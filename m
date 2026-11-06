Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983341;
	b=oiEPY3ZD4/dPPVTVJ8FdcKppuEsP8g/DVXvOUzsjU9r2pcW1K8CiH+gxjz3pxbL80W8h
	 BfHUSsarbXWRGu0SMRCSxv+C03p4wKzIcmEMUjg57uCIu0ZNJZJYVMIkOrDhLCsOUlkSR
	 j00gtGqs7GQsFgBl2zSbl7IxnIbBpe9vrDxb3pnhtsVaSJ70NSAY8bF4UQzSX6scLTKiW
	 Fcm1zzkDn35Sq8nfQsShg4/lqFQFM8mSivme0vZqxraa+bdziUfse86WyDwMtsU5CgZRY
	 FzHyvbSe1au5LmVJaAcRu3R0Gxu+vcfxpbwmOvzXSjOFF9bu9RJivJQT2pHynyWhz1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZFwjx2a4XFS7Rn2YuTa88Hakuqp97j+Wt0wSAdayRf8=;
	b=qFLKXZwNwmwfwr1cgB3/vAYy1LEFjZdxddDjp06EnhqKLpHilY+PfTnwHq75HE5mYoxt
	 SGCHe7IB7/PK9yJDAy5UeSpKTamxDOXSJT7w4iQ+/7DL6ms9+otmFqJsVCIBF8PW2p/N2
	 bExGFZXMbgXbLlMwdbaBM6UM9coMNfGcgqNWjC0GI6Kqd1MazqhJh6NhpLLqzuMDGy8GM
	 HndBTGK3qFCJWoM2oAO4l9LwBIFjq9d319bz5vGy9jYzsFK2E4eTHJctI06l7PTKgz+Gh
	 PC9QPXu4Ez8JMHh+8TE0YSwoaHR+D9nztHLdhQo5ZGmINb0XjhgzFkCzqOOkev0kmjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tIm+4z6p;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0B606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tIm+4z6p
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-992f6d8cb51so189932241.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793983340; x=1794588140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZFwjx2a4XFS7Rn2YuTa88Hakuqp97j+Wt0wSAdayRf8=;
        b=tIm+4z6pfPwnRLbU9gYmyuLFjCyXjg/BiieXPDepbVRjYKLmWXY2JkXTNqBOIHsWpJ
         /HWzQmnZiah2Kiaeq2aoBNsrAeRKkrNM6UeVS4JrX3lnvclUKC5ZkgRrQ4tSuMalhVw9
         +ZrG2rQ196qC2QDtm3KWQ0ZxKtK2k5kjjqCF5p4N3wso04l7AnAa3QwI4ma3JZYGIrJf
         smJQew5/zGzZJRGNAwSx7Fw8DTTCl04DC5qc0u30/tdi5rkGGMCsHCSwPlwhWf3t0w/i
         r3Aw/Vkb/uLV7qiJLJ6xrmecOr4U38Vt9diCJOO4KKgimy9l83QKk4RFqKNvMsbUCg/5
         PMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983340; x=1794588140;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFwjx2a4XFS7Rn2YuTa88Hakuqp97j+Wt0wSAdayRf8=;
        b=fn+2bGbcAuyiAycNPiyusz9k1BQzQR1Ga1pP5bP6zVPxNommN0+ZP03WuAtqs6WTCe
         Wylm3BWpEcacRKGAVgrE5u+Ruh3iktfbY36qZVS3hxxa4RxHRwLTvQRmUssPxyhMDLq9
         PS7Y2+zEOBnN9773siDTKIDDGTxzlAGaIZz07O4u6f0c5aVfsyEJuTZYoW4o4mGIcxLX
         eAWRZBdVbA2EEAbRiAY0Y+RnvrrXGnqWdf31kP7mV5cUfPXl6sD7goAhWYpxXZV7uU+T
         X3yQFQ8iTyYW0Wx0kGFellBT8fSTMnbQKgN2XpDy/yhtw6g1eUgaqHDZhG1puCMumjkR
         GJyg==
X-Forwarded-Encrypted: i=1; AKwUvBxwBgpZc4ql5PRrymawhSgYL51KeP4i8gciFQe1in6u2eNePHqSgkbVJ5sqGOwoOPIX/n6LKrM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hjCSJ7i6TFgAmK8dxUCmNoT3p8o5AdfXZ09FpJCqdMZpHy54h
	Szd0D/LVIgvNqa7TD2Mn66S+8s5fF5OyrOnCAvh9FFIUVn1KxyDfKpfb
X-Gm-Gg: AYBFou2hhTHk4h50l5sQFA2FoMqtJLJNwYZThr0jrKx49Y1pVm5DlmJt/LtGjVz6uNz
	xHj9v5ezLtErNQtpcVrBWK3gJZciMmwE4wa0tPQFOFyJuanSe9ySdAg4zUZL9fNWPgTcj0e+fXo
	cZc6xgdo7OvJJ8hH4JFpH+mWlGZYohAxRnLuOs0mqKHCxOVsC4q3CZ56BhOtx08n7UJuAX7W2SJ
	weMW+NqWLHVsesy+KE1NGxiu1asBYCIOolMXcpLOnW6LzNZiJhii2zWjhyWwIlBPEUYeQogJSOK
	prObT6w1Av8H8hotiQZRm83tr3suep0lSXS1ZbW/jFPLlXGeOi+MJxp11+2VtFF7/uNFb64iHlL
	/t1qZ2Ki7sCDhfVKAMs8jyAxHZzLrTMK/6fXXep0uhgfkvnEdd+4NZxJLKkn7o9pe8jrYsmQCq4
	QHjee/QCerrck2F0Rc1JZkCrTiXNYDZgVAroAlUkba9KMUqAj70SXMvtuO2VMCr3bkBnBFdhN8A
	ry6bZEDiNLHxAro1E2sKNHPM5O3C1iQnOx0J6IXP3Xj3MQnHVxIAptGUdH2i5jummXo2dpX/8Zj
	4O4PZK3JRfgxea7EgS52AYQRYkIRrHjpVHmQJleWPTyGUNX6rhn9DF7Z+NEtzyCYs3ox7JUfrn+
	/5oEZiWnTq2OYlqGjrnPUlkRdDFjzblTPUOT120keg6h/4osJGN5fWYLyo9iNwrl7dCxuTPg=
X-Received: by 2002:a05:6102:509f:b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7d2a1509353mr1381811137.10.1793983339652;
        Fri, 06 Nov 2026 08:42:19 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a89abee6sm1700897137.6.2026.11.06.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:42:19 -0800 (PST)
Date: Fri, 06 Nov 2026 11:42:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 Kyle Zeng <kylebot@openai.com>, 
 Eric Dumazet <edumazet@kernel.org>
Message-ID: <willemdebruijn.kernel.2909f4c55db0f@gmail.com>
In-Reply-To: <20261106141727.2303218-1-edumazet@kernel.org>
References: <20261106141727.2303218-1-edumazet@kernel.org>
Subject: Re: [PATCH net] udp: check frag_list IP family before using
 skb_segment_list()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> UDP fraglist GRO uses SKB_GSO_UDP_L4 for both IPv4 and IPv6.
> 
> __udp_gso_segment() reuses the frag_list skbs when the geometry of
> the head skb was not modified. skb_segment_list() keeps the network
> header of each frag_list skb as it was at GRO time and only adjusts
> the transport header offset.
> 
> Nothing guarantees that the head skb still has the IP family of the
> frag_list skbs: helpers like skb_mpls_pop() let the caller choose
> the new protocol. In that case __udpv6_gso_segment_list_csum()
> handles the 20 byte IPv4 header of each frag_list skb as a struct
> ipv6hdr, and can write IPv6 addresses beyond its linear part.
> 
> Check the IP version of the first frag_list skb. All skbs in the
> list belong to the same flow, so they share the same IP family.
> Use the skb_segment() fallback on a mismatch. Regular fraglist GRO
> traffic keeps the fast path.
> 
> Fixes: b936a9b8d4a5 ("net: ipv6: fix UDPv6 GSO segmentation with NAT")

optionally older

Fixes: c3df39ac9b0e ("udp: ipv4: manipulate network header of NATed UDP GRO fraglist")

> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: simplified the fix, rewrote the comment and the changelog]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> This was found by an AI code review agent.
> The issue was not triggered, no reproducer was provided.
> The fix was tested with tools/testing/selftests/net/udpgro_fwd.sh.
> 
>  net/ipv4/udp_offload.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index cf07c3c6611a22c29b57a72420f2f940609f5e9a..802365b4780fdf7dc19ea7374d51d713e4eb736a 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -514,9 +514,14 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  	}
>  
>  	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> -		 /* Detect modified geometry and pass those to skb_segment. */
> +		/* Detect modified geometry and pass those to skb_segment.
> +		 * SKB_GSO_UDP_L4 is used by both IPv4 and IPv6: also make sure
> +		 * the frag_list skbs still have the IP family we segment for,
> +		 * as their network headers are not rebuilt.
> +		 */
>  		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
> -		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY))
> +		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY) &&
> +		    ip_hdr(skb_shinfo(gso_skb)->frag_list)->version == (is_ipv6 ? 6 : 4))
>  			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>  
>  		ret = __skb_linearize(gso_skb);
> -- 
> 2.53.0
> 


