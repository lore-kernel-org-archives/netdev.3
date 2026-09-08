Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4C256C8B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882632; cv=none; b=IutP/HMVVe30lrCOz9F15i0CIBiqAJsWctTK/hFL7T1Dbdfcs/LrLBkEtCpz3zwuJkFhfr0iEjkdz0iY0+e+GLul6WD4y56y/dcfpdTENVQ0LEBLziJaQXIw4JnGBnPYclxNtR0SXkUB1qyLuJHnaKEAJUzFOZkuG30j+XZrCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882632; c=relaxed/simple;
	bh=AO8jbCqRGqa7sYqY78Ys1LVFR8qXYfbR5sl4AAANYm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNofqwtcMdT/+ooihdCtXz5nM28Mq53T64XkrHAAsXJCY0FbpXnCQtoD6hO4m1D8xzqNZPm2V5qNMibYUJ0t74KzhXFZ8bls4XJCAWFk4WOTB3qVJB+2VnKFW9HEHpI2Q2EpSXiSwoDoRU29/xKEpNPwmPb6WoXTIU7erFnbVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=J75/Mn5z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="J75/Mn5z"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so5473041f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788882629; x=1789487429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGzVjmMWV/Zxl5ybnbzicMVAOKBnIO6SbIFF9Rur74Q=;
        b=J75/Mn5z2Fs/wLuV2KwRnb3XoQQ6crGqskO/W5DNmjJU0HtMZjQ9s+AiU2VEIVwUSC
         EwpBcY+fkMHgzVLnY+bEn/cCdmj+1nOGiGKe5eKd7ZOpHXSezhY9Bi0CWy/ffQlFpfFx
         S5ZF6SGY44jRNx8HKpDl0rch21tSaGIbi2C9n4t2z6bqkfQCCrLeY4gwE2uOhhyiON80
         /ho0emsRm5P6bid1wAdfsfZV1pYF6PG/idBhkjJbNtg23HtRdxkZgjKHPWsMwbiMxema
         +uoYcttwpZ+Oo+4Cy30ZIu5n6la2TYRsB2J3/3PmjUOXSHsoagrmFEZCfmM1CfLwJITP
         wiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882629; x=1789487429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nGzVjmMWV/Zxl5ybnbzicMVAOKBnIO6SbIFF9Rur74Q=;
        b=r/CdpBbpH8bPtcigZzQ7VDiv0GnrGXZkFpEXb1Ioie2ZcqkiW5TisvThu6TS1WAclW
         h7kmVAjPfyuF+J0wzWhbUE9og2QLh8rgIjFmY3381+GZ3B/V01z0pCtGBE6gCDMZmsCM
         aQnrkMken0VWfbwxK+V8vKXZadWFmAYv0/uu1+Wc3qkZnjSQBGAprpK4ej2fuEOoINQT
         phrjzYUQa4QxzQOpCsYlnMwfrEMaYxhpndJhzr7dlBpF7OaNLpMtIC6pMkD1Wd+X+BRE
         7dPBsYS98xreWGZI4lnLBFteQIKRNYL74T8ajvH4KbJtvC2Et/Y9p2A3u0Uanr39d+nV
         a/aQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWBK1nVwU2DrIKT77DTQTHwd06/5ldSgYdT8c8/7tZINmVpKepFjo07FyC0J6r/HipjtuB00c=@vger.kernel.org
X-Gm-Message-State: AFuF++ld37je3xFQjTNHiqu+Azg1R2hvbiTf2qBuBY5eNshptPCiy75T
	Cr6SuYlRBDA1yozHeSVg9bM76aEHIs+jT1zYZbl0N8ihcgiXQpzmBi5dE1ITh/knX5I=
X-Gm-Gg: AYBFou2LK7WQ26Sxl7jmvS97Fvnxs3t72854mDS/5Sww4B0XxYKzJ7jiDCvSbsHDjVm
	415QDD3UcUtah4UmCJFbQOYL7j1Btu8m8R8GfWC27Q3SLD4uhMW8HUtWRbY413WqnwRO0HiTPPV
	2zF3GkW78xLUtskBJzurkm5fcJwpdp6/d5asf0vsPvZmGbrxEnD+PL6NGN7zEBiLCMVnubWigjL
	OiGmVuxjceBeteJmy44cTVgeiiIjnKqdLbEaLfaXFCdJcJX1VcJCmi5bbJ4YOktKIxLu1ju2RD9
	zXTW+LKDFq7NA5bL4E3vwAOaLENAc3IXnT/IseMURe2aXLmruitchrH1e2bRuk2hP225bqo7Pre
	BpIRHUN/Bimc5r756RZjKadtMG1OKFMol6SuWuTUU77cEGiFhlJCAZmLdxoZVdZvNAAI1bhH/8T
	lD0omtEXfCPLNtcZArpRV+lCu2oEfd/s92hhI1x1c=
X-Received: by 2002:a05:6000:288e:b0:485:8c16:a33f with SMTP id ffacd0b85a97d-4858c16a5d0mr27539885f8f.52.1788882629019;
        Tue, 08 Sep 2026 08:50:29 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm40869652f8f.33.2026.09.08.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:50:28 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v6 1/2] net: phylink: unwind the PHY binding when bringup fails late
Date: Tue,  8 Sep 2026 15:50:24 +0000
Message-ID: <20260908155025.4155289-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908155025.4155289-1-f@lex.la>
References: <20260908155025.4155289-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_bringup_phy() records the PHY in pl->phydev before its last
fallible step: on a MAC whose phylink ops implement LPI,
phy_eee_rx_clock_stop() can fail with a real MDIO error. The callers
unwind with phy_detach(), which knows nothing about pl->phydev, so a
pointer to a PHY that is no longer attached outlives the failed
connect.

What that costs depends on how the caller got here.
phylink_connect_phy() and the SFP path go through
phylink_attach_phy(), which refuses to attach while pl->phydev is set
and turns a transient MDIO error into a permanent -EBUSY.
phylink_fwnode_phy_connect() has no such check, so a later connect
overwrites the stale pointer and hides the problem. A disconnect does
not: phylink_disconnect_phy() hands that pointer to phy_disconnect(),
and the second phy_detach() on the same PHY drops references the first
one already released.

Clear the binding on the failure path. This is the same operation
phylink_disconnect_phy() performs, so both now share a helper. The
PHY-side fields are left to phy_detach(), which every caller already
runs on this path.

Fixes: 03abf2a7c654 ("net: phylink: add EEE management")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phylink.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3ec3bb439109..6a92fac58f25 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2083,6 +2083,18 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 	return phylink_validate(pl, supported, state);
 }
 
+/* Disassociate @phy from @pl. Caller must hold pl->phydev_mutex. */
+static void phylink_clear_phydev(struct phylink *pl, struct phy_device *phy)
+{
+	mutex_lock(&phy->lock);
+	mutex_lock(&pl->state_mutex);
+	pl->phydev = NULL;
+	pl->phy_enable_tx_lpi = false;
+	pl->mac_tx_clk_stop = false;
+	mutex_unlock(&pl->state_mutex);
+	mutex_unlock(&phy->lock);
+}
+
 static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 			       phy_interface_t interface)
 {
@@ -2197,6 +2209,12 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	if (ret == 0 && phy_interrupt_is_valid(phy))
 		phy_request_interrupt(phy);
 
+	if (ret) {
+		mutex_lock(&pl->phydev_mutex);
+		phylink_clear_phydev(pl, phy);
+		mutex_unlock(&pl->phydev_mutex);
+	}
+
 	return ret;
 }
 
@@ -2347,15 +2365,8 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
-	if (phy) {
-		mutex_lock(&phy->lock);
-		mutex_lock(&pl->state_mutex);
-		pl->phydev = NULL;
-		pl->phy_enable_tx_lpi = false;
-		pl->mac_tx_clk_stop = false;
-		mutex_unlock(&pl->state_mutex);
-		mutex_unlock(&phy->lock);
-	}
+	if (phy)
+		phylink_clear_phydev(pl, phy);
 	mutex_unlock(&pl->phydev_mutex);
 
 	if (phy) {
-- 
2.53.0

