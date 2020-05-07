defmodule LessonComponent.DefaultImpl.LessonStore.Mnesia do
  use LessonComponent.DefaultImpl.LessonStore

  @config [db: DB, table: Lessons]
  @db Module.concat(__MODULE__, @config[:db])
  @store Module.concat(@db, @config[:table])

  @spec setup!(nodes :: list(node)) :: :ok
  def setup!(nodes \\ [node()]) do
    # Create the DB directory (if custom path given)
    if path = Application.get_env(:mnesia, :dir) do
      :ok = File.mkdir_p!(path)
    end

    # Create the Schema
    Memento.stop()
    Memento.Schema.create(nodes)
    Memento.start()

    # Create the DB with Disk Copies
    # TODO:
    # Use Memento.Table.wait when it gets implemented
    # @db.create!(disk: nodes)
    # @db.wait(15000)
    Memento.Table.create!(@store, disc_copies: nodes)
  end

  @doc "Returns the Mnesia configuration for Lesson Component"
  @spec __config__ :: Keyword.t()
  def __config__ do
    [
      database: @db,
      table: @store,
      path: Path.expand(Application.get_env(:mnesia, :dir))
    ]
  end

  # Callbacks in Table Definition
  # -----------------------------

  # Make sures that the DB exists (either
  # in memory or on disk)
  @doc false
  def initialize do
    Memento.Table.create(@store)
  end

  @doc false
  defdelegate lessons(teacher_id), to: @store, as: :lessons_for_teacher
end
