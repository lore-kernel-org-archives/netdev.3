Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03A42FCCC;
	Thu,  1 Oct 2026 04:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829933; cv=none; b=fs8RN0EB6Yqk1OkB7HfH4c6QVNMSfyk0sPGTZirQSVu2H/f3WivA+3+lXnQCn5WSuiCkbKmL2l1nFx7aBp6hYtHdFUBD5zeVJSS8DIr5YVM4qsYMh1ygfehACWO4N99FVX5TaByMARg49SOgLoQLaj22rToe5elNEKLiAk6rrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829933; c=relaxed/simple;
	bh=WlKDcOWp8dAN9z6EDD3/JIWAai0I6yPsrdMPUIs7rAg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLNscPFOAoCy2W8atRszgq7sq5WH4yRuAXW4JqNOjmnLgZPOFEWQXPdYCWznVWOAT9UqpU1u+7ZcmmMJ/FRKrg72hhHEFflgpv7pwU21UWBoQXc9xyIE6ckqTYxPAHtbgaEuQ5ekekdykQDhAwVeeBzWEgHnavQWkVi4DRGsMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR0JiB/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR0JiB/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CDF1F00899;
	Thu,  1 Oct 2026 04:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829931;
	bh=9/qAmvQZn6deNNGgIxYTo0+iYporCHIz1pJ7rrVVEEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YR0JiB/vFbUK5yycgjQPcBlp1oHAzZddtDmyqDCtqtZtMpgxQskLFGb3I2U3qy+0S
	 j+g5mkQK8goWoKSZqE2zXoztK4SMlrFKidjrcaxZ45uwtx66U4OwM0HS8GgwgsawRu
	 rpLC/ZvDqTIO5RobYTwqpnHP/Z7ekXkPpmmGZuZa7pNkOMXfG997Z0sYpLw43O3qhY
	 58ZN1ZW3P/6c2AcqQMeWbEHu7eQ4LAmMR3iK/3Gh79a4UxEg5uyYGlY87HSUcGGtTY
	 0Tjzqux+bfGajZMG2xvKhtA9Nyda5u+uG7xbLof3xDYcPdcBI7qLDgNoSEl53c0Gtx
	 W6oW8vWtetdFQ==
Subject: Re: [PATCH net-next v24 03/10] dt-bindings: mfd: Document support for
 Airoha AN8855 Switch SoC
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Thu, 01 Oct 2026 04:45:29 +0000
Message-ID: <179082992963.434549.6481857479350337537@kernel.org>
In-Reply-To: <20260928194511.41878-4-ansuelsmth@gmail.com>
References: <20260928194511.41878-4-ansuelsmth@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The series documents two different MDIO clauses for the same
  AN8855 internal PHY (ethernet-phy-idc0ff.0410).
- [Medium] The binding defines reset-gpios with only 'maxItems: 1'
  (airoha,an8855.yaml lines 26-27).
- [Low] The two binding examples in the series map the per-port eFUSE TX
  calibration cells to PHY addresses in incompatible ways.

--

dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC

This adds a new YAML binding for the Airoha AN8855 Switch SoC MFD node.
The node has efuse, ethernet-switch and mdio children and an optional
reset-gpios property.

> diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> new file mode 100644
> index 0000000000000..48127e956c965
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> @@ -0,0 +1,176 @@

[ ... ]

> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1

[Severity: Medium]
The reset-gpios property doesn't describe the pin or its active level. The
only example uses:

    reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;

Does anything in the series read this property?
drivers/mfd/airoha-an8855.c includes linux/gpio/consumer.h but never calls
gpiod_get*(). drivers/net/dsa/mediatek/an8855.c has no reset GPIO handling
either.

The MDIO core doesn't handle it for this node. The airoha,an8855 node is
registered as a non-PHY mdio_device, and the reset GPIO is only requested
for PHYs:

drivers/net/phy/mdio_device.c:mdiobus_register_device() {
    ...
    if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
        err = mdio_device_register_reset(mdiodev);
    ...
}

If the board's GPIO default holds RESET_N asserted, would the chip stay in
reset and cause an8855_read_switch_id() to fail?

Could the binding also state the expected polarity? When a consumer is
added, there are two options:

- It follows gpiod semantics (1 = assert). Then an ACTIVE_HIGH flag on an
  active-low RESET_N would hold the chip in reset.
- It follows the inverted mt7530 convention. Then the DT ABI is tied to an
  inverted flag.

I couldn't confirm the AN8855 pin polarity from a datasheet or from in-tree
code.

[ ... ]

> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                internal_phy1: ethernet-phy@1 {
> +                  compatible = "ethernet-phy-idc0ff.0410",
> +                               "ethernet-phy-ieee802.3-c22";

[Severity: Medium]
This example declares the internal PHYs as Clause 22. The PHY binding
added earlier in the series ("dt-bindings: net: Document support for AN8855
Switch Internal PHY") uses Clause 45 for the same PHY ID in
Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml:

    compatible = "ethernet-phy-idc0ff.0410",
                 "ethernet-phy-ieee802.3-c45";

Which one is intended?

With the MFD driver added later in the series, only c22 seems to work.
The bus comes from devm_mdio_regmap_register(), which only sets C22
accessors:

drivers/net/mdio/mdio-regmap.c:devm_mdio_regmap_register() {
    ...
    mii->read = mdio_regmap_read_c22;
    mii->write = mdio_regmap_write_c22;
    ...
}

If a board DT copies the PHY binding example, fwnode_mdiobus_register_phy()
sets is_c45 and the probe goes:

an8855_core_probe()
  fwnode_mdiobus_register_phy()
    get_phy_device(bus, addr, true)
      get_phy_c45_ids()
        get_phy_c45_devs_in_pkg()
          __mdiobus_c45_read()   <- -EOPNOTSUPP, no read_c45

get_phy_c45_ids() turns this into -EIO. an8855_core_probe() then takes the
err_put_fwnodes path, and none of the switch, efuse or PHY functions come
up.

dt_binding_check won't catch this, because ethernet-phy.yaml accepts both
compatibles. Should the PHY binding example use
ethernet-phy-ieee802.3-c22 to match this one?

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
> +                  reg = <2>;
> +
> +                  nvmem-cells = <&shift_sel_port1_tx_a>,
> +                      <&shift_sel_port1_tx_b>,
> +                      <&shift_sel_port1_tx_c>,
> +                      <&shift_sel_port1_tx_d>;
> +                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +                };

[Severity: Low]
Here, ethernet-phy@1 (the phy-handle of port@0) gets the
shift_sel_port0_tx_* cells and ethernet-phy@2 gets shift_sel_port1_tx_*.
The example in net/airoha,an8855-phy.yaml is different: ethernet-phy@2
references shift_sel_port0_tx_* and ethernet-phy@1 has no nvmem-cells.

The MFD driver treats the switch address as port 0's PHY:

drivers/mfd/airoha-an8855.c:an8855_phy_bus_register() {
    ...
    phy_offset = addr - priv->switch_addr;
    if (phy_offset >= AN8855_MAX_PHY_PORT)
        return -EINVAL;
    ...
}

So when ethernet-phy@1 exists, ethernet-phy@2 can't be port 0. The PHY
driver in drivers/net/phy/air_an8855.c applies whatever tx_a..tx_d cells
the node references, with no cross-check.

Would a DT that follows the PHY binding example program port 0's TX
calibration into a different port? This example looks like the consistent
one. Should the PHY binding example be changed to match it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928194511.41878-1-ansuelsmth%40gmail.com
