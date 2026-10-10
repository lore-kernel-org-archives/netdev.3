Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A42EEE65;
	Sat, 10 Oct 2026 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672129; cv=none; b=Tg47A2NFeEAjuKaT72cs4iKSGJoIRV8rRBTuq6ugeqmv3z8ugywDEexD7Nb9S/NqiyPsPmXLQDrXE+QuCQQ6oA5VF/gfHIPH99GxQgjhGNgASF4o+AU0e/PqX/S+SJa+w9JJEg8Rpo15qQEPwpDi/X3up9OTS+2giIWbTYWrNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672129; c=relaxed/simple;
	bh=ZjECScHKQBo8qYcpMHtjd/iL0i22FZgUly3P2QEbz2Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5XbkpO9VagZcsNcT5nIvZ/J9UNEnrCKhkuzTHqVwj07VCrSWdQ1+89CdxYwY/sJf1fKb45LtobVGCqzLV6xGjqUx/T74FjIcrOqOoTpNBVmovq/k1JE1CRZyPlSoPG6970E3yl2kHydotr+uh+RBQxCdmDd/+D1aR7KRRpmjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7cQeOJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7cQeOJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F1F1F000FF;
	Sat, 10 Oct 2026 22:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791672127;
	bh=VoiyHd+yjewNFECUX8z2BEz8vARVUCWN8WiOP4nnHyE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E7cQeOJAqSI6AQNuHpGLDcDT9t7f86Sqc5DsT/8N+vw4Gl5RjyWhB2TK+by0wiyUg
	 lfKbxPblrSXE3w8i5hbZ98gsMa4v2IWrTBGWfDjoou5kTwDvdE/YcwBGDm89RybZUL
	 YVyuI13xSwU7o6xvlN/2tVgUvpkdarhfZXr1WhXDr0Mo4y/4pWTtPED9kkUlFRrTkx
	 B5CFvt4SLFecc4x+yAFF3nqxQlVsz/gFxp3xnBA5cQrmzNPMmELSrFR2vobigHU+Is
	 08e3qGILP8nMft3iU0w131lnQNGje6KvjNVPmz5QU7CvZ+KOSlNoZx4Au32vPWajok
	 OcB5mzyiXdDGg==
Subject:
 Re: [PATCH net-next v2] net: ag71xx: align the IP header behind DSA tags
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 22:42:06 +0000
Message-ID: <179167212617.434549.11199449087797433558@kernel.org>
In-Reply-To: <20261009223024.545607-1-rosenp@gmail.com>
References: <20261009223024.545607-1-rosenp@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: ag71xx: 1-byte DMA and memory buffer overflow in RX path
- [Medium] The DSA-dependent RX offset is only computed in ag71xx_open().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ag71xx_change_mtu() can be called on a running interface.
- [High] This problem wasn't introduced by this patch, but if DSA conduit
  setup fails, the conduit keeps a dangling dsa_ptr.

--

net: ag71xx: align the IP header behind DSA tags

This patch moves the rx_buf_offset computation from ag71xx_probe() to
ag71xx_open(). When the netdev is a DSA conduit, it also adjusts
NET_IP_ALIGN by the tagger's needed_headroom, so the IP header behind the
tag is 4-byte aligned. The commit message reports a gain in routing
throughput on a qca8k based board.

> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index 4e4794c4dfdce..ff30ebce448dc 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c

[ ... ]

> @@ -1401,6 +1402,24 @@ static void ag71xx_hw_disable(struct ag71xx *ag)
>  	ag71xx_rings_cleanup(ag);
>  }
>  
> +static unsigned int ag71xx_rx_offset(struct ag71xx *ag)
> +{
> +	unsigned int align = NET_IP_ALIGN;
> +
> +	if (ag71xx_is(ag, AR7100) || ag71xx_is(ag, AR9130))
> +		return NET_SKB_PAD;
> +
> +#if IS_ENABLED(CONFIG_NET_DSA)
> +	/* A tag inserted in front of the EtherType shifts the IP header,
> +	 * compensate for it to avoid unaligned accesses in the stack.
> +	 */
> +	if (netdev_uses_dsa(ag->ndev))
> +		align = (align - ag->ndev->dsa_ptr->tag_ops->needed_headroom) & 3;

[Severity: High]
This is a pre-existing issue in the DSA core, not something this patch
introduced. Still, can dsa_ptr be left dangling when this runs?

dsa_conduit_setup() in net/dsa/conduit.c sets the pointer before two steps
that can fail:

net/dsa/conduit.c:dsa_conduit_setup() {
    ...
	dev->dsa_ptr = cpu_dp;

	dsa_conduit_set_promiscuity(dev, 1);

	ret = dsa_conduit_ethtool_setup(dev);
	if (ret)
		goto out_err_reset_promisc;

	ret = sysfs_create_group(&dev->dev.kobj, &dsa_group);
	if (ret)
		goto out_err_ethtool_teardown;
    ...
out_err_ethtool_teardown:
	dsa_conduit_ethtool_teardown(dev);
out_err_reset_promisc:
	dsa_conduit_set_promiscuity(dev, -1);
	return ret;
}

Neither error label clears dev->dsa_ptr. On that failure, dsa_tree_setup()
jumps to teardown_ports and skips dsa_tree_teardown_conduit(), so
dsa_conduit_teardown() never runs. The CPU dsa_port is then freed:

dsa_switch_probe()
  dsa_tree_setup()
    dsa_tree_setup_conduit()
      dsa_conduit_setup()      <- sets dsa_ptr, then fails
    goto teardown_ports        <- dsa_conduit_teardown() skipped
  dsa_switch_release_ports()
    kfree(dp)                  <- conduit->dsa_ptr still points here

After that, every received frame already reads dsa_ptr->rcv from freed
memory through eth_type_trans()->netdev_uses_dsa(). With this patch,
ag71xx_open() also reads dsa_ptr->tag_ops->needed_headroom from the freed
dsa_port.

Triggering it needs an allocation or sysfs failure during switch probe.
The fix probably belongs in the dsa_conduit_setup() error path rather than
in this driver.

> +#endif
> +
> +	return NET_SKB_PAD + align;
> +}
> +
>  static int ag71xx_open(struct net_device *ndev)
>  {
>  	struct ag71xx *ag = netdev_priv(ndev);
> @@ -1415,6 +1434,7 @@ static int ag71xx_open(struct net_device *ndev)
>  	}
>  
>  	max_frame_len = ag71xx_max_frame_len(ndev->mtu);
> +	ag->rx_buf_offset = ag71xx_rx_offset(ag);

[Severity: High]
ag71xx_rx_offset() can now return anything from NET_SKB_PAD + 0 to
NET_SKB_PAD + 3. The rx_buf_size computed right below is still sized
for NET_SKB_PAD + NET_IP_ALIGN. Is that enough when the tagger's
needed_headroom is 3 mod 4, so that (2 - needed_headroom) & 3 == 3?

ag71xx_fill_rx_buf() maps rx_buf_size bytes from the start of the
buffer. It then points the descriptor at dma_addr + offset. The MAC
may write up to max_frame_len bytes there, FCS included, because that
is what MAC_MFL is programmed with.

With an offset of NET_SKB_PAD + 3, the write ends at
NET_SKB_PAD + 3 + max_frame_len. That is one byte past
max_frame_len + NET_SKB_PAD + NET_IP_ALIGN, which is the value
rx_buf_size was derived from.

The SKB_DATA_ALIGN() rounding usually hides this. On ath79, though,
NET_SKB_PAD and SMP_CACHE_BYTES are both 32 and max_frame_len is
mtu + 22. Whenever mtu + 56 is a multiple of the cache line size there
is no slack at all.

In that case the MAC writes one byte past the region dma_map_single()
covered. That byte lands in the skb_shared_info area, which
napi_build_skb() places at data + rx_buf_size via
ag71xx_buffer_size(). On a non-coherent MIPS system this also means
the byte sits outside the range that was invalidated for the device.

I'm not sure any tagger used with ag71xx today has such a
needed_headroom. Nothing in ag71xx_rx_offset() rules it out, though,
and before this patch the offset could never exceed
NET_SKB_PAD + NET_IP_ALIGN.

Would it make sense to size the buffer from the offset actually in
use, for example SKB_DATA_ALIGN(max_frame_len + ag->rx_buf_offset)?
Alternatively, the offset could be clamped so it never exceeds
NET_SKB_PAD + NET_IP_ALIGN.

[Severity: Medium]
Can this cached offset get out of sync with the DSA state of a running
interface? It is only computed in ag71xx_open(). The refill path,
ag71xx_rx_packets(), the restart work and ag71xx_change_mtu() all reuse
ag->rx_buf_offset.

dsa_tree_setup_conduit() accepts a conduit that is already IFF_UP:

net/dsa/dsa.c:dsa_tree_setup_conduit() {
    ...
	bool admin_up = (conduit->flags & IFF_UP) && !qdisc_tx_is_noop(conduit);

	err = dsa_conduit_setup(conduit, cpu_dp);
    ...
}

dsa_conduit_setup() sets dev->dsa_ptr, and afterwards only the admin and
oper state is replayed. There is no ndo_stop/ndo_open cycle.

The dev_set_mtu() inside dsa_conduit_setup() only reaches
ag71xx_change_mtu(), which writes MAC_MFL. dsa_user_open() calls
dev_open(conduit), but that returns early because the conduit is already
up.

So if the switch binds after eth0 is up (late module load, deferred probe,
ip= or nfsroot bring-up), tagged traffic keeps NET_SKB_PAD + NET_IP_ALIGN
until the interface is cycled. In that case the patch has no effect.

The reverse case looks like a new regression. If the switch is unbound
while eth0 stays up, dsa_conduit_teardown() clears the pointer without
closing the conduit:

net/dsa/conduit.c:dsa_conduit_teardown() {
    ...
	dsa_conduit_set_promiscuity(dev, -1);

	dev->dsa_ptr = NULL;
    ...
}

For the qca and ar9331 taggers the cached offset is NET_SKB_PAD + 0,
because (2 - 2) & 3 == 0. Plain untagged frames then put the IP header at
an offset that is 2 mod 4, so every IP and TCP header access goes through
unaligned access emulation. Before this patch, the non-DSA case was always
aligned. dsa_switch_shutdown() closes the conduits before it clears
dsa_ptr, so it is not affected.

Could the offset be recomputed when a DSA tree attaches to or detaches from
the conduit, or could this limitation be documented?

>  	ag->rx_buf_size =
>  		SKB_DATA_ALIGN(max_frame_len + NET_SKB_PAD + NET_IP_ALIGN);

[Severity: High]
This isn't a bug introduced by this patch, but rx_buf_size is only derived
from the MTU here in ag71xx_open(). Can ag71xx_change_mtu() let the MAC
overflow the RX buffers if the MTU is raised while the interface is
running?

drivers/net/ethernet/atheros/ag71xx.c:ag71xx_change_mtu() {
	struct ag71xx *ag = netdev_priv(ndev);

	WRITE_ONCE(ndev->mtu, new_mtu);
	ag71xx_wr(ag, AG71XX_REG_MAC_MFL,
		  ag71xx_max_frame_len(ndev->mtu));

	return 0;
}

There is no netif_running() check, and the RX ring is not rebuilt. The RX
descriptor has no buffer length field. Once MFL is raised, the MAC can DMA
frames up to the new limit into buffers that ag71xx_fill_rx_buf() mapped
with the old rx_buf_size.

ag71xx_rx_packets() then does:

		skb = napi_build_skb(ring->buf[i].rx.rx_buf, ag71xx_buffer_size(ag));
		...
		skb_reserve(skb, offset);
		skb_put(skb, pktlen);

Take a SoC with a 1540 byte max frame length and the non-DSA offset of 34.
Raising the MTU from 1500 to 1518 while up leaves rx_buf_size at
ALIGN(1556, 32) = 1568. Offset 34 plus pktlen 1536 is 1570, so skb_put()
hits skb_over_panic().

On AR934x/QCA953x, where MFL can be up to 16K - 1, an MTU of 9000 would let
the DMA write several KB past the end of the page frag.

dsa_user_change_mtu() can reach the same path by raising the conduit MTU
while it is up. ag71xx_fast_reset() also reprograms MFL from ndev->mtu
without resizing the buffers.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009223024.545607-1-rosenp%40gmail.com
