Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC6421F00;
	Mon,  6 Jul 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349861; cv=none; b=GwWAQZ0kg2ZSltHI9N3mmXOk8fKA4lCIBYiApoIPeLQpJ1FIsPoO2I3g2kxQpgCh1Lq1xTnZyLwXjQbs5v8DTs/jWqN7HQIVqCh8eFi5ytAieC2K7XkoiWnavr8hlpsedHNpl4v3ybNFReHKpxQDMTRjugzLWAcbjq1X0xTZDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349861; c=relaxed/simple;
	bh=VTvytXf49n9wDy4qHB7eU0wl2Euee5GucAXeQgkW1r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGE8BB0P4+o14QMV+GzalPdA1E9ThW1OtS3ERB6kjrLPnECyfvznmNIaBjSBenTE7RLcvLmeCJBjOquXtq6B9A+KJ1+VZwA3auP5DdJyDfhADyDtpdGfzD95JrfI/6icvWQGX7vkIXYW24rnFN/eU4wp0J65rlO/hyZhYE1CFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SDjUcqLQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SDjUcqLQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ADaEzG5k+SdavN1eHzHBe+2hNmvFIXHsmoacs5qvmYM=; b=SDjUcqLQVM9+ct2Tl1Dpp6lmbL
	r+rH8J3EJnI1wsdMkIvrWsN6Hd84jsKsX82Di6Dltnfoi44kSgm2E+6LZDs4pui2lepL0ljcUQEbo
	Ul4664ULpjAbaZIUX28xkaPTqUiYo7MtfhFIxPjdRANKyyjAyLVsB8ssBN/viQm9bN1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgklE-00B0Wp-Ny; Mon, 06 Jul 2026 16:57:28 +0200
Date: Mon, 6 Jul 2026 16:57:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/5] net: phy: motorcomm: Enable optional clock for
 YT8531
Message-ID: <e73a58e4-f9d2-46ea-8124-730f67936aee@lunn.ch>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
 <20260706-rv1126-alientek-dlrv1126-v2-3-ff3176ca362b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-3-ff3176ca362b@gmail.com>

On Mon, Jul 06, 2026 at 05:14:43PM +0800, Yanan He wrote:
> Some boards feed the YT8531 PHY from an SoC-provided external
> reference clock described by the common ethernet-phy "clocks" property.
> 
> Enable the optional PHY clock during probe so boards can model this
> clock as a PHY input instead of keeping the clock alive from the MAC
> driver.
> 
> This is needed on the Alientek DLRV1126, where the PHY reference clock
> is provided by CLK_GMAC_ETHERNET_OUT.
> 
> Signed-off-by: Yanan He <grumpycat921013@gmail.com>

Please separate this out and post to netdev.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew
