{{- define "magnum-conf" }}
[DEFAULT]
debug = {{ .Values.conf.debug }}

[trust]
cluster_user_trust=True
trustee_domain_name={{ .Values.conf.trust.trustee_domain_name }}
trustee_domain_admin_name={{ .Values.conf.trust.trustee_domain_admin_name }}
roles=member
trustee_keystone_interface=public

[quotas]
max_clusters_per_project={{ .Values.conf.quotas.max_clusters_per_project }}

[api]
port={{ .Values.api.port }}
host=0.0.0.0
max_limit=1000
enabled_ssl=False
workers=4

[conductor]
workers=4

[oslo_policy]
enforce_scope=True
enforce_new_defaults=True
policy_file=/etc/magnum/policy.yaml

[database]
connection_recycle_time=600

[oslo_messaging_rabbit]
ssl=True
rabbit_quorum_queue=true
rabbit_transient_quorum_queue=true
rabbit_stream_fanout=true
rabbit_qos_prefetch_count=1

[keystone_authtoken]
auth_url={{ .Values.conf.keystone.auth_url }}
www_authenticate_uri={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}
service_type=container-infra
service_token_roles_required=True

[keystone_auth]
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
auth_url={{ .Values.conf.keystone.auth_url }}

[oslo_middleware]
enable_proxy_headers_parsing=True

[certificates]
cert_manager_type=x509keypair

[x509]
term_of_validity=3650

[cinder]
default_docker_volume_type=standard
default_etcd_volume_type=standard
default_boot_volume_type=standard

[barbican_client]
region_name={{ .Values.conf.keystone.region_name }}

[glance_client]
region_name={{ .Values.conf.keystone.region_name }}

[heat_client]
region_name={{ .Values.conf.keystone.region_name }}

[magnum_client]
region_name={{ .Values.conf.keystone.region_name }}

[neutron_client]
region_name={{ .Values.conf.keystone.region_name }}

[nova_client]
region_name={{ .Values.conf.keystone.region_name }}

[octavia_client]
region_name={{ .Values.conf.keystone.region_name }}

[cinder_client]
region_name={{ .Values.conf.keystone.region_name }}

[capi_helm]
kubeconfig_file=/vault/secrets/kubeconfig
helm_chart_repo=
helm_chart_name=oci://registry.rc.nectar.org.au/nectarmagnum/openstack-cluster
csi_cinder_default_volume_type=standard
csi_cinder_reclaim_policy=Delete


{{- end }}
