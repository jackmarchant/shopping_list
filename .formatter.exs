# Used by "mix format"
[
  inputs: ["mix.exs", "apps/*/mix.exs", "apps/*/{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [
    field: :*,
    value: :*,
    object: :*,
    arg: :*,
    resolve: :*,
    plug: :*,
    pipe_through: :*,
    get: :*,
    post: :*,
    forward: :*
  ]
]
