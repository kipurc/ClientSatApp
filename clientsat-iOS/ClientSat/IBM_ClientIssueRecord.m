//-------------------------------------------------------------------------------
// Copyright 2014 IBM Corp. All Rights Reserved
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//-------------------------------------------------------------------------------

#import "IBM_ClientIssueRecord.h"

@implementation IBM_ClientIssueRecord

@dynamic name;
@dynamic salesconnect;
@dynamic brandBU;
@dynamic cxname;
@dynamic idescription;
@dynamic actions;
@dynamic actionRecord;
@dynamic status;
@dynamic clientContact;
@dynamic esu;
@dynamic buOther;
@dynamic buPersonnel;
@dynamic issueImpact;
@dynamic resolution;

+(void) initialize
{
    [self registerSpecialization];
}

+(NSString*) dataClassName
{
    return @"Client Issue Record";
}

@end
