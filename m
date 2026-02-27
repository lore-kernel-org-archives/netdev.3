Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D130CD81;
	Fri, 27 Feb 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195268; cv=none; b=QUwWfnwdrwqNSeQ1JAmlTben1nF1BiygcUWVuf7j5FEvYlwsrW6ZaKF1EfPslGeNxGEii/TU5xvyVYYh1z8/h3ibblFZPXIR93WrpqD2BnDv8jdz3Tox+td1gYPkcfhTaOhs7f8Xm5KGgbCkBxwzu7BmSWkokZValNPZXDwb1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195268; c=relaxed/simple;
	bh=YqoFbfdWbbPsgQm61WV7m4USPTx5rp7MoWSHPXxMY0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcfUQvvhKYwsvkks4Gh/2FG2SXGPYcVT1xvG8umQoadexH7oPEHEKDyjwFHOWsqSWhCAhEIGfjhH+x9XjFYDmRKjyi7M1GVgd36sTXWaQk8vEXUEA/1W0cE4etmTALC1d5tZviMM5w90MtlRrLDs4Aj01rHicm8xiHHelA8oubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA8E71A1AB3;
	Fri, 27 Feb 2026 13:27:43 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B31701A1A98;
	Fri, 27 Feb 2026 13:27:43 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B59B20321;
	Fri, 27 Feb 2026 13:27:42 +0100 (CET)
Date: Fri, 27 Feb 2026 13:27:43 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	vladimir.oltean@nxp.com, boon.khai.ng@altera.com
Subject: Re: [PATCH v7 2/5] net: stmmac: platform: read channels irq
Message-ID: <aaGNvz/n6b4klf1K@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260226-dwmac_multi_irq-v7-0-f8fe3b945bb4@oss.nxp.com>
 <20260226-dwmac_multi_irq-v7-2-f8fe3b945bb4@oss.nxp.com>
 <aaCankErMJZ2XM_s@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaCankErMJZ2XM_s@shell.armlinux.org.uk>
X-Virus-Scanned: ClamAV using ClamSMTP

On Thu, Feb 26, 2026 at 07:10:22PM +0000, Russell King (Oracle) wrote:
> On Thu, Feb 26, 2026 at 09:54:07AM +0100, Jan Petrous via B4 Relay wrote:
> > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > 
> > Read IRQ resources for all rx/tx channels, to allow Multi-IRQ mode
> > for platform glue drivers.
> > 
> > Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 46 +++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 5c9fd91a1db9..93bd915ab6eb 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -697,9 +697,40 @@ struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
> >  }
> >  EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
> >  
> > +static int stmmac_pltfr_get_queue_irqs(struct platform_device *pdev,
> > +				       struct stmmac_resources *stmmac_res,
> > +				       bool tx)
> > +{
> > +	int *irqs = tx ? &stmmac_res->tx_irq[0] : &stmmac_res->rx_irq[0];
> > +	char name[16];
> > +	int i;
> > +
> > +	/* RX channels irq */
> > +	STMMAC_FOREACH_MTL_QUEUE(i, MTL_MAX_RX_QUEUES) {
> 
> You've missed that there are two separate definitions for tx and rx
> queues - while they are currently the same number, code shouldn't
> make that assumption.

Oh, yes. My fault. Next time I shall review my code better.

> 
> > +		scnprintf(name, sizeof(name), "%cx-queue-%d",
> > +			  tx ? 't' : 'r', i);
> 
> I'm not happy with this method of combining the two loops.
> 
> Maybe instead:
> 
> static int stmmac_pltfr_get_irq_array(struct platform_device *pdev,
> 				      const char *fmt, int *irqs,
> 				      size_t num)
> {
> 	char name[16];
> 	size_t i;
> 
> 	for (i = 0; i < num; i++) {
> 		if (snprintf(name, sizeof(name), fmt, i) >= sizeof(name))
> 			return -EINVAL;
> 
> 		irqs[i] = platform_get_irq_byname_optional(pdev, name);
> 		if (irqs[i] == -EPROBE_DEFER) {
> 			return irqs[i];
> 		} else if (irqs[i] <= 0) {
> 			dev_dbg(&pdev->dev, "IRQ %s not found\n", name);
> 
> 			irqs[i] = 0;
> 			break;
> 		}
> 	}
> 
> 	return 0;
> }
> 
> which has the advantage that it becomes a generic helper for getting an
> any array of IRQs.
> 
> >  int stmmac_get_platform_resources(struct platform_device *pdev,
> >  				  struct stmmac_resources *stmmac_res)
> >  {
> > +	int ret;
> > +
> >  	memset(stmmac_res, 0, sizeof(*stmmac_res));
> >  
> >  	/* Get IRQ information early to have an ability to ask for deferred
> > @@ -735,7 +766,20 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
> >  
> >  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
> >  
> > -	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> > +	if (IS_ERR(stmmac_res->addr))
> > +		return PTR_ERR(stmmac_res->addr);
> > +
> > +	/* TX channels irq */
> > +	ret = stmmac_pltfr_get_queue_irqs(pdev, stmmac_res, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* RX channels irq */
> > +	ret = stmmac_pltfr_get_queue_irqs(pdev, stmmac_res, false);
> > +	if (ret)
> > +		return ret;
> 
> These then become:
> 
> 	ret = stmmac_pltfr_get_irq_array(pdev, "tx-queue-%d", 
> 					 stmmac_res->tx_irq,
> 					 MTL_MAX_TX_QUEUES);
> 	if (ret)
> 		return ret;
> 
> 	ret = stmmac_pltfr_get_irq_array(pdev, "rx-queue-%d", 
> 					 stmmac_res->rx_irq,
> 					 MTL_MAX_RX_QUEUES);
> 	if (ret)
> 		return ret;
> 
> This has the advantage that one can grep for rx-queue to find it,
> and we also use the correct limit for each queue type.
> 

Agree, your code looks better. Applied in v8 :) Thanks.

BTW, I would prefer to use sizeof() instead of constant for array size,
but this is the style used in stmmac, so I reuse the same approach.

BR.
/Jan

