Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF93E7145;
	Wed, 29 Jul 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314371; cv=none; b=MUVnJ4oi30IF2+b/6ZkTXUa15Fw4pUZlP7knx+bacvBE/vi/cyHkgasyMsq52ANCc1JxJQQnuudoaOUcBpTiGG1SdZAKrHtti/yKOGU+c9+AJlDXPuRWlF82DrlSpDWdb+2LuX49G4YgBwO/1qYCs5NQYp6XQHcRY3rMSrI/8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314371; c=relaxed/simple;
	bh=UM8HBCtPVdOaOSvdbk9a5tm9Q7JN3rityBvbIxTGeZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do49Gdu96lZkRZDUmQVTydoG1yFGMmTIFWyFXo8j1K/GqyPL4HqOg3wTOWAVEs4xudPSH7HT4VL8gBpxCDM6hPmajMLePUAgZBYpncWqJnaHZtXhM43I9nJPyBrsTvJTJlDdL119zPyVkY80EU6a1Q9SDPj+AmLCsqjib4dphDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TG73zpzj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TG73zpzj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 600E01A12E0;
	Wed, 29 Jul 2026 08:39:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D2B26039A;
	Wed, 29 Jul 2026 08:39:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 552BE11C11F9A;
	Wed, 29 Jul 2026 10:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785314367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xEogLVz2Pxf/eMF1mT9hKyyJhYalrfWxY3ZeNkdqKtA=;
	b=TG73zpzjMGwlBGqQr7eou0y5j+JTAPvYfRWCv0jIqrDhirMl6CevXEP/jZ/jZUbDMA0FMo
	Xn+W/nhIhOdVDJgnAT9fvMf/m9zPm+S/lwjk1nyXwEJjz2V+0ViCG3qUrKAX532CEBM8CL
	x5dzsKJ0ySYCJrdRZRGZz+LvGSJCCs0dnf1p82PE77i1GgpssbGp/jy4Zjq0kBS/u0n+eN
	jGJacI+0zGDaKkxzgj06aQAEc5pi4LXfvfWwUv9U6KXv5ygW9PFaThjK0yReKsr+is+x6V
	bsJeosa79xsr3vMdtbMmOJ58nUbzr0nUJz73v+4kpTXLXYH0KNpbymEpA9Kglw==
Message-ID: <ca8bb107-4e64-4078-8747-cd256ecfc792@bootlin.com>
Date: Wed, 29 Jul 2026 10:39:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: phylink: allow PHYs to be attached
 in 802.3z inband mode
To: Zxyan Zhu <zxyan0222@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729074237.2624940-1-zxyan0222@gmail.com>
 <20260729074237.2624940-3-zxyan0222@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260729074237.2624940-3-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 7/29/26 09:42, Zxyan Zhu wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Now that we have proper decision making for inband mode support which
> makes it a "best efforts" feature based on the capabilities of the PHY
> and PCS, we can relax whether we expect and permit a PHY to be
> attached. This is especially true for the 2500BASE-X case which some
> PHYs use without inband on their host side interface for 2.5G speeds,
> but use inband for slower speeds switching to SGMII on their host side
> interface.
> 
> We already have such a case for some qcom-ethqos setups, although
> qcom-ethqos overrides phylink's inband settings by accessing the PCS
> directly at the moment. This should allow qcom-ethqos to transition to
> defaulting to inband when 2500BASE-X or SGMII is specified in its DTS.
> 
> Allow PHYs to be attached when inband mode has been specified, which
> will be necessary to allow inband mode to be used on qcom-ethqos.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/phylink.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 59dfe35afa54..fd4e80eeeda7 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1964,9 +1964,7 @@ EXPORT_SYMBOL_GPL(phylink_destroy);
>   */
>  bool phylink_expects_phy(struct phylink *pl)
>  {
> -	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
> -	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
> -	     phy_interface_mode_is_8023z(pl->link_interface)))
> +	if (pl->cfg_link_an_mode == MLO_AN_FIXED)
>  		return false;
>  	return true;
>  }
> @@ -2205,9 +2203,7 @@ static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
>  {
>  	u32 flags = 0;
>  
> -	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
> -		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
> -		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
> +	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
>  		return -EINVAL;
>  
>  	if (pl->phydev)

