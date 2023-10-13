// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NotificationController from "./notification_controller"
application.register("notification", NotificationController)

import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)
