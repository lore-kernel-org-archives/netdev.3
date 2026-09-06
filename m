Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B03BC68E
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716755; cv=none; b=AAxGQuyXCBIr6MHibIdEcdSxTooci5Ed9R8MWQLz5alUORDsXHejZhvafVe8Uec2ZU6z12gq34gJJ18e6Y+f4+sP7lZvnOi5tgZVuGSJndqMCJiUJ5xSd8fttRIhmOZDt/rGha/si7zHkCSPLFZ+Br6e0V2QH83k7iCHrDMlMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716755; c=relaxed/simple;
	bh=K244GoaR/SBN1qTkqznMbdB/qRyg1uAQxHof7eZyYLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ggouyb9tGqx5hiq1tb7qsmdVQfMOVGY1+YJG8VymonU7E88MPAi4iC/D0b9HCtI6sU4waS8Znh1Yo2rbwb902PVXyoVgmBeevRrgeDMlkR2qcbpR5tZXn8hitoSS2OtvBALmFs5EL3vtAFh+mmMOzIi5UYzqRnmFQ6cmuX5ULGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=O8BJRkP9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="O8BJRkP9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso24503575e9.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788716752; x=1789321552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwJE/G6DLPhkatwmSaqyq8HEYQKnbZm9tru5auWihS0=;
        b=O8BJRkP9sIQQk3WxhekyRkAbHQKOHvret/kZWdNVQbnn5s0aWvFITSu6ZmeRakwITU
         4/J78UizbB+Duu7rP7ZxtOViWX5gZVOLvh/ozhVsJrIxOveWlgJp6Le7aPPZp6zXNOax
         XeBSs9Fh72JYnd6ST24QN1nkjsden69EYyrDQ0MK+LUYxBjhBR44tcYyDz52wNVVT/Ok
         pym6D8ZsGxtDBtR0kVfbPrSFl09oRuoGKTDKZWLJIYRU2yB1WIGcKTaOEfCZfLnUBhnw
         TvD0efqr8gY2xRQUaUqpQd4NGRndwwYcW2T84Q2u5L7Ypo6hw3nnapdVWlJsu1oCmPc6
         FKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788716752; x=1789321552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwJE/G6DLPhkatwmSaqyq8HEYQKnbZm9tru5auWihS0=;
        b=KazhzqSAx0of6fG9dG6l7Nwc0eZehrZVP0gbnxS55fWYQGVLagmavxLhJipCX+Hw6B
         LQXmrCCIuFYNOJ7dr1sDw/dUiLFLXBBfGFupFG1OE0uldxWsEuy0lyvNmMTeMm3CpbUw
         ndzGT94WuoxVThYgpwpbpzeXSYeu+5rF1iQo4BhawyRndFY63ROO4wTC7ZOHNx7Izc71
         W35SqbHge6XWgZcyQuIIPZkoqlWfXbNT8vRm6GA0Zo4PYRG0PeTDe6ZkSOm7i4UXjxgv
         zKjGNwuCii1ZCA5hQ58Z7jf4AbYbXy4Q8czuPB/IP2EwwKIPcmDlmBU86QJe4y4gSY2E
         Txqg==
X-Forwarded-Encrypted: i=1; AKwUvByE4FSbyY4KkVke31+fk9YP2MTPKclQFUKiajtjouAKhtY3g/JjnkWeOcZYsnWq+Np+ar2Iu4c=@vger.kernel.org
X-Gm-Message-State: AFuF++mymHka06WXTH7dOb4WINNQKF6Xxe2KPkzqfYULBtgu4HvWeePb
	nY0l52Y+qAr7ietWpL19HlBvHnBXHfNNW0Yfm1zU5NtQY4Z9GE9N6Re1OJ9s8y0LWBY=
X-Gm-Gg: AYBFou0DMZ/3Y3cGGKqUm4VmpOvtcv0jFUEsPaIV2GXhlIDOFW4PmjCgdnG6+HZtV9b
	ThVeM0j+NPRZnsOhleZwxXG0umkcpb1N1grst1NRHxugWXUqbS80cw1ky+8LsKFSsh/xhlV06Nk
	0U2EQsW06htY5K61fjnEzK03lkFi/aioksxa63sTtTEASxN6Hs018dgGTwW9qc4oM9zEtNxGdRN
	xmo+5k0aMuLmaGTJG3kCK7h3Nxyx1B+WIBT9FzDNIoEDI8s78K30iu8rqRnGyTkbfzoLs6GkdGn
	MZ9xjRhhiwBxhiMxpAyYR6mWm/YpxF0F9WxRBQ0hyT9en81yaopcq+zcgpCx5IOX+nnkXAA7iUV
	otGWnMS5tML8lK7zcSX7nxbDQ2FDk7bL3+57/Y9K2aoyZs844tvlY3/v6zvJo2zZ/XOC1y/J6zv
	4uI8INCGAuxsluyCoKXMEQkWd6nDH3poLuOXsKhqg=
X-Received: by 2002:a05:600c:314f:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49cffde4629mr130539685e9.17.1788716751586;
        Sun, 06 Sep 2026 10:45:51 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm245418805e9.0.2026.09.06.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:45:51 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/7] net: phy: add mdiodev_lock(), mdiodev_lock_nested() and mdiodev_unlock()
Date: Sun,  6 Sep 2026 17:45:38 +0000
Message-ID: <20260906174548.4106801-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788711797.git.f@lex.la>
References: <cover.1788711797.git.f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code that holds the MDIO bus across a burst of transactions has
phy_lock_mdio_bus(), which needs a phy_device. A library serving a chip
before its phy_device exists has to open-code the same mutex.

Add the mdio_device spelling beside it. The nested form is for a
library whose caller already holds the bus one level up, which is what
the EN8811H MDIO driver later in this series does.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 include/linux/phy.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3d8afe6b7f1c..e74a8f5cf5c6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2284,6 +2284,22 @@ static inline void phy_unlock_mdio_bus(struct phy_device *phydev)
 	mutex_unlock(&phydev->mdio.bus->mdio_lock);
 }
 
+static inline void mdiodev_lock(struct mdio_device *mdiodev)
+{
+	mutex_lock(&mdiodev->bus->mdio_lock);
+}
+
+/* For a bus reached through another one, as mdiobus_read_nested() is. */
+static inline void mdiodev_lock_nested(struct mdio_device *mdiodev)
+{
+	mutex_lock_nested(&mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+}
+
+static inline void mdiodev_unlock(struct mdio_device *mdiodev)
+{
+	mutex_unlock(&mdiodev->bus->mdio_lock);
+}
+
 void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
 	__printf(2, 3);
 char *phy_attached_info_irq(struct phy_device *phydev)
-- 
2.53.0

