IEx.configure(
  default_prompt: "%prefix>",
  history_size: -1,
  colors: [
    eval_result: [:cyan, :bright]
  ]
)

if Node.alive? do
  IEx.configure(default_prompt: "%prefix(%node):%counter>")
else
  IEx.configure(default_prompt: "%prefix:%counter>")
end
