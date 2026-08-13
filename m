Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111D353A9F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611006; cv=none; b=av++hfo8Dnbz1Evs9Ya9iw0ez2nLbHBaOjoTomwQPOKkDJq5ADICSuMsrceZwZe899fnTIaMObcPTGnc+JF+x+YaZKZsMs7ZVPwebYRIet0lbXqx5rT96FeqKQGYxcQrdrobpsiepeyGddgEtZKE4vfquVbLzGFyoDjwd6YxtNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611006; c=relaxed/simple;
	bh=FjEGFFlm88Ei+R5EFTWOJ5+TvUYy5g7LTG3bgKw3bR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7YpW8/03iYV8t+e+r1UD7kis8qq0oUrTFH7HKhzaa0pRwzkpeZ9hjGfQfjYRJIR+LQPN4H7VoQLAJgUr+EXY857bfZzjK5NiPzP5ujmUoeeseDSm4DFXVvtVgViDRBxrVg19Njk+NodItS7MAMB6GY7w6gRGdMHRbhOPhdU1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/HKpaQ/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+AaFFmC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/HKpaQ/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+AaFFmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786611000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhCeJuOeXQYs6cGlSqtvP+vdZHn0FA++1lLJa9BNjLw=;
	b=Y/HKpaQ/m87UDZPsI0j6Xlyo0lkSNDX+VuQSRcr/XRcHWDUqfzX7tYALTlLljeytZjKf25
	aaNAZKY3bHosou4u8ipnSeOg4cbrnmSrzclmYLyBq7eQ1Hqg0ZET+4/nh7S/cin/kwS1/P
	aoRFx/aiTJQuqX8jW9dZVJ+qXOyw1Q0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-VD7OYsGlNxW1M0-1sSH0TQ-1; Thu, 13 Aug 2026 04:49:53 -0400
X-MC-Unique: VD7OYsGlNxW1M0-1sSH0TQ-1
X-Mimecast-MFC-AGG-ID: VD7OYsGlNxW1M0-1sSH0TQ_1786610993
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4814718d124so1220025f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786610992; x=1787215792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhCeJuOeXQYs6cGlSqtvP+vdZHn0FA++1lLJa9BNjLw=;
        b=P+AaFFmCnMZlAYwcVRZq++IPjsaTcFT0oyXuVNumOz+S9h7Phys+StN1Ai95RXcOmF
         PnueJk3FS+y+gSh0X5QRCJR82pQsuUZRnoSu5npWVOFCU7rodDQ0KYxicjDFrmLpLBGc
         EHKbcWlx4JrV8jZpK31PJZbW3XONu+xAaKSFhEhsZvusMXSkm2rHQM8TUH++tbltPkHX
         mWOpyP8u03SBQxH5pWucMbsejuvyTu3sHNzNwA1Pw2fH8jvAXGxO49IGET6CPwPlfEW4
         fMTC8pcpzsM2B4sMnTuUhoWA9Eae99uILVPrOfI6WGKXno0PCrgQuPf1Gt6E7CcH6x/+
         wO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610992; x=1787215792;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhCeJuOeXQYs6cGlSqtvP+vdZHn0FA++1lLJa9BNjLw=;
        b=o/3RlmPFgoZbosSH7MIfAm3FNMnd9Q8JRZuOeZ4fMX+KJ3ZaeLeFA1z+bu7PX8cSPY
         gsZCFCUfo7X5PwtjX3dDsH7QLe9NySzZOXVfOGYcH+Vk8znCX4yXH2YXl/CuA8BSMvwa
         GE9lTgJ1WYBTNUOaKvIjelrhDZUIZCEBgByUaZxHNK3d1w/LKRaq80O/atxAXv/SH5Ix
         VtAYR6l/XsZ9n0PUYtTC0EWSxNdUhkyHtjZHwCJV2FdLIF8d4eKEcEsf8meojpF2o6xb
         kjnzeegLzBL9zLZ0vKKwH/m98VlACjOBtsmXvZXK9ITPozmnTaPTUkT7Rl0/u1JrJd1R
         WjrA==
X-Forwarded-Encrypted: i=1; AHgh+RqvproAcfCBo5qoqn1V8NvNJzVXy+liVwYaGaDAPk2AZ9ZzumLmlI44lEOdVfjBDeD/Fklq4q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl3EWFPNypk2qttR9GiwIHmkVONOX9GPdYQZowVlp5YHosD4zh
	YGG3Xtn9dg27QaLcdAorwNlsnGvW9hD9qcPv9ktFWYtV4W9tZzjjyy3JZLsbYHBTsJoPGe69zKc
	PNjvZ3luS2G1t7kpVwDycww8yW/lVeVA9mbvWfoJVTL/HvI0gmVMJ1mRyf8Tkf8dLmA==
X-Gm-Gg: AR+sD12Vg7i/PkOj4Cjpv3iO4V37bLiOU/lixYa3mUsxRJ3zeGkPalolD24PHHD2AeU
	Xuj25nDjvOqabqIKleddQFlEC8S36FjbgVT75n+XdepdOy9VMnMoRdUnIrhbW0Rhbsj2xt+uZu+
	1Bd5b4MlwG0NTLFLtyea0Eh6xcNykC/uka+Yk+aGHkCtx3AulYyiCFrFbCCVcztRLcSoCao1/ND
	DMSVZ9dmLFkdOo0a3pNAkBjVn2ub579f2i6exix4o00ctB8QnA2NALoinq9+Nt9pW+e6LPc9tiU
	aSAqgeW0Uec2YHxeYf8p/6Vs9hFuHqC9G6okf3KrzqLvzFFls/dbLi+qcH8dCR0fnmYY+fqjLdN
	Q253vSj5AD1zcIetBaIXOe6hWViP8fMW6GwQndfuJ2lGth9koOKf85Dk5jgqpCKTZGiawLAQSmy
	8=
X-Received: by 2002:a05:600c:6995:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4998216ad6cmr53122085e9.7.1786610992535;
        Thu, 13 Aug 2026 01:49:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6995:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4998216ad6cmr53121185e9.7.1786610992126;
        Thu, 13 Aug 2026 01:49:52 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998216cf70sm41013415e9.12.2026.08.13.01.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 01:49:51 -0700 (PDT)
Message-ID: <64a0b57c-040c-4703-95eb-886701bdf745@redhat.com>
Date: Thu, 13 Aug 2026 10:49:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Tangxin Xie <xietangxin@h-partners.com>,
 stable@vger.kernel.org
References: <20260811085246.2267779-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260811085246.2267779-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 10:52 AM, Eric Dumazet wrote:
> Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
> NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
> which dynamically changed vlandev->hard_header_len.
> 
> This causes two issues:
> 1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
>    read dev->hard_header_len without holding RTNL lock. Mutating
>    hard_header_len dynamically under RTNL creates a data race where upper
>    layers reserve insufficient headroom based on a stale hard_header_len,
>    resulting in skb_under_panic when vlan_dev_hard_header() is called.
> 2. In addition, vlan_transfer_features() updated hard_header_len without
>    updating header_ops, causing a mismatch between allocated headroom
>    and header creation.
> 
> Always setting dev->hard_header_len = real_dev->hard_header_len and
> dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN unconditionally
> ensures:
> - dev->hard_header_len remains 100% static and immutable at real_dev->hard_header_len,
>   eliminating all dynamic runtime updates and data races on hard_header_len.
> - Upper layers allocating skbs via LL_RESERVED_SPACE() will always reserve
>   sufficient headroom for software VLAN tag insertion (real_dev->hard_header_len +
>   real_dev->needed_headroom + VLAN_HLEN).
> - vlandev inherits real_dev->needed_tailroom so underlying trailer/padding/ICV
>   requirements are honored.
> - AF_PACKET SOCK_RAW network header offsets remain correctly aligned at
>   real_dev->hard_header_len.
> - vlan_header_ops is used unconditionally.
> 
> Note to stable teams: Make sure to backport these commits:
> 
> e16e960d55a4 ("ipvlan: inherit needed_headroom and needed_tailroom from phy_dev")
> cef51860becd ("macvlan: inherit needed_headroom and needed_tailroom from lowerdev")
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tangxin Xie <xietangxin@h-partners.com>
> Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com/
> Cc: <stable@vger.kernel.org> # 3.19: e16e960d55a4: ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
> Cc: <stable@vger.kernel.org> # 3.19: cef51860becd: macvlan: inherit needed_headroom and needed_tailroom from lowerdev
> Cc: <stable@vger.kernel.org> # 3.19
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v3: propagate needed_tailroom, add stable tags.
> v2: https://lore.kernel.org/netdev/20260724035419.1473174-1-edumazet@google.com/
> 
>  net/8021q/vlan_dev.c | 39 +++++++--------------------------------
>  1 file changed, 7 insertions(+), 32 deletions(-)
> 
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index ec2569b3f8dac629027b4344bc89402decf026d1..2859cbac3f266b7c4e3f44f41280d33ab69c5270 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops = {
>  	.parse_protocol = vlan_parse_protocol,
>  };
>  
> -static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
> -				     unsigned short type,
> -				     const void *daddr, const void *saddr,
> -				     unsigned int len)
> -{
> -	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -	struct net_device *real_dev = vlan->real_dev;
> -
> -	if (saddr == NULL)
> -		saddr = dev->dev_addr;
> -
> -	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
> -}
> -
> -static const struct header_ops vlan_passthru_header_ops = {
> -	.create	 = vlan_passthru_hard_header,
> -	.parse	 = eth_header_parse,
> -	.parse_protocol = vlan_parse_protocol,
> -};
> -
>  static const struct device_type vlan_type = {
>  	.name	= "vlan",
>  };
> @@ -580,14 +560,10 @@ static int vlan_dev_init(struct net_device *dev)
>  	dev->fcoe_ddp_xid = real_dev->fcoe_ddp_xid;
>  #endif
>  
> -	dev->needed_headroom = real_dev->needed_headroom;
> -	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
> -		dev->header_ops      = &vlan_passthru_header_ops;
> -		dev->hard_header_len = real_dev->hard_header_len;
> -	} else {
> -		dev->header_ops      = &vlan_header_ops;
> -		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;

Sashiko nipa points to a possible functional and performance regression
with unusual config (reorder_hdr off):

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260811085246.2267779-1-edumazet%40google.com

Arguably the current behavior is incorrect, but it's also the
established one. WDYT?

/P

