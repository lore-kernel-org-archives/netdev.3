Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DA3A05E5;
	Mon, 20 Jul 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534047; cv=fail; b=CbMV841lJBlOlwUJ37XdeSmWCLFc1G1e4UaMWs49vLzf8yf2/VSCrzHUWte9I9GKKNc0Ur1QBsZJJaIHzaVLZ0LlBo3wBv5Q2iEzoXGY5zFfvX+/jIbguJLsNf5CYCuC41bHqpgr2Na5JCnCqiTiBD39goN1qnhFBLKN2Fpzzvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534047; c=relaxed/simple;
	bh=9t3ROzLRrNypncSGOoxfy1ON0lmOpzjH+LRc82bCtBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fysjqxHbpV7kRun1HNIGSCLzoKs1T6ENlRzrPSORC5VwuCiJtLtXlcJP4SpU1PiW9BM1rKx6uY4lcpWYGMqI8tchYMrEyofA2I/LmX8Oq5UVr0mZmS0cJt3D5Oak+OVAVTkiZD98qFhWs/UTd6pLxWcM2hdzjtL4J24s0Flnvxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FEG7vQT+; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FEG7vQT+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewjwBSEiQkjE7aNyrEt09Rt7iNo0S9xRRqLTKyg6eUuQmgKvPFTFJYiLLsrvZuNtjrPB8kovRliIghiTsoGB+on56HLvKlFR3ojOGyy0NkfhKVUFEsrsxwdsovyw1wcD/tlgLCBrSo5tTzK7/8uBiylqORF4IVA0EaL67M+XEKuEdgi6WVpADZhkpcZNqaWm3OCfeuRlJYEBjj8C2m5+emQ5L19C3M2oUmgkP9YvOo+Q6GwW8ROhy5DvNaYWOOjwbHuspsr1LAc4sg43QsLeMBeYdjNCF7WMVUuzIQgwBrgqI62bVSVVnaWBVG25WDBOoQSo8uHqIwGbBDKJMAq80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WmV9X5EV3Rm58+HoyXXzS6AZ+uIrwfg6mC1GiWg6r0=;
 b=sANo29qT2ZlMxO16HjgR6XBs6vPIlBiZTuRvtsDS+LCKCrEEHU26qNfjo7Q/8CB8gD2Bt9kSotu5Xw4KEfoE+igrri1cJ4stUmoazOJyutk2rt3Sy66kw7GNAHIvuxJyJplvQPsPGH6K4iK2fy/1NO4QKtrX8VrBwYORFy/M2lF1R/YRHZuuwzgTohCxk8PJYB2aXtXCHUUWtjcPltjgx+LhLwP6yoR7nDk33H5/EmiJY+dw2EW8RXV8koz1ISZyOkY1k5bEF/hQUHAf1FAaEaM6hmnGTarRx77c0bh9msFZbW/BXUbkYOk42yBzG3hi/i8w6grx04/JHMIg7A37Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WmV9X5EV3Rm58+HoyXXzS6AZ+uIrwfg6mC1GiWg6r0=;
 b=FEG7vQT+9n/K9lwtZq0ai1+Cv1YgL+ftrEIKrcfIKg097bxQgdU88QKgBfc9HCVicedZwlkR75TqZXy/u2avg/T7BIIFJaDSB4AgIxWonOoU0tR2H2WbV+aZkFnCG/4BwK4QDrir6nIEvV4SJrXdM2rfCepcxq1jz3/aJ9pCZtweygWfgDdQhvNRBTxlIAepDQd8EaR/1nLjaD6fg+Uiu7cC4HwfzgmWcXwr/FD0QaH5i67kU2ixn0P6Zyg+pcYFOCFyjnEbgk6gqUW2J5kM0n2uvNLutv0em42vJw/vsFz6lJ1aHSiuUtVzEvD/YHds0wHBlKbgxkSWSxos5JPC+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:54:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 07:54:01 +0000
Date: Mon, 20 Jul 2026 10:53:52 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yun Zhou <yun.zhou@windriver.com>, edumazet@google.com
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
Message-ID: <20260720075352.GA2233846@shredder>
References: <20260713151435.1815104-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713151435.1815104-1-yun.zhou@windriver.com>
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b45dea-2c6d-4936-7ac6-08dee634100d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	qVeKTiB7fr7unq8F30NLbhkDEBSMA6dem4KosC05q/X1gHiK8l7tksYmXYPtaFmChZsVhiIkKB9L1Pc5g11xmGtwMjiF8JjEiWFiA0Rb0Bh+290vqLHl2FX79UBDg89+OML1btWfxgBheHSqjGEuRoR3182KI4s+UyrcNC/EluZMCWsrQkfMf3saKmwrtzcgnkkZg/xubp85Vej+FaJNWHAnY/6pVi6rwuiE1kDyjm9PLVj0tOhL9F9n9Je+dlED65cyZXk3/FP7OefClNNhZyzLGf5xJuE0x9uGiE8TgOjUH9/SKbnbDSSEz3Xy0GSvmaiFB+To9kLpFint2xsVsCEJ4wjlnx/TKKW8tcxRk3xfDdB6Nxed8H+TDRmhGhkSrnmLGJgr76jvH9riP5H6wrbm7SEFMhg0iKrEPoQmvMFoJcHALByCBsU+ukuJJ6YICY8fyU+aRHD4wwxaa8zwVzcAOkEOhEnhPCPnDNGxGgW9QloZq0lPUEn+Wrg4r2vUi1viavrF38HbZjhqfsCcWIZHUPA7fqc5l1py8pm1vX1UCcr1XA5cglT9xV/aBZYx9PvQkb3R20joNYF6Gc73u0S9RRpRZXrGSpn0ZugaV6vp56PF1kvj9OJmsgWzhuYsdPj8E2zbm/bJ1k+JvUCA8Jhnp3Upvs2BPjVNCEe+1VA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/10pG/JXfetTg5wyds3fQ7XDLzoc6iipyL4fHsGo0pkumPUq5FRTwp7K1qz?=
 =?us-ascii?Q?MzQKhij24SdZZvthECFY0op0HFKo0/aMNUpf09j8gSIMbvZQ/kAmBQjYZSdG?=
 =?us-ascii?Q?Hj2TgMpjN5/UYoXTcaGmbaSWVzTZ3BFkuQhIt9Yfe5czlyIB2UZ800PZrjCx?=
 =?us-ascii?Q?XOiRcsVVkVQaN+gJaCSdefdVP4ls2mfI0c8L5Lk9z9itQAucP/tZDOzoluff?=
 =?us-ascii?Q?+UwD5kvye9PgEKY8Tjx6w4OZvThX7HosugkjiSh7VR3FD6QFjnZDGtMueT/e?=
 =?us-ascii?Q?r4dgMb7Ye05M1RpNrO+QUCiLL/a3usRYS7gDrxPm0A1vYKuXHEPGsamfC0MC?=
 =?us-ascii?Q?foTD5k/tUiyREWhDGvRsMF0jre+1dUZ1JFATs8sg3hiwgZQyKMjTRzyThMQn?=
 =?us-ascii?Q?4EEBywVoq5rYMmllyWwucrq7Z3hE6bMIawO0HEkRyXhVFm/+S+THOchvorJ+?=
 =?us-ascii?Q?xpKT6npRAjEtXHK/TNP5Gbpy8IHVVQNyEzYCRCTd2flW5ixqS0FtG28xLqPR?=
 =?us-ascii?Q?m6Ahwo1y/u+pH0ujH1+HuMouGEx3lWN6RBabhrD/mxiuk5gOo553/y9kTKrr?=
 =?us-ascii?Q?z63Uo7dKtCoWmvA35vGs3gjcd0zwdQ71aO6KesjN/UAFXn9Sr8VmXnYUuBu1?=
 =?us-ascii?Q?60/QOyG7yX7r+z4jKCCgDpOGYxIIlrT2M7dY6EbRo/XmGhDwW3fZuklkRX/D?=
 =?us-ascii?Q?qU1eWjWwTInccKhKwYfsbcSaO40TC/gyps86+ZBZSIE+GRygoeMnfO2u9fI8?=
 =?us-ascii?Q?sj12Oq/8QqckC4U8AnGXRqir9P2gD2FZAeWem3wr6LqWbO19xiK17jZsh6qM?=
 =?us-ascii?Q?L6B0MhswhpjTRSIeb2sxMGq4a9yesF3ZYfDtFGMPKu6iEyicAlCei1UUoTMU?=
 =?us-ascii?Q?Z1N9j0MHZVDoH8iMFUJDhLdUJUf32ndt0DvcUq7fcNUM/JRFrpkwK8rE86Hd?=
 =?us-ascii?Q?C3dLAyqyVF5P4K25Fv24QyAVI6XRURI1o/VvLYdh0f1AC3nvEE42vAohqsVo?=
 =?us-ascii?Q?b1OZ81TV6umnVKN/2gct6DI487ceHagGTXFtu73w5cWLv2npf5efBaQ90u7x?=
 =?us-ascii?Q?GSBJVS4I8O1OLsHXaEriPBAuoPPiFEd4snnLj/sMpmj4k6teu7dBpwyhXDJM?=
 =?us-ascii?Q?RsIwahhahEMNYrl0sNVUxqZCzr618bARNmHxHSL3KiET+d9i3qb2QYUCPt5o?=
 =?us-ascii?Q?l0usFl4t0unAkkgXxY57Gbf9ws6VKuXNin6+ZNe5gY40R0W5wo+2VSIZ3XKs?=
 =?us-ascii?Q?p/fnmVU18gmhEUe2nlVjCXFmYbordlsJWyiSV4OKJf03RU9kKTrTF0ENNW+3?=
 =?us-ascii?Q?bpFN8JFjViOhmoH86t0Tv85nH34a0+hkz7yGtBlivqJuwzDkdV5mW1LOXz+t?=
 =?us-ascii?Q?v0DEODXW6g3aRfUJOCbR6R5EpHeAbrbSsm0w+ewPEW4yH8vSS3XW8XkIAiw7?=
 =?us-ascii?Q?F3HoP0pDBvCrVJVDHh4rgH2BpZSgZWpPQDgSOexh8lrSdNrIPU3gALoEoeUu?=
 =?us-ascii?Q?8ZWFK12L7Vo+sw+9NnmZ0STqlHXzbg//KsMC0UDBnRWt4fO8FPypHUjOIZy7?=
 =?us-ascii?Q?AgkZOuqoANOzWOD5yBpMtzFClz8h++7QBeEth+lzJ235uuH3DL5ARnXYmRrK?=
 =?us-ascii?Q?FNEgwJIhTl4K5c2pFtwGqRCX9auzS1SlNjrFJkC3S22C6YK/609AtYRit64S?=
 =?us-ascii?Q?q9V2LiianbdvDVyCzM+JAwH/fYgoOymRhc8c8z0wVI6hbTWx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b45dea-2c6d-4936-7ac6-08dee634100d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:54:01.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZY8rqO4pj9wXwTKO1KxOkfrmw8PtnPDdUy+A66n9rG2wzBbKRdOjCB+RChHiW0oXIIo7IzVEs/Rnq5BFAxg/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

On Mon, Jul 13, 2026 at 11:14:35PM +0800, Yun Zhou wrote:
> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
> nested acquisition of _xmit_lock on the underlay device while already
> holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
> the same lockdep class, creating an ABBA deadlock:
> 
>   sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>   ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> 
> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
> atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
> the sibling device with identical xmit structure, already sets lltx.

erspan_xmit() (unlike gre_tap_xmit()) is performing non-atomic
__clear_bit() on shared tunnel flags and KCSAN will probably flag it.

Eric had a patch [1] that changes erspan_xmit() to use a private copy of
these flags. I think it's better to wait for Eric's patch to be merged
before setting lltx.

Eric, can you please submit v2 of your patch to net?

Also, doesn't ip6erspan suffer from the same problem? Please try to
reproduce and fix.

[1] https://lore.kernel.org/netdev/20260615140333.3161072-1-edumazet@google.com/

> 
> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
> Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
> v2:
>   - change subject prefix to [PATCH net]
> 
>  net/ipv4/ip_gre.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 3efdfb4ffa21..9fbff16cda1d 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1363,6 +1363,8 @@ static int erspan_tunnel_init(struct net_device *dev)
>  	dev->features		|= GRE_FEATURES;
>  	dev->hw_features	|= GRE_FEATURES;
>  	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
> +	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
> +	dev->lltx = true;
>  	netif_keep_dst(dev);
>  
>  	return ip_tunnel_init(dev);
> -- 
> 2.43.0
> 
