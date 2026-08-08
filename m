Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9AE3D3CE0;
	Sat,  8 Aug 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218513; cv=none; b=QDdVf/qkEGXgINMvg5H805YGA71KOzwVZboSLemHPZAobK4L/Blc3jWDflvwAm3rk59guupO+ewC+6yvw13SAa/4xoWXIEiTpeQlAzxM1+yFC8QQOQMpkEYMYTQJzjt6feO2eU9AIuYh8ajgLaBLSZiuvvWwGb+DdwjeYKoWp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218513; c=relaxed/simple;
	bh=lzIekT/pvGRq9TMvm0y84O2enBx/YluoPMB7VMUyWDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuXUGMRmnAzGIqpPbNbz/yzM70dvaVNsUDoCqtMvm+yTAN2UcEIJq74mVbK3u2XuhFoSxerQlazT8PhfER9lACOQqGhUThpNqWP+GYJgAdH86FD4H/Fp4uZRvqcChTUEiBq3AymRyecpEGPLeuW38l6b6df6IKkWu4FyO1X3N90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNv6l3dy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNv6l3dy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4D11F00A3A;
	Sat,  8 Aug 2026 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218506;
	bh=PGLFx20OJkATeaOnfq8BynVGC6dZ8C1J46R9FCi/LBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LNv6l3dyn2JhxoNffxFzH5N7/HO6kRQ1XMVBhjGzG23WKCuAE9H0e94GzE7ddXkZL
	 EzgSDKWIqOH2Rv8mgRhTTJGK6UBRSPlXg5nLqOzaV9GdF06LIZLBzSIqok4n5w1/eB
	 XdBCow7G8i22cSyUKEUBjrSk5VaRMlj6Nz6UHcOQieaMoEmdi9ystqgoUT9H0SoMTh
	 XOYH9psBi8Pc6PPJ49P1ltzTqcS0mC3rSEOfWlaaRFc4qe/xOFz6/YQhlqtJL3YEiQ
	 RqnLW0j3P9JN5iekVpEI0qWiTUPVoFidiEKPqYk+MAN+J6/9An1QEilMP+0c5d0UEP
	 33ffWB3wCRXqg==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 08/20] net: xilinx: tsn: deliver endpoint RX frames to DSA user ports
Date: Sat,  8 Aug 2026 12:48:25 -0700
Message-ID: <20260808194825.132892-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-9-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-9-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: xilinx: tsn: deliver endpoint RX frames to DSA user ports

The endpoint driver now allocates one METADATA_HW_PORT_MUX metadata_dst
per MAC port at probe time and attaches the matching entry to each RX
frame based on the TUSER port_id, so the DSA core can route frames to
the correct swpN user netdev.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 7615d27f3b36..051285b47ddb 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -254,6 +262,7 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	}
>  
>  	skb_put(skb, rx_len);
> +	skb_dst_set_noref(skb, &ep->port_md[port_id]->dst);
>  	skb->dev = ndev;
>  	skb->protocol = eth_type_trans(skb, ndev);
>  	skb->ip_summed = CHECKSUM_NONE;

[Severity: Medium]
Should this attach be gated on the ep netdev actually being a DSA conduit?

The only in-tree receive-side consumer that interprets and then drops this
dst is dsa_switch_rcv() in net/dsa/tag.c:

	if (md_dst && md_dst->type == METADATA_HW_PORT_MUX) {
		unsigned int port = md_dst->u.port_info.port_id;

		skb_dst_drop(skb);
		if (!skb_has_extensions(skb))
			skb->slow_gro = 0;

and that path is only reached for ETH_P_XDSA, which eth_type_trans() returns
only when netdev_uses_dsa(dev) is true.

NET_DSA_XILINX_TSN is a separate tristate from XILINX_TSN, so the ep netdev
can be up and receiving with no switch bound (switch driver not built, no
switch node in DT, switch probe failure, or the window between the ep
register_netdev() and dsa_register_switch()). In that configuration nothing
drops the metadata dst, and every received frame carries a dev-less
DST_METADATA into the generic stack: skb->slow_gro is forced on for all
traffic, IPv4 early demux is skipped because ip_rcv_finish_core() requires
!skb_dst(skb), and the stale port_id 1/2 stays readable through
skb_metadata_dst() by tc/BPF/netfilter ingress, AF_PACKET taps, bridging and
clones.

Both existing users of this mechanism gate the attach. mtk_poll_rx() in
drivers/net/ethernet/mediatek/mtk_eth_soc.c:

		if (mtk_is_netsys_v1(eth) && (trxd.rxd2 & RX_DMA_VTAG) &&
		    netdev_uses_dsa(netdev)) {
			...
				skb_dst_set_noref(skb, &eth->dsa_meta[port]->dst);

and airoha_qdma_rx_process() in drivers/net/ethernet/airoha/airoha_eth.c:

		if (netdev_uses_dsa(netdev)) {
			...
				skb_dst_set_noref(q->skb,
						  &port->dsa_meta[sptag]->dst);

[Severity: Medium]
Is the noref dst still valid by the time it is dereferenced?

skb_dst_set_noref() stores an unreferenced pointer that must either be
consumed inside the same RCU read-side section or upgraded with
skb_dst_force().  Neither happens here: __netif_rx() does not process the
frame inline, netif_rx_internal() enqueues it on a softnet backlog queue
(possibly a remote CPU's under RPS) and returns, so the DMA completion
callback's BH section ends while the skb still holds the raw pointer:

ep_dma_rx_cb()
  skb_dst_set_noref()
  __netif_rx() -> netif_rx_internal() -> enqueue_to_backlog()

later NET_RX softirq:
  process_backlog() -> __netif_receive_skb_core() -> dsa_switch_rcv()
    skb_metadata_dst() / skb_dst()

The two existing users consume the metadata in the same BH section via
napi_gro_receive().  The one core call site that queues a dst-carrying skb
to the backlog, dev_loopback_xmit(), upgrades first:

	DEBUG_NET_WARN_ON_ONCE(!skb_dst(skb));
	skb_dst_force(skb);
	netif_rx(skb);

Would napi_gro_receive()/netif_receive_skb(), or an skb_dst_force() before
the handoff, be more appropriate here?

> @@ -771,6 +780,37 @@ static int ep_count_dma_queues(struct device *dev, u32 *out_tx, u32 *out_rx)
>  	return 0;
>  }
>  
> +static void ep_free_port_md(struct xlnx_tsn_ep *ep)
> +{
> +	int i;
> +
> +	for (i = 0; i < XLNX_TSN_EP_PORT_MD_SLOTS; i++) {
> +		if (ep->port_md[i]) {
> +			metadata_dst_free(ep->port_md[i]);
> +			ep->port_md[i] = NULL;
> +		}
> +	}
> +}

[Severity: High]
Can this free a metadata_dst that skbs still point at?

metadata_dst_free() in net/core/dst.c is an unconditional kfree():

void metadata_dst_free(struct metadata_dst *md_dst)
{
	...
	kfree(md_dst);
}

It ignores dst->__rcuref (dst_init() starts it at 1) and skips the
call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu) deferral that dst_release()
performs.  Meanwhile ep_dma_rx_cb() published the raw pointer to the stack
with skb_dst_set_noref().

Two paths look reachable:

(a) xlnx_tsn_ep_remove() frees right after unregister_netdev() with no
    synchronize_net() of its own.  flush_all_backlogs() only purges skbs
    still sitting on a backlog queue, not an skb already dequeued and in
    flight in __netif_receive_skb_core() on another CPU, nor a clone that
    already left the netdev-scoped backlog.  Such an skb then reads
    md_dst->type / md_dst->u.port_info.port_id out of freed memory in
    net/dsa/tag.c or the flow dissector.

(b) If anything upgrades the noref dst with skb_dst_force() (for instance
    __dev_queue_xmit() when the frame is bridged or forwarded to a device
    without IFF_XMIT_DST_RELEASE, which is reachable in the ungated
    non-DSA case above), dst_hold_safe() succeeds because rcuref starts at
    1 and the skb owns a reference.  The kfree() here then frees a
    still-referenced object, and the skb's later skb_dst_drop() ->
    dst_release() does a rcuref_put() write on freed memory and may queue
    dst_destroy_rcu() on it.

Would dst_release(&ep->port_md[i]->dst) be the right teardown, matching
mtk_free_dev():

		dst_release(&eth->dsa_meta[i]->dst);

and the equivalent dst_release(&port->dsa_meta[i]->dst) in the airoha
driver?

[ ... ]

> @@ -858,6 +906,7 @@ static void xlnx_tsn_ep_remove(struct platform_device *pdev)
>  		return;
>  
>  	unregister_netdev(ep->ndev);
> +	ep_free_port_md(ep);
>  	free_netdev(ep->ndev);
>  }

[Severity: High]
Same concern as above, at the call site: the metadata_dst objects are
kfree()d here immediately after unregister_netdev(), with no RCU grace
period and no refcount check, while skbs or clones referencing them may
still be in flight in the receive stack or queued in a qdisc after an
skb_dst_force() upgrade.
