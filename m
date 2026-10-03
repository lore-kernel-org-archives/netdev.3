Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19E320CD1;
	Sat,  3 Oct 2026 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034567; cv=none; b=fV3I6ZVUcDtQYYzkb7JH+HclhLxP7S/cPH/bLjQn9WSs2Vs8UVHRE2xfzBP7m4a3BjNxApaSRD9WbR8I4ddNI0Z0CSQ6L3+s6Qweh6u7Oz/RhLyjHJT7VJmpKlX2ujUOesGrks2Vk58Ob+axqHY3GaI27qYCW1tvPF8f/H1ayXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034567; c=relaxed/simple;
	bh=9AnDKYXwr2pv+uCBK9IaEBRQ1WqP/CWZeMbcm3eNk+o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+YAd4wm9hGBN7mAZXcP+pKQD8ZpGtJIPnOLTBf6+DFZVV45swMSrFZqfNh5qZE/BPOaHPuvAEpurwfmFiB5M9TPnf49kujswscMZ7v7Lc4+fNT8YY0d3qm4JPb0l/AiUh+epJSDxqvBhQi4rAqgfEucBKfQl/fpjtW2uy8eU2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLL3LDjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLL3LDjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FCF1F0089D;
	Sat,  3 Oct 2026 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791034564;
	bh=aBdC7E9rJbZ13AuNxkOnG0VxqbxCL/7cA3wYmmzyfGk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OLL3LDjOoqANZok9rpTJjcot2EfeEFT3q0FOJYXkTh2Bx8uInGGvwlX+etSr/69Bd
	 PKY6STbNeJlJF/u6ciVSlCLVBjPdphCpCjjl6r3TM3YnuX8+SQBowb+/K701p4NEvq
	 Evnlj3eJMMal+iKMEsumOTNFkMjvbjdvuuPhCuMd+y5JWU10BEPcnoKZ+fVG0qxMMy
	 uvpXjIsF/G4SMA0Tw5Y9gz8GVTlQT3CJ4dk+1ivNiXJ27UBlA13YRzkaX3qcXbic8/
	 olUb2vEmVWkzn+gKIGmO6pUMshC25f6h3mpC6jfoDIEjmGMIgULzA80lCGAuaB3Gc3
	 g0/fxvI+aX8WA==
Subject: Re: [PATCH net-next v4 2/4] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Sat, 03 Oct 2026 13:36:03 +0000
Message-ID: <179103456304.434549.18224886836207577425@kernel.org>
In-Reply-To: <20260929125928.611784-3-parthiban.veerasooran@microchip.com>
References: <20260929125928.611784-3-parthiban.veerasooran@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] oa_tc6_phy_exit() now calls
  cancel_work_sync(&tc6->phy_irq_work) for every device that does not…
- [Medium] In oa_tc6_process_extended_status(), the hot path sets
  INT_MASK0 bit 7 in hardware (oa_tc6_phy_irq_mask_hw()) and leaves…
- [Medium] oa_tc6_phy_irq_setup() sets tc6->phy_irq_masked = true only
  after irq_create_mapping() returns.
- [Low] No MAC driver sets the new OA_TC6_PHY_INT quirk in this commit.
- [Low] oa_tc6_disable_traffic() writes INT_MASK0 =
  OA_TC6_INT_MASK0_ALL_INTERRUPTS as a "point of no return" and now…
- [Low] In oa_tc6_process_extended_status(), oa_tc6_phy_irq_mask_hw() is
  called every time STATUS0 shows PHY_INT, even when INT_MASK0 bit 7 has…

--

net: ethernet: oa_tc6: deliver the PHY interrupt to phylib

This commit adds an OA_TC6_PHY_INT quirk. When the quirk is set, the
in-band PHY interrupt signalled through STATUS0 is passed to phylib as a
nested virtual IRQ. The PHYINT mask bit in INT_MASK0 is driven over SPI by
a custom irq_chip using bus_lock/bus_sync_unlock, and the dispatch from
oa_tc6_process_extended_status() is deferred to a workqueue.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 364027c39fa4a..74fe65b76359e 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c

[ ... ]

> +static void oa_tc6_phy_irq_work(struct work_struct *work)
> +{
> +	struct oa_tc6 *tc6 = container_of(work, struct oa_tc6, phy_irq_work);
> +	int ret;
> +
> +	/* Dispatched off the SPI chunk-processing thread so that
> +	 * phy_interrupt() taking phydev->lock and issuing synchronous SPI
> +	 * control transfers from PHY handle_interrupt() cannot stall the single
> +	 * thread pumping TX/RX data chunks.
> +	 */
> +	handle_nested_irq(tc6->phy_virq);
> +
> +	ret = oa_tc6_phy_irq_unmask_hw(tc6);
> +	if (ret)
> +		dev_err(&tc6->spi->dev, "Failed to unmask PHY interrupt: %d\n",
> +			ret);
> +}

[Severity: Medium]
What re-arms PHYINT if oa_tc6_phy_irq_unmask_hw() fails here?

The hot path in oa_tc6_process_extended_status() sets INT_MASK0 bit 7 in
hardware through oa_tc6_phy_irq_mask_hw() and leaves phy_irq_masked false.
This worker is the only place that clears the bit again.

If the INT_MASK0 read or write in oa_tc6_phy_irq_unmask_hw() fails (a
spi_sync error, or -EPROTO from oa_tc6_check_ctrl_read_reply() or
oa_tc6_check_ctrl_write_reply()), we only get the dev_err(). The MAC-PHY
then keeps PHYINT masked, while genirq and phylib still consider the IRQ
enabled.

Nothing retries. genirq has no pending mask change to sync, and phylib
does not poll a PHY that is in interrupt mode. Later link and PLCA status
changes would then be lost until some unrelated extended-status event, or
a disable_irq()/enable_irq() cycle, re-syncs the bit.

The mask side can end up in the same state. If the device applies the
INT_MASK0 write but the echoed reply fails validation,
oa_tc6_process_extended_status() logs an error and skips schedule_work().
Hardware stays masked and no worker is queued.

[ ... ]

> +static int oa_tc6_phy_irq_setup(struct oa_tc6 *tc6)
> +{
> +	INIT_WORK(&tc6->phy_irq_work, oa_tc6_phy_irq_work);
> +
> +	tc6->phy_irq_domain =
> +		irq_domain_create_linear(NULL, 1,
> +					 &oa_tc6_phy_irq_domain_ops, tc6);
> +	if (!tc6->phy_irq_domain)
> +		return -ENOMEM;
> +
> +	tc6->phy_virq = irq_create_mapping(tc6->phy_irq_domain, 0);
> +	WRITE_ONCE(tc6->phy_irq_masked, true);

[Severity: Medium]
Is phy_irq_masked set too late here?

irq_create_mapping() calls into the .map callback, and
irq_set_chip_and_handler() takes the chip bus lock in __irq_set_handler():

irq_create_mapping()
  oa_tc6_phy_irq_map()
    irq_set_chip_and_handler()
      irq_set_chip()           /* installs oa_tc6_phy_irq_chip */
      __irq_set_handler()
        scoped_irqdesc_get_and_buslock(irq, 0)
          oa_tc6_phy_irq_bus_lock()
          oa_tc6_phy_irq_bus_sync_unlock()

At that point phy_irq_masked is still false from devm_kzalloc(), so
oa_tc6_phy_irq_bus_sync_unlock() takes this branch:

	else
		regval &= ~OA_TC6_INT_MASK0_PHY_INT_MASK;

It then writes INT_MASK0 over SPI, unmasking PHYINT in the MAC-PHY before
phylib has requested the IRQ. Only after that is the shadow set to
masked.

That seems to contradict this part of the commit message:

    The interrupt starts masked (hardware reset default) and is only
    unmasked when phylib requests it

If phylib never requests the IRQ (for example, the PHY driver has no
interrupt support and phy_probe() falls back to PHY_POLL), hardware PHYINT
stays unmasked while the shadow says masked. The same happens if
mdiobus_register() fails and the mapping is disposed.

Would setting phy_irq_masked to true before irq_create_mapping() avoid
this?

> +	if (!tc6->phy_virq) {
> +		irq_domain_remove(tc6->phy_irq_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -624,6 +821,7 @@ static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
>  	if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
>  		return;
>  
> +	cancel_work_sync(&tc6->phy_irq_work);

[Severity: Medium]
Can this hit the WARN_ON(!work->func) in __flush_work()?

phy_irq_work is only initialized by the INIT_WORK() in
oa_tc6_phy_irq_setup(). oa_tc6_mdiobus_register() only calls that when
OA_TC6_PHY_INT is set, and tc6 comes from devm_kzalloc().

At this commit, lan865x_probe() does:

	priv->tc6 = oa_tc6_init(spi, netdev, NULL);

so quirk_flags is 0. Removal then goes through:

oa_tc6_exit()
  oa_tc6_phy_exit()
    cancel_work_sync()
      __cancel_work_sync()
        __flush_work()
          if (WARN_ON(!work->func))

with a zeroed work_struct.

That looks reachable on every lan865x remove or unbind. It also looks
reachable on the error paths that call oa_tc6_phy_exit(), both in
oa_tc6_init() and on lan865x probe failure after oa_tc6_init().

The follow-up patch "microchip: lan865x: enable PHY interrupt via virtual
IRQ" sets OA_TC6_PHY_INT for lan865x. The library would still warn for any
user that passes NULL or zero quirks, though, and this commit on its own
breaks bisection for lan865x.

Could INIT_WORK() move to oa_tc6_init() unconditionally? Alternatively,
cancel_work_sync() could be gated on OA_TC6_PHY_INT or tc6->phy_virq.

>  	phy_disconnect(tc6->phydev);
>  	oa_tc6_mdiobus_unregister(tc6);
>  }
> @@ -780,7 +978,12 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
>  	netif_tx_disable(tc6->netdev);
>  	oa_tc6_drop_tx_skb(tc6, skb);
>  	oa_tc6_free_ongoing_skbs(tc6);
> +	/* Serialize INT_MASK0 write with phylib's mask/unmask to prevent
> +	 * read-modify-write races in oa_tc6_phy_irq_bus_sync_unlock().
> +	 */
> +	mutex_lock(&tc6->phy_irq_lock);
>  	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
> +	mutex_unlock(&tc6->phy_irq_lock);

[Severity: Low]
Does this lock keep PHYINT masked after the point of no return?

The mutex serializes this single write. However, phy_irq_work is not
cancelled, phy_irq_masked is not updated, and later read-modify-writes are
not blocked.

In oa_tc6_process_extended_status(), the PHY_INT dispatch runs before the
TX protocol, loss of frame and header error checks that return -ENODEV. A
single STATUS0 value carrying PHY_INT plus one of those error bits will
queue the work. It then leads oa_tc6_macphy_threaded_irq() into
disable_irq_nosync() and oa_tc6_disable_traffic(). Any SPI failure while
the work is already pending gets to the same place.

The work can then run concurrently, or after this write:

oa_tc6_phy_irq_work()
  handle_nested_irq()          /* PHY driver SPI control transfers */
  oa_tc6_phy_irq_unmask_hw()
    phy_irq_masked is false, INT_MASK0 reads back all-masked
    regval &= ~OA_TC6_INT_MASK0_PHY_INT_MASK;
    oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);

This unmasks PHYINT again and keeps issuing PHY control transfers on a
device that has been shut down. Neither oa_tc6_phy_irq_unmask_hw() nor
oa_tc6_phy_irq_bus_sync_unlock() checks tc6->disable_traffic.

The host IRQ is already disabled by disable_irq_nosync(), so there is no
host interrupt storm. Should the PHY work still be stopped here, or should
the unmask paths check tc6->disable_traffic?

>  	oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
>  	oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
>  	dev_err(&tc6->spi->dev, "Device interrupt disabled to avoid interrupt storm");
> @@ -813,6 +1016,29 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
>  		return ret;
>  	}
>  
> +	/* Dispatch the PHY interrupt to phylib via the nested virtual IRQ so

[ ... ]

> +	 * Gate on phy_virq (the actual resource) rather than just the flag to
> +	 * be self-consistent if OA_TC6_BROKEN_PHY skips initialization.
> +	 */
> +	if (tc6->phy_virq && FIELD_GET(OA_TC6_STATUS0_PHY_INT, value)) {
> +		ret = oa_tc6_phy_irq_mask_hw(tc6);

[Severity: Low]
Does this repeat a full INT_MASK0 read-modify-write for every chunk footer
while PHYINT is still asserted?

According to the commit message, PHYINT is level triggered and stays
asserted until the worker services the PHY. So the STATUS0 write-back does
not clear it, and the "if (!value) return 0;" shortcut never fires.

Footers are processed after the whole data transaction completes. Every
EXST footer captured after the PHY event therefore costs a STATUS0 read, a
STATUS0 write, and the two INT_MASK0 transfers in oa_tc6_phy_irq_mask_hw(),
even though bit 7 is already set. It also costs a no-op schedule_work().

The same redundant read-modify-write happens when an unrelated
extended-status event arrives while PHYINT is already masked. That seems
to work against the goal of not stalling the thread that pumps TX/RX
chunks.

Would it make sense to skip the mask while a PHY dispatch is already
pending?

> +		if (ret)
> +			dev_err(&tc6->spi->dev,
> +				"Failed to mask PHY interrupt: %d\n", ret);
> +		else
> +			schedule_work(&tc6->phy_irq_work);
> +	}

[ ... ]

> diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
> index 27f652d4920b2..1c8cc263c5e53 100644
> --- a/include/linux/oa_tc6.h
> +++ b/include/linux/oa_tc6.h

[ ... ]

> @@ -68,6 +70,7 @@ struct oa_tc6;
>  
>  enum oa_tc6_quirk_flag {
>  	OA_TC6_BROKEN_PHY = BIT(0),
> +	OA_TC6_PHY_INT    = BIT(1),
>  };

[Severity: Low]
This isn't a bug, but no in-tree MAC driver sets OA_TC6_PHY_INT in this
commit. lan865x passes NULL quirks and adin1140 passes OA_TC6_BROKEN_PHY,
so the new irq_chip, irq_domain and workqueue path is unused at this point
in the series.

The next patch, "microchip: lan865x: enable PHY interrupt via virtual
IRQ", sets tc6_quirks.quirk_flags = OA_TC6_PHY_INT in lan865x_probe(). It
also carries the Fixes: 78341049fbcd tag and names this commit as its
prerequisite. So within the series this looks like the usual
infrastructure-then-user split.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929125928.611784-1-parthiban.veerasooran%40microchip.com
