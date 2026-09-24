Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99954AEBE0;
	Thu, 24 Sep 2026 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269665; cv=none; b=krgPIWiMIcp4O98ixAYVnpcMRBxaqaqnIqjSFQsEkVOoKB07SU0XcJAuLLibdHZ2Rmvc7OwgcwESVIVB98oCMxpPgUY386jspjLINOyydPxKEpvkXj+dZbKArakZfVFwekfk/20Rn8dR/1GML7pY5VBC/JQKGFTXGE3tPYBQ1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269665; c=relaxed/simple;
	bh=9P1AX9vCYuZR2GZ8rgwgpSGboqToBqhDMopP424HZDQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vDFnolzvaJ8C+9KGuTnxSa6iCILhgCIt6ku5Wt/Dp+yMYEAeAd6GOEC1ihCyBTvLdqQp7mnF+LTciOMW0m1f09JkDCl3coKXz+fZ9AgmNFxhtJTCwai/1mm5pqOBQRP6QEIZgxUuSCg4zjwqsBiWVwIrXOt+moackEwF2cP1ErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYLJmzs2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYLJmzs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF891F00899;
	Thu, 24 Sep 2026 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269663;
	bh=1hN6OfYIG7P0ECzeM7aqzo7k1U1f3qordhOZO9M849I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XYLJmzs23/5yz/pxCtnUdTWeWcFaxXu4Fv3Sh7DXSe/5WA5h3l9NbdKCGGyKuTwMQ
	 VMc/dLMuQEVlkGkNHMeY5Zrnfu87RN6PxeAmIv/yVpunE93sJHiY8C39tSQU12QPl7
	 PpdaYKoNPhqnq9E+whgFyu+ACOhOUUqfVgwvcjxb79t/Dfq9KGfdN7hhJ9b5r5VfqM
	 mMiEP6vzEgrXLLV5btOJNGYiKmgrBVgphwBpR6X0LmR444HL9LW8NfNjydgqdqMU+j
	 drqKOGlJpDXSOfhoQnSiRlC8OgP9t/GrfPz/NdjtoRyZrFEuZ7G8ru+Yw3fkPGFf6N
	 KB62w5GdfBlvg==
Subject: Re: [PATCH net 11/12] net: systemport: Update TDMA queue mapping
 dynamically on changeupper
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:07:42 +0000
Message-ID: <179026966266.2160803.18168687419890840728@kernel.org>
In-Reply-To: <20260921231305.394773-12-florian.fainelli@broadcom.com>
References: <20260921231305.394773-12-florian.fainelli@broadcom.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 3 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bcm_sysport_unmap_queues() now latches RING_IGNORE_STATUS into
  TDMA_DESC_RING_MAPPING(q) at runtime, but the only other writer of…
- [Medium] bcm_sysport_unmap_queues()
  (drivers/net/ethernet/broadcom/bcmsysport.c:2374-2412) lacks the…
- [Medium] netif_running(dev) is used as the sole precondition for the
  new tdma_readl()/tdma_writel() accesses, but netif_running()…
- [Medium] net: systemport: TX ring software mapping exposed before
  hardware is configured

Pre-existing issues:
- [Medium] In bcm_sysport_map_queues() the newly added register write
  shifts the DSA port index into the 3-bit RING_PORT_ID field without…

--

net: systemport: Update TDMA queue mapping dynamically on changeupper

This commit makes bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
program the TDMA_DESC_RING_MAPPING registers right away when the conduit
interface is already running, instead of deferring all programming to
bcm_sysport_init_tx_ring().

A few questions about the new register programming below.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index dd5a7c9dd90fb..e5bb7fa84fda5 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2350,14 +2351,21 @@ static int bcm_sysport_map_queues(struct net_device *dev,
>  		if (ring->inspect)
>  			continue;
>  
> -		/* Just remember the mapping actual programming done
> -		 * during bcm_sysport_init_tx_ring
> -		 */
>  		ring->switch_queue = qp;
>  		ring->switch_port = port;
>  		ring->inspect = true;
>  		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
>  			priv->ring_map[qp + port * num_tx_queues] = ring;
> +
> +		if (netif_running(dev)) {

[Severity: Medium]
Is netif_running() sufficient on its own to guarantee the SYSTEMPORT
register block is clocked here (and in the matching check added to
bcm_sysport_unmap_queues())?

bcm_sysport_suspend() only bails out when the interface is not running,
and then detaches and gates the clock:

	if (!netif_running(dev))
		return 0;

	netif_device_detach(dev);
	...
	clk_disable_unprepare(priv->clk);

netif_device_detach() clears __LINK_STATE_PRESENT, not
__LINK_STATE_START, so netif_running() stays true for the whole suspended
window while priv->clk is off.  The same state persists indefinitely after
a failed bcm_sysport_resume(), where every error path ends in:

out_free_tx_rings:
	for (i = 0; i < dev->num_tx_queues; i++)
		bcm_sysport_fini_tx_ring(priv, i);
	clk_disable_unprepare(priv->clk);
	return ret;

with no netif_device_attach().

The PM callbacks do not take rtnl_lock, so they are not serialized against
the rtnl-protected notifier path
bcm_sysport_netdevice_event()->bcm_sysport_unmap_queues().  A DSA switch
driver unbind in that window (dsa_user_destroy()->netdev_upper_dev_unlink())
would reach the new tdma_readl()/tdma_writel() sequence with the block
clock-gated.  Before this patch neither function touched MMIO.  Would
pairing netif_running(dev) with netif_device_present(dev) here close that
window?

> +			reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(q));
> +			reg &= ~(RING_QID_MASK |
> +				 RING_PORT_ID_MASK << RING_PORT_ID_SHIFT |
> +				 RING_IGNORE_STATUS);
> +			reg |= (qp & RING_QID_MASK);
> +			reg |= (port << RING_PORT_ID_SHIFT);

[Severity: Medium]
The new register programming happens after the ring has already
been published to the TX path.  ring->inspect = true and
priv->ring_map[qp + port * num_tx_queues] = ring are stored first,
and only then does the netif_running() block read/modify/write
TDMA_DESC_RING_MAPPING(q).

bcm_sysport_select_queue() looks the ring up purely from software
state:

	tx_ring = priv->ring_map[index];
	if (unlikely(!tx_ring))
		return netdev_pick_tx(dev, skb, NULL);
	return tx_ring->index;

The notifier path runs under rtnl_lock, but the transmit path does
not, so between the ring_map[] store and the tdma_writel() a
concurrent xmit can already be steered onto ring q while
TDMA_DESC_RING_MAPPING(q) still holds the previous contents -
either the RING_IGNORE_STATUS that bcm_sysport_init_tx_ring() sets
in its else branch for non-inspected rings, or the one the new code
in bcm_sysport_unmap_queues() writes, plus a stale QID/port from an
earlier mapping.  Frames going out in that window are transmitted
with the switch port/queue status ignored, i.e. the switch
backpressure this mapping exists to honour is bypassed and the
frames can be dropped in the switch if the target queue is
congested.

Note bcm_sysport_unmap_queues() has the safe ordering for its
direction (software mapping torn down first, hardware told to ignore
status afterwards); map_queues() is the one publishing the ring
before the hardware agrees.  Would it be enough to move the
netif_running() register update ahead of the ring->inspect and
priv->ring_map[] assignments, or do you also need the ring stopped
(ring->lock / netif_tx_stop_queue()) around the update to make the
software and hardware view flip atomically for an in-flight xmit?

[Severity: Medium]
This isn't a bug introduced by this patch - bcm_sysport_init_tx_ring() has
the identical unmasked encoding:

	reg |= ring->switch_queue & RING_QID_MASK;
	reg |= ring->switch_port << RING_PORT_ID_SHIFT;

but since the new code replicates it into the live reconfiguration path:
should port be masked with RING_PORT_ID_MASK the way qp is masked with
RING_QID_MASK?

The field is only three bits wide and sits right next to the status bits:

#define  RING_PORT_ID_SHIFT		3
#define  RING_PORT_ID_MASK		0x7
#define  RING_IGNORE_STATUS		(1 << 6)
#define  RING_FAILOVER_EN		(1 << 7)
#define  RING_CREDIT_SHIFT		8

port comes from dp->index and is only filtered for the tree index
(if (dp->ds->index) return 0;), never bounded to 7, while the driver sizes
priv->ring_map[] as DSA_MAX_PORTS * 8 and guards with
qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map).  For port == 8 the
shifted value is exactly 0x40, which re-sets the RING_IGNORE_STATUS bit the
preceding mask just cleared and programs switch port 0; port >= 16 would
also reach RING_FAILOVER_EN and the credit field.

> +			tdma_writel(priv, reg, TDMA_DESC_RING_MAPPING(q));
> +		}
>  		qp++;
>  	}
>  
> @@ -2372,6 +2380,7 @@ static int bcm_sysport_unmap_queues(struct net_device *dev,
>  	struct bcm_sysport_tx_ring *ring;
>  	unsigned int num_tx_queues;
>  	unsigned int q, qp, port;
> +	u32 reg;
>  
>  	port = dp->index;
>  
> @@ -2390,6 +2399,14 @@ static int bcm_sysport_unmap_queues(struct net_device *dev,
>  		qp = ring->switch_queue;
>  		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
>  			priv->ring_map[qp + port * num_tx_queues] = NULL;
> +
> +		if (netif_running(dev)) {
> +			reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(q));
> +			reg &= ~(RING_QID_MASK |
> +				 RING_PORT_ID_MASK << RING_PORT_ID_SHIFT);
> +			reg |= RING_IGNORE_STATUS;
> +			tdma_writel(priv, reg, TDMA_DESC_RING_MAPPING(q));
> +		}

[Severity: High]
Can the RING_IGNORE_STATUS bit set here become sticky?

The only other writer of that register, bcm_sysport_init_tx_ring(), leaves
RING_IGNORE_STATUS out of its clear mask:

	reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(index));
	reg &= ~(RING_QID_MASK | RING_PORT_ID_MASK << RING_PORT_ID_SHIFT);
	if (ring->inspect) {
		reg |= ring->switch_queue & RING_QID_MASK;
		reg |= ring->switch_port << RING_PORT_ID_SHIFT;
	} else {
		reg |= RING_IGNORE_STATUS;
	}
	tdma_writel(priv, reg, TDMA_DESC_RING_MAPPING(index));

bcm_sysport_fini_tx_ring() does not reset the mapping register, umac_reset()
only resets UniMAC and topctrl_flush() only flushes the RX/TX pipes, so the
bit appears to survive ifdown/ifup and suspend/resume.

That gives this sequence:

1. DSA user linked while the conduit runs: map_queues() programs QID/port
   and clears RING_IGNORE_STATUS.
2. DSA user unlinked while running: the new code above sets
   RING_IGNORE_STATUS.
3. ifdown.
4. DSA user re-linked while down: netif_running() is false, so only
   ring->inspect and priv->ring_map[] are updated.
5. ifup: bcm_sysport_init_tx_ring() takes the ring->inspect branch,
   programs QID/port, but cannot clear RING_IGNORE_STATUS.

Software then treats the ring as inspected and steers Brcm-tagged frames to
it:

	tx_ring = priv->ring_map[index];
	if (unlikely(!tx_ring))
		return netdev_pick_tx(dev, skb, NULL);
	return tx_ring->index;

while hardware still ignores the switch port/queue status.  Step 2 wrote
nothing before this patch.

The same end state also seems reachable when the interface is first opened
with no DSA upper (init_tx_ring()'s else branch sets the bit on every ring)
and a DSA user is attached while the interface is down, which is the
software/hardware desync this commit aims to close.  Would deriving
RING_IGNORE_STATUS from ring->inspect at both sites - i.e. adding
RING_IGNORE_STATUS to init_tx_ring()'s clear mask, or factoring out one
shared mapping helper - handle both cases?

[Severity: Medium]
Should bcm_sysport_unmap_queues() also carry the switch-index filter that
bcm_sysport_map_queues() has?

map_queues() refuses non directly attached switches:

	/* We can't be setting up queue inspection for non directly attached
	 * switches
	 */
	if (dp->ds->index)
		return 0;

unmap_queues() has no such check and selects rings only by port index:

	if (ring->switch_port != port)
		continue;

In a multi-switch tree sharing this conduit, a user port on a downstream
switch (ds->index != 0) can have the same dp->index as a mapped port on the
directly attached switch.  The notifier forwards every DSA user unlink on
this conduit without filtering on the switch index:

	if (!dsa_user_dev_check(info->upper_dev))
		return NOTIFY_DONE;
	if (info->linking)
		ret = bcm_sysport_map_queues(dev, info->upper_dev);
	else
		ret = bcm_sysport_unmap_queues(dev, info->upper_dev);

Previously that mis-selection only cleared software state (ring->inspect,
priv->ring_map[]).  With this patch, when the conduit is running, it also
rewrites those live rings' TDMA_DESC_RING_MAPPING registers, dropping the
QID/port binding and setting RING_IGNORE_STATUS for a port that is still
attached and still mapped on switch 0.

>  	}
>  
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921231305.394773-1-florian.fainelli%40broadcom.com
