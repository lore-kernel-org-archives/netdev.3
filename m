Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020137.outbound.protection.outlook.com [52.101.193.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98080416844;
	Wed, 22 Jul 2026 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739880; cv=fail; b=a5aPzIc/yuqw8o/IVkvHNemFard21seOvfaWIEHUUgQ4eTnIO/hrjIr4uNpobAJyZUFxZXCV3T/nvxRpi2Y0YqaTmUFGAWW4Cxoqm6+WVjKbKLXSbl8YpDvoFPqsv7rGTZlAbJeLFY9AYRmc2YZaIeCTAZhdaOKh9sXVcyxw5BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739880; c=relaxed/simple;
	bh=XhAtEG+Lm8KoGztHOeyjIxu2H+zkq0FQF90SrjvAXAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kRIqehCORtlL/qnvdIijyF7SSNUEO2ZiSW1K91xczI9aWMKBmP2FXXT5N4ZLo50JDhqfTGoIUt0C3NlNKUgoW7Y+6YI5ruWs0nBsUP1A9kH6jnyicBnWctFvbpbn5zVAWYztvMGDur/4XDtArDWQ43GACy5EjfyThDuk1k7UnSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=FRkp3QQM reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.193.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="FRkp3QQM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDI1Z3YGzdVBgKtSRsD+F3XF2ggL4fvdVQd509NwNj3/Cq43n2i7z7q46isxX35RhZuzFIixD6RmLc07S096+wNjORjWqpamsjr7olpH4h86yKO2lmPKyWOPmv5+2VYqLQ+55wR4PlsTu7M1EWYqylxhRpfvMFLONh1IX7GrX038/273kntNx4RRitMlRYbdlW6k6u9u6zluqRawKwWDn8CpdKkfCKV2QESXf0ZGVfR69AS27w5Gb2jRtVN3rQV1kByztrn4MmAryrQICLXLa817JCzdRurU2wCWReQz2Wdu9xtX/NDXuQ/sadGu/RxTFy5mrRSryhzcnMdNDijBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKfLtErdRUbxDkCMcTZBMxMZguylTC0fjjDBiqdJMKY=;
 b=QwzNNLNSgBKbXvXqu753hgqq22vj8u8931/Mz9t6u+CfWzYSxHFdnQwtarrd6DxKR1FgrXHNYPU+R8O3IGeSATGX5RNN4ji+Y8StOnGLCiQycw99tfrMdOq7acetxRupfymrGc2n5JUMfHG4pRmNSX46DEqLmNYLSXD1ixa5H0DWm9RVZ642h6lmSUfjcQgNI00ps9L2Q2tQwGwFiR8Emzkr6yAzyGc4mnfecy+Qyai7PQwvWsKKcmrJxs33ifWUt+K1gzkngcf583e62Sx0k+gGOYseFsKUG2cjqX0a9s7i1gXhk4U6S16J0fVrvwYa3PzNJzJGBDM9mXgD8TX/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKfLtErdRUbxDkCMcTZBMxMZguylTC0fjjDBiqdJMKY=;
 b=FRkp3QQMymew4H8nQ7qOQLvzGCDO/NOulVJBCmzNpXFBW8RBa00kNHkEux8TgGbTdlwfTqN/4V70E9VmeDgmlmi8vExWHZwVOOJB1YSRD1khDZcZF8Y1sKBNiBFik6wyzk5TvznG3FzvCr3CLjgL528WLV6iJf+My/t4Rz/Txec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 IA3PR01MB8724.prod.exchangelabs.com (2603:10b6:208:532::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 17:04:32 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:04:32 +0000
Message-ID: <de0d8a0f-7f08-4654-b9e0-b8a3c8abb349@amperemail.onmicrosoft.com>
Date: Wed, 22 Jul 2026 13:04:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v45 2/7] mailbox/pcc.c: ignore errors on type 4 channels.
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-3-admiyo@os.amperecomputing.com>
 <20260722-rustling-taupe-sawfly-83c3ac@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260722-rustling-taupe-sawfly-83c3ac@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:610:cc::24) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|IA3PR01MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a588e7-1e06-48ad-a24d-08dee8134cb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|10070799003|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|55112099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pxTpv4HcMK1Hv+hJX6WB2gm9iWO2YoOBo89Ii7gRs3hPnw3RiHvxbTmFK9cQm/oNWBxIeCvcymaGAUverT4v3HePguAdOFDYQ4uiF8rwctjPM2pN649HxLKTaNAzxheUxfMe+XzpvwqdcU/5K4/AyYdHVxlLPVQiQ+i6mFaIW1kLXJLnHhW1zL+5kOlM4pYqtyLYuZc8BQXGtKKq35DgoXNTXnJ8mKYdAhsdd8j+aQ/fgOZWuHtdsUSPIaSrNdqHGvMWZZbMQ34DxawgGbViPNa3QygaH18Ft9gQcvw7EzjhlqC8cDzGn7QkzSTT80CU+hooOP4hgKUpFIhvhmstMZEz+14NBe2M2o/o/Nm46JPRUS5wO4kk0xTkNGMz035wj6EMZ9VeqLuX6h8sCD76s3m5j0Y4uovC2FT12K17iB2odSaYr3T2oNqqkqo8D0V9i/omidmexIZJengmbnqD9LPt58uos1e9vHfGeoEthHZxmhTDFSl8WlYDyFyDQ6+jJgCnJfuLmoZ4LuDQJXxZ/16Fp0vobh9YTivmGdAjtd+Qh4j5v8QI6Rc8vf+XDCwRXnSNQdI5D1M2tZAwQu9xzLyADUt4GWtw1hWJHCJyjWU2CgVBbDfjhOlGf1FUd0cGfnsob0Sm/WsVsrQ6AgynZEoIIi4ELLMoAe2lsGmk0EM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(10070799003)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(55112099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWc2SXBCZG5NNjB6b0dhcUFKZTNGZUlWdDVTTEl6OWczZXVFU2FldUd0WCtO?=
 =?utf-8?B?azlVV2Q4dngzVDNsbkhLc0k4bU13YkRwc0N0SFg5SnVRQlFENCtUTWRtZWI5?=
 =?utf-8?B?bklWY2o1a1hBWHJWSGV0dDl3OGJUOEFIa000eUhzMHNHMXROZ1VLTlVqS0lM?=
 =?utf-8?B?ekFoN1RsS0JwQnlxaUU0U3I4RHI0UW1Gd3EvS2gyRDRlcFdTaUk3NXlrc3gw?=
 =?utf-8?B?UW5ZVHRjV1pnTVAzRk9GNmJaTkpuODUyU0hhd2tlVExOeXYzOEpLSzVQcXdY?=
 =?utf-8?B?VTA4bkZQMjRxN1RvZU10WTYzdEV5YUNucXk2czVGV3JGRmkza0VrUWN2SnVj?=
 =?utf-8?B?Nzl4MWlra1g1Vk9kazRIODFBSVM0c1JQVnZuT1BjQUtaYU5GUjIxMWQ0dW9G?=
 =?utf-8?B?ZHpQbU5RcmZNNldGTDhnbzAybEVRWFhSNzhwNnJ1eEhEbndRNzEzdnorRTVV?=
 =?utf-8?B?aS96Sk9LaEtPZzEwNm9YclZjUmJIQi9UR1d0K1VXWElOdTlqaUY5cnRWYjBa?=
 =?utf-8?B?c0dFNVJpSERHT1MvMi9TKzZtRHBQbkxRRXV1eXJWV2ROQUFhZzN6ODg0TUF1?=
 =?utf-8?B?S3libVZYRXNTU0F6U0ZZbHBUVG5LWDV3QTg2YVNQSjhSR0JJa0kxckVKdmxo?=
 =?utf-8?B?Y3lvQTFVRmRpd3pRTVk2d0xSUi8yWU5DWFQ3S1BYZkRMNjBPQWdPc2xIVnBI?=
 =?utf-8?B?bmRLTXRiT0hrS0NUc3ljeklnVng0YUtUZ1BBNFZMLzliUEwzOUlNTEZkWDRr?=
 =?utf-8?B?N2wvcFRyTTVJQ0VNYWJmZHZBT0V3Ym9wd3gxemc2b0k3M2NvOGljZjl3cmRL?=
 =?utf-8?B?WklHa1B0NlNVRzd3c0R2c0dpMXRteVMrbnFROGI4VkpBSjB4aWFtdWNJUy9z?=
 =?utf-8?B?MVYzaEU5QjJ2d2l0bDhGb3J3ZDJQSVROdnlLNzNMbWwyYktLekNuT256YTZZ?=
 =?utf-8?B?NWVWbkRkclc2N29vV29BbXNBdTE4RnNTeXVvMmRaZGdDSXlJckQ2am92TGZi?=
 =?utf-8?B?eXpWSmM2SUsyeUQ1dUs4SS9KSlRBRW91MjlHWlAyZnpmcElzcEFob0o3WU1T?=
 =?utf-8?B?Nk96NExOb0NwcUluR0Z2eC8reFRDZWZDYmN6aSttV2E5V0I4TGpGUnpYaGl2?=
 =?utf-8?B?WlNEOWd6b3I0aHJUY3VRTUhVTVY3TmpxbjZCbXNCbTRmcFZHTis1cXVBdG8w?=
 =?utf-8?B?cFNRZlBTekJUQjlIUUR2bmZJTkJMRk9IbGVBZ3UrbS8xeDN2cDFNRlE0QXFl?=
 =?utf-8?B?dDVyV3IyWmozU1RLM1dMMmxvZkJZQVEwM1ZXaXBkZnc0S0d2Y1E3Z3NKbTBa?=
 =?utf-8?B?bnZJb1JsZk1pdXczV2VzZENmK1ZGYnczVXJrSEdqYzlZWDhNZ1RnYXI2ZmY2?=
 =?utf-8?B?eTFLOTEraXZmdEFLMDRib0lXM3JhZ0xNVFZUYms4MUJqOUxmU01TYVRZSi9y?=
 =?utf-8?B?VlNWWHBuZmVXK2FLM3dnSHFQM1FtaGRDZ3djcmtGbm9Zb21MUkRSQi95RTZR?=
 =?utf-8?B?SW02Rk4vYUUvdmJYQk1LV1N2WUZzS29Iay8yVTFOaS96NGdVcXozSlQ0bXRX?=
 =?utf-8?B?M1lOUUtQMmVDeDlkTGdZZXk3MWl3dVVyS3dMUXZ3WmxTRUx5OEMwUjNnSjMr?=
 =?utf-8?B?Y2loZ0plUVF5TnlDZ05YSUovdHhEWmw5VXdlV1gwMnBHTjBGajVYcXFZeGNk?=
 =?utf-8?B?RDY0Ny9ua3d0Ym5teDBwK2pKQTl4YVBIZXhzb1JCb1M5NjkvME9lOUhrMmV1?=
 =?utf-8?B?L3VFZmRkUVE5a1ozNkNEVTNtc3Jlc0xQODZEZzYyRHFzK0x1SFZXOVhnSVhU?=
 =?utf-8?B?YmI3OXZ0eEtweGZsaDFleXFHejRHMy9rTDhqa1ZVMUgzTHVkdlN5L2dBeGJS?=
 =?utf-8?B?dGIzVzZla0lWZVhRUW9vdUcvdkJkNEN2a29LK29PMGNaUFg4SU5uMDV2dXBR?=
 =?utf-8?B?SlY2cEViejNJb1ZvL0VtZzYwVk8zL0g2T2xhK3VuSDgyMGhZVzJIT3dnM3Nn?=
 =?utf-8?B?SVV3ZGtzMjJ1MUdUZWUyYnZwdksxenRFaXNFa25nNE92cldjMldqbjk3dDF3?=
 =?utf-8?B?QjBsM1E1U3dpRHV3Y0RNVU53MHhWdHlTVVIvR3ZtbUxlTTdoQ0d3clc0TjBm?=
 =?utf-8?B?UUU0andDWHgvMk1BYU9ndlV2Zk5kcWVMMmlNME1NOGUzVXREeTVGbVBPVDNI?=
 =?utf-8?B?OHl5cFI4ckM3WEphV1loaVdyODllNks3MHVuVVRqbEI1Z056Yk0zbWswdUVl?=
 =?utf-8?B?Q0JqeVNpOUprYXJFZnlwNlQ2d3VhWVEyQXYrcU1KZGhBVWlrWWR1MkVhcXdC?=
 =?utf-8?B?b3VPRjhUcGZwYy9JelN2RjVxZmIwd1JzSWtQbWRjcEtnZk1kRWVHajlmSmRD?=
 =?utf-8?Q?CkuMz4jfupbkHeyx8HK0sONA+jhtx5ySjxI+tLqlYYv4c?=
X-MS-Exchange-AntiSpam-MessageData-1:
	78RZZvoSnnNZkGMqY7CVNQco3OJERWKnwlzKHHyV9DJwU3p81nw5udjy
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a588e7-1e06-48ad-a24d-08dee8134cb7
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:04:32.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx0+0xnGWFj85kR9vTY2Qu+ztE69h0OBH+TWx7SY4iwXkAi/+W2Adgg2zfYD966hugsgYxe9Df1kRLyrYps4C1FvaZd6vQGXRP6HeDel99etY8v8/qHK8ltI1BlbCW0O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR01MB8724


On 7/22/26 04:55, Sudeep Holla wrote:
> On Tue, Jul 21, 2026 at 01:52:51PM -0400, Adam Young wrote:
>> THE ACPI spec states:
>>
>> "[The Error status register] Contains the processor relative address,
>> represented in Generic Address Structure (GAS) format, of the Error status
>> register. This field is ignored by the OSPM on slave channels"
>>
> Does anyone have these error status register for Type 4 ? If not it can
> be optimised with that check rather than channel type check. I would rather
> avoiding adding checks on the type of the channel everywhere in the code.
>
The requirement that errors are ignored is strange and I have no 
visibility into why it is included.  It may be completely safe to ignore 
this rule. We have not tripped over it in our hardware, which is why I 
did not address it before. I cannot speak for any other 
implementations.  However, I think the exclusion needs to be here for 
compliance with the protocol, otherwise we might end up with a case that 
we cannot support.  If you can suggest an alternate way to implement the 
specification, please let me know and I will try to encode it.


