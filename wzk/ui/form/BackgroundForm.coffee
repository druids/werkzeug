goog.provide 'wzk.ui.form.BackgroundForm'

goog.require 'goog.events.EventTarget'
goog.require 'goog.ui.Button'

class wzk.ui.form.BackgroundForm extends goog.events.EventTarget

  ###*
    @enum {string}
  ###
  @EventType:
    SAVED: 'saved'
    ERROR: 'error'

  ###*
    @constructor
    @extends {goog.events.EventTarget}
    @param {wzk.resource.Client} client
    @param {wzk.dom.Dom} dom
  ###
  constructor: (@client, @dom) ->
    super()
    @btn = null
    @client = null

  ###*
    @param {Element} form
  ###
  decorate: (form) ->
    return unless form?
    dispatcher = form.querySelector '.btn-save'
    throw new Error 'Missing a dispatcher button' unless dispatcher?
    @btn = new goog.ui.Button()
    @btn.decorate dispatcher

    @hangListener form
    @removeDefaultBehaviour form

  ###*
    @protected
    @param {Element} form
  ###
  removeDefaultBehaviour: (form) ->
    goog.events.listen form, 'submit', (e) =>
      e.preventDefault()

  ###*
    @protected
    @param {Element} form
  ###
  hangListener: (form) ->
    @btn.listen goog.ui.Component.EventType.ACTION, =>
      @btn.setEnabled false
      @send form