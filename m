Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253C351C25
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865406; cv=none; b=r6oX/w0HSF9A7E1gWTx7Osxovq5AKvMQ7xakZmXL9Rlu2VpGsYFNdpnWIdw0BSbxwUN6FmAk6hR9qT2jXbCMh3imJi0QxHpldjq9VvpQmKnxV9G5gD7QZ289wdPudzlRwGwJN0RXe4/QbvFxWOFPrH7oswno4Rerndgt8n8ZfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865406; c=relaxed/simple;
	bh=8OOocvXC8LP6o3jAGo+TyFH1e88QG6h+jhSfcp4tMUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRvmvkqWpBhEZNfGFVzh6X+X8puNL5jhrx+mB0zHmHRKFtKlFJ9jnMSKB7JWDEQgpd1eaSuiHKBDp2hUCU6iaZdvYjsv9UlsjuXL30dwdg4yqUBUZ6Cdf98ECYQ74vW+Or+zOPbEJWvChi+rlUfD8WltJr0v2THCMsW+HzjS5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=YCoXGtSA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="YCoXGtSA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so2320885e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787865403; x=1788470203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4jRBlKg/XoLKKaAI25ceUVYZs1W/kkw7dO9eH42sTk=;
        b=YCoXGtSAxVvi9s4fmULV2QPD13TthhkPrCVW1a8rGQbwUI+9JIDwccS6EjTrPq3885
         rsRJ8264tohXlSd6y+SfMyEzSEdFVnvzPcVrRdkKH4TM6kjQk7T8QV24AEu7JKXeLWxh
         C4bgZMjKraJLeiHWbk30yV5ctnYV00HRpwESj4IBSeVCOkn/UQUyHXRkYLA41qTiGzyb
         D/u3igWJDP569YQ02A6EGVhC6eEiJ/P/qkKUmvx1hRWeqZsU5mDShoZeiEDzHzJ7Pn0f
         1yK0M0e0GiYcdTYJZNKERkCrPntDjgLlrwyZQnatNf/qGofdlE6o8lo/vYhIj57+DbGw
         9wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787865403; x=1788470203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j4jRBlKg/XoLKKaAI25ceUVYZs1W/kkw7dO9eH42sTk=;
        b=DRf+SDvzZBJhm58zCSIKGGrQNmA152dqb49wI7lMFMklVYhNDbz7PM5asp2AiUjfNN
         9tEWWeD3sitw5toTjHridv1oLThxY9fdkWnQTL7UskCTgOgCgk39KbCe4rUKtpRvnCWe
         x1ouEFUwnhSi7iMK4maRxTjkIq54GsXdIB5AR88pth81y898657+mVN7gVIWN4FnheiL
         NOHQOyRjtBR35v7p/+GRyqmH4We5EBczri4FCjCrIdt2fZcjF+KYq4Ivv9kEn0bj6Bfd
         rVy6hIUmo8Nt7R7TwcXRwBnvHI6NSbsx2O0vMq/1WBccAnDAn2p4UAPebJyZHPMWYcvg
         viKg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7i/paZ3ZSsKF/l5U3L7Hl2i5M5pc5lUcGfyK4UZEdMGRW87ucGsvGqiwv1FZO0pXBnO+zLe8=@vger.kernel.org
X-Gm-Message-State: AFuF++k5VuIegHVg3oYQJS5Sc3R2mCVGpwCQ487iQuyR8uK/xpTa05vU
	AY2LN3pv0hpSNxtd/H2hXQl7945f0Nr3/vKbiIr0F3KyWwwWqEJ9u95baGYk6GRSRQo=
X-Gm-Gg: AR+sD13vHI2j7Y7M3ixawLIYSwH0vWbAoigX8EmeyewxE5su/RJVKEaDZEGCTQQBEfI
	JEz7hSLEu2Eol7T70HDZRCwEVsjJCgrB4olgSbRyQz2pq0adY8xhaEl0Ghj9jyiOSMWjHQJSWS5
	6nWysoXfNr4Vg20wHKNb4f5VYogM1SGIe8rJGZMgwv6yrlt6dPcmqXIVUhc1lkSorCacDD8Gi5q
	HKlEVamBAVHzDa5iAlYmbzpj6TPXKIrgYC8ZjGjugLerpmlppHhaPXNJaXw03U+esjS88qlSdIF
	QN7pbPLhyN3tkAOJDNRknQopxrz0ja9NXnVDQFjedw6EPY1w7mcq1H/zo6e8QbFW45QPu9BVyP3
	DZup0I6TRN/V9uj29g52CaZ3Ycf21bkn1kdR9axFafSNjXxMi7HCEPOrkZBrYR3ngm+GyWDAsir
	Xd7bGw1z86Aog0rCGdz4bA24Tt1we7aJFJgKUM4HtXCZ1T1G1KtGXQqvY=
X-Received: by 2002:a05:600c:3e1b:b0:499:8ae1:b900 with SMTP id 5b1f17b1804b1-49b91c4cb6dmr27314955e9.12.1787865403169;
        Thu, 27 Aug 2026 14:16:43 -0700 (PDT)
Received: from ownbook ([31.146.92.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e4f0c8f7sm11423442f8f.27.2026.08.27.14.16.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 14:16:42 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Aleksei Sviridkin <f@lex.la>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] net: phylink: unwind the PHY binding when bringup fails late
Date: Fri, 28 Aug 2026 00:16:37 +0300
Message-ID: <20260827211638.63395-2-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827211638.63395-1-f@lex.la>
References: <20260827211638.63395-1-f@lex.la>
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
Signed-off-by: Aleksei Sviridkin <f@lex.la>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phylink.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5b8e956902fb..a55e4a64028f 100644
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
2.55.0

