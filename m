Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED23E5A20
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391818; cv=fail; b=uRjD6HtyrMWAvYzdAThlheDhOBJEpVpvRzDK2BrdkOf54h58L0C6gKOQ4+jKP6SkW0y6mLHlLYO7mcLd5RojPin4NTOGLbeNFlLEwKj6hetGWLdcxEo44nz4jF/zgw8sut06WVaQ1KlbMrrbAOcLt8/rQqIUfH8vx0OEFychGEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391818; c=relaxed/simple;
	bh=CXz7k0g1YTqfaK87oV/qdy+QSKaFfmD3dk48H4Y7R7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AJL/GQ/lk4P/y4Kx4vsC4QPBnQGObE+GEnZB4TfNc0up4uNGa0DM+n1UTtr9EYgLYDGFP9gSHFTIPNaxIQVtsMrKUj+hYifGCnWtKnZJ08ZvwcB5QzHHzcy7h6TDWEtmC6jmlExjvtbh0vNvg01/TQNgO+Vipkoa1CtCFzjlCtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lBdRIZDO; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lBdRIZDO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTPo92/vYSrER48Q26HtiwB4GBNz0pLNUuCZc7iqzvCROLSJJvOT8C7FubnYaE5zsSHGg2qxyLCQ1dJTgakccz0dpCgwyqALMcf8oX6tCGgcwuT1WqxgEP5fH8rube6nMgNdWtbNUIPTJtNuooZVT3e6hwRbKC6O7CvdnfABf9QrLe3ZPmzYohCBHkBZ4b9e4vKwFtS6WQLWelL94sy+xjbPWnShRdJKGip70tfB0C870AojNqnY/Ipvij+R2Sn8ffL27PPAz4+eo1rROlg3+1dATVvzWXTHHneTfyzNPoUQYZf4s5hXUBzBot1gO1M9Q9jkPT5PYwIiTlBUklY6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GszwjXJ+TYfAcYKZC+GGd/qMsKxqeUvB/7SqBg4ziWQ=;
 b=ewAXoadaM/CLPzYYDJ03sfWyrdXdXN8Gg7IVsXT40AVrl03PJFg4UMG3k41hcRVnTGtEXA4HWd+WV3udQXWUnc19mmZKt16y//eqgrGH0oSqroregcxa/3iDg3J7nM3+ymBPwot+SrK60MhDvA1VpUzklFVasKugFGzXHIkD0C/Eu3qgxk1pMB9zeUzGjgNT42u6BtHcTiJR8RCw13+DbrMn5kKaE6C62Z094CUaRJR7mGtrvEdQpu+Nw/ldPPKWIbnQBGsIa6h7cEzAHWTiOEfQbJHY7eiHI45w2ksBkL/M23I6/G81Rdm77TlLFMZik5KBwwIAS6CcUV55a1kW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GszwjXJ+TYfAcYKZC+GGd/qMsKxqeUvB/7SqBg4ziWQ=;
 b=lBdRIZDOm/8+33EpQx9+xdJMdzxwWxuKGBncs0Vy0VZNj4kH3l1ffIOTOinnodsKR0NhDlqxBjPOna5GazTm4FA0W5J08gt6f+thiAGsDlHLCx3ug+U19QmfMt5zHG3fTpfSHCHQ+wCbEQ+/EMUj3URpYbLjiMhyxnUZyLTjDu+ucchCAsXxBbqv4dbM18bRsVkNWvYplFUxfcbNpI+K8KwTUYqVvAkHwjTUMZcDeVNi3IFCWSSUh7C/s7tzIil1MnzxTkUR39/HzloSZyB3E4ddHpMkVyZ1DnXPeJKZkc9VnUORvSPr97ZsHzlPsiQt260gsQPxLXGhEt0aewfONw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by IA3PR12MB773567.namprd12.prod.outlook.com (2603:10b6:208:706::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 16:50:15 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 16:50:15 +0000
Date: Wed, 7 Oct 2026 19:50:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/9] neighbour: Add IPv4/IPv6-specific
 wrappers for neigh_lookup() and friends.
Message-ID: <20261007165000.GA1177153@shredder>
References: <20261003212336.1304988-1-kuniyu@google.com>
 <20261007093555.66e9194f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007093555.66e9194f@kernel.org>
X-ClientProxiedBy: FR3P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::10) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|IA3PR12MB773567:EE_
X-MS-Office365-Filtering-Correlation-Id: 35412393-d218-40c3-f3cb-08df24930f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Zl+8HmbWC3h58BT8p4nz2xZyG8HlpRaSJfDmIhfsFuqJbrkv4szZHLFhca51cy1V8hfENaPbmrMI/CeJo3Tx3j1KhfU3FOjmgYRTg5B1gbxATUK/KUmMmt54wpGLrLOvIWTImzEKGcjd73wsUI/3Go4bOrKQAkQOBMI9xhtGmqoG0VMQOBXqFGqwJp6z44KYkd3Kc4puuamWJi64rmbUnbcMwNxfu4Zj501BOKr+tdIUSVA1No8PrJnHnOh46sLk6QeUO8O2RmqgvoX8z1V9tpEBZRugapqiC4OiwM2hfBuRAmNHEjmTQ5nkMjZu9v7tRkF9xvBQzGHN1gwqhN4bLAm0elA1ZaAqiV0PGGwTN/NreltZnlfHmhaZcLqrnfaVw8tnBGejTKd5to1TuE9XOrujANrn98jBczOqa/KbHblkxABnKWZuFjdmJZsOxO88ZJvbfthZvIpJgjcyUH3XXueMqX8AwDzUu7V1bz3Lj4H9GmT8HNQmzRRmvNHrAbmctuM9lLSGtllytOcEMcbaRJjuaP/dRQ3C1qBXgFSiw27yhBTF1uDTBRtigNML3GxSVQ68Id4buXXbw2M4YEg0Se1DfalrhHOOcIo7F6CgBNPndJGBVLzcCHhX/dRyrzEao8QonTaYenYJsosmfrVvS12hkeH/L6Y7DYEnsk2Q3hg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vQoBJVDcOoESK/U0qqZ5+LfNanxCmInANQSARnvu7ByyeIp9SwiEJT/Y045Z?=
 =?us-ascii?Q?bwIHjQps5lLh//pCDn+gjwbOsjEf/PuZq9EzxaTD7dY7qLVkMNR/QPXqsigo?=
 =?us-ascii?Q?JtDa0nne7Wkaxe2rwAV2YtGQh4gK9xvfSwNe9NMFX07JZCiy/nYW5V3tE+I7?=
 =?us-ascii?Q?rHiRwVSC8OxhFRnuxBOex29XqMXGdfMSXfk/ovr8jY1RtR7a0Ga8J3LSE4Sc?=
 =?us-ascii?Q?rj5Qf/oEXG7xyX3IdW/Xh8ehScoS9Bvh5erE3s3FOVoLdzd6ykDm2pCpzUQ9?=
 =?us-ascii?Q?BkCWOF3Q9Dn01L1JqYP7kKfgrw1aT2LTcjgsa9Len5QZz2Cu21xB3NrCCgit?=
 =?us-ascii?Q?uqxTtHRElFOiIGoSKCoMnzvIg52p8hiFzWjGqyfmcx5sFumBGHH/b6fjalbk?=
 =?us-ascii?Q?E989yl5arbXP7x+iFpkchPYYJiDyZYJn5wa9k9R5Qk50IhJDDvyprbaw+UMF?=
 =?us-ascii?Q?hfa5Yoda3+xzNg+nViDBFWqQDI9kWsTHWMXwrCQld6kAdqURV8qEz0Z3Xrow?=
 =?us-ascii?Q?zI+Glz5HqxdsvbLLu22yY5+52MqEMBdcYkhifQgwCKUoULbAVKGyAtGFLDoT?=
 =?us-ascii?Q?/cXUNB4frCnmledpm+3KvhjnxpTpgYKAkjOlccwms1mzvZGCRrmipNr1GS4j?=
 =?us-ascii?Q?gv+KlAOx9sNoBmvetF0VWsFfKRWp1zT2oDYXyumM3cCJWJbpzMj7bXrOgteX?=
 =?us-ascii?Q?lNZcK9EYbYMSDB6cAU3sI9BI3b4WsguIkYs2IdzAXixdzEyqIQAO0Q3WFAhm?=
 =?us-ascii?Q?P5vz8ItuyxFZ/J4ePNzMZwH9wK9kYIz8PYoQ1ijNeNvSJ35LJviZ0ZZ9D5I+?=
 =?us-ascii?Q?QWcjNFSLPNB5SNWA+OdAvO6J37v4CTgQF4jP0M/NsvS02+ef3Hf2y10OniZU?=
 =?us-ascii?Q?E00RZ0aErCxBbEwIX0HA4YhvXAwP+mtH8sy2b8O0Qwm2tKfw3a1NeulmxLI4?=
 =?us-ascii?Q?ZTYO+mjSGWqAXqCXYIkSzEaleqV2uLeTb/Cd50fsDruA7eDZEVYf4LgsXUPh?=
 =?us-ascii?Q?DIyOOFp1GK7tToHB7l3LbY9lWbTjEx673zKZM1BxeiaDX21SS7SgGey3sBIX?=
 =?us-ascii?Q?NLtevzqwKCG1UMm2DZy1JiicFlazRXNCP3D6lf3BIALcZ+fbhov2GAHX61Oi?=
 =?us-ascii?Q?oKV4oH/qbHkhQREGyEJemgNo+yRiKn9tH1QHi00jKmwrpVV8xGuGo9J5e6nr?=
 =?us-ascii?Q?fA0FKnWUZ0INCrexS2vrfDRzYocgNFAoQMgJ/ZaV7uTMo1LX6ltjd1Rp7BJE?=
 =?us-ascii?Q?nMymy7qYWLps73XipWYhV340NLjUf+G22VjAeY14IySvM7w57pz9yoyRZ3TU?=
 =?us-ascii?Q?yY2s1QeoVTUvgrJeW5MUxu2JPSZCko0vs+wgJEJEwNHCDdRp575RnJU9xhp2?=
 =?us-ascii?Q?r4WtgLiZfHG1+76E9vvIXPi3B5Ur+5dea4fVWSn3naSHoK3nESJmOEsZizRa?=
 =?us-ascii?Q?U42wJmktlnF2GKf6H8saAVijG09u3JblD3eMu/ro67KrVGOHkLFa9eSztClw?=
 =?us-ascii?Q?knaJ1/nwOOdaC90EttHN6113prtRT5D7iwc4IYtdA9hrZj22wx7qC1Dr9/dg?=
 =?us-ascii?Q?46LViyvtSKWJUP1bYpdYeUcZMFDqdvkmW3yb7BeU4DRLcpy3ynA+z1iAJWvl?=
 =?us-ascii?Q?ofi75mFL2L+Yao+c7sg9ZTa29wXZ8M9FeiJF6G71OgOgupC0t/3Bi77l7EyR?=
 =?us-ascii?Q?F87/+xJ8oBuywyrUzhyYuVHmQpJ1OcM8wFgcatg4TZcZLwqr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35412393-d218-40c3-f3cb-08df24930f6f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:50:15.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00D5aV+nbUfJhIPFwUxcdGCzTo4Za2blOyv+9Q09Hhe0kwS7DTZpOAJKdzu4ucoK5Elkw7YRR6pFawhmojJYzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB773567

On Wed, Oct 07, 2026 at 09:35:55AM -0700, Jakub Kicinski wrote:
> On Sat,  3 Oct 2026 21:23:13 +0000 Kuniyuki Iwashima wrote:
> > syzbot reported that ip6_finish_output2() could pass tbl and dev
> > from different netns to neigh_create().
> > 
> > When namespacifying neigh_table, I chose to resolve neigh_table
> > in callers to minimise changes, but it turned out to be error-prone.
> > 
> > This series adds IPv4/IPv6-specific helpers for neigh_lookup()
> > and neigh_create() that always fetch the netns from dev to fix
> > the problem.
> > 
> > Along the way, the confusing and now mostly redundant helpers
> > __neigh_lookup() and __neigh_lookup_errno() are converted and
> > removed.
> 
> Ido, David, thoughts?
> The unusual (for Ido) silence makes me suspicious :)

Too many other patches to review...

The series looks good to me:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
