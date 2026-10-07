Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70533CCFD8;
	Wed,  7 Oct 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391597; cv=fail; b=COaK+fEEbN0YA8+0pFfAIH8ues5DMHOitCfIhQB5uLeIcfcqP4XPE2eHnCPS/taYg8xM0WNyTuTNaZJ7SBdca3MTnQgYEZI+YzE8/l9IuIpPDXHZsfnJgb4915MFp78HKOmH5Jq78o2S7Jf/0/qOHTXW3lkIYHmqnhKLAEWFqxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391597; c=relaxed/simple;
	bh=Qxsc0P3ocyv4f1CUEzJMs50r5G4BNYQ492vleUcr0xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cc4t3JzgG88ic458SZFIg25lji7B356R6Kbb5tynqOupk0Es/QlfOczy7+2VO+uroMiWlp40j4xvpvd5HEpyb0CxFoIplsO+Tpm5RCeLooohQHZS7iyzwfW2xsnJTmpaVcAVDwF0S5fYLM/eGoWNNNcZSrQlGGqj9DKouo37cpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HB7YMAfN; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HB7YMAfN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mssduzawMgifo+qA1hIioJ3rlwQtYYHrAIBcOwVDjlQQsnigOZaIDVCuL3i9K7bW8NpKK5BgXsK/dxrgTKaAArZiH2neusHghL3EgbgOvh1LjPzqgyL1quG0HzboL+H0d3OlTmjuUr/SZVU90Nj8605pTO0h3L4vGsj6QkG0sYbePPKAfE7m755CyVF/mUp51nMWeaSJ6wZllxM3SD9kHdG4qp3YIblaMuF3qIRd70QhohLbyuJ/UFotoNTA34FBf5uPNVeSwKxaQXnwVRBAYnNZPauWQANmpJ4A3xzKcqndPE9PFJUo1CQtJnf3WE8zF3eYA9GjdRF7GBtZxhRGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5m80JDb9DbLC0uEibnlJ6FUniAVmX0rVWyGqi3HvgA=;
 b=r4L7bMf7hubedGjQiWfwXW/FRR6rZlT24MbR18Wbn2ptL9zOlbQEmsTa4jpB4u+IjLycXbQ460W1rK8G7VqANDv5qmV4u1cIxhcLfI34SXYFaijA1oOCNxBQq4qu252KwXv1xn9Zme1ULh98Jco7DEBwJQRgPMeq0VVplzE+bxzuDcvCWRqDVznr9COLiF4nB9nSpGz78yi2Oku3WsuLgruzscs0Qq1bjtsaydTk20XinYhN78M+ptDjzJL+p1tEFLbsqM9a5E0OJU6bvDikE+z5Q1yNYh2Fq86nhSMpW6BecI7Gcg0yGEy3AhHfoTRhXMAif+cbifpx5E1K9u71WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5m80JDb9DbLC0uEibnlJ6FUniAVmX0rVWyGqi3HvgA=;
 b=HB7YMAfNYGX5DUUMt8lKWCNFd8FI8ru+5AeUoAGI+Ng7h+XICV1zhiqtKmkecPGeIcj/SNRVmo16LzWwIVI7d4/sVIQDJb+bnr3H+iARWgr8iI3hpxgz/sdZv+2HL5ZSL1U0YkJmNsYROxyFZwYdn7mXKUGE5o7qkOd3mKAxdXPtIPgZGEVrWMGjmSaz2mNCTpQX/4rtQ8FHXlSb0ZU3KV3uGcUUqQxID/Xpsq7OM/ylFdb+CpVUdlF3Q4fcINowZdPxvlW+Adn5rOAyq3b15jetiX1u7sOvd8L6CukaitSnQkbsFk/Shw4BSni+JG1135D1y2PHvhHvQ2NRVGRu4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 16:46:24 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 16:46:24 +0000
Date: Wed, 7 Oct 2026 19:46:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] ipv6: serialize address publication with
 device teardown
Message-ID: <20261007164609.GB1153540@shredder>
References: <20261004183639.3773498-1-4ncienth@gmail.com>
 <20261004183639.3773498-2-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004183639.3773498-2-4ncienth@gmail.com>
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: c926a43f-3975-480e-9d5b-08df249285bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p0E61AyKCbZgkT9di/LfYeU9WY0N4dSTXZN83QgGmXW91eLAyaitcrdSs5/ENV2sy9wyZzcJHXz69JkzdH/wGhBURIlHU9Yi40MEfiC0Qy7sNjvRbqC4mHvgSRmK0TfB0IkmfrynuN4NWcgLPWDCAKGXpQiFrj662kfKB8F5UMdn9s8L8uBSZz3CkQOK8o0WxwPF4vtciQmPPSLwtkai1GSzn22uwo/wdXf3rdbtGPtcVahJBAxATB8YJ3Dg1/cJ9rOcREHa9lBCpUSrguwgfRh9Yoj4IwdHYNu3665p+M4d3+u6d8cj6SLFsAVuomVwq2A42o/JKEc11UpLAjJkru5kj13L3zKl5+beQaE+CBsAW9rWwuwsSI/KKRo0aoWRa7eTaGdRezbkWfh0rTDNKZZeSV5FxspQ+y2dpFeFfmrNn1d6rJzmJh6DCCDYOI0ZKLeh/VVuRYhlYrdkhGbJ2K6FSwrGetardYq2ud7sTbFxI2Z1VkaMVcWpuz0AxK+4jgXM03AUQPcEA2mpuUnavOQB3ghKNRchd1YRf5jH0njcj+40pNrsZd0hruWPPEC711Eqt+txr8xDgOWg/VxUl0iUvicigX6u4dM9DfTWX9v8kwkdpUUEPNkeMuTk5i4VaB3xKvCOduKHA+zE1df9u4jbzFxYBQeHgAJ6TXlA5us=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJbd1L/qWAOzb7+hvCqCuHxiSNeoRr86j/+PJa1ftrWVD1JiLt5moUuxZb4Q?=
 =?us-ascii?Q?ki4DL6c+hKpZben3rzk3l3ruLaV+rZ1Imt4ltY6GO/ADV7uyvFf3OFTKewCW?=
 =?us-ascii?Q?fJ2iCzSASx3JY9VoQQybav7SOF3ImzDS395WHCtjrek9PKMyTm8oDWLJwTe5?=
 =?us-ascii?Q?hT8+wrSiU+MWo1KVtBlIL7BxaBQO/DjCYv5tvG8HtSX4JuGRAAIU5nFMHGhm?=
 =?us-ascii?Q?4GQuwtul5LU3XiY4fxMklS+FSDOk8GnJYkME1zSWZ/8tdzpVHesEYqC6yOc1?=
 =?us-ascii?Q?MKIT8ZBHKtua86fn24HI+nSUf1guACy5X2naVsonktJoc7SvLAG1Dfcb2aAL?=
 =?us-ascii?Q?5DoC9oe4cXoRX0riMqrp1+L0diDOecOEsv32NJWvw34opu3+aoud1K1AqCup?=
 =?us-ascii?Q?xSDpEUk1z3X0FLIxJigHYHIo1lidsPxlgeHHCk0hzNuOx0f4K9vXr54MGOiB?=
 =?us-ascii?Q?H81c4yTezhCmekHYelwmTXqlxK/yWvr9NKb/PQoqUN3vfGliJrzaA+QO+Kg+?=
 =?us-ascii?Q?YVjBuURZfZMr2bGqTTiAUI0bXEN/WV/i5H48pA/3zhIEfN5u4HucLuS/oB1M?=
 =?us-ascii?Q?PJuGLfqewiDmBRUN9tFyO8yeGSpwf0dp1OGG5ed0MO8eGQk4c/VDbLWq9p1c?=
 =?us-ascii?Q?V93Dn+iUbB/bleYVe6RKSsnltst626JuVMU19q6mzWK59wmmBS/E+V1Z2C4t?=
 =?us-ascii?Q?/Y/yvkzzgu69tbQizru4LiWhTPD2Nagg+SMnhczfiIftah2j+NSGCzEYvx+1?=
 =?us-ascii?Q?hJdM7Rw+rzkqfaAc22pcsjrjwLcdqxcDQA1IDu3OxOxPKKblB+Aib1SOVlOB?=
 =?us-ascii?Q?M9L+8khHuZywrnMqM5pa4FTXJA2bb3PQA8i8j9+B8GCIMmS7wlQZvqWHJv3l?=
 =?us-ascii?Q?G+6ww9GIY2n6Hueeh1+Z0U3PSHxBJM1ooNXnRYi2cFkZcaRaYrNt/180JOyM?=
 =?us-ascii?Q?ScSh8mXwzzDviVw1MU+itCFXS4W4hzrXG+Vn42kQYBYQezEzuNEssGK2enbM?=
 =?us-ascii?Q?mRxV95FgccdL62VJuVGrgmMQuluej5CGh9n1yLhmwZwhJPRy/+Fekw9n7yAR?=
 =?us-ascii?Q?voOt2kv0CbH0/zLoY4ORDokNUhX9n77tEEnHSjOHoEOvvEcAJU1nk+GzUaOr?=
 =?us-ascii?Q?L/BxA+fkeMwLcHbwWxHkrW4PAkFaqmDtfG0e1UW1ELjTeXaDikkustDQMdv6?=
 =?us-ascii?Q?w4l/r8++hnOyaakWeDI9beNNtRT1brX4x9xjMVpiUeD3kLRCcVdiP94/UjUS?=
 =?us-ascii?Q?MBDrS6lLTeIaugaCrYxIDOZXl0bkWBlzMsYCgoZLNut6P/MIa7Gi2DbWrXD7?=
 =?us-ascii?Q?AuS2mugfpwfcaOqQPUxdXX29mBE6VM0IQmlPGGBQv4edPiImJvRzq+/9U6UF?=
 =?us-ascii?Q?ddSw5AcYUCLT+DfJp4dPoNxlo2WifVGY1qGvLWnfx2FF4doNcdul/2esZ6GC?=
 =?us-ascii?Q?dIIbgwceeuvkm08soXD5u9ErUo7Ag3Qb38Js0/YPVOeTt2Lsr5KDDMRjITgL?=
 =?us-ascii?Q?AE1v9D8wjJpNAOI0lIa4KUiuvZEyQs9XS2yRREAdxEOHcOYfNnvipmdQT1Is?=
 =?us-ascii?Q?XUNBAkTNCi/89eS9FmV49bxqz4IVP04M+yHTmqnTnDfcUsN//QZpCh5eOOoy?=
 =?us-ascii?Q?GGUmxm2yStVwiWcAbHDLxVYSftOhiRGWhjFyyaz2Jp9yCzFDjrE089pLCkyA?=
 =?us-ascii?Q?k+BA6xa9DIpdO9OOV91ZBhccB/Nphu/F1Cd5DeRj0Vv8Q1ON?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c926a43f-3975-480e-9d5b-08df249285bc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:46:23.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWGvi4rshLWGGa+4VUN9a81pFd7C7asGk4AcdyA/jtP4YdG/ol6EIcOqDqqPogpQi7K77bx23KH4NG0D+Sr/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

On Mon, Oct 05, 2026 at 03:36:38AM +0900, Daehyeon Ko wrote:
> ipv6_add_addr() checks idev state before allocating an ifaddr, but
> publishes the object later. addrconf_ifdown() can mark and detach the
> idev between the check and publication.
> 
> This happens when a non-loopback device MTU falls below IPV6_MIN_MTU. A
> forced interleaving published an address on a dead idev, and later device
> deletion waited indefinitely for the leaked references.
> 
> Protect the dead indication with idev->lock and keep that lock across
> both hash and device-list publication. Recheck both dead and
> disable_ipv6 before publishing. If teardown wins, reject the unpublished
> object.
> 
> Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
> Cc: stable@vger.kernel.org
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  net/ipv6/addrconf.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index c90ee6dd7446cd..426739abb07440 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
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

Why do you need this check? 'disable_ipv6' is not set under the idev
lock and it's checked earlier in the function. The fix here is strictly
about adding an address on a dead idev, as such an address will not be
cleaned up and keep holding a reference on the idev which in turn holds
a reference on the net device.

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
