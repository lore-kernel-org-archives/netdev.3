Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335F4AA3E6;
	Sat, 10 Oct 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645062; cv=none; b=oFjZOHnLyCJbuJL37vigGvrYED/PiFweLbgWwhyETQWtIxYk20y6yIeapzTiwbjH0od3pCixJIKu7extRkBwHnLZKO6bj9gDtf/RSsY886n/hwdelzS33UjiNeNS24WR5JZWi5lJU0N5cyRuY6XwWBDqLbH8kkfRty9hYpxGF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645062; c=relaxed/simple;
	bh=pTf0NtafgzMRl2AhDHX03xQkwVmDMpVpgFMf93SSRqk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBrjZhnizl6onhyYy1fNZXa6kutxfOltK7GmOEs1y+/Q0IXaDM2vUL6OeivCGzUoSG+CHPF0k0tGY1QnYN+X0O0Acgc7g42e5fHFksga5KahN9cnsDHaDx4WMXs7hFAhYpSVyazgFvWnnV1HMuzTZM05ZMbmkrNrWGQIGEdpPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILd2irHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILd2irHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E50C1F00893;
	Sat, 10 Oct 2026 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645060;
	bh=E8GeyO+4i8dZZKvi7XkshM7rDNrK7wamGc0ofjeqC5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ILd2irHOHzhQtljC1BLZTYUu4Ob+4QGU1tE7ll0yz+AzMYvxYMo5ais3cR3ardrPD
	 dRSyZhq8zrgKdmgdUsd9sGiKniatabaXUFfFq7i6nlPIPM0yMjp+oR0dkYBfs+wk7m
	 wf7BPvt2wMCDTI9uxEsG/CTmxUPi8LioVkZ8SjsEfeRZHLB46MEbo8oesStisJCT0A
	 aXqeUY50jBwIJ0UE76xMCevn9n3XJvueZeSXCEvwUJziwWkwtLfy20aNad5w28AAr8
	 IcWZjgGEzCmkBWqGbTzppUsdw4zt6bxF7cKHdEFCvRk/hvcCoHfK+GVYH20GXgOIDr
	 dhHdENiILF1Rg==
Subject: Re: [PATCH net-next 4/5] net: macb: implement timestamped MDIO writes
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, florian.fainelli@broadcom.com, opendmb@gmail.com,
 nb@tipi-net.de, theo.lebrun@bootlin.com, linux@armlinux.org.uk,
 conor.dooley@microchip.com, bcm-kernel-feedback-list@broadcom.com,
 tglx@kernel.org, mlichvar@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 15:10:58 +0000
Message-ID: <179164505890.434549.6507201122764529709@kernel.org>
In-Reply-To: <20261009143506.2507607-5-jjc@jclark.com>
References: <20261009143506.2507607-5-jjc@jclark.com>
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

- [Medium] macb_mdio_sts_delay() applies one fixed delay to every MACB,
  GEM and EMAC variant: 63.5 MDC periods from the MAN command write to…
- [Medium] bp->mdio_sts_rate is refreshed only in macb_mii_init() (via
  macb_mdio_init_sts()) and in macb_init_hw() (on open and resume).
- [Low] The delay in macb_mdio_sts_delay() comes from two values that
  nothing keeps consistent with each other: bp->mdio_sts_rate…

--

net: macb: implement timestamped MDIO writes

This adds a write_sts callback to the macb MDIO bus that takes system
timestamps around the MAN command register write. Both bounds are then
shifted by 63.5 MDC periods, using a cached pclk rate and the CLK divider
read from NCFGR, to estimate the MDC edge that clocks the last data bit.
The 63.5 period figure was measured on RP1 with a BCM54210PE PHY.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index c4223ca848df8..cec6e5a48e9f0 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -384,11 +384,47 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int mii_id, int devad,
>  	return status;
>  }
>  
> -static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
> -			       u16 value)
> +static u64 macb_mdio_sts_delay(struct macb *bp)
> +{

[ ... ]

> +	unsigned long rate = READ_ONCE(bp->mdio_sts_rate);
> +	u32 config = macb_readl(bp, NCFGR);
> +	u32 divisor;
> +
> +	if (macb_is_gem(bp))
> +		divisor = gem_divisors[GEM_BFEXT(CLK, config)];
> +	else
> +		divisor = macb_divisors[MACB_BFEXT(CLK, config)];
> +
> +	/* On RP1 the MDC edge that clocks the last bit of a clause 22
> +	 * write comes 63.5 periods after the command write.
> +	 */
> +	return div64_ul(127ULL * divisor * NSEC_PER_SEC, 2 * rate);

[Severity: Medium]
The 63.5 period figure was measured only on RP1. Even so, macb_mii_init()
installs write_sts for every device that macb_probe() brings up. The only
gate is a non-zero pclk rate from macb_mdio_init_sts():

	if (macb_mdio_init_sts(bp))
		bp->mii_bus->write_sts = &macb_mdio_write_c22_sts;

That covers Zynq-7000, ZynqMP, Versal, SAMA5/SAMA7, SiFive, EyeQ5, PIC64
and plain MACB. It also covers the AT91RM9200 EMAC (emac_config with
at91ether_init) and macb_pci. In macb_pci, pclk is a fixed nominal 50 MHz
clock from clk_register_fixed_rate().

The mii_bus write_sts documentation says to set the callback "only if
timestamps can always be provided". __mdiobus_write_sts() also requires
the bounds to contain the MDC rising edge that clocks the last data bit.

Both bounds are shifted by the same predicted delay. Some integrations
could start the MDC frame at a different phase, for example with a
free-running divider or extra synchronizer cycles between MAN and MDC.
Would those report an interval that misses the real edge by up to one MDC
period (about 400 ns at 2.5 MHz)?

The bcm-unimac patch in this series found that hardware like this exists:

drivers/net/mdio/mdio-bcm-unimac.c:unimac_mdio_sts_delays() {
    /* On BCM2711 the MDC divider runs freely, so the MDC edge that
     * clocks the last bit of a write comes 63.5 to 64.5 periods after
     * the command start.
     */
}

Once this is applied, Broadcom bcm-phy-lib PHYs that check
phy_supports_write_sts() stop using their fallback path and use these
bounds on every macb variant. mdio-mux children inherit the callback too.

Should write_sts be limited to RP1, for example with a MACB_CAPS_* flag
set in raspberrypi_rp1_config?

Also, the commit message does not say that the delay was validated only
on RP1. That caveat is below the --- line and will be dropped when the
patch is applied. Could it go into the commit message?

[ ... ]

> @@ -1141,6 +1203,13 @@ static int macb_mdiobus_register(struct macb *bp, struct device_node *mdio_np)
>  	return mdiobus_register(bp->mii_bus);
>  }
>  
> +static bool macb_mdio_init_sts(struct macb *bp)
> +{
> +	bp->mdio_sts_rate = clk_get_rate(bp->pclk);

[Severity: Medium]
bp->mdio_sts_rate is refreshed only here and in macb_init_hw(), on open
and resume. There is no clk notifier and no rate exclusivity. What
happens to the bounds when pclk changes after that?

On Zynq-7000 the GEM pclk is <&clkc 30> (gem0_aper). It is gated from
cpu_1x, which is divided from cpu_div. cpu_6or4x has CLK_SET_RATE_PARENT
on that same cpu_div. cpufreq-dt-platdev allowlists "xlnx,zynq-7000", and
zynq-7000.dtsi has 666667 and 333334 kHz operating points.

When cpufreq drops from 666 MHz to 333 MHz, pclk halves but NCFGR keeps
the old divider, so the real time to the last MDC edge doubles. Take
GEM_CLK_DIV48 with pclk going from about 111 MHz to about 55 MHz.
macb_mdio_sts_delay() would add about 27.4 us instead of about 54.9 us.
post_sts would then land tens of microseconds before the real completion.
If the rate goes up instead, pre_sts lands after it.

The error lasts until the next macb_init_hw(). It also applies while the
interface is down, because the probe-time rate stored here is used then.

> +
> +	return bp->mdio_sts_rate != 0;
> +}
> +

[ ... ]

> @@ -3095,12 +3166,20 @@ static void macb_configure_dma(struct macb *bp)
>  
>  static void macb_init_hw(struct macb *bp)
>  {
> +	unsigned long rate;
>  	u32 config;
>  
>  	macb_reset_hw(bp);
>  	macb_set_hwaddr(bp);
>  
>  	config = macb_mdc_clk_div(bp);
> +	/* Record the pclk rate the MDC divider is chosen from, for
> +	 * write_sts, which can't call clk_get_rate() under the MDIO bus
> +	 * lock.
> +	 */
> +	rate = clk_get_rate(bp->pclk);
> +	if (rate)
> +		WRITE_ONCE(bp->mdio_sts_rate, rate);

[Severity: Low]
The new rate is published here, but the matching CLK divider reaches
NCFGR only later in macb_init_hw():

	macb_writel(bp, NCFGR, config);

Nothing here takes bus->mdio_lock. macb_mdio_write_c22_sts() holds only
mdio_lock. It can be reached from a PTP_SYS_OFFSET_EXTENDED ioctl on the
PHY PHC while macb_open() -> macb_init_hw() is running, because the PHC
is registered at probe.

Suppose a timestamped write lands between this WRITE_ONCE() and the
NCFGR write. Could macb_mdio_sts_delay() pair the new rate with the old
divisor? Both bounds would then be shifted by a delay that matches
neither configuration.

There are two related gaps. This rate comes from a separate
clk_get_rate() call, not the one macb_mdc_clk_div() / gem_mdc_clk_div()
used to choose the divider. And macb_mdio_write_c22_sts() samples
delay_ns before local_irq_save(), so an NCFGR rewrite between the sample
and the MAN write is not covered either.

A mismatch needs pclk to have changed since NCFGR was last programmed.
That can happen on Zynq-7000 with cpufreq-dt.

>  	/* Make eth data aligned.
>  	 * If RSC capable, that offset is ignored by HW.
>  	 */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009143506.2507607-1-jjc%40jclark.com
