# Keywords Notifier x Robocorp Control Room

This Robot Framework bot monitors configured keywords on F5Bot.com and posts a formatted notification on the desired Slack Channel.

## How to use the Keywords Notifier

_Requirements:_

- A F5Bot account configured with the keywords you wish to monitor
- A Robocorp Control Room account (_under the free plan you should be able to get ~100 mentions per month_)
- A Slack workspace with webhook configuration access

### 1. Setting up the Robot

1. Just head over to your Robots in Control Room, create new Robot and specify the URL to be the public URL of this github repository.
2. Create a _Vault_ secret called "SlackNotifier" with a key `WEBHOOK` inside
3. Create a new process with a single step.
4. Set up the environment variable `SLACK_CHANEL` for this step with the channel of your choice.
5. Configure the process to be triggered by email, tick "Parse Email"
6. Retrieve the email to be used in next step to configure the email forwarding

### 2. Configure Email Forwarding (GMAIL walk-through)

1. Create a new email forwarding using the process trigger email retrieved in step 1.6
2. GMAIL will send a verification email with a code to this email: this will trigger the process with a work item containing the code to verify
3. Create a filter with the following configuration:

- from `admin@f5bot.com`
- to `your_f5bot_account_email`
- forward to `process_trigger_email`

## Known limitations

The keywords notifier currently only supports F5Bot, which monitors mentions on [Hackernews](https://new.ycombinator.com) and [Reddit](https://reddit.com).

Feel free to open an issue or pull request if you would like other services to be supported – the sole requirement is that they must be free or have a generous free tier.
