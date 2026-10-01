Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A133CF21F;
	Thu,  1 Oct 2026 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874414; cv=fail; b=ObPZoDYMMvdVWxbfTjpBW1cvv7J0/IRmIgzG1OLB+xahn45xoHNC4ZrTVZ6DtCuINCT1CtL4m390h14ERAohtsACV1keS6UhhoX07RIRoiwjOOXtVhHSN7i3lxqXB8YXmXPCDlDcH0cPnwqexfkgPIhagdAV55xoqrUMln6Tws4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874414; c=relaxed/simple;
	bh=YJV/Fvq0IH+U2H6s7eJOkrFecaqz7NbG2GZ0vEOX7Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NruyFSkHZ1+k1thwjmoLbmIeEmUwZCzFPJqs2/zjrcSCQsvspM5YjBl0okQ3DmnFmTcKHyEboAwrKlikBujO50pfm++NzSt5McR9FcHqmDOBtMfS6CuXEnc58kwP4oIIID+DL6S05F/Ab39++9i+/gkvyiYqu/93KmdnM4Xzd9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xbj5RPLk; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xbj5RPLk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZm4BmhpryZQri7TidijRTLlZTBvxCn4lostuujDwRTeKhXS55JvIKDZ1d5844pjL+eTDS1GJlL3MShn3G2/1ulisPUfi86hKBngIpM2vv6s6PGtylJyCjkEXiy6OunkhmB5pIa1OXSliataB5Xn+RWdIJMZCD+4/jiEKjvB8kW1BF2gYCxZ92uIJ42dk7Mkh9JBJ4HWB8RfhxNvXuCw1Qo7Xl4/9wj1yQGwfg7t/87+LCtpCo7qu6URmFpcIA520iBZSEABK+f/cDwFWVfzpoDCooL7XuWFmQKYMO0ZVULex/qxQKNHMyLGiPYVJRuXtZoq5/2jhKYKv9rjWd3reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA/eMRdbVovtYpJqx835jafVxAuAtbu9PGUkhBEJOTo=;
 b=N6uSEe+FlDeW60gPAGZ5y/QtCG+Va0TVkfs25cFK+2NJOh88fOZ7gtMPeF9VYI30aBwNTdV0cnd88zOZH+FPQKaYYEFiNyYQVUzDPcslihzw9n2xPmaBEm1SQLSkHWKWupeD35mOWFodhDrV00P7gCd6lwWTj8I3ku2Jk58KrlQyZcvf5fmYW3HeYdq6XatAemCW0ItgdTKCWzWdUZ9jlFvBeV/wkI1muQI+Aq5nrAP65iUW7B7Fo8LyqgOGVSrugXzZw55p/xu4/UYOvnxi87L/8msRDFlqqgldn8fLhlOaYw8M1fDFPBwwtSeEiXzCQw2osQfpKt452tV2Uxun+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA/eMRdbVovtYpJqx835jafVxAuAtbu9PGUkhBEJOTo=;
 b=Xbj5RPLkfm1w7sBjW+XzizVU7IMZzkSpPEu2pbe25hnQCSGy2uK/HaTyJRKq9l3+XsPnl8qzMs18167+bQMlHnvEEPMcifhxuoDmTvJSmmTShvbbE5jrWJW/Z9DFlavu/ay5ZrAceMJLXQD5+ChpZoO90szxwvkGTJGyRl92sE8XjIMuPx14xTP5ZVWuW16LuSkMuyLNiGclRsLnNzAK9bCBZAeG4siqqtVLTnQZlN0ZZz1JNfhZPh4MwBQcLq6z/jHHbJFD/Fc7KFfbQUGIE4xSEjcE7M15gLAmzMJ6n4lJzVgpGLr4kYxvZLHMS+lEvgzMYQNot7oJaD44yyYYiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 17:05:31 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 17:05:25 +0000
Date: Thu, 1 Oct 2026 20:05:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: stop PMTU walk when nexthop group shrinks
Message-ID: <20261001170513.GA1657889@shredder>
References: <20261001010550.2742297-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001010550.2742297-1-4ncienth@gmail.com>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bc8068-7291-4eb1-3851-08df1fde2f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|6133799003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OnngctIfndKZnjFUnupMziM3yoo0oAJHjJfjNm0Vh9UF9LOZ2rQKYcCKWlbUWskXcTT+uKJfZd0pHkpIX+9FjhMOuu3N9Ph6QwlqVi0pihz7e1PilxyjzgqmhHJjHxuqov7obolQzKNMA445T8oaav5P1CXLdGb0VYvjngdEQH1d6vPJrl1vb7gfcQbu0OHK3TSep/zjKFy9Ru98ie88GAja0dlRf3ptrrEWQXFkmFoMsc4XRvJFZACZNayt85r4nZCX9t2BNiFW8vmt3yDedeogL1TKOTlpSphShura4uUTc4EFZwJmIbMa10Ihiy5KGuPA+hwOKbR5SltV6G3EtvVvLIlE7KF9n85qfRPV4ga3mnpSRcTHNYCLQZvI+AzYDZHdzRrB50+xaC6VvUKeo+cXPyfh90QDgmA5W8LMfCNNkGwJ6Glkc4QIUwofsdhWX1DdmdUYPwx4yZ1ckG0xgqkKDTiSoBwZ+Z00c9O2Z6gbRLTKcKPN5EcsPfoLhlQiqp1WIvqOb/Uv4MCTi/4hmCl0FrNhy51ZjxTKEEzNPGwlRa3FKM924oB9C8ZUeUyKkvrY7HvWNlT8EM2iwvW20IH1KaG6F4HPG2aLZ8SyuZUCw2rU4qEiUMbpK8m0DW6gMsv4B0GsrENc3CZL/ClAeJA/i8iiaSQhpvOKnyReuAo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eakmUCqnw5Xoc2G7Pfp/gLqLUO1mmDB1cqqdI8z/nz3iBCscjEOL3tWeVoIw?=
 =?us-ascii?Q?TJGOEFoznw5W/plXqWatD3i5vUtsFt8T3jGjlU8f4kNB+4nLBD9IaDjNUuuc?=
 =?us-ascii?Q?dt8gFq45VZsxIG/VZ3WQeiIjUr+E7PnDwKVVxNOd/yhSp5Zt69RIx/5nlsfH?=
 =?us-ascii?Q?reHbk8LRSSPBRUVDjM6shWEVoQJeCrMTEsWKLN5yobNzL8BbnUt2UjoI4ku+?=
 =?us-ascii?Q?Q4FUNr8+VY90iYCIKNXSWHzV7naGOxeW0+crWGbOt9jChsj6M/b8xqbW104w?=
 =?us-ascii?Q?52Qkh5Jsi3Y9q1L5qdo2AvtFfN0gLzobVdEMzIuUImnZQhPuGHZa6f/DYX0b?=
 =?us-ascii?Q?4bLKXOW+4zQILUzn/RTthMmE6m04B5jelzrIMuCP4o+LENDyQ4zDDc/RpOMp?=
 =?us-ascii?Q?amM7ybSzHrMNhfCo6e3pjKudt4S5l9gqOEP9peD+SavnGDr4s5DiR9S3ROuo?=
 =?us-ascii?Q?hCnWWCdoZaLmIYl3x2woOO5m9Id4nwws9610F72c0+x2x9dQfYYGV0DPNfQs?=
 =?us-ascii?Q?SceyBIeUtR7LJ9DIi3uL7eCKWECHFR8zwk+q/wJa5rIWlNdPE6II4P+eK936?=
 =?us-ascii?Q?WBHllG2YdwPp/IYPEZQpsFBSY7ncGdUuBaAN/hhdMpfEFfhxvXjaFanZBsie?=
 =?us-ascii?Q?MxGiwCwgwlt3Zi5T+TzYzOPsT9d9m8mj4c2JVeqxNS2mOGCh8e0pHhdJtXqR?=
 =?us-ascii?Q?bZtGBNUEhhoxtL+UsVWLLiHs70e+bk8I73nK8+sSJg/7Jmm8VO1l6+Sch+4/?=
 =?us-ascii?Q?ZXBbbbagUWa88XHxr8XR1lqu82Iwn2GsRiglFdSA0/vbk3RBGPcu974nd1Ms?=
 =?us-ascii?Q?S0IxKxFJQFoWhPafOPwT3KZVZGKuBJsO4UmOYz3Uz9ob9aiBMfkekGpYAJgH?=
 =?us-ascii?Q?NxkLBWG09kqr4TNh9bcxy5DrBhEWJ1Als/G6/7vOhqJYw6e0Gu5fPH1Tip90?=
 =?us-ascii?Q?ZuLwUh309qgGriyXY2zFrJ2XIKWGr/MjcJYYlfcsoK5R1PK7/mfkpyNPwUix?=
 =?us-ascii?Q?icAcMM7bDdHh+cOyl/FUKFIV/S5JFO1MD4w8W+pFcX+zFFU8QiQ7KuE1ifEi?=
 =?us-ascii?Q?+hm2Bq2VIk5piYLYTTiZgVJNFFJj/5b1Yhywnek57xBSDZCKW14sTiOyCLOG?=
 =?us-ascii?Q?mnQqdBJSKuY6a1BB3212kBrUI9tQ1LcZwkYu6gavq/LbXf+ARvARSQKBYZn5?=
 =?us-ascii?Q?HDZCv3CIIKNlEm7uJzwwe+XwF0yTerUKAmyD7YlAT2o3KHBjaSLY5ADggVCN?=
 =?us-ascii?Q?xG2JfN6VUktsaV+NL5uswKVvDsQPYsKsQDYIGuwDMDv167Ypnv9ysqlZ6bEV?=
 =?us-ascii?Q?xw4DbUzAzHgX9OInZcLEeF4zWKBeZzDYn6DqsytTxgkcVcqDwXyesTmBYVcV?=
 =?us-ascii?Q?YI2F2ipAoqe/W5NwbqUbFAZVq26jpYdU2zOiPL6blXs255gW3p4wgh6ov7LQ?=
 =?us-ascii?Q?tajYU5Z42C6rTz6xDO1KwJ+kBSpRHzYTRZqw+MG7wmrNi41G+oMbQ4rXpjvb?=
 =?us-ascii?Q?9bIj4OGOI1CgMDkU8Z3C15Y80L9z6aX12FxjVWYpHA0jkGWf2Zc1kdReOyB4?=
 =?us-ascii?Q?EeUGYgTA7tB0mTq8X2A9a9y4KK7mvfM8ZZgNrnAbwpV4FJ6aXaAtuXy+t9hn?=
 =?us-ascii?Q?vEPpoN72AE33+wNahjBBkdChvQl9TijBYTX4xs93Xj+utfJtfcAL7J+aBV9R?=
 =?us-ascii?Q?o2EmiXFXlUfuiRSm84n9YL6wepF8Yz2A9ohYdwrYnWO8dk7mmBQCo78ELOkc?=
 =?us-ascii?Q?edfx1Jh2Ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bc8068-7291-4eb1-3851-08df1fde2f97
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 17:05:25.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeDUD6IjMMJSbOUcD+p959pXJF/uH2mx9eR5MDkclVpt9eSo9UACh1nnbogDWLHwVJqtwMhPRl7SEfoBT2ZAAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

On Thu, Oct 01, 2026 at 10:05:50AM +0900, Daehyeon Ko wrote:
> Commit 7d3f3b4367f3 ("net: ipv4: Cache pmtu for all packet paths if
> multipath enabled") made __ip_rt_update_pmtu() update every path.
> 
> For nexthop objects, fib_info_num_path() and fib_info_nhc()
> independently load nh->nh_grp.  RCU protects each group's lifetime but
> does not make the loads observe the same group.  If replacement shrinks
> the group after the loop accepts an index, fib_info_nhc() returns NULL
> and update_or_create_fnhe() dereferences it.
> 
> A deterministic probe only widened the existing window between the real
> operations.  On v7.2, an RTM_NEWNEXTHOP replacement published a
> one-member group after the PMTU reader accepted index 1 from a two-member
> group, producing:
> 
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: update_or_create_fnhe+0x45/0x15b0
> 
> Stop when the indexed path is absent.  Groups are dense, so no later
> index exists in that snapshot.  The same real-writer window completed
> 114,423 PMTU iterations without an oops with this check.  A reproducer
> is available on request.
> 
> Replacement requires CAP_NET_ADMIN in the network namespace.  Where
> unprivileged user namespaces are permitted, a local user can obtain it
> in a new user and network namespace.
> 
> Fixes: 7d3f3b4367f3 ("net: ipv4: Cache pmtu for all packet paths if multipath enabled")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Please check fib_dump_info_fnhe(). It seems to suffer from the same
problem since commit 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU
protection").
