#!/bin/bash
#!/bin/bash
#!/bin/bash



check_1() {
check_1() {
check_1() {
  logit ""
  logit ""
  logit ""
  local id="1"
  local id="1"
  local id="1"
  local desc="主机配置"
  local desc="Host Configuration"
  local desc="Host Configuration"
  checkHeader="$id - $desc"
  checkHeader="$id - $desc"
  checkHeader="$id - $desc"
  info "$checkHeader"
  info "$checkHeader"
  info "$checkHeader"
  startsectionjson "$id" "$desc"
  startsectionjson "$id" "$desc"
  startsectionjson "$id" "$desc"
}
}
}



check_1_1() {
check_1_1() {
check_1_1() {
  local id="1.1"
  local id="1.1"
  local id="1.1"
  local desc="Linux主机特定配置"
  local desc="Linux Hosts Specific Configuration"
  local desc="Linux Hosts Specific Configuration"
  local check="$id - $desc"
  local check="$id - $desc"
  local check="$id - $desc"
  info "$check"
  info "$check"
  info "$check"
}
}
}



check_1_1_1() {
check_1_1_1() {
check_1_1_1() {
  local id="1.1.1"
  local id="1.1.1"
  local id="1.1.1"
  local desc="Ensure a separate partition for containers has been created (Automated)"
  local desc="Ensure a separate partition for containers has been created (Automated)"
  local desc="Ensure a separate partition for containers has been created (Automated)"
  local remediation="For new installations, you should create a separate partition for the /var/lib/docker mount point. For systems that have already been installed, you should use the Logical Volume Manager (LVM) within Linux to create a new partition."
  local remediation="For new installations, you should create a separate partition for the /var/lib/docker mount point. For systems that have already been installed, you should use the Logical Volume Manager (LVM) within Linux to create a new partition."
  local remediation="For new installations, you should create a separate partition for the /var/lib/docker mount point. For systems that have already been installed, you should use the Logical Volume Manager (LVM) within Linux to create a new partition."
  local remediationImpact="None."
  local remediationImpact="None."
  local remediationImpact="没有一个"
  local check="$id - $desc"
  local check="$id - $desc"
  local check="$id - $desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"



  docker_root_dir=$(docker info -f '{{ .DockerRootDir }}')
  docker_root_dir=$(docker info -f '{{ .DockerRootDir }}')
  docker_root_dir=$(docker info -f '{{ .DockerRootDir }}')
  if docker info | grep -q userns ; then
  if docker info | grep -q userns ; then
  if docker info | grep -q userns ; then
    docker_root_dir=$(readlink -f "$docker_root_dir/..")
    docker_root_dir=$(readlink -f "$docker_root_dir/..")
    docker_root_dir=$(readlink -f "$docker_root_dir/..")
  fi
  fi
  fi



  if mountpoint -q -- "$docker_root_dir" >/dev/null 2>&1; then
  if mountpoint -q -- "$docker_root_dir" >/dev/null 2>&1; then
  if mountpoint -q -- "$docker_root_dir" >/dev/null 2>&1; then
    pass -s "$check"
    pass -s "$check"
    pass -s "$check"
    logcheckresult "PASS"
    logcheckresult "PASS"
    logcheckresult "PASS"
    return
    return
    return
  fi
  fi
  fi
  warn -s "$check"
  warn -s "$check"
  warn -s "$check"
  logcheckresult "WARN"
  logcheckresult "WARN"
  logcheckresult "WARN"
}
}
}



check_1_1_2() {
check_1_1_2() {
check_1_1_2() {
  local id="1.1.2"
  local id="1.1.2"
  local id="1.1.2"
  local desc="Ensure only trusted users are allowed to control Docker daemon (Automated)"
  local desc="Ensure only trusted users are allowed to control Docker daemon (Automated)"
  local desc="Ensure only trusted users are allowed to control Docker daemon (Automated)"
  local remediation="You should remove any untrusted users from the docker group using command sudo gpasswd -d <your-user> docker or add trusted users to the docker group using command sudo usermod -aG docker <your-user>. You should not create a mapping of sensitive directories from the host to container volumes."
  local remediation="您应该使用命令sudo gpasswd-d＜your user＞docker将任何不受信任的用户从docker组中删除，或者使用命令sudo-usermod-aG docker＜your user＞将受信任用户添加到docker组。不应创建从主机到容器卷的敏感目录映射。"
  local remediation="You should remove any untrusted users from the docker group using command sudo gpasswd -d <your-user> docker or add trusted users to the docker group using command sudo usermod -aG docker <your-user>. You should not create a mapping of sensitive directories from the host to container volumes."
  local remediationImpact="Only trust user are allow to build and execute containers as normal user."
  local remediationImpact="Only trust user are allow to build and execute containers as normal user."
  local remediationImpact="只有信任用户才能像普通用户一样构建和执行容器。"
  local check="$id - $desc"
  local check="$id - $desc"
  local check="$id - $desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"



  docker_users=$(grep 'docker' /etc/group)
  docker_users=$(grep 'docker' /etc/group)
  docker_users=$(grep 'docker' /etc/group)
  if command -v getent >/dev/null 2>&1; then
  if command -v getent >/dev/null 2>&1; then
  if command -v getent >/dev/null 2>&1; then
    docker_users=$(getent group docker)
    docker_users=$(getent group docker)
    docker_users=$(getent group docker)
  fi
  fi
  fi
  docker_users=$(printf "%s" "$docker_users" | awk -F: '{print $4}')
  docker_users=$(printf "%s" "$docker_users" | awk -F: '{print $4}')
  docker_users=$(printf "%s" "$docker_users" | awk -F: '{print $4}')



  local doubtfulusers=""
  local doubtfulusers=""
  local doubtfulusers=""
  if [ -n "$dockertrustusers" ]; then
  if [ -n "$dockertrustusers" ]; then
  if [ -n "$dockertrustusers" ]; then
    for u in $(printf "%s" "$docker_users" | sed "s/,/ /g"); do
    for u in $(printf "%s" "$docker_users" | sed "s/,/ /g"); do
    for u in $(printf "%s" "$docker_users" | sed "s/,/ /g"); do
      if ! printf "%s" "$dockertrustusers" | grep -q "$u" ; then
      if ! printf "%s" "$dockertrustusers" | grep -q "$u" ; then
      if ! printf "%s" "$dockertrustusers" | grep -q "$u" ; then
        doubtfulusers="$u"
        doubtfulusers="$u"
        doubtfulusers="$u"
        if [ -n "${doubtfulusers}" ]; then
        if [ -n "${doubtfulusers}" ]; then
        if [ -n "${doubtfulusers}" ]; then
          doubtfulusers="${doubtfulusers},$u"
          doubtfulusers="${doubtfulusers},$u"
          doubtfulusers="${doubtfulusers},$u"
        fi
        fi
        fi
      fi
      fi
      fi
    done
    done
    done
  else
  else
  else
    info -c "$check"
    info -c "$check"
    info -c "$check"
    info "      * Users: $docker_users"
    info "      * Users: $docker_users"
    info "      * Users: $docker_users"
    logcheckresult "INFO" "doubtfulusers" "$docker_users"
    logcheckresult "INFO" "doubtfulusers" "$docker_users"
    logcheckresult "INFO" "doubtfulusers" "$docker_users"
  fi
  fi
  fi



  if [ -n "${doubtfulusers}" ]; then
  if [ -n "${doubtfulusers}" ]; then
  if [ -n "${doubtfulusers}" ]; then
    warn -s "$check"
    warn -s "$check"
    warn -s "$check"
    warn "      * Doubtful users: $doubtfulusers"
    warn "      * Doubtful users: $doubtfulusers"
    warn "      * Doubtful users: $doubtfulusers"
    logcheckresult "WARN" "doubtfulusers" "$doubtfulusers"
    logcheckresult "WARN" "doubtfulusers" "$doubtfulusers"
    logcheckresult "WARN" "doubtfulusers" "$doubtfulusers"
  fi
  fi
  fi



  if [ -z "${doubtfulusers}" ] && [ -n "${dockertrustusers}" ]; then
  if [ -z "${doubtfulusers}" ] && [ -n "${dockertrustusers}" ]; then
  if [ -z "${doubtfulusers}" ] && [ -n "${dockertrustusers}" ]; then
    pass -s "$check"
    pass -s "$check"
    pass -s "$check"
    logcheckresult "PASS"
    logcheckresult "PASS"
    logcheckresult "PASS"
  fi
  fi
  fi
}
}
}



check_1_1_3() {
check_1_1_3() {
check_1_1_3() {
  local id="1.1.3"
  local id="1.1.3"
  local id="1.1.3"
  local desc="Ensure auditing is configured for the Docker daemon (Automated)"
  local desc="Ensure auditing is configured for the Docker daemon (Automated)"
  local desc="Ensure auditing is configured for the Docker daemon (Automated)"
  local remediation="Install auditd. Add -w /usr/bin/dockerd -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediation="安装审核的。将-w/usr/bin/dokerd-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediation="Install auditd. Add -w /usr/bin/dockerd -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  local check="$id - $desc"
  local check="$id - $desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"



  file="/usr/bin/dockerd"
  file="/usr/bin/dockerd"
  file="/usr/bin/dockerd"
  if command -v auditctl >/dev/null 2>&1; then
  if command -v auditctl >/dev/null 2>&1; then
  if command -v auditctl >/dev/null 2>&1; then
    if auditctl -l | grep "$file" >/dev/null 2>&1; then
    if auditctl -l | grep "$file" >/dev/null 2>&1; then
    if auditctl -l | grep "$file" >/dev/null 2>&1; then
      pass -s "$check"
      pass -s "$check"
      pass -s "$check"
      logcheckresult "PASS"
      logcheckresult "PASS"
      logcheckresult "PASS"
      return
      return
      return
    fi
    fi
    fi
    warn -s "$check"
    warn -s "$check"
    warn -s "$check"
    logcheckresult "WARN"
    logcheckresult "WARN"
    logcheckresult "WARN"
    return
    return
    return
  fi
  fi
  fi
  if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
  if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
  if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
    pass -s "$check"
    pass -s "$check"
    pass -s "$check"
    logcheckresult "PASS"
    logcheckresult "PASS"
    logcheckresult "PASS"
    return
    return
    return
  fi
  fi
  fi
  warn -s "$check"
  warn -s "$check"
  warn -s "$check"
  logcheckresult "WARN"
  logcheckresult "WARN"
  logcheckresult "WARN"
}
}
}



check_1_1_4() {
check_1_1_4() {
check_1_1_4() {
  local id="1.1.4"
  local id="1.1.4"
  local id="1.1.4"
  local desc="Ensure auditing is configured for Docker files and directories -/run/containerd (Automated)"
  local desc="Ensure auditing is configured for Docker files and directories -/run/containerd (Automated)"
  local desc="Ensure auditing is configured for Docker files and directories -/run/containerd (Automated)"
  local remediation="Install auditd. Add -a exit,always -F path=/run/containerd -F perm=war -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediation="安装审核的。在/etc/audit/rules.d/audit.rules文件中添加-a出口，始终-F path=/run/containerd-F perm=war-k docker。然后使用命令service audited restart重新启动审核守护进程。"
  local remediation="Install auditd. Add -a exit,always -F path=/run/containerd -F perm=war -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  local check="$id - $desc"
  local check="$id - $desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"



  file="/run/containerd"
  file="/run/containerd"
  file="/run/containerd"
  if command -v auditctl >/dev/null 2>&1; then
  if command -v auditctl >/dev/null 2>&1; then
  if command -v auditctl >/dev/null 2>&1; then
    if auditctl -l | grep "$file" >/dev/null 2>&1; then
    if auditctl -l | grep "$file" >/dev/null 2>&1; then
    if auditctl -l | grep "$file" >/dev/null 2>&1; then
      pass -s "$check"
      pass -s "$check"
      pass -s "$check"
      logcheckresult "PASS"
      logcheckresult "PASS"
      logcheckresult "PASS"
      return
      return
      return
    fi
    fi
    fi
    warn -s "$check"
    warn -s "$check"
    warn -s "$check"
    logcheckresult "WARN"
    logcheckresult "WARN"
    logcheckresult "WARN"
    return
    return
    return
  fi
  fi
  fi
  if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
  if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
  if grep -s "$file" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
    pass -s "$check"
    pass -s "$check"
    pass -s "$check"
    logcheckresult "PASS"
    logcheckresult "PASS"
    logcheckresult "PASS"
    return
    return
    return
  fi
  fi
  fi
  warn -s "$check"
  warn -s "$check"
  warn -s "$check"
  logcheckresult "WARN"
  logcheckresult "WARN"
  logcheckresult "WARN"
}
}
}



check_1_1_5() {
check_1_1_5() {
check_1_1_5() {
  local id="1.1.5"
  local id="1.1.5"
  local id="1.1.5"
  local desc="Ensure auditing is configured for Docker files and directories - /var/lib/docker (Automated)"
  local desc="Ensure auditing is configured for Docker files and directories - /var/lib/docker (Automated)"
  local desc="Ensure auditing is configured for Docker files and directories - /var/lib/docker (Automated)"
  local remediation="Install auditd. Add -w /var/lib/docker -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediation="安装审核的。将-w/var/lib/docker-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediation="Install auditd. Add -w /var/lib/docker -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  local check="$id - $desc"
  local check="$id - $desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"



  directory="/var/lib/docker"
  directory="/var/lib/docker"
  directory="/var/lib/docker"
  if [ -d "$directory" ]; then
  if [ -d "$directory" ]; then
  if [ -d "$directory" ]; then
    if command -v auditctl >/dev/null 2>&1; then
    if command -v auditctl >/dev/null 2>&1; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $directory >/dev/null 2>&1; then
      if auditctl -l | grep $directory >/dev/null 2>&1; then
      if auditctl -l | grep $directory >/dev/null 2>&1; then
        pass -s "$check"
        pass -s "$check"
        pass -s "$check"
        logcheckresult "PASS"
        logcheckresult "PASS"
        logcheckresult "PASS"
        return
        return
        return
      fi
      fi
      fi
      warn -s "$check"
      warn -s "$check"
      warn -s "$check"
      logcheckresult "WARN"
      logcheckresult "WARN"
      logcheckresult "WARN"
      return
      return
      return
    fi
    fi
    fi
    if grep -s "$directory" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
    if grep -s "$directory" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
    if grep -s "$directory" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      pass -s "$check"
      pass -s "$check"
      logcheckresult "PASS"
      logcheckresult "PASS"
      logcheckresult "PASS"
      return
      return
      return
    fi
    fi
    fi
    warn -s "$check"
    warn -s "$check"
    warn -s "$check"
    logcheckresult "WARN"
    logcheckresult "WARN"
    logcheckresult "WARN"
    return
    return
    return
  fi
  fi
  fi
  info -c "$check"
  info -c "$check"
  info -c "$check"
  info "       * Directory not found"
  info "       * Directory not found"
  info "       * Directory not found"
  logcheckresult "INFO" "Directory not found"
  logcheckresult "INFO" "Directory not found"
  logcheckresult "INFO" "Directory not found"
}
}
}



check_1_1_6() {
check_1_1_6() {
check_1_1_6() {
  local id="1.1.6"
  local id="1.1.6"
  local id="1.1.6"
  local desc="Ensure auditing is configured for Docker files and directories - /etc/docker (Automated)"
  local desc="Ensure auditing is configured for Docker files and directories - /etc/docker (Automated)"
  local desc="Ensure auditing is configured for Docker files and directories - /etc/docker (Automated)"
  local remediation="Install auditd. Add -w /etc/docker -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediation="安装审核的。将-w/etc/docker-k docker添加到/etc/audit/rules.d/audit.rules文件中。然后使用命令service audited restart重新启动审核守护进程。"
  local remediation="Install auditd. Add -w /etc/docker -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  local check="$id - $desc"
  local check="$id - $desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"



  directory="/etc/docker"
  directory="/etc/docker"
  directory="/etc/docker"
  if [ -d "$directory" ]; then
  if [ -d "$directory" ]; then
  if [ -d "$directory" ]; then
    if command -v auditctl >/dev/null 2>&1; then
    if command -v auditctl >/dev/null 2>&1; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep $directory >/dev/null 2>&1; then
      if auditctl -l | grep $directory >/dev/null 2>&1; then
      if auditctl -l | grep $directory >/dev/null 2>&1; then
        pass -s "$check"
        pass -s "$check"
        pass -s "$check"
        logcheckresult "PASS"
        logcheckresult "PASS"
        logcheckresult "PASS"
        return
        return
        return
      fi
      fi
      fi
      warn -s "$check"
      warn -s "$check"
      warn -s "$check"
      logcheckresult "WARN"
      logcheckresult "WARN"
      logcheckresult "WARN"
      return
      return
      return
    fi
    fi
    fi
    if grep -s "$directory" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
    if grep -s "$directory" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
    if grep -s "$directory" "$auditrules" | grep "^[^#;]" 2>/dev/null 1>&2; then
      pass -s "$check"
      pass -s "$check"
      pass -s "$check"
      logcheckresult "PASS"
      logcheckresult "PASS"
      logcheckresult "PASS"
      return
      return
      return
    fi
    fi
    fi
    warn -s "$check"
    warn -s "$check"
    warn -s "$check"
    logcheckresult "WARN"
    logcheckresult "WARN"
    logcheckresult "WARN"
    return
    return
    return
  fi
  fi
  fi
  info -c "$check"
  info -c "$check"
  info -c "$check"
  info "       * Directory not found"
  info "       * Directory not found"
  info "       * Directory not found"
  logcheckresult "INFO" "Directory not found"
  logcheckresult "INFO" "Directory not found"
  logcheckresult "INFO" "Directory not found"
}
}
}



check_1_1_7() {
check_1_1_7() {
check_1_1_7() {
  local id="1.1.7"
  local id="1.1.7"
  local id="1.1.7"
  local desc="Ensure auditing is configured for Docker files and directories - docker.service (Automated)"
  local desc="Ensure auditing is configured for Docker files and directories - docker.service (Automated)"
  local desc="Ensure auditing is configured for Docker files and directories - docker.service (Automated)"
  local remediation="Install auditd. Add -w $(get_service_file docker.service) -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediation="Install auditd. Add -w $(get_service_file docker.service) -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediation="Install auditd. Add -w $(get_service_file docker.service) -k docker to the /etc/audit/rules.d/audit.rules file. Then restart the audit daemon using command service auditd restart."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="Audit can generate large log files. So you need to make sure that they are rotated and archived periodically. Create a separate partition for audit logs to avoid filling up other critical partitions."
  local remediationImpact="审核可以生成大型日志文件。因此，您需要确保它们被定期轮换和归档。为审核日志创建一个单独的分区，以避免填满其他关键分区。"
  local check="$id - $desc"
  local check="$id - $desc"
  local check="$id - $desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"
  starttestjson "$id" "$desc"



  file="$(get_service_file docker.service)"
  file="$(get_service_file docker.service)"
  file="$(get_service_file docker.service)"
  if [ -f "$file" ]; then
  if [ -f "$file" ]; then
  if [ -f "$file" ]; then
    if command -v auditctl >/dev/null 2>&1; then
    if command -v auditctl >/dev/null 2>&1; then
    if command -v auditctl >/dev/null 2>&1; then
      if auditctl -l | grep "$file" >/dev/null 2>&1; then
      if auditctl -l | grep "$file" >/dev/null 2>&1; then
      if auditctl -l | grep "$file" >/dev/null 2>&1; then
        pass -s "$check"
        pass -s "$check"
        pass -s "$check"
        logcheckresult "PASS"
        logcheckresult "PASS"
        logcheckresult "PASS"
        return
        return
        return
      fi
