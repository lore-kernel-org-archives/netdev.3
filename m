Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FB48122B
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990065; cv=none; b=gzslLFzzjAKncXmdQnPP3rdwI0TNqtH4KBlLLN2dd5hu8sj9M7Q0NYgLz8QQ+gnzIS8YKqmXEQM22wLDOMELcecFTji/9cMnaxxA4eOQzU+Wv2XpN7yOPM7hfp0lmVOeycB425D8RFi5GT0k3aQQ11tOhTLJiaWjNjuo2td9/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990065; c=relaxed/simple;
	bh=5zU5zHcrpG+3Cyz4sXAs1SdYSi8opH/3j7h10Inx6UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLyUWajj7IhqvtzWF8BxsGKncNvMNRWvFEIbsK54tYlxyTxX9TP+0jnpagTUdTm/VIjodNVHrDzjGghalBNPy8K1/q2aVBh4RypROnpiZQbfXBFqhySzahPJa2kH7b4CabIzTHxCa0K+hEFcGtr9uhSM60tZ7bNF9yOAnuhhgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cdHtpclF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cdHtpclF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AC1EA1A299B;
	Wed, 21 Jan 2026 10:07:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72CB76070A;
	Wed, 21 Jan 2026 10:07:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D899119B1101;
	Wed, 21 Jan 2026 11:07:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768990055; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sQcfSLIQGBQsyjDnlCFvh7UQyWLEbwU5EueHUcH9sWA=;
	b=cdHtpclFrIFKL047AiJevVG8jQQrWHfZbb4no2Bv6z5dPsRZsE0CEK23fh3AE5y0HPok3D
	D/eI4p59v38c6efDuSIJIRY8IKGbJB0YRZdH+EMy25iTseXVRLBhyC9wYKquKynO6ZpvQy
	/CatnEXVrfrObq8bfS7zOTHQgZyekyK0j0aSnC9zfauuoZM586L4eZZRU7nmkcUmldLhKT
	stHSWqARk03rZJcCQu1kYgNmQSXkikdNnuPOgYUaO/GA+80I1u24U+U0DIShI6/K0FBQ/U
	fXIFfREGMFDnYFLYfZTLV7ASMHW1b3L09vnwDrsUCpnhNTk7jy8BOfPLmrobfQ==
Message-ID: <af8c2609-59ca-4573-af4b-b08563a5a0bb@bootlin.com>
Date: Wed, 21 Jan 2026 11:07:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: dwmac: enforce preamble
 before SFD for i.MX8MP
To: Stefan Eichenberger <eichest@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 linux-stm32@st-md-mailman.stormreply.com, francesco.dolcini@toradex.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260120203905.23805-1-eichest@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260120203905.23805-1-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Stefan,

On 20/01/2026 21:30, Stefan Eichenberger wrote:
> This series adds a new phy_device flag PHY_F_KEEP_PREAMBLE_BEFORE_SFD
> that allows a MAC driver to request to keep the preamble bytes before
> the start frame delimiter (SFD) when receiving frames from the PHY.
> 
> This flag is set in the stmmac driver for the i.MX8MP SoC due to errata
> (ERR050694), which causes it to drop frames without a preamble.
> 
> The Micrel KSZ9131 PHY supports keeping the preamble before SFD by
> setting an undocumented flag, that was confirmed by NXP and Micrel. This
> new feature has been added to the Micrel PHY driver for the KSZ9131 PHY.
> 
> Changes since v2:
> - Instead of using phy_register_fixup add a new phy_device::dev_flags
>   flag PHY_F_KEEP_PREAMBLE_BEFORE_SFD so that a MAC can request to keep
>   the preamble before SFD if needed (Russell)
> - Link to v2: https://lore.kernel.org/all/20260105100245.19317-1-eichest@gmail.com/
> 
> Changes since v1:
> - Use phy_register_fixup_for_uid() instead of adding a new device tree
>   property
> - I will send the conversion of the micrel.txt binding as a separate
>   patch series
> - Link to v1: https://lore.kernel.org/all/20251212084657.29239-1-eichest@gmail.com/
> 
> Stefan Eichenberger (3):
>   net: phy: add a new phy_device flag to keep preamble before sfd
>   net: phy: micrel: add option to keep the preamble before sfd for
>     KSZ9131
>   net: stmmac: dwmac-imx: keep preamble before sfd on i.MX8MP
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   |  6 +++++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  8 +++++++-
>  drivers/net/phy/micrel.c                          | 14 +++++++++++++-
>  include/linux/phy.h                               |  5 +++--
>  include/linux/stmmac.h                            |  1 +
>  5 files changed, 29 insertions(+), 5 deletions(-)
> 

Thank you for that. The code looks fine to me. I've tested in on a custom baord
I have that happens to have an iMX8MP and a KSZ9131, it fixes the issue for
10M links ! Thank you :)

For the series,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
