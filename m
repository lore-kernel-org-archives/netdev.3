Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478139;
	b=qWITNXqOcJEX7XC8QqxM2S1sMjlsghKDjasIZJd3eb7Jad6Cb/PSBFvYf3uVjF+hjTFM
	 qMNde2BxsG68Tk6Fvscrk5J1Zf+Ia3PynNqxDBgUjN7TGN5w4h6ky2GuzTt2ROZygL+Ba
	 d530QlO3DypFQQVl9KZ4K0OadqroIJvFxAr5rBgp3KNN6FxWItklzrKa8kbClbag1DyVD
	 I/9PCPr/6SdfIZ6K6lykn+F622EgtfgqUBlcCA9Wor/3ym0Av56onb1k6mQ+a0eJMU3aD
	 HvBmL9gk0YurVv9zVjsLCW0+swMuglNfDW6O1i0QoqDjT4aUu1xM3ROdHw0o3RjdEvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478139;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DVX5Cp+lWjYczys85N/ZZVBZp73FiLIgRZwjBBoiswU=;
	b=I6j8rsBuTRY5ouKFYBUBrz/IsGzBMc/7NgifeCbK0r8jrWMg1Co5EVd7GtqY2rKN5ZAE
	 1MKp+QN2fWzKPDVSLqkuxhlGa2f6MO/eA6/U1tJ+6kFo8Rx4KajhU0Vs45Mo64wyUQZPH
	 lT0HtMQdWNB4+v08B5EdKc1INQTF+eNEp1pEbv7jWuCmaY8jomiIKJPPOUE32lMNbm3I2
	 ylkxor8a/qtbVaf110QKDpLC5QPX7gAWBMYmbTN7pvCs9blINM+khI72CKLJ0qLtL4SJB
	 Yf3rif3DdcZHiHxylkdOEBIZLr/vkkC7BwixptFNzIgbvMGaw8/NJmva2SSU9EQP0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ob0RMCbf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0B606A89C;
	Thu, 12 Nov 2026 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ob0RMCbf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A6E1F00A08;
	Thu, 12 Nov 2026 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478139;
	bh=DVX5Cp+lWjYczys85N/ZZVBZp73FiLIgRZwjBBoiswU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ob0RMCbf8jwbdDMZFdtYvTt2qMFCt8SpLgJpbNg983WtVDXQmJphTm+wpZqanHCZO
	 ddpwIYizpO6ZTO6onCoFR3wqwxy69EacvIMyKOgSfVGZ7X1FhdrDw9pc0s99WfRCHi
	 UplxUdskbdcrNdK0psyG5fIf53Ybxw/+L1IXv1N5i8S1Hv0Kj/RMFZmHUV0NW1TSzR
	 fcPW5a2QQlIaEVezYKgRBtL7CvJDixHlsMSkVCQyoA2DV+9xJ+PjiDVTbN+K9dpHxo
	 8J6cMgvqOGj8s0PEMgQe94D0N7uv3xz3iE5sYvAGU9WIgs6fTSXVRuQ7/AuVRHzxcT
	 CUIrwm5wRzwzw==
Subject: Re: [PATCH net-next v2 5/6] eth: mpnic: IPv4 and IPv6 in IPv6 tunnel
 segmentation
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 10:08:58 +0000
Message-ID: <179447813848.2199510.18299256518114707021@kernel.org>
In-Reply-To: <20261110-mpnic-lso-v2-5-ccd37b051d08@gmail.com>
References: <20261110-mpnic-lso-v2-5-ccd37b051d08@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mpnic_ipxip6_gso_ok() only checks the outer IPv6 header chain.

--

eth: mpnic: IPv4 and IPv6 in IPv6 tunnel segmentation

This patch turns on NETIF_F_GSO_IPXIP6 for mpnic. The device can segment
4-in-6 and 6-in-6 packets. The patch adds the outer L3 header length and
two new L3 types to the Tx descriptor, and adds
mpnic_features_check_encap_gso() to reject skbs the hardware cannot
handle.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 2a0560b7dd19e..839feb4716b60 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -228,9 +232,17 @@ static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
>  	else
>  		hdrs->l4_type = MPNIC_TWD_L4_TYPE_UDP;
>  
> -	hdrs->i3len = skb_transport_offset(skb) - skb_network_offset(skb);
> -	hdrs->l3_type = ip_hdr(skb)->version == 4 ?
> -			MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
> +	if (!skb->encapsulation) {
> +		hdrs->i3len = skb_transport_offset(skb) - net_off;
> +		hdrs->l3_type = ip_hdr(skb)->version == 4 ?
> +				MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
> +	} else {
> +		inner_off = skb_inner_network_offset(skb);
> +		hdrs->o3len = inner_off - net_off;
> +		hdrs->i3len = skb_checksum_start_offset(skb) - inner_off;
> +		hdrs->l3_type = inner_ip_hdr(skb)->version == 4 ?
> +				MPNIC_TWD_L3_TYPE_V6V4 : MPNIC_TWD_L3_TYPE_V6V6;
> +	}
>  }

[ ... ]

> @@ -362,6 +375,35 @@ netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
>  	return mpnic_xmit_frame_ring(skb, mpn->tx[skb_get_queue_mapping(skb)]);
>  }
>  
> +static bool mpnic_ipxip6_gso_ok(struct sk_buff *skb)
> +{
> +	struct ipv6hdr *ip6h;
> +	__be16 frag_off;
> +	u8 nexthdr;
> +	int start;
> +
> +	ip6h = ipv6_hdr(skb);
> +	if (ip6h->version != 6)
> +		return false;
> +
> +	nexthdr = ip6h->nexthdr;
> +	start = skb_network_offset(skb) + sizeof(*ip6h);
> +	start = ipv6_skip_exthdr(skb, start, &nexthdr, &frag_off);
> +
> +	return !frag_off && start == skb_inner_network_offset(skb) &&
> +	       (nexthdr == IPPROTO_IPV6 || nexthdr == IPPROTO_IPIP);
> +}

[Severity: Medium]
Can a nested tunnel still get past this check?

mpnic_ipxip6_gso_ok() validates only the outer IPv6 header chain up to
skb_inner_network_offset(). It never checks that the inner L3 header
leads straight to the L4 header at csum_start.

Some paths reset the inner headers on an skb that is already
encapsulated. One is bpf_lwt_push_ip_encap() in net/core/lwt_bpf.c:

    skb_reset_inner_headers(skb);
    skb_reset_inner_mac_header(skb);  /* mac header is not yet set */
    skb_set_inner_protocol(skb, skb->protocol);
    skb->encapsulation = 1;

For an IPv6 outer header with nexthdr IPV6, handle_gso_encap() then adds
SKB_GSO_IPXIP6. BPF_LWT_ENCAP_SEG6 via bpf_push_seg6_encap() looks
similar.

One way to reach this is an ip6_tnl device whose underlay route has an
LWT BPF xmit program that pushes another IPv6 header:

    ip6_tnl xmit (encapsulation=1, SKB_GSO_IPXIP6)
      ip6_finish_output2()->lwtunnel_xmit()->bpf_xmit()
        bpf_lwt_push_ip_encap()   (inner headers reset)

The packet then looks like this:

    outer IPv6 -> middle IPv6 -> innermost IPv4/IPv6 -> TCP

Here inner_network_header points at the middle header. So
mpnic_ipxip6_gso_ok() sees an outer v6 header, nexthdr IPV6, and
start == inner offset, and it returns true.

The skb is DODGY, so validate_xmit_skb() runs software GSO validation. That
recursion ends in tcp_gso_segment(), where skb_gso_ok() succeeds against
hw_enc_features and NULL is returned. The skb then reaches
mpnic_xmit_frame() unsegmented.

mpnic_tx_fill_hdrs() would then program o3len = 40, i3len = 80 (or 60 for
an IPv4 innermost header), and L3_TYPE taken from the middle header's
version.

The descriptor only carries OHLEN and IHLEN. Would the hardware then
skip the per-segment fixups on the innermost header, i.e. IPv6
payload_len, or IPv4 tot_len/ID/checksum? That would put malformed
segments on the wire where software GSO would have produced correct
ones.

The v2 changelog says nested tunnels under an IPv4 outer are now
rejected, but this layout still has an IPv6 outer.

Should mpnic_ipxip6_gso_ok() also check that the inner L3 header ends
exactly at skb_checksum_start_offset() with TCP or UDP as its protocol?
For IPv4 that is ihl * 4. For IPv6 that is the header plus any extension
headers.

> +
> +static netdev_features_t
> +mpnic_features_check_encap_gso(struct sk_buff *skb, netdev_features_t features)
> +{
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP6 &&
> +	    mpnic_ipxip6_gso_ok(skb))
> +		return features;
> +
> +	return features & ~NETIF_F_GSO_IPXIP6;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-mpnic-lso-v2-0-ccd37b051d08%40gmail.com
