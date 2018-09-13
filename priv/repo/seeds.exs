# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Smarthood.Repo.insert!(%Smarthood.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Smarthood.Repo.insert!(%Smarthood.Accounts.Role{
    key: "admin",
    name: "Administrator"
})

Smarthood.Repo.insert!(%Smarthood.Accounts.Role{
    key: "user",
    name: "Regular user"
})

Smarthood.Repo.insert!(%Smarthood.Accounts.Role{
    key: "data_entry",
    name: "Data Entry"
})

# Smarthood.Repo.insert!(%Smarthood.StatusTrack.WorkStatusType{
#     name: "Daily",
#     description: "This option is used to track Daily Work status",
#     period: 1,
# })