//
//  Vehicle.swift
//  Fleetio
//
//  Created by Deep Desai on 2022-11-13.
//

import Foundation


// MARK: - VehicleElement
struct VehicleAssets: Codable {
    let id, accountID: Int
    let archivedAt: Date?
    let fuelTypeID: Int?
    let fuelTypeName: FuelTypeName?
    let fuelVolumeUnits: FuelVolumeUnits
    let groupID: Int
    let groupName: String
    let meterUnit: MeterUnit
    let name: String
    let ownership: Ownership
    let secondaryMeter: Bool
    let secondaryMeterUnit: MeterUnit?
    let systemOfMeasurement: SystemOfMeasurement
    let vehicleStatusID: Int
    let vehicleStatusName: VehicleStatusName
    let vehicleStatusColor: VehicleStatusColor
    let vehicleTypeID: Int
    let vehicleTypeName: String
    let fuelEntriesCount, serviceEntriesCount, serviceRemindersCount, vehicleRenewalRemindersCount: Int
    let commentsCount, documentsCount, imagesCount: Int
    let currentLocationEntryID: Int?
    let isSample: Bool
    let inServiceDate: String?
    let inServiceMeter, estimatedServiceMonths, estimatedReplacementMileage: Int?
    let estimatedResalePrice: EstimatedResalePrice?
    let outOfServiceDate: String?
    let outOfServiceMeter: Int?
    let meterName: MeterName
    let secondaryMeterName: SecondaryMeterName
    let primaryMeterUsagePerDay, secondaryMeterUsagePerDay: String?
    let createdAt, updatedAt: String
    let currentMeterValue: Int
    let currentMeterDate: String?
    let secondaryMeterValue: Double
    let secondaryMeterDate: String?
    let groupAncestry: String
    let color, licensePlate, make, model: String?
    let registrationExpirationMonth: Int
    let registrationState, trim, vin: String?
    let year: Int?
    let loanAccountNumber, loanEndedAt: String?
    let loanInterestRate: Double?
    let loanNotes, loanStartedAt: String?
    let loanVendorID: Int?
    let loanVendorName: String?
    let customFields: CustomFields
    let inspectionSchedulesCount, issuesCount, workOrdersCount: Int
    let typeName: String
    let defaultImageURL, defaultImageURLMedium, defaultImageURLSmall, defaultImageURLLarge: String?
    let driver: Driver
    let specs: Specs
    let externalIDS: ExternalIDS
    let aiEnabled: Bool
    let assetableType: AssetableTypeEnum
    let currentLocationEntry: CurrentLocationEntry
    let loanAmount, loanPayment: Double?
    let residualValue: Int?

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

enum AssetableTypeEnum: String, Codable {
    case vehicle = "Vehicle"
}

// MARK: - CurrentLocationEntry
struct CurrentLocationEntry: Codable {
    let id: Int?
    let locatableType: LocatableType?
    let locatableID: Int?
    let date, createdAt, updatedAt: String?
    let contactID: Int?
    let address: String?
    let isCurrent: Bool?
    let itemType: AssetableTypeEnum?
    let itemID, vehicleID: Int?
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
    let country: Country?
    let countryShort: CountryShort?
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

enum Country: String, Codable {
    case botswana = "Botswana"
    case canada = "Canada"
    case unitedStates = "United States"
}

enum CountryShort: String, Codable {
    case bw = "BW"
    case ca = "CA"
    case us = "US"
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
    let tollPassNumber: TollPassNumber
    let rearCameraEnabled: String
    let vehicleCleanliness: String?
    let test: String
    let checkboxFilterTest, manufacturerModel: String?
    let extraRextraReadAllAboutItThisIsASuperLongFieldNameMyGuyyy: String

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

enum TollPassNumber: String, Codable {
    case asdf = "asdf"
    case empty = ""
    case text = "Text"
    case tollPassNumberText = "text"
}

// MARK: - Driver
struct Driver: Codable {
    let id: Int?
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
    let cents: Int
    let currencyISO: CurrencyISO

    enum CodingKeys: String, CodingKey {
        case cents
        case currencyISO = "currency_iso"
    }
}

enum CurrencyISO: String, Codable {
    case usd = "USD"
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

enum FuelTypeName: String, Codable {
    case aviationFuel = "Aviation Fuel"
    case diesel = "DIESEL"
    case flexFuel = "Flex Fuel"
    case gasoline = "Gasoline"
    case the5HDPropane = "5-HD Propane"
}

enum FuelVolumeUnits: String, Codable {
    case liters = "liters"
    case ukGallons = "uk_gallons"
    case usGallons = "us_gallons"
}

enum MeterName: String, Codable {
    case hourMeter = "Hour Meter"
    case odometer = "Odometer"
}

enum MeterUnit: String, Codable {
    case hr = "hr"
    case km = "km"
    case mi = "mi"
}

enum Ownership: String, Codable {
    case leased = "Leased"
    case owned = "Owned"
}

enum SecondaryMeterName: String, Codable {
    case secondaryMeter = "Secondary Meter"
}

// MARK: - Specs
struct Specs: Codable {
    let engineBoreWithUnits, wheelbaseWithUnits: String?
    let id, vehicleID, accountID: Int?
    let bodyType: String?
    let bodySubtype: BodySubtype?
    let driveType, brakeSystem: String?
    let msrpCents: Int?
    let fuelTankCapacity, fuelTank2_Capacity, frontTrackWidth, groundClearance: Double?
    let height, length, rearTrackWidth, width: Double?
    let wheelbase: Double?
    let frontTirePsi, rearTirePsi, baseTowingCapacity: Int?
    let curbWeight: Double?
    let grossVehicleWeightRating: Int?
    let bedLength: Double?
    let maxPayload: Int?
    let rearAxleType, frontTireType, frontWheelDiameter, rearTireType: String?
    let rearWheelDiameter: String?
    let epaCity, epaHighway: Int?
    let epaCombined: Double?
    let engineDescription: String?
    let engineBrand: EngineBrand?
    let engineAspiration: EngineAspiration?
    let engineBlockType: EngineBlockType?
    let engineBore: Double?
    let engineCamType: EngineCamType?
    let engineCompression: Double?
    let engineCylinders: Int?
    let engineDisplacement: Double?
    let fuelInduction: FuelInduction?
    let fuelQuality: String?
    let maxHP, maxTorque: Int?
    let oilCapacity: Double?
    let redlineRPM: String?
    let engineStroke: Double?
    let engineValves: Int?
    let transmissionDescription: String?
    let transmissionBrand: TransmissionBrand?
    let transmissionType: String?
    let transmissionGears: Int?
    let cargoVolume: Double?
    let interiorVolume: Int?
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

enum BodySubtype: String, Codable {
    case crewCab = "Crew Cab"
    case empty = ""
    case metal = "Metal"
    case passenger = "Passenger"
    case singleCab = "single cab"
}

enum EngineAspiration: String, Codable {
    case empty = ""
    case engineAspirationNATURALLYASPIRATED = "NATURALLY ASPIRATED"
    case naturallyAspirated = "Naturally Aspirated"
    case turbocharger = "Turbocharger"
}

enum EngineBlockType: String, Codable {
    case empty = ""
    case h = "H"
    case i = "I"
    case v = "V"
    case vjjjjj = "Vjjjjj"
}

enum EngineBrand: String, Codable {
    case cummins = "Cummins"
    case duratec = "Duratec"
    case empty = ""
    case honda = "Honda"
    case test = "test"
    case volvo = "Volvo"
    case yamaha = "Yamaha"
}

enum EngineCamType: String, Codable {
    case dohc = "DOHC"
    case empty = ""
    case ohv = "OHV"
    case sohc = "SOHC"
}

enum FuelInduction: String, Codable {
    case directInjection = "Direct Injection"
    case empty = ""
    case fuelInjection = "Fuel Injection"
    case sequentialMultiportFuelInjection = "Sequential Multiport Fuel Injection"
}

enum TransmissionBrand: String, Codable {
    case bbb = "BBB"
    case empty = ""
    case ford = "Ford"
}

enum SystemOfMeasurement: String, Codable {
    case imperial = "imperial"
    case metric = "metric"
}

enum VehicleStatusColor: String, Codable {
    case black = "black"
    case blue = "blue"
    case gray = "gray"
    case maroon = "maroon"
    case orange = "orange"
}

enum VehicleStatusName: String, Codable {
    case active = "Active"
    case inShop = "In Shop"
    case inactive = "Inactive"
    case outOfService = "Out of Service"
    case rented = "Rented"
    case sold = "Sold"
}
