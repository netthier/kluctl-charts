{{/*
Expand the name of the chart.
*/}}
{{- define "flux-kluctl-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "flux-kluctl-controller.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "flux-kluctl-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "flux-kluctl-controller.labels" -}}
helm.sh/chart: {{ include "flux-kluctl-controller.chart" . }}
{{ include "flux-kluctl-controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
control-plane: controller
{{- end }}

{{/*
Selector labels
*/}}
{{- define "flux-kluctl-controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "flux-kluctl-controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use for the controller
*/}}
{{- define "flux-kluctl-controller.serviceAccountNameController" -}}
{{- if .Values.serviceAccount.controller.create }}
{{- default (include "flux-kluctl-controller.fullname" .) .Values.serviceAccount.controller.prefix }}-controller
{{- else }}
{{- default "default" .Values.serviceAccount.controller.prefix }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use for the reconciler
*/}}
{{- define "flux-kluctl-controller.serviceAccountNameReconciler" -}}
{{- if .Values.serviceAccount.reconciler.create }}
{{- default (include "flux-kluctl-controller.fullname" .) .Values.serviceAccount.reconciler.prefix }}-reconciler
{{- else }}
{{- default "default" .Values.serviceAccount.reconciler.prefix }}-reconciler
{{- end }}
{{- end }}
