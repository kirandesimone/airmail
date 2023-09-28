# Airmail

## Description

## ERDiagram

  ```mermaid
    erDiagram
      User }o--o{ Team: join
    User {
        string username
        citext email
        string hashed_password
    }
    Team }o--o{ Game: in
    Team {
        string name
        int wins
        int losses
    }
    Game {
        int lane_number
        int team1_score
        int team2_score
    }
    Team ||--o{ Team_Game: in
    Game ||--o{ Team_Game: in
    Team_Game {
        int team_id
        int game_id
    }
    User ||--o{ User_Team: in
    Team ||--o{ User_Team:in
    User_Team {
        int user_id
        int team_id
    }Users
  ```

## Git Workflow

  ### Create Branch
  
  update local branch

  ```
  cd $working_dir/project_name
  git fetch upstream
  git checkout main
  git rebase upstream/main
  ```

  branch out

  ```
  git checkout -b feature/my-precious
  ```

  ### Sync Branch

  ```
  # While on your feature/my-precious branch
  git fetch upstream
  git rebase upstream/main
  ```

  ### Commit

  ```
  git commit
  ```

  ### Push Changes

  ```
  git push $your_remote_name feature/my-precious
  ```


To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
