Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793804789;
	b=G4H/ym7fjMIvbfIyRYI10sJChLv36/0EAinKSGG7q2QCC4YBhWvEbloGTOjNzjyl8Oy6
	 b6HVPKIMeaopDHXMfrFTsFONtkHsZEg5txwOFFDMNzj5bW3O/lQtUr5JHGbpzHMwUPGzH
	 LJr5NktHXUSdB5GiuoQ0DIznQlMTp7IQYKpqGvC3FZ4tMsSz9M3QFyam8CwW0Q4MMQeYR
	 pYEgy6F76Jjsvaq82nP7Hj8JxGiOPDQv/YGE2iceDdMIhLmolbXg4rjdkZihjsA3bUNRO
	 cF4uo+nxh8U1TbtDB1wRblQpO0EWUGaGvAShfSEgYojHMlyj9JOKVRhWwHhIm9EFzEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804789;
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
	bh=1UTWreO3Xoz9KDcqqqq/yfNbC9mdGrW98Onc2caIoiI=;
	b=vxfAoKlXQXs78xduksWJzDmi5jshwWdU9Jagl5p+7S1JDqrkg1O7JfUUfBlWwnDKuEwr
	 vk2Ta3JYWsqB4PSzP75WSuI7sD6/7FZAFfLeJuE7EG76ORJbq2kuWC8p3ZT0fQOd4vWKu
	 e149QQ1uzBHX5nn2lrXzsnaSAeUkGeY48DnuRaGpRkLN+fAlMqGPGZ+NT3BMO8I9HyIt2
	 ZCmaMYQlzOc3olK/9a+LSk2t6mrIzMvapMKl3+oC3LZLCyOjWN1fb+eBw7KMimQst54pe
	 31eARQgFmAfURA2QsyPZrlrQ3VrUPNAK29/cMX0MBPnCwNceyaBByf2T+/oPvt9cVYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tWGs6YUJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.11
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CF606D819
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 798CF606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tWGs6YUJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8WJM/dNl29foDQu75aycFkevTdSdUAnKEQID0i4km4gMmHQ4jd+eLGFzaev8SrQ8Z6wFI3HDRtGv45lBsyzOql/9MaejX60yV/F14E4VRlKp3u+iaWLnMdmy3+gRSg6oCE4Q8NpI1KCYZRA2lrWzOaEuHjVn5bcj/fxnEqNpyF+vgy9BFNJ3nQ/bpcMzk+kurVapIQggCZjZ7baI0AtIIPtPv8A+gM/L63XNhIlnYULbMjZfMu8QLGubTltAamPaQmnYOjVAkxruoJ/H3+vNfcGrmY2tACfOoAA/S/00diICFXgHMkRLnnwFZdUQy1er/UhW8COiiGu1CxnIhk9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UTWreO3Xoz9KDcqqqq/yfNbC9mdGrW98Onc2caIoiI=;
 b=eE+gshSFPvJI2pTxOr8Ica90YZ7FPtA8BXcPEZpGrqCvZ+qgvIDrUmourol3VZUd7xZPpWvZu6F96TG5271ceIsfRGWsDK/eSVrfPl8AtSNVUBQ6nLA9GjZVG8cl5BtGE6lnIxxj+W3KC8fpbytm0b8hrZQr3+ajMEVeKU9llMVYXcEj6FlGf3t76m+6CGfmgMYw0HqahHPSS7cpmxfkrIyDrLO6RlChahSmAj9Fel6ltMfHPregDYnA1BV3xNA6GAQE91vOTKbwUI1VCKTSIoW5PM94WXCgKw2epbmAOrspVZS6+nxveX4KgUyT7CIAsRXzpXvdDtn7+YnEfiTGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UTWreO3Xoz9KDcqqqq/yfNbC9mdGrW98Onc2caIoiI=;
 b=tWGs6YUJ9MURbCj3FnXpm/gXTP/NZYFF45gnaGQ4/6XT2v4BZt9T/7wSFZD++DiYugt4oSxtLM/KGWmbJEnUjTRxdtGgWbT9sZehQIEcm8csMtxuKr+SwOae18VvC4nExtlhUezoio2Xq2oaB54HULZsPqv6tuyrVZFYMei2YI0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:06:25 +0000
Received: from SN7PR12MB8817.namprd12.prod.outlook.com
 ([fe80::2315:726d:7ec3:416e]) by SN7PR12MB8817.namprd12.prod.outlook.com
 ([fe80::2315:726d:7ec3:416e%4]) with mapi id 15.21.0569.008; Wed, 4 Nov 2026
 15:06:25 +0000
Message-ID: <16a1cc16-5b50-4c9f-a345-45b2759e34ef@amd.com>
Date: Wed, 4 Nov 2026 15:06:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: remove and replace myself as sfc
 maintainer
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org
References: <20261104013138.4103896-1-edward.cree@amd.com>
Content-Language: en-US
From: Andy Moreton <andy.moreton@amd.com>
In-Reply-To: <20261104013138.4103896-1-edward.cree@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::22) To SN7PR12MB8817.namprd12.prod.outlook.com
 (2603:10b6:806:347::8)
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
X-MS-TrafficTypeDiagnostic: SN7PR12MB8817:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: d4111a85-747b-4641-b48c-08df3a85318a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261021123027099003|261102123227099003|11063799006|261022105027099003|56012099006|261021121427099003|261028144727099003|261026140227099003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6gNKq71ulz6+6qFA2HPHmVnR065ur8dRjzVVJF3HUuZaCC/7xYCpslCQ6Rdk5+nPkeFcse6ICkvg/kYmDyJxNLuefeY1D8fObt02KblPLtWoI4jIzIynAhYXKDIPUx6O9Ig8RQkX1pWSx+zjZE3zxZRVBCVk9wyIn3VEqBNlmFItA2sFUDKFfRh1mqzQziRQgxaeW0azyKDCoUo60MCUW/nAsZMcN5t9cSDPIF4iBUnFE8cIjY3tNm4WSVvGVNoFkdWTxYZcay2HL8lIwPYYWTyHNie4UjY4O67vwJEWtzA9vjuq+KX0x4HIEHHP36TRzFRarTgSAPhboNC4oBA3vi4SqUZvyNEIROOiY3hoRg3q4legTya+TefNgHklUMHZwEHdHMuK2c/U6L2McT03j3hAaDsUTnk3Lhq2b3giqqaOPEMHHDi6gtzQVnphOvi+/NUxNA/WaBUBCMD4TfNNVTMZrxfqMfIlFZY2na+1TMHd2pxDWaKBKwL8aJx55TplhMdor+b8ex64FyUDDcDEBwnWqDjRiAeQKAiExSG94GZjx1Q1uHDY9Ok0GwgHhhtwIidcxOTKx5uQ/PDJH5AsVtt6o+VkVvPD2ZScLMGLC4UNKHZ3Bx9mUXT38nJTazt/o2Uf5BKZBuwtHDbyb43S9T7ID50ogl8U2LF1icnacxU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8817.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261021123027099003)(261102123227099003)(11063799006)(261022105027099003)(56012099006)(261021121427099003)(261028144727099003)(261026140227099003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjRCWmRzY0FVTTNPeUMzRTZ0dDBXV3hjQ0N3RkRJZ3pzbTR0c25oeVhpN2Zh?=
 =?utf-8?B?d3hlcmFJQzlsVGpYM0pVdU9naTlpUFd3V09LS2JRVHlpY0g3R0hGNlkwOXJv?=
 =?utf-8?B?cnBEVlk2Nmp6VXd0SGVrdm1qODBpWmZXaWhYWmV0NXZPNFU3aisrWFU1MHlU?=
 =?utf-8?B?ZFV3enM2L0U1czVIUldYTkxMaWs2cEpPOXhoMy9NRWVuako3U3h4eFRrQUlh?=
 =?utf-8?B?L3hSUkczNFYvODR0Zk5ObXlia0lLbEN1bElJcmN4eEhqbXV3ZjB3d1FzRmUy?=
 =?utf-8?B?ZFhGYmJIYnJiMnJsME9XeVBTVXByZVk3QWt1b1lHMWlqaEVNUTllSUZyTFNv?=
 =?utf-8?B?cjh2THArOHY3T0czMzJLd3gxYURsZE50NjFNS09Zd2paYnlidHpyK2FYVWg2?=
 =?utf-8?B?VTFkZFF0ZU5WN2ZtQ1daRzlYdjE0c3NOSlRIdS9mRW9tNTFIVGFrUmxadDFD?=
 =?utf-8?B?MTQ0clVXc2JTV2lLeGpIYXhFSVhIaFJKMExFbU4yeDVtd3lZT3VLZ0h4NU5S?=
 =?utf-8?B?VVlPaEpHU2p3dmdpS1M2c0R0RUd3a01GSjc1Znk5eU1WWENzejlXdGdycWZ6?=
 =?utf-8?B?T3EreDdJMk9ld2RYN2pYOWs2OS9odm14Y29xUHo2a3JNYUdnQ1ZjVEpEWGxk?=
 =?utf-8?B?aGZodjBRUzlOczZFTUhpaGJWR2czeHVjLzBGQ2ZPVnd5ZDJPMGRWRHFpYnRQ?=
 =?utf-8?B?bStMSUNQUFU3L2VHazBYaUNiQ2dBRmFOZC9xQmxwamxSVWhpR3c3dktwZWMx?=
 =?utf-8?B?VGt4MTVXUUMzOUpyZkV3bE9MZ3lzaCs0VHNpTHhPMVg0d0hTZWFjcE9SVHE4?=
 =?utf-8?B?akJGcU1EMmJVYkZSdWMwK2NFNGY1dnc3K01yKzRIWG9BeW1hM2ZqN2lUVUFW?=
 =?utf-8?B?MTFWVitpTTBJOVVKQmg2SXZ3VEpNUG9yYXdPRGIrR1FBeGtjTjV0SjgraWQr?=
 =?utf-8?B?aTBUaVFDWUJIQUNhM25YdVkrdno5TjZQL0JBblZTT2VxSlJxYzRDQm5kZ2hs?=
 =?utf-8?B?eXlwRVdOemhVSS9FRkZZcExGUzBvZlIvMjlBVHZWUisyTDIyWGpZR3pzbE1G?=
 =?utf-8?B?bXJqUDdFMXhyMHRUUFByWWlVR0JUaUZjd2dVRW5KVjVodUM4SFppeTBxT01L?=
 =?utf-8?B?UHBxMUpDSC9FK1N4OXUrWWZmQnFBKzdZSEk3Y0dlL2lrRVF1VHlteDVvVEV5?=
 =?utf-8?B?S1RmTGJ2dFM0QjRISllveFkwWGFxNUdqdlBFZi9pVUtvQkxpR21wOC92S0NU?=
 =?utf-8?B?ZG53K3BxK3R0UHRBQTJteUpHdGpVd0RUYXV2YWR3MzM1OXFPSitiUlQrc0xZ?=
 =?utf-8?B?MTlmQXpEZjBXMHdVazRUTXFrUHAwYTgzaXFiUkJNd083K0pDRUhyV2FJNkNL?=
 =?utf-8?B?d1BpR2tIdU4zS215aHVnUEY3a3I4QmlKSzN6TGN0a2M3VHhzUTduandVcm96?=
 =?utf-8?B?ZkM3b1RTUzZsUjhTV2cwR0tEWVdReHdVWXVhNy8yMnl4U3ZSQWQzbU9HeVdw?=
 =?utf-8?B?eWVZK2ZLNzR6TXhDS0ZCS3NwQ0pNUmRaNU5UREVTNFJoN3VRelZLVjVjSEtU?=
 =?utf-8?B?ZXovYlhjMU14MU53bmV4MDhqTGhuRm0zSTFOMUlrVEd2bFljNEVPbmFOazFn?=
 =?utf-8?B?WXpZNzMrWGhFUkNtOU90NHJXTEwreUV5Q3dUckN5RmJMblBlSTlPaHlQek9w?=
 =?utf-8?B?MTQ2NzdDYnVTZXR5b09XdlVVQThDeHc4cTYrMURkOUwyL1o1ZHpLc3R5Z0VQ?=
 =?utf-8?B?NHcwWmNuSEdDU2ZURE0rNmVjN1BPWkJYMXAvUW9OUDJQNHFiK1NzZFJDa08v?=
 =?utf-8?B?YmJqQ3FMT21WTEdnbEd6bkw0OUp5VmtvYnhVWm5hNHJzUi9VUmVFbUpqTUIr?=
 =?utf-8?B?cDRJUFRvOVZOajMwOE1saXJVbTFrYUFxN0szRUl4VVo4eE1NSGNoQVN0VlJF?=
 =?utf-8?B?d1lnK1pCdkw0THU0cEM3RlpudFcyV0JDWVFuV1RNV1NSUzh0YzBYQTNRUmh1?=
 =?utf-8?B?cDBER2YzUUp2dU5QYTFpTU5NVithUjgrUVNkTWlKOHNOM3ZDWkVJbUgwK2xY?=
 =?utf-8?B?azdzV2JoLzhCSVM2TmsrdFdIVlBGSlRyWXErL0daclpnamt6aTRnT0xkZzNi?=
 =?utf-8?B?ZDkzTDM0cGRKdk0vWVNoMXp0dUFlbmJ3ZXc1QTU0eFdQaUlmR08vdFlJMTZs?=
 =?utf-8?B?d1ZkWHp1bTRlRElubHZXWnZaeitRcXZuZWRJTWpjYWFiVEE1ZC9tbUtGRUJS?=
 =?utf-8?B?SjRwcHNJdVppaFE2RHJyaHgvdDVEaGNCUXVybklUVXM1aER1eHRNdjJubmFx?=
 =?utf-8?B?aWFJL3JQOFN1OFZicWY0NWcweG5RNU5nczRGRHVzQ2ZSOE1Dc3NZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4111a85-747b-4641-b48c-08df3a85318a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8817.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:06:25.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq/M/OxRkvey1gZ1O/ijW3YX/Rk+tEWGlOEKY/XTk4CZBNUxvNPUT2gCpLehSxDV8TU7n/twZr3RTMOnakmzJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

On 11/4/26 01:31, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> I will be retiring this month, so it is time to hand over the baton
>  after a decade maintaining the Solarflare drivers.
> Remove my M: line, and add Alex and Andy as the new maintainers.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09713dc4c6a7..4d43d3559960 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25465,7 +25465,8 @@ F:	drivers/slimbus/
>  F:	include/linux/slimbus.h
>  
>  SFC NETWORK DRIVER
> -M:	Edward Cree <ecree.xilinx@gmail.com>
> +M:	Alex Austin <alex.austin@amd.com>
> +M:	Andy Moreton <andy.moreton@amd.com>
>  L:	netdev@vger.kernel.org
>  L:	linux-net-drivers@amd.com
>  S:	Maintained

Reviewed-by: Andy Moreton <andy.moreton@amd.com>

