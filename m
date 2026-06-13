Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D552DA74A;
	Sat, 13 Jun 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781376563; cv=none; b=QNzQ159pw93+EBIEYsiZdOPL3hiIJlA+UkUFi36ZxCCbeBY6AzA2OLI5KP7dT5dKjYIe4E4C0YDx91MZdwG/Q4wmqwhl0q/PpHGefnhsKcwCbmn6aFXLE8ghZ4CEQZFcv6167q+gsuEHzQZFX75CBvd3SofUFKylayWd9eJi/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781376563; c=relaxed/simple;
	bh=WcxGAQyg4LKogBzDFjtFhUITqdkwauGV7XDxQWjr/w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1XFcZGkTBddvklCru2UHVXm8DCEi9rEUiCd8N3zheztoxq/02xHsyksfQBh7DTIYSkBjyMvAvFehiNMZEgS7o0iI6gXQ7pF/MHbDqE49QUnSONiZJpvcFml5ejuls9RqGjHwMEB2hiX85cs4kwaf6TWjtSGKU4EwwgCox+YoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYTPw-000000002WZ-1lbr;
	Sat, 13 Jun 2026 18:49:16 +0000
Date: Sat, 13 Jun 2026 19:49:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH net-next v5 2/4] net: phy: mediatek: add phy driver for
 MT7628 built-in Fast Ethernet PHYs
Message-ID: <ai2mKe-fC2D_6pc8@makrotopia.org>
References: <20260613181845.111877-1-joey@tinyisr.com>
 <20260613181845.111877-3-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613181845.111877-3-joey@tinyisr.com>

On Sat, Jun 13, 2026 at 09:18:43PM +0300, Joris Vaisvila wrote:
> The Fast Ethernet PHYs present in the MT7628 SoCs require an
> undocumented bit to be set before they can establish 100mbps links.
> 
> This commit adds the Kconfig option MEDIATEK_FE_SOC_PHY and the
> corresponding driver mtk-fe-soc.c.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> [...]
> diff --git a/drivers/net/phy/mediatek/mtk-fe-soc.c b/drivers/net/phy/mediatek/mtk-fe-soc.c
> new file mode 100644
> index 000000000000..9eb4960bcaad
> --- /dev/null
> +++ b/drivers/net/phy/mediatek/mtk-fe-soc.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for MT7628 Embedded Switch internal Fast Ethernet PHYs
> + */
> +#include <linux/module.h>
> +#include <linux/phy.h>
> +
> +#define MTK_FPHY_ID_MT7628	0x03a29410
> +#define MTK_EXT_PAGE_ACCESS	0x1f
> +
> +static int mt7628_phy_read_page(struct phy_device *phydev)
> +{
> +	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
> +}
> +
> +static int mt7628_phy_write_page(struct phy_device *phydev, int page)
> +{
> +	return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
> +}
> +
> +static int mt7628_phy_config_init(struct phy_device *phydev)
> +{
> +	/*
> +	 * This undocumented bit is required for the PHYs to be able to
> +	 * establish 100mbps links.
> +	 */
> +	return phy_modify_paged(phydev, 0x8000, 30, BIT(13), BIT(13));

As there is only that single use I don't think it justifies introducing
a phy_set_bits_paged helper just for that, but that's my opinion...
