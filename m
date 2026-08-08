Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DE3D47C3;
	Sat,  8 Aug 2026 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192048; cv=fail; b=TNZONkIfyobodYaivnUyQclo1Bc1qiJmLj/Xp0BnU8yWqXR+wPlcjC8ewMx+iO6g4zQ08i8Gvow96aAXoWru9jHvVZjKPSCU5/AwbT/rdCH3IOhKHoGF0lolkW0bs8jE0kJwj5Iyn8TWPInx0IfPp3peZLCGImO2phVe2jE/j9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192048; c=relaxed/simple;
	bh=Rtlsifh1+Z9HfUt3neQZ3M595UCBSBx1NIfhRgxzqQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLi5fVVpGIsPr86grS4n4tK/uDFFwlr2RU/cLfGCJ5rezCKALvOHRB6HMtj92AsBN/cHat8tWZXhDhEZxk3ZnmKepC6a/MwCnBRXOF+/lXymAAzyVxMlInWvBXeFeAgKGgHgORXRufj74EL4Z0/GzOs4ZFAhF1fK+C22MljXWJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vumkroU5; arc=fail smtp.client-ip=52.101.61.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vumkroU5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thqFUl9EtNNh+vtdpcBW0Ju3/H1ZbGQlPiuplJ2wEBLwSUzTTp2CunRxF4nqYhBrhtBMrMwwK/cKn2PuQBJbwCW9xK6QoExR/oliPaDJHXYggB7j22Fb2+z+2CQYSjmJ7Npazmqj81eSfl7tRGxLRQv06ELaCRvCHkrNQw8qWaB8pYVnBTdZNnJgpQ38oVA5w5iEmIJwd0nw58r1wjynIjhdykqXMnaaKlA2Ps5D9FaW3ro0o/VnkgpJb6fFS8TXz9QsOgCQ6UeWnvD4QnV1t1iOXotJV1YKNXzXEqkVzBQMpAsV4QH6JPLFCKLW1qRrqjc61J61lvj7RxYJsTOtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUl7e79l7B7Yn5jcHORMxjsWO7XCVPFDSKyGoex3DU8=;
 b=dL21KBYapaB+F0Viy6eQUUJXjyYzowBfGATY9T3+A3GFdzM9g+W9a7DKtcAAEkFaoBEIYg/cqCUrotVmHCvqkg/hDIBKyq9pcIsxxJUdFCeN5CXX/6VPgeRd+1wYKuzwI7GrC32oNS9DmpyVDYRixr8olCq91l6U9Ki+NjksxbQOLdV8k0+9Kjz8zDySCKnWmeNKW5JYx3aJ+QNaa08PQTFtqo3Mpj/5dPO61nyroTz6PSNV/AKpFkWxTuOr5EJrP/XowKavHkbItOUE2sroL020Pn8RZW2Hg8B5nS3eoE8n6AyZdCnoIZHfuLsCFj0tDd3LBjFzqsMOZ3HqNoRcdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUl7e79l7B7Yn5jcHORMxjsWO7XCVPFDSKyGoex3DU8=;
 b=vumkroU54mYbDCmburI0Ie0eyvs4lsILmUD3yIlTHXjNs99tLtXKbkVy96ytB0k7E2sbcD8hWRKt7AnzngnDNwqm4QABxuA67GOz+KK7EVTW+PZUne6WmuJDDPMzYGuGyQZFF1K3yUlSP/1E6DXO/RmUnTJ+CU9JEZsfSLi7P+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 12:27:13 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%5]) with mapi id 15.21.0292.018; Sat, 8 Aug 2026
 12:27:13 +0000
Message-ID: <b9190115-68b8-4318-8fc7-e9abe6a47557@amd.com>
Date: Sat, 8 Aug 2026 17:57:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] net: xilinx: tsn: add TSN endpoint wrapper driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, git-dev@amd.com
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
 <20260807104431.157230-3-nagadheeraj.rottela@amd.com>
 <anZGPKSopP9GLKJt@monoceros>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <anZGPKSopP9GLKJt@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: f17bc927-8848-4ffb-1e79-08def548604c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	WIikJWBFDHVNS47RrVzB0k8M9xZRQ8BrsHI/vygBHt24OEvCZGBUDbX/6kuuAVM/UzTJVU3EcKkJ9QjpsYmkUbRUbKBohcfQlMwzI5F2NMJILmci11BsR8Y8pDu+uaIYw4Vxo4sW6MDgaU/sI7baPXN3JGELZ22EnrKap10wC9nBcPVFVtu+xNxVWpc/w7u+YIEMW630ED+lfMDNGr8UYkm7edzCJ5hrhvS+Czl41I9Yy94uUKYRlRV9Tn51BFroJA8wrBLPYj5+b+XiTR+txK2zFa3nIUziyKUjaIRHbRsZGpsJt70EvqOQRFmPJGH76GhSuwdWkEqwWabMnKE+deKQ2hSaZmyNkItHufmkBiA6PEL5hJng8/vbv+JJ1K5RS3q2v6H411hcJahZQeCEeUpcQbYripX2x5FKSrWv3XYJVd3SBbDADpgmBZJYugAdzhJcMNBlSRgUaBiDJD2UPh4TfoYppt+NKzzenPRnKKRnzykDTbpzR8uwpFGpnaf0C/TVwADGnbM5Re0oPOLKmBgo4LtturrsNUdVsQRIY9UMURE8G0+9Qu0Wxo59e8J4VEFdlk76572hIyBQ5rF61hRnzMRhLz2LWfPzvXYpewSuxM76ODK7ltCFlALu8gtu5hGszys6T3oUvTnBiqf/vPJc3ZAmQ3cEcaHzQ7OkT34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWhTd2F5QitxcHp6WGVqZDVkU1lqWXNDNkErWStpOSs0T3Y1L0MvYlBkMDVU?=
 =?utf-8?B?UFo3ZXNMZHVrQkJKOEpwRTJzOWZuM2N0U01pTDhOSldXNkZHeFRYamVmVEtR?=
 =?utf-8?B?YldEUzJOclBMZVVMbUc2ZDFNZDRHWkJQRWtZNkp5U1FGNTNpNlQ1NkxkN0Vr?=
 =?utf-8?B?U045d2VJK3MvS280cnlTa3NuQ3BveHBHSkhqTWVDdTFEQVNIMUVIeCtBSFkw?=
 =?utf-8?B?MlZtSzh3L2lqcytRanUvRm9JaENEYlZCOG5GTEx2OUVXQ2VDZTNFWUhhQ1Rn?=
 =?utf-8?B?UmFDVm43NHdTSHcyOHE3Wm1rY2lrdUlRMFppS3NzTGFCZWluWDF1ckdrcTMr?=
 =?utf-8?B?N1NwZ1p6cm9zYW45SlU2VjR4cmUzYlFkMWhxN294QXA3NnNHVzdmYWc2Qjd0?=
 =?utf-8?B?V0h5L0UxWjMvSVZLVXRBODBQa1o3bzVwZ2Z3S0swU3E5ZU9XRVNaaUJ3dXFv?=
 =?utf-8?B?bk9vZksyS1lZNFUxcUJTUXZCMmFmNUVtb1BNaEtxcDQwbjQ5aXR6NWJEcXVl?=
 =?utf-8?B?QVBvcFg5ak9tUzE1eWNjeUt1SEo3Nm1mV0taUE9aQnRURlpMVDk2RmZVNWFT?=
 =?utf-8?B?R2RvbEtocE9QWlU2L1g2TW95VFBGeDZpQURvZTFJd3dYY2NFT2RzSDVLQ2py?=
 =?utf-8?B?bHJEZExRNytuMzF1Tm82dmc2NDM3ZmJWc1luTXJMQmU4ZHVlVzB4NEVWNTVK?=
 =?utf-8?B?R0k2SDFiRU0vRjZuYlM0OHRaWHl0Ynp2eVdEZjNmaFQ5WWgrOWZMTHlnRjFM?=
 =?utf-8?B?RGNTeElQWUh6UDRwdlBpTi9zVklPRVp3S1JYdzZORG93aW5MZzJKQUFab1B4?=
 =?utf-8?B?UHdHdHdIak82OGN2U2xHNjVPSTcrSnIzN1FxeEZqWkVBd3ViQ1dtLzlXV1do?=
 =?utf-8?B?T2lTeVNudTI0cVpiS3FWUCsvcUVPNEN0R05TVnNiN3g3ejNUZS9LQ0Nxa3Er?=
 =?utf-8?B?ZmhOUm1GdjlRMm5VRS9NdFljYlRTT3RHaHZCckliM1dSa3JJcHZJTDFHb3I3?=
 =?utf-8?B?SWdpSGNTQ2FzaHErM1poUnNpbmhkaUVyc1FCOXAwTFJMd0U5Mk1oYW9aM1Vq?=
 =?utf-8?B?L0tkd2ZVODJNbWVLM0FPNXQzS2dsU2U3cUxMc2JDa0hNUU5od1Bqd05FVWxX?=
 =?utf-8?B?UWxkcDBKMk1OMExIOTIyQ0g1L25uOTZRaWM5SENSQ3d0amVQVWRLRzlhN3Zv?=
 =?utf-8?B?MExkTjY1TmYrVG5OeXJlSlo0dVZxTW5rUWRvWVFCMHM4YXpndzZNVEJuTEZk?=
 =?utf-8?B?dmc4STlYalRvb1dOYytzT3NWRDlzZkNCVWV5ejhTcTZSc09yditoMzZtV0hj?=
 =?utf-8?B?V01qZTk2K2J5QmJvM3Y1Q3M5REZUQ0lJWGpGWHpYV3dDQkhTNnc3RVZRR3dS?=
 =?utf-8?B?WmlnalZvQVhTcFdBbmNkU1lJK0xQajh6NU50cUdDeUtIWUFQa3BhcGpiNyt0?=
 =?utf-8?B?d1VocXFKSlBBODB3cUppRVpVNUdxRTR2bWp5RTZWTkRlVzlSb1VpMmd2bnJQ?=
 =?utf-8?B?UmIyNmVGRGFWV2xESnpKSUNYRFMxMHFCUzJDREhKNHgxVEJvN2owQXNnbmM3?=
 =?utf-8?B?bDlrSFd0aXpsaDh0dEV2QzE3akNNeU12Vlh5WEFGSm5ZV3VCRXpvT0k0MUEr?=
 =?utf-8?B?NWlBT1lseEhweEswdVFlRHI3dEtuTE5vQVo2NlRGY0lBcm9aZzlMeVlPb3E0?=
 =?utf-8?B?ZE9YYk9IT1VEOFVnN09HdjNnc20rZ3JJd2trY2p5bjdGYy9MMmE3NW9oRmQx?=
 =?utf-8?B?TXlaNEJFQVVjWkhsdTNSQkpjQnpiK3crK0dsdVY5VTBweDRPOVQ5ZUZRaTRF?=
 =?utf-8?B?R3dnRmFTUjJ5SzdLZWE4Q1FnR1FiSGtSdk00QVdwS3hJQVNtTGRhaGh6UzNS?=
 =?utf-8?B?TUVxanAxbEhjb05RbDhaeUk1K3BWMFVEU25HY2VjM2JkeTVkOWxieENXRFVq?=
 =?utf-8?B?ZGMvaGpkYXFlbmtzc1IyanY1b20rdUpLMElaU29oTVlyS0J6UDRENld4QnF3?=
 =?utf-8?B?Z015QnUreXpkVDZCRzdBdENSL253UTBCdmFPeVhreVdkWFpBR3RLNTZJb0Q3?=
 =?utf-8?B?ZjR1cDZSRTNhdG5KSGlUamF2Nm9ZUzdLRWNQZFU1TmhmdEhFZ3RSM01QWmJW?=
 =?utf-8?B?T25lby96SHJHS0N5UkZxVlE0YndreVpBaUhodVpZY05RK2Q1dUcrM1FCRXhl?=
 =?utf-8?B?dUI2YTRKOUF6SDFrSVNXeGUvQ0hITkUrL3NjWU5TMnpqWU5JT0dORnpiZ056?=
 =?utf-8?B?YXhoU0Z0ekY2NDY5emcxUWIrcWNzSjd5QUpjODVPLzRFbjREdnV4SGdRb2xo?=
 =?utf-8?Q?ic6V1ZFxX+7iisfAqg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17bc927-8848-4ffb-1e79-08def548604c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 12:27:13.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oZuhhnds+Atfwbtm5gYeeb08vWTF0S73b4hBii+V80skJQC5zmFMXzqbbJtMkqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

Hi Uwe,

On 8/8/2026 2:28 AM, Uwe Kleine-König wrote:
> Hello,
>
> On Fri, Aug 07, 2026 at 04:14:13PM +0530, Nagadheeraj Rottela wrote:
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
>> new file mode 100644
>> index 000000000000..1ef1b0c2ee6e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
>> @@ -0,0 +1,105 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Time Sensitive Networking (TSN) Ethernet MAC wrapper driver.
>> + *
>> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
> Please drop <linux/mod_devicetable.h>. This header is planned to go away
> soon and you can rely on <linux/platform_device.h> to provide
> of_device_id.

Thanks for review, Will update in V2 series.

>> [...]
>> +static struct platform_driver * const tsn_drivers[] = {
>> +	&tsn_driver,
>> +};
>> +
>> +static int __init xlnx_tsn_init(void)
>> +{
>> +	return platform_register_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
>> +}
>> +module_init(xlnx_tsn_init);
>> +
>> +static void __exit xlnx_tsn_exit(void)
>> +{
>> +	platform_unregister_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
>> +}
>> +module_exit(xlnx_tsn_exit);
> I assume you expect tsn_drivers[] to grow? If not, use
> module_platform_driver() to reduce boilerplate.

Yes, patch 3 adds &xlnx_tsn_ep_driver to the array, so I will keep 
platform_register_drivers().

Thanks

Srinivas Neeli

