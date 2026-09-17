Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4059E326;
	Thu, 17 Sep 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656364; cv=none; b=uJQjahL/MSzEpqj0kme46g9kN7dVUerlSnLRCEvvnb/r0VAJs9KGtN+tAE/gjgIuqmCUaK9jX9fPStsCApcJte5rcDdqy+mSKbcNziYFBY4cam6UdrX9XfktNCUNzS0VpRAg5AwxC1EcosIv0s+0fFlkGITMDCmZA7Cxm+2X+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656364; c=relaxed/simple;
	bh=k4zrCT4eR8qZM0VR8w2lXLpnLx9LYSHYQZmHdke8O78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f00g/zxdFLJW8x/JJMJxJXcN84u94lHud5V2peUW4oHKFjqkbU4eaHMCfj+RsO+L6L2XYKDu/iawZR5Upm+xw8DcLXTzzoT6pJkGdT87pl9ZVU3hXAA5BQZSBao4Ai4QkYhJNA2QTsFy2Hlfu+oMsv8BZlbS92VelMoJdQjTcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V3Gyy0Hl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V3Gyy0Hl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8D6dupbThaIH6bTnFjZU/0E1SNuTYKf2dx3vH4iYKIc=; b=V3Gyy0Hl0VB3EqjL7f7Qlo+vCv
	faZN/UKwfTRQP/loJbVHCjzzGCD4DOu4h89SsK2os7l7HgxF/zNinoJvU2a9ROFpaGJ/YBV/Nsrf4
	BADyZDSQIMjqjoVwHXCUxw3IgQLjqXNKrqwuBgnPDC/X7oJf+0At69JxicvLQsntQGgY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7DMr-005h68-Lx; Thu, 17 Sep 2026 16:45:41 +0200
Date: Thu, 17 Sep 2026 16:45:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <me@ziyao.cc>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: stmmac: Default DWMAC_MOTORCOMM to m on
 MACH_LOONGSON64
Message-ID: <a10c8361-648e-476b-8b04-8716ad274fc4@lunn.ch>
References: <20260915073206.6665-1-yangtiezhu@loongson.cn>
 <90a666a8-9f6a-4640-a219-731f3d551c66@bootlin.com>
 <f6b93b98-e0d3-9e28-e366-4df126e6ab5f@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b93b98-e0d3-9e28-e366-4df126e6ab5f@loongson.cn>

> Before moving forward, I'd like to share an alternative thought.
> As noted in the earlier review, this network controller could be
> used across multiple architectures. To avoid the redundant churn
> in the defconfigs of every single architecture, I am wondering if
> we could unconditionally set it to default m in the Kconfig instead.

~/linux/drivers/net/ethernet/stmicro/stmmac$ grep default Kconfig
	default n
	default y
	default STMMAC_PLATFORM
	default ARC
	default MACH_INGENIC
	default ARCH_QCOM
	default ARCH_LPC18XX
	default ARCH_MESON
	default ARCH_MA35
	default ARCH_QCOM
	default ARCH_RENESAS
	default ARCH_ROCKCHIP
	default ARCH_RZN1
	default ARCH_S32
	default ARCH_INTEL_SOCFPGA
	default m if ARCH_SOPHGO
	default m if ARCH_SPACEMIT
	default m if ARCH_STARFIVE
	default ARCH_STI
	default ARCH_STM32
	default ARCH_SUNXI
	default ARCH_SUNXI
	default ARCH_SUNXI
	default ARCH_MXC
	default MACH_LOONGSON32
	default ARCH_VISCONTI
	default X86
	default MACH_LOONGSON64

No other glue driver does this. Why is this one special?

   Andrew
