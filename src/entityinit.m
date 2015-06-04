% /***********************************************************************************
%  * 文 件 名   : entityinit.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年08月25日
%  * 文件描述   : 初始化数据模型
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/08/25	创建该文件
% ***********************************************************************************/
function A=entityinit(A)
% 以下模型来源于http://www.buildingsmart-tech.org/ifc/IFC2x3/TC1/html/
% 以下模型参考于http://www.buildingsmart-tech.org/ifc/IFC2x4/rc4/html/

name={'IfcOrganization'};
para1={{'Id'},{'IfcIdentifier'}};
para2={{'Name'},{'IfcIdentifier'}};
para3={{'Description'},{'IfcIdentifier'}};
para4={{'Roles'},{'IfcIdentifier'}};
para5={{'Addresses'},{'IfcIdentifier'}};
param={para1,para2,para3,para4,para4};
A{1,1}=name;
A{1,2}=param;

name={'IfcApplication'};
para1={{'ApplicationDeveloper'},{'IfcIdentifier'}};
para2={{'Version'},{'IfcIdentifier'}};
para3={{'ApplicationFullName'},{'IfcIdentifier'}};
para4={{'ApplicationIdentifier'},{'IfcIdentifier'}};
param={para1,para2,para3,para4};
A{2,1}=name;
A{2,2}=param;

name={'IfcCartesianPoint'};
para1={{'Coordinates'},{'IfcLengthMeasure','IfcLengthMeasure','IfcLengthMeasure'}};
param={para1};
A{3,1}=name;
A{3,2}=param;

name={'IfcDirection'};
para1={{'DirectionRatios'},{'double-wrapper','double-wrapper','double-wrapper'}};
param={para1};
A{4,1}=name;
A{4,2}=param;

name={'IfcSIUnit'};
para1={{'Dimensions'},{'IfcDimensionsForSiUnit'}};
para2={{'UnitType'},{'IfcUnitEnum'}};
para3={{'Prefix'},{'IfcSIPrefix'}};
para4={{'Name'},{'IfcSIUnitName'}};
param={para1,para2,para3,para4};
A{5,1}=name;
A{5,2}=param;

name={'IfcDimensionalExponents'};
para1={{'LengthExponent'},{'INTEGER'}};
para2={{'MassExponent'},{'INTEGER'}};
para3={{'TimeExponent'},{'INTEGER'}};
para4={{'ElectricCurrentExponent'},{'INTEGER'}};
para5={{'ThermodynamicTemperatureExponent'},{'INTEGER'}};
para6={{'AmountOfSubstanceExponent'},{'INTEGER'}};
para7={{'LuminousIntensityExponent'},{'INTEGER'}};
param={para1,para2,para3,para4,para5,para6,para7};
A{6,1}=name;
A{6,2}=param;

name={'IfcMeasureWithUnit'};
para1={{'ValueComponent'},{'IfcValue'}};
para2={{'UnitComponent'},{'IfcUnit'}};
param={para1,para2};
A{7,1}=name;
A{7,2}=param;

name={'IfcConversionBasedUnit'};
para1={{'Dimensions'},{'IfcDimensionalExponents'}};
para2={{'UnitType'},{'IfcUnitEnum'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'ConversionFactor'},{'IfcMeasureWithUnit'}};
param={para1,para2,para3,para4};
A{8,1}=name;
A{8,2}=param;

name={'IfcUnitAssignment'};
para1={{'Units'},{'IfcUnit'}};
param={para1};
A{9,1}=name;
A{9,2}=param;

name={'IfcAxis2Placement3D'};
para1={{'Location'},{'IfcCartesianPoint'}};
para2={{'Axis'},{'IfcDirection'}};
para3={{'RefDirection'},{'IfcDirection'}};
param={para1,para2,para3};
A{10,1}=name;
A{10,2}=param;

name={'IfcLocalPlacement'};
para1={{'PlacementRelTo'},{'IfcObjectPlacement'}};
para2={{'RelativePlacement'},{'IfcAxis2Placement'}};
param={para1,para2};
A{11,1}=name;
A{11,2}=param;

name={'IfcGeometricRepresentationContext'};
para1={{'ContextIdentifier'},{'IfcLabel'}};
para2={{'ContextType'},{'IfcLabel'}};
para3={{'CoordinateSpaceDimension'},{'IfcDimensionCount'}};
para4={{'Precision'},{'REAL'}};
para5={{'WorldCoordinateSystem'},{'IfcAxis2Placement'}};
para6={{'TrueNorth'},{'IfcDirection'}};
param={para1,para2,para3,para4,para5,para6};
A{12,1}=name;
A{12,2}=param;

name={'IfcGeometricRepresentationSubContext'};
para1={{'ContextIdentifier'},{'IfcLabel'}};
para2={{'ContextType'},{'IfcLabel'}};
para3={{'ParentContext'},{'IfcGeometricRepresentationContext'}};
para4={{'TargetScale'},{'IfcPositiveRatioMeasure'}};
para5={{'TargetView'},{'IfcGeometricProjectionEnum'}};
para6={{'UserDefinedTargetView'},{'IfcLabel'}};
para7={{'WorldCoordinateSystem'},{'IfcValue'}};
% para8={{'SELF\IfcGeometricRepresentationContext.CoordinateSpaceDimension'},{'IfcUnit'}};
% para9={{'SELF\IfcGeometricRepresentationContext.TrueNorth'},{'IfcValue'}};
% para10={{'SELF\IfcGeometricRepresentationContext.Precision'},{'IfcUnit'}};
para8={{'CoordinateSpaceDimension'},{'IfcUnit'}};
para9={{'TrueNorth'},{'IfcValue'}};
para10={{'Precision'},{'IfcUnit'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9,para10};
A{13,1}=name;
A{13,2}=param;

name={'IfcPerson'};
para1={{'Id'},{'OPTIONAL IfcIdentifier'}};
para2={{'FamilyName'},{'IfcLabel'}};
para3={{'GivenName'},{'IfcLabel'}};
para4={{'MiddleNames'},{'IfcLabel'}};
para5={{'PrefixTitles'},{'IfcLabel'}};
para6={{'SuffixTitles'},{'IfcLabel'}};
para7={{'Roles'},{'IfcActorRole'}};
para8={{'Addresses'},{'IfcAddress'}};
param={para1,para2,para3,para4,para5,para6,para7,para8};
A{14,1}=name;
A{14,2}=param;

name={'IfcPersonAndOrganization'};
para1={{'ThePerson'},{'IfcPerson'}};
para2={{'TheOrganization'},{'IfcOrganization'}};
para3={{'Roles'},{'IfcActorRole'}};
param={para1,para2,para3};
A{15,1}=name;
A{15,2}=param;

name={'IfcOwnerHistory'};
para1={{'OwningUser'},{'IfcPersonAndOrganization'}};
para2={{'OwningApplication'},{'IfcApplication'}};
para3={{'State'},{'OPTIONAL IfcStateEnum'}};
para4={{'ChangeAction'},{'IfcChangeActionEnum'}};
para5={{'LastModifiedDate'},{'IfcTimeStamp'}};
para6={{'LastModifyingUser'},{'IfcPersonAndOrganization'}};
para7={{'LastModifyingApplication'},{'IfcApplication'}};
para8={{'CreationDate'},{'IfcTimeStamp'}};
param={para1,para2,para3,para4,para5,para6,para7,para8};
A{16,1}=name;
A{16,2}=param;

name={'IfcProject'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'OPTIONAL IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ObjectType'},{'IfcLabel'}};
para6={{'LongName'},{'IfcLabel'}};
para7={{'Phase'},{'IfcLabel'}};
para8={{'RepresentationContexts'},{'IfcRepresentationContext'}};
para9={{'UnitsInContext'},{'IfcUnitAssignment'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9};
A{17,1}=name;
A{17,2}=param;

name={'IfcPostalAddress'};
para1={{'Purpose'},{'IfcAddressTypeEnum'}};
para2={{'Description'},{'IfcText'}};
para3={{'UserDefinedPurpose'},{'IfcLabel'}};
para4={{'InternalLocation'},{'IfcLabel'}};
para5={{'AddressLines'},{'IfcLabel'}};
para6={{'PostalBox'},{'IfcLabel'}};
para7={{'Town'},{'IfcLabel'}};
para8={{'Region'},{'IfcLabel'}};
para9={{'PostalCode'},{'IfcLabel'}};
para10={{'Country'},{'IfcLabel'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9,para10};
A{18,1}=name;
A{18,2}=param;

name={'IfcBuilding'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ObjectType'},{'IfcLabel'}};
para6={{'ObjectPlacement'},{'IfcObjectPlacement'}};
para7={{'Representation'},{'IfcProductRepresentation'}};
para8={{'LongName'},{'IfcLabel'}};
para9={{'CompositionType'},{'IfcElementCompositionEnum'}};
para10={{'ElevationOfRefHeight'},{'IfcLengthMeasure'}};
para11={{'ElevationOfTerrain'},{'IfcLengthMeasure'}};
para12={{'BuildingAddress'},{'IfcPostalAddress'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9,para10,para11,para12};
A{19,1}=name;
A{19,2}=param;

name={'IfcBuildingStorey'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'OPTIONAL IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ObjectType'},{'IfcLabel'}};
para6={{'ObjectPlacement'},{'IfcObjectPlacement'}};
para7={{'Representation'},{'IfcProductRepresentation'}};
para8={{'LongName'},{'IfcLabel'}};
para9={{'CompositionType'},{'IfcElementCompositionEnum'}};
para10={{'Elevation'},{'IfcLengthMeasure'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9,para10};
A{20,1}=name;
A{20,2}=param;

name={'IfcRelDefinesByProperties'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'RelatedObjects'},{'IfcObject'}};
para6={{'RelatingPropertyDefinition'},{'IfcPropertySetDefinition'}};
param={para1,para2,para3,para4,para5,para6};
A{21,1}=name;
A{21,2}=param;

name={'IfcRelContainedInSpatialStructure'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'RelatedElements'},{'IfcProduct'}};
para6={{'RelatingStructure'},{'IfcSpatialStructureElement'}};
param={para1,para2,para3,para4,para5,para6};
A{22,1}=name;
A{22,2}=param;

name={'IfcAxis2Placement2D'};
para1={{'Location'},{'IfcCartesianPoint'}};
para2={{'RefDirection'},{'IfcDirection'}};
param={para1,para2};
A{23,1}=name;
A{23,2}=param;

name={'IfcRectangleProfileDef'};
para1={{'ProfileType'},{'IfcProfileTypeEnum'}};
para2={{'ProfileName'},{'IfcLabel'}};
para3={{'Position'},{'IfcAxis2Placement2D'}};
para4={{'XDim'},{'IfcPositiveLengthMeasure'}};
para5={{'YDim'},{'IfcPositiveLengthMeasure'}};
param={para1,para2,para3,para4,para5};
A{24,1}=name;
A{24,2}=param;

name={'IfcExtrudedAreaSolid'};
para1={{'SweptArea'},{'IfcProfileDef'}};
para2={{'Position'},{'IfcAxis2Placement3D'}};
para3={{'ExtrudedDirection'},{'IfcDirection'}};
para4={{'Depth'},{'IfcPositiveLengthMeasure'}};
param={para1,para2,para3,para4};
A{25,1}=name;
A{25,2}=param;

name={'IfcColourRgb'};
para1={{'Name'},{'IfcLabel'}};
para2={{'Red'},{'IfcNormalisedRatioMeasure'}};
para3={{'Green'},{'IfcNormalisedRatioMeasure'}};
para4={{'Blue'},{'IfcNormalisedRatioMeasure'}};
param={para1,para2,para3,para4};
A{26,1}=name;
A{26,2}=param;

name={'IfcSurfaceStyleRendering'};
para1={{'SurfaceColour'},{'IfcColourRgb'}};
para2={{'Transparency'},{'IfcNormalisedRatioMeasure'}};
para3={{'DiffuseColour'},{'IfcColourOrFactor'}};
para4={{'TransmissionColour'},{'IfcColourOrFactor'}};
para5={{'DiffuseTransmissionColour'},{'IfcColourOrFactor'}};
para6={{'ReflectionColour'},{'IfcColourOrFactor'}};
para7={{'SpecularColour'},{'IfcColourOrFactor'}};
para8={{'SpecularHighlight'},{'IfcSpecularHighlightSelect'}};
para9={{'ReflectanceMethod'},{'IfcReflectanceMethodEnum'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9};
A{27,1}=name;
A{27,2}=param;

name={'IfcSurfaceStyle'};
para1={{'Name'},{'IfcLabel'}};
para2={{'Side'},{'IfcSurfaceSide'}};
para3={{'Styles'},{'IfcSurfaceStyleElementSelect'}};
param={para1,para2,para3};
A{28,1}=name;
A{28,2}=param;

name={'IfcPresentationStyleAssignment'};
para1={{'Styles'},{'IfcPresentationStyleSelect'}};
param={para1};
A{29,1}=name;
A{29,2}=param;

name={'IfcStyledItem'};
para1={{'Item'},{'IfcRepresentationItem'}};
para2={{'Styles'},{'IfcPresentationStyleAssignment'}};
para3={{'Name'},{'IfcLabel'}};
param={para1,para2,para3};
A{30,1}=name;
A{30,2}=param;

name={'IfcShapeRepresentation'};
para1={{'ContextOfItems'},{'IfcRepresentationContext'}};
para2={{'RepresentationIdentifier'},{'IfcLabel'}};
para3={{'RepresentationType'},{'IfcLabel'}};
para4={{'Items'},{'IfcRepresentationItem'}};
param={para1,para2,para3,para4};
A{31,1}=name;
A{31,2}=param;    

name={'IfcPolyline'};
para1={{'Points'},{'IfcCartesianPoint','IfcCartesianPoint'}};
param={para1};
A{32,1}=name;
A{32,2}=param;

name={'IfcProductDefinitionShape'};
para1={{'Name'},{'IfcLabel'}};
para2={{'Description'},{'IfcText'}};
para3={{'Representations'},{'IfcRepresentation'}};
param={para1,para2,para3};
A{33,1}=name;
A{33,2}=param;

name={'IfcBeam'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ObjectType'},{'IfcLabel'}};
para6={{'ObjectPlacement'},{'IfcObjectPlacement'}};
para7={{'Representation'},{'IfcProductRepresentation'}};
para8={{'Tag'},{'IfcIdentifier'}};
param={para1,para2,para3,para4,para5,para6,para7,para8};
A{34,1}=name;
A{34,2}=param;

name={'IfcMaterial'};
para1={{'Name'},{'IfcLabel'}};
param={para1};
A{35,1}=name;
A{35,2}=param;

name={'IfcCurveStyleFontPattern'};
para1={{'VisibleSegmentLength'},{'IfcLengthMeasure'}};
para2={{'InvisibleSegmentLength'},{'IfcPositiveLengthMeasure'}};
param={para1,para2};
A{36,1}=name;
A{36,2}=param;

name={'IfcCurveStyleFont'};
para1={{'Name'},{'IfcLabel'}};
para2={{'PatternList'},{'IfcCurveStyleFontPattern'}};
param={para1,para2};
A{37,1}=name;
A{37,2}=param;

name={'IfcCurveStyle'};
para1={{'Name'},{'IfcLabel'}};
para2={{'CurveFont'},{'IfcCurveFontOrScaledCurveFontSelect'}};
para3={{'CurveWidth'},{'IfcSizeSelect'}};
para4={{'CurveColour'},{'IfcColour'}};
param={para1,para2,para3,para4};
A{38,1}=name;
A{38,2}=param;

name={'IfcFillAreaStyleHatching'};
para1={{'HatchLineAppearance'},{'IfcCurveStyle'}};
para2={{'StartOfNextHatchLine'},{'IfcHatchLineDistanceSelect'}};
para3={{'PointOfReferenceHatchLine'},{'IfcCartesianPoint'}};
para4={{'PatternStart'},{'IfcCartesianPoint'}};
para5={{'HatchLineAngle'},{'IfcPlaneAngleMeasure'}};
param={para1,para2,para3,para4,para5};
A{39,1}=name;
A{39,2}=param;

name={'IfcFillAreaStyle'};
para1={{'Name'},{'IfcLabel'}};
para2={{'FillStyles'},{'IfcFillStyleSelect'}};
param={para1,para2};
A{40,1}=name;
A{40,2}=param;

name={'IfcStyledRepresentation'};
para1={{'ContextOfItems'},{'IfcRepresentationContext'}};
para2={{'RepresentationIdentifier'},{'IfcLabel'}};
para3={{'RepresentationType'},{'IfcLabel'}};
para4={{'Items'},{'IfcRepresentationItem'}};
param={para1,para2,para3,para4};
A{41,1}=name;
A{41,2}=param;

name={'IfcMaterialDefinitionRepresentation'};
para1={{'Name'},{'IfcLabel'}};
para2={{'Description'},{'IfcText'}};
para3={{'Representations'},{'IfcRepresentation'}};
para4={{'RepresentedMaterial'},{'IfcMaterial'}};
param={para1,para2,para3,para4};
A{42,1}=name;
A{42,2}=param;

name={'IfcPropertySingleValue'};
para1={{'Name'},{'IfcLabel'}};
para2={{'Description'},{'IfcText'}};
para3={{'NominalValue'},{'IfcValue'}};
para4={{'Unit'},{'IfcUnit'}};
param={para1,para2,para3,para4};
A{43,1}=name;
A{43,2}=param;

name={'IfcPropertySet'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'HasProperties'},{'IfcProperty'}};
param={para1,para2,para3,para4,para5};
A{44,1}=name;
A{44,2}=param;

name={'IfcRelAggregates'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'RelatingObject'},{'IfcObjectDefinition'}};
para6={{'RelatedObjects'},{'IfcObjectDefinition'}};
param={para1,para2,para3,para4,para5,para6};
A{45,1}=name;
A{45,2}=param;

name={'IfcRelAssociatesMaterial'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'RelatedObjects'},{'IfcRoot'}};
para6={{'RelatingMaterial'},{'IfcMaterialSelect'}};
param={para1,para2,para3,para4,para5,para6};
A{46,1}=name;
A{46,2}=param;

name={'IfcPresentationLayerAssignment'};
para1={{'Name'},{'IfcLabel'}};
para2={{'Description'},{'IfcText'}};
para3={{'AssignedItems'},{'IfcLayeredItem'}};
para4={{'Identifier'},{'IfcIdentifier'}};
param={para1,para2,para3,para4};
A{47,1}=name;
A{47,2}=param;

name={'IfcSite'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ObjectType'},{'IfcLabel'}};
para6={{'ObjectPlacement'},{'IfcObjectPlacement'}};
para7={{'Representation'},{'IfcProductRepresentation'}};
para8={{'LongName'},{'IfcLabel'}};
para9={{'CompositionType'},{'IfcElementCompositionEnum'}};
para10={{'RefLatitude'},{'IfcCompoundPlaneAngleMeasure'}};
para11={{'RefLongitude'},{'IfcCompoundPlaneAngleMeasure'}};
para12={{'RefElevation'},{'IfcLengthMeasure'}};
para13={{'LandTitleNumber'},{'IfcLabel'}};
para14={{'SiteAddress'},{'IfcPostalAddress'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9,para10,para11,para12,para13,para14};
A{48,1}=name;
A{48,2}=param;

name={'IfcRepresentationMap'};
para1={{'MappingOrigin'},{'IfcAxis2Placement'}};
para2={{'MappedRepresentation'},{'IfcRepresentation'}};
param={para1,para2};
A{49,1}=name;
A{49,2}=param;

name={'IfcColumnType'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ApplicableOccurrence'},{'IfcLabel'}};
para6={{'HasPropertySets'},{'IfcPropertySetDefinition'}};
para7={{'Representation'},{'IfcRepresentationMap'}};
para8={{'Tag'},{'IfcLabel'}};
para9={{'ElementType'},{'IfcLabel'}};
para10={{'PredefinedType'},{'IfcColumnTypeEnum'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9,para10};
A{50,1}=name;
A{50,2}=param;

name={'IfcClassification'};
para1={{'Source'},{'IfcLabel'}};
para2={{'Edition'},{'IfcLabel'}};
para3={{'EditionDate'},{'IfcCalendarDate'}};
para4={{'Name'},{'IfcLabel'}};
param={para1,para2,para3,para4};
A{51,1}=name;
A{51,2}=param;

name={'IfcClassificationReference'};
para1={{'Location'},{'IfcLabel'}};
para2={{'ItemReference'},{'IfcIdentifier'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'ReferencedSource'},{'IfcClassification'}};
param={para1,para2,para3,para4};
A{52,1}=name;
A{52,2}=param;

name={'IfcRelAssociatesClassification'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'RelatedObjects'},{'IfcRoot'}};
para6={{'RelatingClassification'},{'IfcClassificationNotationSelect'}};
param={para1,para2,para3,para4,para5,para6};
A{53,1}=name;
A{53,2}=param;

name={'IfcColumn'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ObjectType'},{'IfcLabel'}};
para6={{'ObjectPlacement'},{'IfcObjectPlacement'}};
para7={{'Representation'},{'IfcProductRepresentation'}};
para8={{'Tag'},{'IfcIdentifier'}};
param={para1,para2,para3,para4,para5,para6,para7,para8};
A{54,1}=name;
A{54,2}=param;

name={'IfcFace'};
para1={{'Bounds'},{'IfcFaceBound'}};
param={para1};
A{55,1}=name;
A{55,2}=param;

name={'IfcFaceOuterBound'};
para1={{'Bound'},{'IfcLoop'}};
para2={{'Orientation'},{'BOOLEAN'}};
param={para1,para2};
A{56,1}=name;
A{56,2}=param;

name={'IfcPolyLoop'};
para1={{'Polygon'},{'IfcCartesianPoint'}};
param={para1};
A{57,1}=name;
A{57,2}=param;

name={'IfcClosedShell'};
para1={{'CfsFaces'},{'IfcFace'}};
param={para1};
A{58,1}=name;
A{58,2}=param;

name={'IfcFacetedBrep'};
para1={{'Outer'},{'IfcClosedShell'}};
param={para1};
A{59,1}=name;
A{59,2}=param;

name={'IfcWallStandardCase'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ObjectType'},{'IfcLabel'}};
para6={{'ObjectPlacement'},{'IfcObjectPlacement'}};
para7={{'Representation'},{'IfcProductRepresentation'}};
para8={{'Tag'},{'IfcIdentifier'}};
param={para1,para2,para3,para4,para5,para6,para7,para8};
A{60,1}=name;
A{60,2}=param;

name={'IfcMappedItem'};
para1={{'MappingSource'},{'IfcRepresentationMap'}};
para2={{'MappingTarget'},{'IfcCartesianTransformationOperator'}};
param={para1,para2};
A{61,1}=name;
A{61,2}=param;

name={'IfcMaterialLayer'};
para1={{'Material'},{'IfcMaterial'}};
para2={{'LayerThickness'},{'IfcPositiveLengthMeasure'}};
para3={{'IsVentilated'},{'IfcLogical'}};
param={para1,para2,para3};
A{62,1}=name;
A{62,2}=param;

name={'IfcRelDefinesByType'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'RelatedObjects'},{'IfcObject'}};
para6={{'RelatingType'},{'IfcTypeObject'}};
param={para1,para2,para3,para4,para5,para6};
A{63,1}=name;
A{63,2}=param;

name={'IfcCartesianTransformationOperator3D'};
para1={{'Axis1'},{'IfcDirection'}};
para2={{'Axis2'},{'IfcDirection'}};
para3={{'LocalOrigin'},{'IfcCartesianPoint'}};
para4={{'Scale'},{'REAL'}};
para5={{'Axis3'},{'IfcDirection'}};
param={para1,para2,para3,para4,para5};
A{64,1}=name;
A{64,2}=param;

name={'IfcMaterialLayerSet'};
para1={{'MaterialLayers'},{'IfcMaterialLayer'}};
para2={{'LayerSetName'},{'IfcLabel'}};
param={para1,para2};
A{65,1}=name;
A{65,2}=param;

name={'IfcMaterialLayerSetUsage'};
para1={{'ForLayerSet'},{'IfcMaterialLayerSet'}};
para2={{'LayerSetDirection'},{'IfcLayerSetDirectionEnum'}};
para3={{'DirectionSense'},{'IfcDirectionSenseEnum'}};
para4={{'OffsetFromReferenceLine'},{'IfcLengthMeasure'}};
param={para1,para2,para3,para4};
A{66,1}=name;
A{66,2}=param;

name={'IfcBeamType'};
para1={{'GlobalId'},{'IfcGloballyUniqueId'}};
para2={{'OwnerHistory'},{'IfcOwnerHistory'}};
para3={{'Name'},{'IfcLabel'}};
para4={{'Description'},{'IfcText'}};
para5={{'ApplicableOccurrence'},{'IfcLabel'}};
para6={{'HasPropertySets'},{'IfcPropertySetDefinition'}};
para7={{'RepresentationMaps'},{'IfcRepresentationMap'}};
para8={{'Tag'},{'IfcLabel'}};
para9={{'ElementType'},{'IfcLabel'}};
para10={{'PredefinedType'},{'IfcBeamTypeEnum'}};
param={para1,para2,para3,para4,para5,para6,para7,para8,para9,para10};
A{67,1}=name;
A{67,2}=param;

name={'IfcComplexProperty'};
para1={{'Name'},{'IfcIdentifier'}};
para2={{'Description'},{'IfcText'}};
para3={{'UsageName'},{'IfcIdentifier'}};
para4={{'HasProperties'},{'IfcProperty'}};
param={para1,para2,para3,para4};
A{68,1}=name;
A{68,2}=param;

name={'IfcConnectedFaceSet'};
para1={{'CfsFaces'},{'IfcFace'}};
param={para1};
A{69,1}=name;
A{69,2}=param;

name={'IfcFaceBasedSurfaceModel'};
para1={{'FbsmFaces'},{'IfcConnectedFaceSet'}};
param={para1};
A{70,1}=name;
A{70,2}=param;