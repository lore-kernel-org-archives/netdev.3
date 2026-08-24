Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91CC372ED7
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539249; cv=none; b=PvQqhupKiKozCPEgSTiLj7ZOWSO0n6oMUnX0AjDBlwh08QE4wTwQUX+eGdEkv14KpPqemcrNpjq36F1apchPNvrUZONVu8dHTFF9AC0+yXTL9IShc+LgxYhM9KdrTl43VPsogoJnDh8ME1yV85BEJemTGByjxof82lCRsnOToiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539249; c=relaxed/simple;
	bh=+3Wg4hev+RdHrstqfxAhur7flQ+aLkM6Csxu2Qs/c+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg+D0ee2N+RZR5vDgvdzS+pDXZXAhToapXc+WFTT6eeM1ql8H5nqHy3Rh4ZzX0gg/v5Tkj57sSWnn+0bWBtOW5AW/7BH399bpyxOxI3vD0a3yIzfvt52zU3+EDBbS/xdA5vtxIipsR/hNFC5jUrhhYK9Da9UkvG18M43yxQJ9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=hoaR3SL1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="hoaR3SL1"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so522977666b.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787539240; x=1788144040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcLtMagmgkZbYwvDV0YgYY3BoJUyu7By6WJbKfTcwDY=;
        b=hoaR3SL1Ww1/mQRiIW6LS81s/G9uB68JMqWDoUUbSe8mbkRa2SvHQl2Q0wmGzhQb45
         qe6QNSoUeUjG26vBliBqpmownUa8g8bEcD/0IwkbQctugivA4cerBAGVDdkOKW2sNXPM
         z3ZDOf+rv4F8tIeJWKjFS5n/57SNe1zErVUrHP5caWMLRcRaAL14GFkyVCKHGcp6jp4s
         4fkUXGRrFJrQbekt1QwC50zdZ29hT7gGRJGVgyDI/W0GmvxOXOqkWPY+i5Qt1IhoYc7R
         R1HLdDCpkWLS7s0uRSIeimnJsa91adebE8R/zLc3435J2M8zv1HIeHU8S9noY8b9Gyr2
         Jbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539240; x=1788144040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcLtMagmgkZbYwvDV0YgYY3BoJUyu7By6WJbKfTcwDY=;
        b=JrCwg+sJFbYmfYs/3JZyOSXkW4EfV5SKBtYwP2M/EcUEOmr5/OkrqpTSuumz08xaib
         EAVyc2GZRiMBQuR5sLsE8TV2veuCuaKp+tehsp72ZtTVhYg/YxP51GRiuLQD19zh8PWD
         r+1VlhJM4DknQCkK1pNxfwjzJkwWuhCpnHd/dJIf2LjWOzo8kII0th4ciPEkilrOEJs3
         J7vNqkKfqTQhkZZA4n5/N5Q35N7euTCudyoLejawBApYPZpawW4G/8VaBDHikUILvURa
         1RnamgtPWuS7n/D1jW12VD1oZOw3PnEqKIytpmZ9Fu2LSH5SZk8UWKUBNZYgcxb3ihHt
         EN1g==
X-Forwarded-Encrypted: i=1; AHgh+RoIcMqtdlKm3FUGCM3Viu4z4h32MYoiC6eaAWUA50vL2Y3Bb/qKdYecTsTRRtZ0Z15/DyT/ycY=@vger.kernel.org
X-Gm-Message-State: AFuF++mztJ+lkgZD9T+s5ANLq3uX1ENtvT0WOOEgvQSpA0R0CVYcDvJk
	rN94wvmeOzeDcpP13I/P8tRGl/mymLnGKNFy3beeWNnNUQ71g96ZzD9BT6FzIep3b/Q=
X-Gm-Gg: AR+sD10eVHP4HsomrlNmlxmeZ/RNIYOnuEWwqsUsVO5j0YP8kf+Eh4M3WCf6skB0bwc
	56+bWKk7oHRpNjEKAXKYJZu/yMNTpBO1A5i+BG8R2s1iid9WZGf1HfgfVp1vp3Kr0G3/XnE44Bt
	FLOFeBVAnGbG+sZo0TPIxtEWmbgSIAT2UhQkyxyMRYD0HQiuwZE0ysPnOAOgK+NIuOgvOUfRUy3
	1rWXZFGxT1INNOhflR4q6AX+VG1kCePaXTl9GZq/+WshWg5buP3aLSMvkYQe/+a2sufx7mYJlp1
	wuefyTxsAYXsKhHGrObgUXcL8QxK5R7Y/DtUAIQGucgcnq4FXzCsl1eYHUes9oNcv02Ly+STUys
	2UclbpWzfN5EfiqTotxBAlHxk/XdZVf0LG82HRP5Y+eu1d2KwfaYG4eIwWRWUymKb+lxgVaXWNm
	aP5DUSqqj24EDnpur273paGmw6Nnv+vJJ+5LB+FEC3TqI/z8fRgA4yj2KK
X-Received: by 2002:a17:907:a089:b0:c21:450d:cd88 with SMTP id a640c23a62f3a-c24924b8000mr1721172966b.6.1787539240649;
        Sun, 23 Aug 2026 19:40:40 -0700 (PDT)
Received: from ownbook ([195.181.160.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f8f2asm1051909566b.36.2026.08.23.19.40.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:40:40 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] net: phylink: unwind the PHY binding when bringup fails late
Date: Mon, 24 Aug 2026 05:40:27 +0300
Message-ID: <20260824024029.41310-2-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824024029.41310-1-f@lex.la>
References: <20260824024029.41310-1-f@lex.la>
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

