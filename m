Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BF4A99AA;
	Wed, 23 Sep 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175608; cv=fail; b=FxyU+5ayHMSgT98roCStkchNhJYNldpAjrQET1eM10wMkK2eLAUjDbV1z78dpJ31OGRPjFMnYsPUkNHKnwfxIY06NQqwcHF9zCtaML+4oKVOJfRwIxv687/KtgLO6gRZYPDVgm65MRodOJWBwEYHvmByzJsuVq0bg/sunHUWoes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175608; c=relaxed/simple;
	bh=M1VrRZ5WrAhJ7kBo8cKIIWyukAtUaxaPleUr3yGrfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ctuA+88ssEfmZTZYJrJecnFU/hCuX0PZvL+RsHZm94XF7pfYnSyqzzymkhH9gKNyHXBKUh88Z0Wf8UghX54prgwxAlDD9MZvQX9Rvy/qwWQEF2rKXDShKGFS/A9R4mBfxcSs5bJn6SibkhLsVYz83/TFF3ZgynfH91tZsH2/xY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GgVbQFgs; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GgVbQFgs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWdZXwzG5u00/YK+vXEV8yYp4O1md31/BRCMaAE86Uldy6yveaownhahmykmLPml/k6f30nCWvU+11aGG7gIc7sQgNe+pl8EYG3YzRM/aZvz2ShjJf8hfJDtXohP2QSlY9Ypm3hl4XUOHmSud1h40wwwjyXNB3BKkqSriPMoZqL3chhz9pvbOkBRhMCA8CbsoilLz9ZOzr/c2AQ73B+5oqYAGKAxp5qHZCKI2OOZStaad3/SPAIWm+L+yq4sCrRU+SEkwFx+5FUStRwsa1XeoWeCKbbB9gUz8Dv/JxwjR+SqIXp4WGsHoKP3sIpSy0vSdYXdSEIxa5mOGrY2iE0wLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqNAT24usKzcV4T0idEU5b385nA24uIk8aMBsTu1UkI=;
 b=GtV6RY7SU92ZsLk/rRWuesHZ7Gzf0Rj8QhzdqrZAbtCGpGPRRFwe4qxIE2SnlS/0AyC7fSbzFJkosVOqCJrWqCn83TPtnOsBg464R+TEx5CvO6J/t/JyCSDYeOxiN4FlkJeEDw6ASyauPDK3j7mNBQRQPDVzGhFr9a2/ub2GniNnjHTcXmQsQ492+oTX83XypksNjqPLH/VfFjZ2W/sTf7WqI2LPD+v9oUIejCqlav6GRrzwkYeEuh9yUMtYa48voB6XCo75JwkJ6d8ziqkqHsHRb7I+GcOsgaTg5YbGQ9Rm63J9YGJB8mNOl9qinxmpU6N+VT5bepRaeQl/eIlCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqNAT24usKzcV4T0idEU5b385nA24uIk8aMBsTu1UkI=;
 b=GgVbQFgsZ2IVDOP2tUCHxBGVAeLB80z1rlJ1lFa0X1T51L1yW0aR2DYu1V7Yp6msZ0DDpgolGO4SxmvVae8VrnzXJiHMDuj2j9RuPBsNeAqyy13tpHfYL99MNAsA4cRtndHaOVUx/y8zulWkSHkyGbh8r2KTrrNx8nmmpsUVnqj+lRbc0AS/HC86378S4+97Yi+DMe76LePdSFyz4pZf0J5Kot2Ym+E/hxVFTvxBXjMxJBlN2+WxNvGJsJ0tVVEIwTXhEablsDuU2PxAKa4dhXobepa8SF4leNT5FRJ+RAaMYzVmEj9mDFTxiQPynMHphX5pPud5IcUvABNEDfrOZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 14:59:56 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:59:56 +0000
Date: Wed, 23 Sep 2026 17:59:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/10] gre: make gre_parse_header() report a
 drop reason
Message-ID: <20260923145931.GA2859441@shredder>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
 <20260922221507.3268127-4-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922221507.3268127-4-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 390e69a4-6f25-4e1f-f3e4-08df19834d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|3023799007|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	gxUNRlaTIIUL7BnhbKee25gqqAQDnH6ilttwlxeXsXNepoo9m4JZCPJNVGTacW+R+agtPSCec6o+U6KPkwuWLBcESYF8ibl+n9cFRBMEapzc97esD+QZv/OZmC5Ch5BdoP448T8DruWpeh2diwQJ45MkHkNuwg9YYzqv5YqlBTSOXE3fWftINC1gL3G6rdWpUPzZhTLLkp1UHhk6USrqNF3ujNk9ZLTdBqzeyNp9Sc0D3scaRZ8dRaBryNC6tR6yuQRGT8meoU80P5FgsUZeH+Olnu9FhQRt0kk+fjSz84gFHBFprbGDi8QNArmBZR4urfcIg0l4O6q0Q55cLBiQO0UjMYKwJXYNGshPDAexrjU3YTnkmX82+vVWHOh7FBH57Z5NZOEbe8ibRRIM+AOUw4cr98BLwFTeK7fkYdz1II7vjL+llLmc2YNby6ZvC5cV2sSJmLTOrAEoj8DnJzXl/3EoPjVsLCDpKaxCvPlLw/yk/EvHdXiM+gJsgJxtFJl3AyucA7w0qHB5Y9yAsz1L9W+blgkE/6+IvTGvrjz2WI516icuOzhiotiCzA08AAjHkZq+tVm+wUClyJ82BA/WlednNnaoxWigYwUVbpHzxHmTh4jj0M4u6Rk0rbUyTKPHpYZtsy5HH4VFqxPh4wReinKvGLN0n8OvtMHh1PtcH4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(3023799007)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dY4CMbBimhU2gU3F/g3uCTLm6L1/5t1geXTSXoKw9VP6H0td5rXg79y4Ixlb?=
 =?us-ascii?Q?kWtd53fvDK2sXq/On5lyOqkAqQlqwJpj9ix6xri10ha62YbFC46Z3rls5z9v?=
 =?us-ascii?Q?5e6R1u/3yKCiEcjjVs4vj6wl2znJVh2VUhsmQRs2wvCNVuca9vuRs2n0ph2U?=
 =?us-ascii?Q?HcqHCzOmHJZSczKUVjREFz4R909gaGcO6KWhb3seMFUbCiSj9VtuLCDgpRXW?=
 =?us-ascii?Q?B49AHIk1+mUErOycQ4HuPtUNjTgVMIbf/6peWUx6J1xD3nm/MEG2F1jvPjbm?=
 =?us-ascii?Q?+1dGvf0yuLpPnRLxLURGXgAe4/XJm90dLT6e8XIlaKobAsds+aXYVljzIDzI?=
 =?us-ascii?Q?yRvbYMqidgsaurx7X2M8SMOUPKHif/o9Xb/le8o58iTQPvbo4T4F8QMUE8pF?=
 =?us-ascii?Q?UdH4FadjK/SsJwSVkBJkheQAY/NYW0hWQllmuIiDbhKV7XvyDHfKs+oSfE11?=
 =?us-ascii?Q?ccMms3+K80Z4r06AKVZuFG3cpLwYFmiUoGuMA8pz87pmFmsEfg1G9VR3uY+V?=
 =?us-ascii?Q?4YIbBaceq9n+DxEtkVeczeZpI18fF4LLP98hMXOvxzb3S1aRfUDHfz2ppLB3?=
 =?us-ascii?Q?a+ng2mDTfrEbxt7se1h+nkt2eY3SM40HpDoYTGqWJTNOSxvh7HzReYPzq1Uu?=
 =?us-ascii?Q?O09KXyeK4enkKjxw0jurM7TwY3jwSAgeVqn5/FbiEObVg+gMDc2aw4o/8jEN?=
 =?us-ascii?Q?Tbzo+JcAGoRAkRoTXgLD3K4AyZMsCybdbjg1nhrQgdDRCygZJqyHYKbX+DhZ?=
 =?us-ascii?Q?ywLxT20T0v9+H9hTrOCC8LnKsPZDh2RisQW0HWOyuB3lQNdkyOwK7NMI273c?=
 =?us-ascii?Q?Pua3RByOdDHLmeqbch698qU1CO/ILNVcdBq/pwhipvScPswDR1AAdYRmQTNa?=
 =?us-ascii?Q?HSmVpMFkJkZ8Wv8PdIwcjndKgMPxF7J2F3TtFBSZYqjZUPFUeFQmkG2GC+1Y?=
 =?us-ascii?Q?OIzhnzwNwS/nYRsEaiiw7ggiS0/mjSXJADmdBughPXqx0q+nh4befygNoiJT?=
 =?us-ascii?Q?qabpJn5lPxlsge1FYVt+FZcnbXZtXJO46HwpveErlZOPk23vUv+rwp5T28kN?=
 =?us-ascii?Q?GJ1rVrgbMszHT52N2AECJxYVxP1d6tMtko32Ql5IavAQAv/zzMkSawvKX6YY?=
 =?us-ascii?Q?Wf/5lFokdYuKp8T/o1u/MDtnlagC8/EnLTOAbEXxpouiGtUwN/twodrPutE/?=
 =?us-ascii?Q?4/vwUUvL0nxPFh1tnnV5BYk2KirMD5nfCzYNiLdtzwxGsJNAUwslm9xPudRu?=
 =?us-ascii?Q?q6r2gepHG4rBSOEfWdZcps2PiHtUUimbdq53TFbZENgfSMiXshOqZFgEhsdc?=
 =?us-ascii?Q?uBFMYWGIaenPEFpf5vf6tg3cYxSyha1S//je7VyxCq+9jS/kZtdQcyce63OC?=
 =?us-ascii?Q?Iama/q5dUVSVltN5sWKouref7CZLFMksaeqAwkE/csOBLIuYczXnVXI00Pfj?=
 =?us-ascii?Q?qfBde1GKoTVGnW4cVLoP3uJKhXUO8NoaqZzcs6LaWmMPzIwEuHnj9xj/j7hH?=
 =?us-ascii?Q?LjhCXh5Q83EH8yf4Fwi0GoJM/TsLNYrc+ywgcjMm66ofQWNYMh60lGI/rLfq?=
 =?us-ascii?Q?fqLMDMbJyAlbDKIEpyOshmhk3vNNRb5pZRgugbk9SLrfTLGiRUxm7bv72ojU?=
 =?us-ascii?Q?PFNWIs4mk/2O/WlvuJiBconZhoTiVVb56xA18uLgMWvyA623axlh2Clzby4Z?=
 =?us-ascii?Q?DVqMKDPtZYdnEWwlvyiSfoeeapVrpXZ9Awl0oYqg/ov1fHTZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390e69a4-6f25-4e1f-f3e4-08df19834d52
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:59:56.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4BX9B/QygUZ55w+40qMiwK8U43T6aUO/8LQmguAzGjxFM7WsU+CMFuaBha4vGcaRR/4gN88KSp/B1SqoSi3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

On Wed, Sep 23, 2026 at 01:15:00AM +0300, Anton Danilov wrote:
> diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
> index 96fd7dc6d82d..e117056525f0 100644
> --- a/net/ipv4/gre_demux.c
> +++ b/net/ipv4/gre_demux.c
> @@ -56,28 +56,35 @@ int gre_del_protocol(const struct gre_protocol *proto, u8 version)
>  }
>  EXPORT_SYMBOL_GPL(gre_del_protocol);
>  
> -/* Fills in tpi and returns header length to be pulled.
> +/* Fills in tpi, including the header length to be pulled in tpi->hdr_len,
> + * and returns SKB_NOT_DROPPED_YET, or the reason to drop the packet if the
> + * header is rejected.
>   * Note that caller must use pskb_may_pull() before pulling GRE header.
> + *
> + * @icmp_err is set by the ICMP error handlers, which only get a part of
> + * the original packet: a checksum failure does not reject the header then,
> + * the checksum is still computed and the rest of the header is parsed.
>   */
> -int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
> -		     bool *csum_err, __be16 proto, int nhs)
> +enum skb_drop_reason
> +gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
> +		 bool icmp_err, __be16 proto, int nhs)
>  {
>  	const struct gre_base_hdr *greh;
>  	__be32 *options;
>  	int hdr_len;
>  
>  	if (unlikely(!pskb_may_pull(skb, nhs + sizeof(struct gre_base_hdr))))
> -		return -EINVAL;
> +		return SKB_DROP_REASON_HDR_TRUNC;

Please use pskb_may_pull_reason() as is done throughout the kernel.
AFAICT, there's only one user of HDR_TRUNC (in tun) and it should also
be converted to pskb_may_pull_reason() so that we could remove
HDR_TRUNC. Can you send a patch?

>  
>  	greh = (struct gre_base_hdr *)(skb->data + nhs);
>  	if (unlikely(greh->flags & (GRE_VERSION | GRE_ROUTING)))
> -		return -EINVAL;
> +		return SKB_DROP_REASON_GRE_INVALID_HDR;

[...]

>  static int gre_rcv(struct sk_buff *skb)
>  {
> +	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	const struct gre_protocol *proto;
>  	u8 ver;
>  	int ret;
>  
> -	if (!pskb_may_pull(skb, 12))
> +	reason = pskb_may_pull_reason(skb, 12);
> +	if (reason)
>  		goto drop;
>  
>  	ver = skb->data[1]&0x7f;
> -	if (ver >= GREPROTO_MAX)
> +	if (ver >= GREPROTO_MAX) {
> +		reason = SKB_DROP_REASON_UNHANDLED_PROTO;

This should be TUNNEL_INVALID_HDR to be consistent with the hunk above.

>  		goto drop;
> +	}
>  
>  	rcu_read_lock();
>  	proto = rcu_dereference(gre_proto[ver]);
> @@ -167,11 +177,11 @@ static int gre_rcv(struct sk_buff *skb)
>  drop_nohandler:
>  	rcu_read_unlock();
>  	dev_core_stats_rx_nohandler_inc(skb->dev);
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);

This looks correct.

>  	return NET_RX_DROP;
>  drop:
>  	dev_core_stats_rx_dropped_inc(skb->dev);
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, reason);
>  	return NET_RX_DROP;
>  }
