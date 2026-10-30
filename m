Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371851;
	b=ewX1YmRiu43NAiNHF1gOBLAYwgX+KWxcuNf5KNUR2XGC/im6kNits8mekxtpmTjg9Jza
	 vfeiH4u1uCuvAkD53oF593F4u03JrjDPymK14jQ86ed0yBo2/kdth2NQYwAUSyXO8xUl3
	 lrFXxE0KeqPmCHw+G8aRqES4tnrd30pCxJiljGalPds79E1dLzP7oNx6XbDUz0GJfSgvQ
	 +5LxafjpXK++nRWy/bU/8+gxSDrbHcjRAiXrCjh2xtHnXjficCinZTbrlMf9U0ln/YnkO
	 K83lNY+Hm/0/aTG7h0rj8n1uzoBFhYfO1EM4JxGZ4akJaN/t1cigPQFwxdtJf7L7XHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371851;
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
	bh=iG51RddM0VbejHEn6/2dEi0PvCvF7i4r5vi+URC0sn4=;
	b=zC2ESnE/3S9yiW/3CKo+0ej1tTZAhH4CQhSbwezHyOND5P58lDJisnXiyspsjXB+4cMu
	 ry/hp883VJ+STlzuDLrwBQ0NKRB3yyqnT43LDn6m6RcAUOeb/IPqdvBh/7OtB5iDP/PTz
	 faxS2WTf5ZTupptrGlk7Bzix/bVh/E9bUrWJbo18xfQTuA2T9ZDcjoXdSpbXr8sRLxqAm
	 jw+6A620KQFSxliaO9XSTCoogY4r4vL/x1MRR8aZt0T7Gv/k8+u03n/57xcAa1ozGHRjB
	 HwPoJ0treKtQwyx0VT3+DZpwVx6Z2KZoy5jgQzVejzR2swWM/dWtm2ScUzt0rs8MTpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fya6609Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA871606A31A;
	Fri, 30 Oct 2026 14:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA871606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fya6609Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyuIWuSSmpwVzb6VurZtc61qoWP4FUL/VoVCDn4oWkqz9bGJX7lQu8tNm0k+Zm0paGQ3VjRIzX5znix9nASBZAhFSIxvLBAxFK+/P9ZLTdUoIYooRMB/CLhJj8DP5b7vZcNXl59V4sCp1Ke22W3kzjRxAeca2G0V96O9yOKGgZvvI0VZGj3Z4R6QGTClL/XxaSDk47t712xsXq5R3dBGkKYxOB41xjiAk9FXceFlDM9CywLNpH12UAozJmys7/XSGvBsBySU6AejMvD0y8iHLTPx2knBtZi5u4Qk7e0eYdiR8ATRkPFoy/i8seeZgL0xz3ZIy+o2PxYzoh5jSo/PmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iG51RddM0VbejHEn6/2dEi0PvCvF7i4r5vi+URC0sn4=;
 b=aWzAuhzMSNa2dalKR9O0gCSuI8+dmXzScfpKvAt4PHUV2SM81CbFmLpAzeADQi6JXonaTzDZyOt7JTdOowYN39avySzU8YKpG3fim7XBzNbGFXC8AMpcnPg9bwCaIkpaTm8elZBgw4PiaxmO29jkUZM+hVMKawFY/Dq2f93GWbE93lDKSL9g+L0UWhvoctT5cOov41C6ZL7UbhcGmqry421pGykLSSUCTH0p+qhNPMUiDfaTzNFzaHtTjtGs1rQB8wuVXqB3EWhWykMCu+LM8L1SNXRzaR3EffNRYTSKkQLv1TUTjskeRtuxsjHnL4UStPur8obgCKq9gWf0udwjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG51RddM0VbejHEn6/2dEi0PvCvF7i4r5vi+URC0sn4=;
 b=fya6609ZNFbokk6lfB/b7IfNt5kgQ3OFoPp0XpHpaJ4i0kg1RTACol1+GT2Ia1dGQ/3BepuGQOHVqwXia/kMVsQ5tXg7T4ovzRAN7JX1EfDRbYdRRGWtjQDsCpQpSNXh+mDoiGbFkaBiGm29GujkSjTfNUZvWGzxObLU52InxiQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 14:50:45 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 14:50:44 +0000
Message-ID: <2b16b50f-6d36-4867-87fe-d76c3f8a58e9@amd.com>
Date: Fri, 30 Oct 2026 14:50:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/3] sfc: ptp: serialize host and MC
 synchronization transactions
To: netdev-bot+sashiko@kernel.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com,
 pieter.jansen-van-vuuren@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20261026123023.3566549-3-alex.austin@amd.com>
 <179336481081.3134.5405870739856758840@kernel.org>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <179336481081.3134.5405870739856758840@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::13) To DM6PR12MB4283.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 270f231f-ae0a-45d5-a49c-08df36952d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022075727099003|261022105027099003|261021121427099003|261021135927099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	a7O5uHU2ISTdTeuIo1/Re5kABT1eDWEey2MIGyeIMiOheOgNxMGNN9hQUUUmLzXqerU/zbwaEJ5IkQl1uql6TUtZdkhBL3RE04op3cvYzRZgblvtFwC5WgUHveyssxMHGjIA4cXE0jatWsYcHabWfZDjD02Tc2Og7o+2ppr4JErxrUePlW6v/kTsBob0MEgppPWk8NvndxDjUrdvJ0JMj+Hk1Gn23RuM4Tuj7r2S2t/I58LvBXdAqJ5wtG5EQgqtDNZwGh2T46xDXVLO6ovgXfDasvDyOxe8JX+yLCiMkftXK+cj7+gxU1NCxQQqUE0u2AMMWEuA0waDPAys76UNqXN5JBEXePRs8PNbwX4kxxKN/RSZ+r1Ny2ArYdMCsDhpJcKMA+kXWzt9jcfZtp9HxFz3DaWtRBgD1NQWYeVzeTJwniCbSDbkkKbIw0acmN3T/hEz+N4E7soqqqhDZFpoCDQi6fuYI2sbEN8aG3btQe0b11mLf3hshHyno6Nc6+bPlXRmRteZ1gIKqSoEg05mBkqTVC7qGz7+PiO314ejJYdu+V3ChmM0v4gQUUsHEj1rl3mJiqrC2F612Xy5vO0qgvevsMDt2FuBlEEXO+YuwzH+pYXmOAyz2pLs2P5RForQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUtId0FsZlg2K1ZEMGV0ZUcrbm4zbW5sbWhLalUyeFNRNVJ6ekdZN1M0Z3JH?=
 =?utf-8?B?cEJ4aXNTY0pYUjhlN0NjMGh0YzB2S0FtMW5sWXoxZUlZQlc4aXBSWEFEU0hR?=
 =?utf-8?B?MmxKUnF3dnNOT3pMUDNBK0ZhRHNQSC96ZitFcmdORXNNckJEK0x0OTZRMWVv?=
 =?utf-8?B?c1dnK04vczZwYmpJcDA2Vy94NnFucStGbmxHeDRVYzNPZzQ1a0tuYWVMT0Fk?=
 =?utf-8?B?ekpNekdHRUdUc0kvbUc0TW92M0JVR1JlRjRvWnZzSm9zeXZuUlFraWJjblQx?=
 =?utf-8?B?VVVOYS9ma3o5YS93ZzVkWXl0L2xHV24xVTFHZitlemVhdXBqZjFNWlpJUGgy?=
 =?utf-8?B?ZVJXQXl4YXlRUkQwQ29QZkJFa0hnMktKMmFpY0RqOWJRUmdoaTBPT0lPaDhn?=
 =?utf-8?B?QWFEKzBQMFI4L2tDMTFpQmNxbjliMFFJOFE2c29hNzRjOEJnNGZKVXE4YWh6?=
 =?utf-8?B?a2hHdGNYU3FOUnRWeEVMSkQ2K1ZFV0JUWFhWUklFM1hWVE13VVZvQmM5b1hX?=
 =?utf-8?B?ODhDL1FNN0N4dXVYSE9MenQwMENQMExMcVJocVl5OTkzL1FwWXBER0JHZnpY?=
 =?utf-8?B?Uk8rTnRZZlpRU0lHUlBzdG9HMGwrTC9keERHRUg4aW43VE9vYlRDWlpJL0Qx?=
 =?utf-8?B?NzAxN2xZREF2bDFyODA0TjhER3RjVENEcVFjdlkvMG8rc0t3elVQcHZycm5m?=
 =?utf-8?B?YnozQkdkU24zRnVmN2pBQSsrVE5nU25GNVhab0d4bHZaZzVtbjJWOWZ5dndy?=
 =?utf-8?B?d3MwOVRsYm1XaVpHNW9jRXVGbHllTHZoWnVZeFBLcmQ1d1FoUm1nMWRITGp6?=
 =?utf-8?B?cWMyYTd6Q2RqcHZlTGR1TFU4QjhURG5aUWo5eEdnd1BMc2NjaitKb0F4ZTBW?=
 =?utf-8?B?RHVxK29Mc2pvSnFTSGFOZnVEK2xuZkNPVWN0dk9EUDcyZXlSdTBndEpUd01U?=
 =?utf-8?B?RVNnTXJqZWU4WE9pbHBycjBoT3VZUXRKek1EWFpaWEN2R0tZVlJ2N0svYk5F?=
 =?utf-8?B?OVZDYUpYeThuQ2JWYmpFLzcrMUJrSXExVTUwUEdzSzREa05OTzBMdEtScEdW?=
 =?utf-8?B?VWE0elBsa0k4VVRQS2lBTVdLanNzMTlMS0Y0UHNTSmlMRGNRVGh3VDR5V1R0?=
 =?utf-8?B?YzdLTXdneE9KNmwySzdpSU5iand4L3o4TUFoWFJlaHdyWnJzSjcxeDJ5QmVl?=
 =?utf-8?B?WUU3c2kxVURKSG5vV1kwQkdUbkVoRDRXdjU1cUhZcHVEbUJlTkU3Mmp2ZVRH?=
 =?utf-8?B?RkxoQVZOc2R0T3Y1QldKMUhJKzA4QlBmRER3UC9iWUxhRHgzVGgvT1FGaWs4?=
 =?utf-8?B?UDgrdU5UZ3AyN2RXRU1PYmQvWHVBZnNyVTZUSWU4NmNna2dhb2xReWRVUkxH?=
 =?utf-8?B?dGJqdkVQYVpNbURUYjRKVlBnRFd5OXFkZnpEVWl0STRoMUZYR1dhb0tMclhq?=
 =?utf-8?B?MG9Eb0tTWmpwK1hxL1hHUm9IcWpDcXJYZldmVHJLUjBEOFlyemhFWXMyZjMv?=
 =?utf-8?B?OElKM1ZubWxrVFREc0hYZkhjUmhFblJQdnRqMXJvdGZCN1grcXpScG43bXhT?=
 =?utf-8?B?Ry8xaTV5Y1BCR3Y2ZjhCeUpPSExCVWIrQ3FFbnlXMGdBdW1ZV25DRk1yOTFZ?=
 =?utf-8?B?UVFkUitvVkgrZjMyQ0xLVk81YTJTaG4rVUNwdFRsRzhxSlpmeExRd0pKZllk?=
 =?utf-8?B?UXFMRkU4SXlBdHlQekhlUWk4TmFneW83elp4SlJoUkU3NkNUc2N6enhmR1d1?=
 =?utf-8?B?Ny9uZnYrdk5NdUhmRkgxTC9XdjYvUU95UkxXZDJqMXdCNEI0R2xKV1hBM3B1?=
 =?utf-8?B?ZXQ5ODR2VURZSENvU0dJRGl3dTZuUWdkTkpvOVgzaGpPZ1pvYWMrNlIwSjQ4?=
 =?utf-8?B?QzhpYzFUenRjRy8yZHVNQmFGalZDTUhaMTFYQ0M2aDNlenFsN25iLzNpd3Ux?=
 =?utf-8?B?SzVQYnBUdEQrNEVESWI5bS9INHhuc2dMTXNCQ3htQVR2elhZaFBjUFByKzJk?=
 =?utf-8?B?M0ErbU9sd3A4U252UkdSVUllWmkyT0RZTWRDRStWSG9xWHRlTUJDTHlpRTdU?=
 =?utf-8?B?SDk5QzVkcEdpUGVaTWNORE8rYVY5WGpHcG9XOEJMd0dtSk5xTzRRV3RHT21x?=
 =?utf-8?B?eVdJSHhTdWxCc3ZSa0FiSFhOLy80eldVUE1Gb3N4ZmIxdGhuL3lZUCs5QjU3?=
 =?utf-8?B?aWJBN1NmVXhkTUJBWWpMZThFMzNuMHFXTHIwODR0aVJ1QWRIaVpnaUxlR3NW?=
 =?utf-8?B?MDU2OTVWNXpBVlI1aW10b28vUzVyeHNBUFlDYmZ6OW1ka3NCUEdqNmhqK2xV?=
 =?utf-8?Q?CVJmFA8Sm5DlH67YUP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270f231f-ae0a-45d5-a49c-08df36952d3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:50:44.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6yvRondpivi84q3Xn7xsAo3fyNgy5meSfusrGcINuq5WK1cbsoFYHDReAzivLkWn+ovrzhUD1xy7qSOjouq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205


On 30/10/2026 12:53, netdev-bot+sashiko@kernel.org wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The new kernel-doc for `@phc_lock` in struct efx_ptp_data
>   (drivers/net/ethernet/sfc/ptp.c:275-276) says the lock "Serializes PHC…
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>   `_efx_phc_adjtime()` in drivers/net/ethernet/sfc/ptp.c (line 2144)…
> - [Medium] Baseline decision: not a defect of this patch (pre-existing,
>   Medium, in a driver the patch does not touch).
> - [Low] Baseline decision: false positive, fixed later in the series.
>
> --
>
> sfc: ptp: serialize host and MC synchronization transactions
>
> This adds a phc_lock mutex to struct efx_ptp_data. The mutex is held
> across the whole efx_ptp_synchronize() transaction and around the PHC
> adjfine/adjtime/settime operations, so the PPS worker and the hwtstamp
> enable path no longer clobber each other's handshake flag and timesets.
> It also bails out of efx_ptp_synchronize() when efx_mcdi_rpc_start()
> fails.
>

[...]

> [Severity: Medium]
> This is a pre-existing issue, and it is not in a file this patch
> touches. The Siena copy of this function still has the same pattern:
>
> drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_synchronize() {
>     ...
>         WRITE_ONCE(*start, 0);
>         rc = efx_siena_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
>                                       MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
>         EFX_WARN_ON_ONCE_PARANOID(rc);
>     ...
> }
>
> It takes no host lock around the handshake flag. When rpc_start fails
> it still goes on to efx_siena_mcdi_rpc_finish(), and it processes
> results into ptp->timeset[] after the MCDI interface has been released.
> Both racing callers exist there as well: efx_ptp_pps_worker() and
> efx_ptp_change_mode().
>
> The Siena efx_phc_settime() also still does an unserialized gettime
> followed by adjtime. current_adjfreq is written in efx_phc_adjfine() and
> read in efx_phc_adjtime() with no lock.
>
> Would it make sense to send a separate sfc/siena patch with the same
> fix?


As before, I think we should tackle Siena issues in a different patchset.

[...]

> [Severity: High]
> This is a pre-existing issue, but should this be
> ptp_data->ns_to_nic_time() rather than going back through
> efx->ptp_data? The ptp_data argument comes from container_of() on the
> registered phc_clock_info, so it is always valid here.
>
> efx_realloc_channels() clears efx->ptp_data while it tears down the old
> channels, and the PHC stays registered for that whole time:
>
> drivers/net/ethernet/sfc/efx_channels.c:efx_realloc_channels() {
>     ...
> out:
>         efx->ptp_data = NULL;
>         /* Destroy unused channel structures */
>         for (i = 0; i < efx->n_channels; i++) {
>     ...
>         efx->ptp_data = ptp_data;
>     ...
> }
>
> A clock_settime() or clock_adjtime(ADJ_SETOFFSET) on the PHC that runs
> at the same time as ethtool -G could then do:
>
> efx_phc_settime() or efx_phc_adjtime()
>   mutex_lock(&ptp_data->phc_lock)
>   _efx_phc_adjtime()
>     efx->ptp_data->ns_to_nic_time()    <-- efx->ptp_data is NULL
>
> The PHC ioctl path does not take RTNL, and efx_realloc_channels() does
> not take phc_lock, so nothing seems to stop the two from overlapping.
>
> With this patch the oops now happens while phc_lock is held. Would that
> leave the mutex locked for good? Every later efx_ptp_synchronize() call
> would then block, both from the PPS worker and from
> efx_ptp_change_mode(), which runs under RTNL for SIOCSHWTSTAMP.
>
> Since this function is already being reworked here, using the ptp_data
> argument would avoid the NULL dereference.
>

Ed, are you happy if we tackle this in a follow up patch since it is a
pre-existing issue?

> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026123023.3566549-1-alex.austin%40amd.com
