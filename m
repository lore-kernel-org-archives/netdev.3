Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDB3C13E6
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716810; cv=none; b=kX0To5pcIAmHXLCbVk9C+itoCZVyNEcaVvYjj++lrv5wtuuKLipdSTDJXpHFAUZEbQ6AwikpaWzZ5EK42qbV+zqr9lNq7mwlaUF/CapSejXGd3fUVDTa561myUpO7ebaYiFKuDY+Nwq66colrx1ZNwzqDaaprY3QXxCdyvzmK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716810; c=relaxed/simple;
	bh=AO8jbCqRGqa7sYqY78Ys1LVFR8qXYfbR5sl4AAANYm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFuD4l4432+GfXwkYKtgXLRctHerMVTBPHlE4NWyVLvn1peMEkQmf31f0oyBX6+VTXBhdU5741N+koQCD1KmGOGUvIkXeNd39yuM1VWjS9gYoZb8Xbm6qNIrjcAc2+mn9wIIT3A/5tfP9l5mk++KGMQeVkaXJhhBgSo/twOa38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=kXlXNUnR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="kXlXNUnR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso22351285e9.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788716807; x=1789321607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGzVjmMWV/Zxl5ybnbzicMVAOKBnIO6SbIFF9Rur74Q=;
        b=kXlXNUnR6OmMGRLu14MeTYOqVf6yLahxfIQdjoSDUVatGokIbXChLQUqFhsLK/2b4G
         ZbtdiOj/FeRPXHyX1cbQ7c+5RXORbrYiFEuLY1d62NUXVb4knVyapLlKUHS8XwC3mTFv
         vAZNd4lZlrfs0jQrORSpq1yGKTYyXcteXyJNZ/7IWBoEBFTXKBBI/ajkNHYPWoKbNFC0
         IN0eSDl/kskXGEfBhA2/0Mq11uGlr6tlLrtmI7jrF+yM9tZAqpquAcHD0hS/QjM7bQUt
         HSChqB127HbRVnulXSnwlp9W8YR4uPJtr1end3VXEV5ZpP1Ovkh0ykI6qA8J53crg2O+
         qWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788716807; x=1789321607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nGzVjmMWV/Zxl5ybnbzicMVAOKBnIO6SbIFF9Rur74Q=;
        b=ixrCU3zAX2yltH/BrMGnLJPosSa7R7VgGftiSyFCnDprdE/BbhjmsbWDbSG3Rl+83E
         yjgMf1oyc8YXgXzN6+oSPbzSoNIQasj9igZg9U0ulbVvaW9AS2UBWY7Si60J+0Lq4Wpn
         KjANtYwlIallFAx5rldImZIN1D7VJs26TLGiAJLUPwDzFl5ppNP5qDIlzma3dHH+hJ1w
         K838KOTTCtDbSCvX0BBkt8PMq5nspbpaClxF7iLgiDOoZ8Y31rC6QnlMh33bFtd6W5Om
         0rY1wpg1tCS0hKvIeFkko2OipT+DtYsOFlvkbeDIyEmBCOEGKK+5N+H0o0zZgtgdT61/
         iqFA==
X-Forwarded-Encrypted: i=1; AKwUvBzOy63KvAHcuUzKzZrhSqtlcR+HLEafVvZoEj0xhX8YV2RE+JbaQHtIeXIwjF3Gu6QS1sP7c/E=@vger.kernel.org
X-Gm-Message-State: AFuF++m1LXZCyOs3Wv+4o3jrJQqF3KKI7nmvvzZRE4F7M2HCaU85nVil
	PB6T1k8s1FVfSO/sQ2glBzTvtI6rowL5E25sX74+ridn6vRymXehHy677Yt36QXALjw=
X-Gm-Gg: AYBFou1O6ySLwMHd0eRyo+1zsmFZgtuDSubonnIt6sHTnWgZUXPFB7LOIdXbLlQ5M6m
	xEl3vdZX4iWbUYyaU0WPqvt1T3kz52MV1hjwH/tvHAVMssUz8aNUcHXq/tl8jIySh1TpN7gVq3m
	1gBFkxUEQ/gJE4fG75TGvpvEhf95+1C6j2JoudHyw/QVkkMAMtIa1VruaNzS2wWpX4Wpj7LjUkb
	wpvf1havLU0VNupXmoVPpI0g6lPDCcs1hrQ7cGVSUoiGhbqMz3Q0mNFgKZzMf5H/bRpIeRlWskW
	eQi0HhVLqizuWsalVzxqI0V+W6KLO6O/Fn7okCe9kgzQUroXivptZ90vPrti0VDLx/6m5Ua7YOB
	Yx3EzjWjmjxvR+rVixo9yzU/dqqwG+FjMS/UeFK8MI4m48/4lllRZCkPZWG4CkfGPGGE2/XcDD5
	xUb5mO1QS+yUVi1oh54cEnzGNJIj8Wm3TJatiuFkc=
X-Received: by 2002:a05:600c:1986:b0:49c:fa21:e744 with SMTP id 5b1f17b1804b1-49cfa21e906mr149680275e9.26.1788716806715;
        Sun, 06 Sep 2026 10:46:46 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6158e9sm331552855e9.12.2026.09.06.10.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:46:46 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/2] net: phylink: unwind the PHY binding when bringup fails late
Date: Sun,  6 Sep 2026 17:46:42 +0000
Message-ID: <20260906174643.4107607-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906174643.4107607-1-f@lex.la>
References: <20260906174643.4107607-1-f@lex.la>
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

