Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793061621;
	b=eDooUiWF7ABj/B3YmV8IMhHEPi9lkrfxtDyjkm9Me7g9FwQbucxE9aO/huxQkBY/M98k
	 M9Py0ga2neiZGDyTd6aN/PG3p0Yc4HAvfO7P6UnnJGRyFAA4WrllYd/ITNDUaI49LQAqq
	 5CFeKniW+a5SeCGFEBvmJ39qWiOTju6hVNPx8aNdIyJ9a2f8YrDK5ps897FGJ8o+NUT5G
	 Es8DZvtLQ6NXvu5KqO3JJYHEP34qe66EvxG+vKzB1USzyEzFyrCw4w6XjGcST+2GesQxn
	 I4hN5Pn97uUAq6BfVSpdaLA7AU+Q4DcAD0E9QbGocAhudYyV84WNQWmuhICitNl6Lng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793061621;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=t0obrBbwuNhE5r6pqg8igR6uRkq6fMAxP2g+lD1ExsQ=;
	b=H4qztwabs7l3/GxXI19yqU0LGORE9N+wy4PMQjPL3q2I6GCH2K47o6Cf/FNV0+SbUKDA
	 +mQeyhP5HGzssTQCZOadZC97QgKk3rzmKJ3ZjdRrc3re+d8+yXnMeReIjqbqfjpiJn3DL
	 0uvEisoGcVNEMMjyfvBTLk6cMQZNeZvYf49/EAZVPdjumKuIZGNLBqLLCE1AZOw3PEcb0
	 lsZlZRyaAvHACk39lSaP8IipXqJ8ciRPrrGfdRd0FCfw/2GbH9nRmcaXHAdH4OHyYD0hP
	 6SdodguyXcXMuyX79UwpG7BoptCGlVi+1xDR8X9SFOxKH0NaDNAC+D51lfvm/k6bOLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ms+g+0e7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CBF606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ms+g+0e7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC971F01825;
	Tue, 27 Oct 2026 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793061621;
	bh=t0obrBbwuNhE5r6pqg8igR6uRkq6fMAxP2g+lD1ExsQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ms+g+0e7w5s2xhaJa7AvKxN/uJETdHd75RsrfTwWzZghX4t3fctf9YX0B30icSolz
	 eSuM3SQZjGdd3pW0IOLX8RtBLnbCu25732oAh0kvYL/SPMe7uXQil5TpKh5UeJKQur
	 MhO1yaAOo3UZKhmjE4DipmKXgiU0EyzvQA/HEkVhSE82nVYGCHL5UGTmo1u+Kghmdv
	 4tnBDJI58z6t3YpTxgL9TTzRXmAhGuaFCSSQqt7OzaHjAIUZnwjxxFkZf+shloTJ5u
	 NB0wVnhkmAOUPoixAS2p3lFNLWd3ScovUHVn/QAo1yzcB4pLOwhyAFKcV3PaDeaCx5
	 +ekVfATky+3bw==
Subject: Re: [PATCH net] net: limit priority VLAN untag depth
From: netdev-bot+sashiko@kernel.org
To: user148783812897@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 27 Oct 2026 00:40:20 +0000
Message-ID: <179306162016.3134.9236911749193166053@kernel.org>
In-Reply-To: <20261023003750.1133904-1-user148783812897@gmail.com>
References: <20261023003750.1133904-1-user148783812897@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message promises a per-packet bound, but the patch
  only bounds one pass through __netif_receive_skb_core()…

--

net: limit priority VLAN untag depth

This patch adds a vlan_depth counter to the VID 0 retry branch in
__netif_receive_skb_core(). Once VLAN_MAX_DEPTH tags have been consumed,
the packet is dropped. The aim is to stop repeated skb_vlan_untag() calls
from wrapping the 16-bit network and transport header offsets.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..b40efea27dc29 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6198,6 +6198,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  	}
>  
>  	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
> +		unsigned int vlan_depth = 1;
> +
>  check_vlan_id:
>  		if (skb_vlan_tag_get_id(skb)) {
>  			/* Vlan id is non 0 and vlan_do_receive() above couldn't
> @@ -6209,6 +6211,10 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  			 * 802.1Q or 802.1AD and vlan_do_receive() above could
>  			 * not find vlan dev for vlan id 0.
>  			 */
> +			if (unlikely(vlan_depth >= VLAN_MAX_DEPTH))
> +				goto drop;
> +
> +			vlan_depth++;
>  			__vlan_hwaccel_clear_tag(skb);
>  			skb = skb_vlan_untag(skb);
>  			if (unlikely(!skb))

[Severity: High]

Does this limit the number of tags removed per packet, or only per pass
through __netif_receive_skb_core()?

vlan_depth is declared inside the if block, so it goes back to 1 every
time processing jumps to another_round. The VID 0 branch itself leaves
through another_round when the inner tag matches a VLAN device:

			if (vlan_do_receive(&skb))
				/* After stripping off 802.1P header with vlan 0
				 * vlan dev is found for inner header.
				 */
				goto another_round;

A TC ingress peer redirect also restarts the round on the same skb, and
skb->data does not change:

net/core/dev.c:sch_handle_ingress() {
    ...
	__skb_push(skb, skb->mac_len);
	if (skb_do_redirect(skb) == -EAGAIN) {
		__skb_pull(skb, skb->mac_len);
		*another = true;
		break;
	}
    ...
}

With BPF_F_PEER, skb_do_redirect() calls skb_scrub_packet(), sets skb->dev
to the peer in the other netns, and returns -EAGAIN. skb_scrub_packet()
leaves vlan_all alone, and nothing in this cycle counts iterations.

Here is one example setup. A veth pair is split across two netns. Each end
has a VID 100 VLAN device and no VID 0 device. Each VLAN device has an
ingress BPF program that calls bpf_redirect_peer() on its lower veth. A
frame carrying repeated [VID 0, VID 100] tag pairs could then cycle like
this:

  vethA: VID 0 branch untags the next VID 100 tag (vlan_depth == 2)
  vlan_do_receive() finds vlan100A -> goto another_round
  top-of-round skb_vlan_untag() strips the next VID 0 tag
  TC on vlan100A peer-redirects to vethB -> another_round
  vethB: VID 0 branch starts over with vlan_depth == 1
  ...

The same loop also seems possible with VID 100 tags alone. That version
goes through the earlier vlan_do_receive() -> goto another_round before
rx_handler and never reaches the patched branch.

Each round, skb_vlan_untag() calls skb_reset_network_header():

include/linux/skbuff.h:skb_reset_network_header() {
	long offset = skb->data - skb->head;

	DEBUG_NET_WARN_ON_ONCE(offset != (typeof(skb->network_header))offset);
	skb->network_header = offset;
}

After about 16K tags the 16-bit offset wraps. That is the out-of-bounds
condition the commit message describes.

Would it work better to put the bound inside skb_vlan_untag() itself, for
example on the header offset or the headroom? Another option is a depth
count that survives another_round.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023003750.1133904-1-user148783812897%40gmail.com
