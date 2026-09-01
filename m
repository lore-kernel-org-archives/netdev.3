Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17747345EA2;
	Tue,  1 Sep 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282126; cv=fail; b=L3pJ/7QzM3VDzqFWJdHdWPhLCw1fex1znmTigtKqQNdZgj86j7ioBQq7bCq3ScDqYqHZAvQh24wruqjc8RN2R+F7tZQgoSzF6A2UdFZkZ8EawAFND+yq+4Ipvn/+Y2KbpSqSCTAqa9dtszaiD6UmuVxQNiubmFFM141gcwSG/Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282126; c=relaxed/simple;
	bh=ZV7iqFGrBjrrOEKOlmPztrsv4ewhBQotUhqIujczwhY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ezfmc/RXWzIIJk4Lva/lov0BVQIEbXBI1CEhcmpBtG8jB/FV2LvHk5GaUeGRGw7ghcPObqsysKHbc9gfMgQDDWWFeff2Cs0dJjHCErWh/NZHPbm3kEocPwG2e2O7YoA9qnRFCmWeV30lRe2kXvZeKUlGbkmnf3CCGdi5PtU/IgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5SAWdzqC; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5SAWdzqC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re/GDW9XiaerK/a9a95GFks8+K6LB7QeGyKsyFKZ2/gYh3dRbYSvpd4cAWGEMeLBqVVJ3DMMPTXpTaYAYjiW6fkbtEZJ5yulex22+4R7XhUo7dCAqhLrvn6sp9HgbieZQZQIqdLFA4yqK6eCV+/r1QgjRWyST7O1ifbOu9aKadigWVc94XwRsISgoQkWJbPQaK5lQGDti2podSsQEuPBqGI6K/GsArCW5qzqI9AGjxAIdjsTCTNsgRLWa1tZRTNYGQdrcLFh1nudQjOLgWiPXFqgmC7G5WjBkGmsyZh/6bU3MVpddI2STxy6WDRnnB3Bphyr9FmYc61PyfpiHqtJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLefIa8Mrh/aTZAMwrh+JCwyU3O8JQ9MIQ5ATlA7HxE=;
 b=wzTDbIzp/WzG4rN9YqhOi6zBaoCAlvETtGRVJ4/fq4mdcpb09VhPvxA1Y0aUoPqQF7aMfk7UnvzF5P/7369EGI4yFXaClQCuqPge9J4WIIxaFh1cLqHjqmj0z+JRMlT2XRLbnsyR/EZ6/MUvX8var7+8PYdSD9SkiH9480qLzvFZR+7L5qtCmnlNxe+50QYTzGXax/3MGf6Adha5Xgv9bRgXTOHKiUn6Rpl2RoxJZUubL6vfZ+7enY7kx+KrP8HCWjwJOWPlY3Swmk8VurJNhVqp44zn+NZaSuFVYOyqFnbMSiutN/vEq0Vfbc1D3uTDGPLfZrBoTk9VdZyYCHPS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLefIa8Mrh/aTZAMwrh+JCwyU3O8JQ9MIQ5ATlA7HxE=;
 b=5SAWdzqCUFiw0lNLJQxQ5E7jFV2fYfG3GUpKpRE0G82VZIdO2lTS4uZhfTXpJLMl6mPeaOgP0nZG9ANrSCliWcLLrjYtTt4ASnqkNoZXmzu5wYYrMEMY1wij4F++65LNIdOhgEQO+k+tT/XWtt3co/n5tpLMhVgCgDRRGZTjqcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 17:01:56 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%2]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 17:01:56 +0000
Message-ID: <320e31b8-7e26-404e-a1bc-d19ecb59ff3d@amd.com>
Date: Tue, 1 Sep 2026 22:31:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] dt-bindings: net: xlnx,xxv-ethernet: Add
 Xilinx XXV 10G/25G Ethernet
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260831150816.1020883-1-suraj.gupta2@amd.com>
 <20260831150816.1020883-3-suraj.gupta2@amd.com>
 <bb36094f-07d1-49fb-be2a-ffe126e1b919@lunn.ch>
 <9717ad8d-0117-4320-9d6c-dda6b712ecee@amd.com>
 <b5126d72-734b-4f4d-b953-807579c8583e@lunn.ch>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <b5126d72-734b-4f4d-b953-807579c8583e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::9) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c8f8b9-4c53-41ce-4240-08df084abac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|6133799003|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	GGHkoFoWukGsBdp9WqQgmxbPXiIupEQCyPsGW9YwN8wnzoUXUtDxu9PMSBnJSvmRqLgUCPi9z7JqMtmBygwoLBA0m7BRdzBP4Ai8bxaVWoXbBFOKVjj6RYKYh/Mtn4xtXJxMqgzi6JUyYcpbyyO/qw3DCZdjBIabcAXnEnqPBAG4a8ABFhYR2rl7MYfUer0FWCsxUSCGBYV0irOTya/kH3SIRt3it4P7+sgN3cYjAqdHtMFQVzcn6W9id7wK5diKPWVhfB3dK7vy4APZI2eO72ZoDSuGwiAKDVneLQMBVu97bq4lLOe3C1JJS0ld1NxoGpFfsdIAJ/wBe+bnBO3Qs5Umz/KcLZuQuomuERBa1zR+OJUh3/9SfB2QBoKBRNxdW/1QhArKadu3Mp9HgpMmc3ILoFaEHWCuXLxDJhsfMrEn6488OquUrhLYARYPOuJaBe1pwzgfZ18ELGmcD++f4U6d3xuXqhCIFysKvNJcRfvb1Hagi+fWkrjr8kHAA9lT8e3hEMXAp/Y5kHHU/2wUd+Eqid8i1CoQp6CbJhADrFkczaVE5zY5pQMerxMKs4YBzBopUMOEud/LPVy4MSvqXnKBd8bPwhX+oADnMZQq9SZbhhfgPvPh8FbtVxfH5Xtf4wWVzkMzknVz+cR9rjrexHBOSF2/t9laBTWO59TvdeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHhFeElETFQwb3dPMTNZdHdnYkNpdHBoaXY2V0ZOVTRtb1ByQlRUZ3FTVFNn?=
 =?utf-8?B?b2ErbGQvVU0rVktLRkdzRjVFWjUxelExMFkyQVVJTFlyTXlFN1VVOTNrZTBH?=
 =?utf-8?B?R25vVzY5OEtUZ3hWS0h4S0dYUnFLYXJNN2VEVzhTb09vaHFrQ0t5elJlRDcv?=
 =?utf-8?B?RnFDblN4SHZqWkZzMGpKaFVNazJHaldYSkJSM3FlNkhtNDdIUEQrSktjclh3?=
 =?utf-8?B?ZFNMY3hBL3FMYVdteWpJZk9uMGxwODV5VkFpUGhMZUthWVlIVHc4eGpIQ1FZ?=
 =?utf-8?B?UEQxRE9sK3Jpc1FpR0tFd0ZwWXRHUnU1UGZJeE5QRHI3TmFaMlN5bXJhZ1V5?=
 =?utf-8?B?SnFyZGRsdXZ4YkhTZTlMb3d0OExsaElkM0swUUtpeUNnSWgzM3FFQzRGV0do?=
 =?utf-8?B?dkF5NjJDNndUSGR2bmlOc3I5Z1pwcENXNm5GRTRzQ0lETjNRR051dytGRm0r?=
 =?utf-8?B?WjVNbXBkeU5LT0g3akJHS3A0Qlh5Sm5vMnhIS3FkZlFsWU9jd3VkS1B5ZmdU?=
 =?utf-8?B?UXRwOTFPVjVGTTVRc0E3TkVMb2cvWFNWZUozbThYVHBLeFhxdmVpRGlBQVBC?=
 =?utf-8?B?NitBWTJxQlNBMmV1MG96T2d5MUYxNVJXNGZsQ09CYkVMWFhlYlRPclEvKy9n?=
 =?utf-8?B?dTlHc1Z1aCtmdXh5enVXUk53bnJzUjZrY2FQUFpaR1VQNE5yTW9kdzN4Z0VC?=
 =?utf-8?B?enU4dzg0MVl5a25XVGt6NWZKeG5GM2dyOHd0dkVuZ0VWd2txc0JQaFdZOGxU?=
 =?utf-8?B?Z3IrZk94VXFBTisrRm1qMGpZTzRDL0JVblNaRXM2Q20rU205SU5KOXc3dXJv?=
 =?utf-8?B?cFVQMEk4Q256UGJRa3czZmxWTTBvbmtUeWNmandrSUJva2pOajZNQjVraFlq?=
 =?utf-8?B?M2Fvc1VZQy9kVHdmYlFLL0pXWkJiMkR2OFMwa1JMM1NIZ0RPMlF2UmxHdnVu?=
 =?utf-8?B?cjYyR2tMNkg2U0l2MngxTlJuZkxYL3RLMUMxbXRLRlFkb3RVR3kybHlMME1l?=
 =?utf-8?B?SGJKVis1OU5mMjEyRnZhS29EQzA4ZitNYWlxL2NTY3FkdzhPZWd2czRYS2tK?=
 =?utf-8?B?M1ZtdDRPVk5yVzhKMGFvL3pJWmZTajIxZnRaSDFGTWxWV3lySkNHdWlBNEE1?=
 =?utf-8?B?dVJDTmJrYTlBQzZ1LzQyeVVGaC80c0N4OC84QWRjWGtjTVo3REZoOHhOYTda?=
 =?utf-8?B?ck1JNTQ2TkN5bkFRYkExd3F3REpWb09yY3MwYTY2bzBDd2gwY21sS2VLV200?=
 =?utf-8?B?N28raFVvSnBTb3BXZjlaNElHNDdWZVFSMlZhMHZ0WUJvcWFxd0RWS3h5ZWdj?=
 =?utf-8?B?QXZkUXoxQkMzb2dNVDg1RHp0R2cxbVkvbXhEUU42djZVbDFBOUNUZ2xDSVBV?=
 =?utf-8?B?UkJLTGIwNkVQdGJXT1NhQzEwOHJHbFBnVTVBS0puNEJZVmNPM3lMMHdtbHdS?=
 =?utf-8?B?TXM5R1A2RkgreHBkOEc5Qjg4ZlorZEl6UW5BMVpYTHVQTG1ZbEtMYnVpNE0w?=
 =?utf-8?B?c1htSGJvRFlYbUxZaXhRNDVySXM5M242Nk1CSVE4Q1FMZStxOXBueUpiNUpR?=
 =?utf-8?B?dCtDbGs5NWdnb2tONkNIYWR1L3UyYmlJcGYrTlVZUU8vY0pmeGRkOW5Ybzcx?=
 =?utf-8?B?WkZkMW8xb211TjV5K1NkM2VOU1lKTkJpWXFlbTU3V1Qyd1hxamNmdElYWnB4?=
 =?utf-8?B?eS9oUGxyNzYydHFnTjlLTFBKRkhIZGlBMjNVVytvRTdYWW9XR1BKaG1IaE15?=
 =?utf-8?B?QnBWZysvQkJ4Ui9IUUR6REU0VndrSzVRcDRZdU5uRjVzL0s2Qnp1cy9MZjhk?=
 =?utf-8?B?TWl0RVJ0YWVDU2ZZSUNSRXVaL1VjOHBmYjVhQ04vQlJTWUZIMW1id25KSjBR?=
 =?utf-8?B?RnpJWG1Hbkx0U2xlNGhwU01FYjBDelppNDd5ZWRTbTJRY2kvQTM0M1grQkhC?=
 =?utf-8?B?Und1emFpYUJqMU11U0p2Y1ZuYjFIZ28yRnhBK0l4Rmd0b2p3a0hhYWdJUTh4?=
 =?utf-8?B?T3J5Yi9SaHRUbWNNc3RiVXhEcGRPYUZjTTN2NFhsWXhFK0hlWGZvQ080cS9j?=
 =?utf-8?B?bFlwbjdJQWZ4cmJySEVPU3dDR0Z0QkpyMkRvRTI0M2htcjA4QlRtaVYxSU5J?=
 =?utf-8?B?b3ByRmVGU0ZQT0NkZnFzeEJIbkFQWllHc0VoWGlic3hTbE5yV3BhRDV4WGQ5?=
 =?utf-8?B?UGQzM2NUYS9YeEVQVUlONllFeW1xQ0RSSEM0bWtNTFhYMUNJQkJmQUZMejBG?=
 =?utf-8?B?a1cwQ0VpV1h5eE5rUmxScmVsdGEwOFBhMmdjNGFNNW1zS2FhR1h4ZVA2cEg4?=
 =?utf-8?B?d29TV1RrS2ppSk9KMVJtY2syZEtqVnBWLzkvMlFhMC9XbjJZZHZTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c8f8b9-4c53-41ce-4240-08df084abac2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 17:01:56.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VWPbA9Q4yvlGRfUTGOKP6XIO7sdclTD6tZxONs9wsz5B6izBnStdFpvAbXSDocx8pmug75Dvz8cTIcbHs8/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222



On 9/1/2026 8:01 PM, Andrew Lunn wrote:
> On Tue, Sep 01, 2026 at 08:48:18AM +0530, Gupta, Suraj wrote:
>>
>>
>> On 9/1/2026 7:57 AM, Andrew Lunn wrote:
>>>> +  The Xilinx XXV Ethernet Subsystem implements a 10G/25G Ethernet MAC with an
>>>> +  in-core PCS/PMA driving a high-speed serial transceiver. It supports the
>>>> +  10GBASE-R and 25GBASE-R line rates, with 25G operation following the 25G
>>>> +  Ethernet Consortium specification. It has no external MDIO PHY
>>>
>>> What about MDIO bus?
>>>
>>> 	Andrew
>>
>> The 10G/25G (XXV) Ethernet Subsystem IP does not provide an MDIO master.
> 


I'll try to make the overall architecture clear, please let me know if I 
miss something and additional details needed. The datapath is:

DMA (AXIDMA/ MCDMA) <-> (XXV MAC + PCS/PMA) <-> GT serial transceiver 
<-> optical module / backplane.
MAC's in-core PCS/PMA drives a hardened GT (SerDes) transceiver directly 
at 10GBASE-R / 25GBASE-R, and the GT is configured over its DRP 
interface (the "drp" clock in this binding). There is no discrete PHY 
chip and no MDIO or I2C master inside the IP.

XXV ethernet PG: https://docs.amd.com/r/en-US/pg210-25g-ethernet

> O.K. Please change the wording to make that clear. There are plenty to
> 10G PHYs available, but it seems like you do not consider that a use
> case.
> 

Correct, the IP has no MDIO bus master, so an externally MDIO-managed 
PHY is not a supported use case. I will reword the description in v4 to 
state that explicitly, e.g.:
"The subsystem has an in-core PCS/PMA that drives a GT serial 
transceiver; it has no MDIO bus master and is therefore not managed 
through an external MDIO PHY. Link state is taken from the MAC's own 
status registers."

> Has the MDIO bus master been replaced with I2C? I assume you intend
> this device to be paired by an SFP cage, so an I2C bus will be
> required. Is that a different IP which needs to be licensed?
> 

The XXV Ethernet core contains neither an MDIO nor an I2C master. When a 
hardware design pairs it with an SFP/SFP+ cage, only the high-speed data 
path runs through this IP: the in-core PCS/PMA drives the GT 
transceiver, whose serial TX/RX lanes connect to the module. The module 
management side-band -- I2C for the module EEPROM/diagnostics is not 
part of this IP. It is provided by separate board logic, i.e. a 
different IP: a standard AXI IIC controller. Those are general-purpose 
soft cores from the standard Vivado IP catalog; each has its own 
devicetree node and binding, so the SFP management path looks outside 
the scope of this Ethernet binding.
Please let me know if I should describe sfp in this binding.


>> The contents of the appropriate MDIO registers are available in the IP control &
>> status registers.
> 
> What does that mean?
> 
>       Andrew

I meant that the PCS/link state a driver would normally read from a PHY 
over MDIO (link up, resolved speed, block-lock/RX status) is exposed 
directly in the XXV IP's control & status registers, because the PCS/PMA 
is in-core.


Thanks,
Suraj


