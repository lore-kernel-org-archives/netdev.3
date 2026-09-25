Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4A72C027C;
	Fri, 25 Sep 2026 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338086; cv=none; b=eRRw11IOx6WquwL5orTio8zqAwC+7VEjL0JCTwnFD4tdNIfr8aXqjoJ0WoEs80Yc7sOBTL6jZLN9k3rzBfpjorHvStqrsYaihWJji8wFckxsMmJYcL7Kzmnka8LdVTVclH+IqQa9B6cf7UTw1Uamohu05hGv2cJTziVCcXYlLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338086; c=relaxed/simple;
	bh=d6fZEchk/VckRlyR3hC79fRs1UNbQdtvXxLPF14JpT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYTMHq/SyVONbrKcSx2HUPydj09jbtYJm2Vx+NjfGLHDmSarQ59/mYl1uDFb4tC736Dyawd91MJiMZvahn5zgzj1/qDCZci0EcI4i7hYWD0N5YQcYCpKNxNs2C6fVINvJJ8K68JJY0v/ltdPETwB+0r0dpJtJqYYgg+q/cfJtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RfNvCgTA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RfNvCgTA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ip0BjCbeE5u2dnRs68g1AJi7dyB4zP4AIX8Xm2fbxDg=; b=RfNvCgTAlKllyivUK6W9vssIKy
	2FDpepoCXRq9vaWMga/Wa+H2T98yRIQDMtmd+iuKznWj5NLiCD64G7ntqGGouLH4ymOoy7k7RRMy+
	X3B21H3YvCq4KPLwOKshatfup8bwMF06fUynAhZRWKSqvzGalwuMuaadEW9NE21H1F0o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xA4iW-007BsJ-Jo; Fri, 25 Sep 2026 14:07:52 +0200
Date: Fri, 25 Sep 2026 14:07:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] net: pcs: airoha: add support for Airoha
 AN7583 SoC
Message-ID: <12d6e310-3aa9-45f1-925e-e3c8f2f0efad@lunn.ch>
References: <20260925072712.23419-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925072712.23419-1-ansuelsmth@gmail.com>

> +static void an7583_pcs_setup_scu_pcie(struct airoha_pcs_priv *priv,
> +				      int index, phy_interface_t interface)
> +{
> +	u32 xsi_sel;
> +
> +	if (priv->phy)
> +		return;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_USXGMII:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	default:
> +		xsi_sel = AIROHA_SCU_PCIE_XSI1_USXGMII;
> +	}
> +
> +	regmap_update_bits(priv->scu, AIROHA_SCU_SSTR,
> +			   AIROHA_SCU_PCIE_XSI1_SEL,
> +			   xsi_sel);

I suspect the AI will be here soon. xsi_sel is initially a random
stack value. IF interface is something else, you use that random value
with regmap_update_bits().

>  static const struct of_device_id airoha_pcs_of_table[] = {
>  	{ .compatible = "airoha,an7581-pcs-eth", .data = &an7581_pcs_eth },
>  	{ .compatible = "airoha,an7581-pcs-pon", .data = &an7581_pcs_pon },
>  	{ .compatible = "airoha,an7581-pcs-pcie", .data = &an7581_pcs_pcie },
>  	{ .compatible = "airoha,an7581-pcs-usb", .data = &an7581_pcs_usb },
> +	{ .compatible = "airoha,an7583-pcs-eth", .data = &an7583_pcs_eth },
> +	{ .compatible = "airoha,an7583-pcs-pon", .data = &an7583_pcs_pon },
> +	{ .compatible = "airoha,an7583-pcs-pcie", .data = &an7583_pcs_pcie },
> +	{ .compatible = "airoha,an7583-pcs-usb", .data = &an7583_pcs_usb },

Device tree binding update to list these new compatibles?

	Andrew
