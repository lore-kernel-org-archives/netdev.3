Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00351C2AA
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695654; cv=fail; b=Nzunm934v2Gqizn5KaeBid/4pxHwykh1APrznpyUnwrSB8Jg9aQG5FTlg04DQ60NFF7LxFwvv0tpUFfd5wJ4De9pSD8TcjDUnhFEb+domAV7bleTfly12uyB0/HCssyyWZvKPjm+KQDfqugKt1tlvAwQ++bFTU+joR57F6xjzOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695654; c=relaxed/simple;
	bh=RWqIdqbx4Nyl6pWVw+42XgVOD0mCSFmZElPOUQGmXhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQHRuLdsW41qY/SXlwAyNL3a1sM0tGrWHwJVFulF3LTWnPVAHMlljvQ22VskETYaOhdpcCbExXY1TaR4jrHajcFdCfg2siyj7FY2lRJbqmeztKOOsKg6jN3+c8/guyswZNeRymelumk5dufH7BHw1a6IRq+apCIqOdZJKOWpjd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPpk2yS5; arc=fail smtp.client-ip=52.101.56.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPpk2yS5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5SoijFeRhhYqMxGOQqs3Jss6GIZlAfdZ52OnL6sSjmFtjuxeRdNxtJY9tCGHf2ORAJW6AT3SYdEcQEBSM8h2SGX1d2WB3/ZN8GlMtYM8tr4gxEfRuCcsYCsuUGULxiNCe7mx2ykOFwt4u+qg90PRXfoE9Bv7HuSeIXIWdnhx5hg3YCP45AjKjHDclCXLEM59NleTETt/bUka0zFKqo+APvGLnUGVQwHCT5/kcRYEmtNEvVL9RCHLcpURJX9EusXkZCZOu20Nr/tmeNDr759PJ9tapEPcVH+3uj2SYOeAb3ZClmlZUnbzQ3JgWze19/dafOIv2DzkyadkywA0gu2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zKZOCzKxrtkhbbgaMK74ZUb/QCEiJljEMHMsFb4bK8=;
 b=fVpZqLeGME6a9puEQ3OoIkAeVdNAASqYXo/C6XqF10bbzcYeNFUhSF+oE2CNxQdihtTfL5HiENhuuQhl0kTT6K6QHWDEWPnHNeVmLkcxr8wTkVNxXKl/DX9YYuhUeh39T2hLILrO4CASXQSlHm8GPY5v/pEKKPRr3d/RlVfv1Yv62sNsIn3Ph7NCUaYCuYPUUIkk4pVqnNx3mHY/i5r4JPECKxNR/BAIAKg6zlrDizQIWZtO1ArRCzA4USS1etByUGqQyUs+Bbd2XWoJ21ILRVb9irmdPcP6yZUQrlv0HQ7V1+XOkeg8Fr4OEREXZv9s9ZeZN0FQsf65hhAWItcsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zKZOCzKxrtkhbbgaMK74ZUb/QCEiJljEMHMsFb4bK8=;
 b=KPpk2yS5cAUl4EIHy/0IFbZIrnocHJHK6dnTqnPEow4LLTEXteq77OVdJ37EvvP+KezwchhagtS00eQRGu/I1DhJPz3BQ9mTWyDMyWK017lGiUygHbjdHuEEghSmhzKJTUowMQ5adlhe8P0IxxjWlZOfpf4B2cUPepyZInEk2pMdza3AipNuqwWbJomFaqwPrzR87CorRJYEJo47sncOb0Q/EZaViEaBgkCTDC7FDistCsz0sQuvKFZUO6R6irllUmD/R8mcVcuPVftDaPWppwT7VuqjhoEvDDDtPEa2PsL0OKTNCx5zNAybQX8s2pd41n7AoSLBMUOotWZZce4onQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 6 Sep
 2026 11:54:07 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 11:53:59 +0000
Date: Sun, 6 Sep 2026 14:53:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Naman Gulati <namangulati@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ipv6: null-check fib6_node before accessing in
 __ip6_del_rt_siblings()
Message-ID: <20260906115348.GA247919@shredder>
References: <20260904180645.706425-1-namangulati@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904180645.706425-1-namangulati@google.com>
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d4e468-8d48-4164-8a5d-08df0c0d89c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	cEwf5ExOQ4c8RnlIxcuYzEXEcz4F2osAp8yfDujwvbg4vmLV8z6NZ2n9g4EyRLVs3Uuj+jvrYIhySC5/tptzr7bA6wEDhp2x58y/tysqSZKJz9EcGG+u2BcJuv/mbZrcwQ28SgFgLuIROcxW5PYwbJGWjv+06pFwVCQrViKuECHxepRj0cXSt5AqNXOVlGcwNFQ1sZLr0Pcc3FHfGEQdph9JKwXHgPEa14Vcdrjb5zf1JnVFVcI6QQoAfmxVRDvlUcrsqPD0uJDGWNY7TMHvqhvowVmrT0ZMa2fDDKve68yly/NRtA1ISTAVKeZhUOgko16S34W/X038dEl4pgEVeEzosv8XJz+/KUAY0uX3WnlzECiZ0aNxjtemApukQIBVF0mjgFrOSMoIAARrbYQ3MA9NWRPt/+WLGYO21MxcapMC6/eOzgDTP3sTYKO2dIi3S9AN5IKIEGTo/zOK6jWq+RCZfMOaytj2TaEsqJZz1LkhH3Hk07su+X3+9/MBv3lKy9ITELvJdf9pnbY4u3r+PFCEDtFj3N6WYlsLRkqzw/0CoDj5fanUR3DzoETfYigEYIngLawo1DB9ZboGRpYkfIQhW22XHcuRJ7+Dy5lwmqnzaorLrP1ib4TVAds2gnf8ej9tD4Myb6RZPBHRM42XYqLuo+0MkiGKc8YUINKLKJU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gnsYiUYa/hKztFs2H17tKZWKV81PvX2mMNkDeBfRKqPoyORFhC2v+F6BixUD?=
 =?us-ascii?Q?NYkJj1zWBLhq2lV7Yugh9MgWzT6L5XFDmeJFSzPBA9iu6ODA60dV8X9+tx5P?=
 =?us-ascii?Q?rMFUYwFVGZVFw80+VZzd80fQ2oVy5QqKdxI9vHU5pdA1ia8W8Br4muiYmkFH?=
 =?us-ascii?Q?/Rp53CZ+Z8M4tABC1PjhWwTBv2lWqXt49LWpxmtAAgNC9mrhwCa6hnWtHPBy?=
 =?us-ascii?Q?UYORj4OcmqCxIltWKjtgi9Wcm4NmtJlP6oHSJinTutBjK9wx/HYDyU6f1oLD?=
 =?us-ascii?Q?bY6eNiPlxZlCgbCLguGOO8nh1hSeSDulxTK8cna4HIaQD1vlkSeHhnCpuB3T?=
 =?us-ascii?Q?2ZOmSRq17I41nH+fK19pDBQB/Mr0fW8gAAqQ8j/R44RauUrym2ccMdyqdVcp?=
 =?us-ascii?Q?BOUZBdMK3xky+Li29d/ASaIIYG3L+w7ESOrckbLe//MTxLPgbe1/fPEZiCZ4?=
 =?us-ascii?Q?hGsOEyQBJwSrEp2cTzWI9V+mt+z+dS2QJagOmMA1sOb0gNhWF9PurF6pGIvS?=
 =?us-ascii?Q?BVe3DBiqo9Wf2Knn7ro9oF45FbPsffJZPVoKZSzEUf2FJc5e+dBMJ0oij0/G?=
 =?us-ascii?Q?w+psjnXdYcrvkWnleDswcvKGGsbMhLDMsZ34LGhlTNogkjGxi7YuqV0TpFEL?=
 =?us-ascii?Q?AjUdRgfTMNsnmsFbWiGo0WM9wnszw7ix9BqNi9V3egyhfxajhUk/p76j21L6?=
 =?us-ascii?Q?lC9ZBFeshcujjO8/HLbX5+0lGLQtfK9lc7WMaKCKg/dVRUBYIxAzcHShhu9c?=
 =?us-ascii?Q?9DgdBceCbYY+eC7/cuO1gL3QlzTkCvI0RjaiFL95ltQW7v44u9kSo0Fd8unO?=
 =?us-ascii?Q?AZYNR8XiVHj/2d3RiCzyL2jLV/c88xQ5VCFtUKTFBu0uSC0cz9TrlgWFxsSz?=
 =?us-ascii?Q?ldvQZ8pbTCAWBBCc1bRtTJwb+x2oyr0N6xW6gmHGReEA9tzQBiMPqUv3ernt?=
 =?us-ascii?Q?LkUSjdeJ9Bs3vgaz+GIvr//3S2yirxWd6lmEbUL2gJvtYnAZhRZXFi1suuC9?=
 =?us-ascii?Q?PLeHkrFTacCF9BeKrYiTWPXiMfQGz4zNDpEHz30R6I4ciMRcfy/jncLELlsK?=
 =?us-ascii?Q?c0hKhrFoN91QMvP5nfEF8t5E9HgpQQ3U25AvCisvfkkjnWFYbtUiCN4TuBIh?=
 =?us-ascii?Q?MXPR8bv20AD2dhEObN2pEFqcpybfB4fiiztSF9lHZMgc5D7PAcOizKO2BFpG?=
 =?us-ascii?Q?smcRoSCpDq0fEfJw7KqX+uxhmVJwkfnM1/AnXM84/Y6Zgf53IvgMAT1b2TM3?=
 =?us-ascii?Q?cVvz2x+/clH8aTCbS2O76XU66x+Krtg5+eeB6iypzvx9ERNIhQOGHKTPYpXq?=
 =?us-ascii?Q?QHx+0GW7SuuHVb9EbxGcKkiyplnViWUl8SY3RTOvTefgoZdN2lYnOVXy8i+i?=
 =?us-ascii?Q?VyxJWqDac1IhtzdU1wU3v0jRSWo4kXZaBdWNz+Z7SiG22b6XKxIDlo3vY31G?=
 =?us-ascii?Q?HhpjwAH2qzRQ2LOFvAT08OJL2ED2rd0Rywy3hIpVOoFDKhHSOGhn+FvVpI0b?=
 =?us-ascii?Q?yqjH6tR/y4U8iLsTBivm5EjbugP/dhkkZDXQCGgwkzLFtCUBUweJgPoMftP4?=
 =?us-ascii?Q?pe9fjuSARbVKWbNwdOCxzPW7v3Sq2pidXXyHKp1nyonTym4JvZkLJYgdl7rH?=
 =?us-ascii?Q?iBMPotwRCxVPZbx2l0inlAJObovgz5AzgK5J4cyPvrvn5dApZfQ378A3TL62?=
 =?us-ascii?Q?ZreBSvx+7lCkXGv5ZCmJjZP+8YM8mUsLmozjzfus6VM7yFTt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d4e468-8d48-4164-8a5d-08df0c0d89c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 11:53:59.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfsoeT6ecKWrUwgAEZbKHJAESF0lnblh81+O/Zthzscio/x4LS3nHAyVqQa/qp960/M0q68ZJTcSmYl9++UaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

On Fri, Sep 04, 2026 at 06:06:44PM +0000, Naman Gulati wrote:
> syzbot reported a null-ptr-deref in __ip6_del_rt_siblings() [0].
> 
> The stack trace hinted towards a null dereference of rt->fib6_node when
> fn->leaf is accessed in __ip6_del_rt_siblings(). With
> RTNL_FLAG_DOIT_UNLOCKED set, inet6_rtm_delroute() operations run
> concurrently without acquiring the RTNL lock. In ip6_route_del(), the
> route lookup happens under rcu_read_lock() without acquiring
> table->tb6_lock.
> 
> Between ip6_route_del() looking up the route and __ip6_del_rt_siblings()
> acquiring table->tb6_lock, another thread can modify the routing table.
> For example, when an ECMP route is replaced via RTM_NEWROUTE with
> NLM_F_REPLACE, fib6_add_rt2node() unlinks all old siblings and sets
> iter->fib6_node = NULL. A reproducer was found that triggers this [1].
> 
> Add a check to ensure rt->fib6_node is non-null before accessing it.

[...]

> Fixes: bd11ff421d36 ("ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.")
> Reported-by: syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a9b03f9.04649fcc.10325f.0003.GAE@google.com
> Signed-off-by: Naman Gulati <namangulati@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Sashiko-gemini flagged a pre-existing and unrelated issue that looks
valid. I will check it.
