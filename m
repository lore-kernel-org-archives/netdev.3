Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292E38F951;
	Tue, 22 Sep 2026 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089714; cv=none; b=spoKQ8ryitNoW/s8gDYrONeijqNDPv7JksmayYedZPdCm1zRA+IjPKInSjHDBEmN/lNk31TamZnPt/d+7dpaBoWpKAsG4kfGZQr+OH3o5xPMFTfteWZozfFxg3/umbI/eoHfHSrziTC9wnxab/kiWxcMPkd273q5VYKbVsW8RCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089714; c=relaxed/simple;
	bh=veYOWRgHEBVNxox/aJCmN1gSmwlfQEhyYY+r9ZPnM9g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ie1xm5xTYvfkHK8umgrwNr042BvFbAkQb5pD6UFBi/U0Nc1c0sCNnEIxc6Oum2acFERqEcJrR+GJZ7dPa2/0OT+bsW6wqNlcn31Yfx+7HDdmZRTfjUfeytPPu+bMlrX/RLI7+oEVahFSw/dEKGdzSShJD74GV9zLb8fEqAwFwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fes+E6PT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fes+E6PT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2700F1F00899;
	Tue, 22 Sep 2026 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089710;
	bh=de7QF1Qj9nMkZym16WInFSa4gw/wUerVeVyBDe3SMrs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fes+E6PTqJc+vc6tqGIp6wa3PT3CnvFlmxZtBTzKWQXmZ78U+RcgAJqCYFmZB8AvL
	 N23C+0ZXm2BpOB4a7MSnRLQ6DH1Midvnp3UbspLgApE72uhaxGNxSwy/0KL51VUP2p
	 wle2W/Q8XDKgTxVtEBZfjvHJHmjofkFxE0/2SLt/u+VssKm5R07luAGUaJgoJ1/KAt
	 t7fznQFcOKCz+l6V1BbIyEpPWgHuj+WXsM4eix73TCKKMELbRR0j0GAKx6m6fkZFKA
	 uRC/MrMEJqKN+uERCWvoPSfS9SGOUohWttWtDlE5a4lTXL0/abGB6A0fS4+7aYdHTz
	 73CCs8VIVbr8g==
Subject: Re: [PATCH net-next v3 4/4] net: phy: microchip_t1s: fix collision
 detection for LAN867X Rev.D0
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Tue, 22 Sep 2026 15:08:29 +0000
Message-ID: <179008970969.2160803.871498341525662184@kernel.org>
In-Reply-To: <20260918143302.76909-5-parthiban.veerasooran@microchip.com>
References: <20260918143302.76909-5-parthiban.veerasooran@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Rev.D0 collision detection can stay permanently disabled: after
  this patch no code path ever programs COL_DET_CTRL0 (0x0087) bit 15…
- [High] Wiring .config_intr/.handle_interrupt into the LAN867X Rev.D0
  driver entry (lines 836-837) regresses ethtool cable testing on any…
- [Medium] net: phy: redundant MDIO traffic in
  lan867x_revd0_handle_interrupt()
- [Low] lan867x_revd0_handle_interrupt() discards an already-established
  IRQ_HANDLED verdict.
- [Low] Concern as filed: lan867x_revd0_config_intr() (lines 709-747)
  performs a multi-step read-modify-write of PHY state (read-clear STS1…

Pre-existing issues:
- [Medium] In lan86xx_plca_set_cfg() the Rev.D0 link-status-selection
  register (LAN867X_REG_LINK_STATUS_CTRL, 0x0012) is programmed at lines…

--

net: phy: microchip_t1s: fix collision detection for LAN867X Rev.D0

This configures the CCMFC field in COL_DET_CTRL0 to the OA default so the
LAN867X Rev.D0 hardware gates collision forwarding from PLCA_Status, and
stops the software CDEN toggling for that revision.  It also adds
lan867x_revd0_config_intr()/lan867x_revd0_handle_interrupt() handling Link
Status Change and PLCA Status Change, forcing the semaphore link-status
source whenever autonomous fallback to CSMA/CD (PRSCTL1 bit 10) is enabled.

A few questions below.

> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index 3333e4801aae..a69ad6ce1d8a 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c

[ ... ]

> @@ -40,6 +41,17 @@
>  #define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
>  #define COL_DET_ENABLE			BIT(15)
>  #define COL_DET_DISABLE			0x0000
> +#define COL_DET_CTRL0_CCMFC_MASK	GENMASK(10, 9)
> +/* OA default: collisions gated by PLCA_Status in hardware */
> +#define COL_DET_CTRL0_CCMFC_OA_DEFAULT	BIT(9)
> +
> +/* PLCA Reconciliation Sublayer Control 1 Register (PRSCTL1). Bit 10
> + * controls whether the PHY autonomously falls back to CSMA/CD mode when
> + * no BEACON is observed while PLCA is enabled, versus staying pinned to
> + * PLCA mode regardless of BEACON presence.
> + */
> +#define LAN867X_REG_PRSCTL1               0x0035
> +#define PRSCTL1_PLCA_FALLB_TO_CSMACD_EN   BIT(10)

[ ... ]

> @@ -454,9 +505,12 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
>  {
>  	int ret;
>  
> -	/* Link status selection must be configured for LAN8670/1/2 Rev.D0 */
> -	if (phydev->phy_id == PHY_ID_LAN867X_REVD0) {
> -		ret = lan867x_revd0_link_active_selection(phydev,
> +	/* Link status selection must be configured for LAN8670/1/2 Rev.D0.
> +	 * Only update link status selection if enabled is explicitly specified
> +	 * (not -1, which means "don't change").
> +	 */
> +	if (phydev->phy_id == PHY_ID_LAN867X_REVD0 && plca_cfg->enabled != -1) {
> +		ret = lan867x_revd0_update_link_selection(phydev,
>  							  plca_cfg->enabled);
>  		if (ret)
>  			return ret;
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but the ordering here looks
questionable in both the old and new code: LAN867X_REG_LINK_STATUS_CTRL is
programmed to the PLCA_STATUS source before genphy_c45_plca_set_cfg() sets
MDIO_OATC14_PLCA_EN.

genphy_c45_plca_set_cfg() performs several independent MMD writes
(PLCA_CTRL1, TOTMR, BURST) before it finally enables PLCA:

	// if we need to enable PLCA, do it at the end
	if (plca_cfg->enabled > 0) {
		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
				       MDIO_OATC14_PLCA_CTRL0,
				       MDIO_OATC14_PLCA_EN);

If any of those writes fails, lan86xx_plca_set_cfg() returns the error to
phy_ethtool_set_plca_cfg() with no unwind, leaving 0x0012 selecting
PLCA_STATUS while PLCA is still disabled.

Does that leave the PHY reporting link-down until the next successful
ethtool PLCA write or a re-init?  Would it be better to enable PLCA first
and switch the link-status source afterwards, restoring the semaphore source
if the PLCA programming failed?

> @@ -472,8 +526,12 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
>  	 * here as a baseline on every ethtool PLCA reconfiguration. The
>  	 * limitation is that autonomous PLCA mode transitions between ethtool
>  	 * reconfigurations are not tracked on such boards.
> +	 *
> +	 * LAN867X Rev.D0 has autonomous collision detection via CCMFC, so skip
> +	 * the software CDEN toggling for that revision.
>  	 */
> -	if (phy_interrupt_is_valid(phydev))
> +	if (phy_interrupt_is_valid(phydev) ||
> +	    phydev->phy_id == PHY_ID_LAN867X_REVD0)
>  		return 0;
>  
>  	if (plca_cfg->enabled > 0)

> @@ -507,6 +565,20 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
>  			return ret;
>  	}
>  
> +	/* AN1699: Configure CCMFC (Collision Counting and MAC Forwarding
> +	 * Control) to OA default (0x1) so that the hardware autonomously gates
> +	 * collision forwarding to the MAC based on the live PLCA_Status:
> +	 * collisions are neither counted nor forwarded when PLCA_Status is OK,
> +	 * and are counted/forwarded when not OK. This eliminates the need for
> +	 * software-driven CDEN toggling. CDEN is enabled by default and remains
> +	 * permanently enabled for Rev.D0.
> +	 */
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
> +			     COL_DET_CTRL0_CCMFC_MASK,
> +			     COL_DET_CTRL0_CCMFC_OA_DEFAULT);
> +	if (ret)
> +		return ret;

[Severity: High]
Where does anything actually set CDEN (COL_DET_CTRL0 bit 15) for Rev.D0?

The comment says "CDEN is enabled by default and remains permanently enabled
for Rev.D0", but the read-modify-write above only covers bits 10:9:

	#define COL_DET_CTRL0_CCMFC_MASK	GENMASK(10, 9)

The Rev.D0 init table does not touch 0x0087 either:

	static const u16 lan867x_revd0_fixup_regs[8] = {
		0x0037, 0x008A, 0x0118, 0x00D6,
		0x0082, 0x00FD, 0x00FD, 0x0091,
	};

And the new early return in lan86xx_plca_set_cfg() removes the last
remaining writer of COL_DET_ENABLE/COL_DET_DISABLE for this revision:

	if (phy_interrupt_is_valid(phydev) ||
	    phydev->phy_id == PHY_ID_LAN867X_REVD0)
		return 0;

So if bit 15 happens to be clear when lan867x_revd0_config_init() runs,
does the part end up running CSMA/CD with the collision detector off
permanently, with nothing left to re-arm it?  The CCMFC gating only decides
whether detected collisions are counted/forwarded.

Is the "enabled by default" assumption safe here?  This driver provides no
.soft_reset, and phy_init_hw() only resets when the driver supplies one:

	if (phydev->drv->soft_reset) {
		ret = phydev->drv->soft_reset(phydev);

so on a board without a PHY reset line config_init() runs against leftover
register state, for example after an unbind/rebind or a kexec from a
pre-patch kernel where lan86xx_plca_set_cfg() wrote COL_DET_DISABLE
whenever PLCA was enabled (pre-patch Rev.D0 was always PHY_POLL, so that
branch always ran).

The AN1699 Rev.B1 table in this same file explicitly sets bit 15 for the
same register:

	/* RMW 0x1F 0x0087 0x801C 0x801C */

Would including COL_DET_CTRL0_ENABLE_BIT_MASK/COL_DET_ENABLE in the same
read-modify-write be preferable to documenting an invariant that no code
establishes?

>  	/* Initially the PHY will be in CSMA/CD mode by default. So it is
>  	 * required to set the link always active as it doesn't support
>  	 * autoneg.

> @@ -634,6 +706,91 @@ static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
>  	return ret_irq;
>  }
>  
> +static int lan867x_revd0_config_intr(struct phy_device *phydev)
> +{
> +	u16 mask = LAN86XX_STS1_PLCA_STS_CHANGED |
> +		   LAN86XX_STS1_LINK_STS_CHANGED;
> +	struct phy_plca_cfg plca_cfg;
> +	int sts1, ret;
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		/* Read to clear any pending status before enabling. */
> +		sts1 = lan86xx_read_clear_sts1(phydev);
> +		if (sts1 < 0)
> +			return sts1;
> +
> +		if (sts1 & LAN86XX_STS1_LINK_STS_CHANGED)
> +			phy_trigger_machine(phydev);

[Severity: Low]
This isn't a bug, but is the ordering here intentional?  phy_trigger_machine()
runs before the link-status-selection source is resynced a few lines further
down by lan867x_revd0_update_link_selection(), so the state machine can read
the link state through the old selection source.

On the related concurrency question: lan867x_revd0_config_intr() does its
read-clear STS1 / genphy_c45_plca_get_cfg() / LINK_STATUS_CTRL write sequence
without phydev->lock, while lan867x_revd0_handle_interrupt() touches the same
registers under that lock via phy_interrupt().  That looks benign as written,
since both writers compute the 0x0012 value from the same two static inputs
(PLCA_CTRL0.PLCA_EN and PRSCTL1 bit 10) and the only mutator of those inputs
runs under rtnl and phydev->lock, so the two paths write identical values.
Would swapping the trigger to after the resync still be worth doing?

> +
> +		/* STS1 may have cleared a pending PSTC while masked, and a
> +		 * missed PSTC leaves no trace to key off, so unconditionally
> +		 * resync the link-status-selection source from the current
> +		 * PLCA enable state and fallback configuration. CDEN is
> +		 * never touched here - see lan867x_revd0_config_init().
> +		 */
> +		ret = genphy_c45_plca_get_cfg(phydev, &plca_cfg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = lan867x_revd0_update_link_selection(phydev,
> +							  plca_cfg.enabled);
> +		if (ret < 0)
> +			return ret;
> +
> +		return lan86xx_set_intr_mask(phydev, mask, true);
> +	}

[ ... ]

> +static irqreturn_t lan867x_revd0_handle_interrupt(struct phy_device *phydev)
> +{
> +	irqreturn_t ret_irq = IRQ_NONE;
> +	struct phy_plca_cfg plca_cfg;
> +	int sts1, ret;
> +
> +	sts1 = lan86xx_read_clear_sts1(phydev);
> +	if (sts1 < 0) {
> +		phy_error(phydev);
> +		return IRQ_NONE;
> +	}
> +
> +	if (sts1 & LAN86XX_STS1_LINK_STS_CHANGED) {
> +		phy_trigger_machine(phydev);
> +		ret_irq = IRQ_HANDLED;
> +	}
> +
> +	if (sts1 & LAN86XX_STS1_PLCA_STS_CHANGED) {
> +		ret = genphy_c45_plca_get_cfg(phydev, &plca_cfg);
> +		if (ret < 0) {
> +			phy_error(phydev);
> +			return IRQ_NONE;
> +		}

[Severity: Medium]
What does the PSTC arm here actually accomplish?  It re-derives the
link-status-selection source from two inputs that a PLCA_Status
transition cannot have changed: lan867x_revd0_update_link_selection()
computes the 0x0012 value from PLCA_CTRL0.PLCA_EN, fetched via
genphy_c45_plca_get_cfg(), and PRSCTL1 bit 10, fetched by
lan867x_revd0_fallback_to_csmacd().  Both are static configuration.
The only mutator of PLCA_EN is lan86xx_plca_set_cfg(), which already
programs LINK_STATUS_CTRL itself, and lan867x_revd0_config_intr()
resyncs it when interrupts are enabled.  So every PLCA flap ends in
lan867x_revd0_link_active_selection() writing 0x0012 with the value it
already holds.

The cost is five MMD reads in genphy_c45_plca_get_cfg() (PLCA_IDVER,
CTRL0, CTRL1, TOTMR, BURST), one more for PRSCTL1, and one write -
seven management-bus transactions per transition to produce no state
change.  On a multidrop segment where BEACONs come and go, PSTC can
flap frequently.

The error handling makes that worse than just wasted bandwidth: a
single transient MDIO failure in either call lands in phy_error(),
i.e. WARN_ON(1) plus PHY_ERROR, which parks the PHY until something
re-initialises it.  That is a hard failure taken on behalf of a
no-op register write.

The commit message says the Rev.D0 handler "only needs to update the
link status selection on each PLCA transition", but with CCMFC gating
collision forwarding from live PLCA_Status in hardware, and 0x0012
already pointing at PLCA_STATUS (or the semaphore when fallback is
enabled), does Rev.D0 need to subscribe to PSTC at all?  Could the
mask in lan867x_revd0_config_intr() drop
LAN86XX_STS1_PLCA_STS_CHANGED and keep only the link-status event?  If
there is a hardware reason the selection must be rewritten on every
transition, please spell it out in the comment - as written the code
reads as if the value were expected to differ.

[Severity: Low]
Should these error paths return ret_irq instead of IRQ_NONE?

When STS1 latches both LAN86XX_STS1_LINK_STS_CHANGED and
LAN86XX_STS1_PLCA_STS_CHANGED, ret_irq is already IRQ_HANDLED and
phy_trigger_machine() has run, and the latched bits were cleared by
lan86xx_read_clear_sts1().  A failing genphy_c45_plca_get_cfg() (or the
lan867x_revd0_update_link_selection() call below) then reports IRQ_NONE for
an interrupt the driver did consume.

phy_error() only sets PHY_ERROR and queues the state machine, and
phy_interrupt() forwards the driver verdict unchanged:

drivers/net/phy/phy.c:phy_interrupt() {
	...
	ret = phydev->drv->handle_interrupt(phydev);
	mutex_unlock(&phydev->lock);

	return ret;
}

so genirq accounts the serviced interrupt as unhandled.

> +
> +		/* lan867x_revd0_update_link_selection() drives the selection
> +		 * source from the configured PLCA enable state, forcing
> +		 * semaphore mode instead whenever autonomous fallback to
> +		 * CSMA/CD is configured (see PRSCTL1 above).
> +		 */
> +		ret = lan867x_revd0_update_link_selection(phydev,
> +							  plca_cfg.enabled);
> +		if (ret < 0) {
> +			phy_error(phydev);
> +			return IRQ_NONE;
> +		}
> +
> +		ret_irq = IRQ_HANDLED;
> +	}
> +
> +	return ret_irq;
> +}
> +

> @@ -676,6 +833,8 @@ static struct phy_driver microchip_t1s_driver[] = {
>  		.name               = "LAN867X Rev.D0",
>  		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
>  		.config_init        = lan867x_revd0_config_init,
> +		.config_intr        = lan867x_revd0_config_intr,
> +		.handle_interrupt   = lan867x_revd0_handle_interrupt,
>  		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
>  		.set_plca_cfg	    = lan86xx_plca_set_cfg,
>  		.get_plca_status    = genphy_c45_plca_get_status,

[Severity: High]
Does wiring .config_intr/.handle_interrupt into this entry break ethtool
cable testing for Rev.D0 on boards with a real PHY interrupt?

phy_drv_supports_irq() returns config_intr && handle_interrupt, so phylib no
longer rewrites phydev->irq to PHY_POLL as it did before this patch.  The
same entry registers .cable_test_start/.cable_test_get_status but sets no
.flags, so PHY_POLL_CABLE_TEST is absent:

include/linux/phy.h:phy_polling_mode() {
	if (phydev->state == PHY_CABLETEST)
		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
			return true;

	if (phydev->drv->update_stats)
		return true;

	return phydev->irq == PHY_POLL;
}

With a valid IRQ and no PHY_POLL_CABLE_TEST this returns false during
PHY_CABLETEST, and phy_start_cable_test() only queues the state machine in
polling mode:

drivers/net/phy/phy.c:phy_start_cable_test() {
	...
	phydev->state = PHY_CABLETEST;

	if (phy_polling_mode(phydev))
		phy_trigger_machine(phydev);
	...
}

The PHY_CABLETEST arm of _phy_state_machine() is the only caller of
drv->cable_test_get_status():

	case PHY_CABLETEST:
		err = phydev->drv->cable_test_get_status(phydev, &finished);

and genphy_c45_oatc14_cable_test_get_status() detects completion purely by
polling:

	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_HDD);
	...
	if (!(ret & OATC14_HDD_VALID))
		return 0;

Nothing in lan867x_revd0_handle_interrupt() signals diagnostic completion, so
does "ethtool --cable-test" now leave the interface with the carrier down and
netif_testing_on() set until phy_stop() aborts the test?  Would adding
.flags = PHY_POLL_CABLE_TEST to this entry, as at803x/qca808x/micrel/
microchip_t1 do when combining .config_intr with cable testing, address it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918143302.76909-1-parthiban.veerasooran%40microchip.com
