//
//  Constants.swift
//  Gate Guard
//
//  Created by Ram on 3/10/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

// MARK: - Login Filters

var login1 = "http://api.gateguard.com.mx/api/Accounts/login"// Entra: usuario y contraseña -> Sale: Diccionario de información "Perfiles", "UserToken"
var login2 =  "http://api.gateguard.com.mx/api/Accounts/login2" // Entra: "profileId" y "userTokenId" -> Sale: Estatus de entrada 

// MARK: - Administración de Sistema

    // Usuarios
        // Get Users
        public var usersGetUsers =  "http://api.gateguard.com.mx/api/Users/getUsers"
        // Save User
        var usersSaveUser =         "http://api.gateguard.com.mx/api/Users/saveUser"
        // Delete User
        var usersDeleteUser =       "http://api.gateguard.com.mx/api/Users/deleteUser"
        // Disable User
        var usersDisableUser =      "http://api.gateguard.com.mx/api/Users/disabledUser"
        // Check User Mail
        var usersCheckMail =        "http://api.gateguard.com.mx/api/Users/checkMail"
        // Get Suburbs 
        var usersGetSuburbs =       "http://api.gateguard.com.mx/api/Users/getSuburbs"
        // Get Residences
        var usersGetResidences =    "http://api.gateguard.com.mx/api/Users/getResidences"
        // Activate GPS
        var usersActivateGps =      "http://api.gateguard.com.mx/api/Users/activateGps"

    // Colonias
        // Get Suburbs
        var suburbsGetSuburbs =         "http://api.gateguard.com.mx/api/Suburbs/getSuburbs"
        // Save Suburbs
        var suburbsSaveSuburbs =        "http://api.gateguard.com.mx/api/Suburbs/saveSuburbs"
        // Delete Suburb
        var suburbsDeleteSuburb =       "http://api.gateguard.com.mx/api/Suburbs/deleteSuburb"
        // Get Doors Directions
        var suburbsGetDoorsDirections = "http://api.gateguard.com.mx/api/Suburbs/getDoorsDirections"
        // Get Doors Types
        var suburbsGetDoorsTypes = "http://api.gateguard.com.mx/api/Suburbs/getDoorsTypes"
        // Save Doors 
        var suburbsSaveDoors = "http://api.gateguard.com.mx/api/Suburbs/saveDoors"
        // Get Doors
        var suburbsGetDoors = "http://api.gateguard.com.mx/api/Suburbs/getDoors"
        // Deleted Door
        var suburbsDeletedDoor = "http://api.gateguard.com.mx/api/Suburbs/deletedDoor"

    // Guardias
        // Get Guards
        var guardsGetGuards = "http://api.gateguard.com.mx/api/Guards/getGuards"
        // save Guards
        var guardsSaveGuards = "http://api.gateguard.com.mx/api/Guards/saveGuards"
        // check mail
        var guardsCheckMail = "http://api.gateguard.com.mx/api/Guards/checkMail"
        // get profile
        var guardsGetProfile = "http://api.gateguard.com.mx/api/Guards/getPerfil"
        // get Suburbs
        var guardsGetSuburbs = "http://api.gateguard.com.mx/api/Guards/getSuburbs"
        // get My Assigned Suburbs
        var suburbsGetMyAssignedSuburbs = "http://api.gateguard.com.mx/api/Guards/getMyAssignedSuburbs"
        // deleted Assigned Suburb
        var suburbsDeletedAssignedSuburb = "http://api/gateguard.com.mx/api/Guards/deletedAssignedSuburb"

    // Perfiles
        // Get Profiles
        var profilesGetProfiles = "http://api.gateguard.com.mx/api/Profiles/getProfiles"
        // Save Profiles
        var profilesSaveProfiles = "http://api.gateguard.com.mx/api/Profiles/saveProfiles"
        // Deleted Profiles
        var profilesDeletedProfile = "http://api.gateguard.com.mx/api/Profiles/deletedProfile"
        // Get Categories
        var profilesGetCategories = "http://api.gateguard.com.mx/api/Profiles/getCategories"
        // Save Privilege
        var profilesSavePrivilege = "http://api.gateguard.com.mx/api/Profiles/savePrivilege"
        // delete privilege
        var profilesDeletePrivilege = "http://api.gateguard.com.mx/api/Profiles/deletePrivilege"

    // Servicios
        // get services
        var servicesGetServices = "http://api.gateguard.com.mx/api/Services/getServices"
        // get Category Service
        var servicesGetCategoryService = "http://api.gateguard.com.mx/api/Services/getCategoryService"
        // save Service
        var servicesSaveService = "http://api.gateguard.com.mx/api/Services/saveService"
        // deleted service
        var servicesDeletedService = "http://api.gateguard.com.mx/api/Services/deletedService"
        // Disabled Service
        var servicesDisabledService = "http://api.gateguard.com.mx/api/Services/disabledService"
        // Deleted Category Service
        var servicesDeletedCategoryService = "http://api.gateguard.com.mx/api/Services/deletedCategoryService"
        // save category service
        var servicesSaveCatgoryService = "http://api.gateguard.com.mx/api/Services/saveCatgoryService"

// MARK: - Nuestra Colonia

    // Ingresos
        // Get Residents
        var incomesGetResidents = "http://api.gateguard.com.mx/api/Incomes/getResidents"
        // get Incomes types
        var incomesGetIncomestypes = "http://api.gateguard.com.mx/api/Incomes/getIncomestypes"
        // get Payment Methods
        var incomesGetPaymentMethods = "http://api.gateguard.com.mx/api/Incomes/getPaymentMethods"
        // save Income
        var incomesSaveIncome = "http://api.gateguard.com.mx/api/Incomes/saveIncome"
        // get Incomes
        var incomesGetIncomes = "http://api.gateguard.com.mx/api/Incomes/getIncomes"
        // get Last Operation Number
        var incomesGetLastOperationNumber = "http://api.gateguard.com.mx/api/Incomes/getLastOperationNumber"
        // calculate Balance To From Date
        var incomesCalculateBalanceToFromDate = "http://api.gateguard.com.mx/api/Incomes/calculateBalanceToFromDate"
        // get Expenses To This Date
        var incomesGetExpensesToThisDate = "http://api.gateguard.com.mx/api/Incomes/getExpensesToThisDate"
        // get Incomes To This Date
        var incomesGetIncomesToThisDate = "http://api.gateguard.com.mx/api/Incomes/getIncomesToThisDate"
        // conciliate Income
        var incomesConciliateIncome = "http://api.gateguard.com.mx/api/Incomes/conciliateIncome"
        // delete Income
        var incomesDeleteIncome = "http://api.gateguard.com.mx/api/Incomes/deleteIncome"
        // get Residence Incomes
        var incomesGetResidenceIncomes = "http://api.gateguard.com.mx/api/Incomes/getResidenceIncomes"
        // get Income Periods
        var incomesGetIncomePeriods = "http://api.gateguard.com.mx/api/Incomes/getIncomePeriods"
        // get Periods Concepts
        var incomesGetPeriodsConcepts = "http://api.gateguard.com.mx/api/Incomes/getPeriodsConcepts"

    // Gastos
        // save Provider
        var expensesSaveProvider = "http://api.gateguard.com.mx/api/Expenses/saveProvider"
        // get Providers
        var expensesGetProviders = "http://api.gateguard.com.mx/api/Expenses/getProviders"
        // get Providers On Load
        var expensesGetProvidersOnLoad = "http://api.gateguard.com.mx/api/Expenses/getProvidersOnLoad"
        // check Rfc
        var expensesCheckRfc = "http://api.gateguard.com.mx/api/Expenses/checkRfc"
        // save Expense
        var expensesSaveExpense = "http://api.gateguard.com.mx/api/Expenses/saveExpense"
        // get Last Operation Number
        var expensesGetLastOperationNumber = "http://api.gateguard.com.mx/api/Expenses/getLastOperationNumber"
        // get Expenses
        var expensesGetExpenses = "http://api.gateguard.com.mx/api/Expenses/getExpenses"
        // get Payments To This Expense
        var expensesGetPaymentsToThisExpense = "http://api.gateguard.com.mx/api/Expenses/getPaymentsToThisExpense"
        // conciliate Expense
        var expensesConciliateExpense = "http://api.gateguard.com.mx/api/Expenses/conciliateExpense"
        // delete Expense
        var expensesDeleteExpense = "http://api.gateguard.com.mx/api/Expenses/deleteExpense"
        // get Banks Accounts
        var expensesGetBanksAccounts = "http://api.gateguard.com.mx/api/Expenses/getBanksAccounts"
        // get Payments Forms
        var expensesGetPaymentsForms = "http://api.gateguard.com.mx/api/Expenses/getPaymentsForms"
        // save Payment
        var expensesSavePayment = "http://api.gateguard.com.mx/api/Expenses/savePayment"
        // get Payments
        var expensesGetPayments = "http://api.gateguard.com.mx/api/Expenses/getPayments"
        // delete Payment
        var expensesDeletePayment = "http://api.gateguard.com.mx/api/Expenses/deletePayment"

    // Facturas
        // get Residents
        var invoicesGetResidents = "http://api.gateguard.com.mx/api/Invoices/getResidents"
        // get Invoices
        var invoicesGetInvoices = "http://api.gateguard.com.mx/api/Invoices/getInvoices"
        // get Data Invoice
        var invoicesGetDataInvoice = "http://api.gateguard.com.mx/api/Invoices/getDataInvoice"
        // get Devices
        var invoicesGetDevices = "http://api.gateguard.com.mx/api/Invoices/getDevices"

    // Encuestas y Votaciones
        // get Surveys types
        var surveysGetSurveystypes = "http://api.gateguard.com.mx/api/Surveys/getSurveystypes"
        // save Survey
        var surveysSaveSurvey = "http://api.gateguard.com.mx/api/Surveys/saveSurvey"
        // get Surverys
        var surveysGetSurverys = "http://api.gateguard.com.mx/api/Surveys/getSurverys"
        // get Users Avaliables
        var surveysGetUsersAvaliables = "http://api.gateguard.com.mx/api/Surveys/getUsersAvaliables"
        // get Questions types
        var surveysGetQuestionstypes = "http://api.gateguard.com.mx/api/Surveys/getQuestionstypes"
        // Question To Survey
        var surveysQuestionToSurvey = "http://api.gateguard.com.mx/api/Surveys/QuestionToSurvey"
        // get Question In Survey
        var surveysGetQuestionInSurvey = "http://api.gateguard.com.mx/api/Surveys/getQuestionInSurvey"
        // get Question Options
        var surveysGetQuestionOptions = "http://api.gateguard.com.mx/api/Surveys/getQuestionOptions"
        // delete Question
        var surveysDeleteQuestion = "http://api.gateguard.com.mx/api/Surveys/deleteQuestion"
        // insert Surveys
        var surveysInsertSurveys = "http://api.gateguard.com.mx/api/Surveys/insertSurveys"
        // delete Surveys
        var surveysDeleteSurveys = "http://api.gateguard.com.mx/api/Surveys/deleteSurveys"
        // get Survey Result
        var surveysGetSurveyResult = "http://api.gateguard.com.mx/api/Surveys/getSurveyResult"
        // send Survey Mail
        var surveysSendSurveyMail = "http://api.gateguard.com.mx/api/Surveys/sendSurveyMail"
        // get Survey Users
        var surveysGetSurveyUsers = "http://api.gateguard.com.mx/api/Surveys/getSurveyUsers"
        // get Data Result
        var surveysGetDataResult = "http://api.gateguard.com.mx/api/Surveys/getDataResult"
        // get Participants List
        var surveysGetParticipantsList = "http://api.gateguard.com.mx/api/Surveys/getParticipantsList"

    // Notificaciones
        // 

    // Configuración
        // get configurations
        var configurationsGetConfigurations = "http://api.gateguard.com.mx/api/Configurations/getConfigurations"
        // get banks
        var configurationsGetbanks = "http://api.gateguard.com.mx/api/Configurations/getbanks"
        // get Incomes Types
        var configurationsGetIncomesTypes = "http://api.gateguard.com.mx/api/Configurations/getIncomesTypes"
        // update Monthly Payment
        var configurationsUpdateMonthlyPayment = "http://api.gateguard.com.mx/api/Configurations/updateMonthlyPayment"
        // update Bank Account
        var configurationsUpdateBankAccount = "http://api.gateguard.com.mx/api/Configurations/updateBankAccount"
        // save Income Concept
        var configurationsSaveIncomeConcept = "http://api.gateguard.com.mx/api/Configurations/saveIncomeConcept"
        // get Income Concepts
        var configurationsGetIncomeConcepts = "http://api.gateguard.com.mx/api/Configurations/getIncomeConcepts"
        // get Income Template
        var configurationsGetIncomeTemplate = "http://api.gateguard.com.mx/api/Configurations/getIncomeTemplate"
        // save Income Template
        var configurationsSaveIncomeTemplate = "http://api.gateguard.com.mx/api/Configurations/saveIncomeTemplate"
        // get Periods Concepts
        var configurationsGetPeriodsConcepts = "http://api.gateguard.com.mx/api/Configurations/getPeriodsConcepts"
        // update Invoice Numbers
        var configurationsUpdateInvoiceNumbers = "http://api.gateguard.com.mx/api/Configurations/updateInvoiceNumbers"
        // save Bank Account
        var configurationsSaveBankAccount = "http://api.gateguard.com.mx/api/Configurations/saveBankAccount"
        // get Banks Accounts
        var configurationsGetBanksAccounts = "http://api.gateguard.com.mx/api/Configurations/getBanksAccounts"
        // delete Bank Account
        var configurationsDeleteBankAccount = "http://api.gateguard.com.mx/api/Configurations/deleteBankAccount"

    // Quejas y Sugerencias
        // Get Complains
        var complainsGetComplins = "http://api.gateguard.com.mx/api/Administrator/getComplains"
        // get Complaint Detail
        var complainsGetComplaintDetail = "http://api.gateguard.com.mx/api/Administrator/getComplaintDetail"
        // save Complain
        var complainsSaveComplains = "http://api.gateguard.com.mx/api/Administrator/saveComplain"
        // comment post
        var complainsCommentPost = "http://api.gateguard.com.mx/api/Administrator/comment"
        // close Complaint
        var complainsCloseComplains = "http://api.gateguard.com.mx/api/Administrator/closeComplaint"

    // Monitoreo de Paneles de Alarma
        // get Residences In Suburb
        var alarmPanelsGetResidencesInSuburb = "http://api.gateguard.com.mx/api/AlarmPanels/getResidencesInSuburb"
        // get Panels Brands
        var alarmPanelsGetPanelsBrands = "http://api.gateguard.com.mx/api/AlarmPanels/getPanelsBrands"
        // get Panels Models
        var alarmPanelsGetPanelsModels = "http://api.gateguard.com.mx/api/AlarmPanels/getPanelsModels"
        // get Panel In Residence
        var alarmPanelsGetPanelInResidence = "http://api.gateguard.com.mx/api/AlarmPanels/getPanelInResidence"
        // get Zones Of This Panel
        var alarmPanelsGetZonesOfThisPanel = "http://api.gateguard.com.mx/api/AlarmPanels/getZonesOfThisPanel"
        // save Panel
        var alarmPanelsSavePanel = "http://api.gateguard.com.mx/api/AlarmPanels/savePanel"
        // get New Account Number
        var alarmPanelsGetNewAccountNumber = "http://api.gateguard.com.mx/api/AlarmPanels/getNewAccountNumber"
        // delete Panel
        var alarmPanelsDeletePanel = "http://api.gateguard.com.mx/api/AlarmPanels/deletePanel"
        // get Servers Status
        var alarmPanelsGetServersStatus = "http://api.gateguard.com.mx/api/AlarmPanels/getServersStatus"
        // save Zone In Panel
        var alarmPanelsSaveZoneInPanel = "http://api.gateguard.com.mx/api/AlarmPanels/saveZoneInPanel"
        // get Alarm Event Class
        var alarmPanelsGetAlarmEventClass = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmEventClass"
        // get Alarm Events
        var alarmPanelsGetAlarmEvents = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmEvents"
        // update Event
        var alarmPanelsUpdateEvent = "http://api.gateguard.com.mx/api/AlarmPanels/updateEvent"
        // get Panel In Suburbs
        var alarmPAnelsGetPanelInSuburbs = "http://api.gateguard.com.mx/api/AlarmPanels/getPanelInSuburbs"
        // get Event No Ack
        var alarmPanelsGetEventNoAck = "http://api.gateguard.com.mx/api/AlarmPanels/getEventNoAck"
        // get Last Event In Panel
        var alarmPanelsGetLastEventInPanel = "http://api.gateguard.com.mx/api/AlarmPanels/getLastEventInPanel"
        // get Panel Alarm No Ack
        var alarmPanelsGetPanelAlarmNoAck = "http://api.gateguard.com.mx/api/AlarmPanels/getPanelAlarmNoAck"
        // save Ack
        var alarmPanelsSaveAck = "http://api.gateguard.com.mx/api/AlarmPanels/saveAck"
        // get Alarm In Suburb
        var alarmPanelsGetAlarmInSuburb = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmInSuburb"
        // get Alarm Events In Residence
        var alarmPanelsGetAlarmEventsInResidence = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmEventsInResidence"
        // get Alarm Classifications
        var alarmPanelsGetAlarmClassifications = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmClassifications"
        // get Alarm Events Db
        var alarmPanelsGetAlarmEventsDb = "http://api.gateguard.com.mx/api/AlarmPanels/getAlarmEventsDb"
        // get Event Info
        var alarmPanelsGetEventInfo = "http://api.gateguard.com.mx/api/AlarmPanels/getEventInfo"
        // get Holder In Residence
        var alarmPanelsGetHolderInResidence = "http://api.gateguard.com.mx/AlarmPanels/getHolderInResidence"
        // get Mobile Alarm No Ack
        var alarmPanelsGetMobileAlarmNoAck = "http://api.gateguard.com.mx/api/AlarmPanels/getMobileAlarmNoAck"
        // mobile Get Events In Residence
        var alarmPanelsMobileGetEventsInResidence = "http://api.gateguard.com.mx/api/AlarmPanels/mobileGetEventsInResidence"
        // get Cameras
        var alarmPanelsGetCameras = "http://api.gateguard.com.mx/api/AlarmPanels/getCameras"

// MARK: - Mi Casa

    // Paneles de Alarma


    // Servidores de Video


    // Mis Vehículos
        // check Plate
        var vehiclesCheckPlate = "http://api.gateguard.com.mx/api/Vehicles/checkPlate"
        // save Images
        var vehiclesSaveImages = "http://api.gateguard.com.mx/api/Vehicles/saveImages"
        // get Readers In Suburb
        var vehiclesGetReadersInSuburb = "http://api.gateguard.com.mx/api/Vehicles/getReadersInSuburb"
        // set Reader
        var vehiclesSetReader = "http://api.gateguard.com.mx/api/Vehicles/setReader"
        // delete Reader
        var vehiclesDeleteReader = "http://api.gateguard.com.mx/api/Vehicles/deleteReader"
        // check Access
        var vehiclesCheckAccess = "http://api.gateguard.com.mx/api/Vehicles/checkAccess"
        // check Reset File
        var vehiclesCheckResetFile = "http://api.gateguard.com.mx/api/Vehicles/checkResetFile"
        // update Alive Reader
        var vehiclesUpdateAliveReader = "http://api.gateguard.com.mx/api/Vehicles/updateAliveReader"
        // get My vehicles
        var vehiclesGetMyvehicles = "http://api.gateguard.com.mx/api/Vehicles/getMyvehicles"
        // get Brands
        var vehiclesGetBrands = "http://api.gategurd.com.mx/api/Vehicles/getBrands"
        // save Brands
        var vehiclesSaveBrands = "http://api.gateguard.com.mx/api/Vehicles/saveBrands"
        // delete Brand
        var vehiclesDeleteBrand = "http://api.gateguard.com.mx/api/Vehicles/deleteBrand"
        // check Veicle Plates
        var vehiclesCheckVeiclePlates = "http://api.gateguard.com.mx/api/Vehicles/checkVeiclePlates"
        // save Vehicle
        var vehiclesSaveVehicle = "http://api.gateguard.com.mx/api/Vehicles/saveVehicle"
        // delete Vehicle
        var vehiclesDeleteVehicle = "http://api.gateguard.com.mx/api/Vehicles/deleteVehicle"
        // save Device Gps
        var vehiclesSaveDeviceGps = "http://api.gateguard.com.mx/api/Vehicles/saveDeviceGps"
        // active Gps Vehicle
        var vehiclesActiveGpsVehicle = "http://api.gateguard.com.mx/api/Vehicles/activeGpsVehicle"
        // get Imei
        var vehiclesGetImei = "http://api.gateguard.com.mx/api/Vehicles/getImei"
        // get Ubication
        var vehiclesGetUbication = "http://api.gateguard.com.mx/api/Vehicles/getUbication"

    // Telemetría
        // get Telemetry Devices
        var telemetryGetTelemetryDevices = "http://api.gateguard.com.mx/api/Telemetry/getTelemetryDevices"

    // Automatización
        // get My Devices
        var homeAutomationGetMyDevices = "http://api.gateguard.com.mx/api/HomeAutomation/getMyDevices"
        // get Device Functions
        var homeAutomationGetDeviceFunctions = "http://api.gateguard.com.mx/api/HomeAutomation/getDeviceFunctions"
        // save Function
        var homeAutomationSaveFunction = "http://api.gateguard.com.mx/api/HomeAutomation/saveFunction"
        // run Function
        var homeAutomationRunFunction = "http://api.gateguard.com.mx/api/HomeAutomation/runFunction"
        // add Funcion
        var homeAutomationAddFuncion = "http://api.gateguard.com.mx/api/HomeAutomation/addFuncion"
        // update Function
        var homeAutomationUpdateFunction = "http://api.gateguard.com.mx/api/HomeAutomation/updateFunction"
        // delete Function
        var homeAutomationDeleteFunction = "http://api.gateguard.com.mx/api/HomeAutomation/deleteFunction"

// MARK: - Control de Acceso

    // Monitor de Acceso
        // get Access Record
        var accessGetAccessRecord = "http://api.gateguard.com.mx/api/Access/getAccessRecord"

    // Registro de Visitas (Vehiculos y Peatones)
        // get Residences In Suburb
        var visitorsGetResidencesInSuburb = "http://api.gateguard.com.mx/api/Visitors/getResidencesInSuburb"
        // get Users In Residence
        var visitorsGetUsersInResidence = "http://api.gateguardcom.mx/api/Visitors/getUsersInResidence"
        // get Holder In Residence
        var visitorsGetHolderInResidence = "http://api.gateguard.com.mx/api/Visitors/getHolderInResidence"
        // get Accounts In Residence
        var visitorsGetAccountsInResidence = "http://api.gateguard.com.mx/api/Visitors/getAccountsInResidence"
        // get Documents Types
        var visitorsGetDocumentsTypes = "http://api.gateguard.com.mx/api/Visitors/getDocumentsTypes"
        // get Plate Info
        var visitorsGetPlateInfo = "http://api.gateguard.com.mx/api/Visitors/getPlateInfo"
        // get Vehicle Relation In Suburb
        var visitorsGetVehicleRelationInSuburb = "http://api.gateguard.com.mx/api/Visitors/getVehicleRelationInSuburb"
        // get Vehicle Access Log
        var visitorsGetVehicleAccessLog = "http://api.gateguard.com.mx/api/Visitors/getVehicleAccessLog"
        // get Resident Account
        var visitorsGetResidentAccount = "http://api.gateguard.com.mx/api/Visitors/getResidentAccount"
        // get Visitor Account
        var visitorsGetVisitorAccount = "http://api.gateguard.com.mx/api/Visitors/getVisitorAccount"
        // get Visitors Doors
        var visitorsGetVisitorsDoors = "http://api.gateguard.com.mx/api/Visitors/getVisitorsDoors"
        // 

// MARK: - Reportes

    // Reporte de Accesos

// MARK: - configuración de Colonia

    // Residencias

    // Grupo de Residencias

    // Usuarios del Sistema

    // Control de Asistencia

