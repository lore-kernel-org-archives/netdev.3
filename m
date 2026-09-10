Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38036194C;
	Thu, 10 Sep 2026 05:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017674; cv=none; b=CODACTaPrFumAsLkCQD40gwLi2SbA9ybRuxyJX81N2wISgZngwpIoNb0Mqbdd7oBq2hjjCn97T/S3tKbumECAwek5AvZcOD+gM7awewvw+2RIN6i18216zulcnTkvW+4ovTFsbdFaj7bV0UwGU15aJMPoN+gzmSGIHRB7I6X9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017674; c=relaxed/simple;
	bh=v/QstYm3i2rgnZLYs1v96MWHLqKGiHy8kb6V4Gnfytc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7jIg/8qwn+6ZHGMdFDfXbdK+U3jO9DzYL+/Qn8OYViZmlUv/IzIG9EjFXTM1LKqx9HaGuujmiACCB9rxcit3bpBaClQi5gangamqMznH+5u3gWcTsh+3RIN/EcPnO8DZAxODQerjdEcOpG+Bw2uDIPv1o8wRsn7oyQdx7Zzl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS8j8sGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS8j8sGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07441F00893;
	Thu, 10 Sep 2026 05:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017672;
	bh=cdMoUQ8ORrxIIRtrlFXwK9p+foa2zwlewAJA91TDSZ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oS8j8sGeI4xieaMAb46xG6IpEYWE/+tqbQreKEB/qTIA6dUNnwYhPx8jAQXGhHE9N
	 EC1/Y8D0LdII8ckG1I/bml997kTrtsoP2tuC2yGNdUK6ix5BqXfU4Rw1Op8UFhnceM
	 sr7uvUsG4t3Gc2ZkmzoY2TlhPFInehkgimlh3hrz/YZpeqwG4k5a+R0pKQZRV0EGDY
	 FqfJniDVmCm8xcUEi9SB6W6M/opgyiMghULEuwmS18KBeu9+vBeybb5ptMIb0pXXIW
	 euyqpwxPGBHYLKqsaFaO5uPxPmDOu43/aZ+TNMQh/Xcc7EERSBgdApSzuWqp+RmVfc
	 tdcfse3gQYNuw==
Subject: Re: [PATCH net-next v2 2/4] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Thu, 10 Sep 2026 05:21:11 +0000
Message-ID: <178901767130.219967.4729766971337827606@kernel.org>
In-Reply-To: <20260907052007.391972-3-parthiban.veerasooran@microchip.com>
References: <20260907052007.391972-3-parthiban.veerasooran@microchip.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 0 · Low: 2

- [High] oa_tc6_unmask_interrupts() clears OA_TC6_INT_MASK0_PHY_INT_MASK
  unconditionally for every MAC-PHY, while the only code that can make…
- [High] Use of `dummy_irq_chip` for the nested PHY interrupt creates an
  unrecoverable interrupt storm (DoS) condition if the generic IRQ…
- [Low] The new code in oa_tc6_phy_irq_setup()/oa_tc6_phy_irq_teardown()
  calls irq_domain_create_linear(), irq_create_mapping() and…
- [Low] Concern (baseline verdict: false positive) that the
  OA_TC6_PHY_INT infrastructure has no in-tree producer, making the irq…

--

net: ethernet: oa_tc6: deliver the PHY interrupt to phylib

This adds an OA_TC6_PHY_INT quirk flag so MAC drivers can opt in when the
PHY interrupt is delivered in-band through the MAC-PHY SPI status register.
When the flag is set, a one-entry irq domain with a nested virtual IRQ is
created before mdiobus_register(), all mii_bus->irq[] entries are populated
with that virq, and PHYINT seen in the extended status is dispatched with
handle_nested_irq() from the threaded IRQ.

A few questions below.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 6fcc5f561d560..00b0176c1fe7a 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -8,6 +8,8 @@
>  #include <linux/bitfield.h>
>  #include <linux/iopoll.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
>  #include <linux/oa_tc6.h>

[ ... ]

> @@ -528,6 +532,44 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
>  }
>  EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
>  
> +static int oa_tc6_phy_irq_map(struct irq_domain *domain, unsigned int irq,
> +			      irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_nested_thread(irq, true);
> +	irq_set_noprobe(irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops oa_tc6_phy_irq_domain_ops = {
> +	.map = oa_tc6_phy_irq_map,
> +};
> +
> +static int oa_tc6_phy_irq_setup(struct oa_tc6 *tc6)
> +{
> +	tc6->phy_irq_domain =
> +		irq_domain_create_linear(NULL, 1,
> +					 &oa_tc6_phy_irq_domain_ops, tc6);
> +	if (!tc6->phy_irq_domain)
> +		return -ENOMEM;
> +
> +	tc6->phy_virq = irq_create_mapping(tc6->phy_irq_domain, 0);
> +	if (!tc6->phy_virq) {
> +		irq_domain_remove(tc6->phy_irq_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void oa_tc6_phy_irq_teardown(struct oa_tc6 *tc6)
> +{
> +	irq_dispose_mapping(tc6->phy_virq);
> +	irq_domain_remove(tc6->phy_irq_domain);
> +}

[Severity: High]
Is dummy_irq_chip the right irqchip for a level-triggered, in-band
source that only stops asserting once the PHY is acked?

dummy_irq_chip (kernel/irq/dummychip.c) implements .irq_mask and
.irq_unmask as no-ops, so nothing the generic IRQ core does to this
virq can ever reach OA_TC6_INT_MASK0_PHY_INT_MASK in the MAC-PHY.
That matters because the core does try to mask this virq on its own:
handle_nested_irq() calls note_interrupt() for each dispatch (unless
irq_settings_no_debug()), and the spurious-IRQ accounting there will
eventually call __report_bad_irq() and disable the interrupt if the
PHY handler keeps returning IRQ_NONE. Note that oa_tc6_phy_irq_map()
sets IRQ_NOPROBE via irq_set_noprobe(), which is not IRQ_NO_DEBUG, so
that accounting does apply here - is that intended?

Once the core has disabled the virq, mask_irq() lands in the dummy
chip and does nothing, but the next PHYINT still reaches
oa_tc6_process_extended_status(), where handle_nested_irq() bails out
early in irq_can_handle_actions() without running phy_interrupt().
The PHY status registers are then never read, the level-triggered
source stays asserted, and with IRQF_TRIGGER_LOW | IRQF_ONESHOT the
SPI IRQ re-fires as soon as oa_tc6_macphy_threaded_irq() returns -
with no path left to re-mask PHYINT in hardware. Same reasoning
applies to any other caller that disables the virq, e.g. the
disable_irq_nosync() in phy_interrupt().

Would a small real irq_chip with .irq_mask / .irq_unmask that clear
and set OA_TC6_INT_MASK0_PHY_INT_MASK be preferable here? Since the
register access is over SPI and sleeps, that presumably needs
.irq_bus_lock / .irq_bus_sync_unlock to defer the actual transfer,
which is the usual pattern for nested SPI/I2C irqchips. If you would
rather keep the dummy chip, how is the disabled-virq case supposed to
be recovered, and should the IRQ_NONE return from handle_nested_irq()
be acted on instead of dropped?

[Severity: Low]
Does oa_tc6 need "select IRQ_DOMAIN" now?

irq_domain_create_linear(), irq_create_mapping() and irq_domain_remove()
are all declared inside the "#ifdef CONFIG_IRQ_DOMAIN" block of
include/linux/irqdomain.h.  The !CONFIG_IRQ_DOMAIN branch only provides
stubs for irq_dispose_mapping() and irq_find_matching_fwnode(), so
oa_tc6_phy_irq_setup() and oa_tc6_phy_irq_teardown() would hit
implicit-function-declaration errors there.

The OA_TC6 entry in drivers/net/ethernet/Kconfig currently has:

config OA_TC6
	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
	depends on SPI
	select PHYLIB

That allows CONFIG_SPI=y with CONFIG_IRQ_DOMAIN=n (m68k/ColdFire has SPI
and never selects IRQ_DOMAIN).  drivers/net/dsa/mv88e6xxx/Kconfig and
drivers/net/dsa/realtek/Kconfig add "select IRQ_DOMAIN" for the same
reason.

> @@ -661,7 +721,7 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
>  	return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
>  }
>  
> -static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
> +static int oa_tc6_unmask_interrupts(struct oa_tc6 *tc6)
>  {
>  	u32 regval;
>  	int ret;
> @@ -670,7 +730,8 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
>  	if (ret)
>  		return ret;
>  
> -	regval &= ~(OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK |
> +	regval &= ~(OA_TC6_INT_MASK0_PHY_INT_MASK |
> +		    OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK |
>  		    OA_TC6_INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
>  		    OA_TC6_INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
>  		    OA_TC6_INT_MASK0_HEADER_ERR_MASK);

[Severity: High]
Should the PHYINT unmask be gated on OA_TC6_PHY_INT the same way the
service path is?

oa_tc6_unmask_interrupts() clears OA_TC6_INT_MASK0_PHY_INT_MASK for every
MAC-PHY, but the only code that can make the level-triggered source drop is
quirk-gated in oa_tc6_process_extended_status():

	if ((tc6->quirk_flags & OA_TC6_PHY_INT) &&
	    FIELD_GET(OA_TC6_STATUS0_PHY_INT, value))
		handle_nested_irq(tc6->phy_virq);

As the commit message says, PHYINT is level triggered and only drops when
the PHY source is acked, so the STATUS0 write-back just above does not
clear it.

For a driver that does not set the new flag, is there anything that can
clear PHYINT once the PHY asserts it?  adin1140_probe() sets only:

	tc6_quirks.quirk_flags = OA_TC6_BROKEN_PHY;

and its PHY is polled (devm_mdiobus_alloc() leaves mii_bus->irq[] at
PHY_POLL), so PHYINT is now armed in hardware with no ack path.

Even on a device that does set OA_TC6_PHY_INT, can the dispatch return
without acking?  drivers/net/phy/phy.c:phy_interrupt() has:

	if (IS_ENABLED(CONFIG_PM_SLEEP) && phydev->irq_suspended) {
		...
		phydev->irq_rerun = 1;
		disable_irq_nosync(irq);
		return IRQ_HANDLED;
	}

After that the virq is disabled, so handle_nested_irq() becomes a no-op
because irq_can_handle_actions() is false.  resume_device_irqs() re-enables
the SPI IRQ in the noirq phase while mdio_bus_phy_resume() clears
irq_suspended only later in the device-resume phase, which looks like a
window where the PHY source stays asserted with the SPI IRQ live.

With IRQF_TRIGGER_LOW | IRQF_ONESHOT, wouldn't the still-asserted level
re-trigger oa_tc6_macphy_isr() as soon as oa_tc6_macphy_threaded_irq()
returns, spinning on empty data chunks plus two extra STATUS0 control
transactions per chunk footer?  The result of handle_nested_irq() is not
used, PHYINT is never re-masked, and oa_tc6_disable_traffic() is only
reached on SPI transfer errors.

> @@ -810,6 +871,15 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
>  		return ret;
>  	}
>  
> +	/* Dispatch the PHY interrupt to phylib via the nested virtual IRQ so
> +	 * the PHY driver reads and acknowledges its status. PHYINT is level
> +	 * triggered, so doing this synchronously here (in the sleepable
> +	 * threaded IRQ) clears the source before the next data chunk.
> +	 */
> +	if ((tc6->quirk_flags & OA_TC6_PHY_INT) &&
> +	    FIELD_GET(OA_TC6_STATUS0_PHY_INT, value))
> +		handle_nested_irq(tc6->phy_virq);
> +

[ ... ]

> diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
> index 27f652d4920b2..1c8cc263c5e53 100644
> --- a/include/linux/oa_tc6.h
> +++ b/include/linux/oa_tc6.h
> @@ -68,6 +70,7 @@ struct oa_tc6;
>  
>  enum oa_tc6_quirk_flag {
>  	OA_TC6_BROKEN_PHY = BIT(0),
> +	OA_TC6_PHY_INT    = BIT(1),
>  };

[Severity: Low]
This isn't a bug, just a note for anyone reading this commit alone: at this
point in the series no in-tree caller passes OA_TC6_PHY_INT, so the irq
domain, the virq, the mii_bus->irq[] population and the handle_nested_irq()
dispatch are all unreachable here.

The following patch in the series, "microchip: lan865x: enable PHY
interrupt via virtual IRQ", adds the producer in lan865x_probe():

	tc6_quirks.quirk_flags = OA_TC6_PHY_INT;
	priv->tc6 = oa_tc6_init(spi, netdev, &tc6_quirks);

so this resolves within the series and no change is needed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907052007.391972-1-parthiban.veerasooran%40microchip.com
