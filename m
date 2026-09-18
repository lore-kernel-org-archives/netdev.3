Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60F192B75
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693353; cv=none; b=EsP83etgS0HYXTi1E5OmlO6v++wWr25mqNKIihYq2SmvxHqUFS+T52F4nmEGO0Kw2Pdj8l2ygxFtoQZk8WSMONim02MuWF70Lv6tEVBEolE3SCQqtBSDsiQdJ35dn4MahpmPauN8eNKhhOMJ4L3QJWBakzU4o+7MJ1SLW2NwlRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693353; c=relaxed/simple;
	bh=blglleRcDjT6CRpAJlSWgvVfoRsC9biYPWqwZsZPGXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKH7bnixSAwjywHvClWlcT/qIx1+6bfb1yNp+69RDdjIPquxLe8S4j+VWaDFzh6lXPOwOzxHpWRBueBLuOv16aAu/pNROlp2NsVcBE269l9OTSuUWwx0QE4XVL1XHnokN00TmWXb0aibYVxosCbemvzqJPQaKNG1NuCtvqW45kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BobdElza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BobdElza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FFF1F000FF;
	Fri, 18 Sep 2026 01:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693351;
	bh=ZhSr1NUTxvuHPFulSPxLSnWjmJ6m/kmgM5CTGfIudZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BobdElzaGECp8b0JL91HjmWSOJCQuFY8GvBTIHOj3TaI15fxpzXjP3fjgAAPAkHnA
	 iciSMEnqGfO7BR340xE9EvFPhPLkEronShZM0Qo59TLRJrZHLu5+/2sO5e/ggy75Cr
	 ArzXXBj8+hUiuk//ZPKgFIb+rBAmBRwvYP7vdJMZrQAs4J/yFZ1G3j5/Umoasv1LwU
	 NPnRJLZlSgyTByYfhtsY2blFWZYmYZcO58S8A6GmfrbGPwEvsB3uiESCh958ypJYxc
	 XKjPJTAZ8ukW5CdGh6Foix+C2KLQzBYtDLpY3Lpff15AwS6kKYad5IvgDhpS8gRZ1V
	 /kDaH+ACWg3pw==
Date: Thu, 17 Sep 2026 18:02:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH v3] Add config phase for dp83td510e phy
Message-ID: <20260917180231.17dcc86c@kernel.org>
In-Reply-To: <370d52b3f5da403b5a92226a92cb23cd92c4b4a4.camel@sprinte.eu>
References: <370d52b3f5da403b5a92226a92cb23cd92c4b4a4.camel@sprinte.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

some checkpatch nit picks to address here:

On Tue, 15 Sep 2026 07:15:09 +0000 Julien Blanc wrote:
> +	if (phy_interface_is_rgmii(phydev)) {
> +		rx_int_delay = dp83td510_config_rgmii_rx_delay(phydev);
> +		/* Set DP83TD510E_RX_CLK_SHIFT to enable rx clk internal delay */

nit: we prefer staying under 80 char line width if it doesn't make 
the code less readable. Comments should always be under 80 chars.
You can probably drop this comment completely, IDK what value it adds,
the if below is clear enough

> +		if (rx_int_delay)
> +			rgmii_delay |= DP83TD510E_RX_CLK_SHIFT;
> +
> +		tx_int_delay = dp83td510_config_rgmii_tx_delay(phydev);
> +
> +		/* Set DP83TD510E_TX_CLK_SHIFT to enable tx clk internal delay */

ditto

> +		if (tx_int_delay)
> +			rgmii_delay |= DP83TD510E_TX_CLK_SHIFT;
> +
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_RCSR,
> +				     DP83TD510E_RX_CLK_SHIFT | DP83TD510E_TX_CLK_SHIFT,

this is also >80 char but more of a judgement call, up to you

> +				     rgmii_delay);
> +		if (ret)
> +			return ret;
> +
> +		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
> +				       DP83TD510E_RCSR, DP83TD510E_RGMII_MODE_EN);
> +
> +		if (ret)
> +			return ret;
> +
> +	} else if (phydev->interface == PHY_INTERFACE_MODE_RMII) {
> +		// set RMII_MODE_EN, clear RGMII_MODE_EN (exclusive)

Okay, but you're mixing comment styles, above you used /**/
(so does the rest of this file)

> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_RCSR,
> +				     DP83TD510E_RMII_MODE_EN | DP83TD510E_RGMII_MODE_EN,
> +				     DP83TD510E_RMII_MODE_EN);
> +		if (ret)
> +			return ret;
> +	} else {
> +		// may be RMII, which is supported, or something else. Just 
> +		// return success to keep the old behavior and not break 
> +		// anything. Configuration may have been done by straps so 
> +		// it's better to keep as-is.

This comment block has trailing space chars, please clean up

> +		ret = 0;
> +	}
> +
> +	return ret;
> +}

Please use --subject-prefix="PATCH net-next v4" when reposting,
to clearly mark the patch for net-next and add/preserve Andrew's
review tag
-- 
pw-bot: cr
