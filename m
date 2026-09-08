Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB147A892
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861939; cv=fail; b=HwkNIEGpsQCw3is70S8M5XDe3SJZq4wDfc5BCz79nSkpmZ4LuBmE/wE3bE9V/Tfi3NmxJcAHsEXysa30Akr3Xm0s9YTWAoQY0d7YiLWzdt1o/tQItTdH9Bbcyt37G4BE4ptYVoFzqPVgZqVVtf7kh1+CuK77E6x9m/0K3OUC2no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861939; c=relaxed/simple;
	bh=yQAi1PLss2YCyh7voiIRTY21p8+xhwJ0Fjx9zu0YBCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YoIkkbpV+lrAKG+QsB2OgYJVb/eTpCDVFZx5D6ErwmIEhaAshLq+DMs/cxcaqvPQla83CcdvijMSs8n9SbRkhXmATLzrEJE3/vPt6/CPHH2sKHPU1rMsFjS7RoWI6s0nAaKtGEcYC3ABme7iWnCMVNIe7dhVuPY9rzV2yWfKNUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KNffyc/3; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KNffyc/3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IurZYnD8MB1IMlgMb9l8S1kqM5/nGqdRpPiucuerP9At+Y1WZMG1ztF7yemOOWxfloLvurkfL4bNzlgYRbUWmH/GiKTkiqFg+OixfIwLidMw4oW9jY5xnLAAZT9jWuLepuTfl/3oZM64gSzYHF8NbGFfujYLsf1ZGLQ4dgLodzb4Be09HAx65hkxGPLx8y/wpyLGC7EVddMEHfZOD9QSdzBmhnwPQMqghgzk3SMHHIqJvqQlhIa/6ariHWjZaqy99MIp8ZQkWY/8qiQGfY8cPe3CG5mbrWr5/14kOGZ0Nb4VmXaxopGMYvUjnPPRal3w9xhcohcnduymYb3tPBG46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLyaCTuf3PFuge/CeklexN0hJN51lt3CHUUwDTOEUHQ=;
 b=jnpCk0uw68pSPREcA4zohezqU0GywT0wN9ebXvxrvgelwltZK3ItIMerCAryDnqLTEvyfEByDjxP2QQaZnteUdWV9D7uoTNdDcTRja6QiimMlf8iV/dkKWMo7GKHA+fICC5R4qsF5HWKe1+Byv/oHyo7bno93mBQY7kf95NWAJeOeW0ftPl26Tx73l6mlpmIzjaTtVpQl0luyzLIk3ljo8DrwHe0w5qUWdIFQFomsT4lUiLGvSZ8leKXP3fqUGIT/0rcbLvxOp/XhYenVVyfwc/v5c0wHok/ysSmUePA2t8OMLeLIRIRdeIzbvy38XCUtLbGox40x8IH+hGb0Xlhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLyaCTuf3PFuge/CeklexN0hJN51lt3CHUUwDTOEUHQ=;
 b=KNffyc/3Syf2XfktZI6ENiZfEwy3ACFv/1CxgAR6Qdb1ESWtdzSyKwdCybryRgMT7KxD80s1IYcCV9nmADaJB4Du/wHbnFCQ4wFKYuQ2Cj7X9dOlSaVLc54EEa/65xQiD4Kp93+PyKbn7Z1gVjOjyaB0PtDpVKG0PlNzTHQ95N9/HmZ3Vf+H6Q5NQlxeOD9b/jK5857kiHYFWt92jqq/P9QZ7fm3AN9bdbTE4jhIADqW1P0G5fdsLDgru6tJaAhuqeZzwYOdPjntnH1kKqQB2FJZ3UYWpmY68C14BMil9CdcFEHGSQjSYmPO/5pgTEFs9frElRlmMMmX2wtv5xmXXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 10:05:32 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:05:31 +0000
Date: Tue, 8 Sep 2026 13:05:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 1/4] neighbour: Add missing RCU annotation for
 neightbl_dump_info().
Message-ID: <20260908100522.GA903218@shredder>
References: <20260907215853.3709987-1-kuniyu@google.com>
 <20260907215853.3709987-2-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907215853.3709987-2-kuniyu@google.com>
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: ef68d699-581e-4073-c1f5-08df0d90b745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jfb8IX9U4Y4BpCTRxONA6NvcFqd0gsQ+A5Qa9UzUX8tXGQZoHG9uvqSXgI+Rg4pGZsOxp6crwnzWndxkkfbhw66DKE06ANqiqaRsQ61lzRiGWvpDqxD36PB+O3TmSWbVmQEUxsHwKi/OhSRrf4U/jxpjcFtTkOXect+kBkdbCtM63CFrxDIn38LrdQ7TQMK2i1VjeLzoyu7de7FnmnVCSaaZewXtu1JU7L4Verc2giFVNbikhUztPrOJJdnurJ6hGeXD2s4BxCAceAoScHM3UhzHc928tYXOgBgGLRkr3KY38PWLbf1fURAA/06SRQYYCdr79KWtx55wmsHQgDHxe8TCURGMexi6Q7bwi8zD9DZ/wSfQmYzcJ2QQsU97i5JE0Apl2Fm7iJjKyj+Ic465KyDAkEzjfJWE5TxLFEjb5PxBq4Bi4BzeBcNlx5I5LiTh/F7E7YfcNZ7Szfm3r0PRv7xCjL/0cabmZmO8oSN0DkbXSBf2hqAuwUJ/dH9OHCPrFy0AhYUYSYNU84ncQ93UPAhMMSai6sS1Hjj/F30n4OCHncZNXKqZc9DR65HuYFGx6g0G5ncGIcdny3zLD/WQbotj+iPKSt94yNusedj+fa+t8Z5JtMXYp0DlA72qD1XzFIM2TaI1LVv5b8pDNPi9LFan/hPuDUITE/avxXCAA5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mtGUKD03wYvNJZPEaLIxY5yUnzLQ96TgP2AYSBUOyB3V6zX+RhHOH+bnODZW?=
 =?us-ascii?Q?nsrk1EnyZ+A+vZmkuIZDSjB6fP/KdKhkNUUu5cVss6Riu8Ex5CjlZ7NAsT9/?=
 =?us-ascii?Q?Nal+Rifn6SlP+OxejsCKMdis66PnhFpbHpeBPVdQ2Zj7ttfmQPjMa2hAEwIL?=
 =?us-ascii?Q?ZovrH/f69WUzy2WvCnVy0u0bNuf2389ViFJbPSGprYxq1yMGGuBvWDJDcBJk?=
 =?us-ascii?Q?/BlPbPD+Njyy1M2OFFaHgFY4okJ1FDbeEn4DNIXaf1lp0oxCHuQuRUveIJ3g?=
 =?us-ascii?Q?yUg7NdxTJ+HblZI46D4DosoMmjdv9ofD/WTMieoE2ge3Emp7kjxNj55p0WlY?=
 =?us-ascii?Q?tEPGTU6Sw1OhPaSMBYrf961Kdyh6OUjB1KCuBR9ozGCFRl8Y9YXPXKe01R/Y?=
 =?us-ascii?Q?xdbGdX96ln/WLPbdqdGdkKJ5nAmPaAvaTJxR/mYEAcXoEGQxywgXTELuLvJN?=
 =?us-ascii?Q?ihZyO561pu4q1QErqEeBvFPyLp3YI+0zsLQmcdtv5LJVQjBSrFm1WBiLO/Vm?=
 =?us-ascii?Q?fOqthpkdr3dH/e7QTtLQglwulyH0fBn9D0ykKSlgeL9jG9fStMWN5YmGchnE?=
 =?us-ascii?Q?qMtBZ7r3oDU8baO730UgOgi/g+j6wAPTbfZWX2RZir+bHelEPhySp1gz1dmh?=
 =?us-ascii?Q?Z/5Kmu/S0AdTXqGG7m9O8/K7hKTDfEg/zFeymwWOnv5k8efPvBmY2RQ0uT13?=
 =?us-ascii?Q?KhasR4ZZZUj/tkg6slAmkcNYh+tvg4AO//wDKZPBsck03kCrvEEyyUD+F686?=
 =?us-ascii?Q?EOwOYiKMYnlBr1pVoRwktWMnb+HX+PXvuVnvE/zkYgMkhKkhUvHCEcghmWZP?=
 =?us-ascii?Q?X4G8PeT9/cbk3oY9qnkU21JhqTR/FpinQSwU/uBLtGTcqI1dDESt2cBrZ+qx?=
 =?us-ascii?Q?h1U93R2/TnkYdwZTTtVtuAAlQyP5dBQuuMyI5hg2fTE+LeukDj+8jVdmDBgx?=
 =?us-ascii?Q?f0A4tMwJUxuF7M74XlLWjUlqufgks3B7Zc8IkObp+k8Z/SQN29WDyBOe++Dr?=
 =?us-ascii?Q?2AHO5oTnpih7178J97A2afOHjUE0plewCYvM4wHN40boF1FePvajQfqZypNT?=
 =?us-ascii?Q?Xp6ZIDeuErao6Pgb510m2fIJgImTZH73QjaOcl5PvFc7AhYD9WDwfAc5S51X?=
 =?us-ascii?Q?Ox2PWOTxQSwidzEEAnjznm7rA56yELLQyZF+nsnLn3nZJbvR6sDcWLIyVsiY?=
 =?us-ascii?Q?NkvV8pzP23SGy4uSnoj0yLK7oENje6RJBSnXwX6CqVwitYb+ji11TUuohxgQ?=
 =?us-ascii?Q?yYi1wmXwz2dg0UPg7D9xqGf4ZkMCtoLGdzaLWATdB7LR2QhonQi5BYrnCavn?=
 =?us-ascii?Q?6A9jwHiulflHzE0N4pH/PuGtFuOBz7z2ujpbuJ0ofmTDcMNDyIT8rIVDlCQt?=
 =?us-ascii?Q?uLJoi3LCqPsLekdOsStGjkpB3eUh0tox7yTZWEZuv3l73QCv/8F6gVMzjxH1?=
 =?us-ascii?Q?U6ub9LySmuC5FaG2/rpNwuLnvoeaqomxaOXnZJLD19A2FgMkDff+/fT8rzaY?=
 =?us-ascii?Q?zQm6hk/s4eHTKRSlK2erg0WwavXMHKUtdmQOYFZ+7DLYAMWlx/L05YFi1SZW?=
 =?us-ascii?Q?ccoNSQqYee+XebpUlYZpFAb1cEgl8zlDIrYHft4du9Myjve8+W+jEkZ0OqqX?=
 =?us-ascii?Q?v0jS/w8ktNdE0cCjgbsQ4IBDdG0V3OC0Ei0oz+hjBerkRYCHyaBDMKd7DR8+?=
 =?us-ascii?Q?qNWskZds6FE6dG2OV6vmeGzcNURxLiNwOx732iD3jFFPYVCF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef68d699-581e-4073-c1f5-08df0d90b745
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:05:31.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vwa4xITw5MgFzv13w7wbs49IydGJMlpXF/0mmsCRPR2VMK+u4PQFeHK7VabX4sAKCdTlX/fi2ytV/OtdxV7Csg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599

On Mon, Sep 07, 2026 at 09:57:52PM +0000, Kuniyuki Iwashima wrote:
> neightbl_dump_info() fetches the first non-default neigh_parms
> with list_next_entry(&tbl->parms, ...) and iterates through the
> list with list_for_each_entry_from_rcu().
> 
> However, list_next_entry() does not use RCU helper.
> 
> Let's fetch the default parms with list_first_entry() and
> use list_for_each_entry_continue_rcu() for iteration.
> 
> Note that the first entry is always tbl->parms, which never goes
> away, so list_first_entry(&tbl->parms_list, ...) is safe.
> 
> Fixes: 4ae34be50064 ("neighbour: Convert RTM_GETNEIGHTBL to RCU.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/core/neighbour.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb64..4b17c2a15594 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2611,8 +2611,9 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
>  			break;
>  
>  		nidx = 0;
> -		p = list_next_entry(&tbl->parms, list);
> -		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
> +
> +		p = list_first_entry(&tbl->parms_list, struct neigh_parms, list);
> +		list_for_each_entry_continue_rcu(p, &tbl->parms_list, list) {
>  			if (!net_eq(neigh_parms_net(p), net))
>  				continue;

I find this more readable:

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..3af539f5fd4b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2611,11 +2611,13 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 			break;
 
 		nidx = 0;
-		p = list_next_entry(&tbl->parms, list);
-		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
+		list_for_each_entry_rcu(p, &tbl->parms_list, list) {
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
+			if (!p->dev)
+				continue;
+
 			if (nidx < neigh_skip)
 				goto next;
 
Then patch #3 becomes:

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 3af539f5fd4b..b4d8e5b6832c 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2615,7 +2615,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
-			if (!p->dev)
+			if (!p->dev || p->dev == blackhole_netdev)
 				continue;
 
 			if (nidx < neigh_skip)
