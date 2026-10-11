Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611952BE3C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914068; cv=none; b=FBlDjqhU8B3Vp1tnb44XGFxh+uC5geW5OqjugVvYzH4T59D4p7B9fbmJ8wV3VpfenXFPlYthyKuHKHbvRoo1W4/th32k0T7pM7TsY9xHp1Hs42x5VG3TmXFOFa8UQmrFucia/YbiZTjYJEIpDX36HO/c8rcJoV3h/j7d+YhZszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914068; c=relaxed/simple;
	bh=V04HKkppP4otIUiZZjwJr+SY7gh+0MABS3xv2JJGm94=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=VQQxapnKej7jwPJbCfWN0ihfqdfKHkhH1ECY2wVeKb/L/vkn2zoW6X8UP8C+Rq59Q5l0MEO3H4ry37u18g6brLgNUOuIoEKyKGpA5NfJHRceKDjCwIV1aAskOtZObf5DpY2pwkOV+xTpQ09M3FDvJKBnC9TmlHUPGHTmtepQBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hqlmMxbx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hqlmMxbx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F22E91A1201
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C5C146075C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:22 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 205F011D718BA; Tue, 13 Oct 2026 19:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914062; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=guaRvjHarTeM+wByn0FDVtfSuw3w5G/k8EvSJ1DM3JQ=;
	b=hqlmMxbxcWJcib7I28HbYJGNu/f1x5hdBzYw1fQr3io7cY+5y0Tfx04LOw7SgytXaEt7Cf
	NIErlPSTZZ2EmuHxUBAknOKij8Ai/M2oRwuAEj+b22Z5FjiT+d+3Y16TCdPU18J8E0b1lj
	wmOHMf/7yz8GeEfpO923wFFQbWWAmA33DWCIj4It8iAcH0e5kPDcOn32AFYT1EA+39TeC6
	x3lKdSNU9bCS43L+wH5uVowBHFhcx7bYS0M5UHlkrpjOQwmULbQHrvwibWsdeE865vitbB
	bc2vzYq5HTcDTCniS5iNjKO+hO42PW3pQu56gZwoaDNXPvoiFkcHI0xIqOJJUA==
Authentication-Results: mail.galae.net;
	none
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 11:23:54 +0200
Message-Id: <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>
Cc: "Russell King" <linux@armlinux.org.uk>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>, "Thomas Gleixner"
 <tglx@kernel.org>, "Miroslav Lichvar" <mlichvar@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
To: "James Clark" <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Florian Fainelli"
 <florian.fainelli@broadcom.com>, "Doug Berger" <opendmb@gmail.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 4/5] net: macb: implement timestamped MDIO
 writes
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-5-jjc@jclark.com>
In-Reply-To: <20261009143506.2507607-5-jjc@jclark.com>
X-TUID: VaWZt3fdrtgw
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 205F011D718BA
X-Spamd-Result: default: False [-2.60 / 30.00];
	BAYES_HAM(-5.50)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[56];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	BCC(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[jclark.com,davemloft.net,kernel.org,redhat.com,lunn.ch,gmail.com,broadcom.com,tipi-net.de];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[lunn.ch:email,broadcom.com:email,microchip.com:email,localhost:rdns,localhost:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:url,tipi-net.de:email,armlinux.org.uk:email,davemloft.net:email,jclark.com:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim]

Hello James,

On Fri Oct 9, 2026 at 4:35 PM CEST, James Clark wrote:
> Implement write_sts to provide system timestamp bounds for completion
> of an MDIO write. This enables tighter system timestamp bounds in PHY
> implementations of gettimex64.
>
> Take system timestamps around the command register write, then add
> the time from the command write until the MDC edge that clocks the
> last data bit, calculated from the peripheral clock rate and the
> configured MDC divider.
>
> On RP1 that edge comes 63.5 MDC periods after the command write. This
> was measured on a Raspberry Pi CM5 with its BCM54210PE PHY. The PHY's
> PHC was read with PTP_SYS_OFFSET_EXTENDED while the MDC divisor was
> switched between 48 and 128 through /dev/mem. Any error in the number
> of periods would make the PHC offset jump at each switch. After
> compensating for drift, the jump with 63.5 periods was under 2 ns.
> The MDC divider does not appear to run freely: the spread of the PHC
> offsets did not change with the divisor.
>
> Signed-off-by: James Clark <jjc@jclark.com>
> Assisted-by: LLM
> ---
> The 63.5-period delay has been measured only on RP1, but the code
> assumes it holds for all MACB and GEM variants. I am not sure whether
> that is a reasonable assumption; if not, write_sts could be enabled
> only for RP1.

I'm invoking my colleague @Maxime to get his opinion. What impacts the
MDIO write_c22 duration and how likely is it that this duration varies
(1) on the same MAC+PHY combo, (2) with a different PHY or (3) with a
different MACB revision?

Thanks!

Sashiko makes an interesting point with PCLK that might change over
time, giving an example (which I've not checked) where it would be
derived from the CPU clk which might change with cpufreq.

I'm wondering if we could do better than a hardcoded delay? For example
we could busy-wait for NSR.IDLE inside the prets/postts region, but
that implies at least 25=C2=B5s with IRQs disabled. Or we could do a few
measurements at init to sample our platform delay?

It doesn't solve the PCLK changing issue, but it solves the hardcoded
63.5 value.

If you share more details on your testing setup it would help for us to
reproduce on other hardware to gather more data points.

>  drivers/net/ethernet/cadence/macb.h      |  1 +
>  drivers/net/ethernet/cadence/macb_main.c | 95 ++++++++++++++++++++++--
>  2 files changed, 88 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 1cb2778fe49..3670731690f 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1334,6 +1334,7 @@ struct macb {
>  	struct macb_or_gem_ops	macbgem_ops;
> =20
>  	struct mii_bus		*mii_bus;
> +	unsigned long		mdio_sts_rate;
>  	struct phylink		*phylink;
>  	struct phylink_config	phylink_config;
>  	struct phylink_pcs	phylink_usx_pcs;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index c4223ca848d..cec6e5a48e9 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -384,11 +384,47 @@ static int macb_mdio_read_c45(struct mii_bus *bus, =
int mii_id, int devad,
>  	return status;
>  }
> =20
> -static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regn=
um,
> -			       u16 value)
> +static u64 macb_mdio_sts_delay(struct macb *bp)
> +{
> +	static const u16 gem_divisors[] =3D {
> +		[GEM_CLK_DIV8] =3D 8,
> +		[GEM_CLK_DIV16] =3D 16,
> +		[GEM_CLK_DIV32] =3D 32,
> +		[GEM_CLK_DIV48] =3D 48,
> +		[GEM_CLK_DIV64] =3D 64,
> +		[GEM_CLK_DIV96] =3D 96,
> +		[GEM_CLK_DIV128] =3D 128,
> +		[GEM_CLK_DIV224] =3D 224,
> +	};
> +	static const u16 macb_divisors[] =3D {
> +		[MACB_CLK_DIV8] =3D 8,
> +		[MACB_CLK_DIV16] =3D 16,
> +		[MACB_CLK_DIV32] =3D 32,
> +		[MACB_CLK_DIV64] =3D 64,
> +	};

Do I sound crazy if I say we could use a single array for both?
Both GEM_CLK_DIV* and MACB_CLK_DIV* are enums and are ordered in the
same way. First four GEM_* are the same ones as MACB_* and it will
never change.

> +	unsigned long rate =3D READ_ONCE(bp->mdio_sts_rate);
> +	u32 config =3D macb_readl(bp, NCFGR);
> +	u32 divisor;
> +
> +	if (macb_is_gem(bp))
> +		divisor =3D gem_divisors[GEM_BFEXT(CLK, config)];
> +	else
> +		divisor =3D macb_divisors[MACB_BFEXT(CLK, config)];

I'm a bit surprised to see you reading NCFGR.CLK and derive the current
divisor from that. The divisor is set by us in macb_mdc_clk_div(), with
only input being the PCLK rate.

> +
> +	/* On RP1 the MDC edge that clocks the last bit of a clause 22
> +	 * write comes 63.5 periods after the command write.
> +	 */
> +	return div64_ul(127ULL * divisor * NSEC_PER_SEC, 2 * rate);
> +}
> +
> +static int macb_mdio_write_c22_sts(struct mii_bus *bus, int mii_id, int =
regnum,
> +				   u16 value, struct ptp_system_timestamp *sts)
>  {
>  	struct macb *bp =3D bus->priv;
> +	unsigned long flags;
> +	u64 delay_ns;
>  	int status;
> +	u32 cmd;
> =20
>  	status =3D pm_runtime_resume_and_get(&bp->pdev->dev);
>  	if (status < 0)
> @@ -398,12 +434,32 @@ static int macb_mdio_write_c22(struct mii_bus *bus,=
 int mii_id, int regnum,
>  	if (status < 0)
>  		goto mdio_write_exit;
> =20
> -	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
> -			      | MACB_BF(RW, MACB_MAN_C22_WRITE)
> -			      | MACB_BF(PHYA, mii_id)
> -			      | MACB_BF(REGA, regnum)
> -			      | MACB_BF(CODE, MACB_MAN_C22_CODE)
> -			      | MACB_BF(DATA, value)));
> +	cmd =3D MACB_BF(SOF, MACB_MAN_C22_SOF)
> +	      | MACB_BF(RW, MACB_MAN_C22_WRITE)
> +	      | MACB_BF(PHYA, mii_id)
> +	      | MACB_BF(REGA, regnum)
> +	      | MACB_BF(CODE, MACB_MAN_C22_CODE)
> +	      | MACB_BF(DATA, value);
> +
> +	if (sts) {
> +		delay_ns =3D macb_mdio_sts_delay(bp);
> +		local_irq_save(flags);
> +		ptp_read_system_prets(sts);
> +		/* macb_writel() is relaxed; order it after the timestamp. */
> +		mb();
> +	}
> +	macb_writel(bp, MAN, cmd);
> +	if (sts) {
> +		/* Flush the posted write before taking the upper bound. */
> +		macb_readl(bp, NSR);

An unconditional readl for flushing the posted write won't do it.
MACB is over PCI only on very few platforms. I guess the straightforward
solution is a POSTED_WRITES flag that is then read from here.

For example broadcom/tg3 does it with their FLUSH_POSTED_WRITES flag.
Not sure they are a good example though.

> +		/* Order the read-back before the system timestamp. */
> +		rmb();

Why rmb() and not mb()?

> +		ptp_read_system_postts(sts);
> +		local_irq_restore(flags);
> +
> +		ptp_adjust_system_prets(sts, delay_ns);
> +		ptp_adjust_system_postts(sts, delay_ns);
> +	}
> =20
>  	status =3D macb_mdio_wait_for_idle(bp);
>  	if (status < 0)
> @@ -415,6 +471,12 @@ static int macb_mdio_write_c22(struct mii_bus *bus, =
int mii_id, int regnum,
>  	return status;
>  }
> =20
> +static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regn=
um,
> +			       u16 value)
> +{
> +	return macb_mdio_write_c22_sts(bus, mii_id, regnum, value, NULL);
> +}
> +
>  static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
>  			       int devad, int regnum,
>  			       u16 value)
> @@ -1141,6 +1203,13 @@ static int macb_mdiobus_register(struct macb *bp, =
struct device_node *mdio_np)
>  	return mdiobus_register(bp->mii_bus);
>  }
> =20
> +static bool macb_mdio_init_sts(struct macb *bp)
> +{
> +	bp->mdio_sts_rate =3D clk_get_rate(bp->pclk);
> +
> +	return bp->mdio_sts_rate !=3D 0;
> +}
> +
>  static int macb_mii_init(struct macb *bp)
>  {
>  	struct device_node *mdio_np, *np =3D bp->pdev->dev.of_node;
> @@ -1166,6 +1235,8 @@ static int macb_mii_init(struct macb *bp)
>  	bp->mii_bus->name =3D "MACB_mii_bus";
>  	bp->mii_bus->read =3D &macb_mdio_read_c22;
>  	bp->mii_bus->write =3D &macb_mdio_write_c22;
> +	if (macb_mdio_init_sts(bp))
> +		bp->mii_bus->write_sts =3D &macb_mdio_write_c22_sts;
>  	bp->mii_bus->read_c45 =3D &macb_mdio_read_c45;
>  	bp->mii_bus->write_c45 =3D &macb_mdio_write_c45;
>  	snprintf(bp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
> @@ -3095,12 +3166,20 @@ static void macb_configure_dma(struct macb *bp)
> =20
>  static void macb_init_hw(struct macb *bp)
>  {
> +	unsigned long rate;
>  	u32 config;
> =20
>  	macb_reset_hw(bp);
>  	macb_set_hwaddr(bp);
> =20
>  	config =3D macb_mdc_clk_div(bp);
> +	/* Record the pclk rate the MDC divider is chosen from, for
> +	 * write_sts, which can't call clk_get_rate() under the MDIO bus
> +	 * lock.
> +	 */
> +	rate =3D clk_get_rate(bp->pclk);
> +	if (rate)
> +		WRITE_ONCE(bp->mdio_sts_rate, rate);

Can you clarify here and in the commit message why clk_get_rate() is
unacceptable under the MDIO bus lock?

Seeing your comment, my guess is an ABBA deadlock risk between
clk_prepare_lock and mii_bus->mdio_lock but please write it out.

This rate caching introduces the bug Sashiko describes of what happens
if PCLK rate changes over time, which sounds valid to me. If we could
avoid it it would be much better. Otherwise the full fix would
introduce clk notifiers and that sounds like a lot of work.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

text:
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 11:23:54 +0200
Message-Id: <DM1WEUIF8V8V.2OZWRB5G232T4@bootlin.com>
Cc: "Russell King" <linux@armlinux.org.uk>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>, "Thomas Gleixner"
 <tglx@kernel.org>, "Miroslav Lichvar" <mlichvar@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
To: "James Clark" <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Florian Fainelli"
 <florian.fainelli@broadcom.com>, "Doug Berger" <opendmb@gmail.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 4/5] net: macb: implement timestamped MDIO
 writes
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-5-jjc@jclark.com>
In-Reply-To: <20261009143506.2507607-5-jjc@jclark.com>
X-TUID: i0xKV7JAEaON

Hello James,

On Fri Oct 9, 2026 at 4:35 PM CEST, James Clark wrote:
> Implement write_sts to provide system timestamp bounds for completion
> of an MDIO write. This enables tighter system timestamp bounds in PHY
> implementations of gettimex64.
>
> Take system timestamps around the command register write, then add
> the time from the command write until the MDC edge that clocks the
> last data bit, calculated from the peripheral clock rate and the
> configured MDC divider.
>
> On RP1 that edge comes 63.5 MDC periods after the command write. This
> was measured on a Raspberry Pi CM5 with its BCM54210PE PHY. The PHY's
> PHC was read with PTP_SYS_OFFSET_EXTENDED while the MDC divisor was
> switched between 48 and 128 through /dev/mem. Any error in the number
> of periods would make the PHC offset jump at each switch. After
> compensating for drift, the jump with 63.5 periods was under 2 ns.
> The MDC divider does not appear to run freely: the spread of the PHC
> offsets did not change with the divisor.
>
> Signed-off-by: James Clark <jjc@jclark.com>
> Assisted-by: LLM
> ---
> The 63.5-period delay has been measured only on RP1, but the code
> assumes it holds for all MACB and GEM variants. I am not sure whether
> that is a reasonable assumption; if not, write_sts could be enabled
> only for RP1.

I'm invoking my colleague @Maxime to get his opinion. What impacts the
MDIO write_c22 duration and how likely is it that this duration varies
(1) on the same MAC+PHY combo, (2) with a different PHY or (3) with a
different MACB revision?

Thanks!

Sashiko makes an interesting point with PCLK that might change over
time, giving an example (which I've not checked) where it would be
derived from the CPU clk which might change with cpufreq.

I'm wondering if we could do better than a hardcoded delay? For example
we could busy-wait for NSR.IDLE inside the prets/postts region, but
that implies at least 25=C2=B5s with IRQs disabled. Or we could do a few
measurements at init to sample our platform delay?

It doesn't solve the PCLK changing issue, but it solves the hardcoded
63.5 value.

If you share more details on your testing setup it would help for us to
reproduce on other hardware to gather more data points.

>  drivers/net/ethernet/cadence/macb.h      |  1 +
>  drivers/net/ethernet/cadence/macb_main.c | 95 ++++++++++++++++++++++--
>  2 files changed, 88 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 1cb2778fe49..3670731690f 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1334,6 +1334,7 @@ struct macb {
>  	struct macb_or_gem_ops	macbgem_ops;
> =20
>  	struct mii_bus		*mii_bus;
> +	unsigned long		mdio_sts_rate;
>  	struct phylink		*phylink;
>  	struct phylink_config	phylink_config;
>  	struct phylink_pcs	phylink_usx_pcs;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index c4223ca848d..cec6e5a48e9 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -384,11 +384,47 @@ static int macb_mdio_read_c45(struct mii_bus *bus, =
int mii_id, int devad,
>  	return status;
>  }
> =20
> -static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regn=
um,
> -			       u16 value)
> +static u64 macb_mdio_sts_delay(struct macb *bp)
> +{
> +	static const u16 gem_divisors[] =3D {
> +		[GEM_CLK_DIV8] =3D 8,
> +		[GEM_CLK_DIV16] =3D 16,
> +		[GEM_CLK_DIV32] =3D 32,
> +		[GEM_CLK_DIV48] =3D 48,
> +		[GEM_CLK_DIV64] =3D 64,
> +		[GEM_CLK_DIV96] =3D 96,
> +		[GEM_CLK_DIV128] =3D 128,
> +		[GEM_CLK_DIV224] =3D 224,
> +	};
> +	static const u16 macb_divisors[] =3D {
> +		[MACB_CLK_DIV8] =3D 8,
> +		[MACB_CLK_DIV16] =3D 16,
> +		[MACB_CLK_DIV32] =3D 32,
> +		[MACB_CLK_DIV64] =3D 64,
> +	};

Do I sound crazy if I say we could use a single array for both?
Both GEM_CLK_DIV* and MACB_CLK_DIV* are enums and are ordered in the
same way. First four GEM_* are the same ones as MACB_* and it will
never change.

> +	unsigned long rate =3D READ_ONCE(bp->mdio_sts_rate);
> +	u32 config =3D macb_readl(bp, NCFGR);
> +	u32 divisor;
> +
> +	if (macb_is_gem(bp))
> +		divisor =3D gem_divisors[GEM_BFEXT(CLK, config)];
> +	else
> +		divisor =3D macb_divisors[MACB_BFEXT(CLK, config)];

I'm a bit surprised to see you reading NCFGR.CLK and derive the current
divisor from that. The divisor is set by us in macb_mdc_clk_div(), with
only input being the PCLK rate.

> +
> +	/* On RP1 the MDC edge that clocks the last bit of a clause 22
> +	 * write comes 63.5 periods after the command write.
> +	 */
> +	return div64_ul(127ULL * divisor * NSEC_PER_SEC, 2 * rate);
> +}
> +
> +static int macb_mdio_write_c22_sts(struct mii_bus *bus, int mii_id, int =
regnum,
> +				   u16 value, struct ptp_system_timestamp *sts)
>  {
>  	struct macb *bp =3D bus->priv;
> +	unsigned long flags;
> +	u64 delay_ns;
>  	int status;
> +	u32 cmd;
> =20
>  	status =3D pm_runtime_resume_and_get(&bp->pdev->dev);
>  	if (status < 0)
> @@ -398,12 +434,32 @@ static int macb_mdio_write_c22(struct mii_bus *bus,=
 int mii_id, int regnum,
>  	if (status < 0)
>  		goto mdio_write_exit;
> =20
> -	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
> -			      | MACB_BF(RW, MACB_MAN_C22_WRITE)
> -			      | MACB_BF(PHYA, mii_id)
> -			      | MACB_BF(REGA, regnum)
> -			      | MACB_BF(CODE, MACB_MAN_C22_CODE)
> -			      | MACB_BF(DATA, value)));
> +	cmd =3D MACB_BF(SOF, MACB_MAN_C22_SOF)
> +	      | MACB_BF(RW, MACB_MAN_C22_WRITE)
> +	      | MACB_BF(PHYA, mii_id)
> +	      | MACB_BF(REGA, regnum)
> +	      | MACB_BF(CODE, MACB_MAN_C22_CODE)
> +	      | MACB_BF(DATA, value);
> +
> +	if (sts) {
> +		delay_ns =3D macb_mdio_sts_delay(bp);
> +		local_irq_save(flags);
> +		ptp_read_system_prets(sts);
> +		/* macb_writel() is relaxed; order it after the timestamp. */
> +		mb();
> +	}
> +	macb_writel(bp, MAN, cmd);
> +	if (sts) {
> +		/* Flush the posted write before taking the upper bound. */
> +		macb_readl(bp, NSR);

An unconditional readl for flushing the posted write won't do it.
MACB is over PCI only on very few platforms. I guess the straightforward
solution is a POSTED_WRITES flag that is then read from here.

For example broadcom/tg3 does it with their FLUSH_POSTED_WRITES flag.
Not sure they are a good example though.

> +		/* Order the read-back before the system timestamp. */
> +		rmb();

Why rmb() and not mb()?

> +		ptp_read_system_postts(sts);
> +		local_irq_restore(flags);
> +
> +		ptp_adjust_system_prets(sts, delay_ns);
> +		ptp_adjust_system_postts(sts, delay_ns);
> +	}
> =20
>  	status =3D macb_mdio_wait_for_idle(bp);
>  	if (status < 0)
> @@ -415,6 +471,12 @@ static int macb_mdio_write_c22(struct mii_bus *bus, =
int mii_id, int regnum,
>  	return status;
>  }
> =20
> +static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regn=
um,
> +			       u16 value)
> +{
> +	return macb_mdio_write_c22_sts(bus, mii_id, regnum, value, NULL);
> +}
> +
>  static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
>  			       int devad, int regnum,
>  			       u16 value)
> @@ -1141,6 +1203,13 @@ static int macb_mdiobus_register(struct macb *bp, =
struct device_node *mdio_np)
>  	return mdiobus_register(bp->mii_bus);
>  }
> =20
> +static bool macb_mdio_init_sts(struct macb *bp)
> +{
> +	bp->mdio_sts_rate =3D clk_get_rate(bp->pclk);
> +
> +	return bp->mdio_sts_rate !=3D 0;
> +}
> +
>  static int macb_mii_init(struct macb *bp)
>  {
>  	struct device_node *mdio_np, *np =3D bp->pdev->dev.of_node;
> @@ -1166,6 +1235,8 @@ static int macb_mii_init(struct macb *bp)
>  	bp->mii_bus->name =3D "MACB_mii_bus";
>  	bp->mii_bus->read =3D &macb_mdio_read_c22;
>  	bp->mii_bus->write =3D &macb_mdio_write_c22;
> +	if (macb_mdio_init_sts(bp))
> +		bp->mii_bus->write_sts =3D &macb_mdio_write_c22_sts;
>  	bp->mii_bus->read_c45 =3D &macb_mdio_read_c45;
>  	bp->mii_bus->write_c45 =3D &macb_mdio_write_c45;
>  	snprintf(bp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
> @@ -3095,12 +3166,20 @@ static void macb_configure_dma(struct macb *bp)
> =20
>  static void macb_init_hw(struct macb *bp)
>  {
> +	unsigned long rate;
>  	u32 config;
> =20
>  	macb_reset_hw(bp);
>  	macb_set_hwaddr(bp);
> =20
>  	config =3D macb_mdc_clk_div(bp);
> +	/* Record the pclk rate the MDC divider is chosen from, for
> +	 * write_sts, which can't call clk_get_rate() under the MDIO bus
> +	 * lock.
> +	 */
> +	rate =3D clk_get_rate(bp->pclk);
> +	if (rate)
> +		WRITE_ONCE(bp->mdio_sts_rate, rate);

Can you clarify here and in the commit message why clk_get_rate() is
unacceptable under the MDIO bus lock?

Seeing your comment, my guess is an ABBA deadlock risk between
clk_prepare_lock and mii_bus->mdio_lock but please write it out.

This rate caching introduces the bug Sashiko describes of what happens
if PCLK rate changes over time, which sounds valid to me. If we could
avoid it it would be much better. Otherwise the full fix would
introduce clk notifiers and that sounds like a lot of work.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

