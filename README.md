# grafana_bot

This bot is designed to alert messages from [grafana](https://grafana.com/).

Forked from [prometheus_bot](https://github.com/inCaller/prometheus_bot).

## Compile

[GOPATH related doc](https://golang.org/doc/code.html#GOPATH).
```bash
export GOPATH="your go path"
make clean
make
```

## Usage

1. Create Telegram bot with [BotFather](https://t.me/BotFather), it will return your bot token

2. Specify telegram token in ```config.yaml```:

    ```yml
    telegram_token: "token goes here"
    # ONLY IF YOU USING TEMPLATE required for test

    template_path: "template.tmpl"
    time_zone: "Europe/Rome"
    split_token: "|"    

    # ONLY IF YOU USING DATA FORMATTING FUNCTION, NOTE for developer: important or test fail
    time_outdata: "02/01/2006 15:04:05"
    split_msg_byte: 4000
    ```

3. Run ```grafana_bot```. See ```grafana_bot --help``` for command line options
3. Get chat ID with one of two ways
    1. Start conversation, send message to bot mentioning it
    2. Add your bot to a group. It should report group id now. To get ID of a group if bot is already a member [send a message that starts with `/`](https://core.telegram.org/bots#privacy-mode)

### Configuring grafana

Go to *Alerting* -> *Notification channels* -> *New Channel*

Set a name you like, ej. TelegramBotWebhook, and select *webhook* as Type.

In *Url* put the address of the instance or container.  
Ej:  
http://localhost:9087/alert/chat_id  
http://my_docker:9087/alert/chat_id

Replace ```chat_id``` with the number you got from your bot, make sure you include the ```-``` if your id has one.  
To use multiple chats just add more receivers.

## Customising messages with template

This bot support [go templating language](https://golang.org/pkg/text/template/).
Use it for customising your message.

To enable template set these settings in your ```config.yaml``` or template will be skipped.

```yml
telegram_token: "token here"
template_path: "template.tmpl" # your template file name
time_zone: "Europe/Rome" # your time zone check it out from WIKI
split_token: "|" # token used for split measure label.
```

You can also pass template path with `-t` command line argument, it has higher priority than the config option.

[WIKI List of tz database time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

Best way for build your custom template is:
-    Enable bot with ```-d``` flag
-    Catch some of your alerts in json, then copy it from bot STDOUT
-    Save json in testdata/yourname.json
-    Launch ```make test```

```-d``` options will enable ```debug``` mode and template file will reload every message, else template is load once on startup.

Is provided as [default template file](testdata/default.tmpl) with all possibile variable.
Remember that telegram bot support HTML tag. Check [telegram doc here](https://core.telegram.org/bots/api#html-style) for list of aviable tags.

### Template extra functions
Template language support many different functions for text, number and data formatting.

#### Support this functions list

-   ```str_UpperCase```: Convert string to uppercase
-   ```str_LowerCase```: Convert string to lowercase
-   ```str_Title```: Convert string in Title, "title" --> "Title" fist letter become Uppercase
-   DEPRECATED  ```str_Format_Byte```: Convert number expressed in ```Byte``` to number in related measure unit. It use ```strconv.ParseFloat(..., 64)``` take look at go related doc for possible input format, usually every think '35.95e+06' is correct converted.
Example:
    -    35'000'000 [Kb] will converter to '35 Gb'
    -    89'000 [Kb] will converter to '89 Mb'
-   ```HasKey```: Param:dict map, key_search string Search in map if there requeted key
-    ```str_FormatDate```: Convert prometheus string date in your preferred date time format, config file param ```time_outdata``` could be used for setup your favourite format
Require more setting in your cofig.yaml
```yaml
time_zone: "Europe/Rome"
time_outdata: "02/01/2006 15:04:05"
```
[WIKI List of tz database time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)
