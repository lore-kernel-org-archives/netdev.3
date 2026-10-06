Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834149A3AC;
	Tue,  6 Oct 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298851; cv=none; b=cbjYT/Iu61Y58SZebZW2a82OEqCbL9ptvsCdSgjsPW9IJMivAZ0u3EGQxbHRIWFig4WmbR7DBiEdksLXgDRDR7xlTPqb2pm+j0d9hkhKKkW+yBQdNeVJAtnw+6gnLG36hV+EhbTWRrzXew62JNnPLtbFtWzPeX/+ZWoNtB7hev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298851; c=relaxed/simple;
	bh=tCuRX/ttEZvtZVRf8tc0S+Lk1487gsfA/lnPHMYnVxk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GVFMy+duOkJLAIX3IhA5Bx7sprF82X6gfxiU2iThY/2biPwp7YzPLQ7iA01Ayws9AQMx/sqn3B85YxYmbbXGy8e/2pqZGr61IRo3jSJSMMt/VcWf8AbHxatr/idEyMeEns8AcrHx8WdR0qedgYoIwAmUjFEYI1MZdCJLko5cvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STDCz6yz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STDCz6yz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710821F0089B;
	Tue,  6 Oct 2026 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298850;
	bh=xbx81L8e3ncq4Oj+Gu0R/wb6t5li6yjl1P6nbemNJeE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=STDCz6yz/GKGBuI1Ffb3YuYz2JGXX7Z3QdDtvVIIoiTjSnd0EgqAGbYVTxXTXTBn3
	 gx77F89iJA48h6LYuNR8I0Z0U2tMLcB74Au2Ka27WhOGQXRg0LBBVFju5Qidb7AQPO
	 /ztU5tZd3YZOdcVodxGQR7xjDAzlvcT3G3mDP8wBBUw4KVbEOx6fBoMwGks7qVdCGk
	 T9w6SXgMxsXy2qLa5qdiwYJdVDYsl0z5vIJJCTzJ5HY58HLfyft8pczs7kaGtdKEcr
	 TU7ENITP00nIiSvIFb6pDT8XJ6JoN5w+GCQDkcJNWFtR3zAlOP8e9wLotRxI9xyGyH
	 A+Xgu3DWk/v+A==
Subject: Re: [PATCH net-next 3/4] net: rmnet: conditionally expand skb
 headroom in ingress handler
From: netdev-bot+sashiko@kernel.org
To: koen.vandeputte@citymesh.com
Cc: netdev@vger.kernel.org, quic_subashab@quicinc.com,
 quic_stranche@quicinc.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 15:00:49 +0000
Message-ID: <179129884903.434549.5629804675458467057@kernel.org>
In-Reply-To: <20261002143529.3217189-4-koen.vandeputte@citymesh.com>
References: <20261002143529.3217189-4-koen.vandeputte@citymesh.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch drops the implicit unclone that the old code did for
  every ARPHRD_ETHER skb.
- [Medium] On architectures where NET_IP_ALIGN is 2, removing the per-
  packet pskb_expand_head() leaves the inner IP header 2 bytes off…
- [Low] The commit message misdescribes what the patch changes.

--

net: rmnet: conditionally expand skb headroom in ingress handler

This patch changes rmnet_map_ingress_handler() so that pskb_expand_head()
is called only when skb_headroom() is less than ETH_HLEN. Before, it was
called for every ARPHRD_ETHER skb. The goal is to avoid a reallocation and
copy on the RX hot path when the lower driver already provides enough
headroom.

> In many modern architectures, the underlying physical driver (e.g., USB)
> can be configured to pre-allocate this extra ETH_HLEN headroom when
> minting the initial SKB.

[ ... ]

> The expensive pskb_expand_head() operation is now strictly a
> fallback, allowing properly configured hardware to achieve zero-copy MAC
> header insertion.

[Severity: Low]
Is this description accurate? For an ARPHRD_ETHER lower device, the lower
driver has already called eth_type_trans() before rmnet_rx_handler() runs:

net/ethernet/eth.c:eth_type_trans() {
    ...
	eth = eth_skb_pull_mac(skb);
    ...
}

That pulls ETH_HLEN bytes, and those bytes are really the start of the
MAP frame. The skb_push(skb, ETH_HLEN) in rmnet_map_ingress_handler()
just gives them back, so skb->data points at the MAP header again. No MAC
header is inserted.

Because those bytes were already pulled, skb_headroom(skb) >= ETH_HLEN
always holds at this point. That means the new branch can't be taken,
which matches the test result in the commit message:

  "the expansion is not triggered as enough space is already available"

If headroom ever were below ETH_HLEN, expanding and then pushing would
leave 14 uninitialized bytes where the MAP header is expected. So the
fallback wouldn't give a usable frame either.

In practice, does this patch remove the pskb_expand_head() call for every
ARPHRD_ETHER skb, whatever the lower driver's configuration?

If so, could the commit message say that directly? It would also help to
describe what else the call was doing: it made the skb data private and
shifted the payload by ETH_HLEN. Commit ec405641e2b7 ("net: qualcomm:
rmnet: Fix incorrect allocation flag in receive path") describes the call
as needed only when headroom is insufficient.

The "severely degrading throughput" claim also has no numbers. Could some
measurements be added?

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> index aa5523f4618eb..95c3e3934fd3c 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> @@ -114,9 +114,11 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
>  	u32 data_format;
>  
>  	if (skb->dev->type == ARPHRD_ETHER) {
> -		if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_ATOMIC)) {
> -			kfree_skb(skb);
> -			return;
> +		if (skb_headroom(skb) < ETH_HLEN) {
> +			if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_ATOMIC)) {
> +				kfree_skb(skb);
> +				return;
> +			}
>  		}

[Severity: Medium]
Can this let rmnet_map_send_ack() write into a data buffer that another
skb also uses?

Before this patch, pskb_expand_head() ran for every ARPHRD_ETHER skb. As
a side effect it gave the skb a private head (skb->cloned = 0,
dataref = 1). Headroom is now always >= ETH_HLEN here, so that no longer
happens.

Nothing earlier in rmnet_rx_handler() unclones the skb either.
skb_linearize() does nothing for a linear skb, and the pskb_may_pull()
that replaces it later in the series doesn't unclone.

The skb can arrive cloned when a ptype_all tap or a tc mirred mirror is
active on the lower device:

__netif_receive_skb_core()
  deliver_skb()
    packet_rcv()
      skb_clone(), clone queued to the socket
  rmnet_rx_handler()
    rmnet_map_ingress_handler()
      __rmnet_map_ingress_handler()
        rmnet_map_command()
          rmnet_map_send_ack()

With RMNET_FLAGS_INGRESS_DEAGGREGATION clear and
RMNET_FLAGS_INGRESS_MAP_COMMANDS set, an acknowledged FLOW_ENABLE or
FLOW_DISABLE command ends up here:

rmnet_map_command.c:rmnet_map_send_ack() {
    ...
	cmd = (struct rmnet_map_control_command *)(map_header + 1);
	cmd->cmd_type = type & 0x03;

	netif_tx_lock(dev);
	dev->netdev_ops->ndo_start_xmit(skb, dev);
    ...
}

This write changes the packet already queued to the AF_PACKET socket,
after the socket filter has accepted it. It can also race with a
recvmsg() copying the same buffer on another CPU.

Raw-IP lower devices never had the implicit unclone, but for ARPHRD_ETHER
this looks new.

Would skb_cow_head(skb, ETH_HLEN) work here instead? It reallocates only
when headroom is short or the header is cloned, so the fast path stays.
Another option is for rmnet_map_send_ack() to make the skb writable, for
example with skb_ensure_writable() or skb_unclone(), before the write.

>  
>  		skb_push(skb, ETH_HLEN);

[Severity: Medium]
Could skipping the copy leave the inner IP header misaligned on
architectures where NET_IP_ALIGN is 2?

The generic NET_IP_ALIGN in include/linux/skbuff.h is 2. Only x86, arm64
and powerpc set it to 0.

A lower Ethernet driver that uses NET_IP_ALIGN lays out its RX buffer for
a 14 byte Ethernet header before L3. Here, though, the frame starts with a
4 byte MAP header, plus 4 more bytes for a MAPv5 csum header.

With NET_SKB_PAD of 64 and NET_IP_ALIGN of 2:

  before: pskb_expand_head() copied into a fresh head shifted by ETH_HLEN
          MAP header at head+80, IP header at head+84 (4-byte aligned)

  after:  frame is parsed in place
          MAP header at head+66, IP header at head+70 or +74 (2 mod 4)

In non-deaggregation mode, the checksum code then does word loads on that
header:

rmnet_map_data.c:rmnet_map_ipv4_dl_csum_trailer() {
    ...
	if (ip_fast_csum(ip4h, ip4h->ihl)) {
    ...
}

The skb then goes to the IP stack. On architectures without
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, the stack expects an aligned
iphdr.

On strict-alignment CPUs such as MIPS, wouldn't these loads trap and be
emulated on every packet? That would make this change a slowdown rather
than a speedup.

The deaggregation path is not affected, because rmnet_map_deaggregate()
copies each packet into a new skb.

Which architecture and ingress data format was this tested with?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002143529.3217189-1-koen.vandeputte%40citymesh.com
