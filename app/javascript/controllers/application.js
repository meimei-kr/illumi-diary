import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true  // デバッグ用にtrueにする
window.Stimulus   = application

export { application }
