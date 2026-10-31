Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457154;
	b=5eGcgTYQfi5CmfVyNl46hq6JWBpS1O/6Y1Fb7s5np6mg6Wm2/rD9A4z3YZWpoN20WKkG
	 XQqFZHbZCFZ5s0LsF93WJeCwnhEys8lBOzZyMFXqQuHZ0/8EHE+myEJ4z6useafVAyj5Q
	 Bija9K6LgLtzTU/2LIX567drVQWfGcg0ch8Y/bLtn5EW5ooaKPo7wAHKYV48pfBeWwRYl
	 sVMJ45kfbhevxve2yOYAEjfuzpXoDqeHBiS1vnPeyF5CakhhE3EXPFcqw+6jHS+Ue3uDm
	 8gpr+t6AMVCJlAcz5RfdNPxYV6O24guRj9WYun8yeCZTKo+m0zNbY/mukPSasPhKQuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OvZYDcFDIRWfvfXaq1u7zsXZgEB/FQNUiqs1j++mmR8=;
	b=ip8hWKi7bMd+EgTpRVjKqJ1TC4FQqza8kTc48Yd/yVPrg8144n1k3CBfw7LoMbYCFNJX
	 rXo0TQ8V5VkuAxfuRsN3oO0Hznxdjn1AxovmTgc6vEwVcb1fAnEAab7V+eecef+O+z61r
	 oy74Bu4jsGI3eNvC+bzTftHduGOf8mj2LuAWNCkwZj8hy4WiQ+ZXVaivOjGOguP+UoeZe
	 4v7b/E/qnBQG2QMYIsKGt4whFib7sqdfR2NDLBQL9mmt6rbQNSkK0f6TvHaWM81QAkSPY
	 tsF3g/tVHlpHao89yLxx5pYEtvet6w7Aqghnh9d+hgTr76vrXznxwjfm5KrCxvBSiuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHoaVHww;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF0606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 14:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AEF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHoaVHww
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7ce6cb4c6faso979080137.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793457153; x=1794061953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OvZYDcFDIRWfvfXaq1u7zsXZgEB/FQNUiqs1j++mmR8=;
        b=SHoaVHwwlG7gC4I6IU2I7XHJrFCgo03jFrPHmqa9nlpLPRliO7uPAoMT9o7gbaVCa9
         Kbc+ui+2BiWx0nC3hN8bVuEFR17ckv0Jm6lcSzU970L5mY/ydJhr2izHw0RMmxsiZZdz
         YNnolrWDcr2jN6blXYMV14gGnes9jUhE21BvmZEo5IBo+MlqXVXMd42quJf+Wf6CHjFx
         Ap/OcRSm7eEm/2TLTM8KdLsSDeojOSF9tyRkyKEiMtKTzpan3ojXUlh4ufO+yb6p6lAK
         88fdOYAi9cf740slUVYVmwlhovozfFEznOEHIjvU5gyuvqbbtiujiPwU5yABQ168hKD7
         IYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793457153; x=1794061953;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvZYDcFDIRWfvfXaq1u7zsXZgEB/FQNUiqs1j++mmR8=;
        b=NiL/De1CnWAiFPHVjiG95a87ah2ka9VvTzQvmdVW0GZ6961KREqk2N0SpjtZoSVequ
         DvlLfWDyrk4AsePJcK7HM+yhQb+Bsa0ih8mcohmb6aLfqorVsIVL++SiIsOYaRChM/+k
         Xc8paF0ljhMZwXY+IJm0xc3h6+KEzump5e5L8H7l2dN4FTzQYp8pn2QKRHL228Ff5V9L
         TSmiiWwcx9EIKW3nDwMb24PovO3FzuL5dKSX6Ir4ufE0fVYufCYBIWtDxq6xSYJko0xe
         qGj9snHDbBKIlw+A8U2uKsVZJ6LY+/uk7Kh7M6MTvWpAN41H1QlvsA1t0WPqDRC1nj01
         fHRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIp3+iNQmdynl28kD5IOGHlQaJWb6Ntu8+bKg374lg9UH1HilTQ4Rv4QE527miYIwncqjXIkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrW/QjUtsgrsCVRTxh/GWKXULpCYfzi2IqcJZGzpDIqk+vO+b0
	MWTSWIDkNFyvBU3qGuMDLXTI0TKmR8WoKm+v2hOu7BxLIEAGeP2kQUg4
X-Gm-Gg: AYBFou0r/5ZOsqO1EYBcjSM9unvePll1p9qDvbn6aXXAxcVHXVD8XqgqlClDIs6/aBc
	Fc/9IY5n2P1hdQbiPYxQZDSMtB1HX80D5z2lsr0yqNrigv9IGcra/OaTr0s27NkoM4hMSrBl7UR
	rSif+rQElj0iqWWXCfL7ZrEsMq+8A2LtGC63lUBHuAWkKssjZ+H+kwihvR+jAqMXI/tCdU0aIXQ
	HKh5Bxz7DslhIe3fan+7dsxUopKdOaBkLhKrdK/BYMrddGmuPzN0ZZPFjHG36sploxT/T6OxOAe
	2y6YfsSS9RwDm26N2KxWtgvqaviTHJMysQ3FPtcc9VnfNQnSym7041z6LveVP73eJf2Yp5OAowK
	5pGu3xosT75nm+Bvx5nmn/q9OMGLQrR4IN69n5xEwEr+jRnm/QM8efVO5kquy+t4rdDbcGj5P+R
	Exxo6pUPYaxVoIq+VUuebM0kxxH5tckA6N2MTNv+bgQINpsEI6kkC22v1X2Kp5nrcTYS9AfcnSF
	xXham4NYg855AoK+qYSQmB5JluaR58/QWVrNcUHn6NB5lJmTGp3JHCK1U5LQJTGHtnTSo0MBdT5
	qDAYSca8SLamaSdKcCmoIUj9KAJAfAQAZBUzlm60UHCT2iKC7gqYd0W7IymX7p9JdQWqBIBEBYV
	mj+MREW39lLQ2+kbGOXq3pWrNO0ub9sdbu3VqN9rGCaAVShzequ0VQTdhSzC1ke3OC+BP
X-Received: by 2002:a05:6102:14a3:b0:7a4:e550:eeb9 with SMTP id ada2fe7eead31-7d072710407mr2530458137.22.1793457153130;
        Sat, 31 Oct 2026 07:32:33 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d077606b7asm5562013137.8.2026.10.31.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:32:31 -0700 (PDT)
Date: Sat, 31 Oct 2026 10:32:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bo cao <treebacker@foxmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 edumazet@kernel.org, 
 idosch@nvidia.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.22a3131380a8c@gmail.com>
In-Reply-To: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
References: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
Subject: Re: [PATCH net v3] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
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

bo cao wrote:
> The second half of the MTU guard in __ip6_append_data() has been dead
> code since the initial git import:
> 
> 	if (mtu <= fragheaderlen ||
> 	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> 		goto emsgsize;
> 
> (x & ~7) is unsigned and >= 0, and fragheaderlen is at least
> sizeof(struct ipv6hdr) = 40 > sizeof(struct frag_hdr) = 8, so the
> second condition can never be true.
> 
> For mtu - fragheaderlen in [1,7], (x & ~7) == 0, so
> 
> 	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen - 8
> 
> underflows below fragheaderlen.  Every later bound computed as
> maxfraglen - fragheaderlen then wraps to 0xfffffff8, in particular the
> datalen clamp inside the fragment loop, which never fires and lets
> fraglen = datalen + fragheaderlen escape the MTU constraint.
> 
> With MSG_MORE on an egress device without NETIF_F_SG, alloclen = mtu
> while skb_put() is called with the unclamped fraglen, so a single
> sendmsg() on a raw IPv6 socket with a 1240-byte HOPOPTS cmsg and
> IPV6_MTU = fragheaderlen + 1 triggers:
> 
>   skbuff: skb_over_panic: len:61280 put:61280 ...
>   kernel BUG at net/core/skbuff.c
>   skb_put __ip6_append_data ip6_append_data rawv6_sendmsg
> 
> The same re-lowering exists with a transport-mode xfrm bundle: ESP/AH
> bytes counted in rt->dst.header_len are not part of fragheaderlen
> (ESP lacks XFRM_TYPE_NON_FRAGMENT), and ip6_append_data_mtu()
> subtracts dst.header_len from mtu for the first fragment, so after
> the entry guard passes, the recomputed maxfraglen can be pushed below
> fragheaderlen the same way.
> 
> Replace the dead expression with a single check that requires room
> for at least one 8-octet payload block after the fragment header,
> matching the minimum ip6_fragment() already enforces:
> 
> 	reserved_headerlen = fragheaderlen;
> 	if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
> 		reserved_headerlen += rt->dst.header_len;
> 
> 	if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
> 		goto emsgsize;
> 
> For the transport-mode xfrm case, pre-reserving dst.header_len in the
> entry check makes the later ip6_append_data_mtu() recompute safe: the
> subtracted mtu still satisfies the same minimum, so the recomputed
> maxfraglen cannot drop below fragheaderlen either.  The check runs
> before any zerocopy uarg is allocated, so the emsgsize path needs no
> cleanup.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: bo cao <treebacker@foxmail.com>
> ---
> Changes in v3: collapse the fix into the entry check of
> __ip6_append_data() and leave ip6_append_data_mtu() unchanged, as
> suggested in review of v2; this also removes the emsgsize cleanup
> hazard for the zerocopy uarg and the separate maxfraglen check.
> ---
>  net/ipv6/ip6_output.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a..936dad85f1c9 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1477,7 +1477,7 @@ static int __ip6_append_data(struct sock *sk,
>  	bool paged, hold_tskey = false, extra_uref = false;
>  	struct ipv6_txoptions *opt = v6_cork->opt;
>  	int csummode = CHECKSUM_NONE;
> -	unsigned int maxnonfragsize, headersize;
> +	unsigned int maxnonfragsize, headersize, reserved_headerlen;
>  	unsigned int wmem_alloc_delta = 0;
>  
>  	skb = skb_peek_tail(queue);
> @@ -1499,8 +1499,11 @@ static int __ip6_append_data(struct sock *sk,
>  		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
>  		     rt->rt6i_nfheader_len;
>  
> -	if (mtu <= fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> +	reserved_headerlen = fragheaderlen;
> +	if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
> +		reserved_headerlen += rt->dst.header_len;

    ip6_fragment() only enforces `mtu >= hlen + sizeof(struct frag_hdr) + 8`
    once `skb->len > mtu`. Checking it unconditionally here rejects valid
    unfragmented datagrams that fit within `mtu` and never carry a fragment
    header (even with IPV6_DONTFRAG set)

    Placing this before the `v6_cork->dontfrag` check below also skips
    ipv6_local_rxpmtu() when `dontfrag` is set and the payload exceeds `mtu`
    while `mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8`.

    If this guard is moved below the `dontfrag` / `maxnonfragsize` checks and
    gated on fragmentation actually being needed (`reserved_headerlen +
    cork->length + length > mtu`), `reserved_headerlen` should also include
    `rt->dst.header_len` regardless of `!skb`, so a subsequent corked append
    (`skb != NULL`) that pushes an initially unfragmented datagram past `mtu`
    still accounts for the first fragment's xfrm header space.

> +
> +	if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
>  		goto emsgsize;

