Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021091.outbound.protection.outlook.com [52.101.57.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C66486E6D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634670; cv=fail; b=B/cBzuPu6S24Q7QRDuXV8Ul+cGv8iSv/nn12go4JWlGa5WfL0YLRmtAxNMjQlML+yimh/t//XaTQ7W8p7VgigWgk77vRgSPf6itvLQuUk2CJoiSLdmYfiMay4v2OJy1htLwu8UEAZAUrAE7WtOw4Hl53TWtfHCRFDYBT9FdvmqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634670; c=relaxed/simple;
	bh=IMDFpiT1f7fSjvz2MzSJno+46aharmFtOLmKB+SuAOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJ+gpYPXFV76oj7F5EZACeV+YxeQUpMjMJ3dO9+dBqwd7gzCfgyk7YGUnsCCLUXTwSaWm3JQ7xq1DQ4t3p4F+VC4PEIRBJxaoSLNCKq3WSeVJxX6XtJsewBRUYC5uNYqxjl0ok5MCKguw1pabJafnq2wmnh10N3u2roDdPirzxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=Sjq7043b; arc=fail smtp.client-ip=52.101.57.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="Sjq7043b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGRrUDStd3AiCQOB0CAPeR8iw9vW3xdCemloMMbdzuRttKlDJv2cQwjNTzMaGXEnOWUf3PMqxMmVJknQwdDRENohrHq9mCrx7D5RtO+lfOdydQaSYrGo8ZijWxwYe765GYETjDgVePLBLhm/0whN976bjCjoqanCAU3Y0eo5kDVAiDFObGCNsbNEQrmz8lI0MuRtDr5HuV6K6ZGHOegQ/sQSqlWIDjBaZ5H08nAM8MWKSe5tm3M6quSfVd70l3qeXeN1pxd9DTg26QHBMsIxTbJ/rRBv5FT1DfMsg+dBSaR8bf82xL5lZPsXGsm5wpsmvxjjuXlrAIucfbi9bCN9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GZ419kLR85shMOyIjVoexsVhw8t2veWzVHJLUieuy8=;
 b=zFsB4bmI+SCqSZ4xFcFlw3KaegezdGyslqCrAKr2v2ecM+gGf4UVr2okI8981RxTsQP/paPTq1HZlTOkaMVZ4Eoj/6rGnyRpmZnOovfrD9a81amZGd0yGyxYdXEiA8ihZ6RTMySDKhJkxIIzhODFEDeOZPuep1dG1vEDtDBJ5MeNDVPXZ752juOoH8FT7m9dffXdCpvfq3Uk/PDL/iZ4XgPVTB3tAcKnyP3qVSRUQ7wZQDN0JHCE7wzmuKaMznfOo2tyZ7EeMjs+0n7fQtJ0eB69ltkHy0LTfBe5FfHcsm6Sq3AAyVkbVUtu4LaSfe+r9l0zERxUgxekQFCf6N1Myw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GZ419kLR85shMOyIjVoexsVhw8t2veWzVHJLUieuy8=;
 b=Sjq7043b+mpoE7l3aU62KZbZw7OAL6wbaUSFLmwqcDm4Ke34LcDu9T3YYDIEZWbYfQbiPQTqRBmKWiDJ5MBs+ttq99bjjqbpTJoo3UrJ0iaJGkEriwzSGEf4RnRLbb/VeY+KZCDJk0PjeP2xag2HHwNWT21jQkIqDI6gwBnAAFsnMl5oNCruRl2rMKhi0d0zf6pT/eDOI0PjuRtzMv7fbORl2fWTIeZCmaIfDp15RWc9ZYkA3PFG8IfR7WShmNssOG+zC+bK8pkfPETJT7VJtlvRWgkruqtfP8OemI3Y0J7X9nboujmZMSPxpG9leCS8H5TwUi354VV4YbmUtCDFTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 15:24:22 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 15:24:22 +0000
Message-ID: <4c8a403a-a86a-4369-81ec-130fb9b3aee3@pa.msu.edu>
Date: Thu, 13 Aug 2026 11:24:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: macb: Poll for link state changes
 when using the internal PCS.
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 charles.perry@microchip.com
References: <20260807201741.3275-2-nwhitehorn@pa.msu.edu>
 <20260812015433.1687252-1-kuba@kernel.org>
 <d130cf47-1d70-4345-b60a-795d463cb84a@pa.msu.edu>
 <16ca48e8-c9d5-4df5-b955-024349730ae2@lunn.ch>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
In-Reply-To: <16ca48e8-c9d5-4df5-b955-024349730ae2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0426.namprd03.prod.outlook.com
 (2603:10b6:610:10e::10) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc2592d-6ed7-47ff-d85b-08def94ef373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|23010399003|366016|786006|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	M+nb71GD2vpruknSlpBN1xl2YPeaAgECtEc2Dno8el21soGXgV+hvcTOvakOACVxz/TaeulOT3wdp0DmEnK/7Kig5KESochw3bnt998CxA6OERpv/c3JyKJ9fkTbwK6y0TUrjbsC3E17w/AoOpmMFfHFSeT4IR8Zq2LMdCx2tQwdgP0hC/vJqkTFuakgig3I0PA+G5pLSSHzroYpaeTsUprFHjOR61a0JjCywQNqR4Mc6alssyUjZZ6PYrbFapkADIYnjy6EssQ5LqDwz4fA2Kz6CLDk4qVSGOSRhlj6t6WqUqppF9Mf0igIBi2v8zNiQhXULnEihH5ObCH6mXna/LJYlnfzIoFGNlq5rAwiylFXCKvz2GEFQlLs9xTFbSCkd3wctk4ha394X8gBDneyTftbdkuAxxZ2RXJc2ds66GkY+H2L244/5jmN2Bk9ZeoDTOwXY3t3i5Ymto6WYEimbqXbS3PmlhrVZ22Ewt0zx9qcCgELPSc+zG1FCXOvFkf6d/AGZ51/57vZis29OoYmgzklOLv5Hf6A7cLQYYW47f3E5tKT5GJ89KlsXX+9zZjdaMfk40sHqP/kq770uSE7bKxUK/toPiotjPelzWpOJ+dVnH5cS5C6i8A8yb0zByEi+9a3LOBo1n5SuwZuum3pI0cnpvcpv0ZsnDefzly65ts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(786006)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1JRakpFcHhJZ1N1Z21hd3VjUEk5c0FZTjRVNExVYlJ6Vy9Dc0piZXROSWZl?=
 =?utf-8?B?UjB2aXlDT3V1K1JQNmVqY3hZYlZralljeHBhdEVHS2l4Tmw5SDhlOVlRZDM4?=
 =?utf-8?B?dzc2SHdjSTExNVJDdmFRbS82WXJzenZramNGSWxvaHNpZUtMd3NmOEh2VFRH?=
 =?utf-8?B?T1gzL3VmUzlGN0YrOGVlQ0hteDJ1YXl5dXM1b21RSVhrZ2pBMWdZdjlWWUJm?=
 =?utf-8?B?NGIwODIvcU1jbGVKM2tzdy8wQmZlRVBhMU1PdXY1c3RsZExHbWpNWTVuelZP?=
 =?utf-8?B?c1pYdkVlQzNCRjFpWmh4QlVtZ2w5Yi9yOHBoU1p0T0pFSTYzYkZPajUzNGxr?=
 =?utf-8?B?dGM2bXk2NWI1V2ZLQVZXc3JuUWROMGNwT2hsc0k3anIxK2haaThzcUJTUmZa?=
 =?utf-8?B?amNYV1pqakpiNm9IRU1MakFmUWx6blRpTGFPZDdsTXRhN0RXNmh5Y3hxWHM5?=
 =?utf-8?B?VjNKMjhobzJ1Q0xxWkhoV21iUmpYUTB6SUZLdlBOZWo1dGphS1lYOVhKQitQ?=
 =?utf-8?B?WGJkTVNGd3piejdPaDl1bExwb3Vrd20zM2xQNWdIR0x0Vk1QcjhnLzFkQ00r?=
 =?utf-8?B?a2ZWWGFnNkw0Uk9ieXZnc2owaGlTNDJJQzRSK05LWkJDaXVSRWZIcWQvY0Y5?=
 =?utf-8?B?ZGFidXNhZE1yc2FQNHhmWFVPdFpRcVdJcTlhZUFoeTdIVUZ3YVRZc0ZaYVR1?=
 =?utf-8?B?OSs1WU90c3ZJb0hLWmtmd1ZZc1NrdzVRbXg2aXNlQit2cGkxR0poQjBwUm1P?=
 =?utf-8?B?aUJLeEpxS213eGRkWHFjczl1bmd3N2IyK1JuN2s4MFRXSGg0bFhwdGN5RXMz?=
 =?utf-8?B?S3BXRU1vU2pvekluU0s1MzNlQXV3dnowTHJGOTcwSTZiemYxSSt1VGRQZjYr?=
 =?utf-8?B?bUluZnhGN0lEd1Z2M1BtZFQ4TFlzOElyTTVqT0lhdXFQNGk1MjVsMjBTR2Js?=
 =?utf-8?B?bFoyZGJIYkJ5ZnZPUW1HQUZaUytPZURrMFk0cG83Wjl4QnlLbGN0T2lBejda?=
 =?utf-8?B?V1J0OElwM1NuTGlkNitXQlZuQVNld2RSaVNjdE9waTdIbDlZZU5US3U3UHA2?=
 =?utf-8?B?dE9HTVMxeThOTnJmbFdsUFRCS2NBQ0ZBVXlNOXR5eTI5dkZ6N0RzcGdKVXlO?=
 =?utf-8?B?MGJEQXp3bXJSVE1GbEptelRtNy9xM1U1K2hVYWloYXNuRmZZZ1RrNEJkQzJz?=
 =?utf-8?B?eXJqYm4zMEprbGVwTnB5SUdtaWF4ZzV1OFJ1ZFNLNkNvY0ZyU2xIeHI4VWtB?=
 =?utf-8?B?MHlxV1ppa2xBc2JQYWt2V2lxcWJWdXdya3N2K3hhMkhObGROeEV3Q2xiMlh3?=
 =?utf-8?B?QXJEeXdzKzMzVkNnL0pQOHNjV0QrNDVqakdFdjlzN2FiRXp3OGU2NWpibFhW?=
 =?utf-8?B?a1E2ZmM5b29XcUY4OG1DaHo3Y3RwM2Q0L3VRaW55OThvc3ozRzdVaGd6RTJD?=
 =?utf-8?B?aXRnQitCUDByU3hwR0QyeER2U25mSjh4WkVWQzhMNzJuWUs2aWo0QzErUEl4?=
 =?utf-8?B?MldKOGRwMjZWQUNwVTRRYVNteTlBZFFCRmQxamdQSjBGYUxEdnlxSEx5Sytx?=
 =?utf-8?B?NTRRcXYwQ1Z2N1lLVEtQWHBVcHhmY0NJVFpCSWpGZnkrRzF4Wk9iV0tBKzl6?=
 =?utf-8?B?Tnc5RitDMU9wTDFKWG5WUTRtckRyTEhhTWxDdWFOdmtad3BnL08vL0F1YXFV?=
 =?utf-8?B?by9JV3k3akxlNW91U0p1T0grajY1N0hIdFN3cHN0RG8wVWY2NkxTdFJpazk5?=
 =?utf-8?B?OHFEekNTYjJELzJjbUdxVDJRVnNyaEN4RGp4RVJRUCtZVUpzVGxrQWo4YVVv?=
 =?utf-8?B?Y21rUWZtMU1mSVQwamdXZ1JaVWxmdnhQRWJFcFBlNkpGMWJuMkQ1eWcvejdY?=
 =?utf-8?B?NzRabHU0R2JoeFY4b094bzFnbVJMdkl1TW1NcmZnU1NZWlArcGx5eG1QQU9u?=
 =?utf-8?B?Wll4NmFLb1dmVVNueHc3RFZuZXNPcnZEZWF1UnhPUjVSRkgvdDV4SWsrQSsr?=
 =?utf-8?B?L01zaXUxVTZnTUFRMUlyUGd0YVVRY21Cd3BUdTVkblVGZENCS1dxSHBOUjF3?=
 =?utf-8?B?UzkwanRrSTQ3clJPVVRCOXE4aWJpRnFpTGUwb2Q4UnJzMjNWQVB1dFhDL0s2?=
 =?utf-8?B?WGhmZG1WM01lYTdnN0k0cHVKTXhrVHVtUVpqSVlPTzRBbjR3WEpLSUx1QldI?=
 =?utf-8?B?YVh4QmdtQ2xSSldHeU5HRGRETkl4NmFyekJKTkZ2N2JPNnR3M0pjSE04U2I0?=
 =?utf-8?B?T25UTWJmRGh1OEhXVERleUpBVldPUk5qMmQ4azRXS0tnd3QzM0NSVmRZd3FE?=
 =?utf-8?B?Y2pwZUtrNWlTVGNtU0UvQng4WlpGMUpCdWxUUjBGY0Z4eWZEbnFKdz09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc2592d-6ed7-47ff-d85b-08def94ef373
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:24:22.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fDbVQmNeqThCqksX3KVYNZVnF0RV1ktaIO44eZwWVqD5E07F+NawcRXZVNAOKS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995



On 8/12/26 12:22, Andrew Lunn wrote:
>> I am a little reticent to include fixes to this pre-existing situation in
>> this patch unless it is unmergeable without doing so, especially given that
>> I think a full solution would be a substantially larger change, but if it is
>> needed, I would be happy to work on adding it.
>> -Nathan
> The way WoL works has been changed in phylink recently. Many MAC
> drivers got it wrong, so we tried to make it easier by putting as much
> business logic as possible into phylink.
>
> So i would suggest you do a minimal fix for your issue, but also for
> net-next try to rework WoL to make full use of phylinks code. So two
> independent patchsets.

Thanks, that sounds good to me. I'll post v5 in a few minutes.
-Nathan

>
> 	 Andrew

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


