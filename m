Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370534086A;
	Wed, 21 Jan 2026 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997159; cv=none; b=rFfdfEXokPSR4r8k/wYtQuhXqvRVkpyJaVm3mwZ4iRqzs/ow68DcQFF/eq/fbvydUKloLuEUZRZGo7LIK+k9iNqTAMaKNTdGzaX7ElhTBbxupaUufCrNTp1RvfjZXQKF55cU51Rh7kpIpVxGHc1iP7q7JyhRGi9/OjcQhHcy9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997159; c=relaxed/simple;
	bh=PPEEIbajXrrS9gFGgRZggB4Ah/4PxStya/vb5zaJ9cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sO8X1TiugSYVJQHUlDmYw8i+VuAJ5E2FmZIGk07/IBHCwmh65jNUMWNiat8TW3UYoijuIRxxG+6mB5/4YEfprM7cWVfZf7yrye5P1lr14FHwaHBYOE++3+woUYnu8mk1p7I615NOUOw2j/K2UxHE7hN5V9/ucvNdw+HQHKaexTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wsvJyjsN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wsvJyjsN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=blJQMqqu4tFSTWEqphnNTUonZrAUAH4mGc9+Tb33mXU=; b=wsvJyjsNN/dYonRihTeNndKH9F
	E/iD+wYJydFtrHcrFyiRcrd82HQJfY+uODv6NnB2BTgelcP1smsdmQPShauQm7SXsKaCpX/FfoV3S
	7sqmuUhd6HRcy87hF/jnI6pg1PS3AGMRcBqqKxpHBNhMNbTLCOTDbFQJHoX3RgML7qcucH1qZQ5ei
	CDtnaon+ZuhgbQLeUC7D4DpRYPdEuiZdpbRBQ/3sFcVTkFVZ9/M3QFXxRRdVtcuo6qgKMIe2oGn8j
	2PDijyfLXOMMxxAc7Oznp3pQT/h4V7d51svvzCsk3l+MaQ4eElB1307EBV5wIS9Iexn+ER22dIbYX
	TY/2SJ5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35426)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1viWxq-000000007Of-16nY;
	Wed, 21 Jan 2026 12:05:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1viWxm-000000008Qh-3nJy;
	Wed, 21 Jan 2026 12:05:30 +0000
Date: Wed, 21 Jan 2026 12:05:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yao Zi <ziyao@disroot.org>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aXDBCsfaNrgfGjNK@shell.armlinux.org.uk>
References: <20260121071315.940130-1-inochiama@gmail.com>
 <20260121071315.940130-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121071315.940130-4-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 21, 2026 at 03:13:11PM +0800, Inochi Amaoto wrote:
> +	mask = RGMII_RX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
> +	       RGMII_TX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
> +	val = FIELD_PREP(RGMII_TX_DLINE_STEP, tx_config) |
> +	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
> +	      FIELD_PREP(RGMII_RX_DLINE_STEP, rx_config) |
> +	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;

So your reply where you basically stated that all the RGMII.*DLINE.*
constants here should be the same was nonsense. How can we trust your
replies?

> +static int spacemit_dwmac_fix_delay(struct plat_stmmacenet_data *plat_dat,
> +				    struct regmap *apmu,
> +				    unsigned int dline_offset,
> +				    unsigned int tx_delay, unsigned int rx_delay)
> +{
> +	bool mac_rxid = rx_delay != 0;
> +	bool mac_txid = tx_delay != 0;
> +	unsigned int rx_config = 0;
> +	unsigned int tx_config = 0;
> +	int rx_code;
> +	int tx_code;
> +
> +	plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
> +								  mac_txid,
> +								  mac_rxid);

Maybe Andrew can confirm, but this function was to fix up existing
broken DT, and shouldn't be used by brand new drivers.

> +	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
> +	if (IS_ERR(plat_dat->clk_tx_i))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
> +				     "failed to get tx clock\n");

As stated on the previous series, please don't abuse clk_tx_i for
soemthing that isn't the dwmac's clk_tx_i signal.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
