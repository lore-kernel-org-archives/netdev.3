Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272F3DCD8A;
	Thu, 24 Sep 2026 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216497; cv=none; b=ftGM4L2v2OZqtrMZzAzGc4vFHhUFQZ7rIz5glQ3YqULxhDADfqXK5F1H5uFPDrSH4zVV7XCWq9HpDbPw10s+ofBb50lOEaDq09nGZoHk8quDYp3uRr3zO9ZvGxBEqGGIRoybB0EDYYIHpF6TxB41LezNIW0e1l7dHARo5h5s99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216497; c=relaxed/simple;
	bh=LXJM1t/VVwZGwElGyxOmPCKYbYsB1I0/sr39tzmu75E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YoKyiQADNyc+XSauEAeitcKFqofUZaqyFqcPrhJdNMVPz0jpgsRaPXJGCimqAnQCfh5R4JcmdT6pnILOxpXX9/12ylJEDTec16tPZNaFB1iSJEePcIDA89YfkeFOi21gJMJnxYOKYUbcl7r7mpTuk7lhDUouD9fCXfeHE0d+GKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecK4g3jJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecK4g3jJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C55F1F000FF;
	Thu, 24 Sep 2026 02:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216491;
	bh=2ZwzhB3VrBJ5e6p0n/RKD0PYNXcFwhT0hp/kIJps+v4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ecK4g3jJZVk9TaE+kxABSWUU1aIPZCXsAbK/8+o/rIQEHLxAmgjaxobDrqTcqfzNS
	 rSziGajemAI/2Ug+oo+paw15T45+WFK+xLvAvs+VpvdfXmxdXeSaOIz8I+8S0qM529
	 Ft6MuG9aus7udiKRSxL1v8sxO+iDrt527/ZyYzlhnMgy6HoTz8Kg28pvChqVP0YSzf
	 mPT/5xqPEwrPBk7rHnwxMkoNf69zzDEZm9wbVFB5S51iC52jApw4JY6IVMtXIDPS0k
	 OfF/s1R7bp0/s2jjVWOwz6wNadz6GIftNTEMZrTI+WGGwoese9PIfOBwphNbSzYZu4
	 DiVHRV6odqTVg==
Subject: Re: [PATCH net v2 10/10] net: systemport: Update TDMA queue mapping
 dynamically on changeupper
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, nb@tipi-net.de, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 02:21:30 +0000
Message-ID: <179021649002.2160803.8605280366448713462@kernel.org>
In-Reply-To: <20260922232440.598918-11-florian.fainelli@broadcom.com>
References: <20260922232440.598918-11-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch programs RING_IGNORE_STATUS one way in the new
  runtime paths and leaves it unchanged in the deferred path, so the…
- [Low] In bcm_sysport_map_queues(), the new TDMA_DESC_RING_MAPPING write
  masks qp with RING_QID_MASK but ORs in `port << RING_PORT_ID_SHIFT`…
- [Low] The new MMIO in bcm_sysport_map_queues() and
  bcm_sysport_unmap_queues() (tdma_readl/tdma_writel on…

--

net: systemport: Update TDMA queue mapping dynamically on changeupper

This commit makes bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
write the TDMA_DESC_RING_MAPPING registers directly when the SYSTEMPORT
interface is running. Before this, those functions only updated the
software mapping, and the hardware was programmed later from
bcm_sysport_init_tx_ring().

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index dedd49ad6c4ef..ca1b86953dba0 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c

[ ... ]

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
> +			reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(q));

[Severity: Low]
Does netif_running() guarantee that priv->clk is enabled here? The same
question applies to the new block in bcm_sysport_unmap_queues().

bcm_sysport_suspend() calls netif_device_detach() and
clk_disable_unprepare(priv->clk) but leaves __LINK_STATE_START set.
bcm_sysport_resume() can then fail in several ways: clk_prepare_enable()
fails, bcm_sysport_init_tx_ring() or bcm_sysport_init_rx_ring() fails, or
the RDMA/TDMA enable times out. In each case it returns with the clock
disabled and does not call netif_device_attach():

bcm_sysport_resume() {
    ...
out_free_tx_rings:
	for (i = 0; i < dev->num_tx_queues; i++)
		bcm_sysport_fini_tx_ring(priv, i);
	clk_disable_unprepare(priv->clk);
	return ret;
}

netif_running() is still true in that state. A later NETDEV_CHANGEUPPER,
for example from unbinding bcm_sf2, would reach
bcm_sysport_netdevice_event()->bcm_sysport_unmap_queues(). That would do
this read-modify-write on a TDMA block whose clock is off. Before this
patch the notifier path only touched software state.

Would netif_running(dev) && netif_device_present(dev) be a tighter guard?

bcm_sysport_stop() already does umac/tdma MMIO in the same failed-resume
state, so these new accesses add only a little extra risk.

> +			reg &= ~(RING_QID_MASK |
> +				 RING_PORT_ID_MASK << RING_PORT_ID_SHIFT |
> +				 RING_IGNORE_STATUS);
> +			reg |= (qp & RING_QID_MASK);
> +			reg |= (port << RING_PORT_ID_SHIFT);

[Severity: Low]
qp is masked with RING_QID_MASK here, but port is not masked with
RING_PORT_ID_MASK. PORT_ID is a 3-bit field, and control bits sit
directly above it:

#define  RING_PORT_ID_SHIFT		3
#define  RING_PORT_ID_MASK		0x7
#define  RING_IGNORE_STATUS		(1 << 6)
#define  RING_FAILOVER_EN		(1 << 7)

Could a dp->index of 8 or higher spill into RING_IGNORE_STATUS and
RING_FAILOVER_EN?

This doesn't look reachable with bcm_sf2. Its user ports are 0-7, and the
CPU port (8) has no DSA user netdev, so dsa_user_dev_check() filters it
out. bcm_sysport_init_tx_ring() also already uses the same unmasked
encoding.

Would it still make sense to use (port & RING_PORT_ID_MASK) here, the
same way qp is masked?

> +			tdma_writel(priv, reg, TDMA_DESC_RING_MAPPING(q));
> +		}
>  		qp++;
>  	}

[ ... ]

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

[Severity: Medium]
Can RING_IGNORE_STATUS stay set on a ring that is later inspected again?

The new running path in bcm_sysport_map_queues() clears
RING_IGNORE_STATUS. The deferred path in bcm_sysport_init_tx_ring() does
not clear it in the inspect branch:

bcm_sysport_init_tx_ring() {
    ...
	reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(index));
	reg &= ~(RING_QID_MASK | RING_PORT_ID_MASK << RING_PORT_ID_SHIFT);
	if (ring->inspect) {
		reg |= ring->switch_queue & RING_QID_MASK;
		reg |= ring->switch_port << RING_PORT_ID_SHIFT;
	} else {
		reg |= RING_IGNORE_STATUS;
	}
	tdma_writel(priv, reg, TDMA_DESC_RING_MAPPING(index));
    ...
}

Neither bcm_sysport_stop() nor bcm_sysport_open() resets
TDMA_DESC_RING_MAPPING before this read-modify-write. Consider this
sequence:

1. Unbind the DSA switch while SYSTEMPORT is up. This new code sets
   RING_IGNORE_STATUS.
2. Bring the SYSTEMPORT interface down.
3. Rebind the switch. bcm_sysport_map_queues() sets ring->inspect = true
   but skips the hardware write because netif_running() is false.
4. Bring the interface up. bcm_sysport_init_tx_ring() writes QID and
   PORT_ID but keeps the old RING_IGNORE_STATUS bit.

The inspected ring would then ignore the switch port/queue status. That
seems to turn off the queue inspection flow control this mapping exists
for; RING_IGNORE_STATUS was introduced in commit 3ded76a8ff53 to stop
rings from inspecting switch queues. The same state can be reached by
opening with no switch attached, closing, attaching the switch, and
opening again.

So the final register value now depends on whether the switch was
attached before or after open. Should bcm_sysport_init_tx_ring() also
clear RING_IGNORE_STATUS in its inspect branch?

> +		}
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922232440.598918-1-florian.fainelli%40broadcom.com
