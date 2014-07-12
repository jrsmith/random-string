module.exports =
  configDefaults:
    length: 20
    type: 'alphanumeric'

  charsets: {
    'letters': 'abcdefghiklmnopqrstuvwxyz',
    'numbers': '0123456789',
    'special': '!\'#$%&"()*+,-./:;<=>?@[\\]^_`{|}~'
  }

  activate: (state) ->
    atom.workspaceView.command 'random-string:insert', => @insert()
    atom.workspaceView.command 'random-string:settype', => @settype()
    atom.workspaceView.command 'random-string:setlength', => @setlength()

  charset: ->
    charset = ''

    switch atom.config.get('random-string.type')
      when 'alphanumeric'
        charset = this.charsets.numbers + this.charsets.letters +
                  this.charsets.letters.toUpperCase()
      when 'printable'
        charset = this.charsets.numbers + this.charsets.letters +
                  this.charsets.letters.toUpperCase() + this.charsets.special

    return charset.split('')

  insert: ->
    length = atom.config.get('random-string.length')

    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()

    randomString = ''
    charset = this.charset()

    console.log length
    console.log charset

    for i in [1..length]
      randomString += charset[Math.floor (Math.random() * charset.length)]

    selection.insertText(randomString)

    # there has to be a better way to do this
    for i in [1..length]
      selection.selectLeft()
