Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051D27057D;
	Tue, 16 Jun 2026 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570269; cv=none; b=AZpFpULEqTmu4tE2v1Wmn1MfG9S8wvhkxzB5UZV5Di3fOvdyKdP8yH/8guy/Z1jngiBlw71X4lteFzYtXVHL8FLtmOgOCyfVyHwsEXoZgVdl9Z13Sq6JdXA8A360mQbix5o2bb8ceolfMmaMWMiNgZnzBycWhpE317Oh4UT6Z/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570269; c=relaxed/simple;
	bh=N7CA8tu4gCXRdGUJj0ejv/KaQhb2xe2JGkx+TQDF/q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew4SXDeF5Y+2TST3VwQPiWqc1nmdHbvI5GLaSfVm8cHzjJsZOHoL0HD2NtGFVBNtxuG7KG0Qi32pPqAmOi/cgZTbsTyjEy1BGP6quCDiu5UCc8K5rMpnQcf3ibSFuEroPrPTAJjUlVNKZLcidAxAHKGAyRnCXrDy5gme9X4Y6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvyCCYEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvyCCYEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACA51F000E9;
	Tue, 16 Jun 2026 00:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570268;
	bh=iPkaIuVCWelyuZ6UjRfipwOZ9LpTBtSdPLH0Z1ddBOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lvyCCYEqMxBXtSsJSYbI4BQgdUyF5oOByFPppBjok3hK20phTyLoZPKazhnE4eFLn
	 grf0wb0lZojFxRREJaJJjZlrqYyvY8Qx4/rwZd7Jezh/5uSsN14ohagVVfnx+D12hD
	 hJaZwQ2kFerxHgeP7CsoyHZ2WeFWNGl1Hou+t3fuBVUwy5JxWcPzwK+9ckFFOzz40b
	 WzvxQN/KJK75a+UjYMLMdAsdhKdDGbN1Sv+KWdZNqAkfN4w8hF06n2PK2C5ITy4kT1
	 DMKrD/SGHrqWEVoS9eDR4GPCOpixHhi8gfg6vTjSSpnquPNDL7/itEV6iSBVT7aWLP
	 xY4esEAAAaOUw==
From: Jakub Kicinski <kuba@kernel.org>
To: markus.stockhausen@gmx.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 8/8] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Mon, 15 Jun 2026 17:37:46 -0700
Message-ID: <20260616003747.1104800-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-9-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-9-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: mdio: realtek-rtl9300: Add support for RTL839x

This patch adds RTL839x (cypress) support to the realtek-rtl9300 MDIO
driver, reusing the multi-device infrastructure that was prepared for
this purpose. It introduces a new RTL8390 register set, four c22/c45
read/write helpers, and a new otto_emdio_8390_info compatible table
entry.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index d9ff0b0aecbb..2ab1aeb85eed 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -139,6 +139,29 @@
>  #define RTL8380_SMI_POLL_CTRL			0xa17c
>  #define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
>  
> +#define RTL8390_NUM_BUSES			2
> +#define RTL8390_NUM_PAGES			8192
> +#define RTL8390_NUM_PORTS			52
> +#define RTL8390_BCAST_PHYID_CTRL		0x03ec
> +#define RTL8390_PHYREG_ACCESS_CTRL		0x03dc
> +#define   RTL8390_PHY_CTRL_REG_ADDR		GENMASK(9, 5)
> +#define   RTL8390_PHY_CTRL_PARK_PAGE		GENMASK(27, 23)

[Low]
Is RTL8390_PHY_CTRL_PARK_PAGE used anywhere?  It does not appear to
be referenced in the rest of the patch, while the analogous masks for
the 8380 and 9300 variants are populated with 0x1f in their c22 helpers.

For example, otto_emdio_9300_read_c22() does:

	.c22_data	= FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
			  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
			  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),

while otto_emdio_8390_read_c22() below only sets REG_ADDR and MAIN_PAGE,
leaving bits 27..23 of c22_data at 0:

> +#define   RTL8390_PHY_CTRL_MAIN_PAGE		GENMASK(22, 10)
> +#define   RTL8390_PHY_CTRL_FAIL			BIT(1)
> +#define   RTL8390_PHY_CTRL_WRITE		BIT(3)
> +#define   RTL8390_PHY_CTRL_READ			0
> +#define   RTL8390_PHY_CTRL_TYPE_C45		BIT(2)
> +#define   RTL8390_PHY_CTRL_TYPE_C22		0

[ ... ]

> @@ -457,6 +480,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *bus, int port,
>  	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
>  }
>  
> +static int otto_emdio_8390_read_c22(struct mii_bus *bus, int port, int regnum, u32 *value)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
> +	struct otto_emdio_cmd_regs cmd_data = {
> +		.c22_data	= FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
> +				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
> +		.ext_page	= FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
> +		.io_data	= FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
> +	};
> +
> +	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data,
> +				   RTL8390_PHY_CTRL_DATA, value);
> +}
> +
> +static int otto_emdio_8390_write_c22(struct mii_bus *bus, int port, int regnum, u16 value)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
> +	struct otto_emdio_cmd_regs cmd_data = {
> +		.c22_data	= FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
> +				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),

Should these helpers also set RTL8390_PHY_CTRL_PARK_PAGE to 0x1f, matching
the 8380/9300 convention, or is the macro itself intended to be removed
because the 8390 hardware does not need a parking page?

> +		.ext_page	= FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
> +		.io_data	= FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
> +		.port_mask_high	= (u32)(BIT_ULL(port) >> 32),
> +		.port_mask_low	= (u32)(BIT_ULL(port)),
> +	};
> +
> +	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data);
> +}

[ ... ]
