Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28170389447
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769897332; cv=none; b=ag4fuNqaFmK2RhRmMr1Ewpf9Yl6oCmd+aYZ5as1tdepIj1N1I68pR1bKaq5CR+EDqFembK8v8un92prdl6y9EZFyMz5VtjjyPwNSslSpM69LCE2nPs655dMLKP6rHFF3C3MIEIoVj4NwSgz5hQaIgq8gSUnwWPySbbYRV4ql03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769897332; c=relaxed/simple;
	bh=Hn8w/ZxgQKZB1pqDOktEsWsMFqCOzwf2moKrHkSKVE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsYAEEIVSYeJzkkqRa2ItYz8ezcT+OSzsUKhSJ5KU6HBITBpY/HBCeXtAcHOa2GqUd2/I3gfxRhHePK2aIjiqTpXJTi5ZaBaCeiXft/CHasCYM8z8gx4ld5/aCYdsLI3c+MoG7nPfWC5BMypwKNwO9VZ9OPDe8/1Ff8wXFaZxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9r9IU5+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9r9IU5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B85BC4CEF1;
	Sat, 31 Jan 2026 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769897331;
	bh=Hn8w/ZxgQKZB1pqDOktEsWsMFqCOzwf2moKrHkSKVE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9r9IU5+7sYqoinIEQH1ySie6BgWaECZAb0Q5MFZ1kMuAG6Qi2n+B6TLTquqRSagO
	 RYdz3jEFc1sZXCOExF0vvuG2y73z+DD/8DJIxht6zCN3pMoed+nWMYduJNKkUzZf09
	 VeR7Fu8CxztCorCGYB+q5jDNozzNl71ADEmdyVAq7n+3TOlDo7T7ikgSVCR7gKt/0V
	 wVhGk2UJ2iX3gyIMCW6NjYfuJtKyCMRIhHFSykO/Gcly78dpZHR4hw7k35DtHY3UoW
	 K9e0O6JV0VdGx3hErxZ5mKc3t3Cs4b++DRXAoXSY73aSnNPPSSmlbcpNdDrX/T7P7U
	 oEO1ggyX1v7Ig==
Date: Sat, 31 Jan 2026 14:08:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiko
 Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: stmmac: rk: convert to mask-based
 interface mode configuration
Message-ID: <20260131140850.3c35f95a@kernel.org>
In-Reply-To: <E1vlmEY-00000006znn-0N0Q@rmk-PC.armlinux.org.uk>
References: <aXyPK9rlMt8h_fze@shell.armlinux.org.uk>
	<E1vlmEY-00000006znn-0N0Q@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 11:00:14 +0000 Russell King (Oracle) wrote:
> +	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
> +	if (ret < 0)
> +		return ret;
> +
> +	intf = ret;
> +
>  	ret = gmac_clk_enable(bsp_priv, true);
>  	if (ret)
>  		return ret;
>  
> +	if (bsp_priv->gmac_phy_intf_sel_mask ||
> +	    bsp_priv->gmac_rmii_mode_mask) {
> +		/* If defined, encode the phy_intf_sel value */
> +		val = rk_encode_wm16(intf, bsp_priv->gmac_phy_intf_sel_mask);
> +
> +		/* If defined, encode the RMII mode mask setting. */
> +		val |= rk_encode_wm16(intf == PHY_INTF_SEL_RMII,
> +				      bsp_priv->gmac_rmii_mode_mask);
> +
> +		ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
> +		if (ret < 0)

missing
	gmac_clk_enable(bsp_priv, false);
here?

> +			return ret;
> +	}
-- 
pw-bot: cr
