Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B13F823C;
	Wed,  7 Oct 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400846; cv=fail; b=tB2hEZCzfh/kR3uLTrRWUaZ2iTfDvHOk0u5pci+CkEwQ7h4UIT8U5ZU4c+z0lgv5Z8Br9lHAtfEAykAVI9of2A0sUKbM1gUvMhWDV8H/6RPnVF1iKhET74FlmjmCeXwGQzvUtY9LCi6BBGF6kenLmhhQBP5tHNRVNMW8XlYFlso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400846; c=relaxed/simple;
	bh=XYP3pSL0BRfPsqbLAkv/vBLSJ0hMQj0ZWWaG2vDIE3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rmSwZFGa9V5ALkXKH8q87qHkUL68KRjuH1RasodBzYz0jr4KLXaq9KaP4lXOdBtR96ZRJGSEVpySOa4uu7phli5qqMNNaMousPzmkn7N/N5oPSwQ8welW7OyHHordhrJvnloLkCllXFAQQBc5giSpZyg5NUHLCExymk7uWJb5Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lAnrCV1n; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lAnrCV1n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2TWQ5BTtNMCJDB5L/6YfqP3ImZHz5iF/xYPfx2bos/iaNyE6ikWBHXp3HO0Wf2HytYV+1Ep7LK87fbkf3YGLI86sVCLciP4BJRTmR0TX/0z/IFnSYHW+UDQQPc1UtYoKeXSzq6aW/pCDbxJMhl8V09/mGj92L9Un6fZwoNdjGoQJEPsZQHUAQBJWNhii11aNHH3vgQZjlSp/y2x38S58knqIjeYn27aTxihvk8rA/0tG5NgoEJ6bKlqdmLhzLvdqSevfbMV4toVwuM04XoOLk4lqghlr4I1x859uYow3aDMjExL0XeRsSm8aFE6kfdTZiULSRfRjWyv24yeM02Mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW/JiCRkvcCs9xbVf1KxGObi+UiK1EC5I7iaBDgQq0E=;
 b=StH/Tcss4d/Oe/FZap5PbB5ujeh5193Xo60ddnXahNg3fTPAZiHMENlaGgIf+UukDovtJ6F/ZyRHr6jU4Sf4MfjfOUTBHBZ6JnG5Re3CDMtkzy1Zc+kXgblWdIVUT+poBRl3kTJVsMY7T/eOs0VirLgTH7W0f4YsnsBTrzBF/es5sPLowyVw9vqtrcZOHY5+8lE0FVwOpIjcO8Ni5e8JM2lD5FTHT+lnArcw1bKiAzLhEajzQHPmtspH9s4TC8W/3VyvuMTAThAl2S0uvC7m4gl19xOXD8kFeYpuxIfKK3C3WIvcsMmW5/iT7wjx5R6Fgjq8hTZzuSaKSdAczrh/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW/JiCRkvcCs9xbVf1KxGObi+UiK1EC5I7iaBDgQq0E=;
 b=lAnrCV1nTTk3vIsHDzxf9ugb0QktbNtYxdB0H2NvveQB5JDxU6C1kaPaCMajhV3Ez1MgxJ2IyNqTvtW/96LCFNbKXV57lhZLWvOHSI+e72S4M9SCXgW2wVeKRpsXdeyepB7P3g1uGjOeJyd3VRJGMXfrLCvIgukgl6vrjsdtGSrAzzJyg4eGxsh3ONGtjtaDh5BvekxFSYDvgHJk1sUHoQKbQC8LGRsa955Xpd/B3VAflX0ihzPS9ZuhvH8liiLFyF7gqPrwoeBKXp3qeTPTI9tpslblyVFQnqoFYyorTEekVV0jOBUSfT4O2P4M7AFc7+0ZNpU6VHG0wdzSnkeuWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 19:20:40 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 19:20:40 +0000
Date: Wed, 7 Oct 2026 22:20:32 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: 4ncienth@gmail.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] ipv6: serialize address publication with
 device teardown
Message-ID: <20261007192032.GA1212364@shredder>
References: <20261004183639.3773498-2-4ncienth@gmail.com>
 <179122559913.434549.12720841717630168470@kernel.org>
 <20261007164548.GA1153540@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007164548.GA1153540@shredder>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 40147a45-d897-4e35-78f7-08df24a81316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	W4BriQ/VO3rtLlAFKkLhUcJYdExRC0H9ALppMYR0UXZxaOqrlzn6Rgv11nQLacUBNSqtERcdrL3qhsd1NZ4p/z9utYuacWtxiQneoIY+zm2JOSOwb2JTDY7BzLFlmVCghEyaDgWFtqIzTRtPR/n2Cylpm69bQ/cV3GVACFBb6UZUk/xFfSSSNaE1TplDSMsjZXHwkLGAqM3tRnWwIjegjhFgSb+gy1ubtPC8NHam9DLL6BPPNv6H6h89ljcX853vPNaE9x9dkr3h5BUnobOILmhwvjpxNkOmbS3JUt+jskP48FZzD5ULlPKzhVIGBR/189/fWES4s3xpcaIKSOcwG9pmlNaN1EEblHJ/j+z2uNdoSSehC+525q3uPp97kl9cXynfSIYPs8FTJzlPfGIY2H/aWUj9bia33dX3geNxvYhVQMYaBRy8Y5pruXfamB3tyCPhk6llwroP6w4Q5s3fLRN/BVn65w4Q+T2HOB29/a+9FbLTKd5T5/3Er1YF8Nfy78fHx/tknJcuyZ0olJmglysiWdL2Y2FcKnsBw73Qr3w88YgyiWVzmfHn4R7B2/uuIMJ2GBYOqnojJPFptOgY5bepIjDoV27Kv1vjHHVFN4CfDjPL57tPjcUEkuvJM92YHMKvn7SUoApdsxq/9KMLrTV+A+C77I2dPMdMKLD/HvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/aLusw7woBmDbfn2o36Ut8khhUSSE+DysChuP03EV3niyRd0bQzhhW0N0OK?=
 =?us-ascii?Q?t0LgeZrxpKNWPVTdeL9n1eFjnr8ZaFY/guZy5o6gP81+/M59hcwRzWUJP4F5?=
 =?us-ascii?Q?ZT21QdPickSXL/G+rHBd7SAO6+Hi2oo1ety6lW2gB1nSiLS12N7bntC0k3WV?=
 =?us-ascii?Q?Kep0sA96a86/ev5INnG8ftN2P+b2sVjzBP2mGkPf8kYy23GRQ5Bu6qq0QL0i?=
 =?us-ascii?Q?bDLGo/A8FkNmy7xNOM9yOOsT+ViDExftx7rOawd8UwVYf3ke1yrTh5VwC1Me?=
 =?us-ascii?Q?E8ZD83fFI8MpaUpevEhTuGfz2dKlDMcC4Y5VSQKc+ruvJJudHGydPJ/JNSwL?=
 =?us-ascii?Q?ix1s1mepS88suJ7Z8XkRKbd0M2OLJWmnirGhwpBNM/OoJW/BNpkShK7V0o/8?=
 =?us-ascii?Q?mPkKFQW+Z3eulndDzlAx2MgGZS7jjHC37NbmPm7Fp51lcJCi2Cg/5/EbsCeX?=
 =?us-ascii?Q?VH1yz+Re+/tvfIuZELRGPlvM+1tiNI2sZ98wJrHzlOlLsw+8GEkaDiEHKBV3?=
 =?us-ascii?Q?vC4PUTsLyuwU4yjoZxeExHiznsaLXlPXK5zzCX7Ie6I1CUJrvT0C300PH2uV?=
 =?us-ascii?Q?gpFFnZn0gWiQU+akyLXKt9UAoPnV82XkUgfLCcaKMmrWBIP+s8vQ4e68ngoi?=
 =?us-ascii?Q?I8X/Kr/mKpEEnQACcghfa+Z4nTpy+mqBqIz2ZMIWSjrpTNepLPBllNwysVDX?=
 =?us-ascii?Q?kfcwIQjhaJa7z5MsI/z07EKbVn074J9CyOwslnFLdQUUc4egbyyPX8phfDTC?=
 =?us-ascii?Q?mxy8Flfu6L9WiBDpBQl2x9U0ZT85rSlESKU89msCsizY5LpdAK6rmwYGafIF?=
 =?us-ascii?Q?ShLMyF0tUwz+o2eo3iz+9F0whAn+97ig+nmpGkFzrUhsR022NZsENJgMzL1Z?=
 =?us-ascii?Q?T5SweRIz6pxPoV1eczhTMyY/oKZ3t/EZIdQhfi4BF0rElXJnampFaEYQqtnw?=
 =?us-ascii?Q?4C14udVOvfHB9dtLBqIN3C01CSrROJtj4FivHTzcwl2aZ5HtWEwRBdMyZYTz?=
 =?us-ascii?Q?jvT3aVXUJ8+UF9P1yTJjMvp9+GDLXZ2khAuBNsPkisLOw7KSb3m6C0ii+tMw?=
 =?us-ascii?Q?Tu77tVj9RXnC1/HKNokBZ8RbBHWVFvdlURcy5W5zN+XGTWLo7bJFV/2yqW1O?=
 =?us-ascii?Q?TZU7yYPszLzVdwGsg/MOit2qpDeQ7sTkzpsNl4Yf4Mt6emYroh7lImztGmom?=
 =?us-ascii?Q?/SYsGE3ruFJUtAucLcLUVm6ss2DxhvcTNweHRZU40YyE6WygRv/raoh0H/vF?=
 =?us-ascii?Q?QiUblZZRRZG2XVqHNeECRLyFMyWqoSO82tt/tzHj7BfHgd9yn/MI5ffNmALQ?=
 =?us-ascii?Q?FCmRvL00l5v3fQsRM9lWZrfFZ9QWHT6z1HO+OaPL0LIICbnf9GUy9LN5+Wbg?=
 =?us-ascii?Q?7leTPEjC7DkAmgoSYIPGUhs2ijkelEM6FxKJ47RgdjK5VfYIcDqu8KDY/FSo?=
 =?us-ascii?Q?9Gq6Xe1hontO10tml0WGtAs65xfRgGuNUswRwtjFA2gkWZOUd0CcYkTUJnkl?=
 =?us-ascii?Q?9J+RQoIYvDqzC6xUv8QMXXgHVyC/EUnFA2SL79V4oRC2sq0cl5gJcIM1/SYf?=
 =?us-ascii?Q?sdoaZ7KLYwmGK7sAr1jC/NOm4hq6umX80dYhhq9IaTThO/HXSHN9OpjvPOCu?=
 =?us-ascii?Q?1IwzTaMbmy3/NY6EeZZFOnHU4zSyoUOh415kF8SRVxOK7copOsTOfXQ3SMLb?=
 =?us-ascii?Q?abzdrfso5G2xDQlA8HYdQpACaD/4uHRe02jimWRe24tIb+U9COvbUS9rMylL?=
 =?us-ascii?Q?fkpgvvyiRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40147a45-d897-4e35-78f7-08df24a81316
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:20:40.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti8XQ/2liyGUcaqIDCWmZj25Vq14F0ag9igp7dZ9+UhZJC7NbHq9CAmNEjHXQotpsJHZDeZLZZ5T6KlvRgoFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066

On Wed, Oct 07, 2026 at 07:45:48PM +0300, Ido Schimmel wrote:
> Yes, we need to pass the public address to ipv6_add_addr() so that we
> only publish a fully initialized temporary address in the per-idev list
> and the per-netns hashtable. Something like the diff below. It should be
> another patch in this series.

Thinking about it again, the following diff seems cleaner to me. That
way we don't modify the timestamps after publishing the address.

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index e6764245995f..0cfc99b4d251 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -87,6 +87,8 @@ struct ifa6_config {
 	u32			preferred_lft;
 	u32			valid_lft;
 	u16			scope;
+	struct inet6_ifaddr	*ifpub;
+	unsigned long		tstamp;
 };
 
 enum addr_type_t {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c90ee6dd7446..df3f25fbab64 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1155,10 +1155,12 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 		ifa->flags |= IFA_F_TENTATIVE;
 	ifa->valid_lft = cfg->valid_lft;
 	ifa->prefered_lft = cfg->preferred_lft;
-	ifa->cstamp = ifa->tstamp = jiffies;
+	ifa->cstamp = jiffies;
+	ifa->tstamp = cfg->ifpub ? cfg->tstamp : ifa->cstamp;
 	ifa->tokenized = false;
 
 	ifa->rt = f6i;
+	ifa->ifpub = cfg->ifpub;
 
 	ifa->idev = idev;
 	in6_dev_hold(idev);
@@ -1487,6 +1489,8 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	cfg.pfx = &addr;
 	cfg.scope = ipv6_addr_scope(cfg.pfx);
+	cfg.ifpub = ifp;
+	cfg.tstamp = tmp_tstamp;
 
 	ift = ipv6_add_addr(idev, &cfg, block, NULL);
 	if (IS_ERR(ift)) {
@@ -1497,12 +1501,6 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		goto retry;
 	}
 
-	spin_lock_bh(&ift->lock);
-	ift->ifpub = ifp;
-	ift->cstamp = now;
-	ift->tstamp = tmp_tstamp;
-	spin_unlock_bh(&ift->lock);
-
 	addrconf_dad_start(ift);
 	in6_ifa_put(ift);
 	in6_dev_put(idev);

