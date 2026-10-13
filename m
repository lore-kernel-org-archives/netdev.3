Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A83E2ADB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895324; cv=fail; b=kGd5QrnxEDIdVZeIqGqGuLnnbI2mdr4pKv3UXp24kGC6PyHybo9O5xwH7guGTUVbJFAdYi2ijHArF5pkDVjF86KLJWuiA4ohe0Kc5wLfpJBPh2xgeOVnMCTcCVM4fMNbEOWFBExE3lxlCBuCrlXxdzN2FoaGqa9en/KStdv6rjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895324; c=relaxed/simple;
	bh=ToA69KwvN/wpLic/S3nBRIKmwOw9Luhe/rF/g/AlBGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWcNfvTUK9exE1iuE8wQJF8V+aIdywClvc4bdJ01bTWZ+GS8E21GnC3p/GHihuNYxxeEQDVJ42I05EwcCoy/Dnvf8rwWEuQfxgN8PEsqqV1tNKU8yjW63Icj/7ZYBTf/+6Mb50fUmaSU6cpk4j87oBU8PE3WieHNCz2VznnRP0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AjPgo48w; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AjPgo48w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1toKKX15eUlVe1z4w8DQUgV1dHgVZRDk5JZ+QYhZfLD8TlTkp+6AZsu96cGxgHJWQilF/97jNazo4sMHAcrBSZik7EYxIMeGEKM2dHgcJI+Ng2n865lAUVg7mtYJhpgwXwD4jQjplIGQhS/4WZV649afHV9IfHMl2Jwypu1KiZDF0lddG6m7OSAW10RW0lUqRtiidkvphQcg4OY7jw1JHO0OyE82aSjvOhZlcg2fRrqsU13XefPxFkS9UpPAlWKMUFoJIV1lxrgHfKlHUT68QNB0+n5sV4kpNnsUv2QpDzcyVkfBX4v9Ov7MIH1tilog9bitRvECqm8IFgbBcPONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beOHR3yqNoTKXkzGqRhz/ElcE2aePXtpCXdaN4yVopY=;
 b=lU9E/vykrcLrnntXzQffoVmuG91bTM1vkpG/ePFZJESI66qStoCJPs3v8/VejPPX3YNIMKfqQV8jfFjUyuzsLe3y1g1ToDkfatRG/1q7mXpCUIDFblamC3KDJYUL7upIO+VMZuaeBOhw/NUdkP8UkcFWbFD/w04Tbz16Gz66ySZQoZ8pG4lie+O9gpMs/K9sJbZZX7S8HLO0xt3PFn2DSGWs3dZljSrujKFPItfSAO2k/Avh05qtB8kcCCrPBHvLiNSpcireuSzCDP46vuD6/SHKpZxB5g9wsOyIzdSHg79TK+7iNr3bWTjojt3ymWFFIM5pTVNcgctQmg21+6GZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beOHR3yqNoTKXkzGqRhz/ElcE2aePXtpCXdaN4yVopY=;
 b=AjPgo48w7O/RQ9m+qwnjKjsBXUwx1Bz7mNCG5tj4xolx8W98zRBGGEMFwbVN7dB0tFOWoQdhrSVpSlo223jzt2wiqs4Pl259n7619q6cbHtgP6Iqgsx7i8RGN5E/2fsolU2TQf/szuUr1wU9dyd4M55ApqqVa/dkEUnQpNdo2d9ALTaIr/R/7G/afslF/wSUkZAhe4dKrLVCCHyNpN0CrtxmVqEmwPVwY0h/+L7kAenq7CW4oGp5gSm8ME4cprzZJWNbn9DSl1mZNF4qwS5EgYFUFr90HipTsXA5hdmWAztdAlZWlLffUOQO1MOuEgQovm5Rj2Sh6SPPXvsbGcK3Zw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 12:41:52 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 12:41:52 +0000
Date: Tue, 13 Oct 2026 15:41:36 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jun Yang <juny24602@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kaber@trash.net, netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>, stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: Re: [PATCH net] ipv6: take tb6_lock across the fib6 dump sernum
 snapshot
Message-ID: <20261013124136.GA1010894@shredder>
References: <20261012083843.60510-1-juny24602@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012083843.60510-1-juny24602@gmail.com>
X-ClientProxiedBy: FR4P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 364b2cf2-35ee-4a8c-11e5-08df29275b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|18002099003|22082099003|11063799006|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rzZ5Y7wBmD2ajDB1FAogBT5/F5dhjQqHScnEQTfZXedSMFCXgeHbHN3Jn9Y+k8PsMht2EC/0EhwSgSqrmAnQETuMepCUueSoKPSLNqnVucwglJ+2DY2rZWonJGCAJfDtb//o7n35ZP+SC4GrIkkm8DdCFy9kK/uXv7TiFieLLUKpiSGFoauBYJiU0n+xDNLMhPQNPg3eBgeeJzjvIaauaofc74wm5h5aR2dlqKCVF4QMScW2ktnTR+hJDeTce9NuyCuKJ9KmQZUc/MRok9LvJfrD8d24ufU74/Q6etFoN9tfMqRx1pWZarrpL7fsoogo72UCIctIr8qLdvtFGHnu+o+jCXn/CIHDD8YRBnD9vaB6Bqq0WtgEWk/sQs+ApGbO0nHKhJFTLMpa1CJJ6K3XDI+fIfjdYioUFiYpXPyGdN7ulu0TnF6XR5D8/t3n0oTmx5iXjJIRpPKYm3OjsYQ+rZvFsXaDFLCjapXj6XE/692gCJNpemNaWDKfhkV+DsIyP4gHWYZQM20rccFDM/pnhYvbF9huBb3Mk00ApnXei0u+2R1DJaeKZ49GZUKssL9o3W33rwNGMN7znrBQj5BiMLaj5k789lfzjuhbbNyg4BPf59gsKzLs/Ll7Toy1tZxcgd1g2J0Q1Z00jppXn5BaSRT7umUr6kXV7TnwNEw8Z5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRqA1aKABVqmdrWEgS/hzHb2DX/BLAfH2ajbY9vWipDZk8sgIOqn975bvXHi?=
 =?us-ascii?Q?HO6yv2pQ+2I7vPP75v5Ze1MF7obhikdJ5mg+36g11RJcmrhT3yKNYvJn2zMD?=
 =?us-ascii?Q?M8LPBQQXepC5B6bFQ/Wc3fG4Vs8oXWRf71HpKEeM5MMvpVMeqzL6jMAikIhc?=
 =?us-ascii?Q?AbyF4R3CzWZDdYP6TT2Z/RohI3QlAcrNgAp+0h58wnE+SXG8vE1kSUWqijbQ?=
 =?us-ascii?Q?DDDAxF+Z6YO2a+jDA+ofWPSnvyZMiwt/ZUNP8oj+KDnFVOTWMTNinnc35djB?=
 =?us-ascii?Q?pZwVPdzyNm0exlwPVt59DQogWBbHtAxFH1yRQqUZywx6Oak8cDrRpg5MMMqS?=
 =?us-ascii?Q?cQfVyuPB9c1uP4BurIFsPL6jhnOrCVfNgDn89M1vUMLogbt0zwaBJ1Jpf4PO?=
 =?us-ascii?Q?hWiSn/Hitu8LwgYzrBWG1+W7LuL+W+S5xs+TJ21mnTB/OKSODlf//VVctKw5?=
 =?us-ascii?Q?mdlXDwwuCB1AgZBz7DOvGSV8B9xld7FS62Llxtm7hXbWSbp2eUyXZ94GchPK?=
 =?us-ascii?Q?X0PoJusF6/wQcyURPIy9rAK/xhVgxsVaX/+gQh+TtLGwYMM88R76kVQvhkf7?=
 =?us-ascii?Q?r0RjQYR9WrnmSfEbankCX9ZdxuVUBhwkDGPu8Vt+3DQ3GG/7ZDNitLMZPRrB?=
 =?us-ascii?Q?pOVLeJx9ZpjPhTXf2Bn6bBffx8qVBpyXd/FjixQyS5LE0ORRW1jzcdtiI7RA?=
 =?us-ascii?Q?hXUHgRWH6szkBTCS3jCNYvjIxSzTyDOpEmfDxOBEHJw2BHqs59nKbWvFb3hJ?=
 =?us-ascii?Q?83vjOR0tgpfeWecC+yKYte/hNpM8SKd6bRhsQk8wMmo6IkOBW9TYQdYTVEoM?=
 =?us-ascii?Q?+Dlx9vP1ouH72tx7AMriN7qDjiCuS00SzcDNQFpGAKLl79BgCA3j0WzFXGlC?=
 =?us-ascii?Q?gU3juYdJo9PSWWLecMgc0Kox/Ob6048jKL35iN8wUjYysp5V2XDx6shpxohV?=
 =?us-ascii?Q?ENxZpgn6O8yDCuaoEExhjYPEvA6+A9pczdGCalUfyicL6UrQDXR0yAfMTweT?=
 =?us-ascii?Q?xEWK6vZHWImrPQzOz5rc5mwgWpQcgTPJ5Y4AKNctpABHBhot6C0B4+U/0nzh?=
 =?us-ascii?Q?sPf+ZviABWn2btCCJlWIX2ET6ka0vY+SzV2C0cDZ3e4tatfxzDrB0XBoC/TM?=
 =?us-ascii?Q?+iy5qjx2ACKdTpVb/nQz+2yspS3adZgNTWdqJvR+3m4774fwgq2J6Yd1fkmO?=
 =?us-ascii?Q?eZoBnj2eU01SfXc65MNX0RZJES//Z08VU9lfc0B3c8hfc3SFuga6uwqYttSi?=
 =?us-ascii?Q?N957q8kUmSAeCZTo95jjkSOTQwkCGWEhk/e0TPOCcSQKWRU78rGbNFU/q8fr?=
 =?us-ascii?Q?hE8wM9ZlHoCwsKpo0BEfKCISiiQjHeN1iXEVmGC7hlE+gfECvXO1S7kEvqI5?=
 =?us-ascii?Q?Tx/wauK96pdaR6dPRtifLsLjRf02M5ikksE2raAcArssPmwfAchLX4U5Bu/l?=
 =?us-ascii?Q?I0UfS1r1RsDC8n1rBJWAbtlItVUmeHKpt5ksagJ2sHJn5YVkvRx4ymvwgIFS?=
 =?us-ascii?Q?/T+uFxq+i+8Cj33FZI61vdW2y8n/uVUKZhpOJdwjDRoZ9K2W7SLX7sQd93JK?=
 =?us-ascii?Q?qzxa6GmaMgtAaomKdKHngfOg7R/TaC/IiR5bZflBMu5zqygCpxADqrwnxhD/?=
 =?us-ascii?Q?Y6ysOK3N4gHwB9B6HDEy8ypoVi+cAkxdoPUB6/jThKX2IRVvFA7mkKoPmAs6?=
 =?us-ascii?Q?M13bVqqB58kez79KOx+ZcoTKrZeJjesEez+duOwnKbMGiT35?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364b2cf2-35ee-4a8c-11e5-08df29275b70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:41:52.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQ2UIOdTEwBgiA+jhOEFb1Ncy41GYJTETQqfJrtONPMvogUVFMnwPo60geUpU00KbJTMFfIStJcGmo+42VVLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

On Mon, Oct 12, 2026 at 04:38:20PM +0800, Jun Yang wrote:

[...]

> the replace path has no FOR_WALKERS fixup, unlike fib6_del_route()

Why not fix that instead with something like [1]?

[1]
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9ff761962b45..b9268b5569a8 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -89,6 +89,24 @@ static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)
 	write_unlock_bh(&net->ipv6.fib6_walker_lock);
 }
 
+static void fib6_adjust_walkers(struct net *net, struct fib6_table *table,
+				struct fib6_info *rt)
+{
+	struct fib6_walker *w;
+
+	read_lock(&net->ipv6.fib6_walker_lock);
+	FOR_WALKERS(net, w) {
+		if (w->state == FWS_C && w->leaf == rt) {
+			pr_debug("walker %p adjusted\n", w);
+			w->leaf = rcu_dereference_protected(rt->fib6_next,
+					    lockdep_is_held(&table->tb6_lock));
+			if (!w->leaf)
+				w->state = FWS_U;
+		}
+	}
+	read_unlock(&net->ipv6.fib6_walker_lock);
+}
+
 static int fib6_new_sernum(struct net *net)
 {
 	int new, old = atomic_read(&net->ipv6.fib6_sernum);
@@ -1324,6 +1342,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 		}
 		nsiblings = iter->fib6_nsiblings;
 		iter->fib6_node = NULL;
+		fib6_adjust_walkers(info->nl_net, rt->fib6_table, iter);
 		list_add(&iter->purge_link, purge_list);
 		if (rcu_access_pointer(fn->rr_ptr) == iter)
 			fn->rr_ptr = NULL;
@@ -1339,6 +1358,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				if (rt6_qualify_for_ecmp(iter)) {
 					*ins = iter->fib6_next;
 					iter->fib6_node = NULL;
+					fib6_adjust_walkers(info->nl_net, rt->fib6_table, iter);
 					list_add(&iter->purge_link, purge_list);
 					if (rcu_access_pointer(fn->rr_ptr) == iter)
 						fn->rr_ptr = NULL;
@@ -1971,7 +1991,6 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 			   enum rt_del_reason del_reason)
 {
 	struct fib6_info *leaf, *replace_rt = NULL;
-	struct fib6_walker *w;
 	struct fib6_info *rt = rcu_dereference_protected(*rtp,
 				    lockdep_is_held(&table->tb6_lock));
 	struct net *net = info->nl_net;
@@ -2022,18 +2041,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 		rt6_multipath_rebalance(next_sibling);
 	}
 
-	/* Adjust walkers */
-	read_lock(&net->ipv6.fib6_walker_lock);
-	FOR_WALKERS(net, w) {
-		if (w->state == FWS_C && w->leaf == rt) {
-			pr_debug("walker %p adjusted by delroute\n", w);
-			w->leaf = rcu_dereference_protected(rt->fib6_next,
-					    lockdep_is_held(&table->tb6_lock));
-			if (!w->leaf)
-				w->state = FWS_U;
-		}
-	}
-	read_unlock(&net->ipv6.fib6_walker_lock);
+	fib6_adjust_walkers(net, table, rt);
 
 	/* If it was last route, call fib6_repair_tree() to:
 	 * 1. For root node, put back null_entry as how the table was created.

