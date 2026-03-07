Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C694330D50
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880791; cv=none; b=KD3btiMqSUQinsHVJVy/4kaA+Mz8eOfB5oHvMy20cfXuEIRHLr0aFKSwz+t3WmtSDpJxJYAqCHUBIL/DetDoXjTmyMg8OAxU8olKz+m3L/NyLTCYMyDxgMKpVGxUyS5xKqrd3HFXz+D6vCdxRdv6KcCjxmNvy3eCbElhAVFZcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880791; c=relaxed/simple;
	bh=69MIr4bYbpvdTH8aDxV0WaYuowYCEBS5uuS43O1sDl4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tJn+lVENGqFgSG1cOlHQFs4cLDj4ejQyhqZ4Z0IoylQXaae7V/R7D7lyu/181JXOc8r8Dz8cO2Qb32LY8IMykkrHCtHh6z/tDX/sFZiyVw8a99b5hprsgZmnUDjalBgYNAwPoswS574wfx1DrHIKs/dWWsppvDme7avz77ENGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u5ZwaofJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u5ZwaofJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yeRFLAMIYNkcai4uXKjM2O8dKLKiiCy/NlMEOTbW5Ww=; b=u5ZwaofJIqqBLjeQ1U3FwXMTKC
	Az1vIdPWDvYoR0lNFmb+NYlMk+bJSq4douV5yF4Yz6S9gvF+edMwqrleODK1fbQ9BtU55MkahcEoy
	yMbx0v518TNVf6G9wLW3xO9atiPGUu3ITLAq6RSjJicLBuLwLhXp0KyoDHE5Rt5e6I7HGXZsBbSc5
	IeGu8umS5jIwvrE06EvWhAVcIajeBIrrXt1DRelZf5lrBVYSAam4Ttzq4+r7BjRu47ChaxZr0Zr5D
	QPTchbUBnd4HfsxCZ1ylCzZfHiUVf+Os2VmjwJ0FCEOKbPk40yBi5zdlIHc2zAgdtHzN9/LiP0mgv
	pWPM2DtQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58536)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vypHI-0000000024g-1VQ4;
	Sat, 07 Mar 2026 10:53:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vypHE-000000002K0-40VV;
	Sat, 07 Mar 2026 10:52:56 +0000
Date: Sat, 7 Mar 2026 10:52:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: further ptp cleanups
Message-ID: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

A couple of extra PTP cleanup patches.

The first uses a local variable when setting n_ext_ts which is a minor
simplification of the code. The second removes the now unnecessary
"available" flag for the PPS outputs.

 drivers/net/ethernet/stmicro/stmmac/dwmac5.c        |  2 --
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c |  2 --
 drivers/net/ethernet/stmicro/stmmac/stmmac.h        |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c    | 10 ++++------
 4 files changed, 4 insertions(+), 11 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
