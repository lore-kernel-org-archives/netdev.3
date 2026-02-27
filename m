Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF730F951
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186059; cv=none; b=IM1Q2rshh0Dl4AMiQm+FiVw7pdduxAV2fURmyOHiL91EBMU1Lonq++JCsRQl5cgn3pX4ByZzQRQR09bsjoOQDcAPWLXpbQ5FK1UxBELANDi8Eud4J6E4Mdr/FuTMna7+pB12vCpQ0+IlIWN4mQdUcxJbSKfuGsYedKKPprhp5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186059; c=relaxed/simple;
	bh=PhCqbJMjy1SiQVtSiBCwMTTHKiTtgasjPMnPd89AlnA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=S2+s3DLDgS09n4nZkt2uRhGW9Q0yssY/TysijlMMWiOcCAKZ1YWAXJIga+qx0Jx0b/vflMFhQ7zpYj2bARk4LKkzlm63CBOwnuoJ8o27m4Xd9blwKyxBDdxDufsLsMrbgH8+W2iUteDQfBbedtiWIDhXtb2vk4kPKmfljnn2Ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KV+0ks30; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KV+0ks30"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RpIRyZ7QzC/EBC6A85M42Ue5KN0IkzW1S7uTrte3DSM=; b=KV+0ks30s5w+XkvAjqLK9c8aLw
	Y+SPF51vKXHle27aiO2GeXb8eWHxqyQgempeY71m/oBoNovR+bNTCWZUkSWygrNWMcYn14YjSTdwH
	k4bvkmphbhrsfc44wKkboAFLYr+sZEvB3VY8RuMyfZJpSfdUyiUvMD4DzkY9+gNES3lm4s/g92Ar2
	TAOi4xoRiwRqDeB3hku79SkzAlayajKUo2w4Ni1MnMcMFG+ASFSAtdFf7m9zbZxxUkSF0mcLrefPM
	rAZRAgl69NVyvbIzZqUw9mkp/oKbp/ARZ8Rvx2hwPVFqF8FWqN0Mf1FC7vALHfaX7lIEL0NbA6ifn
	iPxuJd9A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51748 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuXu-000000000ec-3V5u;
	Fri, 27 Feb 2026 09:54:07 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXn-0000000AvnX-4A1u;
	Fri, 27 Feb 2026 09:54:00 +0000
In-Reply-To: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
References: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 11/14] net: stmmac: make dma_cfg mixed/fixed burst
 boolean
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXn-0000000AvnX-4A1u@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:53:59 +0000

struct stmmac_dma_cfg mixed_burst/fixed_burst members are both boolean
in nature - of_property_read_bool() are used to read these from DT, and
they are only tested for non-zero values. Use bool to avoid unnecessary
padding in this structure.

Update dwmac-intel to initialise these using true rather than '1', and
remove the '0' initialisers as the struct is already zero initialised
on allocation.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 4 +---
 include/linux/stmmac.h                            | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 92d77b0c2f54..ece2a0c38562 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -636,8 +636,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
-	plat->dma_cfg->fixed_burst = 0;
-	plat->dma_cfg->mixed_burst = 0;
 	plat->dma_cfg->aal = 0;
 	plat->dma_cfg->dche = true;
 
@@ -1106,7 +1104,7 @@ static int quark_default_data(struct pci_dev *pdev,
 
 	plat->dma_cfg->pbl = 16;
 	plat->dma_cfg->pblx8 = true;
-	plat->dma_cfg->fixed_burst = 1;
+	plat->dma_cfg->fixed_burst = true;
 	/* AXI (TODO) */
 
 	return 0;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index cc6c89769d82..84dea8c4fa65 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -97,8 +97,8 @@ struct stmmac_dma_cfg {
 	int txpbl;
 	int rxpbl;
 	bool pblx8;
-	int fixed_burst;
-	int mixed_burst;
+	bool fixed_burst;
+	bool mixed_burst;
 	bool aal;
 	bool eame;
 	bool multi_msi_en;
-- 
2.47.3

