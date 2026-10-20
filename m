Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792517665;
	b=lPKMHBR5W/Ty5GPLXQiBdA7DhbeEIiqjD6rGv+5W64xdlDv/Uqti/Y/Bfp4QZPW/l7Ym
	 m/sHI3GT33jXzOojgtYTgIoZDm/uMVhaj7XS5PDbjbuJcoVQrqNqDTzHb61l5JDpqmobO
	 yOq0kZ2flf4zcvfbKUQcGnfD5lMj8KbJ5qg9VV8XrNSGnpLLSvf6vdseu0SfdZ+fkZtAz
	 eyMuiHUGc11WaxjX625+qntJGQz17D5ygq2WQYJyedGvBW+hlZSzTdYMm2euOSt3KJRwC
	 m4sBYrDBrv5io2IKIym+V0xQX39rplVRJUivSor+lplcWGrLxd4e9czO5LkOMjPhXdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517665;
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
	bh=Tq+2Z+InWsalEkMyeR9TE75rSi3D5mRmISGbh26+/NI=;
	b=3+luyDyAniLNHPSK3EuJJpCxNx3mn4t0bY/1EXj9TTQzkpauiCPvYy9+ovxBQY2sDBrp
	 LG9fjtOTKiGsckpcTCUZCQX+oU+knv0tvIOhWqawvYLxt81I97QLYhdDaym6Vj6D8ha0T
	 omodhTMS+QkM4S7hacY9uq+Ej7Z05j10Hc5qJzVTaPg1TNUV8yVGaOC5ThrdsmJGoMw+o
	 B3RLeIYJ28Fdj2V5m0CBroFQdGKV3/p023ui8h41pYLUCawte17x2luCwYZI8i6InJpuG
	 X/kmgY/oukKWz/99bksrR6awhc1xo2krPEZQQqTAWYsGMKJ3dkBttdETO2iMHlQg8jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BTYfO8z9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.33
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4C8606A31A;
	Tue, 20 Oct 2026 17:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B4C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BTYfO8z9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ+cZvVsak4ONJ89WGqMUq2V77TnkmbWfTBVDn/M+UTWUMvwXw48DW91B93L+13nwZbFl58+Q112OA0uJ7tH9VrQqbhT5hE6fEtstelCqpUsOtBEQOKVn+62wQbY4TiHLNKbt0gmLKmnQI2wfExCm12UoAIiRZsXrvjwB6e4RpBDn/z1DEaBeXDtjTyJJMiSbXXckLIr3c5/300pBpsMhtFy9V7Sc+xJMH2X9XGxiDs7xQ/iPyjl7vhgI7rLpyRYO/aciAX6B5YK/mzKGdnthXZUYqwamGG0lRhN75CeW7clAXskaCLNRI3n3vCU1rdzylZRizQGZFHGi29qZSRywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq+2Z+InWsalEkMyeR9TE75rSi3D5mRmISGbh26+/NI=;
 b=NNfz1zMdSWCNI5vw3KPa0YKCyVNZs66SN+LUs/tIR/aoEhZgo+VtWqTqX4i6JDtQotRfLZWiKCIgiO89l1KqqU2R+5UtZcUoDGoZywnt93NuKh9RX8dC3MdxOi7KXrT4HEruX4O9b2aHYiVoyh5u0pRvNPV4zU/b84bWLfPVls9tZja15a6r8OOW7i1wEaM+u+CK9unznmMfU3FsNSbFnKdEsuYEcnDh7c1BWklxjiDBy+KN25ix26cAsej4wb1cPZy8HH6noj5R/8AwcOyYCpAU2ucHx52bLwdcJ2zR4wDA1d8pkbI3+w6lEaoqIIJgsaHKMavHx4MrYHOk128vvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq+2Z+InWsalEkMyeR9TE75rSi3D5mRmISGbh26+/NI=;
 b=BTYfO8z9rJqoY6X7SfvyV0nJmulNrp6H1TZMs8Y4EOLI0QVyST8pyYzdRw9SxmeTrGEojBiFIPBSoYkH6/bUo2ONbmNg6sg/P1Wv8f/1r/H81v371Rz3N+5I/4t5FrYveD5uLG1ncZjLHza7MswiGJp8eYc9MvgruIIrWNWmxmgBtKlqrKspM8oefrTSRLXG/2FF1hQxjCqkKpMNhXWMqcp5ar4yroGsQ0fv1hJhO8C9Mv0pM4ufBFBqc7dExf2Hfcu+JfH3mvl+Q3GdVIFx/bIsGtsLo+1+9YjdvEEMb2mtL3p6lhlYGaBr+z1RPfMKP6EhU2tHyUhBItmyPqYibg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS5PR12MB238689.namprd12.prod.outlook.com (2603:10b6:8:47e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 17:34:21 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 17:34:21 +0000
Date: Tue, 20 Oct 2026 20:34:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: icmp: use skb_dst_dev_net_rcu() for echo reply and
 unreach
Message-ID: <20261020173411.GA3251490@shredder>
References: <179241613335.5916.18191480036849517944@whr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179241613335.5916.18191480036849517944@whr>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS5PR12MB238689:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cd9157-56e0-4de5-39b4-08df2ed06049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vD+XjzHeCISmbx++3c0ALKte3l9Tvmqw3I4zqVeOrqDvuihjfD6xSKY6eu3efCPL7PDQi7z4RN9970NrpO3zaIhL/K/a8wlDBq+DoRck8r7naV2xresgcTFqiLrfgAo0z+Rz0/Ksp95zr7rz0Rzy2DrpvYaTWr/8WeeI0nXobir+qLCOwre3eoZzUg1X4FwHegSSZjCsqc1ndu23yLwlfVf2F05GjcDqgMN/5Xx7onkR9ol12iflwa97fyhgxB8tsrmuFUkMDxMOK+FnGobf1SHGJAMEHWRWF+y09iHXDqtRTIHoeE66JysIm7gtO3rIc2kU6ig3bdd3pQmqk8k2LSe+jD9G0TFUSRckRvMOf0KitH8XftVlpFdWUFFirsNbMyASeJrFY0lv/ZbE5cbNI98nEbtxxMMe990Wt7WVyz+mSP5tbGTNr2fSJePmP8qeW8sgl/CXDKLfhn1bm0keCUt1BvtZ8VZTZTDdTAkKMRYaUiqVsXygk8OyvpGquQOnhLYynRS29Vr+cnyQtXgnzTsfyo22L4NS4bnzaOHV19kAokJmqhWGAs+CApIrVj0DcHsnVrKQM8/ngkaEbexOsTPoAFkQCe2wgqmNtNCrFRGL1fnqjbwurR1mN1BveLAYC4mP32QzLKVqZvv3Ra1fpa3UWjfkiM+zUL1kSeDNACM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ud4owxshI0Mv+OqOHn5dmO+ME2Ywi0S0mlDXwOWp0VLMQHAEfc990Yi4t+Bg?=
 =?us-ascii?Q?3S5oyctSEfPQSdBOQajya+5YprIb+3liBYFh4g0fGXNppmlB5+I+gROal2r5?=
 =?us-ascii?Q?CNv1iyB6cF/EgOrqGyT99oYKqB/OY4Svk5S30fUaApoG50/gLs6lNR5AU+lz?=
 =?us-ascii?Q?kNKZ49lShJ9wJ7CJyhKzlN+756RA+3GjWBZ9HQDOm8IMtLbuuIY1teSwAD9A?=
 =?us-ascii?Q?gC7ZET2AGWB+MvTlDpqzd2nMauAtWUMFcXLKMs2CfdB+f3Yi9a21bO6f45rY?=
 =?us-ascii?Q?BGPdleah1n8EBOkZ+JL1MqAW4QIOj/RbKtKY5osTW68bzGjj2ERXxooX6/ks?=
 =?us-ascii?Q?di481h+S2Otnl4X5234gkITWgA+yLCMOFmHSuOtre9sJ6VLcSsbqXh0tO2LV?=
 =?us-ascii?Q?IDXxPhlcAOvRq0xxi1pE7UNAhKYtUUDxGD+NNzUVzo2EVx+eb5i3qh0zP204?=
 =?us-ascii?Q?XfhxBOTTwWlFEPeid95LVSVrGXuvmIKyFvjQwfoxMjZ0pqZJWgJorAusUk/s?=
 =?us-ascii?Q?qFzyNtf2cbLBxQLCSuthBbfwGRj5p8ocvbwKIHKjSsUpkQw504Op6QNzoxUz?=
 =?us-ascii?Q?1Ehdo/lOD0ZKVwsJ8ZUHNtBebBGRGEannxsfBf/GkBI1NPiizYpdTsgNTzK5?=
 =?us-ascii?Q?l0IdQeu9mkcFrw4IAIhPE8d/B7qBCsMlMbcKxoAB34RISPKUGu4pduWkBFoQ?=
 =?us-ascii?Q?Y4bNkBFUD0q4ozVBtPMmPXJmhOEq1stL2888zfW5JU5mLrg7gK2b09AYZF+O?=
 =?us-ascii?Q?SC5SPDP7TRLqFlyMH0FFWD8wHmU8prrwrP77t/5sgc3Ol0aRyuvJgt8wj8fC?=
 =?us-ascii?Q?zGVqkSZQ7xO9PYveIp6ROk8ZfmlqZFLpapoYE199vWW3X146OGMege2KL3ff?=
 =?us-ascii?Q?+j7hKHMOnJR4TAhbHkXkHifUKXSJOzzVKy+ygGDlXwo7oFSfanWiImqFxYHZ?=
 =?us-ascii?Q?g4c00MUyfbXG1lwSCdofYa80nLxT1QACavtugI5a/lhBJd8Lll8QguUwMDA9?=
 =?us-ascii?Q?WexLs1qveGBcc+kiW8lGckwcousflPUNP65/aIjHohjac5QNL2Lh0+wWDeII?=
 =?us-ascii?Q?89+TK9d+BQANfwB8GjpIrxRHONbdHDAcOmNhX66GO7GlU5ZFHJFW1INigb4Q?=
 =?us-ascii?Q?D8iZ3mixnF0bXVaYw0gFJtwR7v6JUU5WWCufCnF36r7Jnfj5Ott5dIO2etjz?=
 =?us-ascii?Q?OaFqrvYdqZZ7h4CFIqfRU5gh55BcTNcqSkgoeocwSf387xuH0mVhnLTekCBl?=
 =?us-ascii?Q?PPlT2bMhGpbCJpevY3K+t5veGpGRDpGUla428TIVNFyut/jO5nmkcQq/IqIs?=
 =?us-ascii?Q?ubmwwL4cbj6gMOhfkHm5zC0Lje8O0E2HCHJlPDMm4VuF9NSqrkmP+ugOksz8?=
 =?us-ascii?Q?SPIiYnAfOJ0x0zglModC4lsDEPdh4kyWhAudxOUB5xZdqNjA03uRc/1B31Gv?=
 =?us-ascii?Q?kFS+2kfA5XwnC/+EnCyHTllBhqD3PFphXEK4FiPvbFAysCgJ+VJDbXGkt/dc?=
 =?us-ascii?Q?yrUS4GUInTm44BkxY53bIJ04dwYtywZt/C33tTAWVzm6Dc5AhWaDeTmhYJwV?=
 =?us-ascii?Q?iFmCCkTFrmik/cCq/A4yjT6ETeVdWQVWpicY2wjSDXIsrF0s8a32udGGluTH?=
 =?us-ascii?Q?k0MuP5UQse++xHNqTev0bWkHidr5HV4fjnU7sJXYGHJ8VsjU869awjti0up1?=
 =?us-ascii?Q?lXlhUWiidz9yXU4KXzXIWwDW3wsBLZEUKUQ/DBTWfl2ToOcE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cd9157-56e0-4de5-39b4-08df2ed06049
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:34:21.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOHtM1KtdG9sfOYQ1u6nP87htzYxu7frF47F46owkAfhYomPqrEGa65eyHpAu9S0hnSwVP6GBEgoE6kuhinsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB238689

On Mon, Oct 19, 2026 at 09:22:13PM +0800, Haoran Wang wrote:
> ip6_err_gen_icmpv6_unreach() and icmpv6_echo_reply() derive the network
> namespace from the ingress device with dev_net_rcu(skb->dev).
> 
>     /* ip6_err_gen_icmpv6_unreach, net/ipv6/icmp.c:885 */
>     rt = rt6_lookup(dev_net_rcu(skb->dev), &ipv6_hdr(skb2)->saddr, ...);
> 
>     /* icmpv6_echo_reply, net/ipv6/icmp.c:923 */
>     struct net *net = dev_net_rcu(skb->dev);
> 
> Under a VRF, skb->dev is the VRF master device, so dev_net_rcu(skb->dev)
> returns the netns of the master rather than the netns the packet is
> destined to.  The route lookup for the unreach and the send policy for
> the echo reply (ratelimit, IPsec, route) then run against the wrong
> namespace.  The rt6_lookup may miss the route to the source, leaving
> skb2->dev unset, and the echo reply is emitted/routed per the ingress
> netns instead of the destination netns.
> 
> The IPv4 ICMP echo path already uses the destination netns via
> skb_dst_dev_net_rcu(skb) (net/ipv4/icmp.c:1123 and :1267), and the IPv6
> echo path still uses dev_net_rcu(skb->dev).
> 
> Use skb_dst_dev_net_rcu(skb) at both IPv6 sites so the namespace is
> taken from the skb destination, matching the IPv4 path.

I don't understand any of this. VRF master and slave are always in the
same netns. Same comment about the IPv4 patch.
