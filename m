Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793230399;
	b=mplNVYpQsZQ9s32BXoiYfWJWuY4t87pvER2X/DrZTGCpdJGq7TSGQcBp/V+/hHts/J1N
	 NRq4Cj5s74K3H8mIxI2V5XElAipP9od/3VGwBy/uDV5VVDkD3yu2MZX4INdkGjMeCtqXm
	 8zMIUOWDH6b4wmaKT9UqP5kJjNZ7y307scVNfkySKazuuz1tIdmSrywOQPHqx9COYGR3W
	 hS11TP7hb/TN5nNSS/KsHenbOWXdhCK2tT2VBS+uJR7qLuBwOIgjpWA8Ydu5omJJCq2nm
	 hbsfLjrXsZ0BSGy+rLP2faIUuKkCpD+nkQvLini9vFYc2G/bEv3TM2kNKSvyYW0oT+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Caoz38UaWl8alrUkOvASwanRBcF1FUEvpTUdYs4f3aE=;
	b=wjGYZ0IovOb+IE8TMPmLorHbqM5Yniq5A1dxKoVhvKs0SQQOVIRK7Rnb9o1IWvD1mwJp
	 grLEuyI8J50z9M4ywFRmh1YFieRT0k4cUk9jz+fxJgf+EkTVcOxIoJB49w8NQVdy0Cmnh
	 x7UntaHqxzhu1XKQVnaTg61qcBVPyAtnd8zdfYWzVpDBXzyL/mAuoLq///ZVdrgOaFmn1
	 wUSz3WjaaryZ0vZRamXZVllwioaaPgfQIkJPaZRq33+kRmTnRo7H6fQMP4AIOU0bsf6xQ
	 yjn3hK0NAqSYeYnfz9QWdIt58YZeZxCNtu2+p5jCRsbnhuuUnxyJOo+7114k8X4KXVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KAB6IC6O;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7E606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B7E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KAB6IC6O
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eb14d0837fso1070973e0c.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793230398; x=1793835198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Caoz38UaWl8alrUkOvASwanRBcF1FUEvpTUdYs4f3aE=;
        b=KAB6IC6OJxqTzH3dCdq5pRUxB/IE3HIdgc1mW3p69X4Jz9GkEYXKPhSLIj3ssKHVzK
         KUlT6oNVBM68FDspp4rcNIs3DZLGXVd08xbhTLtTrI02pK6Xg0VCuObLgC+WKFVG6zZX
         c35ghCw5Q9PBXYyiktAm/MCEfFSpbN1mlaZoRAbEa/Lx+sWi6GgKsTs/kFGVJdgD4Nc4
         2wrWDx4BbCg+KIJvagkmzWqecK+CqSjELapKfaie0up15kE8GGb6rpkkUSpesN3hM+1f
         V2XnQ9rdDT3qdMo5YQsfMi3kZpK7NWB16AOp6k6eBZ9oM2nO7Q7AGsKcZVOqjTJp+NXL
         xW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793230398; x=1793835198;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Caoz38UaWl8alrUkOvASwanRBcF1FUEvpTUdYs4f3aE=;
        b=nYteR5FLDxsovX71XRAShq4Akpv/P5Fphd+39JwYsX+Vi4Di5gJlG6iUiSI6WaFaJ+
         Y1hOrxoXFq7pWL5CjpCjfOJQ+5eyn1tepUfSg2kOcRqmW0GxMRD1/asjTrns8uwu15f0
         7clcxQjeHhmu+DsZSmVXNoCeHUJI9MfLt74AP5PyYT8y6KdB4x+/ZPt6qF+K4Sce9KSC
         elwbZ287bUgk74zmm+w9LwLtXK6YqAAkAehu+VQsgJbExNkK3zQkb4vhKf6h9k4lNSsP
         klA07QUgk6FSS/f1aDPfADi9SVtju/g5wZdcquIxbM1bwFfTVe3wsnrecUfb83/I3tKy
         x8HA==
X-Forwarded-Encrypted: i=1; AKwUvBwcYVwArLjdXaM3/xLgCI2xYvEkgy6pflzJ1i2vNA/MfWLTcFjlPstCOBe/dbqMO+LNW4wrB98=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6l5vsZzlVGbCY4rAgoJpdphC21HNFEQbBHmt+dX9lq7Pgfkk+
	HU0IelZL3eKueDXa40r5iQDgSfT4VmqHVfdl7T5cq0pDxO5bJhYit61r
X-Gm-Gg: AYBFou2v2zIziv5d4tmdzZq27pPYQcqUJ1PsVlzCld6zXdFP+FQCvgCX2WK9dctHCci
	KgpsC2eou/LGI/WrfmIJY7zdvhlOaxWi5whw23BnFC+GuZHsLpCa6lGzwwlxc1b0Haod4EY8w9g
	uiFOjr3KNcdHbG5R6aFRapIv14Epg5cjz5/FHHvrx0Lr0b2oGW2QcgKfSr7V8AGbLbtFn462rKB
	nPm3qduxRV3qho2wDB96zBek+ZBHVbFP5KKHn9iCABggQJ9gdRiIEYyOhD8FtfgFBaz0EXL2ssM
	pVMu8O4N7BKtmFyY1TVJ9e5+DThXHfsV+w26whmRrUehvprXbf901I+KTDPsdKPlJjybXsrN6tR
	YZV1+VFip3aAuWNJY0kYrWr40LV5jLugqJCrMO/2p+RSFKraRPZBJ+eympkIcCxW6rVMXUec0dc
	TMw8wIpy5oRvWJvGunoSpDJ3+hN7I3I74Z9UGfuapj6Pim/3efUScpyK2o5W9jyJb22RmJ31WzL
	7s34Xu+cUKuphw/PWRSQp63PjNqNWZi/FXeKJe1ui1ClHmZOo4siUbbrCSIQmKti7QR2fCA1Vtv
	WSVwPu18vM9JLbsk8OJw2Tkvu+7FsxkeLT9Nk5nmF3p6pa/SqDBy8b4HVX3PlqvR1uYkiM6sFLc
	HKKpUZYu7mXOO5vkVyEuxTSKqGdZFQF6WuJ4IiqAzTfL/+b5tyrQXEpV5Cw+UIybj70bG
X-Received: by 2002:a05:6102:2906:b0:7cc:16e2:c1a8 with SMTP id ada2fe7eead31-7d03a4ba6femr1931963137.8.1793230398282;
        Wed, 28 Oct 2026 16:33:18 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3c44ee7sm7228730137.6.2026.10.28.16.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:33:17 -0700 (PDT)
Date: Wed, 28 Oct 2026 19:33:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 edumazet@kernel.org, 
 Kyle Zeng <kylebot@openai.com>
Message-ID: <willemdebruijn.kernel.207a67bdeedc5@gmail.com>
In-Reply-To: <20261028171350.2205175-1-edumazet@kernel.org>
References: <20261028171350.2205175-1-edumazet@kernel.org>
Subject: Re: [PATCH net] gro: do not GRO GSO packets with inconsistent payload
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
> tcp_gro_receive() excludes empty non-GSO packets with the unsigned
> len - 1 check, but its GSO branch only checks that gso_size matches
> the held packet's MSS. A trusted TCP GSO skb can reach GRO again with
> no payload after TC pedit increases its TCP data offset.
> 
> If the skb is fully linear, skb_gro_receive() then enters its fragment
> transfer path with nr_frags == 0. The do-while loop copies skb_frag_t
> entries backwards beyond both fragment arrays. An unprivileged process
> using its own user and network namespaces can trigger a KASAN
> slab-out-of-bounds write and panic through veth, pedit and GRE.
> 
> More generally, the payload of such a packet can be shrunk to any
> value, making it inconsistent with its gso_segs, and a GSO packet
> with gso_segs == 0 contributes no segment to the GRO packet.
> 
> Do not aggregate GSO packets with gso_segs == 0, and require the
> payload of GSO packets to be consistent with gso_segs and gso_size,
> the last segment being allowed to be short. This rejects the empty
> skb before either TCP merge helper, and covers both IPv4 and IPv6.
> 
> Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: check payload against gso_segs, refuse gso_segs == 0]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  net/core/gro.c         |  5 +++--
>  net/ipv4/tcp_offload.c | 12 +++++++++---
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index ff828a3dce3ca649e149a840bd6e3dfd9ddaf0c4..1b033855a20db6b8b996179f0b81e38393d3864a 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -513,9 +513,10 @@ static enum gro_result dev_gro_receive(struct gro_node *gro,
>  	NAPI_GRO_CB(skb)->count = 1;
>  	if (unlikely(skb_is_gso(skb))) {
>  		NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
> -		/* Only support TCP and non DODGY users. */
> +		/* Only support TCP and non DODGY users, with a sane gso_segs. */
>  		if (!skb_is_gso_tcp(skb) ||
> -		    (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
> +		    (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) ||
> +		    !NAPI_GRO_CB(skb)->count)

Or make tc_pedit set SKB_GSO_DODGY? BPF already does.

In pedit_l4_skb_offset and pedit_l4_skb_offset.
