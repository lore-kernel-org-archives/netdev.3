Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE4437852
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827983; cv=none; b=PCLTPQzMWIb27YdrDPQPoa7S0DMiCzbKuuByjiVT3yxnHlRcND3iaA3KPtWuUTlXHkW5jkReF7+d9MJ8Kx9/olqVcRsrRojSKeuK5beWJC60OnX2wUNsdPHZzuBLcwhBhO7VNHYOPNlEGXBeA4cR36EsJqMbFnoofJghmof8Rso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827983; c=relaxed/simple;
	bh=Hx5UJuxKjwprvSGWaXQVjVJ0w0ttNwljukD9w8lrWm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IA779DEEEyGeRwAwwpuIek81lHjskBy/LRicIwgdek+q29jWflNr0GtYYYV7ZfP+t0hh0s1Dxhy09mnfaT6cC6Xq0cZdPqL6III+qo2nS76wVgAtD2byXsLvKWpGaZApKUnVZACR2WUVJMN16zMePyiBiYuUdso20jNtAT9781E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcUWHp7j; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcUWHp7j"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-80a18990c76so3834436a34.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790827980; x=1791432780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfjvWDlH74aBokTz23r7fE1Dwv67vVeYYEoQzFsEUhQ=;
        b=CcUWHp7j9E+nNdSpLM5zkVVFJQT6pv9pYo04SvWma+tRmIjiRQWaaBYH0VFap1A6Li
         EGMa2dmmioyO6bj7p6Yt1ac2h7KReEXu92kyTi5e47rJtsYwy2M6YvyWRQ6lo/LlUXPC
         vSgufNyzMw2vQ2UsM6wDreK6BU/Ib/KikvHVp4aOuTTAto2H7Gyn6vp/X8XYMZAcXzbp
         JlWxQvBarZM1d9KkKxNxZF4aCX93WTHL4wY9HaAJWHWZI1R8iofOtBe5uD/DjY74cHQj
         wyt1ZHT3II8zUnFmuaXBMaciNvUkspp4xUZm4O/Lhd8VRxZukG2YdWcZNbaaaoIduI+c
         uJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827980; x=1791432780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfjvWDlH74aBokTz23r7fE1Dwv67vVeYYEoQzFsEUhQ=;
        b=m76kmTXz2Th++RbLkd95LVlB/eVtNJhctu+6XVOQohAwOFsvqsYTfK/vrBxVy3Sdt7
         GNxqIe7eS87OIlFrx/1BZKKwdS209JFAiMpJecplZsMM1fIWyilbtne2OUYQafsDZ8mX
         DmT6IADnUagbyDJRCfSgK/SYqDHGUHqPxh2mfchmfUd4mkPKe7QyJud3H9WPnmHDJ0LB
         boHqYvCR0CEf9xwYXNB9f/y9lpuo/ayf1gmLyhxk6lhxJV+Sf5P0pSX+XPwuKtT0UR/f
         34HP6ljPUB76enBrY79toJbO6UTw2gQVJBDXmQqtP3wXFfGOzjNj/8iV1LBIVbWyA4hg
         Apag==
X-Gm-Message-State: AFuF++nPNvrL6qaRwhJ4brCbKxYEhkltG4KMSrU3edHugr6VcsiFc+Uv
	WWKngP2xzFjo1dBGOezLvs0aMnFED67rnu1BiZw2AQai9pQ0lK4LSjJE
X-Gm-Gg: AYBFou1pfCkDW5r5wBcL2Hby6ZIoRNo/LXp2HMfOoc6wz+OxO353fTQetHexV4uZUrc
	AIAxJ0RZlhkB4G9BPdG6rCT92hLbvZ0iWMF0vpjLqUWaitkzc+tVsFYWXwd4HCQqiEd0SY9WrlX
	0fMuypiyD3erVB5cASekJhe/5fw2LwnaCPtFFtAyMuaOFZmwV/QGbWUyqOzED3B69BuLOTtqvy+
	jUxhk+rh5RvtM3DD0bbcIcPml7vuLDtf9lC1ZofrZGqSvD743xNO2PltTRWo7sO9iSGCR8un5gN
	2b7Xl8C8MDGZMIjQPXZqpH/W3VGX+UQuewrirLT29zkPzq9OiFklqOsu+4Wy5hCOzvTLxvAKrvl
	z7ZIph4EsbuwsqNWF3WsaF/tgC6mnPaeOmh6f1FlmfVCyxDO0230H1fwsbfjs5FIibDP0a7OM3p
	w7OBdaDY1iTaZIRfil+j/MeynCZJZYd3wYGd8FUUn1w6slU+L8re/vBYcO5lzLKySrisEZSFY16
	PJys12cl2Ef1U8qvbcpr/y6rD5KxF3TxRLYMrWsesqIZ6YEqt46bVtV5rsDSN36/bFDHndYwI9G
	ancvROdrERIm+v3ZPMkBYRQv6Okatm1UI8R2ghq5JEus2C1IQw1+8J5rAGz2tSpCNq1FTqY/sTu
	py3q/13eNXe2YZI9ePphM
X-Received: by 2002:a05:6830:398b:b0:7f8:4ebe:2854 with SMTP id 46e09a7af769-82046ebb400mr4300712a34.4.1790827979789;
        Wed, 30 Sep 2026 21:12:59 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212af3c1ecsm1708657a34.21.2026.09.30.21.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:12:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 22:12:50 -0600
Subject: [PATCH net-next v4 2/4] net: stmmac: pass the desired EST enable
 state to est_configure()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-stmmac-est-reapply-after-open-v4-2-9d4366587b73@gmail.com>
References: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
In-Reply-To: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Pass the desired EST enable state explicitly to est_configure() instead
of having it derive the EEST/EST_INT_EN bits from cfg->enable. This
decouples the hardware programming state from the priv->est.enable
flag, which records whether the taprio offload is attached.

No functional change intended: the callers keep toggling
priv->est.enable around the EST programming, as before.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index a8a5c8fdd5ed..1fd9f1ab316e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -617,7 +617,7 @@ struct stmmac_mmc_ops {
 
 struct stmmac_est_ops {
 	int (*configure)(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate);
+			 unsigned int ptp_rate, bool enable);
 	void (*irq_status)(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index afc516059b89..f15d4d046aa7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -26,7 +26,7 @@ static int est_write(void __iomem *est_addr, u32 reg, u32 val, bool gcl)
 }
 
 static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate)
+			 unsigned int ptp_rate, bool enable)
 {
 	void __iomem *est_addr = priv->estaddr;
 	int i, ret = 0;
@@ -62,7 +62,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
 			 EST_GMAC5_PTOV_SHIFT;
 	}
-	if (cfg->enable)
+	if (enable)
 		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;
 	else
 		ctrl &= ~EST_EEST;
@@ -70,7 +70,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	writel(ctrl, est_addr + EST_CONTROL);
 
 	/* Configure EST interrupt */
-	if (cfg->enable)
+	if (enable)
 		ctrl = EST_IECGCE | EST_IEHS | EST_IEHF | EST_IEBE | EST_IECC;
 	else
 		ctrl = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 2a4099fe470c..64d890664421 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -74,7 +74,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->est.enable = false;
 		stmmac_est_configure(priv, priv, &priv->est,
-				     priv->plat->clk_ptp_rate);
+				     priv->plat->clk_ptp_rate, false);
 		mutex_unlock(&priv->est_lock);
 	}
 
@@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->est.btr[1] = (u32)time.tv_sec;
 		priv->est.enable = true;
 		ret = stmmac_est_configure(priv, priv, &priv->est,
-					   priv->plat->clk_ptp_rate);
+					   priv->plat->clk_ptp_rate, true);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 357d1eaf0d7d..67c6fc32d0ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1082,7 +1082,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	ret = stmmac_est_configure(priv, priv, &priv->est,
-				   priv->plat->clk_ptp_rate);
+				   priv->plat->clk_ptp_rate, true);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
@@ -1100,7 +1100,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	mutex_lock(&priv->est_lock);
 	priv->est.enable = false;
 	stmmac_est_configure(priv, priv, &priv->est,
-			     priv->plat->clk_ptp_rate);
+			     priv->plat->clk_ptp_rate, false);
 	/* Reset taprio status */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		priv->xstats.max_sdu_txq_drop[i] = 0;

-- 
2.53.0

