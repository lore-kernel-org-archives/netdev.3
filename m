Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F93B05A9;
	Wed, 30 Sep 2026 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805127; cv=none; b=osQJBaogIqliMSgiawOlnqVCy7IA/neBz8Ywu3DROJaij7dT/1gqWdARj0H460RMeqhAokiG9kzHwynqSQVsfyPQ41XLv+P6JIOjCNv285FK13GjJeYv9yTLV19/2D/L+wwuvI3rI/pCLqvh8RoeTlcc68EDqc+Qjql3PiTC4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805127; c=relaxed/simple;
	bh=fKjO1mQT5keV3NYzoqBVtHaHPDn8lKrOJsLQwgjOOOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7+c2UgEp8CfKnyAs7rE5RWD/vmMIiYc2EVDGtQFC4j+nobrRr4ImC0lyXlYUCGeIEK3UJr4MEHYp6dHaopQ/uy6JbwKQ1vQR8Qgkqfv97hIdk9XxwTqfBQbAiVRNlsfErRtwl5U5vi2J4MRqvdVDw+VUdPZVh7pk0DWWBInXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4CCUkl9I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4CCUkl9I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FD05RHOFRGfYmVLDxBq8IkkAKhJy/zrMPVkcJKQGgug=; b=4CCUkl9IfkEKMKG8R7waFOW7Zo
	sx5Jids8oyB/TLZO5vpfgAqsaJbVlAPBjWEcT1l715xC/SlHu94aUEQgVrm2TxsRknWwBWJrNjF4M
	iLyXmjKvlsGc8qHDfXaHcA6uTTXTF0uYdDOqw0e2JwNxaJSuJy1F24YagV0Q3BYiv1yY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xC2DJ-008FQg-Nn; Wed, 30 Sep 2026 23:51:45 +0200
Date: Wed, 30 Sep 2026 23:51:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: iav@iav.lv
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Eric Dumazet <edumazet@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: keep the GMAC powered when
 the PHY wakes the system
Message-ID: <1799630a-945e-49ca-b9d5-9e068c482cea@lunn.ch>
References: <20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv>

On Wed, Sep 30, 2026 at 07:34:45PM +0000, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
> 
> Since commit 6911308d7d11 ("net: stmmac: convert to phylink-managed
> Wake-on-Lan"), the MAC device gets its wakeup flag only when the MAC
> handles Wake-on-LAN itself. When the PHY handles it, device_may_wakeup()
> is false for the MAC, and rk_gmac_suspend() powers the GMAC down: its
> clocks stop and phy-supply is released.
> 
> On Helios64 (RTL8211F, Wake-on-LAN in the PHY) the board then hangs on
> the first or second suspend with a magic-packet wake.

You have not answered the question why is hangs? Given the current
description, this just sounds like a workaround, not a fix.

	Andrew
