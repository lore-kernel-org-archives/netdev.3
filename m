Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1D3AFD02;
	Thu,  3 Sep 2026 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421672; cv=none; b=STXIMaj696DB0b52UB0A1hBqnT6gSeD9x+txJFZ0XKEJ5Ymn9N2cqAtmSOyWSEE2QPfaKU2VS095EhvA11uFRcvqPVn0/4ELLc8YohB+lXeEXHzLV8kYHnEMUAp7OF0QH5zTgAetOWbFH1gfIjFbvvR5JLM8TVEVNq25o6P58eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421672; c=relaxed/simple;
	bh=DybwMHnu9HH3kbXlnUcPstvbk79t201Lu98vpXdj4uE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kKTfkSYPHT44sbvHMywGbi7NDahCiZpudsV5wUBJrHKx4b+cIcqOH2/996jImKGKWh4CGKDU8oWlJd63HdfNMtO0RoztkRtSGZzWKZ1uFNxxh+P+OQfSHSjQvlA5eApMQVZrLJOTotk3yg+HKU1NWwY/WhGf2iJQTogu6qQUoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=XIksORlv; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="XIksORlv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=XWP5fc4YMZTsJ2HevoqYoNs057Br9v2hg
	14ZFf8XlCw=; b=XIksORlvpCW8Qp157igN4uvjHDCx7UroW+HtKw7U6vHU4GKE7
	CrMGn6wsWAv70Fkrqz0cqrEwTEP0iJ46FYZVE2DpMZlPZIJkuw1OwsvMt8FIipyz
	AS2haRt2DEHQVuX+gkFHyOUKOhQRDmsJkMVLPDk8VGxDZRB5UQ/S+IL/GY=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwD3vwYDJplq5jUAAA--.234S2;
	Thu, 03 Sep 2026 15:47:15 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add UltraRISC DP1000 GMAC
 support
From: Jia Wang <wangjia@ultrarisc.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jia Wang <wangjia@ultrarisc.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <910be156-b631-4b62-972a-79d9a9e38697@lunn.ch>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-3-f19454814bcf@ultrarisc.com>
 <910be156-b631-4b62-972a-79d9a9e38697@lunn.ch>
Date: Thu, 03 Sep 2026 15:47:04 +0800
Message-Id: <178842162417.2701756.3296149694160507506.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421624; l=2832;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=DybwMHnu9HH3kbXlnUcPstvbk79t201Lu98vpXdj4uE=;
 b=MTwdQIZFMkbeENF4A3judwSQZ9jZW/LS8/4WqBqpP51EXKsVSTV1O35Wdj31d9QzgGdwSGhEW
 WDM3zfrjERlD1bVKIuFiLEpxKaocgEZ4bgWhaExPvNWV7vILKknfe3/
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwD3vwYDJplq5jUAAA--.234S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr45ZrW8CF17Ary3GrW5Awb_yoW5Xw4rpF
	ZrCFW3tFyDGr13Ka97Xw4DZFWIvr1xKrW7tr18tw1ayasIvr93X3WkK3y5u3Z7AFWDuw12
	ya1jvFZrua90qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQASEWqXx6QADgALsZ

On 2026-09-01 15:48 +0200, Andrew Lunn wrote:
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * UltraRISC DWMAC platform driver
> > + *
> > + * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/phy.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "stmmac_platform.h"
> > +
> > +static int ultrarisc_dwmac_probe(struct platform_device *pdev)
> > +{
> > +	struct plat_stmmacenet_data *plat_dat;
> > +	struct stmmac_resources stmmac_res;
> > +	struct device *dev = &pdev->dev;
> > +	int ret;
> > +
> > +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to get resources\n");
> > +
> > +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > +	if (IS_ERR(plat_dat))
> > +		return dev_err_probe(dev, PTR_ERR(plat_dat), "failed to parse DT parameters\n");
> > +
> > +	plat_dat->phy_interface =
> > +		phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface, true, true);
> > +	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
> > +		return dev_err_probe(dev, -EINVAL, "unsupported phy interface mode\n");
> > +
> > +	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> > +}
> > +
> > +static const struct of_device_id ultrarisc_dwmac_match[] = {
> > +	{ .compatible = "ultrarisc,dp1000-gmac" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ultrarisc_dwmac_match);
> > +
> > +static struct platform_driver ultrarisc_dwmac_driver = {
> > +	.probe = ultrarisc_dwmac_probe,
> > +	.driver = {
> > +		.name = "ultrarisc-dwmac",
> > +		.pm = &stmmac_pltfr_pm_ops,
> > +		.of_match_table = ultrarisc_dwmac_match,
> > +	},
> > +};
> > +module_platform_driver(ultrarisc_dwmac_driver);
> > +
> > +MODULE_DESCRIPTION("UltraRISC DWMAC platform driver");
> > +MODULE_LICENSE("GPL");
> 
> This looks to be 90% identical to dwmac-sophgo.c.
> 
> Do you expect any further changes to this driver? Is everything
> supported? Are there more clocks? A GPIO for WoL?
> 
> I'm just wondering if the common code should be pulled out, or even
> dwmac-sophgo.c made generic so it can handle all plain boring devices
> which have RGMII delays and not a lot else.
> 

The probe boilerplate is indeed largely similar because both drivers
use the common stmmac platform helpers. However, their platform-specific
requirements differ: Sophgo requires additional TX clock handling and
other configuration, while DP1000 requires fixed TX and RX delay
handling. ACPI support under development is also intended to use the
UltraRISC glue driver.

>       Andrew
> 

Best regards,
Jia Wang


