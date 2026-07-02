Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD947DFAF
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983275; cv=none; b=OV6cnciLRfAL9cNR+TRcTosWTDaKnW+LLknFSSaPRpRxLCF+qEOUTHueDB8SVP/WTihkCo+rl2HtHxqfdHaKZD/i0JFeI7labFcQ5X7F/kBoa1vngFnGTVt6Wl4V7ecqUrJQ3nWEEX1zM0lQWe5EJ37RfXSCl+9ylq4GivZwjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983275; c=relaxed/simple;
	bh=4UAp5ZrZWlF73uucLDzR3l0r11jDqRvLWAHa4K1+g+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVzMBA0Jn7A2MazV3R65ZTAXDhfxNqxwXZvYIOheFeBErQbXoa4Xk0yrlfcEmn7P8iMm/gxeINi6Q3QWVn9Btu4E9Q68ifkpx3mQ6dfqP+3QQqa8uaZp291/9oxEI9OG9gciAT4W22bSotiFZs5Fg7aSGn8SWhdrwUT8GYDvjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XCc/ceRk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XCc/ceRk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9976F1A0DD7;
	Thu,  2 Jul 2026 09:07:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6BEE05FF03;
	Thu,  2 Jul 2026 09:07:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2C00104C990D;
	Thu,  2 Jul 2026 11:07:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GQVrQgDR7eJBrRUODjf4Liq6ZKp5ye9nzyTUx+KIHkI=;
	b=XCc/ceRka18ozDjvOMsD8CVvQ//AJlNUvMp2X2cJ5EFWpFiNzSr8pQ6/JXZbpcHeUKWSi5
	+gVsDXXbvC/2kcQ3ORqj+gc83tKfK2By9TCF8XHp4DZWSEvyM7d2M7fa6r2sfV2usrjGss
	ctJCm5j97yUCiyGlRnpFQty7iBhwDSwVYEDp0/C6Uf+fyUmAlHkftOOqyXJKBvw7atvmmK
	QZdvl6jAAvAzV1Oc9RFVsnitaXQzJvRMbiJC6w/utHzSfRz8/obCk+YEYEVtewZO0gXJuj
	/cBnwDKUudoPtE/dJIUEWuEywqQAGumtuapZULj8d7eLlvIGYQKoGAbg6/mSXQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:31 +0200
Subject: [PATCH net-next 09/10] net: dsa: microchip: rename
 ksz9477_drive_strength_write()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-9-93441e695fa4@bootlin.com>
References: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
In-Reply-To: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

ksz9477_drive_strength_write() isn't used for the KSZ9477-family only.
It's also used for the KSZ87xx chip variants. This function name is
misleading.

Rename it ksz_drive_strength_write().

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 4f6f5526c26b..15ed139564cb 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3838,8 +3838,8 @@ static void ksz_drive_strength_error(struct ksz_device *dev,
 }
 
 /**
- * ksz9477_drive_strength_write() - Set the drive strength for specific KSZ9477
- *				    chip variants.
+ * ksz_drive_strength_write() - Set the drive strength for specific KSZ9477
+ *				and the KSZ87xx chip variants.
  * @dev:       ksz device
  * @props:     Array of drive strength properties to be applied
  * @num_props: Number of properties in the array
@@ -3850,9 +3850,9 @@ static void ksz_drive_strength_error(struct ksz_device *dev,
  *
  * Return: 0 on successful configuration, a negative error code on failure.
  */
-static int ksz9477_drive_strength_write(struct ksz_device *dev,
-					struct ksz_driver_strength_prop *props,
-					int num_props)
+static int ksz_drive_strength_write(struct ksz_device *dev,
+				    struct ksz_driver_strength_prop *props,
+				    int num_props)
 {
 	size_t array_size = ARRAY_SIZE(ksz9477_drive_strengths);
 	int i, ret, reg;
@@ -3998,8 +3998,8 @@ int ksz_parse_drive_strength(struct ksz_device *dev)
 	case KSZ9896_CHIP_ID:
 	case KSZ9897_CHIP_ID:
 	case LAN9646_CHIP_ID:
-		return ksz9477_drive_strength_write(dev, of_props,
-						    ARRAY_SIZE(of_props));
+		return ksz_drive_strength_write(dev, of_props,
+						ARRAY_SIZE(of_props));
 	default:
 		for (i = 0; i < ARRAY_SIZE(of_props); i++) {
 			if (of_props[i].value == -1)

-- 
2.54.0

