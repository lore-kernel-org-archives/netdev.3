Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726618;
	b=dKS/f0mbZWwwQvy71mv1KpM4MpPUTUP3xGLW6ZM0XFi3fuqElGTwfILM/NQ8d1oLLH/7
	 s7k4US7Po1BylgTP2q60uiETjrFZU7SIkXhnamKKeynWU1BCKoOoNi6dNYC15BJrO1Hym
	 a1FlKXyIlPtjY78VJYWFAuQQs3L4+Nkm2gfRVuPJ+U4Gig0pycmsKistCVOhoSTs60Gat
	 LYajRFs5sABpzS5skSLxHLcYEQPIvXoK/XQeOXMT4ffj9hPIIuJX6oXcJFRN76bb5uGZR
	 xus+PcG71oday/O6UCX9Uuk870Uugjaz9TBHorW2RTB6WknbXTz29XG9m5btbcyE4XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726618;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ygrKKRmQfRRsJAUFN/CGRVYdHUF8FNOyvt+ARoECY5A=;
	b=X0YCq1S5chU31XoLlAjALz9TDbXQv9rj0guG7uHYUoxXjWKaiEvlctlCdp720XjTbS25
	 7yovDj6togoZygxUdDR6F7KU90SKZVZNmFJsvg4QQzTJv4lxZJ+9dkcqZ+PeUEWkBYtNi
	 1prY0hly2LjIy1p2dEYH1g/kYEpVHMKUtJRHBqaYEgoEd2hh5FtWmJ4Vc9omT0sk2WgjC
	 sXH6zHfA6/ANVMKR5jV5D5kgY5FF2Zm7TCKDfuUb37RFRqR/qlzCOup6nR/EoOU3gmwzK
	 qncTH4FF7OPTS6ruWIgVfj1/YhHdyizldVs2MYTsYtrufkulaHRAmZMLdxR+cqzCGag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3efq1BD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86B606A320;
	Fri, 23 Oct 2026 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3efq1BD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673C21F01829;
	Fri, 23 Oct 2026 03:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792726617;
	bh=ygrKKRmQfRRsJAUFN/CGRVYdHUF8FNOyvt+ARoECY5A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J3efq1BDPXLT7StMexhARzDg2TYYVvz9Jvmq+8NK9TmkaQq+1faFv4eGW/Q9DgjBb
	 knFdyt6i43Sx0L8CvD6MFI7gcqh/tZeq/1ZmV5cUR/31HjvhJ25ysnoa3BIi0XWdt1
	 Zis31uysqZwwR3XExZib3uBn2SGUtzV5EPkskYvWZFw6GzJetYDAhwX9PqQNd7CZgA
	 knBYUI1LQwDckfLxw84po9OCxZ4aJXYwFfvhYixUTIElZWOI549MK5EPHsa7uy6EgD
	 lkc3LtjimRPoJF7fOoRSJQ6gmv5h0EoBMNduTC28YfcKyQ8xb70E6ZhYhJPak3c+iy
	 bcZ7R0yu5F21Q==
Subject:
 Re: [PATCH net-next v3 2/5] net: phy: mxl-gpy: add MxL86211C VDDP supply
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lrosu@maxlinear.com, luka.perkov@sartura.hr
Date: Fri, 23 Oct 2026 03:36:55 +0000
Message-ID: <179272661595.3134.9715632995095747172@kernel.org>
In-Reply-To: <20261020093655.344585-2-robert.marko@sartura.hr>
References: <20261020093655.344585-2-robert.marko@sartura.hr>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In this commit, the MxL86211C pad-voltage select
  (VSPEC1_PM_CTRL_MDIO_VOL, bit 14 of VSPEC1_PM_CTRL) is written only…
- [Medium] The VDDP regulator powers the MDIO/MDC/MDINT pads, but
  mxl86211c_probe() (drivers/net/phy/mxl-gpy.c:437-457) first gets and…

--

net: phy: mxl-gpy: add MxL86211C VDDP supply

This adds an optional VDDP supply consumer to the MxL86211C probe. If the
supply is described, it is enabled for the PHY lifetime, and the
VSPEC1_PM_CTRL MDIO pad voltage bit is set to match the reported 1.8 V or
3.3 V level. If the supply is absent, the hardware reset default is kept.

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index 089a1a9e5bc6..952272faac1e 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c

[ ... ]

> +static int mxl86211c_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct gpy_priv *priv;
> +	struct regulator *vddp;
> +	int ret;
> +
> +	vddp = devm_regulator_get_optional(dev, "vddp");
> +	if (PTR_ERR_OR_ZERO(vddp) == -ENODEV)
> +		vddp = NULL;
> +	else if (IS_ERR(vddp))
> +		return dev_err_probe(dev, PTR_ERR(vddp),
> +				     "failed to get VDDP supply\n");
> +
> +	if (vddp) {
> +		ret = regulator_enable(vddp);

[Severity: Medium]
Can a switchable vddp-supply that is off at boot work with this ordering?
VDDP powers the MDIO/MDC/MDINT pads. Here it is first enabled from the PHY
driver's .probe callback. By then phylib has already accessed the PHY over
MDIO and has already released its reset.

During discovery, fwnode_mdiobus_register_phy() reads the PHY ID over MDIO
before any driver binds:

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_register_phy() {
    ...
	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
		phy = get_phy_device(bus, addr, is_c45);
    ...
}

The binding's vddp-supply example uses compatible =
"ethernet-phy-idc133.5400", "ethernet-phy-ieee802.3-c45". That makes is_c45
true, so the ID reads go out over unpowered pads.

Wouldn't registration fail at that point, before mxl86211c_probe() gets to
enable VDDP?

If only the ID compatible is listed, discovery is skipped. Even then,
phy_probe() deasserts reset before it calls the driver probe:

drivers/net/phy/phy_device.c:phy_probe() {
    ...
	/* Deassert the reset signal */
	phy_device_reset(phydev, 0);

	if (phydev->drv->probe) {
		err = phydev->drv->probe(phydev);
    ...
}

So the PHY comes out of reset while VDDP is still off. mxl86211c_probe()
then enables VDDP and writes VSPEC1_PM_CTRL straight away, with no reset
cycle after power-up.

This seems to work only when VDDP is already on (always-on, boot-on, or
left on by the bootloader). Should the commit message or the binding
document that limitation? Or should the supply be handled earlier?

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable VDDP supply\n");
> +
> +		ret = devm_add_action_or_reset(dev, mxl86211c_disable_vddp, vddp);
> +		if (ret)
> +			return ret;
> +
> +		ret = mxl86211c_configure_mdio_voltage(phydev, vddp);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = gpy_probe(phydev);
> +	if (ret)
> +		return ret;
> +
> +	priv = phydev->priv;
> +	priv->vddp = vddp;
> +
> +	return 0;
> +}

[ ... ]

> @@ -1406,7 +1482,7 @@ static struct phy_driver gpy_drivers[] = {
>  		.name		= "Maxlinear Ethernet MxL86211C",
>  		.get_features	= genphy_c45_pma_read_abilities,
>  		.config_init	= gpy21x_config_init,
> -		.probe		= gpy_probe,
> +		.probe		= mxl86211c_probe,

[Severity: Medium]
Is the VSPEC1_PM_CTRL_MDIO_VOL setting lost after a later hardware reset?
This patch writes the bit only once, from mxl86211c_probe(). The MxL86211C
entry still uses gpy21x_config_init(), which never writes VSPEC1_PM_CTRL.

On a board with reset-gpios, a detach/attach cycle runs:

phy_detach()
  phy_device_reset(phydev, 1)
phy_attach_direct()
  phy_init_hw()
    phy_device_reset(phydev, 0)
    phydev->drv->config_init() -> gpy21x_config_init()

After that the pad mode is back at its reset default and no longer matches
a 1.8 V VDDP. A suspend that drops PHY power would have the same result.
This commit stores priv->vddp but never reads it.

A later commit in this series, "net: phy: mxl-gpy: release MxL86211C Super
Isolate", seems to fix this. It switches the entry to
mxl86211c_config_init(), which calls
mxl86211c_configure_mdio_voltage(phydev, priv->vddp) whenever priv->vddp is
set. Before this patch the bit was never written at all.

Could the setting be restored from config_init in this patch, so that the
intermediate commit is correct on its own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020093655.344585-1-robert.marko%40sartura.hr
