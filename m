Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792508759;
	b=RP4zaEA0uruuhWTzmeMC7nJ+VjGbuDuNgJZlqEGXaGU/+RwJLTkCcfEXuuN4lj+EBU62
	 oHLjVF+BqNi6xr8MkFR9v1RiGrmCMXPolnoZq1/pjIhRg0c7Gdo6xVjXFFBIqJkLRGHOR
	 jVksOWjUmfHc0XSh173XmE1nQWXOwcV4FqX934OfpxXKVQJNuTWuQ56otT7/rhTb20Swv
	 Jx1dB0Kf6pc0ePZAEaaqmcPfR4lGUPWlnf0jL9e+zZW+0AjZMvQ0Vze9o7of1c2VXhccZ
	 bjF0pjW8liFsTjShFfdOa5uDo5HjPc3qU5WToZkBQLl9ar331yOe8a2/s9K08G4IQUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508759;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4YV4HBMtHQcW55ptRAvjR1CZE+js8JNCgef17+qLb08=;
	b=AoJMa0d3P+iY/ukyZqAEPgdyWlyv+vizzkwWGFX4o2hRcSkqfggWgc4s3GAmwnRMu8du
	 QwDdQrBWBhZDoUj7mW7eoxHQc+RRPC1Iyp4PR5BzVNovOx8GxqvdNvYfal+W7x8sVJf48
	 24PJ7d3HRN66/Nii0DZArqRuqsBD7sYzhiYjgjykUeBkbL6tijC/mhlskSQPu9X+Bybx/
	 aAOSJswqa2DeBxXeo+S9KGJS2LXDzKgNHdmlDHwgRWeQ91sNKAQxzwGf2tc2gCC2xxwci
	 hf8e5fp82HwtUY70li6YZ9GxrLGzIcn7QBOxfz70YKGJvOV5n51k54HI2HoHEroQlcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lrahr2ku;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.27
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6C606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lrahr2ku
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pntqtIU91dYq11+VOqRXGiSvEuhwlE1dR3AYvWrSvZ24mYBZD/VLXjFAOSXbzp3OKHagRAHpzDtRy/X4I+7qU456rbBO3ybtYsCroPdQRc33qAvy/HmFxGeofV/wl5n3slTfDKKpp7aE6hJXc/rCqJDHdnWQmSt3u1Lb0bBq2aIV/Sy0c+15VHNeR4lGEefx/l5Qhkv7s5ZgdNCrQ59S7Azf+AQ87AEG0uitd3odgQzuvG+fQyu5oybr97S90p4jtdE/CGV4z6OR0P2L3r+iaZmw4JvXrcC9RgzasfgySHyPgB0dAplexhyAZK7Vkv2MV5N9ccPijJt+m+bFjaLjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YV4HBMtHQcW55ptRAvjR1CZE+js8JNCgef17+qLb08=;
 b=prH2HIQvggaY1aoMqVkk9LLopn706ycWPpnIrH5oCkflRl7Wa13+vXAVyJxK6DVDOc0av9yhrglD1+CCVRSK5WW7x24C1VnLn//UOwuOMregAq/SxVK6Q4qgQ9o10f9OX1YY2Kl+cJtlV2su9GA9vq20jCIy+fHVvlAB6+P2kbWIBd8PkbuIZVJ9/ksXVNkKlHU0ME+h5guv+9OTid4s+uWLEW0/OmL+tzFHnp8D/bm3mYFxJUAMRWnW04QqryPtFjiaVt/xV3oWaV+zfs7YvAn2aS+FvhcFoia1XMsvykRhhW7mOFr9f3gZgUJT1YdCIEN6kKBqOdlMjCz+zzBomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YV4HBMtHQcW55ptRAvjR1CZE+js8JNCgef17+qLb08=;
 b=lrahr2kuJcbG7YQZMkHoEPeZE6t0aEWlnTLSG+oNXEKNeU6FKODyLJLV02/JLujIlxPxVgdxAzcrzCXmkCJCTadymLWz1KgXJqiL0PKfzVJr7bYZICcEuup5pQJ/IQEroirTwzog1FT7gJKGSU8IbZp4IZgWjcp6Mt3iYwWI+8/+NSttCHIA02Km+BE1mUXXxcTCZTKHyEulzBfy0d5zcOcqWRi7SYTAkjfDxtCVicj883WXckMcXfUcCNHykmzvfb4SOT6OdmjApPDCjYN5SuY2Ygv0pPuJ7X2Pixt5DJeYLzoVR27kpwBHc6XcqRBkXzCJhaYpz22z0+zLjJv3vg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 15:03:53 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 15:03:53 +0000
Date: Tue, 20 Oct 2026 18:03:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Girlich, Franz" <franz.girlich@secunet.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: IPv6: wrong routing from local socket with multiple routing
 tables
Message-ID: <20261020150342.GA3175861@shredder>
References: <84e3ec2178897680e510842e4282d691984bf20f.camel@secunet.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e3ec2178897680e510842e4282d691984bf20f.camel@secunet.com>
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: d558153d-6154-4126-a9a5-08df2ebb5ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z1QthT+Dc5uOVoglv4HtIilG9CWfPplEt7UvlZw7Ce+ewRikKMUREoGtFYsumGfmN5J9JRAn0tCeIPUs4zKpOLDWRvkRMSjevPYZEWbwGGRQkzxUoeOy8ctFL6D9WGJxKQYYeKCXIaVZcsB7kVZB0GGj+zHZNLETYrO+f/qRSQ2gSG9PvoWxvdZ7N9oaHOHYzX9EAJTG8txbp7xhWvK6ZcxJpOY+KshEY6driM/qROg2ztQvEY7E54w2ITmx/YgD/7AP1bHk71bnHEjzl7B1oPbFkA0G6gOBEt2i7EdbJYubYe0xgCeO6rx5u4PS0IKDbu6L0pFi35X8Z9c2GpvomPTFBas3Buxi35YXt3UCgF6tKuG/KeE9J1S8olk2VV4WVh0PCY38sdYiK91aMPvKHvY2sfGOcFkcShYRKO08Vmc9jmE1t9y1zyFWI225/dUx0rjNIp4nyhESJGU2B7klK6qV18HAwYYlO/2k2awywk1sB6sYwRjY03dFmE/NlLj0MK6cGx3F+ubgAWEsnSVvVDPMvDo68GgZU3GG+4Hr31yUaHPQCvsftT+osrvjB8Ka9jQNgU/CqAvgqE2V5B/tEjw6aIkBkP4QVT30XK80/OZTKIZh1gg8MlUj4QT1lNi4xakwal1yO3ilEELskiameuOgnkGqCq/pPTA5B24MFBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7v/efpDvl1S1wSunC7dBAwG7RXpnOBBozgAaeVwdn+kie6ATjQaRBX7iG2n?=
 =?us-ascii?Q?sOKNjVIWUIuE/R2VJ4PbGlDqdeQBrEs0qzemBOpo2nX8hWhzwDOOSgL6RlwQ?=
 =?us-ascii?Q?J0HtWTVD5udAGBDfKUNqOn6aaKa+XbmPSOhdGzMB9yW70Fya+cdkEJz5s2ir?=
 =?us-ascii?Q?P6BPjLtNKxVsVXVFVD4UHJj4ozZdU2y8SDVHGXJoAYoAj8okHaiIZy/i4+XV?=
 =?us-ascii?Q?AJUUJr7GMUslZWLfDkGOP20FKTA3QKGz+xScAGEJWMBVnG1W2INeMrPi5GCh?=
 =?us-ascii?Q?YhJYGMwNkA8dpGnpJZkVroUDlb9sOwULrWl+NTuCeQVg3uNBl9uu5snTN7px?=
 =?us-ascii?Q?aqcDOEzvI+Wa6ivPwX0QzsW3ppc20xPE3hOHDAqaT1Oa2z5hk/R1wb+aaUaA?=
 =?us-ascii?Q?SLh/B8cK9XtJZjqmZSwYZlbofaRk2UIf1EUR97/BSJGT59MltxlCiLNIlSIg?=
 =?us-ascii?Q?s/Z1GFwEtKd+7FqudnsGGYbT7qndZg8BmuAF/ieM16FmZySx8TPmhEB1jIkL?=
 =?us-ascii?Q?f4UligJjPlEkELObVgLUNOSp7HoLyclBE1NGsfAXiX/NY2M4P1ntX4yakVh4?=
 =?us-ascii?Q?bA23CH+WYH4TReEXiBCLjrH1oGJhXqe9GFEwvQAB//DTSKzB4R4GJVn0yLkh?=
 =?us-ascii?Q?Bm6iJjPrO5GvYzOME0tl8pFM49bjXoew2yiuGACeN+XtMS/4VlV4ivEdZQBn?=
 =?us-ascii?Q?YDoKIVV/Qbw+Anejek0snynpLf+fYDbuD+v0w5pj4DWjLct0OGACkvUv3XeY?=
 =?us-ascii?Q?Tu3wcEoi7D+Gb0KgPek4hhfhxqVfIJMYI2iD0l3pCVF1Z2VOi7MFbKNku2Qs?=
 =?us-ascii?Q?vjj/ZJjeVXj99E39C3A11pzE3Nb0uoff+0N9t2URuAFDxNpUwWP7LjE7jjqA?=
 =?us-ascii?Q?FaZKNiHO9rM1GsqupPqhF+76gaSkAw4fBeyI3hCA/UFDIeOKDg7RjhvbDegT?=
 =?us-ascii?Q?pJKCUxviYtRH4BnL9BkF36TpQs93fMlhckZS6/dqNdCZnqBi59HFT2iapQkv?=
 =?us-ascii?Q?FE5dciPJ4zWAkoTL8IZUm++f9bWt9eBiE0qQs1lFaFrHA0hrVExqPfgteMl8?=
 =?us-ascii?Q?hBRYQE0Qb5dCYnQM5yKfQEhL8+AsGPcHAm2HLyL0SpWH/IBlgy7v1926zLn7?=
 =?us-ascii?Q?da4/hgn1xZtyAKRPNhm4Cmgnun7tiRlml5cUhwve9LIpQvTNrrGxwusdYp5D?=
 =?us-ascii?Q?KGH7afQYQUmfE3e2sO890AYIe3Xeqo7UIxtRKk27+MITLRyxys9n8P91gkoN?=
 =?us-ascii?Q?EFZ8H2xma//liNdzejae/c0yu2WkOrTHxJFFbs/6AYejf63UXhb2iq3tY36j?=
 =?us-ascii?Q?5EtP771WlptLQv4iOVpdc743dzPoffCNG8H63NvihqwhuNM0KEt/6/sD/DSj?=
 =?us-ascii?Q?4HSKhA5EXfLdnRaCPPaC6fIZRN9dLEeZWbcnUTM24oVmwiZ3ZonnmR6DFw2b?=
 =?us-ascii?Q?Ldc5qWZqG+wf0/dwkelGNIGdBfZ2rfpCqkR8VbPOaKoteRTN9jCQULSDo0s3?=
 =?us-ascii?Q?RfN5hXsLsAV5vBzLPBnluLym3RW4S4EvrFwAukFjoN/B3qjlOPeUzab+yyok?=
 =?us-ascii?Q?Nmh/u9aRYL/5O/NhwAisdZfKLitLQad+U6wvObqmPV120eMEhpaECQBU6NF/?=
 =?us-ascii?Q?ZOhPAQyAm13vLHwui7VzwuAnyb+xAUrc09Xf/FTKU3/N2j+jPfPqUbyb3utN?=
 =?us-ascii?Q?VvpaZ5X5uS1QwtYRHw9wY16p372h8sRp69eZY3B4z0xF3G5X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d558153d-6154-4126-a9a5-08df2ebb5ae2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:03:53.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxpvcCUqAQ0Bu01VWjPmUouNMGkba4sOA8jVHBlEAdMA13IXi4mcAqAX3MO8PKZQPxEYFwBnKit8nWGexWNPQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446

On Mon, Oct 19, 2026 at 11:35:43AM +0000, Girlich, Franz wrote:
> Hi!
> 
> IPv6 routing from a local socket breaks when using multiple routing
> tables and changing them while the socket is in use. When a different
> routing table is changed, i.e., one not "used" by the local socket, so
> that the best path for the socket changes, packets from the socket
> still use the old path.
> 
> The behavior fixes itself, when the routing rules are touched, the
> table currently in use is touched, or the socket is re-opened.
> 
> I was able to reproduce this bug with multiple kernel versions,
> including current master 7.3.0-rc7 and 6.12.113 LTS: 

Thanks for the report. AFAICT, this is not a regression (never worked).

[...]

> 
> I used deepseek-v4.1-flash to attempt a fix for this issue. The fix
> does work for the reproduction above, but I am not confident that it is
> regression free. So I am attaching it for reference only.
> 
> ----------------------------
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 9ff761962..516176599 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -2059,6 +2059,8 @@ static void fib6_del_route(struct fib6_table
> *table, struct fib6_node *fn,
>         if (!info->skip_notify)
>                 inet6_rt_del_notify(rt, info, del_reason);
> 
> +       fib6_new_sernum(net);
> +
>         fib6_info_release(rt);
>  }

This looks correct.

> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index a5e955e56..b21ef70f1 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1430,8 +1430,7 @@ static struct rt6_info *ip6_rt_pcpu_alloc(const
> struct fib6_result *res)
>         ip6_rt_copy_init(pcpu_rt, res);
>         pcpu_rt->rt6i_flags |= RTF_PCPU;
> 
> -       if (f6i->nh)
> -               pcpu_rt->sernum = rt_genid_ipv6(dev_net(dev));
> +       pcpu_rt->sernum = rt_genid_ipv6(dev_net(dev));
> 
>         return pcpu_rt;
>  }

But this one is problematic. It's similar to IPv4, but invalidating the
cache in IPv4 is cheaper since there are fewer entries to recreate. An
IPv4 nexthop can be shared by many IPv4 routes, whereas in IPv6 each
route is using a different nexthop (unless you're using nexthop object).

It also doesn't solve the problem when the socket is caching a dst entry
that is not per-CPU (such as an exception). 

I need to think about a different solution for this, but it will take me
some time given other commitments.
