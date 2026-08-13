Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DBE33937F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588187; cv=none; b=MdfhoPlrKcZllKPH0ATHRh05bYA9CFEmQ0T3qXd0U7ZRgGQhHUhiLPlnqBZla+NWqVBJCKwNEe965IxmhXbxxa46azf3fPsHti8dMy3B6LitlDBLDdiBoU3hcFvpc59w7Ca4bWU3p0wiqECG4Oq4bkH98ADTIy+gmF9pEdDK0u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588187; c=relaxed/simple;
	bh=HgaVcvjFh5t19JEzA/gHWyXxmDbDupg6zoy1y8nrNQg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B61uunAkb1zYe6T6grvetb6fxURZEql0TioF47EoypBg5xI0PDikjaG5zJz4CEH6g8i1FqMpaYUUxEHUvLQYkrFKwCvkv6FBbO/08/r5YaTRnqPukJ2JT16eQNLLXV9QpOOKtWXZidFlbC7vAOzl2eox0MW8p7xN2d/4aGJ9BBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNRZoAMx; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNRZoAMx"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c2d726650so1393003d50.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786588184; x=1787192984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cnmgta/wS6M8HYTbflNWe4vYMLIDSzI2C2egQNuOXpM=;
        b=oNRZoAMxUVTPyV8TPcX25wkXr9y8CW6Qc+4T3ZAKBo5p8vjNALg9EzOVzI/5bHzfoy
         MknvqgN8QONrVHsZcjtHzZpQZnob/e/t9XzvIdXhTaTXzX6845CXZi9JkK8ROX40roGi
         5maRaFdkqU0t0wW5IxPEQ76K5+FtaTyupGiuMH79/0slyxO/BzMEHTSCOc0Q6mszZmrO
         zJgUIwnpbpYg3bDJF2CmNQQIu+RTzee3ZTfQLlkFpEef5WaJTsJ5c4jau7senTj00I+u
         4Uh1vxjGu8OdqXPIX9dhp9+zzKJaftYiJumA9ExIqtJ6MAuPXdp+pYUGwjX67TNMHbwa
         28Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786588184; x=1787192984;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnmgta/wS6M8HYTbflNWe4vYMLIDSzI2C2egQNuOXpM=;
        b=kiZN7Sn40qQ42FcAXjVfFR5lA5vsX85AQYYyM7x+BEQ+NJD2QvEziEl3Kn1gQOg6zv
         NIvmD1vi3+LS36gv8uzn0fh6UiF+RkTOByapqSC0ve5EnolE41djQ4N6bHsrCcdpvHKA
         lndH+8u1/woyZtXV1Fr6rFik8WrtlhOt2AsFDVCDx86X1fLdPsKC6IYezEs+IQEnZ7Ka
         uJQPm1F9qZEawu4IKyegG0PeZStEDwTMjDHPDfT5R30NhxYBSDQZN2okwENYfXlAK977
         9KHI2APqpXxfNn5Wr58089FnAqm3JjKZ5g8RpxAmryz3QvmHuqrDhdgqnk7WGaimK0HN
         HtgA==
X-Forwarded-Encrypted: i=1; AHgh+Rovk4wKbzXCYF677rLWvCo8x3Xz+P2Tfan0NhXzhbITSU7Encf+9cGcDMKr+yeIpMOfvjJdKKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK92RG5euStttdsSnlI2MDXqVkmnEf3KeftV0QTYyHmRg1cg/M
	DnyAP2DTjoAlYPddLLibhm4phJfto/S22SnOYY32P0eVyB/dAElhwN4s
X-Gm-Gg: AR+sD10pbVFCcCv9A/1MntT75d7TZeuJ0smQ0JKdHWRNbku2sM4uerTRkws24pdcAfJ
	a1kQYzTHdrG6BneMO94LXepWBg4eSAvFFMLt0zBcuTE1+lg6ywkMX4Dw1jgkV/fWllTWTBe0x3h
	9clSEsnPUl63Bc8exP+QX45YbExjY3B4aMizXWQD+qtiBfT7/Etga/rvN8/r/XcuhnU0g6+Qs+S
	wsWtnN5NVoD9iVjMvqMX/6hxDPKzRtJ5ze9CRpdTdHTL1kc4pY9gHdKsmobh2bVE1pjVw3y7/u1
	scH2ivScNurqtXkgsgZVHLf8Zxjp3ApXZUcLxmvnTT4ZsEzVD+5Nf8aJTZ+544WxEFs3Ux3w1gD
	JtYApGMAIR2//35/LjJ2klGg/rCk4XsiZjC978rvlEZZWQecUuLiXaPeAWxrnPY+esu47s16bEy
	MI+ZYVyshQn0M+pZwijsa7itigcdd3HKUg7SzGmiG25y5bnjhJzKn4onGKyHYR849gAobPu7w/O
	V/EX96Rz9xqsjm8ZIfyrYNSC4rO4hhyYdG8R3GOaUComic=
X-Received: by 2002:a05:690e:4288:10b0:66c:4be4:89ef with SMTP id 956f58d0204a3-66c514f1295mr1042206d50.14.1786588183813;
        Wed, 12 Aug 2026 19:29:43 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8346f704851sm4472597b3.48.2026.08.12.19.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:29:42 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:29:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zhaoping.shu@mediatek.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 hw.he@mediatek.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: haijun.liu@mediatek.com, 
 xiayu.zhang@mediatek.com, 
 lambert.wang@mediatek.com, 
 Iven.Yang@mediatek.com, 
 Zhaoping Shu <zhaoping.shu@mediatek.com>
Message-ID: <willemdebruijn.kernel.1372b82f50882@gmail.com>
In-Reply-To: <20260813014056.160533-1-zhaoping.shu@mediatek.com>
References: <20260813014056.160533-1-zhaoping.shu@mediatek.com>
Subject: Re: [PATCH net v3] net: gro: Fix nesting of TCP GSO SKBs in 
 skb_gro_receive_list()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zhaoping.shu@ wrote:
> From: HW He <hw.he@mediatek.com>
> 
> A device supports GRO_HW, and the device driver enables the
> NETIF_F_GRO_FRAGLIST feature. During a tethering test,
> skb_gro_receive_list() reaggregates the GSO packet. However,
> skb_segment_list() cannot segment this packet back into
> the original packets, which leads to IP fragmentation or packet drop.
> 
> Scenario (Tethering/Forwarding):
> 1.Driver submits a single TCP packet, P1. P1 is kept in the
> gro_list as the first packet.
> 
> 2. The driver submits a TCP GSO skb, P2. P2 has already aggregated
> multiple TCP packets by HW_GRO, and its non-linear data is stored in
> frags[].
> 
> 3. P1 and P2 match the GRO rules, and since there is no local socket,
> they are aggregated by skb_gro_receive_list(). The resulting skb,
> P3, has a frag_list entry that still contains frags[]:
> P3: [ Linear Data ] -> frag_list -> [ Linear Data ]
>                                     [ frag[1] ]
>                                     [ frag[2] ]
>                                     ...
> 4. Later, tcp4_gso_segment() or tcp6_gso_segment() calls
> skb_segment_list() to segment P3. However, skb_segment_list() only
> segments the entries in frag_list. It does not segment the frags[]
> inside P2, so P3 is not restored to the original packets, which leads
> to IP fragmentation or packet drop in the following path.
> 
> When NETIF_F_GRO_HW is enabled, do not set NAPI_GRO_CB(skb)->is_flist.
> Fall through to the regular skb_gro_receive() path instead of
> skb_gro_receive_list().
> 
> Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
> Signed-off-by: HW He <hw.he@mediatek.com>
> Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
> ---
> [2]: https://patchwork.kernel.org/patch/14706032
> [1]: https://patchwork.kernel.org/patch/14702209
> ---
>  net/ipv4/tcp_offload.c   | 7 +++----
>  net/ipv6/tcpv6_offload.c | 3 ++-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 3b1fdcd3cb29..641c47fb1ea2 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -395,9 +395,6 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
>  	struct net *net;
>  	int iif, sdif;
>  
> -	if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
> -		return;
> -

Interesting that ipv4 and ipv6 diverge here. Nice to try to make them
more alike.

>  	p = tcp_gro_lookup(head, th);
>  	if (p) {
>  		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
> @@ -430,7 +427,9 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
>  	if (!th)
>  		goto flush;
>  
> -	tcp4_check_fraglist_gro(head, skb, th);
> +	if (unlikely((skb->dev->features & NETIF_F_GRO_FRAGLIST) &&
> +		     !(skb->dev->features & NETIF_F_GRO_HW)))

Would it be better to test skb_is_gso(skb) and only skip fraglist GRO
for HW-GRO skbs, rather than disabling it for all skbs?

If treating the features as mutually exclusive, another option would
be to replace these datapath checks with disabling one at configuration
time, in netdev_fix_features.


