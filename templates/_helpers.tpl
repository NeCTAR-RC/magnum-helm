{{/*
Vault annotations
*/}}
{{- define "magnum.vaultAnnotations" -}}
vault.hashicorp.com/role: "{{ .Values.vault.role }}"
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-pre-populate-only: "true"
vault.hashicorp.com/agent-inject-status: "update"
vault.hashicorp.com/secret-volume-path-secrets.conf: /etc/magnum/magnum.conf.d
vault.hashicorp.com/agent-inject-secret-secrets.conf: "{{ .Values.vault.settings_secret }}"
vault.hashicorp.com/agent-inject-template-secrets.conf: |
  {{ print "{{- with secret \"" .Values.vault.settings_secret "\" -}}" }}
  {{ print "[DEFAULT]" }}
  {{ print "transport_url={{ .Data.data.transport_url }}" }}
  {{ print "[database]" }}
  {{ print "connection={{ .Data.data.database_connection }}" }}
  {{ print "[keystone_authtoken]" }}
  {{ print "password={{ .Data.data.keystone_password }}" }}
  {{ print "[keystone_auth]" }}
  {{ print "password={{ .Data.data.keystone_password }}" }}
  {{ print "[trust]" }}
  {{ print "trustee_domain_admin_password={{ .Data.data.trustee_domain_admin_password }}" }}
  {{ print "{{- end -}}" }}
vault.hashicorp.com/agent-inject-secret-kubeconfig: "{{ .Values.vault.kubeconfig_secret }}"
vault.hashicorp.com/agent-inject-perms-kubeconfig: "0440"
vault.hashicorp.com/agent-inject-template-kubeconfig: |
  {{ print "{{- with secret \"" .Values.vault.kubeconfig_secret "\" -}}" }}
  {{ print "{{ .Data.data.kubeconfig }}" }}
  {{ print "{{- end -}}" }}
{{- if .Values.sentry.enabled }}
vault.hashicorp.com/agent-inject-secret-sentry.env: "{{ .Values.vault.settings_secret }}"
vault.hashicorp.com/agent-inject-template-sentry.env: |
  {{ print "{{- with secret \"" .Values.vault.settings_secret "\" -}}" }}
  {{ print "{{- with .Data.data.sentry_dsn }}SENTRY_DSN={{ . }}{{ end }}" }}
  {{ print "{{- end -}}" }}
{{- end }}
{{- end }}
