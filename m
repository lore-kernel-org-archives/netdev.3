Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794481016;
	b=COKj4CUKr9dKdzFYif+aCIwH84PAEkT9DsiWkgts3xsz5qIIL9TLwltUihO0KhAQmU7+
	 mujqWKD3e5qRmVgKW6RRzlep/NzY0sd5PyAWAPYsfQ568gKwZBrWMueuDdV77FNf03J7K
	 fJsfIdBaPiCj8RxUFojdJOzxexCPtkTlWHV1kZE4e/Ur/tNq29rEeUK1JwYp6Sz3N8He9
	 HiTsO1a/9NvTZv+hxgIc5UAzQJZhlR6fhCFt7G+prKcbTxgTGDyDvZkw5ONyom23hXFPk
	 opjphdLYptBNQvvmoTe+SoRI1QZBk3ojIxTuKm+VNZM/zfBSLM7lR907tu4l06n+bqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481016;
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
	bh=PurGLV2Xtj4ZnWDhQjLnoYknfYp4PalUOAuW5X8WO/k=;
	b=vlF9Vj+2nGGrbjHdloIpnTzs1CadiZ0cuNN55HZNJ6fLv3bAUF+wP1ehnVeMjmREy5mK
	 TUz/EToKFSfYB569egLzCsKaqAONyluVGZy7SjDG2MRKYXl8XAthCbYtQuQYsd0p9aYJ9
	 VGbOLVT6EZE+8CrAC6LO2WZaVc8dMpwuZFSVgRO5XFYVFQG3mQDZz4MmIBZxRIamx7A6W
	 Wba7cRylxj6Hc8ynymFy135p9Va+Pa3rcC0ZGB22+DMKR0aUpFKyMnI0BLWxSwT4jX6Ge
	 EZ6T1mMxshXspkKclrmK6bTaa9v6tAg2egIOooMeBSIGF687xuw7s4VrSj3chrYbFBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yicdVSJv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.59
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F868606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F868606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yicdVSJv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utJv73SwHR3P3GcLDkPpDvlPVeHmiVi7fuk4Mswv5awMV2zyvhf0SEOujYN+SVc6Tjav4hWeE7/LjM14qxb2YDgIeIyApXOFrdx2lmZK0T7H1JnjrrRPNJiWu+KiOSmLH/udtbrsI11x39nOLB9juR4kHAOkI46MWaGtxx6Tb2fq6p4QGBuNwqALtdx95V8vD8O6BzzElnYPrp490A4Bd0QCZdL0U3H/hMu4ueLkH6SIjaHc1IhBk7uZ49nVlLraG/TsOjMumnlxE/uokwYC73xCBwTXQf4nh7ibdz4CHpdyokw+QsHzj7MavaEc2v9ZGzTl1cf6s1VEdHdFKueO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PurGLV2Xtj4ZnWDhQjLnoYknfYp4PalUOAuW5X8WO/k=;
 b=HsX7HaTfzJzCNKXqZybvGrWtut9C306llm+hojOfHPaxjf627Dhap4S+1vFyPepkv8CZ3TD7GfFbtg7yG0nbfJVf4UhuneOStffg5UslluHRNcVZydMTjJvZTa8rGLQ9kiKwwxsEdONBgEdIZ/Aw/JZ5JA5My6Ov/0m1kgYQEq7h8WEFHw6gh6Q+vHtQAz7tWc4F0cOW0WF2kKXIWxq502G7iu043xqLGWuyHjwHhcHcOCnaWWQTKrD80My4veIdU5RDHzbEiZi3GUEcqq9RzXviaDfeZmi5RM6vzz+/gr00YPK4Z9kjLg5oc9xO0htlQHP69PhAwPuYnSJmgG8/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PurGLV2Xtj4ZnWDhQjLnoYknfYp4PalUOAuW5X8WO/k=;
 b=yicdVSJvI1+eHUiAqtghXuMlFSpMFWyMrJAdoiY5vEWNhimK4H7jo35Ya+0n3GOawYwEREOaY7C36x2uSmsSCh5mrTs7mLgrGGXxiCeHYKrsb0NlGdk0521LxfnwceEg1cycYT+fFAsH6lSkS3Vyslr9p6LpO+YJxLpTWSVwWEc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 10:56:49 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0546.016; Thu, 12 Nov 2026
 10:56:44 +0000
Message-ID: <9776328c-19a2-4025-b8b3-c008db019448@amd.com>
Date: Thu, 12 Nov 2026 10:56:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sfc: add missing prototypes for ef10 helper
 functions
To: =?UTF-8?B?6ZmI54ix5YW1?= <chenaibing@cmss.chinamobile.com>,
 netdev <netdev@vger.kernel.org>
Cc: linux-net-drivers <linux-net-drivers@amd.com>,
 "ecree.xilinx" <ecree.xilinx@gmail.com>,
 "habetsm.xilinx" <habetsm.xilinx@gmail.com>
References: <2aff6af5293d4b3-00050.Richmail.00005386047582601673@cmss.chinamobile.com>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <2aff6af5293d4b3-00050.Richmail.00005386047582601673@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::11) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 136906f1-7170-461d-9396-08df40aba41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|260925021911599003|260925022911599003|260925021311599003|56012099006|22082099003|18002099003|11063799006|6133799003|10067099003|261009223027099003|261102130727099003|261026140227099003|261022105027099003|261021123027099003|261021135927099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	0U5yzyhxJVCZ3cH2GKcHSCZC3b8QFwZv1bkyFcLRwfrHy0ibBtnP+UTO4q96dF92h8QeHBryjSspeeWUKE2pMsbm1+adjVwFX3Vp6CWrLVDGAnjnwV7enen6kNnoaJNE3S2LMdC1XEeRWHloSzQOqF7L3EppzhrGNa2BiloA/0I1c87yE8QbCJTfRsie8njV1i58CcpVio+3OGO9DHVMGXxf8XBiHv7/peebVH0sEWm3uc8m3djQH5aT6swq7+pDMxY8Hf1m6dXBD786OqNJIJHICr0PTYkuuYI5vLsHD0qziS1/IdC7FrkuCMoFwaJMtexujdB1Hmdt0SwNXBG9jZj9lQ71V6ruHLmh1L7ArJh/lXLVKvkSic25AHLpqhmQHZNYDkvKKEm7xiTWxYvEkjwUZwQ6VGGYN2K4E3aao2cdACFQGxkiKA5/tYmh6dE8X12bcDD7hJXjFhJAzMX4tQznoeK78IFxGCILL11/0EhAp+jUly2zZpGsdEeHH4hfPl+5rfScBQB6CsIuwqTxISSgaHjqFBMsaCXoRGfXRCeuL9VgkwmDdHLgpCsdoWBLs5fqxhJlqxxUnnwkCCcdK28loCwxnX0fpANd/HEq0wnkz5fG7woztON4RMDPwLSOh7fp2xH0KcepA7gZ7tZyL4piHthtTCYSxMHXKG3tuRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(22082099003)(18002099003)(11063799006)(6133799003)(10067099003)(261009223027099003)(261102130727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021135927099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGFnWWdLWEFnQ1lQQjVIektMMGp1WC9lZkgvRHZKNjJTOThraHNPYWIyU3Fy?=
 =?utf-8?B?MGRTS3dGV1Z4Rk03cXdVR0hhZUZyM09oa0x6cmlVK1JlUFdxKzFCKzFKNmpp?=
 =?utf-8?B?WkVxY2R2cjZ6ZUVGOG8vb054cXRDNmkxU1NDWG5uYk10Mzl0NmU4d0QreXJz?=
 =?utf-8?B?Y0JHQTduRVIvVDF4MTdLUVFkNklMZEFPUnB2Ym1NeFJ0a3FzMlV1VDE5QzdO?=
 =?utf-8?B?V21OYXk1NG5Ob1F6S1UzdjNHSG5Ecjgrdm1nUTcvRkY2aFdFR3EzZjFoNy9L?=
 =?utf-8?B?U24wZzcyemlNbHdBY2IzUnVWY2dJRE1zN1BEK1B4YndlUXIyNEZjQVUxY3dH?=
 =?utf-8?B?aExvc250a2pBcmRCWlk5clI0dmxldWxJUExGTE1sdmhRYUpOUWVFTVgxcUxo?=
 =?utf-8?B?Y1N6Y29pR0hMcGZlZCt5ZlhsL0UxWlBoLzRiaVVVN20xRll5V1ZScDhsa05i?=
 =?utf-8?B?a1NQdnVSZy9CYjJ0c3Bjb25JQzRHTU0rS042RVJLck5EMXFHam5OQVdJQWlQ?=
 =?utf-8?B?SXRIdSsvbWJJV1NJZVg3NDI1UWluNEVJRnFSODY1bS9mVkpDbm5MU2ZFT2pr?=
 =?utf-8?B?dm4zbktKSFh3K09kZ2NHRnZ5QlVIbzBPUTR1eXd3MXh4VzhNV0tjdW1JRlZH?=
 =?utf-8?B?ajdDUTByN0VEczF5eDhBNWFBbHNIRU1Mc1gxYzFIT0hNOXlIU3NKdFVSTnVP?=
 =?utf-8?B?dGQzSUI0ZlI0WVNmODA4ajRKTlAvdkorbW43ZjFZNFJiZEQvYUsybUdtZnJi?=
 =?utf-8?B?dGR3ODJ0eEl3NFZOaHMwWDlWbnBsMy9kK0REV0tiTFhUaTIvQ2UvYW05R2Fl?=
 =?utf-8?B?MTVtRG1iT2RhZzVwbHUyQWRMaTJuZDJIV05sT0dmRlQweURocFdaU0lwQnN5?=
 =?utf-8?B?UkRMbFlKelBEOEJreEdaUjRDRVVlbFBlZVFSZjhucXVwQktmNVRiYk1jendW?=
 =?utf-8?B?dkgzR1pGSEJlRDUyNzJpbU1PZ2c2VnpVVzFaQldiNXlQaWRqUjhhMXNnR1JW?=
 =?utf-8?B?dGJJNjh5OXlOc1NCK1c3WFZhOEs1bVpqNU1QdDNOR2VLOTZIMDFUWG41Wk9I?=
 =?utf-8?B?ejBESlozWWlhN0MwRnkzOXlKSlhsc3U0YmtmMkVVWlNaWkNsZE1HQWc4OHZl?=
 =?utf-8?B?NFhGNDFqWkhhZmFtelFSa2tXc1cvbmpNTjh4MzdPZnBEeEx2Uk1YclVGQklt?=
 =?utf-8?B?L0d3VXVBYTB1OVRmSWxZbENsaDB2a3FKejlrUmpoYS9rMEw2R01KWGVNSFdG?=
 =?utf-8?B?WXpMNEp0eE53ZXVramZXbFZxY3U1dUFwcG5udm5yMEJkQzRNK2pCbGlwZjhp?=
 =?utf-8?B?SERBbldKRGhSL2tQOTVyN28xd3pnSkpWMmxIMjdZMWpxWWNKZHZodFl1K0wv?=
 =?utf-8?B?WWNkL3JXQ3dsVjVZZXhCMDhOajREWEUvaEN5KzROMCsyTXMwSDgwQU1jWkJW?=
 =?utf-8?B?b3BIR3QyOHlQM2VsRFhHcnRVdEdoWG5Pa011TE1CMDIxRDgzV3pFNXk0UzVD?=
 =?utf-8?B?b2pYODNJR2ZiOVh5dGlwWi9vMGdvUWVxQkRFUzRwVkJCcThxRE9MUXZ1K0tK?=
 =?utf-8?B?M1c5eEFmeWd0NStTaDJrT2dPdWRzQjBCT0dJRkZpSGFLVEpkQVBlNnk1OUZR?=
 =?utf-8?B?QS9oZUNqbTZhNjFCNUdUbzFpa0phaUoySmM4eG1yZ1RCOWd5cXd4aWZTWEEv?=
 =?utf-8?B?dTByQjNUOVNQc3hrSHBQVmtsb05vRGF6Ky9kbnZ0bzQ5ZU5GZUVIZTBCOHZt?=
 =?utf-8?B?dTBJNWZUL3JQQUpCU3o0Q2IrbUZwMXpRWjBOVlUyaUxLR1VBTVRBSGxZMGxI?=
 =?utf-8?B?b09oL2tpVXk3c29mZ0ZBenNCMWZpaU1LZC9GbjhvRmZGUng1VmVFQVRYRU5a?=
 =?utf-8?B?WGx4aEtPa29ueDR5bmtvdDR6cFVXWFJlTUpuOEdvSFM2RTFpbFlkM0QzaGlu?=
 =?utf-8?B?cHRwL1hCN2VONnZrZkpUVjBaV1JqMjdXbk8vejdBdEhkL20zUHR0cmNzZWxi?=
 =?utf-8?B?VVQ0RGgwU2lEbVZwaVlrTjk3cmFnRi9Ec3hqblNlT2ZpUUpUQmJUQ2hNZGFG?=
 =?utf-8?B?NjZNNS9xSEpvSncwUHJZU3YyOHpZcW5kREt1RXFBQ09KcEVuZFNwUDkvNnA3?=
 =?utf-8?B?Y2I2QkpCeFE2ZFo4MzVoK0ZHU1E5V0RuRFdpdndYODh6WG1VWXI0TFozeStx?=
 =?utf-8?B?SzlYY1UvVlRFSjhWVGFheW8zU3lrYWM1VWw3OWt1VmRkQ3k0bHAzK055cFlm?=
 =?utf-8?B?NlAvaXFJV2JmRS8vVC9YYk5JSEtyTHFiS2N5ZTZQY2NvTmNjbExwUDUwY0ww?=
 =?utf-8?Q?BEJAlhNpA0KoGdGrRG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136906f1-7170-461d-9396-08df40aba41f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:56:44.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOPYpDHbH+INYB3TEKml5cYh7aWFsKU41HVjoFZHEDqdzMjPMhKyRpbUdRk6X+ibeAUTTfoPUCGL1vgJZUtdAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333



On 12/11/2026 03:44, 陈爱兵 wrote:
> 
> From: chenaibing <chenaibing@cmss.chinamobile.com>
> 
> Fix the following W=1 warnings when building with -Wmissing-prototypes:
> 
>   drivers/net/ethernet/sfc/ef10.c: warning: no previous prototype for
>   'efx_ef10_vadaptor_query' [-Wmissing-prototypes]
>   drivers/net/ethernet/sfc/ef10.c: warning: no previous prototype for
>   'efx_ef10_vadaptor_alloc' [-Wmissing-prototypes]
>   drivers/net/ethernet/sfc/ef10.c: warning: no previous prototype for
>   'efx_ef10_vadaptor_free' [-Wmissing-prototypes]
>   drivers/net/ethernet/sfc/ef10.c: warning: no previous prototype for
>   'efx_ef10_vport_add_mac' [-Wmissing-prototypes]
>   drivers/net/ethernet/sfc/ef10.c: warning: no previous prototype for
>   'efx_ef10_vport_del_mac' [-Wmissing-prototypes]
>   drivers/net/ethernet/sfc/ef10.c: warning: no previous prototype for
>   'efx_ef10_tx_tso_desc' [-Wmissing-prototypes]
> 
> These non-static functions are defined in ef10.c and called from
> ef10_sriov.c, but have no declaration in any shared header.
> Add the missing prototypes to efx.h.
> 
> Signed-off-by: chenaibing <chenaibing@cmss.chinamobile.com>
> ---
>  drivers/net/ethernet/sfc/efx.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
> index 1234567890ab..abcdef123456 100644
> --- a/drivers/net/ethernet/sfc/efx.h
> +++ b/drivers/net/ethernet/sfc/efx.h
> @@ -209,6 +209,18 @@ int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
>                 bool flush);
> 
> +/* ef10.c: exported helpers also used by ef10_sriov.c */
> +int efx_ef10_vadaptor_query(struct efx_nic *efx, unsigned int port_id,
> +                u32 *port_flags, u32 *vadaptor_flags,
> +                unsigned int *vlan_tags);
> +int efx_ef10_vadaptor_alloc(struct efx_nic *efx, unsigned int port_id);
> +int efx_ef10_vadaptor_free(struct efx_nic *efx, unsigned int port_id);
> +int efx_ef10_vport_add_mac(struct efx_nic *efx,
> +               unsigned int port_id, const u8 *mac);
> +int efx_ef10_vport_del_mac(struct efx_nic *efx,
> +               unsigned int port_id, const u8 *mac);
> +int efx_ef10_tx_tso_desc(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
> +             bool *data_mapped);
> +
>  #endif /* EFX_EFX_H */
> --
> 2.39.0

These declarations already exist in ef10_sriov.h and nic.h. Does this
patch apply to net-next?
