Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D2448B87;
	Tue, 15 Sep 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455732; cv=fail; b=LWDKDVEjwtzowpJ/cwiTRSR2jwgppRiEgzfbjFd9EANlGNVbKQbaOFa7xNWvIwOnw2eiTp04w+sTjLEBTdXwxf9VJQdL2LarylapK3gjwYPWjU2BEjUtcB6UD4Rr8KvSpuX4TsHdZpluxUNEwb6QS7PFJqfPBnVDlRlU+Iz60uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455732; c=relaxed/simple;
	bh=MbvrD3qmMeERQKtNAzSPLC1P2fhRXgelJj7DTnlXW9g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tb0GbJcal5ZiE6PdrLbSyTEg16fW19QVms0AsWyr7iwQIS+Q1Ruqnq3AsR/ctdZVgQLUx+/O+7LJUHy58gdwaOHA96Q5S9LdJ9mpCO8rcNelsUv4vfxdIY4AaYt7zWKyJPGGPto/sXmthDlvOOaOyZdNGEBkDjnR/AX4IIxU6IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ppJS8Ay; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ppJS8Ay"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7gnPClcKWVOgA6oktSiGQ5WKr1Ppg0t7a2p2P95bkiXRe7pH+j7vtamld6EPYYjuBUvNudiCG0k4QaxPHjOEhHDOPy/0JYVABI88zx/cAc0GDm5s6/9msuYAurotv5aEgX/Lo7au96b7ICrE1AFG+4P3fYQcq+r0nawJS0Lq5ZsMX6l6xOdxKzR7/75ugKZhgSwE1rx4n5Sf+vsQ4aLKeY0qgTgLgUQ5grIHNTFeiOSB0jzqRS2+ksICU/qaJgw6UDURvnmhpp9uJpYM0KWBaEvywi7QfJJxgBh3HM7AeW9nQqV/yfWt2GM0hpS2+6rMfkFQ9ZQQMNIVWYrpTfFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVgDtpGr26zEBIKKvI1fzc6RfgVsM+fCIGtAtWfAB9Q=;
 b=Xyxjd+OHVhc00IIiMc5ebPSPmYHX/A+uRyKzyBlo1Eu+FP7FeV2y0y/gcDYDS5Bl8l2KJATcKoGbbyeIQ8SoP18xJ/cetTLqyFkNowYxjtHvDcVyFkRVYdedJ5zQpGe2aaiuBDe94S1ayWK4A0fhPitGp5BwmOLnOvmBlHB1wcU57+Lj872kSg2U3xr3/gYUSZRfST4FMRaMG5UcyIEgaW3IRT68nIqrOIFa1P0hLlEmav4NQVKIJginjP1QrRlsGc0jmv+xdnwvJ7NGXkPe16yZrNHL68bG/Hm67tUA9uQdknSQtPL1mx4z0UMnLYUwfRCVi95NnzjqV1WsCTP96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVgDtpGr26zEBIKKvI1fzc6RfgVsM+fCIGtAtWfAB9Q=;
 b=5ppJS8Ay8Lb6kCP06QvM6nzSHPPjXzZzOosif5r0weCWLKI8o1brcSqMo1eI7Eh31lkPNziEvV5AG0+CnY4cAXDPb24bTUwOHhQigbA9KqqvUyjjg+El9lGgIaMPWUWH0wU/vfKXmMXnxLq0lSuINpP6byExY2rbD2F8v59HXRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:02:00 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:02:00 +0000
Message-ID: <023a2198-8187-44d7-8f1a-bb23351f9920@amd.com>
Date: Tue, 15 Sep 2026 12:31:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] dt-bindings: net: xlnx,xxv-ethernet: Add
 Xilinx XXV 10G/25G Ethernet
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
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
 <320e31b8-7e26-404e-a1bc-d19ecb59ff3d@amd.com>
Content-Language: en-US
In-Reply-To: <320e31b8-7e26-404e-a1bc-d19ecb59ff3d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::17) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e93f1d-c768-4b6b-8b62-08df12f73ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aifsiEt4gR1HolBQaREDXFdYm45B8UeHwjPmvVAL1IgdrBtj8JjkXVeClnS/GHz14Rd6DuNEOTpg7BVt5jsQByZtuk3VixtYVyzO0HmOmEjymDsJu7ZfEjRMlcbvOtbgAqsfxWrGUTbDHVMqg6ek8KJPxk+De34DLdLoN8M7DOkBiJlf17aHL5g+CHcMMT4c+qRaUJ1fUihO4HRKXf3YH1z8ztnmWtOu9CQ9c4ilagl2HAaBEpBqsJOpRxsSBId+bcCeVk0adMegdxxFA6kx2TDGzTuGp3H8U0FWwKE4PCXd4Bpr3NSE9cYfzfWlQniqNc2LRdV/lTCMXAiYOxdphG144YIMiIkfuJtMD7bkNiJrYDbvAimFLrtxaMp/t+CFIxZK1r41bMBG4h1G1K4qXxJ3ylKX4wOdE2e6u+NihsYRql3jBldmpWeoICtM49dMvbdG1d/I62QX3HyJ0uUfH8hNNVYqGuxsJR8ypnk+aRZ7/TGilTWp/xwvTE3wdW7PpECE39zA9Gb+qe/5QrAwBptZexCatSmEPypj0Ydd6X8NKb9Sy9XfxQqEe0UaaghuT26ROrQExtWQH3SGCJyY5LalNBiConkoYv6xRe1OUtOiPf9TiacbnMiVkI+uSAftrPgefmc0kgaifriudkR5z52Gkd2uIE6Ju+GMzSqCJm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzRsMWJVOTVXTE5JYllDWEJxcGNqWUsxN0I4VUtra0FqTWpNTTZGb2pTc0Ja?=
 =?utf-8?B?emc3My9iSUdSN01OU3NHREkrR3g0UG1HcGY1SERQd2M1azhCUWloZzhzVkdL?=
 =?utf-8?B?bElieXc5UTJwTUEzenc4WVNhMXl3MTQ1SGw2V3QvZGxXVjhnMHZGTUE4L0d2?=
 =?utf-8?B?M2pHWC95MzJUZUlNQjU2NCsxeis5aWtyd3Q2VHJYbHZ5ZXJYOVlUWGdDRStK?=
 =?utf-8?B?em85WVU5TGNtaGg0SWNEZzNzNUtLU3crV1FHNnZPNkJOV2pockYrZEc3LzVt?=
 =?utf-8?B?bEhlMGFZaHVwVFdXY3ZoejhocDRtNFFaVDJ3RkJMMW9XcUhTNUplWm40MCtn?=
 =?utf-8?B?Y1MrT1g4YXVrY1ZBWnZkUW5JMS82TlE3S2pZQjNCdHpvOW1iSDRUU1MxRzdC?=
 =?utf-8?B?dVBLWVgzWWtOeE9DcmlXcncxRWZXeHRIRXBnNDRKMndmeFEzVXJuU2t3YWk5?=
 =?utf-8?B?ZkpGNnR5K2RLSU9FODZjeDkyczdsL0NEMCt6b1I3WnhjN0ZkT3pISnl4UmtW?=
 =?utf-8?B?SVpDOUJmZ2V4NGg4WjRpMjZtRkt4VGM3dVc2ZnRnL1RpWWg0NUpqQXlHTnkz?=
 =?utf-8?B?eGhDWmZHUUxVNkZvTDRUd3pCMG5UZG5pbjQrdkNWTWwyUzhqSVQyYTU5dGlW?=
 =?utf-8?B?a3NxRVNlY09YS24rSkk4Syt0TDR3TG5xakprWEY2ME5UN2VzSWIvN1ZWVUcr?=
 =?utf-8?B?enNNWG9oOXl0OS94YlNDTjA4bVhDRWhXaHhxNjhzNEJJSlZqNzN4NXY2eG53?=
 =?utf-8?B?MHpVNE9EZkJFYU5wVXM0NCtFeDVpbUJtcmp0RWZYdXdrS1dQMThzL2kxdTAw?=
 =?utf-8?B?UkdwamJXMDRFRk9JdnE1UE9vQjFVQ0FXM2huYXdwek9JUVVWMWtYcFdyS1ZL?=
 =?utf-8?B?cGR1dUtDZGJtaHJ5SUthWDV5VTFjNTlMbHNWYmRNRmpVWmVFUURVQ20yK2xZ?=
 =?utf-8?B?eUhRR3ZlZnZrVjdnVWhDbjlBVlQyUkF0cENsZUFIOE5WN1lIMTVManZkdlpV?=
 =?utf-8?B?and6NVp4R2ROVjZHenkrSklQRzRNTVRJUGtYbENIaUQ0M1Vlb0xxRTZTMCs4?=
 =?utf-8?B?dU1HTzhDM3hZbkpuUjg3Q0pDRHJKS2kvRnBaZ1RHOTVkM1Jpd0xZaVRJUTdp?=
 =?utf-8?B?RFVCbFRDeWdTUEliWXFKUVM4V3NkeU9sL3B0WVBaMzBGMTZJRXZ5TFRTQUdv?=
 =?utf-8?B?MDlSdElsZVV5VEtuMHZHaHdaQkZyTDRvR3JwcnYyd3dubVBOOVJsaWE3VzF2?=
 =?utf-8?B?bkF6OVZsSEg2dHFiSDhEYnl6T2hybE4zQ3lpMWpkWERGRUJ4ZzMzZHkxRjZn?=
 =?utf-8?B?YXZQQWRTQWZ0T1VpcXFGV1FFNnAwOUdJSk9YaFVkeTcxcDcvanZaNmtFV3cz?=
 =?utf-8?B?eVVHRm5FVUJsNjQxWGdrNmVaSlBUVkpSTHp0cnFGdW5JTktVUVc1WFhDcFJW?=
 =?utf-8?B?V2Yrd2U3N0c2ZHJtUFQxSWFDR2ttMTVQaVVaZVR5UGNYSzFJSUh3eTFITWtv?=
 =?utf-8?B?bVBFSld5ajlTQ3UwUllmZi90OTA1a0tXTFBVYndxQmlUTUZmQkNVQVNYZUVa?=
 =?utf-8?B?eEdhcUwyRGpyMGF2bGkxUmJxQmRJQVNYNmtXM2ZWYnVKZ05nNGF6dEdLUVhi?=
 =?utf-8?B?U3NuMytVY2FYZjIzQmNRUUZuWncwTWRTRkQvMEhuQzByU3JJWStQc1Zoc0sy?=
 =?utf-8?B?VnJHZnQ2NjN4VFY5a2UxQzZoYklSRVdOQU1Oc3BqZzYyZ1Q1U2p6VTVzNERv?=
 =?utf-8?B?Q0VwUU1vNVVVM2NKcll6amxXemRMOStKdTZDOERkRjQ2MUxFZjFlMU5rRmxt?=
 =?utf-8?B?dlNIYWtOTmIzMVlINjVVRmxXQndvUVp3ZUcyS1FqTmdjdE5ZRmpyeXAvWUxo?=
 =?utf-8?B?WDJUN0dxTVBrU01xYWJjZ3loU2NvdDVTejhVTTRqaVZyK20zN0g1TER1NEFi?=
 =?utf-8?B?ZE9mNW4zb0ZUbHhER3pUOVJiU001KytmWGhnd28rZkFtZ0M5YU9GOXRPS2NE?=
 =?utf-8?B?a283MHZDUSs3c2t1dGJrVU1kWUEyL1RRYWhVWjY5V200a2dVRGNCK2hhNE9n?=
 =?utf-8?B?Sk94TlR3R1pMQ2RaaXRCTElYcVVkd2N5YjlLZ2ozTXhTT0Z3KzZ2ZU9aQWZm?=
 =?utf-8?B?RG9Fb2RjRGQxVzZuZXk3Q2ptU1lEM2RzQS9DdlJoTFlkSTFFZUdqVkNWVXJr?=
 =?utf-8?B?RG1aRjQ0emRUODhKZ2NRUkl5ekMzZUxoR1JGbHpPUVNiNVVyY0gxYUpOZjRM?=
 =?utf-8?B?ZjJ3M3h4bTdoV2Z6UDUzaFBoc0FaMzF5QWlRa3pYOFN2dnIxRTducFErb1M0?=
 =?utf-8?B?RE9GNHNpT0lZejBOaHFBbTNyc0pwZlpML3ZHMWpmMFdLTkxzZmMydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e93f1d-c768-4b6b-8b62-08df12f73ce9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:01:59.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTHLvNylrtSanuLqEK70j0XjWNm9cFje7ST1zvFPCGEfliuUm/alb+UTh8ScNy+NGnnqwOSurzE6Q/FJPflSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328

Hi Andrew,

On 9/1/2026 10:31 PM, Gupta, Suraj wrote:
> 
> 
> On 9/1/2026 8:01 PM, Andrew Lunn wrote:
>> On Tue, Sep 01, 2026 at 08:48:18AM +0530, Gupta, Suraj wrote:
>>>
>>>
>>> On 9/1/2026 7:57 AM, Andrew Lunn wrote:
>>>>> +  The Xilinx XXV Ethernet Subsystem implements a 10G/25G Ethernet 
>>>>> MAC with an
>>>>> +  in-core PCS/PMA driving a high-speed serial transceiver. It 
>>>>> supports the
>>>>> +  10GBASE-R and 25GBASE-R line rates, with 25G operation following 
>>>>> the 25G
>>>>> +  Ethernet Consortium specification. It has no external MDIO PHY
>>>>
>>>> What about MDIO bus?
>>>>
>>>>     Andrew
>>>
>>> The 10G/25G (XXV) Ethernet Subsystem IP does not provide an MDIO master.
>>
> 
> 
> I'll try to make the overall architecture clear, please let me know if I 
> miss something and additional details needed. The datapath is:
> 
> DMA (AXIDMA/ MCDMA) <-> (XXV MAC + PCS/PMA) <-> GT serial transceiver <- 
>  > optical module / backplane.
> MAC's in-core PCS/PMA drives a hardened GT (SerDes) transceiver directly 
> at 10GBASE-R / 25GBASE-R, and the GT is configured over its DRP 
> interface (the "drp" clock in this binding). There is no discrete PHY 
> chip and no MDIO or I2C master inside the IP.
> 
> XXV ethernet PG: https://docs.amd.com/r/en-US/pg210-25g-ethernet
> 
>> O.K. Please change the wording to make that clear. There are plenty to
>> 10G PHYs available, but it seems like you do not consider that a use
>> case.
>>
> 
> Correct, the IP has no MDIO bus master, so an externally MDIO-managed 
> PHY is not a supported use case. I will reword the description in v4 to 
> state that explicitly, e.g.:
> "The subsystem has an in-core PCS/PMA that drives a GT serial 
> transceiver; it has no MDIO bus master and is therefore not managed 
> through an external MDIO PHY. Link state is taken from the MAC's own 
> status registers."
> 
>> Has the MDIO bus master been replaced with I2C? I assume you intend
>> this device to be paired by an SFP cage, so an I2C bus will be
>> required. Is that a different IP which needs to be licensed?
>>
> 
> The XXV Ethernet core contains neither an MDIO nor an I2C master. When a 
> hardware design pairs it with an SFP/SFP+ cage, only the high-speed data 
> path runs through this IP: the in-core PCS/PMA drives the GT 
> transceiver, whose serial TX/RX lanes connect to the module. The module 
> management side-band -- I2C for the module EEPROM/diagnostics is not 
> part of this IP. It is provided by separate board logic, i.e. a 
> different IP: a standard AXI IIC controller. Those are general-purpose 
> soft cores from the standard Vivado IP catalog; each has its own 
> devicetree node and binding, so the SFP management path looks outside 
> the scope of this Ethernet binding.
> Please let me know if I should describe sfp in this binding.
> 
> 
>>> The contents of the appropriate MDIO registers are available in the 
>>> IP control &
>>> status registers.
>>
>> What does that mean?
>>
>>       Andrew
> 
> I meant that the PCS/link state a driver would normally read from a PHY 
> over MDIO (link up, resolved speed, block-lock/RX status) is exposed 
> directly in the XXV IP's control & status registers, because the PCS/PMA 
> is in-core.
> 
> 
> Thanks,
> Suraj

Please let me know if I should provide any additional details.

Also, would you recommend that I send a v4 addressing the commit message 
and comment updates we discussed, or should I wait for further review 
feedback on the series?

Thanks,
Suraj

