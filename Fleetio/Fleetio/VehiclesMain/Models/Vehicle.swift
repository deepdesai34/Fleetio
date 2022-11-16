//
//  Vehicle.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-14.
//

import Foundation

// MARK: - VehicleElement
class Vehicle: Codable {
    let id, accountID: Double?
    let archivedAt: Date?
    let fuelTypeID: Double?
    let fuelTypeName: String?
    let fuelVolumeUnits: String?
    let groupID: Double?
    let groupName: String?
    let meterUnit: String?
    let name: String?
    let ownership: String?
    let secondaryMeter: Bool?
    let secondaryMeterUnit: String?
    let systemOfMeasurement: String?
    let vehicleStatusID: Double?
    let vehicleStatusName: String?
    let vehicleStatusColor: String?
    let vehicleTypeID: Double?
    let vehicleTypeName: String?
    let fuelEntriesCount, serviceEntriesCount, serviceRemindersCount, vehicleRenewalRemindersCount: Double?
    let commentsCount, documentsCount, imagesCount: Double?
    let currentLocationEntryID: Double?
    let isSample: Bool?
    let inServiceDate: String?
    let inServiceMeter, estimatedServiceMonths, estimatedReplacementMileage: Double?
    let estimatedResalePrice: EstimatedResalePrice?
    let outOfServiceDate: String?
    let outOfServiceMeter: Double?
    let meterName: String?
    let secondaryMeterName: SecondaryMeterName
    let primaryMeterUsagePerDay, secondaryMeterUsagePerDay: String?
    let createdAt, updatedAt: String?
    let currentMeterValue: Double?
    let currentMeterDate: String?
    let secondaryMeterValue: Double?
    let secondaryMeterDate: String?
    let groupAncestry: String?
    let color, licensePlate, make, model: String?
    let registrationExpirationMonth: Double?
    let registrationState, trim, vin: String?
    let year: Double?
    let loanAccountNumber, loanEndedAt: String?
    let loanInterestRate: Double?
    let loanNotes, loanStartedAt: String?
    let loanVendorID: Double?
    let loanVendorName: String?
    let customFields: CustomFields?
    let inspectionSchedulesCount, issuesCount, workOrdersCount: Double?
    let typeName: String?
    let defaultImageURL, defaultImageURLMedium, defaultImageURLSmall, defaultImageURLLarge: String?
    let driver: Driver?
    let specs: Specs?
    let externalIDS: ExternalIDS?
    let aiEnabled: Bool?
    let assetableType: String?
    let currentLocationEntry: CurrentLocationEntry?
    let loanAmount, loanPayment: Double?
    let residualValue: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "account_id"
        case archivedAt = "archived_at"
        case fuelTypeID = "fuel_type_id"
        case fuelTypeName = "fuel_type_name"
        case fuelVolumeUnits = "fuel_volume_units"
        case groupID = "group_id"
        case groupName = "group_name"
        case meterUnit = "meter_unit"
        case name, ownership
        case secondaryMeter = "secondary_meter"
        case secondaryMeterUnit = "secondary_meter_unit"
        case systemOfMeasurement = "system_of_measurement"
        case vehicleStatusID = "vehicle_status_id"
        case vehicleStatusName = "vehicle_status_name"
        case vehicleStatusColor = "vehicle_status_color"
        case vehicleTypeID = "vehicle_type_id"
        case vehicleTypeName = "vehicle_type_name"
        case fuelEntriesCount = "fuel_entries_count"
        case serviceEntriesCount = "service_entries_count"
        case serviceRemindersCount = "service_reminders_count"
        case vehicleRenewalRemindersCount = "vehicle_renewal_reminders_count"
        case commentsCount = "comments_count"
        case documentsCount = "documents_count"
        case imagesCount = "images_count"
        case currentLocationEntryID = "current_location_entry_id"
        case isSample = "is_sample"
        case inServiceDate = "in_service_date"
        case inServiceMeter = "in_service_meter"
        case estimatedServiceMonths = "estimated_service_months"
        case estimatedReplacementMileage = "estimated_replacement_mileage"
        case estimatedResalePrice = "estimated_resale_price"
        case outOfServiceDate = "out_of_service_date"
        case outOfServiceMeter = "out_of_service_meter"
        case meterName = "meter_name"
        case secondaryMeterName = "secondary_meter_name"
        case primaryMeterUsagePerDay = "primary_meter_usage_per_day"
        case secondaryMeterUsagePerDay = "secondary_meter_usage_per_day"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case currentMeterValue = "current_meter_value"
        case currentMeterDate = "current_meter_date"
        case secondaryMeterValue = "secondary_meter_value"
        case secondaryMeterDate = "secondary_meter_date"
        case groupAncestry = "group_ancestry"
        case color
        case licensePlate = "license_plate"
        case make, model
        case registrationExpirationMonth = "registration_expiration_month"
        case registrationState = "registration_state"
        case trim, vin, year
        case loanAccountNumber = "loan_account_number"
        case loanEndedAt = "loan_ended_at"
        case loanInterestRate = "loan_interest_rate"
        case loanNotes = "loan_notes"
        case loanStartedAt = "loan_started_at"
        case loanVendorID = "loan_vendor_id"
        case loanVendorName = "loan_vendor_name"
        case customFields = "custom_fields"
        case inspectionSchedulesCount = "inspection_schedules_count"
        case issuesCount = "issues_count"
        case workOrdersCount = "work_orders_count"
        case typeName = "type_name"
        case defaultImageURL = "default_image_url"
        case defaultImageURLMedium = "default_image_url_medium"
        case defaultImageURLSmall = "default_image_url_small"
        case defaultImageURLLarge = "default_image_url_large"
        case driver, specs
        case externalIDS = "external_ids"
        case aiEnabled = "ai_enabled"
        case assetableType = "assetable_type"
        case currentLocationEntry = "current_location_entry"
        case loanAmount = "loan_amount"
        case loanPayment = "loan_payment"
        case residualValue = "residual_value"
    }
}

// MARK: - CurrentLocationEntry
struct CurrentLocationEntry: Codable {
    let id: Double?
    let locatableType: LocatableType?
    let locatableID: Double?
    let date, createdAt, updatedAt: String?
    let contactID: Double?
    let address: String?
    let isCurrent: Bool?
    let itemType: String?
    let itemID, vehicleID: Double?
    let location: String?
    let addressComponents: AddressComponents?
    let geolocation: Geolocation?
    
    enum CodingKeys: String, CodingKey {
        case id
        case locatableType = "locatable_type"
        case locatableID = "locatable_id"
        case date
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case contactID = "contact_id"
        case address
        case isCurrent = "is_current"
        case itemType = "item_type"
        case itemID = "item_id"
        case vehicleID = "vehicle_id"
        case location
        case addressComponents = "address_components"
        case geolocation
    }
}

// MARK: - AddressComponents
struct AddressComponents: Codable {
    let streetNumber, street, city, region: String?
    let regionShort: String?
    let country: String?
    let countryShort: String?
    let postalCode: String?
    
    enum CodingKeys: String, CodingKey {
        case streetNumber = "street_number"
        case street, city, region
        case regionShort = "region_short"
        case country
        case countryShort = "country_short"
        case postalCode = "postal_code"
    }
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let latitude, longitude: Double
}

enum LocatableType: String, Codable {
    case fuelEntry = "FuelEntry"
    case serviceEntry = "ServiceEntry"
    case submittedInspectionForm = "SubmittedInspectionForm"
}

// MARK: - CustomFields
struct CustomFields: Codable {
    let telematicsSubscription: TelematicsSubscription?
    let restrict, warrantyExpiration, warrantyType: String?
    let tollPassNumber: String?
    let rearCameraEnabled: String?
    let vehicleCleanliness: String?
    let test: String?
    let checkboxFilterTest, manufacturerModel: String?
    let extraRextraReadAllAboutItThisIsASuperLongFieldNameMyGuyyy: String?
    
    enum CodingKeys: String, CodingKey {
        case telematicsSubscription = "telematics_subscription"
        case restrict
        case warrantyExpiration = "warranty_expiration"
        case warrantyType = "warranty_type"
        case tollPassNumber = "toll_pass_number"
        case rearCameraEnabled = "rear_camera_enabled"
        case vehicleCleanliness = "vehicle_cleanliness"
        case test
        case checkboxFilterTest = "checkbox_filter_test"
        case manufacturerModel = "manufacturer_model"
        case extraRextraReadAllAboutItThisIsASuperLongFieldNameMyGuyyy = "extra_rextra_read_all_about_it_this_is_a_super_long_field_name_my_guyyy"
    }
}

enum TelematicsSubscription: String, Codable {
    case empty = ""
    case subscriptionA = "Subscription A"
    case subscriptionB = "Subscription B"
    case subscriptionC = "Subscription C"
    case subscriptionE = "Subscription E"
}

// MARK: - Driver
struct Driver: Codable {
    let id: Double?
    let firstName: String?
    let lastName: String?
    let fullName: String?
    let defaultImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case defaultImageURL = "default_image_url"
    }
}

// MARK: - EstimatedResalePrice
struct EstimatedResalePrice: Codable {
    let cents: Double?
    let currencyISO: String?
    
    enum CodingKeys: String, CodingKey {
        case cents
        case currencyISO = "currency_iso"
    }
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let clearpathgps, externalFuelID, fuelID, taskCode: String?
    let traxxisID: String?
    
    enum CodingKeys: String, CodingKey {
        case clearpathgps
        case externalFuelID = "external_fuel_id"
        case fuelID = "fuel_id"
        case taskCode = "task_code"
        case traxxisID = "traxxis_id"
    }
}


enum SecondaryMeterName: String, Codable {
    case secondaryMeter = "Secondary Meter"
}

// MARK: - Specs
struct Specs: Codable {
    let engineBoreWithUnits, wheelbaseWithUnits: String?
    let id, vehicleID, accountID: Double?
    let bodyType: String?
    let bodySubtype: String?
    let driveType, brakeSystem: String?
    let msrpCents: Double?
    let fuelTankCapacity, fuelTank2_Capacity, frontTrackWidth, groundClearance: Double?
    let height, length, rearTrackWidth, width: Double?
    let wheelbase: Double?
    let frontTirePsi, rearTirePsi, baseTowingCapacity: Double?
    let curbWeight: Double?
    let grossVehicleWeightRating: Double?
    let bedLength: Double?
    let maxPayload: Double?
    let rearAxleType, frontTireType, frontWheelDiameter, rearTireType: String?
    let rearWheelDiameter: String?
    let epaCity, epaHighway: Double?
    let epaCombined: Double?
    let engineDescription: String?
    let engineBrand: String?
    let engineAspiration: String?
    let engineBlockType: String?
    let engineBore: Double?
    let engineCamType: String?
    let engineCompression: Double?
    let engineCylinders: Double?
    let engineDisplacement: Double?
    let fuelInduction: String?
    let fuelQuality: String?
    let maxHP, maxTorque: Double?
    let oilCapacity: Double?
    let redlineRPM: String?
    let engineStroke: Double?
    let engineValves: Double?
    let transmissionDescription: String?
    let transmissionBrand: String?
    let transmissionType: String?
    let transmissionGears: Double?
    let cargoVolume: Double?
    let interiorVolume: Double?
    let passengerVolume: String?
    let createdAt, updatedAt: String?
    let dutyType, weightClass: String?
    let msrp: Double?
    
    enum CodingKeys: String, CodingKey {
        case engineBoreWithUnits = "engine_bore_with_units"
        case wheelbaseWithUnits = "wheelbase_with_units"
        case id
        case vehicleID = "vehicle_id"
        case accountID = "account_id"
        case bodyType = "body_type"
        case bodySubtype = "body_subtype"
        case driveType = "drive_type"
        case brakeSystem = "brake_system"
        case msrpCents = "msrp_cents"
        case fuelTankCapacity = "fuel_tank_capacity"
        case fuelTank2_Capacity = "fuel_tank_2_capacity"
        case frontTrackWidth = "front_track_width"
        case groundClearance = "ground_clearance"
        case height, length
        case rearTrackWidth = "rear_track_width"
        case width, wheelbase
        case frontTirePsi = "front_tire_psi"
        case rearTirePsi = "rear_tire_psi"
        case baseTowingCapacity = "base_towing_capacity"
        case curbWeight = "curb_weight"
        case grossVehicleWeightRating = "gross_vehicle_weight_rating"
        case bedLength = "bed_length"
        case maxPayload = "max_payload"
        case rearAxleType = "rear_axle_type"
        case frontTireType = "front_tire_type"
        case frontWheelDiameter = "front_wheel_diameter"
        case rearTireType = "rear_tire_type"
        case rearWheelDiameter = "rear_wheel_diameter"
        case epaCity = "epa_city"
        case epaHighway = "epa_highway"
        case epaCombined = "epa_combined"
        case engineDescription = "engine_description"
        case engineBrand = "engine_brand"
        case engineAspiration = "engine_aspiration"
        case engineBlockType = "engine_block_type"
        case engineBore = "engine_bore"
        case engineCamType = "engine_cam_type"
        case engineCompression = "engine_compression"
        case engineCylinders = "engine_cylinders"
        case engineDisplacement = "engine_displacement"
        case fuelInduction = "fuel_induction"
        case fuelQuality = "fuel_quality"
        case maxHP = "max_hp"
        case maxTorque = "max_torque"
        case oilCapacity = "oil_capacity"
        case redlineRPM = "redline_rpm"
        case engineStroke = "engine_stroke"
        case engineValves = "engine_valves"
        case transmissionDescription = "transmission_description"
        case transmissionBrand = "transmission_brand"
        case transmissionType = "transmission_type"
        case transmissionGears = "transmission_gears"
        case cargoVolume = "cargo_volume"
        case interiorVolume = "interior_volume"
        case passengerVolume = "passenger_volume"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case dutyType = "duty_type"
        case weightClass = "weight_class"
        case msrp
    }
}
