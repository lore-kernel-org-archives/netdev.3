Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503384;
	b=TL2OdW9LmymSKUrSScnPJQrtK+riUST7+zypbTm717FVwZ2UliBMlZc/IgtgJyaEvlpl
	 7BsrmgImNxO4awGZwWzd1SdzCSHn9S7VU3b4H3AJGm7ozEqh/wJVlUtc5i0o6z/QbmE3l
	 frDENW8HQ/gh41j6N8d8nswrsDfo5fTRZndIYHQddpFsGFlQcMScvi988lgNoRWcDza+Y
	 IrJzji0KIj5oH1qXyW9pq5/REiBbZo2/U3mvtzvx1fmA8pfGY0k/5tsUlv3JgmfsOtrJM
	 sC5f+rVKPYIsEih1CQuPd88YCD7kSWujJ0X/Sicyiw/Uavs+bzEMOTFt6478wcguPHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503384;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MGUvIugS+lpW0/60pXJG7rA3wOxjL11PdzpzXL8pcZo=;
	b=upDb2f0vN1aCYY8MfV4l/G1PmYMutN2bjXg69t5BHzStR+qyXo5jlYbpwV4VSM0gMCKM
	 nEGQaRc4EoIFG+k7+y9p+2t0rwTrd3g6CHS6OxI0bECVmL5f6diovPkI1uWVcYHXtkaPV
	 LaNeSekiRyfCnRC0ForntZeAeZ37v9bHLnrb4KTbToEnOF8HG2Uvs5ffo5Y8ET7eqdxEl
	 mdf5iJB8ZpHPn6vuVNrhO337hDI0HspIaJezACmkbRAfLkZUIvvW0YMlux5ueZCb/arZh
	 L6sglhu/ihortMffLTvuZWNrZ+bbF60LKObsO56ZJ9jo63ow97cHYaVAUMbesO0UjHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qz86LGvj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4247606A325;
	Tue, 20 Oct 2026 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qz86LGvj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6113F1F000C4;
	Tue, 20 Oct 2026 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503383;
	bh=MGUvIugS+lpW0/60pXJG7rA3wOxjL11PdzpzXL8pcZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qz86LGvj9yWwJN/K/AHZMy7IW8jhQJh1oKBhZloxbJCsWbH0+08ea4SJe1gaiTNpF
	 Kq3SXPLD6rfVJmMzBl9fS4HggSUs9BXB/m80uC0gM6JQKqRfuRYFVxNs8NE/lIy/gW
	 9InrqeD8s3ueIzMg/RHi66Ii4slBd9tcHwHGfhSMeUpiuGRXVFsQUTd848inK6wF77
	 uMOTODJnnRJm3TNZVaG9efh9NbmsOv/lyuJGGSr9/gFQg7tGvyaVTvfVPLR5OXuqJq
	 JcosddMyaKfwB8tZWzqbZZrjrEwqS4mj/eMDTZBIW2UTk+RR4We0TS3/TIHQPuyXCj
	 PoRtpLyhrfcjg==
Subject: Re: [PATCH net-next v2 3/5] net: phy: mxl-gpy: release MxL86211C
 Super Isolate
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, michael@walle.cc, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lrosu@maxlinear.com,
 luka.perkov@sartura.hr
Date: Tue, 20 Oct 2026 13:36:21 +0000
Message-ID: <179250338193.3135.601268020281366283@kernel.org>
In-Reply-To: <20261016112033.949026-3-robert.marko@sartura.hr>
References: <20261016112033.949026-3-robert.marko@sartura.hr>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This series breaks existing MxL86211C setups, and this patch
  makes the new Super Isolate (SI) release depend on the same supply.
- [Medium] The VDDP (MDIO/MDC/MDINT pad) supply is acquired with
  devm_regulator_get() in mxl86211c_probe() but never enabled.
- [Medium] net: phy: mxl-gpy: firmware version read while PHY is halted

--

net: phy: mxl-gpy: release MxL86211C Super Isolate

This adds an MxL86211C config_init callback. It reapplies the MDIO pad
voltage from the VDDP supply, then clears the Super Isolate bit in
VSPEC1_PM_CTRL, then calls gpy21x_config_init(). A PHY strapped into
Super Isolate is then released after each hardware reset.

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index fbac7c49b4759..8bc119655f104 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c

[ ... ]

> @@ -422,6 +423,23 @@ static int mxl86211c_configure_mdio_voltage(struct phy_device *phydev,
>  			      VSPEC1_PM_CTRL_MDIO_VOL, val);
>  }
>  
> +static int mxl86211c_config_init(struct phy_device *phydev)
> +{
> +	struct gpy_priv *priv = phydev->priv;
> +	int ret;
> +
> +	ret = mxl86211c_configure_mdio_voltage(phydev, priv->vddp);
> +	if (ret)
> +		return ret;

[Severity: High]
Does this make releasing Super Isolate depend on the VDDP supply
reporting exactly 1.8V or 3.3V?

If mxl86211c_configure_mdio_voltage() fails, mxl86211c_config_init()
returns before VSPEC1_PM_CTRL_SI is cleared. Clearing the SI bit has
nothing to do with the pad voltage.

This adds to a problem from the earlier patch in this series ("net: phy:
mxl-gpy: add MxL86211C VDDP supply"), where mxl86211c_probe() now
requires the supply:

drivers/net/phy/mxl-gpy.c:mxl86211c_probe() {
    ...
	vddp = devm_regulator_get(dev, "vddp");
	if (IS_ERR(vddp))
		return dev_err_probe(dev, PTR_ERR(vddp),
				     "failed to get VDDP supply\n");
	if (!vddp)
		return dev_err_probe(dev, -EOPNOTSUPP,
				     "VDDP supply requires regulator support\n");

	ret = mxl86211c_configure_mdio_voltage(phydev, vddp);
	if (ret)
		return ret;
    ...
}

MxL86211C support is older than this series and has never used a supply,
so no existing DT has a vddp-supply property. Without that property,
devm_regulator_get() returns the dummy regulator. The dummy has no ops,
no fixed_uV, no supply and no supply_name, so
regulator_get_voltage_rdev() returns -EINVAL for it:

drivers/regulator/core.c:regulator_get_voltage_rdev() {
    ...
	} else if (rdev->supply_name) {
		return -EPROBE_DEFER;
	} else {
		return -EINVAL;
	}
    ...
}

With CONFIG_REGULATOR=n, the stub returns NULL and probe fails with
-EOPNOTSUPP instead. Non-DT setups and PHYs found by MDIO scan go down
the same paths.

In every case mxl86211c_probe() fails and the mxl-gpy driver no longer
binds to the PHY. That loses SGMII/2500BASE-X handling, LEDs, WoL and
stats.

The binding select only matches nodes with the ethernet-phy-idc133.5400
compatible, and no in-tree DTS uses that compatible. So dtbs_check won't
flag existing nodes that lack the supply.

Neither commit message says existing setups stop working. The last patch
in the series ("net: phy: mxl-gpy: support MxL86211C lane mapping") keeps
the same probe and config_init ordering, so the problem is still there at
the end of the series.

Could the supply be made optional, with the pad voltage setup skipped
when no supply is described and the SI bit cleared either way?

> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_PM_CTRL,
> +			     VSPEC1_PM_CTRL_SI, 0);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Does gpy_probe() still read the firmware version while the PHY is
halted?

mxl86211c_probe() calls gpy_probe(), which reads PHY_FWV once and
caches priv->fw_major and priv->fw_minor. With this version, Super
Isolate is only cleared from mxl86211c_config_init(). That runs from
phy_init_hw() on attach and resume, well after probe:

mxl86211c_probe()
  gpy_probe()
    phy_read(phydev, PHY_FWV)
...
phy_attach_direct()
  phy_init_hw()
    mxl86211c_config_init()
      phy_modify_mmd(..., VSPEC1_PM_CTRL, VSPEC1_PM_CTRL_SI, 0)

The commit message says a strapped PHY stays halted after reset until
software releases it. Suppose PHY_FWV is filled in by the PHY
firmware. Then on a strapped board, probe caches whatever the register
holds before the firmware has run, most likely 0. Nothing re-reads it
after SI is cleared, so the bogus value sticks for the life of the
device.

That value is printed as the firmware version in dmesg. It is also
used by gpy_sgmii_need_reaneg(), which compares it against
ver_need_sgmii_reaneg to decide whether gpy_config_aneg() applies the
SGMII re-ANEG workaround. A zeroed version would not match any of
those entries, so the workaround would be skipped on firmware that
needs it.

v1 cleared SI in probe. Is PHY_FWV valid while the PHY is in Super
Isolate? If not, should SI also be released in mxl86211c_probe()
before gpy_probe() reads the version? Or should config_init read the
version again after clearing the bit?

[Severity: Medium]
Is the VDDP supply ever enabled?

mxl86211c_probe() gets it with devm_regulator_get(). There is no
regulator_enable() or devm_regulator_get_enable() call, and the only use
of the supply is regulator_get_voltage() in
mxl86211c_configure_mdio_voltage(). So the consumer use_count stays at 0.

Suppose the VDDP rail can be switched and is not always-on. Examples are
a GPIO-controlled regulator-fixed, or a PMIC LDO marked only
regulator-boot-on. In that case regulator_late_cleanup() turns the rail
off after boot:

drivers/regulator/core.c:regulator_late_cleanup() {
    ...
	if (rdev->use_count)
		goto unlock;
    ...
	if (have_full_constraints()) {
		rdev_info(rdev, "disabling\n");
		ret = _regulator_do_disable(rdev);
    ...
}

If the rail is off at boot, nothing turns it on.

phy_init_hw() calls mxl86211c_config_init() on attach and on resume,
often after late cleanup has run. It then does read-modify-writes on
VSPEC1_PM_CTRL over MDIO pads that may have no power:

phy_attach_direct() / mdio_bus_phy_resume()
  phy_init_hw()
    mxl86211c_config_init()
      mxl86211c_configure_mdio_voltage()
        phy_modify_mmd(..., VSPEC1_PM_CTRL, VSPEC1_PM_CTRL_MDIO_VOL, val)
      phy_modify_mmd(..., VSPEC1_PM_CTRL, VSPEC1_PM_CTRL_SI, 0)

Can these accesses fail, or read all-ones and write back bad values,
leaving the PHY in Super Isolate?

The binding does not require the rail to be always-on. The missing
enable comes from the earlier "net: phy: mxl-gpy: add MxL86211C VDDP
supply" patch in this series.

Should probe keep the supply enabled, for example by using
devm_regulator_get_enable()?

> +
> +	return gpy21x_config_init(phydev);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016112033.949026-1-robert.marko%40sartura.hr
