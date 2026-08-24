Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC7374E76
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539255; cv=none; b=V3PK/tYEn7l6XBb+FIi5XpfD9sBTUd1M0l/KpnPZQ+1qpKqSh3xhco3nhNQAaRymyAVIz7DiEms9ktxp+RhUD+e2KQUdluOtM3XzsJGFCD4Fu+CDeoV8S2QphoLq6WV2eZBNtmNAoyxA/HiB+i39fwGSXU3rYKN7VJsp8VIlMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539255; c=relaxed/simple;
	bh=ZmlYm3jxveF7tzH6WdQSj6F2s52ax7kuzJCcwgnCX3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spYiJKRGZhT3INWuY+t9zp2xOgWH1mnhwF+cJKzh+/XBQeHhfDU7c/fLRV3OaBlckV953Rf3IH/FSkQVDte05n6hvC4IUYt9NIgp7kGdkgIsTCZL7jykGxIwdw6R+iNnbMH2K1relAEk22Jl7v6UFAmeUhkYIyZXEPPoLc84Uq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=BcyXNKth; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="BcyXNKth"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15f020a223so429657766b.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787539245; x=1788144045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PFgu3uI6WNJeyj2BeGtQJ3I+sGN1TGHV3G/Qfqx6y0g=;
        b=BcyXNKthz3n7TkfS36c91/45Z5lAA1iCFnlb+dtTE4jgiXofJQIJ9ESu1vhuf5iVVD
         VjhSmwtVL1zolF0V/JWAHge91bILXRpL2CcMjD6g8lMfo2y/OM5o0JtveUzVzdftLmC/
         7FjhoIjYcM2632yuAv9tIWrIq/o0K0h1BXWeWTpyMhAj2HaYdL9au8g7scgnXGrLSFZ/
         kQDb0hS+HEOx/RRAqYSglcEqXMuDv0qxQrojQkttdXkASF1dvVT/2eJWQ8+2QQhFlFSc
         aeq1+B+ISzttNgsy7B41anrFkgPxYnsDrDngClDCZLtYqobiiveb7ELIBaMCkjJpnYqI
         75GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539245; x=1788144045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PFgu3uI6WNJeyj2BeGtQJ3I+sGN1TGHV3G/Qfqx6y0g=;
        b=ThGmanXrmnzjH6QaYmTPdBqwH3GwU9AhgRBe8NDKoPXGQVaWo0reQ9HUYsouBzxugj
         NpBP9lFU/UzRVWg/eOx3kabIql9V56r+tS1BUKedKtYIYfaP7yCJYkl5jFWuLqyFZoPR
         s9q00dk0OsWLzUPC7Knm0olLdBwkftFhfZm00bqG733/Xdl1q9JBt96ZdETvtZzbGhZp
         NMtTKXPgSFtptMg9ceR58LQ1/hEs+zxG8dEGcNlQmN8UB3fBpQiJuGyTdV11lcx8sTSx
         U6ZBt4epzuPWBj5/2LxQzuEn/2TGdg6LxuN9Wij8joqYAuuNbDvYvJobVfAFwd+ZCfv+
         Er9g==
X-Forwarded-Encrypted: i=1; AHgh+RoKsju9/C/3cnNuz2krn1V96u+88EXSzy3z7LnYF/jH/SHZmGBnUfb4rB1dQ/Yb7ZMpz7XepSo=@vger.kernel.org
X-Gm-Message-State: AFuF++nZqLB6gIAGIRxMhyCY3MNwCf2U9AZtSJA2yw4tZ5vxMMvnNsv2
	wVzw/jqPyTbUXcUT2hXltuclCfp0mhzuBlzu58nkZ8lsgBJSSjufOdlNoNno/ydY9mxOYKAQOn0
	ZISlBZDA1Qv10
X-Gm-Gg: AR+sD12cSje1urh5KmNmxYpyka9unrqKkVpXR+bDA7u2aZc5ZUtCsw410BXBpkJdeSx
	FvWTJLEeBbXrEE1XbFQxheQVVYiyGP1IRCAXIhdU0D7RMRzuUmFJ/430s/+NqkPqiMQzWtqNnxd
	vhXyfGhdQ/VjdaQqYGKENFPMQ1zveMk3qP/exXqZCuQVY0LpwUOh6GeXCvkP1w/o9SUlca1XOvS
	3WX3UkCtw+7sYwkwEZlsVxQ0dQIpJZPkIobcZhohpOgtMEJ33Atie0y0IU3RV9lo9sg+Mcfvma/
	evgD3uV7UHpABrgUjiX4As914jdNMHZkcfqxBcPn/BJxrBgAVy+QtTB4VO6zlAVTXQTw3oqxpiX
	KWPWup/PnUexG+SGRo+C6jFZtF92A2XJusBO2Sb7E+Dlhjj0DipA4vCAKMTSEHl4XRkgUrcN4qM
	CE731Zx3lAxJAj0g3u+eHi3IjE68Pnow0r1DingvNDMdqysycU+Y6V1PUJ
X-Received: by 2002:a17:907:1c9e:b0:c16:3187:997e with SMTP id a640c23a62f3a-c246a4ede76mr2414805966b.7.1787539245600;
        Sun, 23 Aug 2026 19:40:45 -0700 (PDT)
Received: from ownbook ([195.181.160.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f8f2asm1051909566b.36.2026.08.23.19.40.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:40:45 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: phy: restore the interrupt after a generic-driver bind cycle
Date: Mon, 24 Aug 2026 05:40:28 +0300
Message-ID: <20260824024029.41310-3-f@lex.la>
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

A PHY with no specific driver available at attach time gets the generic
one, and phy_probe() parks it in polling mode because that driver has
no interrupt callbacks. phy_detach() releases the generic driver so a
real one can bind later, but the interrupt is not given back, and a
generic probe that fails leaves the PHY the same way without reaching
phy_detach() at all. The specific driver then attaches with
irq == PHY_POLL and the PHY stays polled for the rest of the uptime,
with no warning on that path.

Take it back from the MDIO bus interrupt table on both exits from the
cycle: the cycle does not touch that table, so whatever the bus
recorded there still stands. A bus that never filled it has nothing to
give back and its PHY stays polled. Restore only where the cycle left
PHY_POLL, so that an interrupt mode installed on the attached PHY
afterwards is not reset.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
The cycle is easy to hit on a DSA switch that probes before the rootfs
is mounted: the switch connects its user ports during setup, the PHY
driver is still a module on that rootfs, so the generic driver binds
and is released again when the connect fails. The real driver binds at
ifup and gets irq == PHY_POLL.

Both exits from the cycle need the restore: phy_detach() for a generic
driver that bound and is being released, and phy_attach_direct()'s
error_module_put label for a generic probe that failed, which never
calls phy_detach() at all.

What the table covers and what it does not. Nothing writes
mii_bus->irq[] after the bus is registered except stmmac_mdio.c and
mlxbf_gige_main.c, and both assign the same value to phydev->irq in the
same breath, so a PHY whose interrupt came from firmware is fixed here.
A PHY handed its interrupt by its MAC driver is not: lan78xx and
smsc95xx write phydev->irq after registration and leave the table
alone, so they keep polling after a generic cycle exactly as they do
today, and the set of drivers that write only phydev->irq is larger
than those two. Which raises a question I would rather ask than settle
alone: if bus->irq[] is the per-address registry for a bus, should
those drivers be mirroring into it the way mlxbf_gige and stmmac
already do? If that is the intent I am happy to send it as a follow-up.

What the guard distinguishes and what it does not. It preserves an
interrupt mode installed on the attached PHY after connect, so
PHY_MAC_INTERRUPT from genet, tsnep or bcmasp survives the detach. It
cannot tell phy_probe()'s parking from the other ways phydev->irq
reaches PHY_POLL, so a PHY parked by PHY_F_NO_IRQ, by a failed
phy_request_interrupt(), or by a MAC taking the phy.rst advice to set
PHY_POLL, is restored here as well. That is harmless for the drivers
that do so today: phy_attach_direct() applies PHY_F_NO_IRQ again on the
next attach, a failed request is simply retried, and every MAC that
forces PHY_POLL does so in the same function that connects the PHY, so
a restored value is overwritten before anything can act on it.

The guard is not only tidiness. Without it a PHY that a MAC had put in
PHY_MAC_INTERRUPT mode would get a real interrupt number back at
detach, the next phy_connect_direct() would request it, and
phy_disconnect() would then skip phy_free_interrupt(), because the MAC
overwrites phydev->irq again right after connect and
phy_interrupt_is_valid() is false by the time the interrupt would be
freed. That asymmetry between phy_connect_direct() and
phy_disconnect() is not new, and it bites any such MAC whose PHY has an
interrupt to request; the guard keeps a generic-driver cycle from
walking a PHY into it.

The same interrupt is also lost on a plain sysfs unbind and rebind of a
PHY driver, and this patch does not cover that. A restore in
phy_remove() would cover both paths, but is_genphy_driven is what keeps
the intent narrow here, so I would rather not widen the fix on a guess.

No Fixes: tag on this one. The behaviour predates what I can bisect in
this tree; if someone can name the commit I will add it.
 drivers/net/phy/phy_device.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..8c93d35e1c94 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1734,6 +1734,18 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 	return phydrv->config_intr && phydrv->handle_interrupt;
 }
 
+/* Give back the interrupt phy_probe() parked when a driver with no interrupt
+ * callbacks bound. The bind cycle does not touch the bus interrupt table, so
+ * whatever the bus recorded there still stands; a bus that never filled it has
+ * nothing to give back. Only the parking is undone: any other value the PHY
+ * carries was put there by someone else.
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

