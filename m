Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5A4F85B8;
	Thu, 17 Sep 2026 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680301; cv=none; b=pQD5EPFjyeC+4Xian13bn731N+3oVJuQT7yRRceqt1Xk52zIo0o9SzX7ad/Hm8Yc5rU+luXYMGRKxHJpRDeQBAOHJGVztZoT7sHT2ZesostQpi46OMHjesSi+FJNSAxnm/X8/9W/USZM5fggHxhHU/7XEs6hR7mrEbxUgkQqTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680301; c=relaxed/simple;
	bh=/pwZCm1kXBsFAV7WOJgZPP8gOoinseNhlhPmvzLeMCc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eM7J8O8IXjRqioPrTML9muQz63rMiP7lnMfHi9LVGZ6LCflhabkwyldMcQ2Zj7XrygWYUj7u98RnrswqjEw548voLf41o/uihkTnQAP765+JTfZByPo37NkUKjzx9ch0+8hJzpeGIwZIj85APg6p3O1YYDfUM5dXqT7bRR96FqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU6uR/Wc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU6uR/Wc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25411F00893;
	Thu, 17 Sep 2026 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680299;
	bh=Kyvy2i3dArRk/IO7VH0i/VJzSrHT7aPsWEhKgS94XAk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gU6uR/WcaBghYMrvjvvlep6K2aw6XOYw73M29Yws5yYbvaUW0Rwt5j3/Gq/+gl1BP
	 oP+Ykw/wUvn4zPTFkV0fJYFhefii3DwR2zajyh27Q2zU0AzKfXTEY2IpT7LDcNbD0r
	 15NyWPu2/hHJk0+VwQpnNlUEaSHheLIvLZgPwyA77x0EXzPX0JEcsQKizRBHw5xvD8
	 34KduG2BsMaBEZ+JxnWDvukRJU9BLJ3Msl/hKP658kV/Q2u8sI0nrGbt+rbCddVuOJ
	 SrwPWTXb17kUdTG4fGNeuGO01ig9ryzAbVDnS+gZuvB8aUt2F/d1jYL+m0isXaJb/W
	 WazWor9T67NZg==
Subject: Re: [PATCH net-next v12 07/15] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:24:58 +0000
Message-ID: <178968029831.22033.7070310020914026845@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-7-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-7-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] The AX179A EEE control register (AX_GPHY_CTL /
  AX_GPHY_EEE_CTRL) is never forced to a known state, while the driver…
- [Low] In this patch alone, ax88179a_phylink_mac_ops gains
  .mac_enable_tx_lpi/.mac_disable_tx_lpi while ax88179a_phylink_setup()…
- [Low] The changelog of "ax88179_178a: Add EEE configuration support for
  AX88179A MACs" ends with the truncated/incorrect sentence "Add support…
- [Low] At this commit, ax88179a_ethtool_ops
  (drivers/net/usb/ax88179a_devices.c:209) has no .get_eee/.set_eee…

--

ax88179_178a: Add EEE configuration support for AX88179A MACs

This adds mac_enable_tx_lpi and mac_disable_tx_lpi callbacks to
ax88179a_phylink_mac_ops, which write the single AX_GPHY_EEE_CTRL register
of the AX88179A family.  The chip has no LPI timer registers, so the timer
argument is ignored.

A couple of questions below.

> ax88179_178a: Add EEE configuration support for AX88179A MACs
>
>     The AX88179A uses a simple HW configuration for EEE
>     via a single EEE configuration register without LPI timer support
>     Add support for this EEE enable/disable register and replace the EEE.

[Severity: Low]
The last sentence looks unfinished: "Add support for this EEE
enable/disable register and replace the EEE."  What is being replaced?
The diff is purely additive (17 insertions, no deletions) and
ax88179a_devices.c has no prior EEE handling apart from the
eee_enabled_default assignment in ax88179a_phylink_setup().

Also, the subject and body mention only AX88179A MACs, but
ax88179a_phylink_mac_ops is the single ops table passed to
phylink_create() by ax88179a_phylink_setup() for every chip handled by
this file, including AX88772D/E and AX88279.  Could the message state
that these chips share the same single-register EEE semantics?

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 5dac7a137c323..785919e14e861 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -384,10 +384,27 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
>  }
>  
> +static void ax88179a_mac_disable_tx_lpi(struct phylink_config *config)
> +{
> +	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
> +
> +	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
> +}

[Severity: Medium]
Is AX_GPHY_EEE_CTRL ever brought to a known state at bind or reset?

Neither ax88179a_bind() nor ax88179a_reset() writes AX_GPHY_EEE_CTRL, and
these two new callbacks are its only writers.  Meanwhile
ax88179a_phylink_setup() tells phylink that EEE is off:

	if (!data->is_ax88772d) {
		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
		data->phylink_config.eee_enabled_default = false;
	}

phylink cannot clear it either, because the disable path only runs for a
bit phylink itself set:

drivers/net/phy/phylink.c:phylink_deactivate_lpi() {
	if (pl->mac_enable_tx_lpi) {
		pl->mac_enable_tx_lpi = false;
		...
		pl->mac_ops->mac_disable_tx_lpi(pl->config);
}

So if the chip or firmware power-on default of AX_GPHY_EEE_CTRL is
"enabled", does the MAC stay in LPI mode while phylink and ethtool
--show-eee report EEE as disabled?

The older MAC path in this driver does force the state explicitly:
ax88179_reset() calls ax88179_disable_eee().  lan78xx does the same by
clearing MAC_CR_EEE_EN_ during probe, and lan78xx_mac_enable_tx_lpi()
documents that it relies on that.  Would an explicit write of
AX_GPHY_EEE_CTRL to false in ax88179a_reset() be appropriate here?

> +
> +static int ax88179a_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
> +{
> +	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
> +
> +	/* AX88179A does not provide LPI timer registers */
> +	return ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, true, 0, NULL);
> +}
> +
>  static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
>  	.mac_config = ax88179a_mac_config,
>  	.mac_link_down = ax88179a_mac_link_down,
>  	.mac_link_up = ax88179a_mac_link_up,
> +	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
> +	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
>  };

[Severity: Low]
With this commit applied on its own, does registering these two callbacks
have the opposite effect of what is intended?

ax88179a_phylink_setup() sets lpi_capabilities but leaves
phylink_config.lpi_interfaces zeroed (the config is zero-allocated in
ax88179a_bind()), and phylink gates all MAC EEE handling on that bitmap:

drivers/net/phy/phylink.c:phylink_create() {
	pl->mac_supports_eee = pl->mac_supports_eee_ops &&
			       pl->config->lpi_capabilities &&
			       !phy_interface_empty(pl->config->lpi_interfaces);
}

So mac_supports_eee_ops becomes true while mac_supports_eee stays false.
ax88179a_mac_enable_tx_lpi() is then unreachable, since phylink_link_up()
only calls phylink_activate_lpi() when pl->mac_supports_eee, and
phylink_bringup_phy() takes this branch instead:

	} else if (pl->mac_supports_eee_ops) {
		/* MAC supports phylink EEE, but wants EEE always disabled. */
		phy_disable_eee(phy);

This resolves later in the same series: the following patch,
"ax88179_178a: Add EEE configuration support for AX88179A PHYs", adds the
memcpy() of supported_interfaces into lpi_interfaces in
ax88179a_phylink_setup(), after which mac_supports_eee becomes true.  Is
it worth folding that lpi_interfaces initialisation into this patch so the
intermediate state does not force PHY EEE off?

[Severity: Low]
In the same vein, at this commit ax88179a_ethtool_ops has no .get_eee or
.set_eee, and eee_enabled_default is false, so nothing can set
pl->eee_cfg.tx_lpi_enabled and ethtool EEE requests are rejected by the
core.

The following patch in the series adds ax88179a_get_eee() and
ax88179a_set_eee() forwarding to phylink_ethtool_get_eee() and
phylink_ethtool_set_eee() and wires them into ax88179a_ethtool_ops, so the
user-visible path only appears there.  Would it read better to add the
ethtool plumbing together with the callbacks that it drives?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
