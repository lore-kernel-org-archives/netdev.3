Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806371;
	b=vvycRmdCGImeigecAU36I86cQEMcUkHJQZjicZcYrxlo+w7CKsRFNUN07v5f8l83l42Z
	 GFiv+ZTgRZIkCtW2Nh4ISQeTB3XK6pTy9ZMSKpI/Orp6+etQZqpgh6tRTVfN0WUaYjIn6
	 z6AGq60FvG6PPBXWizGUiT365VbEMQ3YgokoqmVzvMlOoBWlSG5eVu0M/L/c1J/WZhZLB
	 yMIGG5eB4oKjFAeluvPzLUOasMoDWE0hamqOHyOIMiKWsSRMyaZQ7eW6SB5y2Bghm4FIZ
	 FplrS2jyEJuJid6e01RDArap6uaoG7My7EAkQcnn/18G4KPd4snuH9e68PD53KS6qmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VSl8UTHuzcGlusp9eWKHTaKhrhlwdDdWaRoNG7GwWpE=;
	b=Bev15GBsypFg/hVgvUQPXSOysEDVdElqfp5JQl3J5dQYoOUHUiPErxRSNRQcOFVGjgL/
	 qd726h6sPGEkIlFywC0akKCKSm2Mm1EmyY7SPvoB1UFOVPIX7Xmz3xXRsObFLgzKYj9gg
	 ZigvnbxHt/6pJShn4snlwdbDN5F+XKqsw4giXKWOk9iHT553PiF75YrF+gvt+UzMvghFD
	 xSSXtWZoJmDCpmB5PyUPZuFM1/D3JWBdc5HKsnCbFb/giyv+DFA3/gJr9c8yxGWFbDal/
	 M96usKOCmFUYbkXk8TKxrtmKPcgyk0m32Sx6Q4HsGQ9KBKMzNnMTDDjkWXk9G91EoQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KoffEYmt;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26706606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26706606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KoffEYmt
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso247789e0c.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793806370; x=1794411170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VSl8UTHuzcGlusp9eWKHTaKhrhlwdDdWaRoNG7GwWpE=;
        b=KoffEYmtSTtqgY3zwfXbmYHgTOoBv+dyJ/ZeA088MydpOb9jS7rlPrYFM/CiwfZJSw
         ul0qdToy8eDpq6plk1f0dGznO8XToih25glvtXW07nJiHOZqBNPAazRjcWeOn8Y0XeZf
         dKbZ1LpvwLEDidgwNSvQ97gW3zoo/szcFcQif1+3/PNQcs+NKcyktvfzeUrKYALOHZgn
         OWtIvK7lxuNJVWdUIs1zMRvZZdrE9JnLmcJwb8YpXsbiDSIGcgsbpczU9RJAlSBBMSCe
         g/S7d5qiwIl1dEixRh2lDKzLflTC53jGwdLSjdwA1X6fAJyauPedSRDYAgBETNKe31zQ
         RL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806370; x=1794411170;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSl8UTHuzcGlusp9eWKHTaKhrhlwdDdWaRoNG7GwWpE=;
        b=hbiZFCoIXh2OvSgx/aXMypEmtOFi8D4xARnIvTrdjyvx6AIfhuBUNRF4xPWhXvw3kw
         KgXnU7fFliD9dUIdeSXMr3BvAfHKEKiDcOIWNxD37i99GXp1A3/EVzDEkjG6CA1+QJq3
         qPucQgwKYKNUVpi2HFQLdvAVIZ5YgjoEsNT7HZ+6IX7Z6ka9jvEpMIdKsS9CP818V7rH
         wLZ+eseBcojYDdDA3q0SLi6ZZxRPHR6EFVX2WQ3esZqjeaYJgIA7D0Pz6WjJdrsgVI0U
         aBe2e4uMG+uRTnp8t9P9v8rrkpe359ow5tBWLEi0uGuPJyRQKTkWm64B1/GvaAypq18n
         yfTw==
X-Forwarded-Encrypted: i=1; AKwUvByg8ffzmMJoA1CoUKiZLrzV2d5HE8vSIFVrOGSrSMLFyr/4FexVU+Cr7QSe75faZWI16lLO8kE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WnxsHI1fIbIDDRNxFqt0X7dKmJabWBR7dFb6R2PcQePangEcm
	QE4Vv8pT9tARGX4WoHnhOUNd1WRszNNJ5osSz6YjEXI2o432kCldxamb
X-Gm-Gg: AYBFou0CGkwHHr6Rru/HDlOlN19dIJ1S+JwoY1Pd2/ysIIJopYjaexNKW+fjhQwkUTg
	/ve2lKEH9+fEvbz/z9B7zoh6JvjuGXj7iD+6yp+zzsvHXtR1nb6vTWWG7VJ/UFyol5MwZB9SmvB
	PL99dUVrL+vqpS3txbq6sVgESAfY8jqLrJ2zCen40Umqshy7wMWdUsUUKQK4mkRekuRdcgzE3uO
	4xkAd1hzO1i4UfY6DNQaexHqiFyvJ9Z5PYpiXKi+gBsZK/dQs0Qf+hJSscIL3SgBk48bZT9gYeX
	3Id1pRuBIBIhNGeIoQrUVsFJfrUheaZnuXaSM42MCLa+yNohhGta+/mutKNFW3nwPQW2KQCpsth
	8i2d7c7BEbBAEuKIynSTtbeeKEjX1EBNAQ07Fho8FQdA2PohJ7RR3Zaox6v9RXZXUDnDmJbgVkr
	pELNc/lmlHGnru+QbgjZ+PQasC9gzIWcKxNpKQreRyFVWtbM1X+kHXLP8tvImamjXsoYeSK95Y0
	Yy5thwx47ss7edZzgdOnjkf61mQM9TpHZYTae4d+fYUa8TihFGNYRu85uEqn/b6q8h+NICRk6dE
	Ef7h79lzrynVwBuKKijcIsM3ML2yso7Kiip1I2Lx9ImqdhZLxHwPXb14O3i5b8awwvG2SL5QVlm
	HDF8WpRBivbYHqcrOPRlo77daaaHDduGSiE5LO8jj+G5LVSYnD8/j7H/4jvVeQiuTmgH/OoY=
X-Received: by 2002:a05:6122:3a14:b0:5ea:e324:7c19 with SMTP id 71dfb90a1353d-5ec68528589mr6692053e0c.3.1793806369972;
        Wed, 04 Nov 2026 07:32:49 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b81b3sm1906332e0c.2.2026.11.04.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:32:48 -0800 (PST)
Date: Wed, 04 Nov 2026 10:32:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.332f86b4be346@gmail.com>
In-Reply-To: <20261104050131.629967-2-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-2-edumazet@kernel.org>
Subject: Re: [PATCH net v2 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
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
> virtio_net_hdr_tnl_to_skb() trusts the virtio header to describe a
> UDP tunnel over IPv4 or IPv6, but never checks that the frame actually
> carries such outer headers. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
> mandatory for tunnel GSO, __virtio_net_hdr_to_skb() skips the flow
> dissector, so virtio_net_hdr_match_proto() is never applied either.
> 
> A guest (or a tap writer) can then inject a frame with an arbitrary
> outer ethertype, for example ETH_P_NSH, with SKB_GSO_UDP_TUNNEL set.
> The GSO stack then runs nsh_gso_segment() on top of the UDP tunnel
> segmentation, which assumes a different header layout. The result is
> segments with skb->data before skb->head, and a host crash in
> skb_under_panic() as soon as a later layer pushes a header:
> 
>   skbuff: skb_under_panic: ... put:4 ... dev:gretap1
>   kernel BUG at net/core/skbuff.c:215!
>    skb_push
>    __gre_xmit
>    gre_tap_xmit
>    ...
>    tun_get_user
> 
> Validate the outer headers with the parsing helpers from Michael's
> series "net: resolve uncommon partial checksums at ingress":
> 
> - locate the L3 header from the device type: Ethernet with optional
>   VLAN tags, or the network header set by the caller. skb->protocol is
>   not trusted when it disagrees with the frame.
> - require the outer L3 protocol to match the declared tunnel type.
> - require the outer UDP header exactly at outer_th_offset, after IPv4
>   options or IPv6 extension headers, and reject fragments.
> 
> Unlike the original helpers, ipv6_find_hdr() stops at an AH header,
> as Willem suggested in the review of that series.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Hassan Sultan <hassansultan@google.com>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Co-developed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks Eric!


My bot points out a preexisting issue with this udp tunnel feature.
_Not_ reason for changing this patch.

virtio_net_hdr_tnl_to_skb already does not support IFF_TUN, as it has

    outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);

So the only reachable path with IFF_TUN is L3 with IPV4_OPT_LEN 16
(or greater) as indeed test patch 3/3 introduces.
