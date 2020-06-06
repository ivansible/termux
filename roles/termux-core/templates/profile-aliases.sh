#!{{ termux_root_dir }}/usr/bin/sh
echo $PATH |grep -q /system/bin || export PATH=$PATH:/system/bin
{% for alias in termux_bash_aliases |dictsort %}
alias {{ alias.0 }}='{{ alias.1 }}'
{% endfor %}
