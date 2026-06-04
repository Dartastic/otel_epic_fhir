// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';

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
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.system', 'fhir')]));
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.service', 'EpicFHIR')]));
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.environment != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('epic_fhir.environment', res.environment!)]));
      }
      if (res.tenant != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('epic_fhir.tenant', res.tenant!)]));
      }
      if (res.fhirVersion != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('fhir.version', res.fhirVersion!)]));
      }
      if (res.interaction != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('fhir.interaction', res.interaction!)]));
      }
      if (res.resourceType != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('fhir.resource.type', res.resourceType!)]));
      }
      if (res.resourceId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('fhir.resource.id', res.resourceId!)]));
      }
      if (res.bundleType != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('fhir.bundle.type', res.bundleType!)]));
      }
      if (res.entryCount != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('fhir.bundle.entry_count', res.entryCount!)]));
      }
      if (res.totalCount != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('fhir.bundle.total', res.totalCount!)]));
      }
      if (res.searchMode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('fhir.search.mode', res.searchMode!)]));
      }
      if (res.includeCount != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('fhir.search.include_count', res.includeCount!)
        ]));
      }
      if (res.revIncludeCount != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt(
              'fhir.search.rev_include_count', res.revIncludeCount!)
        ]));
      }
      if (res.pages != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('fhir.search.pages', res.pages!)]));
      }
      if (res.bulkExportType != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('fhir.bulk.export_type', res.bulkExportType!)
        ]));
      }
      if (res.bulkJobStatus != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('fhir.bulk.job_status', res.bulkJobStatus!)
        ]));
      }
      if (res.bulkOutputFiles != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('fhir.bulk.output_files', res.bulkOutputFiles!)
        ]));
      }
      if (res.bulkOutputBytes != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeInt('fhir.bulk.output_bytes', res.bulkOutputBytes!)
        ]));
      }
      if (res.smartScope != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('smart.scope', res.smartScope!)]));
      }
      if (res.smartLaunch != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('smart.launch', res.smartLaunch!)]));
      }
      if (res.usCoreProfile != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('fhir.us_core.profile', res.usCoreProfile!)
        ]));
      }
      if (res.operationName != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('fhir.operation.name', res.operationName!)]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('http.response.status_code', res.statusCode!)]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('epic_fhir.error.code', res.errorCode!)]));
      }
      if (res.outcomeSeverity != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('fhir.outcome.severity', res.outcomeSeverity!)
        ]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400) ||
          res.outcomeSeverity == 'error' ||
          res.outcomeSeverity == 'fatal' ||
          res.bulkJobStatus == 'failed';
      if (fail) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              ErrorResource.errorType.key, res.errorCode ?? 'epic_fhir.error')
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
