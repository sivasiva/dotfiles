local mixCopyTmpl = [[
defmodule Mix.Tasks.Seed$1Data do
  use Mix.Task

  def run(path) do
    Mix.Task.run("app.start", [])

    opts = App.Repo.config()
    {{:ok, pid}} = Postgrex.start_link(opts)

    Postgrex.transaction(
      pid, 
      fn conn ->
        stream =
          Postgrex.stream(
            conn,
            "COPY locations(name,latitude,longitude) FROM STDIN CSV HEADER DELIMITER ','",
            []
          )

        Enum.into(File.stream!(path, [:trim_bom]), stream)
      end,
      timeout: :infinity
    )
  end
end
]]

return {
  { prefix = "mix:copy", body = mixCopyTmpl, description = "Mix Task to copy CSV" },
}
