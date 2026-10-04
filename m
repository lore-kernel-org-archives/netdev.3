Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770971F3B85;
	Sun,  4 Oct 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119871; cv=none; b=idcZjZlYncUT4BU4CKJfOHdE+LoqjM4XhlY6Nwk6tHjECBQCii2iZn9HTr5jc3GNGrPzQ7XXSW9prXjWDVaBsNSXjbDEfGZFCWftaYt5orfHfYJcrB31HNii8fxGf/bL007RZIkWqLGJQdF0mjTLIGyD8HCjVd9jWw0s/tiHrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119871; c=relaxed/simple;
	bh=vUA5WKJqhGmlI7KcbJrBIYYjKz9sp6W098rZd3zh5ac=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inVi5ktgC6H1dL0pHKvYfEhubY62CaUXmzfjalHO++hy8RcrXhDb3OjMNaHMlnFfCd/2fymALIHQSrXB8BAdXWNrzLKpixzR8wT4WcJQeE7ndCaBFi5mOmExzXWwMH6Lan6iFoy435h75SY4zACAcxB+/EIzHJL2/cOPrtlK1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3mLcn+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3mLcn+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3A81F000FF;
	Sun,  4 Oct 2026 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119866;
	bh=/+CqUBQZJxc90ye40efzg01j4LH4VlBM6/2chZcLOhc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U3mLcn+OES8yXa7M33W0J4YnJwdQo/pieLF/et1//Xh1HZsXpAzsGW2WkK0V8x/jl
	 Bqxss6bqptrdHfYHnsV73+GT5+iU0+eZJFWt6FO9+49ZmxLl7OyHaOgt9X6FpSsOK/
	 m81uZDL59SCXfxNjO3sJ0qB7CiodUVv3NKdt0Vkkr3w61PQgQZb8Gd0D2lHcBWVSVH
	 SMaDyc/krKaSUMm1+lruJ3wiv9RYCi+RJteUAT0jAi31WuVr6G/udugn/7jiCZzB+R
	 OmwFOcqqJEeZcATNHh2EfQMt0j/jn9LMLZ7Kze9ZTNo+WXX6TNh6iHeilLGc4rMwcG
	 LCrkFAmfqbQ/w==
Subject: Re: [PATCH 5/5] net: phy: mxl-gpy: support MxL86211C lane mapping
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Date: Sun, 04 Oct 2026 13:17:44 +0000
Message-ID: <179111986480.434549.1016045593989432989@kernel.org>
In-Reply-To: <20260930122305.293686-5-robert.marko@sartura.hr>
References: <20260930122305.293686-5-robert.marko@sartura.hr>
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

- [Medium] net: phy: mxl-gpy: potential overwrite of upper bits in
  VSPEC1_LANE_ASP_MAP

--

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -440,6 +447,50 @@ static const struct regulator_desc mxl86211c_mdio_desc = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static int mxl86211c_configure_lane_asp_map(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	u32 lane_asp_map[4];
> +	u16 val;
> +	unsigned int seen = 0;
> +	int i, ret;
> +
> +	if (!device_property_present(dev, "maxlinear,lane-asp-map"))
> +		return 0;
> +
> +	ret = device_property_read_u32_array(dev, "maxlinear,lane-asp-map",
> +					     lane_asp_map,
> +					     ARRAY_SIZE(lane_asp_map));
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(lane_asp_map); i++) {
> +		if (lane_asp_map[i] > 3 || seen & BIT(lane_asp_map[i]))
> +			return -EINVAL;
> +
> +		seen |= BIT(lane_asp_map[i]);
> +	}
> +
> +	val = FIELD_PREP(VSPEC1_LANE_ASP_MAP_A, lane_asp_map[0]) |
> +	      FIELD_PREP(VSPEC1_LANE_ASP_MAP_B, lane_asp_map[1]) |
> +	      FIELD_PREP(VSPEC1_LANE_ASP_MAP_C, lane_asp_map[2]) |
> +	      FIELD_PREP(VSPEC1_LANE_ASP_MAP_D, lane_asp_map[3]);
> +
> +	return phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_LANE_ASP_MAP,
> +			     val);
> +}
> +
> +static int mxl86211c_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = mxl86211c_configure_lane_asp_map(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return gpy21x_config_init(phydev);
> +}
> +
>  static int mxl86211c_probe(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;

[Severity: Medium]
mxl86211c_configure_lane_asp_map() writes VSPEC1_LANE_ASP_MAP with
a plain phy_write_mmd(). That means bits 15:8 of the register are
always written as zero, even though the patch only defines the four
2-bit lane fields in bits 7:0.

Those upper bits might hold something: reserved bits with a non-zero
reset value, or an unrelated control field. If so, they get cleared
whenever maxlinear,lane-asp-map is present in DT. The commit message
says the reset configuration is left alone when the property is
absent. When the property is present, this write also changes
whatever else lives in that register, not just the lane mapping.

Does the datasheet say bits 15:8 of VSPEC1 0x14 are unused and safe
to write as zero? If not, would phy_modify_mmd() with a mask built
from VSPEC1_LANE_ASP_MAP_A..D be safer? mxl86211c_probe() already
uses phy_modify_mmd() for VSPEC1_PM_CTRL, so that would also match
the rest of the driver.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930122305.293686-1-robert.marko%40sartura.hr
