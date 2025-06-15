//
//  Generated code. Do not modify.
//  source: example.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getSubtotalRequestDescriptor instead')
const GetSubtotalRequest$json = {
  '1': 'GetSubtotalRequest',
  '2': [
    {'1': 'products', '3': 1, '4': 3, '5': 11, '6': '.Product', '10': 'products'},
  ],
};

/// Descriptor for `GetSubtotalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubtotalRequestDescriptor = $convert.base64Decode(
    'ChJHZXRTdWJ0b3RhbFJlcXVlc3QSJAoIcHJvZHVjdHMYASADKAsyCC5Qcm9kdWN0Ughwcm9kdW'
    'N0cw==');

@$core.Deprecated('Use getSubtotalResponseDescriptor instead')
const GetSubtotalResponse$json = {
  '1': 'GetSubtotalResponse',
  '2': [
    {'1': 'subtotal', '3': 1, '4': 1, '5': 1, '10': 'subtotal'},
  ],
};

/// Descriptor for `GetSubtotalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubtotalResponseDescriptor = $convert.base64Decode(
    'ChNHZXRTdWJ0b3RhbFJlc3BvbnNlEhoKCHN1YnRvdGFsGAEgASgBUghzdWJ0b3RhbA==');

@$core.Deprecated('Use productDescriptor instead')
const Product$json = {
  '1': 'Product',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {'1': 'price', '3': 2, '4': 1, '5': 1, '10': 'price'},
    {'1': 'category', '3': 3, '4': 1, '5': 11, '6': '.Category', '9': 1, '10': 'category', '17': true},
  ],
  '8': [
    {'1': '_name'},
    {'1': '_category'},
  ],
};

/// Descriptor for `Product`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List productDescriptor = $convert.base64Decode(
    'CgdQcm9kdWN0EhcKBG5hbWUYASABKAlIAFIEbmFtZYgBARIUCgVwcmljZRgCIAEoAVIFcHJpY2'
    'USKgoIY2F0ZWdvcnkYAyABKAsyCS5DYXRlZ29yeUgBUghjYXRlZ29yeYgBAUIHCgVfbmFtZUIL'
    'CglfY2F0ZWdvcnk=');

@$core.Deprecated('Use categoryDescriptor instead')
const Category$json = {
  '1': 'Category',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'id', '17': true},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
  '8': [
    {'1': '_id'},
  ],
};

/// Descriptor for `Category`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryDescriptor = $convert.base64Decode(
    'CghDYXRlZ29yeRITCgJpZBgBIAEoBEgAUgJpZIgBARISCgRuYW1lGAIgASgJUgRuYW1lQgUKA1'
    '9pZA==');

