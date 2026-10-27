Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132570;
	b=sOeEZjt1PID4ZZzTm3b/k+icM593/WN56rleAJx1HbMtk8HoaQkF4+qNfhZsNcOBNXyF
	 BSfZccS95TRgJ7Bwcl7Hxym8we3HqI/2/SmRpe8gowRpSrS1ZQdrYY6L0uZK6WGY6L0cK
	 60mYe1K1zNIVO7ckQfqOvwDrVHk9nCWj6JHNGJjC6ZTCT4yVLbjpVqMKZyJTJbyXeAifi
	 FUFt6Tb5XO3Ojyaq5HSwMCWDZBaz/6M9LH3kuH1RrQaZ81FTnxf0hcnTB5UsjT/2opXXZ
	 oUBY+F09B202oNPF1VJn2bZFYN/lW8Ki8V2AvOOIVhtj1A8aAyk8YHbpe6No0Sm7mwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132570;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=IKgbuad+wGOIwvgFCVy9jcp0cWcfp4Y+GDQZJZCqkEs=;
	b=QEdCL1g+IAgPbN0V/8owaxHAsMjRHCnN1B43C31KxU79a9S7Eimbi5XfHI1jmsLMfWjh
	 G7pN9SsaoQTi2trQM9ioKdNYYYYaPUsBNB6Hgr+uwmgqsBjzdP0chLQovuNvLs6BUrcsf
	 3Uuvp6mFZ04lElJjnurcTjebbo2qT3DOizapqm6ZI4ojEyySo7M6F2HFfD2oFlTK7DuHt
	 qZ3tT4UCJpx4UU+LlTZjqs19krd6HZcOHzi+otKmNV1bEOjtnejuEJ1wt/g8KJpvdsXZC
	 o6+CAGX+lERbRAcMGHfXgeV+QBmjwAX18mHhxw/H19xTfScOnhgSsEauA1jOaycjm7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="JE8SbHr/";
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FE606E315
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D46FE606E315
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JE8SbHr/
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so173079a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132569; x=1793737369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IKgbuad+wGOIwvgFCVy9jcp0cWcfp4Y+GDQZJZCqkEs=;
        b=EzdFeGQwH1TEgkMD38o6OEPayit4SC/jsQpbtaAneoGnvjLGCw9yO/64je1xwy5CRM
         WcIwldRa9iZ5+7rbyGe6PJSfpsq9h+Mkb1GtjCTzmcYaaTYEPRjsMC5xF2pebnnPLjR9
         QYEH9LnJV88Y3GJ5FwP9SOD/r5nFSTfH6U9YL2OVErsr715LXbKWstPBs4c7cIqkE/eb
         wXSfy88DWpeVlj7+GHBAf14luKtPYdyFXNqrKnyYuPlN+iSEoq67DmTD4NNhWXgiOQzM
         uTG5OTHp4mkgsBO15wXjvHbqocEtJK9UBcgAPBQu3kzRSIzFWaYpSdESufa7Q5ziqIly
         rxjg==
X-Gm-Message-State: AFq9FYIZCnMtyMDdeq6Sk/vhc0Qiq1c7jtomlPCPLa04hflOZr2i34KO
	dXaN2RuwcoDhyqROAi7PoSAo7CdtRc2oB8NxfYnR5zDOVHocdUru5ax8stf8dPiinsuzbFxioZV
	qOX0KrWBlZ+oEppY1WbcsNUMVahBYno4gLTDADClsEqYSQwIsEcU2gdMrV7sjYEWlzj7/1jLMYd
	Y0C1XXqGcpSeV8gwYPewIeZ14T5/esB3SubxaXpisV+X/XM7SbkkoK8n/BjiEktoWAQhJAxT0gu
	HeLGArTvAa6HJRdPFE=
X-Gm-Gg: AYBFou38kSkB7ff9WNNXvdrpHNsjhb+XAKIzivXFrUqUKd4d+tmEjq8lMlVBgpCH/My
	xk1ZPIy5P/gBCX6h9j+hNtJaS+dwnRFr6mc9KILY4+CIhsfMF0yqsuv7M5H9HR6ysfMMmEUrsAM
	cP5m+1jf35z9ngeoRA/YZBT1fJcQjlP9SZfBcfTS+cfu+1+nkdI1M4Ezb0XQFeQ9sQcmryiVyWJ
	UuKM1OX4sjCQ6DsxviG4aMwc7jPzTiWm85GY25hkmqPXR+lXaFr86VNOBkleu65zbK8zfvVP209
	YQxBWsXcz77HdV4Tg7ugiUxn4NiYeM32ktnU//p6iXZPPnWoWSVvhUZga0Z/OC//8CIGefQvwQY
	+p68gT6xvjF34nZ5GhzgZl22UQ5dvYvw6JQ9yfI34s5wi3EnBmXnD/MZQng44WBDxhw7xM/4eL+
	57XnUCM2uOml3TkCPXQlampqbHB3BrqcTU5QrfninRvS8=
X-Received: by 2002:a17:90b:48c2:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3ae581835f3mr78981a91.38.1793132569105;
        Tue, 27 Oct 2026 13:22:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae5780afc0sm185910a91.5.2026.10.27.13.22.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:22:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ade5b3ae97so193373a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793132567; x=1793737367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKgbuad+wGOIwvgFCVy9jcp0cWcfp4Y+GDQZJZCqkEs=;
        b=JE8SbHr/4WgLicaiSWgBEr2mAyfaMI5mT7inwSN80QMaLJpSK8nJVlr/aqctWU7jTX
         N+LpxV3V13avMfItGLYgcDof7pwOmsXOVtiS2GifY72Gugyyu2upR6WD1eGBKxxS6x7I
         hlEpzpOyUSyAmhbiyL9YNdkqaxWbPX8rJZzAk=
X-Received: by 2002:a17:90b:5146:b0:3ae:3d82:5d88 with SMTP id 98e67ed59e1d1-3ae57bb8a75mr111146a91.0.1793132567544;
        Tue, 27 Oct 2026 13:22:47 -0700 (PDT)
X-Received: by 2002:a17:90b:5146:b0:3ae:3d82:5d88 with SMTP id 98e67ed59e1d1-3ae57bb8a75mr111126a91.0.1793132566969;
        Tue, 27 Oct 2026 13:22:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d1650csm275486a91.1.2026.10.27.13.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:22:46 -0700 (PDT)
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
Subject: [PATCH net 5/5] net: dsa: b53: use the correct override register 2 Gbps bit
Date: Tue, 27 Oct 2026 13:22:30 -0700
Message-ID: <20261027202230.3539646-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
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
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index b8a7b380bac8..7bbbfcd611e1 100644
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

