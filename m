Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1831B101
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203930; cv=none; b=mdxl/yJtz120wTq2vHx8XlFOEemqBmsZioeFNGkxi0y82CEFcnzGaOg8Tl10JqLn/ANOB98KfJbSOj2q3MvL40KXgDi8MK8xx724aGwk9e0HgVB+eFKnFFriwY9b2/qZQrG+Nl0MrefoQpiyRhCD3CLUzFHE5EojOnwyQyzkn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203930; c=relaxed/simple;
	bh=SUWAGf8sVHKWryZvJc2CRMyaoHq/CAf8ooTs1lQf5cA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Sy7oHzaTtO2DBskDzE7upaNpFRmizAWZplvVtJCbFZcyp/FEhtT1beVvYmIUdKMazoETwqOLAIFl+KOlVwrOPqzIsubqnYWp+Uw9erPD5UAn7Ux6skgRvXQcBWqtiIHmjfLCAhaKUTCdUGZkRF7v4bErF4kxZhWCsINua6VpQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0gsBBh1; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0gsBBh1"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66f79f58123so1333631d50.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788203927; x=1788808727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vyGggYc18dLYZvLE+3PHcbnS8L3cXtAXyIgurB3vQjg=;
        b=S0gsBBh1Q8dxmt9Bh/gnTP65jBd1H3cjishr05Lpn3jyaP+5qr5ZT4UzpXZshlMVGE
         3dQn/ChQNwYC1do7iGkNjyRonMVWD1rlFhSDIbVTH422OvPHtqWmKA+z1yWfSAxlT4sM
         uIVgJ5jm9pU2MrOO6tFrshjBucYHJl3tNG9ndfNKJQWL+HWeAFRFjflXORJoiSveIc6y
         Ox4cbGRKcnFbKJo91yVNJJWJ8CDA4HoGJIhvdjevP160RmP8jQm+7eXeIIlEgvowULMi
         /hf+kUFlArlVsaXhAl+iDSDT9ovqX/3CRRJVfjtZLL6wVIPTTWb/k96QQYbPn0edn13j
         9HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788203927; x=1788808727;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyGggYc18dLYZvLE+3PHcbnS8L3cXtAXyIgurB3vQjg=;
        b=gB4+r2XwFQLntRH7FkMZpQyQGtgNVD2n+QvTERIt160eUjHwat7xoCeyiaduvk4Shh
         xsqToKizeozDd/X6mdRQZimQPkjpmZAQQ14NGjU8nRYlWqnYy8kM5Wq/J4ihy0Nct/R4
         7dtMMGGOWjY7+mAbmoA3fgLblC6fasG+6wc+W9kqEiM6RbjRgbxbFU8lpn/yryjY6iJR
         qwHHJQuiilKDlB3ffxGWbeTXLxEkPIVBp1a8xvclIYImiquPw3BjOkHls+DPMaEKl4Mx
         RcMsWPgTYy9mZDag6pt3V8syFtw+P/Y06YnjasAZCAk6tJBwDlVMd8wxstTbo1FY8ZlW
         Oo1g==
X-Forwarded-Encrypted: i=1; AKwUvBzyFgv87gIZAqFNU0XOE+3hnSw9N4f60GDM+PaY29Qqh/Iv8tOtzYc6LORx47gaXNE5xdv9bTA=@vger.kernel.org
X-Gm-Message-State: AFuF++lD3zxZ0htmPymrf/ZBRm8FBUH2hIEMqb3L3x++OnJGQoGKLwyj
	HWWC6jza5ssZOy4l3a4JfMRTS+Bjx5k68fdYwQVvT8v4dXUeL+ubkbYZdx14Ag==
X-Gm-Gg: AYBFou02GYUlSjLlFo5uBOqROxxxof+qeQoFyW4Ss2Na1t5gJQ4z/voCGjGIX9ENHkV
	Hf0StpNhxa4yr8NlgHLIZ+1sL22Gm2MVBDY3Gsms6mkEcJYxlZlLTeTQ8Q3bYs0Wn8NViozdJrz
	BMAYXpS/M8f8dmOqm1rXEeKMTLyiyRw1SnxMibH+LjtjSfvZuO498DMFwRzsBRSfUtyvpCrMBKV
	poSAGQAm3k9cajB7MITh+WJOmCrD1DiJ9CVHqKIO3U1O2a+rmEv4DJWo6EWXBdkVpfPVJ3jVDl4
	S/X1qgWvj/lxmzXriapCqf0bgEns78kqSItKfUEqhNcC6a/AMpP1EG9c4itQb14mVBrf/nAAbAJ
	X2816nRK9XucXmDIH37q5TQScpxHCHcosn0DgxAwo/v3EBOYNT88c0xxQfh4QvenSYe/6jnFrlG
	MqzCmgkMrbvFtjbOJZV/2y1HF1qL3hyN5yc5kCzh86/2d7NQe09AM2id7RT94aa7N+npQim1/ps
	ck3t7lJqrnQsJa4XdCrSwk4+D24WvSwOrL0SEpdcQ==
X-Received: by 2002:a53:e950:0:b0:66d:289f:6498 with SMTP id 956f58d0204a3-66f875c6a73mr824777d50.36.1788203926780;
        Mon, 31 Aug 2026 12:18:46 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed2c78esm6675036d50.19.2026.08.31.12.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:18:46 -0700 (PDT)
Date: Mon, 31 Aug 2026 15:18:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Junnan Zhang <zhangjn_dev@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 zhangjn_dev@163.com, 
 Junnan Zhang <zhangjn11@chinatelecom.cn>, 
 Shouxin Sun <sunshx@chinatelecom.cn>
Message-ID: <willemdebruijn.kernel.2a4f4a498e1ff@gmail.com>
In-Reply-To: <20260831072034.40044-1-zhangjn_dev@163.com>
References: <20260831072034.40044-1-zhangjn_dev@163.com>
Subject: Re: [PATCH net v2] net/packet: fix network header offset for non-VLAN
 raw packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Junnan Zhang wrote:
> AF_PACKET SOCK_RAW sets skb network_header to dev->hard_header_len in
> packet_snd(). For Ethernet devices whose hard_header_len exceeds the
> on-wire L2 header length (min_header_len = ETH_HLEN) -- e.g.
> software-offload VLAN subinterfaces, where hard_header_len = ETH_HLEN +
> VLAN_HLEN = 18 -- a non-VLAN SOCK_RAW frame still carries a standard
> 14-byte Ethernet header, so its L3 header sits at min_header_len, not
> hard_header_len.
> 
> packet_parse_headers() only corrects network_header for VLAN-tagged
> frames. For non-VLAN frames it leaves network_header at hard_header_len,
> so the IP header is found (hard_header_len - min_header_len) bytes too
> late and inet_gso_segment() fails with -EINVAL.
> 
> Observed on a virtio_net NIC (KVM guest) that advertises
> NETIF_F_HW_VLAN_CTAG_FILTER but not NETIF_F_HW_VLAN_CTAG_TX, so VLAN
> subinterfaces use software tag insertion (hard_header_len = 18). An
> AF_PACKET SOCK_RAW socket bound to the VLAN subinterface with
> PACKET_VNET_HDR enabled sends a large IPv4/TCP frame exceeding the path
> MTU, with gso_type set in the virtio-net header. The user frame is a
> plain [ethhdr][IP...] layout without a VLAN tag; the VLAN subdevice
> inserts the 802.1Q tag in vlan_dev_hard_start_xmit(). 

Where does it do this? validate_xmit_vlan does this on the physical
device I think.

That adds a bigger problem that the extra needed headroom of
(hard_header_len - min_header_len) is not reserved at the start of the
frame.

In packet_snd, reserve == hard_header_len, so the packet socket
starts writing at the start of the buffer. When
__vlan_insert_inner_tag inserts the tag, it tries to move the mac
header back, leaving the network header in place. Which works fine if
the network header was set correctly from the start, and the original
mac started at network_header - min_header_len.

This is all messy because before needed_headroom existed, legacy
tunnels had to resort to increasing hard_header_len to reserve extra
room for their outer headers.

Long aside, and I don't expect to address/disentangle that in this bug
fix targeting net. Will take a look whether we can safely do that in
net-next.

But please Link to this version of the patch (and thus the thread)
when sending the next version.

> With
> network_header stuck at 18 while the real IP header is at ETH_HLEN (14),
> inet_gso_segment() reads a misaligned ip_hdr(skb) and returns -EINVAL.
> 
> Set network_header to min_header_len for non-VLAN SOCK_RAW frames on
> Ethernet devices whose hard_header_len exceeds min_header_len, so the
> L3/L4 header positions match the actual on-the-wire frame.
> 
> This fix is placed before skb_probe_transport_header() so that both the
> transport header probe (which uses skb_network_offset() as nhoff) and
> subsequent GSO see the right L3/L4 offsets. It complements
> commit 01fdecc0480d ("net: packet: fix wrong transport_header when sending VLAN-tagged frame")
> which only covers VLAN-tagged frames.
> 
> Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
> Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
> Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
> Signed-off-by: Junnan Zhang <zhangjn_dev@163.com>
> ---
> v2:
> - Drop "on VLAN subinterfaces" from the subject and reword the scope to
>   Ethernet devices whose hard_header_len exceeds the on-wire L2 header
>   length (min_header_len). The min_header_len < hard_header_len test is
>   not VLAN-specific; it also covers Ethernet drivers that reserve extra
>   hard_header_len space for driver-internal wrapping.
> - Restructure packet_parse_headers() to test dev->type once; replace
>   has_vlan, which mixed the device and packet tests, with the
>   packet-only is_vlan.
> - Describe the header offset error generically as (hard_header_len -
>   min_header_len) bytes instead of hard-coding the 4-byte VLAN case.
> - Document the reproducer: virtio_net advertising
>   NETIF_F_HW_VLAN_CTAG_FILTER but not NETIF_F_HW_VLAN_CTAG_TX, with
>   PACKET_VNET_HDR and GSO triggering the -EINVAL from
>   inet_gso_segment().
> 
> v1: https://lore.kernel.org/all/20260821085722.24036-1-zhangjn_dev@163.com/#t
> ---
>  net/packet/af_packet.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 1168bd6b09cd..be5bf9db7ea1 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1935,6 +1935,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>  static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
>  	int depth;
> +	bool is_vlan = false;
>  
>  	/* On TX skb->data is the L2 header; anchor it for all socket types. */
>  	skb_reset_mac_header(skb);
> @@ -1943,11 +1944,28 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  	    sock->type == SOCK_RAW)
>  		skb->protocol = dev_parse_header_protocol(skb);
>  
> +	if (likely(skb->dev->type == ARPHRD_ETHER)) {
> +		is_vlan = eth_type_vlan(skb->protocol);
> +
> +		/* For non-VLAN SOCK_RAW frames on Ethernet devices whose
> +		 * hard_header_len exceeds the on-wire L2 header length
> +		 * (min_header_len) -- e.g. software-offload VLAN subinterfaces,
> +		 * or Ethernet drivers that reserve extra space in
> +		 * hard_header_len for driver-internal wrapping -- the SOCK_RAW
> +		 * send paths leave network_header at hard_header_len, while the
> +		 * user frame's L3 sits at min_header_len. Move network_header
> +		 * to the actual L2/L3 boundary so the transport header probe
> +		 * below and subsequent GSO see the right L3.
> +		 */
> +		if (!is_vlan && sock->type == SOCK_RAW &&
> +		    skb->dev->min_header_len < skb->dev->hard_header_len)

Instead of using min_header_len != hard_header_len to detect vlan devices,
consider is_vlan_dev(). That does not have false positives for other
protocols, and makes the code more self-descriptive.

Unless we are certain that the same also exhibits for other devices that
play hard_header_len games, such as GRE tunnels. But then the
ARPHRD_ETHER check excludes those anyway. So for now I would focus on the
VLAN issue only.

  if (sock->type == SOCK_RAW && !is_vlan_packet && is_vlan_dev(skb->dev))
    skb_set_network_header(skb, skb->dev->min_header_len);

It sucks that we have to add another branch in the hot path for an edge
case. Would be preferable if we can fix this in the vlan driver. But
that will come too late for skb_probe_transport_header.

> +			skb_set_network_header(skb, skb->dev->min_header_len);
> +	}
> +
>  	skb_probe_transport_header(skb);
>  
>  	/* Move network header to the right position for VLAN tagged packets */
> -	if (likely(skb->dev->type == ARPHRD_ETHER) &&
> -	    eth_type_vlan(skb->protocol) &&
> +	if (is_vlan &&
>  	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
>  		skb_set_network_header(skb, depth);
>  }
> -- 
> 2.43.0
> 


