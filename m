Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EA44C64B;
	Thu,  3 Sep 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437482; cv=none; b=FR+g7FhtTd+l/zkVjU89he6Y8zJPYG3HDFp+JZ/zKgOGjoR+qi1FZDf78GwHV3fPwLQnywrxwYPeXd0GFYK4uDFG0Yu3Df/wthTbKK31mT5yPMRkOpQS9wNqIsPOB30HNKMVfigLBb5MAR6s53ooA0318kZ1Hey+08g3JaF0H/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437482; c=relaxed/simple;
	bh=TmyulZ8mVnSltxZsjxwNrEta0HAnB/Gi4aRTsa6XtQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQTNHFJASSEs34AJHzIfR2yj39tkdCMHM7NtWQnAYtCdERFOfb7MELBrKIQpDUiATWCW44Y6eBUwvV9FsMPTVF1ssSVJ5qVFnO+PjbGffld4jRjNDpQloQ0hm4VyRTp97NMYHbAAhTcEDQR/d+4XNZC2JHWHSQiz7c6Oz2O24VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bp2aa5Xz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bp2aa5Xz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xl5ihRMOzCbIkTbFuO/xpo8Dv4lTrmxjlUdD28fg19w=; b=bp2aa5XzrfyPcPnBIBwq6oHlN6
	88BYK5dx03MiAIuG01aderzieEPs23O6qP3Y38H7x8YQJYPW4yzRH6a5dA6jFRrqwDRRC90fCvakK
	pJXb3cmamC+YRs/FOUiMRMwkobrtsO3Ffc/SUrz0sBVS4Br3/JPjLg0QwcAIjK59pcw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x26HG-002iLy-Sn; Thu, 03 Sep 2026 14:10:46 +0200
Date: Thu, 3 Sep 2026 14:10:46 +0200
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
Message-ID: <1622b0a7-5516-4e72-b5e1-60c12b65b52e@lunn.ch>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-3-f19454814bcf@ultrarisc.com>
 <910be156-b631-4b62-972a-79d9a9e38697@lunn.ch>
 <178842162417.2701756.3296149694160507506.b4-reply@b4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178842162417.2701756.3296149694160507506.b4-reply@b4>

> > This looks to be 90% identical to dwmac-sophgo.c.
> > 
> > Do you expect any further changes to this driver? Is everything
> > supported? Are there more clocks? A GPIO for WoL?
> > 
> > I'm just wondering if the common code should be pulled out, or even
> > dwmac-sophgo.c made generic so it can handle all plain boring devices
> > which have RGMII delays and not a lot else.
> > 
> 
> The probe boilerplate is indeed largely similar because both drivers
> use the common stmmac platform helpers. However, their platform-specific
> requirements differ: Sophgo requires additional TX clock handling and
> other configuration, while DP1000 requires fixed TX and RX delay
> handling. ACPI support under development is also intended to use the
> UltraRISC glue driver.

ACPI is going to be fun, since nobody does ACPI networking.

But how big is the change to the glue driver? I expect the change will
be minor, a call to devm_stmmac_probe_config_acpi(), in addition to
devm_stmmac_probe_config_dt(). Anything else?

One problem the stmmac driver has is cut/paste glue driver
development. The same code is repeated again and again. Russell King
spent a lot of time and effort trying to reduce the duplication. So we
should not be adding more duplicated code unless it is actually
required.

	Andrew
