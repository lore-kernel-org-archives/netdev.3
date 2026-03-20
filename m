Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91E30EF84
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773987651; cv=none; b=MFdwxvTXpvDj4nmNZatZ/vm8hEhR6zJJB4tqlkPpzzcbAYZbIajBiXwV4G6vTEWOEUGj3dQlWgvhF/tPfrQpkzXKUao39NDSTVskcgB2Qc7PAxmJaHI8TQPpsHDzFRC4ssjMEOAOxW98obKTL0s2/Is+QANE2UTqVwvK1vt6yTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773987651; c=relaxed/simple;
	bh=/GAq46yYSAf24859SU4N9spoCPWEk/QOWi0M/RJlJ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBK/vt7deOV+i4/MzZvihnC7hc9OvXSqAfvHxWW23F4r+B9FPMNH7YCEXAdtqKUphXSc1B+qBdmX/FMIeabVoZTxM9sQndjF3nRAgn+aWqt65W2Bor0IAxFa8L3bdwIJruAH4npF1TNCIfRYL2Z1p94sq2Hyfh8WYsRZ1YbGLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt6c/0YI; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt6c/0YI"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b056b7f783so8120105ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773987648; x=1774592448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bsX7j3IsBCAR2JvcHeowKyby9MbV8ivPuVe631jWpdc=;
        b=Dt6c/0YIyrHgHAh5s7Xd1Ynvd+8b+zMBTNMH+lgu5UxIKTpZ1UnzA3Jdpq+GYq6tBk
         130NFkdV9QzHZ/L/Y47f58zioybTtiyqqib2oc9QqigbMbHOcKSwQrB/mMX9hLaCZCUe
         JV4xdwDGFVP9p3iSif7rvXX/PhDqA1vu4xAQTGwoLAQuJXnjUuK+E6iQMLefI0dq8zzd
         ojjs434uEi1BzNcpgD1G/JBsJdajqOXvsOBLJrXH7GCQqvlSETdq5XFWc1WL+/Tp1Qfp
         8vhSsVF7ymqOHZSR3PHtiDVhJ580hUuDIUtbfbs2wTSbh+kMy3SdWmAQuFwv1zyOHun7
         iVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773987648; x=1774592448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsX7j3IsBCAR2JvcHeowKyby9MbV8ivPuVe631jWpdc=;
        b=QLez01Nhl5jhOLKxvb6QQCeV+2QMEtU+gAosB0pa1luoc3IwsCV3/Igvnrh6RMrB9J
         bcR9f6tFE+So88gVLEiwIrmbHhnC6FziErFQxWYLrUOYdTmWe0ApfmGtWSab9qtj7U9j
         As5SxvNcu01m+ALcKTULx72P/lCLc3XzMWdHCgZUBSzl/bKxIt6jaS3IRFfdpgTy4v8H
         tJJ7btrlK2/u41/cYAvrHaVdUMTVxP0mGX+owzAOGVxBNvQuBnxGFp8lPp2vJDiOPThd
         LgtN9LUCVLvz04fUsrPhmlLuZZZ1oBbARurzUmddI4wFDeGPk9hGvr/7IIW2N8pol5Gg
         3xXQ==
X-Gm-Message-State: AOJu0Yy7r3mAICERiQ2kyKpuLYDC46aMLvrVovwYg83AhGImkcp2oQ25
	2prxThwGbAQgZrQxXXmYn5xvtF5LO4iN3v6nD9HIwPUWKg5KZh0Is4eeY3MZuGSN5y0=
X-Gm-Gg: ATEYQzzPiYI7lF5A8BqjNvR2PGyO0ONhzpQT6PxEizSpbJXT6cSuMh3r3QomJTRbuF/
	Msb/aV/SVyGIwqF5f0fLSK6nIDn3ELNjPfPkv8xd3SG7UTJcJySsAFanzokHduSkJHqi5+SZRHQ
	s5cRCTepCcD3jzPiTOqTdV4g3pWXyVWM580BESnQL9wtv+EOMht7VFq/gbS6xWFRatR+aXFN+ek
	TEBvGjSPhBLWxn2xx/gwkMgTC4w2wa7YmZPtdRYMK+Nkr7fBDCI1605Q8hZ27a/X929TW/nMDCY
	4gCXp7J/+lC2LCAjiywDlbsnkY4EqYHQxJNMJWg5JxnCMktQwbymrd4sUDfGkqlN9HwI58CXKQP
	O3Tdj5rC6VsNztufySad5O68p5mT/LXxo+GEom9BEnj60rbRXJWmSLi+90m7ZUWU2bybwHN+oiH
	mAC3AyIYBeuwjmLp3QN3yV1d8NPvJJz2q0sKkvzCfdkR0lSQ==
X-Received: by 2002:a17:903:1a2e:b0:2ae:cd8c:bd04 with SMTP id d9443c01a7336-2b077165dabmr46941965ad.10.1773987648287;
        Thu, 19 Mar 2026 23:20:48 -0700 (PDT)
Received: from XP-PC-yangg9.xiaopeng.local ([98.98.112.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836554acsm14418715ad.51.2026.03.19.23.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 23:20:47 -0700 (PDT)
From: yangg9 <cohenyang511@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	yangg9@xiaopeng.com,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	vladimir.oltean@nxp.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: close reset IRQ window and avoid double free
Date: Fri, 20 Mar 2026 14:19:55 +0800
Message-ID: <20260320061955.833785-1-cohenyang511@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yangg9 <yangg9@xiaopeng.com>

During reset, stmmac_reset_subtask() used to set STMMAC_DOWN before IRQs
were freed in __stmmac_release(). That leaves a window where interrupts can
still fire after the device is marked down, which may lead to interrupt
storms while the interface is transitioning.

Move stmmac_free_irq() earlier in the reset flow, before setting
STMMAC_DOWN, so the reset path no longer has that interrupt window.

Since IRQs are now released in stmmac_reset_subtask(), guard IRQ release in
__stmmac_release() with STMMAC_DOWN to avoid a second free_irq() during the
same reset sequence.

This removes the interrupt-storm window in reset and prevents double IRQ
release.

Signed-off-by: yangg9 <yangg9@xiaopeng.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 124d7a00f9f0..99b661379d9c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4212,8 +4212,9 @@ static void __stmmac_release(struct net_device *dev)
 
 	netif_tx_disable(dev);
 
-	/* Free the IRQ lines */
-	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+	/* In reset flow IRQs can be freed before dev_close(). */
+	if (!test_bit(STMMAC_DOWN, &priv->state))
+		stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
 	/* Stop TX/RX DMA and clear the descriptors */
 	stmmac_stop_all_dma(priv);
@@ -7331,6 +7332,8 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
 		usleep_range(1000, 2000);
 
+	stmmac_free_irq(priv->dev, REQ_IRQ_ERR_ALL, 0);
+
 	set_bit(STMMAC_DOWN, &priv->state);
 	dev_close(priv->dev);
 	dev_open(priv->dev, NULL);
-- 
2.43.0

