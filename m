Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274717;
	b=qWLF0JxIIoCtJzAw23cEjpicl7wnSMAL/8FOYdD3IbK7ascs0RKv0l3qaHbDsSS8KyLn
	 G5xITert2g4W1SOG0zgnirmlBJbWU21xshAhh2RH0ADOrchVNqijOrxWwJdYzfdJBHA7R
	 CGwiV5dXTQySS7KQ75yOE+rvHQEhw42GSvppf5Q1L9UCijrtiSj52POXePSYgRZ2psobG
	 738g6wUA114hANDKKGS4S0Easj3lJhK3wc33uGt/rvsYT3WxCIQ7dEr3JDdY9UqNneslg
	 1rv3cEu66MNFprl9XXn2XbbQcgi3K/ZbMVXn0hdqCpPJJ0GKpiJn326mIu8Wky49/qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274717;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mgZWax0CROPTd0jbS/MexNgXxV705CGMTqZEFbzUWic=;
	b=kjs9DAS0oyr/tOm4YWn8ZpQFaTJRw6JcqDJD5woVZb15COMm9ZpWEPrck+g5sTbGerJk
	 3/iYhDrwEmo4Rl7+87EQGH2X49PlF6q2+Bf2WLBiMGIBqTZpmNQ80PjeXtouMFjiANiMy
	 f8mOI1XfCefyRza03l5FW5xzAIwygVZni7guN6mqU6qWTgyaJTOgsa+yL1YtmBlqX6gZ2
	 ieruWt/ErPCt3ydoCkrFf1Ko3WfYmh6dElUm/yL00bq/I7QsDLTEXB8CFhVJexpfQO3WB
	 wWT+Dc8r6wGqDPmSfJqPIP4+IXtr5b1+z5IiA5S8VLLDucpkmPmC/L8jYwBzaELNk6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6ZVy11U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F460A6F59;
	Tue, 10 Nov 2026 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6ZVy11U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37001F00901;
	Tue, 10 Nov 2026 01:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274716;
	bh=mgZWax0CROPTd0jbS/MexNgXxV705CGMTqZEFbzUWic=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g6ZVy11UqhrRhTWPfoRAJn5l992aRTZOg4P1jBrp7xZQGlEFF/451z3Mpzj3x/mZr
	 02Ed6nmE7riDabHLRGfa4x9fx6u+D+pSgHtqxyDxmMsihQAs8QmTEcgHfMR3PzFEk9
	 Nh91NDhGQnoVsRsN3tzyaH2YEortqm8+rKHGBGVuhbgHTQWTQ+G753o0eiVFwkWvI3
	 3FI1BMxrRPv5K7nhdD4sHKqfcwb8DOmgFpvsjOUEVbuqxRuWW4Xv5tQHt99ldZgpPx
	 JQyshGvMZ82yk3CH1ThgrAGzf/K1ZrUdadIVIU35r7wvK4OqzT8BWJCHzzD1KYCbFY
	 Sc5yIhdGKZs8A==
Subject: Re: [PATCH net-next v20 06/13] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:35 +0000
Message-ID: <179427471542.994134.8751513782745732734@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-6-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-6-37b5a1189983@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch fills phylink_config.lpi_interfaces in
  ax88179a_phylink_setup() (drivers/net/usb/ax88179a_devices.c).
- [Low] The new ax88179a_set_eee()
  (drivers/net/usb/ax88179a_devices.c:235-240) passes the user's struct…

--

ax88179_178a: Add EEE configuration support for AX88179A PHYs

This commit copies supported_interfaces into phylink_config.lpi_interfaces
in ax88179a_phylink_setup(), so phylink now treats the MAC as supporting
EEE. It also adds get_eee/set_eee ethtool ops that forward to
phylink_ethtool_get_eee() and phylink_ethtool_set_eee().

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 62619fd68c408..272e923656832 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -225,6 +225,20 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
>  		return AX88179A_EEPROM_LEN;
>  }
>  
> +static int ax88179a_get_eee(struct net_device *net, struct ethtool_keee *edata)
> +{
> +	struct ax88179_data *ax179_data = netdev2data(net);
> +
> +	return phylink_ethtool_get_eee(ax179_data->phylink, edata);
> +}
> +
> +static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
> +{
> +	struct ax88179_data *ax179_data = netdev2data(net);
> +
> +	return phylink_ethtool_set_eee(ax179_data->phylink, edata);
> +}

[Severity: Low]
Should ax88179a_set_eee() reject a tx_lpi_timer that the hardware cannot
apply?

Neither ax88179a_set_eee() nor phylink_ethtool_set_eee() checks
edata->tx_lpi_timer. The value is stored in pl->eee_cfg and
phydev->eee_cfg, and get_eee reports it back. The MAC callback ignores
the timer, though:

drivers/net/usb/ax88179a_devices.c:ax88179a_mac_enable_tx_lpi() {
    ...
	/* AX88179A does not provide LPI timer registers */
	return ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, true, 0, NULL);
}

The phylink_mac_ops documentation for mac_enable_tx_lpi() says
"Configure the LPI timeout accordingly".

As a result, "ethtool --set-eee ethX tx-timer N" succeeds and
"--show-eee" reports N, but the hardware never uses it.
phylink_config.lpi_timer_default is never set either, so the reported
default timer is 0.

Other drivers whose LPI timer cannot be changed reject this request.
e1000e_set_eee() and ixgbe_validate_keee() both return an error when
tx_lpi_timer differs from the fixed value.

Could the wrapper do the same here? Another option is to set
lpi_timer_default to the real hardware value and refuse changes. The
last commit in the series still has this code unchanged.

> +
>  static const struct ethtool_ops ax88179a_ethtool_ops = {

[ ... ]

> @@ -451,6 +467,10 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
>  		phy_if_mode = PHY_INTERFACE_MODE_SGMII;
>  	}
>  
> +	memcpy(data->phylink_config.lpi_interfaces,
> +	       data->phylink_config.supported_interfaces,
> +	       sizeof(data->phylink_config.lpi_interfaces));
> +

[Severity: Medium]
Does this change the default EEE advertisement on the wire for every
non-AX88772D chip, including AX88279?

Before this patch lpi_interfaces was empty. phylink_create() therefore
set mac_supports_eee to false while mac_supports_eee_ops was true, and
phylink_bringup_phy() called phy_disable_eee().

With lpi_interfaces filled in, mac_supports_eee becomes true. This
earlier setup also applies:

	if (!data->is_ax88772d) {
		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
		data->phylink_config.eee_enabled_default = false;
	}

So pl->eee_cfg.eee_enabled is false, and phylink_bringup_phy() takes
neither branch that changes the PHY's EEE enable:

drivers/net/phy/phylink.c:phylink_bringup_phy() {
    ...
	if (pl->mac_supports_eee) {
		...
		if (pl->eee_cfg.eee_enabled)
			phy_support_eee(phy);
		...
	} else if (pl->mac_supports_eee_ops) {
		/* MAC supports phylink EEE, but wants EEE always disabled. */
		phy_disable_eee(phy);
	}
    ...
}

phydev->eee_cfg.eee_enabled keeps the value phy_probe() derived from the
PHY's power-on advertisement:

	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);

If the internal GPHY advertises EEE at reset, genphy_c45_an_config_eee_aneg()
will keep advertising the 100FD/1000FD EEE modes on every autoneg. That
includes after the PHY power-cycle in resume and reset. The link partner
then negotiates EEE while MAC TX LPI stays off.

The legacy ax88179_178a.c reset path explicitly disables EEE and clears
the EEE advertisement. That suggests this family does advertise EEE by
default, but this was not confirmed for the AX88179A/AX88279 PHYs.

This also seems to conflict with the comment in ax88179a_reset():

	/* Ensure EEE state is off, consistent with phylink setup */
	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);

That only clears the MAC-side LPI control. phylink_ethtool_get_eee()
would then report the PHY's eee_enabled as true together with
tx_lpi_enabled as false, which does not match phylink's own eee_cfg.

Was this default change intended? If not, should the PHY's EEE
advertisement be disabled explicitly when eee_enabled_default is false?

The commit message also does not mention that AX88279 gets
phylink-managed EEE (lpi_capabilities is set for all !is_ax88772d chips).
Nor does it mention that AX88772D now has get_eee/set_eee ops that always
return -EOPNOTSUPP. The final commit in the series has the same code, so
nothing later in the series changes this.

>  	phylink = phylink_create(&data->phylink_config, dev->net->dev.fwnode,
>  				 phy_if_mode, &ax88179a_phylink_mac_ops);
>  	if (IS_ERR(phylink))

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
