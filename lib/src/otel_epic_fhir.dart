// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_epic_fhir_suppression.dart';

class EpicFhirResult {
  /// Creates a result.
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

/// What a traced call returned: the value for the caller plus fields
/// recorded on the span.
class EpicFhirCallResult<T> {
  /// Creates a call result.
  const EpicFhirCallResult({required this.value, this.result});

  /// The value returned to the caller.
  final T value;
  final EpicFhirResult? result;
}

Future<T> tracedEpicFhir<T>({
  required String operation,
  required Future<EpicFhirCallResult<T>> Function() invoke,
  APITracer? tracer,
}) async {
  if (epicFhirInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTelAPI.tracerProvider().getTracer('otel_epic_fhir');
  final span = t.startSpan('epic_fhir $operation', kind: SpanKind.client);
  try {
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.system', 'fhir')]));
    span.addAttributes(OTelAPI.attributes(
        [OTelAPI.attributeString('rpc.service', 'EpicFHIR')]));
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.environment != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('epic_fhir.environment', res.environment!)
        ]));
      }
      if (res.tenant != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('epic_fhir.tenant', res.tenant!)]));
      }
      if (res.fhirVersion != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('fhir.version', res.fhirVersion!)]));
      }
      if (res.interaction != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('fhir.interaction', res.interaction!)]));
      }
      if (res.resourceType != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('fhir.resource.type', res.resourceType!)
        ]));
      }
      if (res.resourceId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('fhir.resource.id', res.resourceId!)]));
      }
      if (res.bundleType != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('fhir.bundle.type', res.bundleType!)]));
      }
      if (res.entryCount != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('fhir.bundle.entry_count', res.entryCount!)
        ]));
      }
      if (res.totalCount != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeInt('fhir.bundle.total', res.totalCount!)]));
      }
      if (res.searchMode != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('fhir.search.mode', res.searchMode!)]));
      }
      if (res.includeCount != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('fhir.search.include_count', res.includeCount!)
        ]));
      }
      if (res.revIncludeCount != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt(
              'fhir.search.rev_include_count', res.revIncludeCount!)
        ]));
      }
      if (res.pages != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeInt('fhir.search.pages', res.pages!)]));
      }
      if (res.bulkExportType != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('fhir.bulk.export_type', res.bulkExportType!)
        ]));
      }
      if (res.bulkJobStatus != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('fhir.bulk.job_status', res.bulkJobStatus!)
        ]));
      }
      if (res.bulkOutputFiles != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('fhir.bulk.output_files', res.bulkOutputFiles!)
        ]));
      }
      if (res.bulkOutputBytes != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('fhir.bulk.output_bytes', res.bulkOutputBytes!)
        ]));
      }
      if (res.smartScope != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('smart.scope', res.smartScope!)]));
      }
      if (res.smartLaunch != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('smart.launch', res.smartLaunch!)]));
      }
      if (res.usCoreProfile != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('fhir.us_core.profile', res.usCoreProfile!)
        ]));
      }
      if (res.operationName != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('fhir.operation.name', res.operationName!)
        ]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('http.response.status_code', res.statusCode!)
        ]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('epic_fhir.error.code', res.errorCode!)]));
      }
      if (res.outcomeSeverity != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('fhir.outcome.severity', res.outcomeSeverity!)
        ]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400) ||
          res.outcomeSeverity == 'error' ||
          res.outcomeSeverity == 'fatal' ||
          res.bulkJobStatus == 'failed';
      if (fail) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              ErrorAttributes.errorType.key, res.errorCode ?? 'epic_fhir.error')
        ]));
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
