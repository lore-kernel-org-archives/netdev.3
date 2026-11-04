Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757713;
	b=MDKLI+YizIBIn0QpE8a2Ovb3vv622Jt6nN3H6kzPOdatqvl9QzzjbEkLfgxU5K31pdNk
	 CdASpA98OdjqIH/qjyIanKy2HpzTuyYEpphhw9rQugbarZkidWe/lgTJEmUXk+BNKYXtg
	 gZevZZ337LS7UTfAjzOigI42v1gBF6wNskd76rPnl45ZArVWH17ZeGyLARqi+Du/8uail
	 dhMaqLZJLXylFg04BpgVleoYvpXWu9cVbTtHQ9i6tO3SILTAQqE5whUyduaG5uGOCInxv
	 eF+H6tf5dT9413/CZiOWwUB/60iSa3456Pissvd5mARk5bMW0k7t2QStJNAiVRhgXpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ef3LJtj0EHb+BHKwRreNfN/8Uj/h0T0Rh6JYGdvZlAI=;
	b=MTv6AgD4k0RH4XCNTRCsk1Bah+RczudaHme3+VhekJepJGRWA86ZI7Sq2EVqlahdokar
	 2BrjHis32BoJyaLvhey+1YPe91JNlYzG5FcijTxh+l95LaXhjzWHv9WhLr9F4He6xjGR4
	 aiK9FAeYpspBLkXELKRLjTteJQgEmrGHkxAcb3Ozpc8QZEcFYbM/ASIm6On3jt8ZvbFvT
	 /DEhaeBHBGB0epjHez+8a6/NhZ720U5wAzM1q9L+ckodAGt8neX8yZpzWycUqvszNGYWf
	 gz2//WDASXuhkszv0BdFeHOkRTRXKMjayTPOtdEAv84JfEztMwTnnlgzOKXSFSGyU+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZWUGAbX;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCE606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFCE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZWUGAbX
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso47661e0c.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 18:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793757712; x=1794362512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ef3LJtj0EHb+BHKwRreNfN/8Uj/h0T0Rh6JYGdvZlAI=;
        b=oZWUGAbXBr8Chv1GtF/QCTEz3tyNJc7mD9ZQb3n2OE8/HSv+ML4KfqEozI3L8z3pTa
         ueTqC1UrQ+y3H97xhtgb3/y+jhfakcIWE6tS3lG5Dah0JpON718I6mJtxwUsIOv6DFQl
         ZK+2IkPPkRghQ+EjZFtEfI9mYDBOHqz4kALeVnI6bcAYreIMNy/Cw6OLzy/Lkxxq/OiR
         9FAXpDnC2kbPNYYj6CcXk/HZLCcI+yz4MuFBRbNThA/0/viAYRlQ+DQjysFpphSxiLtN
         +98+VobQ78p5L7NM6k5hfid5TFCGxNSFJFaF0rJ08LiqpVut6TMStSxcTTgr8hgfL34E
         xOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793757712; x=1794362512;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ef3LJtj0EHb+BHKwRreNfN/8Uj/h0T0Rh6JYGdvZlAI=;
        b=HaDdtXcWNKyqt0N7w9QzR+Bq1R2+P5OCrKvzKawdkzMQezV8aI8PV9ht5DDm36YezE
         xdvXTLFt6X9sM/cRZryBd+AkPZ3PvEDXEdKYAfFwYzIMd/kVztGm/FoTOrY8fwvm9HbR
         zg6AtRjnUOFZyC0BFHEuyw6vbVopk2E09/RcJcrw+QVvNZ/SogNRHAxzJ1rZcSGiLGM3
         IHoqTSOu7d1xHkmkSXU63e6DGYb1p1ECmPUfUvIoxoEbXo5Ykmni5KQDBWVbUWd0usav
         nSjHcSvmiUQrK6w/lGgCbqhqYjpaZkR54bW9+RJwdhMpI4clzJeFZD7Vo8XVO0heLCia
         OHZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXS/exwIlp0sGFv94tqNfpQ8n8aQIocBIIIsQ6TwcH53CwpBmtIsEDkbKykcZabfV/wT5Rvfw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Xl3nw1qb3jIM/lqLUvp9VnnDJalsz4byLsYh4MPxCIXZE3Upz
	KfKxW07fNpB7Ua5zHkOkv4mLW0dAaFkpAC+U9qEw2IO7M2dwbyKbcHAc
X-Gm-Gg: AYBFou1+H+r8Hpi89qODNfvJKPeTEysRbJooS8qgw1EvOdxr2m5+58t9CowoMypoZVG
	tpFWbjuk2wnDCi/LYg1qJBuJCgZLsG6isaemeSwK9vGb1DrF83thPAEjxDtkTRRw7CamyKaS3jI
	gei6xUa0s/mX287kW1CzRw994iYJrHtgqdm8FdRmz/t9FG9GoAAF4Nohq3ckY419fsv/9Kg+g/O
	ZO4WAZ/IJnLC0RMiRrIEkpv++9jXYZCF9QCobH8AbOJy1TzReqFDC+MYt/Pjc7afufcBBltuGs4
	E0yRRYXJx/rW9biifNel8+9tmMU1+PynZz53VPCnguNJOnSukdgcaUzSTUNaqlgTGxPbg/EAdn9
	58cRfcOoaR8wME/xrfXQUoVGuUWZA6gh8UO+K84P7H/emC6Z1U1AZc+/0m+jat/kiBJHWyXdi3C
	HhpdodGgxJ3ie0L0wO4LHpjKfN9+1Qvrl7EHjIn72k1sHmxmGGQewoAADxmS+RLcBYJz6q+DuJ8
	kH0V2qRfsspbcnkxKfw40F0foRHtZlq2aKrCNIejwxlVbI1dCsYRLAlZfcnoYDuovwoJhtTbbD/
	m6JIH5VavWSq0xsq/zjZ6vX+uInCi8+Bn0od1LgBe7cKzhvI8vSFu0nXXu90L1sYZYQdpx4pMBq
	NnMGzcn0YDbPFnimEsywy9x+A6JdF0NaiRf3ZEqVqk4/o/7sTf4R6lm95nZ7I0mSPryRLo94=
X-Received: by 2002:a05:6122:3115:b0:5d4:1193:73d3 with SMTP id 71dfb90a1353d-5ec6894bf5emr6089133e0c.14.1793757712007;
        Tue, 03 Nov 2026 18:01:52 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d7780fsm615030e0c.3.2026.11.03.18.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:01:51 -0800 (PST)
Date: Tue, 03 Nov 2026 21:01:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 mst@redhat.com
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.2e11b18d6e190@gmail.com>
In-Reply-To: <20261103203113.550604-2-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-2-edumazet@kernel.org>
Subject: Re: [PATCH net 1/3] net: virtio: validate outer protocol of UDP
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
> carries such an outer header. Because VIRTIO_NET_HDR_F_NEEDS_CSUM is
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
> Require the outer L3 protocol to match the declared tunnel type:
> for Ethernet frames, look at the ethertype after optional VLAN tags,
> and check that the outer network header fits before outer_th_offset.
> For IFF_TUN, skb->protocol is already set by the caller.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Reported-by: Hassan Sultan <hassansultan@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>

Thanks for the fix. It overlaps with

commit "net: resolve uncommon partial checksums at ingress"
https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/

There are a bunch of subtle issues here. That series is up to v7.

Two specific issues are that
- skb->protocol in general cannot be trusted, and
- non-L3 sources cannot be assumed Ethernet

Would it make sense to take the relevant parts from the quoted commit,
which has hopefully resolved those edge cases, and send that on its own?
The rest of the series can come later.

> ---
>  include/linux/virtio_net.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..d3f97d71d81c 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -282,6 +282,31 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* The outer network header of a UDP tunnel GSO packet must match the
> + * tunnel type declared in the virtio header, otherwise the GSO stack
> + * would parse the packet as something else (e.g. NSH).
> + */
> +static inline bool virtio_net_tnl_outer_proto_ok(const struct sk_buff *skb,
> +						 bool outer_isv6,
> +						 unsigned int outer_th)
> +{
> +	__be16 expected = outer_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	__be16 proto = skb->protocol;
> +	int nh_off = ETH_HLEN;
> +
> +	/* L3 device (IFF_TUN): the caller already set the protocol. */
> +	if (proto)
> +		return proto == expected;
> +
> +	/* Ethernet frame, possibly VLAN tagged. */
> +	proto = eth_hdr(skb)->h_proto;
> +	if (eth_type_vlan(proto))
> +		proto = __vlan_get_protocol(skb, proto, &nh_off);
> +
> +	return proto == expected &&
> +	       nh_off + virtio_l3min(outer_isv6) <= outer_th;
> +}
> +
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> @@ -338,6 +363,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> +	if (!virtio_net_tnl_outer_proto_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner
> -- 
> 2.53.0
> 


