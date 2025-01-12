# Copyright 2021 Bedford Freeman & Worth Pub Grp LLC DBA Macmillan Learning.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

base_url <- "https://storage.googleapis.com/torchtransformers-models/"

# maybe later store as a tibble with more info, but named vector is ok for now.

weights_url_map <- c(
  "bert_tiny_uncased" = paste0(
    base_url,
    "bert-tiny/v1/weights.pt"
  ),
  "bert_mini_uncased" = paste0(
    base_url,
    "bert-mini/v1/weights.pt"
  ),
  "bert_small_uncased" = paste0(
    base_url,
    "bert-small/v1/weights.pt"
  ),
  "bert_medium_uncased" = paste0(
    base_url,
    "bert-medium/v1/weights.pt"
  ),
  "bert_base_uncased" = paste0(
    base_url,
    "bert-base-uncased/v1/weights.pt"
  ),
  "bert_base_cased" = paste0(
    base_url,
    "bert-base-cased/v1/weights.pt"
  ),
  "bert_large_uncased" = paste0(
    base_url,
    "bert-large-uncased/v1/weights.pt"
  )
)


# There are some hard-to-avoid differences between the variable names in bert
# models constructed using this package and the standard variable names used in
# the huggingface saved weights. Here are some renaming rules that will (almost
# always?) be applied. We modify the *loaded* weights to match the *package*
# weights.
# Also! different models within huggingface have slightly different conventions!
# The tiny, etc. BERT models use "weight" & "bias" rather than "gamma" & "beta".

variable_names_replacement_rules <- c(
  ".gamma" = ".weight",
  ".beta" = ".bias",
  "LayerNorm" = "layer_norm",
  "attention.output.dense" = "attention.self.out_proj",
  "bert." = ""
)


# May as well store the configuration info for known BERT models here...
# "intermediate size" is always 4x the embedding size for these models.
bert_configs <- tibble::tribble(
  ~model_name, ~embedding_size, ~n_layer, ~n_head, ~max_tokens, ~vocab_size,
  "bert_tiny_uncased", 128L, 2L, 2L, 512L, 30522L,
  "bert_mini_uncased", 256L, 4L, 4L, 512L, 30522L,
  "bert_small_uncased", 512L, 4L, 8L, 512L, 30522L,
  "bert_medium_uncased", 512L, 8L, 8L, 512L, 30522L,
  "bert_base_uncased", 768L, 12L, 12L, 512L, 30522L,
  "bert_base_cased", 768L, 12L, 12L, 512L, 28996L,
  "bert_large_uncased", 1024L, 24L, 16L, 512L, 30522L
)


usethis::use_data(
  weights_url_map,
  variable_names_replacement_rules,
  bert_configs,
  internal = TRUE,
  overwrite = TRUE
)

rm(
  base_url,
  weights_url_map,
  variable_names_replacement_rules,
  bert_configs
)
