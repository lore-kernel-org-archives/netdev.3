Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89645492E4B;
	Wed,  7 Oct 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391616; cv=fail; b=p04VxwYpR8CGxsRZMOzj2vIXrJ0fie2usc3aH7rnOUnX9eBms9B+3TeYNcBLx2nO+P+CYG/cZW5xQqe9FYA42nwXBldzBRg9Awugu231fXxGOXJEHbpwImdLf8JuOcXgNB2bo//oRWmh/l8HyOkgyWjd2512gaKw77A2yvZ0FdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391616; c=relaxed/simple;
	bh=HwS/1n0oD+yNeIBFK/vlUd9HYkdAOuDfwHK1VezpUEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hnwT9eKEWafz1VTUpoa+BobGW2alrBHNEsstXWzlHZaUdMSGwQvFocB7rEOnF/MHpMDPjrx/iRRoVnpu3TT6kKBHYpCN8HeeF7J/i6CtH7kdfJ9k621f1+smY8kyr0DmykpBvP0jykY6HXvxd1XbbV8viLHzntav8/AZ6tRbU7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gR5bmqjK; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gR5bmqjK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/ppJahpmM8AwCmhcjWzAeNFaUn9DejXak6L/imJnJBnWnnrWtyXNPp7+tWV9h+a+MYywspHIus9VYUOhHAuecb9ESGCfBp1VdaBP+TxgoV/9EUcKl3L/B9urDTBdZxAwfAMSOj0eQyTirgOafjhNbT0Q8OM7axpiUHyXJBQdKXlc3AxV6KYmjPV7zHOQHwq4gToqlxVjFdg/RjWVnufGBmKRcqbcuYe/KfVmEIp0pGqIh+3M+cR/C7lNliDD9354ZNwsBQBc61xan8V2TEU388rifN89Qbe0S/KonJD0KyypbMN+kbALNDmC3paYM4wQI45Z4mBXFrCXi0hsUegZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBkdBrhaQgYFZxB/orGGO7WPETW1GtYZoshUXEIF/OQ=;
 b=O7MK2+y0gHXVD8rlcEKiwLMgos1ouI+Sefs7yWbr0pt6Jx9s/jnOQrZTnhtufWNR3EwrZXyUsbHlCvxcJ/G9YoGXWHOZQTezEwYWaHEUO84eZgzJE4Y5cYhdPA92x9bJGdi2n5dBfTp8n/QTOOqfCqGcaDB2hOVu77va904lL9J1KS4beiAxtHFXHZrRlKZnJEkIjxtuAvdT+7iX8ssI5JGiwgQw9O2elr1l+1zvU9/DvvZCuNUVoQ1AUKo7UGktRN0se2/5qjyhcGo+a23B1RRaBHfyV9Da7ktXwMhcj5wNjFWJ/41IA1vC/q6vrZ0L80PDOGcSMafJL1tVdQ49DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBkdBrhaQgYFZxB/orGGO7WPETW1GtYZoshUXEIF/OQ=;
 b=gR5bmqjKsfqTxuODPyV2aibgW45J68e9jxT7poiChGppEyqiaAt5Nv7bMQHnHNayDQSkej4+SqUm33/4Qy7iWKWSbBU6HD4rdcNPS93HbR7LGPKoDf6MdABFBmtiCPlQT2wv37j3Oa7hlUy4hm+B83wUrc+TZL3CUR/xV/C2xoewgb6sggwHP7SjaFi9vCM9CRuXQlm+F5Sj6FJRH77li+LXeuqRVJPVPpelLf2z2jwQGX/D2Oc81Lh2vUysHcBQll8mJRJh8rlgQYuhVDMtCF63vrBPUCOXT1PqBhKCj+3ijKuGLSMEY8im8B8iY5Nkv7j/BAPzNM6vBX7HA+sVhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 16:46:46 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 16:46:44 +0000
Date: Wed, 7 Oct 2026 19:46:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] ipv6: remove ifaddr from hash during ifdown
 list cleanup
Message-ID: <20261007164635.GC1153540@shredder>
References: <20261004183639.3773498-1-4ncienth@gmail.com>
 <20261004183639.3773498-3-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004183639.3773498-3-4ncienth@gmail.com>
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: e9995927-9727-46e9-146e-08df249291a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|10067099003|11063799006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p5wCrVw0TxBV9R/7c9PU/5mFxTlceBfhehHfUDleCgDy3wWnNBFjDwOyHLWBGcl4s9evTbqAeG6PJAJByOkCw6A1JnPHda1S7BSLnC61iNeH5dDJ9YK2AY+I7ywtplLX097f2o02LMpIzOB3g1WuXeKeA3on1lIIP27kqwa7lwpYHH5ryOjL1a3Rb3BOk8jKKhKvEWYa5lNyiID/pvUhSUk42NneklyoVx30GJDn2Ym7fIYzMnfGOEhHoKAZ+ulPVt8mmO5mfBQ0j/lwWvQrqOAWEC7ABauG5rg+s5RLrYbZlULXB9wWQObEw+p2Jsr9Hqb9YxPHkY2gFhFAqT9UDdyKwHM17JxN+n1P10wZx9JLm3g7lj8wZiNG91MENu6g37p/OSmSYHrf04641hJFb4UzBptR3CmMGa+hVuAlw6Sul8OQNXEwUilkisGTjnDMkrDBJ0rtXYXeaHhmOyRUK78sjKheQEk4v4UWFITsM2Qp46RXXJx8v9eH2C+AjHOvIroRtpnkyMwr0JvfnXDsdFi3WNNSVb2BVZude/SKGf1vrmp/glxn7wDHtzJkPSxpdBnlwFkSV7Lxemkz28Sx7yu4ysT59jsFGfT8aNgyLKU7bAWlfKB9ZwIWSdT5FxdHXoX5zc2zKVzILeTpfnNfXdP0eCRK9rAK4o1euhhy87U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKyU0QMc/NSJ2cOWZmlMxYYYC0lOM0hmpofhwZSndwElyC+V3n/N0KIDAyPk?=
 =?us-ascii?Q?ULAA/aEf4jYzkNhJZetDnuI+fz0F4rbsyI3TjXLIjE3rhe9xpvf+puhsmsNY?=
 =?us-ascii?Q?MK1GfGrBGijZE5BlnEjovpxa8q2g40mko0+IeFzUNfGu/eZRZjOIa37PXCrR?=
 =?us-ascii?Q?cHq8glG7JNUE1lTe54nPUR74+5IsGoF4xdSLU/gCoU0hMhW66rljIAcgsX7p?=
 =?us-ascii?Q?eNdO1m9aLElhG7x9yrQrauIUapdlCCHHYQ5TH79lDkye0JOzctitmkfwCUp6?=
 =?us-ascii?Q?yjMngWd3Ih3gZond1FYM8f3eRsB1LhPSCyRWyRY7AWpRKhbPcFra9WgeSVAJ?=
 =?us-ascii?Q?oWQdXAiAkVOKUXsjRWxEVqMbJazLdMAu8V7kPJuRnjoDxxJ21HFQfbkFEVrm?=
 =?us-ascii?Q?LeYvbviLH2d1IXAxsc4QD/YvYUb9IUg26TgPoOMxspWMug+A+5v7vOJyfccC?=
 =?us-ascii?Q?0HybtrnATLNJwQ1eEmsARW4AQNU4fWq6xO26FjJidg6+oMY2JZVz2DUoaF3V?=
 =?us-ascii?Q?Omo3o+ZjZchKq+DTt9Ur9D6MSMAWAnLFZFRbe7m0nDN2ZGYVQYDdS/U6HXZm?=
 =?us-ascii?Q?3prZ3Wm5bV81vB/AyQ4jOScn97M3J6Q/xR29aSp7ABka+xv9proislev7o7R?=
 =?us-ascii?Q?/OZDhlKHrghJDJV119UAXR5hOI8pMGWaCXrOQ1frRiqsHa0ipm1/pr8AFx5c?=
 =?us-ascii?Q?hFfw9fZwA18lN1ULOkHKJwGebUkW4rT1co1qKDgXx2ozYzt7IpnYVg/8PiMi?=
 =?us-ascii?Q?960W7GaqecGQCdG1gEaXCQrT4NCqG2bjcKKUqS3Fcrhwb8vIJF9cdmSe5Ih5?=
 =?us-ascii?Q?l2uo9xRShN7wCMhQw9bPX7Lttvb4xNdgULZ3PoQJS1GUp7gDxO9wmiVt5tP5?=
 =?us-ascii?Q?LfUEwsCFgShwphA+rv382LDomf3IIll7Htmdmu7Q3tqniiDVw6C1W8zF0+B9?=
 =?us-ascii?Q?+AvapcbpFNNWZi8b8uMpKt/VrDN8TGkPx1v2aVBk3pvcLxueR08f2l8yHmEf?=
 =?us-ascii?Q?BGB30+AW3VTCPI8ekysM6YYpDHRZZiRCp+qWRvfp3/X3mELB15F4yrOsbb+b?=
 =?us-ascii?Q?m+RWkMGguYN+jQy810PFV0MyqlQpt52moG1QA5Ci09dIiVnDdYcyqs46kpvF?=
 =?us-ascii?Q?fG499WcHSb8KXYPd7ye9XgThNuzxAdr/hC7OyeZxgI0AF8LdLhg0c1KY4JLh?=
 =?us-ascii?Q?y9UonvQiqw7aAfuotVTkArWUy14Zflh6UXEdkP2BLkw8ylpIgqug4tI2dGcu?=
 =?us-ascii?Q?sfsYwAD+fCAWE6yKhO89+zp32j1kcs41xZJYBByL3fxTtpR3DpshlRgeIvpb?=
 =?us-ascii?Q?aRGSrlzJ+R4X0J5Y+NHl0M2aqJfxPl6bpWa7h3Q7EHu8qfvePPeBQEZ6zeLk?=
 =?us-ascii?Q?R90YjJUWyCqiKG3uAX8ns88ZVCyC8SC0oLetKPzvM9h3NhWBRQ6qF5UPiSWb?=
 =?us-ascii?Q?Q6bNBI832Z+dGNR23eP/TllYa1xnWZ8aUEbveRAUm9Dxx/kzzl4HxdHWG6pd?=
 =?us-ascii?Q?SnWGLuQCjHPVAXaSrlftdQzBgeQtWvaEUx0b3Pjl/PGhg1oqSBeJgFRqo16i?=
 =?us-ascii?Q?c9uWMcyi9VkjuMFNPuSmbml+A1E2OVa7V9VL85/eyaNkTEfE25Xie5qX8Rt0?=
 =?us-ascii?Q?iz68NrQ0B2naVGxgHFm3It0AkxnBs/urVZnl1P2sBajkMR7J90BAZ8odwChv?=
 =?us-ascii?Q?T/ncDjeEUbRT4tTEpLwWLWBFkXmVTkdNiSyeda1/o/JUUqIF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9995927-9727-46e9-146e-08df249291a9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:46:43.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y41J20GVS4HzYGmHjpgXn1RRb51FNbKOC2HbWhs56M/xJAMEpLC1CojG09ov2hmwBVUYlPBioj8YFgTo+MvLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

On Mon, Oct 05, 2026 at 03:36:39AM +0900, Daehyeon Ko wrote:
> addrconf_ifdown() clears the address hash before snapshotting the
> per-device address list. When the device is not unregistered, a
> concurrent ipv6_add_addr() can publish an address after the hash scan and
> before the list snapshot.
> 
> The ifdown path then removes the address from the device list and drops
> its last reference while it is still linked in the hash. This triggers
> the WARN_ON() in inet6_ifa_finish_destroy().
> 
> Remove each non-kept address from the hash before marking it dead,
> notifying listeners and removing it from the device list.
> hlist_del_init_rcu() is safe when the earlier hash scan already removed
> the address.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Doesn't matter in practice, but blaming commit 73a8bd74e261 ("ipv6:
Revert 'administrative down' address handling changes.") is more
appropriate.

> Cc: stable@vger.kernel.org
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/r/20261004135117.GA206930@shredder
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  net/ipv6/addrconf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 426739abb07440..309c49b2141563 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3996,6 +3996,12 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
>  		keep = keep_addr && (ifa->flags & IFA_F_PERMANENT) &&
>  			!addr_is_local(&ifa->addr);
>  
> +		if (!keep) {

There's already such a check below where address is removed from the
per-idev list. Why not move this there like I suggested in [1]?

[1] https://lore.kernel.org/all/20261004135117.GA206930@shredder/

> +			spin_lock_bh(&net->ipv6.addrconf_hash_lock);
> +			hlist_del_init_rcu(&ifa->addr_lst);
> +			spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
> +		}
> +
>  		spin_lock_bh(&ifa->lock);
>  
>  		if (keep) {
> -- 
> 2.55.0
> 
