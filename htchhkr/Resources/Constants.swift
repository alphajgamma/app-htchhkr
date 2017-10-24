//
//  Constants.swift
//  htchhkr
//
//  Created by Andrew Greenough on 23/10/2017.
//  Copyright © 2017 Andrew Greenough. All rights reserved.
//

import Foundation

// Account
let ACCOUNT_PROVIDER = "provider"
let ACCOUNT_IS_DRIVER = "isDriver"
let ACCOUNT_PICKUP_MODE_ENABLED = "isPickupModeEnabled"
let ACCOUNT_TYPE_PASSENGER = "PASSENGER"
let ACCOUNT_TYPE_DRIVER = "DRIVER"

// Location
let COORDINATE = "coordinate"

// Trip
let TRIP_COORDINATE = "tripCoordinate"
let TRIP_IS_ACCEPTED = "tripIsAccepted"
let TRIP_IN_PROGRESS = "tripIsInProgress"

// User
let USER_PICKUP_COORDINATE = "pickupCoordinate"
let USER_DESTINATION_COORDINATE = "destinationCoordinate"
let USER_PASSENGER_KEY = "passengerKey"
let USER_IS_DRIVER = "userIsDriver"

// Driver
let DRIVER_KEY = "driverKey"
let DRIVER_IS_ON_TRIP = "driverIsOnTrip"

// Annotations
let ANNO_DRIVER = "driverAnnotation"
let ANNO_DRIVER_IDENTIFIER = "driver"
let ANNO_PASSENGER = "currentLocationAnnotation"
let ANNO_PASSENGER_IDENTIFIER = "passenger"
let ANNO_DESTINATION = "destinationAnnotation"
let ANNO_DESTINATION_IDENTIFIER = "pickupPoint"

// Map Regions
let REGION_PICKUP = "pickup"
let REGION_DESTINATION = "destination"

// Storyboard
let STORYBOARD_MAIN = "Main"

// View Controllers
let VC_LEFT_PANEL = "LeftSidePanelVC"
let VC_HOME = "HomeVC"
let VC_LOGIN = "LoginVC"
let VC_PICKUP = "PickupVC"

// UI Messaging
let MSG_SIGN_UP_SIGN_IN = "Sign Up / Login"
let MSG_SIGN_OUT = "Sign Out"
let MSG_PICKUP_MODE_ENABLED = "PICKUP MODE ENABLED"
let MSG_PICKUP_MODE_DISABLED = "PICKUP MODE DISABLED"
let MSG_REQUEST_RIDE = "REQUEST RIDE"
let MSG_START_TRIP = "START TRIP"
let MSG_END_TRIP = "END TRIP"
let MSG_GET_DIRECTIONS = "GET DIRECTIONS"
let MSG_CANCEL_TRIP = "Cancel Trip"
let MSG_DRIVER_COMING = "DRIVER COMING"
let MSG_ON_TRIP = "ON TRIP"
let MSG_PASSENGER_PICKUP = "Passenger Pickup Point"
let MSG_PASSENGER_DESTINATION = "Passenger Destination"

// Error Messages
let ERROR_MSG_TITLE_AUTHENTICATION = "Authentication Error"
let ERROR_MSG_TITLE_SIGN_OUT = "Sign Out Error"
let ERROR_MSG_TITLE_NO_RESULTS = "No Results"
let ERROR_MSG_TITLE_SEARCH = "Search Error"
let ERROR_MSG_NO_MATCHES_FOUND = "No matches found. Please try again!"
let ERROR_MSG_INVALID_EMAIL = "Sorry, the email you've entered appears to be invalid. Please try another email."
let ERROR_MSG_EMAIL_ALREADY_IN_USE = "It appears that email is already in use by another user. Please try again"
let ERROR_MSG_INVALID_PASSWORD = "The password you supplied is incorrect. Please try again"
let ERROR_MSG_UNEXPECTED_ERROR = "There has been an unexpected error. Please try again"
