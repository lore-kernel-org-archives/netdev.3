Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4A382379
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025225; cv=none; b=An5kQbjrWqUcAq3SLaHHfPFgYjmeGWBCPkmnbbvFYdswycxtNE9YZdMvDVOC/Y5CqBCCyRBNaL3HurPoT4a9qd5ujps1CRbfOU+/8qTI3YFyoJYTXKkJ16X7kXtarG4/AdTbz+qI/sve50/uxbEkgpmgq1A6mfEdE1ISmxsJdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025225; c=relaxed/simple;
	bh=TeFAKdm8teZdbhfLVWdLmhbrkyDsZKVXFNEFYJNtw9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iIWoAkZ4LuYN7Q/vMYHVn79X2YwZFjbNgSQfkV70NVbhinAbqDRm3BksyyXw8W1sKfmdtTtjRJ1ZkE4J+V0GtmFufzGZXRzC4aV4EUHrNZVe8JU3ABV9QhF1+Vf0KTkdtZVIeQAPGWZ0TMxB+a3WbeloE6waV7EMAt+w+CdVFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FjUYwxKJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FjUYwxKJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JLXg8A2dB6C/6B3r2jVXzkuVuzKHB/KU8OzuEFwRTtg=; b=FjUYwxKJ/I5gBvDEJi2ksZy4LW
	8N0+cGay7O2i2LKYMFL8RZNNTNqNn4SK65jEwfyHLBwxhf3PPkPXFMhGa+vRu0umK56hp4hrGf4oa
	HmOd5znMCf2L15mFo/WOUZZBylMSf8cLw5d3jyDYgYIASG7CX81m3aSCFgqauExrrJY3FGKLdZ5G+
	UujfMnDbY1UDfwB/1TJEFoGiPOJ42OVvxxupUGh+MePmb5SqGGXa4ZVY3845U/Nf7f/W9uHZc6RlZ
	sWUJyo7rscXslLY/LSsTZ4Ad7VEdir/vFts8Nv0s1v4vwCoDYXN8N3k2cUnJuT1UsUYQqspcHDPob
	8GWe9jwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46752)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3czv-000000006Kx-2eGQ;
	Fri, 20 Mar 2026 16:46:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3czs-000000000yz-3eck;
	Fri, 20 Mar 2026 16:46:52 +0000
Date: Fri, 20 Mar 2026 16:46:52 +0000
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
Subject: [PATCH net-next 0/6] net: stmmac: cleanup stmmac_xmit()
Message-ID: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This series continues on from part 2 of the descriptor cleanups, making
stmmac_xmit() more readable.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 103 +++++++++++-----------
 1 file changed, 52 insertions(+), 51 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
