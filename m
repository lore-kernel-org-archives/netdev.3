Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A642D7802
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597277; cv=none; b=r1M0w+7uR8uYSadzIVCraya85p7HZIMH8pPyreg57DRdn3bXKyIAWcZmMwzj2qpuJFmdAh9ajSvkX0i/LhPsc+o5CSh/OsG90RZGh+aF/KoHRPibATBaFgLHBKgmgvgB8UqXzaiu6IBahcBE71kJuFgYabBuK/FJKFi3WvyRZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597277; c=relaxed/simple;
	bh=hERTJksCWrgRyPfhBOCyYZ287TJ74/oWM0Ekt31NgWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TEr3ZHNe1pPjbUhJNHx37Jfdvd+pgW9MD78tDdYxHHPOe5IAfy+tayPVSg2GZ7iF9WnkdcLhGbNwztZez2wspOHMfLCmCF++QzV/8lYCJE5nKU1/o0vtblrH+4sVjcFSN8dJfCoQZUtlVY7nGx2452xVWPDqbC76Q7vhbcx3fXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jUs+J0rg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jUs+J0rg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fl4sYJRAfaPvJq+rD6WIfA9roqE5yw0+JWLXHL0Mt+Q=; b=jUs+J0rgHb8ycxAmuApWhPpuS5
	+VQWO0tl6o5iqwsM8hj5dekOEnA4QlUyMF8jV6CanFP8VqeuqWZJjGCpH/VXqLNOrkztKXaVBYQYD
	HQ5zraR5wnCtZsPcbQTwVz7wzLKvz6xWxoN2TRMoKN3dvrz5bJwHN1XKG/gO43RDMlWXrYruvL8gV
	TnOQZN2msYJtlc5WmztZUeLJP6LYLw18J1g86SM2ESh3gKhUwjGvPAajAVRP1LYtUSIFexv0BS3oc
	a6hj+yvlDw7iwmEgaNvdCKqrGFPvTYafwfLx8Fe3OA5MeZGueGwCzgrodH2+SOWmIhdhyFkCPXhEP
	OYltMUpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54694)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vl35N-000000007CT-3lIa;
	Wed, 28 Jan 2026 10:47:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vl35M-000000006uO-0cOS;
	Wed, 28 Jan 2026 10:47:44 +0000
Date: Wed, 28 Jan 2026 10:47:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <fustini@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: report active phy interface
Message-ID: <aXnpTy6XckPGcmg0@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

The original patch needs dwmac-thead fixed so the PHY_INTF* definitions
do not clash.

 drivers/net/ethernet/stmicro/stmmac/common.h       |  6 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 10 ++---
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 52 ++++++++++++++++++++++
 7 files changed, 69 insertions(+), 5 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
