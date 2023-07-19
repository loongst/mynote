#!/bin/bash

check_1() {
  logit ""
  local id="1"
  local desc="主机配置"
  checkHeader="$id - $desc"
  info "$checkHeader"
  startsectionjson "$id" "$desc"
}

check_1_1() {
  local id="1.1"
  local desc="Linux主机特定配置"
  local check="$id - $desc"
  info "$check"
}

check_1_1_1() {
  local id="1.1.1"
  local desc="Ensure a separate partition for containers has been created (Automated)"
  local remediation="For new installations, you should create a separate partition for the /var/lib/docker mount point. For systems that have already been installed, you should use the Logical Volume Manager (LVM) within Linux to create a new partition."
  local remediationImpact="没有一个"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  docker_root_dir=$(docker info -f '{{ .DockerRootDir }}')
  if docker info | grep -q userns ; then
    docker_root_dir=$(readlink -f "$docker_root_dir/..")
  fi

  if mountpoint -q -- "$docker_root_dir" >/dev/null 2>&1; then
    pass -s "$check"
    logcheckresult "PASS"
    return
  fi
  warn -s "$check"
  logcheckresult "WARN"
}

check_1_1_2() {
  local id="1.1.2"
  local desc="Ensure only trusted users are allowed to control Docker daemon (Automated)"
  local remediation="您应该使用命令sudo gpasswd-d＜your user＞docker将任何不受信任的用户从docker组中删除，或者使用命令sudo-usermod-aG docker＜your user＞将受信任用户添加到docker组。不应创建从主机到容器卷的敏感目录映射。"
  local remediationImpact="只有信任用户才能像普通用户一样构建和执行容器。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  docker_users=$(grep 'docker' /etc/group)
  if command -v getent >/dev/null 2>&1; then
    docker_users=$(getent group docker)
  fi
  docker_users=$(printf "%s" "$docker_users" | awk -F: '{print $4}')

  local doubtfulusers=""
  if [ -n "$dockertrustusers" ]; then
    for u in $(printf "%s" "$docker_users" | sed "s/,/ /g"); do
      if ! printf "%s" "$dockertrustusers" | grep -q "$u" ; then
        doubtfulusers="$u"
        if [ -n "${doubtfulusers}" ]; then
          doubtfulusers="${doubtfulusers},$u"
        fi
      fi
    done
  else
    info -c "$check"
    info "      * Users: $docker_users"
    logcheckresult "INFO" "doubtfulusers" "$docker_users"
  fi

  if [ -n "${doubtfulusers}" ]; then
    warn -s "$check"
    warn "      * Doubtful users: $doubtfulusers"
    logcheckresult "WARN" "doubtfulusers" "$doubtfulusers"
  fi

  if [ -z "${doubtfulusers}" ] && [ -n "${dockertrustusers}" ]; then
    pass -s "$check"
    logcheckresult "PASS"
  fi
}

check_1_1_3() {
  local id="1.1.3"
  local desc="Ensure auditing is configured for the Docker daemon (Automated)"
  local remediation="安装审核的。将-w/usr/bin/dokerd-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/usr/bin/dockerd"
  if command -v auditctl >/dev/null 2>&1; then
    if auditctl -l | grep "$file" >/dev/null 2>&1; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
    pass -s "$check"
    logcheckresult "PASS"
    return
  fi
  warn -s "$check"
  logcheckresult "WARN"
}

check_1_1_4() {
  local id="1.1.4"
  local desc="Ensure auditing is configured for Docker files and directories -/run/containerd (Automated)"
  local remediation="安装审核的。在/etc/audit/rules.d/audit.rules文件中添加-a出口，始终-F path=/run/containerd-F perm=war-k docker。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/run/containerd"
  if command -v auditctl >/dev/null 2>&1; then
    if auditctl -l | grep "$file" >/dev/null 2>&1; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
    pass -s "$check"
    logcheckresult "PASS"
    return
  fi
  warn -s "$check"
  logcheckresult "WARN"
}

check_1_1_5() {
  local id="1.1.5"
  local desc="Ensure auditing is configured for Docker files and directories - /var/lib/docker (Automated)"
  local remediation="安装审核的。将-w/var/lib/docker-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  directory="/var/lib/docker"
  if [ -d "$directory" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $directory >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$directory" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * Directory not found"
  logcheckresult "INFO" "Directory not found"
}

check_1_1_6() {
  local id="1.1.6"
  local desc="Ensure auditing is configured for Docker files and directories - /etc/docker (Automated)"
  local remediation="安装审核的。将-w/etc/docker-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  directory="/etc/docker"
  if [ -d "$directory" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $directory >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$directory" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * Directory not found"
  logcheckresult "INFO" "Directory not found"
}

check_1_1_7() {
  local id="1.1.7"
  local desc="Ensure auditing is configured for Docker files and directories - docker.service (Automated)"
  local remediation="Install auditd. Add -w $(get_service_file docker.service) -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="$(get_service_file docker.service)"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep "$file" >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_8() {
  local id="1.1.8"
  local desc="Ensure auditing is configured for Docker files and directories - containerd.sock (Automated)"
  local remediation="Install auditd. Add -w $(get_service_file containerd.socket) -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="$(get_service_file containerd.socket)"
  if [ -e "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep "$file" >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * File not found"
  logcheckresult "INFO" "File not found"
}
check_1_1_9() {
  local id="1.1.9"
  local desc="Ensure auditing is configured for Docker files and directories - docker.socket (Automated)"
  local remediation="Install auditd. Add -w $(get_service_file docker.socket) -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="$(get_service_file docker.socket)"
  if [ -e "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep "$file" >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_10() {
  local id="1.1.10"
  local desc="Ensure auditing is configured for Docker files and directories - /etc/default/docker (Automated)"
  local remediation="安装审核的。将-w/default/docker-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/etc/default/docker"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_11() {
  local id="1.1.11"
  local desc="Ensure auditing is configured for Dockerfiles and directories - /etc/docker/daemon.json (Automated)"
  local remediation="安装审核的。将-w/etc/docker/daemon.json-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/etc/docker/daemon.json"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_12() {
  local id="1.1.12"
  local desc="1.1.12 Ensure auditing is configured for Dockerfiles and directories - /etc/containerd/config.toml (Automated)"
  local remediation="安装审核的。将-w/etc/containerd/config.toml-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/etc/containerd/config.toml"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_13() {
  local id="1.1.13"
  local desc="Ensure auditing is configured for Docker files and directories - /etc/sysconfig/docker (Automated)"
  local remediation="安装审核的。将-w/sysconfig/docker-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/etc/sysconfig/docker"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "       * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_14() {
  local id="1.1.14"
  local desc="Ensure auditing is configured for Docker files and directories - /usr/bin/containerd (Automated)"
  local remediation="安装审核的。将-w/usr/bin/containerd-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/usr/bin/containerd"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "        * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_15() {
  local id="1.1.15"
  local desc="Ensure auditing is configured for Docker files and directories - /usr/bin/containerd-shim (Automated)"
  local remediation="安装审核的。将-w/usr/bin/containerd shim-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/usr/bin/containerd-shim"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "        * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_16() {
  local id="1.1.16"
  local desc="Ensure auditing is configured for Docker files and directories - /usr/bin/containerd-shim-runc-v1 (Automated)"
  local remediation="安装审核的。将-w/usr/bin/container-shim-runc-v1-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/usr/bin/containerd-shim-runc-v1"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "        * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_17() {
  local id="1.1.17"
  local desc="Ensure auditing is configured for Docker files and directories - /usr/bin/containerd-shim-runc-v2 (Automated)"
  local remediation="安装审核的。将-w/usr/bin/container-shim-runc-v2-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/usr/bin/containerd-shim-runc-v2"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "        * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_1_18() {
  local id="1.1.18"
  local desc="Ensure auditing is configured for Docker files and directories - /usr/bin/runc (Automated)"
  local remediation="安装审核的。将-w/usr/bin/runc-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  file="/usr/bin/runc"
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $file >/dev/null 2>&1; then
        pass -s "$check"
        logcheckresult "PASS"
        return
      fi
      warn -s "$check"
      logcheckresult "WARN"
      return
    fi
    if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      logcheckresult "PASS"
      return
    fi
    warn -s "$check"
    logcheckresult "WARN"
    return
  fi
  info -c "$check"
  info "        * File not found"
  logcheckresult "INFO" "File not found"
}

check_1_2() {
  local id="1.2"
  local desc="一般配置"
  local check="$id - $desc"
  info "$check"
}

check_1_2_1() {
  local id="1.2.1"
  local desc="Ensure the container host has been Hardened (Manual)"
  local remediation="您可以为您的容器主机考虑各种安全基准。"
  local remediationImpact="没有一个"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  note -c "$check"
  logcheckresult "INFO"
}

check_1_2_2() {
  local id="1.2.2"
  local desc="Ensure that the version of Docker is up to date (Manual)"
  local remediation="您应该监控Docker版本，并确保您的软件根据需要进行了更新。"
  local remediationImpact="您应该对Docker版本更新进行风险评估，并审查它们可能对您的运营产生的影响。"
  local check="$id - $desc"
  starttestjson "$id" "$desc"

  docker_version=$(docker version | grep -i -A2 '^server' | grep ' Version:' \
    | awk '{print $NF; exit}' | tr -d '[:alpha:]-,')
  docker_current_version="$(date +%y.%m.0 -d @$(( $(date +%s) - 2592000)))"
  do_version_check "$docker_current_version" "$docker_version"
  if [ $? -eq 11 ]; then
    pass -c "$check"
    info "       * Using $docker_version, verify is it up to date as deemed necessary"
    logcheckresult "INFO" "Using $docker_version"
    return
  fi
  pass -c "$check"
  info "       * Using $docker_version which is current"
  info "       * Check with your operating system vendor for support and security maintenance for Docker"
  logcheckresult "PASS" "Using $docker_version"
}

check_1_end() {
  endsectionjson
}
