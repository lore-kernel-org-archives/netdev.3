Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676504266B8;
	Tue,  1 Sep 2026 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270557; cv=none; b=j2PR1ennL6OeuNtK0YcFYLx4q9+fbOPGZdPS5KcrymdnHcSuo2Jb76LdcUUU+gJJUSINqZXrJc4FN6acnL6mo3rGSR3WnWq9igciznku5L5PzKjav4kFo7MTGKLt3ToKV9i11Ikj4QLivFIXCaHXfHWkJmVYuT7QomuyepTOcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270557; c=relaxed/simple;
	bh=PVhpvelKtMWVVHcIFK38Lglxyc5enB4NZx9uwY/m/zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuvmdaojdAkuw+HSwaSatICcqSSkxB4gXmcQlx5iUQsorlfZm36WM7iMJp/+cQ85xLzINVSpRlVtRMsIvGlyGysv6FVoR8Q26m/mkqJNrUxHkPTIoJ3klnzHyR80T7XySIiVnh5ZI9GnH+7k+u/IptQFwyYQE+/vqP533ozt0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BmPHjLdm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BmPHjLdm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=57RWwzvbEDf7DvtJW9GsWV6QWqUGcL9KWR4klLOP/3A=; b=BmPHjLdmp5W9SZiMNWvuxvdjCj
	Wa9un9M1cecMTXAQROipZ+eaiy+P0Ic3OnFb76MwkN2bBLa66Z6TuTC3TsfDt94pdBw0UaGoMBezy
	B3I32EJxW+9swJ09kjtNwPPvdOjptdI793sgwStqwh+HAIQ1q8OVQRXfODOcjrhAH7f8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1OrA-002Mbr-FD; Tue, 01 Sep 2026 15:48:56 +0200
Date: Tue, 1 Sep 2026 15:48:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add UltraRISC DP1000 GMAC
 support
Message-ID: <910be156-b631-4b62-972a-79d9a9e38697@lunn.ch>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-3-f19454814bcf@ultrarisc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-dwmac-ultrarisc-v1-3-f19454814bcf@ultrarisc.com>

> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UltraRISC DWMAC platform driver
> + *
> + * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +
> +#include "stmmac_platform.h"
> +
> +static int ultrarisc_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get resources\n");
> +
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return dev_err_probe(dev, PTR_ERR(plat_dat), "failed to parse DT parameters\n");
> +
> +	plat_dat->phy_interface =
> +		phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface, true, true);
> +	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
> +		return dev_err_probe(dev, -EINVAL, "unsupported phy interface mode\n");
> +
> +	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> +}
> +
> +static const struct of_device_id ultrarisc_dwmac_match[] = {
> +	{ .compatible = "ultrarisc,dp1000-gmac" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ultrarisc_dwmac_match);
> +
> +static struct platform_driver ultrarisc_dwmac_driver = {
> +	.probe = ultrarisc_dwmac_probe,
> +	.driver = {
> +		.name = "ultrarisc-dwmac",
> +		.pm = &stmmac_pltfr_pm_ops,
> +		.of_match_table = ultrarisc_dwmac_match,
> +	},
> +};
> +module_platform_driver(ultrarisc_dwmac_driver);
> +
> +MODULE_DESCRIPTION("UltraRISC DWMAC platform driver");
> +MODULE_LICENSE("GPL");

This looks to be 90% identical to dwmac-sophgo.c.

Do you expect any further changes to this driver? Is everything
supported? Are there more clocks? A GPIO for WoL?

I'm just wondering if the common code should be pulled out, or even
dwmac-sophgo.c made generic so it can handle all plain boring devices
which have RGMII delays and not a lot else.

      Andrew
