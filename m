Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35D36606A;
	Mon, 27 Jul 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139366; cv=none; b=nBcSNg2HSTKthKfAe9Me/VFOjGth0Z/Xv/v/weSQ8fe3Flnr3ADKvcieqWkLXiYVsEwe8zdbSdu/F6aoE33SXcrCLh0LraR2MBLSwK+nOrUM8Xx5CiCZlP8rezajiV9Lp0VQ/tq0mJBqLCkvc5szHus+vDSymPuvPZRBabyItkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139366; c=relaxed/simple;
	bh=aCqveZO/uwV475G3YTUcfnz1omPwXA4O42AmfQZEfnY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFzeI3KFGRLOxlSLXrh8nGXh5p9j533eKRW8hcG2cEQ/Vg8aUkW2pTrXd9RWjg1tjVZAECtL4Qv/V7m+OFrvZGmRefCI4q/wnhFuK+t38h2E0l8vbTevJQD6ODQEwdz4/u6lgO/VziXuedWtMjJJNDyyoEsnizkswyL6iQFHR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 88EAF202055;
	Mon, 27 Jul 2026 10:02:42 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1woGIM-001VP2-1U;
	Mon, 27 Jul 2026 10:02:42 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1woGIM-000000007n2-1U0y;
	Mon, 27 Jul 2026 10:02:42 +0200
Message-ID: <d19b673bba6cfb5c9634510ba742021a7135f6c0.camel@pengutronix.de>
Subject: Re: [PATCH net-next v9 11/12] net: pcs: airoha: add PCS driver for
 Airoha AN7581 SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman	 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan	
 <skhan@linuxfoundation.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan	 <saravanak@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,  Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Date: Mon, 27 Jul 2026 10:02:42 +0200
In-Reply-To: <20260717065448.1498335-12-ansuelsmth@gmail.com>
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
	 <20260717065448.1498335-12-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fr, 2026-07-17 at 08:54 +0200, Christian Marangi wrote:
> Add PCS driver for Airoha AN7581 SoC for Ethernet/PON/PCIe/USB SERDES
> and permit usage of external PHY or connected SFP cage. Supported modes
> are USXGMII, 10G-BASER, 2500BASE-X, 1000BASE-X and SGMII.
>=20
> The driver probe and register the various needed registers and register a=
s
> a PCS provider for fwnode usage.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/pcs/Kconfig                    |    2 +
>  drivers/net/pcs/Makefile                   |    2 +
>  drivers/net/pcs/airoha/Kconfig             |   12 +
>  drivers/net/pcs/airoha/Makefile            |    7 +
>  drivers/net/pcs/airoha/pcs-airoha-common.c | 1324 +++++++++++++
>  drivers/net/pcs/airoha/pcs-airoha.h        | 1311 ++++++++++++
>  drivers/net/pcs/airoha/pcs-an7581.c        | 2093 ++++++++++++++++++++
>  7 files changed, 4751 insertions(+)
>  create mode 100644 drivers/net/pcs/airoha/Kconfig
>  create mode 100644 drivers/net/pcs/airoha/Makefile
>  create mode 100644 drivers/net/pcs/airoha/pcs-airoha-common.c
>  create mode 100644 drivers/net/pcs/airoha/pcs-airoha.h
>  create mode 100644 drivers/net/pcs/airoha/pcs-an7581.c
>=20
[...]
> diff --git a/drivers/net/pcs/airoha/pcs-airoha-common.c b/drivers/net/pcs=
/airoha/pcs-airoha-common.c
> new file mode 100644
> index 000000000000..781f89adf3ab
> --- /dev/null
> +++ b/drivers/net/pcs/airoha/pcs-airoha-common.c
> @@ -0,0 +1,1324 @@
[...]
> +static int airoha_pcs_setup_scu(struct airoha_pcs_priv *priv,
> +				int index, phy_interface_t interface)
> +{
> +	const struct airoha_pcs_match_data *data =3D priv->data;
> +	int ret;
> +
> +	switch (data->port_type) {
> +	case AIROHA_PCS_ETH:
> +		airoha_pcs_setup_scu_eth(priv, interface);
> +		break;
> +	case AIROHA_PCS_PON:
> +		airoha_pcs_setup_scu_pon(priv, interface);
> +		break;
> +	case AIROHA_PCS_PCIE:
> +		airoha_pcs_setup_scu_pcie(priv, index, interface);
> +		break;
> +	case AIROHA_PCS_USB:
> +		break;
> +	}
> +
> +	/* TODO better handle reset from MAC */

What does this mean? There's a "mac" and a "phy" control in rsts.
Should the "mac" reset be handled differently? Or is there a separate
reset line that is controlled by the MAC itself?

> +	ret =3D reset_control_bulk_assert(ARRAY_SIZE(priv->rsts),
> +					priv->rsts);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D reset_control_bulk_deassert(ARRAY_SIZE(priv->rsts),
> +					  priv->rsts);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

regards
Philipp
