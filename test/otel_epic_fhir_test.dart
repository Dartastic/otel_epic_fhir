// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry/testing.dart';
import 'package:otel_epic_fhir/otel_epic_fhir.dart';
import 'package:test/test.dart';

void main() {
  late TestHarness harness;
  late InMemorySpanExporter spans;

  setUpAll(() async {
    harness = await maybeInitializeOtelForTest(
      serviceName: 'otel_epic_fhir-test',
    );
    spans = harness.spans;
  });

  setUp(() => harness.clear());

  Map<String, Object> attrsOf(Span s) =>
      {for (final a in s.attributes.toList()) a.key: a.value};

  test('search.Patient records bundle counts', () async {
    await tracedEpicFhir<String>(
      operation: 'search.Patient',
      invoke: () async => const EpicFhirCallResult(
        value: 'ok',
        result: EpicFhirResult(
          fhirVersion: 'R4',
          interaction: 'search-type',
          resourceType: 'Patient',
          bundleType: 'searchset',
          entryCount: 10,
          totalCount: 312,
        ),
      ),
    );
    final a = attrsOf(spans.findSpanByName('epic_fhir search.Patient')!);
    expect(a['fhir.resource.type'], 'Patient');
    expect(a['fhir.bundle.entry_count'], 10);
    expect(a['fhir.bundle.total'], 312);
  });

  test('OperationOutcome error severity sets span error', () async {
    await tracedEpicFhir<String>(
      operation: 'read.Observation',
      invoke: () async => const EpicFhirCallResult(
        value: 'ok',
        result: EpicFhirResult(
          resourceType: 'Observation',
          outcomeSeverity: 'error',
          statusCode: 400,
        ),
      ),
    );
    expect(
      spans.findSpanByName('epic_fhir read.Observation')!.status,
      SpanStatusCode.Error,
    );
  });

  test('bulk export records output files + bytes', () async {
    await tracedEpicFhir<String>(
      operation: 'bulk.export',
      invoke: () async => const EpicFhirCallResult(
        value: 'ok',
        result: EpicFhirResult(
          bulkExportType: 'Group',
          bulkJobStatus: 'completed',
          bulkOutputFiles: 12,
          bulkOutputBytes: 524288000,
        ),
      ),
    );
    final a = attrsOf(spans.findSpanByName('epic_fhir bulk.export')!);
    expect(a['fhir.bulk.output_files'], 12);
    expect(a['fhir.bulk.output_bytes'], 524288000);
  });

  test('suppression skips spans', () async {
    await runWithoutEpicFhirInstrumentationAsync(() async {
      await tracedEpicFhir<String>(
        operation: 'metadata',
        invoke: () async => const EpicFhirCallResult(value: 'v'),
      );
    });
    expect(spans.findSpansStartingWith('epic_fhir '), isEmpty);
  });
}
