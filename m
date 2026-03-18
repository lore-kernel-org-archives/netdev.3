Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8E3CD8C8
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858384; cv=none; b=gdHf74/DDXXnJ2SL9eP4KWG7tI3GG4YxgeTZaQrzyjE32i1dmkA0BMLjwwm+60qER56QQGheDG/iv9aQxRg80HNCodUutw2JbpyIwg7k2a/y6dR3ht1HTZr1fbhM2oYppWALL1Hi5QFN3L6R4kYK9P6SQWGMubYZgPTosrsWvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858384; c=relaxed/simple;
	bh=jVseAMGDZnEnDSsab2/hfTJam7jaDka2m+kybhypjys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DecUANqQVKuyrBKpw+Ma7xej8K65oP7oTOZJD+k2avnCzzpSHgwFWleB5OEqIJ7B0shgfFznoWJFbuaNFZ06PruDLpHaZe3Yrfwir5NM6gmk8K9JegjXkltqpPyNWwrnY/0dDpNgZl9ux81weap3oG6Qr1j2EG9eI8CC6oUTz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MGDf90YM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MGDf90YM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IgmHv1W2xff5lyiQbHV+n4Yse37UxYTbZx0k4RwQlNE=; b=MGDf90YMO1+FhI2NwjaX+6K3ZR
	dkMnyqDAtrgXGwTUPHlT//njb7PtlDfEYStx9317lfMMNTVZuKZpX1sGGHZLGkgTobqaHkb9fPN1o
	qWzohUrv4aQ90HKcRIEf+bslEXfB0ideBcEjHCtJP3ck3ltgc37JMmUPnyXGTxZ/oLaVCnHk8/cqD
	jX90SF5hlXu16fywJhkzJ33QDmr5OVLEfePHcowM5iLI+B40UeHyfPwP1K1riKdrwLDzsrLJnx5Ja
	dbDiMptugqEQ5Ht8E9uzu8NlVqDHuO809nuYbYEDNfCnQFQlJDHJ6Axupw8QqKid67dXF/6bXCJ/5
	9qiZeMiw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44118)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w2vax-000000003ok-2skG;
	Wed, 18 Mar 2026 18:26:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w2vav-000000007IU-1OAe;
	Wed, 18 Mar 2026 18:26:13 +0000
Date: Wed, 18 Mar 2026 18:26:13 +0000
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
Subject: [PATCH net-next 0/5] net: stmmac: descriptor cleanups part 2
Message-ID: <abruRQpjLyMkoUEP@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Part 2 of the stmmac descriptor cleanups.

- rename "priv->mode" to be more descriptive, and do the same in
  function arguments.
- simplify descriptor allocation/initialisation/freeing
- use more descriptive local variable names in stmmac_xmit()
- STMMAC_GET_ENTRY() doesn't get an entry, it moves to the next one.
  Describe this in the macro name.

 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |  12 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |  12 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |  20 +--
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  12 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |  21 +--
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 152 ++++++++++-----------
 11 files changed, 127 insertions(+), 117 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
