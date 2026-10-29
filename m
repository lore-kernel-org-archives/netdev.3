Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290522;
	b=XrLA5IRJjik27BLzh0RNHUvUMTgmL4cxu5DsPAzERZR8P5nVNJ+DsFXWLUQnhO3WLXfg
	 o/DmlIr/ZedV4h4KuAzoO2pKbfjWAjmxEebn7f0Slr5MzJKpm1d2xhZOXUBeHka9uYw7k
	 9wqz93HyEgmuEvReewMWoq4xz5LpgpSfo4bJsjDwT7gH5LnO3VmmC7smUX86MjfgTtL5/
	 4um5EEVLy+ceRcMHTOcE3+IE1nAe89wAdblnxPHg33u6om9Z0mzX2HOHLaboA1ov0Rdr8
	 hNN/HWf+/d+JahHnViBrqWiQZWiPCfVtgwT+1pqmhYYWFTMOuwKZa5MbQSwMecXiBdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290522;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TCFPyAapjLpHT+Pe4IQD4cHNg9VWjJyHc7rIiSCsk8g=;
	b=MH8gwl7RmiaYvx6uS2gSZ0NuJQq+HULDLJ+t2gDmxZh+GxqQv7cLjg+gQbnQHxu2LYq+
	 ALlNUKy6I5etrp7qZdwuaSw3oKaMHF19MQROBOItdyBHJr5yOsBtjtJMPHBkG+odfxl2I
	 1xq9leC6HpR0slkJBD377ywjJMwUSLKb4Cmy85lYO1zHzQ9K25hOnnv3xtu9ibSO0sQdy
	 OyC/sXZWrUA2ycoOuMHWWZvdiHnfD+Zt+FGlccsdAxgy3AexCUIttiyWWjMpNU/KrHIjc
	 O68D2B4wLS1sG8qvkc6vb8NJhlNuoOwTTzksMi1nR95I4eVjaQU24yM3IihUKulN2DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN3ePbyv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1760A262B;
	Thu, 29 Oct 2026 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN3ePbyv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8CE1F01825;
	Thu, 29 Oct 2026 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290522;
	bh=TCFPyAapjLpHT+Pe4IQD4cHNg9VWjJyHc7rIiSCsk8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AN3ePbyvd0PyRvFWhXKwuZ/tke7f6F4w9qodURwqazvndihFvBe6vx0BerKgV1v55
	 2ULj+HZQLNpG1SOMkT9Z4dMKL7jCeOHfe8mqwyqzKcJbmdTGU1ee0w+9lNSs0ZJLoV
	 bIHcVUjZMROU5+9dUp85UtbunacJINYxXWu/yCa39exkkhixc/IfTI9itBTYRQAtCA
	 uB1KfcxdZZ38KqLkt5K5IfRAXFAL86AWYs/GzrAdqeSJ6guURwHWkNAoKQXuITtPzJ
	 SnoQgt3YauUWiLZ3a4uL3tGi7BjRjWIm8f/b+9jwUi1lOWvfzsusCiwWDRtcmmG49H
	 RpiX8qjCljwaw==
Subject: Re: [PATCH net 10/11] net: au1000: keep the MAC stopped until the PHY
 link is ready
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, shaojijie@huawei.com, horms@kernel.org,
 runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org, jeff@garzik.org,
 danny.kukawka@bisect.de, mugunthanvnm@ti.com, sebastian.hesselbarth@gmail.com,
 linux-kernel@vger.kernel.org, manuel.lauss@gmail.com
Date: Thu, 29 Oct 2026 16:15:20 +0000
Message-ID: <179329052077.3134.10233975410162013013@kernel.org>
In-Reply-To: <20261027223140.3774570-11-f.fainelli@gmail.com>
References: <20261027223140.3774570-11-f.fainelli@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] au1000_open() now calls phy_start() before au1000_init().
- [Medium] Reopening the interface after a PHY status read that changed
  phydev->link and then failed can leave MAC RX/TX disabled for good…
- [Low] The new au1000_hard_stop() call in the link-down branch of
  au1000_adjust_link() runs inside spin_lock_irqsave(&aup->lock).

--

net: au1000: keep the MAC stopped until the PHY link is ready

The patch moves phy_start() ahead of au1000_init() in au1000_open(). It
also leaves MAC RX/TX disabled in au1000_init() while the PHY reports no
link, and stops the MAC in the link-down branch of au1000_adjust_link().
If au1000_init() fails, the PHY is now stopped.

> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
> index 8c2dbf72652e9..c616ce616541f 100644
> --- a/drivers/net/ethernet/amd/au1000_eth.c
> +++ b/drivers/net/ethernet/amd/au1000_eth.c
> @@ -458,7 +458,8 @@ au1000_adjust_link(struct net_device *dev)
>  		/* link state changed */
>  
>  		if (!phydev->link) {
> -			/* link went down */
> +			/* Stop the MAC before the PHY can remove its clocks. */
> +			au1000_hard_stop(dev);

[Severity: Low]

au1000_adjust_link() holds spin_lock_irqsave(&aup->lock) at this point,
and au1000_hard_stop() ends with:

	wmb(); /* drain writebuffer */
	mdelay(10);

So each link-down now busy-waits 10 ms with interrupts off.

On close, the sequence looks like this:

au1000_close()
  phy_stop()
    -> au1000_adjust_link() -> au1000_hard_stop()   /* 10 ms */
  spin_lock_irqsave(&aup->lock, flags)
  au1000_reset_mac_unlocked()
    au1000_hard_stop()                              /* 10 ms again */
    two mdelay(2) for the reset                     /* 4 ms */

That is roughly 24 ms per close with interrupts off. The duplex branch
already does something similar on link-up.

Is the second au1000_hard_stop() in au1000_reset_mac_unlocked() still
needed now that the link-down callback stops the MAC?

>  			aup->old_speed = 0;
>  			aup->old_duplex = -1;
>  		}

[ ... ]

> @@ -740,6 +741,10 @@ static int au1000_init(struct net_device *dev)
>  		control |= MAC_FULL_DUPLEX;
>  	}
>  
> +	/* The PHY may still be restoring its MII clocks after resume. */
> +	if (!dev->phydev || dev->phydev->link)
> +		control |= MAC_RX_ENABLE | MAC_TX_ENABLE;
> +

[Severity: Medium]

Can the MAC stay stopped after a reopen if old_link and old_duplex are
stale?

With this change, RX/TX get turned back on after open only through
au1000_adjust_link(). It calls au1000_enable_rx_tx() in just one place,
the duplex branch:

	if (phydev->link && (aup->old_duplex != phydev->duplex)) {
		...
		au1000_enable_rx_tx(dev);

Neither au1000_close() nor au1000_reset_mac_unlocked() resets old_link,
old_speed or old_duplex.

Here is one sequence that could leave them stale. Assume autoneg is
disabled and the link is up at 100/Full:

genphy_read_status()
  genphy_update_link()        /* BMSR says link down, phydev->link = 0 */
  genphy_read_status_fixed()  /* BMCR read fails with -ETIMEDOUT */
phy_check_link_status()
  returns the error before phy_link_down()

MDIO timeouts reach phylib since "net: au1000: report MDIO transaction
timeouts". The PHY_ERROR handling, and a later phy_stop() into
PHY_HALTED, call phy_link_down() only if phydev->link is still set.
au1000_adjust_link() therefore never sees the link drop, so old_link
stays 1 and old_duplex stays DUPLEX_FULL.

On the next open, au1000_init() leaves RX/TX disabled because
phydev->link is 0. When the link comes back at the same speed and
duplex, au1000_adjust_link() skips all three branches. The MAC stays
stopped while carrier is reported up.

Before this patch, au1000_init() always set MAC_RX_ENABLE |
MAC_TX_ENABLE, so this case recovered on reopen. Would resetting
old_link, old_speed and old_duplex in the open or close path avoid it?

>  	writel(control, &aup->mac->control);
>  	writel(0x8100, &aup->mac->vlan1_tag); /* activate vlan support */
>  	wmb(); /* drain writebuffer */
> @@ -928,16 +933,18 @@ static int au1000_open(struct net_device *dev)
>  		return retval;
>  	}
>  
> +	if (dev->phydev)
> +		phy_start(dev->phydev);
> +
>  	retval = au1000_init(dev);

[Severity: Medium]

Is it safe to start the PHY before the MAC is initialized?
Documentation/networking/phy.rst says:

  Lastly, once the controller is ready to handle network traffic, you call
  phy_start(phydev).

The commit message says "Start the PHY before initializing the MAC" but
doesn't explain why the order has to change.

phy_start() resumes the PHY over MDIO:

au1000_mdiobus_read() / au1000_mdiobus_write()
  au1000_enable_mac(dev, 0)

mac_enabled is 0 after probe or close, so this takes the MAC out of reset
before au1000_init() runs. That contradicts the comment above
au1000_init():

 * conserve power. Thus, whenever au1000_init() is called,
 * the device should already be in reset state.

phy_start() then queues the state machine with zero delay, and
au1000_init() does:

	/* bring the device out of reset */
	au1000_enable_mac(dev, 1);

With force_reset set, this holds the MAC block in reset for about 2 ms,
including mii_control and mii_data. It takes only aup->lock, not the
mii_bus lock. au1000_mdio_read() and au1000_mdio_write() program
mii_control, poll with mdelay(1) and read mii_data without any driver
lock.

Could that forced reset land in the middle of an MDIO transaction from
the phylib worker, for example on a preemptible UP kernel? A read could
then return a reset value, a BMCR or advertisement write could be lost,
or -ETIMEDOUT could put the PHY into PHY_ERROR.

If the worker runs first and already sees link up, au1000_adjust_link()
takes the duplex branch (old_duplex == -1) and calls
au1000_enable_rx_tx(). That happens before the MAC address and RX
descriptors are programmed. au1000_init() then force-resets a MAC with
RX/TX enabled.

There is also a problem with the new check in au1000_init(). It reads
phydev->link under aup->lock, while phylib updates it under
phydev->lock:

	if (!dev->phydev || dev->phydev->link)
		control |= MAC_RX_ENABLE | MAC_TX_ENABLE;

genphy_update_link() can set link to 1 for a moment and then clear it:

	phydev->link = status & BMSR_LSTATUS ? 1 : 0;
	...
	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
		phydev->link = 0;

If au1000_init() reads that brief 1, RX/TX get enabled. The link-down
callback never runs afterwards, because phydev->link still equals
old_link.

Wouldn't that leave the MAC running with no link, which is the state
this patch is meant to prevent?

>  	if (retval) {
>  		netdev_err(dev, "error in au1000_init\n");
> +		if (dev->phydev)
> +			phy_stop(dev->phydev);
>  		free_irq(dev->irq, dev);
>  		return retval;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027223140.3774570-1-f.fainelli%40gmail.com
