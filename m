Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25283AE1A3;
	Mon, 31 Aug 2026 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159459; cv=fail; b=k7BjNmSmxl2mkRb6qb6twKeD7vl/fNBX7BXtrwP/ntYEcoE1kbuGUjpR/iU0JxM/WBYnHakquWbVd1gNyZH4M79yJARIlEp9/OyCh8wpbttHU8Cy8WBF2KCkm0VzNvtd1jQROuAGCfhkaaVylYhgRPXw0ZzI8rG0sQE8r+tMDB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159459; c=relaxed/simple;
	bh=rjUySQc2YA/pLN2dO0WHicnpRwoTGvZdJIsUVr30I3M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GLU5NRMcDaJQ5EnHd/ShQg5nZ2mnvm7slBIQwX1RVwmI8hbRUDi0NMCXk+YSs39p7VSx4R6WrdEFyyTMC+Bi9tv/cqmdy6kiKQLs8Eie5odqbuj2fkum7+UojciPYRGSulOGGHx6OBniYtrvwbLWxNfsPDuQm2fONYskOM5E5aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ba4jdyMn; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ba4jdyMn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOkGwIO/eI0Bs6johF/R4UZ/pbUMAXnkkE8lz/Y7jzVNhF4PtDW6cE5EH8e2n/UH+JlcCFQ3ePqE+U3SXm1p80JnCNLeDv8oAjbnCzNNIt7rDI3yuQ5LQU3NRsUC44x4gjbwYokG0wYs1f5u3CGRlhqYIZkSd6lkJW6EmGdKFkUC/E0x4OzLKRfuIHqatF9mEACGRSbusACjqgreuuOPSwiXgX0pYpMyq7pXpYEu8kDYnMP5i4gaBSbkMGSIeEsXVbqp3hlalFMyGP2HmBDFV0cSjvylHG/VMhIvL+YmEuibcZV2lfMecR5ecOSkP/E/SH4hljqmpX1avM8ZK1ZbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrOxsmXc558oRTWrhvdFECvfCj6TDr/3GQ1tnhG2Cbs=;
 b=lGrqJmqmM2tTHP5Gbfx1FepQuJQ+tI0bKFUaeUtvRDN0MlsTAfQP9p5+SwgU24j8CW/tqHjoGVDcw4Ry6+NOS69O4ZHSBzSqHlqENe0tft5daOdxzHpm0jzgusgz/k8J5Vsq1HWLWqdrtDZtHaEKNCsVVH82+Dfy5s3PFTZTPedBXgNxiVFEpJ/aF1DkaUKqTm7yG/8FNv5yt/5XgLznfkTPFhRgY1RKCDIP8BKZNL4xTyv3w0Y+GeyVRlzwgYr4nxjvl9AmrNDsYbvTfiBRAJQDN0pxY8KAxyFug754Sa3nd2Sa4zzm8J0DYL7S8FOtHUm9c+NQodEqaahdQTUnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrOxsmXc558oRTWrhvdFECvfCj6TDr/3GQ1tnhG2Cbs=;
 b=ba4jdyMnL6f+Tkc2TNjnUgH/BRO+oSNEZTTGjGmVFONI/aVQqXlPDSI3rM6H1+V4stU44mmI5slhM0EbO0AsmwNz40Q93bZCgA2RVrjFVPjS+3yZVeQq1OGeX7wgEgFAHL9YOR9OqW/1LLgoPHbEKRplHi3nMhu//qMYFrpgXeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:57:22 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:57:22 +0000
Message-ID: <19708df1-7f79-48c0-b026-3c69eb8c2034@amd.com>
Date: Mon, 31 Aug 2026 12:27:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: macb: Rename MACB_CAPS_QBV to
 MACB_CAPS_TC
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Conor Dooley <conor@kernel.org>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, git@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
 <20260807095012.640223-2-vineeth.karumanchi@amd.com>
 <20260807-juggle-porcupine-71281d2d9041@spud>
 <DKIX8UXQE9AW.3V3Y8P4USSJDR@bootlin.com>
 <080ab679-cd69-48ed-b96d-c515741101ba@amd.com>
 <DL0GSSXQPVDE.2O8IIQA60348U@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <DL0GSSXQPVDE.2O8IIQA60348U@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::6) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3490562d-131d-4086-3fe7-08df072d1aec
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xIZRWBMloR8OKg1IgU83Wly9G42DLuMGkCy7azGFXzN1iUXSriMGLdOZ42zE05V0Wgx2NKGbF9u26dlPbVzieebre9XGWbUikTV+LiwZ7Lrow6Tux4iMfoTKi+6AcyTDMkyTJfM+erzo41+GimA/6LJ8LbieW6lvMuFUs2U9rF32oJCCIMh/EAm8qTXOUHQE278AH4SLTzuMtX0E+vHSzSiHJjUgQfA119AGFIF+/kuVQDkCpRBrP99sRHZiEjfQN2/zhAE+Zj12N3fbraUq+nWHDZ/7VbfP6tnfjiPyZTh6UPlAiZT+h8ejwpLoIf0esy+JmSGEUyWE1fLCDuK7Dldz4qC2FYFb92kd13buYBlnSg1BNuFnO4ZlDR4qqQ5eYJDiaQ/qwP9Ax/VqpFvYlsDJXN/MniA4tpTmxEFkESYatLI4oW91m8odBrJbX4lJOe8fCszVL5qBvSSZh7jFvgL101VgLe837b5isItcuoo+I8UbxqofSgVfXla5Hk8S6gploKsJk04SsVUhIv54YPxHLk6DxpOEEyCANvX28HITD9/B4HEtNWFgsD5i/G0FrrkV7FwEARLYhbF4d5eM+gVv3FwFLCtx/abx4Af+pOw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXlWQS81aHZMQmt2MFBPeFZwdnU5cURmVlF0VUZVa0l6d3B2NHJScjlCL2xl?=
 =?utf-8?B?VllkTHZEdUNhT3FlRi9DejU0RnI0WFZiQ2NrVUIyZm5lYTBsbmpoNnN0MTlV?=
 =?utf-8?B?TFFXbjd1eklnUHlMWGx2Rk15ODdhNmlvNS93MXprNE5DcVVINEtDQlNZWU11?=
 =?utf-8?B?aUZCb3VraWZCZnIxK2V0U3hKNWFJVVpEcVhTQUswTm5BUm0xaklDbWt4RHhk?=
 =?utf-8?B?UGJBN0l4c3BEMEJqMzJnVllxZ244NkdZckd1SGNDTlBFdGJ2Sm5kN2N4c0xh?=
 =?utf-8?B?b2JwQzUwS2NPVld1RHk0eEJGd0FlYWVaOGdjSGQ3YTVCY1FvMFBBbTZLcVR1?=
 =?utf-8?B?RWtPZU5xUHlTOUt5ZkRFK3FrMnd0dmlORHZFNjRMSElOZ0lYckZ0SmpWRE02?=
 =?utf-8?B?UkdWTnNsS2NZMUNMTXluZmNtdmtyMW0zRGRVWitGOVcya2JwZUM1WEZQM1RX?=
 =?utf-8?B?dHNydVB3RDRQYitVd0dyN3B5K3BHcnNHaXpLMmJlOHdaVXJ2MXZtYS94ejg1?=
 =?utf-8?B?empsN0wzR0Y2TWszOE02VUJNQjRqQVNGaGI2TDdwM3FycUJPdFZUTW53QTFz?=
 =?utf-8?B?SjBpRExZZElIak1YeEdEbGlxWWxBQWZHM2VhSWpzNUl3SzJrNUhHL3p4L3FU?=
 =?utf-8?B?SDI1VXhmVnM5WkgrQkMweG94WlM0WXY2NWlzVUU1WEdGUloxVkx0SmpqU2sv?=
 =?utf-8?B?SkkxeUc5RWhaVFAvN21vbERiN2tBLzdVdGlvTzlDN0ZyK2xxVjU2YlNwM2JP?=
 =?utf-8?B?VE1yRG1GNGt4N2NKbmY4OElMS2dMY3AzNVlLMUhHQ2Y0Zlk1M2xrYVNmVjNU?=
 =?utf-8?B?L3NDM09DZERtUXpCa0xaN3ZaYkFTMEdZdzlKb0RDQUdKN2VZRnJMdzBrWWZa?=
 =?utf-8?B?bndadWhoSE9jTDBKekQyRmo0d1BCa1RJZmJWMVlvbkZ3a2Q2NWFLQXlXNVVy?=
 =?utf-8?B?VEQ0RHJpMXhOekJoNFZCME11WVgvdG5iaTR2MGMzb21oaDJBNHRCcm1CcHZW?=
 =?utf-8?B?bjNWMkdSY1VjTWgzY0M1dFB0UkcyK0ROVUpiSHp2OGZ2VU9VeG56MWxaZk80?=
 =?utf-8?B?ekEyYTZoZWZiQU8vMlJZTnB2VUNTM3hDSElDYlFtbFlZUzBDa0d0RjJzRU44?=
 =?utf-8?B?RkNyQ0pjcXhacHVJbFZNVXl1aXFNMkcyVFpkQitabEl6Y2k5cUVacHU5ZHda?=
 =?utf-8?B?OTVyN1RlYUEyS1plQ3NHRHJYb3luaFhqS0llT001ZVFKdVE3Q1pKVkIxc2dN?=
 =?utf-8?B?dGhjbERta0IyMlZ1VURiZ1dXeGVNRHpYNXZpTEQwVVR3SGNSUmlIZkNmMjFh?=
 =?utf-8?B?S2JiNWtLcEF3MmM1NUJzWWU0a2V4cVhtNEtoUm4zMnVBN0g1cGdEUTdmVnRn?=
 =?utf-8?B?ZC91TjlaMW50YU1Sd0crY3ZtcnRkejVPRWYvb2p6TlVOR2xPV2VnNzFqeVhT?=
 =?utf-8?B?ZlVGV1FyVlFtV2o3SjdWNFdUUG5vUFJXYkFGRXNrdmhkbU1yOVM5UTVzUlox?=
 =?utf-8?B?Z2c0alQ4VmdoaitKaEhienZ6VFZ5bjU4bEE0eUljdmJ2RzRlNFp4TkxXUkYz?=
 =?utf-8?B?Y0RmeEVKa3FMTGoxY015SDl0cXpRd05WZ0k2M09MUTZLU3g5NnU4QmlQQ2wv?=
 =?utf-8?B?R2V3bXNlcGJnNzdSWCt5eVp0SEhEQUNOclliTTQxdWd4V0N0Sjh4cXdXaUJV?=
 =?utf-8?B?Z25lMERKMmZwZFV3QWdBeW42NlpodHpoOUtMZ2xkcmp6ZGErdUNMT2k1U2g1?=
 =?utf-8?B?SmprRGlDcmJ3Vm1aUmRPdnBwYkZ2LzV0MWtlcVhvRk0zZWEzREhrQjNEaldB?=
 =?utf-8?B?UXdsOHlXaEFqMEszb0g2c3lGQktJOTV5UlpjZzJ1b2lYeHFSenV0SFZGN2Ur?=
 =?utf-8?B?UzJUUXZKMWU4UHY5d09sZWU2SlJMbHJGRElsRFRNTEpOUlQvUEZ6TnNMRHBH?=
 =?utf-8?B?amFISDlNaEsyY2luMG1qclVVbVhvOVp1U0lsY2xIaFFPWEN0ZkFVMGRlRTAy?=
 =?utf-8?B?dlRWdzdiMWp5SDNJanJsc0VoT21CempzUVVxNGYxblIxS3JTK1NDazIxeVVp?=
 =?utf-8?B?U3VEa2xNa3pzLzQ5ZndGTEJzTGc4Zm44WEZEUVFlV3VCWkE0SHNMZXJxT0R6?=
 =?utf-8?B?VkEyekdzN3hnTmwxcFJNZkszTmxROHlYa3RDR29VcnowenRaNEdUUEEwU2Y0?=
 =?utf-8?B?SURuYjlqZ3Z1S2RwQ0huZzg3a3EzeEtuaU10QkVlSll6VUM5TElVczNzL1JI?=
 =?utf-8?B?NUx5RDBsb1dmRG5TVzlGaGFsQWhVdTZvSzJ1ZG9TNllWNXdBNFJ2KytvMkFJ?=
 =?utf-8?B?QWVSV0RMSHozMDlxUFhjSnlzV1lRQTFSMzVBLzhkdGRWNlhYNXNMZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3490562d-131d-4086-3fe7-08df072d1aec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:57:21.9860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PSAkGP2qKA2VTkkYNFBhy1riR2YYPXI5KpEmSjlcUsWfuozhaX75N1xyOil1nj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

Hi Théo Lebrun,

On 8/28/2026 2:51 PM, Théo Lebrun wrote:
> On Mon Aug 10, 2026 at 12:11 PM CEST, Karumanchi, Vineeth wrote:
>> On 8/7/2026 11:56 PM, Théo Lebrun wrote:
>>> On Fri Aug 7, 2026 at 7:09 PM CEST, Conor Dooley wrote:
>>>> On Fri, Aug 07, 2026 at 03:20:09PM +0530, Vineeth Karumanchi wrote:
>>>>> The MACB_CAPS_QBV capability flag was originally introduced to
>>>>> gate TAPRIO/QBV support. However, GEM IP versions that support
>>>>> QBV also implement multiple TSN clauses.
>>>>>
>>>>> Replace this with a generic capability flag that can be reused
>>>>> by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
>>>>> better reflect its role as a general traffic-class offload capability.
>>>>
>>>> I'm not convinced that this is broadly correct, whether or not there's
>>>> Qav support (which is what you're using the newly renamed flag for)
>>>> depends on an IP configuration time define that I think is independent
>>>> of whether or not there's Qbv support (gem_exclude_cbs).
>>>>
>>>> That said, the only platform that supports Qbv that I have the exact
>>>> documentation for does not disable the CBS bits.
>>>
>>> EyeQ5 instances have both active qbv and cbs as well.>
>>> I see two ways forward:
>>>  - MACB_CAPS_TC aggregating the two, coming from match data
>>>  - split and use runtime-detection, see DCFG1/0x0280 bits 1 and 24
>>
>> This was the initial plan for the QBV implementation.
>>
>> Quoting from
>> https://lore.kernel.org/netdev/20250814071058.3062453-3-vineeth.karumanchi@amd.com/
>>
>> "The 'exclude_qbv' bit in the designcfg_debug1 register varies across
>> MACB/GEM IP revisions, making direct probing unreliable for detecting
>> QBV support. This patch introduces a capability-based approach for
>> consistent QBV feature identification across the IP family."
> 
> This is surprising to me! What's the source? Do you have AMD hardware
> where DCFG1-6 have diverging layouts?

Yes. The source is the AMD register documentation for Zynq and ZynqMP
devices. Some DCFG register layouts on these devices differ from those
on newer devices.

For example:

GEM IP revision: r1p6f4  (revision_reg: 0x40070106)
For this GEM revision, bit 1 of designcfg_debug1 is defined as
"serdes", while bit 24 is reserved and reads as zero.

> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

Thanks
-- 
🙏 Vineeth

