Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93E4E50C8;
	Mon, 19 Oct 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413720; cv=none; b=YClYtxVWtfUX4CqY52QVN9qNL5VEzFZ5yoD9tOSu6oFk5uT2/OrS+qsrDMQTinOoEGIGpRL5ofpTHakHgSso4rht3Oo7qEIOpSqyJT7qggWUE5cSMijUYpf5J7SSFFdEpl31aeu0nHrQE8TZz9b4m0UhWD1/d0E4qWNUvSUtNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413720; c=relaxed/simple;
	bh=keLa+s1ChwKMV2N9Ex7hfMpXR7DAHmOcRkmSBMQA20A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaBbZsMqz4XikOaFx2oYzdgglIAldAy8buE1HtRe+bDDCv5z9/j43fzrgTdMcjrJFS8neYf4d5x1poyJ6dDzkpJu16UBWW6RGLvN9epwtgL8dJboK2bPUYiWeLJ9vLqXVUKfDfdWidXu/AWNFTq5sV+WkFhJS8fq+iFS6Mb9tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rO7Sr89z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rO7Sr89z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F0QANOw3/YflyQHsxKAQ7FbU1GzakLqdGTy7ygi73FM=; b=rO7Sr89zO/YJiwMN8XiYMwlCTI
	8cVZTYM/exDC94h8ybPb1TQCI3ixc9dmocPbirBZIbjkXYdtY4y2wqQNlEQdPBHSzPsw+RSpcbbI3
	GrJP8mogSafcjJ+pQjVRKTL6D1NRMmUuLDf1yrZPv/evjVo9iSmsS5t2gW+CP6uLGEVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xImg8-00BcyU-Pp; Mon, 19 Oct 2026 14:41:24 +0200
Date: Mon, 19 Oct 2026 14:41:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@riscstar.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, richardcochran@gmail.com,
	p.zabel@pengutronix.de, peppe.cavallaro@st.com,
	joabreu@synopsys.com, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, daniel@riscstar.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: add support for Toshiba
 TC9564
Message-ID: <7ea35e21-aa5d-4ded-ae4d-fb88d072cdad@lunn.ch>
References: <20261019030129.1470307-1-elder@riscstar.com>
 <20261019030129.1470307-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019030129.1470307-2-elder@riscstar.com>

> +  snps,tso:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable TCP segmentation offload.

snps,dwmac.yaml 

  snps,tso:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      Enables the TSO feature otherwise it will be managed by MAC HW capability
      register.

> +
> +  snps,pbl:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Set the programmable burst length.

  snps,pbl:
    description:
      Programmable Burst Length (tx and rx)
    $ref: /schemas/types.yaml#/definitions/uint32
    enum: [1, 2, 4, 8, 16, 32]

> +  snps,force_sf_dma_mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Force store-and-forward mode for both TX and RX DMA.

  snps,force_sf_dma_mode:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      Force DMA to use the Store and Forward mode for both tx and
      rx. This flag is ignored if force_thresh_dma_mode is set.


You should be using snps,dwmac.yaml to provide all of these.

> +  phy-mode:
> +    const: sgmii

This device support 10GBase-R? So why in the binding only allow SGMII?

	Andrew
