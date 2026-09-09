Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832964BFE99;
	Wed,  9 Sep 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994957; cv=none; b=Cd4I8wR0uHxMkHK2KZNEeEjw7olQ6AcffBN8uWQQBpREOQpjdd7ZbR6owUlmgiajNCf0x5FHtwwM95+xkSXUf1E82VZJ8MnstW5y1PhE+rO2O8vvlvlQgY4vazJv507lTDSdfd69TVMMkPqsXQBOvkbfELfHp/yFYTQUqJAzdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994957; c=relaxed/simple;
	bh=QjK16sie7MgXB96+Ng63IwlmIeaS29filRHpCphWWS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnMM5B/YEdHApFGH8BOiylRmOYihYh+ex/y5fcLUW0qtQLupD6gNACalMl/ku0xZXJlEjcSKIBvNXbn6JrgwQG3PFtYSYQrzKLwB708P+NRtop067OXWwkeTFq4he7RhDY0bM0HFmVDJ1JiREXdm3OhivEsWimlMgRUnxL2nkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x4RJB-000000005g9-2wtQ;
	Wed, 09 Sep 2026 23:02:25 +0000
Date: Thu, 10 Sep 2026 00:02:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: Re: [PATCH net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
Message-ID: <aqHlfmYa249e3HRM@makrotopia.org>
References: <20260909213250.3184238-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909213250.3184238-1-cjd@cjdns.fr>

On Wed, Sep 09, 2026 at 09:32:50PM +0000, Caleb James DeLisle wrote:
> The EcoNet EN751221 multi-chip module implementation of the MT7530
> requires some additional configuration of the PHYs on startup.
> The reason for this is not known, but it is possible that it has
> to do with the fact that the EN751221 MCM implementation of the
> MT7530 runs at an abnormal PLL frequency (362.5Mhz).
> 
> Detect whether the MT7530 PHY is attached to the MDIO bus of an
> EcoNet EN751221 switch and if so, apply the necessary register
> updates.
> 
> Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
> Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  drivers/net/phy/mediatek/mtk-ge.c | 61 +++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
> index 73d9b72f9d9e..42b06c40d703 100644
> --- a/drivers/net/phy/mediatek/mtk-ge.c
> +++ b/drivers/net/phy/mediatek/mtk-ge.c
> [...]
>  static int mt7530_phy_config_init(struct phy_device *phydev)
>  {
> +	int ret;
> +
> +	if (mt7530_phy_is_en751221_companion(phydev)) {

Please introduce a `.match_phy_device` operation for both, actual
MT7530 and EN751221, similar eg. to `ksz8051_match_phy_device` in
micrel.c.
