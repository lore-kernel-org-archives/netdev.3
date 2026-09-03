Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FC4AA596
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439636; cv=fail; b=tBiyBVbGo+lBTZLUC0EyV1bn6rfGSd9pT+VdQOfK337tAlHl56iScEHO8sK7SiZRk+vuv3vWCABLCcVfo/pmBneJUn5TO6IY1kOE2ZS+NHz48GuuDph2J9oKGCfRVq8jIzfutAbY81g0f5c+4TcnBqLut979Hy5WxW1KRsthlTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439636; c=relaxed/simple;
	bh=wx6d2bKk8y50RWO5r7kJRcNU0nvO3JDr7PczjJ+qgfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YVbgBC9CBsx5/iekpUD1sX5VsGC+90sj6iitJrA2BM25ep9J1Yc/+7m1Sqd+VXyGUS6NxnNDkexQKt62HflkiozBX7NIiNN9X2TpHGZ9DWk7GzDbrJ/57IPIPjdmCSgPJRPL8Lp07PtbEOr+EJtb7VwdefkUE2dRrlqxkDZXDHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LFHBRE1W; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LFHBRE1W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz/DxrPIGHvp5AY7UrWeORZamcitNOFsquFQbDCwaq6jZmU/wSS703LuopYXxzyS/O3hFxwifFeV4K/zxjXzz0DrXf4xa49n5/I2pkogRVVErmV4LgMw/6daBU38ra5+8zsn0fxnnIThEaaAWvWWCxc9za5v4RrAnlnYotest8SNLdNAKGfMU6gNMHqPZHx/+fFJAwLWXuscvHGZ8FB7DvywL/8/N9ZSaDeLLZhxf80L2bBdrauQzA11nxUtquPgEzpVjqkBZkTFYSFZH/lBWR8b0K42JF//AHF4F/fP4SZaB2/WzdWuFVAQIgMH1KCqW+ZKD3FolbZq8uRWaJkQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaU1lFqgAmimwW9w6fl2Ncc2g7DlcC+uO/mXHM+mfHs=;
 b=RiXyGquRXtyj5D0rzoAM+zav2iBP6E5W568h22P1u8VfNHQvNRFv/Zo5+/BF76LBA8BgFdb2CBf1Lzeix0CfTL8CrfC4qbXK/wUQj5AouVy7k0j/RDpqcBYP0LIieFqzZqR0qwtPkm1VK9qvyOlGLDoskfpLrWxyj4AmAdUg9/RSdZmG6T3MndAsE46Dv9U22kn4TfLxlQDhrEkmWWOTnF8PMwz1iu64DCrrf/COjs5JLG08SdP03DSmjxNA40sqn6X8KrIUdxbvfFWfkY2EbrnC4X/4aQIwUyhqmj0wV7ZcdfrfsFWbVy8TkvLWocJA48MGzOyze7iRMgRh8Ykjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaU1lFqgAmimwW9w6fl2Ncc2g7DlcC+uO/mXHM+mfHs=;
 b=LFHBRE1Wybitq7j72mJp1a819BD1xtXQwivKfC0ENRtxR8MIGrFjyaf/IDAeJa832zXkggU9xOHwkXdGaQ9EWId1S/EiDvCuE+DFlIJ/O0RIM6hxswEoDXdGv5CrV36ZOgWXXExvREjbbtA8IK8PodV478zwfo2mPZVlFiafvJMwjSjC3xQgQeyJTSx5AYPds7mJrcMP7whECt9+iDWAyqBc+cq7g6iPJA/gxPBZIrFpcJ6f46nkFDByS8Qhwx54qwSTwWcHykumGoApdLqfaiNLeZuMuvxd2T4CWmgBwJlexX6yxnwmA91JYxEJa+Jj8UoSBt1nVllcbGTKrj6Uog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:47:03 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:47:03 +0000
Date: Thu, 3 Sep 2026 15:46:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v6 net-next 00/15] neighbour: Namespacify arp_tbl and
 nd_tbl.
Message-ID: <20260903124654.GA128168@shredder>
References: <20260902203722.926528-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3c1c74-d1d4-4202-0d15-08df09b9741a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	n1kF5+AgeVIOqiSEZ5pqfFBnEEnXhKemwh6LQEWvf/O1s+kDVIVze2MxTIFS8zuQYienH7ODl8K4gCF9vOgUvgncYdg2Fla+D5Xq35rD91aMspwQLYeReIeRZT0Z/Ns00/A7qDqkKcWDut0oAH783Sk2iwQVJeX7GN7NPR5itaBBfCWZowGknMLFtdqKkr1hdX+f/Jaqqvw3PP3xxXencEw17ZMmA5cYeYYHHZkt0UnLj8VQMMkNvA0XZKvLEB55vhl7/RDOF4Z6GC6x2D2zquGj3Tk166hbR7ESzBWhXq2w/TrlsXPqLw2nVaX6ElIW/DToyTst8gcILIoT3wOQs4IpLau3EhvCczZYLS0iLBf5bPJvxERm5O0tK8sevNcGjwj+I8vynVFywgwmzrHS6anJ3HutJAWH89cVtfVDz6DC8caJQoRtlQJrTmqJCAhmbfT8KEEVFK2EspGbr9rn39DkJKLq7+u/1nanirCrWyolD4Os+uXvyQ2n8hjZYe0P9/lc9pbZn3EPVltn7FuZX2alA0uuQJgVIkJ9wKss2V+fM41TGpSSJ/EIfb5+uU1i04YA1QAyLXzEf1/gd46UQG5zhHU5rfoLZXhDkDcVFApzQbPNtHkDmGPo1Cf1tkoDwCjh9SdImVpXr+nQDGksKsHmjVTO82wAPJhLSxI5JOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NLYWiJmdZeXHNP33Ca2kaEzJyophigVGoH/zY0GCKWsHP/Anyq8+1A3462Hh?=
 =?us-ascii?Q?ds4qlj0pFYMbpeu2XjtKC/oDl7FDCDK63GAA5jk1Guh5L69Uo0Z1fhdKi2AA?=
 =?us-ascii?Q?v0Er3CWP3GpSGnLM6KpojYqZktdy0mIkuDXaqvnlB3m5RCiOCe/Mt7Jn6VOL?=
 =?us-ascii?Q?X5dmgjn+zLDEZ4u/x2W/C/5E5zCq70W8RjpRd6B4rkgduE7Y+i1rq/yn6kB0?=
 =?us-ascii?Q?zj6wwENihhM/n1OwTmnvOdZ11Z9n7JvgaVe7aHiughCg3aRMt5ViG7zgWlha?=
 =?us-ascii?Q?yR8UIXH/pNLJB4vovQaG6r229G3T36FYCOuA4SqAqoLGWkr81BRf9SpbOWbG?=
 =?us-ascii?Q?HfzxV1PflYmXrQYKu2qDFaICCfHeN06m8Q2jHbXMWDPzIGUctUf8Af7KWWMV?=
 =?us-ascii?Q?lZ+HXNYDoxyP0LvTMIeIJsEkbM/n9RkcgI+1a4HItnsQ2AEiONYdwYtjj1pa?=
 =?us-ascii?Q?vWx8650SkKsdt9DCiPv5j5Cr7ElF/6LBkJsqgiGJURt95nW7REMKfTj1NkCu?=
 =?us-ascii?Q?iucbjMsgD2W0e+6yvDgkQPc56KxBTa3lYA0erwQdxJIYtz6KRXvBq0P1+aBq?=
 =?us-ascii?Q?+KA/Fy+r++65lYqUF2bjTk1jG35sy5+pKoHIpSF7R8a1fkKT6iqAoIH423iE?=
 =?us-ascii?Q?Mwi+k9HtcvHpaBSltp9IHcoJ7MHDdN63yXGKM0mdpTVw2+qdYm6aA+tI21GV?=
 =?us-ascii?Q?90bNjDu7P0P/L1DmtdvKDkpP7QCfyxRjuzIoE48GFLVeFizcBGjx7nseb5lG?=
 =?us-ascii?Q?IiR0MAJqHuM2nS2M9DsmYTmzAGIuB/jYrNiPlIk5tofFHLet12btDReN9Aws?=
 =?us-ascii?Q?lezRJKQAX7YmNIgkJX8b0bcFguQbA/SVtzlXRrvXf+OkfrjmCo/lJzGdU6EW?=
 =?us-ascii?Q?fcqJr2f3XGwza37O0jKQBTE2KUZslYOiFKGGvq6KGYleVGFV2agznwdSBQxE?=
 =?us-ascii?Q?gALdqSY4NAMP/MtQxLU7kDLUxrlXfvwrutaH2lRuEXEmYpseZeHfZrs9DaGV?=
 =?us-ascii?Q?w64fPwts9WoQY/AMh83VgjBxSXHfyjiKVde1A//1qUocyOREb1zdYVhtsl/E?=
 =?us-ascii?Q?eViGK888HzR2CaFqFJC8TQGV4aYCykucOoxLCkr16MjrA+RF7k2qksT1kUY2?=
 =?us-ascii?Q?wKyO34uVdz3PZwM8Q1lBtzSy/06L7REgbBIUkF/FqaTC6YpSk6ahBKA/Aj7p?=
 =?us-ascii?Q?EfoNUAHdV6dYVARUb1QHekAWos6xvM23wVhztn0Cg8r8OYJDZrv8IVHiGJBX?=
 =?us-ascii?Q?u1uEdH4Cymgd2OXfbQRRGkOYj5V3KcVULzhodTEVCy8+u7FxmdOfaT0IImEK?=
 =?us-ascii?Q?0ThyRgOszIlzWUa49OkUqLjv0AWwQLmje+vLpWkUpf34x2LyIMgkz6vv/Z/o?=
 =?us-ascii?Q?cK+5sHmvNLyVVtrTsfy9AwBD56fhiAjWoKkN1kemRjBIvuaO2TkACEAwwXCo?=
 =?us-ascii?Q?PdqxtNBoVQcJ3QabncFSD4FehicVIdTy+8L5U5ZvctgzQOtnBh4v6Xx5ga/G?=
 =?us-ascii?Q?v0cGqbszEjOKDszoIB2z3vcacdnTPZws2NxjgfBNcsQmCr0nOGg2ujSWlL1T?=
 =?us-ascii?Q?snaWqkANwhv6WZmTnS+J5V8B3ht91bhAFATiOP+DLdokHAzJyz+JlF5auMP1?=
 =?us-ascii?Q?XMkoDHT3+kNq1rqMj93y3JdgNutdY3RrUAQCmMoMphB9sUNltfKep50hjRL+?=
 =?us-ascii?Q?SABYdjnb1Qa5F94oGF6nNcsuesWmKvLPBQiK8olYBdaYb4kT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3c1c74-d1d4-4202-0d15-08df09b9741a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:47:03.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM4PoFrKxPrtq8Nu1ycNnoKk5HCV/CAZS8r0KzEjDFUX+1QvezkD5DJhIL6lhy+QAnxDZc08L3Glep0cQ2SBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

On Wed, Sep 02, 2026 at 08:36:41PM +0000, Kuniyuki Iwashima wrote:
> The neighbour subsystem is almost ready to drop RTNL.
> 
> However, the control paths are serialised by the global
> per-table lock.
> 
> This series converts arp_tbl and nd_tbl to per-netns table.
> 
> With the series, /proc/sys/net/ipv{4,6}/neigh/default/ can
> be configured per netns, which was only configurable in
> init_net.
> 
> To avoid potential regression, all the settings are inherited
> from init_net by default, and this behaviour is controlled by
> a new sysctl knob, net.core.neigh_inherit_init_net:
> 
>   # sysctl net.core.neigh_inherit_init_net
>   net.core.neigh_inherit_init_net = 1
>   # sysctl net.ipv4.neigh.default.gc_thresh1
>   net.ipv4.neigh.default.gc_thresh1 = 128
>   # sysctl net.ipv4.neigh.default.gc_thresh1=129
>   net.ipv4.neigh.default.gc_thresh1 = 129
>   # unshare -n sysctl net.ipv4.neigh.default.gc_thresh1
>   net.ipv4.neigh.default.gc_thresh1 = 129
> 
> If it is turned off, all settings are reset in the new netns:
> 
>   # sysctl net.core.neigh_inherit_init_net=0
>   net.core.neigh_inherit_init_net = 0
>   # unshare -n sysctl net.ipv4.neigh.default.gc_thresh1
>   net.ipv4.neigh.default.gc_thresh1 = 128
> 
> Series overview:
> 
>   Patch 1 deflakes test_neigh.sh.
> 
>   Patch 2 ~ 3 are misc cleanup.
> 
>   Patch 4 ~ 7 store arp_tbl/nd_tbl to net->neigh_tables[] and
>   remove the global neigh_tables[].
> 
>   Patch 8 ~ 9 replace the direct access to arp_tbl/nd_tbl to
>   net->neigh_tables[] using new helpers.
> 
>   Patch 10 ~ 12 finally replace the global table with per-netns
>   table.
> 
>   Patch 13 ~ 14 clean up unnecessary net_eq().
> 
>   Patch 15 updates test_neigh.sh.
> 
> Note that some buggy drivers access nd_tbl without checking
> disable_ipv6_mod, so nd_tbl's extern definition is still left.
> 
> After this series, I will follow up on two suggestions by Ido:
> https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!
