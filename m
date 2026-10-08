Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6545D5E7;
	Thu,  8 Oct 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447518; cv=none; b=FDyrCQTdNQycdDiiEaLmbMgjuIvOLrnu+SOkpdAIXhPGB+pQrXBpM6Hw6prriJQO04Qv0w9Zup9vUlPHSr4de3XreuioprlSatEnWpQ7k/odzZd6lIrvCxyW6M2F5Ej9CR6Tm0hIS1nIjJyy+ziNVL7xMgHV5hgycsTxcipszws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447518; c=relaxed/simple;
	bh=xWUfOU8MuvctbubLUZLnCbRCMKaCKdNv8oxG9XGx8n8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W794PQ6aiIHVtkyoaJWuJbIssuFo9WbVVbVfm6t+FlHP2Ty5za2vXzyCp9LIGTGkfM+c+z3zsTesjkV26kvQXzetfkJB/IDrU2XETDD2vq3LdeguDB4K4hpxrHzO5+I0SmZbZlS8o8H6es7x7qPQ79PnlsBxbgevSWwG+ptKtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDfC9//0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDfC9//0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7481F00893;
	Thu,  8 Oct 2026 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447517;
	bh=Mzpy3pXiZbbNuv4st42NYIwUfkQrYV+MjLygJ2qXHRI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iDfC9//0XDrOFu6ad0yHNqi0Az5C/ay57kTGzulGGnIEY/iB62zvE9G4YFynasyDw
	 /rOIeHd+G8VngwBR5SQ17rz9heNpdpcDoNaKOA134KUHd/+gwzbLRqp69GmFP2Xjsu
	 HAEd2KCmgRdosJQoCm7SZSC8XiHX0zM/7cKgJUHNypx6pwde4v6D2b346HWn0s7hqi
	 FZ6zVJz72c9BE2dOhsDWKvX5HNWwKL7ORCz9nzK/SJolyZqEkwNNhOc4WbfhFozlEh
	 GgfS8s8l8oLy3KHPQZ4+XBb557AtX/gnZq+BJ1oy/0uZ587eFrqFcwZcY/7NPHHQiG
	 hrJxfqU1EnkRA==
Subject: Re: [PATCH net-next v2 2/2] net: phy: realtek: support unaligned
 RTL8224 PHY packages
From: netdev-bot+sashiko@kernel.org
To: oskari@lemmela.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, daniel@makrotopia.org,
 javen_xu@realsil.com.cn, vladimir.oltean@nxp.com, olek2@wp.pl,
 o.rempel@pengutronix.de, ih@simonwunderlich.de, amadeus@jmu.edu.cn,
 jan@3e8.eu, f.fainelli@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mensi@mensi.ch
Date: Thu, 08 Oct 2026 08:18:35 +0000
Message-ID: <179144751562.434549.8240253139319713521@kernel.org>
In-Reply-To: <20261005201540.913977-3-oskari@lemmela.net>
References: <20261005201540.913977-3-oskari@lemmela.net>
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

- [Medium] The RTL8224 text added to realtek,rtl82xx.yaml (preceding
  commit "dt-bindings: net: realtek,rtl82xx: document RTL8224 packages")…
- [Low] The new RTL8224 package example in realtek,rtl82xx.yaml
  (preceding commit "dt-bindings: net: realtek,rtl82xx: document RTL8224…

--

net: phy: realtek: support unaligned RTL8224 PHY packages

This commit makes the RTL8224 driver take the package base address from
the reg property of an ethernet-phy-package parent node, rather than
always rounding the PHY address down to a multiple of four. The port
index relative to the package is stored in a new struct rtl8224_priv and
used to pick the MDI pair order and polarity fields. When there is no
package node, the old aligned-address assumption still applies.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index e14960192e791..91cf34d134202 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c

[ ... ]

> @@ -2783,9 +2789,42 @@ static int rtl8224_config_init(struct phy_device *phydev)
>  
>  static int rtl8224_probe(struct phy_device *phydev)
>  {
> -	/* Chip exposes 4 ports, join all of them in the same package */
> -	return devm_phy_package_join(&phydev->mdio.dev, phydev,
> -				     phydev->mdio.addr & ~3, 0);
> +	struct device *dev = &phydev->mdio.dev;
> +	u32 base_addr = phydev->mdio.addr & ~3;
> +	struct rtl8224_priv *priv;
> +	struct device_node *np;
> +	int ret;

[ ... ]

> +	np = of_get_parent(dev->of_node);
> +	if (of_node_name_eq(np, "ethernet-phy-package")) {
> +		ret = of_property_read_u32(np, "reg", &base_addr);
> +		of_node_put(np);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing or invalid PHY package reg\n");
> +
> +		if (phydev->mdio.addr < base_addr ||
> +		    phydev->mdio.addr - base_addr >= 4)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "PHY address outside RTL8224 package\n");
> +
> +		ret = devm_of_phy_package_join(dev, phydev, 0);
> +	} else {
> +		of_node_put(np);
> +		/* Without a package node, assume four aligned PHY addresses. */
> +		ret = devm_phy_package_join(dev, phydev, base_addr, 0);

[Severity: Medium]
What happens in this fallback when an RTL8224 is unaligned and has no
ethernet-phy-package parent?

The binding text added in the preceding commit "dt-bindings: net:
realtek,rtl82xx: document RTL8224 packages" says the package node is
optional:

  Its PHY nodes may be grouped under an ethernet-phy-package node ...
  This address need not be a multiple of four.

That text never says the package node is required when the first PHY
address is not a multiple of four. So a DT for the Hasivo
S1100WP-8GT-2S+ layout (chips at 1-4 and 5-8) that has no package nodes
still passes the schema.

For that DT, this branch uses base_addr = addr & ~3 with no check:

  PHYs 1-3 join base 0, which is not part of either chip
  PHY 4 joins base 4 with port_offset 0
  PHYs 5-7 (ports 0-2 of chip B) also join base 4, with offsets 1-3

rtl8224_package_modify_mmd() then does a read-modify-write of
RTL8224_VND1_MDI_PAIR_SWAP and RTL8224_VND1_MDI_POLARITY_SWAP at package
address 0:

	val = __phy_package_read_mmd(phydev, 0, devad, regnum);
	...
	ret = __phy_package_write_mmd(phydev, 0, devad, regnum, val);

Wouldn't chip B's pair order and polarity settings end up in chip A's
registers? They would also overwrite the settings for chip A port 3, and
nothing reports an error or warning.

Commit 330296ea9e15 ("net: phy: realtek: add RTL8224 pair order
support") says the swap "has to be set correctly for each of the 4 ports
before the chip can detect a link". The affected copper ports may
therefore fail to link.

Could the binding require the package node when the first PHY address
is not a multiple of four? Alternatively, could this fallback reject or
warn about the ambiguous case?

> +	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to join PHY package\n");

[Severity: Low]
This isn't a bug, but I have a question about the RTL8224 package
example added to realtek,rtl82xx.yaml in the preceding commit
"dt-bindings: net: realtek,rtl82xx: document RTL8224 packages".

The only compatible on each child PHY in that example is:

	compatible = "ethernet-phy-ieee802.3-c45";

The schema has no explicit select, and its compatible enum lists only
ethernet-phy-id001c.xxxx values.

Doesn't that mean dt-schema never applies realtek,rtl82xx.yaml to these
nodes? They would then be checked only against ethernet-phy-package.yaml
and ethernet-phy.yaml.

If so, the example never exercises the RTL8224-specific rules in this
file: unevaluatedProperties: false, the leds: false rule and the vendor
properties. A wrong property in the example would still pass
dt_binding_check.

This is partly an existing limitation. The first example has no
compatible either, and cameo-rtl9302c-2x-rtl8224-2xge.dts also uses only
the c45 compatible for RTL8224.

> +
> +	priv->port_offset = phydev->mdio.addr - base_addr;
> +	phydev->priv = priv;
> +
> +	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005201540.913977-1-oskari%40lemmela.net
