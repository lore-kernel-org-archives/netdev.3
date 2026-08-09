Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B8156661
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283187; cv=fail; b=A03b7rndjDFx4AaEtrCMDpWRXbyb0YuFGPaMZ94wZeSp49JbMUWfV/16SzFZY/8kuVQPSJI7RTmBrvGiDCxS3T+gsubMs5JI3aNJVybm5PHF+UTXBF9Kqa7vBZDIs2NMGJCGq39WSY3U8U/8TZP9ljIyV3MHWLa0JCTUEaWXibk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283187; c=relaxed/simple;
	bh=LPWHw/AqbUtP1zKVCbNhunarWNlR84w5Z/4J1jYyHpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aOc8MVPB4cRxr/Pqom7/VTCi2oT/G/+WuG8VMUdHLZd2yqLwVhNwWN2b6wUDY3orXXKXIv9Ja4pkjuKGdnZ2Brsrusg5IKOf1UkmHIKEbdWcD19g7UGBhCSP8H4+bjws6YtFtqc8jHWI6UdvoHtBoiXmV7SbQYryJkoHRt+8/HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c26k77bh; arc=fail smtp.client-ip=40.93.194.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c26k77bh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5kQ8s71+n2i5Gqp7ccAJWho1zG/QXuxF7CmJyYYrPEOAzt2M0RdU9uDsgOdbIJC3K/VWzGeLaFxU5KQ5dpabtROkG143IOR3OXfWNKpdMj2DUhBiFsuzG4xREJodCLPioElR+nPbKQbKf0cY+DAU+qHYm0T76GaZ2P2TPYqMYR9mPbCsUGRvREfsE7XR0jCiS8zunN3OFxPFyJffTPskoe5FsO4dQtRp5NZFb+hdFqCPL9ZrGLv3DmtWBd3NnY8TU2DST5Asx0TZHnIewvvESFoXCS72244fZjRdUmSPXeSOXt0qT/IhkAiSNreWySao/pyCk8ZVBDHwWUbdEoQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1XMY9slYkLxIvBweEUSVfI8nxrd5eDjjmfSvJtXPt0=;
 b=mzAU6RtovKTz4bRLZ8waEWUjGnhahmmLH4R8VwT3Anm0pnMChPsEwjrJVRGv+wY/ZiVheIsIGk7TSIu/uWVxpkOTOdgvXqu7PLWGANrBgmikFPaw/FYFjstbr2IhUFdBNV/gFAI4AFXlIDDDuj6PQFBP0csgSTxbQDPv8IYYb+hcLcxb2TjfTnd8cps2pIHCtS0XQxrk9R8kb8BvliiYznd7Y/YY0Zj79dsMqkVpbayXrigBOZk1xFzyLKoOcDPrgLB7wP8GVhBjHbDmivl37gIBScbj4Gz96H0zHls1g4XoPtVxAOwMWBGerqeCOD0t5FIyBvQLeRvc8yrDojygXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1XMY9slYkLxIvBweEUSVfI8nxrd5eDjjmfSvJtXPt0=;
 b=c26k77bhJ29ahpKV2wOJY4luvQ7WkfOYagC1PwvUUFfMFRQ00rk0viWhkZDCpPKrwREMz6tynNC6JMjFhv7DCy3PPz7vfkKwHsFjF9O2HS2xH9Wa9zm7Hxsa6yoEorSZbOOhY0yM4LpMW6zmPFxLCCDogQgq3o2/DX4+2BzMi+84T4Rnb5dBN/XpmMOHdXh6gDfD/bif2KXNi3DEl22IaYL3NJLS5EjGErstoCTDTUoSuT7reFv52sLwA7K+YhMXoA4qdZW2yKz4x/fVeFakhGWTaOKusfZ5Tz3m3HYTtcREzW/RyRLTMdD5umLB46dk+rgNKIffjhNkl5vdg2YKcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 13:46:22 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 13:46:22 +0000
Date: Sun, 9 Aug 2026 16:46:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, tom@herbertland.com, vega@nebusec.ai,
	petalzu987@gmail.com
Subject: Re: [PATCH net v2 1/1] ip6_tunnel: snapshot encap in xmit
Message-ID: <20260809134613.GA2478309@shredder>
References: <cover.1786088695.git.petalzu987@gmail.com>
 <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com>
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: edf74308-7adc-477e-fc42-08def61c9904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0LxKb315CvIj8kV0Kp8pziPpX+ZwojkoqytAxVtnr8JX4ZmEo5ZZvQ/Hu88XKtK2c/afLngaTxcRhTWVnAwmvWD5qO0FNEC+yh01vdU63Ok9XzkW61UK4lCQWp7wJqT6rI/0cpiC8s3EwwJ2k+W3xhEYhzmI0ZNgjwLEhpEt/lYb8S5mas3QurR57hak1pUnXOOBGz+oeQLb8G0XmS0idv8EFUbsM0Qjia0SQYm1sqHVMyXkIr8cBgnkq0+ukdeDU5zBid0gtt5wnzZJQKkdoq9oRXMgc0E8AJ+x6/T85JZEkefTiYa+9dSGLXKe+kPgBG6WpyH6Uye4ilCbSsDKRBMzosYSdA6CSTrQRGTuqYbj+1BhutYRWfkVyyEyzU/k9vbVuugZcfzmvTt0r3CFNPxzTO36dwn9IsibpEn8Ntkzz5jGmsTo7kBLoO9PwdCpIMGWprXgPdthfuf5pr1pF7oybJ5CzdGiRh/ocv/VaVzc/AlwugGg4XpMI9Yoari3S0oVBVUZ4y+w9jqPWlbGU4Uh8kgupKjZdTlP5t8Uqgz66Gt4OaDf4AN7Te9J/QSL64yY3V3sEsP4kAWp2T8gNEBrr3HikWQLK5CSiasZCPVVUm+/lgoMCvYVdY2Qt+y6flCBHW+4bsFPMAisumOt0ahdITfLUtsTgvjHRWWnm6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LwcMxJT1W90B87L93Fwn+7aeSAEXrGJqZLu4H//9HnSc42NLYZOUtrZPXOoP?=
 =?us-ascii?Q?LNUor6EGF9u4O3LI/thOYhB0DSs96kx8MXuhibMuuXX/LNpePFwekxiTkGDH?=
 =?us-ascii?Q?15GlIHeCoJwha1CQjOKz1kqs5Zck7Gqy/BG9a3agVyZds5c2F++ZVnuXJbNs?=
 =?us-ascii?Q?vlQQ94gNognRqsoFnMjGEEgqVt9+UUYLLAo6yzAUFTUgOEL8h0JTh1iXFsF0?=
 =?us-ascii?Q?12Psp5J/Eprexi1i6rUCt4BFYjY6QLTGAuP6MSqZWPW7olprJfmwZg/nsL0v?=
 =?us-ascii?Q?6rOkDS7lcVHsOMaES8rS4+oRLTEu/k2aunWXz0ABHP8mP7RhUEQyOFjf9+4D?=
 =?us-ascii?Q?kNf0ktRnxyBrf/aPzNj+44/qrD4eeeH7Ufik/+davQJ90IM4ida9dZ0Ejl0f?=
 =?us-ascii?Q?ME5sFwmhY3bQhD1+qz4MAhFnl3ZHn7VG77wmhy2xR9+ucSy2l0PE2CsYeViV?=
 =?us-ascii?Q?5vB0UKw7kNEXTTZlzdbk5ydKWBZNKpKgxef8C3T9GpRhoR5CjG3nNuGkWECs?=
 =?us-ascii?Q?+oYPbcvvGHxdRg4Tj0YrzNoEYwiQSVIpoi8AuWxDi+II0ZnqY7dyZSDzcP9/?=
 =?us-ascii?Q?9dotACkMFf6wQ/xRoU7P2bdFoOD5MHVR10Nxq0/st7gQwoiWJSsowp1fHVjJ?=
 =?us-ascii?Q?wSZya9/qJuJYzmGvG+Cn8cnuZ30FCiZuLWr6XjOsfxiAE/T6Uk+9Eqi4G9Ut?=
 =?us-ascii?Q?Gn5Yh/pv0w1a5kwLg8Ai+E9L25CXnAAuoBsIm0ZUd0D2yeY4Ccrtmpq35e2x?=
 =?us-ascii?Q?d+UcvfEZDCoU00vs59ZdXDBNFkKzfdwWehnbQqldTHP3zecap2mNNtpi7lZ6?=
 =?us-ascii?Q?1lbAeu/fUn3+ORLGGQj8ebet7LStH9VhxUjOELZtnWwQmUzOStKy0O4APALZ?=
 =?us-ascii?Q?No3OtYMPGGw0eOdTMhmHQK8fwj0lVVBxDqZTOFCC5DzP48bOP1oaGvPmhFaf?=
 =?us-ascii?Q?6qkrqlNWSAYZaFmIrGH7uhUCHyWZQMgd0lWKfH8I2OUokOJf3VZgqW10U/1H?=
 =?us-ascii?Q?S69kng5/fmKau3zRdL85DrYuTCLR0dKRuFWxsoiT3DykQRqLmSeJQaEinvrz?=
 =?us-ascii?Q?7tR2a3AzqBLeSk1XjrpgkbevQLIflvHjTlNHcsPW8fiA9AdIM5A0hjtSwGRk?=
 =?us-ascii?Q?taNYXMQ3mOAS978mmO350kXiCug0Q3ZhNiZPYortdVO9VocncsrqweMjpG0W?=
 =?us-ascii?Q?O7Rzn3I3GW0qF+uEyaXwT/WLfI+dD1vXpo6AgCn1tTfXJzFaq7V+S2JKjMJc?=
 =?us-ascii?Q?Z/a6a37iizw+XvvaqIhHdlxzxTGZYts83Tn7NdniRzDcXPjOrcwywBeNQvDD?=
 =?us-ascii?Q?yZM4LTIkhmnVJCmM7X+lRIB0EKneSY4hdwky2mvQF1M4Q//kFOlAU4By0oY0?=
 =?us-ascii?Q?vdi1I/eOKAzp78Z28aZaZ8/ESMbG/+h7kIDChcSBg939SbevrH6rHO+V7Ycm?=
 =?us-ascii?Q?7V8kGqqAY4rw3/zAY8Z1QxSYEhUa+dxV5KPb9BSctZCAnen5SziWk3ZWWjkb?=
 =?us-ascii?Q?ID4b31EwGzJD+nJL/sz1yjCc9igEpiMELOvy73Pf65blVBBl/4Rd3gBSCk/c?=
 =?us-ascii?Q?Yh8lT6i8SMHjG1gWt+Wp1aFuIwDWhhRBH5O1+qoedD5IBEIz2k3FgzsoYDcT?=
 =?us-ascii?Q?yyJQe1IOZKsQIvJVnte3DU/CR+/8nsmzAL1M0sPrRiAXk6SOt9oJ8gIVZnxJ?=
 =?us-ascii?Q?JXEl5IO9N56RKlmCp+JDpUynsL3LKFZ8M6BLag74XTLyXlu1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf74308-7adc-477e-fc42-08def61c9904
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 13:46:22.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FewBy4zf3NnLPvNBuU4apBJlAdV2oJmPcEiFPYP1iwOYoOg2G62iGDksUCcTP/AfPtiRPgsaA6jlLnjQg9AWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017

On Sat, Aug 08, 2026 at 04:40:49PM +0800, Ren Wei wrote:
> @@ -1202,6 +1204,15 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  				     t->parms.name);
>  		goto tx_err_dst_release;
>  	}
> +
> +	/* Can tear, but hlen and build_header() use the same snapshot. */
> +	ipencap = data_race(t->encap);
> +	encap_hlen = ip6_encap_hlen(&ipencap);
> +	if (unlikely(encap_hlen < 0))
> +		goto tx_err_dst_release;
> +	psh_hlen = sizeof(struct ipv6hdr) + encap_hlen;
> +	max_headroom = psh_hlen;
> +
>  	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
>  	if (encap_limit >= 0) {
>  		max_headroom += 8;

[...]

> @@ -1272,10 +1283,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  	 * needed_headroom if necessary.
>  	 */
>  	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr)
> -			+ dst->header_len + t->hlen;
> +			+ dst->header_len + t->tun_hlen + encap_hlen;

Sashiko is correct that 'hlen = tun_hlen + encap_hlen' doesn't hold for
ip6erspan which accounts for the ERSPAN header length separately (not
part of tun_hlen).

There is no need to touch this line since it's irrelevant to the fix.
The needed headroom was already calculated correctly earlier
('psh_hlen') and guaranteed to be available in the skb by
skb_realloc_headroom(), when needed.

>  	ip_tunnel_adj_headroom(dev, max_headroom);
>  
> -	err = ip6_tnl_encap(skb, t, &proto, fl6);
> +	err = ip6_tnl_encap(skb, &ipencap, &proto, fl6);
>  	if (err)
>  		return err;
>  
> -- 
> 2.34.1
