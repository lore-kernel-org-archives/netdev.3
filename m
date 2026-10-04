Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A83B1EE7;
	Sun,  4 Oct 2026 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129996; cv=fail; b=QuPm1a2OUXgXD/i/aAdVOfPOcOS4/zCqxnlnMpiPK6RD6i/OKPy5DT6AahOl6npHYezYJCYnNDvG4rbwx50DpED3lPHIYMSbzKJTNfibka2QN4AKjQ4zw5Btb1wsfxlk9B4DPrNHngTvG04OofYnAhzto38Fd25HgvnQruYqp20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129996; c=relaxed/simple;
	bh=24RQhcO1BCXwlQ1TjVDOMuvW+eMuwbKwleJKpXvJq1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZlR2iq+NJhaETVA3ABZEi8wfem/T9cd+XtOVBRa+XOOyRhq6cSH34nj2344LsyBMgDbRBilyGl/ohvXbtOR+EnfnwqUw/pOyozFAERIuOs6s4Toz+XbTmS+IFqEPijeMq5uc6WqSKY/has7CJZjjzeuY2MzVbHjVlLdloT5mfCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ewcvjyx+; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ewcvjyx+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMuvzyZxt/x2necvFpYUz/HZQpplU6uyzO8rGj2cB4oCBGwk7L2oxuKFnLvz8ooECrsGbALGJ5q/m1wN8ACMwLAS5gJtrqBQav3ILWHB/wW4CfA3yN+qCGAyXjZUP3OrjvrpDILHU0cgTKOFVPJ+X2dTBF6HlzvS1NCwfH9QtFI39rqmjVy6MPwj/1K0/zy5sf9rrxkz8fwoFcgQgF/dExEzf/zwopp3B9SfhkhFOuiW8VxQwsXVslbGr3nTrMVu29q5TgxXRzeZ5qeaElGuTaWGlFn1QrGGXCB2PxCbyqvh5FSTZnYr5nUsYtf1HrUFt7twciXTqSHDo1iUAUyJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl8zxuiSxOGASTBV92KtRe7O9pzVm6BC6wjbsYa6B+I=;
 b=Ukc1UgsTyHXvJ//4Q4+tS0KWDpSBErMteVVIZ8e2um33Xomq8La3cIKemdMIyvU/89Vpl62S3qEvlbE9y5HvCygdCv0EwYURkmRqDFtbUxP2RFaQIc8F0Qar1OEXzy1XPQHC9wBdNWUeMxw5nGPRJSbQDNYsO9YgNN4N+mt5OZ23sUd8ZiAFSiV4hH+89/t5dkcLp6tKLAc/jbj6iazCf6dI6Ngds5atKETWOSNDXCzLndn6OIGLiTXWSOk+5zKXEwHpmR5f7gkIna2dGoOOoZz/Q6Tb4FUdATEvIK8cNM7f3Dokyu6pFwFLXnczQWfVZ9c8QguUUVGLeYcn+3c3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl8zxuiSxOGASTBV92KtRe7O9pzVm6BC6wjbsYa6B+I=;
 b=ewcvjyx+cxkQlGjGM/X3ArOVHQibVqenhejwFL8NHWOJ1lOax4nfgf/aczRxyceO8WWssDSw9vlyJMRqozfdFpvoT/lj9wj/t/yKcutv3HUVAI+wKnSWFToKTUR9/0vQN8074XJQcqrayyjfGu7lRUTiG7KnfOzjpfVylFuqKryiTm+DuQVfGg7/gioVPLQk+ca1WUYLVD+nlavnjNkPe2g4cNXXHAt5roJHkBPhdmpSwsgklCn7Z3y4mvJDSW+9jK2kfs9rLVWm2aDZkYtnwxr04dBr/xv9mKhek/I0JzHJlPzpzppftEFCgPFWt5iTqVGWremmYSjXnkY35eFTqQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 16:06:31 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 16:06:31 +0000
Date: Sun, 4 Oct 2026 19:06:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/14] ip_tunnel: add drop reasons to the
 generic RX path
Message-ID: <20261004160622.GA334650@shredder>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
 <20260930183910.3151873-5-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930183910.3151873-5-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR4P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::8) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c59eed-4338-46a9-27e2-08df2231743d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	vCYNXR1778SZPgXx9KUgo3o5AyzUCQnnlfwVtO5xq9uqTrgPiy6YhYUhgn2NCHn013gglrEfdv+QAsX/eHbgmszjFtI7hGUcOBDYNMWXKkHMZC5EnedE6OwN4wcjazupq7AoeEH9yL9m59mIPQX0LTWQghYuv6Gc8QAOV4TlFOsRxsK29GN/uGj/z0YgVRGtn2J0Z9mV4IU31dLERbwxbrnRV/FJ4nrdPmPKUSQ4XFFPYt1fp0PVkakEiz3DWtWNao4veDRnNn0FIbP8U7HFtmAQTBpr1bEWhesl8GebSewx0BteFEGb3673r8W6o0FkPDxUOHXw8f6HQHdRzU3x6icsGGjFmTzKlrMKtVs0IhPrQyYY7zlOZSergTPGmHRBpdE3FkDvOaIXURkzx+RTXEaG1Ylj3tbX6Qo7In7qK3zmURSJ/XMhWRK9drcf+fUFWbKtFOzBy9McUQcMdZjEodsvwgOrDaHf4lzuwl/GZWTSupZsokJa0hYFwILShYRsFPSCvjC67CiMl+0JdrdeFvRbPFqyvuEFmkuWOjO1GCUflAplu1zweaOg4SOr1JEVJ4cWZaWmlnARUgx18HGi3jUugCRP8FLM1T90oWX5lBkwxJ5FP0mbUNtOqMg+chcgdbXtI0yRUmBMnPLaSOITfAQJJQDSjG9g1BQegK7iv9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DOC6fv7zIf9rOKJKq6mjTRB89WLdH9E5Bw500++PunXjPX/ARWQhbYUdPBOz?=
 =?us-ascii?Q?D1zFuazycK8gT2HgTHQ8AgypiRH1R3t+r2Fp7Dz8iwh1cjXtFDNsG58QWzyS?=
 =?us-ascii?Q?MLGyq7K6M15Z7Mga5Pv9fEV+70+FmDkYoIHu4mp9W+lsc2XtIJGkekhSlOq1?=
 =?us-ascii?Q?0zKzBcBxPtKJleZ367IONwe+yQ4O65AuNEkgU2bMhjVCEH1A36UhREnbQEjv?=
 =?us-ascii?Q?lCnsX7uctGbfZ93J6702qT+CZoABuAEX+uBgnaVihIUmcmqPx2hYb8ifY3vP?=
 =?us-ascii?Q?FZI7R4RvJ3Q8diW1ARX3TvIwlABI23H4aeHjAaO+lwYs0eU3oZT46T4RzIL4?=
 =?us-ascii?Q?4kNaKXxKdbtLcPH+1I4OlXhU8lDcU/CIlkh73d9pleRphUSh9SHd5xoJCjdC?=
 =?us-ascii?Q?zvS9jSlJGqYOujYaffE5jngRW2/8OQ2ER1yZOZHo/sNHYaj8rbRwCW99qpYD?=
 =?us-ascii?Q?oFx5F+8alR2pp7T3LJQO7ExWArWix0H01RRo0ZdwO3KlgLKFAQIf0GaHy2gK?=
 =?us-ascii?Q?I0xBF3d14IfTylSbVM9pKAZqUQ/ufQB7o8QJxZxEs1RfyUCmlG6MFgIsRQpO?=
 =?us-ascii?Q?BeseQhqWjaRXa539ujMsH9sJoRePOGiLYtINxr0by5ddPuz7uPL0NVrSjbJE?=
 =?us-ascii?Q?QshaDdgO60QApLKeyLhl+39eeYn9rrUd97xuytO/tMMH1siwoyAxD3Ya8d2D?=
 =?us-ascii?Q?3v+wxNkGbtWf9BhTqAaH6LQ6VEslJrNL/nLHGG8dI+2VCmku8V92WdZG9Ooz?=
 =?us-ascii?Q?qFOBk3p6DZFHvSB1MmuQ9+xyfGU8+tYqM1yHBmkmbUkgEATxEM3+YETc2/Rz?=
 =?us-ascii?Q?jYm5ZLkFaeuzviP0AOz1MaLrlyY+R3ZF2gNmw5AicPAuWqZYl2actkUNBj+y?=
 =?us-ascii?Q?MuDbt8CXg4TkanIsoyocORB0YGdhFtVEOYD5cr9LkDGj3g7IHZfSQ/uBVGix?=
 =?us-ascii?Q?Eak5aCq9tKGwWwnUAGlislGgTXmVUOfCGxFQpZDmSjvT4/TRJ5xXUJQMYze+?=
 =?us-ascii?Q?HaADEuS5YELFYHgxf7i09JdMvU7w4kJEOw1ulg5Bl9kNFeG+c0GFl+HgJE0M?=
 =?us-ascii?Q?rPVvB9MBjG6vzDP29c0jXddI4VzLtLHOU1Q8b4ZjBf+PEqmzIZyiJ50k3kUO?=
 =?us-ascii?Q?IJ+HjYoIKr1Zpt/tu9w4qnU/e9ED3ItDfWU9de5MnqTwYQ/LybzmZbZ+MQMo?=
 =?us-ascii?Q?ZnUz+3jRMiytRtAPfOipY4SvgwGmnQa0HaxocMzOEdEi+v9afiYaQXIdKDI3?=
 =?us-ascii?Q?zPwk5fTAPOGfv3Nz2JqOychUu05Hevn+BhArInk2XuiJLpjDVcIJg9jWr4yk?=
 =?us-ascii?Q?GTXpWJM0o/P3ZTqXyyw/ke9bJaro4l1c5qX25Sm9Y0KtXwzcZa2qcQfLOSfx?=
 =?us-ascii?Q?6LdWxs0EA4eHyScuC44DcUeM3ZE/oLN7Uvr63BuAG0vJj0pN/MitJUiOxKT3?=
 =?us-ascii?Q?3L1YN/EBkJHukgUItHaQeLhPcWWNdqKOlx76isK9BjLJ/RyhQJL7mlUWYtHT?=
 =?us-ascii?Q?mYFj35m8UpKLA5npMT4ywQQlDVk/gVUqewSDHVdwjhH/rBstHkhmUmGWZ2vr?=
 =?us-ascii?Q?5gA8bDuwGsDbc7ZjxTs6wOHzmUqYbjIlpfYiU3iyyt9ezmVbQBe24qPPTND5?=
 =?us-ascii?Q?r50Jc1ZmVOw7Lbdw3OnpZhg1N3bMeuawwYjo3efWtSPOWhRw5eh+uThrIvZz?=
 =?us-ascii?Q?7NBJVRvmaa3ZaetuXni/yFeCTNwM0WfR/U0xc7Qb9fYVqygv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c59eed-4338-46a9-27e2-08df2231743d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:06:31.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq4pHK/UWNWItk7Iln/uewR6fHu2GsshIygWl2q1ALsr/S+5RrFBIclTjag3OL317WGD4mLJ5hQpoU63fmik9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573

On Wed, Sep 30, 2026 at 09:39:00PM +0300, Anton Danilov wrote:
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 0875474a578a..6d500751f837 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -384,6 +384,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
>  		  const struct tnl_ptk_info *tpi, struct metadata_dst *tun_dst,
>  		  bool log_ecn_error)
>  {
> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	const struct iphdr *iph = ip_hdr(skb);
>  	int nh, err;
>  

[...]

> @@ -455,9 +466,10 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
>  	return 0;
>  
>  drop:
> +	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;

Why is this needed? Looks like dead code. It also masks the debug check
in __sk_skb_reason_drop(). Better to remove it from this patch and from
other patches if they introduce the same pattern.

>  	if (tun_dst)
>  		dst_release((struct dst_entry *)tun_dst);
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, reason);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ip_tunnel_rcv);
> -- 
> 2.47.3
> 
