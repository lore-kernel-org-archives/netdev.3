Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAFF35CBD7;
	Fri,  2 Oct 2026 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915790; cv=pass; b=Zx+C4uh1GIM1PQutk1L1dykOwUlsu89tDjlcBaz5u0Eddwai0F+8ILx2ZzELWoY5rKc6n03N6VFdjb1PRa9JhOWcu/zbxaAH/fPU57zuEHuLsNLbPTGNSWiSW8nBQ4iDlnfbObJFgPev7nyMm108/fHeHmzo86mJ7pYw5fqDD/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915790; c=relaxed/simple;
	bh=uN8BDeLpJRg0nGxltAi+o1OXX8JiZTRr6tmpFxqIUGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZcpuf9FWjrJiAU4phL3vwh77JVm8IaOuzhx2JU5hVPZodCxCtEpHfwKqVf3YrBAsDvK1eiIluRkjNa9CCLjRGjquO5Uj48QpGb1ikEz2ncVEqoiEb5e01pEeJ5ZE3pATeyrCoIrFbRtJ/s+g9nWrSbnwBNUn5y4HVKLoMIvonA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=BALetECD; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="BALetECD"
ARC-Seal: i=1; a=rsa-sha256; t=1790915761; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=f81BEgl5SbZFYoaATwIEpgVq+9LH4WN5p5RspyYPN38d4JgAhtvbpfWDnnYm1E0W5LRVVR+6EL6zPGflDebusABSTOcG2U92MEhfjJ05V4GKFd9Vdr+S7QjFA375LgyXEAWzoYcQ5bEp9YJVyvl9hm159tnXPEQ/25NbwrO+OSE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1790915761; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PUfIzwWDOAbo53jI5D67aCx7a69oUCJygXJtMbNr/jA=; 
	b=i+lyTCND9l9vomJGH0pQz6BfG5rGUh6ri2GnIHWhD0290a8bA0+Y0QaWLbnRQDLDLi4elsVWxImjgINa4WJO8UjG/FHFU/kxSpd3V4H4XIf8ZcJhYDe/49fs4J3aXV9qb9losz4tmcELmWdjDR00Ucvwm1hLsiiddw9XEiMS7GU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790915761;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PUfIzwWDOAbo53jI5D67aCx7a69oUCJygXJtMbNr/jA=;
	b=BALetECD+Kcv7vxOPtv99Y/bt1hMxfuGXADJX2pUxsyMfuSYTFVuz2tLcI4wgkRL
	Zmle7XRRewXgbBxwFBby5S6F++LGoVeiehwjLLPixC7rUfTaxrtM9y+ZR0Skksp44vD
	Tz7rAz0BerJ09Dcy7MjvoDK88QpdAL+xDDTFw1vA=
Received: by smtp.zoho.eu with SMTPS id 1790915759373340.0396654276939;
	Fri, 2 Oct 2026 06:35:59 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: mask the MAC interrupt while resume resets the MAC
Date: Fri,  2 Oct 2026 07:35:57 +0300
Message-ID: <20261002043558.1302590-1-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac_resume() resets the MAC in stmmac_hw_setup(). On dwmac1000 the
reset sets GMAC_INT_MASK to 0, which unmasks every core interrupt, until
dwmac1000_core_init() writes the mask again. Since commit 2e2c878a3141
("net: stmmac: remove SGMII/RGMII/SMII interrupt handling") nothing on
the RGMII path reads GMAC_RGSMIIIS (only the PCS code does), so RGSMIIIS
stays pending behind the mask from the first link change on, and the
reset lets it through. The line storms:

  dwmac_dma_interrupt: unexpected status 04000000

A register dump at the first message on ODROID-HC4 showed it:

  core int_status 00000001 int_mask 00000000 pmt 00000000 rgsmiiis 0000000d

The mask is written by the resume thread itself. When that thread runs
on the CPU that takes the MAC interrupt, the storm starves it and the
board hangs until a watchdog reset or a soft-lockup panic; on another
CPU the storm ends after a few interrupts.

Disable the interrupt line for the whole resume and enable it again on
every exit path. This matches open(), which resets the MAC before it
requests the interrupt; resume resets it with the line live. The line
is IRQF_SHARED, so leave it enabled during suspend, where another user
of the line may wake the system.

Wake-on-LAN resume with the resume thread on the CPU that takes the MAC
interrupt, 7.3-rc5: without this patch the storm hit the first resume
on Helios64 (dwmac-rk) twice, ROCK Pi 4A (dwmac-rk) once and ODROID-HC4
(dwmac-meson8b) twice; with it, no storm in 10 resumes on Helios64 and
10 on ODROID-HC4. With the thread on another CPU and no patch, the
storm printed at most 3 messages per resume in 30 resumes.

Fixes: 2e2c878a3141 ("net: stmmac: remove SGMII/RGMII/SMII interrupt handling")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
v2:
- target net with a Fixes tag; v1 was posted for net-next
- describe the RGSMIIIS bit pending since link-up and the resume thread
  on the interrupt CPU instead of a link change in the reset window;
  the code comment is fixed the same way
- results on Helios64, ROCK Pi 4A and ODROID-HC4
v1: https://lore.kernel.org/r/20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv

Build-tested on net: allmodconfig and allyesconfig with W=1, no new
warnings.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ec62fa7418f4..b275b6234b55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8313,15 +8313,25 @@ int stmmac_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int ret;
+	bool irq_off;
+
+	/* Resume resets the MAC, leaving every core interrupt unmasked until
+	 * the mask is written again: a status bit already pending would storm.
+	 */
+	irq_off = netif_running(ndev);
+	if (irq_off)
+		disable_irq(ndev->irq);
 
 	if (priv->plat->resume) {
 		ret = priv->plat->resume(dev, priv->plat->bsp_priv);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
-	if (!netif_running(ndev))
-		return 0;
+	if (!netif_running(ndev)) {
+		ret = 0;
+		goto out;
+	}
 
 	/* Power Down bit, into the PM register, is cleared
 	 * automatically as soon as a magic packet or a Wake-up frame
@@ -8344,7 +8354,7 @@ int stmmac_resume(struct device *dev)
 	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP)) {
 		ret = stmmac_legacy_serdes_power_up(priv);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	rtnl_lock();
@@ -8367,7 +8377,7 @@ int stmmac_resume(struct device *dev)
 		stmmac_legacy_serdes_power_down(priv);
 		mutex_unlock(&priv->lock);
 		rtnl_unlock();
-		return ret;
+		goto out;
 	}
 
 	stmmac_init_timestamping(priv);
@@ -8393,7 +8403,12 @@ int stmmac_resume(struct device *dev)
 
 	netif_device_attach(ndev);
 
-	return 0;
+	ret = 0;
+out:
+	if (irq_off)
+		enable_irq(ndev->irq);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stmmac_resume);
 
-- 
2.43.0

