Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97B3E277C;
	Wed, 20 May 2026 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302647; cv=none; b=ol+9hMoX+kLiZrO16g8xz9jp+pc+31jskP1TkWUs6HALtJRfPsnr0azj9nmgF4/2MELZhEdtRaoKZJXx9P+KLDK92zBA3u8kOJ/+IUeVtvyOqQv9DWwc4flkeIxRRqIILbG//4Es7CsnXJw1L9WDiecrRtJLoWfPdi++j/hzzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302647; c=relaxed/simple;
	bh=b03qRrZcAGccNMFvgTiUEzk6iVDZdoOo75O+YD1y1oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2svFEnWHQRzgxqyDRhbRW8FXU0XawBBEsObtxd9mGZaQj58C55ZVCyWMSAnCjHLDEklWClkoG7L0S2gixbCPuDBF7HSjSuhDS9VtbpWrV7bhYFdiL1cb94yfy99WJwaJfxOp+IdIakcbtPVDxtFlfBtP/8atU/nxfvdHDQLFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=o8oFhaTo; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="o8oFhaTo"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14B56A3E19;
	Wed, 20 May 2026 20:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779302634; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5sb4b5JmNuf3m+PKjvTG++e3CU9o6TXzphhA4z3gnCE=;
	b=o8oFhaTowOetH30VgwONoGjAb/GifoAEFAD/JavPTlVYM/llZLkTPD3W09toHmOUU85ojq
	RQjUmydjNTMAOd3bpKODNKbkWUJkkX3ih0cX23WiRxQVltGS4wQQ9+2i9BTSAZOZV/rTmY
	oG/xIbIweqG1ZL/+sBLN9ji2UFpjjKm8lBsI44mVxfNggYZh6tmh8XnWYC5mniiMLi2Yre
	KNgm2d69FpQ3CUjpR//ApN7axkCnZZ5sJLzgfeERWzxrj0SEA7tRomHS8+L8dR9oTWrzON
	8EZCre0IxUiFQn9nfTz8gWGsQmB83ZlezsOlZ6FyetDCgsRYJba0Y+7eTIYZ8g==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: justin.chen@broadcom.com,
	phil@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net] net: bcmgenet: keep RBUF EEE/PM disabled
Date: Wed, 20 May 2026 20:43:20 +0200
Message-ID: <20260520184320.652053-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Setting RBUF_EEE_EN | RBUF_PM_EN in RBUF_ENERGY_CTRL breaks the RX
path on GENET hardware once MAC EEE becomes active. RX traffic stops
flowing while the link stays up and the usual descriptor/RX error
counters remain quiet. In that state the MAC still accepts frames
(rbuf_ovflow_cnt keeps climbing) but RBUF no longer forwards them to
DMA, so rx_packets is no longer incremented at the netdev level. On
some boards the corruption ends up as a paging fault in
skb_release_data via bcmgenet_rx_poll on an LPI exit.

Reproduced on Pi 4B (BCM2711 + BCM54213PE) and confirmed by Florian
Fainelli on an internal Broadcom 4908-family board with the same crash
signature. RBUF_PM_EN is not publicly documented.

This shows up more often now that phy_support_eee() enables EEE by
default, but it also affects older kernels as soon as TX LPI is
turned on via ethtool, so it is not specific to recent changes.

Always clear RBUF_EEE_EN | RBUF_PM_EN in bcmgenet_eee_enable_set so
the bits stay off across resets. UMAC and TBUF setup is left alone so
TX-side EEE keeps working.

Link: https://github.com/raspberrypi/linux/issues/7304
Fixes: 6ef398ea60d9 ("net: bcmgenet: add EEE support")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 54f71b1e85fc..7c11cf916762 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1368,13 +1368,12 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
 	bcmgenet_writel(reg, priv->base + off);
 
-	/* Do the same for thing for RBUF */
+	/* RBUF EEE/PM can break the RX path on GENET. Keep it disabled. */
 	reg = bcmgenet_rbuf_readl(priv, RBUF_ENERGY_CTRL);
-	if (enable)
-		reg |= RBUF_EEE_EN | RBUF_PM_EN;
-	else
+	if (reg & (RBUF_EEE_EN | RBUF_PM_EN)) {
 		reg &= ~(RBUF_EEE_EN | RBUF_PM_EN);
-	bcmgenet_rbuf_writel(priv, reg, RBUF_ENERGY_CTRL);
+		bcmgenet_rbuf_writel(priv, reg, RBUF_ENERGY_CTRL);
+	}
 
 	if (!enable && priv->clk_eee_enabled) {
 		clk_disable_unprepare(priv->clk_eee);
-- 
2.53.0

