Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3837B41F;
	Tue,  1 Sep 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256175; cv=fail; b=F5HYBzvIkwHYifMdOe1bD3p2F+VhGOLalLBuVLX9WyENT+X5w9edEG5J//ZNfA+EO7v/QskTP3kLPXp6xF8SE29GkRwJngygSErhQuwI9wyCbMj+CWyImhe3t6pguv16T6dlFGSZu/QUxuVAN9WzcSW62VQ55k/EGqTe5BIBmRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256175; c=relaxed/simple;
	bh=PYlAOBPhbrzSnYmUmE9MPlxHUf+Vhz+97MWrfq+E6FE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PFzoFzV9tnyXgvV0Qh3W0pcUNiTuDKWybM4yu5W0f7rW3GfxjofrliSZByIzGUY0X/2k8POHnoQCqammEcYX6d/xPJwaYTz/Ln8kNWQNsRfM2RgUPnPN3seVSeU2aAzyJQqgjEddgsAQ6UqStGEGJotXoviO6AMwH5qguK3/OfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gifz+haz; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gifz+haz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqNFYlyn6YOzKGN/1Q9lh3mFKIX6/KiRd15fAriHABzdq3xC/HgOedW3sSvldHNfuMp9VwIXCJNHZTuBsitEwWoFzSKXEwNl59nQnmRPMAEcnoorhhP8XLHMD6AFwWs7A9wra7CgJwrW3hhf551avQvkqS/RZAz6N79QFYoVELofyawQF2/gDGOYsf0zZKgkkKIBPjSJqmZPWCbiecvA8jWaUPkFa9bnQNCuYlkNdbrIoLMXCUaXUEkkJtvjshm4kgPaN5r777mIukguQeSV0u0gQ7oml8OelDrzO5S25FYludsiSFOBYHRpCI9d/NTrgCkUxZHaesOcCdnByc/Irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF/tgVzqz+c7badlcVgxETDbUhDXEBs/oB2xj1eXW2w=;
 b=N9B3E7e5a10RgRq1bW99Hz+v3l6dWi/r0UbXH+j1X3r5V24yg2HlFmP1RIQlmVSY9OafN2pigGpMyfIvdysgO/oofVMz0zKuM90+Ipm+G1Jh01DOncNqTxKr0F+T31N7pXP49/CjvMqOaPxWiM/81ZVQYB2LIGTyemen392nrdTLGhdse1NnARFb/1od0HX3ZugQNJJvPRBh+ERY2nyN1gy315UY/OUB6J9LbkRBP2x0COwXEOZH9X2a+v9gGJFPGpJZ6SY4pV2jG27FJAP40hKLMwlWwUrVxBwUz9rEUmR3zARU95MeY/YvfhSLKb0RaWWBuskm6AEuaCeVvC+6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF/tgVzqz+c7badlcVgxETDbUhDXEBs/oB2xj1eXW2w=;
 b=Gifz+haza2ejnu2ezfGq0GBB/dSMyd+WyNYLp4RmuW/KoqJdp4T6+pjB0+3avUx838YElA2pTC/W1RKwyGo1Y7iqM9uboumZKF/BP1tismBc7GzV1cJOmr/qchA3EO7YeDZzwZ8Cvb0zx5/tdcLc8m4eGTWJ14Wes/YJUU7P7/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:49:28 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:49:27 +0000
Message-ID: <5573c94c-db2e-4fb4-af19-c9764f0a74c2@amd.com>
Date: Tue, 1 Sep 2026 15:19:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: macb: Rename MACB_CAPS_QBV to
 MACB_CAPS_TC
From: "Karumanchi, Vineeth" <vineeth@amd.com>
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
 <19708df1-7f79-48c0-b026-3c69eb8c2034@amd.com>
Content-Language: en-US
In-Reply-To: <19708df1-7f79-48c0-b026-3c69eb8c2034@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0041.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::15) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d42848-6b8e-4176-69f6-08df080e502d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FBoF/m2z7kqB+qYomqIjwMQRdj25H7vVj42BhaoxnTZyKeWDldpvmyd/2YrnB9fRM4ebEhepdDcAgt9g3Kr/kPR0zuTWAW3vKEKazY+0+K+1U9j/Umxj5XwpiYTk/4MpclA9hUhmixFaazoejpn+vLR4KegWW6ZUMcBT97rkDgEA1C8rfMB6YGTi548bi0PAzmerJ71RXEH6tLCu+gp5WvT0CdAxhnW2HmbgtVaoYdBCDjVxHmfnwdC1Tb5jKbCJt+tj50185RpSwlhsnjtw4HjVsFfl3yMvkH8F4I7rS/QIT5t3O+A4SMTtKRdbWLKgj016dr8PIswi6PRdaao7xA3DxvcoGFcPAkqk93qFKRJZhiBc6VI33ERy3spggjRQ2pp5/r4BH4dJmIS0rDPiYgbOg39C0GSZVblQyx6yyVqTKhJr/ForhThtYdqHvL2SG4Vqt2xPx1YjP1vryIeFaziEXQsbXPgM2Egi+gvdI/sMl9TKKy9YPr3geM9z+PlMBtalUvsYURiRKjYAz/KCHdkhvq3DrLUF9PAgaKQYG94Ic4/6r3US7OUXDwspxKzxNx/eajzFqVfHNdVer1YxvWps9AcjCX6Lu0/CE8vMKdM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzRGUU5DUkNGRUZQa1QzdDZyTE9CMldFdnFJc1U3Qlc3MURVUnFxd1V3d1o4?=
 =?utf-8?B?b29sQ3J6L1dJRzM4NlhoTTIrNUdDd3FwaXlLdVo2VnBzOUcyWEcrOWhEQmFJ?=
 =?utf-8?B?cy82OHVlb2FXOXYyajYxMTdETERoZHZiQjJOYnVQaHlJWG1HejJPaHdOVWJo?=
 =?utf-8?B?Z0hZdzNUdWdiSVNjMm9Tc0RvR2ZGWWJ0aTUzNUFRbTZmeTlnN0dRZDg3OHFV?=
 =?utf-8?B?ZHBYTldDNzI0OWd5blQ4SnJxZWlmbmdvL09HbUZyNU9XY1A4WHUzdW1rRGhw?=
 =?utf-8?B?dDRGTnUyU0FTTVNwQjlJUHB3UmhYS0J0OVo5ZHlRb1dpU2Y5NlNBV0EydDJZ?=
 =?utf-8?B?eVJWRG1EQVRTSnpUM2tKVVpFSlJIRUowNlpZdm0vSkxiWTZ0WHZxRk9JYjZu?=
 =?utf-8?B?Zmt2Q3Rxd1lJeGpjMTZXd2dhK1dtTDBKWjR6QTRGaTVtNkRZdEUzcHA5RHNx?=
 =?utf-8?B?ZEJNV0k5TVJyZWZ1Z215WDZFcHZhelhGZ0tzU0ZrUk01bXg3bkVaVXFlNU11?=
 =?utf-8?B?bFFmOEdTM1pHZkJMTFpjanFFTmExd0R0a3BiZEt2eHZUa3B3UElVcXk3akhB?=
 =?utf-8?B?OHEvWUFMSU4zMFArclRPT2JrUDNDbWtmNVdqMmFXcGhyVDhickJJdGxGZHdD?=
 =?utf-8?B?bE1QS2FLckJxcWtRVHNza2phbUpPOENRYmYxK1ZlL09yL1hjdERMalI2UHRq?=
 =?utf-8?B?YXpjYjg4UExQWlJqSHR0UWpBOVl3U1l3SEo0eUorRVZaY0M1ajhNVzA1cmR3?=
 =?utf-8?B?KzJySVp0REFMcWgwRU10NWk2UEJMYlZiTnN3d3hkR0J6OGkxNGp4WHpwYUNC?=
 =?utf-8?B?L2VDSWdlWEJJUVlyeEF6N0VFMStxTGp3M1JYdXgyM2dmVkphY01iOHJIL204?=
 =?utf-8?B?ZHJxb1lZZ2RYZGM5cks3NFVJNUdha3BKN1dFSFJUR3kvWVdGTGI0d013TkZ6?=
 =?utf-8?B?M1Vjci9TL0tRQ01wa3B1ZXJ6UzNBMUJSZ3FVcHNoNUJORUkzbW1pbThKOEla?=
 =?utf-8?B?dy9BclNXMDB2QjNZZmxRKzRvVWhWR282N3haN3ZpcktxOUhxYlJJampJeVow?=
 =?utf-8?B?MjNoblZLN1hqUmdrN28xc0RlYThmWkh2OU9yWFgveWkySlpuVFAzU29EWEhY?=
 =?utf-8?B?NExYNXhPcWI2N1Uzd1NIa25LeTBsQzVOSk5ycHQwcDRueXFYaDMyT0VJMXd2?=
 =?utf-8?B?Ykt3cFlDMkNDQnVycUZFanhmYVE4ZWU1WkgrTVFGM0tLMU9KelNvNW80ZjVY?=
 =?utf-8?B?eEZtVGlORUtuTnhyVmhVaDlvamlwdW8yakI3U01RTGh5ZmRoQzU5UjZVMXQ5?=
 =?utf-8?B?UytjSnA5QW1YZ0J2RlhwOUdwSHFtY1h6WGtLK0ExYytwaWJmQlVJU0pFaGZr?=
 =?utf-8?B?UXVDN01Edm5zbEZabjAzMm1zaXV1bnNnY0lQR2thNTRqWDB4bU5nR3FLTk1H?=
 =?utf-8?B?UEdkcVZXTnkwM2VaWjdLTzBaVjdLVjg4QWFONWx6cDZKaTM3TzlaeTRUSTVW?=
 =?utf-8?B?cGsxMTFwdmVwMDhKYnZIZ1ZlTERVbEJPZ0ZNZDdwR0JrY2ZJaEwyYy9UOUFF?=
 =?utf-8?B?aDdTV0FnQVhaNDhzSTUrQjNYUEpYQXNFcHZXRUFMQ25kMlBPNkVwODcxNi9N?=
 =?utf-8?B?OWFpaXI0WFV2dzhEZGdySktXUzhzaUViS3dEOGxxRVJBQjZFS2V4Mk1kOXp0?=
 =?utf-8?B?Z2FzTzl2M0o0TkhEUXdUTjRsUnZKMkJDaThCZ21sZVlMUGYyOXRXTzJhZ0lq?=
 =?utf-8?B?ZEszUFF2MXRJd0FFSlFOSHE4YlhIV1AyQ3N4dGhXWjV1SkxmWWs0TlFtdHFz?=
 =?utf-8?B?ZWdobis5VUlETHVuQ1N4OEQxY0xrOU9wb2NqbWE3NmdKN004Umlkd1BDekxs?=
 =?utf-8?B?NGk1Qmg2ekVZRG52dmtIVHprNnBlTE9SSDk2UG51MXB3b3hQdEdYWXN6Q3pK?=
 =?utf-8?B?dXVMbUNsSmdSTWNMdkNTQVF6cTV6WTdCOXRhc0dBRksxaGpLQVBNNnJwKzVV?=
 =?utf-8?B?WmJIMEVwSHQ2ZmlqZ3FYWXpPLy9DT1ovYk5WdDh0R2toSWRrQm1iak04NDBM?=
 =?utf-8?B?aEVLTkFtMXNjVmtERERIYm15VUVZODd6WUREMEp3R3ZCelg4SWMzNUxLVzZZ?=
 =?utf-8?B?Q1duYjNQYUdIVlRnMldvNnQ2aFErUzZKYlY2ZGhMNWxPRnJQYnRSVDJ2MlNr?=
 =?utf-8?B?NTJHTFRyNmJkUnRGS3NBUUNva3Q4NTZZU2drVlZLaU5LNUhpY25hSW0vOTBM?=
 =?utf-8?B?cXFKczVRVW4zRkpRczBweEFKYUVsanZ4YVVERWRsNFRNb0RYNmZQcUVYNzdS?=
 =?utf-8?Q?62g+GQAMm/3owROBe5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d42848-6b8e-4176-69f6-08df080e502d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:49:27.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKEdtfagu/EQ4KCV5P1bQZKQ9QHIqZuDftDdmo/0rNtv2D1wSc4BSTAxWynx53zz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

Hi,

On 8/31/2026 12:27 PM, Karumanchi, Vineeth wrote:
> Hi Théo Lebrun,
> 
> On 8/28/2026 2:51 PM, Théo Lebrun wrote:
>> On Mon Aug 10, 2026 at 12:11 PM CEST, Karumanchi, Vineeth wrote:
>>> On 8/7/2026 11:56 PM, Théo Lebrun wrote:
>>>> On Fri Aug 7, 2026 at 7:09 PM CEST, Conor Dooley wrote:
>>>>> On Fri, Aug 07, 2026 at 03:20:09PM +0530, Vineeth Karumanchi wrote:
>>>>>> The MACB_CAPS_QBV capability flag was originally introduced to
>>>>>> gate TAPRIO/QBV support. However, GEM IP versions that support
>>>>>> QBV also implement multiple TSN clauses.
>>>>>>
>>>>>> Replace this with a generic capability flag that can be reused
>>>>>> by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
>>>>>> better reflect its role as a general traffic-class offload capability.
>>>>>
>>>>> I'm not convinced that this is broadly correct, whether or not there's
>>>>> Qav support (which is what you're using the newly renamed flag for)
>>>>> depends on an IP configuration time define that I think is independent
>>>>> of whether or not there's Qbv support (gem_exclude_cbs).
>>>>>
>>>>> That said, the only platform that supports Qbv that I have the exact
>>>>> documentation for does not disable the CBS bits.
>>>>
>>>> EyeQ5 instances have both active qbv and cbs as well.>
>>>> I see two ways forward:
>>>>  - MACB_CAPS_TC aggregating the two, coming from match data
>>>>  - split and use runtime-detection, see DCFG1/0x0280 bits 1 and 24
>>>
>>> This was the initial plan for the QBV implementation.
>>>
>>> Quoting from
>>> https://lore.kernel.org/netdev/20250814071058.3062453-3-vineeth.karumanchi@amd.com/
>>>
>>> "The 'exclude_qbv' bit in the designcfg_debug1 register varies across
>>> MACB/GEM IP revisions, making direct probing unreliable for detecting
>>> QBV support. This patch introduces a capability-based approach for
>>> consistent QBV feature identification across the IP family."
>>
>> This is surprising to me! What's the source? Do you have AMD hardware
>> where DCFG1-6 have diverging layouts?
> 
> Yes. The source is the AMD register documentation for Zynq and ZynqMP
> devices. Some DCFG register layouts on these devices differ from those
> on newer devices.
> 

https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/designcfg_debug1-GEM-Register

This information was taken from the original Cadence IP documentation
for that version.

Thanks,
> For example:
> 
> GEM IP revision: r1p6f4  (revision_reg: 0x40070106)
> For this GEM revision, bit 1 of designcfg_debug1 is defined as
> "serdes", while bit 24 is reserved and reads as zero.
> 
>>
>> Thanks,
>>
>> --
>> Théo Lebrun, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
>>
> 
> Thanks

-- 
🙏 Vineeth

