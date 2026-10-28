Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210244;
	b=EGs6j+N7P87iL8JaNvhTeIGCEXJRZrAcCWlzPtFGzugiEQjG6j2FaSUEchVI3U28n7EU
	 g/26YhsgIgGNSdxen/X2DfRbYh4E3yFPUkU7IAqQWWwSrKby56D5NP/sZXGjx9vsne/HB
	 4V8DSOOW804yotJp/wBl8WQawDxWL3UeuveoWgYa9b+IZoBxoBPqzVMYr55BC2yMhNqSw
	 hx/wysL6byGkbiGeFUquFjtOTHM+nVFJOTbgb4nLwUBEEPNk8SB9lyun+O2KWRRt++n/v
	 7tEJyTT6eYCd/O6rJ44ge9avKfFM3SotdkjmbA76baLpI5IbaOKlfqZ01IaYRikxTSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NLi3/BG0Bs9B56hArwXkfCuLuGaxIXRi5A1vTeIzvQs=;
	b=ONwh/kMEthGFtKggq+C8EywuS9tBK8l9CHy7AKhWqSmr/HzezI8s3w095djDPQ0/x0iz
	 drkPRLW3SfsT+E7A8Gkw9pRZfT1uGbTTbBIBp46wWxIczgs7d2qy6vECfQWgTwKWamQ33
	 axd4V4yy0u1AsFCQ0p1RSDy3x3eRlHR4dEhc7clFyVd5qtmcOf2FpcE+fPMLgszghp61Q
	 5oIcSwjggWt2VDH2LAgwju5wHPXC8MLhsiHsJ08MF7fmJ6TTjHmg6HdAOCYvg8uGrhoHi
	 D/Uy+cpMLtfTTdP8g0A1WFHuP5u5I3iBylpyL6jP6W6GamL8FSydlfH9g9+TVrfC6hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WcC6GsGU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.22
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF7606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73CF7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WcC6GsGU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGyiFVAonEcEBInE+kGO48OS7VSfW5rbLNXPnovaZ9PV0aGA0/4xa9hC16XGQBrvfDcx14fwFb1558dNhKw9e6gOWnheBA7AozGUEmBmNp8qO4JIYDuAOg1ddbqHYGnLQBh5bngWOkVhELOAhO0Y+0q8grtNLCGq8+BneFEwK3A1PIQSVUKL9IIhggIETU9BU4f4u/3/QK7ljLK1brrqnXDUKcE6hBdmAa8y/MB1qsqeQmTVHODNVaIYKgldBIafaREwha2fNb5/NhA11iBn6Hmv7oaONnxBjeM6cu3rpn3hooDSuPJIIQ5TUT+w2NG4j9KvPgAEc93xtK4enX+i4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLi3/BG0Bs9B56hArwXkfCuLuGaxIXRi5A1vTeIzvQs=;
 b=UzOUzygyKr1/zCE+lHtNQZ+Bm2TH16cY5mKaZ4zeuBbDlseqs26jwQ2oxcpfk2YzxhzTZqWS0mcBdVeC6enZOqtxcsg01/ilg7Q2RVXNZWMw9Tarl1bWoJZfe6CC4hQITV8WHvErHgmR/qqHQyMK2gU5ilWGK7Vwdqum/BOr94VOAZCD/1e6rIZspPx6VBe6Nyt/VCTVGCBkMRlc2kqFkFhrdrxvqKwUF9nZ4XaAWjOiMPV83bC43ynpI+qFoQLltiCbdaN64Iqows2C9Yn65wKDL+4FBMEi8HrRz+OPD5WpCTr1jJwicjAknA0LaTb4j41lc0iKn0Blsv1u5tFr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLi3/BG0Bs9B56hArwXkfCuLuGaxIXRi5A1vTeIzvQs=;
 b=WcC6GsGUDyVPSWDt4TwDGu56ccxpJnlu3Lx0k82ot/fZj2vezXZQmytSRdmYftkrFqnOr48bAzUKdssxkaH8kY/baCtWZCyN+esq4cPXAI8A/4oOiC3gq1NvKkhvZCdsXPMWYp0HsXwvgZpdt0DJqDHEfVkg/rKe+aVJMJc1o/C8V1FjRVXGUgEkokzN0+48hcRi04xYOXyvw0bOvqd2mzc09xm/cFigzTj9TnV8a9le9598MEkKJQ623gh+2Z491n9NOCW1jlImedSMZXCCdJb7KwCA6d5HE9n1QG48YHaF9NTh0BzYEl1GdILv1cISmWbTPtb+CKsQ493SOincfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 17:57:20 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 17:57:20 +0000
Date: Wed, 28 Oct 2026 19:57:10 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Sascha Frey <sf@techfak.net>
Cc: netdev@vger.kernel.org, qotmddnjs@ajou.ac.kr, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com
Subject: Re: [REGRESSION] vxlan: duplicate ICMP replies with nexthop FDB
 entries after 3fa64d86fc64
Message-ID: <20261028175710.GA1116088@shredder>
References: <20261028142928.GA8406@techfak.de>
 <20261028150824.GA992905@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028150824.GA992905@shredder>
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7a04e2-328b-454e-ed55-08df351ce940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|261026121527099003|10067099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Jvv54JauEKOdCypYWJFITAD3yDFl13q6iTXB9f7VYHt0LkKUoo4SiE3UvH0+0aN7voz7DY9Dybbs3cEp9n4fbECqzph440R0iaXvWc4ttJWqinve5lCnTftynzJNgc9WLAqzL4Qz/uZOeRQ9EyLwCn1hYHFH0xJlxbnd/KikguvJCaYTRIWuBAe7jZKaIDl0uvCwMLhnopveLHYnlH7AkV/ZBhUe7fZdbYYMcAFzQKY0K37LrDI03YNZgMO3M/jY8QlBEn+/7NppWc5LTZj3w48FWAWzf5UrOxTUMKHSuRa00lMSsibnqVsFXTj1b07icL0V91GBRS8MGkYV3FtLvBcwkSsCRLyQLvrSYH+a0DZfsIKJ/dnVO4iUZeKjpvlk6kCNU8dpvD0rVhF0bVP/mM5T9gSruQKWob6xQViI6N33yO0+Vxo/pkB6xU/N/gg/JLReZF98IafugNcBUhrFTD7cuOMFdYTcVFzY3zSgjL/69KNitJMPq1qy5RIah8J0V4axmKfdnIeMiiEKLljmgTB2U+eCkXBpeMPdCaU0lIOLFfkXj2XfkFUUyvNrpczbfTYxR+S7BDSOd5GfuRsswEQhGBB69GvbDaZpzXOueb6lB7FYRLQKlkFftUnL/MfZHCgDbzRCzxH8OKYhoNYHVTVuCTgMVrii4Lip+6SS0SE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(10067099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYTay/ke39Rzm13pGH0Y7odAT3BbSO/SXOKxBSkZUPNRhdPeRO3Nj8qm5+VM?=
 =?us-ascii?Q?WYlW73O3w/tB32azbavtegZzlUPtjT//fDO3giNNJWwmNW479zA7CwcCNncp?=
 =?us-ascii?Q?TwVqpPlwSGD5sSa73NfRqSbF76yce6aS8OjKEVpQD/zx6nrNoxpR2BuvggdB?=
 =?us-ascii?Q?Jiz61DUt2rMKJZhgtEkHKJoW6nf2Q4Jwg29Y5bFGArie76u86JFeJ+EHee3W?=
 =?us-ascii?Q?unLPFyZzgNc31A/NeRywt6yc/GwH43sZVR6n6CFrQvQkzHiCEr9nJTPfF/IG?=
 =?us-ascii?Q?EOFvWgVHt40oR4BKhdy33l1LHyyM9F+WHh6PKZeIphcQGPppQz8tRGhmCvQ8?=
 =?us-ascii?Q?/J/b9FL96FUUMZyMqG7QBDs+F+kijDIyrfW3uEcrol9xAdz+e9TeYLLdFAeA?=
 =?us-ascii?Q?W+FwWTtL6CFsq/L5B1Rmy6IGzUhE8VqspV2lXhbHbz248/4EzRz3Kt3L8LFf?=
 =?us-ascii?Q?4XxDjzh7JvZuC3vtVYoVF1b7gYB9NnH40kWWrvDUWE3pInXqeMoCFANSCevp?=
 =?us-ascii?Q?NSTrvCx1BZi56u5J+NoS1NWINPPmWaG6QRlDYM3S370fNlpeS1T8emw05Slm?=
 =?us-ascii?Q?W6Sec8rCGDUJQI7/gs6AoQ4YaAEkIYBgSONSsA4acnk7Qn/nLrQgOHrEYLnc?=
 =?us-ascii?Q?BWscaCqpHIbN0wDVXUIGGy2tM0IxYc05HT4/fuAxKW0x9wMtvxHEqIGRH4V1?=
 =?us-ascii?Q?KtDmCCHfBr9iWeFS5bhO9aWgBpZOZZ/QtUdRjGl57l08Dm6e5XmIWlu8Id/0?=
 =?us-ascii?Q?ZVNyy3Rk06zmw5a/8JL0qqzcMaDxFS6v85Dewa4SPA4UlpfCQZx4+ikGRWhN?=
 =?us-ascii?Q?Ck0a50v6XGH1emI8MwKe0ept+nf+se32d4KEUXaR9ELeq8cvvFnjYKmeOLsJ?=
 =?us-ascii?Q?X5v7XdWHHI6RHKRDFsho8QoWqNR9yXVv5xrR2ybv8a56SuJJ+j1dU2eucqJV?=
 =?us-ascii?Q?JPc6wzYiyrxIhVPMWxP8WrnWpornsVTkSzKZCsFKx8f3blz9XSvsz4j48N7j?=
 =?us-ascii?Q?b0AXydwLA21/ZZ2b7G6+/bknJBzqm4YpMluX5rv1v6Ikfl0F9UWbhgdZrcwJ?=
 =?us-ascii?Q?OXrKcRigTpABbzD5KAOfxTQqRRi8tJfptoPVMixDHafbUjlUwtkp2mXlDYXU?=
 =?us-ascii?Q?qmU/zT4sAzduF3sY25Yfmp9jdpWISBXYAECshY7lssl2Cw7/wPlRVd9N+0hD?=
 =?us-ascii?Q?esPczG2sqT6X1JdHlpXIzwbhs013mozoZpWv8YcckFB2LZJjInxlyA07JKhE?=
 =?us-ascii?Q?bwwkRTxWCMjJMI0CyNSWiWqJb2CRXLYNLxgPMbYMvOdvqKea8meWCqps53XP?=
 =?us-ascii?Q?+38r4D3PkS5b5HpoMym3hjmXU3jSf6whH26YQFgjnrtZwqDadVBmuja7mwU8?=
 =?us-ascii?Q?+hQgQP8PdTA39h2NHlIw0QYTFqhQYUL8ml8Ih+zIuCwJ+6WCvulTGKaWuQWf?=
 =?us-ascii?Q?eQN+XmZYVEk5Y1TxmR77A/eQ8L4G2H/eQkwsrGaicNLDNYNLnwh3kUG7mEwF?=
 =?us-ascii?Q?280CH2N0PkLi2BzMPsbN3V2FvgBGn3dgqef6vUYDCbNPnMQ42bnvYj6DLFE4?=
 =?us-ascii?Q?zYLnBjBXjbTRed7jfi1pdtrf63BZLTwRODQIfM8UphOGa0SKLVPRBWY8E0Ss?=
 =?us-ascii?Q?udbV9WV4mxkAThG8E1VOCKsqa0yrtS4LfbMIZqqSp8x8BsDVuCu0/t2F1aQZ?=
 =?us-ascii?Q?S1xjPBl+ZX3kx3Lwf7Me6hkeR4xv+T2MejH933H6PNQF1+LJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7a04e2-328b-454e-ed55-08df351ce940
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:57:20.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSA1K8XmCoZdvauGcs1JpNy+6mmj0Qw496n8Zyu2cEKtHQfC9ylaNhwIGyuzhCWi2CVbpqssCvrov3jUkJhquA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

On Wed, Oct 28, 2026 at 05:08:24PM +0200, Ido Schimmel wrote:
> On Wed, Oct 28, 2026 at 03:29:28PM +0100, Sascha Frey wrote:
> > Could someone help investigate whether the new checks can interfere with
> > EVPN/FRR-installed nexthop FDB entries, or whether this exposes another
> > issue in the VXLAN FDB handling?
> 
> I believe we need to relax the checks to allow "extern_learn" entries.
> They are not subject to ageing (vxlan_cleanup() skips them), so they
> cannot trigger the bug that commit 98fc57d16744 ("vxlan: reject dynamic
> fdb entries that reference a nexthop id") fixed. Let me do some testing.

Please test the following fix:

https://github.com/idosch/linux/commit/8d98fad34ed4ec2b5e0253a68ead7e436ceae6d6.patch

It's on top of current net.git. It won't apply cleanly to 7.2.y, but the
conflict resolution is trivial.
