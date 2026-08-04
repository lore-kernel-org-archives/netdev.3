Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E34252BB;
	Tue,  4 Aug 2026 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828921; cv=none; b=GDxRbRY+tYfUkx1NUvv+YZG/bQf8UV9U+7xP7UmoWZttgXRx1D2jzhgMkHkV87olDp+pDxRPpwZmWBk3A9pBX889h62qjgKBD80MvWHBgpOJQS89oSwftbUUDJ3XDEee3J2jRgBarmOjR8Uhoim5m8JoEas1kQyBCTbHqGuFjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828921; c=relaxed/simple;
	bh=VXq/e6yx/ODBsZFJHxHev9uG6iLtPJ63w3iGHEJgbd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gt4V38jrVLcXSTm+Y0hkzAvF4BDE5sxuNC1fWndp2yu6TADyHNwOM7UNUkDMy4rBAkwcQb2a0kEIkCcrCFj4PSUwN41b3KMDxFrQGvBnlfOsYbRgUNo+uKavPaR0iakYLNjil3LwOvGJUNCF/+IzmMjMpMnOVH38DP2MGBMQ7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I2tZ+bNA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I2tZ+bNA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 66CDF1A13F3;
	Tue,  4 Aug 2026 07:35:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F9F66029E;
	Tue,  4 Aug 2026 07:35:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87C3011C3243E;
	Tue,  4 Aug 2026 09:35:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785828911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AFfzA1yEpz98WSrUzXTIRfHYsrqeBVjjHGrLZ3rUQuw=;
	b=I2tZ+bNA0vzRFhmdyuin09lXj1zvdD7zwq/21TRtxvJAS28BdjiQqtpbzj/qkdu/zExPwL
	oPHZkLSwWK7Dx2acBZLJ3QnuU/EDBoTZFMxbEjiFUTJ/yEmg+lalZTFlB80ZIQYnAl2rQn
	dyJJccTFoqBivc6fofHC4q6t2/NO5siAIF7G79RfCow7oKPOhMOmFOaTNlaI2ARxjtMoWy
	6rcQtZiaPuta6OTGCRVld6D3B/e+eV6zHVjG3tif4H2eVPfj+pvBHDo+unxSNXCTHmKpeN
	VsQC+5ssJaQf9L7NrC/mZB4niI02oyvoAxeK7+OLrLr6hgKl9szAWq7bS0ZKZw==
Message-ID: <28ca553c-59ce-4608-b63a-6e8c4dfb6020@bootlin.com>
Date: Tue, 4 Aug 2026 09:35:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] net: pcs: xpcs: add ANRESTART support for SGMII
 link recovery
To: Coia Prant <coiaprant@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-8-coiaprant@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260801142244.679437-8-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Coia,

On 8/1/26 16:22, Coia Prant wrote:
> On some hardware using the DesignWare XPCS IP (e.g., RK3568 MAC side
> SGMII), the PCS does not automatically restart auto-negotiation when the
> link goes down and comes back up. Without an explicit ANRESTART, the link
> stays down forever.
> 
> Add BMCR_ANRESTART in two places:
> 1. In xpcs_config_aneg_c37_sgmii(), when starting AN, set ANRESTART
>    alongside ANENABLE to initiate a fresh negotiation.
> 2. In xpcs_get_state_c37_sgmii(), when link is down and AN completion is
>    detected, clear the interrupt and trigger ANRESTART to restart the
>    negotiation process.
> 
> This change has been verified on:
> - RK3568 (Photonicat board)
> - Wangxun NICs (no regression)
> 
> Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

KSZ9477's old XPCS doesn't break with that code, tested in SGMII
mode :)

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/pcs/pcs-xpcs.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 0337e2bcc0125..28e98449e8ac2 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -816,9 +816,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Clear CL37 AN complete status */
> +	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +	if (ret < 0)
> +		return ret;
> +
>  	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
>  		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
> -				 mdio_ctrl | BMCR_ANENABLE);
> +				 mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTART);
>  
>  	return ret;
>  }
> @@ -1089,14 +1094,18 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
>  			state->duplex = DUPLEX_FULL;
>  		else
>  			state->duplex = DUPLEX_HALF;
> -
>  		return 0;
>  	}
>  
> -	/* Clear AN complete status or interrupt */
> -	if (state->an_complete)
> +	if (state->an_complete) {
> +		/* Clear AN complete status or interrupt */
>  		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
>  
> +		/* Initiate the next round of AN */
> +		xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
> +				    BMCR_ANRESTART);
> +	}
> +
>  	return 0;
>  }
>  

