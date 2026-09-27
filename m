Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C4314A9E;
	Sun, 27 Sep 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524849; cv=none; b=EAnKvUg+T/6hha5I1t85x2y51t2ChdVsGaRkzpvPxLBhzaFqorKapn6DDcQHReofnK44rNTOjBGM1KUAEIFvSH/d628fazMfEfSc1N2p2/zbA+sZJA50YQ4CAU8bJ4gwMOfrm2zv2RIfOG5F5na+ZwPgBy2sPYdwNKxYhfPlsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524849; c=relaxed/simple;
	bh=1jXcilBCqxxtP/HG7T7p4/HErBemiED/CQUyeAFr5Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ygmf/8JoX0bH21A9MEHwY9+KxmH0Ky5Ne/aLQNcwiInnFjvrEM40Qm/fFBbM0fxT3GBOjCGtW8Tt1is/LH6WUfm+ispfOtRoVdkFRNRbjtAhBVFWUnQz5xCnbHdyq3wR1YvmNauSPHqaJCA1tH2VJzxFd3BAnrF26VnL0pZZZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UzBREPF8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UzBREPF8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CeE136aIIhy+ZFn9pE7CHCVaaq8lJW7PLCTFAuVc1Ks=; b=UzBREPF8M/dnld6kndhz7jS8Kn
	/xV7Zy0le2aAzfiqPH006k75TaBmyEAvzGh0YKnaa4u1hm1aTJynrzBmxiMBSKlfFBRqQ2dbgWxXj
	cE+GTGvgZ2ZdxdmpbXgPZnwhHaNsCgQhSiM9TvqO+rWGHYLbGtJ7x0V0CwCx7Q0fuqZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xArIp-007XHF-Oz; Sun, 27 Sep 2026 18:00:35 +0200
Date: Sun, 27 Sep 2026 18:00:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	George Moussalem <george.moussalem@outlook.com>,
	Ziyang Huang <hzyitc@outlook.com>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: qcom: at803x: Fix IPQ5018 short-cable DAC
 values
Message-ID: <2e59e8eb-42dc-4ecf-b4f2-56c18431f2f0@lunn.ch>
References: <20260927155136.2489-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927155136.2489-1-yongzhao.derek@gmail.com>

On Sun, Sep 27, 2026 at 05:51:36PM +0200, Yongzhao Chen wrote:
> When "qcom,dac-preset-short-cable" is set, ipq5018_config_init()
> programs the MDAC (MMD1 0x8100) and EDAC (debug 0x4380) fields. Both
> fields occupy bits 15:8 (IPQ5018_PHY_DAC_MASK), but the value 0x10 is
> passed unshifted as the set argument of phy_modify_mmd() and
> at803x_debug_reg_mask(). Neither helper shifts or masks that argument,
> so both fields are cleared to 0x00 instead of being set to 0x10, and
> bit 4 of the low byte, which is outside the field, is set.
> 
> Use FIELD_PREP() to place the value in the field. This matches the
> vendor SDK, which clears bits 15:8 and ORs in the value shifted left
> by 8.
> 
> On a Redmi AX5400 board, where the IPQ5018 internal PHY connects to a
> QCA8337 switch PHY without a cable, MDAC and EDAC read 0x6868 and
> 0x7800 before the write. With this change they read back 0x1068 and
> 0x1000, with the low byte preserved. Without it, the same writes would
> leave 0x0078 and 0x0010.
> 
> No in-tree DTS sets this property yet, but it is documented in
> qca,ar803x.yaml and used by several IPQ5018 boards in OpenWrt.
> 
> Fixes: d46502279a11 ("net: phy: qcom: at803x: Add Qualcomm IPQ5018 Internal PHY support")
> Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
