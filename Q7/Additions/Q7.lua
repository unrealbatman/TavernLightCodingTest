Q7Button = nil
Q7window = nil
JumpButton = nil

-- Initialization function
function init()
  -- Create a button in the top menu
  Q7Button = modules.client_topmenu.addRightToggleButton('Q7Button', tr('Q7'), '/images/topbuttons/questlog', closing)
  Q7Button:setOn(false) -- Set the initial state to off
  
  -- Display the UI window
  Q7window = g_ui.displayUI('Q7')
  Q7window:setVisible(false) -- Hide the window initially
  
  -- Get the JumpButton widget from the UI window
  JumpButton = Q7window:recursiveGetChildById("closeButton")
  
  -- Register the terminate function to be called when the UI window is closed
  Q7window.onClose = terminate
  
  -- Schedule the moveButton function to be called every second
  g_dispatcher.scheduleEvent(moveButton,1000)
end

-- Termination function
function terminate()
  Q7Button:destroy() -- Destroy the Q7Button
  Q7window:destroy() -- Destroy the Q7window
end

-- Closing function for the top menu button
function closing()
  if Q7Button:isOn() then
    Q7window:setVisible(false) -- Hide the window if the button is on
    Q7Button:setOn(false) -- Turn off the button
  else
    Q7window:setVisible(true) -- Show the window if the button is off
    Q7Button:setOn(true) -- Turn on the button
  end
end

-- Function called when the mini window is closed
function onMiniWindowClose()
  Q7Button:setOn(false) -- Turn off the Q7Button when the mini window is closed
end

-- Function to move the JumpButton horizontally
function moveButton()
  -- Get the current position and size of the button and the window
  local buttonWidth = JumpButton:getWidth()
  local windowWidth = Q7window:getWidth()
  local currentMargin = JumpButton:getMarginRight()
  
  -- Calculate the new margin position
  local newMargin = currentMargin + 5  -- Move right by 5 pixels
  
  -- If the button reaches or exceeds the right margin, reset its position to the left end
  if newMargin == windowWidth - buttonWidth then
    newMargin = 0  -- Reset to the left end
  end
  
  -- Update the button's horizontal margin
  JumpButton:setMarginRight(newMargin)
  
  -- Schedule the next movement
  g_dispatcher.scheduleEvent(moveButton, 1000)
end

-- Function to update the JumpButton's vertical position randomly
function UpdateButtonPosition()
  -- Get the window height
  local windowHeight = Q7window:getHeight()
  
  -- Generate a random y-coordinate within the window height
  local newMarginY = math.random(0, windowHeight - JumpButton:getHeight() )
  
  -- Update the button's vertical margin
  JumpButton:setMarginBottom(newMarginY)
end
