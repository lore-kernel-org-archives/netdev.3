Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299670;
	b=qfjLz72zhxbQ95rxMBkOViFQZypexw0whlYhWEJF7TQx2Xm5ws4J6lW7SdQ0uJEpA/xI
	 JykVcHTJ+HSTHuTcT4hRdARZ417bfg30fyYA9UqzZ5Qq2dH+NoymYkli+ZM9eeSTnsJH5
	 UmCI3a8ENr1wF7Zvp/Juxi3mJs8e6MKJChcuoA41+R5+d+LQiKXSzFuimPtuRfYElqT2O
	 Htk1luFfweMO2aBpcuzBGV71tRH9K8Q/c3zLk2YDSVOAajo/jZDWKsttr95Woa6KkpWLz
	 wi82s8fojVZOFJOqyFDap88e0BPFXJgq1C/PNZ1EYEwJiPMIwcYvMKpoxJWh2/UrT7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299670;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IoHg76qdWGX0YXGKv6gKymH4VgSnyA022n4X6S0GYTU=;
	b=a/2VMteUMKVqlTjv9Y9c3qr1BEgilj9AmNIBRXuoFQaqM3PWabgHW/gbJUg+V1vd+hZ6
	 DsuV7fEvw9iTjhSuwzBv2pDCD8hb5Mp+RM/iKtyZB93S2NeQ84dmf0CNTSybZqVe2ddue
	 euU2NjEoUMm/yQySGaFdhLiBOge9PcpcF6dfymNfMlHA30xpkuqrkKtQ+2+k1y3PKWa/t
	 8uJxLHQ9ED5Q+ZTBx2g3vPgz+YVKUIc8n3MSLqMXwwEvxwocVhEIOgFXfTRVjKXQsfak0
	 jGRwSGFhpLXiqxJDq/+N2qxRgKFmEY/jfp8Ch6QkrD9GO+QFs/TySb768uKecIBa5AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxqFF+xr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD0606A321;
	Tue, 10 Nov 2026 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxqFF+xr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B951F0089F;
	Tue, 10 Nov 2026 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794299669;
	bh=IoHg76qdWGX0YXGKv6gKymH4VgSnyA022n4X6S0GYTU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WxqFF+xr13/a/ySiR+kNLzUaa1Xs/h9B2YkHZXEvv7EByE9agjd1GbIdV07abAi1+
	 8kVNCtn5MUV+bISGWuwiNjhqJaUT6Sa3FzaN/+Y8fjCtT1jWehSFbGGFHDS/0IHcTK
	 GG1077WC7X00ODBSWKHfAswU2bagVTyTgawOl57DBvpSNQOWZg8o3er2CblBSXgWEt
	 Aigvlwy4CSzv6nX+iXZ1+cT2KfxQEM0lCygnwOfy0jPDaIS4PzfQrDevlCsUwl65NQ
	 MaGDQtA7A0vsb7qxKkc9qqRixUZghKeyJhJxP9Dmv7y1NDVTJfRVQvxZ31LudrR51F
	 ooRTNPq9adiGA==
Subject: Re: [PATCH net-next v4] net: phy: realtek: Add support for JLSemi
 JL2101 and JL2121 PHYs
From: netdev-bot+sashiko@kernel.org
To: cyan2254650260@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 08:34:28 +0000
Message-ID: <179429966829.994134.15582667508213020583@kernel.org>
In-Reply-To: <20261105173350.159060-1-cyan2254650260@gmail.com>
References: <20261105173350.159060-1-cyan2254650260@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The JLSemi entry in realtek_drvs[] uses two incompatible
  register-access models.
- [Low] REALTEK_PHY's Kconfig help (drivers/net/phy/realtek/Kconfig line
  6: 'Currently supports RTL821x/RTL822x and fast ethernet PHYs') was…
- [Low] The concern says realtek,rtl82xx.yaml forbids LEDs for JL21xx
  (allOf: leds: false unless compatible contains ethernet-phy-…

--

net: phy: realtek: Add support for JLSemi JL2101 and JL2121 PHYs

This adds a realtek_drvs[] entry that matches the JLSemi JL21xx model ID
(0x937c4030) and reuses the RTL8211F callbacks. It also adds
jlsemi_read_status(), which reads PHYSR from page 0xa43, and adds the ID
to the MDIO module device table.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 4927ee838de21..355135143fb98 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c

[ ... ]

> @@ -1755,6 +1758,23 @@ static int rtlgen_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int jlsemi_read_status(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret < 0 || !phydev->link)
> +		return ret;
> +
> +	val = phy_read_paged(phydev, JLSEMI_STATUS_PAGE, RTL_PHYSR);

[Severity: Medium]
The commit message says that on JL21xx, reading 0x1a on page 0 returns
0x0000. That is why PHYSR is read here through page 0xa43, and it means
0x1a depends on the page select on this chip.

Commit 650e55f224a5 ("net: phy: realtek: simplify bogus paged operations")
changed every 0x18-0x1f access in this driver into a plain phy_read() or
phy_modify(). It did so because only 0x10-0x17 depend on the page select
register. The RTL8211F callbacks bound to the new entry still follow that
model for registers next to 0x1a.

rtl8211f_ack_interrupt() and rtl8211f_handle_interrupt() read INSR (0x1d)
unpaged:

    irq_status = phy_read(phydev, RTL8211F_INSR);

rtl8211f_disable_autonomous_eee() modifies PHYCR2 (0x19) unpaged:

    return phy_modify(phydev, RTL8211F_PHYCR2,
                      RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);

rtl8211f_config_aldps() modifies PHYCR1 (0x18) unpaged:

    return phy_modify(phydev, RTL8211F_PHYCR1, mask, mask);

rtl8211f_config_clk_out(), rtl8211f_config_clkout_ssc() and
rtl8211f_config_sysclk_ssc() also access PHYCR2 with phy_modify() or
phy_set_bits().

Suppose JL21xx pages 0x18, 0x19 and 0x1d the same way it pages 0x1a.
Would these accesses then hit the default page instead of the real
registers?

For interrupts, rtl8211f_config_intr() enables INER with a paged write,
which does reach the hardware:

    err = phy_write_paged(phydev, 0xa42, RTL821x_INER, val);

rtl8211f_handle_interrupt() then checks the unpaged 0x1d read:

    if (irq_status & RTL8211F_INER_LINK_STATUS) {
    ...
    if (irq_status & RTL8211F_INER_PME) {
    ...
    return IRQ_NONE;

Could this return IRQ_NONE without ever clearing the latched INSR? On a
level-triggered INTB line, that could cause an interrupt storm. The IRQ
would then get disabled and link changes would be lost.

For EEE, phylink_bringup_phy()->phy_support_eee() calls
disable_autonomous_eee whenever the MAC supports EEE. It sets
autonomous_eee_disabled as soon as the MDIO write succeeds. Could phylib
then believe autonomous EEE is off while the PHY still has it on? The
same write is repeated after each soft reset in phy_init_hw().

The ALDPS and CLKOUT-disable paths would also report success without
reaching PHYCR1 or PHYCR2. The clk_out path soft-resets the PHY as well.

Now suppose 0x18-0x1f are not paged on JL21xx. Then
phy_read_paged(phydev, 0xa43, RTL_PHYSR) is the same as an unpaged read.
In that case, how does jlsemi_read_status() avoid the 10/Half downshift
it was added to fix?

The changelog says PHYSR, the RGMII delays and the LEDs were tested on
hardware. v4 drops WoL as unverified but keeps the interrupt, EEE, ALDPS
and CLKOUT paths. Were those also checked on JL21xx?

> +	if (val < 0)
> +		return val;
> +
> +	rtlgen_decode_physr(phydev, val);
> +
> +	return 0;
> +}

[ ... ]

> @@ -3283,6 +3303,23 @@ static struct phy_driver realtek_drvs[] = {
>  		.led_hw_control_get = rtl8211f_led_hw_control_get,
>  		.led_hw_control_set = rtl8211f_led_hw_control_set,
>  		.disable_autonomous_eee = rtl8211f_disable_autonomous_eee,
>  	}, {
> +		PHY_ID_MATCH_MODEL(JLSEMI_JL21XX_PHYID),
> +		.name		= "JLSemi JL2101/JL2121 Gigabit Ethernet",
> +		.probe		= rtl821x_probe,

[Severity: Low]
This isn't a bug, but rtl821x_probe() now parses vendor DT properties for
this PHY, for example:

    priv->enable_aldps = of_property_read_bool(dev->of_node,
                                               "realtek,aldps-enable");

Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml has no select:
section, and its compatible enum only lists ethernet-phy-id001c.cXXX
entries. So a JL21xx node (no compatible, or ethernet-phy-id937c.4030) is
never validated against that schema. Its leds: false rule therefore does
not affect JL21xx either.

The realtek,* properties only do anything if a DT author sets them.
Should the binding say that they also apply to JL21xx?

[ ... ]

> @@ -3527,6 +3564,7 @@ module_phy_driver(realtek_drvs);
>  
>  static const struct mdio_device_id __maybe_unused realtek_tbl[] = {
>  	{ PHY_ID_MATCH_VENDOR(0x001cc800) },
> +	{ PHY_ID_MATCH_MODEL(JLSEMI_JL21XX_PHYID) },

[Severity: Low]
This isn't a bug, but the module now binds and autoloads a non-Realtek
OUI. The REALTEK_PHY help text in drivers/net/phy/realtek/Kconfig still
says:

    Currently supports RTL821x/RTL822x and fast ethernet PHYs

MODULE_DESCRIPTION() is also still "Realtek PHY driver". Could the help
text mention JLSemi JL2101/JL2121, so that people building for that
hardware know to enable CONFIG_REALTEK_PHY?

>  	{ }
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105173350.159060-1-cyan2254650260%40gmail.com
