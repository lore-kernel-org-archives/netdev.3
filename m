Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E436A36B;
	Mon,  5 Oct 2026 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235947; cv=none; b=NvTRrw7GXQU9XKCq6KrqaAlsgGs9/23EhXANkNq0XdCbbnxglAIaiHobdO4Lt2J+XtRZegAvWlDt+Fmz4saBL+rPIN4phnXQu/xtXdh0YGJI/1SN4G44E5n/oZ2JY+iBY830qaOggzeEQzXmBkCVnAd2E9qinwLoHCbvmUf4I4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235947; c=relaxed/simple;
	bh=TDcZCddBf9AsiMRxk2IreZ5YIpQb9+kgqNRD7MI57WU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXg/B9PAKuVPjYn5LYHhYR3NQoOIW4Q8592sqwY927swIqK1xfVO4UUui497fmRAOSa0IJMfxN0/hd2g3OBJHwMn14ouNxT+7d51XtFxaELUZSG3DPvsMU+vLX+Kt2IUayHLN1JP645RnIo+Wpp/JsvMNR8fKIMxR+8Iu55wVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJgvzsyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJgvzsyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874BF1F000FF;
	Mon,  5 Oct 2026 21:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235946;
	bh=Jiw19YMNcmn444avbsXXHPsf83UFaK2Hh1UK0pvmjbw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jJgvzsyuqa3AXZ7H4IL+2rMuygGeyVzRFeOcRrDnv0EJthfJU3z13wNXTTWTRHM7s
	 jLbN719eAlQtQb2Z2vvXrYSKJ0P3xX55bUALx+tGbvKvkO/kDeT3xH+eRmBYEEM1fA
	 Vzi+rVIJ68rsaiJALe57kTFPMgUxvhMdAjiu0kPzg/lPSKR3uJuCJ8qk0DZWKzM+u/
	 QOsQjY8tZnxi4QCZpUsaWJEvtQmtGCPAAQgv5p5HSWvQAeu37Qej6FCuCrq8L5TAog
	 dfjCopnQolBq7QnUVjOy8MMw8rBmzXOWU8tSNWcZ39heFpDjzrEXEGt2wv5BiHvXdb
	 GEJfgNsuTzdBQ==
Subject: Re: [PATCH net v2] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, michael@stapelberg.de,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 21:32:25 +0000
Message-ID: <179123594509.434549.641674895146976264@kernel.org>
In-Reply-To: <20261004204516.281201-1-rosenp@gmail.com>
References: <20261004204516.281201-1-rosenp@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds a second source of truth for WoL.
- [High] phy: marvell: m88e1318_config_intr writes WOL_EIE to wrong page
  on 88E1510
- [Medium] m88e1318_config_intr() reads priv->wol_armed (marvell.c:451)
  without any lock, then overwrites the whole CSIER register with…
- [Low] m88e1318_set_wol() updates priv->wol_armed only at the very end
  (marvell.c:2173), after all page 0/3/17 accesses have succeeded.

--

net: phy: marvell: keep WOL_EIE across interrupt reconfiguration

This patch gives the 88E1318S and 88E1510 PHYs their own config_intr. It
sets CSIER.WOL_EIE from a new driver-private wol_armed flag, so
phy_init_hw() on resume no longer clears it on polled PHYs. It also adds a
handle_interrupt that claims the WoL event, and m88e1318_set_wol() now
clears WOL_EIE when WoL is fully disabled.

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa884062..46527abab6af8 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c

[ ... ]

> @@ -425,6 +426,83 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
>  	return IRQ_HANDLED;
>  }
>  
> +/*

[ ... ]

> + * WOL_EIE is derived from the driver's own WoL state rather than read
> + * back from the PHY, so a bit left armed by the bootloader or a
> + * previous kernel is cleared at probe/init instead of carried over.
> + */
> +static int m88e1318_config_intr(struct phy_device *phydev)
> +{
> +	struct marvell_priv *priv = phydev->priv;
> +	u16 wol_eie = 0;
> +	int err;
> +
> +	if (priv->wol_armed)
> +		wol_eie = MII_88E1318S_PHY_CSIER_WOL_EIE;

[Severity: High]
Could this flag end up disagreeing with what m88e1318_get_wol() reports?

priv->wol_armed starts out false from devm_kzalloc() in marvell_probe(),
and only a successful set_wol sets it. m88e1318_get_wol() still reports
from the hardware WOL_CTRL register:

m88e1318_get_wol() {
    ...
	ret = phy_read_paged(phydev, MII_MARVELL_WOL_PAGE,
			     MII_88E1318S_PHY_WOL_CTRL);
    ...
	if (ret & MII_88E1318S_PHY_WOL_CTRL_MAGIC_PACKET_MATCH_ENABLE)
		wol->wolopts |= WAKE_MAGIC;
    ...
}

WOL_CTRL can still have match enables set at probe. A bootloader can leave
them set. So can a previous kernel (kexec, or a warm reboot without a PHY
reset), or an earlier bind of this driver (unbind/rebind, rmmod/insmod).

In that case, both of these paths write CSIER without WOL_EIE:

phy_probe()->phy_disable_interrupts()->m88e1318_config_intr()
phy_attach_direct()->phy_init_hw()->m88e1318_config_intr()

Meanwhile get_wol keeps reporting WAKE_MAGIC.

phy_drv_wol_enabled() then treats WoL as active, so phy_suspend() returns
-EBUSY and keeps the PHY powered. Nothing reaches INTn, though, and the
board does not wake.

Running "ethtool -s ethX wol g" doesn't seem to fix this either.
ethnl_set_wol() starts from get_wol, sees no change, and returns before
calling set_wol:

	if (!mod)
		return 0;

so wol_armed stays false.

Writing 0 to this register at probe time isn't new. But the commit message
describes this same symptom:

  "m88e1318_get_wol() still reported WAKE_MAGIC, but a matched magic
  packet was no longer routed to INTn and the board did not wake"

It also says stale bootloader or previous-kernel state is "cleared at
probe". Only WOL_EIE is cleared, though, and WOL_CTRL is left alone.

Should get_wol and config_intr use one source of truth? Some options:

- get_wol could report from wol_armed.
- The WOL_CTRL match enables could be cleared when wol_armed is false.
- config_intr could derive WOL_EIE from the hardware state.

> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		err = marvell_ack_interrupt(phydev);
> +		if (err < 0)
> +			return err;
> +
> +		err = phy_write(phydev, MII_88E1318S_PHY_CSIER,
> +				MII_M1011_IMASK_INIT | wol_eie);
> +	} else {

[Severity: High]
Does this reach the copper page when an 88E1510 is running a fiber
link?

phy_write() and phy_read() go to whichever page is currently
selected. m88e1318_set_wol() explicitly switches to
MII_MARVELL_COPPER_PAGE before touching WOL_EIE, since that is where
the WoL interrupt enable and the latched WoL event bit live.
m88e1318_config_intr() and m88e1318_handle_interrupt() don't do
that.

The 88E1510 entry has PHY_GBIT_FIBRE_FEATURES, and
marvell_read_status() deliberately leaves the PHY on
MII_MARVELL_FIBER_PAGE when the fiber link is up. It returns early
without switching back. After that, these two functions access
registers 0x12 and 0x13 of the fiber page instead of CSIER and
IEVENT on the copper page.

That defeats two of the cases this patch sets out to handle:

- With a PHY interrupt, phy_free_interrupt() on ifdown calls
  config_intr to drop WOL_EIE before the handler goes away. On the
  fiber page that write misses, and the copper CSIER keeps WOL_EIE
  set. That leaves a latched WoL event with nobody to clear it,
  which the comment in the disable path is trying to prevent.

- While the handler is installed, a WoL event latched on the copper
  page is neither seen nor cleared by the IEVENT read in
  m88e1318_handle_interrupt(). It returns IRQ_NONE while INTn stays
  asserted, and on a level-triggered line this repeats until the
  core disables the interrupt as "nobody cared".

The old marvell_config_intr() and marvell_handle_interrupt() have the
same dependence on the selected page, but the WoL handling added here
only works if these accesses land on the copper page. Should the
WOL_EIE update and the IEVENT read go through phy_write_paged() and
phy_read_paged() with MII_MARVELL_COPPER_PAGE, the way
m88e1318_set_wol() does? If so, how should the fiber page interrupt
enable and status registers be handled, since the current code ends
up touching those when the fiber page is selected?

[ ... ]

> +		if (phy_interrupt_is_valid(phydev))
> +			wol_eie = 0;
> +
> +		err = phy_write(phydev, MII_88E1318S_PHY_CSIER, wol_eie);

[Severity: Medium]
Can these whole-register writes race with m88e1318_set_wol()?

m88e1318_config_intr() reads priv->wol_armed without holding a lock, and
phy_write() only takes the MDIO bus lock for that one access.

m88e1318_set_wol() runs under phydev->lock (taken by
phy_ethtool_set_wol()) and the MDIO bus lock (taken by phy_save_page()).
phy_init_hw() takes neither.

On mv643xx_eth, the driver named in the Fixes tag, tx_timeout_task() runs
from a workqueue without RTNL or phydev->lock:

tx_timeout_task()->port_start()->phy_init_hw()->m88e1318_config_intr()

So it can run at the same time as:

mv643xx_eth_set_wol()->phy_ethtool_set_wol()->m88e1318_set_wol()

For a polled PHY:

config_intr                        set_wol
reads wol_armed == false
                                   sets WOL_EIE, routes LED[2] to INTn,
                                   enables magic match,
                                   wol_armed = true
phy_write(CSIER, 0)

get_wol then reports WAKE_MAGIC while WOL_EIE is clear, which is the
failure this patch sets out to fix. If the order is reversed and the
ethtool command is "wol d", WOL_EIE stays armed after WoL was disabled.

wol_armed is also a plain bool. It is written under phydev->lock and the
MDIO bus lock but read with no lock, which KCSAN would report as a data
race.

There are two ways to avoid this:

- Update only the IMASK_INIT bits with phy_modify(), so that only set_wol
  ever touches WOL_EIE.
- Serialize the snapshot and the write against set_wol.

> +		if (err < 0)
> +			return err;

[ ... ]

> @@ -2074,6 +2153,25 @@ static int m88e1318_set_wol(struct phy_device *phydev,
>  			goto error;
>  	}
>  
> +	if (!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY))) {

[ ... ]

> +	}
> +
> +	/* Let m88e1318_config_intr() re-arm CSIER.WOL_EIE, or keep it
> +	 * cleared once WoL is disabled.
> +	 */
> +	priv->wol_armed = !!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY));
> +
>  error:
>  	return phy_restore_page(phydev, oldpage, err);
>  }

[Severity: Low]
What value does wol_armed keep if an MDIO access fails partway through
m88e1318_set_wol()?

The flag is only updated when every access succeeds. Any earlier failure
jumps to error:, which skips the update and doesn't roll back the
registers already written.

On the enable path, CSIER.WOL_EIE, LED_TCR and the WOL_CTRL magic match
enable may already be set while wol_armed stays false:

		err = __phy_set_bits(phydev, MII_88E1318S_PHY_WOL_CTRL,
				     MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS |
				     MII_88E1318S_PHY_WOL_CTRL_MAGIC_PACKET_MATCH_ENABLE);

get_wol then reports WAKE_MAGIC, but the next m88e1318_config_intr()
writes CSIER without WOL_EIE. If the user retries with the same mode,
ethnl_set_wol() skips the call because get_wol already matches.

On the disable path, the WOL_CTRL enables may already be cleared while
wol_armed is still true from an earlier enable. The next config_intr then
re-arms WOL_EIE.

The missing rollback was already there before this patch. What the patch
adds is that later config_intr calls now act on the stale flag.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004204516.281201-1-rosenp%40gmail.com
