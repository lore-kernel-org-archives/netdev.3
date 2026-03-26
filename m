Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815433F8D4;
	Thu, 26 Mar 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527540; cv=none; b=mr446TkT6bMhJQdGaoocglWXwvTV/bW7TRADAJ0V16QO4orhIAyuHRvPBYI4/qfbGb6taaEtDudR+KTKZJd2SsMiGe8tDev0F+VJ3II2yBJLddvFn/DUKPQ/OHyWmBeFiAb8Hrg74iZzsqwKZR4jSNLgXFu0OVXBiYrjWjPbQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527540; c=relaxed/simple;
	bh=9UlhdLvO/oAVXnN0UVC/Y9bBJYS4roP0RLGr6kuLNUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT+bGVSy7jb4K+NWbMmoKuEdTNnndYnXMXddY6jthsslik82NdANr2MZQZTxOuKtn0wBYl+9In0Ngrxk+FUxx1NVhO+AXKU/2zLknBbRw+TLT0RX2KwkCGRMm8NLcRbcbblwWDsp2fBVkL9+A9UiqChxLr+Z+rDAHarcd76YrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eRP0fnIh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eRP0fnIh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wrg/kFgdY4Ptg/fFnrPXnWqYCPBktQnEu4NL0+V4Z0g=; b=eRP0fnIhsKI0g0t9tYe40Yq79P
	mnKkbFlSpxgAFFR0p57/eU1lzKnzCA+A4eHmhE0mhOIG9IrSg/krHXlYCCHFPjZhdJGv5kLJHIY+m
	g5Xkae8Pprrr7DYlTEnwtf7UeqgSyf3NatYdGmV81RrcnHI4Q76ZFmKyExPFLNQrQFTc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w5jfk-00DTRF-6F; Thu, 26 Mar 2026 13:18:48 +0100
Date: Thu, 26 Mar 2026 13:18:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Message-ID: <ab6a06c1-2d7d-4032-8d38-063470cd45c0@lunn.ch>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>

> +	mutex_lock(&dev->alu_mutex);
> +
> +	ret = ksz_write8(dev, regs[REG_IND_CTRL_0], 0xA0);
> +
> +	if (!ret)
> +		ret = ksz_write8(dev, 0x6F, indir_reg);
> +
> +	if (!ret)
> +		ret = ksz_write8(dev, regs[REG_IND_BYTE], indir_val);
> +
> +	mutex_unlock(&dev->alu_mutex);

What address space are these registers in? Normally workarounds for a
PHY would be in the PHY driver. But that assumes the registers are
accessible from the PHY driver.

	   Andrew
