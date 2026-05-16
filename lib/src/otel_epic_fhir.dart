// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_epic_fhir_suppression.dart';

class EpicFhirResult {
  const EpicFhirResult({
    this.environment,
    this.tenant,
    this.fhirVersion,
    this.interaction,
    this.resourceType,
    this.resourceId,
    this.bundleType,
    this.entryCount,
    this.totalCount,
    this.searchMode,
    this.includeCount,
    this.revIncludeCount,
    this.pages,
    this.bulkExportType,
    this.bulkJobStatus,
    this.bulkOutputFiles,
    this.bulkOutputBytes,
    this.smartScope,
    this.smartLaunch,
    this.usCoreProfile,
    this.operationName,
    this.statusCode,
    this.errorCode,
    this.outcomeSeverity,
    this.errorMessage,
  });

  final String? environment;
  final String? tenant;
  final String? fhirVersion;
  final String? interaction;
  final String? resourceType;
  final String? resourceId;
  final String? bundleType;
  final int? entryCount;
  final int? totalCount;
  final String? searchMode;
  final int? includeCount;
  final int? revIncludeCount;
  final int? pages;
  final String? bulkExportType;
  final String? bulkJobStatus;
  final int? bulkOutputFiles;
  final int? bulkOutputBytes;
  final String? smartScope;
  final String? smartLaunch;
  final String? usCoreProfile;
  final String? operationName;
  final int? statusCode;
  final String? errorCode;
  final String? outcomeSeverity;
  final String? errorMessage;
}

class EpicFhirCallResult<T> {
  const EpicFhirCallResult({required this.value, this.result});
  final T value;
  final EpicFhirResult? result;
}

Future<T> tracedEpicFhir<T>({
  required String operation,
  required Future<EpicFhirCallResult<T>> Function() invoke,
  Tracer? tracer,
}) async {
  if (epicFhirInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTel.tracerProvider().getTracer('otel_epic_fhir');
  final span = t.startSpan('epic_fhir $operation', kind: SpanKind.client);
  try {
    span.setStringAttribute('rpc.system', 'fhir');
    span.setStringAttribute('rpc.service', 'EpicFHIR');
    span.setStringAttribute('rpc.method', operation);
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.environment != null) {
        span.setStringAttribute('epic_fhir.environment', res.environment!);
      }
      if (res.tenant != null) {
        span.setStringAttribute('epic_fhir.tenant', res.tenant!);
      }
      if (res.fhirVersion != null) {
        span.setStringAttribute('fhir.version', res.fhirVersion!);
      }
      if (res.interaction != null) {
        span.setStringAttribute('fhir.interaction', res.interaction!);
      }
      if (res.resourceType != null) {
        span.setStringAttribute('fhir.resource.type', res.resourceType!);
      }
      if (res.resourceId != null) {
        span.setStringAttribute('fhir.resource.id', res.resourceId!);
      }
      if (res.bundleType != null) {
        span.setStringAttribute('fhir.bundle.type', res.bundleType!);
      }
      if (res.entryCount != null) {
        span.setIntAttribute('fhir.bundle.entry_count', res.entryCount!);
      }
      if (res.totalCount != null) {
        span.setIntAttribute('fhir.bundle.total', res.totalCount!);
      }
      if (res.searchMode != null) {
        span.setStringAttribute('fhir.search.mode', res.searchMode!);
      }
      if (res.includeCount != null) {
        span.setIntAttribute('fhir.search.include_count', res.includeCount!);
      }
      if (res.revIncludeCount != null) {
        span.setIntAttribute(
            'fhir.search.rev_include_count', res.revIncludeCount!);
      }
      if (res.pages != null) {
        span.setIntAttribute('fhir.search.pages', res.pages!);
      }
      if (res.bulkExportType != null) {
        span.setStringAttribute('fhir.bulk.export_type', res.bulkExportType!);
      }
      if (res.bulkJobStatus != null) {
        span.setStringAttribute('fhir.bulk.job_status', res.bulkJobStatus!);
      }
      if (res.bulkOutputFiles != null) {
        span.setIntAttribute('fhir.bulk.output_files', res.bulkOutputFiles!);
      }
      if (res.bulkOutputBytes != null) {
        span.setIntAttribute('fhir.bulk.output_bytes', res.bulkOutputBytes!);
      }
      if (res.smartScope != null) {
        span.setStringAttribute('smart.scope', res.smartScope!);
      }
      if (res.smartLaunch != null) {
        span.setStringAttribute('smart.launch', res.smartLaunch!);
      }
      if (res.usCoreProfile != null) {
        span.setStringAttribute('fhir.us_core.profile', res.usCoreProfile!);
      }
      if (res.operationName != null) {
        span.setStringAttribute('fhir.operation.name', res.operationName!);
      }
      if (res.statusCode != null) {
        span.setIntAttribute('http.response.status_code', res.statusCode!);
      }
      if (res.errorCode != null) {
        span.setStringAttribute('epic_fhir.error.code', res.errorCode!);
      }
      if (res.outcomeSeverity != null) {
        span.setStringAttribute('fhir.outcome.severity', res.outcomeSeverity!);
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400) ||
          res.outcomeSeverity == 'error' ||
          res.outcomeSeverity == 'fatal' ||
          res.bulkJobStatus == 'failed';
      if (fail) {
        span.setStringAttribute(
            ErrorResource.errorType.key, res.errorCode ?? 'epic_fhir.error');
        span.setStatus(SpanStatusCode.Error, res.errorMessage);
      }
    }
    return r.value;
  } catch (e, st) {
    span.recordException(e, stackTrace: st);
    span.setStatus(SpanStatusCode.Error, e.toString());
    rethrow;
  } finally {
    span.end();
  }
}
