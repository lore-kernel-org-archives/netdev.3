Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793972297;
	b=TNPwmo/K9cXRLE2XsRvV4lBetVZ4oHpvTTLjV2k9eC2JO3vjxeaC2AVMIeTMMgeJhbsq
	 zFBjUohvdBQ3QfqEAWyGykibhfQLaagKD5j+huLKGrhalvsZTmX1CdQF/JakFw9//ShIr
	 rHJEIFGi2K0g0ESQy5EMV02xN9rS63ThnDhEOMO/WmWF6LTyTdG4mdlh6R03d9R2nkxOl
	 j/tDBgyLdLF8TfU1ICblTp41D/9l4vySYgzsyfH1SczcrtTHyuobIJfcAwOssHyHGDYI/
	 O9Z4j2LdteZUv6vkkLtQxiW1lwxzCtii/7MblV4ylNUjmDkeil2A5RwipCrb1+hh5XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972297;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:To:Cc:References:Subject:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wvWrzoYWQi9jfDhbSHT/2btNiRwk1TNbvGUu4kNoeBA=;
	b=cF4YoWuBTySGseMvlHIBtJ1ALQjJiUEt6RjvvJfV4l4C7WjULgzrPk0JbJe87tzThy/r
	 3xsDMjtWUN97Uhn3Ja7kpbCMUJoNQZo2YQ94OfYxiorf0VZdlLRN33BzT4gAXnd+medYK
	 oV61j7QkcYvtPd0KrbsxAqxLi/5kUeEv4KjcsnPdZTQUTnBC2FjaV7m3DDvKeEOkXRVkK
	 L2Zl32i5G62pLAv/a5p0cu2v73CecUD1wmbv9WojVPVRBl+RFsIgF9qB3bFM3iMsMg+Eh
	 /KGAQjZTytoXYAyJlVGeWBAyyq1T4hibfhXxhlzOTF4fQibKHRVTZN1fahAEsXuozaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="lh5T/1sy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.18
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010018.outbound.protection.outlook.com [52.103.66.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25E606A326;
	Fri,  6 Nov 2026 13:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B25E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=lh5T/1sy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFtB6Aiil2J4qry1TwoJg30I7kdNUsdGxQIerUg1N3vs2yEjoY8WsdzFi/sq8ieu0a8QrVR0fh/tfqeeiQ1B71M7a8jRD3Z95JWxErgYN6NPrOoLLIB/DKLr0KrqEufuHv9ATUAfyKo0HTicanl0vyxgUKwhRwgosDWyz2SNqsEJVGjaXzq/ItiLp3vBlPlzRmkNkW6y+1PfWbCJFkZi+4CHHzUkdoLW3rMdRoXChIfKVsm6gefgTY31QNt08ZJZxFvgZE0nvuyt4h/VacSPBKPmn/ZCvbwlD3g92HQhvvXITUSkOgy0duYRLbd7FmX3+wZDiBceNjbuWbXwTMg7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvWrzoYWQi9jfDhbSHT/2btNiRwk1TNbvGUu4kNoeBA=;
 b=g2dD1yaci6taVr31I7EL2fyD1pz3ktasc/EotaFBKVrmCIAJ8fiyTlW5yO4udg/4QuVNeuLyUYUP38xt2mp5apv1Q9uE65gCrJfW8OBmq2DZtuBsPS9t+SG8btN+odRxjDlT5mCssgjxwHyNyAIrmf1HltRk2R3cnugXmuPtcoXWybGqXNnqcXs4PmQ/hbOTGPnVJoUckClFxk4ST+0Kn/6ip0ruMqWp3xAu16xZqgFz3eWxqbqspXn4BQ2vIIA5pWOcYXQekLC3DdxoBlnQDod6pX9Io0jeuS4feUC5zr4YHnmI+Xd3Mv0JTcquar2Sunk0i/RZZkAt1P1kOmqUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvWrzoYWQi9jfDhbSHT/2btNiRwk1TNbvGUu4kNoeBA=;
 b=lh5T/1sytuqEPc9yktg7r4SBWJiBW434+rGF1WG9jJaZsKfAIo9QtyNttFGiiErxHr07JWgtOh4+3mZsaCxe1JNROlePmqb+wyCQGHCCQKqJIJ4xqfAM7p9d+rXt1q3ZcHQ8T6t2f8O1m6owtFna5UEE7kEHSCR3on3y5T9JGNCnZGEYRMdWPp6+cea7FmN9cAtANPaU/lEiDCJ+Pkxr42bBfZAie/ajwWlENABS+F3LncRJHIrW5qi01Nmb2NKVjEHQpgYvjokDN7Vp30M6uQrjIjcBKzRVyeXER4F/D1B0BHTW7kYtxUjf3ezXnibV0+u8sIGvDumg0VRMVHJP5Q==
Received: from TYCPR01MB11008.jpnprd01.prod.outlook.com (2603:1096:400:3aa::9)
 by TYRPR01MB12666.jpnprd01.prod.outlook.com (2603:1096:405:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 13:38:12 +0000
Received: from TYCPR01MB11008.jpnprd01.prod.outlook.com
 ([fe80::d61c:732e:48f9:fb9f]) by TYCPR01MB11008.jpnprd01.prod.outlook.com
 ([fe80::d61c:732e:48f9:fb9f%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 13:38:12 +0000
Message-ID:
 <TYCPR01MB1100852BD6000EFAFDF14A418CA762@TYCPR01MB11008.jpnprd01.prod.outlook.com>
Date: Fri, 6 Nov 2026 21:37:52 +0800
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
To: ralf@mandelbit.com
Cc: antonio@mandelbit.com, davem@davemloft.net, dxld@darkboxed.org,
 edumazet@kernel.org, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
References: <20261024092532.172005-12-ralf@mandelbit.com>
Subject: Re: [RFC net-next v2 11/18] net: ipxlat: add IPv4/IPv6 header and
 transport translation
From: Xavier HSINYUAN <XavierHsinyuan@outlook.com>
In-Reply-To: <20261024092532.172005-12-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0087.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::20) To TYCPR01MB11008.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::9)
X-Microsoft-Original-Message-ID:
 <ca98e2b5-d94a-466d-ac76-182a67fb5156@outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11008:EE_|TYRPR01MB12666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fed7c36-2948-41d9-9932-08df3c0b333b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|25010399006|24021099003|19110799012|8022599003|23021999003|5072599009|15080799012|12121999013|8060799015|6090799003|25031999004|3071699003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm1PNXFscHJRZU9mb0l6TytEaDMxTGwwQnJ5OUtOdVQ3aldJSS9kZzRwMUND?=
 =?utf-8?B?aTBwNnRBQWI2dlk3ZVpmQ015alE4cG1VU3JkTG1xcXZFV3F4MENxbytnQlF5?=
 =?utf-8?B?U25oYnZYN2dHNS9tRWVOMTd6bzhnMDlNb3NaclZrNytCYUZTWVFacmFBdUlN?=
 =?utf-8?B?b2cxaElKbDUxNGxzWmd5RnBac20reVVxUkgzZ3FvSHJMcDFBTm8xUEtxbXNQ?=
 =?utf-8?B?MnR3a2RQb2hHdTNMY21ja20zVkFMTGFpQTdPcXIrbmVBdlYvQnJjRmNvazlo?=
 =?utf-8?B?N2NPRHN4ekt4UHRPUnpmWnJDelJxK1l4T3QxRDFmejZReFBvYUhScnJ6UnU1?=
 =?utf-8?B?T09GM1hxQTFkWkQ5SHBmSW1JcWh3NDZMcFpwQjNndzgxUWhLdHYrYzdnRjI0?=
 =?utf-8?B?Ym5POHRpOG84bEJ6U1VMbm1FTGFISDVxTlN3NG5Ha0lLejFVd2d5bWRma3Qv?=
 =?utf-8?B?RFg1TG9aYlJXa2VNbmZnZFhRVk1jWlY3cXpiVVFwRFBGSFVINi9nVUpsbXZp?=
 =?utf-8?B?QXc0Z1FJMDd5WFZpQ0RzZThLWGZ0UW9rZTZVbGMwV1NNTi91OUZSWHVrM0Nr?=
 =?utf-8?B?dlJvNldSazQ0dW5TZndoMkFqZmZnWHluUjJIazBQMmlNRDB5NXNyOU1XdEU1?=
 =?utf-8?B?MkpUOEJLRTRLY3ZrRi9GSG53T2Rhcm9HRDRveDZCRExXMTNtQjQvbDRpTDk5?=
 =?utf-8?B?dVp1ak5POTRXdVYvLzAwSzdRTmovazl4V3ZYK1BucGc3NUZmdFB3bERWYm50?=
 =?utf-8?B?UlNXVWMwK2FIT1hJQnFHdjE1SUdmOFM5R3B0SXpzeVBuQ3J1NVJhYzhadm1U?=
 =?utf-8?B?dndxV0RSSS9kQ1JodzJvbENPR2NvY3QxM3Fxajk3K0JFWTBEZ3h2RXpkdjVv?=
 =?utf-8?B?emphcFppSzBEREtCcHpOMFlHN1NXMkdIdk90d0xGaTZhUWRqd3puYTFySHNy?=
 =?utf-8?B?YXNPbm8wbWY3cFBwWmN1MU9Kb3ZESEZHQUtQTkdwWFFEUkxxTjlHdG54a3ZH?=
 =?utf-8?B?YTlIWUVaQ3RxdWFhYm5wZjk3UUtLVjMyMm5IZTRVRkNXa3p0VWc1VTdqOVpV?=
 =?utf-8?B?MTM3NnJaVGxpN1dld1FuM1BKZkN0R2dDNUUvRVZZVTUwZEZPUVJNOThna3RZ?=
 =?utf-8?B?T1U5Z2R2K1hVK0F0YTloM01RK04weXJLdkJtZ3p4TjJqQWx4LzRGTllyeTBi?=
 =?utf-8?B?c0pOL0h6S3lJUlpaVHpxYkpSNzNRL3FjQ1lrRS95U0Q1MWk4VkNPM0ZYSDJP?=
 =?utf-8?B?QWVRVXI3ZjBBeHNRTGVhRDB1T2xiZ2ZSci9TL2V5L3JhbCtja3pmNEdyUmky?=
 =?utf-8?B?SVFkMDJ4TzFmQWhDQlArMlhhYm05YWJCREtGZ1RvY0pWWUlMeWdveHpVZ3Zx?=
 =?utf-8?Q?PTdPfCNzGD/m76HNBN4TXW7yXuSVR8i0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFRYNEJUWWRLYndJOXp0Z3lUUENPK1ZVNHE4TUtwRHptSlpIeVpkMjYwSXFx?=
 =?utf-8?B?MFpuNnN0aU1kaVFqeWpYd1ZNbmtZYklKRXJVS1U4V0pyOHd3c2Y2VXlzOVZt?=
 =?utf-8?B?eHJWZXpHRy85YnBNUS96R1BOSENqdVY2MHZWMENOeDdtVmhORjdBRUpyNExO?=
 =?utf-8?B?ZXhkK0IrMXhpdFJJTDRGdUhwZWpDQjlUUFdzOWEvNjd1WkF0WW5rOTIycmQw?=
 =?utf-8?B?SEgxUzdSK053VnNmWURlT1JocFM2azNtYUhKZkxxVDZOdE4vWm5zR3MrdU1X?=
 =?utf-8?B?NGp0bHFxbUVHbWJ0TGgvTmRkU2l3SVJKQnRBZkVLMllQSEpWM3BzMTA0Q0t5?=
 =?utf-8?B?d1Z3di9JWElSKzFnTjJVMFpZOHJrVy9JbllyVmFDSlZYd2dQN3ZQUC8zdFlC?=
 =?utf-8?B?M2ZYdm1ZOTdITTBNUjg3K0hqK3lkaHVhMUpCQUdNNTFCallDZ2ZOVno4aERt?=
 =?utf-8?B?UFBVRWtvdFZ4VkcweVE0ZmMwZmlIaTJ0K3BJOHN1eDkxL1RhUGVZa1pYamNx?=
 =?utf-8?B?ZE5MRlpmek4yMTFILzRoYVdZbmwzdHdEMEVEMUg4ZTU2WC8yYkp0NW5ZVWxT?=
 =?utf-8?B?TVIzZ3VaSXlmTEJsQStwbFNmZ0IxdHhlejRSaU5uSGJZWnF1NVMzWGJQRDlz?=
 =?utf-8?B?emJMRDdGa0kwa3NDbG85bHFhbFU5VElXcmdTd3dNcFBKMVM1WFg1dlRJQWhS?=
 =?utf-8?B?NHZsRGJMZStuSmMyK2ZGazJvZGRRTGR4Q0YrUnFjbnRSQlQwVTl2Y0MzdW52?=
 =?utf-8?B?YkxjaDE0a3JHbGgydGFzbFBkbFZ6MXcrS1pCVDdRME9WblN5SDluSEtGZkRL?=
 =?utf-8?B?YkRUdVFFTVFveVljWHpkL1RCc0FKS1pOVHl4T0hCbjBBRGpJblh2TnZVOUpz?=
 =?utf-8?B?YW5TS3d0SmVneG40VTNRdXRJK1NkQWZJOWhwQTFBb0FOanFpbzJLMzRWQ2hm?=
 =?utf-8?B?S2pJZ3RMR281YU5EYXVBYzhwaWk0WkloYkd2eGNSSzRMSWRYTEhCaFBSTXU2?=
 =?utf-8?B?TWQ4WkNlODdtcVFyRmJiQlZ6aStlUE85WmNDUVowQU85TGdmY0hVckFrQTZr?=
 =?utf-8?B?WllyV1MzR05oeEl0cXlBR3Bmd3NKSTM2bjFXVnBoTjIyUjFoRVU0MnRjemVZ?=
 =?utf-8?B?dnRmbTJkZ245T1RmanJkUUhkelFPTUdwZnphcjFld1lYc01pQmlSODNFaDUr?=
 =?utf-8?B?WW9uZnM0WUs0eGxuNTRUZExGKy9rc2tPOG9jUElScENsNWpwKzdJdVZkU2Uv?=
 =?utf-8?B?d1RVTElodi92UXZPakdTRVhrbHh2aGxSdkgwZis2c1hyOXBnb0h2UWQ0K1cz?=
 =?utf-8?B?VkFEUnoyYi82R1luYnZVL0F2SU54ZCt2ck1CZHVCUmZGb0gzVXg3M2VLRUpu?=
 =?utf-8?B?QlAwaGRJS2x6SkZoOXdUUWlHQjZRSzNNczBhRXl3N25pSEdjNjFzU09oMENJ?=
 =?utf-8?B?QXkzWVlXVzlrdDhSWDFXR1M5c1I4a2RZTXF5M3p4aTRBSUxta2Q5ZCtqeUlF?=
 =?utf-8?B?OC9lV3NaaTJ4LzYrS3lWNWRERnduOXU5eGw5T2h4TmRjaDJicGYrZWdweHpG?=
 =?utf-8?B?VXNYZHg3L2ZtS3kwRzk5Z3FFcGd4aThiTHVvVXA5dUQ2QjNyZkRrWXNabWRk?=
 =?utf-8?B?SHRicmhZKzhaWko2aFJ3SVV6MHZhcDJjRHZHVFdEaGZxbGVQbGNBb3Jod1Fm?=
 =?utf-8?B?UG5KdEVIeElVbzE5c1JXaVZnNGRJWDl3KzNTSHRYL01UL1h5NTBtZ1NodTh3?=
 =?utf-8?B?S05WUzZ2bnFRZGJ4cFk3S3lmaDhXa1FJTXZGeThFYy9xUTZSU2ZQWHk4Nlor?=
 =?utf-8?B?eCtKTU1HUFJDSkNpRzJnWlZaN0VJbU1YZ1RXSWxEaXZRelZuVVhWZ2doTGpj?=
 =?utf-8?B?ek5KUjRpZ3JsVys5akVPV1BSSjVtZVpMM0xKSFNoVXgwaTRpTW8wcEdSTFVP?=
 =?utf-8?B?c0lMZ2Y5R2FjQXREaXB1NndlZFBYUVAxUG5SemFzWHBVWktBYW1PSFJvRE5X?=
 =?utf-8?B?Rk1wSUZubWFBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fed7c36-2948-41d9-9932-08df3c0b333b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11008.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 13:38:12.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12666

Hi Ralf,

> +static int ipxlat_46_translate_tcp_csum(struct sk_buff *skb,
> +					const struct iphdr *in4)
> +{
> +	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
> +	const struct ipv6hdr *out6 = ipv6_hdr(skb);
> +	struct tcphdr *tcp = tcp_hdr(skb);
> +
> +	/* CHECKSUM_PARTIAL contains a pseudo-header seed rather than a final
> +	 * checksum. Replace it with the translated IPv6 pseudo-header and
> +	 * leave completion to the later output path.
> +	 */
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		tcp->check = ~tcp_v6_check(ipxlat_skb_l4_seg_len(skb, cb),
> +					   &out6->saddr, &out6->daddr, 0);
> +		return ipxlat_set_partial_csum(skb,
> +					       offsetof(struct tcphdr, check));
> +	}
> +
> +	tcp->check = ipxlat_46_update_l4_csum(tcp->check, in4, out6);
> +	skb->ip_summed = CHECKSUM_NONE;
> +	return 0;
> +}
> +
> +static int ipxlat_46_translate_udp_csum(struct sk_buff *skb,
> +					const struct iphdr *in4)
> +{
> +	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
> +	const struct ipv6hdr *out6 = ipv6_hdr(skb);
> +	struct udphdr *udp = udp_hdr(skb);
> +
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		udp->check = ~udp_v6_check(ipxlat_skb_l4_seg_len(skb, cb),
> +					   &out6->saddr, &out6->daddr, 0);
> +		return ipxlat_set_partial_csum(skb,
> +					       offsetof(struct udphdr, check));
> +	}
> +
> +	udp->check = ipxlat_46_update_l4_csum(udp->check, in4, out6);
> +	if (unlikely(!udp->check))
> +		udp->check = CSUM_MANGLED_0;
> +	skb->ip_summed = CHECKSUM_NONE;
> +	return 0;
> +}

Pseudo-header seed in CHECKSUM_PARTIAL uses per-segment length instead
of the aggregate length, resulting in bad checksums for almost every
segments.

How about updating {tcp,udp}->check with a pseudo-header diff like
inet_proto_csum_replace_by_diff() to preserve the existing seed?

Best regards,
Xavier
