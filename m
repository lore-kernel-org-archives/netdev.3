Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90D377AB4;
	Sat, 10 Oct 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649157; cv=none; b=dgUhA6GntbXiK123XqxdonFGbARVYV2YqyI8plShzko6nlqGFoGdbZbwmNyUHJ1r3Wa2Ky4fbAioRzq/iZoh5T56V8LhgdiOWyK1ioAfx9Y98hvs0ROTgUoRMo6MRSvYcbx9UJRfcmI0lmJOapMdgtL7BI3qwpmJfGdIIMfMdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649157; c=relaxed/simple;
	bh=nkdXyZkcISnJhs8F3A5XKsv6cLININC6qOumqJ5Vltg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ikz76fSNeBLjN4YGWKr5qkV1H25h/iV8Z+RD6aqidh120vNnYcQIXtalZJgXdwovvJI9SGDFNxUQNryL4nu+KGGM9Wf6VPj5lU2moHkHzhJV0MKNUJ9EXjtTR08WW6JrnexFqVBQCvFhdv1f0qjBsa/ozmlKvmNhdoKcj7GTcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ualu43Nz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ualu43Nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73691F000FF;
	Sat, 10 Oct 2026 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791649156;
	bh=CEh+OP+AcjYhR6oKB2h8hBH3yA6V2LOkzyhQyArnj+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ualu43NzJCXN1uI9AIW5f3AkQM2OGnJiDfICaNKenL5MPZlyKcfQskaWmpMhTNToC
	 4WTGUG9s9ycqc7uaCf9WgZHdEVxXuVNMiruNac4Vi8igrKi3k2odJaJZp3cYtXxmIu
	 hNaLMjoGKPR81Scq9NNT55Whmd8r/qQEEJ9W2seixXgEQMVXcaOXvORTE9zOELR5e0
	 e522Pztz3SYdS4bzU7/eUg6lDPzFDSihT3Fiq20X06tfYk1eSyxfw4hoRDw9WUwG6B
	 ruQG1dRA/sD0j1wDE/95m9OsMFgg1VfOO625MBNnIvXUgrOpd9fnnQ6we/DaWkB2d7
	 slACVnEUs8uDw==
Subject: Re: [PATCH net-next v25 03/10] dt-bindings: mfd: Document support for
 Airoha AN8855 Switch SoC
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Sat, 10 Oct 2026 16:19:14 +0000
Message-ID: <179164915433.434549.5287414575554706963@kernel.org>
In-Reply-To: <20261009161102.38961-4-ansuelsmth@gmail.com>
References: <20261009161102.38961-4-ansuelsmth@gmail.com>
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

- [Medium] The two AN8855 binding examples disagree on how the internal
  PHYs are accessed.

--

dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC

This commit adds a YAML binding for the Airoha AN8855 Switch SoC. The SoC
exposes an Ethernet switch, an eFUSE NVMEM provider and internal Ethernet
PHYs. The example puts the internal PHYs on a nested mdio node.

> diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> new file mode 100644
> index 0000000000000..48127e956c965
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> @@ -0,0 +1,176 @@

[ ... ]

> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                internal_phy1: ethernet-phy@1 {
> +                  compatible = "ethernet-phy-idc0ff.0410",
> +                               "ethernet-phy-ieee802.3-c22";

[Severity: Medium]
This example gives the internal PHYs the ethernet-phy-ieee802.3-c22
compatible. The PHY binding added earlier in this series uses the C45
compatible for the same PHY ID:

Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml:
        ethernet-phy@1 {
            compatible = "ethernet-phy-idc0ff.0410",
                         "ethernet-phy-ieee802.3-c45";

Which of the two is correct?

The PHY binding selects on ethernet-phy-idc0ff.0410, so it also applies
to the PHY nodes nested here. Its $ref to ethernet-phy.yaml accepts both
c22 and c45, which means dt_binding_check won't catch the mismatch.

Later in the series, the MFD driver puts each PHY on a bus created with
devm_mdio_regmap_register(). That bus only provides C22 accessors:

drivers/net/mdio/mdio-regmap.c:devm_mdio_regmap_register()
    mii->read = mdio_regmap_read_c22;
    mii->write = mdio_regmap_write_c22;

Would a board DT that copies the PHY binding example end up on this path?

an8855_core_probe()
  fwnode_mdiobus_register_phy()      /* is_c45 is true */
    get_phy_device(bus, addr, true)
      get_phy_c45_ids()
        get_phy_c45_devs_in_pkg()
          mdiobus_c45_read()
            __mdiobus_c45_read()     /* -EOPNOTSUPP, no read_c45 */

That error turns into -EIO. an8855_core_probe() then jumps to
err_put_fwnodes, so the switch, eFUSE and PHYs never get registered.

The switch binding says its registers are reached by configuring the PHY
page. That also points to C22 access.

Should the PHY binding example use ethernet-phy-ieee802.3-c22, or drop the
C45 compatible, so the two bindings agree?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009161102.38961-1-ansuelsmth%40gmail.com
