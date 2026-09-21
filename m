Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681EA48B398
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983104; cv=fail; b=mBfb9Phtsj8tDO0aFR/4nSHgcBYyxgC02axB7klGf8KZ4K5v88xrofypduQ2l6jlYlyHL4XkNYn4Y6bxaWYKvfnkkknXzRgOIS8aKKj0BpQ9l11Mwwg31D+kAc0OPeeoP34BFt13xJ2/ES9T6D4m5jCQkIiQP2/go6D1J9FV8d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983104; c=relaxed/simple;
	bh=yxwT/6oFqjghhyhygEpNmtQW/VhG7RUElE7qQsjf0gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NYP5xOPrYHwZ0PFC+UT9wAlvGkiu8vxrtbHT6Ng0/svFNtJHJ6oEVfK9Qy4YNL8g5O2ex5qzKQbHjY7MEqQkCiIThH8aZBOHeDLwB9S8/ErTR6IeXKskdsaaPQvpdfJ7E0sFX8AZ/4e64emDC+g66hK71nnI7TNmZw31RXgSa2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YuW3KsEg; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YuW3KsEg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0HD7SrvDfOn00WChf7j9VFtYuWi4/MPYrx7INeuHS9LLpzTOZkuxER7QlKuay9utVubF/QFFMgYTBnw2Ojne/rjMocyOIfkonK3drJCmZVLyAXLHCGRA1cwXMDeiiIw1S9U6k99Y31vmKWDqizlw15Qf9my0djSXB6AEpqHN67PKKmkhDCz9YnTA5f5R4V61Rklc6beXXvfX26BDjf5V9oijb5+XFpGIbxgxOWT4yhE3veJQmsFl5QriPBU7wlYs1GF+QgX6AmKg6+BJaC0m29YQ0iDdc3F0/Og4p4Ww3UFuhkW1UAjta1UPPl8VuMumJ2p1V8JrzPMAA9/R8PdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtyH+OvJSoc71kduIxDkT7747t1WLoGgNJwtV4On9/I=;
 b=wrKJ6Ek5whNusC6CIJhdP0YMd3f8cv/ExvJI0l7u9OYPARhsoZUiF7pi8hkQl7MCeiMtCBwneEdlTeERV6hGX/wxsmgeIf2DjzCdAchO0Nb7ljZY2FKZnlsmNipiNx3Ji6/YlfJeD9A+y1bsJ8pWvRco7D/BLse6FJa8AiMFyc8vsjuz3nYWZCtDhIdvVOwCjqOe+t7yUUm70w7BCl63w7gJak4NwinPLwjtj6JG+kgEr0hEnXG9MokBPnPy+Mh9CZa+2s5hljORuc54WYksmpMIc5BkUpzu0y+j3VdpozuR7NkUxgzm/zGlig5K529RLfp2hLpAOz5u0Cm7jXDwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtyH+OvJSoc71kduIxDkT7747t1WLoGgNJwtV4On9/I=;
 b=YuW3KsEgqh2HHChjVvnGG/UT64ZlUjtVLauU8tD/Cl+F/O7/PtFIBTI2ZLoZ+fZq2To3+p2bfMJ+G2evYS/BAb4rIZ+aytfbCOm2IR17RGYqVI8wJ9Jqveyyt0/5x97bMezWiu5qHRj4uqXMgy7W712tbs1Eq8tepG9+t+UtwmIirVkrX1etmhcyL72A/tdzjL+mufqCR8SO4NY+h0HFTX4A+Kl2nXOaKfMS2TH1AfCM5MgvkNnxJP7GI1FbGfe/CuNGmIKvO/DkHthFpfkYs5Aqrcj20OxEX0zEgNC2hYy7ZdCwegNrgOvbRzeevQ3Ei8jMSqR9nqQTT9Sowa2r3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SAWPR12MB999316.namprd12.prod.outlook.com (2603:10b6:806:55f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:31:40 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:31:40 +0000
Date: Mon, 21 Sep 2026 12:31:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, jiri@resnulli.us, vega@nebusec.ai,
	milkory@outlook.com
Subject: Re: [PATCH net v2 1/1] net: arp: terminate device name before lookup
Message-ID: <20260921093131.GB2103061@shredder>
References: <cover.1789910973.git.milkory@outlook.com>
 <fabf02a70787d17299e4b3153eadffaf20d154b3.1789910973.git.milkory@outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fabf02a70787d17299e4b3153eadffaf20d154b3.1789910973.git.milkory@outlook.com>
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SAWPR12MB999316:EE_
X-MS-Office365-Filtering-Correlation-Id: b91a0d5d-e7fa-4813-f46c-08df17c32449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|3023799007|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MUHZ5YPs6/ecN0Kxbqlf1GLaLbn3DHVN6Ts7op9KlRNDZk5X2pNkCMtEyYliJqfwvYcOtSM5qgVRosTlaKr2r3srZN6dNbZ9Era8RaYyESAxAuAH3mMRWYWeQbpTeu+tESMh8/Ta7xf2jQR8EKnJHF/OldMaLHLBUmSYZkv7mKV1Z73WaTFpxmPDGE68CIr7tn6QspBgfK/B0d5jRVjPvzMbi742Uw65q2vgL1IbKN9M2SLMPYlBGZf4oUALidyQKud+r7A7g0SSTDZibMvnaq1eo3yuxdCKL/yE/x5IeFHzYKpiwRW1UaVWyydUMSuzRlOc+Q+pQdnvDZxy6a/BoMCEcRXNZkAXFtApBWiZi1o6LzBk1QQEmemqm+Qd9mdj4p4heVw7MDyIUCdL/Ex3GyrvlD0YIQV2M4HJl4USe9q8aQvMrvoxlAVBpb/EUzCYU9IoDAk7+9vdcWK2v8xb63eNKvmL1e5DTe6iHvPCV0yAO1Hzd8CB/r7ZurDiV7188qrTZG3FMCiYFGRRSSrTYKWLIuZboUpYne6MPDKnasPDZFo/zwJ3CedRs3E5Ab3ZOVEOxiNpXhyzj1WX0xJfjwbbtJcq0cdUk2IqLSlUEgXMWRzK/ln3wm5osXAIrkk5blnedmFSFSePuIAvshxP2tAHR7aSiKYr2T0kOJZKIGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofFOSGAaYwbmR7RWQTQEJBx/Izbk5ldcA51j5/ddI8zerBqLbzn8+Kn2lOlX?=
 =?us-ascii?Q?DuIxSQJKobjt7SRetTc1EadjbnikFGxRoub9JVc6nGhGQ+tWHfpaVX6RlcmI?=
 =?us-ascii?Q?HES5JPijlJbfORwnnMR46oEamOwZwz2GnuXHSHnohJcXMmFJDL9jQXM7ouJH?=
 =?us-ascii?Q?OmYmZzJ5DvthWX2ToJp9ha9z9S/g5jqpSEwB8M2whf2p/5ptaXXOtmXpIX8O?=
 =?us-ascii?Q?cLh3EO5Ij5gBPjEE2JOmjWK9B7DMyebRgX11fJTwLHKwrTp6TUH6E7eOrb3l?=
 =?us-ascii?Q?kMRK0XaXYB30hm6wgVob4T4L1reBSaLFlPWYPW0PltMYOKn2q9HILmEZHahM?=
 =?us-ascii?Q?+a1ySSGc0Ri+R7rPV8ARvlHwNhWDPH7wL5gWqsw2BizF73TdloFCObYpYEON?=
 =?us-ascii?Q?hk2qn37DMUn/t9l0dXzCXC4GLCuDk50zV4v4DxpkaLnF4rSCV8vEYmUc8dUJ?=
 =?us-ascii?Q?dg3ueLnREyg6Wcc5LOmaVBBVIK2xfjm92pFrljpPf76IqpTmE82KxCk1ONP1?=
 =?us-ascii?Q?yNu7qDwFusACBAOxOYvFyIO0+WMev/naXyTGQJz+aocxUbgkjYyxw0CGZ/fD?=
 =?us-ascii?Q?P7ejqss/NIsMe+2eEvuMf7yT9aHnkxlWVPhP1CbMC5XsM/SUiTYrQ6LFV4et?=
 =?us-ascii?Q?Z4w+Ql8lYRgJ14RXrsluBmRTUiSKXvK21IVFJdXlCoSuTziZuIacK5TgrwGw?=
 =?us-ascii?Q?1rmS7vF2RRSu4TXp8+ltEifYH9SqvulSbCZFBqG9L5GAlKKcHBbOxL5kGKZz?=
 =?us-ascii?Q?KXm68DjOJLr8IW8PQyNK0xWNhuSFX1a6Gm/pX9zzWK4BGuXUtBGg2A0K05gY?=
 =?us-ascii?Q?qvUeYAqhTYwZPM/btsI6a4W9cOmUEXgupULEMuab4yyYW54Lngn720xGIdL3?=
 =?us-ascii?Q?r4JpVdlTPMwXfmAcynEO0eJ42QvRhWmZP4lJfK5z7p/6PgX7hBS0g6pd1lio?=
 =?us-ascii?Q?I52FyDownm+Gy/3Fn1olZ1Gcr/zt74uCqOW9VN1m9Dv0GP/74DuI50+IZ2Vc?=
 =?us-ascii?Q?TSX0+GZKMLwNGwPEXZlIT7dUiQVbFy1yhD+rD2CYb8N5VdXp0DebqMf+g0PI?=
 =?us-ascii?Q?ZDdQG1ziTk9He2bzGkoO4dstcKgke6BZzXZQ2qRHJ5ZZaoiRapH5avef4mcA?=
 =?us-ascii?Q?sqNJZo2fYPpjE+5QuZ6exoTssaYACiCPm8HYeF3qLwSJ9IUjXhKjXp16y8uB?=
 =?us-ascii?Q?4TQlARmQZNHLUbvPZlGCUcZFGAuE0LIyX67uSzXn9zU92E2nap+5tQov5oCz?=
 =?us-ascii?Q?QN8xD9LuzjD7khAKx6StS6VP9xSZ6SakE5D759OkvJwOIJQpydq/G2WRV5u+?=
 =?us-ascii?Q?XQFVwC40DbagusL13mriJre4UXRxhBjQaMEb16w6VifB2NIjwK5Z5o7xxZEI?=
 =?us-ascii?Q?1n5985lqR+OyONGT4GbS2SWbEPu7yKE12dz566I43jMjn23LFx7iwrXFtAvE?=
 =?us-ascii?Q?X947chbgqyeEiahXqnnYwL0ZcMVjSyDqGLQwtdP5xXHP/+xzDm3aWlFI4eMU?=
 =?us-ascii?Q?lycpBREtl2nIAT1Bdh6oOLxdSbSE16VlFVtRAMWVli29tDBTurdcXjnradI7?=
 =?us-ascii?Q?dch/hctiQWBNfULU8p5k9fD3Ufsv/j4gG3Baivkgs2m+IZOTqQkVcihkSmHa?=
 =?us-ascii?Q?18tcljqxUbY+ONkfgJ2qT9j2c+H+DgR8/942UutbqJIEEmCcBoBK/NWmg2n9?=
 =?us-ascii?Q?YVCRBqKjZkB3zqi4GJIoJHN9mBFYUHnxt+r6OslvI1MFQOwmtQagaI7OiGer?=
 =?us-ascii?Q?4z9EczTO9g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91a0d5d-e7fa-4813-f46c-08df17c32449
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:31:40.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKBE+CXw9vf7cYWtmmHzSuelxujUhWPnE6EHuaAFC/LY4235YvSVo+Hz9vqYdXDEwturojympUhtX5RCyAERlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999316

On Mon, Sep 21, 2026 at 01:36:19AM +0800, Ren Wei wrote:
> From: Zijie Huang <milkory@outlook.com>
> 
> The ARP ioctl copies a user-provided struct arpreq into a stack object. Its
> arp_dev field may contain IFNAMSIZ bytes without a NUL terminator.
> 
> Such input is passed to dev_get_by_name_rcu() or __dev_get_by_name(), where
> strcmp() can read past the end of the stack object when a matching
> alternative interface name exists.
> 
> Terminate the field before the lookup to prevent the out-of-bounds read.
> 
> Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zijie Huang <milkory@outlook.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
