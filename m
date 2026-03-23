Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000EF36DA10
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259742; cv=none; b=ja5slrqIVOg8p1qRyqMFhbsIAbduMbexHKWyHUKayj4LIVeCNwee7z+di+ngKXIDM0QT/BwLpPDMrsBLcx+tkTQKeDK2+qD85vz5KK0ada7IFx+Af49zMnpLv7Vxzu/K2W2goG2qetW3vqIPcqQdQW7Md+z60W2ziWwhSNJW/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259742; c=relaxed/simple;
	bh=GSqj15XOYgZ+z3rGtlQoS2JdFGH8XW37H8ENXEVYxQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+wbc9NWSBflJaZ0pZmM3pLUOnmrXh3iuPHjtjdbh/wokxnNKgMlY9He7Ql8WTtwaN7bn2JLVmeNIy7ZgKGUlKZapE/WgkosiCNfpbsCGgKpKxuOojlHIFcA9HeWIxBcVu29f3fokZ0H/t/8bmUdaBkFZxypvSORQHaI1WJBsCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KSobhkUH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KSobhkUH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lrsfFTGfYyLKxF07ePPhHcfSutGOTt7NkUKvGum/24k=; b=KSobhkUH1DcN4nToJvqyD5yAUQ
	/YpHvXdbSzU/y6TgMZ2xtyfj7RPYzfRRFYJvfvJV8J5aiOWZgDg8+Otj13FDeCHV8cyXcj6+gVISn
	Gp4j/vwmO0HAIkQSvho4ojB8Cgnow6dWrQ8onHswqgD55iniIYO9q8WKP/M6Pywi3EkY5I4Zv2Zlc
	Ua/Yy8CL4gLXFmaIx4CdSXbes8YbsXVCJiC+jHf4ODYwLNia5zNHTJrLJobSaLhf1VGO+gw3NHXJU
	BrNyURQGWUCtEdKSVuVDuWRkDoObJqSlntuD5RJHQOZuDT6VsZjm1Fu0tj4lLxOAuljroKiHj9FE6
	tHgTrPqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57086)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4c0X-000000000GI-2nAx;
	Mon, 23 Mar 2026 09:55:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4c0W-000000003w9-0ocX;
	Mon, 23 Mar 2026 09:55:36 +0000
Date: Mon, 23 Mar 2026 09:55:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] net: stmmac: provide flag to disable EEE
Message-ID: <acEOGMHfYsxv3GOk@shell.armlinux.org.uk>
References: <20260323093933.1785583-1-laurent.pinchart@ideasonboard.com>
 <20260323093933.1785583-2-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323093933.1785583-2-laurent.pinchart@ideasonboard.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 23, 2026 at 11:39:32AM +0200, Laurent Pinchart wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Some platforms have problems when EEE is enabled, and thus need a way
> to disable stmmac EEE support. Add a flag before the other LPI related
> flags which tells stmmac to avoid populating the phylink LPI
> capabilities, which causes phylink to call phy_disable_eee() for any
> PHY that is attached to the affected phylink instance.
> 
> iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
> along with the main dwmac interrupts. Since lpi_intr_o is synchronous
> to the receive clock domain, and takes four clock cycles to clear, this
> leads to interrupt storms as the interrupt remains asserted for some
> time after the LPI control and status register is read.
> 
> This problem becomes worse when the receive clock from the PHY stops
> when the receive path enters LPI state - which means that lpi_intr_o
> can not deassert until the clock restarts. Since the LPI state of the
> receive path depends on the link partner, this is out of our control.
> We could disable RX clock stop at the PHY, but that doesn't get around
> the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
> 
> Previously, iMX8MP worked around this by disabling gigabit EEE, but
> this is insufficient - the problem is also visible at 100M speeds,
> where the receive clock is slower.
> 
> There is extensive discussion and investigation in the thread linked
> below, the result of which is summarised in this commit message.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Closes: https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

As you are sending this on my behalf, you need to add your s-o-b after
mine:

 Any further SoBs (Signed-off-by:'s) following the author's SoB are from
 people handling and transporting the patch, but were not involved in its
 development. SoB chains should reflect the **real** route a patch took
 as it was propagated to the maintainers and ultimately to Linus, with
 the first SoB entry signalling primary authorship of a single author.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
