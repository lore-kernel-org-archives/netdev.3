Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72491345EBE;
	Mon, 12 Oct 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816800; cv=fail; b=IUlJsUNpQiAK5hY8sclLmMVgbTLy+QximFT+j3kOMniFqaUp1PnNSg8CIxYu1itNU9AGmizwdsi5rLgcS+aGj+8xYs1HgMzONRPVu58OiHxu1WBaTlpE75MkDt+W0VGhGAE773TRAJWFPf6O7wcW/ccQJJAOn609dTk3qzyLLH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816800; c=relaxed/simple;
	bh=yExRUSpaR1k7VC99UPE7E8dimRjVRw5ByPcxwOZsCkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DAery2H5GQKFODuT9OOgSG49pj0Ysj+2tfcXKi2C0PVm7iuih3d1LNa8YkuTFxiPoISVD8y/gS1MwtXXMEFHVXWeE0CSRd5w7qDpgWTnIuoZVmx/+pL7znOIU2Dme9Wc6KY3aMLhELYtTzBPoI7HCgDQnrL+FZsQeI8ABJzoDME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LAx9l9Sy; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LAx9l9Sy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJaQX5DlC4f7xPMCXT8FKQ52YfuAKt0VXH9t2yllqHJjRCnnA7clIZBjVfjYhnvmeDLNU43gAoqb0//hqKwk/dZnTJvY+SSFgG3yFF5AeYnq3s5GIb5qJG+y8zGteO8J2SksnejmmZ94zO22ZSQvDuCuTsRBLjUBC92u5cSX5HOAyEX9o7AxWCH5rXrZcI78Xx4Uop3rvURM0UOg7ZhA4hGGVeaClg78zglSrJAuQs4DxHdpmNC8uya/wpvvIZcl4ZaPUTa9CpPgFpqc8CKuUTCDF4XVfmSXN2RjD9NgPzkRvCDz7Wwd3K7pn0lnLOJ3HRsAgOGyjJ/WrA4Bs+wAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddQL4JUPdf87edWy29BJaHaqPCm7N3m2igyKBU2k1Pg=;
 b=A+QWjiCASl+PmziqcSfOuxX3ayWlLaWf9YNQwJIwQS1KvpgOtq6/T+GF6n04I9hqUWbi1WFgRjBtgSfmCX/hUhqGGdnlv+ML+vGoYv1fCclgbVJTB5QIXibGU/VyXGBZ+GzJW4ThXgz+yfpm/CRcE8HgXA12G4lUnBz5giIXF8No90hU+E2ZUTdqWsP5vPXmmKJ5lq6h4jFvRZdq/33YjPigXFzOhBSD6/uSLCntBx5Tr36dMFPZ0rUVFBg304BtDQKKotaCkHfqqceHPm91GkIXRqPvN+L6Szt1iKWdzrphzt+Dqxu5serL64vkOdDdNLKy8q5yaUTWdnbYwCrWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddQL4JUPdf87edWy29BJaHaqPCm7N3m2igyKBU2k1Pg=;
 b=LAx9l9SyNHT/dpoztgRuZJBuIii04VZMfIWaPu8rnuMPPYXTK7VCRu0SdJ+sboWbqrvFvsh1Cr+NVS6GE2TKMAY1cRTHrdwG8nVWfVLQL959iPQKB2XBLbmTycwkdrPSxiGYLIQBUsh3S0lL7v7A7e2O92Cb7TGn2K1sL2VbJRS3l2oo3DVZHprULaB1eB1rK9APcojLCF2pPavU/8FNzRntOMlX1+92Zmss2NjwWReWxUvyuUluSb5hI33kAm4goNp3ta0JxeIP1w8BsCwW8zMluA3pv22uQXaLceG8yCYy4g6nH4lCKF15DRlQWNUR+8iZ3JwEgF9/yUTdbrACnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 14:53:14 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 14:53:13 +0000
Date: Mon, 12 Oct 2026 17:53:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] ipv6: serialize address publication with
 device teardown
Message-ID: <20261012145306.GB779501@shredder>
References: <20261009054042.272944-1-4ncienth@gmail.com>
 <20261009054042.272944-2-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009054042.272944-2-4ncienth@gmail.com>
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: f539eea5-be8e-47d9-bdbf-08df28708a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hPaGo+ZTPhJUS5Cndw/AlN1O+tBXmfxf6zSaUcdG37gPTNwUFzvI9fFafgnFVfksKsurMq/Ai34sOtk1ATHxnZ3pQWe7w3EYSKiUZQXjFAtsO1CwwqpmSakRwgiH/o9d00nuvMnSxmzu7VJoK1Zm88ySnCiVmZZ0j1wNT0lYj1aE1ikkQjV9GXqjc82KJZg5U4SMmqPFAOTtexVStPN0WYfhrDM/BbXfxbgtcfvxDkDMGIRpGgUZaxtrThf1iPwHtYjlvEFCM/iwXodWMWd8ZT4i/CRf8hVlGlg0y4Ds8EAnyW/NofO2o3fB20+8ey2rG3ee3eYG2T1Ow68P5i4WXTEuYYG8IEAUV+URrXx6/otF9WNuP5/lR+11J/PRhDG0UWZrSrfpqoxMQiCrVgp3o1zo7hkxcslO7pLnsBgrQ04AwEiLbjkpWzKrGFcIJPfp2L0cCRPdzOvQdOftI5kJRhE/yELogESB9R+/fjS21n/foxUhKUf5ryuK5Cj4EXUT7H6Gk3Wb98Xm08l1/piYRof16zp9vjP8QLYwtEL7hBjn2khnxeKkRdYqKkpKxf8d4LkYcNqMPZ0HMfnxUQOIZZRCNzW6BxsbS1P2UqNK8gMPUio2O91zdJwPMsm0ttbSjqi5ikJU+NJe/grGEeSOFVcH+LEyrTFKrWgBTXTMszI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yBTXHiuQJPowrsJFZFxH4TngrmapcugDeVeqG2svS/Y4a2ikkOKjMslkrAjC?=
 =?us-ascii?Q?LMZx4JngBKR0l5cASJqCYUoiQooAooicRBjd0BysnJCJmr83vbQ27OQ7f4HC?=
 =?us-ascii?Q?DimgcFOap4ofuBKjwyfv3aonJXS/axy7FXWxUebNZEB6Ebqg97dttRa7AjFk?=
 =?us-ascii?Q?i2yaczSsQYAETv39bRIMVEB9OsA8r2IsRKGKBeP2diermlBhgoe+lcT3gK+2?=
 =?us-ascii?Q?9s7Is/IAs1dng4bo/oZKDRlZjPnXvZTG5bPuXfW3k1SGmLgN1Enp6gwlbmeJ?=
 =?us-ascii?Q?qGlFV1Ll1xONs1P/rgqYIO6Sr74vdUFlMtcOKXHCcmPfX/PvBg8Wj0WKQKDR?=
 =?us-ascii?Q?ibYzxUGvrsPNCoZBJ1udfXWkxXZrLVscv3wGyO77678y/VZFG4Agjn+tCYSX?=
 =?us-ascii?Q?ynLrnU2Sm1zPgW4WulVYTDmoov8OWBvsCwMB+jtPc5TdYKJ//i/fjgEVCVGS?=
 =?us-ascii?Q?H9J6Vl2uFjxf3ttQQXdZ8ugyzkTtsGN+vlE2rlcUWn8rTPBJkd49uEshV5jI?=
 =?us-ascii?Q?fvcrGFcfzkOrm3ygVZ25qQRnVvrpsJP31tOSJn1xEZ1u6EFSZekpReIxsLmj?=
 =?us-ascii?Q?BHIlB+6uGx6SYsE3iuUR/Ai/HIjjVy6hjIX/WTaXbnYpeHVsbs7xXmamwMrY?=
 =?us-ascii?Q?6MRrisKLPK1YVu+0thPLUWwaxS4hueJWXsYCr++NX0YPPuMF4eMZm26aPZmO?=
 =?us-ascii?Q?qEOL2mJKseq5QCmdb/vpvE+OollpodyrBuXhIqzXr/qn0xduu0cUZNr2CdIi?=
 =?us-ascii?Q?W9XI1y9cJNNb4Ap4HaBCpds+XWX7dkold/cogRAxO+t9zHjmGuQwKs54Z+sR?=
 =?us-ascii?Q?QuGKM3MOV98/iUAUyPjGU5vACOTV0UVig7JIgCLBE5qC/D4yem7U2JU7BGjd?=
 =?us-ascii?Q?NI+B9ULbCi/sBLRksFk0ox3DusYeOi5p4v3gtvZ/vXtBidUK7pQlNcBqTPSP?=
 =?us-ascii?Q?FTYiXYQWNhCP3mZcPS+ENBgeRROoOvhRSKiutY9zH9+mtx11Nlf/6nXP3rCK?=
 =?us-ascii?Q?j1mny1viLIDnyroPTGGOLtVmTFD0hL2ytUNsAx2lQBCsY7K9h0e8RBl0rND4?=
 =?us-ascii?Q?8Uly50WnNr6ax1b0MucKwpRcFDTA81E3/9T2w99hjCF9Ht3ssq3bjwjug9hu?=
 =?us-ascii?Q?DS0rcyGDBMb9nsPRlp6cmjkOLJTLlVRU5mlvQNKVZzTxKi1KqvEUOSI89Kws?=
 =?us-ascii?Q?3WubasHyJH34AtbiC2wXTCyWI+hWGsZrxqRINGy5GMD8kCdpkRR9GGJL/0Cx?=
 =?us-ascii?Q?6uWMlGebV+Bs3AFfPdpAHKhv6WpKPKgFLrNbmGoXlGHEfcsqsXYHEbn/mFGm?=
 =?us-ascii?Q?+hqk4FiucnhCdzsG4qgj4Kl7CfdRctx6036q9/naJtgLIMtXQW3zCbfDuxlP?=
 =?us-ascii?Q?Rx1hzNS0ecBrYQp8nXHJcxMTCLz1vKPw5ZjXHWNpKGQO6J/lQt2vV7S5+mOh?=
 =?us-ascii?Q?yzNJFYsQu+9EnPYl0SWlbtcYT5yqxXYZL4OXyMnF1bfroUkqNJ37qr+ApW87?=
 =?us-ascii?Q?eEhbtWQ+5Nk0yamlWwj3d7/6fNkUmePm/Uzq2diN9H9xvAg/HxlvCLG4MGZj?=
 =?us-ascii?Q?0JfCzcGppDNFllPFIOspfEgG0NV3Qvp6A/Nu8ryZmwqrZqSbhH31z2kPSwfn?=
 =?us-ascii?Q?CJjzFKV2kaA2Ki2zctgmjqsF01zKDCEbPuqFcje599aCcgP+eJ6oYuhc/WYe?=
 =?us-ascii?Q?5wDS0pEf81RRe7bddfBrWcKoBmB2CWd+7iESR2rHAJTPYm9z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f539eea5-be8e-47d9-bdbf-08df28708a9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:53:13.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+WxDPykrz1A3IbHSw/KhmkifwizuaMpxEjT/PHSMb+YTQU0dAiRi0s+DGKtGwXBC7X4xA4q/PZWLRPX85ambw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80

On Fri, Oct 09, 2026 at 02:40:40PM +0900, Daehyeon Ko wrote:
> ipv6_add_addr() checks idev state before allocating an ifaddr, but
> publishes the object later. addrconf_ifdown() can mark and detach the
> idev between the check and publication.
> 
> This happens when a non-loopback device MTU falls below IPV6_MIN_MTU. A
> forced interleaving published an address on a dead idev, and later device
> deletion waited indefinitely for the leaked references.
> 
> Protect the dead indication with idev->lock and keep that lock across
> both hash and device-list publication. Use READ_ONCE() for the initial
> lockless state checks, then recheck both dead and disable_ipv6 before
> publishing. If teardown wins, reject the unpublished object.
> 
> Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
> Cc: stable@vger.kernel.org
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  net/ipv6/addrconf.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index c90ee6dd7446cd..77b3b1154d591c 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1095,13 +1095,13 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  		return ERR_PTR(-EADDRNOTAVAIL);
>  	}
>  
> -	if (idev->dead) {
> +	if (READ_ONCE(idev->dead)) {
>  		NL_SET_ERR_MSG_MOD(extack, "device is going away");
>  		err = -ENODEV;
>  		goto out;
>  	}
>  
> -	if (idev->cnf.disable_ipv6) {
> +	if (READ_ONCE(idev->cnf.disable_ipv6)) {
>  		NL_SET_ERR_MSG_MOD(extack, "IPv6 is disabled on this device");
>  		err = -EACCES;
>  		goto out;

This hunk is not needed for this fix.

> @@ -1168,14 +1168,20 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  
>  	rcu_read_lock();
>  
> -	err = ipv6_add_addr_hash(idev->dev, ifa);
> +	write_lock_bh(&idev->lock);
> +
> +	if (idev->dead)
> +		err = -ENODEV;
> +	else if (READ_ONCE(idev->cnf.disable_ipv6))
> +		err = -EACCES;

I asked why this check is needed and you didn't respond:

https://lore.kernel.org/netdev/20261007164609.GB1153540@shredder/

And I provided a suggested diff on v1 that doesn't check 'disable_ipv6':

https://lore.kernel.org/all/20261004135117.GA206930@shredder/

If you disagree with the suggestions, then say so instead of posting a
new version that ignores what was suggested.

> +	else
> +		err = ipv6_add_addr_hash(idev->dev, ifa);
>  	if (err < 0) {
> +		write_unlock_bh(&idev->lock);
>  		rcu_read_unlock();
>  		goto out;
>  	}
>  
> -	write_lock_bh(&idev->lock);
> -
>  	/* Add to inet6_dev unicast addr list. */
>  	ipv6_link_dev_addr(idev, ifa);
>  
> @@ -3897,7 +3903,9 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
>  	 *	   Do not dev_put!
>  	 */
>  	if (unregister) {
> +		write_lock_bh(&idev->lock);
>  		WRITE_ONCE(idev->dead, 1);
> +		write_unlock_bh(&idev->lock);
>  
>  		/* protected by rtnl_lock */
>  		RCU_INIT_POINTER(dev->ip6_ptr, NULL);
> -- 
> 2.55.0
> 
