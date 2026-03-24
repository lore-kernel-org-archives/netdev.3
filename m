Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F1352FAF;
	Tue, 24 Mar 2026 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357886; cv=none; b=LsyZtMs+sK/Sh7dlkhAlmn7gmW6Zqe1naFLwvbWH9k3P1r/wwqDUYUt9GQy0HWzqgJ8hWxIQhXMvG1XMvqVV29nCQ2PR8t/jJofqAOmEWODOnJ6siBcKw/My0XupAGA5j+mC4BhRNIYBKQfIjGD+P8TYpX9K3g6ZE7z5DZfIvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357886; c=relaxed/simple;
	bh=PzZ6C+1ATm6ZfENRCLXaXYvKU3MUGVM77I+xpxXixtc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SgFymTiJWzM3jyJuEVJ2t/0F7qONNfa4qY2cRj5FEj8tfA7rNqkIiMU/mes3plqmKq5qtxWZO3IKLWpWU41yYQzm5bYCPJPexl0BZTbODG5iCnNPR7NSzNZRTo5mIk6u9Lutl38lVx33doZDSXnEBN9cMr3af8Hc+TrmfIOwMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J9mM2uaP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J9mM2uaP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=322fmOA6sO/PNJzwsVlNjOBB6q/adXyjpi97wMhh9wo=; b=J9mM2uaPpXIdRUJu+lZ4TswC75
	7Xf7RJ6tfdxzS7HZr8qjU8htK6K9sBi3l0iWab4pUYozYrE+sMkAOBEq6sn89EkiUzQKFz8KVY1D0
	1x5evzNkvQQKSO9FtO34lo2AlU60Kt1uhzTE/4EeDJHQtZVpWDb/c8Q/kUTMkTHTQRTGbo+B5tHi4
	GntyAWh66fyQwoc37ytKk+6j44H4NwGxRL7Mt2yCvpAn+UZpowyZQ28Ol04RC2wLigssbS+rsLnFr
	tVrwgFjl/pg/GcQGoTwxgyEmIaGet0faCk+7f/ntBfYM4tKd5E56dUgWXA5aYXYjm3URBLGliSVxg
	hksTJ4JQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46578)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w51XQ-0000000022F-0gPI;
	Tue, 24 Mar 2026 13:11:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w51XO-0000000056C-04OJ;
	Tue, 24 Mar 2026 13:11:14 +0000
Date: Tue, 24 Mar 2026 13:11:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 00/15] net: stmmac: qcom-ethqos: more cleanups
Message-ID: <acKNcX5PqtWYf8m3@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Further cleanups to qcom-ethqos, mainly concentrating on the RGMII
code, making it clearer what the differences are for each speed, thus
making the code more readable.

I'm still not really happy with this. The speed specific configuration
remains split between ethqos_fix_mac_speed_rgmii() and
ethqos_rgmii_macro_init(), where the latter is only ever called from
the former. So, I think further work is needed here - maybe it needs
restructuring into the various componenet parts of the RGMII block?

 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 218 ++++++++-------------
 1 file changed, 86 insertions(+), 132 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
