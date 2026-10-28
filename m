Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222606;
	b=Cw+BkLIBcCAyRcaM7xoHZiu6rBG+jz4JhgZ3+1eDUr7FofVNPV00CMckjYNe2YGWVqHv
	 gDDaDin0V045w/RMywqo6eAMAKz41Gvwb4anP11CoSe2xjpISMQea9W+mvTrglWI/bwnC
	 zPx4VzQElU7+7LIlwPoVFdnihotPqR2jM2CbkArS70G3n9W/ZYnieYYFy4YoTj2czzVn9
	 POItYEwj+e/15mYDiZKpvTQ/zM/oqWeIwWbAxC3EhdBPrHfLcBqIRH6tZwxnybL1oBC/8
	 sMCBDV/qUj4Z/P2Z6fT+rIds5jQT1qPNyGyCwy5QmyFPBUTsXBaL1Y5SnxnTl0NbYRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222606;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
	b=YKHTVaq+9hprb4wACQo4LSvC+GQO90QRHwZI3aNJu6j9EqPI8RS+55itn3581XoEsJpz
	 Cmc/YplVLmzNRblda/vCQKl60GXmojT08YAlv9vVuYqxzI5VDY06RwxMlRF2M4sV3fS18
	 k51MIuWWtKXoPOXSRgE5mSZRnuLpZSTKh/NOYN+pmpJoGL1bLZdbANEDlECi2RuL5PwVD
	 68spwp6/bpD11ut3XH194Q5LsHr4oaiaqlhUeodlhfqZ+WRg/UqGfnuQUAxM4b+qIi4w8
	 7i4qLJ5ywS5+nx3+MaNZvZJ2bU5GpaW0cuXTrSu68vYwfOI2oqIluveBDD7nA2535sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="RQ2AXx/A";
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7760A2620
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A7760A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RQ2AXx/A
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so774173a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222606; x=1793827406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
        b=Ay20fh08Svn7lC6YhPMmxw4ZC/mPTPIrjIGLBb7zU0Y8kejRKLQZtoPsz9tXIAloLD
         7JKzMy3is7IKLNit8aC9d4miPqmjsHSvmg8sbx30i1WTH2xeKl4713Ljr3bCHDBrcoUB
         SBpkrhTVJ2YPkzM+PdeLueEpjeb+pJ6/WdfGKwT8SiZCoHnnaf79UPcYhK5QJJerS1x6
         FCSC+Ly0R8euV049CxjtkxfVE1wfqrUAefelBHUoDwg1ERtQ6peL8rNdX/AT58gCTduc
         nGuuoYQrOUUpljzcoT6DsWKmU67ur79R1ykIkB4qbFzsCKsrw/LQ4Cfh7ZSwQbDkQXVB
         w4OA==
X-Gm-Message-State: AFq9FYLljNkoN+oSzoCbdamKdL60b3kkYeM4hZviNGDHgPe9LCE3/7UP
	vCBQBoVydf4mP0nbBOkOOmkcEAUEGUShs+kEatSkKUn6zt2lFx6JCIYOU8Z56XP+KlUETQPNUIR
	0T854b2X3ge2JSrSBeG20HFB1HYnGlLtrxugzMVa/yrPGxtHc8kRYlNtDojKzDoOg6bAUw3Xugb
	cQkRxlh3Mc0xmw2z8rvDgcmDXC9hGTdGrxxNgVhCdlPXS+AmZyNhoHB/Ac8DsqVZyYK3xN/zEuo
	f1qL7fbb4ynD3KY
X-Gm-Gg: AYBFou2K1cc6a0mxNI9DDGEM82PIFqaMwqpbWKQ3lcBMJXV4WO6UX2rnGaKkDEN9WmK
	WLEOd3OBwU/QvnFNBbTkgOkHI6WWvesI4KkKEIv7EyJJowCSOuwsMkSkA+OJ2+po8flH8XqCFTP
	F6f4Eo4ichUUDvMdEHH3V9tfyWjUHLn1nS++lGN9d9bX7sCHic/rip33z42Ld40M+3FwwX+dTJi
	jCvnskBBWMauEoPkPFDHn5QisN2HhlqZYTYFI5a9TMlxFUwuqEnX5N1F4wF9itFBTOfUXWsZh4P
	VZqryab8bvefDWu6j8E9Y6XYWS3wKLv5c6TGyZ0W0wSB3AkYVe7wKyIVYZtKlGzlw8gmWMPMqQI
	e7BaA1YIxDIGa2S74wKkHtg3BvFLrmrxN20KZORNDm3TPNoEzQBrqmrUbiM+EJFhygA9Ro9zXqQ
	OVnZZwKAT9p1FuGvdyG+mmbi8cKrmlTIgezjZEprXH
X-Received: by 2002:a17:90b:4f49:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae580ae572mr2498440a91.11.1793222605707;
        Wed, 28 Oct 2026 14:23:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e5e4c54sm558415a91.2.2026.10.28.14.23.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:23:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2005ce21so204744685a.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793222604; x=1793827404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
        b=RQ2AXx/AEmTOkGwCqivWPHmGfr9SaJGSn4nXt+rK0bL+z0JLNs/4IGcB+mmAK2hzUl
         Unctm3jfJ29kHpI5oeI+V3UcHVVkmgdpz5klDu7+2Suf0EHn0SciRCU4dP1KUQJbtt+J
         uovbUAZn8qclmyPIrAtA6IGi9YV5rXB0ymyts=
X-Received: by 2002:a05:620a:400e:b0:939:6de6:9518 with SMTP id af79cd13be357-94408a9275dmr560955185a.47.1793222604653;
        Wed, 28 Oct 2026 14:23:24 -0700 (PDT)
X-Received: by 2002:a05:620a:400e:b0:939:6de6:9518 with SMTP id af79cd13be357-94408a9275dmr560952285a.47.1793222604237;
        Wed, 28 Oct 2026 14:23:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669112sm1368755185a.10.2026.10.28.14.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:23:23 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 5/5] net: dsa: b53: use the correct override register 2 Gbps bit
Date: Wed, 28 Oct 2026 14:23:10 -0700
Message-ID: <20261028212310.3847553-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
References: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The IMP and per-port GMII override registers swap the override-enable and 2
Gbps speed bits. Using the IMP speed bit on a GMII port clears its override
enable and leaves any previous 2 Gbps selection intact. Select the speed
bit alongside the register and enable bit so lower speeds clear the correct
bit and 2 Gbps sets it.

Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on forced link")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 378f47e7250c..75033b28100e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1370,17 +1370,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 				  int speed, int duplex,
 				  bool tx_pause, bool rx_pause)
 {
-	u8 reg, val, off;
+	u8 reg, val, off, speed2000;
 
 	/* Override the port settings */
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+		speed2000 = PORT_OVERRIDE_SPEED_2000M;
 	} else if (is5325(dev)) {
 		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
+		speed2000 = GMII_PO_SPEED_2000M;
 	}
 
 	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
@@ -1392,11 +1394,11 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 
 	reg &= ~(0x3 << GMII_PO_SPEED_S);
 	if (is5301x(dev) || is58xx(dev))
-		reg &= ~PORT_OVERRIDE_SPEED_2000M;
+		reg &= ~speed2000;
 
 	switch (speed) {
 	case 2000:
-		reg |= PORT_OVERRIDE_SPEED_2000M;
+		reg |= speed2000;
 		fallthrough;
 	case SPEED_1000:
 		reg |= PORT_OVERRIDE_SPEED_1000M;
-- 
2.53.0

