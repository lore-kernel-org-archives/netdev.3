Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B429314D1D;
	Thu, 26 Feb 2026 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147250; cv=none; b=a5+5gIj6C2H3OIhTQo3ecuuF7xRbCdKd8h1u9fTq1qLBxn7DlZ7PP0PL40eKFWJUblTa+Ka7Sk7E8k7Ycp/J/qzvxmrNtURjx2DM8gAt0wlo5dipm8ZrFRUaPFpTA5+ptH+mODiIltnRLqrQhhTqDcTMTYZhJwyG+ql28ajfPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147250; c=relaxed/simple;
	bh=perFwprZ19NFmkt6yJXHy5SD7ngPmDBmfDTrqL+DsoE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RMbEwyIcggHeOEzewh+Y4Igs5JH/yZxl0DgsMeVzxXjyxiYhBTmmkMCi630RfDz4RlOZbOyYOIN0Yex45vQZyTok33eOKaP9yBxImFHNgj6xMaqz8CRF5OlsFHCfZzmbZKSdezcBtZfeFiNO8ThcyTwEjHhxEim0pLcbKeSQfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MNboOHRE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MNboOHRE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D0UK8pO0Y/9nQsoDE0tyGVTLdOq02b88CjLRoni4BOQ=; b=MNboOHREJJVAwQGuNTlghY1201
	FHF0dvFD7a4Al7EYtSTPQiyxAl2nLEaRy3S81mT/Nu6eai2n/B86Jl+r6zvHVefKm29AtOcJrOv8o
	I7GjG6YvM5G9h+LyfdYN7UzpO9iVGhpMsN5sgpbCcoZIS3kuSPKgocR0gZCDor/wpZequcky0E2Fm
	IDP2phoCoVFvz5g+jvFV/euVHrIPiP2KF4X2NERWsyReTHvIUB7ipZaGBAZQ5ebZ29IjrgugjCfC8
	PgaIAkbSB/emei8UyqGsH3ja/fIEPniU9n+5PFZGgLxR5+KitxEwavrZTe6Izz1ugwb+4BhINXhli
	tvECZaOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38136)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvkS1-000000008Uq-0gwu;
	Thu, 26 Feb 2026 23:07:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvkRx-000000002RJ-0MlJ;
	Thu, 26 Feb 2026 23:07:17 +0000
Date: Thu, 26 Feb 2026 23:07:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH RESEND2 net-next 0/8] net: stmmac: qcom-ethqos: further
 serdes reorganisation
Message-ID: <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This is part 2 of the qcom-ethqos series, part 1 has now been merged.

This part of the series focuses on the generic PHY driver, but these
changes have dependencies on the ethernet driver, hence why
it will need to go via net-next. Furthermore, subsequent changes
depend on these patches.

The underlying ideas here are:

- get rid of the driver using phy_set_speed() with SPEED_1000 and
  SPEED_2500 which makes no sense for an ethernet SerDes due to the
  PCS 8B10B data encoding, which inflates the data rate at the SerDes
  compared to the MAC. This is replaced with phy_set_mode_ext().
- allow phy_power_on() / phy_set_mode*() to be called in any order.

Mohd has tested this series, but it would be great to get acks/reviews
from the generic PHY maintainers.

 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 31 +++--------
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c          | 62 +++++++++++++++++-----
 2 files changed, 57 insertions(+), 36 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
