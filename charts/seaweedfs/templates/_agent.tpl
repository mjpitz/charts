{{/* All agent specific versions of _helpers */}}

{{- define "agent.fullname" -}}
{{- printf "%s-%s" (include "seaweedfs.fullname" .) "agent" -}}
{{- end -}}

{{- define "agent.labels" -}}
{{ include "seaweedfs.labels" . }}
app.kubernetes.io/component: agent
{{- end -}}

{{- define "agent.selectorLabels" -}}
{{ include "seaweedfs.selectorLabels" . }}
app.kubernetes.io/component: agent
{{- end -}}

{{- define "agent.serviceAccountName" -}}
{{- if .Values.agent.serviceAccount.create -}}
    {{ default (include "agent.fullname" .) .Values.agent.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.agent.serviceAccount.name }}
{{- end -}}
{{- end -}}
