import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="avatar-fields"
export default class extends Controller {
  static targets = ["fields"]

  connect() {
  }

  toggleFields() {
    this.fieldsTarget.classList.toggle("hidden")
  }
}
