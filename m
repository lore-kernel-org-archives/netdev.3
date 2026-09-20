Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131A2C027F
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789942849; cv=none; b=RkMcstD5nEfXaXEmke5Q0FUcKInI9x2pBIzsGED5OchochYxzcBUxrmjPLEBE/S/DsprdfjTrWs+pijXjzthdtoHyQcYJRVOT5e/NiQb/NLUmvaG7UeTqvB2/gsteDdTSpYHf6rrlA+Z8snpcTZHWrA/tYrvl3bhPX9fEAZBBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789942849; c=relaxed/simple;
	bh=jJ3QwRlnW9Vwxdw/1S6Y7JDhcY1bvzYCsw4DmV5r+oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRqem970kkBHPpCDC65FKV99H0LhjfH/GUteP3ZmYxgKHIXYcJs3D/2PVo2Zr0cpyytwKXV30JRkCzrd3dP9YbE3lMPolj7pu3w+JvMRcWg70h4B+Rm5UOFK3Ihx/hnnOy9fyRNRHVsufEohqEglcoYrZrnhKhW0QPothqareN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=eON9T0uw; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="eON9T0uw"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so16016315e9.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789942846; x=1790547646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGgXUYgvHQ8Fg6J9+hUTqNq3sfh9W+ZtLaGrZCtz8oM=;
        b=eON9T0uw58DwSzmxG8iYTVsCs5oP2u0/q/xiJN9o5v6B7YBGjHPMVkpD9CHJH6Bxkr
         gItjSqG/CgYzouWv8jJYHSZ07x4M6Lq2q7y0ANRvQbRlHewrHmXTQR14EYa+6TLZhhy9
         WxBHkEz2R5n7/SihMwqmG83bW/t9luT92kaByzicKUxmHWbNK5bqzRKlnuOlOn7wHnZw
         g+DJZJjdoY+vxB62KNcx1+McwlPUmjGb7KvoGNO2Uju7yUkDKygKRBoa0gH7wrUTRfsw
         sC6Zg4ViB1lLzgCXYruZ9RXTzebBKyXGYiXuwmM/wENtki8giFFT4FtfUlO1dIFyddfn
         UeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789942846; x=1790547646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGgXUYgvHQ8Fg6J9+hUTqNq3sfh9W+ZtLaGrZCtz8oM=;
        b=RZ3RPfF1e2fgZyTpXIRActkAKyQsaxP0nlrCe5Syad8XIjpHWAP1/rhtB8YTzjx+vP
         Vu5uUeQ0bUDcxEmYPrIaq1fonJwflHd+sGJoZKnpSLa4WKvbOyYLDseuHHJo74/UglE0
         HFY1VnKGgzRszWyAmfl8d9i5GJ6H5m7+IVZGfwdoOXTWsn/TnbYDeSnzXI0eiIvCJgod
         75ADZRk/9w1Pc1j79MyYpblyEVWxSnt/7SOAAQ5xyTNRSC9G1AuphF6xkAA0Lp5/WBR5
         DAHpDbnYfU2FFFvuAf1+NoZmNqhoj9ZY6CSsq5qYZfrRRn9UGy4KvPwBaqQMOC4ylPl7
         n7hw==
X-Gm-Message-State: AFuF++nUJ7wpVyiwV4uXN5f8rIhafmICnXjHC+GIH8TXnhEQr7c2ZJdw
	t+fPjiGt7fRwuah80GGKMP+ViqK4Ue/tpaPUwuZ/v6nTJzuozk0kVr1Y6AAqc8LQY042eCKi71e
	eTzVkrTGXWA==
X-Gm-Gg: AYBFou3MHoCpiE8C8yUd952C/s8mIKE7s51EyQznzJIE/hkCVYUajfrk1VcNISZ+zSl
	2NpwTs0TJogKaBlN0LJkGhEjnfS/XkMyH5tg4QkUdWAbwrY3GkuY6gSvQ9njKuh1L9S78PKlwUU
	4uTUqqSy+eyaM2jEIIcWD7dLRg33vhN/6TwPC7XIA+JEscr2ur94N5X513T8Td/dr3TgwSR732C
	Y3V3UMBRn12zsJRg0VeHMTx1zI7zf+FAN9WgBNx2hLEJ17HhvDBmXcqKGEgyVY8AfafU8hqL+7l
	1sBLZs+oOVwKcGQOPtqJFHViG2yXy79Z8rQOFHEHjtljNYlKtQTnGdf1vld3IhYppkAGzxLwSJr
	PeGaaNhPH7HrrzwmGtb9VKEKzlInMeg838crfj7sudOgBSPrrzC7YkzqCpjWDVQfqNstiRAHbir
	nvS45Bj0FNImEPkv+O7K1OnQYgsZWtY4V06xGHrk2tOiBjFg0Lyg==
X-Received: by 2002:a05:600c:19d1:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49fc5743bc4mr129978595e9.23.1789942846247;
        Sun, 20 Sep 2026 15:20:46 -0700 (PDT)
Received: from remote-01 ([84.17.55.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07411fsm188321175e9.7.2026.09.20.15.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 15:20:45 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v3] net: phylink: record the PHY only once bringup cannot fail
Date: Mon, 21 Sep 2026 01:20:44 +0300
Message-ID: <20260920222044.1752860-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919015338.499611-1-f@lex.la>
References: <20260919015338.499611-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_bringup_phy() stores the PHY in pl->phydev before its last
fallible step: on a MAC whose phylink ops implement LPI,
phy_eee_rx_clock_stop() can fail with a real MDIO error. The callers
unwind with phy_detach(), which knows nothing about pl->phydev, so a
pointer to a PHY that is no longer attached outlives the failed
connect.

What that costs depends on how the caller got here.
phylink_connect_phy() goes through phylink_attach_phy(), which refuses
to attach while pl->phydev is set, turning a transient MDIO error into
a permanent -EBUSY. The SFP path is worse than that: sfp_sm_probe_phy()
answers the failure with phy_device_remove() and phy_device_free(), and
it assigns sfp->mod_phy only past that error return, so nothing clears
pl->phydev and it is left pointing at a freed phy_device that
phylink_resolve() and the ethtool helpers go on reading.
phylink_fwnode_phy_connect() has no such check, so a later connect
overwrites the stale pointer and hides the problem. A disconnect does
not: phylink_disconnect_phy() hands that pointer to phy_disconnect(),
and the second phy_detach() on the same PHY drops references the first
one already released.

Found while making a DSA port survive a PHY whose driver arrives after
the switch probes: keeping the port across a failed connect and
retrying is what makes this window reachable.

Publish the pointer after the last call that can fail instead of
unwinding it afterwards. Nothing between the two points reads
pl->phydev, and the registration that follows cannot fail:
phy_request_interrupt() falls back to polling on its own. The PHY-side
state keeps the order it had, so no MDIO operation moves relative to
another.

Fixes: 03abf2a7c654 ("net: phylink: add EEE management")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes since v2:
- Record the PHY after the last call that can fail, as Andrew suggested,
  which removes the unwind and the helper it shared with
  phylink_disconnect_phy(). The fallible call keeps its place so no MDIO
  operation moves.
- Hardware evidence for the failure this prevents is in the reply to v2.
---
 drivers/net/phy/phylink.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a1458da8111b..1bbcf46c8356 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2129,7 +2129,6 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	mutex_lock(&pl->phydev_mutex);
 	mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
-	pl->phydev = phy;
 	pl->phy_state.interface = interface;
 	pl->phy_state.pause = MLO_PAUSE_NONE;
 	pl->phy_state.speed = SPEED_UNKNOWN;
@@ -2196,10 +2195,25 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 			ret = 0;
 	}
 
-	if (ret == 0 && phy_interrupt_is_valid(phy))
+	if (ret)
+		return ret;
+
+	/* Nothing below can fail, so the PHY can be recorded now. Doing it
+	 * here rather than above keeps a failed bringup from leaving
+	 * pl->phydev pointing at a PHY the caller is about to detach.
+	 */
+	mutex_lock(&pl->phydev_mutex);
+	mutex_lock(&phy->lock);
+	mutex_lock(&pl->state_mutex);
+	pl->phydev = phy;
+	mutex_unlock(&pl->state_mutex);
+	mutex_unlock(&phy->lock);
+	mutex_unlock(&pl->phydev_mutex);
+
+	if (phy_interrupt_is_valid(phy))
 		phy_request_interrupt(phy);
 
-	return ret;
+	return 0;
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
-- 
2.53.0

