Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021C49EC76;
	Mon, 14 Sep 2026 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417496; cv=none; b=c2YzW+fBLCTOcun+f4U/wNCuI7iS/bu01Ko52P77N3b7C/Gj7KnHYOgsh7D3WY72YvtytOVYgdXW50ZjqnEx2tDpug1ag1CJ7cd6XcX50qydSAkGdXHbIsMHhaRP7aZa5Mw8FdYiuOFiP7cFAodvtN5aAtpT2i6qJMZ6Bf9bKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417496; c=relaxed/simple;
	bh=YpOn+iA1MLOzWHJTu2Tk1TYaASk3eTRTiuPjsXIa82A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qn+sd5D6EJpoH0m6+efPcvGqXKmvpVQyNzFMP65CftieefPLApd9GHsODMt5L1RoVoYnm6FwrBEwdw3l08QbqNOHa8C68uQcOHjNq2IpBHMVAG5i3DYvvF9IjW5Sd3HE3psI19LK9PglkEo7fOb80N0ax5vzF9gkC8oiMRyjWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT5bx3ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT5bx3ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057D01F00898;
	Mon, 14 Sep 2026 20:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417487;
	bh=2RoJd8ruCeOMjv7whikitY82kCP+TLKSSzWDnjVuejo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FT5bx3ij689sQ+HZYCl+7q0vCyYLKB4UxUcVCS7L0ji+eszqTc7E7ktVeZZWKCKJI
	 FEBy3SgecMakPhYJDL7MunVofR6CdVFLJxlECCUECzmcKsMlr1ONj2KYAGdTon1eDP
	 kadSP6fMryKbRj1kuf4kENtT5Qi6x6dSQjL9wIHFl1hIKb/P6TmifBlFo3SxgM4eny
	 QeNKuQgqYEw4EntXJ3KD4dobstFtAJYELI0Kqq6XHmJDi8Vg2iPG3AEUSXo4O4+F8V
	 DXLhlj7zJyA4kzREtOlInvVL4sy4zB4r07wL5HysuvHOClY92SuKkS1iE2nH59hDmB
	 rcPebAsonsrTQ==
Subject: Re: [PATCH net-next v5 06/11] net: pcs: xpcs: add ANRESTART support
 for SGMII link recovery
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org,
 linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Date: Mon, 14 Sep 2026 20:24:45 +0000
Message-ID: <178941748560.22033.7667125492368880786@kernel.org>
In-Reply-To: <20260913185849.907479-7-coiaprant@gmail.com>
References: <20260913185849.907479-7-coiaprant@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 4 · Low: 0

- [High] In xpcs_get_state_c37_sgmii() the combination
  'DW_VR_MII_AN_STS_C37_ANCMPLT_INTR set + DW_VR_MII_C37_ANSGM_SP_LNKSTS…
- [Medium] Undisclosed functional change: besides the two BMCR_ANRESTART
  additions the commit message advertises, the patch adds a new…
- [Medium] Device-specific quirk applied unconditionally: the commit
  message and the new comment at drivers/net/pcs/pcs-xpcs.c:776-781…
- [Medium] Wrong ordering in xpcs_get_state_c37_sgmii(): the latched AN-
  complete indication is consumed (xpcs_write(DW_VR_MII_AN_INTR_STS, 0),…
- [Medium] The patch turns the read-only-by-contract pcs_get_state()
  callback into a hardware-state-changing operation (BMCR read-modify-…

--

net: pcs: xpcs: add ANRESTART support for SGMII link recovery

The patch sets BMCR_ANRESTART together with BMCR_ANENABLE when
xpcs_config_aneg_c37_sgmii() enables in-band AN, and makes
xpcs_get_state_c37_sgmii() clear DW_VR_MII_AN_INTR_STS and assert
BMCR_ANRESTART when the link is down with AN completion latched.  A new
comment explains that the DesignWare databook says AN restart is not
needed for MAC side SGMII, but that some parts (Rockchip RK3568) need it.

A few questions below.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 0337e2bcc0125..8c3875b6985b9 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -769,7 +771,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
>  	 *	 SR_MII_AN_ADV. MAC side SGMII receives AN Tx Config from
>  	 *	 PHY about the link state change after C28 AN is completed
>  	 *	 between PHY and Link Partner. There is also no need to
> -	 *	 trigger AN restart for MAC-side SGMII.
> +	 *	 trigger AN restart for MAC-side SGMII on most devices.
> +	 *
> +	 * Note: While the DesignWare databook states that AN restart is
> +	 *	 not needed for MAC side SGMII, some implementations (e.g.
> +	 *	 Rockchip RK3568) exhibit a timing quirk when integrated with
> +	 *	 phylink and do not restart AN automatically when the link
> +	 *	 comes back up. An explicit AN restart is required on those
> +	 *	 parts to recover the link after a disconnect.
>  	 */

[Severity: Medium]
The comment says the restart is only "required on those parts" and that
there is "no need to trigger AN restart for MAC-side SGMII on most
devices", and the commit message says "This is not a fix for an existing
mainline platform".  The code, however, applies the restart on every
device: no gate on xpcs->info.pma or xpcs->desc, and struct dw_xpcs gains
no quirk flag.

The same function already uses that gating idiom a few lines below:

	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
		mask |= DW_VR_MII_AN_CTRL_8BIT;
		val |= DW_VR_MII_AN_CTRL_8BIT;
		/* Hardware requires it to be PHY side SGMII */
		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;

Note that this TXGBE case is configured as PHY-side SGMII, which the
MAC-side/RK3568 rationale in the comment does not cover.

Should the new restart be gated on the affected PMA (or on a new dw_xpcs
quirk flag) so the code matches what the comment and the commit message
describe?

Also, phylink already has a path for this: pcs_config() may return a
positive value to ask phylink to call .pcs_an_restart, and
xpcs_an_restart() in this same driver performs exactly the same register
write:

	xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
		    BMCR_ANRESTART);

Would using that framework path be preferable to open-coding the restart
in the config and get_state callbacks?

> @@ -816,9 +825,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Clear CL37 AN complete status */
> +	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +	if (ret < 0)
> +		return ret;
> +

[Severity: Medium]
The commit message describes the change as "Add BMCR_ANRESTART in two
places" plus a comment update, but this hunk adds a third functional
change that is only visible as item "5)" in the in-code numbered list.

This write is unconditional: it runs for every xpcs_config() ->
xpcs_do_config() -> xpcs_config_aneg_c37_sgmii() call and for every
neg_mode, including PHYLINK_PCS_NEG_OUTBAND where no AN is subsequently
enabled.  It clears the register that xpcs_get_state_c37_sgmii() uses as
its only source of link/speed/duplex and of state->an_complete:

	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);

It also changes the value returned when neg_mode is not
PHYLINK_PCS_NEG_INBAND_ENABLED: the function now returns the result of
this AN_INTR_STS write instead of the DIG_CTRL1 modify.

Could the commit message mention this status clear and the return value
change?  For reference, xpcs_config_aneg_c37_1000basex() already performs
the identical clear, so the write itself matches existing driver practice.

>  	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
>  		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
> -				 mdio_ctrl | BMCR_ANENABLE);
> +				 mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTART);
>  
>  	return ret;
>  }
> @@ -1093,9 +1107,18 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
>  		return 0;
>  	}
>  
> -	/* Clear AN complete status or interrupt */
> -	if (state->an_complete)
> -		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +	if (state->an_complete) {
> +		/* Clear AN complete status or interrupt */
> +		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Initiate the next round of AN */
> +		ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
> +				  BMCR_ANRESTART);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: High]
Is the trigger condition here really "stuck AN"?  The state reached at
this point is ANCMPLT latched with LNKSTS clear, taken from the same
register read:

	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;

	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
		...
		return 0;
	}

For C37/SGMII, isn't that the normal steady state whenever the partner
PHY's media side is down?  The PHY keeps sending config words, the SGMII
AN exchange completes and latches ANCMPLT (bit 0), and the media link
state is carried separately in the received config word via LNKSTS
(bit 4), per pcs-xpcs.h:

	#define DW_VR_MII_AN_STS_C37_ANCMPLT_INTR	BIT(0)
	...
	#define DW_VR_MII_C37_ANSGM_SP_LNKSTS		BIT(4)

If so, then on an unplugged port each restart re-completes within the AN
link timer with LNKSTS still 0 and re-latches ANCMPLT, so the condition
re-arms itself and a fresh AN restart is issued on every poll,
indefinitely.  phylink polls pcs_get_state once per second and
xpcs->pcs.poll is true for everything except WX_TXGBE and MP_FBNIC, so
this affects the existing DW_AN_C37_SGMII users (stmmac/Intel mGbE, NXP
SJA1105/SJA1110, Wangxun), not only RK3568.

Two further consequences: with MAC_AUTO_SW armed, the hardware-selected
speed/duplex is dropped on each cycle, and because the whole status word
is cleared by writing 0, a restart that lands on a just-latched LNKSTS=1
word destroys that link-up indication and costs an extra poll interval.

For the interrupt-driven case there may also be a faster loop.  The SGMII
AN_CTRL modify in xpcs_config_aneg_c37_sgmii() does not include
DW_VR_MII_AN_INTR_EN in its mask, while the 1000BASE-X path sets it:

	if (!xpcs->pcs.poll) {
		mask |= DW_VR_MII_AN_INTR_EN;
		val |= DW_VR_MII_AN_INTR_EN;
	}

so an enable programmed by a previous 1000BASE-X configuration persists
into SGMII mode.  On txgbe the AN event is routed to the link IRQ:

drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c:txgbe_misc_irq_handle() {
	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
		    TXGBE_PX_MISC_ETH_AN)) {
		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
	...
}

which ends in phylink_pcs_change() -> pcs_get_state(), so the restart can
be re-triggered at hardware rate rather than once per second.

Would gating this on the affected PMA/quirk, or on an explicit "AN is not
active" hardware condition rather than on the latched AN-complete bit,
address this?

[Severity: Medium]
Is the ordering here recoverable if the second access fails?  The latched
AN-complete indication is consumed by the xpcs_write(DW_VR_MII_AN_INTR_STS,
0) before the fallible read-modify-write that actually starts the next
negotiation.

If the write succeeds and the xpcs_modify() of MII_BMCR fails on the
register back-end, the only indication that AN completed is gone and no
new negotiation was started.  The block that would retry is itself gated
on state->an_complete, which is now read back as 0, so the restart is
never attempted again.  The error only reaches xpcs_get_state(), which
logs it from a void callback:

		ret = xpcs_get_state_c37_sgmii(xpcs, state);
		if (ret)
			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
				"xpcs_get_state_c37_sgmii", ERR_PTR(ret));

and nothing records a pending restart.  This matters most on the hardware
this patch targets, where AN is not restarted automatically, so the port
would stay down until a fresh pcs_config().  The failure is plausible for
these vendor-MMD accesses: the RK3568 back-end added later in this series
returns errors from pm_runtime_resume_and_get() inside
xpcs_rk_write_reg()/xpcs_rk_read_reg().

Would asserting BMCR_ANRESTART before clearing the status word, or
retrying independently of the latch, close this window?

[Severity: Medium]
This makes pcs_get_state() change hardware state rather than only read it,
and phylink calls that callback from contexts with no common lock.

phylink_resolve() holds pl->state_mutex (and the phy locks) but not RTNL,
while these two callers hold only RTNL:

drivers/net/phy/phylink.c:phylink_ethtool_ksettings_get() {
	...
		phylink_mac_pcs_get_state(pl, &link_state);
	...
}

drivers/net/phy/phylink.c:phylink_mii_read() {
	...
			phylink_mac_pcs_get_state(pl, &state);
	...
}

The lockset intersection is empty, and the driver holds no private lock,
so two CPUs can run this block at once and both assert BMCR_ANRESTART,
aborting each other's negotiation.  It can also interleave with the
multi-transaction BMCR sequence in xpcs_config_aneg_c37_sgmii(), which
reads BMCR, writes it with ANENABLE cleared, programs AN_CTRL/DIG_CTRL1,
clears AN_INTR_STS, and finally writes the cached value back:

	mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
	...
		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
				 mdio_ctrl & ~BMCR_ANENABLE);

Each xpcs_read/xpcs_write is a separate bus transaction, so an AN restart
can land while AN is disabled and the AN configuration is only half
applied.

Both RTNL-only paths need the PCS-only case (no phydev), which is
reachable for inband SGMII without a PHY, and SIOCGMIIREG and
ETHTOOL_GLINKSETTINGS are unprivileged.  Before this patch these paths
only cleared the AN status word; should the restart be moved to a context
that is serialized with pcs_config(), such as the .pcs_an_restart op?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913185849.907479-1-coiaprant%40gmail.com
