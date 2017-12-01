# -*- coding: utf-8 -*-

# Copyright (C) 2016 Ross Scroggs All Rights Reserved.
#
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

"""GAM GAPI resources

"""
# callGAPI throw reasons
ABORTED = u'aborted'
ALREADY_EXISTS = u'alreadyExists'
AUTH_ERROR = u'authError'
BACKEND_ERROR = u'backendError'
BAD_GATEWAY = u'badGateway'
BAD_REQUEST = u'badRequest'
CANNOT_CHANGE_OWN_ACL = u'cannotChangeOwnAcl'
CANNOT_CHANGE_OWNER_ACL = u'cannotChangeOwnerAcl'
CANNOT_DELETE_PRIMARY_CALENDAR = u'cannotDeletePrimaryCalendar'
CANNOT_DELETE_PRIMARY_SENDAS = u'cannotDeletePrimarySendAs'
CONDITION_NOT_MET = u'conditionNotMet'
CUSTOMER_NOT_FOUND = u'customerNotFound'
CYCLIC_MEMBERSHIPS_NOT_ALLOWED = u'cyclicMembershipsNotAllowed'
DELETED = u'deleted'
DELETED_USER_NOT_FOUND = u'deletedUserNotFound'
DOMAIN_ALIAS_NOT_FOUND = u'domainAliasNotFound'
DOMAIN_CANNOT_USE_APIS = u'domainCannotUseApis'
DOMAIN_NOT_FOUND = u'domainNotFound'
DOMAIN_NOT_VERIFIED_SECONDARY = u'domainNotVerifiedSecondary'
DUPLICATE = u'duplicate'
FAILED_PRECONDITION = u'failedPrecondition'
FILE_NOT_FOUND = u'fileNotFound'
FORBIDDEN = u'forbidden'
GROUP_NOT_FOUND = u'groupNotFound'
ILLEGAL_ACCESS_ROLE_FOR_DEFAULT = u'illegalAccessRoleForDefault'
INSUFFICIENT_FILE_PERMISSIONS = u'insufficientFilePermissions'
INSUFFICIENT_PERMISSIONS = u'insufficientPermissions'
INTERNAL_ERROR = u'internalError'
INVALID = u'invalid'
INVALID_ARGUMENT = u'invalidArgument'
INVALID_CUSTOMER_ID = u'invalidCustomerId'
INVALID_INPUT = u'invalidInput'
INVALID_MEMBER = u'invalidMember'
INVALID_MESSAGE_ID = u'invalidMessageId'
INVALID_ORGUNIT = u'invalidOrgunit'
INVALID_OWNERSHIP_TRANSFER = u'invalidOwnershipTransfer'
INVALID_PARAMETER = u'invalidParameter'
INVALID_PARENT_ORGUNIT = u'invalidParentOrgunit'
INVALID_QUERY = u'invalidQuery'
INVALID_RESOURCE = u'invalidResource'
INVALID_SCHEMA_VALUE = u'invalidSchemaValue'
INVALID_SCOPE_VALUE = u'invalidScopeValue'
INVALID_SHARING_REQUEST = u'invalidSharingRequest'
LOGIN_REQUIRED = u'loginRequired'
MEMBER_NOT_FOUND = u'memberNotFound'
NOT_A_CALENDAR_USER = u'notACalendarUser'
NOT_FOUND = u'notFound'
NOT_IMPLEMENTED = u'notImplemented'
ORGANIZER_ON_NON_TEAMDRIVE_ITEM_NOT_SUPPORTED = u'organizerOnNonTeamDriveItemNotSupported'
ORGUNIT_NOT_FOUND = u'orgunitNotFound'
OWNER_ON_TEAMDRIVE_ITEM_NOT_SUPPORTED = u'ownerOnTeamDriveItemNotSupported'
PERMISSION_DENIED = u'permissionDenied'
PERMISSION_NOT_FOUND = u'permissionNotFound'
PHOTO_NOT_FOUND = u'photoNotFound'
QUOTA_EXCEEDED = u'quotaExceeded'
RATE_LIMIT_EXCEEDED = u'rateLimitExceeded'
REQUIRED = u'required'
RESOURCE_ID_NOT_FOUND = u'resourceIdNotFound'
RESOURCE_NOT_FOUND = u'resourceNotFound'
SERVICE_LIMIT = u'serviceLimit'
SERVICE_NOT_AVAILABLE = u'serviceNotAvailable'
SYSTEM_ERROR = u'systemError'
TIME_RANGE_EMPTY = u'timeRangeEmpty'
UNKNOWN_ERROR = u'unknownError'
USER_NOT_FOUND = u'userNotFound'
USER_RATE_LIMIT_EXCEEDED = u'userRateLimitExceeded'
#
DEFAULT_RETRY_REASONS = [QUOTA_EXCEEDED, RATE_LIMIT_EXCEEDED, USER_RATE_LIMIT_EXCEEDED, BACKEND_ERROR, BAD_GATEWAY, INTERNAL_ERROR]
ACTIVITY_THROW_REASONS = [SERVICE_NOT_AVAILABLE]
CALENDAR_THROW_REASONS = [SERVICE_NOT_AVAILABLE, AUTH_ERROR, NOT_A_CALENDAR_USER]
DRIVE_USER_THROW_REASONS = [SERVICE_NOT_AVAILABLE, AUTH_ERROR]
DRIVE_ACCESS_THROW_REASONS = [FILE_NOT_FOUND, FORBIDDEN, INTERNAL_ERROR, INSUFFICIENT_FILE_PERMISSIONS]
GMAIL_THROW_REASONS = [SERVICE_NOT_AVAILABLE, BAD_REQUEST]
GMAIL_SMIME_THROW_REASONS = [SERVICE_NOT_AVAILABLE, BAD_REQUEST, INVALID_ARGUMENT, FORBIDDEN]
GPLUS_THROW_REASONS = [SERVICE_NOT_AVAILABLE]
GROUP_GET_RETRY_REASONS = [INVALID, SYSTEM_ERROR]
GROUP_GET_THROW_REASONS = [GROUP_NOT_FOUND, DOMAIN_NOT_FOUND, DOMAIN_CANNOT_USE_APIS, FORBIDDEN, BAD_REQUEST]
GROUP_SETTINGS_THROW_REASONS = [GROUP_NOT_FOUND, DOMAIN_NOT_FOUND, DOMAIN_CANNOT_USE_APIS, FORBIDDEN, SYSTEM_ERROR]
GROUP_SETTINGS_RETRY_REASONS = [INVALID, SERVICE_LIMIT]
MEMBERS_THROW_REASONS = [GROUP_NOT_FOUND, DOMAIN_NOT_FOUND, DOMAIN_CANNOT_USE_APIS, INVALID, FORBIDDEN]
MEMBERS_RETRY_REASONS = [SYSTEM_ERROR]
USER_GET_THROW_REASONS = [USER_NOT_FOUND, DOMAIN_NOT_FOUND, DOMAIN_CANNOT_USE_APIS, FORBIDDEN, BAD_REQUEST, SYSTEM_ERROR]

REASON_MESSAGE_MAP = {
  ABORTED: [
    (u'Label name exists or conflicts', DUPLICATE),
    ],
  CONDITION_NOT_MET: [
    (u'Cyclic memberships not allowed', CYCLIC_MEMBERSHIPS_NOT_ALLOWED),
    (u'undelete', DELETED_USER_NOT_FOUND),
    ],
  FAILED_PRECONDITION: [
    (u'Bad Request', BAD_REQUEST),
    (u'Mail service not enabled', SERVICE_NOT_AVAILABLE),
    ],
  INVALID: [
    (u'userId', USER_NOT_FOUND),
    (u'memberKey', INVALID_MEMBER),
    (u'A system error has occurred', SYSTEM_ERROR),
    (u'Invalid Customer Id', INVALID_CUSTOMER_ID),
    (u'Invalid Input: INVALID_OU_ID', INVALID_ORGUNIT),
    (u'Invalid Input: custom_schema', INVALID_SCHEMA_VALUE),
    (u'Invalid Input: resource', INVALID_RESOURCE),
    (u'Invalid Input:', INVALID_INPUT),
    (u'Invalid Org Unit', INVALID_ORGUNIT),
    (u'Invalid Ou Id', INVALID_ORGUNIT),
    (u'Invalid Parent Orgunit Id', INVALID_PARENT_ORGUNIT),
    (u'Invalid query', INVALID_QUERY),
    (u'Invalid scope value', INVALID_SCOPE_VALUE),
    (u'New domain name is not a verified secondary domain', DOMAIN_NOT_VERIFIED_SECONDARY),
    ],
  INVALID_ARGUMENT: [
    (u'Cannot delete primary send-as', CANNOT_DELETE_PRIMARY_SENDAS),
    (u'Invalid id value', INVALID_MESSAGE_ID),
    (u'Invalid ids value', INVALID_MESSAGE_ID),
    ],
  NOT_FOUND: [
    (u'userKey', USER_NOT_FOUND),
    (u'groupKey', GROUP_NOT_FOUND),
    (u'memberKey', MEMBER_NOT_FOUND),
    (u'photo', PHOTO_NOT_FOUND),
    (u'resource_id', RESOURCE_ID_NOT_FOUND),
    (u'resourceId', RESOURCE_ID_NOT_FOUND),
    (u'Customer doesn\'t exist', CUSTOMER_NOT_FOUND),
    (u'Domain alias does not exist', DOMAIN_ALIAS_NOT_FOUND),
    (u'Domain not found', DOMAIN_NOT_FOUND),
    (u'domain', DOMAIN_NOT_FOUND),
    (u'File not found', FILE_NOT_FOUND),
    (u'Org unit not found', ORGUNIT_NOT_FOUND),
    (u'Permission not found', PERMISSION_NOT_FOUND),
    (u'Resource Not Found', RESOURCE_NOT_FOUND),
    (u'Not Found', NOT_FOUND),
    ],
  REQUIRED: [
    (u'Login Required', LOGIN_REQUIRED),
    (u'memberKey', MEMBER_NOT_FOUND),
    ],
  RESOURCE_NOT_FOUND: [
    (u'resourceId', RESOURCE_ID_NOT_FOUND),
    ],
  }

class aborted(Exception):
  pass
class alreadyExists(Exception):
  pass
class authError(Exception):
  pass
class backendError(Exception):
  pass
class badRequest(Exception):
  pass
class cannotChangeOwnAcl(Exception):
  pass
class cannotChangeOwnerAcl(Exception):
  pass
class cannotDeletePrimaryCalendar(Exception):
  pass
class cannotDeletePrimarySendAs(Exception):
  pass
class conditionNotMet(Exception):
  pass
class customerNotFound(Exception):
  pass
class cyclicMembershipsNotAllowed(Exception):
  pass
class deleted(Exception):
  pass
class deletedUserNotFound(Exception):
  pass
class domainAliasNotFound(Exception):
  pass
class domainCannotUseApis(Exception):
  pass
class domainNotFound(Exception):
  pass
class domainNotVerifiedSecondary(Exception):
  pass
class duplicate(Exception):
  pass
class failedPrecondition(Exception):
  pass
class fileNotFound(Exception):
  pass
class forbidden(Exception):
  pass
class groupNotFound(Exception):
  pass
class illegalAccessRoleForDefault(Exception):
  pass
class insufficientFilePermissions(Exception):
  pass
class insufficientPermissions(Exception):
  pass
class internalError(Exception):
  pass
class invalid(Exception):
  pass
class invalidArgument(Exception):
  pass
class invalidCustomerId(Exception):
  pass
class invalidInput(Exception):
  pass
class invalidMember(Exception):
  pass
class invalidMessageId(Exception):
  pass
class invalidOrgunit(Exception):
  pass
class invalidOwnershipTransfer(Exception):
  pass
class invalidParameter(Exception):
  pass
class invalidParentOrgunit(Exception):
  pass
class invalidQuery(Exception):
  pass
class invalidResource(Exception):
  pass
class invalidSchemaValue(Exception):
  pass
class invalidScopeValue(Exception):
  pass
class invalidSharingRequest(Exception):
  pass
class loginRequired(Exception):
  pass
class memberNotFound(Exception):
  pass
class notACalendarUser(Exception):
  pass
class notFound(Exception):
  pass
class notImplemented(Exception):
  pass
class organizerOnNonTeamDriveItemNotSupported(Exception):
  pass
class orgunitNotFound(Exception):
  pass
class ownerOnTeamDriveItemNotSupported(Exception):
  pass
class permissionDenied(Exception):
  pass
class permissionNotFound(Exception):
  pass
class photoNotFound(Exception):
  pass
class required(Exception):
  pass
class resourceIdNotFound(Exception):
  pass
class resourceNotFound(Exception):
  pass
class serviceLimit(Exception):
  pass
class serviceNotAvailable(Exception):
  pass
class systemError(Exception):
  pass
class timeRangeEmpty(Exception):
  pass
class unknownError(Exception):
  pass
class userNotFound(Exception):
  pass

REASON_EXCEPTION_MAP = {
  ABORTED: aborted,
  ALREADY_EXISTS: alreadyExists,
  AUTH_ERROR: authError,
  BACKEND_ERROR: backendError,
  BAD_REQUEST: badRequest,
  CANNOT_CHANGE_OWN_ACL: cannotChangeOwnAcl,
  CANNOT_CHANGE_OWNER_ACL: cannotChangeOwnerAcl,
  CANNOT_DELETE_PRIMARY_CALENDAR: cannotDeletePrimaryCalendar,
  CANNOT_DELETE_PRIMARY_SENDAS: cannotDeletePrimarySendAs,
  CONDITION_NOT_MET: conditionNotMet,
  CUSTOMER_NOT_FOUND: customerNotFound,
  CYCLIC_MEMBERSHIPS_NOT_ALLOWED: cyclicMembershipsNotAllowed,
  DELETED: deleted,
  DELETED_USER_NOT_FOUND: deletedUserNotFound,
  DOMAIN_ALIAS_NOT_FOUND: domainAliasNotFound,
  DOMAIN_CANNOT_USE_APIS: domainCannotUseApis,
  DOMAIN_NOT_FOUND: domainNotFound,
  DOMAIN_NOT_VERIFIED_SECONDARY: domainNotVerifiedSecondary,
  DUPLICATE: duplicate,
  FAILED_PRECONDITION: failedPrecondition,
  FILE_NOT_FOUND: fileNotFound,
  FORBIDDEN: forbidden,
  GROUP_NOT_FOUND: groupNotFound,
  ILLEGAL_ACCESS_ROLE_FOR_DEFAULT: illegalAccessRoleForDefault,
  INSUFFICIENT_FILE_PERMISSIONS: insufficientFilePermissions,
  INSUFFICIENT_PERMISSIONS: insufficientPermissions,
  INTERNAL_ERROR: internalError,
  INVALID: invalid,
  INVALID_ARGUMENT: invalidArgument,
  INVALID_CUSTOMER_ID: invalidCustomerId,
  INVALID_INPUT: invalidInput,
  INVALID_MEMBER: invalidMember,
  INVALID_MESSAGE_ID: invalidMessageId,
  INVALID_ORGUNIT: invalidOrgunit,
  INVALID_OWNERSHIP_TRANSFER: invalidOwnershipTransfer,
  INVALID_PARAMETER: invalidParameter,
  INVALID_PARENT_ORGUNIT: invalidParentOrgunit,
  INVALID_QUERY: invalidQuery,
  INVALID_RESOURCE: invalidResource,
  INVALID_SCHEMA_VALUE: invalidSchemaValue,
  INVALID_SCOPE_VALUE: invalidScopeValue,
  INVALID_SHARING_REQUEST: invalidSharingRequest,
  LOGIN_REQUIRED: loginRequired,
  MEMBER_NOT_FOUND: memberNotFound,
  NOT_A_CALENDAR_USER: notACalendarUser,
  NOT_FOUND: notFound,
  NOT_IMPLEMENTED: notImplemented,
  ORGANIZER_ON_NON_TEAMDRIVE_ITEM_NOT_SUPPORTED: organizerOnNonTeamDriveItemNotSupported,
  ORGUNIT_NOT_FOUND: orgunitNotFound,
  OWNER_ON_TEAMDRIVE_ITEM_NOT_SUPPORTED: ownerOnTeamDriveItemNotSupported,
  PERMISSION_DENIED: permissionDenied,
  PERMISSION_NOT_FOUND: permissionNotFound,
  PHOTO_NOT_FOUND: photoNotFound,
  REQUIRED: required,
  RESOURCE_ID_NOT_FOUND: resourceIdNotFound,
  RESOURCE_NOT_FOUND: resourceNotFound,
  SERVICE_LIMIT: serviceLimit,
  SERVICE_NOT_AVAILABLE: serviceNotAvailable,
  SYSTEM_ERROR: systemError,
  TIME_RANGE_EMPTY: timeRangeEmpty,
  UNKNOWN_ERROR: unknownError,
  USER_NOT_FOUND: userNotFound,
  }
