Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA53932C6
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865409; cv=none; b=MYTc2vxvvNyXGEge/BB5sAQ+pos0CTqUNCQlHe+gTt0E/nDjT5Ex0FHKwDi9m++zxT0e8jr74wG9BLdp67D0kh9bxdXQ4mEiZrVK4WoM5uTSPs6q1+KT2YR6AQPOBX0n+DrdaVQfQu8gaHucX1m7C0i1Dx8x66Fq/Cz1t6aWrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865409; c=relaxed/simple;
	bh=OStuMbIJRGR13QguPPMS5Cujr1HI19Kyd2Ubu5FBRLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=at2d6zF7WCfeloDzJSr7YNtz5/UTWA6seDy8lqxshcVggLe6A1bcuT068pAfWJfWWJp7WCowpDviFl5BKlnpXCIUepnhgkiIB6fanJksZIc90y88aj8yps16VrYJS/Yw9LMAzSxkHg/NIT7f2Rw+zpR7rHFvQkk0jSRFtC5Y/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=d/ervt//; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="d/ervt//"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482ddbc11aaso66834f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787865405; x=1788470205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+A4DiEskWi8Pmb6CKBEIUqGXSf7tGcrNLyl+aIITkDY=;
        b=d/ervt//lXz+rtvbC5jX3kBLuQKmScpYnNLa+6IyU4W5wON4rqxVqKdy69Uh1K4FGE
         uERL04wsggr4P8zYwy4SFNfrdJmOyaKkTuvb5w2NQgJ3gqpcGZkuSd31HjYyl50WODZx
         P2+4rCNog60zOtlYSXHhsbPE6eq8gBm50H9teafKWGCPN2z7tIrduLdv9y1+TrnhLPAv
         lKu3gZ++NVoh6cJgd/AJgaE+utl/td9ixZOE77hHh6iDQiBTvHxkLanKxGcgpCPVwC8e
         Ixm9E8kzV0gqgQCmYATu2SrWpCKyDyWsOlrM+aRboGwTeto3+xGqhvzYdSK6+1gvRS7C
         gdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787865405; x=1788470205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+A4DiEskWi8Pmb6CKBEIUqGXSf7tGcrNLyl+aIITkDY=;
        b=YzDAsP0IqX8Ov1sIDQS1+7d3Z4Gb3GBynRBVxpCVL43s85cCss4bCVwtfRmsQERQQs
         xZttU6OodvzNDrH33sv4k2AXDwutekzcKXoM/zGseuLoQICyp5fxoJxO5cf4/pCtOCLv
         bS/VUl7xd4dlqVhKjSOHMJH+uhRJ1IrUJCO6URhzHSbZbDRND7dEwxagxOpKyn/TKSqq
         FfvEcxNMhrAM2BgYggyehJKejn3sk3zDIWOTtDZ+LWchd7ZrJZsFcAdmNHSDDDjHavo2
         pNidpMtY7Gdsaf80P4LaVaqS1F564jdqYotpGzIK+sC+1jlfluCThJnfcky4VIlXKopA
         f6tQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1gAW+i8rys2P2Viz3zqTzo2kHwDGEpHHvoR0ZNqfFTtdKam0VK2UF7eYhdbvU18qu43M7ByU=@vger.kernel.org
X-Gm-Message-State: AFuF++nXdGg2qY9Ez1mx5CAR1+4HEijpy7X3vh9VnChmLwPxKmHVBWqF
	NZ1rKvMX7x3t2r/PXlE8XIcu7Gwbl9kWkkG7WhTYx/fY314i9OgyAUQCx/40aqxA00FXJAvFiLr
	HSe2qQ1SYTw==
X-Gm-Gg: AR+sD12C1Mi8knmlMitJzZUgUqjmChjLCbiK/k0Tr9mDT4MfGJH6QYT1azq+9HHrL5A
	zqQ6hAVcOVIAkHkBCugM/hyZoW253b/Wk5tJxdYbSC+5DZoc8yCUpQNzWKbTbZShzH014hq46ac
	vvX+AyniH77PtfaWRlsXmFvWyn6or2q8sSh48Ar6yKLkpJ6xF8qdq0bXkly82fowBhK6eslOwaU
	a6AxYbBhXCoNuclIq5Vzggi/QS2gCy9rYCc3B0QbcRaYfiLEo21dAMy3ai2pRdwOw3AqSGJTpKw
	DD3gTm2jdJfcu9HZltCoztLs1vKKBWIOyzpmlru12j8rymGM4LN2pBexQ3U99hK2XtzUQ0k3TUh
	Bs0ak8lvl9+oJ2pDDAUR3mounxHqpDkOue4Y143QomRoneRrq/O5RMEovByxSnqsf1+uqSiIQ8o
	ipTVMUXaIGEu8D4JBnaTv8m0HVZeCMaROg7VyoseeTxamNu31dlh2qILQ=
X-Received: by 2002:a05:6000:2388:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-482f7828315mr2228378f8f.0.1787865404806;
        Thu, 27 Aug 2026 14:16:44 -0700 (PDT)
Received: from ownbook ([31.146.92.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e4f0c8f7sm11423442f8f.27.2026.08.27.14.16.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 14:16:44 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] net: phy: restore the interrupt after a generic-driver bind cycle
Date: Fri, 28 Aug 2026 00:16:38 +0300
Message-ID: <20260827211638.63395-3-f@lex.la>
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

A PHY with no specific driver available at attach time gets the generic
one, and phy_probe() sets phydev->irq to PHY_POLL because that driver
has no interrupt callbacks. Neither end of that bind cycle puts the
value back: phy_detach() releases the generic driver so a real one can
bind later, and a generic probe that fails never reaches phy_detach()
at all.

The specific driver that binds afterwards therefore starts with
irq == PHY_POLL, and the PHY is polled for the rest of the uptime with
no warning on that path. A DSA switch that connects its user ports
before the rootfs holding the PHY driver module is mounted hits this on
every boot.

mdiobus_alloc() fills bus->irq[] with PHY_POLL for every address, and
the bind cycle never writes to that table, so the entry still holds
whatever the bus registered there. Restore phydev->irq from it on both
exits, and only where the cycle left PHY_POLL. That guard preserves an
interrupt mode a MAC installed on the attached PHY after connect, and
it keeps a restored interrupt number out of the
phy_connect_direct()/phy_disconnect() asymmetry, where such a MAC would
have the interrupt requested and never freed.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Both exits matter: phy_detach() for a generic driver that bound and is
being released, and phy_attach_direct()'s error_module_put label for a
generic probe that failed, which never calls phy_detach().

Which buses and MAC drivers the bus interrupt table covers, which other
paths to PHY_POLL the guard also restores and why none of them is
harmed, and the sysfs unbind case this does not cover, are worked
through under v2:
https://lore.kernel.org/netdev/20260824024029.41310-3-f@lex.la/
 drivers/net/phy/phy_device.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..be4c35db8de9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,6 +1734,18 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
 
+/* Give back the interrupt phy_probe() parked when a driver with no interrupt
+ * callbacks bound. mdiobus_alloc() defaults bus->irq[] to PHY_POLL and the
+ * bind cycle does not touch the table, so whatever the bus recorded there
+ * still stands. Only the parking is undone: any other value the PHY carries
+ * was put there by someone else.
+ */
+static void phy_restore_genphy_irq(struct phy_device *phydev)
+{
+	if (phydev->irq == PHY_POLL)
+		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device pointer
  * @dev: network device to attach
@@ -1896,6 +1908,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 error_module_put:
 	module_put(d->driver->owner);
+	phy_restore_genphy_irq(phydev);
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
 error_put_device:
@@ -1965,6 +1978,7 @@ void phy_detach(struct phy_device *phydev)
 	 * real driver could be loaded
 	 */
 	if (phydev->is_genphy_driven) {
+		phy_restore_genphy_irq(phydev);
 		device_release_driver(&phydev->mdio.dev);
 		phydev->is_genphy_driven = 0;
 	}
-- 
2.55.0

