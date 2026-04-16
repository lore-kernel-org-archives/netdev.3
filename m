Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDA1922F5;
	Thu, 16 Apr 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345613; cv=none; b=iatIJznRYd2n2dbMjt4jN9vW2S5dTR1lPFpSsQl5NadQ+dbdfDTXsIPmwpIjzeMdFD7qHzCQ3emhYuH/TtXrt3YbSNdv9+rQmVwDCGwhF+lc0WMVN4lFdJlyEkGltXhqkcmtlKJL3Rahs5DQvt1fIoQUxgZ33R5oUkrAIqrhRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345613; c=relaxed/simple;
	bh=E7eGyefqW133ukX7BbFEmtGfErOk/FmhqY5MWm9KLN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc92OgF37O0vUj8Ub9/fKEZLhbrKn26MnltSdCLdJUmURYK9hiiDJDlHCoURVI72pKnIZxL449RX3A9iiXAdVU1Cil8mGWsMziGGyb+OJTTgcYgXx/xLmD9pIJQw+8CwRAMRRtWP9g2pOQuBlB2zPnRaIkmMJApq+za6JcJLLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE955X1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE955X1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4AAC2BCAF;
	Thu, 16 Apr 2026 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776345613;
	bh=E7eGyefqW133ukX7BbFEmtGfErOk/FmhqY5MWm9KLN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EE955X1JKX9779kze5sp+z4VPaiXETLF7oHsOPXG5HpyT3Ru4sBTbdsYTGSyVvau0
	 +oDRWn0GLXS+GC1LLpFL84DZUsxWt//juIbWJRLTDtaXU6cbXtu+x4l6QUOqkAlGBI
	 HBhBCilAw2R65AJ5KTSyGjX2zJ6uOagZVC3r0P6ErtU20Mz26T8ZUfLhT01QKKUnsc
	 WQNFDTbmIFm/b0iiyonMKt2j7CogfalHS3oTcd/MudNc/G3pR6fNgyLliiY/bWTfeY
	 1k2oRoH++0k0uv+lNz1qpclXBXC7TWrz6QiA3bZwE5IbQM5BhSevyRIx3qTOaVNch/
	 fmCdBjukZS8cQ==
Date: Thu, 16 Apr 2026 14:20:08 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Charles Perry <charles.perry@microchip.com>,
	Conor Dooley <conor@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: MDIO_PIC64HPSC should depend on ARCH_MICROCHIP
Message-ID: <20260416132008.GS772670@horms.kernel.org>
References: <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>

On Tue, Apr 14, 2026 at 12:30:47PM +0200, Geert Uytterhoeven wrote:
> The PIC64-HPSC/HX MDIO interface is only present on Microchip
> PIC64-HPSC/HX SoCs.  Hence add a dependency on ARCH_MICROCHIP, to
> prevent asking the user about this driver when configuring a kernel
> without Microchip SoC support.
> 
> Fixes: f76aef980206e7c6 ("net: mdio: add a driver for PIC64-HPSC/HX MDIO controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@kernel.org>

