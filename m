Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6A4C9DE2
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792332991; cv=none; b=PPkZbaKkf9HajkHh4fCCMZp39PYpyVo/VEN4Tzhp7sqe6FhOFHJdawHeJ57nzzj2H2KYYtqHZKOZ47RjSUxI5+cEiE75up9TDSScErXiJ13Sj3LAvRKJPIvKNzVQmNl5VxHdh+UAKbduAH0NaOnErYkEyEGfA6Dw3hIRLVq7K9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792332991; c=relaxed/simple;
	bh=W8vn7NiA5BAvJ8dEFYX46Aidk7UOs5AMvgvxnbQ2tgQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Pd+iL0WnkMmqu7WaFy+ByCMRUG4SS6o6DSyMxk5X8dN/Fn4S78tgXQf2avC8Cfz0VMtwFACx+dj/egfAkfzSXDUS5ll28VscglAmph9Um1dtP3oMGMqLaoDFxVpBvJEYkrBiblNBh7kuM5rjWCcArAOilw8sBqaUtS9aTjW4e1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQAbk4g1; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQAbk4g1"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so1583055e0c.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792332985; x=1792937785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jVaSw9+ay5U/DMzzP2wiXweasla5TRaQQp0iRi1bG1w=;
        b=ZQAbk4g1Cuyrantow3ZsAYFbVcs/uo1TTu24T1L+lWUTsAuJeGI4+dXVKqDZMzeFoZ
         wQQtgnknZNfaJQiqDPZzUA3KIxmYbu/RXVZ3wVEj936oSgqqMjNKjARrEq9PQun9+FM3
         UF5CWy87JAZHnZeyZ67JwxOt2kpGy4t6el4FkX+KrKm/CnDyAsjG6h8JJqtgxjtwNSkd
         6mRloEOSNa+R/FuW5pRt3L0cUUjhDX2AsJgwqryXByYyBD7VfpfpgkzJj4lHqVGRk77k
         6SMjCxRb1lEBAp+bDUi2Qkf6GEi8Kcp6iZtpxaU7sjTGo+YE0BoKta1KR7K8/ZMe5jkV
         jxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792332985; x=1792937785;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVaSw9+ay5U/DMzzP2wiXweasla5TRaQQp0iRi1bG1w=;
        b=AkCPfcm8eJ4ZhLxRaDcAvqS1PHoG3vPZC65GLntZh35cWtxpTI//HVMBVvoBXPd/e9
         Mxg2fyytCqCHZCvvK4o+nsx3hlyBVAE318DpDcwfcKozRdHwGArzVZxIBamQVCG7F+QO
         xGSsuiyL1edyLLwaaJIsgsh3CdbHvX3tulujtssE77yMKOVa7LwJCdM01wHa4nFaPMts
         H45NQKeaTexYE05NoKK8JLsTBJWTkdjXexnpp1Gi7du9FGRtVb0P+Ne1yCsX21vHBuk8
         KmFIJ/bhhgbP60JJL2jvmMQGXoWyx3ycrBnjRLGs4diIvVbrqQeV+Wk2sOt9Zcwbmya7
         YLyg==
X-Forwarded-Encrypted: i=1; AKwUvByPOBjD66+MDu+smHb/5zrw6VVRYDUoDlYwEgAXq17N6IYbMeCqeFvmwrrWC8kDxeHyU4xAbsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkLSZvbZKowBLHvWXFwHrZERQHTJGjy21MQewUVUQ6KQWa32P7
	hm3VritpUKeSgUdz4YoaLagLXdUSs38HkEvsOLyBA/nNL5sXsCmnv7x+IVEPLw==
X-Gm-Gg: AYBFou0EMkmymc+wErGpEw9u2uh9u2WbTatfiaB5fJJz03WsqKpPvzsEFRC86zWf+a+
	6f7x8heBEXuMp5ScasT9cc23tvQM+9GKm9EFntf2H/xQ3lDapHaiWQHa03Dm70K7P7eIG01OAGK
	8Jp92WWxic6Ka698RZpAggWknUcDYrGwc6SYgtAHmb55EGzUhzgpT3CAzCrapH5RzIqc9QEMuMQ
	QPA3vBBavL7qJry91ziEIF1U8a1ix82y3uko/Ve5/S82fZitWkJZoFxq3FiSvljjmBdVqWDKlCq
	UaJBRVBaC3dsLoMPA6T8MrdoCSzA2Ufx64JC1MD115LNpB7uZTrbLxQy7oZAQksAdt0s7u2j5eQ
	1urcYu/BJl0Hau+iNpXNVrfukZs4FERdRjCJMezDY3cu6Py2ehs4yR8uBBLu3yB9HvB7dI3VDwX
	oiz8tFLyXGtgMQ59lHdVbnbttWbA1AoilsB/+Yny+ijF/OpgGYrhbo56QBuYs3Ohx6limadQb3H
	SHb33owxSAh5g4bLXlNDuPYH3CjOM6N/8h65mka2b5I51J4O7MAi4xT4AI5wIAp26Dj11ZvOoye
	F83MkIHOHe6eAzn5ZmVflx9033waHLBkHBbbdA==
X-Received: by 2002:a05:6102:549e:b0:7a0:eb10:79b5 with SMTP id ada2fe7eead31-7cc3691f4e1mr1759603137.10.1792332985368;
        Sun, 18 Oct 2026 07:16:25 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc1928aef3sm7607647137.0.2026.10.18.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:16:24 -0700 (PDT)
Date: Sun, 18 Oct 2026 10:16:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3a3160b92eb96@gmail.com>
In-Reply-To: <b714fa38ab650b313ca3121cd4cb3ee847d06a0d.1792327180.git.mst@redhat.com>
References: <b714fa38ab650b313ca3121cd4cb3ee847d06a0d.1792327180.git.mst@redhat.com>
Subject: Re: [PATCH net-next] net: gso: validate transport header before
 computing segment length
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> If a TCP GSO packet is processed in the stack before a transport

TSO

> header was ever established, the TCP data offset is read through the
> unset header offset, far outside the packet.
> 
> This was demonstrated by syzkaller, back when the input path did not
> dissect such packets: a virtio net header supplying a malformed
> network header was enough.  Qdisc length estimation has carried a
> guard against exactly this since a0dce8752193 ("net: Skip GSO
> length estimation if transport header is not set"); the GSO length
> validators never got one.
> 
> We used to, but we no longer allow such packets in: since 44378d02c5aa
> ("net: always dissect GSO packets in __virtio_net_hdr_to_skb()") the
> virtio net input path dissects all GSO packets.
> 
> But as a defence in depth measure, let's also check before we read: if
> the TCP header is unset or outside the linear data, drop it.
> 
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Can be net or net-next, but given we have Eric's patch in net already,
> net-next seems more appropriate, and it's safer.
> 
>  include/linux/skbuff.h |  5 +++++
>  net/core/gso.c         | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a3ff380d43f0..aa5bc608de06 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3041,6 +3041,11 @@ static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
>  	return skb->inner_network_header > 0;
>  }
>  
> +static inline bool skb_inner_transport_header_was_set(const struct sk_buff *skb)
> +{
> +	return skb->inner_transport_header > 0;

skb_transport_header_was_set has

        return skb->transport_header != (typeof(skb->transport_header))~0U;

is that initialization different for inner_transport_header?
If so, slightly confusing. But also understandable that zero is the
default initialization, I guess.

> +}
> +
>  static inline unsigned char *skb_inner_mac_header(const struct sk_buff *skb)
>  {
>  	return skb->head + skb->inner_mac_header;
> diff --git a/net/core/gso.c b/net/core/gso.c
> index e96ef6350064..d98acfd68595 100644
> --- a/net/core/gso.c
> +++ b/net/core/gso.c
> @@ -131,6 +131,36 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(__skb_gso_segment);
>  
> +/*
> + * GSO processing (but not UDP/SCTP GSO, which uses fixed header

TSO

> + * sizes) reads the TCP header as specified by
> + * skb->transport_header/inner_transport_header.  Make sure it is
> + * there to read.
> + */
> +static bool skb_gso_transport_header_ok(const struct sk_buff *skb)
> +{
> +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	unsigned int thoff;
> +
> +	if (likely(!(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
> +		return true;

The likely case for GSO is TSO.

> +
> +	if (skb->encapsulation) {
> +		if (!skb_inner_transport_header_was_set(skb))
> +			return false;
> +
> +		thoff = skb_inner_transport_offset(skb);
> +	} else {
> +		if (!skb_transport_header_was_set(skb))
> +			return false;
> +
> +		thoff = skb_transport_offset(skb);
> +	}

This is not GSO specific. Could be a helper in skbuff.h?
> +
> +	/* A negative offset converts to a huge value and fails. */
> +	return thoff + sizeof(struct tcphdr) <= skb_headlen(skb);
> +}
> +
>  /**
>   * skb_gso_transport_seglen - Return length of individual segments of a gso packet
>   *
> @@ -253,6 +283,9 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
>   */
>  bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
>  {
> +	if (unlikely(!skb_gso_transport_header_ok(skb)))
> +		return false;
> +

seems weird to test a transport header feature in a network
header test?

Should this instead where it is needed?

>  	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
>  }
>  EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
> @@ -268,6 +301,9 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
>   */
>  bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
>  {
> +	if (unlikely(!skb_gso_transport_header_ok(skb)))
> +		return false;
> +

even more so in a link layer header test

>  	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
>  }
>  EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
> -- 
> MST
> 


