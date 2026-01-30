Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037736998F
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771421; cv=none; b=c2d2izWlpALYwTTmZ5mj9z572jXwVbz0kL//8S2oKezx1Un+n4IbxLhSKd0yXRQ+HZGoGsW8bJVxUdKCahq05NtOMuPmydfSsdJK5umvuQ50JxRiT3wCAisDRkV6AOfDbPDagTVjAXsRV9gQVfPi1pk28R05Rcu/MCmnTmr0HNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771421; c=relaxed/simple;
	bh=lQ1GPqBG1bLMVug+IQYN9Rt4D+myfoPqfyRjjy2E4As=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tpLqwYcJ204Ns+C7GWQE+QQ+gU17J1vHlyiG4e+J024j1wYU1en25nic6iJqBR9H6aGL7V6zzC7EbQ9r5lgp+wqZJn0zPY6H/JclXW+XPlSRT/l1aYY/yP/YHrPcWg7JprC7ndiJrLP3iHo8HdXav7i2YCFcy1bcq8yx9Sva6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bmTK0DWC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bmTK0DWC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3k8TRdhaXeM2i6zJgXaeR4nkYItV8+qlQs+6J4fCWbo=; b=bmTK0DWC5RF/7ippF0fl7kF3Zr
	ihBB4O7eJDOapBuT8ZpT7Tphf+RY8R49Fqd8jesCBeZWPtjCh8qKZ3538jnW+eIMi2xoT7B4VhGjc
	TCAw+318c1zuuOFIX2cpMUSC4IGe71/gll3hflsdiWZJy6Q+5tBilpRhwFRLAQpKmZm+Hc30QBwvt
	mhAjMISXD8Ob+obvY41rQcA4lP7clVw42nckn0x64m/R1KTg860WiROVah0AZRJordPbp/gOji9R9
	GpVBAS8RljgZKhDbQ7Q/iERbgafoLzcmvWgcTUJ90+8jcv373KHvR4ub916c5P/YEDA+wzCSSxeUF
	tgrONKWA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47814)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlmOE-0000000012b-2SoS;
	Fri, 30 Jan 2026 11:10:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlmOC-000000000Sl-33GT;
	Fri, 30 Jan 2026 11:10:12 +0000
Date: Fri, 30 Jan 2026 11:10:12 +0000
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
Subject: [PATCH net-next 0/3] net: stmmac: pcs preparation
Message-ID: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
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

These three patches prepare for the PCS changes, which, subject to
Qualcomm testing, should be coming in the next cycle.

 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 --
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   | 31 +++++++++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   | 24 ++---------------
 4 files changed, 44 insertions(+), 31 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
