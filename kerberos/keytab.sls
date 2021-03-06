{% from "kerberos/map.jinja" import kerberos with context %}

/etc/krb5:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode
    - makedirs: True

{%- for keytab in salt['pillar.get']('kerberos:keytabs') %}
/etc/krb5/{{ keytab }}:
  file.managed:
    - user: root
    - source: salt://kerberos/files/{{ keytab }}
    - group: {{ kerberos.get('root_group', 'root') }}
    - template: jinja
{%- endfor %}