Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678E389DF3
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740912; cv=none; b=aNFi6nidi98rXBU8l/w6ipeiDpzMtWtLVf8PE4fm0ZmUkKBDjD5QWUKDuiXwyqBuhrVbb5eJaMTOv74R3J6ebWQpDEpluY6xa7utpv2bDzhtHTRRoYmkU35A8Oli2sU5e0iCup4xr5lU90x6wVXxiuERbYoOPZAYzkwIXzZdDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740912; c=relaxed/simple;
	bh=sXhiHZI8mZNgaETEribil7t3+7ffWQhDIkyHb1maeag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jb73XcHVKNlMMb586cGr05Jh2OgBhTbxGDrk0/PZ8lFSW0dDXWBZmp6I+/NhcEyIpKh1RMw/1/0cTkQhbDUAtwNN0MsZz2FmQTVuG+MlXGi5ZYo/g4Yd98K7fVXUsnHV7AT2mSMAf7LCtbdUkHY4T1OpPNEIxDgdDekZF5edOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BD7WBtmG; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BD7WBtmG"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202602101628206708e23ea80002073f
        for <netdev@vger.kernel.org>;
        Tue, 10 Feb 2026 17:28:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ag+Cq1k6g10bvY3OzWqdpR/d9e2z2DN2pf65+hTvlr8=;
 b=BD7WBtmGTpMp/fh+Fk4hZkgs9F6Gdlr/YcgQZmHQ4Q3t3VX5lBMhVZx3gCpfsZVzDItC4A
 zUSp7INR5ACKSAIcl7U0qvgh49ZGs2FezZJVjgKyOKjd01tMCWBE3ybIygkx/QlvnU9aNBaT
 zL9V5H7fnqOjVrA3Yt8vrB8Yejteh9IfXkyA0hEyjDJAh+4xBDYuWDj0VGScuwnF8d3L6fbl
 cU5sF7atUCAnPsv9psAksHFSaf2w0mFiS0kwY0EItrpwDMZglGhm9cfnDPuYtPQHJe8+Y3We
 r09oKlSiKT0jqodCne1qWXoWJJvzcuzEfDhTQh/SeZi4pVPZ6sgcGt7A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 10 Feb 2026 17:28:14 +0100
Subject: [PATCH net-next 1/2] net: stmmac: intel: Fix IRQ vector leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-flo-net-stmmac-default-affinity-core-v1-1-4e76612444e1@siemens.com>
References: <20260210-flo-net-stmmac-default-affinity-core-v1-0-4e76612444e1@siemens.com>
In-Reply-To: <20260210-flo-net-stmmac-default-affinity-core-v1-0-4e76612444e1@siemens.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The IRQ vectors allocated in stmmac_config_multi_msi() or
stmmac_config_single_msi() where never cleaned up.

Fixes: b42446b9b37b ("stmmac: intel: add support for multi-vector msi and msi-x")
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index aad1be1ec4c11c3da8a1f56cdc200250b7f2d1d9..48e6d61064bd57afe90d3b83cbb3f2fe5351166a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -1327,6 +1327,7 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 err_alloc_irq:
 	clk_disable_unprepare(plat->stmmac_clk);
 	clk_unregister_fixed_rate(plat->stmmac_clk);
+	pci_free_irq_vectors(pdev);
 	return ret;
 }
 
@@ -1346,6 +1347,7 @@ static void intel_eth_pci_remove(struct pci_dev *pdev)
 
 	clk_disable_unprepare(priv->plat->stmmac_clk);
 	clk_unregister_fixed_rate(priv->plat->stmmac_clk);
+	pci_free_irq_vectors(pdev);
 }
 
 #define PCI_DEVICE_ID_INTEL_QUARK		0x0937

-- 
2.53.0

