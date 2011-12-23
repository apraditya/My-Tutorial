# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  the_form = $("form.multisteps")
  current_step = 1
  total_steps = $('.multisteps .step').length
  steps_width = 0
  widths = []
  
  $('.multisteps .step').each((i) ->
    widths[i] = steps_width
    steps_width += $(this).width()
  )
  $('#steps').width(steps_width)
  
  # To avoid problems with IE, focus the first input of the form
  the_form.children(':first').find(':input:first').focus();

  # slider function
  slide_to = (step) ->
    $('#steps').stop().animate(
      {marginLeft: "-#{widths[step - 1]}px"},
      500
    )
    return
  
  # Bind the next button
  $('.navigation_multistep .next a').bind('click', (e)->
    if validate_form_at(current_step)
      current_step += 1
      slide_to current_step
      e.preventDefault()
    else
      alert "The form on step #{current_step} is invalid"
    false
  )

  # Bind the previous button
  $('.navigation_multistep .prev a').bind('click', (e)->
    current_step -= 1
    slide_to current_step
    e.preventDefault()
    false
  )


  # SETUP THE FORM VALIDATION
  rules = {}
  current_name = ''
  # get all the required inputs in all steps
  $(".multistep_required").each ->
    unless current_name == this.name
      rules[this.name] = 'required'
      current_name = this.name
    return
  
  # setup the validator
  the_form.validate({
    rules: rules
  })


  validate_form_at = (step) ->
    form_names = []
    current_name = ""
    j = 0
    $("fieldset .step#{step} .multistep_required").each((i) ->
      unless current_name == this.name
        form_names[j] = this.name
        current_name  = this.name
        j++
        return
    )
    
    valid = true
    for form_name in form_names
      valid &= $("[name='#{form_name}']").valid()
    
    return valid  