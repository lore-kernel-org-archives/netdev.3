Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682538;
	b=vDdUVPrZ1qMeGYcGiudmPQIrjnqLTxqqHtaMzVYZX4mhQk5iwQyJgJ+Ipeua7SmtF51i
	 NBmgB84RF9YMajetMqSjNJXQ0ktI26P1YmriVq+da9m7PffiX7bPEiE4+g7m7F3oPnqcy
	 AJNJr2QvGDVkXky/EuPQdH6bHX1w/5sf4FJ/nSNddcT5FwAAxOqFgZZzoObFwfuEm1R7W
	 Bz02OArdELAsElRqJKGyPm6dYcWywsfcjQC3DoUp7lobdkMZQU1HNE6AL0AREd5Z0pulE
	 4nXUJTtVicYA0ALXbKT+bF6fquiGYFUYYPDuumFstlxarQJ6Q1LzAMklWespSQ8ZbIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=68Rvb7aUxttG4Fdp8saSxzc+J8XhVedG6EOf3uyXFq8=;
	b=D/S0W6WsfJQj8hhwImSfRPuNiaAx1eeDkILjh9HqHdlik/VHvR17ijr7CpJmxsrmC/qM
	 Wac+T8WIt8LXfMEl+MjXEdJYQ1OhqmukHOupcfek9dOPzgOMUMyl/Hn1tE+11JjDZ6vWH
	 HC4LhnVph7jvuDcGSsdersHg0Vncrq8HJBBE2b4veihLonQJfKTK2KD6g6xDSSU1Hbzgk
	 zUgN7pGDeekRi4DepoLsK0ye3a28yGIiB+nLstYgdIwG6EVio65Bt8T5l6NByuEngFG/f
	 Yer4llU7CQddZOQMaiRs/bvA2vpNhrOGi4Y+uh3bC9JwU1NRVrkKZNQdl3/wBRCFxYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=au7AOXxD;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72009606ACC1
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72009606ACC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=au7AOXxD
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eafa528803so302401e0c.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682537; x=1793287337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=68Rvb7aUxttG4Fdp8saSxzc+J8XhVedG6EOf3uyXFq8=;
        b=au7AOXxDjOdgnT3iUi0sFUwP7+rzWqLxnY0aahQ6RumvyAavyTlAvIedps+oiiMveX
         HBzoKlxXYsYhK0RZuQUWy47dXvztxTHl5cBHTt8Dh3eSukfJHdmQDYlEpiArQKhVf738
         tct+HJOcWgild9BtfYGsrW6cAYHjoSTIw4zLzF8qyKIK8rH3fJrLO6oPhaz3hmYGQ5hM
         ichgitfSQN9Jaev9M5WUbZ68RUJpJjqdRv6+/ozELSdVmZolnsBNpTUHvzcIKa9UEDZc
         j5bbzVBOP642OYJlNh0YLot8KeD9htMLUaEBhkAJ5NH6I7UjjyHYLHYCC+vIHQnJiGyZ
         PM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682537; x=1793287337;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68Rvb7aUxttG4Fdp8saSxzc+J8XhVedG6EOf3uyXFq8=;
        b=RKLubtXC0P3aU7p71BaPQvimuDsiuP3whIty2EY+mBpLEKj7/tojSqDD8rgm5yixO/
         c9TbTNbm38oeXZGIKYFdeitZSOmeGH4o2KJZBHje9ffrpg9Zltl/a5/mQWRyj6Basxp8
         IKA9jd1Y98gBva2+cM6ewFOVPib1P29U40bKBR6PpZpvqR9Rs+LuLIvh5Me/L5XH7Gxc
         sX1XRWUaDpCaU7gn5A+pa9ZCZZ7m18XLAWZ+h5rezgFkn7jFyuYp8EvSoba1NSx+6gIu
         DYp5fV2PgGxDzbADbnPPZE8xPnSYdeKSJuIAzRck0SHAp4gXQk4ViE7pd1n8zgD5P8mF
         nm7w==
X-Forwarded-Encrypted: i=1; AKwUvBy+nGHM8w9yL3U7ScYUdEvOTCraCQOl72eN0hvIAycxTJ5D3wQt5esXk2yfvruNQkhmWtVgLDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr/EZWw7C1wPN9irm1ejC99zJAdp2aD7503KWVhoBb4YCUbj7K
	afYfsI/MvWflmpuBZa8k8uCs0NgxHsa3SCnbCqg+iS45kmoob3kUO1D1
X-Gm-Gg: AYBFou3eQWhtr4PaShNZYI2R5ngfWflku0We1BSNUOxULNSlZBamI8tMStpML5Pi6y+
	c8ZphAN56P1oWH8SekpMBdkr6hldcTdhbDMxd2c3haX5+z2ycOBtnmMDusMWhKWY4WjYa1OvjNl
	FZfaeu0AcOi1mb6HVaw8XYGOdF0qFgIJ8H8SAI5jEYiktS3L1h9A75tnkT7uF1av3vl6qGd86xC
	qNeNYu0qvcrWvJmIP5wRLEggpbey9XDIijj+mG/dTRigYR4Djdj9RQgE02NxPGtRYEOgl3qTMng
	+yw0umN6odpqfJ8kB9KpJbkDBkz5Rdl+ck9OUT7gTE9bFKtIel518IFtxNQgMLONWNDbRb1oqBv
	UH9fVxO5Z0/LV7wJwDITNZqUjRMyI3K1Z7x3bAAecRZp6p7lheUVfy4a2iRV0oSJhk4W3U4UtYY
	BWR9C1ef9GoXlj3xpWUChyGOLP9BPAPdO74Nhd50lQOko7rQCxAThrAja9JWNyHnRJXIuQAlQVx
	2PFLklq3EdqN3h8gh6mdEJhpBaNdq3bHH5dzLB542EDZ0GRmZSv1kDXKALUjOxYxSLVJvQ7tFgU
	Vi+xTMjYpTWHHyR3BH2bJ74vUFR6eZIBo1pZ7ftDI3tTH0OkirehVfIhpLkPpXmep0Lu/Hbbgpq
	dURej6McPeyrTJZc0ce7ZcknilJaSTuOlItxNnugn
X-Received: by 2002:a05:6122:4d86:b0:5ea:dbae:3cb1 with SMTP id 71dfb90a1353d-5eaebeb916dmr2122937e0c.19.1792682537176;
        Thu, 22 Oct 2026 08:22:17 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae9787f03sm7277042e0c.4.2026.10.22.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:22:16 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:22:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Victor Nogueira <victor@mojatatu.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1c05560ef167@gmail.com>
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
Subject: Re: [PATCH net 3/5] net: tun: keep TUN short linear copy hints safe
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

Jamal Hadi Salim wrote:
> The issue:
> A TUN skb can be redirected by tc mirred to an Ethernet xmit path, which
> calls eth_type_trans() and needs a full Ethernet header in the linear
> area.  tun_get_user() currently validates len and the GSO header length
> only for IFF_TAP, so an IFF_TUN | IFF_VNET_HDR packet can set hdr_len to
> 1..13 and leave fewer than ETH_HLEN linear bytes.  The redirected packet
> then BUGs in eth_type_trans().

TUN mode does not imply Ethernet. Indeed, TUN implies an L3 packet?
> 
> The Fix:
> Reject packets shorter than ETH_HLEN in both modes.  For IFF_TUN, where
> hdr_len is only an allocation/copy hint when GSO and checksum offload are
> off, raise a short nonzero hdr_len to ETH_HLEN instead of rejecting the
> write.  Keep the TAP rejection and its NET_IP_ALIGN adjustment unchanged.
> This preserves valid no-offload TUN writes with hints below ETH_HLEN while
> guaranteeing at least ETH_HLEN linear bytes for the redirected consumer.
> 
> The maximum receive headroom advertised through tun_set_headroom() must
> reserve the same linear minimum.  A large upper-device needed_headroom
> (for example an L2 netkit port behind a VLAN in an OVS datapath) otherwise
> caps good_linear below ETH_HLEN and defeats the clamp.  Reserve ETH_HLEN
> for TUN; the TAP branch already reserves ETH_HLEN + NET_IP_ALIGN.
> 
> Conditions to recreate the bug (repro available):
> - create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
> - attach ingress mirred egress redirect dev lo;
> - write a virtio_net_hdr with hdr_len=1 and an 8192-byte payload.
> Unfixed kernel will panic in eth_type_trans via loopback_xmit.
> In a fixed kernel the write is accepted with hdr_len clamped to ETH_HLEN and the
> packet is forwarded without a BUG.
> - no-offload acceptance: a separate check writes a 28-byte IPv4/UDP-shaped
>   packet with hdr_len 0, 1, 13, 14 and 20; all writes are accepted.
> - high headroom: create an L2 netkit pair with headroom 4096, put a VLAN
>   over it, and add both the VLAN and the TUN to one OVS datapath so the
>   TUN receive headroom is raised to 4100.  The same hdr_len=1 jumbo must
>   keep at least ETH_HLEN linear bytes; without the setter reservation it
>   still BUGs.
> 
> Fixes: f42157cb568c ("tun: fallback if skb_alloc() fails on big packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  drivers/net/tun.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 242899f7fd07..1e235c2f0aee 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1193,7 +1193,7 @@ static void tun_set_headroom(struct net_device *dev, int new_hr)
>  	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
>  		max_headroom -= ETH_HLEN + NET_IP_ALIGN;
>  	else
> -		max_headroom -= 1;
> +		max_headroom -= ETH_HLEN;
>  
>  	tun->align = clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
>  }
> @@ -1830,6 +1830,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		align += NET_IP_ALIGN;
>  		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
>  			return -EINVAL;
> +	} else {
> +		if (unlikely(len < ETH_HLEN))
> +			return -EINVAL;
> +		if (hdr_len)
> +			hdr_len = max_t(int, hdr_len, ETH_HLEN);
>  	}
>  
>  	good_linear = SKB_MAX_HEAD(align);
> -- 
> 2.43.0
> 


