Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7A4E534F;
	Mon, 28 Sep 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608531; cv=none; b=QMPtB33iynwfoyQ9B0fSlLXb+nfux2EZgmECnUDGR/+uK5Br7V1gPRCoeWAkNGHmqi1k92SOZfQeip2UU9+UoljDU02NPi+dxKczLKPh4UGmGC5mFhq6pQHudGbIA8HJ1IO2PtE1idBsnZVeftPity6znN7kS6PrByKs46KXB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608531; c=relaxed/simple;
	bh=fLObqkQLYe3RH5LSMk+upCg7lYWutCTJ3jIQIZ5yfbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=da/w4aqLOK+tYFItdrBPwmsI2c9xTxJpeeusjA9c15oVoU4N3UD3pisug4esvuEMdA9+wjJThAU7wBnOPU/x4otuXgwQrbosZgc0qRpjV59/QebdAeGj+pRSiKMw2pf3qHQlGxSUEbXEBU/tlz2D47BLhrp+hXgwCH9dK5ztqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DYRMiRUI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DYRMiRUI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6742B1A103C;
	Mon, 28 Sep 2026 15:15:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36700601BD;
	Mon, 28 Sep 2026 15:15:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF143103294F8;
	Mon, 28 Sep 2026 17:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790608520; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xnYPacrxh2Vf2kARWZmsahsEJWN2KdcsCERjzEKumDY=;
	b=DYRMiRUI2yCubHBc/jLEDWCSg7bWV8uv5DRdc10KUOPsttxWpksmOSIJqHfdzEdQzR13TI
	zfIz+gu681ikcAFurqJCci5EUE8jUDOXJbDqEIqOZAapTB/2bdcATQoN6/rXrK0/mnRBJn
	+S+tzA2mL4I1cWChRfoNErkYzb6/qm1i31wJfoHMMDbR0t9h1BNBwft09ZSmvAAKdKEoz0
	KFu2/SNKZ/nvvWEk9ACdej7qJRzK886tT+kISLvLdMRyZmNzsk+X4nUodqsv9WI+670EC2
	PDq9OUTVWGsJzEnktcewWcQwLR7keBfJwS26Rkif7363ftwtf93lIiczYe5cmg==
Message-ID: <dafc17ac-316e-4cfa-83e0-314d187fb3e4@bootlin.com>
Date: Mon, 28 Sep 2026 17:15:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 8/9] net: stmmac: qcom-ethqos: support
 external PCS
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
 Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923-qcom_xpcs_nord_emac-v1-8-4b1c682af70f@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-8-4b1c682af70f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ayaan,

On 9/23/26 03:07, Mohd Ayaan Anwar wrote:
> Select the XPCS instance initialized by stmmac when firmware provides
> a pcs-handle. Reject interfaces that are not supported by the selected
> PCS.
> 
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c  | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index ac7d6d3e205a1ab5b391def879d6f1033a0961b6..a99a78880c0fb7858e90b6212b37ebfc7fccaf84 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -7,6 +7,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pcs/pcs-xpcs.h>
> +#include <linux/property.h>
>  
>  #include "stmmac.h"
>  #include "stmmac_platform.h"
> @@ -681,6 +683,21 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
>  	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
>  }
>  
> +static struct phylink_pcs *
> +qcom_ethqos_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
> +{
> +	struct phylink_pcs *pcs;
> +
> +	if (!priv->hw->xpcs)
> +		return ERR_PTR(-ENODEV);

If there's no device (i.e. no PCS), then you should return NULL.

> +
> +	pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
> +	if (!test_bit(interface, pcs->supported_interfaces))
> +		return ERR_PTR(-EOPNOTSUPP);

phylink already checks if the interface is in pcs->supported_interfaces,
no need to do it here :)

Thanks,

Maxime
