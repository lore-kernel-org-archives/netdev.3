Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D437F739;
	Tue,  6 Oct 2026 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326145; cv=none; b=f0WW73jSAiNYPRFx9jYCHp6EGcZEzHbwDI4ANMk0vtbzDcrXontKjIJRNjIilDZkJkyZnuuhgkLMkCDL/ueQ6CKJ5OFjjumuulC5du0+8A1huFh7mdFJNqjzQ0+A0nZj1x6XFVYp2lCaL65fgmugEePD49/ra3NGXAEuUXj0UlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326145; c=relaxed/simple;
	bh=7/vgQNQINhVeM2HEILSaTkQbjerRyuAlLe9U5Q1+B+s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3qLGNgFTOEv3YD5EG3U0Sf8keio8QKGOf8Wkr426aOLa4233ZKK5eUWTffZlGgNmef+SnPLFzwzP8WWOukhHsMET0tTi38S0a/ZqBtPIaJ/g4bdooHBUp/uLFb7hJrFnBIRSLNWvYPbK6q0AtOIjPtiX3OE/HaVaRmf9ExiHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6E6z/Vw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6E6z/Vw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CF31F0089C;
	Tue,  6 Oct 2026 22:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326144;
	bh=Ei22AxPmszgqDnoECsD/E6gEFH7Nqp440bIHD12NIaE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f6E6z/Vw6hKHm3MsCaAWWG+GeCHGDH/byQDsDuxq80pK6ORzvpfZLjtwFmlgPYyO0
	 rdKFOXOklzi9F+QGbFOpdlFx1c3Gq2KTREuviVqLGl4FlwEo1a+StNCKXwSBiVLcPI
	 szdLNwXGeiYXe5zbKqyIABdKfBNU5BOkj0tLUVNMNlGicoRNVjhOesDJREZfosV8oZ
	 IXXgPCNe8bOiXmDzPl2zuE8CU8XRXQcsgZ1TbqAzdpHyuCDsuqd/+YsA0NauZZoYGj
	 b0hGCdxJmdkhn2GzaH31CMqA04KdwEaPv+HaoquMI7lhJ6F/Er235O0COX44ELKqfu
	 nKWPZKqUpFRdg==
Subject: Re: [PATCH net-next v2 6/7] net: bcmgenet: pad transmit frames out of
 the packet ready window
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Tue, 06 Oct 2026 22:35:43 +0000
Message-ID: <179132614302.434549.16529107189654383198@kernel.org>
In-Reply-To: <20261006-nb-genet-mtu-nn-v2-v2-6-c4be21151912@tipi-net.de>
References: <20261006-nb-genet-mtu-nn-v2-v2-6-c4be21151912@tipi-net.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] skb_put_padto() in bcmgenet_xmit() appends up to 63 zero bytes
  after the existing end of the frame.
- [Medium] The two new error exits in bcmgenet_xmit()
  (skb_checksum_help() failure and skb_put_padto() failure) jump…
- [Low] bcmgenet_xmit() gains a software checksum fallback that this
  commit's message never mentions.
- [Low] Series ordering leaves one intermediate commit broken.

--

net: bcmgenet: pad transmit frames out of the packet ready window

This commit pads transmit frames that end just past the TBUF packet ready
threshold out to 64 bytes past it, to avoid a Tx DMA stall seen on CM4. It
also lowers the transmit threshold for the MTUs where the longest frame the
MAC accepts would land in that window. It adds a software checksum fallback
for CHECKSUM_PARTIAL frames longer than the threshold.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 3e2ebd9a2cc50..e8f86374c7cd8 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2173,6 +2178,31 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto out;
>  	}
>  
> +	/* The MAC only inserts a checksum into a frame it holds in full, and
> +	 * silently drops a longer one, so fall back to software.
> +	 */
> +	if (unlikely(skb->len > priv->tx_thld_len) &&
> +	    skb->ip_summed == CHECKSUM_PARTIAL) {
> +		if (skb_checksum_help(skb)) {

[Severity: Low]
The commit message covers the padding and the threshold change. Should it
also mention this software checksum fallback?

In bcmgenet_xmit(), any CHECKSUM_PARTIAL skb longer than priv->tx_thld_len
now goes through skb_checksum_help() instead of hardware offload. If that
call fails, the skb is dropped and counted in ring->stats64.dropped.

bcmgenet_tx_pkt_rdy_thld() also lowers the threshold from 0xf0 (3840 bytes)
to 0xe0 (3584 bytes) for MTU 3809 and up. So at those MTUs the CPU now
checksums every full-size frame, which the hardware handled before. In this
tree that covers MTU 3809..3820, and only on kernels with pages larger than
4K.

The changelog doesn't explain the hardware behaviour claimed in the comment
("silently drops a longer one") or the new drop path either.

The last patch in the series, "net: bcmgenet: reassemble jumbo frames from
status block fragments", does say "anything longer than the threshold falls
back to software", so the series does disclose it. Could this commit
describe it too, since this is where the code is added?

> +			BCMGENET_STATS64_INC((&ring->stats64), dropped);
> +			dev_kfree_skb_any(skb);
> +			ret = NETDEV_TX_OK;
> +			goto out;
> +		}
> +	}
> +
> +	/* Keep the frame out of the window just past the threshold */
> +	if (unlikely(skb->len > priv->tx_thld_len &&
> +		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
> +		if (skb_put_padto(skb, priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {

[Severity: Medium]
skb_put_padto() appends up to 63 zero bytes after the current end of the
frame. Can that break protocols that keep their metadata at the tail?

DSA tail taggers write the egress tag as the last bytes of the frame with
skb_put(). Examples are ksz9477_xmit(), ksz_common_xmit() and lan937x_xmit()
in net/dsa/tag_ksz.c, and trailer_xmit() in net/dsa/tag_trailer.c:

	trailer = skb_put(skb, 4);
	trailer[0] = 0x80;
	trailer[1] = dsa_xmit_port_mask(skb, dev);

The DSA core pads short frames itself before tagging, in dsa_user_xmit(),
so that conduit padding never ends up after a tail tag:

	if (dev->needed_tailroom)
		eth_skb_pad(skb);

With GENET as the conduit, the switch would read zeros where it expects the
port mask/override or the 0x80 marker. The real tag bytes would then go out
on the wire.

PRP has the same problem. prp_fill_rct() puts the RCT last, and
skb_get_PRP_rct() looks for it at skb_tail_pointer(skb) - HSR_HLEN. With
zeros appended, the receiver treats the frame as a standard frame and loses
duplicate discard.

bcmgenet_tx_pkt_rdy_thld() lowers the threshold to 3584 for MTU 3809 and up,
so 3585..3647 byte frames get padded as well. At the end of the series (max
MTU 16347), a conduit with a jumbo MTU hits this for any 3841..3903 byte
frame. A remote peer can steer frame sizes into that range, for example
with ICMP echo sizes.

The commit message accepts this and says the alternatives are dropping the
frame or leaving the transmitter stalled. Where the tail is known to carry
data, for example netdev_uses_dsa() with a tail tagger, would dropping the
frame be safer than sending it with a corrupted tag?

> +			BCMGENET_STATS64_INC((&ring->stats64), dropped);
> +			ret = NETDEV_TX_OK;
> +			goto out;

[Severity: Medium]
Both new error exits, after skb_checksum_help() and after skb_put_padto(),
jump to out. That label comes after the doorbell write at the end of
bcmgenet_xmit():

	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
		/* Packets are ready, update producer index */
		bcmgenet_tdma_ring_writel(priv, ring->index,
					  ring->prod_index, TDMA_PROD_INDEX);
out:
	spin_unlock(&ring->lock);

Suppose an earlier skb in the same batch was queued with netdev_xmit_more()
true. ring->prod_index was advanced and netdev_tx_sent_queue() ran, but
TDMA_PROD_INDEX was not written.

The last skb of the batch might then fail here, for example on a GFP_ATOMIC
failure in __skb_pad() or pskb_expand_head(). In that case NETDEV_TX_OK is
returned without prod_index being published, and dev_hard_start_xmit()
treats that as the end of the batch.

Would the descriptors already queued then stay unsent until a later xmit
rings the doorbell? The queue isn't stopped, so the TX watchdog wouldn't
step in.

The existing exits for bcmgenet_add_tsb() failure and DMA mapping failure
behave the same way. This patch adds two more paths that do it.

> +		}
> +	}
> +
> +	nr_frags = skb_shinfo(skb)->nr_frags;
> +

[ ... ]

> @@ -2680,8 +2729,7 @@ static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
>  		return;
>  
>  	bcmgenet_rbuf_writel(priv, thld, RBUF_PKT_RDY_THLD);
> -	bcmgenet_writel(ENET_THLD_MAX,
> -			priv->base + priv->hw_params->tbuf_offset +
> +	bcmgenet_writel(tx_thld, priv->base + priv->hw_params->tbuf_offset +
>  			TBUF_PKT_RDY_THLD);
>  }

[Severity: Low]
This one is about the order of the series. Does it leave an intermediate
commit broken?

"net: bcmgenet: derive the receive buffer length from the MTU" programs
TBUF_PKT_RDY_THLD to ENET_THLD_MAX and defers the fix ("A later patch lowers
it for the few MTUs that need the room").

"net: bcmgenet: allow the MTU to be changed" then raises dev->max_mtu to
ENET_MAX_MTU, which is 3820 on kernels with pages larger than 4K.

vlan_dev_change_mtu() lets an 802.1Q device use the full parent MTU. So at
that commit, a stacked VLAN at MTU 3820 produces 3820 + 14 + 8 = 3842 byte
frames.

Frames of that size fall in the 3841..3886 window this patch describes for a
3840 threshold. And according to the new comment in bcmgenet_xmit(), the MAC
silently drops a CHECKSUM_PARTIAL frame longer than 3840 bytes.

Could this patch, and the threshold logic, be ordered before the max_mtu
increase? That way a bisect landing on "allow the MTU to be changed" would
not hit the stalled transmitter.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912%40tipi-net.de
