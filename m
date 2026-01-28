Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B0635A930
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607261; cv=none; b=BTvjtEdLTWOQX7FuUZWt0stfzUt0NMcsvTrOrVNqjKUfb7+MaZpXfEviHw8hf6YsdNX8QGuT0v0k1cleAOt0RRACQa1lEkbzZR+qAELQeCw3/khIikqronwG01KibmnPsxpp405stjL3oIfLr6XEvAioyeejzs/8oj6UVUHuvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607261; c=relaxed/simple;
	bh=v6cRY1490HSv5FdBzXz/p2SJ/ws3xq2YnRd6X/SgcYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQS70/v321KUtHSAOLnYTr/sjg4JKIMa7GYoCVnfMxBtqI5bbSAW156mERAYbKNZYERln8gwJyCQBvnPo4ZNmRcEx7Ayl2IUzKKdCVh7KolCR0GExp/7bfx1XFrm5OaKKft+rlw1/AHEKkx/AtgWt0A9p2G/Wg+5qOSO9FxBN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V7PWZBKM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V7PWZBKM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J0KcY7Fsfvbjfd/GXsJlX0QhIkev7bIX3GqdcG+qxZM=; b=V7PWZBKMvlEZzzoE5wl2irsdY1
	j0GjLSrReUh6U4SNiHG9ctT1LbAY00sSG267v5t0tnx8QsVhqsj1f+8EglDOHih1+liiJC+oSoWQJ
	Qrr/NCuk9YI2ODkGi8cX3Gy+upz8GAIYHIC5sHCTFBH27LpTYUBCUu9Ir69TWpm/2saM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vl5gG-005BWr-8a; Wed, 28 Jan 2026 14:34:00 +0100
Date: Wed, 28 Jan 2026 14:34:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH net-next 1/3] net: stmmac: rk: fix missing
 reset_control_put()
Message-ID: <30e0bcd5-6366-44f5-8d79-8a2eb3560246@lunn.ch>
References: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
 <E1vl3Fv-00000006v3L-215v@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vl3Fv-00000006v3L-215v@rmk-PC.armlinux.org.uk>

On Wed, Jan 28, 2026 at 10:58:39AM +0000, Russell King (Oracle) wrote:
> rk_gmac_setup() delves into the PHY's DT node to retrieve its reset
> control using of_reset_control_get(). However, it never releases it
> when the driver is removed. Add reset_control_put() to rk_gmac_exit()
> to clean this up.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
