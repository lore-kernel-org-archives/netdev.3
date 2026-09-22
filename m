Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124F3EFD21;
	Tue, 22 Sep 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089713; cv=none; b=UJRFTaPKwHRD5a0eU33VhV0J1L+Khm4ablJ9+J67qccwyIytEzmKmq2kSBS6Lvk96+4vq4N/bK7U/qBq/v7FEe97wF+sHxOck9cLeO8s6ivCuDjhU5QsTNG4RMqTuWoHAqx+RNlxcLmocVSIqzVp1alRy5ZQw3ejlXGBzlu+Gts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089713; c=relaxed/simple;
	bh=nchtHe4d7HmDygvI4Xex8GatmKT+kAesYgDQzriydf4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lUUn3yjKuVA7dutlw9J/g46BzM67o0SLD/VS57bGxBTTZPvWvm0gjHohR7Cpuv3WeW/1SlRMD43tndckmxu5jVCJrhX7lAePN+5cEivlUYTMYoqeEs6O00l0b9naRcdL5hW/NX/nnfAXJvlZfJBGdeR0HntspUjCWDAbhmoCuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2UpBKKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2UpBKKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E4F1F00893;
	Tue, 22 Sep 2026 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089708;
	bh=IWWxma7+hMTO9D2YrvvtrZ4+kP+D806woZj8Z6YEucQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H2UpBKKsQTjNfi4Wx2XShk4wha1iZ3af3w5asJ6Ctu2KUdbMTQt4adciy1leIGzwF
	 B5wwGjTceH0jHJnJsFmiWXrPDEJ6S1/m3DyVU64GDUFHvAwUoWB2kPtjotbCTjgqH9
	 BkGuRvhlwZye9fqTV1+15fZQKZDIwezh3ouLtqM2jPlIm9AtTIkTayhvYCNhi9W7UM
	 WLNRzJwuYeM/OT9BmTlJc7P39B5q7nX3kTxO6XbF4Q7hcPNfPCQ1hOJXtSJuotqbIl
	 UmIKerdYa8zJ3ciioIId2EGoSIaTb8phvYBUET8cspBs8Dtr+6ZxJfr7ZRPsKqfGSj
	 oCdXtYfDCzu2g==
Subject: Re: [PATCH net-next v3 2/4] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Tue, 22 Sep 2026 15:08:27 +0000
Message-ID: <179008970729.2160803.16190666389473785608@kernel.org>
In-Reply-To: <20260918143302.76909-3-parthiban.veerasooran@microchip.com>
References: <20260918143302.76909-3-parthiban.veerasooran@microchip.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new irq_chip (drivers/net/ethernet/oa_tc6.c:596-602)
  provides only .irq_mask/.irq_unmask (shadow flag flushed from…
- [Medium] In oa_tc6_process_extended_status()
  (drivers/net/ethernet/oa_tc6.c:953-955) the driver only calls…
- [Low] Concern that OA_TC6_PHY_INT and all code it gates is dead in-tree
  because no oa_tc6 consumer sets the flag.
- [Low] Inconsistent quirk gating: oa_tc6_process_extended_status()
  (oa_tc6.c:953) schedules tc6->phy_irq_work based only on…
- [Low] Concern that oa_tc6_phy_irq_bus_sync_unlock() (oa_tc6.c:571-594)
  only logs a failed INT_MASK0 read or write, leaving the hardware mask…
- [Low] oa_tc6_phy_irq_bus_sync_unlock()
  (drivers/net/ethernet/oa_tc6.c:571-594) performs a read-modify-write…

--

net: ethernet: oa_tc6: deliver the PHY interrupt to phylib

This adds a nested virtual IRQ plus a custom irq_chip to oa_tc6 so an
in-band MAC-PHY PHY interrupt can be delivered to phylib, gated by a new
OA_TC6_PHY_INT quirk flag.  Dispatch of the nested IRQ is deferred to a
work item, and the mask bit is pushed to INT_MASK0 from
irq_bus_sync_unlock().

A few questions below about the mask handling and the dispatch gating.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 6fcc5f561d56..b4a95155e924 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c

[ ... ]

> @@ -528,6 +535,114 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
>  }
>  EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
>  
> +static void oa_tc6_phy_irq_work(struct work_struct *work)
> +{
> +	struct oa_tc6 *tc6 = container_of(work, struct oa_tc6, phy_irq_work);
> +
> +	/* Dispatched off the SPI chunk-processing thread so that
> +	 * phy_interrupt() taking phydev->lock and issuing synchronous SPI
> +	 * control transfers from PHY handle_interrupt() cannot stall the single
> +	 * thread pumping TX/RX data chunks.
> +	 */
> +	handle_nested_irq(tc6->phy_virq);
> +}
> +

[ ... ]

> +static void oa_tc6_phy_irq_bus_sync_unlock(struct irq_data *irqd)
> +{
> +	struct oa_tc6 *tc6 = irq_data_get_irq_chip_data(irqd);
> +	u32 regval;
> +	int ret;
> +
> +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "Failed to read INT_MASK0: %d\n", ret);
> +		goto unlock;
> +	}
> +
> +	if (tc6->phy_irq_masked)
> +		regval |= OA_TC6_INT_MASK0_PHY_INT_MASK;
> +	else
> +		regval &= ~OA_TC6_INT_MASK0_PHY_INT_MASK;
> +
> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
> +	if (ret)
> +		dev_err(&tc6->spi->dev, "Failed to write INT_MASK0: %d\n", ret);
> +
> +unlock:
> +	mutex_unlock(&tc6->phy_irq_lock);
> +}

[Severity: Low]
This read-modify-write of INT_MASK0 is serialised by the new
tc6->phy_irq_lock, but is that lock taken by the other writer of the same
register?

oa_tc6_disable_traffic() writes INT_MASK0 from the threaded IRQ context
without phy_irq_lock:

	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);

tc6->spi_ctrl_lock only makes each individual control transfer atomic, not
the read/modify/write pair here, so can this sequence lose an update?

CPU0 (oa_tc6_macphy_threaded_irq -> oa_tc6_disable_traffic)
	writes INT_MASK0 = OA_TC6_INT_MASK0_ALL_INTERRUPTS

CPU1 (phylib mask/unmask -> oa_tc6_phy_irq_bus_sync_unlock)
	read INT_MASK0   (stale copy, taken before CPU0's write)
	write INT_MASK0  (reverts the error-interrupt masking)

The reverse order would clobber the PHY_INT mask bit phylib just asked
for.  The practical effect looks small since
oa_tc6_macphy_threaded_irq() calls disable_irq_nosync(tc6->spi->irq)
before oa_tc6_disable_traffic(), but should all INT_MASK0 modifiers share
one lock or a lock-protected shadow value?

[Severity: Low]
This isn't a bug, but both error paths here only log and return, so
tc6->phy_irq_masked (and phylib's view of the line) can stay permanently
out of sync with the hardware mask bit, with no retry.  The same
log-and-continue shape is used by regmap_irq_sync_unlock() in
drivers/base/regmap/regmap-irq.c, since the genirq callback returns void
and has nowhere to propagate an error, and a failing oa_tc6 control
transfer already means the SPI link to the MAC-PHY is broken.  Is it worth
noting in a comment that a failed sync leaves the mask bit undefined?

> +
> +static struct irq_chip oa_tc6_phy_irq_chip = {
> +	.name                   = "oa_tc6_phy",
> +	.irq_mask               = oa_tc6_phy_irq_mask,
> +	.irq_unmask             = oa_tc6_phy_irq_unmask,
> +	.irq_bus_lock           = oa_tc6_phy_irq_bus_lock,
> +	.irq_bus_sync_unlock    = oa_tc6_phy_irq_bus_sync_unlock,
> +};
> +
> +static int oa_tc6_phy_irq_map(struct irq_domain *domain, unsigned int irq,
> +			      irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_chip_and_handler(irq, &oa_tc6_phy_irq_chip, handle_simple_irq);
> +	irq_set_nested_thread(irq, true);
> +	irq_set_noprobe(irq);
> +
> +	return 0;
> +}

[Severity: High]
The commit message says:

    "The interrupt starts masked (hardware reset default) and is only
    unmasked when phylib requests it, so disabling the nested IRQ actually
    masks the hardware source too, preventing interrupt storms."

Is that true for this chip?  There is no .irq_disable callback and
oa_tc6_phy_irq_map() does not set IRQ_DISABLE_UNLAZY, so
disable_irq()/disable_irq_nosync() takes the lazy path in kernel/irq/chip.c:

	irq_state_set_disabled(desc);
	if (desc->irq_data.chip->irq_disable) {
		desc->irq_data.chip->irq_disable(&desc->irq_data);
		irq_state_set_masked(desc);
	} else if (mask) {
		mask_irq(desc);
	}

With no .irq_disable and mask == false, OA_TC6_INT_MASK0_PHY_INT_MASK is
never written, so the in-band source stays armed.

The usual lazy-disable safety net, where the flow handler masks the line on
the next occurrence, does not apply to nested IRQs.  handle_nested_irq()
goes through irq_can_handle_actions():

	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
		desc->istate |= IRQS_PENDING;
		return false;
	}

so phy_interrupt() is never called and nothing masks the line.

Can this then be reached from phylib itself?  phy_interrupt() in
drivers/net/phy/phy.c does:

		phydev->irq_rerun = 1;
		disable_irq_nosync(irq);
		return IRQ_HANDLED;

i.e. the virq is disabled from inside the nested handler without the PHY
status being read or acked, and it is only re-enabled later in
mdio_bus_phy_resume():

		if (phydev->irq_rerun) {
			phydev->irq_rerun = 0;
			enable_irq(phydev->irq);

In that window PHYINT is unmasked in INT_MASK0 and unacknowledged, so the
MAC-PHY keeps IRQn asserted and oa_tc6_macphy_isr() ->
oa_tc6_macphy_threaded_irq() -> oa_tc6_process_extended_status() keeps
looping with an empty-chunk transfer plus a STATUS0 read/write and a no-op
schedule_work() each round, with nothing able to clear the condition.

Would adding an .irq_disable callback, or
irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY) in oa_tc6_phy_irq_map(),
make a disabled virq really mask the in-band source as the commit message
describes?

[ ... ]

> @@ -810,6 +943,17 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
>  		return ret;
>  	}
>  
> +	/* Dispatch the PHY interrupt to phylib via the nested virtual IRQ so
> +	 * the PHY driver reads and acknowledges its status. This is deferred
> +	 * to a workqueue rather than dispatched synchronously here, since
> +	 * phy_interrupt() takes phydev->lock and PHY handle_interrupt() issues
> +	 * synchronous SPI control transfers, which would otherwise block this
> +	 * thread.
> +	 */
> +	if ((tc6->quirk_flags & OA_TC6_PHY_INT) &&
> +	    FIELD_GET(OA_TC6_STATUS0_PHY_INT, value))
> +		schedule_work(&tc6->phy_irq_work);
> +

[Severity: Medium]
Should OA_TC6_INT_MASK0_PHY_INT_MASK be set here for the duration of the
deferral?

As the commit message notes, PHYINT "stays asserted until acked", and the
ack only happens later in oa_tc6_phy_irq_work() -> handle_nested_irq() ->
phy_interrupt() -> drv->handle_interrupt().  Until the worker runs, STATUS0
keeps bit 7 set, so the existing per-chunk short-circuit earlier in this
function:

	if (!value)
		return 0;

never fires, and every RX chunk footer carrying EXT_STS pays an extra
STATUS0 read plus STATUS0 write control transfer on the single SPI
chunk-processing thread.

Also, the MAC-PHY IRQ is requested with IRQF_TRIGGER_LOW | IRQF_ONESHOT in
oa_tc6_init(), so does the still-asserted line re-trigger the hard ISR as
soon as the threaded handler returns, adding another empty-chunk transfer
per round until the work item is scheduled?  The irq thread runs at
realtime priority while the ack worker runs on system_percpu_wq at normal
priority, so that window is under the worker's scheduling latency.  The
mask bit and the shadow/bus_lock machinery added by this patch already give
a way to quiesce the source while the ack is deferred.

[Severity: Low]
This dispatch is gated on OA_TC6_PHY_INT alone, while the only initializer
of tc6->phy_irq_work and tc6->phy_virq, oa_tc6_phy_irq_setup() called from
oa_tc6_mdiobus_register(), is skipped when OA_TC6_BROKEN_PHY is set:

oa_tc6_phy_init()
	if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
		return 0;

For a consumer passing OA_TC6_BROKEN_PHY | OA_TC6_PHY_INT, would this
schedule_work() then run on a devm_kzalloc()-zeroed work_struct that never
saw INIT_WORK(), and would the worker call handle_nested_irq(0)?  No
in-tree caller combines the two flags today, so this is not reachable as
things stand, but the flags are independent bits in an exported enum in
include/linux/oa_tc6.h.  Would gating the dispatch on the resource actually
created, for example a non-zero tc6->phy_virq, make the lifecycle
self-consistent?

>  	if (FIELD_GET(OA_TC6_STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
>  		oa_tc6_look_for_new_frame(tc6);
>  		net_err_ratelimited("%s: Receive buffer overflow error\n",

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918143302.76909-1-parthiban.veerasooran%40microchip.com
