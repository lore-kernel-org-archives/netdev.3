Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5D37D104;
	Wed, 18 Mar 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822248; cv=none; b=Ct1keQhRKmW18KJDpsOxm5tDEeZ1xqbbS2JGIeZL9YSF7gLLU+8Oc5Yfgwt4SVls6deEmECRLVET7ZOFiw6Kx9uwSvMXWM5pQ2vbhSVpJ+O0KuI+pX1CyoiBLM1u7bwovJ4ZWhSTPPyogr5sUzoysqo4ll83L6+l+fWkFStKaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822248; c=relaxed/simple;
	bh=zbrEzDQ0AblNhXke6/7cPNOTm3Avyhavj22x1LcfmRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZQ0DDLVQw3VI8JzTcKRv8jT2lP0+gATWAoP0ntjPDb8/9Y6LoziBj0sp9pUu8Q3Mp+zF7VeLmsVD0q1dILX+I3xedxA3PxNx+VFYfMkzeHyyIy0MQozHp8ziMQb8IQo+geXhWdzMkoGUIkDtdHNeKsaK3b923jFPsYDwKjQT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdWYyowz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdWYyowz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53225C19421;
	Wed, 18 Mar 2026 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773822247;
	bh=zbrEzDQ0AblNhXke6/7cPNOTm3Avyhavj22x1LcfmRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdWYyowzn9WA2aJGuHLNRqX/QEe2NLHcUNCkhDUY64ztt4svOZmzxFrWlzmUHI6xU
	 /uZ6hPer+e0gNtoBPTWwrX/4/7Y7NvBA8sBZlt870hhJjKBW7mlNFErn5jRqmcWzUI
	 ZvuE9nLCPHP31SJgQXUPwHPO6asgJzE8clgaERBQLzu6N9cYSGvueZs5NEtbkDxERW
	 0uJbhCBwzFOmdXng/YhTB1b3/JQeJfKObJH/IhHBdmBsZiqjuYj2FAYfYX/gYxNizC
	 3PxPrHxwNqCsWYeU/7l/EP6+bQvr/f/z2ZIb4fdI4QjIBTDeTbHHgHvFBmLlYCncbE
	 OJTQxjRlH3XgQ==
From: Simon Horman <horms@kernel.org>
To: a0987203069@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	richardcochran@gmail.com,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	linux-stm32@st-md-mailman.stormreply.com,
	joabreu@synopsys.com,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	conor+dt@kernel.org,
	schung@nuvoton.com,
	linux-arm-kernel@lists.infradead.org,
	davem@davemloft.net,
	robh@kernel.org,
	yclu4@nuvoton.com,
	andrew@lunn.ch,
	mcoquelin.stm32@gmail.com,
	ychuang3@nuvoton.com,
	openbmc@lists.ozlabs.org,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com
Subject: Re: [net-next,v14,3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family
Date: Wed, 18 Mar 2026 08:23:46 +0000
Message-ID: <20260318082346.1825390-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316055427.1310569-4-a0987203069@gmail.com>
References: <20260316055427.1310569-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family

Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac
driver.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
> @@ -0,0 +1,136 @@

[ ... ]

> +static int nvt_gmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct device *dev = &pdev->dev;
> +	struct nvt_priv_data *priv;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get platform resources\n");
> +
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return dev_err_probe(dev, PTR_ERR(plat_dat), "Failed to get platform data\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate private data\n");
> +
> +	priv->regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys",
> +							    1, &priv->macid);
> +	if (IS_ERR(priv->regmap))
> +		ret = dev_err_probe(dev, PTR_ERR(priv->regmap), "Failed to get sys register\n");
> +
> +	if (priv->macid > 1)
> +		ret = dev_err_probe(dev, -EINVAL, "Invalid sys arguments\n");
>                                                                                   ^^^^

Does this code return the error on failure? The dev_err_probe() result is
assigned to ret but the function continues execution without returning.

Russell King's v12 review suggested using set_phy_intf_sel callback,
which led to significant refactoring in v12. This refactoring appears to
have inadvertently broken the error handling here and below.

The code should be:
	if (IS_ERR(priv->regmap))
		return dev_err_probe(dev, PTR_ERR(priv->regmap), "Failed to get sys register\n");

	if (priv->macid > 1)
		return dev_err_probe(dev, -EINVAL, "Invalid sys arguments\n");

See Russell's v12 review:
https://lore.kernel.org/netdev/aYsurPBMnzWDZCco@shell.armlinux.org.uk/

> +
> +	plat_dat->bsp_priv = priv;
> +	plat_dat->set_phy_intf_sel = nvt_set_phy_intf_sel;
> +
> +	return stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> +}

[ ... ]
