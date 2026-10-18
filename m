Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814C3B42C3
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338707; cv=none; b=Nk/p9bd/ctvS36Vp0jQn2B5QHFsHoreUYw2z/S/FCv6bb+TQHx7HuwcJJ80ZF6cD5nxETZL0ThIc8hX6azyKCQPg9xZSb48f9JfhZJPzFK3r3/XixMG/djeTrp3XiSYLRqOJppKUW6BqAuhKzfIxxHFqy2UggM5kq0QiN9l7UtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338707; c=relaxed/simple;
	bh=6R/BuFhfGcO1oRj2v36lrBKm+fzAB4xKrCJt26Y4wYc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qbt91UiwS6Rfld4HDS8BFSciwKJnqqEGHwHEHTqC38pMMbiR3JQSIDzOlfGx8xI5OxtjjBkImJwQYlmNL62lNebJBUyUlv/tyVpM36xrtLF4uzi1zysAVIdVf4PkoEcX/X3XSKp2WtXZ26zdoqvvlULJ4DSPrgZXPn0+/vBxGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idDCcNcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idDCcNcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0349B1F000C6;
	Sun, 18 Oct 2026 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792338703;
	bh=I09pRrm2WPrQgGhtNYl0tBj38mh2IxMbEVkcFORZBaI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=idDCcNcR4JRXD3YW/fCoKHG8UQLEPlsvE4JcAdojsc9uQTDutnrtG3+I4G9BAnQQ1
	 u2LbvLdnVONGypzWiXwcuxWT3MLuBpg5jjG8ZiDnJejMicAgwgc935R7iZ3w3rG4cg
	 J+Vk2x0KAZqOjRA5covZ4vc+DBJuvXql1Sj6BCu45vT9/JPt3It/+HK1Jt2fjuYVJM
	 ZSHaNGLh6IIEIMuUm3FYAt3v+0bW1l28ZGsL3tzXjIYje/gbEbEuKGesK4YA5dqM7z
	 +KUNk1EvTSg0iiGZMUmgOWF/4gTbCG8NGuteeoW5RqZBclutpw9sZb1lnPsJAjwfdu
	 wDe3AVEGKhd3g==
Subject: Re: [PATCH net-next v9 4/8] hsr: Drop received PTP packets
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com, pabeni@redhat.com,
 praneeth@ti.com, pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
 vigneshr@ti.com, willemdebruijn.kernel@gmail.com, daniel.machon@microchip.com,
 edumazet@kernel.org
Date: Sun, 18 Oct 2026 15:51:41 +0000
Message-ID: <179233870158.3135.22211323415720778@kernel.org>
In-Reply-To: <20261014-hsr_ptp-v9-4-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-4-2d20a2a0f816@linutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "VLAN tagged packets are not
  considered", but the code does drop VLAN-tagged PTP frames.
- [Low] Every received PTP frame goes to finish_free_consume, which calls
  kfree_skb(skb) and returns RX_HANDLER_CONSUMED (hsr_slave.c:101-103).

--

hsr: Drop received PTP packets

With this patch, hsr_handle_frame() drops PTP frames that arrive on HSR/PRP
slave ports instead of forwarding them. For HSR/PRP tagged frames it checks
the encapsulated protocol, and for other frames it checks the ethertype.
The existing kfree_skb() error paths are merged into a new
finish_free_consume label.

> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 5274ba6dd36e6..a5b47f016abd7 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c

[ ... ]

> @@ -64,15 +64,28 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)

[ ... ]

>  	skb_reset_mac_len(skb);
>  
> +	/* PTP packets are not supposed to be forwarded via HSR as-is. The
> +	 * latency introduced by forwarding renders the time information
> +	 * useless. Userland needs to capture the packet on the original
> +	 * interface instead of hsr.
> +	 */
> +	if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
> +	    protocol == htons(ETH_P_HSR)) {
> +		hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
> +		if (hsr_ethhdr->hsr_tag.encap_proto == htons(ETH_P_1588))
> +			goto finish_free_consume;
> +	} else {
> +		if (protocol == htons(ETH_P_1588))
> +			goto finish_free_consume;
> +	}

[Severity: Medium]
The commit message says:

  VLAN tagged packets are not considered.

Does that match what this code does? Before the rx_handler runs,
__netif_receive_skb_core() has already moved a single 802.1Q tag into
skb->vlan_tci. NIC rx-VLAN offload does this in hardware. Without offload,
the software path does it:

net/core/dev.c:__netif_receive_skb_core() {
    ...
	if (eth_type_vlan(skb->protocol)) {
		skb = skb_vlan_untag(skb);
    ...
}

As a result, protocol = eth_hdr(skb)->h_proto in hsr_handle_frame() holds
the inner ethertype:

- A VLAN-tagged PTP frame on a PRP slave matches
  protocol == htons(ETH_P_1588).
- A VLAN-tagged HSR frame matches
  hsr_tag.encap_proto == htons(ETH_P_1588).

Both frames take the finish_free_consume path.

The only exception seems to be a VLAN upper device on the slave that
matches the VID. In that case vlan_do_receive() moves the skb to that
device before hsr_handle_frame() is called.

Since VLAN-tagged PTP frames are dropped whether offload is on or off,
should the commit message say so? Or should these frames keep being
forwarded as before?

> +
>  	/* Only the frames received over the interlink port will assign a
>  	 * sequence number and require synchronisation vs other sender.
>  	 */
> @@ -84,7 +97,10 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
>  		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  	}
>  
> -finish_consume:
> +	return RX_HANDLER_CONSUMED;
> +
> +finish_free_consume:
> +	kfree_skb(skb);
>  	return RX_HANDLER_CONSUMED;

[Severity: Low]
I have two questions about the PTP frames that now take this exit path.

First, RX_HANDLER_CONSUMED makes __netif_receive_skb_core() jump straight
to out:

	case RX_HANDLER_CONSUMED:
		ret = NET_RX_SUCCESS;
		goto out;

That skips ptype_base and ptype_specific delivery. Only ETH_P_ALL taps see
the frame, because they are delivered before the rx_handler. A packet
socket bound to ETH_P_1588 on the slave never receives it.

The commit message says a PTP stack "needs to retrieve the PTP packet on
the original slave interface where it was received". That works with
ETH_P_ALL plus a filter, which is what linuxptp's raw transport uses. It
does not work for a socket bound to ETH_P_1588. Could the commit message
mention this?

Alternatively, on PRP the frame is a plain ETH_P_1588 frame. Could it be
returned with RX_HANDLER_PASS after undoing the skb_push(), so that normal
protocol delivery takes place?

This isn't a new loss. Before this patch, ETH_P_1588-bound sockets on the
slave didn't get these frames either, because the frames were consumed for
forwarding.

Second, kfree_skb() reports SKB_DROP_REASON_NOT_SPECIFIED. Every PTP frame
filtered on purpose (sync, follow-up, announce, pdelay, on each slave port)
will show up in the kfree_skb tracepoint and drop_monitor as a drop with
no reason given. Would a dedicated drop reason, or consume_skb() since ETH_P_ALL
taps have already received the frame, fit better here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-hsr_ptp-v9-0-2d20a2a0f816%40linutronix.de
