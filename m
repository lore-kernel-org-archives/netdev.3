Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0453E2E6;
	Tue, 29 Sep 2026 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714105; cv=none; b=bSwYcA+TAXWI+5UReoZgsYsqwND/Beqkw/Tsa4GVeDhla7fEGPSk/Um3EZM7D+v2TRAXNjVlmBOvo6isK35fO7WtIcAzwePkSy4F0z1tNxe4juVBEnSeU1Vb0UC3RePcsMMVhXsOgAoe68dJ1LN2ofAQOq5rIh2mx/KCyYNDThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714105; c=relaxed/simple;
	bh=g4rKMN4obeOqIqyzNiFJLZe8HOwQaEB9S6ITkB7LfoY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qsa9/x744+CbLq+zbOhKCtlQuxcAUOzW4ZdWCnIvofIGwEtXXiMI7mF9CNs3oLiSIP3zW3aV6A+DQtHFRIAL//ZsCoOHoOFVvd6N7HyLvN0stl5N/rWx1CVHQqb/6JlLExIc5TQ1iKHGZwEDzJVAejJFy12GH7Aqutdve8t2s+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj6N2xdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj6N2xdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C111F00893;
	Tue, 29 Sep 2026 20:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790714103;
	bh=sh4qxehA1sx2vDYeAmAozq0PGtGDmtydJBAmf0IsWF4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xj6N2xdFIi2RAHaYSlRw5HWY5+UHpfl5KIUikUnB65QDBpYx4Nr0cPKs5GDIdx/uP
	 ysnjB3K1iL7Zo3Tjwbu+PKEpa/d4W1+mwJk6uIO9Jlw9VTsN4mh67NPxLpWkU1tFZE
	 zVGi4+5jp1oiodW1OYDyj0X25t9yiShWwLY9lEL54E/cBtocbF3Wd15E49b7tJV1AF
	 fQKEht0W3q0baQa25JC4fnLIduXrUjy+CtnsW/MZjzdexWqWZ56/N98MFr5GDsNtOC
	 EzHhL2oXOyiCJ7dWdUYLIWrFB5xusZ8kgdNerQTqzxlVlGcDjHNDgutea1daB+HA8s
	 CftTuh5bA7d7w==
Subject: Re: [PATCH net-next v23 3/9] dt-bindings: mfd: Document support for
 Airoha AN8855 Switch SoC
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 20:35:01 +0000
Message-ID: <179071410185.434549.1910025420633087722@kernel.org>
In-Reply-To: <20260925182435.21207-4-ansuelsmth@gmail.com>
References: <20260925182435.21207-4-ansuelsmth@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Two bindings added in this series disagree on which MDIO
  clause the same AN8855 internal PHY (ethernet-phy-idc0ff.0410) uses.

--

dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC

This commit adds a DT binding for the Airoha AN8855 Switch SoC. The SoC
exposes an Ethernet switch, an efuse NVMEM provider and internal Ethernet
PHYs on an mdio subnode. The example shows the full layout, including the
nvmem cells the internal PHYs use.

> diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> new file mode 100644
> index 0000000000000..48127e956c965
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

[ ... ]

> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                internal_phy1: ethernet-phy@1 {
> +                  compatible = "ethernet-phy-idc0ff.0410",
> +                               "ethernet-phy-ieee802.3-c22";

[Severity: Medium]
This example describes the internal PHY (ethernet-phy-idc0ff.0410) as
ethernet-phy-ieee802.3-c22. The PHY binding added later in this series,
Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml, describes
the same PHY as ethernet-phy-ieee802.3-c45 in its ethernet-phy@1 and
ethernet-phy@2 examples. Which one is intended?

The drivers later in the series suggest c22 is correct. The MFD core
registers each PHY on an mdio-regmap bus, and devm_mdio_regmap_register()
sets up only the C22 ops:

drivers/net/mdio/mdio-regmap.c:devm_mdio_regmap_register() {
    ...
    mii->read = mdio_regmap_read_c22;
    mii->write = mdio_regmap_write_c22;
    ...
}

bus->read_c45 is never set.

Now take a board DT that copies the c45 example from the PHY binding.
an8855_core_probe() would register each PHY like this:

an8855_core_probe()
  fwnode_mdiobus_register_phy()      /* is_c45 = true */
    get_phy_device(bus, addr, true)
      get_phy_c45_ids()
        get_phy_c45_devs_in_pkg()
          mdiobus_c45_read()         /* -EOPNOTSUPP, no read_c45 */

get_phy_c45_devs_in_pkg() turns that error into -EIO. The failure then
goes through err_put_fwnodes in an8855_core_probe().

Wouldn't that fail the whole AN8855 core probe, and with it the switch
and efuse children? The schema can't catch this because both compatibles
are valid under ethernet-phy.yaml.

This example looks correct. Should the c45 examples in
airoha,an8855-phy.yaml be changed to c22 so the two bindings match?

> +                  reg = <1>;
> +
> +                  nvmem-cells = <&shift_sel_port0_tx_a>,
> +                      <&shift_sel_port0_tx_b>,
> +                      <&shift_sel_port0_tx_c>,
> +                      <&shift_sel_port0_tx_d>;
> +                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +                };
> +
> +                internal_phy2: ethernet-phy@2 {
> +                  compatible = "ethernet-phy-idc0ff.0410",
> +                               "ethernet-phy-ieee802.3-c22";

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925182435.21207-1-ansuelsmth%40gmail.com
