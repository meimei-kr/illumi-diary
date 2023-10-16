import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import { Japanese } from "flatpickr/dist/l10n/ja.js"

export default class extends Controller {
  connect() {
    let maxDate = new Date();
    maxDate.setDate(maxDate.getDate());
    flatpickr(".start_time", {
      locale: Japanese,
      dateFormat: 'Y/m/d(D)',
      maxDate: maxDate,
    });
    flatpickr(".end_time", {
      locale: Japanese,
      dateFormat: 'Y/m/d(D)',
      maxDate: maxDate,
    });
  }
}