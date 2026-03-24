Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7A2A1AA
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344109; cv=none; b=iC3FZJXh4MUMymbQ0ZCv3GfXyNT71jZmdXMlC7386fH6Ur8/MW6lqR1wfWRYq80eaQ3suZ9HXyZ1qTBc6t7trnam81cPaq0TqKvguMgV4XkAFqUx2o2zBge05hjHJIrYr0tSmp1+BZ4bHtMk/VU5YvhFWqs2ytx15jvnau6nInE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344109; c=relaxed/simple;
	bh=BfBFqaDuUuwjt+LEIhJ9aKKSBbuR6ZmsJyVY9a/3l3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvcfBsR5sp+Fo2ZAhTdRxUue9YLrRhWso+NpUtVXA6ccbN5NrPfdIOwAAF0BPJSy8xtnUS/l/yyvQNi3UNzoC2uwRXfzbDEmE0AVwR9WbmNYMoYHDdk2jzn8YVRq3tXgP1hnhhTGvGZC3q1WSu63I6SHakFD93u4fn6gwESds5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cxA/kf5g; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cxA/kf5g"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C6ABCC58099;
	Tue, 24 Mar 2026 09:21:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 924EC6011D;
	Tue, 24 Mar 2026 09:21:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 567DA104511A9;
	Tue, 24 Mar 2026 10:21:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774344088; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Jl+zv1qJmZXW+mDeB3W8k/7HhcPBhRwvYFxrgAInSP8=;
	b=cxA/kf5gpYbIex+CoaokBYA+SpEs39Fk0Abby5TD9YNoriShrrsVtUp4oduIQKNmDzkhVR
	yQov/qovYmCdF4P0vzkg/1A5Gtv4fUqHxlzY5W/mDotlcE0dE+ydZPyBJobSJjcx+un4BB
	/CihzzaD7aJ8XJIjmENAla3P1ZBlqey5zPOPg+OStaIQ54G3US32OhZZThESznk9ASxJF7
	jt8yBw9h9krOyXbz+atMvCWOxz+lhbQqy4EO685O1VYOWmYHSFqJhk5BqDWgwsFiHLZo8R
	nBv0EtFyWCd80DmPiLZFgAEXfF1l+5WkDfHeCYb1edSpI1U4I3Mhtdq9lJ/W5A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 3/5] net: stmmac: dwmac-socfpga: Use the correct type for interface modes
Date: Tue, 24 Mar 2026 10:20:58 +0100
Message-ID: <20260324092102.687082-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The internal helper socfpga_get_plat_phymode() returns an int where we
actually return a PHY_INTERFACE_MODE_xxx, use the correct type for this.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index ed6448c0ad2a..629074dbbc15 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -72,7 +72,7 @@ struct socfpga_dwmac {
 	const struct socfpga_dwmac_ops *ops;
 };
 
-static int socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
+static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
 {
 	return dwmac->plat_dat->phy_interface;
 }
@@ -386,7 +386,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 {
 	struct regmap *sys_mgr_base_addr = dwmac->sys_mgr_base_addr;
-	int phymode = socfpga_get_plat_phymode(dwmac);
+	phy_interface_t phymode = socfpga_get_plat_phymode(dwmac);
 	u32 reg_offset = dwmac->reg_offset;
 	u32 reg_shift = dwmac->reg_shift;
 	u32 ctrl, val, module;
@@ -444,7 +444,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 {
 	struct regmap *sys_mgr_base_addr = dwmac->sys_mgr_base_addr;
-	int phymode = socfpga_get_plat_phymode(dwmac);
+	phy_interface_t phymode = socfpga_get_plat_phymode(dwmac);
 	u32 reg_offset = dwmac->reg_offset;
 	u32 reg_shift = dwmac->reg_shift;
 	u32 ctrl, val, module;
-- 
2.49.0

