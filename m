Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F7521226;
	Wed, 16 Sep 2026 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569337; cv=fail; b=XI4lmYVybEFpOX02zA4RJVFXmhHeY6ZU6LY4oNXxENapYgHA24oy8ciI9XIFROf7me55pgTqcfNMy1+eVZmwCBFHhEQnxNhfbwlFynl8b2g2cw/HZs7ZxD8o/7g7pNe6sWT+kqB4pawcFCdL4Z+zOX//VgXmsEBwZaj6IJuhPa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569337; c=relaxed/simple;
	bh=hMfKUG+i3rXNA3LRvyF9ATk0LmjTUlXUcOw4TI5rK6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AnNXBd+r2NnHFk1LMsyJq4lBrxxUV9CKs3Az6KOte36+YsOeQEDLWfg2+cYbISh3GG45IVkZIv26LEQTWR0YKm/sPgaMi9xuuNvn6AibzIdGGaS+uFPRfm3C1NpTRHsp4XaKXYyJ1q3vAfZ+8/cvenpyFe8h2jn4nKluAtEdjno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k0GCrSbT; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k0GCrSbT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nopObzUprh5ojd+VJy3iI2fPV3FnLly6vEjFJ0wjXhTGUlSm0OARakm32nKtR3hb99dvzDgsbr28xb4IyzU2C+W2yIPAsqw9Jt4ZLDAcSbfPY1WIjLeiChM9CrOGwGGZZl8c/w4pi/xDkr29xtIRni0873eHxjh/+Q2LnS4cjRCJSOThdHad+cqJM27rNisiTEmfkROqXurTN2Z/swHWscZEd6Ge+Y0IhymVq18j5VXtZ3ayE8zX6Kh3f9QCr2WeSwo3k6OuLvwQ9TA7GtlQ7y7pMYkwov0Wi/Q/Uvpfr4BnXFixwl0AbIUO8bohlDPQIlHbdP4z3UjPbm2lhXYODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntYsMCRvP/Cxnib1EMT/KLNGJlKzG1Yh4Gs1eV3UUWQ=;
 b=JLowxtPX54zg6a5gAVOYFVaJIAqnpRXBmrftrRFZiUYD+tS0guUTNHb908uwu3VH2UQ2e8UwwgNoy2bXKQDZMihm8zN2bZi1JMwD37t4BLIWAGZ/KaVBcJBETGrSYRZazOcEoCiaj1W8jHTv+nj5zzJHToxrebKaXClGdWfwm0dVbd4SdeYHBqbXixevbwLxjaxGXphPpmjAqg9RsygrzkvYDIcxgoWTjUTJ+Xj2fWHMUjdUojwYT8Tg0z0s6S565rojiZ4p45IbNsME1ierizNa4iMXl10yxIMAvk0LR/A5RnRCfEwF7r0KotbO4aUSXYNhxMJ37Nbd2wsCbw9kAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntYsMCRvP/Cxnib1EMT/KLNGJlKzG1Yh4Gs1eV3UUWQ=;
 b=k0GCrSbTXquHgIVruC6sj2iwF3TCeZ0h2IotliROHgS0+n57J/HXmfnz0d2A63BB8HEIj0ZdXMjKizZYhDFtjYvX8d4p5L/Ll83ZYcxRq21mgxe3R6cIVA4E09nK7HDlfEqfczW2czOjAGYIOeLIb/ENVmGG+GSJ9oXpfSQQNaN56goyM3fzkEZoncsPFRFdpHLqof/19bRsV7UtP3f0sDQS08gwMxzo197uRdKiCxKE/0qPzOdgA5OiW8yAz+j91c3rHItLnXQDYszRo2cmHbmH5niANGv58eNE7krgVgy6ZQ7ocWZy0RQXjmb9eAYQRc7HTJ+3ciOAMFEKrG+Y4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:35:29 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:35:29 +0000
Date: Wed, 16 Sep 2026 17:35:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net v3] ipv4: fib: fix data-race and stale genid check
 around nh->nh_saddr
Message-ID: <20260916143520.GA1046072@shredder>
References: <20260916125316.988044-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916125316.988044-1-xiaolinkui@126.com>
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efe7624-a7af-412a-6fb0-08df13ffc19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xDpLU0AUZhwo+YM76asQPh8pZ6xSilizfM+RFUsr8HDQT74Am6p9UJcP2RhjshnwzJioBXIAGb/xDiA5W5LuXyObVxekHcZqQ9GoWb4hUCunYoILjTrf3MyO3hz/Ddu5kqXdOkf6Y5NcovFjF3N+ssUDSlYXeeNOzAtGcZ7ZmJSXo+RTeNkeLIupTK6eTy9lmbGh1VzIUc0zPw3EUXDy/rJOiKuONzcj6gOe0MzPzciZRz35KnwzL/ULBApNHrGTMiBr2DUPhcfH7YKFbHGLNHz0S8hPVma5x8gj3v3eJgM5tVFhZQUS4JMQzZXkRTGir5bpe8Fjsh3WRBfjIGhEiiuetBUrOGLGXtuMVKs/0gBuQTD0xCYlqFWwpiM95RUgWFW5HOgcD769rpcvTUxT2k1flnApY7Qqwyf6wk+4XPwtFfDDADGQbuSYfcvQLRDiQDnNLOlClE2TO5O+iZmBIy8CZDVrKeliFQrgBcu4dm3V8f8YUiXCXaDWbsrwW2bwiEFNh78tvWu9qOVYi3gtz8uaIAj3x/x/POR3KcO1V1Nf9SYwDnv2wM35pG8BnnBfwl9qCcvAiAwVdGzXVlkRTcVvXud3pdCKKOm3TwCrXE5lqwZLNoI3xQOzDyU76MCxKMIfJPqerxUNA4hG7rtAtyOOD9uiA83ZAja2xZd/eaM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pIOeYhWpEz0V7jhPINX/E8yIntT7ppXJEJKgc9R4TSXEvBUjj+BffVGeFhco?=
 =?us-ascii?Q?AmjZdFNRR123VdFsIIXX+kWOR6HCMjTkaSmr30plD+ZZnqATlLODuAIXKT9M?=
 =?us-ascii?Q?m15zP7UlYFkF38c8aDtrnB4Y1LVxC8yP+nPVsGczsB3+xav6GN5eKGb113bC?=
 =?us-ascii?Q?6zxXsJeEzlTewxrkboy4Fx2YJEhyqXD4YNYGe5QSGcayKf2SQC99Z0jufaPd?=
 =?us-ascii?Q?1ABLkdbEjlNm0ubXeMoyKchyPT+KJv7gbuBAQ21lk1FED23e8X1TpIdo3Yjt?=
 =?us-ascii?Q?FSfLBeiGhnI3z1Y5rHGsJK7otyhUyeXBY7LuNsGz8DQEjDRl7zzP0t1BQtun?=
 =?us-ascii?Q?2zQ4ifbk0Qqup89DsZrq2l4eLGtQCptMnHFOMq15vyQCPbLz+/BiBwoZic64?=
 =?us-ascii?Q?Z7DGdScHvvNOkRlfPN36UQnjYQNI5mPqoEcFA4xYLGhuBUNW/Kj423wGU4Yr?=
 =?us-ascii?Q?A7podBjFd4a02SL9SwXl7UgKrw3r87Fo8mqT90zzAqEmwp5yMmHDlmZKkVZ1?=
 =?us-ascii?Q?Bx96e6x/TPzMloRFIL2xOQ3zoiux32q0z702uk45iv5TNx224GchAPgZlQ8U?=
 =?us-ascii?Q?dlOjH0UeHOq9LKVnKo46vatq2FXkeFkYk19xIAlk649BV2m0AEBatE7Yuw9a?=
 =?us-ascii?Q?MqnBX2kaAPGydqZN1WgDBrigEFY+BLGEwHeejpLMyTu+d8u3j4XlIIMRssCS?=
 =?us-ascii?Q?QTKCgj0t2BF1cMUM/zrQ8ib+XVoXL87IPXcgAkzgV67/XYRQFOa7S0gAYTuR?=
 =?us-ascii?Q?dYSLs3g+pdI9nFniSVUzYGeVAw+tdUftUz1BgekdzwMHXejOYb/LGTG+2RVg?=
 =?us-ascii?Q?LaoAsghUJWVwBDNl972XBxCs1+mb86UVuH8FMhZ24y2o3YInUfXZJ0XB/4EL?=
 =?us-ascii?Q?aVKI8VWEqralQtFcESxbeO/IBUUpaa9zu9ZZNg3Vc54Z9flvDzih0BFiOMe4?=
 =?us-ascii?Q?8KpH+AhkrIgIxr0mc7hFiFVkD2Xg8/EoqveZTM83VJlCjuZaBFkGlpdT0JMn?=
 =?us-ascii?Q?CPGW7AfmM+Gk1mUbAl0lfUUaz/QdZwOzBpV1kKurXIHUJlnDA+012l9IjeS2?=
 =?us-ascii?Q?n1ubJqdJw80rokbJfmfQwvtq0eeT8q60UjuevXEYJCLhhqU0cdZO1EXvgsIz?=
 =?us-ascii?Q?DuwjunZYzbz1QLBUa6EyozZjvV+5zVD1YD00O1DLGIVfZtAqHTBWxqaGIKMs?=
 =?us-ascii?Q?/ekp5WBFeoXzEI3XNFCgOumdiMk9ENaxt0PUVibU7yje8FS0QubwFI5zHTeY?=
 =?us-ascii?Q?ntaY4ZduP3F4WTkp103qW5uiFrA5KfiOsM2jgitnUii3FNity2cmP9F15sAQ?=
 =?us-ascii?Q?cW3Igg5LmodCcQaAxlMgviksSNJEs6gT7a/fD0KZ1HWOk/ZnPIAJlOyAWRKq?=
 =?us-ascii?Q?ZKMTNsnfniawUeeUYUG5LulubTuu4FQX8zzCtHKrUgNs8jgEd78WNm1RyX9B?=
 =?us-ascii?Q?/lJZaX8worDkVt6hXP9XvGnjSSAWLvz2zanv3Hkk/PbmNUFq3qeJ22uxf/lk?=
 =?us-ascii?Q?AjW8OyBhSqMmEj0b626laq77nsbLf4LMVHaPux4798P4mNTxZMh+h9iPD8dY?=
 =?us-ascii?Q?8l29e1DvQy+2x4E2AldPp6XshYBRSd4H6zklvirDp0V6kK6tLniWH2E5c7ms?=
 =?us-ascii?Q?sUg0n6vIMB2HpMGxgFmkODi8bfI6DUVwjMzWnsQN8Fc5er95gWhy43RLvL80?=
 =?us-ascii?Q?756UhI6jbjf+F9uq65NRgtpgzoOVH3GewDPy4YpdJP4MdmBQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efe7624-a7af-412a-6fb0-08df13ffc19a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:35:29.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBflB4UrrhGPgTdPHjV0sphm2DfC2rq/OSFsFNu4yLXHSq3FOEisuyb+SohSYlw5BVRrZY0sCyMW+H7bo2S7EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017

On Wed, Sep 16, 2026 at 08:53:16PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
> source address with no lock held, while fib_info_update_nhc_saddr()
> stores a new value from another CPU as soon as the preferred source
> address of the egress device changes.
> 
> Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_genid
> and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE()
> in fib_result_prefsrc() after syzbot reported
> 
> 	BUG: KCSAN: data-race in fib_select_path / fib_select_path
> 
> but it only covered that reader. fib_select_multipath(), reached from
> fib_select_path(), is a second lockless reader of nh->nh_saddr and was
> left bare.

Nit (not worth a v4): This reads as if 195374d89368 missed
fib_select_multipath(), but back then this function didn't use nh_saddr.

> 
> Moreover, nh_saddr is only meaningful when nh_saddr_genid matches
> dev_addr_genid, as established by commit 436c3b66ec98 ("ipv4: Invalidate
> nexthop cache nh_saddr more correctly."). fib_select_multipath()
> skips that validation, so it can score a nexthop using a stale source
> address and skew the ECMP selection.
> 
> Annotate both reads with READ_ONCE() and refresh the cached source
> address via fib_info_update_nhc_saddr() when the genid does not match,
> mirroring fib_result_prefsrc().
> 
> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
