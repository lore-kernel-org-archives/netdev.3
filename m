Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0F339B3D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279183; cv=fail; b=dwrtIctYFgj2AwSf9DACUCC8it3BSmw9Ziz44ZTTmMDJbFnxI+a1noQDU7zKEIuUd0ocgWCguM/Eoyj8YAX33IhHnMCvQcsbXLo+PnYdkIbf4cRigJOCYn91HYqZHl/5Jiu78Z5PJt4Fpo9CvU3b/2fo3yaenPwdq2JN0CIegJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279183; c=relaxed/simple;
	bh=Ilq8M8WxbU0kX0uSHUd/a6ZfiFG98Pn9nR6h/gqAS0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XFyJO2EZExacoMQE6SBHuv0WkEYdubHqdcUwbRmCXtyXeS/FE2+y+zG4O88B1oiFlixbAc6rVpNNejTStrif0oycrAmAVXGboV2/lLTCeNXa/mPn58itpDCWWyzxGJiB/iVN2A+x/3C8JW2ihLBDh8ODvvMKDCL69Olrk63N/Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QFeNhso8; arc=fail smtp.client-ip=52.101.48.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QFeNhso8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5x/O0z8nMrVJIBIgbNw+Pg57CIAkqrISwMae29pTxDS9C5MaawjdhK7PWYBTG5c7QynxUgOPt9/+/6cIoiS8SqDb3aIsUt//t1k76OThNpzFvcjYV+wlLHUVhsOubYmMm/R4yfgHRZ8GFTvXZ4gGVnMaUXvmRKF+cT0I3RlBCLtUiQqf/BBIvSjuVknN0MoXwswQw2+GYuu6ezYAL+zD05MY6XIRgS9UwWNHQuQ3EG9wpscqWkqcThSK29FFpTu6K10Qvpzu/jMUAE+Zkf1NdfVxHAj3A5kKuUctbKy1D6vTfnZ2ubyYjGFa79+wfANt9A90s4Ayg903cVGhyVDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x85qCk0Ugo7cy1oXXhfFXNwp+V3xvb65dxWZa97QnWk=;
 b=nkmj0EHdb9O++RkkQUG8oqyptLB0JMDD50l28hn8vbZoCEpZ1vMxdNzZWn3vrEDjxwN18FWFc3/IYPUmXOce/zYiom3IhUfJQXGzeK0u6OaprqW8KF9LTTOAOPC62l0NiZqGWXlCyeClUVvgkGUa/EEOEc/u7rBbApIxv7fkUqsKUOEnciGWNwTEF15gKPESqNkk8eRHz0mmUmiLmIs+9Bk3sa8YhlyB5i+R36HYzGZDOfmqp+H9aHUkT3UiUMivBTOpiXMHtZaymlbBrz9h0wqrnlAEvPqjJVS7r/xZRdwwuyMejQGnj0qlwozBu1Q382OGr7ydpkuJs37fZbRUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x85qCk0Ugo7cy1oXXhfFXNwp+V3xvb65dxWZa97QnWk=;
 b=QFeNhso8fmgNnS4UrfVH9Qf0eaVQRxFscvOc7E29q+doAXldYh2fm3c7+7mSRUABQmvtIwXS1SYiSdVnghPN5uqEnTf2pLvUMJg2mrK2L5+y7pagjFG6M1PrOzDFMaoaFCeUoNnfQEWYNlFYN6zVbj2MW3adhCbnaB8GKQSFpBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 22:52:58 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 22:52:58 +0000
Message-ID: <50a63b4b-ba5e-4acf-bda8-5aa488c81794@amd.com>
Date: Tue, 28 Jul 2026 15:52:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
 Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Simon Horman <horms@kernel.org>, Vamsi Atluri <Vamsi.Atluri@amd.com>,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260728-upstream_v8-v10-0-46dafbd74571@amd.com>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260728-upstream_v8-v10-0-46dafbd74571@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 336a511f-5eb6-4e4e-3903-08deecfaf817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Kij7czM217tKjePUfHIoa8zASNTVq2JdfBZR0YsuXEATCtaoW6bdjOXFjw0iYXK2+vTW4+d8uo978pwYxjLyC8/1zUXcZM2jZUWP6EUt+/Ioc/apZ0a0DmGErVW7cnUm9zNiH8Zfq8K3zddZ+wE5sWQPsHNy+UeaWL5hzV79hvC/vo8JzUx/Az+BECJPXBwktWuZHyJpKzM5p4iTKbvrqU2u22N9644PlPrqMbmhbl+Zj95rZU9OrriPj0V0DMlnr4Bh/5hi8mmwVKvhD6DxhBALdmELrdYMFPHnEZDTxpG3T7brorvmFE93wwnE4lPMU825yK5JlYk5qSivb4Rq15i/fdBWaWdmzaXH8Mg1/HZUcmCJsRS2fbB2dQycCmSq+9bP7FCM9b2nkmnllkBZWnqCD5SPplsLH4GGnEzl1fM70gkzfZRsFNW/PfDrPQb8AzJnVYxTrHEX1hEHQXyxL7bqbGQaXnZ19P4B4T0EcDEeYLA/qXEJeHNn6GYH7mJ6LO2k2aXiCCseTM+CYKHIqm7bhDToKM7Elxr67HXn1x/KndNoTCXFzYb+bjv3ZNoaQgx2NRzfNJW/xlm4vdsMntLEOcUlrk66EPZtKiN4RHo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NESlBJekJtZGpQbEFSRWY0Rmdhb2lFTmlYRWd5Rk5aR01kTVpweks4TklR?=
 =?utf-8?B?SlR2S2lmbXJobjdqTTN2R214bkxUTkNGeFVCRVEvSTNGL1hsZXk3ZkRNYmM3?=
 =?utf-8?B?Sk00VUhKeDZrSHJUbGdCSFZmU0plbEN1ZFhHckhEUmVORFFMRFl5UmhyLzZk?=
 =?utf-8?B?anlPaTZvNFl1TUZuZmhLSkJja3UyK005TytQVFlhRlhxeDllM3Rkajk0bUtn?=
 =?utf-8?B?dXdteDNKSXNNYng1QnBHOFlEbytGYzZEUFE2UXNRUnRQekU2Ry9WSFJFcTZW?=
 =?utf-8?B?VUswL3BWMms1aEZ4V2E1dTNLWERmeFNGQUFBblJlVElMaEc0QkpSTytuQ2Ex?=
 =?utf-8?B?RUFrU2dGRGFyQ2h1M01rTU1NTUdyOGVxTnVxQkpPb1REV3JhdWpvdTZsUmYw?=
 =?utf-8?B?YUs5Zlk0WjBpZ2ExUHM0UEcxeXdvTmhNRFNYQVhoVWEvMHF5Q05waktSR1A3?=
 =?utf-8?B?T1dNTGtmK3hFL0UrWlR5citSOTE4dnFaQjhoSEVLQnM4enBsdjlFZHhSQzho?=
 =?utf-8?B?L3p1SnZpZzJnVXFrVVVybW1ERHBZbktsb2FyV2phT2Y4RVVBR0VXelFSNDBQ?=
 =?utf-8?B?NUdBZWFjTHN3a0laRDJjanhVV2ZvOGNUM0FoSmUySlRSUTZaUjFwNDIxL3Yw?=
 =?utf-8?B?WGdXa0FtUmVybDJPMzNWSDQ2SVRnbEJ3eHAzNEt1MHBhVUNPbTNNbUE3Vkc5?=
 =?utf-8?B?bnpteTZ1V0l5bmMxTnF1ZUhJVVkwVHEwWm9SbEZBSGtkSjZjamsrUGdrUVFi?=
 =?utf-8?B?dHlTWGo3dG1pMm9iS0srV0t0aFJVVE1PUkZUQVdVNFlvbkdEeXBqUFVLeXZ6?=
 =?utf-8?B?aGhScll3VEZpUk93Znk0K09QY3U3VUFJQ3VJV1VqZW1ESW9lVUhkeVlxZmxG?=
 =?utf-8?B?Vnk1MGN1ZlpMSkFpYmFZTzFjcGlBN1Q2MWhVd3phZVNRUkxuekVaTTlSeUx2?=
 =?utf-8?B?eGpyQXBrTUlscE5zUE9PL0MvaTFVS3NVT2FSYzMxN3p5a25BN1VRckxJSjdC?=
 =?utf-8?B?dmNqcitiNjlWeG5ndGphTGZwdlp2UE5vRloveWV5OXoxUGh0bi84SHdFeGxh?=
 =?utf-8?B?ZzRUT3ZnTWRieEMxUHNPSnVscGRXNkU2TkFYaUZyT1VWdnJsdkhWMGpTSGVj?=
 =?utf-8?B?TWJuVjl6U1hGVGJKbysrTExDZkpvMU9paUdWbzlsLzE2U1pwQW5mU05TOHlT?=
 =?utf-8?B?V3FWdGZyU0tVNWk1VVJFYnFLaDR5VVZOOGtBcUdmTUFSeHFWdVJ1SDliTXpw?=
 =?utf-8?B?VzUrZXUzQlRhSmcyOG5yb0hvY05KL3FDUExKaHZKNHlraVdScnRMY2V1UTRH?=
 =?utf-8?B?T0dtWFZpZWlEYUMvb3Q5ZjFoUFFXQ21WYXZtak9FZVYvb1REVVUrYXJyanN3?=
 =?utf-8?B?SlduVmUrM3oxd1dZQjA5M3RyaVBUbmdwdUErcmt2Tk1RM3RQL1IxZ2p5ekxZ?=
 =?utf-8?B?eStGV0x5UmhTeEJYZ2RieHk2QXFHM0xGNjg4d1g5Ujc5dmxBa1FZYitBb2Er?=
 =?utf-8?B?cUt2c2NZQjQzcmQ5cUVSZnU4V2tnb0NmMmtqS2V1VFBoc2tXZEcvTzFzYzdi?=
 =?utf-8?B?cmdTTWdCUUpZN0dvQmI3Yi9uY2t6bE5YYStiTmJzVmJsUGFlZEZGVG9qSmsw?=
 =?utf-8?B?bTJQQjZKSFdrMUMzZW9Jd2RMVFNBY3ZlT3ZjQk85eVhMWFVYeUI0TVk1QnJN?=
 =?utf-8?B?MjFUamxJbDdoSGVOWURCUG9OZE4zSlZyNTl5NlRod2xGWFBVUXlZcHdvQWFK?=
 =?utf-8?B?Mk16bUxkd0F6R2YvenlMaGsrWHoydHpnQlRhVmRDczhXRHJoeU1LeUx1ME9o?=
 =?utf-8?B?K1ZWeEVMc2Fjdkdac21KRzFSTHpuVkxBZUt4bzJXSGFERWJoOExpc3p5MVZY?=
 =?utf-8?B?SUJrVGhLVVJvY2hMcHp5dlVCc0tKeGdqZ0tZK1g0ODRIMkJqMW1rV2NmdVhN?=
 =?utf-8?B?MjhSTk9QbUUzclkvUXl2WWZKOEZSWHhGdmhBdGdwRVIzaXlQbFlVT1hhaGlD?=
 =?utf-8?B?MFpGYjVScXplUmkwUVhabjNaL3VUUmYvUy91OG4zTTNlSkVBdVNkeE8vbUMv?=
 =?utf-8?B?Z0ZVeHNnT2k2QWVqWE0yOU1ObjJ5KzA5dnBIY2JNOGRLOUF4TzVWRExVbUNG?=
 =?utf-8?B?b3Vxcml4V3pDRHlNa0RmL2xlODNsZUR5MEJZTnJ4K2c0aVdGUzhUUDQvUnlr?=
 =?utf-8?B?Uk53Wi9RNnZYcngwQWdES2k4dW1lMVBnZ25kaHU0dE1QUkp3V3M5RVJUbmV1?=
 =?utf-8?B?Szd2bllLT3UycDZOOXlaQUw5bWszdEtFQnZtMUd2SHVHc2lBclNZcnE5RHg1?=
 =?utf-8?B?ZGZqSFVWVGNnTlFWeHJtSXl6QkJOdUpKaCt5QnhkckxwRnNJS3R4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336a511f-5eb6-4e4e-3903-08deecfaf817
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 22:52:58.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7qOC720/jZgpEiTmL5cOstOzLZt4YtUjFBVlwaLmAop+tLWIT/RwuR8UA1rr3ZG8MY9Hppz2OvmrFYzM5GI2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246

On 7/28/2026 2:09 PM, Nikhil P. Rao wrote:
> This series adds PLDM-based firmware update support to the pds_core
> driver. PLDM (Platform Level Data Model) is a DMTF standard for firmware
> management that provides a vendor-neutral interface for firmware updates.
> 
> The implementation uses the kernel's pldmfw library for package parsing
> and component matching. Users can update entire firmware packages or
> individual components via devlink flash. Component information is
> displayed via devlink info, showing firmware versions and update status
> for each component.
> 
> The series also adds host backed memory support, allowing firmware to
> request memory pages from the host for its operations.
> 
> Changes since v9:
> - Patch 3 (PLDM firmware update):
>    - Fix a v9 rebase error that reintroduced an -EOPNOTSUPP guard in
>      pdsc_dl_flash_update(), which rejected all per-component flash
>      requests and made per-component update unreachable.
>    - Implement per-component update using the pldmfw
>      PLDMFW_UPDATE_MODE_SINGLE_COMPONENT mode and component_identifier
>      instead of a driver-side component-name filter. The name filter
>      silently reported success when the requested component was absent
>      from the package (nothing was flashed); the framework mode rejects
>      that case instead.
> - Link to v9: https://patch.msgid.link/20260724-upstream_v8-v9-0-8425762b8b7f@amd.com
> 
Self-NAK for v10 -- per-component update is broken.

Patch 3 filters the package by a single device-side identifier
(PLDMFW_UPDATE_MODE_SINGLE_COMPONENT), but the same component type can
have different identifiers in the standard vs gold firmware packages, so
that identifier may be absent from the package and the update fails with
-ENOENT.

I will send a v11 that matches by component type against the
package contents, as in earlier versions.

Apologies for the churn.

Nikhil

