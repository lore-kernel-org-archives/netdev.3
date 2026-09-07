Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415A479872;
	Mon,  7 Sep 2026 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781502; cv=none; b=ZH67cdt4DukhdA4LiE2varH+vQT4WKoa0jMfIWuAi8spPrtjnjEEJFK86DyY5+I8QUIFfmOxTlDyWzVKqM9crsBi+bpyIoyGq87I7WczBxvdXUTWteiamuMlz8nRROdBEh46zVb9dqCdR578oqy3No5zjBf//VBL6Bi66/0aC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781502; c=relaxed/simple;
	bh=gHf/JWbywMGHSP7KYgxxxlxij+cmqOc3AHmFechyKSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XARmlsXJiGH2wMF5sq7FurFw1Iakfh9JuKAJVxMcv9v7crZJ3lExNmVj09zBRMt5uYQ/FDe10XqqLsHOTDkOjUMBnvUHf54A/c0sh/Su3DE4FCKT4qgkaRF5YfDX6FhjgLCX71ZjpOZ7jCeYrJ3lYjWfgmgWPQhvhlgFcOVMg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jwwvMAHM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jwwvMAHM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7B20E4E41565;
	Mon,  7 Sep 2026 11:44:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45E7960383;
	Mon,  7 Sep 2026 11:44:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33BE511C7A21B;
	Mon,  7 Sep 2026 13:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788781495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YCLIOUymlLprrYxagyBjJIlkYmWYFOeOtwfW4d/Bvuc=;
	b=jwwvMAHMbW0KwTwMLkiwiHquYsfmGZlErwev0Y67QZ8/BUfWsSENihLREiXf5OyVCTP295
	W9Ed0zUoeciAAtkIH9APZwEcXnQYve3PpY/4M6wQ6cuCjSmGJ0npSXGM2hRltwzLArf+nK
	7feLSgSPgDasIP99OszE4rI43+fwgTPQWpn/O+ZOORFGdm49mv4FpKzJQwgTNnB5yDpRdA
	Y3QB1v+KRM2W63BAU7XO2UiQIhI08sppZqbPg049VU5IHdO1wtV0UIw6uqqZjxccpx0NzW
	CA6W+ZFQgHm0/B8RadyQEzdWZ53ADr53zRTFryyPGljPJG8hDSd3BAyeF4iYXQ==
Message-ID: <1a8b585f-495b-435b-bd36-72c68bbc3600@bootlin.com>
Date: Mon, 7 Sep 2026 13:44:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/5] net: stmmac: Add common internal RGMII
 delay handling
To: Jia Wang <wangjia@ultrarisc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Chen Wang <chen.wang@linux.dev>,
 Inochi Amaoto <inochiama@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, sophgo@lists.linux.dev
References: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
 <20260907-dwmac-ultrarisc-v2-1-9a39bf8db313@ultrarisc.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260907-dwmac-ultrarisc-v2-1-9a39bf8db313@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 09:46, Jia Wang wrote:
> Some DWMAC integrations add fixed RGMII clock delays internally.
> Glue drivers need to account for these delays before passing the
> interface mode to the PHY.
> 
> Add TX and RX delay capability flags to the common platform data.
> Apply phy_fix_phy_mode_for_mac_delays() in stmmac_pltfr_probe() when
> either capability is present.
> 
> This lets glue drivers describe the MAC capabilities without
> duplicating the interface-mode validation and conversion.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++++
>  include/linux/stmmac.h                                |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 6128ed1bd521..93b9af203a18 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/of_net.h>
>  #include <linux/of_mdio.h>
> +#include <linux/phy.h>
>  
>  #include "stmmac.h"
>  #include "stmmac_platform.h"
> @@ -847,6 +848,16 @@ int stmmac_pltfr_probe(struct platform_device *pdev,
>  		       struct plat_stmmacenet_data *plat,
>  		       struct stmmac_resources *res)
>  {
> +	if (plat->has_internal_tx_delay || plat->has_internal_rx_delay) {
> +		plat->phy_interface =
> +			phy_fix_phy_mode_for_mac_delays(plat->phy_interface,
> +							plat->has_internal_tx_delay,
> +							plat->has_internal_rx_delay);
> +		if (plat->phy_interface == PHY_INTERFACE_MODE_NA)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +					     "unsupported phy interface mode\n");
> +	}
> +

Seems good, the default values should be false hence this condition won't be taken,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

