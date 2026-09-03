Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF8469830;
	Thu,  3 Sep 2026 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428241; cv=fail; b=ABwnTNF2GaekcsPGcxqwWgugurpg8S/mEHakTkJsebi3W5HagnC05C6DcjMGG+37QD8UWxPYVBqE2SMxIOCUYbympGULEUrw7u2Z4TvTK1KTJQ+2Td34EupVInkJR7WKWy2Fm9ikHuWERyxlNgtsKyThiJRcgJcPvCYGRDz38nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428241; c=relaxed/simple;
	bh=clkqfFqAlu6XIy8QMNZ6ruz5TFXfz+LlcLYj1E7ghmI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gTJbz9JI7nWt9kwosfQCfzLdEB7LEOfYBNZ8aBcoSefIAoIx7kjKE2UtdGs/lLn0BkdYG5hTM808m/BiIFGQj62prHiJK8Hk4bV3nvCXBfIJ/q8XgX2M+C1HGL90KM/Kv0fLUsneng/AcVlzkl2oNnJll3LHBQVBW6a4gC7wXgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rB1JUVj7; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rB1JUVj7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcPqck+yYR8ukB5Zj97ECAlXwRXVZXF1G3Tdi+24C+etuEFHy9zrHciAMU2boRPQOqbuWcObDX7AnEQRTRveHSn1txiOZ0Q7XFR3buWppAud5UcQhUAy8fF1zwRzEN0wOT47lnrSIBI7tW+F/0zRLskASFV24+vDTwUYpT5UPyMTHcY1DyOC1DnNCbrYF7vBlLXJCONU/lBBVm8lqGKDP4vtbxjTYy1+kt0iWQUPnkokWdhiK/IHFFTwtj0vk0XZ3IYUqnWhJAp9r1LryOqP12PIw+rlyPl5Qe7dD/x92wnBLu+X8A7vsMYtRC8ubGx8K3yJsoGj/nAL/FicO3k5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGlUvdI7stv2T7+W7ZxBMt9FGBHa9QPET8JOFOaA6e4=;
 b=o1em85mzUjj+ZCpzuW5gxtOcWuZQu7q4rFBdsbn2nXW/qCvYoLp+hMBDnkzjQSptGp0bMzX51S/l+D9h9WxrhJsFq+Bd0xwvXwigOiFi3HyqeooQNFlyRI5gefughuQO+nor7lgpwny62alL+pefZuu177OmYQChtI8CCOotqUe+X+c7PoJl+pVk2Y0b7+8gd6R+rZ15uaAl5TakqI3HZ/iuYbrXzJdTM3bFwKLAaJmyDXVlsMhNfPGF/WV0ywY04tCi5+Pyzo8zfc1R8qozb1mWv4qO6nlkc9QsiQdwi95jvYGynjlGHKejPPuXu0Q1oy+FacE/+v3BI728Tky8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGlUvdI7stv2T7+W7ZxBMt9FGBHa9QPET8JOFOaA6e4=;
 b=rB1JUVj7arpqEBO6/kHn7xlpfFubh5n4QWrCN0idvLUT28n1f2qONF4sgCRmkytjkzpkNOvS9ZxlH5nn8LbaLqls4IQsoJkm3KTp+2iN4c/3gkRwrkpUURR7FcfdznrF1zDyMP6ljHyivvwwCi8CJEDwyTmVGZl3MAzp3DDvddw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:37:14 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 09:37:14 +0000
Message-ID: <54e4c15b-e235-4c97-ba82-7e5d5a05a154@amd.com>
Date: Thu, 3 Sep 2026 15:07:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: macb: fix NULL pointer dereference on unbind
 with fixed-link
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
 <DL5JESSS9JQK.2EV7XV479M0UW@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <DL5JESSS9JQK.2EV7XV479M0UW@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PEPF000001B2.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: ea04d7d5-2d0b-4fed-8171-08df099eef89
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2csTYjNTB1SG9IUJPNcyup/pRLLHnHNHsWmvIImd2FoqeR2zx74LrJa0dSiJwsavUnILi96cMSR4Cvkt5tn8Ora0G/+kHBt+RiZm6JrMy+TFNYvGKdMdmpONaiO7CGMG0AAm0ITZy0M8ZDnHSK4AwsNNHw7AtJ6IpRPYnmhFP72XpgMHXHrcMLzo7JbYE71VKXDXABVbT9dbJyLEbAxv2fRv8YadflJp/BGER5PGwYjMOqENUtnbZ7CKMdcj48LAeXZzkxVAW/SA4MkzOpm02LZ9I1mVNt9SHE60Vpb3x54daRuC0Ooz+GJh+G5eM8GBGdGFF+xaI0r5/iLzzhqnL/u3cQ5W2/2+BV3ZFucWPLsGJ+bgMp/XzMv6ZECF58n8OUGomMY1aSN8plu654tA95oS0QDMoMkWiTzCdMhmwW9lGrKHtyt15ghiRd2lExfAYBmYdfBWJ2koLVxvgkdNom6QABmTusT9Nt0TuYtLZAxSjGEBbHEk9MCIqApDt0j+Y1MISPHq9QehRUF9GgjKH75hPXs6i+nQiqNBRhMIlAAOxZTO74ESOsWMIBOVrrmB9fZT8IvUXhehIPXrxmm37q/mt4tee6TLmX2VqKph6Sk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnF4SWE3a0dyNGRCMGwzVUdPOHNWV1prLys5WlUzNmtYb1hqWjNzRG1oRzAz?=
 =?utf-8?B?dXBiazlsbE9tYi9ubHFFRXB3SWRZVkFHRmNYb0tKdUZrTlFxaGNaMG1QRStr?=
 =?utf-8?B?VjJvTWRFTkhjMnJZQ3EwQmhEQjByVjk2VXpIajE4U1BmTG5IUWlCdnhOaFJ1?=
 =?utf-8?B?Z3kzc2JGSEhWbFRSUnJ1NVhoSTE3UFc0N3QxdFVSdUd3c1FkVUJxK0NEaDBp?=
 =?utf-8?B?eGJ0eVFlQUl1RkZnWTdVY1RSVjgxd3drVUR3Mk9KWFYvSWF5ODJwZWZxa0Ft?=
 =?utf-8?B?d1pjaVBzdDZWdTQ4OEpNYkxPWGFVTmpxWE4reExzVmZFU0M1aG9ma0RFMzBj?=
 =?utf-8?B?NkFmc2s5aHM3b2g0YUlnNnBqWjFhU0VEN2w0NVUwQVNuRWFRc1p2Y1Y3NDB4?=
 =?utf-8?B?S3ZBS29lUnFuS3oyS09WejNHTDJHa3dYV3F4a2UvOGh3RTc3ZFUzZFkvR3Fy?=
 =?utf-8?B?R0NiUXpjY0lMVHJpSzJnRXd3K3RMYXhvTVpjZFI2VXJuOTREakpXc3lMdTgw?=
 =?utf-8?B?ZlBVbEFCTitubXRpQkg3LzFKM1I0Nkt6U1M3YXpQb21rZDFlZ0lDd0dCVFh6?=
 =?utf-8?B?N2RpV0o2WnEwU2ZVUHNJN3hleGMxMDBYcGNNWi9lUnpqUzVKbnpGN2pMOVk5?=
 =?utf-8?B?M2xabm1qblJLbEJPUm1qOVo3OTdhQ1FUaUw3TEpFVy9kc1FkS0JZaVg4MzE5?=
 =?utf-8?B?eFAyb1g5VnFzTzRETFMvYWxEQkpIS1hQQzFNZ05TUzFQMlZ2cGtBZE1ibGZQ?=
 =?utf-8?B?d2VqcERqTG5jTC92UTJzOUQvQ3NodElHL0pwQVFRYkZXdndhb0FhYlBhQXFJ?=
 =?utf-8?B?c0k1dEdpd3Y5M0taY3FzK3M1Y1JveDI4ODFIUElHZVEwV0NVaG1DSWFXbkdG?=
 =?utf-8?B?Z2dnVDRjK01pbThwQnFSMU1aeFhKWXdOK290QjNYNFhZR0RCOCsxYmtmTThP?=
 =?utf-8?B?cGY2VStYdXBQdHl2R3o2QXM2SW1RVzA3b3BDaDZJMjIyRm1rdm5RblBtY1hM?=
 =?utf-8?B?M2pkUXJac01Jbmt2Y2t3V1g0OTA2RHZqMGt4ZW5LbUFLSUFkcTQzYnYvdVM5?=
 =?utf-8?B?QkN4YVNMMlB2OFZFdmFNSUNJU1VuWHcvQkxmWXpuelRrV3QxZlFTQUVoZVFV?=
 =?utf-8?B?VTFHMkNhWU1PYVFiTW5ldWM3SUsvZHhvMklBR3RFRHJIQStPVlNudjIxVkIx?=
 =?utf-8?B?ZWEzQmk4ZnVLWVBuRXh6TVY0OVJKUWREMW9ueTJPODlDVjc2SzBrVlZnOFVy?=
 =?utf-8?B?VFRsTDJZbUdBMlBVL0YyTi9aMDg2TTNsOC9Cb0p2WG5DSzZvRUZmY3V2aTN4?=
 =?utf-8?B?SENZdVZ1OVJ4cFgxaDFCTEd2L2t0ZWdScm9rQmNjRVRmYVdWU0I0aWl1b29W?=
 =?utf-8?B?eVNNSzBOVVNjL1VhZFRSVnpxNFA5RW5vV2orNFNUM0EzRnluVEZHQ0Y3a2ZW?=
 =?utf-8?B?TUxsY0dNeVdDRk1JVTlydXJnZDRna2ExS2NxVFhhOHlpOFl4NnRqT2lJQmRH?=
 =?utf-8?B?c2c1a0NxTUJIVnFqazJBUktlenhuNWJhMnJCNlpPNUpxK0tzUEdCdFRxZFBY?=
 =?utf-8?B?TkhTL091WCttdVYzMmRRV2hRNkp4RDhoaEowTzltWkJDaTdxcWpIWVJrNDZJ?=
 =?utf-8?B?cjMxeFZERVlSSnVqRS9LWlBQeTM2aWhzbVluWmsvaFcxSEZTVGRwT3hhSVRJ?=
 =?utf-8?B?dkNONk5FcThzWncwQWRjTnFlUVRoQ2ZiSXhtTG0wdGJXYTY5eEtUbzFXRnVo?=
 =?utf-8?B?N2FrcGV5blQxVUliOVNjWTdqSzdoZnJFajJObzF1aUFUaXU0aUlFV3dCaWl2?=
 =?utf-8?B?UlV5ZWFOOVoyTHR6YXpJUDFxSTA2TGlvQUdYT0wya1IxOFc5cDdMaGptMm5S?=
 =?utf-8?B?VDNjVzB3LyttOUM4UDcrWG9VU1kvVURMcGowZEdNcGc3cWNSaW1qUi8ySHcz?=
 =?utf-8?B?N2tPSytITi81TE9kK3hlcGptNUlUQTZCZGV5aEhidHlQMTRnK2szU09ic0g4?=
 =?utf-8?B?ZTZ1Ymc3N3JBV0VmZThpbWlEang5eHg1L3lkdnd1N2pidjg0VUhBa21ta1Z2?=
 =?utf-8?B?ZmdLOE9KUGF4K3k2Z2ZMREtVWXlNRGUvb3VNajhiZkMvNHdueUtDVmx0cmpY?=
 =?utf-8?B?NzVUNENLL21tSlNCN2dlWVF4Um5XbDIwZGpKMXNSRitCbnlSNS94cWJkZmZn?=
 =?utf-8?B?WUtIUzU2b1p0Y1BhYWtyT0JYaDBOUzlIRlV6cGVGeTNZVzJrTENZUUc1eVRq?=
 =?utf-8?B?TW9EQi9xTUhXeVJqR0MyclI5bzU2VkNIOFUxOVJLbWJpUzhkNXh0d3pWRjlQ?=
 =?utf-8?Q?iMPDfAzL3wjQU5zgtD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea04d7d5-2d0b-4fed-8171-08df099eef89
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:37:13.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnah7FbcW9ywQPClcxrxw9RZEAqzkdFusSKrmVKw6JIELGTrqabBsHZU+Ov59Z7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229

Hi Théo Lebrun,

On 9/3/2026 1:57 PM, Théo Lebrun wrote:
> Hello Vineeth,
> 
> On Wed Sep 2, 2026 at 12:28 PM CEST, Vineeth Karumanchi wrote:
>> When the device tree describes a fixed-link and has no "mdio" child
>> node, macb_mii_init() returns early without allocating the MDIO bus,
>> leaving bp->mii_bus as NULL.
>>
>> Two cleanup paths then dereference this NULL bus:
>>
>> 1. On driver unbind, macb_remove() unconditionally calls
>>    mdiobus_unregister(bp->mii_bus), which oopses:
>>
>>   Unable to handle kernel NULL pointer dereference at virtual address 00000000000004a8
>>   pc : mdiobus_unregister+0x14/0xa4
>>   lr : macb_remove+0x38/0xa4
>>   Call trace:
>>    mdiobus_unregister+0x14/0xa4 (P)
>>    macb_remove+0x38/0xa4
>>    platform_remove+0x20/0x30
>>    device_release_driver_internal+0x1c8/0x224
>>    unbind_store+0xb4/0xbc
>>
>> 2. On the probe error path in macb_probe(), reached when
>>    macb_mii_init() has succeeded but a subsequent step fails, the
>>    err_out_unregister_mdio label runs the same unconditional cleanup.
>>
>> mdiobus_unregister() and mdiobus_free() do not guard against a NULL
>> bus, so guard the calls in both macb_remove() and the probe error
>> path.
> 
> Agreed on the patch! However as we are there, I looked at all
> bp->mii_bus usage and macb_phylink_connect() might crash if bp->mii_bus
> is NULL.
> 
> bp->mii_bus is NULL if
>  - no children mdio DT node AND
>  - DT declared fixed-link, see of_phy_is_fixed_link()
> 
> In macb_phylink_connect(), phy_find_first(bp->mii_bus) will be called if
>  - phylink_of_phy_connect() fails AND
>  - we have no phy-handle phandle prop
> 
> Those two overlap right?
> 

We did not observe crash in the scenario described above.
The AI-generated response below is also consistent with our observations:

A fixed-link forces phylink_of_phy_connect() to return 0 (success), so
the phy_find_first() branch is never entered.

So in macb_phylink_connect(), the fixed-link case gives dn != NULL and
ret == 0:
if (!dn || (ret && !macb_phy_handle_exists(dn))) {   /* false || (0 &&
…) → false */
        phydev = phy_find_first(bp->mii_bus);        /* not reached */

Both disjuncts are false, so phy_find_first(bp->mii_bus) is skipped.

Thanks,

> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
🙏 Vineeth

