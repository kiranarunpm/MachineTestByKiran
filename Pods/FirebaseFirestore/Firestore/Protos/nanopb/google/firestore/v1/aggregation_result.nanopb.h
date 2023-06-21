/*
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* Automatically generated nanopb header */
/* Generated by nanopb-0.3.9.8 */

#ifndef PB_GOOGLE_FIRESTORE_V1_AGGREGATION_RESULT_NANOPB_H_INCLUDED
#define PB_GOOGLE_FIRESTORE_V1_AGGREGATION_RESULT_NANOPB_H_INCLUDED
#include <pb.h>

#include "google/firestore/v1/document.nanopb.h"

#include <string>

namespace firebase {
namespace firestore {

/* @@protoc_insertion_point(includes) */
#if PB_PROTO_HEADER_VERSION != 30
#error Regenerate this file with the current version of nanopb generator.
#endif


/* Struct definitions */
typedef struct _google_firestore_v1_AggregationResult {
    pb_size_t aggregate_fields_count;
    struct _google_firestore_v1_AggregationResult_AggregateFieldsEntry *aggregate_fields;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_AggregationResult) */
} google_firestore_v1_AggregationResult;

typedef struct _google_firestore_v1_AggregationResult_AggregateFieldsEntry {
    pb_bytes_array_t *key;
    google_firestore_v1_Value value;

    std::string ToString(int indent = 0) const;
/* @@protoc_insertion_point(struct:google_firestore_v1_AggregationResult_AggregateFieldsEntry) */
} google_firestore_v1_AggregationResult_AggregateFieldsEntry;

/* Default values for struct fields */

/* Initializer values for message structs */
#define google_firestore_v1_AggregationResult_init_default {0, NULL}
#define google_firestore_v1_AggregationResult_AggregateFieldsEntry_init_default {NULL, google_firestore_v1_Value_init_default}
#define google_firestore_v1_AggregationResult_init_zero {0, NULL}
#define google_firestore_v1_AggregationResult_AggregateFieldsEntry_init_zero {NULL, google_firestore_v1_Value_init_zero}

/* Field tags (for use in manual encoding/decoding) */
#define google_firestore_v1_AggregationResult_aggregate_fields_tag 2
#define google_firestore_v1_AggregationResult_AggregateFieldsEntry_key_tag 1
#define google_firestore_v1_AggregationResult_AggregateFieldsEntry_value_tag 2

/* Struct field encoding specification for nanopb */
extern const pb_field_t google_firestore_v1_AggregationResult_fields[2];
extern const pb_field_t google_firestore_v1_AggregationResult_AggregateFieldsEntry_fields[3];

/* Maximum encoded size of messages (where known) */
/* google_firestore_v1_AggregationResult_size depends on runtime parameters */
/* google_firestore_v1_AggregationResult_AggregateFieldsEntry_size depends on runtime parameters */

/* Message IDs (where set with "msgid" option) */
#ifdef PB_MSGID

#define AGGREGATION_RESULT_MESSAGES \


#endif

}  // namespace firestore
}  // namespace firebase

/* @@protoc_insertion_point(eof) */

#endif
