Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F613264DD;
	Wed, 23 Sep 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129313; cv=fail; b=cOUm973AEGnah+t26+tQTrKcQM2jePrp9WxfjFobnyQe7gcdF9EyH/t9OXBegNqG3dK0VIKsI/dGecPk9/yFD2cWih5cnyGPUrsxuEfjZFmnS2vqiZrxqDx0+XF2FoAez9L7ntZ5Uhb2ssU3rmp/MReM6OFV85qh7LX8BpJbClo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129313; c=relaxed/simple;
	bh=MW2TGEDUHW9s61SoVadypkbyYtWEgbD1tY1XVwRz1v4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mLYtQSOAc4FLGr2D66DmXDwWgnaDZK5OfasaM6yKU1fjuCKD/pZLzlilsub0mkKwhNCKXaNGPWwWGrgh8gD+iONVOTjyv/SYepi7PkwhuZxbqINLNvEmRMI50INmyjAC2YyMMPwGICofZQbmteyw2Hpbb8dSOkI7DC2r1Qs00e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hO4PN2F7; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="hO4PN2F7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCHsnZlDWBMy1R/zXY5yZ6MTC9kZTi/oItZRL+sxuDcDsS6c0S4qyn5Wn2nkbLGiImx0Jf0Thdb4SoPXwL/lYH39rMAeZPFybDikSjDAkjjUjWeqzVOauOtgbXcvgpGIR+naplRMRNuANpxJlPZKPXLFbybUyF6d6rL+ciI4qcuX3x6GJazbYn+X0OiTTR+dd7zN0IPm0yric9s7BSUQeIUn3rdlJai3+DTRazXhmoTFOIvUgPkBgi1lmuDCpc4sgIQ5AucUqktrVvj8V/PzR8BwYSQrGv0gPQFKXswPHmOxsXhkfKQwVUcHokXMxp9xPx8ZtyByXwhG4MAEblMKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFgSja0ZOy1TMAtmAWaEDHharBXslK2OiS92KBh/SPM=;
 b=PBqyXMc1jOehcv5Oka57ypK/GmPC0lCBLJCs+ZgITsHGAe/Fqv7ToZIQ2h4EKuB3O/JIzkO55v3ucsWv9z2xM4B18KibJMLysn2Llj9CJqgyz1CkluP7rUzo8oFfU8KJJ5jSDBM0M51b4W4Gm2OqdveING72echsnZN3gV/QuzXzmXghDTH7AZHrp7LgKCrTqH5ubzrKhBlD32VdEvSJGi91XlJArrxrF94Nbo+Anu4wvsEu+fzybbC2TMLwKuKRCG0h47Ds/4DpEr5uscIGuLw/W4ZQvxLoGOndYKY9Zn2NexhZm58n3CsPo0dKUAqQNDPTNuyfPgXMnjeyCZ9cFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFgSja0ZOy1TMAtmAWaEDHharBXslK2OiS92KBh/SPM=;
 b=hO4PN2F72zsP2++pHNMs+f95cYG9UQ1b0VYb17frCetKE+MLWOk9dsmDe2CgSPQagvayPxuxR6Q+NWn0Uehw0EszK82fs0aPzQDDMre5M/iq6fbfTrUu/EZRABw2gIxDJJXglhf/jfojBcdaFw/qF9vBz3LAHc8TP9NuGa6Kib5od8BOEYkNPSZ42G53IPzSJCVv5w+OZwKCCqdqNnZu7SO/cjFok5IsycBq5NIXxXjd7ddsHErbEvGA25jzqpChn51hXG2836sVETkIYMxYyvolkn1u3CJWISJDXt4+T848KCxRQiQwPxrL5WZLYbruiEoOvydjj09hJaAG6Glfpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DSVPR03MB139884.namprd03.prod.outlook.com (2603:10b6:8:37e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 02:08:29 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 02:08:28 +0000
Message-ID: <dec371a4-d288-439e-b07b-6dade8e56c64@altera.com>
Date: Wed, 23 Sep 2026 10:08:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Add Agilex5 SoCDK TSN Config2 board support
To: Jakub Kicinski <kuba@kernel.org>
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260921133938.003a5a19@kernel.org>
Content-Language: en-US
From: "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: <20260921133938.003a5a19@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::7) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DSVPR03MB139884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7ffeee-cac8-4136-f7cc-08df19178f0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|55112099003|5023799004|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	xVtWwEHWHfg/qI/5hRFpQr0eDqWwlp615w8JL+ocpOJpsvTzfHiKx5GQbl5t4PE48CFN2xB1nSpK0ECSWEukBTEacZtVV22AOEDAk68ebKyou6ePK+Y50ob7yt/n+UZjms3oI2Bw3LqgAmFrU1coHk5Pq7aFk+ID9+RLiZAU75+mF0fDUfpTUfG1YTt1U7AXlMChQ7DlpplZOFhd+hhJmyXUho3h2bW9wrBYDGrlHqGn0CLGEifFc1hyCMItFK6rQh5UgH3v7tGwXjBbQwW70W9QXwUnNKr25n6sOZGHJh3a2CZ+ClFpj1/MmHq2JtLGzZL+pG4GJlxYX7w9BDljIifPdO+5QLGfflFxPbgz7L2YlXQe4yzJ5PeMIF8MSKLNvOslQWA26NkQxyHKRmKotxYFggBdl2icHHn6HFVXkBw2qA1sBnuLSmIT3vH6EuUxDJRRnbksHZtmC2ei0LF+++yABZcHEFzfFbofg5texL4QTNls8kKOXYo6/AUNSkHhA3NmhVrhUZhHySzv2Pxsg2MAk5eLebYHDyngDhfCj3Cr6suOR7L12BXYWbVywruh9QUCrJy6gWc1hZ8V1JSKtQ8nH7W9NQl3EoaIwuK7uSAZaVhcgOQJTeMiJHj4nJGUYcYqsZ1BvV2ZJXhh2/YY4elPR2TwgHdu0uam74K+dfk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(55112099003)(5023799004)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T21YSE8rOFdkL0xhYld4Y3V4TEw0YlJMRHZSYzI2U2pvWmFwV0xyY0NMaGlX?=
 =?utf-8?B?Q1QvNzhQaDR3SVZwQm9nQkNrNW5nTFRTSjEzOE13b0dCL2FnUkhTem5rSU1l?=
 =?utf-8?B?VGxZbWtiYjFBVFluSldoM3V6TTZ2OFNFaXhmbzNERzRtREtUN2FkdnQzTGtO?=
 =?utf-8?B?TTVYblU4SlZlM2N6dk1ncndjS3NGRUlJZlFOcXZMRy8xN3NhVkllUnZ2RW9s?=
 =?utf-8?B?TzE3QTh4b01DSThwT1JFL1B0cURwNlo4MlRSay9UU1JTckpFWlR0RXF5dHZU?=
 =?utf-8?B?UVFoMDJHRmtSWjZ2Y2trNWZkODQ4VXRtYjMxcGtwaXRYbFk1QW55bHg4WUli?=
 =?utf-8?B?UStkaHBpa0t2WWZVNnlud1pmZ2tML3Z4VHJzbEdRODhCSkdNblFnK0RzYTRV?=
 =?utf-8?B?bHhqR290MVo3MmVsV1VhNWFQbWhQUU1uUWFXZlZiS3pOMlBQdkNMM2l5NWRK?=
 =?utf-8?B?dXNpZm1jNnJjYXVpdGo4VVdla1lCRmM0YlpyYnVLdFhvMXJHVkpmeVRsMnp2?=
 =?utf-8?B?WU1ya2JVbnpEbHFRQmlxTjl5OWJ0WUpFMGkvbzRDZ3hCVklGL0QzQXJWZjVh?=
 =?utf-8?B?R2d2SjZWTnNqTFpoRlBEc2pNTHcvQ0xycGVEcmxqMnpZOGQxQ0V0RkNjc2N6?=
 =?utf-8?B?OGJCZlUxc3JKMUhLZDhGVFBFaHF1cDNCL0xYaVQ2OUF2NFNUcVJINWZDelZl?=
 =?utf-8?B?em5rSU5RclNaVjMwSEtQRGdoSFhVUGQ2aFFIRGFUYzI1R1JXNnUyeDhyOG1B?=
 =?utf-8?B?cDlCbFBNVmZCS01JYUsvVDZIUmMybzNIQ0lnY0c5VTNsQ09KaGoyMVgwTHFZ?=
 =?utf-8?B?WkQ1dnRjZlR2VTBwa2wrb05zV2lPUzdiQjFVNGxLSFZDcjlERVdxL0pLbENr?=
 =?utf-8?B?cEh5SzZ4RlNRdVRLN2tHeTQwa3ZTSUV4ai9UL05wVTQzajE3UFZTZ0FlNXhz?=
 =?utf-8?B?KzRyeUZUWlNYNWx3Q08yeDY2ellyTkkzRWNibVFBcVRCR29TTFVtY2wvYm02?=
 =?utf-8?B?RHFBcnBtakFHMStUaXBpcnYwV3oxbmowRm5WNDUveG5RakgyZEZId2R5WXAv?=
 =?utf-8?B?Yll5Sy9nQTZBYi9IKzZnUzN4TDF5TG5kWCthNmFURXpvVThTRmFZVU5VWTVP?=
 =?utf-8?B?M1U4czJUL25QK0xEU0Vlcy9xTklHTTZ3Nk9oNzFVc2s5ajI1Y3hQQVJCdmJI?=
 =?utf-8?B?MlM4Tk1IZnF2aXhLOFRPUlRDQlczR1dsWjRudDllQ212Zyt4RkpweGFNU1Fy?=
 =?utf-8?B?cnA5RVlVbmVYNkFrMzYwZlY5ZGk4VnlTbGJ0ajBvZ0w0cG9zaldabGJVWW9h?=
 =?utf-8?B?OXZ1RklHb2NTYWFMWXVkS3JaMHZqM1lycVhjQitWbmJraUowK2lYaldhWmpm?=
 =?utf-8?B?OU1iVmNsZm5kY25RZjdvcndLUC9WU2F1RnVWQXdURzdSS0lId3hPb0ExL01J?=
 =?utf-8?B?bXU4c3Rwa3BJS1BNK1RwVTBVaUlDVUtsWnNnZ0pGYVg4eHMrSzB3cEdJNXNK?=
 =?utf-8?B?M1R2bmZDUFAvRFhySzZRaTNWNS84TDNKTEpSVWkxK1RzRlYwWnQ3Ri9zOHp6?=
 =?utf-8?B?UXVOdi9jSmVFT04xRUNFLzh1TGhtMjdMOWU1NnZoQTcxVXZVVGdyaytpbFVX?=
 =?utf-8?B?T01ZQ1FWa0Jsc1lVQUxwTHV5L1BtY1Q5cDJ2aTEyd3pTcXhzcGJZdkE4TWM2?=
 =?utf-8?B?M3J5YklEM3QvS051SWw2ZTI4Ujh4L3Z4WGFXcmtqZTNGSGVpOTVjZW9RMkR2?=
 =?utf-8?B?eUVvcVgvZnhUd1F0WW1wc1B0d2RTaWRDRTBGZUFhR3hDLys5OUh5a3R0Uzlh?=
 =?utf-8?B?b0wxcmljY3E3cmZReGhlS2ltbWYvV3V4TlIzNzNBSVJlMzAwVTROb0owckJD?=
 =?utf-8?B?ZEhaaUE2TGhqSmpzOGh4Q1lUSlFOb0ttbTBjdGU4RldrWkYxTjE4YTNzOEk5?=
 =?utf-8?B?UVIzZnVEUFI5c0ZIUjBKNDlsWmd0TTNjM2tsQm56VWZJZStGcDFJOEZnV1Rs?=
 =?utf-8?B?ZldQanBHdC82Y2NFRWI1eHBYYjdvRllSYm4vQW5HdkJJMFVLUXpzNjNOcEln?=
 =?utf-8?B?NWRyc3poZGxISXkvL3lzS204RUNIMGNwYnhSWVhiZHY0Zk9qamo2VkdsbHNr?=
 =?utf-8?B?OWR5ckNTR1ljMnZpSEc3ZlVLY21ycmVXQ0JkMGFQY3A5L0l3c3FlUk9HSWta?=
 =?utf-8?B?bCs5VFptcFIrUGZSMUhWaGlHY1N2dVdvV2RKc1JGcnN2M3VVMUNJMmdrYUZ0?=
 =?utf-8?B?N3JvSkgwSE1EN0QyZTlDOHR2dGdhcnlIOG1DQ2FRakx2L2N6ZHAvQW8rSnRi?=
 =?utf-8?B?eDJGQnVoM2RwNnhkYkIvdGtkY2htR2RGdEVUZ3paM0xTSnAvQzQrd0tLNWY5?=
 =?utf-8?Q?Yn2NgrQuqRn4T6GGpFRfkkCfkX/bjxnFljR8M49kvU+U4?=
X-MS-Exchange-AntiSpam-MessageData-1: jCKm2GKNrknugw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7ffeee-cac8-4136-f7cc-08df19178f0c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 02:08:28.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLmNZjKxs+8jkNT49YGr384LW0JvpM/V0v12tsA5Yf42uP0i4zNG9sWARoO40ffk7y5OkQdUlceNDzImWqU0QwxF0Aj8O1uxxboEGcsUsizfds9FPGS6la3hTCSetlqUwfSUfQ5ilQDIV/PoQGDNLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB139884


On 22/9/2026 4:39 am, Jakub Kicinski wrote:
> On Tue,  8 Sep 2026 00:05:53 -0700
> muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
>> Subject: [PATCH v6 0/4] Add Agilex5 SoCDK TSN Config2 board support
> This is about to drop out of patchwork, and we need acks.
> Please repost just patches 3,4 as a separate series for networking
> (if the series is still relevant of course).

Hi Jakub,

Will separate the series and repost it. I think its harmless because 
this feature is for tsn config 2 only and it will do nothing until DTS 
part are merge and meanwhile it shall not break any feature.

BR,

Nazim

