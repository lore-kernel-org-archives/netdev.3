Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254F497B99;
	Wed, 23 Sep 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165918; cv=none; b=ebj70iU5dra9D0zrXtIrXhE4N5UTrI0TxpR255t+sbKClncAGsu0TEYONSh0Na9FMdQ5LwzxO2hZHCqs5GRPNEIkCW11h55JjoVhI1Mxr7DQZY/u8VRn137/bHT88t1z3va7JkKfrJxQECPV3mCmIbE+kDi+A6rJ2/pPxc3dXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165918; c=relaxed/simple;
	bh=5fGxk9HhwjCb6xTY1ZXljQ8LJNbL1+NlyXYyVEhbq/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6T5jVs9XmbV+cpwPGCtos2S6fKiX0OlafCDjmga+LOJASzU30KZSFxo5WdcQ8Xt54VavxVVn/qYHIyRsCi1RBSHwyTRPpHS84gQ1wfqE8I+j+vTvFGaLgNFnYqwdJcWYluwkmXKpkjz3jKM6abJARrKQ9OOL2E7KqXW3UN95xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MvwxdJ8T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MvwxdJ8T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rZ+t0r04A9n4IJdQ/W6j5U+mLAScXuxePRrybklmGrA=; b=MvwxdJ8TIg3NSfmiO5iN5pdkZG
	JUO4RZhctuuY1g0lTouZ0uOHLv5w4RqCHLbA0DXxhwDKOGAocM5rWmVIifmRXQC+WIXDbh9MzSf6e
	JF5C/3399TTWE7+MtoK8/EZDaYwMlJY8BXK2d9zhvyB4vO75g25SqsCYQFIt8vH/Dxr4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9LvV-006nYe-3Q; Wed, 23 Sep 2026 14:18:17 +0200
Date: Wed, 23 Sep 2026 14:18:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Shawn Guo <shengchao.guo@oss.qualcomm.com>,
	Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Subject: Re: [PATCH RFC net-next 3/9] net: pcs: xpcs: add custom platform
 register accessors
Message-ID: <be09d6dc-c1c0-4a0c-9836-2b686ad096f4@lunn.ch>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923-qcom_xpcs_nord_emac-v1-3-4b1c682af70f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-3-4b1c682af70f@oss.qualcomm.com>

On Wed, Sep 23, 2026 at 06:37:29AM +0530, Mohd Ayaan Anwar wrote:
> Some XPCS integrations do not expose the standard direct or indirect
> register layout. Allow the platform driver to use optional register read
> and write callbacks for both Clause 22 and Clause 45 accesses, while
> retaining the existing access paths when no callbacks are supplied.
> 
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---
>  drivers/net/pcs/pcs-xpcs-plat.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
> index e669a7b248ac4677aeb5cd1874108f5c87f837d2..e78a233fb198d940951064a71e8597c6c666bc9d 100644
> --- a/drivers/net/pcs/pcs-xpcs-plat.c
> +++ b/drivers/net/pcs/pcs-xpcs-plat.c
> @@ -24,8 +24,16 @@
>  /* Page select register for the indirect MMIO CSRs access */
>  #define DW_VR_CSR_VIEWPORT		0xff
>  
> +struct dw_xpcs_plat_ops {
> +	int (*reg_read)(struct platform_device *pdev, void __iomem *reg_base,
> +			int dev, int reg);
> +	int (*reg_write)(struct platform_device *pdev, void __iomem *reg_base,
> +			 int dev, int reg, u16 val);
> +};
> +
>  struct dw_xpcs_plat {
>  	struct platform_device *pdev;
> +	const struct dw_xpcs_plat_ops *ops;
>  	struct mii_bus *bus;
>  	bool reg_indir;
>  	int reg_width;
> @@ -169,6 +177,10 @@ static int xpcs_mmio_read_c22(struct mii_bus *bus, int addr, int reg)
>  	if (addr != 0)
>  		return -ENODEV;
>  
> +	if (pxpcs->ops)
> +		return pxpcs->ops->reg_read(pxpcs->pdev, pxpcs->reg_base,
> +					    MDIO_MMD_VEND2, reg);
> +
>  	if (pxpcs->reg_indir)
>  		return xpcs_mmio_read_reg_indirect(pxpcs, MDIO_MMD_VEND2, reg);
>  	else

Ugly.

How about changing pxpcs->reg_indir to an enum, with values indirect, direct.

One patch.

Then look at

	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "direct") ?:
	      platform_get_resource_byname(pdev, IORESOURCE_MEM, "indirect");
	if (!res) {
		dev_err(dev, "No reg-space found\n");
		return -EINVAL;
	}

	if (!strcmp(res->name, "indirect"))
		pxpcs->reg_indir = true;

	if (pxpcs->reg_indir)
		spc_size = pxpcs->reg_width * SZ_256;
	else
		spc_size = pxpcs->reg_width * SZ_2M;

Look how easy it is to cleanly extend this with a new resource name?
And add accessors using the funky mapping your device has. Another
patch.

    Andrew

---
pw-bot: cr
