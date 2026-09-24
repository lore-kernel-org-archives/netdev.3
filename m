Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98219468C02;
	Thu, 24 Sep 2026 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245282; cv=none; b=MTx7WwOloQHi7NwS6UhFLCcxJUQZzGlpJhQj8q+8Yy4VyThFG1B+foI1uSIP/BT6G1xdufQMI/Kmn7HsMAalU817EDcbmCoZYwLsDmCsT3ae1hp8cU7RyQPp0IDuTZpXI9EVNKWLAeRRvkj7unjoWz3Sbp1hsYmFHy3k2cqP4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245282; c=relaxed/simple;
	bh=UBX6gOEbonwuYyCaalxwbCEYy/HxmWxEjR6w1BkxIp8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uuie9l4kGoOTHCRTShFbfdglszB93Fj9Km4MKYvU3ay+qO2bKtgh+XewWGUzeLp51t1u/tpidTrDMG9IeslFZB7EaJfoYtE5D7hZ3zoNBvVw0noqJS2H7ccQMy/fDwOqTA1h+wSFuu/J37YaJIzb58HDjITv0kvWVJaXknYSCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc9BD7gm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc9BD7gm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F181F00893;
	Thu, 24 Sep 2026 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245273;
	bh=97waUDYI/PZP6GU9SnoYCHAgkPlK++8tAiSjkEhmkno=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gc9BD7gmTgbtX6DHw0dAsVf8kWJIjH/ZLpXR7uBWCGJM5zUGmmbRzetjCDKsMei0w
	 KIP4nE9tmSP2zSByq9u8EfuCpQh2np0DNIKwbSU73G7aYBFfU2tcOHiswdBPa0XLk9
	 NT/nhrb7yVzsp4UJYGnE2YSuNFYVywysuCpQbM+p+14kQvM3NOICb49Y3AYPe27kfT
	 Op5GAOfVLJzjVzHahSXZ+5PNLqZoazLj05NGVfABeQ4tVLnKkEzorVxHfOcnfGnNI+
	 /ubVKBYuR7irLdqeCE4aaMA5jnZnebCPhuPENK4KiCnRjElUoNIFKKRqdJc07IfoWq
	 gdrM6IgZrYmMA==
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: apply SerDes lane
 polarity on RTL8261C/D
From: netdev-bot+sashiko@kernel.org
To: spolack+git@mailbox.org
Cc: andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, javen_xu@realsil.com.cn, chad@monroe.io,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 10:21:11 +0000
Message-ID: <179024527181.2160803.18245192266952877524@kernel.org>
In-Reply-To: <20260921161817.565185-3-spolack+git@mailbox.org>
References: <20260921161817.565185-3-spolack+git@mailbox.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Binding/driver contract mismatch for the generic tx-
  polarity/rx-polarity ABI: the new binding (patch "dt-bindings: net:…
- [Low] Reported concern: the patch fixes a user-visible NO-CARRIER
  condition but carries no Fixes: tag (suggested Fixes: b772b5ae4537…
- [Low] Reported concern: rtl8261x_config_serdes_polarity() commits
  RTL8261X_SERDES_POL_REG0 before attempting RTL8261X_SERDES_POL_REGC2…

--

net: phy: realtek: apply SerDes lane polarity on RTL8261C/D

This adds a read and a read-modify-write helper to the RTL822x VEND1 SerDes
command window, moves rtl822x_serdes_write() next to them, and programs the
host-side SerDes lane polarity described by the generic tx-polarity and
rx-polarity firmware properties from rtl8261x_config_init(). REALTEK_PHY now
selects PHY_COMMON_PROPS for the property helpers.

A couple of questions below.

> The copper side negotiates normally while the SerDes never trains and
> the netdev stays NO-CARRIER.

[Severity: Low]
Since this fixes a user-visible NO-CARRIER condition, should the patch carry
a Fixes: tag, e.g.

  Fixes: b772b5ae4537 ("net: phy: realtek: add support for RTL8261C_CG")

For completeness: at the baseline revision
Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml lists no
ethernet-phy-id001c.c898/c899/c89a compatible and has no $ref to
/schemas/phy/phy-common-props.yaml, so tx-polarity/rx-polarity only become
part of the ABI for these PHYs through the sibling binding patch in this
series. On that reading no released kernel can regress, and a Fixes: tag may
not be appropriate after all - worth confirming which way this should go.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 1e670638dd1c7..04d397f0a2d80 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c

[ ... ]

> @@ -708,18 +723,147 @@ static int rtl8261x_config_aneg(struct phy_device *phydev)
>  	return 0;
>  }
>
> +static int rtl822x_serdes_wait(struct phy_device *phydev)

[ ... ]

> +/* The host-side SerDes lanes are only inverted when the board says so.
> + * Lanes the firmware node does not describe are left as the boot loader
> + * and PHY firmware left them.
> + */
> +static int rtl8261x_config_serdes_polarity(struct phy_device *phydev)
> +{
> +	bool tx_present, rx_present, tx_invert = false, rx_invert = false;
> +	u16 reg0_mask = 0, reg0_set = 0, regc2_mask = 0, regc2_set = 0;
> +	struct fwnode_handle *fwnode = dev_fwnode(&phydev->mdio.dev);
> +	const char *mode = phy_modes(phydev->interface);
> +	unsigned int pol;
> +	int ret;
> +
> +	tx_present = fwnode_property_present(fwnode, "tx-polarity");
> +	rx_present = fwnode_property_present(fwnode, "rx-polarity");
> +	if (!tx_present && !rx_present)
> +		return 0;
> +
> +	if (tx_present) {
> +		ret = phy_get_manual_tx_polarity(fwnode, mode, &pol);
> +		if (ret)
> +			return ret;
> +		tx_invert = pol == PHY_POL_INVERT;
> +	}
> +
> +	if (rx_present) {
> +		ret = phy_get_manual_rx_polarity(fwnode, mode, &pol);
> +		if (ret)
> +			return ret;
> +		rx_invert = pol == PHY_POL_INVERT;
> +	}

[Severity: Medium]
Is the range of values this accepts narrower than what the binding allows?

phy-common-props.yaml constrains rx-polarity items to enum [0, 1, 2], and
the realtek,rtl82xx.yaml conditional in this series only disables the
property for compatibles other than ethernet-phy-id001c.c898/c899/c89a, so
<PHY_POL_AUTO> validates on these nodes. The helper used here only permits
BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT):

  int __must_check phy_get_manual_rx_polarity(struct fwnode_handle *fwnode,
                                              const char *mode_name,
                                              unsigned int *val)
  {
          return phy_get_rx_polarity(fwnode, mode_name,
                                     BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
                                     PHY_POL_NORMAL, val);
  }

so the lookup returns -EOPNOTSUPP for PHY_POL_AUTO. Should the binding
narrow the enum to [0, 1] for these compatibles, or should this code treat
PHY_POL_AUTO as "leave the lane alone"?

A second shape has the same effect. When tx-polarity/rx-polarity is a
per-mode list and the *-polarity-names list does not contain the active
interface name and has no "default" entry,
fwnode_get_u32_prop_for_name() fails:

  drivers/phy/phy-common-props.c:fwnode_get_u32_prop_for_name() {
          ...
          if (idx < 0 && n_props != 1) {
                  pr_err(...);
                  return -EINVAL;
          }

          if (n_props == 1) {
                  err = fwnode_property_read_u32(fwnode, props_title, val);
          ...
  }

The $defs/protocol-names text in the binding says the system should use the
manufacturer default value when no name matches, which does not look like
what happens here. And in the n_props == 1 case the single value is applied
even though the name did not match, so a polarity described for one protocol
gets programmed while running another - is that intended?

Note the lookup key is computed at config_init() time:

  const char *mode = phy_modes(phydev->interface);

and phy_modes() returns "" for PHY_INTERFACE_MODE_NA, a string that can
never appear in the binding's protocol-names enum, so the unmatched-name
paths are reachable when the interface is still unresolved at attach time
(phylink_fwnode_phy_connect() passes pl->link_interface, which may still be
PHY_INTERFACE_MODE_NA).

> +
> +	if (tx_present) {
> +		reg0_mask |= RTL8261X_SERDES_POL_REG0_TX;
> +		regc2_mask |= RTL8261X_SERDES_POL_REGC2_TX;
> +		if (tx_invert) {
> +			reg0_set |= RTL8261X_SERDES_POL_REG0_TX;
> +			regc2_set |= RTL8261X_SERDES_POL_REGC2_TX;
> +		}
> +	}
> +
> +	if (rx_present) {
> +		reg0_mask |= RTL8261X_SERDES_POL_REG0_RX;
> +		regc2_mask |= RTL8261X_SERDES_POL_REGC2_RX;
> +		if (rx_invert) {
> +			reg0_set |= RTL8261X_SERDES_POL_REG0_RX;
> +			regc2_set |= RTL8261X_SERDES_POL_REGC2_RX;
> +		}
> +	}
> +
> +	ret = rtl822x_serdes_modify(phydev, RTL8261X_SERDES_POL_REG0,
> +				    reg0_mask, reg0_set);
> +	if (ret < 0)
> +		return ret;
> +
> +	return rtl822x_serdes_modify(phydev, RTL8261X_SERDES_POL_REGC2,
> +				     regc2_mask, regc2_set);
> +}

[Severity: Low]
This isn't a bug, but the RTL8261X_SERDES_POL_REG0 update is committed
before RTL8261X_SERDES_POL_REGC2 is attempted, with no rollback, so an MDIO
failure on the second rtl822x_serdes_modify() leaves the two registers
describing different polarities.

Working against that being a problem: the error is propagated out of
rtl8261x_config_init(), phy_init_hw() aborts on it, and phy_attach_direct()
takes its error path and calls phy_detach_internal(), so the half-programmed
PHY is never used for a link, and the sequence is idempotent on the next
phy_init_hw(). Mentioning it only in case a comment here is worth having.

>  static int rtl8261x_config_init(struct phy_device *phydev)
>  {
>  	struct rtl8261x_priv *priv = phydev->priv;
> +	int ret;
>
>  	/* The firmware parameters are preserved across IEEE soft resets and
>  	 * suspend/resume cycles. Reloading is only necessary after a power
>  	 * cycle or hard reset.
>  	 */
> -	if (priv->fw_name && !priv->fw_loaded)
> -		return rtl8261x_fw_load(phydev);
> +	if (priv->fw_name && !priv->fw_loaded) {
> +		ret = rtl8261x_fw_load(phydev);
> +		if (ret)
> +			return ret;
> +	}
>
> -	return 0;
> +	return rtl8261x_config_serdes_polarity(phydev);
>  }

Returning the polarity parse error from config_init() makes any of the
firmware descriptions above fatal to PHY initialisation:

  drivers/net/phy/phy_device.c:phy_init_hw() {
          ...
          if (phydev->drv->config_init) {
                  ret = phydev->drv->config_init(phydev);
                  if (ret < 0)
                          return ret;
          ...
  }

and phy_attach_direct() then goes to its error label and detaches the PHY,
so the netdev never comes up at all. Would it be better to warn and keep the
lane untouched when the properties cannot be interpreted?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921161817.565185-1-spolack%2Bgit%40mailbox.org
