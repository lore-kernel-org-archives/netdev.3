Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669A3168F6;
	Tue,  3 Feb 2026 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140912; cv=none; b=lReFKvXAaZ78A1+KnLOX6kcTjRD2+rz1qs6g7G9qUe9HBnpR0clJGZhFGDwT0UFv35QNOBYK9vatMSuwLqZMjC/5Gvu9+MPlqjqdkT7GCmQucFtpt75Fgi3mBhXolbRF5v6qJ6/rzvhvF5AHsWRxbacsv2xNn+twe8Aydu/cj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140912; c=relaxed/simple;
	bh=nT5gqQY1z1axiKnDg1xENUtc5nF991Bpu0PcgekNvUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm7AATTK/g9cekvR/IXWgsnCn4zZUssjHVStO7ieQWuHGkfxU9W3GvaDlS2mIHMF7LukOjCFcFqD189PgZveiPOQpSopOzSkT5GOpus8p3G3XD8Q/3iUU/16YJ6HmCQ0q/vsx9rnvyzy3pZV+Ql05o8QvCTQ6ErPLPFCnKZqbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mnmCHRwg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mnmCHRwg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8+rZdHUALqDXCYWomEbTBBbdF709hbUaxOu7TxGSuck=; b=mnmCHRwgVvO2uVu8vPwzL3jlaQ
	9e3s28tK2RkxDDz+wudnKFLlMgf8rsID3pS07Xd03nfUi/IOgHTvc4AYPkDSWkg8uZopukn03su/q
	P7/A9g0eLJSwzR58O0WDaJVRC1VQO83NBE+KNK+wygGw/N/ZhhRad/Ht4honZ9Qc9Qo242neo8wKi
	PIQ0qpcgMEmUQKrModpz+SkByA7jDdHARbBl5sgvopqaFP2qFctC8BEN+2kBzFlRlhaAMy2i3aCeK
	DUf9JTguGfJOZXEOyc14Hbq6dAcCcmBDoL+92a34ygVVMMDNOsAfUug0efvdF/PZgHiZpVrcoCea1
	hbGxnchg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46968)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vnKVS-000000005Pd-2TsJ;
	Tue, 03 Feb 2026 17:48:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vnKVM-000000004ZO-2y1I;
	Tue, 03 Feb 2026 17:48:00 +0000
Date: Tue, 3 Feb 2026 17:48:00 +0000
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
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>, Zhi Li <lizhi2@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aYI00Exytbgbnuzp@shell.armlinux.org.uk>
References: <20260130022705.1059214-1-inochiama@gmail.com>
 <20260130022705.1059214-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130022705.1059214-4-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 30, 2026 at 10:27:04AM +0800, Inochi Amaoto wrote:
> +/* ctrl register bits */
> +#define CTRL_PHY_INTF_RGMII		BIT(3)
> +#define CTRL_PHY_INTF_MII		BIT(4)
> +#define CTRL_WAKE_IRQ_EN		BIT(9)
> +#define CTRL_PHY_IRQ_EN			BIT(12)

Thanks for updating these.

> +static int spacemit_dwmac_update_ifconfig(struct plat_stmmacenet_data *plat_dat,
> +					  struct stmmac_resources *stmmac_res,
> +					  struct regmap *apmu,
> +					  unsigned int ctrl_offset)
> +{
> +	unsigned int mask = CTRL_PHY_INTF_MII | CTRL_PHY_INTF_RGMII | CTRL_WAKE_IRQ_EN;
> +	unsigned int val = 0;
> +
> +	switch (plat_dat->phy_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		val = CTRL_PHY_INTF_MII;
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RMII:
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val = CTRL_PHY_INTF_RGMII;
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (stmmac_res->wol_irq >= 0)
> +		val |= CTRL_WAKE_IRQ_EN;
> +
> +	return regmap_update_bits(apmu, ctrl_offset, mask, val);

I would suggest that this is split into two parts - first, this is
renamed and reduced to just controlling CTRL_WAKE_IRQ_EN.

Next, a function hooked into plat_dat->set_phy_intf_sel which sets
the CTRL_PHY_INTF_RGMII and CTRL_PHY_INTF_MII bits as appropriate.
Note that this function is passed the dwmac's own phy_intf_sel
value from common.h which will be PHY_INTF_SEL_GMII_MII,
PHY_INTF_SEL_RGMII or PHY_INTF_SEL_RMII for you.

It would also be good to have plat_dat->get_interfaces populated
using phy_interface_set_rgmii(), and __set_bit(PHY_INTERFACE_MODE_MII)
and __set_bit(PHY_INTERFACE_MODE_RMII) to indicate to phylink which
interface modes are permissable.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
