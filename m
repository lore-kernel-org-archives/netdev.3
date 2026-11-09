Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211633;
	b=D3xQsdgaDalusCZGMUDXsP3/xdC9TsBeZzuS0pnt9MftxDhQ8i/M+IEz7MscLg44Ow6n
	 ReeYjAOJmRcbJSSoUXvdipM5y7phw+6OxaY/DRb8d/jRloWqwbiPRFe7f3f8Gt+p81XRI
	 g1VbEd/9wp2DkEtuKGrShbs4kBK0jS7Nx5/1URNiHc9+aCnvPxX71XEy1JnCLIrQQzaV2
	 G5ahRcCmUBSd6MmvqTDSi2XANPGvRh75pJdegWvj/bQSQkxJ6d1uctLuEkESyOFbdNBtw
	 +4l+8dtbUtaPXcWr+YVQen0lEggCySNf6fVFkcQx08v+U+saefzoBu+zs6cjrdH1PFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211633;
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
	bh=x2N00hG0rZtLscUKM6HXQJ3Zimj4vjkcHA8+M9WrQeo=;
	b=eRYFwl4yKFOa5MMi+oFo9m/+TVLqwdYVu5X2WMi2pb1UhCXu6VnCU4Qv5digPosL9Lud
	 Wg4QcFJIG/VSm7r2R7S40tTPlTVQ0SJrf6ZEvgvoY8E8d4aJ1otinVaOENgpoKzBn0z/7
	 gNAr8GyphWW1xlJ5158bZtqV1KiGh0h62YiSdHv81H8ues19YjECQlQNWhKEKpPDjLwFz
	 /jfawNdrRChyKogD/RvJ/UL/OQb/T+YI3c1hk72kG3RvqYNSPfGwjzYw9ABwUSOk1MUmX
	 X5mmd94H3A5RpV1TgCXiX8oqzCWFYmUl3SXg95qpI0YfBRE1IDvg3Ac6IPm3uAbpY3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QFvs1B67;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.42
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E7606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197E7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QFvs1B67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ3oOsWGBKisl33HNSEtgr6RjH3isnr+Wk/bjjSxKpRVsG3MG+RiqCc4TxmoJJwTzFYe/LK5BCZQ0Ns+6avzLVn86JtoOufBbIwSV3MQTOLa0/7hbe1idV6ww3+1cv+n18H//Xiz9rx1zSm649pq44flZ2rKrkOers2P9F1204Jdq6GXTHPEoG3xaZmR7pQloL01Vw30QGuC7G4dQOhXpwtEeBoTZtQEbuiErhJqpqVUsDOtgc+OKADkiHyA8P+k/7rgKwv68JWVrqDVRuCn0pSmIbooKwIKhRtTUeT/jTK8NfQIgUvDDETmxoiKN3g4qDDjmwuHx1lMSjFCqwkHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2N00hG0rZtLscUKM6HXQJ3Zimj4vjkcHA8+M9WrQeo=;
 b=tB3fWrHBQyNEoNq27cGodwWtmo8LHxezPWcYf1mHXhSID/umal92cNBMebouMBEhSVzk6mr35zAAvX4e5mifytAD95TcTMIvQoSewng3QdB3jN3oBgy5Gql7Ebl62MkhO6Vduf6tNT++havNpwp9et1I+t9bLQLZhdNr7gHN6cIdVtHVN9unPADWE1mItN3r4tDDf+N3+52c8yFi5ePjN0KUlHpCTjSX5q/rNhw2D3oQLj5QwaIGU7Z6AuL0wUtplzsIhFhCdeOX9ib1M3vn6FokwoPwZ/jXpWwsse6qFQq9rDpT9i5FKjmsXk8Dpo5cwIXXuhEVl8e4+OGgvn4JiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2N00hG0rZtLscUKM6HXQJ3Zimj4vjkcHA8+M9WrQeo=;
 b=QFvs1B67M9oCjfxPl2E9BQl4rJMHd9iMqzLEVt2b/nxdHA1jD+D1ZElUhzwZR/bX8LqzpzSmylDZIL3xxk0iMA4Uk1CEHS3aHd0wuZuO6jlF8ckO7bYNbXEMFCklKKh34Ysv8Z7BMcLciAeh+T2mgtW5Je5Za3UjIdOjRoM9Cy5WdpAYIVof4cUVqBwZ3zKf8irn7SHsXxw70jHGYRvGniar4mWBwp9C+YdW+P1smuBRwvO7ZvX4h3WyernOxl7P03xDKpyGjB3S4MK00YaH0jBocMojPJCpVpDxt4x6Xzr98zPr/J+OlJ2Uxt8+AS+HifhU57kkGlidZ1VAdo0UKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ5PPF8AECCE022.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:07:08 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 08:07:08 +0000
Date: Mon, 9 Nov 2026 10:06:58 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH v2 net] inet: frags: bound the wmem charge of the socket
 completing a reassembly
Message-ID: <20261109080658.GA1454873@shredder>
References: <20261104122927.1033747-1-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104122927.1033747-1-edumazet@kernel.org>
X-ClientProxiedBy: PA7P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::18) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ5PPF8AECCE022:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2e79bd-29fb-47fb-36a7-08df3e387385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	PaooR8dNBSXDNSyFCW+aWikNw6V8tV84AgsLR23gxX4OuznREss+nwFkw2u4DjFtRoDyGX3sR7seDuqgb17mbhLmDDCPkK9QXngKu7MPC3SRNf9MVmzcKt8kUQkpQehGXkmb7ks6zj5UictjnbJxDeHJ4NUA8XfCrtdNja1GzOLbl0ErIxrCWCJikHZED4TrWNtJll4ZPIN/Qk1Wmu81lE2w2hLWC0oUMz0xhX9l4IbXTH5FLijVrW/6tjWkmkB4vwXb88lJdaOHd0QlVNKxd7zlrILTSKFS7rH/ttj4LkeQjFV00mkp7Gh+saIvZiwHI93p2/AzIEFb+hh+4Kp0dd90gjFkbrnJAqHsghnQsBV3MGxva65P1+BtS6JebmYkTWbq8qi+yFWXtIAahpHpDk9ZtpMGctMe+xyJG8eAZjUdZGvxdnI80Yw/FD3f6bH7KiNLfGosD77s6yFzw/BInPLu4RcVwwBAh5DOYy9r02zRab3A2HJaiaggy5ULSqROdJfK2T9d67iezk0St6tgk9qsQ6Jn5iMdC4PO8c5jq52GEFm/Arb0lojK65f8KwknfjlriY4+0cOhjLq/EZKgWTDiSyYWnL6+3XrI8BKK1YttuytRWsFfOsJ41K+fFlH3FL8XFfF6wTnmiRDUFiA1LTpziFka459in71ZRE90fBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?myr4OBGmBo+Bnpd7FO/Uk3jXFdihzABmlTZLFpwP7v1lY48jC2qh9uffq/dQ?=
 =?us-ascii?Q?HvwX5AHTuOSGvr0MLbLSJ/3sheiXU/YBR2unDzHuRFCnZxiPRtI0LT+PCa8j?=
 =?us-ascii?Q?A4RzUTtxM5hzvb0evXuta34HCC7YzLYj7b534cQ32pzV0VOTCaDbdQXy0I0q?=
 =?us-ascii?Q?IucM0qTjCpIs+ty+dx2KMPhMr8cSjy0/XpJ7H88qhVJUkb0j0xbWNl2pBmDP?=
 =?us-ascii?Q?TQHXcZSvZU06qGdH432oXVX0QiqSiAevnUh8JUo0Q3v9Wy+8UU8wVC/3GTDS?=
 =?us-ascii?Q?bRfwZ3PFXHgh6jQpH8r1YbovgGKL/INaziH5iG98lusvHFWVBIQgWOY6eBoG?=
 =?us-ascii?Q?4ketvfneZoQhudStpB8RiTHBFeVwlPpNRSYo2xNqreIy150sT6bU6mhitqbf?=
 =?us-ascii?Q?hWILqbG08pn8EpOnx95XweHojsz1b5FI7auuASQGSsT6ZPb1TEnmyunhqIrR?=
 =?us-ascii?Q?fCZcaSRt0ETIGp4Kt/nO3COeR4exW7G4gybhz0lHk4qyC2f/+1udLNU4tDn+?=
 =?us-ascii?Q?eiCj0ghCv0Qo8HVXhZ3hWw7olPlcEJhSmg7eNvLncWgwg7Cum2I6UTG1VxB9?=
 =?us-ascii?Q?O/Qzu9Dwi6sElOmbL48f5yx0OaC01thgVybA9kBIwj1rtS9WzHHJsCxK6q/6?=
 =?us-ascii?Q?s48s1pA8MTVe5QrTFuodNh02J4kiy79rCNLrsrj5SbUbxYi32noNJWbdc0cB?=
 =?us-ascii?Q?v9KNq74r6hRaEZxHkDB/T74OL3yz4hec+2RhFtOWLr6y8W4e7uM4L3NV/Pzm?=
 =?us-ascii?Q?yhKGrTxSxVsalSkzH6aHYF/7AAnPMTBV0B807Euh2yisaGZzYsbShyeUKP6C?=
 =?us-ascii?Q?DknYxYB+2QR/BbvQpT5Vs4buvVQE6Q95INHmIu62o680NjbIuSS0ewGukGlE?=
 =?us-ascii?Q?Y87BuAciTRH4VeHULAZBiIhx4fEPD9p4hsOcs+TbxHkh66Wn6Tif0cJz4eZx?=
 =?us-ascii?Q?Boes4Z5I1McNLeugUfuPSl0LsALFix9ESNz1mZRVCsInhauMmmFKztSGzf3B?=
 =?us-ascii?Q?bGA52fkZi4NvJAZxGlf8JofbrcJHHFSsCE5rYky9+mp40k17Mp4R1xGLDryO?=
 =?us-ascii?Q?b7sV8X+Yi5U6zUWywpSzpn3BTfppSJF7a/CfHKysUahuYqZyRRbP6y6t5GD6?=
 =?us-ascii?Q?bFKp4QrquNTtkN0JgwYaEQs1D5qvk6JMwG0PVOOAvOq55c9fe9AD+UlZd9cG?=
 =?us-ascii?Q?8coNfvlD0pgIFoAsHY1AFdsUNjbzYzH/+/aULbF9u9X3alKVf62qq9MJGrWX?=
 =?us-ascii?Q?F+5v8QqC30Q1u5MOrorHEozod+KY9/HbkEh+feipzKE3q43lOvh4MX6si8ly?=
 =?us-ascii?Q?dag2/7i7Ik0jL9mjkiEGFNs+KQ4scEsD59EaT44W4LKAlk1XLbPf5NFT1B9J?=
 =?us-ascii?Q?UJqg68nYk7xYIUeqMDTeLWhzGFUp99cKPLrnlZbR1MPFwIjuyo6gZcYbgaCj?=
 =?us-ascii?Q?1cpbT3BftSOtzzt3AH7YcreQmUPVmsQbYKijfGWT9vPddJINvQ7Eyy0gacuA?=
 =?us-ascii?Q?083z2VDgPddfc0ZIlvL7cpL+uv1qjYje0T9Tx25FOdZ/ODQyRrV3OfK5AgVH?=
 =?us-ascii?Q?RPv/ypkvwWu7bJovJ9FP1SkN6Cc9DhWFOHTRiFZmFnZ2fR8HxQ3PseaVMG4n?=
 =?us-ascii?Q?c6UFGJS6495jFnKE7o07+oRiEVtozk6PI+cazOo5FiOVmu6/4eG/NM3K/0c9?=
 =?us-ascii?Q?ATzu5p/uSqvTm4mp5uGuDt87r51H8p973atgG153XM/OjohZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2e79bd-29fb-47fb-36a7-08df3e387385
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:07:08.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGiJmK/UMlYz4dFKBUGCTChXHvbYOshgGX9KjHSeMFBGRbHaILU8fPMUfZNLNP+dpfhymHiUEK3k9YuVtohBzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AECCE022

On Wed, Nov 04, 2026 at 01:29:27PM +0100, Eric Dumazet wrote:
> When a socket owned fragment completes a reassembly queue,
> inet_frag_reasm_prepare() and inet_frag_reasm_finish() charge the
> truesize of all other fragments to its sk_wmem_alloc. These fragments
> were orphaned when queued, and might have been sent by someone else,
> for instance padded TUN packets.
> 
> Commit 3ae20e4697eb ("inet: frags: limit the truesize of a reassembly
> queue") bounds this charge to INT_MAX / 2 per queue, but a socket can
> complete several queues while the reassembled skbs are still alive,
> for instance held in a qdisc. sk_wmem_alloc can then go past INT_MAX,
> refcount_add() saturates it with a WARN, and the socket is leaked.
> 
> This is reachable from an unprivileged user/network namespace, by
> raising ipfrag_high_thresh.
> 
> Refuse the reassembly if the charge would push sk_wmem_alloc above
> 2 * sk_sndbuf, the bound ip_append_data() uses, plus 4MB of slack for
> fragments inflated by a refragmentation with a small MTU, and never
> above INT_MAX / 2. The cap matters for tun sockets, which use
> sk_sndbuf = INT_MAX, and whose skbs are still owned when act_ct or
> openvswitch reassemble them at ingress.
> 
> Several queues can complete at the same time on different cpus for
> the same socket, so the charge is reserved with a cmpxchg() loop in
> inet_frag_reasm_prepare(), before it modifies the queue, and settled
> in inet_frag_reasm_finish(). Move the size checks of ip_frag_reasm(),
> ip6_frag_reasm() and nf_ct_frag6_reasm() before
> inet_frag_reasm_prepare(), using the first fragment which becomes the
> head, so that a successful inet_frag_reasm_prepare() is always followed
> by inet_frag_reasm_finish(). All callers already kill the queue when
> inet_frag_reasm_prepare() returns NULL.
> 
> Found by code inspection (AI review), not reproduced.
> 
> Fixes: 18685451fc4e ("inet: inet_defrag: prevent sk release while still in use")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://lore.kernel.org/netdev/24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
