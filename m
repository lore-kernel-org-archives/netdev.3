Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211026B2AD;
	Wed,  7 Oct 2026 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791342914; cv=pass; b=WzX5hhybOLfEjAD7KC14PHNrZMmq8L2Asu4AjN0agh1w9wRPfI1iUlp9EPFcZEDriKxTbExiUNDVpMQk+RJCA5z9QrkxOqwCJa8toag6A+S0h2NIDUETCichHLA2kPfbl0jUQgtUnp3rR1kzBksRivjIZYoWWUGbkbugsFK37BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791342914; c=relaxed/simple;
	bh=5nMR08qKE40Q34lJ2LndaTZDYNEPY1AYkH9+9D58Ekg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J48VfVk9QJcZhRRkum5dfyyzhU9UNFhm+Yaf2GAn11XQkuDWhlSuT+ZpOwmCKjw+FtWgc4ov25mW+Cb9XHk9yuoAPJx0aviJqe1ToIg6cGJ8TBr9yGmSscC9lm0vK8E0cCthJ92VW/HMJl3kP21AqW5OyWBIQyKFpVZkql03HFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=KF6vx3TO; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="KF6vx3TO"
ARC-Seal: i=1; a=rsa-sha256; t=1791342883; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Cznt3eby3evqFmTaqFMX61fH9TCqMrewryqZ0ZIa0guwBKiL57NvRHiXDMoS8Yy+FIPiw3RIqylETPrZFBBh8fCzB1FnmuAIu2pvU5lrXesEpoI2h/9WxN1u6s82LU6JxaA0Qxgg9lUi7TZbTSs7yceacl3EJB1eeD4yWcvDD5k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791342883; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1lEvJX1E303KGewRVMWUi6HWA6+DV9DZawsuOsQIsn8=; 
	b=KHc6n8lKadRmoC+boJGfigKcUgEU6vVTrhQCLHvp4wUhsCKQqtJ+56l9svWtx6JsyZhf6sTxhcSfYCKhKw8/qXVlt4yOU/381k3KdKxSFpEunz7HgoD6MnVCIDC5EdiWyhXhfKNZgyhd7WCKOs3CCcOGhqZtZWaqVGnM+zqBG5g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791342883;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1lEvJX1E303KGewRVMWUi6HWA6+DV9DZawsuOsQIsn8=;
	b=KF6vx3TOUhUkD5heJM/WrFAuygkhXbZJsimKwXsJNHSzb0F7xfhUZDJbIU1BGhWv
	16RpHMeRHp+bx//q3FOG1GgwmoPe0xp3tcBP2MtP/q69jPVtWa9eCPOKqZTYHhMLU/f
	vZJ/VGtYfBKpNo9HG3L0VFmXMvDF4OyJYu3/angc=
Received: by smtp.zoho.eu with SMTPS id 1791342880666265.053555662332;
	Wed, 7 Oct 2026 05:14:40 +0200 (CEST)
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
Subject: [PATCH net v3] net: stmmac: mask the MAC interrupt while resume resets the MAC
Date: Wed,  7 Oct 2026 06:14:38 +0300
Message-ID: <20261007031438.3179966-1-iav@iav.lv>
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

Disable the interrupt line around stmmac_hw_setup(). This matches
open(), which resets the MAC before it requests the interrupt; resume
resets it with the line live. The window sits under rtnl_lock(), which
stmmac_reset_subtask() also takes, so the reset task cannot free and
request the interrupt between the disable and the enable. If the setup
fails, it may not have written the mask: mask the core interrupts before
enabling the line.

Wake-on-LAN resume with the resume thread on the CPU that takes the MAC
interrupt, 7.3-rc5: without this patch the storm hit the first resume
on Helios64 (dwmac-rk) twice, ROCK Pi 4A (dwmac-rk) once and ODROID-HC4
(dwmac-meson8b) twice. With the thread on another CPU and no patch, the
storm printed at most 3 messages per resume in 30 resumes. 7.3-rc6 with
this patch: no storm in 10 resumes on ODROID-HC4, 10 on Helios64 with
the GMAC kept powered across suspend (an Armbian patch) and 10 on
Helios64 with mainline dwmac-rk plus "net: phy: postpone PHY interrupts
during sleep with MAC-managed PM"; int_mask read 00000001 after the
glue resume and before stmmac_hw_setup() in all 30.

Fixes: 2e2c878a3141 ("net: stmmac: remove SGMII/RGMII/SMII interrupt handling")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
v3:
- disable the line only around stmmac_hw_setup(), under rtnl_lock() and
  priv->lock, not for the whole resume (Sashiko)
- mask the core interrupts if stmmac_hw_setup() fails (Sashiko)
- results with this window on 7.3-rc6, including Helios64 with mainline
  dwmac-rk
v2: https://lore.kernel.org/r/20261002043558.1302590-1-iav@iav.lv
v1: https://lore.kernel.org/r/20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv

Build-tested on net: allmodconfig and allyesconfig with W=1, no new
warnings.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b837e8e27a35..6091dc2d4ab4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8361,7 +8361,15 @@ int stmmac_resume(struct device *dev)
 	stmmac_free_tx_skbufs(priv);
 	stmmac_clear_descriptors(priv, &priv->dma_conf);
 
+	/* On dwmac1000 the MAC reset unmasks every core interrupt until the
+	 * mask is written again; we keep a pending status bit from storming.
+	 */
+	disable_irq(ndev->irq);
 	ret = stmmac_hw_setup(ndev);
+	/* A failed setup can stop before it writes the mask. */
+	if (ret < 0)
+		stmmac_mac_irq_modify(priv, ~0U, 0);
+	enable_irq(ndev->irq);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
 		stmmac_legacy_serdes_power_down(priv);
-- 
2.43.0

