Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108D4229B0;
	Mon, 19 Oct 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406077; cv=none; b=CtYwkLqc1LoOBCh4jYWhxElcowUL5yozKhMmUdqAJW2x8DLhdkO29W32vDK8LskNQGm5cp9xnE5q6cCgFo4pvCDjxDcVgPp9s070rWnW+X/s6rYMTQT5CWiAAnJeuphtHmxkxGFvR8YaiyCjLquerhg6cEb9xpYEG/l2duNDc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406077; c=relaxed/simple;
	bh=u6k3DjbG0QcEo8/pv0nSnNbn6NcK6VLJk6SVP6MdizM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6j6eju0f6e23PCVGbV8cTWFOdX0TxFLuvu8KXx0J5SC4FlB/zZ2hSNnQq7mwXFkjHL1wzPPf/WSfeuVoaCC9xw44VoCmiN0qQOvKPoR6HIcxPssMvkDKL+8UnioePUCmy5pT+K1BOtB9BmvEGqsuKfPYxG0w4lUyzxSiwWCHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8rDaMmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8rDaMmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760761F000C5;
	Mon, 19 Oct 2026 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792406075;
	bh=Ip3kZ6Yb3vcXwlNfH4uwGjqDeMqf/ciGL9TlOaLmBZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n8rDaMmN0I64EM5jKUubB3BvE6YKfaEEf7BjkULFX+yCJAy24C2Cua8r68oABl517
	 OFhuLRDvwVkrE7fEaQc80Es40vhwt0cx7u7hdGWXkwIpzj4vOQRCVWxj5X3ctw06tU
	 16Im2pjYR+IOyBo004H4647VwbfSRkGSTz5L3K1ObZFmEpTskLFAZY8r4dn2kjE2LN
	 T+7QhoOksGa2diio80W+IjVuSaJAq4vlz2dyiKVXj7lV3GsZphS57Rw+5cfg5mllug
	 EnPBOfohrVbWxXSoU/XPMEoXV1zsvMtoPtj275v5XP5Hbju4AbVgamvNGHJgxL0MDJ
	 DT2Owhc6hsavw==
Subject: Re: [PATCH net-next v2 4/6] net: phy: broadcom: use timestamped MDIO
 writes in gettimex64
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, florian.fainelli@broadcom.com, opendmb@gmail.com,
 nb@tipi-net.de, theo.lebrun@bootlin.com, andrew@lunn.ch,
 linux@armlinux.org.uk, conor.dooley@microchip.com,
 bcm-kernel-feedback-list@broadcom.com, tglx@kernel.org, jstultz@google.com,
 sboyd@kernel.org, mlichvar@redhat.com, olteanv@gmail.com,
 h.feurstein@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 10:34:34 +0000
Message-ID: <179240607406.3135.6389434535700214639@kernel.org>
In-Reply-To: <20261018100257.566267-5-jjc@jclark.com>
References: <20261018100257.566267-5-jjc@jclark.com>
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

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The calibration behind BCM_FRAMESYNC_CAPTURE_NS assumes the
  PHY's external SYNC_IN capture path and the GPIO observation path see…
- [Low] Claimed problem: no MDIO bus driver implements write_sts, so the
  new bcm_ptp_framesync_ts() branch (`sts &&…
- [Low] The new comment on BCM_FRAMESYNC_CAPTURE_NS in
  drivers/net/phy/bcm-phy-ptp.c measures the capture delay from 'the…

Pre-existing issues:
- [Medium] In bcm_ptp_framesync_ts(), `reg` is a u16 holding the int
  result of bcm_phy_read_exp(phydev, INTR_STATUS).
- [Medium] bcm_ptp_perout_work() declares `struct timespec64 ts;` without
  an initializer, ignores the return value of…

--

net: phy: broadcom: use timestamped MDIO writes in gettimex64

This commit adds bcm_phy_write_exp_sts(). bcm_ptp_framesync_ts() uses it
when the MDIO bus provides write_sts, so the gettimex64 system timestamps
bracket completion of the write that triggers the framesync. A 350 ns
BCM_FRAMESYNC_CAPTURE_NS bound, found by measurement, is passed as the
event delay to cover the PHY's capture latency.

> diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
> index 65d609ed69fb4..61593dd2dbc0a 100644
> --- a/drivers/net/phy/bcm-phy-ptp.c
> +++ b/drivers/net/phy/bcm-phy-ptp.c
> @@ -161,6 +161,11 @@ struct bcm_ptp_capture {
>  #define BCM_MAX_PULSE_8NS	((1U << 9) - 1)
>  #define BCM_MAX_PERIOD_8NS	((1U << 30) - 1)
>  
> +/* Allowed for the PHY to capture its time after the last MDC edge of
> + * the framesync write.
> + */
> +#define BCM_FRAMESYNC_CAPTURE_NS	350

[Severity: Low]

Is "the last MDC edge of the framesync write" the same reference point
that __mdiobus_write_sts() uses for event_delay_ns? The kernel-doc there
says:

drivers/net/phy/mdio_bus.c:__mdiobus_write_sts()
 * timestamps bounding completion; a transfer is considered complete on
 * the rising edge of the MDC that clocks the last data bit. The upper
 * bound is moved @event_delay_ns later, so that the bounds also contain
 * an event that follows completion.

A clause 22 frame has a falling MDC edge half a period after that rising
edge, and free-running controllers keep clocking after it. At the MDC
periods in the commit message, "the last MDC edge" could therefore be
read as a point 50 to 200 ns later.

The 350 ns value looks like it was calibrated against the rising-edge
completion bounds that the later macb and unimac write_sts patches use,
so the constant itself appears consistent with the core.

Could the comment be reworded to match the __mdiobus_write_sts()
definition? Otherwise someone re-deriving the constant from the comment
could end up with a value that is too small.

[Severity: Medium]

Does the calibration behind this value account for any latency in the
PHY's external input capture path compared with the GPIO? The commit
message says:

    The same PPS signal was wired both to
    the SYNC_OUT pin connected to the PHY's PHC and to GPIO pin 18.
    [ ... ]
    Combining these gives a PHC/system time pair for each pulse.

The PHC side of each pair comes from bcm_ptp_extts_work(), which reports
the raw heartbeat capture with no latency correction.

Suppose the PHY latches the PHC D ns after the true edge and the GPIO
sees the edge G ns after. Then every interpolated capture time would be
early by (D - G), and the true bound would be the measured one plus
(D - G).

The polling bracket compensation and the 8 ns phase allowance don't
cover this fixed path offset. The CM5 cross-check uses the same PHY
input path, so it would have the same bias. That leaves about 12 ns of
margin (350 - 330 - 8). A two or three flop synchronizer in a 125 MHz
domain would be 16 to 24 ns.

__mdiobus_write_sts() extends post_sts by exactly the value passed in:

    ptp_adjust_system_postts(sts, event_delay_ns);

So an underestimate here would quietly give PTP_SYS_OFFSET_EXTENDED
bounds that don't contain the PHC capture. The size of D - G is a
hardware property that can't be checked from the code.

Is this input latency known or bounded? If not, would a larger margin
be safer?

> +
>  #define BRCM_PHY_MODEL(phydev) \
>  	((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
>  
> @@ -214,22 +219,35 @@ static void bcm_ptp_framesync(struct phy_device *phydev, u16 ctrl)
>  	bcm_phy_write_exp(phydev, NSE_CTRL, ctrl | NSE_CPU_FRAMESYNC);
>  }
>  
> +static int bcm_ptp_framesync_sts(struct phy_device *phydev, u16 ctrl,
> +				 struct ptp_system_timestamp *sts)
> +{
> +	return bcm_phy_write_exp_sts(phydev, NSE_CTRL,
> +				     ctrl | NSE_CPU_FRAMESYNC,
> +				     BCM_FRAMESYNC_CAPTURE_NS, sts);
> +}
> +
>  static int bcm_ptp_framesync_ts(struct phy_device *phydev,
>  				struct ptp_system_timestamp *sts,
>  				struct timespec64 *ts,
>  				u16 orig_ctrl)
>  {
>  	u16 ctrl, reg;
> -	int i;
> +	int i, err = 0;
>  
>  	ctrl = bcm_ptp_framesync_disable(phydev, orig_ctrl);
>  
> -	ptp_read_system_prets(sts);
> -
>  	/* trigger framesync + capture */
> -	bcm_ptp_framesync(phydev, ctrl | NSE_CAPTURE_EN);
> -
> -	ptp_read_system_postts(sts);
> +	if (sts && bcm_phy_supports_write_exp_sts(phydev)) {

[Severity: Low]

At this commit, does any MDIO bus driver set write_sts? If none does,
mdiobus_supports_write_sts() always returns false and this branch can't
run. The 350 ns bound would also depend on bus driver timing that isn't
in the tree yet.

This appears to be resolved later in the series. "net: macb: implement
timestamped MDIO writes" adds:

    bp->mii_bus->write_sts = &macb_mdio_write_c22_sts;

and "net: mdio: bcm-unimac: implement timestamped MDIO writes" adds:

    bus->write_sts = unimac_mdio_write_sts;

So this is only a note about patch ordering in the series.

> +		/* cannot ignore error since sts may be uninitialized,
> +		 * but still poll for any triggered capture
> +		 */
> +		err = bcm_ptp_framesync_sts(phydev, ctrl | NSE_CAPTURE_EN, sts);
> +	} else {
> +		ptp_read_system_prets(sts);
> +		bcm_ptp_framesync(phydev, ctrl | NSE_CAPTURE_EN);
> +		ptp_read_system_postts(sts);
> +	}
>  
>  	/* poll for FSYNC interrupt from TS capture */
>  	for (i = 0; i < 10; i++) {

[Severity: Medium]

This isn't a bug introduced by this patch, but reg is a u16 that holds
the int result of bcm_phy_read_exp() in this loop:

	for (i = 0; i < 10; i++) {
		reg = bcm_phy_read_exp(phydev, INTR_STATUS);
		if (reg & INTC_FSYNC) {
			bcm_ptp_get_framesync_ts(phydev, ts);
			break;
		}
	}

Can a negative MDIO error look like a completed capture here? -EIO
truncated to u16 is 0xfffb, and that has INTC_FSYNC (BIT(0)) set.

bcm_ptp_get_framesync_ts() then stores the unchecked bcm_phy_read_exp()
results in u16 hb[]. If the trigger write succeeded, the function
returns 0 with a bogus timestamp.

The new error check only covers the timestamped trigger write, and the
commit message says the existing framesync error handling is out of
scope. This may be better fixed separately.

> @@ -242,6 +260,9 @@ static int bcm_ptp_framesync_ts(struct phy_device *phydev,
>  
>  	bcm_ptp_framesync_restore(phydev, orig_ctrl);
>  
> +	if (err)
> +		return err;
> +
>  	return reg & INTC_FSYNC ? 0 : -ETIMEDOUT;

[Severity: Medium]

This is a pre-existing issue, but *ts is never written on the -ETIMEDOUT
path. bcm_ptp_perout_work() ignores the return value and uses ts anyway:

drivers/net/phy/bcm-phy-ptp.c:bcm_ptp_perout_work() {
	struct timespec64 ts;
	...
	bcm_ptp_framesync_ts(phydev, NULL, &ts, priv->nse_ctrl);

	/* this is 1PPS only */
	next = NSEC_PER_SEC - ts.tv_nsec;
	...
	bcm_phy_write_exp(phydev, SYNOUT_TS_0, ns & 0xfff0);
	bcm_phy_write_exp(phydev, SYNOUT_TS_1, ns >> 16);
	bcm_phy_write_exp(phydev, SYNOUT_TS_2, ns >> 32);
	...
}

If the INTC_FSYNC poll uses up all 10 iterations, wouldn't uninitialized
stack data be written to the SYNOUT_TS registers?

This caller passes sts == NULL, so it always takes the unchanged else
branch. Its behaviour is the same before and after this patch.

>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018100257.566267-1-jjc%40jclark.com
