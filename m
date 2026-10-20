Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503382;
	b=vFYjMC6QjQ1We1RKuOva9WOMNrXgZRwB3Ej/DPq3ZR7uQFfOTF5huyVQVWra5lh+xRL3
	 X66UbRrgGPU6R6QbGj1WUF/bKPsxo+XTt27ngqlkMSjEP4rghclC+N+iSnPe2MOLRcZcq
	 PDym0HEUiAO4cQyHn2ujNSU8Sxx8p2e441sUfB9yDtXPTkK11YmuGN4YYb1AJJrgDKh5b
	 1TGM/fxyIYMQ5RWbiRQbO++6eO5Py4maOy/bBR5fUqEsARfENXjaYzoo+eAoaN5FbiTgS
	 cg1ciw+2jKN3f2hJqM0nS1AFOyu9gf4Tepmny/NfDrF1n8TcPE8JlhXva+y232/HXUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503382;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Sv6AkjTOBf6BCXzrHoLh5ovCpQLdH2U6SavzYMmZFVw=;
	b=0CYy68HxhIK5ZRAyjrb8CRwnTJutCjsCTgOCTLSWzmNPHq12ml8knI0GnOGDKU4ea2BP
	 ycJ02qYCMtjo4Wk+yFiORk2HA+XzsX98x0PzsF5SffeD7g8Qy7LlvoGlQABHzLHw/td0J
	 ua5xAqxBmPJYPZXWKlKJuNrdUk2MBYwNylq7XAQbRySxJSH8hUayW2anP+JL+Elfy/Xd0
	 X4Mtz0sOYyLbqWczgDG7Mw2+bGQ4paUoiaiBOyZ84QVZb5l7/G/+pxCG86OV31qwn5mt8
	 1ez/98AdYgZQo9nOkPx/kbMWMaLFsYtff8PiDvflnUdmnkv7Ggcpjdo6DCD4sn9zMzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkCLXsHQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E01606A31E;
	Tue, 20 Oct 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkCLXsHQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B672F1F000C5;
	Tue, 20 Oct 2026 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503381;
	bh=Sv6AkjTOBf6BCXzrHoLh5ovCpQLdH2U6SavzYMmZFVw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mkCLXsHQ+nXjU11UBxjykTv+9CjadvacKj8UBlBbeluhJp/TgnN+1u6lysgKMZA8W
	 kMr+PcnDXEUPIp7sqQ75OQdfDk39GBeM4XnOZYOH/LaoKCo3yxnE5JPvCgSGhs82OV
	 rGjtTPwDRKgkxltzGR+PClR/U5OBSuu5PlvU01X+PvJGEy2L7TmGcbyYppzHwTTEi9
	 pyXFgTPTBZPl2hb/I1jmP2dzjrGvrqi1UcRGU4Ory2pPuCVZS/qmHwVZSok7jSjcee
	 6Kto04Crt9YZ5Kw82siJq4BetAHx7B4e7ThvOnSiIZjc0rVwDkcMdbBZQhUsphbamG
	 zXTlkmWIbeIcw==
Subject:
 Re: [PATCH net-next v2 2/5] net: phy: mxl-gpy: add MxL86211C VDDP supply
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, michael@walle.cc, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lrosu@maxlinear.com,
 luka.perkov@sartura.hr
Date: Tue, 20 Oct 2026 13:36:20 +0000
Message-ID: <179250338027.3135.14058409446224604977@kernel.org>
In-Reply-To: <20261016112033.949026-2-robert.marko@sartura.hr>
References: <20261016112033.949026-2-robert.marko@sartura.hr>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Probe regression for existing MxL86211C users.
- [Medium] mxl86211c_probe() gets the VDDP supply with
  devm_regulator_get(), reads its voltage, programs the MDIO/MDC/MDINT…
- [Low] Baseline decision: invalid (kept only because
  requires_validation=true).
- [Low] Baseline decision: invalid for the final state of the series
  (kept only because requires_validation=true).

--

net: phy: mxl-gpy: add MxL86211C VDDP supply

This commit adds mxl86211c_probe(). It gets the VDDP supply, reads its
voltage and sets the MDIO/MDC/MDINT pad level in VSPEC1_PM_CTRL to 1.8 V
or 3.3 V. The MxL86211C entry in gpy_drivers[] now uses this probe
instead of gpy_probe().

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index 089a1a9e5bc61..fbac7c49b4759 100644
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
> +	vddp = devm_regulator_get(dev, "vddp");
> +	if (IS_ERR(vddp))
> +		return dev_err_probe(dev, PTR_ERR(vddp),
> +				     "failed to get VDDP supply\n");
> +	if (!vddp)
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "VDDP supply requires regulator support\n");
> +
> +	ret = mxl86211c_configure_mdio_voltage(phydev, vddp);
> +	if (ret)
> +		return ret;

[Severity: High]
Will this break probe for existing MxL86211C users whose firmware has no
vddp-supply property? gpy_probe() has handled the MxL86211C since commit
9d844da693d6. DT nodes written before this series won't have the
property, and neither will PHYs matched only by MDIO ID.

With CONFIG_REGULATOR=y and full constraints, devm_regulator_get() falls
back to the dummy regulator. That regulator has empty ops, no fixed_uV
and no supply, so regulator_get_voltage() reaches the last branch of
regulator_get_voltage_rdev():

drivers/regulator/core.c:regulator_get_voltage_rdev() {
    ...
	} else if (rdev->supply_name) {
		return -EPROBE_DEFER;
	} else {
		return -EINVAL;
	}
    ...
}

mxl86211c_configure_mdio_voltage() passes that -EINVAL back, and
mxl86211c_probe() fails without printing any message.

Without full constraints, devm_regulator_get() returns ERR_PTR(-ENODEV).
With CONFIG_REGULATOR=n, the stub returns NULL, which becomes -EOPNOTSUPP
here. So probe fails in all three cases.

When probe fails, the PHY no longer binds to mxl-gpy and phylib falls
back to genphy/genphy_c45. The PHY then loses the SGMII/2500BASE-X
possible_interfaces setup, in-band AN handling, WoL, LEDs, hwmon and the
SGMII re-AN workarounds.

No in-tree DTS sets vddp-supply for this PHY. Could this use
devm_regulator_get_optional() instead, and leave the hardware/strap
default in place on -ENODEV?

The requirement is still there at the end of the series, because the
later mxl86211c_config_init() also fails when the voltage can't be read.

[Severity: Low]
The earlier binding patch in this series ("dt-bindings: net: maxlinear:
add MxL86211C VDDP supply") documents vddp-supply and makes it required
in maxlinear,gpy2xx.yaml. However, the schema's select only matches nodes
that carry the explicit compatible:

select:
  properties:
    compatible:
      contains:
        const: ethernet-phy-idc133.5400

A PHY node matched only by MDIO ID is not checked against this schema,
but mxl86211c_probe() still requires the supply for it. Should the
binding and the driver agree on which nodes need vddp-supply?

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

[Severity: Medium]
Should the VDDP supply be enabled here? mxl86211c_probe() stores the
handle in priv->vddp but never calls regulator_enable() or uses
devm_regulator_get_enable(). As a result, rdev->use_count stays at 0 for
this consumer. No later patch in the series enables it either.

Suppose VDDP is a switchable regulator that is on at boot but not marked
regulator-always-on. Then regulator_late_cleanup() will turn it off:

drivers/regulator/core.c:regulator_late_cleanup() {
    ...
	if (rdev->use_count)
		goto unlock;
    ...
	if (have_full_constraints()) {
		...
		rdev_info(rdev, "disabling\n");
		ret = _regulator_do_disable(rdev);
    ...
}

On a shared rail, another consumer could also turn it off by dropping its
last enable reference. In either case the MDIO/MDC/MDINT pads lose power
while the driver is still bound.

regulator_get_voltage() also works on a disabled regulator, so the read
in mxl86211c_configure_mdio_voltage() does not show that the pads are
powered.

[ ... ]

> @@ -1406,7 +1467,7 @@ static struct phy_driver gpy_drivers[] = {
>  		.name		= "Maxlinear Ethernet MxL86211C",
>  		.get_features	= genphy_c45_pma_read_abilities,
>  		.config_init	= gpy21x_config_init,
> -		.probe		= gpy_probe,
> +		.probe		= mxl86211c_probe,

[Severity: Low]
At this commit, only mxl86211c_probe() sets the pad voltage. .config_init
is still gpy21x_config_init, which doesn't touch VSPEC1_PM_CTRL.

phy_detach() can assert a hardware reset, and phy_init_hw() releases it.
After that only .config_init runs again. Wouldn't VSPEC1_PM_CTRL_MDIO_VOL
then go back to its hardware default?

The next patch in the series, "net: phy: mxl-gpy: release MxL86211C
Super Isolate", adds mxl86211c_config_init(), which calls
mxl86211c_configure_mdio_voltage() again. So this only matters for
bisection.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016112033.949026-1-robert.marko%40sartura.hr
