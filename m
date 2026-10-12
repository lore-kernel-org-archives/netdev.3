Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263343D8902;
	Mon, 12 Oct 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816440; cv=fail; b=NYKPIZUhC7O90Fdeq+cL7eHoMhRG/lNwI+7Ufv1ZX3hWAM5HrWN9KlDk5HjdJvr+Vp8lYxHQW/pAlx+JGyvnh8u1gGp+LP0fsY+U5atDyPqgV/HKv4K406KiCFepbbb/qyXcXX60urfLfKVZzxjAPmw6DL8V8/2e5xeSZEXFM5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816440; c=relaxed/simple;
	bh=PCl3DCPthtvy1LXzOviKpRi8Lssfdz/ot7M4gjm48rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LcqirSpBD7A/9p2sxJeURFEe1DxJr8WgNCMVZLNgV75PGwqGujiz+I2rcoa+iB8yFcGQjte7GtNL1hpWMV9dY0crTVPCDZTMhgZ8PillfWqA+cscJi2JHcWUj2QHRAHYJktpp3OcIZHirXmAA/SSFwuL69syBJdvZUE69yucTPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VAZTgEXU; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VAZTgEXU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9ai3jnFsjn0zN+WWY6U34tLllgzNKoB+PUwpnfX6R8pMJ6yzEV3Xz+AKH29qvIQt2dXtHJNm/SrFyIDYwHL8hhBAzMjz4I1UOR4JCYslAmIzmgnz0EcF2geKbXQnZ77MvU6Rbr+wuPjLsyksL9IujdJTd/AsdKzlefNH8wOCq0Vs4aH2u1BykI1Gu//1SvQVi+y2OyYmjQKT1GBz7ivz0xQ6GAaQUtolhXXrmvFS4t1y9WnBxJDJPbH4ubod4e2RR/lm+yUCK7EPTJuwbrTc5QD3pkpKJ7xHny1IwPhe0B6Tglr21Xzs8lMbA1JSk6orCyKaMfy12QGbFkvAs+uvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsyTpkPxFm9oGeFMXoLja8V7uuw3/8ThajxbOtosB/s=;
 b=LmwyR6L0N/Ow5lkf4IhN2lJnDK0xC1tV7elmhXpyovKfqCZa70EO2H9D4lKKIswSCx5rStF1yz/n2kc7kDPxBJSIcuqGQLcPjk2ahHj+Rf8bTNnw6AFHxxgMyNz50xhA3n1dYfD8vrEhKrXkQf0Q9NYklbeXD9n/9Hrhl5UaUQjkwXxuWoZCvWZxrh70sBw39HWNuA3daUqhFdMXWbeCnjMTZiaejaYBTUS+t7zsHeSCjvvTEcn46ezLGCFqIaSUHy4KBZtgnTE5sV4JV9pkQFauEmPfpRE0o+/pMKTwkgLt4Kggn+FJCwgN+4k/jdyrI3yt/f4XHrjDui+gf/SsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsyTpkPxFm9oGeFMXoLja8V7uuw3/8ThajxbOtosB/s=;
 b=VAZTgEXU8Zsvfd8zsfWYkgX/JlmErkq3+e4L7MOX0RInYD/WX3H0zJfIpJa14eyHHASn59TketGv58IQ1uyHTAvLKPmbeUWszQlJEJK/ACaC1iHoiDHcWiW0qUqLc9DxKJJ/JHjzErllZaE1FqphNb2PTaYGxAHA0Nx4VWQgi8o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 12 Oct
 2026 14:46:44 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 14:46:44 +0000
Message-ID: <20f3d530-0e18-4cf6-881c-ec82dcf3ca5e@amd.com>
Date: Mon, 12 Oct 2026 15:46:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] sfc: ptp: serialize host and MC synchronization
 transactions
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, bhutchings@solarflare.com,
 davem@davemloft.net, ecree.xilinx@gmail.com, edumazet@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 pabeni@redhat.com, richardcochran@gmail.com, smhodgson@solarflare.com,
 alucero@amd.com, pieter.jansen-van-vuuren@amd.com, alucerop@amd.com
References: <20261009183240.1898762-2-alex.austin@amd.com>
 <179165944590.434549.13992833657056738261@kernel.org>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <179165944590.434549.13992833657056738261@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0498.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::23) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 84afd32c-76a2-4460-0c73-08df286fa26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|7416014|18002099003|10067099003|11063799006|4143699003|22082099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	nYSp3VzNtlc+QOPdTLoYwTU+KzkHWEuk4a7Gp+crv0408nfHiKFxV5L7G8KUfy7aPXrEwVnU7Oucws7du9f5PpL5CO0tQRgyBqyGASqxg37+ipCuMwH609aS/5430+ukKMxMdx21ZXAK6RQ6gPggiiFKh+KhM3ZWKNLtG8sAOSlGkNchQ0giBJ9kI9iRIfgCgdFQseS8jekG4rHU76sSkgMh5q1wvUhUp/18Ib1sAjd1BB2miSl5JNHzLgf6Ea5zsnDJEPos5NvERYr9oSHDw8uOjgLj8RKC7IhjVG0A/7g5JrcHnVjoz3axNEXi6mwNTUfEtdujs6E0ruTws0GSZqN4413lkSdeyXlNJ4uSFCMQngjudkvOcfUNOCQN7oZ99gpaA3lSDjAD6mFiLfgww6+zDTUA4RscH6xY8YZXR3q6POnp2PcNfqiFwGYkszSttlaL1nCZpoVQGzCucMu1hgyAhwTr/ZiCPBIFrH0zA9xhmc25agobRd0/uQiJjPjAJCoWvKqCDgIboGpo1Fh1H0YK6MUGEQgveBEG27r3f9X2S/PaX6zHenHKRQaBYlGtz/1pILUA8IP84cRqKTuBpwpgySjEsAUz2FU+Np0zGJ8TnyMH+HG8141TiK1QDJATNYA5QnLDjT7yNS/bxOyLiGXx/HWDii3RzNz0gxJaTs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(7416014)(18002099003)(10067099003)(11063799006)(4143699003)(22082099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXpvMmRFWk5qL1k2MjdMbmwwZ0hQSmQrS01ncGx6bHVqeUpIVjlMdkJpUGN3?=
 =?utf-8?B?cmcva2k4bzFENFpJWXoxN0toa3NMZGptRDZFN2Y2TVZpVE5FM1UvS1JHTHFZ?=
 =?utf-8?B?MmwyZHJYTWc3OGJmZFlkTkFuSVV6QjZqTVFqOXQrQkJkbXF1S2FXOWE5Tk12?=
 =?utf-8?B?L1lLeUN1VXordVc2SDZ5emFEeS8vUFRDSVE3WHFINUQ5R1NyeGpxZmw3V29a?=
 =?utf-8?B?dHpBbW1Bc2ZhN0U5ZTkxbi9Qd2xYcnNHMVk0WUVFK2xYc3hvTlFMQTlCeHFO?=
 =?utf-8?B?NEpkT1dnZFk0bFFQZmdQdUcvbXlHZzhqNnovMjgvaU0wY0JyYndVZjlxVkxs?=
 =?utf-8?B?VUxoTy85Y0RheklDQ2RrZi9lWERnOVM0QUt4WmR1RjlUUlcrb2JRY3FVRFFa?=
 =?utf-8?B?ZlZMcitKM1k3QWtqNlNwNDB0YnpsSDBSNnVaNFA4TlJaL1lBVGgwajlYWVdp?=
 =?utf-8?B?UlpWM2pnQTV4TUNmT3ZIV3lnVDB1d3Jqb05iQno4dFc3bTU1YTM1akNaNlpG?=
 =?utf-8?B?bWJTa2Yvdml3cXBSdkw1a1RNNTFBV3RQYVgyTHl5WWlLOXB6Q1k5ekRRZG83?=
 =?utf-8?B?c2ppeTJXV2IyNElZRkt4K2JsaWF5K2RiMm01Y1J0NHBNNk1wS2VlYUZQNkhp?=
 =?utf-8?B?OURDV3pkandrYnd3eUsrU3JjOFpLT1pIeUFGV3o5dFZ2ZDl3R1czS1FKNTlZ?=
 =?utf-8?B?ZnNEcm44NEw3cEN4SVIzMlpLbGs1ZFFDVnJzYi9CVmsrdXpGZjVlUmxKcGtM?=
 =?utf-8?B?K0RNbC8yK1RUWlFFTTBpbmxCOXRLVC93Tk9MUytWZDMwRUk3MXZ0RUxMd0Zh?=
 =?utf-8?B?MU5yNmg3WHVEWXQzaGViWDhmRklQWEwwYVA3cnlyWWhaaEN0Vk1xTjVxbVB0?=
 =?utf-8?B?VTFmeTVYRjRaUDcrcnBNTUpQWDJIZG1TUHNjRTRHMlAybUVKNUhVYXBTN2Jv?=
 =?utf-8?B?QTlPKzdIMXAvSTVrTFhyQnFGTkU3UHE4SXNISG1QWkJ4dUZITDQyazNiNEEx?=
 =?utf-8?B?dFVJdXBEUkMvVFF3QW1FZ0x5L1I4Uml4K3RoSlpMNU8yRTlYVWxZUVZKT3Vo?=
 =?utf-8?B?R1h4ZkNCTlZhN2pkclZHbjNQRWp5V0gySFdia1d0RFNaZkRaU1NGSytPRGJo?=
 =?utf-8?B?QTRhSE1CemUzVXJSVjlDMUt6aE9UdWx0TkYxV3RUanErN1RRMXdTaGNnMVVQ?=
 =?utf-8?B?emxkNm43YUFXeXhDd01pZ2lnVzlON0ZOeXY1NGlkNEhzd2pxbGt2QXcxamZu?=
 =?utf-8?B?YnpNWHN4TGRld1h4TjNDeWt6cXJ6ZzRka050SzJkcWFNQ2ZjNDNQaGdzOWtM?=
 =?utf-8?B?UFZIRzk3UHJJV1J3NWtheVpCOXBVajU0VGR2M1MwZys5LzJQVDA3TVV0aHVm?=
 =?utf-8?B?YXZveUVoN1hNRzN4ZFlURVNXdzk1dW80M2UyTnQ4OENaTUo5c1huQVlQM3VF?=
 =?utf-8?B?YmIvalp3a0k2QWVmaWFNUzNnUi9Nb28xdC9SWUV0elpkZ1VJa3VsaFNSYmcw?=
 =?utf-8?B?c0prZHUxdkhoVUkwc01LZ1VDZkRUZitaZUZuN25LRTFFNXdnQWN3VytPR3Ns?=
 =?utf-8?B?Lzg3MDlrdHJmcmFqcHNKaVFta1Q0M3lzVTA5cEZMeWVHa2svM1V0Vk51ODcz?=
 =?utf-8?B?MnhBaHJYRVZOZ2dQL3IvZnErdUpDa3pVR2N6blN3NEc2UWg5bmRYT3VUeXBu?=
 =?utf-8?B?R05nVkxkSjIzamtNTWM1WTMvOW05OHoyaDV0SG1PRk5vK2ZNcmlkbzlnSjhJ?=
 =?utf-8?B?N0oxcWRuL2dZSUZPUEJoa09idnVGdE1LdjRmUHpDR0tWRVBqWVNTc1o5OXkr?=
 =?utf-8?B?RGtYSURCdmRoaTl4UDY0L25LeU15WVhycElHWVFVV0lzVDJqSkl4NVZ2SUZo?=
 =?utf-8?B?UUY4UWE3RkIvcDBmbk9xVWhJaGxTREZDemtyK3lJcnNreDkzenBUTUJKSEh6?=
 =?utf-8?B?eTJ3a0dackx4cUw4U09wblhyQ0MvdldDUmk4WElhRmFKcC80UXNGMzZjQkRY?=
 =?utf-8?B?cSs0NnRjbVVzaW1Fd1pTSXB2VnlLcjJvR0luYWloRStnVlkzL2Jxajg0TVlU?=
 =?utf-8?B?VDFqWEwxLzVpVnNmNmIzSDNwenV1bFpJVWtBREd6THUyWkhDT1R6dytveGNn?=
 =?utf-8?B?dkM0UTRJRVlVMUZpU2JQb0hYbENIdWRTR0poTERseWVhb2s0dHBld1FXYXRj?=
 =?utf-8?B?clZUMVJJY01ObHBOYTRaU1VtU2R2VUFtblgrdDNoMVZDN1NwdkNjL2FzaGJu?=
 =?utf-8?B?eTY2ZThTTXlscUJvYmJJZ1NIMTBwdHNoVW5RazZMczZLcTdEWjVGSms1bzha?=
 =?utf-8?B?Njg0KzBTUWNBSEl6Lyt6djNGRDk2OHBibStHTDB5cU0rMU5hNlJVQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84afd32c-76a2-4460-0c73-08df286fa26d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:46:44.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMl9OOlCqQNJzFEYXI4KWyDiM/gBmYP4mocycaGyaqutSSO4QA/jC6Ged3ce+IjPBB1LsUANnUtmUhERj84tzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715


On 10/10/2026 20:10, netdev-bot+sashiko@kernel.org wrote:
> [Some people who received this message don't often get email from netdev-bot+sashiko@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 3 (1) · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] At this commit, ptp->host_time_pps is written by
>   efx_ptp_process_times() while phc_lock is held.
> - [Medium] phc_lock is created separately in each PCI function's
>   efx_ptp_data: efx_ptp_probe() calls mutex_init(&ptp->phc_lock) for…
> - [Medium] sfc: data race on current_adjfreq in efx_ptp_start
> - [Low] The patch changes how efx_ptp_synchronize()
>   (drivers/net/ethernet/sfc/ptp.c) handles a failed…
> - [Low] The commit message says clock adjustments are serialized with
>   phc_lock "so they cannot change the PHC during a capture".
>
> Pre-existing issues:
> - [Medium] efx_ptp_start() resets ptp->current_adjfreq = 0 (line 1457)
>   without phc_lock.


More care needs to be taken when efx_ptp_synchronize() is called by secondary function(s) - will respin.

pw-bot: cr

