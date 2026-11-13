Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794575427;
	b=gMzwAGMJXXNYhFFdtynOyiZy8ZVdhefQ8zApw3bWE4/Z06qoDKtWjKM4fETfMljjScng
	 3BRdQBQqw+EYgGBwKpqIofjpSX2D3AgrIKmEAPXYJ7JMYW1PwiXcHLyv7i9aYZzTEbUeU
	 bpW4Lqvs7GbaVeM9FK1ogia6Vc25HzQoJ/BcFa6IUZfZ9GjSoTVFEUoQKgS5kUIQ0LeZr
	 QNAlCS4XHzDAv1qy6qCA6bL+s02oggpZg8OtjFoICn38XBcmanBMJ+xL9ICh/mPnGbaFW
	 jteZhYx7aPsfPvw/AtyQAFRZOiRWM8ZbloA9ALcANmyp7LXPcZ1yy6Fz/lO9TVNZqnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575427;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Q1BiPcWBskSAau2lfq40+UBEIKu70HILCWn0sIIOxUE=;
	b=kbFKuqxSc08/jfd1mmjUTVt5MsjTILtC8Xul56CLREalorSOn/3vKJmAF75SmnTKPrX2
	 te8gahvdOHgD2HQp/Y3z0onSigvrasg3ycCjwm81t1DHhb9ddwNXe62nM3UxgiqLh0Ll5
	 18BGDQWiGfMqJeb0e5gAfHBhS1rxZ6kLU8obYWVdaQ4eAZllHA1Cleldvlb5uWz2kMU9U
	 0PkkQj8mWs9GcDm7Z40otUMkUHPjdKlPEAXA/mpr7Jt8VXKv3Q8nDVt2C14lnENq9H7ds
	 ctMhCNTqeqyKYdTQsFDclgzxKdS+foARXEVXIiIHK5vrk6oZyVOinYw9BOIiz7Qt3/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CUciOwL2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.59
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B3606A333;
	Fri, 13 Nov 2026 13:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C8B3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CUciOwL2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZXziXxohYK23jPHPRyUOrFsEbEREhQs6f3jvDmlv4ZpDLoe4l1vwB6hEtumgi6qYQUUVrF0qbnLDlx4QKGy7Aqx9Ap5Ir70a50Ur3BGG1zm+3cHXCFQPq33LqYo0+Yw1L9GFNHKGny7+uGAhfd1ZHFuFKG0bjJjNjtvzo5H29bNC7O5RpqEAOtvUQVbNj7fbSFt6H6nyBr7bs2PLuCtROZCagoD1mthEVV8Ye1riUXIsFBiLPFfn8mgKOSqF4as8IxPCZC7cKCRcRZ9sg0mD2XkQrAXVcoXANOz8ursNP21r9OQSa9JdsXKK7twdy5n14pz0f4WMHYvmM+SNwG7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1BiPcWBskSAau2lfq40+UBEIKu70HILCWn0sIIOxUE=;
 b=xw6U+LvdIW2lTvk85b7c6BmOHSrljChTY35J0vZvfJ70O6v6/sFIy5eYirEfloecHx4wC0aRwcmn0kt5Oj+jxtnJRbw1LPhsPCHavlHVeDQrZv2OBs3Pfkmqt8vwNxc6jWjDnNOw4ncEjTovpT3xt4OL43MjwvnB9QfeSjwnFeFne8Fq41/KK4hxM6UaY5iS59nZhdSTBfOJvA6MxXK3lx00koGP/gZg+VKh0qvpHAd/OhR47SYjmQtEyX6zgFP0pQWEc5Engt8jajVagGAJ5HH+jW1lufKGyQdN/Hcki7WiE+812oFjsb4PNyXN2fPnejttLAMtTIxTAlVaGAmwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1BiPcWBskSAau2lfq40+UBEIKu70HILCWn0sIIOxUE=;
 b=CUciOwL2OeOPcZc9LHz9x3YQ6b2g5CNCaF51wi1rTFLVqs5H3MMRsohfu7nkr9VIyr8SIFpVzzvJz+wMTIxgQXFj9NGxKwNypNYpUdsQT+4yrp0UvRJkCCO4TkUBqZO/WxgbO37NyxtlG0ml4krnPi2PxVDWvjgTtDFeSrubsNc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 13:10:23 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%4]) with mapi id 15.21.0592.012; Fri, 13 Nov 2026
 13:10:18 +0000
Message-ID: <8c39f488-4e10-4857-b642-1edf021a86f2@amd.com>
Date: Fri, 13 Nov 2026 18:39:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Add Suraj Gupta as AXI Ethernet
 co-maintainer
To: Suraj Gupta <suraj.gupta2@amd.com>, netdev@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org
References: <20261112174926.2102832-1-suraj.gupta2@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20261112174926.2102832-1-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::27) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: b901607d-1b2f-4413-a29e-08df4187772d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261022105027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ymlglqLQuHt7ji5tCOsAtoBzt12Z+SayA8QuVeZqhrDshWt6FWRFCBvmnzBW2e6VxgZ/+926faf3UN9Zsi3yY9HlWbjmZY30xwtSX7MltApyUb1iNHzxsiZsiWCLCaV7jFbfynlzihNLf6R/JTWdPgSfUA8955JWEZsKNByJLQ9razHDowL8Gk5YxrmHoHWFOyBHvCKA3KcduArhGoPT6E4YyAuCaSsjDds7SKLXSCgxq5UUjWHCdaRHx4OT1uk9LPcmH0tfHUAHQjBDoRloGM89MTaBEaBuoBq69cW0ktK+RwGQHpwGlIESJ398OsjzkYZ9fuGnhosz+SUhuHDEHknDDtbHgwcglVpNVOLwwOp2ibb6AhAgLAvglPf642F/7is89fx9bRBQGYfmhE2EbpCa0CA5dg5/qLw+JhAV2yP9Loq453FPiwEJFF5DFKTgoiTu9fmM9tABliqKS3jacNGGpMiV+FdH8It3bwoA9ciP98/E/tV3jCVWAU7ueZnVsMTXOczXDZpXPnQYaBMZHsCrqkOKQW5FGont+Ux4EbuALoEziVliNaK5w4XaewzKKPqjHqbWRKsdJNnDcF+TieFuJmy4gQy/kgABqveUbEUTkBPQmr4kDCQSvtid3YY1bsNnct2NtPikJvuF9NNmC7CsMyRD6B8WL2ljkiwf6vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akx3UmxmUTQ3TG55cE9pdmN3Q1hoQ2VVRXVLTTM1YVNaa3loMHl1azU5YURp?=
 =?utf-8?B?U3FBNVhoWGtwQ05uemFHdTkwVTJpWDluV2RZTjhMcG1nQXdKU1NYdjB1N05j?=
 =?utf-8?B?QTRhdkEzWkFnaTdWNEFHZko0andoUTFaRWJXNmI2L0VOU0VqZWdpUmRFczBq?=
 =?utf-8?B?VDVRVTdXb1BQQ0tzNzFMb1RwMHZDT2dHN3hKTXV2OVpyL1FSYWZMU3UxZTFJ?=
 =?utf-8?B?R3FPc1NTMGFGMndxeTZVaFV5eDlTOW1ERURpM1d2ZGgySG1HT2lnNFdOSDRS?=
 =?utf-8?B?M2kxS2NNYTNtVk94RGptOGxOaDR5bDBFRGk0THhaNzJmcFg4S2czdTNlcmVl?=
 =?utf-8?B?eVlnTzJicTVpM09iWDEvbFpwVjhEaXZZU0RaTUZ2b0NGYnVEMUcveUNuRWE5?=
 =?utf-8?B?TklqbjBjVWVheFNQakt3QWs0TnB0TWpNb0VSRmdiWDJSUUF4TmY5TFVRQkpm?=
 =?utf-8?B?dktLKzArajUyQi9JTGdwSnUwVXYyWGk3b2VseWJrVGV0Y1pNN09JSWFyb0JH?=
 =?utf-8?B?Uk11TnVrWDQvcU1lRms0aDIwNjhQdDRlZ25RM2lXdWZQbkNGOG40MlNEN3Jt?=
 =?utf-8?B?SnNoeVRUaDcvblVLSmRWVXVvLzFFb3R0OXBuMDNqa1ZUR3FFVFJ3a0wzdUJ5?=
 =?utf-8?B?cjBoamZobEVGQyszZi9jM1FFd2l6bkswa0RiVSsvWnBWUnJVNU55ai9UZFhk?=
 =?utf-8?B?ZC9ES0dQYlBDYm0zalNHZnZTUkpRR0ZsWWZnaUpPZ1NiUE1wWUR0MWppRTdB?=
 =?utf-8?B?bmRwTlVmaTNtdUZxc0tPdDVGTkJEYUF5SDdUMkh1aVNRb1A1RWZqcTNWcmkw?=
 =?utf-8?B?Wm5qR05ZcW9yaUYremU1RzVUV3NrZDQ3THhqKzR2RGMwTHpkSGZtNjlhRG92?=
 =?utf-8?B?bElqVDVyckU2cVA2T3R4Y1FYQk9TYk5RSVpSSFg3Q21MY3hRREZWeGRNd1Zj?=
 =?utf-8?B?NDRRY2RpYk5lWDE3L3N1T1VPTDlaYWVyKzZOT1ZKS3VJcmFKRlNEUlluaEM0?=
 =?utf-8?B?Nk9hU0pFZFFkZEp4VkZvRTFkU2xzd3J2NE1sTmhFcWN0dGpBM2x6eEZvWFpr?=
 =?utf-8?B?cVJlWXBCTy8wM0w3c01JNjc5S2s2RGd5NDk2bWwxSDRGSkhZMHlqN3JaMkZV?=
 =?utf-8?B?NkI4c1JwK2hPRjBtMjJUVmdMR1IxMTN6cXJGazJ1d0xuWWhveHAveWVXdFdG?=
 =?utf-8?B?ZDVkM3RzVlN6K0duL3BmWFdmSStGVGNiaC9SZTljWE5kNHBUM0VTMHhWQXZJ?=
 =?utf-8?B?RSthanhucmIyRUZaT00zbG96NWx4ZitQblc5NE9pTWdZUThCQTV6MU00WStZ?=
 =?utf-8?B?Y2FyYi9jblB1ZWVjWHV2bWROdmVYQmpIUVhueUl4V0l3SkRTa0RxVTlaT0E4?=
 =?utf-8?B?RnNZcVREQ05Fdzg2YWVTNzdtUVU2ZFViSG8yMWZUaURNenZZaUN0MW9FQTVI?=
 =?utf-8?B?M084WEk2Mi93SkUybWFFTGJLeU83QVNXcGtrTGM1NWxRdTdYYnh0QzhpNkUx?=
 =?utf-8?B?VEhZQXNrZTJLb010azhDZUowL2NhZXVMZ1VkNFVhbjhndjVsTUtqNFhmcFcy?=
 =?utf-8?B?eWZ0Lzc2WGFlaUtIRUZMcnd4TWFKdWdJMTIzSWJFdkd4cHlJQk9wR1UyU0ZB?=
 =?utf-8?B?anQ4OHlUbmQrK05LbkF3L2x5M2Z2WldxK2IyWXIveGliV2VRL1h6c0lkNkJl?=
 =?utf-8?B?T1VPMGQ5RUQzWU9GS1RnWGkyVjE3aDRRQnQ0bXlyNVJFUWN4ZEpQVndScE4r?=
 =?utf-8?B?RmtvTzBGa2VyNnZLYW9lTHFzSUgvY25iUEJMczBBbzRpNERSVmF6NEtRbVNR?=
 =?utf-8?B?SjMrOEZtNk13Q3p0VUdHUDdmSld3V1AzcGRtWk80Y3V5aVBiclpUVWwzTlFR?=
 =?utf-8?B?UmxEQmMzMGViMFlOUWR6Z3IxS1RKQXpEQ2svMkZxU3lmWHhDeFZvQzZCeDF6?=
 =?utf-8?B?OW51c1l2ZWJoS25uamc2SStYeWEwSjl6bSt6TzFOWW8yc2xUekcvdkVDWjBm?=
 =?utf-8?B?cjhjdmNiYUk0R09yYUhEVWVxeUUydTFycDdyQlNEVFQ0WDVxRWdqcjMxQmVl?=
 =?utf-8?B?UUIzbWpMQmFVbWdHeHAzcGk5bnVNMVZBdUpxODdpWjhDZ3poNVhFNWRwcXBD?=
 =?utf-8?B?enpTZ0pNMDVsbldKdnlLT1lHK1I2V053K2UvYTBZMnlqbUlFZVphOEpxTFNp?=
 =?utf-8?B?UEliN3RyMWhKMkFkNE85VFVoSXp5dHZpS1JrZ3J2NkNzYUFMdUdlS2NJS0lN?=
 =?utf-8?B?VXVSWXJFOVUzVGE2NWtqYUpjN1FCYUNyVEd2bWpuTm5xZ3ZNOEs0S1c4M25D?=
 =?utf-8?Q?xdYS/Egg8HXRENcBrE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b901607d-1b2f-4413-a29e-08df4187772d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:10:18.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQy0LIq9WLqEojWDyMbDdfRWobTgsu02W1coX+JXBfHi0EMzcQll5xpC4bES3prp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

On 11/12/2026 11:19 PM, Suraj Gupta wrote:
> Add myself as co-maintainer of the Xilinx AXI Ethernet driver. I have
> been contributing patches to and reviewing patches for this driver, and
> will continue to help with review and maintenance.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Acked-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065..6979b92b938f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -30613,6 +30613,7 @@ F:	drivers/iio/adc/xilinx-ams.c
>   
>   XILINX AXI ETHERNET DRIVER
>   M:	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> +M:	Suraj Gupta <suraj.gupta2@amd.com>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
>   F:	drivers/net/ethernet/xilinx/xilinx_axienet*

