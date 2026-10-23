Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792723795;
	b=c2fQ0NzTWdhjUCwEU6LsmiMinxrAy7SzgG7+qz5L/fyJ0seSwFjcr3N1N5y5NFVSAyah
	 NrwR+WRS8gpUA78ofm0gq9bBl+7lcM2qGl/5e5d8UUpTCkyqjl3JOJULV1cv4lAnRTKqI
	 U8dtiA8+w9SC+jCSDSHPa0Tse5ZeFTCrMyeIAxgGbLN/TyxjYGpb87kDqyT5x/wxG6/4h
	 0JMVUDV9D7GIGPb/hMaX7SfXewskaGuD3qexPxmU9aRuJeMQd4Ah6ByD7bn/eBHsHAuBS
	 CQ23TKb0P5rbVf/mdFaA+acgJpyB4Eui+YmgOA7ku8jwa55j0PkhEM40LJIvDXMLcmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792723795;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iSaVGh0/J9R2PsEBRnNcSpf6/T9iBif0unUe3V+FZCk=;
	b=oGD8VF/fIRuo+yMhKfUpAFZAQSxWoAnZCVR4hautplyTl9h83r+nJjtmoWbjOu4b+5Hy
	 yYKIiEBtML3pWjLIBREs67TmVjuqnhN3mSx4nyEhInWbyJEkfqfG3pi1J//vD3XkKbiiD
	 7718302ITuYgSI9duWgaNnDzWCFEZMyeR1fILdi3vDYANRfhJegS3EBO0XU7vng+aii8h
	 mse5S6g6gryiuLtzmM5sUkcgrS9Z1/K+UIfWf282Wr15hnEphACPLQkHCAlsSPYLKFucn
	 cPjCuMaD+ZQxSmfjJg1LNvz/Jh0dQlAyss6SeSYMYv4dKCjp8V4pZD28+9RgTdcfvbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChP9+g1Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAA606A31A;
	Fri, 23 Oct 2026 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChP9+g1Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248241F01825;
	Fri, 23 Oct 2026 02:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792723794;
	bh=iSaVGh0/J9R2PsEBRnNcSpf6/T9iBif0unUe3V+FZCk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ChP9+g1ZrWe3ctWkfJxodczNnZ3pJkzdJi4XGzoV69sRxI5cyJjVUIhE4qfbQ06iK
	 VnaNOuNkvvX6OjJJseWrLH2VAZS4EuwiJ9sEhpAzZnue1VtDciQd29dz8vqXDirs47
	 YKxVqOYg0curHKuVjjH3ndcnILsOMsOySdmJTMWatJrFQIiK1oFmyWbuMQnkrAE3qo
	 VPrHBuSU8F3OcDsRVabcM81BNaDku85ZjIPYJjWDgbV7dLrc/uUiHBUp4TASZa4efM
	 lAsgOQ13DEsiRF1DWhqlfEOS5w6+ltLkXt86II9/Lu1tCFEgQbFwasuZ+36vVtyIAP
	 IKpYmtDWrTFvA==
Subject: Re: [PATCH net v3] seg6: Fix unset mac header in SRv6 End.DT VRF
 decapsulation
From: netdev-bot+sashiko@kernel.org
To: yymhvert@gmail.com
Cc: andrea.mayer@uniroma2.it, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, co+98d7de09cd94fec5@bugs.sh
Date: Fri, 23 Oct 2026 02:49:53 +0000
Message-ID: <179272379368.3134.2964815137936170194@kernel.org>
In-Reply-To: <20261021024738.17266-1-yymhvert@gmail.com>
References: <20261021024738.17266-1-yymhvert@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch restores the mac header only after the VRF
  l3mdev_l3_rcv handler returns.

Pre-existing issues:
- [Low] Concern: the other SRv6 decap behaviours (End.DX4/DX6, End.DT6
  legacy, End.DT46 non-VRF) leave mac_header and mac_len pointing at the…

--

seg6: Fix unset mac header in SRv6 End.DT VRF decapsulation

After the VRF l3mdev_l3_rcv handler returns, this commit restores a valid
mac header in end_dt_vrf_rcv() if the handler did not rebuild one. It
points the mac header at the network header and resets mac_len. With
that, UDP GSO re-segmentation no longer does a huge __skb_push() from an
unset mac header.

> Every other receive path delivers packets with a valid mac header:
> NIC drivers set it in eth_type_trans(), and tunnels without an L2
> header (ipip, sit, gre, tun) reset it to the network header after
> decapsulation.

[Severity: Low]
This isn't a bug introduced by this patch, but is this description
accurate for ipip, sit and gre?

In ip_tunnel_rcv() in net/ipv4/ip_tunnel.c, only the ARPHRD_ETHER case
touches the mac header:

	if (tunnel->dev->type == ARPHRD_ETHER) {
		skb->protocol = eth_type_trans(skb, tunnel->dev);
		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
	} else {
		skb->dev = tunnel->dev;
	}

In the L3 tunnel case the outer mac header stays set. It is not reset to
the network header.

The non-VRF SRv6 decap behaviours (End.DX4/DX6, legacy End.DT6, non-VRF
End.DT46) end up in the same state after decap_and_validate(), which only
resets the network and transport headers.

That stale but set state looks harmless at runtime. __skb_gso_segment()
calls skb_reset_mac_header() and skb_reset_mac_len() before
skb_mac_gso_segment(), and the outer mac header is still inside the
buffer.

Could the commit message wording be adjusted, though?

> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 53f7b24525759..45d0aabc58152 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1200,6 +1200,16 @@ static struct sk_buff *end_dt_vrf_rcv(struct sk_buff *skb, u16 family,
>  		/* the skb buffer was consumed by the handler */
>  		return NULL;
>  
> +	/* the VRF device had its chance to rebuild the mac header for
> +	 * sniffers; restore a valid one pointing at the network header,
> +	 * like any L3 device without an L2 header, before the packet
> +	 * continues up the stack.
> +	 */
> +	if (!skb_mac_header_was_set(skb)) {
> +		skb_reset_mac_header(skb);
> +		skb_reset_mac_len(skb);
> +	}

[Severity: High]
Does this restore happen early enough? end_dt_vrf_rcv() calls
skb_unset_mac_header() before l3mdev_l3_rcv(). If no sniffer is attached
to the VRF device, the header is still unset when the PRE_ROUTING hook
runs inside the handler:

drivers/net/vrf.c:vrf_ip_rcv() {
    ...
	if (!list_empty(&vrf_dev->ptype_all)) {
		...
		err = vrf_add_mac_header_if_unset(skb, vrf_dev, ETH_P_IP,
						  orig_dev);
		...
	}

	skb = vrf_rcv_nfhook(NFPROTO_IPV4, NF_INET_PRE_ROUTING, skb, vrf_dev);
    ...
}

vrf_ip6_rcv() is structured the same way.

Suppose an NFQUEUE rule queues a GSO packet at that hook, either on a
queue without NFQA_CFG_F_GSO or as an SCTP GSO packet.
nfqnl_enqueue_packet() then does:

	nf_bridge_adjust_skb_data(skb);
	segs = skb_gso_segment(skb, 0);

and nf_bridge_adjust_skb_data() does:

	if (nf_bridge_info_get(skb))
		__skb_push(skb, skb_mac_header_len(skb));

With mac_header == 0xffff, skb_mac_header_len() is network_header - 0xffff,
which is roughly 4G as a u32.

Can that move skb->data far outside the buffer and corrupt skb->len before
skb_gso_segment() reads through it?

The bridge netfilter extension can still be attached at this point. An
IPv6+SRH packet that arrives on a bridge port with br_netfilter and
call-ip6tables enabled gets it from nf_bridge_alloc() in
br_nf_pre_routing_ipv6().

Nothing on this path drops it. br_pass_frame_up(), decap_and_validate(),
iptunnel_pull_offloads() and nf_reset_ct() all leave it in place.
nf_bridge_info_free() is only called on the bridge xmit paths.

ip_sabotage_in() also lets the packet through PRE_ROUTING on the VRF
device. sabotage_in_done was already set during the first PRE_ROUTING
pass on the bridge device:

	if (nf_bridge) {
		if (nf_bridge->sabotage_in_done)
			return NF_ACCEPT;

		if (!nf_bridge->in_prerouting &&
		    !netif_is_l3_master(skb->dev) &&
		    !netif_is_l3_slave(skb->dev)) {

The call chain would be:

ipv6_rcv()
  seg6_local_input_core()
    end_dt_vrf_rcv()
      skb_unset_mac_header()
      vrf_ip_rcv()
        vrf_rcv_nfhook(NF_INET_PRE_ROUTING)
          nfqnl_enqueue_packet()
            nf_bridge_adjust_skb_data()
              __skb_push(skb, huge)
            skb_gso_segment()

This looks like the same problem: an unset End.DT VRF mac header becomes a
huge unsigned __skb_push() before GSO. The difference is that it happens
inside the handler rather than after it returns.

Would it make sense to set a valid mac header before calling
l3mdev_l3_rcv()? Alternatively, the consumers inside the handler could be
made to handle the unset state.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021024738.17266-1-yymhvert%40gmail.com
