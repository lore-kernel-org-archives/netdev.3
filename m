Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F554A9D59;
	Wed,  2 Sep 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364427; cv=fail; b=bBhSsRpFiq4Jp3h0SXKzXlgRYeWm1mHhNMEdfmFFkw3UpSMrjSLVkatjcogq01kOzt0pomturWvdQ4+pX9WPDNhWHJiKKKlFNMleszq892vujq092tLptHywMXUG2Eixn4t4nOxAE4ocwkS8ZDeGXouXdUutk0/y/QZOfP0Wr44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364427; c=relaxed/simple;
	bh=EVykAGNjFGC097pKABXr3ANPAvlJwdbKjtnMwCNBEJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xbbchs14X/Wwlys80H3Q9GE7rFi4n0c0Xz8sGcOnQ6jwfS1bTJ8Bztu3vF3HxU6rpRIIr15x0ewdIicgn04pEDsGUXQABjxFQfK/jJ2Yw7o7F1ez/JXIEgUZhRvCJnbUlsNJw7rdD9UoTphAMB82I4mOcsBaryH/ahAKHYHpr9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NT8aeV0V; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NT8aeV0V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1qV+26N+pqill6dqZi+v2KPJneXsudNnn/nv1E3rxSwxMB6/05FkfWWARE2V3IngSWoHV066LBLMnc/5rK+AxS+DCbC8cAL/m/3ulmTw7KLbBqlhxaZjDuT9N5M1vtQTP5IWWs6aHFo/fgDB4B1aEkkwNuDmqGQrmgFaF5pvi3GVs890kw6L7PbG2Poqk0u2C/Id/+L6b0Z3jBon9DIbls/S6V6NjK/9D5i9iyKLLWao0Dn6NywfgZ4NzltAoJ8mUPtR6Zxr5oBGkhnsMJOAzbpYedPhc7J/9aBddC2pcehVHbggU/60lgX8wbH5moD8ecdf32EFOfWgYlQDVzfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLbRMnH6NYy5Got8B2l6UoiZL247riQmXR8pUAYZHz4=;
 b=F/kNGRDjxHBsj/ogkKq09jJXT2J5YjSaJML+tq50jBmIFfHF2HljIz8bl54K0AVPNqeL9eyc0Muf6x+dlFl9Zs3uwylSgmojkSYSE+3bK5WiXq9DJNKILFsXjrKFaXQ4n8ntBFw0L7zCV5J8yazPxjDuO8NCPfIRIDJZx7kd+I8+HRL/pmdKWk5oL9L+kLrMd4mECpBkxJxBaqOjtus51gVXPQssy9n7JTNetiv7yxJs5NelbPCyme9ex9I7HTz3lM4hNbbqPtHLZDKw/efWSH5et8ZIKJuRM6Vy0yDijpScdXzLOoXzxz9EJuj2QMHB3nQXhqiefU2K/KB/nAuOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLbRMnH6NYy5Got8B2l6UoiZL247riQmXR8pUAYZHz4=;
 b=NT8aeV0VzSfndRkGiNG2qqQJuYP4ITLVzs685brKolherWuvcZ2neyMdt37rx9jtfLEd9oo1oCPTb569K+21/40cJ7KsFK9Hb1T6EAC4Jp7STVExwRXme/eouA4Y/oXXCy6Xbo7oD4H1tGvafbczH3aOmwI6dPBayl4HqgsMI7nC8Do0XNF9erEFJN4T9YDhT1wapBIOORVazFvbVKAOIuKUP/W/WvNXUe5F08vr+Var5L3/0E18CctG8zcQGccgDsQ7VpzUD47birGAom3djXfzEyOS+iEGub1uFDG7pVOVLk9+lk9ZFB4RTKZ+JDA/pTWB1hnLZVDmy7+xgbpZKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:53:38 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 15:53:37 +0000
Date: Wed, 2 Sep 2026 18:53:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, zhilinz@nebusec.ai
Cc: Daehyeon Ko <4ncienth@gmail.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] ip: validate options before echoing them
Message-ID: <20260902155327.GA4024109@shredder>
References: <20260902055802.3724915-1-4ncienth@gmail.com>
 <CANn89i+CSVHtjDk_NQT_Q6NpwJ76WQ=CExXp1xY15iPQuZSp+w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+CSVHtjDk_NQT_Q6NpwJ76WQ=CExXp1xY15iPQuZSp+w@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6a5179-0aa2-449e-9849-08df090a5a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ikdtma2OIsIrrqHVGHbU+vX5RYJTVK6h+tUtDAWPHN1xWxZurCbTMbp4ZBjJQ72Y7LVsx4/ls31e7qRM0mbqha1Kaede/m+aqp2+/awTlilo+GM+PJe3R88rx7r1NiKcSCK/t1f5Po/ckgGmZcMr26WZC0QV6L8ssTW5YiG3+Y2cQOtWQPhkz+kT865aCqzkR0cBs1gELWzq3hPIkg4q4fyEfNrwauM2+4yqKsMxRe3OJHM9cabK5QkhobYsBUppu18E2I7CZIALV/jvu5YbyFWeMApUpR5Y6VKjuqrjSZtchFOxPvWBruNLdR2MmHhFRpmfIaRKxfsYeYBVgOz5wcJt7gawkq00raCOfnHq1ysT6w+DPeXQ6B9yu0m/ZM/miwQB0dMBbDq2BfwIS4bWzncvLZwOGbrP8lr6EEr47b6xc94kp/RijWodvlBJ75Ryf2OCITreqauIh4SpyyP8ZWkXQwGLVFeeB/QU/C5/DuddKKXH2FxXy6+QK0s5MAQhEuVDJ7IeGUWhy+nYTtSb1WmkZhIBmjzZ4yfR1qED03GTiIddNjIadwCGQgZeCDth3MB63iOgV0j4aU/9mJRQD/2Lfm+y1eKLHH15MIR35c4J7zGTkTFUqfbM5GSp8QMTjF+ujJR43xALCWNECAMJ+AxYi1ybRg00/eFbDtB+b3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTmXZLbxTkHI0lNgSZS0BMeg2OwsPWZesv9H3+vHqyTvfoUmxK4osW7n58z0?=
 =?us-ascii?Q?+HdNVI18uaGUMZcbETX/V+0YMiSYATgm1cATaLDFT50/SN4bN5ofc/dFC0ap?=
 =?us-ascii?Q?pIceTthow3uqf8iVgi+It+Hv/F5mEECguVlogWIOJ13oA65gYfPFkXbBQk64?=
 =?us-ascii?Q?7WcWf4PYEDsq/SOtEQFTLAy0c0j3H+hC4tqBL5Y2n3aovIww85nHG4aHeVm5?=
 =?us-ascii?Q?vFn6LoyqbanNhNgGnmpWjzJrn+TFHmgqd8nWs3RVrJM6Vb38pwzT6n+M0XSt?=
 =?us-ascii?Q?QHfzqqIzI4bpApq/qOBIUAzq+O3LsOdAh8T2BEZHazvXKnYzv7VGy00OXZaU?=
 =?us-ascii?Q?2nbq8E3GLAm3MJ6Iy/OYIuTB7cfTx4YgCeneG6s5+tzuTBp9iVdyYBa38PYi?=
 =?us-ascii?Q?9LEl/27qqbGlx5luQZeC4amtt/tyW/5ffTYhi75bWqsRofA0O/syG75v6l1n?=
 =?us-ascii?Q?prCxj5EluqQkGaBNkPTTqlN0UaqYrs1ncVrTvyxLPk5WIebFwx/rKUwPWjYv?=
 =?us-ascii?Q?R4cuipLiUq51NT/pSTCELQUFJGC82+Qa6ZXKVE3OAQsNkNTSF86b/Clrjh/B?=
 =?us-ascii?Q?bY0+E05J2EARZNEj2ga32u7HqY6R/3fBg4ZX35KGabd0gT6qXMBNbxsRIEMR?=
 =?us-ascii?Q?IFPSIuhUctNpakF4Vgc7KoCduu/oqBvhfFcavxwIy+quiIStlMtHXheicX88?=
 =?us-ascii?Q?D79qh4ucbAA6zFgHyKQA/bMC2XosGITuDb7mDWXFY2zZ/tmNTFA0eNJTIZ9i?=
 =?us-ascii?Q?g0kHf8NEYobvFmBgKQeqLjROl58khi2QLQXmOds9doDblwEDAwWQ9gAURefV?=
 =?us-ascii?Q?SP3db4ehgS28su9l8msKtDsf6an5qW7cEFB/xDiEXyBgh7FhPD3y9VcWBQBw?=
 =?us-ascii?Q?guswEfCNt1JzkR5F5Ktv0zSd+NUscp6x5xtPgDGXzHeDI7BsCnF10FR6UqjC?=
 =?us-ascii?Q?GTI6OWqoeDBfG03mq7MWT/EmLv+7THcJTXqnQ0wdh4mi91jX46coEwD3nRfX?=
 =?us-ascii?Q?ZoGAm3KK0pg7r5qcryz82PR8NeIiVCvgjo8CXykjNHrAjqnGexQ/CqvFn8/X?=
 =?us-ascii?Q?TRCn5BUH1lFRhXcCLXpaTGLHKnRIS8v8qkn/c8HF1QIsuDKsozoCBMT1Gwwk?=
 =?us-ascii?Q?y88R5lwbf0COVIDiyLteK3ssiSfUpI+wu5sKzmttrAjRPmwJumh9O2EON0KO?=
 =?us-ascii?Q?1jy89xAEWwQT9bWFreAmG/97cylayOexQ8ceU73pxvSWc0r5J3aHvlYs67Qv?=
 =?us-ascii?Q?uyAv4lEeNjYRipne7Er3rrx9JhQWzJ7c8baF2jWJAq82czz0vb5jIkHaGnO1?=
 =?us-ascii?Q?mTUCM7wsLP7UcZh/PrX7ARn7ZwFYGjk3MG/zQnkQ/aEU4w1AGJ/OvUrknZ9c?=
 =?us-ascii?Q?rcyQR/7HcYbsZDzTPzPNYW8vCOQq55rDCNMTdMh/blzJGT67KjHD/pHAvYI/?=
 =?us-ascii?Q?sT0Zr7czdqhgb1U8GXqeZ2yj7BGBHVvY8p/2aXOSlk0oUmzRnvWVQ+cqH5um?=
 =?us-ascii?Q?iB4ZHaDxwrdtazbCPdWYLk6WwcCdJkoTkHkaa+P3I/piAnzuuq1onkZGs9PO?=
 =?us-ascii?Q?YHOmHhexCXXzgR0Xfq7WarN3p5y2o6I531Iv/Xfd23E29Vsw2hWAxOf8r8zd?=
 =?us-ascii?Q?5od/n5duS0SafUJDjGHDYojQCIremUHEtyd1D1STmPyRfHw2pvml5k3Rbt86?=
 =?us-ascii?Q?RnBXKnx5x6CK3hiyhwvQZ+p8fx6pgxBMKsnep1oG8MXF7VUP5e8nLdXp+EiZ?=
 =?us-ascii?Q?UqrTMSmmNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6a5179-0aa2-449e-9849-08df090a5a1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:53:37.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39rnHUsqq0vBcsFcT2uiy6Zx1Jh9mXhbmOAzIICvDv1VHp0wTLp9bRpQ1DXasjHkeLzyH2+35N3svYJ5Mt4LbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776

On Wed, Sep 02, 2026 at 10:44:45AM +0200, Eric Dumazet wrote:
> Oh well. Ai reviews will probably raise many bugs in this patch :/
> 
> ipmr_cache_report() is a distinct bug and needs its own one liner fix.
> 
> When ipmr_cache_report() builds an IGMPMSG_WHOLEPKT or IGMPMSG_WRVIFWHOLE
> report, it reallocates headroom and pushes a 20-byte iphdr with ihl = 5, but
> inherits pkt->cb with stale IPCB(skb)->opt offsets.
> Even if __ip_options_echo() rejects it, ip_cmsg_recv_opts() will still read
> stale IPCB(skb)->opt.optlen bytes from ip_hdr(skb) + 1 and leak packet data
> as IP_RECVOPTS.
> ipmr_cache_report() must clear IPCB(skb)->opt (or memset IPCB(skb)) when
> prepending the report header.
> 
> Something like:
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index e5f2b1c6150d2f6b2084c2ebaef6047db869cc87..72f1d620b8760722f805935d0299bac24a9f720c
> 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1102,6 +1102,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
>                 ip_hdr(skb)->ihl = sizeof(struct iphdr) >> 2;
>                 ip_hdr(skb)->tot_len = htons(ntohs(ip_hdr(pkt)->tot_len) +
>                                              sizeof(struct iphdr));
> +               memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
>         } else {
>                 /* Copy the IP header */
>                 skb_set_network_header(skb, skb->len);

Yes, this was raised in the past [1].

Zhiling Zou, please send v4 of [2].

[1] https://lore.kernel.org/netdev/20260805081737.GA1284302@shredder/
[2] https://lore.kernel.org/netdev/e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai/
