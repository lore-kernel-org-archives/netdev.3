Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792990495;
	b=Ml8G6ADtdL/QhyGGTC8iNH6nJ6+1PIfBxqXRGpSCADw9J71216i6s+0NqX9LUFaevH2O
	 LAtt9TgcXLUMcjHGPWZRCJ7tsbC3o2nd04hw4GSgYGFKXKvXVBaaltcWg/LL1xmDaYxTd
	 uIhSbBU9NGuCsstAGDdpFosmfTj/8PCxYfdojjlWszAQtgzIU+Cw31skm/8rR42sEr34N
	 QKOPeIScQBOiKLMqvdRjArcnVWDjdTLke0NB5hkHQXMGxO6yuMIDprnDTklociJc3eYZ6
	 XiIV9FEHyRX6OaESplkZxeR2yIFkNrhXLeoxuujDaXSVR5y2uxH+ZapxO/3FajcSAGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C5D6ag0et/7qEqmj4ZeNoqCOLre9sM//MI9Do8sVHR4=;
	b=VgqWyA2Er8C3W8GM2cFWHCwjSEVV1RsD4zIpeqpNTb4iILgYQ9ubuS5PRgXA23iWJ3Ez
	 G+apVxJULI4HjLxgxBO94BlaRHEnJWoEz310LiklI3IOcqLaqwCTE69RV9rs7FaRkNDwy
	 eexU4+KuGk7eqNw+cR64jwrV+DLF5Z+jzjcpblKCKBXKgtRrR0bXKDceHqZJVV3kStxO/
	 9oQjIpxJoAdwa8AKgdVoeDfitUL3LigoYhmU/LnMuDMNTujrTowv51EUB+E8D01tdEm8a
	 97KZMFTdENvEWdYlPBwlEP7SC+fnSHJSSkwrlu2UhjmKxe20Z1fU+40eMwFm9voFisQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=d1FZijcl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A50606A31B;
	Mon, 26 Oct 2026 04:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A50606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=d1FZijcl
ARC-Seal: i=1; a=rsa-sha256; t=1792990456; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QlGx1dl6GEO+fccfAeAlChgFkaYG8paCEbFFdaifMPJwB6Xalntm/++6B7xEjZzVOKOCCjd/lg+4gZyx3AOyIMwWB6FeAg90zrNOGMmutcyYy7g7B2P3drskutpMNM6ONR7RQVjGckGP4957IxWqnryb8xlcsjheJphCqjGQF4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792990456; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C5D6ag0et/7qEqmj4ZeNoqCOLre9sM//MI9Do8sVHR4=; 
	b=efpcF+kMg01m6CSnrRy1mgtDz+6deL2aSnDiurbLmxQxLuvclNk1DMEHA4SgAeDGaqNLlGPJ7T/LQ6EEdqfoKSrIkvD4MH5od6FA0345d3M+QWQ3j7T03t8VL5pWpHTA0OwC3rcldEzdvWnOLV8LXbQ0M0WjmQZ+dWgfR7NgKaY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792990456;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=C5D6ag0et/7qEqmj4ZeNoqCOLre9sM//MI9Do8sVHR4=;
	b=d1FZijclyodE+xk7jXHEOLC4B0WGo5vJyxkawS/0HI+/Nzu02igBr36UJ+5sowY2
	b/HJjW48OCwVOw8ehJ20nLcUXr6qx8fvCUZNqEhF43mnP4vXnyqHNzWVhGtkdNOU6zI
	qjceMsrsLnuasoJIWwFBfoL5xXJgtgkwwpffzozk=
Received: by smtp.zoho.eu with SMTPS id 1792990455180651.1255534764931;
	Mon, 26 Oct 2026 05:54:15 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Wei Fang <wei.fang@nxp.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Igor Velkov <iav@iav.lv>
Subject: [PATCH net v2 1/2] net: phy: move irq_suspended and irq_rerun out of the bitfield
Date: Mon, 26 Oct 2026 06:53:42 +0200
Message-ID: <20261026045343.837889-2-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026045343.837889-1-iav@iav.lv>
References: <20261026045343.837889-1-iav@iav.lv>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_suspended and irq_rerun share a word with link, autoneg_complete
and interrupts. phy_interrupt() sets irq_rerun from the IRQ thread
without phydev->lock, while the state machine writes link and
autoneg_complete under it and phy_request_interrupt()/
phy_free_interrupt() write interrupts, so one read-modify-write can
undo another. A lost irq_rerun leaves the PHY interrupt disabled after
resume, as phy_interrupt() has already disabled the line.

The next patch sets irq_suspended for PHYs whose MAC driver manages
PHY PM; with stmmac that happens before the MAC stops the PHY, which
widens the window.

Make both flags bools.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 include/linux/phy.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21afc2082b17..ec2c4d9a15d3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -726,8 +726,9 @@ struct phy_device {
 
 	/* Interrupts are enabled */
 	unsigned interrupts:1;
-	unsigned irq_suspended:1;
-	unsigned irq_rerun:1;
+	/* irq_rerun is set by the IRQ thread: not bitfields */
+	bool irq_suspended;
+	bool irq_rerun;
 
 	unsigned default_timestamp:1;
 
-- 
2.43.0

