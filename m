Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000330;
	b=IIiNpOsMBILqTJjykXCYloJOUIzrpTSKZsh4Acv1uvuYMIGe+fQIo8Ju+kDdFT6vApe6
	 7m3tLjHp4WrqZvuP9AJ/iespsgKZ6JFWbR566kf9DDbNDN4e2zRCwvFiMdWJc+HOf/P4+
	 eFBSsyIDaTp+prnQgcV4fyJuQ5CGBg95dNkwXtgTB05/8hINPvtHAq+61FK1icB0DA8NT
	 0AZTfPUNLZt7+T/V1fIBAvSHxU+em8DxGIZilz+gTz/JkPrH6lRj6beoe51dRONhcWHZL
	 /ru2vUx3+76iuifdbizVBEsNCDydYhqVCUPPAtDIwjqR6DYm6DzeHRIhrAtIYd8x4lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000330;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D75xnHEgEQErGUOR7h9XEUbUTbEHhDcv8kD4EeaNl/M=;
	b=q3jS1YpZkUZoZuipTSMfLzmMAmVvMxegwQvQidQT+Kvnc+KQRCWORWc3Gt4IxEK7tQDH
	 u8k8DMZNvVgDIDs4P3RBTm0Yfgzk51Ad7/1NhhOgbRSfN+UYo2v7PyvTSg7sRVpopF/VA
	 0T9zZ9GZMJ5ocaqlJBd/ai76KQeFMbxrLKZVuGFbrLGwdWDnG+MZJZ1ixxnpHweih1+ik
	 2hhyl9dxUVJ2tk8qhEhkwVZEwxCSnN+GYQGaOEnB43W0ZfqRj9rYnfYNR5lbGllORUyBE
	 WxICxJ5fKHIJbPMVm0AuoHlOKHlWeTxOUuaBSayE7ZUdRc4BIv+H7q0H1M5anhAg/bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoKh2jvn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C686606A330;
	Fri,  6 Nov 2026 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoKh2jvn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13B51F008A1;
	Fri,  6 Nov 2026 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000330;
	bh=D75xnHEgEQErGUOR7h9XEUbUTbEHhDcv8kD4EeaNl/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EoKh2jvnbEJsJ282GpLsZXxdoLIQqxHvKW7d2Nj8JZAsOQclK+XJPhfmZT3Z6yuQp
	 M5Azz5ReSqtK1KyTgpd0oIuWHBiZBcAhVAacUviOjyY29Dn/Hk4g5HGgMF3Qb4AMKd
	 BAW2wamAqN80OVZFCb9poFYkzW9ZMQAm3d0JVojRCqujNBrpXyaIaM1XfW8QCvHu0c
	 ADMdIjamA+QjstNWyUY3hZXQqujp0BTvnwYmOwaijdhol/XmAWL1k9hwv2o8sVsBYi
	 ttGRjuimzjXqso/vjoSgPfTIGNO8Q3DA85GF0mdkn2/Gx3mF2jyj2dECFDlehKVUSd
	 jHrBzDh1c2KCA==
From: Jakub Kicinski <kuba@kernel.org>
To: me@marleb.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: register hwmon thermal zones
Date: Fri,  6 Nov 2026 13:25:28 -0800
Message-ID: <20261106212528.948836-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-realtek-hwmon-tz-v1-1-e672723c58cb@marleb.org>
References: <20261103-realtek-hwmon-tz-v1-1-e672723c58cb@marleb.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: realtek: register hwmon thermal zones

This commit adds HWMON_C_REGISTER_TZ to the channel info of the Realtek
PHY hwmon device. With it, the hwmon core registers the PHY temperature
sensor with the thermal framework, so device-tree thermal zones that
reference the PHY can bind.

> Set the flag, as the Aquantia PHY driver does. This lets the RTL8261N
> sensors on the Zyxel XGS1250-12 B1 drive the chassis fan through
> thermal cooling maps.
>
> Tested on a Zyxel XGS1250-12 B1 with OpenWrt's Linux 6.18.55: the
> three PHY thermal zones register, and an emulated 85 C reading on one
> of them (CONFIG_THERMAL_EMULATION) switches the fan on through the
> existing 80 C trip and off again once cleared.

[Severity: Medium]
Does this description hold for the mainline driver?

rtl822x_hwmon_init() has only one caller, rtl822x_probe() in
drivers/net/phy/realtek/realtek_main.c:

    if (IS_ENABLED(CONFIG_REALTEK_PHY_HWMON) &&
        phydev->phy_id != RTL_GENERIC_PHYID)
            return rtl822x_hwmon_init(phydev);

Only four entries use that probe: RTL8221B-VB-CG, RTL8221B-VM-CG,
RTL8251B and Realtek Internal NBASE-T PHY.

The RTL8261C/CE/D_VM entries use rtl8261x_probe(). That probe only
allocates priv and picks a firmware name. It never calls
rtl822x_hwmon_init(). The driver table also has no RTL8261N ID.

An external C45 PHY cannot fall back to the internal NBASE-T entry
either, because rtl_internal_nbaset_match_phy_device() has:

    if (phydev->is_c45)
        return false;
    ...
    return rtlgen_supports_2_5gbps(phydev) && !rtlgen_supports_mmd(phydev);

So on mainline, no RTL8261 PHY seems to register a hwmon device. The
three thermal zones seen in testing would then come from out-of-tree
OpenWrt PHY support.

Could the commit message name the PHYs that actually gain thermal zone
registration (RTL8221B, RTL8251B and the internal NBASE-T PHYs)? Or
could it say that RTL8261 hwmon support is a missing prerequisite?

> diff --git a/drivers/net/phy/realtek/realtek_hwmon.c b/drivers/net/phy/realtek/realtek_hwmon.c
> index ac96e2d1ebe82..e6235df288c32 100644
> --- a/drivers/net/phy/realtek/realtek_hwmon.c
> +++ b/drivers/net/phy/realtek/realtek_hwmon.c
> @@ -51,6 +51,7 @@ static const struct hwmon_ops rtl822x_hwmon_ops = {
>  };
>  
>  static const struct hwmon_channel_info * const rtl822x_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),

[Severity: Low]
Does this need a DT binding update to go with it?

With HWMON_C_REGISTER_TZ set, hwmon_thermal_add_sensor() calls
devm_thermal_of_zone_register() on the PHY's of_node. Thermal-of finds
zones through thermal-sensors phandles, so the PHY node needs a
#thermal-sensor-cells property.

None of the relevant schemas seem to allow that property:

  realtek,rtl9301-mdio.yaml is the RTL930x MDIO binding used by the
  board in the commit message. Its ethernet-phy@ children are
  $ref: ethernet-phy.yaml# with unevaluatedProperties: false.

  realtek,rtl8224-package.yaml restricts its PHY children the same way.

  realtek,rtl82xx.yaml, which covers the
  ethernet-phy-id001c.c849/c84a/c862 compatibles, ends with
  unevaluatedProperties: false.

  ethernet-phy.yaml does not evaluate any thermal property.

Would a DTS that adds #thermal-sensor-cells = <0> to an ethernet-phy@N
node under a realtek,rtl9301-mdio bus fail dtbs_check?

The Aquantia and Marvell PHYs have the same gap, but this patch makes
Realtek PHYs new users of it.

[Severity: Medium]
With this flag, rtl822x_hwmon_read() becomes the get_temp backend of a
thermal zone that drives cooling devices. Should it check phy_read_mmd()
for errors now?

drivers/net/phy/realtek/realtek_hwmon.c:rtl822x_hwmon_read() {
    ...
	case hwmon_temp_input:
		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSRR) & 0x3ff;
		*val = rtl822x_hwmon_get_temp(raw);
		break;
    ...
	return 0;
}

The mask turns a negative errno into a plausible temperature, and the
function returns success. For example, -EIO becomes 0x3fb, which reads
as -2500 millidegrees. -ETIMEDOUT reads as -55000.

hwmon_thermal_get_temp() treats only ret < 0 as a failure:

	ret = hwdev->chip->ops->read(tdata->dev, hwmon_temp, hwmon_temp_input,
				     tdata->index, &t);
	if (ret < 0)
		return ret;

	*temp = t;

If one MDIO read fails while the PHY is hot, the thermal core gets a
sub-zero reading. Could the governor then switch the fan off for at
least one polling interval? If the errno were returned, the thermal
core would keep its previous state.

The hwmon_temp_max path, which reads TSSR and shifts by 6, has the same
unchecked pattern, although thermal does not use it.

The masking itself goes back to commit 33700ca45b7d2e ("net: phy:
realtek: add hwmon support for temp sensor on RTL822x"). This patch is
what connects it to a cooling control loop.

>  	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX),
>  	NULL
>  };
