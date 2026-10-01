Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A4316905;
	Thu,  1 Oct 2026 04:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829931; cv=none; b=PCRkiFdEXij9X8bKfLe04iayaYH7i0Wm+nNSlGSzRkk7G3kiTy68x/977rcUIEQQNakVmw5t56gCWlsGqoH6e8FDVxaEWay/WvWA7n3Cp8B7cYvbavEJFYp59sqJsErj1xr3/F+eglVo06kVBYv0U3ZFr5vZNOq7Ckog43a0KhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829931; c=relaxed/simple;
	bh=5U+nPIG6mC8DoAok249WaAIVoToiqVbwNujUK/O8Ayc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FD+j45TSo+glqExJD+2NeYmYOtY+PbepM7D3zAWfJCysNXMxcpF88lHKGmQ8EKmWSbEvWIQLMSEV0VfOXf2mlQaPKbZ13ydhsaiuKKji8ZyEEB63QxiBv5DdTqF/g6bFn3Rb5AxxVEe+mWgcPE51thZ7DWH31xkRPdXAxeJd8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXz/Am7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXz/Am7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302E81F00898;
	Thu,  1 Oct 2026 04:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829929;
	bh=RuI8uxpdRgy8WBnmh0pII5bxCi44e1viryPqs0zYc4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OXz/Am7A7jdVl8UYmpGiHdT1GxiUtCsxouGwbU/E4vIIb00OxAcTe0mAqaJqqfEe6
	 HCqA5CPjCXxZhhwzgayw2+Z933fatIhKdn1M4CaM7KFhRhlCbnGKvi8PTHv2LbCSej
	 97hfi52So3Py5C+lBfrOhNvgPBU94HMGWyJDSNRPacQiz6rQOKnEVJkCZRd9cOM5BF
	 yUgYBRLQz97y03fWKIsCkV09V5O3bZXC6n5SYy0BwrNSwViN5pBIbCcSXLFLbpJ8KJ
	 O/5Fks2KGac1JwhaS7sRHEsQSLrNRl73TFHD3YpWryDRzlGVcAS+T9ymEymh/leYPk
	 NtRc+B7lxRkZg==
Subject: Re: [PATCH net-next v24 02/10] dt-bindings: net: Document support for
 AN8855 Switch Internal PHY
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
Date: Thu, 01 Oct 2026 04:45:27 +0000
Message-ID: <179082992778.434549.16784752640119030283@kernel.org>
In-Reply-To: <20260928194511.41878-3-ansuelsmth@gmail.com>
References: <20260928194511.41878-3-ansuelsmth@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Both PHY nodes in the example in
  Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml list…
- [Low] The example in
  Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml gives…

--

dt-bindings: net: Document support for AN8855 Switch Internal PHY

This patch adds a DT binding for the internal PHYs of the Airoha AN8855
5-port Gigabit Switch, which are exposed on the MDIO bus. Each PHY can
optionally reference four eFUSE NVMEM cells (tx_a..tx_d) that hold TX
calibration data.

> diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
> new file mode 100644
> index 0000000000000..d2f86116badf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml

[ ... ]

> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@1 {
> +            compatible = "ethernet-phy-idc0ff.0410",
> +                         "ethernet-phy-ieee802.3-c45";

[Severity: Medium]
Should these PHYs be described as "ethernet-phy-ieee802.3-c22" and not
c45? Both example nodes use the c45 compatible.

In fwnode_mdiobus_register_phy(), the c45 compatible makes phylib ignore
the explicit PHY ID and probe the device using Clause 45:

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_register_phy() {
    ...
    is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
    if (is_c45 || fwnode_get_phy_id(child, &phy_id))
        phy = get_phy_device(bus, addr, is_c45);
    ...
}

Each AN8855 PHY is on a per-PHY bus that an8855_phy_bus_register()
creates via devm_mdio_regmap_register(). That bus provides only C22
accessors:

drivers/net/mdio/mdio-regmap.c:devm_mdio_regmap_register() {
    ...
    mii->read = mdio_regmap_read_c22;
    mii->write = mdio_regmap_write_c22;
    ...
}

That means get_phy_c45_ids()->get_phy_c45_devs_in_pkg() gets -EOPNOTSUPP
and returns -EIO. The PHY registration then fails, and
an8855_core_probe() in drivers/mfd/airoha-an8855.c goes to
err_put_fwnodes. As a result, neither the PHYs nor the switch/efuse MFD
cells are registered.

The PHY driver in drivers/net/phy/air_an8855.c matches the C22 ID with
PHY_ID_MATCH_EXACT(0xc0ff0410) and uses C22 paged access. Also, the MFD
binding example in the same series (airoha,an8855.yaml) uses
"ethernet-phy-ieee802.3-c22" for these PHYs.

If a board DT follows this example, won't the whole AN8855 probe fail?

> +
> +            reg = <1>;
> +        };
> +
> +        ethernet-phy@2 {
> +            compatible = "ethernet-phy-idc0ff.0410",
> +                         "ethernet-phy-ieee802.3-c45";
> +
> +            reg = <2>;
> +
> +            nvmem-cells = <&shift_sel_port0_tx_a>,
> +                          <&shift_sel_port0_tx_b>,
> +                          <&shift_sel_port0_tx_c>,
> +                          <&shift_sel_port0_tx_d>;

[Severity: Low]
Is ethernet-phy@2 meant to get port 0's calibration cells here, while
ethernet-phy@1 gets none?

an8855_phy_bus_register() in drivers/mfd/airoha-an8855.c maps the MDIO
address to a port relative to the switch address:

    phy_offset = addr - priv->switch_addr;
    if (phy_offset >= AN8855_MAX_PHY_PORT)
        return -EINVAL;

Because ethernet-phy@1 is present, switch_addr has to be 0 or 1. That
makes address 2 port 1 or port 2, and never port 0.

The eFUSE binding (airoha,an8855-efuse.yaml) has a separate tx_a..tx_d
set for each port, for example shift_sel_port0_tx_a@c and
shift_sel_port1_tx_a@1c. The MFD binding example in the same series
wires internal_phy1 (reg 1) to shift_sel_port0_* and internal_phy2
(reg 2) to shift_sel_port1_*, which does not match this example.

A DT copied from this example would have an8855_probe() read port 0's
R50-ohm values. an8855_config_init() would then write them into the
second PHY's AN8855_PHY_R50OHM_RSEL_TX_AB/CD registers, and the first
PHY would stay uncalibrated. No error would be reported.

Should the cells move to ethernet-phy@1, or should ethernet-phy@2 use
the shift_sel_port1_* cells?

> +            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
> +        };
> +    };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928194511.41878-1-ansuelsmth%40gmail.com
