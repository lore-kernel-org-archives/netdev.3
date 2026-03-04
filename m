Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17535375F6B;
	Wed,  4 Mar 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614152; cv=none; b=evAyDXclNa9HI2pLzJQr9amLO/SAgjEIX3t8VNwItnez6OyCaV1PYOO6oIb1RaH6+l0CMpiKIK6kyGFKfU6BFMRGR3G/rDKm4SAHCDY4p4gZu+DH609KogjZYdVMCQyPtYwp6CWrNtRob1/LulPxgapLO2EtFaorQrGwIMoJFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614152; c=relaxed/simple;
	bh=iN3b7iEtG9PMMsy5RTiZO8w8Rx/i/YCfQL9yVosldr0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=BaIdNf1snhiPZi5CkXBOL5se6DsvfjS/uREoutsq1tWOsFDboMI3VBIyE5HMQpFrWmtbO89XJRXKvpZLftWzS+B8EUgD+E0KzMj4uBAo1j6WXLRlzRRBCs5LaaB3mm/WXMerX74bTUKJi6l3viYR20v98i6VoXxdZRH2UW3eOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AfoTj4lS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AfoTj4lS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9W0bh9pzsIi/vOkBmQhG/GUPdU1OE7zm0Z0RCZHa8gk=; b=AfoTj4lS/LuzQBgxm/Y93b16f1
	gQwW0fzHR+9My8IgxtrsoVF3L6gDHpth+ZwDWvZ014oqiHtbc1INpoB7KBEJNdDNtqDl90HiMxaxZ
	+NGCZ8zYUrR7RXkjZeG2dkH/Ye03Dfbh3yXuzXCMA8L8vYYXtTooB8tk0YafBUwet/0Cj1zTajECs
	uc2Fq4U5XhRKtFc7lkQ/LldyeHhMNfZR3bwi3Zv+CO4CM0P0QvYLxZ5lzaW9a2j4VKj2sKVFgOZoE
	/K3SIzrBPNLQ5iK2Y75FJG1p1Qpv8eaqHTehq9vx1WQKdPONSppjWaUQgBIwfaL74lgqQutAUF3mI
	GPtYZTLw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58856 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxhuj-0000000069C-3I5o;
	Wed, 04 Mar 2026 08:49:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxhui-0000000BqGQ-47ml;
	Wed, 04 Mar 2026 08:49:05 +0000
In-Reply-To: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
References: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next v2 2/7] net: stmmac: qcom-ethqos: enable
 2500BASE-X
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxhui-0000000BqGQ-47ml@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 08:49:04 +0000

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index cb1c074c2053..f4b63544895e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -828,6 +828,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ethqos->serdes_phy) {
 		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
+		plat_dat->flags |= STMMAC_FLAG_SERDES_SUPPORTS_2500M;
 	}
 
 	/* Enable TSO on queue0 and enable TBS on rest of the queues */
-- 
2.47.3

