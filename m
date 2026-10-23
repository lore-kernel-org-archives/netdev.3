Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784271;
	b=AGVAdqwqVRCOh7WIfvwHc9+iUyv5yNihd6rIfKmwLR5krJ8YnvK0vVf8ZKuml2UB1ipr
	 n6x1fZHG9IgMMvY06pONplPliOo79fc1BJLEl3o74ql8fcPtcNel4zJEMfPNAlnJTWvQH
	 o1hej3MZanxChVaPthaf4GoVT2yotYfA6CuAM9AtP9auuuBttMDp5orawjWP1thlKRN+u
	 PTkSVYD5F/VZRzRqqeEvxVG4kiXDxoOk54UlimvfdjWj6uZeekvpOPCLw0BdrhWFp72Mi
	 sx9rZ69eiKaTIhit3M20ocppxkYyDyPrhNg4QOQm/Ls8ludNi9cBnLjYL7tc6RZqr1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dBqlzpdFcJ3hUDMw92HPVyeVA39vP3B1zf8tX9+k8sk=;
	b=VGzOsndpN5x539KX5QHw/TWdsuzq+v4t0BL2hYrxlvirps0lYOvPObXJrMsbRphPdEnB
	 +Uz0He8w4MI8aV7MFk0Ie8Vmzjt1Mpecg3R9iN3yXD6T8BuhwmO4g/c6CZFehta28zmIx
	 B7iDhYNeH4PeDe29Xd9jKlhiawX8V39Ivum4bdng8sKftZQtvq4AL06ZYDIOaIpDwYfPo
	 mOuRYu9wcTGfIJk8uLhITRRCTqzlm9jgHn76o2EhXvJVN2s9XfBFj9a7S+MZ8ljdblnyU
	 O70YFEiSs7k2Y/M3HFbVRITOg7+snu8mQgwIWmgV9U8+pb4B2zhjXAZsNGMRrPzJ+3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pZlfqFW0;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A5606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 157A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pZlfqFW0
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cc013095d4so378580137.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792784270; x=1793389070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dBqlzpdFcJ3hUDMw92HPVyeVA39vP3B1zf8tX9+k8sk=;
        b=pZlfqFW0RtfJVe2ispa6nozv4AXQIPar7T5xrUUaAcsv1voVu0GdwTl/86CDn9W7L5
         c/d9WZSqghU4WxTrERP2c4j1GQsiVYTJL8z+VacZjjgI12E7UdJPiPf3kzgb5uKB+dWK
         mJ4sTYkwcK7YkOmZcGTXqObzN0v6JGK8l3mNclJXrsoGI+B5OsPorjniK3x+NTfDOsgU
         WAHl9RlwtZfVaOY6t6JHZip3sq2R7EF2bTY3/YPlYsySkrowvP4XXiuPiEdHfcyf0mc2
         EMHGZuy5bc9HA1iPzfzCRobbZBMSOPGFK5VTGaXJ4aC1mTORrAZDo+RvvifzDkUWguMu
         fJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792784270; x=1793389070;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dBqlzpdFcJ3hUDMw92HPVyeVA39vP3B1zf8tX9+k8sk=;
        b=atHw+/6DIwnQg7hiuMgUiQjG0InX360wVXchBghZO8f+DTEwOTLrcPSqF8nWDrPELp
         Dbg7SxBjMOASwdSjAxhhlBwn6krpSX6crn5rOIjqTsQeoPthAVilHCZ3Dsaac5UPLLqS
         NFlAzQ5Y3QgBwqKazgKH3+TNzVfhuWJPuexMsIY91gAuNw9y5lPlaEkuuQkPnLu1Wp80
         cG0eM+RLp9/x+MIzI0A5yZX/3lfmn/k4354WHVN7xUZKaCFOwTUBLtmP6aqcS4q3eNuV
         HsYw60PORzJGzqkuJ188he5627RkTYftOF/GrGzbxkmiOoAqKYvo7wQ9lBiMNrJitWMn
         OwHw==
X-Forwarded-Encrypted: i=1; AKwUvBxxauiG3iCje1p+UY3BLrWIjAV+a8CpYNPQBzliv2jfc5uGXYoev4yNGxm1BzfM8OTAN9BTWYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkvUcv0AchDcmnq+ZD+R3fhlCWcnLPIasDjKqKKm9c05RkX1hY
	i3SLD1BYfiJgsltZef2MR7wo1b44YVWvUWFPH3yIg0AWyxUxtcWaVfrI
X-Gm-Gg: AYBFou0kNyZjlJDtJHc0QKjU3/Ul9OYmku3AnMhA8Yn0nY7VGpBFIM2xwiN8OXDWw1D
	qzOxPoeMOhYwbHB+pcfRELhzHK+ewvLLXjlY75kmRcOlC3y4dVRyYY9MsJ08645GTzQxmMEi/Hy
	v7Ry1fsIranW3Y3MbdSCNYpAm8Do1APOlAXKexsNWn9g8kwhm9iD4EgvoWTKwWv/9WnT30lYJYg
	XQv3Ck+nkNJbWuQTvZjatZ2RIV7ICSyEOX0a+4xSTV+lO59XOWsUw6EzQ29HJ9vllXCF2zu/Z1k
	golvkIhFlduS55RehV5qhk4ULwJouDPdGP/m2LW5a1VIfDETNXLPI5L635l30UGYurGZzo1mx/N
	vogya2XIivZz/VO38+ObljrpVQEs0zTYqWWW4ln76f7x/omHAfArc6XefOyQcilacFdd0r5RfTN
	1r4kdbQKvqvpDKFLTAHlvV6oFUyD4x64ics7KDTeoXKp5Cwisii2Esxn/B7xV3KimCyhKbHm9to
	wkcWQFcRawFCoEuJ7sF6ibw045jxG/956brKYYEDs2hj0LcoufqfuJOTitq6oTUEfG6LAkjVVkW
	K5hDve7JGtLdRD7KjjoE+cgYssoVGqCCOg9gYZa3ws4xmOrSNLBtbgQZUE7cevHIF5gIK8Bq+IA
	GPVLBUJfKOuW3Q27MwOA=
X-Received: by 2002:a67:e7cb:0:b0:7cb:bc5e:7dab with SMTP id ada2fe7eead31-7ce5cd5c735mr53020137.24.1792784269876;
        Fri, 23 Oct 2026 12:37:49 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e5f0452sm455908241.0.2026.10.23.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:37:49 -0700 (PDT)
Date: Fri, 23 Oct 2026 15:37:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Paulos Yibelo <habte.yibelo@gmail.com>
Message-ID: <willemdebruijn.kernel.3ae6f662e1ed8@gmail.com>
In-Reply-To: <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
 <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
Subject: Re: [PATCH net v6 4/5] net: resolve uncommon partial checksums at
 ingress
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

Michael S. Tsirkin wrote:
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users) a
> virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> If that state is retained, later checksum completion can modify the
> packet after protocol processing has made decisions from it.
> 
> Let's fix that: let's validate csum_start and csum_offset and only keep
> CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> headers.  Complete other non-GSO checksums immediately, before any
> protocol processing runs.
> 
> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that shouldn't happen.
> 
> There's some risk here:
> - non-gso packets which can't be parsed get checksum calculated in
>   software, adding performance overhead
> - gso packets which can't be parsed get dropped
> 
> Note that for zero copy, userspace can change the data after the
> checksum has been calculated.  This is fundamental to zero copy by
> design, and the only outcome is a bad checksum and a packet drop.
> 
> To mitigate the risks, the following patch will add a sysctl knob to
> bypass the resolution. This is reasonable if the setup is such that
> there is no protocol processing at all.
> 
> UDP tunnel headers get the same handling on the inner header.
> 
> Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> 
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Tested-by: Chris Arges <carges@cloudflare.com>
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

A few comments inline. All but one cosmetic. Feel free to ignore
those. Please do review the comment from an LLM about the tunnel.
Aside from that LGTM.

> +static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> +						  unsigned int nhoff,
> +						  unsigned int *thoff)
> +{
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> +		return NULL;
> +
> +	iph = (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version != 4 ||
> +	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> +		return NULL;
> +
> +	*thoff = nhoff + iph->ihl * sizeof(u32);
> +	/* Pull the options as well: the transport header offset
> +	 * returned above must be within the linear data.  iph goes
> +	 * stale across the pull.
> +	 */
> +	if (!pskb_may_pull(skb, *thoff))

perhaps a local var instead of dereference the pointer here.
though the compiler probably optimizes that anyway (?)
> +		return NULL;
> +
> +	return (struct iphdr *)(skb->data + nhoff);
> +}
> +

> +/* Walk the L3 header at @nhoff: where does its transport header
> + * start, and which protocol is it?  Returns false if the header
> + * is truncated, malformed or fragmented.
> + */
> +static inline bool
> +virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
> +		    unsigned int *thoff, int *ip_proto)
> +{
> +	if (proto == htons(ETH_P_IP)) {
> +		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
> +
> +		if (!iph || ip_is_fragment(iph))
> +			return false;
> +		*ip_proto = iph->protocol;
> +		return true;
> +	}
> +
> +	if (proto == htons(ETH_P_IPV6)) {
> +		const struct ipv6hdr *iph;
> +		int flags = 0;
> +
> +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> +			return false;
> +		iph = (const void *)(skb->data + nhoff);
> +		if (iph->version != 6)
> +			return false;
> +		*thoff = nhoff + sizeof(*iph);
> +		*ip_proto = iph->nexthdr;
> +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> +			*thoff = nhoff;
> +			/* Find the transport header behind any
> +			 * extension headers, AH included.
> +			 */
> +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);
> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;

Since ipv6_find_hdr is called with target -1, any non extension
header might pass. Do we want to restrict here to IPPROTO_TCP and
IPPROTO_UDP again? No other transport layer requests csum offload.

>  static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					const struct virtio_net_hdr *hdr,
>  					bool little_endian)
>  {
> -	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> +	typeof(skb->transport_header) old_transport = skb->transport_header;
> +	int ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> +					  hdr->gso_type);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (skb->ip_summed != CHECKSUM_PARTIAL ||
> +	    virtio_net_csum_partial_ok(skb, hdr->gso_type))
> +		return 0;

This is the common hotpath, but default branch prediction is to
predict if without else as not-taken. Probably not very important on
modern server CPUs, but optionally add likely. Same below in the
tunnel code.
> +
> +	/*
> +	 * Here we do not trust the checksum metadata.
> +	 * __virtio_net_hdr_to_skb set the transport header to csum_start
> +	 * from virtio hdr, restore it to a known good value.
> +	 */
> +	skb->transport_header = old_transport;
> +
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);
>  }
>  

>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> @@ -293,6 +558,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	unsigned int inner_nh, outer_th, inner_th;
>  	unsigned int inner_l3min, outer_l3min;
>  	u8 gso_inner_type, gso_tunnel_type;
> +	__be16 inner_proto;
>  	bool outer_isv6, inner_isv6;
>  	int ret;
>  
> @@ -335,9 +601,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
>  				      hdr->gso_type & ~gso_tunnel_type);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +
>  	/* In case of USO, the inner protocol is still unknown and
>  	 * `inner_isv6` is just a guess, additional parsing is needed.
>  	 * The previous validation ensures that accessing an ipv4 inner
> @@ -352,8 +621,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			return -EINVAL;
>  	}
>  
> -	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> -						 htons(ETH_P_IP));
> +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	skb_set_inner_protocol(skb, inner_proto);
>  	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
>  		if (!tnl_csum_negotiated)
>  			return -EINVAL;
> @@ -368,7 +637,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
>  	skb->transport_header = outer_th + skb_headroom(skb);
>  	skb->encapsulation = 1;
> -	return 0;
> +
> +	if (!skb_is_gso(skb))
> +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> +					       SKB_GSO_UDP_TUNNEL);
> +
> +	/*
> +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> +	 * set CHECKSUM_PARTIAL.
> +	 */
> +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> +						 inner_proto))
> +		return 0;
> +
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);

    Allowing `!skb_is_gso(skb)` packets through `virtio_net_hdr_tnl_to_skb()`
    has a few issues:

    1. When `!skb_is_gso(skb)` and `virtio_net_csum_partial_ok_at_offset()`
       returns false, `__virtio_net_resolve_csum_partial_mismatch()` completes
       the checksum in software and lets the packet pass, but `skb->encapsulation`,
       `skb->inner_protocol`, `skb->inner_transport_header`,
       `skb->inner_network_header`, and `skb->inner_mac_header` have already
       been populated with the unvalidated `inner_th` (`csum_start`) and
       `inner_nh` offsets (unlike `virtio_net_hdr_to_skb()`, which restores
       `skb->transport_header`).
    2. If `!skb_is_gso(skb)` and `VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM` is set,
       clearing `SKB_GSO_UDP_TUNNEL_CSUM` drops the outer UDP checksum request,
       since a non-GSO skb can only carry a single `CHECKSUM_PARTIAL` offset
       (at `inner_th`).
    3. On RX, a non-GSO UDP packet with `CHECKSUM_PARTIAL` at `inner_th` causes
       `skb_csum_unnecessary()` (`skb_checksum_start_offset(skb) >= 0`) to treat
       the outer UDP checksum as already validated.

    Unlike plain GSO (commit 7c6d2ecbda83), UDP tunnel offload is modern-only and
    explicitly requires GSO (`/* The UDP tunnel must carry a GSO packet, but no UFO. */`).
    Why not reject `!skb_is_gso(skb)` right after `__virtio_net_hdr_to_skb()`, and
    return `-EINVAL` directly if `!virtio_net_csum_partial_ok_at_offset()`?
