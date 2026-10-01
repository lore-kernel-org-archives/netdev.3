Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05337F314
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859699; cv=none; b=r3ii+duzxNx7VPbbuso8QPiRjTNULmaoLiUundE57T7CAmTJmsNrj1tB4864VR/kYNnFljWHis+WHwGNotDYVGYyGfj2Y4SALd47jUuDkPRJWlcAI7MYpkPmzNoqlQzDAYwjIo+C68ojSGqkdmcELO652/FhHdHbUcQRn6s9DGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859699; c=relaxed/simple;
	bh=WHpk82mUkFB2vFnh1LFkpQWBemM5hnwuR05PHM6vFc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn1akhvb5ka298v79xRwtMOv7USj8bj+Bq91YcDo8lqLgrVgUtnUs8BFgipLb83Noed5XyYDdqhQOmRd3uApAmz4RU2bCvH+BBL6mr9H4bAfKBld/ENQSy5mcm1H7C8/wSzAOhgiK60BaLxnbHs1Q8kEbPw9xgFwOkOtnH2bqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Z6EiuEca; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Z6EiuEca"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso67012705e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859695; x=1791464495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MTePdzM4ES1ZVqpNwvykJX5M77gzZebHIMSDcsk0XLE=;
        b=Z6EiuEcapC3x9+XHS8KBx7A5ap2OFP3A/s2ykl3BefCYIcu5IFsqsWBqL/tcho4hcg
         5QYlSbP53vEVXcRUmMagDpWOH9w36W6Bcvoumy1Btq83UTDN2TbGSc2g99da5XpC04yN
         F8CRPuiz8YGLnPQv4CuhIme6CjuZsqmOnQf4oG6Qd+aFyPz6iBR8FCtBrPFGZ2xvrVKb
         gt131JkPisKU2atctjXRUZ5THknxdOOcdpPOuHh8MkMS+p9ZQNLF18TrY3+X2iya3O9v
         ntYUESD7Y35fDOilArjqCRAoWcR40IziyWOUjCc3SVnSnw9GfcohXG0Jx7zOmLtf8aAL
         COwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859695; x=1791464495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MTePdzM4ES1ZVqpNwvykJX5M77gzZebHIMSDcsk0XLE=;
        b=CREaTyz5PFMXV9Kemn/GrTRpD3AxNLczGOJcN3JJ0cTHESwAQstQYui2HAFhgiOdkk
         Gqu+ItZ3gWCAE/5mBNbQ/LfKHi58etAYZThPl36xJExlna5hkWqOfGFF3PQZvOjZi0V7
         Pc9DN1T5jINJCf4aT2lu7r05eKG9LbiBPbKUGpspvgU2kYwJuCID9wcxx1iAiYHC/Emo
         noUbvs50NJJ+/dEFVV91AzOvPSfJ0mBRcK+Tbfyo46mw0Tj3AFJfUhZ+13vWHWceIaZg
         REmjZxJZOu5cgti4BDrq1zPQZH54+AZWbF/kG/mOM3VvMwYW8fv55o9OySkZ1Bu9S5oB
         clAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGxExGhGqCt8eb6LbC14IWgXZBvAI+OFhQzNPzw5FE+qhLuCxA0CTc4egLcTvRTgdy9Yyo4lg=@vger.kernel.org
X-Gm-Message-State: AFuF++lvIT0AEjgRhTsIXYIK21S41TjJ3l3FdoW4XVGETQsmhO2Csst3
	po0+sw5nKzG92QyEHEBsmJWAvmvoBS+zM2v0Y07/TyhohUHytnTXcQ70xnum7Gp4YCk=
X-Gm-Gg: AYBFou3ZAunKNxGaQqgaUUYcqTBOdArEO1bgtEjmBJctDbJ+S+bEKq5nkXmoDLK+0FL
	c/tHacZGgxK/wXqbTzKZdRDmwVkw1PxJTJPSsWvuScsoSx1K8dwWoRvIdJYZd1jYP+cpU3HPfVA
	eokm+4v0cG6gVm5MrzRmA3IeO3EKdddbhntQKOmUYXg/T+zrC/824BDylKFJFtFs0FQ0lOO9olR
	xFYGcwY47JWm7I9Wt/z5+fhR4LtNL32lgifekvnY9E2Ww9HVf6dA1H/eV8jdYwx22Vgqwy++XNN
	3TGQKzOnePO4HKaj1szsmorgoIQjfMxgjJpr0ueC2mbmDkA8GNG9AoDkEJ1I1agp4lc5XPCC1/B
	hFhvV6I6IzkfGgjM0VPfD+XKmXXgfly4/RAjnpuJn7NhzqhQeM93IVg4p9soENwdOkcgbMDBtxC
	Ohm7ICXfSQ2EPY31ij73nPALzveLNtSGJZLzRo1d6RZUtcAOA/Gw==
X-Received: by 2002:a05:600c:8b88:b0:4a0:62d:4424 with SMTP id 5b1f17b1804b1-4a01addebd5mr71063345e9.8.1790859695457;
        Thu, 01 Oct 2026 06:01:35 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99b113sm77732245e9.14.2026.10.01.06.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:01:34 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v4 4/4] net: phy: make an unbind wait for the attached consumer to detach
Date: Thu,  1 Oct 2026 16:01:20 +0300
Message-ID: <20261001130120.104628-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001130120.104628-1-f@lex.la>
References: <20261001130120.104628-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With attach serialised against unbind, the unbind that loses the race
waits for the attach and then removes the driver from a PHY that is now
attached. phylink uses phydev->drv right after the attach returns, and
phylib uses it again in later phy_start(), phy_stop() and state machine
runs.

Found on the same KN-1012 by repeating the wan race on a kernel with
the previous patch. The attach completed, the unbind then removed the
driver, and phylink faulted one frame up:

  Unable to handle kernel access to user memory outside uaccess
  routines at virtual address 00000000000000a0
  Comm: ip
  Call trace:
   phylink_bringup_phy+0x680/0x784 (P)
   phylink_fwnode_phy_connect+0x1b8/0x27c
   phylink_of_phy_connect+0x18/0x20
   mtk_open+0x38/0xb70

A DSA port gets there without any race, and did on the same board
before this series: unbinding the lan4 PHY driver returns at once, and
with lan4 up, tearing the switch down later faults in
_phy_state_machine(), called by phy_stop() from dsa_user_close().

The driver core gives a driver no way to refuse an unbind, so make
phy_remove() wait until phy_detach() has run. An unbind of a PHY in use
now blocks until the consumer lets go: ifdown for a MAC that connects
in ndo_open, the switch teardown for DSA, which connects at probe.

Deleting the PHY device through phy_device_remove(), as
mdiobus_unregister() does, keeps today's behaviour and does not wait,
and it releases an unbind that is already waiting. Some MAC drivers
unregister their MDIO bus with the PHY still attached and never detach
it (greth), so waiting there would hang their removal for good.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes in v4:
- Rebased on net-next. A line over 80 columns wrapped.

 drivers/net/phy/phy_device.c | 22 ++++++++++++++++++++++
 include/linux/phy.h          |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 544b2da6a1d9..8a7cd53f9a14 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1065,6 +1065,13 @@ void phy_device_remove(struct phy_device *phydev)
 	unregister_mii_timestamper(phydev->mii_ts);
 	pse_control_put(phydev->psec);
 
+	mutex_lock(&phydev->bind_lock);
+	phydev->removing = true;
+	mutex_unlock(&phydev->bind_lock);
+	/* Order the store before waking an unbind waiting in phy_remove() */
+	smp_mb();
+	wake_up_var(&phydev->attached);
+
 	device_del(&phydev->mdio.dev);
 
 	/* Assert the reset signal */
@@ -1737,6 +1744,8 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 	module_put(phydev->drv_owner);
 	phydev->drv_owner = NULL;
 
+	store_release_wake_up(&phydev->attached, false);
+
 	/* If the device had no specific driver before (i.e. - it
 	 * was using the generic driver), we unbind the device
 	 * from the generic driver so that there's a chance a
@@ -1940,6 +1949,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phy_resume(phydev);
 
+	phydev->attached = true;
 	mutex_unlock(&phydev->bind_lock);
 
 	/**
@@ -3843,11 +3853,23 @@ static int phy_probe(struct device *dev)
 static int phy_remove(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
+	bool attached;
 
 	mutex_lock(&phydev->bind_lock);
 	phydev->bound = false;
+	attached = phydev->attached && !phydev->removing;
 	mutex_unlock(&phydev->bind_lock);
 
+	/* The driver core cannot refuse an unbind, and the consumer keeps
+	 * using phydev->drv until it detaches.
+	 */
+	if (attached) {
+		phydev_warn(phydev, "unbind waits for the PHY to be detached\n");
+		wait_var_event(&phydev->attached,
+			       !READ_ONCE(phydev->attached) ||
+			       READ_ONCE(phydev->removing));
+	}
+
 	cancel_delayed_work_sync(&phydev->state_queue);
 
 	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3881a4651da0..1b7e7bf124cc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -673,6 +673,8 @@ struct phy_oatc14_sqi_capability {
  * @lock:  Mutex for serialization access to PHY
  * @bind_lock: Serialises attach and detach with driver bind and unbind
  * @bound: A driver has finished probing and is not being removed
+ * @attached: phy_attach_direct() succeeded and phy_detach() has not run
+ * @removing: phy_device_remove() is deleting the device
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -807,6 +809,8 @@ struct phy_device {
 	/* Protects bound */
 	struct mutex bind_lock;
 	bool bound;
+	bool attached;
+	bool removing;
 
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;
-- 
2.53.0

