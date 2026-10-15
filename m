Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B33AC0DD;
	Thu, 15 Oct 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074743; cv=fail; b=efw8RJLrAlpsBPWEWXXaehD2aCYbEH7sDgzHQVxB0tbF+YQr3pwcAbLclEP+Gyos1zxwmPEgBUh3C5wL7h11Xwasp6LhopLOE3IYK9PIHsp1QyB3D5TgEtq+TIUjaWz4uCDIBWapxVcfxUCUa9OZyGoZM3Z+yshiLyiXGca24D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074743; c=relaxed/simple;
	bh=E1MXOIYDBt3lJH5i11lFr/sYU1ULm47ea1AcHuKsMmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UyZ7D1khHDq/jgwZD+NnNm7/dsOQjOPzXFr0GeOpzAJuZ1UhdaYuQmFDa59+PnqYH3ZaC+PVloEvbKcx1CIxKb3AGOM7OzN3rRgwMT2qtN0JfWZU8nFwvODMOXeM8zX0AOTx4hoGBKfJlvIyRQxKezpNFUdy4b8OVWNfdKIApNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y7Pv03vJ; arc=fail smtp.client-ip=52.101.56.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y7Pv03vJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o16fqm/+yoQt9aIcOzCgIrvmjSBi0DyBebZF9gGnuhlg2xGwj52S33T2VXkPH6GleeeAyc/VwexPYok+pAmRE90UibyckQKgkkQmVAfd4I3bGuVbSnA+HpT2Nkm0K4yjN1jZhTxmvXt8rn6PP1eoZ0RstTzdxPla7pTaYlK0w6s2J2BrBvJmquGz6Hq27sdctxaCywG4vfp1XP2NsVHHQcncyORME6CQnyvMu16eCaVrplTGF+UvD7W93kzUKE8vBkeO+srqhW01VbBMppJwcILvCO7p7RQ0x/A3Dw1nj9OxzQNhdsepETe8V4d6EXYLdhPDr4V/I3MFBtq5Qj8ivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx1rfRGEaG3N66gZZn6uM7slWvBSdZxd5RChMNKyXIA=;
 b=JYDuM/UBTKBfWq2zKWHpZrYeazRI43OqbUnrsFH00H0Y7yHSx6b5rgtLKbZwx9SkNPyFsSf5/YU9W53mt7nCb3wxfS/iy1O4zDk598AWxDNHCgVbYbFcmiRhyUiTFly6iDyB44+0nMp2QYD2uMuctyCiuEPbgZgk6HkKUr8xcjwfi+n+wvjhSsCtFYNchh7z+v5xeqnVVNd8SerhWDsDUpDgozWKvZh6ye593FJ31pTqPCbx2ymi8SOg2kP8r2+1H4hZnmHWf2ZGq3OC0HyT/Jz1IUu0Y0szfnu3vVF3PffgVu2Guro2+zr1UhKz/ziS7MKYgS3MPIceStDCuhARmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx1rfRGEaG3N66gZZn6uM7slWvBSdZxd5RChMNKyXIA=;
 b=Y7Pv03vJYpqYR88NCjIkw6TloU/ooUhsVX05llyE4dQl780/UEqKYAbM9fkKo/MeQHNjKWT9AQ6kLT0wmL8aJfyGbWl70LIYkGETtSxnSi/Y5pe8JZI3sUM/CMrLKb7ZhpSxBPD4pAtX19zwoqeCWB+oUBKIku12db+ExfuXob3pLnbx15ruBgX/F6bpGYa0erIw3z159jlzKrU1iqfgzu0Ef9liCR/Sf0BUVtWhhMk0zfaAWScWT3kiLg1OC0lBgbwtIybmYVvuuiyb03y3kndSFeDWPApf6N+VgU+2qINfb2b3Lfj2JTB44Uv0uhCmVgmeTE9jBilHsWxvRZp2Sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:32:16 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:32:16 +0000
Date: Thu, 15 Oct 2026 17:32:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/4] ipv6: serialize address publication with
 device teardown
Message-ID: <20261015143207.GB1794897@shredder>
References: <20261015050651.1841557-1-4ncienth@gmail.com>
 <20261015050651.1841557-3-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015050651.1841557-3-4ncienth@gmail.com>
X-ClientProxiedBy: MR1P264CA0139.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 35fec646-6fa7-4786-d444-08df2ac91c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	alwl3tnIvnVV8GS4ikPAsiH5e9GdzJXBs0CuciAVLQ/XNvXhABfXreQ+cltybHxXZYNE7nIFMYfbfb6YKygGgzdqtqdqUuyi0F1Unrvw7mgiVZfsSqysEMtK/ptY6xJu7qvVkB7y+EYHboMzDYdfDdgs8iEuFuCvHyHWP5MDP37blz4HmeQFuKuYDnWKEzxIN0nWx3Lh116Y4WveyrycK7y/W5tk+gP5fdSpJSlKhxq6+VANfSk/TszpiguwNKkbuhSLqE0/oR6CuoqLTvAynIlZ6JeDGVx7RkVmVGdRmgr4d8nswG49t3CInqbIK8MyABV+Hjesk9XfxcDR7cir8wTPDvMQTkeexLJP7GtcPCkqbtbJNXzvo83ydjrf4b2znSwGxoD5WVsnOsrbpydvSNyEYwc43VtRmew9KetVDCpd7tEy8aZv1x8WwyavcT6fAShSWW62dU7HM4JNCIHkEsMLjm7R1pPGVAuZlran8S4as1OZj2p4T0Qor0M6DX5uuvJzSEYfLOFTxPy98NygPPErmL/ZqAY6eiquFKyc/qxEbvUXOYkaPX5tLs8fMErPE8E0aKNPxSJelNCPEeB1Pa33kOCWsBJfcYSAKCCd6IA0ah8PNIu6P7wIMbGqwTEffjqp2B8mMsADm0unymnTiBFZzggvL14PWhb2ncIlu+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4+ct+UhD/cN63eHaO778dLEH3NTxKXsXP18ALIzxJg0DTSMd0ffaK14Ndpag?=
 =?us-ascii?Q?/+43FpnuZXdaDXoUnaI4rG1blD4TbG7y7fjmdMqcZYE+xS0uSrA/i23mHMBd?=
 =?us-ascii?Q?fNTtjDCNX3bs1JtlJY5WGFtr1Wv+XR6eP/evonvLvGRfp1a9UMHel1/F1SUh?=
 =?us-ascii?Q?6uQM61GjKLkEQMEmqovXwA28frz98mhW8cNd8H6dgZRmshkMg23xpo+JyiuO?=
 =?us-ascii?Q?zvc+/nn8H0rNII1AqEueOPaquyZD37nthJl3C1rpY294SaUdfg85xwaM0Auy?=
 =?us-ascii?Q?eRplXtYHQZYVU2dcsiHujOXWCVeskftgIskZQX1b2wNsU/6g7NkncJ3CSsfZ?=
 =?us-ascii?Q?fNPdaQVeLkf0tWhfhNR1HvI3vu7g/ej4vl4HHYddcPrTlcPDA+lMrpA4XIyr?=
 =?us-ascii?Q?IpEMH6OiU6ckfPfl+u9amOuzZyzPXN+7hMsExs6uhRSKFHPxd6664ecQUF/R?=
 =?us-ascii?Q?tZVoBol3S0sTZ+rNhuWMPqCAsBsu9z1qR01ahNKYFouXS7CgkQuNE4Z49nyg?=
 =?us-ascii?Q?CV2XE+jQLe+C6tj9KBWKEojqvvtMt5j/Pvt7KxUzIA0osvJjbuBhnhBgXAz5?=
 =?us-ascii?Q?jguxClbvDP3awn8FnSOnGighiozxv1XB75KapfHo7pw3bRJYwtOj5RiRRzeU?=
 =?us-ascii?Q?SnB+8MGziyDw6wRRbrNa7/aEuD/pxATOGGY9Du5GfAp0y7yS2c4X/Gg+uZ7r?=
 =?us-ascii?Q?71F7veQIJhyG2J1HC225/z62vHot9Op3wjrYTrRVd2D2ag/xhuN3E7iDHbUT?=
 =?us-ascii?Q?59l0j/P9N3FJInSBbxnhcV8+DQZXv/Axwbe810+ircgha4aZCmnR+6WThKdW?=
 =?us-ascii?Q?Uyjbd8UH4tJvq2oRyRX0+gXwMm5VIVUN+p4zif5hCjQ+z6Z0mzA/hAhni+E7?=
 =?us-ascii?Q?SSg+Ttv5rA8KbvzpxuqcwSpAxXVGFmvn2Alb6Ig1xdL/lvKT3K0UvF56np5P?=
 =?us-ascii?Q?XvTqwmLN7fSS8ERGFwdO0/N8Djm+nH8AyOJBPLCDRDUoVEPXWbD6Qy3LiOLt?=
 =?us-ascii?Q?kQ+w4vwMinGHtDd2C+hY2R/cP1PolkDnToBfMW+uS+NLaisHErplYQN/ecLA?=
 =?us-ascii?Q?J2dTY9N+yJnPlcIa4BAi486o/0oUA365/rXnb31uT9mz5lWAAZY2clI/n6TN?=
 =?us-ascii?Q?HaKNrekVWjVBzWB5UjXyO6umnbrUfIZvNRemLl3P4Z5k3kVynBSIgwb7mI7U?=
 =?us-ascii?Q?uOQLxKYNt9FO+oUiiCjG4rrb4Kt3WjlZ6Mj2p8ghqRFlfQdhSFSOSZTDU+L/?=
 =?us-ascii?Q?tgjvkIgkEgBB1Hz5cvRAodNDsc9kKk0OqeuNj3mx/0tRKHmg+6wv5LxlWloz?=
 =?us-ascii?Q?tXv1OdJulOf7cIdRVPgglYX0pfSKG7KwHmVTLSN0Ba1VwvNNzEfuEat3axes?=
 =?us-ascii?Q?pSAYqmtMPaQ9Uu3ejfyxJ1vT8Qo0hMZPceQ+WfiqU/GrD+izHeqsrZzTqQx2?=
 =?us-ascii?Q?c9fln83b5ES9MaPEGGhLagzjvv1aBNrabQ38MizQeVnkRttSeh0NZxHCenk+?=
 =?us-ascii?Q?kiqwmRUiHYfWgu16xJWQXsWciGo234+xC0+SYveNK13nU37iVbvoSXHvbDGU?=
 =?us-ascii?Q?x1YoQoJdQ/h6XafmAUlvyRq1aQs+pIpfCHZB2jlC+K6uT8Kz/T3sL/AQeTrO?=
 =?us-ascii?Q?NoZtOKRmSCR3+FhTr1p0DAP9WV2CzbYijt+etzHn5bN5bvKif4QqtFQ7T+0a?=
 =?us-ascii?Q?No3EjKFw9n+6If5ESpLBdh7274icZbt6HQCBX0GTHWH7TmoXdZSl/iBIoGWt?=
 =?us-ascii?Q?XUdnUgFQxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fec646-6fa7-4786-d444-08df2ac91c40
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:32:16.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD2U0V0QU+l70JqzHPipLUHWE7N+dhMVNt8gZM1AWB7VmFPE741JfKelj3CuoVYj7ci4r2aDnh39fdqmAFgWMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

On Thu, Oct 15, 2026 at 02:06:49PM +0900, Daehyeon Ko wrote:
> ipv6_add_addr() checks idev state before allocating an ifaddr, but
> publishes the object later. addrconf_ifdown() can mark and detach the
> idev between the check and publication.
> 
> This happens when a non-loopback device MTU falls below IPV6_MIN_MTU. A
> forced interleaving published an address on a dead idev, and
> ipv6_get_ifaddr() still returned it after teardown. Later device deletion
> remained blocked with:
> 
>   unregister_netdevice: waiting for ac0 to become free. Usage count = 3
> 
> Protect the dead indication with idev->lock and keep that lock across
> both hash and device-list publication. Recheck dead before publishing;
> if teardown wins the lock, reject the unpublished object.
> 
> Non-unregister teardown does not set dead. The preceding change covers an
> add that misses the initial hash scan but reaches the per-device list
> snapshot. Both changes are required when backporting this fix.
> 
> Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/179161099408.434549.14449036924552933828@kernel.org
> Link: https://lore.kernel.org/r/20261012145306.GB779501@shredder
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
