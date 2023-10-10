import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true // debugモードを有効にする
window.Stimulus   = application

export { application }
