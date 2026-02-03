Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7039B4AA
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112886; cv=none; b=fasdoPwRSlbSPrCjcaZBOtE+Yb668/P3CcO+EhttJtw2Coyl8OPY+MBD35/CrQq2gS6n+y8swEYekx4igI6CG8x8luQFxCOmvpQhiOPmZa6oeCYvPv0ixkPwisEkhCWwqWXiKUuZBg/xJR6KzwYFgByMhf+FLPrp6KDXtjHPR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112886; c=relaxed/simple;
	bh=S6w5TOaGLHTBZ61boHGqajX7YS3iJ2bSnqbB5Bp4FeM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NcVy6WQlej/Ff2aokpUOUkW8Fy8LzU8/gkkWJEA3KTBmylcPt2aZ/y19Gkq95e6mqowgMi3WWcSg/SgByALw+jqTD2MSf3X7C6qOSpaByEF+aZLPaHBCktHX+rhkXF/vaO71X3CO7DEEUGt/UKqnggwpNV8B+jVaNsPI8nJmcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VGc5SFjR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VGc5SFjR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NgxGeROhbjObWg7IAZzJgp1I3pE73spYexZUzz3i04M=; b=VGc5SFjR2IMH+2UMj7VwRkHW/1
	QTPJlF2n8OgXBK6+TGUFuIvs2yWsqZvvvTz9cIPFPDPi1qh8ZBiUzyaoQxjEW7KMD3FbgBoeuuFoU
	gdNUyQmnI+uZnhaomMK34dUc3AXBjyhvxbAz+A5Gr9MDqBjJs1FozRkBSXOGSA2vf5QeqAvCn1Pnr
	m6bZbvfNGcugUjntXI8aAk9Id4uhu1+4I7Ed6BSV/naN1W/3yv04OvZXyjgSvp6DY1HBB4bxcvP5r
	vVkpode7InS+EnlubRm6qaGAxWAtfKX6Sb7Ph3gmbncu9ku0qW7CAmrDYD/Mil1qGGTeyvvcIm7wk
	/3Ainz4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36726)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vnDDV-000000004wU-0IUy;
	Tue, 03 Feb 2026 10:01:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vnDDO-000000004HS-3vmU;
	Tue, 03 Feb 2026 10:00:58 +0000
Date: Tue, 3 Feb 2026 10:00:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/4] net: stmmac: fix serdes power methods
Message-ID: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

The stmmac serdes powerup/powerdown methods are not guaranteed to be
called in a balancing fashion, but these are used to call the generic
PHY subsystem's phy_power_up() and phy_power_down() methods which do
require balanced calls.

This series addresses this by making the stmmac serdes methods balanced.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 65 ++++++++++++++---------
 2 files changed, 41 insertions(+), 25 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
