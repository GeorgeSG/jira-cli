# jirify
A simple ruby gem that helps me work with jira

## How to use
1. Run `gem install jirify`.
1. Execute `jira setup` and go through the setup process OR if you had the previous `config.yml` or `.jirify` file you can just move it to the `~/.jirify/` folder.
1. Execute `jira` and `jira <command> help` to learn about available commands.

## Config Explained
Currently, the config structure of `jirify` is:
- `$HOME/.jirify` folder that contains:
  - `.jirify` - yaml file generated by `jira setup`
  - `jirify.bash_completion.sh` - bash completion script you can source. This is placed here by `jira setup`, so if you don't see it or you want to refresh it, run `jira setup` again.
  - `.cache` - cache for completion script

### Config file: `$HOME/.jirify/.jirify`
```yaml
options:
  username: <atlassian username (email)>
  token: <token generated from https://id.atlassian.com>
  site: <JIRA url>
  project: <JIRA project key>
  filter_by_labels:
    - <label to filter by when displaying sprint>
  verbose: <force jirify to always be verbose>
```

## To Do
- Add ability to define mapping between custom statuses and custom transitions in config.
