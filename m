Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A64344D9B;
	Tue, 29 Sep 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642446; cv=none; b=AiAHXtfOOSF8ZhG6SwPh/2+idnM6sjSMToQI6zbRFnO8aARI2tEqRi8kCiinLNC9rfxlL+2ZDjwk+vJmGoMkNxSTPaB7UlE/21jyaiBLBgIlkG3en8uWd5gSlcmguR0TS3xXtrdoFxb6i2Z35hFpxKgSx8d+vqCgbdXA9DHPIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642446; c=relaxed/simple;
	bh=LzNbdN0uaOSVOL15u5V46O1zF4ixCb5IE2pw1QccxKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy1yqkf2PeqFubVxueIoBU0rJeNdK9AZOUonkZxrJlSWZHfX+CBGpAvtxlBQXs61x21I0feXZiHTTMpCb+hJ/F3bt0IRXTMtnLP6dVzgjauVj0Mvm/bGQICBQ6FpEYI1+bAiPHank3K1/mOSz+Ky9/68Qo5Y5lkEsSTdPTocZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=snATtY7W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="snATtY7W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H+3P9/1H80uhqAW/O2F9lJsnZpl88zS81n6oqSI+3zE=; b=snATtY7W4q5KrAcTqigzQCiJld
	ryNVpo9AeN1ibl8sLIj+ohKoH2CTeJq2kejTSzqLG5hDIMKfoKSCtcEhY9MARzeCfbNJB4QbhNuOy
	3VKJ6/neWEi90O4T9+SozQl+F8g58iVu+6eYkjmV63Bv75JaF5zgCVBYMz0BYyD/x+1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBLtd-007pae-Qv; Tue, 29 Sep 2026 02:40:37 +0200
Date: Tue, 29 Sep 2026 02:40:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca83xx: read resolved QCA8337 link
 status
Message-ID: <01a62e77-6c4e-4665-ba46-26d12b1c77b4@lunn.ch>
References: <20260928220749.857-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928220749.857-1-yongzhao.derek@gmail.com>

On Tue, Sep 29, 2026 at 12:07:49AM +0200, Yongzhao Chen wrote:
> Read QCA8337's vendor status on each autonegotiated link check so the
> reported speed matches the PHY after SmartSpeed changes negotiation.
> Keep link down while that status is unresolved or encodes a reserved
> speed; PHYLIB then notifies its consumers when valid status returns.
> Forced mode continues to use the generic BMCR result.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
> Assisted-by: LLM
> ---
> Andrew suggested this in his review of RFC v3 4/5, where he noted that
> read_status should report the real speed from the vendor register.
> Thanks, Andrew. I mentioned this change in the same thread:
> https://lore.kernel.org/netdev/20260924234814.1734-1-yongzhao.derek@gmail.com/
> 
> It does not depend on the qca8k series and applies to net-next on its own.
> 
> Testing: a model test compiles this function with the real
> genphy_read_status(), phy_resolve_aneg_pause(), phy_read_status() and
> phy_check_link_status() and covers 10/100/1000 in both duplexes,
> unresolved and reserved speed codes, a speed change while the link
> stays up, forced mode, pause resolution and MDIO read errors. W=1
> builds for arm64 are clean. The same function is in my OpenWrt Linux
> 6.18.52 build for a Redmi AX5400 (QCA8337), including the build used
> to test the at803x IPQ5018 fixes. I have not injected a real SmartSpeed
> downshift on a user port.
> 
>  drivers/net/phy/qcom/qca83xx.c | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
> index bc70ed8efd8..b3f3183d4a4 100644
> --- a/drivers/net/phy/qcom/qca83xx.c
> +++ b/drivers/net/phy/qcom/qca83xx.c
> @@ -92,6 +92,54 @@ static int qca83xx_probe(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int qca8337_read_status(struct phy_device *phydev)
> +{
> +	int ret, ss;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret)
> +		return ret;
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return 0;
> +
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = false;
> +	phydev->asym_pause = false;
> +	if (!phydev->link)
> +		return 0;

If there is no link, genphy_read_status() will of already set these to
_UNKNOWN etc. There is no need to clear them.

> +	/* SmartSpeed can make the actual speed differ from the advertised modes. */
> +	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
> +	if (ss < 0)
> +		return ss;
> +	if (!(ss & AT803X_SS_SPEED_DUPLEX_RESOLVED)) {
> +		phydev->link = 0;

Can this really happen? BCMR says there is link, but this says there
is no link? What does the data sheet say? It seems unlikely to me.

	Andrew
