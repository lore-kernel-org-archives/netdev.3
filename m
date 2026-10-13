Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BD23C51D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874848; cv=fail; b=kxoN1fAA3kzccbtDnmdo+4IcZiu3zhb4GrX8wlYLKrbeDKI7ztOh2aGgqJhn+qAl6T5FZeX98kxOUimHR4R9EBYd41ZaRdYmGh8h9rIpxg6aIsGf2V7F2/D8dFDJ/iYt9fCnIkmblaggmWnorQA6L4nlyEX2CvMzx0pCym//v14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874848; c=relaxed/simple;
	bh=M+cjQttdnamklcWyc+9h8pt+Bjyaxsx+vm5F7ONRwtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sy/YJt/F75RNZI6s6OyNEUy2s4bf5TiwJGxCzpraV/x5z6elVnmelhuK/MwlmZyH2oyTMieFQXPktmmIIls+8cNfjHC0e3PWGe+qbmWHV2gx4VE4NwSYachLWekopmtjam/K/UYwTQPHGB7d6vnv7Ml8uvbZWVMBBczPk3z4kQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nb/DwC3X; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nb/DwC3X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbTta394+Cc6Pb6DiZNiPZKsFhQ4duSAPkBWA2P2ebF03s/vYDCSqn9OGrcHCVxsrBOIWdyCEyGnfLeUvH6h1isYvBRfqBSK3zPydwQ1BLhAQD4tbgEREB5mRfXJL2N3cVhSukM7ELXCgUy3Bxx/B1SgWc6Wdj+jnDeT4SOs2jFrT0iiIFt4BkFz4eSTN5ha0cIB55gPAeLCwiwp0mhzrgT1Ri5dirmWl+wFP09U1GpQQSweXXVZqJexkdkGEZb6zmRrHtt2PIlvoiRPPiYmZsIXEc0r6yZUzbcrpJLngZZ6hf61x2RB3tb0Q15nOrP/lIk4Tvfsn2JidUeO6TTvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXgXBk2KnX1QOoRxSiiDLEfDxs/eXbF1GF01hjiTNdc=;
 b=K5S5ItE+xUuzjtbimmtfkSSQET5cOcfNJ/OX11kt2NxgSMht8tYg6hVVX1QkGUlYyH9AoERptDtCXOeqjDAvs6L81BanE3nMrXhwpDIOOdIvDnrDVirYJksFmpxhuA5l985owyDqQ+91nqeA6lthkvbEB6l36xVw425GXeJ6j4ymrCkuPcwk8EE7ME4m0K3IMgrhQNI3OEF94yaZnHWN9YmK3M/AEpt8u6CoppKfPu5YAyfqdyNEXiDEx2FViqSdOMlRB+2rL8l26nqx8Wy+Qs+hXMKx4wvOiCJ5AbjJrG7kBfdUO7/BYOeszzfrOQTZFEjrmdXiLYHLEoemOEY74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXgXBk2KnX1QOoRxSiiDLEfDxs/eXbF1GF01hjiTNdc=;
 b=Nb/DwC3XWi8aC5GxTe15IO574nyPiJQzGIWNqnn82G446w91L9kGhYcvjk2N0i7BtxuhWQq0vX7tHtih8trfIT3fOz5FStMyqRYvaHMm2isiurEUN5YdPu3OwUjp3AhuWYQR/MURMhquEvXcDgXetdL8BkWXdOCN0iRDtYxNJb2wakkSsUyRxu+WApCJzhD4uqTJe6Bh7LGnzAi4bg18f6VXodjwMbwz0NWXfpZa3RmlerSYs6KMJd/CLk2+wsT1+xpIpsYrm3SbB5myfcOW3A0wmH0W0uV0nGXeiocYn/EM5OzzSnTuUxH2e3Nh6IZ9dbFlXXggYHwdGhaUUk8eww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:00:43 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 07:00:43 +0000
Date: Tue, 13 Oct 2026 10:00:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 0/4] neighbour: Misc follow-ups on per-netns
 neigh_table series.
Message-ID: <20261013070033.GA852441@shredder>
References: <20261012194530.3751034-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012194530.3751034-1-kuniyu@google.com>
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 392d6bc6-5804-4716-dc96-08df28f7b2b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rHeqdS8l+VzeAy6kjJCoue1v9Zm+6EjGGthaUO7rpxh/2KMxG2OQ+qLsCaz+qaPesj54Pc5iHJGhw/wHS3BrRQOhCi9Y13qXqsvVME13waDFx3kLJcs9REV2OSJwa/xqaI+SDzfnKdsjExvEEsQCCeCKeVg4cuI1rY+4cZUXnD+nfYq05Jo4rEj3lkWVXaoirch/NoIzlo9GeSjsjvHo7VP+T00FFRWbb5/lFr3w4JCWSjJkQ+2LaJ6ZfMChKumwgEQk6guEFLv//rGPcAzuEbc+iHTlo9jIG8L59kgqRnhRD2nmtZQyDsxTBbeXm3AOfC7FquKUzIMN1/06iALdU2FALJ2Z/ebN+SPtgEtYRiAQj0q7rhG4dCRp7OKJfM5bL2TCMioETPN/E+bF7YPkqZF8/VBg7Md1RrqLqIP32P8uqW8oC8iYUYAQOoW8DVq6r/njyY/u7YPT9nVbfevdE7ao+/KqfwzAhmw9nyMVwYuQ57ehchg9eSnoQQmJntupv96UnFUJTZFIBhmjbN3wGvZdsxdftIB8ahDhFOGJg1sg9X4mH6f1jNDGp+ulHoviQhJwEQHsHwoiiDoyQ1nOfhAo+irtkUeqRxE51FjJK+QXSFd7LgtYKgcZOu48jBx03hq89L4wFbUFm4FFZBkQyRNsBXWvDTVEvqq4Kn+H0LE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mq2pMWDmX5IeJfbDNayT5AfjHb4iX1/QvHRoZtt6+LJitKsmH71V6JJhwcNK?=
 =?us-ascii?Q?fJTANvxanaoyOzTZsgxPYwyQMYOLuqvywbK87DBNK68wPD8qdLkh1zft3W69?=
 =?us-ascii?Q?b/M94VWMYIS3VIZtHt3soUJgyjg+2rMnykRBfWG8KLfzsvafzbj8d4asKCqt?=
 =?us-ascii?Q?6+MCTtSOw43d18CBNTpjXViWtXbqaFvZhfhWDpt0G4XbZEuEnColAFr4U8t6?=
 =?us-ascii?Q?v3H/JE+UmL6X/xVpxA0mm8UAtsACH51K7FgWJcI/S3iF2nHLp5Yt/0qsawdA?=
 =?us-ascii?Q?/fIej7aWXaLZbJlNM23wGgvcFA8JV5qenSftKCrMAtwnh2SUZbzdEfcHoLpi?=
 =?us-ascii?Q?CQULPptJwcULE1EiX693s3+e+f+VFoOaKYprZNzFz3yryh39fDeH+CF9ZZdh?=
 =?us-ascii?Q?tfrgFJvWNq9KPpYSubFjVhzhcNEbd2LaGLVRklOUX1hLHkP8KULd+UIG/H2m?=
 =?us-ascii?Q?OkuhD42i5z/2Jkez9Rn8iyUkI+aqKFFCFZZsYUiyulZVzUlviS+3ptlcPAwQ?=
 =?us-ascii?Q?NC51F4j0C1CbGTV8nn+8BnGWpifzUbwdu27ZYMxjL2ScrmlN+cpVOr+d4lbB?=
 =?us-ascii?Q?XRtMroH1eeGAhmMliNccfXEz6BoKmKxqX80g6HHpGjVEqQ95EJyMirBrp3/a?=
 =?us-ascii?Q?43CRKvoBJ3DZ04O3BNrldzfqNefLimXG0k6QnLiQS22bX7wwlyoR8MS/ypA0?=
 =?us-ascii?Q?1TEB2ptLJIj1VRRrHusjLE9zNPeo2LUTI+vInTPiCUl4VXY2h8wJIHwh32dc?=
 =?us-ascii?Q?734abqkajKVSXNHsV0IUs937zLpM9uKKMuWwhWluoBvJtWUnno7O8GEyrod4?=
 =?us-ascii?Q?sVFBu8pnoQIezlVavzAxXJLUdCLluA4nZLW4ykU7HXFIWAYYcVplSF4AAJmI?=
 =?us-ascii?Q?wOpRb011nc873vzVCpQXXgremmjay7KOoWEQxEW8jqBkjr2uZ3t2bnge6ISx?=
 =?us-ascii?Q?YYF38NPhlCV8G/qWiYaRV7gJ0BHRCTDcB9DXH4CWPUY/vtieIvmO1rTcnUil?=
 =?us-ascii?Q?/jF8wtQgqapEssaWQtNtruoPHwzed7lh/RH5hbT7OgH1iQqkJu4MKF6osaop?=
 =?us-ascii?Q?6v1EVRVoayFMo3K0rEhI1UXzcyskQOgFcJsnochTGcQRfxtYXnjwWLKYJyRL?=
 =?us-ascii?Q?bbRljWP00ooxxWz859c9nZ94WSYw4MlfFaB7DRC248Z6s5LMoHGlQy/Rhzu7?=
 =?us-ascii?Q?NmlwDPGfmbUG162onTjrgTLGBOBuOMcsYP2k/DBfReLJrSmyR2blHeA/qXqB?=
 =?us-ascii?Q?c+W/21t81rZamcWZigJVlX3TQI9cxBL11NKQZrvhq5R6r9kMl3UF8OTsXQYX?=
 =?us-ascii?Q?Jev0VhkJ1LXsZfQUZ9GhKXI0EtLti9DYjfGk9rJ3puFEJCLvwc67YM5Flv6c?=
 =?us-ascii?Q?DkJ2BtK/twJG2mPRPC5zAB1VrCmIldF5oeKJmBESmClfCa/U+SOLr0/joqaW?=
 =?us-ascii?Q?PaZ29NMmYC55rr3Z1W7zU6nMBhC/OQkm+CUOe1K7UOYmBT67ut2Tv4epoGYr?=
 =?us-ascii?Q?ztBhyxgUfKkNA4QuFfGe+hTvOY/AcSF+oNlh3edY6d2znQkln/gCd5XRyCCn?=
 =?us-ascii?Q?VjqhXIAGDRBV3VppVsMoQIdY6KxBi0bu3LcayOdji8jdSHLGM/6PYi4xt2ed?=
 =?us-ascii?Q?j4ukHWi90B0uGKPYHzIz94gx+X36kQsDeFNnPpaGMxYJhr/jJjAgqsQPFohq?=
 =?us-ascii?Q?Y9hXXSK91+fcLRlUu91D9l1KK0LxwcACNZBU6wJpKY+MQwe2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392d6bc6-5804-4716-dc96-08df28f7b2b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:00:43.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYFXKgIqSjjl/8kn+/5vibbEJUjg9lkDIw/RejEOlveSxAjrh/QBQZ6q5khjSeFANH3Ex+V9KAojxQhmHIAIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

On Mon, Oct 12, 2026 at 07:44:55PM +0000, Kuniyuki Iwashima wrote:
> Patch 1 updates the switchdev doc, s/arp_tbl/arp_table(net)/.
> 
> Patch 2 updates a selftest for per-netns sysctl knobs, though this
> is not an actual issue since the test does not hit gc_thresh by
> default.
> 
> Patches 3 & 4 are based on a suggestion by Ido Schimmel to make
> neigh_managed_work CPU-friendly:
> 
>   https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/

Thanks for the follow-up, but I think you missed my first point... My
comment was about the GC work that doesn't have a floor at all. An
unprivileged user can set the base reachable time to 0 and
neigh_periodic_work() will hog the CPU.

> 
> Given it's rc7, I'll defer RTNL removal to the next cycle.
> 
> 
> Kuniyuki Iwashima (4):
>   Documentation: networking: switchdev: Replace arp_tbl with
>     arp_table(net).
>   selftests: netfilter: Set gc_thresh[123] for gw netns in
>     nft_nat_zones.sh.
>   neighbour: Schedule neigh_managed_work only when needed.
>   neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
> 
>  Documentation/netlink/specs/rt-neigh.yaml     |  2 +-
>  Documentation/networking/ip-sysctl.rst        |  2 +-
>  Documentation/networking/switchdev.rst        | 11 +++---
>  net/core/neighbour.c                          | 26 ++++++++++----
>  .../selftests/net/netfilter/nft_nat_zones.sh  | 34 +++++--------------
>  5 files changed, 35 insertions(+), 40 deletions(-)
> 
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 
