Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF7305664
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786262289; cv=fail; b=Rb1qXNNO1OTLfxox6E1kIEoWzbX5h+8rzNe40AZGru6nZzLgO27Jv3LfkkK9WcNbKt5C7kbT7GZ5PyS28Ocr5BpshgZuCBwI8A0IqO3z2TJ8KNw0YzckG/8Kr64nNibn0Zcj7lvmzzBmJKyL/ksuIvz6WRwBhm4r2psTVBmWKSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786262289; c=relaxed/simple;
	bh=Rfr2VlJCkCqHoBUVjAXgcNoNKic2hYVe34RWJ3K7kkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lcqw4Gb5ta9VL9UyKBUlJg5QcMuTk4ewJLddq5AqIBvd2Bx20J0LVC1fWnCWU95vN6auhJid4fEHx6HIPMbsvNFIjFwkYzbHUpQ4EDsVnYMbtKd7wkq8Nnsovc9hop1KV2f74x3Qiyt0rCobkNBXH/2RCXL2qqyKtVEJYseCvrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SSzPu+og; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SSzPu+og"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLOqZxjuIk8cVgHSE03EFQmOSHFk1AsdUHyXJU/8hLY76KwIrDyttIHmo8H+Nr+IN1dNzUM/325zGyyNG9xdauMGCxaWnRde4n6puheqT9wZBtSvEjug4Jm9uBecvW8ViyYLskDRp79T2V7TFStmT/FVX4zAmLEK9su2jy3ycPel8GHkTBSQwA4y1qXbMb6CWEnnr7cmxWm0QJ+Xg1NJZC3SCkmGVEW5rdAtMpWmAVpy6sUeIlVIo9TkmG0fsUjfeeS36cuqNza/UtyeQgbDu0SNQQxygES1dX4p2MLMmJg807OwFWP8uH4Z1wqjkKPbMnIDXx/7lCg7VZGdAegpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot6UPJPL9hme/quvl9vPurWzLCrNcIhRCWJG8r9w36w=;
 b=JpIXMO22Z8S5vEBtzg8KX0+fSz6Pp1jdI6JTKlSRwzfT+nmhjlqACwaT7KvRBrzfTkyjWR9WWRY1oZIp7t34eojrYnnqkZNCn90XRR6OH1c99nZGdRqWNK/BUfzhAWUHINVdQaKlegmWwCa2HZ9jXPQdYLwhf5lb0zj6VlYqEi0svfJQB6r7yvTeJms/kCe0BYpDhT2sjbMCr/2iCA2HfStwiVOyukr2Lpi2JKEVKJmVgQZFzmio9RjbrBK0VEOC1HGqy1uqSGDVC4Rw2MvzHQuMetxwBKQjugGeyqCWYGVTinVyqmPtkHF3Sjv41PW5NeA5/gKcej6g5rIM0GC1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot6UPJPL9hme/quvl9vPurWzLCrNcIhRCWJG8r9w36w=;
 b=SSzPu+ogz5iagT/XsbhaeNXO/cNFdInQGO/4Tq4BUlvDLshe2Rc4EnF4Yg5EfmfZ41ZsBBPKO8wSzOES1WV+4AWzDkXO+9NJTTcWhhruYevRwFboNTNQSUu2mNQCh32OEA3+Pjp4T6PuFUlDOD3w3R+eGL9NYX6qXhKe6dVJ8Uh1mY+aDF9OmLzvXEOksleCBlBz5m/voUcXm1CnJvPvrRSZz11hIjoUV8X9jM2+h0yxdrwIZaoeLE1qWRC8ixIi+F2Ms+im6RtaycPF4i7nREg6SiWqkpsaYPijrenht4m2Us6sgSp9Ymf5bNAK33EhHfW1DY55juy4HLvl8Zz3tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 07:58:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 07:58:04 +0000
Date: Sun, 9 Aug 2026 10:57:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: zhilin zou <zhilinz@nebusec.ai>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, tom@herbertland.com,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
Message-ID: <20260809075756.GA2304632@shredder>
References: <cover.1785734738.git.zhilinz@nebusec.ai>
 <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
 <20260805090721.GA1364862@shredder>
 <20260805172902.27c9bde0@kernel.org>
 <20260806085214.GA1748060@shredder>
 <CANB6i5xN-rrcVe9foAJ+nUP-6VLrgXa90kwh5banCUVDOwG=1A@mail.gmail.com>
 <ae905b11-1b13-4f3e-8705-8a8c2ea7f54b@redhat.com>
 <20260806181918.GA2060872@shredder>
 <4dfd3009-efa3-4cc8-9d67-a9e845fa2d1c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dfd3009-efa3-4cc8-9d67-a9e845fa2d1c@redhat.com>
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc18e3b-eb30-4903-402d-08def5ebf111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N1B5INEeSqDiSXVh3UAkZ0aUvBKErQTTYBgAj0S6bw+QA0x0vsm6RfJ5HWTNQM6mEBynLeotbT6GIl176LpqNcCh0J8FirXjDXPDCVIc62FDAFLW9weQtzSKbAF4UYMNsZE00QiY8DwAT/xq/614wJMQlJhFwMZbOdHiTXgj3Rk0O6adlqEePfSol1O+3lWQlgjLi2e8a0czGw4S16xhFk6hXPd9GjCetibc7TfebyBQkPo/dMX61ceV5Hs/tsQ7Pmf59hPMTWjZOkVSXur4OOJhs78KwwSifCW3/DDJwwxqIeBWej9/vVnAy9IrWsJt+me/Fx5JEDYVkKoyg3TjPR03z6v1o0SSbac2G1GQhvCgXxWEgKaiL+zDLMXK5so7fsvtUqdwqrpolbmiZ3G7YshkFmjYOzq9L2jpkdDnGtxqHuN3ljAifG2WO1k/N7cI76K18QssUe3fTJK4JnxWPBrFg7eGxnP9g3I6peamPYyO3R9vv0xzLeK92xw4SchwqwHFqT/1XSuquNL5lh8Yb5FoPzOcXrHBf5FzRWrw1hdlcwWWsLCjrUGknPle3TZhZMb6mrSI0GmxV2kOZ6m+MOycHkKZl8zk3nWX15hn7X2qwNBBTzZVSGEFLLXuNXaJyj99vO4awz8hhpFJzw5qPoDfduHDUDmWb/JbC82ZwqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLLZLzFsfnWJs0PiGYkJ5iz1nJwCiGESnAIeEg5l+kR4NohciX1JeSFUdbRa?=
 =?us-ascii?Q?PTN2pWLb5V11aoGyAYfTTibOcm8bouLkjnjxoLbcuKXDf9s29fIdksnYx0WQ?=
 =?us-ascii?Q?e8Cm7jWEA8QXne/Dq8nHpsAFEaZGAH6dXPV8WdhNeVOxcyGeIiAS5Hqt9NU0?=
 =?us-ascii?Q?3b4wdxEFwsjDj8y859QmXNNrv5u2fX/s37lVwqUPW1WvaYLpQ0XtU6+ahWK1?=
 =?us-ascii?Q?IulgO4bQnvyl5xS+E/T0T6Dw+xAOJoz+1KsMavaAoj9QSxvVc+7bD5WoBJbA?=
 =?us-ascii?Q?cGCL01Junb5cy5Q5OfSTGu5M4NRORtxVyMYK3d+lM73FI8QSIW60dG2V9kn0?=
 =?us-ascii?Q?6rnJLD1uj0+4ksCKL7aVAFSLQoxHTH40v9yE+ydLz7Bc5PnnFcKt+Z7s6HI9?=
 =?us-ascii?Q?rwAHLi6si/UR+8//Qsy6jTd0lUZJf9hURzeqJ8OYDZrI8I6uCqIq1YUrH2SP?=
 =?us-ascii?Q?OGt+24LJ9f6aDhBaAa3j0Auy5/cC4yVpkj5v7uNFH8ChlXwKMJxuTXOFGkj3?=
 =?us-ascii?Q?s9vLzaZnV1m6AUyLafwyqGBmNYd8TPj8/wnDiaQ2duMZ6RM7WjTXNsIaZ2kG?=
 =?us-ascii?Q?AoCVZdtQeNqSleyHDfhMfmq6QyV6tR3hqHlx+aU3YO0gKzSBOFN+MCHz1CoX?=
 =?us-ascii?Q?fc2D01KDgVa0yJEhJ2v+Zy0pFigDgO7wku5pS99ButJEZpVYplUZTuRHTUk9?=
 =?us-ascii?Q?HNhQWiITWqbPh/okRHWBRH00aqanEdS9s0NZcnwrYJ9oCeuVcEPM9s5HgINN?=
 =?us-ascii?Q?emvq7Rj06hkqK6prWmdBw4nEKCokTSUQduADWinDygzD0GtcqZ5Yd/z+IpSI?=
 =?us-ascii?Q?blvFrOKowKBNv2WcfgntugnYtgoDPGf3ev2ZOgzsIOwu4oT68ey85AVgcngB?=
 =?us-ascii?Q?4JGMHbPm0HBcjw/vNk3ufRakxE3L8RRPlZ/6WxVdNyk5Lv668UKO62fTt4uj?=
 =?us-ascii?Q?YWue6VvZZTBh9OD5UpipnGbdQjnJNBkXaUtrdBr47d9pkVanDOnkcxtTfvEk?=
 =?us-ascii?Q?DzAU4xYQR6psCvHXUhKCVdgiKf6xG1TBlBR0UUWu6ibP07sauzfyowcnXP2k?=
 =?us-ascii?Q?AQbpHwgmooFPsibBmugsppRcTVM07RTbcIaCS8eWurkBgb10QBjOU8/Ii7AU?=
 =?us-ascii?Q?J84w0BpL40Rrdscqz4dn7y8HLNALWEiAr5HIdmfn2SjGgzTYXdwk0E6ZIxPG?=
 =?us-ascii?Q?eWnBaRQzDUf6cC5WJpMw/Buoo/LZiXvM4pJwFTEvGHBVLI0/S2hLWoQGf/rf?=
 =?us-ascii?Q?4meXGYkmsCh+pjCueYdh+yvIkCLYwokJu6uAopadPkH/dq0c/jdqwSR33rab?=
 =?us-ascii?Q?Tmb+ljaAwe/x8rUS8scPw15uEGjVZ19LHDAblikbRhSiMKg7qz9w6J4cwMp/?=
 =?us-ascii?Q?sHwDNq1UzmQBfAYkJvsbXpqBGu9lUu7eUPFVhWpGuBL/Hs9eucak7h3sRlUK?=
 =?us-ascii?Q?GAJuhzXuwBVUfiACfueaJHao4HGKQMlukGJ1HvjSYjtvCCM5tRLP7RnMHE9c?=
 =?us-ascii?Q?b/5v9aLUS0rW7Azhm9MxM+yZHTVEkOSDAuofhXbRgSzVwO5NS4amv/JYLs62?=
 =?us-ascii?Q?EZZ4KF6Ei5dNEsIVEM8BNNeqaZbz8mNNIyMS5VHyizpkasvrLEH9/+1K7uDH?=
 =?us-ascii?Q?yy+WIhi7ZBD0xkM06sLptscaGtquPfjaT4WI5ivZt1yK2ovaUixHjNUrI5ku?=
 =?us-ascii?Q?KuYxN0VnFfwZDketxbXfAMP4+XZf4UJv+Q6HFDUihRju/IKZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc18e3b-eb30-4903-402d-08def5ebf111
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 07:58:04.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4ta96MttWW6mjjT1eNXNTXTwNj3voK+rlhnIbxX0n65LYTAqHYvkpMZ0MrVUnLpHwbatzvont4PBPTlFausmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

On Fri, Aug 07, 2026 at 10:31:29AM +0200, Paolo Abeni wrote:
> My my concern is against possible regressions. At this late stage of the
> release cycle we want to avoid them, even if there are already similar
> pre-existing bugs.
> 
> AFAICS pktgen sets the per pkt_gen device F_SHARED flag unconditionally
> and push shared skbs when F_SHARED is set regardless the NIC priv_flags.
> 
> What about addressing both issues in the same series? Something like
> the following (completely untested) would do:

I don't have time to look into pktgen right now. I disagree with
conditioning the merging of this fix - which makes IPv6 tunnels
consistent with existing ones - on fixing a benchmarking / testing
module that is not available to unprivileged users.

> ---
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index ee64f3012321..a7126d639586 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -1385,6 +1385,9 @@ static ssize_t pktgen_if_write(struct file *file,
>  					return -EINVAL;
>  				pkt_dev->flags &= ~flag;
>  			} else {
> +				if (!(pkt_dev->odev->priv_flags &
> +				      IFF_TX_SKB_SHARING))
> +					return -EINVAL;
>  				pkt_dev->flags |= flag;

Doesn't this reject the enablement of any flag (not just "SHARED") on a
device that doesn't advertise IFF_TX_SKB_SHARING?

>  			}
>  
> @@ -3868,13 +3871,15 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
>  	pkt_dev->svlan_id = 0xffff;
>  	pkt_dev->burst = 1;
>  	pkt_dev->node = NUMA_NO_NODE;
> -	pkt_dev->flags = F_SHARED;	/* SKB shared by default */
> +	pkt_dev->flags = 0;
>  
>  	err = pktgen_setup_dev(t->net, pkt_dev, ifname);
>  	if (err)
>  		goto out1;
> -	if (pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)
> +	if (pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING) {
>  		pkt_dev->clone_skb = pg_clone_skb_d;
> +		pkt_dev->flags |= F_SHARED;
> +	}
>  
>  	pkt_dev->entry = proc_create_data(ifname, 0600, t->net->proc_dir,
>  					  &pktgen_if_proc_ops, pkt_dev);
> ---
> 
> /P
> 
