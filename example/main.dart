// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:otel_epic_fhir/otel_epic_fhir.dart';

/// Traces Epic Fhir calls with OpenTelemetry.
///
/// `otel_epic_fhir` depends on the OpenTelemetry API only, so the application
/// initializes an SDK once at startup. Wrap each Epic Fhir call in
/// [tracedEpicFhir]; the `invoke` callback makes the real call and reports what
/// came back, which is recorded on the span.
Future<void> main() async {
  await OTel.initialize(serviceName: 'epic-fhir-example');

  // Traces a Epic Fhir call.
  final epicFhirId = await tracedEpicFhir<String>(
    operation: 'create',
    invoke: () async {
      // Make the Epic Fhir call here, then report what it returned.
      const id = 'epic_fhir_8f3a2c';
      return const EpicFhirCallResult(
          value: id,
          result: EpicFhirResult(
              environment: 'example',
              tenant: 'example',
              fhirVersion: '1',
              interaction: 'example',
              resourceType: 'standard',
              resourceId: 'resource_8f3a2c',
              bundleType: 'standard',
              entryCount: 3,
              totalCount: 3,
              searchMode: 'example',
              includeCount: 3,
              revIncludeCount: 3,
              pages: 1,
              bulkExportType: 'standard',
              bulkJobStatus: 'succeeded',
              bulkOutputFiles: 1,
              bulkOutputBytes: 512,
              smartScope: 'example',
              smartLaunch: 'example',
              usCoreProfile: 'example',
              operationName: 'example',
              statusCode: 201,
              errorCode: 'example',
              outcomeSeverity: 'example',
              errorMessage: 'example'));
    },
  );
  OTelLog.info('tracedEpicFhir create returned $epicFhirId');

  // Calls that should not be traced, such as health checks, run inside
  // runWithoutEpicFhirInstrumentationAsync.
  await runWithoutEpicFhirInstrumentationAsync(
    () => tracedEpicFhir<String>(
      operation: 'create',
      invoke: () async {
        const id = 'epic_fhir_8f3a2c';
        return const EpicFhirCallResult(
            value: id,
            result: EpicFhirResult(
                environment: 'example',
                tenant: 'example',
                fhirVersion: '1',
                interaction: 'example',
                resourceType: 'standard',
                resourceId: 'resource_8f3a2c',
                bundleType: 'standard',
                entryCount: 3,
                totalCount: 3,
                searchMode: 'example',
                includeCount: 3,
                revIncludeCount: 3,
                pages: 1,
                bulkExportType: 'standard',
                bulkJobStatus: 'succeeded',
                bulkOutputFiles: 1,
                bulkOutputBytes: 512,
                smartScope: 'example',
                smartLaunch: 'example',
                usCoreProfile: 'example',
                operationName: 'example',
                statusCode: 201,
                errorCode: 'example',
                outcomeSeverity: 'example',
                errorMessage: 'example'));
      },
    ),
  );

  await OTel.shutdown();
}
