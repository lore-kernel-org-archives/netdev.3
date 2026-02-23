Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F734E769
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846902; cv=none; b=bUKMA6rKYmFcUomgQokeI2XmC4quof2BsEMeT0i341kpVjbQmLgKzDb5bUEyQPfCqLtKHmWUkyO3m2xk2bYoc/uteBJLGfXfrmg5462clt8j16nD1dvG4LxG+M5UjzPypwDqVmvbppB+X8WIxLQpyfqGIl9p81p5ASsi1wKuyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846902; c=relaxed/simple;
	bh=D/iFb5oyC+TZYGbrxrSssawvXPQUVPpU+92eKJcsSO4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VrXJPpvsEIqB67ByWTVuti/4O7qIL0S2YtO22OSkwn1i5kY5U8aOkJeVRjbg3utaPYKD6923lZ66r6yOwXJi0WTQC8Kfm+QrSrKY2wK8U3oDgfMgfjxHzxXyQO+jDfI82MzTd4EH+vkOVKmBP3bdnGMrablAZjKZy1NUqTUIY2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iDELU8NH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iDELU8NH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yVvxS2osg3afF5QxBmdLydqPQProiRbBV5PcFjFO3rw=; b=iDELU8NHAmM6JhFcM9spRAW3nh
	MhRfYpQt65BSWM3wU/oUk6yTzlvCcLa3rpVBUcbV9KG6nZNcMuq5JlYKVBZ7M8uWwig9BTNaF3OYz
	XVLy7xgQ8v+s4FSQEyaC5XBxXNFylV8UCsbCRdb1RTM9/hUkSmBXuKwIczv3XltY34oBttO5vAe80
	ip03Q6NNCCap1+Fxx1EgC+KE/n2Uisgo0uHARbWoAOTGJyo5lFHh9PL4mGwRVvJQlUyx7POUhbjV/
	JgwdWGtNY681CcsZFJU8uIqpCauHgsEnCXANGDBDhocJ8H472QQHODWEAlGqj642ttfWpF4420Tmt
	vTasf/cQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47186)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vuUJi-000000003zE-1EVx;
	Mon, 23 Feb 2026 11:41:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vuUJe-000000007L7-1JHc;
	Mon, 23 Feb 2026 11:41:30 +0000
Date: Mon, 23 Feb 2026 11:41:30 +0000
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
Subject: [PATCH net-next 0/2] net: stmmac: fix interrupt coalescing
Message-ID: <aZw86hpjQ-3w3xqJ@shell.armlinux.org.uk>
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

While cleaning up the descriptor handling, I noticed that the accounting
of transmit "packets" for interrupt coalescing was buggy in that it
takes the difference of the two indexes into the circular list of
transmit discriptors and merely subtracts one from the other without
regard for the indexes wrapping.

This can result in a negative number or very large positive number
which would have the effect of either reducing tx_q->tx_count_frames
or making that very large.

Either way, the result is numerically incorrect, and could trigger
interrupts or not trigger interrupts when required.

This series converts stmmac to use the circ_buf helpers, and then fixes
this problem.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++++++++---------------
 1 file changed, 10 insertions(+), 18 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
