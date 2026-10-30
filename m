Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793376418;
	b=1ZrXJxkQYj0Zkqr0/D3zVvjxhGAlgHn8iFmRGyPchY4wBxiIx5NX4znucU3T8KMM+wJa
	 A7aBWha7Xrrg0w7F/pgQgxso0h0A5WhaXQOKKHBFkik6D/KgTBIl88q5xansAN0btN0M1
	 dhDeq3aTLVRc21y3HN1VKKUzjhekOlRuZu43lwDEDiYEnSyOB5Gdun1A+3NK/ONdJtojT
	 85px5+HfG3xiDLRj/ygmCZr+uQZlT1VGTZ/Cxrw3u/KcqnmdIHS+ujYBLU76CwpqSO78i
	 iUh94IWtxtbCPbMn9pgIDX/AyGw10bteYVIPcGAB5CcXAKoa6FrJKHUs2Js3Z92hHMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376418;
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
	bh=kQGMDdLQSrlzIaZx/Kux8+psHtyGMJtJLZJRyaW9zmE=;
	b=12JKRBO5xisZbu5t4yLz/gGjA9AI4xcJLryU6a1JM5GEom2l7r2m3JscfPg0MKJJhR7L
	 JuRWzyWyn6FLY+wK/BLmYjUSeMt8F73cyGDIPW9t4vKvaGGgolxdhHH5Jlbj21O14czlg
	 /c5xJBV+PRz88/LadKvU/9/25kfvYvKFRq0ek4bY+t+DyrY0R+1FnmHb94tGJGY0UjMLe
	 wffTb7Bwd8c7vaWPj/9D1ODBOSQoSihahcwkqQoZuT624q8Zi+7bQ26Cd/Pxq7IyLTAEm
	 qO/aMr3kLPqvsNI7OUm6OHhbwgqktfl82D148oGJ80plbixoYcz922B+8sP8iXDR49w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KPZLotvG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.67
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7D606A31A;
	Fri, 30 Oct 2026 16:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KPZLotvG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epkV6aJHRkG3KmN9h4NRAlurvx4QdY+jLqGJoUzeC905uuJqU2r746GfMxwyOkgQpryf5KS82TAAxBbPSZbPFiqTnRPNufUjGzaoIakweWw3cBUAbLnV/EknOEEX0IOrsS48nTXS9DP/z8u/RGgPYvwDxI4dEetoEInHN+ur0IRlfEMkICgxgyCLCWsjx6SNBHoRhWcyJPepZd3aT6Y89UZzMDgC2B0fhlvSF9WHLP3lsdt5TlMFx7efZedmgpHfv8RUz7ydREk7jRUG4zX4DDmoW2VTirAphRScDHS09Y7UUPECDdnhTRZFyZCC86TeZQztKXv3X/Bzjrdx8yBXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQGMDdLQSrlzIaZx/Kux8+psHtyGMJtJLZJRyaW9zmE=;
 b=mIzTl7WbkjRsYHeqrdLEYZ9f8c9KBbMNzA7rg5j2eLivhkCdkj0yIUi7DphdgwB+8sCa8sdxvMO6gRFkpM/Uh09eHFHit3RPZUS4EUFS0WT+3+2084r7uNr+UgsPqfKisY5ERaTCQrOnzpOR9sEAHpxaiQUttbjp3OX+MSjnYAwLTsz0pex0062NGWLCpOZgujbQ+I57wLf/w4rsDNQWi0Df6C7nmn4U3h0+QJZoMeEKdrPHTAjQ15Xj3enKYE70SMh+LIKH7SBZ4P2cWGRP/MhLKMYApoFU3++8EXh/mORPo0Cpb05Q5LzFpVxjonGcI9o6pTq9fL9+DrohRXpo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQGMDdLQSrlzIaZx/Kux8+psHtyGMJtJLZJRyaW9zmE=;
 b=KPZLotvG1N2vvvELmbYHCkOf+naXyx/V4zFt8xwQg2XWkWjzmGaqU+0Zg2YsqBBhILaPhi8mL3BWuBGQJrY+D/GnBsspwiIjBeY3K/Yeohm0E19+hHfd+QR7vkZy7nz5/VLIUU2D2WHtz5lRnBy5+71gnnqO3leymiWr5rBYbSJyqBC/ZC+9PzJt4gYNZuAQfLVePeTULhYN6ze863jzJ9yQijv5PlpGNiEjPCJtoMKB55iw9tjIii2JkMfI2cd53AhYqs75A64l7HaezJwKpkOvrJJFAPQZhKiccaracoC/c/QzNh51KuarfHlzsaVheIXU+Yt4XPYUUc/nrYQz4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 16:06:53 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 16:06:53 +0000
Date: Fri, 30 Oct 2026 18:06:43 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Wei Wang <weiwan@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: ignore link state in gateway check
Message-ID: <20261030160643.GA116970@shredder>
References: <20261028152634.3355852-1-aroslavdudkov622@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028152634.3355852-1-aroslavdudkov622@gmail.com>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 13263500-ed2d-4e22-3980-08df369fd061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	bLCdWFzQK0v/PU+DkTagyrRE73Ie9k1C4LHvdpkq6Dh2ujGYzrDdcl1T1AZzIZWozfWnnM+YH5rPKnFGQizLXGt+5YLOe4KweSnCSzAIFemVF2xhejrjdttXRYunN0sy25ihhJdU57BUYj4C8yLBwHU7K7Mgz98L+dGyoYqcB8M/GAP0NekaaAsoNTQLkv5+qT3Vp8zBG0nbC20VYDI582muU87HITHQAObSRR6NOIkCOjpDWaDdNwHButb9CnrlSATr55MDBXmJa8TOfZ6J3sQMcenjnTBA//F7b30qhuen2tJh1XsTNKWPkMHzWcXf57+hPJZKid/5UqSPxRnsJgz/D4Qvx3+1yHKh9vLb99t/tvLlIyGfmBjSk1a6wB/socCHlFjOrko8gkCb/BIeUXcIcr9nsw0eQhHP5lMhag0Ju3l+xGnkinRW0tMTLo7oe+zgBwbBUpuYbLxNX6hrnOoj9ovmGP5TGTGbyD25KXLMBLhVB3OIl0h44Q+/PcYPBVM8JzNFbg/eSUgW5/eIuxdUJvy4u/JmQIH/jYVqufC8+wDkhZ4A6xBKmcFQIlfjl4DfIXC6GbjA3BLG7ti+B55X9gUNXxHmlSF1NW1zt1xIVLDY7l+aR1RGtlbHRPK0B2/70GwipkJ69SUCQAKdlUPpMrUP9RRSbj802E+2J4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNI0xG0kCuJafj3NtopXN2UiBtKhFXFZ+aVM5agIjHjE9UztMDHhkkqvFudJ?=
 =?us-ascii?Q?T9Z7+Qe1eymnMOoAFRwX55QSS6UwjPfEb6LmJ6if+TKHhLVF81sHqTq/bk/d?=
 =?us-ascii?Q?KA7iS+gPDlHeoIHuWDbUXjUghv9gW7sHocm8iOBzwtfDbgsq1k4j0i1TfNwc?=
 =?us-ascii?Q?2OgBO8Nd+4lANyh4c2ohgw+Kp75240YRC7EsV5wtp+XQaktGmzKprVovGnY5?=
 =?us-ascii?Q?kXPRONgqpmvVFkzn7MuHRKKI7P7OsOO3MilQUg08ZJvBbjiHq89H328dy1EX?=
 =?us-ascii?Q?oNIKmoTH09FuFoPpKOVKz/ItbX3EiiCehe8AQwI5hek0gg5gpp5/ikTYhc8y?=
 =?us-ascii?Q?GDh+ZmExi0VVtEkkZAnKskvCoGCvE4OwkmaOD4K9wgrQy+3kMMpDe8O1HX0q?=
 =?us-ascii?Q?cZi3bsVS46TqLugHhLqXNdJtWOeEsmoeHV5Kupupgci0obh0jt5+LeOq806p?=
 =?us-ascii?Q?sl+EUZO7Qx+Y+E5zNr/NNdbhNqtUucOGB7IWTytFMBMf5WiBYBj49glb2cGG?=
 =?us-ascii?Q?VB4Neu2OUplCCJHaiYFD/1WYxsXTa4k2EaKM7nXnfc3/WdmpJSSDAS6Db5sC?=
 =?us-ascii?Q?kWEhKJfevXVRK3Ka4tf4bemiq0C8wF3/pfMZV4Kvfdin4nFUvxNuUrCIAp1X?=
 =?us-ascii?Q?7Wve0+nUiQ4oc/u/Igmx6QUc/ri3O2w9mhDWAPJc0KeuD1kz2OP4bmElADh4?=
 =?us-ascii?Q?4iES+4Q2knorMdIHOT0CCCZZlWkKW/lcRM7jqlwcyTl347zXfriE0Dy3ykl2?=
 =?us-ascii?Q?P97o5SiOsZ8GWNuEQthE8WWQa2BGqTt44fKbZaNYLXxee0kMfNSUP2kwh8t3?=
 =?us-ascii?Q?f47+LoNV9Ln7Qj1nsVt4Ef842ex/rPzHjZweyJI/mBAoeLMD5zc0cPv+0IBi?=
 =?us-ascii?Q?eEroSTM18Qf1QAHlskD/0N6qKCANi4UqbH0S2WvPhBk7THeIQ1SiUEmeKgi5?=
 =?us-ascii?Q?aTqpYWkqd8HrOkf1xsG/jDSMQSZbHP9uGrxjK/26QzL6UFC1bNnIQa7Ti/ha?=
 =?us-ascii?Q?mzZUOeQEGxiNwUasbPErI5/BY/lUVw1G9X+BacY0sDAW5Z2tIvmvBvjfrn4i?=
 =?us-ascii?Q?1+iXw40GyNAit4/APNKxSnPtTdhQbIEgOohMSej1BgxFzNv54FbCC1B0ATCz?=
 =?us-ascii?Q?PUvLBuPSZkDfQdrufv0F/G5wczs0ZMTkgeICHBWX2tTgaXLbtic0qAvrGptQ?=
 =?us-ascii?Q?eU0MHKePgyD4cvjn+/sa+GM2QHqO5r/M06MszyHh+0wH8oLREZiNokck9V1N?=
 =?us-ascii?Q?sgh9SYcEIUenq5P9Ige5gysZO0SUaQPH1btgq1eYDk0d0r59WiKBUX9XzH6M?=
 =?us-ascii?Q?pM7dRE61De2zwIHZWeigKebTP23zDGmuyAU0Tj0wuCxapzliixnBTk2hVgXf?=
 =?us-ascii?Q?+8wt1IG2cV6zxipcs8u8ljhmqgR1ZdioEbDaAshbpUpyL6T8/d3VKZiKli5/?=
 =?us-ascii?Q?5/IZ3PKWgfWcYzVIN7+0yyaO2hPMEsfJyvE1U4t5tweZRy73ye/qzZugVhf5?=
 =?us-ascii?Q?5M5Gq7tp4xb+PleEOKV2X4M2IB+WO9LZ1/XBWUiB1AnKFOyOc89l6os0cKDt?=
 =?us-ascii?Q?EW/5BKp30X9IV78mAG2BToPLuoKPA0zpoR/iaS/vTJFvLuiTFcTcl0wZaka5?=
 =?us-ascii?Q?vuUpzj9z9O5HcS+uJ7QAYy+P6fjTMvVbwNJkx1VshZlbNsdEkol3ZNcCnDzK?=
 =?us-ascii?Q?NilQV9d2gcE6VBSxexx6D40w/ZPZHSdywVhlhTBKU51DH1k1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13263500-ed2d-4e22-3980-08df369fd061
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 16:06:53.4668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7z4PZd+m678kLMK2/87+jo+C1qZ13u5yDxnDS8EOENTbWMHwNbLI80aB1jvv4PIBSyIzKfsirxleGUi8w/gSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

On Wed, Oct 28, 2026 at 03:26:33PM +0000, Yaroslav Dudkov wrote:
> IPv6 route cannot be added in table when all
> following conditions are true:
> - gateway is not link-local address
> - ignore_routes_with_linkdown=1 on device
> - nexthop has no carrier
> - gateway is not present or covered by any route in table already
> Also multipath routes addition is invalidated by kernel even
> if only one of added nexthops satisfies all above conditions.
> 
> Reproducer:
> 
>   ip netns add t
>   ip -n t link add va type veth peer name vb
>   ip -n t link set va up
>   ip -n t addr add fd00::1/64 dev va nodad
>   ip netns exec t sysctl -w \
>     net.ipv6.conf.va.ignore_routes_with_linkdown=1
>   ip -n t -6 route add 2001:db8::/64 via fd00::2 dev va
>   # added
>   ip -n t -6 route add 2001:db8::/64 table 100 via fd00::2 dev va
>   # RTNETLINK answers: No route to host
>   ip -n t -6 route show table all
>   ip netns del t
> 
> Route should be added because:
> - RT6_LOOKUP_F_IGNORE_LINKSTATE in commit d5d32e4b7668
> ("net: ipv6: Do not consider link state for nexthop validation")
> was added for this
> - the same route is valid in main table (when no specifying table id
> while adding route)
> - fib6_nh_init() initializes nexthops with no carrier
> - IPv4 already does this (fib_check_nh_v4_gw() ignores link state
> using the FIB_LOOKUP_IGNORE_LINKSTATE flag)
> 
> Before commit b2c709cce682 ("ipv6: Convert gateway validation to
> use fib6_info") rt6_lookup() was used for checking if nexthop is
> valid, rt6_lookup called rt6_device_match() which does not check the
> link state. After change rt6_lookup() to fib6_lookup()
> find_match() under fib6_lookup() started to invalidate linkdown
> devices, because RT6_LOOKUP_F_IGNORE_LINKSTATE is not passed to it.
> 
> Adding RT6_LOOKUP_F_IGNORE_LINKSTATE to flags for ip6_route_check_nh()
> solves the problem. RT6_LOOKUP_F_IGNORE_LINKSTATE is already used
> inside the first search ip6_nh_lookup_table() and fixes the
> bug in second search fib6_lookup(). Also RT6_LOOKUP_F_IGNORE_LINKSTATE
> isn't read inside fib6_select_path().
> 
> Fixes: b2c709cce682 ("ipv6: Convert gateway validation to use fib6_info")
> Signed-off-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
> ---
> IPv4 example of this situation:
>   ip netns add t
>   ip -n t link add va type veth peer name vb
>   ip -n t link set va up
>   ip -n t addr add 192.168.0.1/24 dev va
>   ip netns exec t sysctl -w \
>     net.ipv4.conf.va.ignore_routes_with_linkdown=1
>   ip -n t route add 192.0.2.0/24 table 100 via 192.168.0.2 dev va
>   # added
>   ip -n t route show table all
>   ip netns del t

Please turn this into a selftest so that it doesn't regress in the
future. Something like [1] (vibe coded).

> 
> Also when adding RT6_LOOKUP_F_IGNORE_LINKSTATE to flags of
> ip6_route_check_nh() makes adding this flag inside of
> ip6_nh_lookup_table() unnecessary for this call, making another call in
> ip6_route_check_nh_onlink() with flags=0 the only place where it is
> needed.
> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 94e5ef1c4f83..95d7b5b10e51 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3426,7 +3426,7 @@ static int ip6_route_check_nh(struct net *net,
>  {
>  	const struct in6_addr *gw_addr = &cfg->fc_gateway;
>  	struct net_device *dev = _dev ? *_dev : NULL;
> -	int flags = RT6_LOOKUP_F_IFACE;
> +	int flags = RT6_LOOKUP_F_IFACE | RT6_LOOKUP_F_IGNORE_LINKSTATE;

Maintain reverse xmas tree:

https://docs.kernel.org/next/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>  	struct fib6_result res = {};
>  	int err = -EHOSTUNREACH;
>  
> -- 
> 2.54.0
> 

[1]
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 7c47d7fe250d..76f950eaef52 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -406,10 +406,48 @@ fib_carrier_unicast_test()
 	cleanup
 }
 
+fib_carrier_gw_test()
+{
+	echo
+	echo "Gateway validation with carrier down"
+
+	setup
+
+	set -e
+	$NS_EXEC sysctl -qw net.ipv4.conf.dummy0.ignore_routes_with_linkdown=1
+	$NS_EXEC sysctl -qw net.ipv6.conf.dummy0.ignore_routes_with_linkdown=1
+	$IP link set dev dummy0 carrier off
+	sleep 1
+	set +e
+
+	$IP route add 203.0.113.0/25 via 198.51.100.2 dev dummy0
+	log_test $? 0 "IPv4 route in main table"
+	$IP -6 route add 2001:db8:10::/64 via 2001:db8:1::2 dev dummy0
+	log_test $? 0 "IPv6 route in main table"
+
+	$IP route add 203.0.113.0/25 table 100 via 198.51.100.2 dev dummy0
+	log_test $? 0 "IPv4 route in non-main table"
+	$IP -6 route add 2001:db8:10::/64 table 100 via 2001:db8:1::2 dev dummy0
+	log_test $? 0 "IPv6 route in non-main table"
+
+	$IP route add 203.0.113.128/25 table 100 via 198.51.100.2
+	log_test $? 0 "IPv4 route in non-main table without device"
+	$IP -6 route add 2001:db8:11::/64 table 100 via 2001:db8:1::2
+	log_test $? 0 "IPv6 route in non-main table without device"
+
+	$IP route show table 100 203.0.113.0/25 | grep -q "linkdown"
+	log_test $? 0 "IPv4 linkdown flag set"
+	$IP -6 route show table 100 2001:db8:10::/64 | grep -q "linkdown"
+	log_test $? 0 "IPv6 linkdown flag set"
+
+	cleanup
+}
+
 fib_carrier_test()
 {
 	fib_carrier_local_test
 	fib_carrier_unicast_test
+	fib_carrier_gw_test
 }
 
 fib_rp_filter_test()

