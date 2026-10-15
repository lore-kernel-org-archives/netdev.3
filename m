Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867693BFAFB;
	Thu, 15 Oct 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077440; cv=none; b=p3NDAt5A2aq3/RGyCGrOp9fJQN7thJmO0mFe5JkQuvXNXVV9s1eFSunf9P9WMCt9Rh/QQsee6w9ebCqbxBTjVGzVEVQ99T9PB9c8kfkg3USz/WT8QLj59QatDmlXQyHA1ywPCXY2uD8pt+Xto0FmmS/MsU5zulsN4FevBnuBhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077440; c=relaxed/simple;
	bh=jKGtx42BtJjOa00dZ9cXK1ppP64ul0T2eNAgb8RpqSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGm6rrn+/H7mQaf4b/ScgleTWC2OTE48b2GgFb+tXUHtoM0XivMQB7GleXqwicWYVkU1q65TGuhAoCuh8uQ7FZ/EvULuTNnNJFEEA6UKNEE8a4HKK5QJfG7zPGKd1d+U0+mbsQvRwQcV5CqIdxz48qIxoUm6vN8z7Qml6Unizk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZmuTnLo8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZmuTnLo8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CBF8A4E41253;
	Thu, 15 Oct 2026 15:17:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95F9C60360;
	Thu, 15 Oct 2026 15:17:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2BFC10328C20;
	Thu, 15 Oct 2026 17:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792077434; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HaRGKm4Kjn2FqC8T5q14zb3CHanv2Cr+TY5652PSjyY=;
	b=ZmuTnLo8xzcqwuJmGTRSA4uy3JicI39VFFVJZMX0lWTjGT+htpucNGB6f9jl0VKOmp1PX4
	LOWnvuKeU8ps8tp4AIPBXN0P6lYj2yH70ToqKy6+tO0dcMwtgI00DdM4CUcfmIiEhDgF/r
	tEJ+FrTl0rd4jeVkzHJrsaaU+ltNbWjw8B85r3g32sQeqlcK0u+wISGpDZ+PehVlqagczL
	B0++UvZ0qb/8X4S2HbBIcM31lAIl1TqHqwjhxXnPUhkL9Dd+Z7H69BSfj4texO81sXRwdE
	fgleqg2EQDzuZCEcF6j9XduXbYE5yEPMoBTlMZL6Otlww38h72JLOlj306jIvA==
Message-ID: <e5be1492-d646-4233-8845-c0f1b4f2cbd5@bootlin.com>
Date: Thu, 15 Oct 2026 17:16:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: Add regulator
 management
To: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk
Cc: Daniel Thompson <daniel@riscstar.com>, ansuelsmth@gmail.com,
 donggeunyoo.kernel@gmail.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261015143849.483339-1-elder@riscstar.com>
 <20261015143849.483339-3-elder@riscstar.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261015143849.483339-3-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/15/26 16:38, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> QCA8081 appears in embedded board designs paired with GPIO controlled
> regulators for its power rails. Add logic to allow these regulators to
> be turned on during a probe.
> 
> In order to avoid the complexity of tracking state for suspend with and
> without WoL we take a tremendously simple "always-on" approach to
> regulator management, essentially relying on BMCR_PDOWN to conserve
> power when the phy device exists.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/net/phy/qcom/qca808x.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
> index bab26e4c61408..4aba513b9a512 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
>  #include <linux/phy.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/module.h>
>  
>  #include "qcom.h"
> @@ -181,15 +182,43 @@ static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
>  		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
>  }
>  
> +static int qca808x_power_on(struct phy_device *phydev)
> +{
> +	static const char * const regulator_names[] = {
> +		"avdd18", "vdd", "vdd18", "vdd125"
> +	};
> +	struct device *dev = &phydev->mdio.dev;
> +	u32 count = 0;
> +	int ret;
> +
> +	for (u32 i = 0; i < ARRAY_SIZE(regulator_names); i++) {
> +		ret = devm_regulator_get_enable_optional(dev, regulator_names[i]);
> +		if (!ret)
> +			count++;
> +		else if (ret != -ENODEV)
> +			return ret;
> +	}
> +
> +	if (count)
> +		fsleep(phydev->mdio.reset_assert_delay);

Kinda makes sense to use that delay as a basis, it may be too short in
some odd cases but I guess it's good enough of an approximation here,

> +
> +	return 0;
> +}
> +
>  static int qca808x_probe(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
>  	struct qca808x_priv *priv;
> +	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	ret = qca808x_power_on(phydev);
> +	if (ret)
> +		return ret;
> +
>  	priv->led_polarity_mode = QCA808X_PHY_LED_UNSET;
>  
>  	phydev->priv = priv;

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

