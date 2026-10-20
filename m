Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503387;
	b=o1QUaEowyotxfzv5y7XibgCvJYMqVjpY9TqJ6ovFxR037Glb1cGvw35QXE7LvPnqAsz/
	 PQ5J0admPWWT1ZlwFUOEDZd8Jjom9j1q3U0QcZNfAxhx89uWFvYUVEprklUz5d+iOBPrI
	 iln8P31woeW0xixb5xPLYh6TyxdHL0GkQu/wIehhLCijBr0G5ZT2UtTVkn64XK0xFqTKb
	 xgCHXFVXdEBNx8SgaisTzouSJmlA73DO4xJj/JI1RclpZUP55dQGV1+d4xBS+fFVNJjVH
	 KGge+3MjQvcjUUAZ4Sg0zMq+lpTzPes4pk9ao+RwpfBCysUp12D0goqAnKAdlPaBW9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503387;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=F/efK23LeIOGaOPfvaxqK/IGnFt5fdIsZ71nTbD9mZM=;
	b=n4ytqkCM/DhW/pBYiMAHkBjIcGPhCLOGmCw00lNe7mpnjiL8xpXMTBYh6efirKXGYehv
	 tu1WCDnPf0WE1+qWrLiuw23mguxwHGCUbo67RFNvK9znfqo/v1+gHnAnQa1jeIOGTDqGh
	 TixhevOotKtv8ZiDXDAuMIlMWav2lva8o5NSASWLtidaSFYCThjABEqqnDm15GUT7YBgE
	 IwgfBPR/10/1xvxaoUpG56gV2Xsb4k4jdbiwIWeoJbno6hRINfGhdhcMgokMK1OeI5gSA
	 6gIAzZpj3+rhxdmM3ElZ/QELDnr4dAjvmBH1fEzK1fmNkFFkaV1V45KZKxam+oo0hfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWSBL7sS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902860A2612;
	Tue, 20 Oct 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWSBL7sS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA661F000C4;
	Tue, 20 Oct 2026 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503386;
	bh=F/efK23LeIOGaOPfvaxqK/IGnFt5fdIsZ71nTbD9mZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lWSBL7sST/V2DDFFYF1LLU/cLmOhW8X0V0PLOyAvOLgtaPC2egSSongVCFWVijrNJ
	 0oeuPYtAc/bsZ7wqDosGRoSph2HrUbjRUtJrssMaUbaQB7vHbhsnEiJw1ETKjmURUD
	 PQ/JxX5mZzvT/9+UPWNoFS5DEEnlfXDeAdieW5bvyaYR/P3PZ4AS+Agwr+jP/3Aumk
	 vBKHNxnKEKv0JcclODjNHYUrg3phHhUs0W7jnAC2uORqlNUFT/kIHOtdMfcOvW/Fbz
	 8FuZMd/pb+TGula5W5jz/OtwcNUb/xVAB9tAl2/D/Bwtuo0b3mSS9ENXDRB62hjgut
	 pxKFQ8kP6WcjQ==
Subject:
 Re: [PATCH net-next v2 5/5] net: phy: mxl-gpy: support MxL86211C lane mapping
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, michael@walle.cc, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lrosu@maxlinear.com,
 luka.perkov@sartura.hr
Date: Tue, 20 Oct 2026 13:36:25 +0000
Message-ID: <179250338515.3135.6239703047800333744@kernel.org>
In-Reply-To: <20261016112033.949026-5-robert.marko@sartura.hr>
References: <20261016112033.949026-5-robert.marko@sartura.hr>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The binding and the driver disagree about which nodes
  `maxlinear,lane-asp-map` is valid on and how long it may be.

--

net: phy: mxl-gpy: support MxL86211C lane mapping

This commit lets the MxL86211C take an optional maxlinear,lane-asp-map DT
property. The property programs the mapping from physical TPI lanes to
analog front ends in VSPEC1_LANE_ASP_MAP. When the property is absent, the
hardware reset mapping is left alone.

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index 8bc119655f104..acd5ad01a285d 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c

[ ... ]

> @@ -423,6 +430,42 @@ static int mxl86211c_configure_mdio_voltage(struct phy_device *phydev,
>  			      VSPEC1_PM_CTRL_MDIO_VOL, val);
>  }
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

[Severity: Low]
Should a maxlinear,lane-asp-map with more than 4 cells be rejected here?

With the OF backend, device_property_read_u32_array() ends up in
of_property_read_variable_u32_array() with sz_max set to 0.
of_find_property_value_of_size() treats that as "no upper bound":

drivers/of/property.c:of_find_property_value_of_size() {
    ...
	if (max && prop->length > max)
		return ERR_PTR(-EOVERFLOW);
    ...
}

So a value like <0 1 3 2 1> is accepted. Only the first 4 cells are
used, and nothing is logged. The binding says the property has exactly
4 items.

The range and duplicate checks below still keep bad values out of
VSPEC1_LANE_ASP_MAP. The problem is that the driver and the binding
accept different things.

The schema may not catch this case either. The driver binds by PHY ID
through PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C), whatever the node's
compatible is. However, maxlinear,gpy2xx.yaml (from the earlier
"dt-bindings: net: maxlinear: add MxL86211C VDDP supply" patch) only
selects nodes that carry this exact compatible:

select:
  properties:
    compatible:
      contains:
        const: ethernet-phy-idc133.5400
  required:
    - compatible

An ethernet-phy@N node without that compatible is only checked against
ethernet-phy.yaml, and that schema allows additional properties. So a
malformed maxlinear,lane-asp-map on such a node would pass dtbs_check,
and the driver would still read it.

There is a related issue in "dt-bindings: net: maxlinear: add MxL86211C
lane mapping support". The allOf if/then/else tests the same compatible
that select already requires:

    else:
      properties:
        vddp-supply: false
        maxlinear,lane-asp-map: false

Can this else branch ever be evaluated? No other schema references this
one, so the ban on these properties for other GPY PHYs never seems to
take effect.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016112033.949026-1-robert.marko%40sartura.hr
