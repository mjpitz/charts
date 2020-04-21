{{/* All filer specific versions of _helpers */}}

{{- define "filer.fullname" -}}
{{- printf "%s-%s" (include "seaweedfs.fullname" .) "filer" -}}
{{- end -}}

{{- define "filer.labels" -}}
{{ include "seaweedfs.labels" . }}
app.kubernetes.io/component: filer
{{- end -}}

{{- define "filer.selectorLabels" -}}
{{ include "seaweedfs.selectorLabels" . }}
app.kubernetes.io/component: filer
{{- end -}}

{{- define "filer.serviceAccountName" -}}
{{- if .Values.filer.serviceAccount.create -}}
    {{ default (include "filer.fullname" .) .Values.filer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.filer.serviceAccount.name }}
{{- end -}}
{{- end -}}
