import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [ "inputDate" ]

  connect() {
    let maxDate = new Date();
    maxDate.setDate(maxDate.getDate());
    flatpickr(".start_time", {
      locale: 'ja',
      dateFormat: 'Y/m/d(D)',
      maxDate: maxDate,
    });
    flatpickr(".end_time", {
      locale: 'ja',
      dateFormat: 'Y/m/d(D)',
      maxDate: maxDate,
    });
  }
}