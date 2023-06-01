{{/*
Return a default application name.
*/}}
{{- define "vaultwarden.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 20 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 20 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 20 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "dbPort" -}}
{{- if .Values.database.port }}
{{- printf "%s%s" ":" .Values.database.port }}
{{- else }}
{{- printf "%s" "" }}
{{- end }}
{{- end }}

{{/*
Return the database string
*/}}
{{ define "dbString" }}
{{- $var := print .Values.database.type "://${dbUsername}:${dbPassword}@" .Values.database.host (include "dbPort" . ) "/${dbName}" }}
{{- printf "%s" $var }}
{{- end -}}

{{/*
DB credentials secret name
*/}}
{{ define "dbSecretName" }}
{{- printf "%s%s" ( include "vaultwarden.fullname" . ) "dbSecretName" }}
{{- end -}}