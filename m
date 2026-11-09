Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267072;
	b=CAHHxs2C/MjJU4Sx47pr8qnezv9twY/QyK1brc5fUVrLZEaprduBnSE6AVfBOXcZCw24
	 icyk+Rs2bMcU+5nqc4pD2xA+tuVfF4QuckX1BO5W5DTxa/qquapVE+gnVlLiNVuzsr0XZ
	 nZ7G9WnrIeAo83AYCqmXT2Jg9+vrtyjQIQOf35wFl6GIx7soFAD8q3/xw2m7NRSjNaPhU
	 mljlECocWdWT45bZqupguCf+pTJsVBuHdhghDmkC4hPwgHwkXMGCDLjZ6dZXgimueZ1K/
	 1lO2koSrQzul/g5yeDEFnNBc4obnFzB7aLvoVlCiZnX9OMXCCUaFpLdmg/ezVLyKYcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267072;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GDirXnEyOjSk90lJat7/yy0ERwBcYsbhl0j/O7o90CY=;
	b=BjR3M01+NpKyoblAOFsiVbHKenyTewJfCZ9azTd2TI2DnQNRTrZhBhHVWPN/Pm85rhzA
	 R4qOiuiqzQFB8BEAPC8EgXjPHoeKvF6RTEs1dUJvcBx2J+PBvZnIoDO7rbqgkAGVEgtpy
	 0bNkXmTKl8dnObE0a1+KO6l5E/wbCAPGhh6sWI9xo7RY4Dx51Z3A1aUxyKWLj/MojiTHZ
	 x4Czsk6MycCUV7uI0aOGd4ft8VqKzd9QBm0RlkCiZlzHtrJr2EuXYgQvU5lfjMr0/lwoY
	 1Ba3Tw4idkzI8SM08AcGLuz7nOAZyL86AdFToF+aa17fy/q8MbAYRI7kVkyQHA61jvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpBYZGB0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019C60A260C;
	Mon,  9 Nov 2026 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpBYZGB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ACA1F008A2;
	Mon,  9 Nov 2026 23:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267071;
	bh=GDirXnEyOjSk90lJat7/yy0ERwBcYsbhl0j/O7o90CY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PpBYZGB0wF9aO3CCtXo/+X3QtsLGH1gc64EPCIPzjAW5fUsQtWNKmsMVh2K3W2Igs
	 umyfJHO+/zanFnXu4NVR7Wb9jVC1opSyS16q7ScJ4vXHfWHwaqbiHiRJcveCjRc8EL
	 PYpIUEWRh+XzNTnq8Y6quQWKQpAX+QaFbANU3a2n8vaOu1nN1VENsI2wA1bgqnESlK
	 8ZB1wSAxQzcvh/dv86RpM4Vg+yJPjTlorpFYIhnRau5kRDqG1WPklcTH5YKBTGm0Ac
	 djYUvrJq9qGidwZzwuuxk9PrX8hs/vidxnAC9gbdiWX7KKEWWN5GMKpyn/i0AsUuIi
	 zY2FUlFVWBUAQ==
Subject:
 Re: [PATCH net-next 6/6] eth: mpnic: add GSO_PARTIAL for other tunnels
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:31:10 +0000
Message-ID: <179426707009.994134.17352575652872251031@kernel.org>
In-Reply-To: <20261106-mpnic-lso-v1-6-e943ff1493e4@gmail.com>
References: <20261106-mpnic-lso-v1-6-e943ff1493e4@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message is incomplete about what the new GSO_PARTIAL
  tunnel offload covers by default.

--

eth: mpnic: add GSO_PARTIAL for other tunnels

This commit advertises GSO_PARTIAL for GRE, IPXIP4 and UDP tunnels. For
GSO_PARTIAL skbs the TX path uses L3 type OTHER, so the device does not
update the l3 headers. mpnic_features_check_encap_gso() now requires DF on
an outer IPv4 header and MANGLEID when the inner header is IPv4.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index c349e54a35470..8b17acffe7e5f 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -395,11 +398,27 @@ static bool mpnic_ipxip6_gso_ok(struct sk_buff *skb)
>  static netdev_features_t
>  mpnic_features_check_encap_gso(struct sk_buff *skb, netdev_features_t features)
>  {
> +	struct iphdr *iph;
> +
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP6 &&
>  	    mpnic_ipxip6_gso_ok(skb))
>  		return features;
>
> -	return features & ~NETIF_F_GSO_IPXIP6;
> +	features &= ~NETIF_F_GSO_IPXIP6;
> +
> +	iph = ip_hdr(skb);
> +	if (iph->version == 4 && !(iph->frag_off & htons(IP_DF)))
> +		return features & ~NETIF_F_GSO_MASK;
> +
> +	/* HW can segment inner udp4 with fixed IDs, but there is no UDP
> +	 * analog for MANGLEID, so defer to SW GSO.
> +	 */
> +	if (inner_ip_hdr(skb)->version == 4)
> +		features &= ~NETIF_F_GSO_UDP_L4;
> +	if (!(features & NETIF_F_TSO_MANGLEID))
> +		features &= ~NETIF_F_TSO;

[Severity: Low]

This isn't a bug, but could the commit message say more about what the new
GSO_PARTIAL offload covers by default?

The subject says "add GSO_PARTIAL for other tunnels", and the body says
these tunnels "can be supported with GSO_PARTIAL".

mpnic_netdev_alloc() doesn't add NETIF_F_TSO_MANGLEID to netdev->features.
The core only makes it available as a hw_feature:

net/core/dev.c:register_netdevice() {
    ...
	if (dev->hw_features & NETIF_F_TSO)
		dev->hw_features |= NETIF_F_TSO_MANGLEID;
    ...
}

With default settings, this check clears NETIF_F_TSO. Then the
skb_gso_ok(skb, features | partial_features) check in __skb_gso_segment()
fails for SKB_GSO_TCPV4. As a result, inner-IPv4 TCP over GRE, IPXIP4 and
UDP tunnels is fully segmented in software until the user turns on
tx-tcp-mangleid-segmentation with ethtool.

Inner-UDPv4 tunnel GSO is never offloaded, because NETIF_F_GSO_UDP_L4 is
always cleared when the inner header is IPv4. The code comment explains
this, but the commit message doesn't mention it.

The message does say "MANGLEID is required when the inner l3 is ipv4".
Could it also say that, by default, only inner-IPv6 traffic over these
tunnels gets the new offload, and that inner-UDPv4 always uses software
GSO? fbnic has the same MANGLEID gate, so the behavior itself looks
intentional.

> +
> +	return features;
>  }
>
>  netdev_features_t mpnic_features_check(struct sk_buff *skb,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-mpnic-lso-v1-0-e943ff1493e4%40gmail.com
