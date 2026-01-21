Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974EE4657CD;
	Wed, 21 Jan 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981499; cv=none; b=gE/MkK4Kc/qJum854xiYHwJpkiDFOyjtnT1D41Ylqs44Mr9MqlvjEpNXyyVxJJzw7yvnb05DoSQLm8JDvlxLc8t5+GA/5D9Dsqh9WAC2PwomkYmyUTh3th9Rf1A3ofuwQukr2DHE4j9OIEjU44wkHBreF/xcaaM3pSnfxZ2SaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981499; c=relaxed/simple;
	bh=IefQU51qzJ4yD/UHG/6qxxEwZ+bk9a0mwin+q0hz+OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHQ3I1TDu0milnhrACq/G4TMeT8wM130LVfDDuDKNtuio3+9sA76FrSb/SuBJ909noeoydJOefm/p601UyabLhr27SdJ0HD/u6TJzKUfTxwPDms2zU3AH1cAohsyp53dZRjhbqT9yGiiFi3dEXJNcIzlOF0AsElWmo1hIU2GspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AAE9D200D44;
	Wed, 21 Jan 2026 08:44:49 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93A1B200D2C;
	Wed, 21 Jan 2026 08:44:49 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 00D46202C4;
	Wed, 21 Jan 2026 08:44:49 +0100 (CET)
Date: Wed, 21 Jan 2026 08:44:49 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
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
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] net: stmmac: platform: read channels irq
Message-ID: <aXCD8US9KQR4lq9W@lsv051416.swis.nl-cdc01.nxp.com>
References: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
 <20251214-dwmac_multi_irq-v1-1-36562ab0e9f7@oss.nxp.com>
 <b9c8580f-e615-4eaa-8878-2fb8d888c0aa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c8580f-e615-4eaa-8878-2fb8d888c0aa@lunn.ch>
X-Virus-Scanned: ClamAV using ClamSMTP

On Sun, Dec 14, 2025 at 11:30:43PM +0100, Andrew Lunn wrote:
> On Sun, Dec 14, 2025 at 11:15:37PM +0100, Jan Petrous via B4 Relay wrote:
> > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > 
> > Read IRQ resources for all channels, to allow multi IRQ mode
> > for platform glue drivers.
> > 
> > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 38 +++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 8979a50b5507..29e40253bdfe 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -700,6 +700,9 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
> >  int stmmac_get_platform_resources(struct platform_device *pdev,
> >  				  struct stmmac_resources *stmmac_res)
> >  {
> > +	int i;
> > +	char name[8];
> 
> Reverse Christmas tree please.
> 

Fixed in v2.

> >  	memset(stmmac_res, 0, sizeof(*stmmac_res));
> >  
> >  	/* Get IRQ information early to have an ability to ask for deferred
> > @@ -743,7 +746,40 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
> >  
> >  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
> >  
> > -	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> > +	if (IS_ERR(stmmac_res->addr))
> > +		return PTR_ERR(stmmac_res->addr);
> > +
> > +	/* RX channels irq */
> > +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> > +		scnprintf(name, 8, "rx-queue-%d", i);
> 
> It would be better to use sizeof(name), not 8.
> 
> Also, 'rx-queue-' is 9 characters. So i don't see how this can
> actually work?
> 

That is true. My fault, I accidentally pushed incorrect version.
Fixed in v2.

Thanks.
/Jan
