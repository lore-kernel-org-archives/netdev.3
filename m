Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708212;
	b=FgQyAtYGYtc5PEov2UmU/z1Dyazc9SYUQNEydTYL9ryp7eSH7kSNrovw90sSQclhi7Cp
	 MsYc56/pnxdWSXWNBzneWgchTopYd8NzsgG6jE6r/qvxQdjDhSgIH1/FIn0BL74NPLhOV
	 5amoLxaymES2LGjRcjTQK6PhU03ZL2j2b4byg56c/bJk8IYmVKFuErCZnZ9KbnlAgbSW+
	 GBEt1+rVOezlSwKnGE7MHDemCGei2lUTIP1OIzEt8TGOGLTTBzxnygqt0pmD/QTTcQKVn
	 0K12L8NFZXp44pmisTDE6udx4WlSi6+KSjGLIt4t/9cMtMzI4h6SFKD4AgZxzbrNFvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pJNO182l6e+8BfE6OvTk4EQHBvr1+MR3R8s/7W0jVHc=;
	b=qdrUm64qfslosVyB4UDggbL6+DNO4e7VPe+q71uXJnvv2yP9ocbnRf664zUA4VCX6kY0
	 deDW56iwbr1B6NNqxMMpYS+XvkXX0Tezp7RIfoU8jV1hx1u0ItTxuJiOMDAg+j0/2qnM3
	 R81o3F0++y8WJOKE6x5FqWjzLe+b0MXeF0yNmtquUdV6kJAHuj21250+d34XrQ/KtJZeK
	 3XuxPYRR26Pb4wUaKL5rdKUzvFOWMDybHQz4iH+i4DAVBgWZhBTYNI8gdzUB3DPOiHIzc
	 ILt0HFEukj52DwywG8ZorYSCGXBCxA5TY8utIo135xCMSxYesHYHi7DCRZyTceeytNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XH24dlhs;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7216606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7216606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XH24dlhs
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so2278235e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792708210; x=1793313010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJNO182l6e+8BfE6OvTk4EQHBvr1+MR3R8s/7W0jVHc=;
        b=XH24dlhsl0rGpsdUho5fD+KZ9Y2ksuLmods8dMH9niSGUi9bPiH0J2UPXGfHg2gLa1
         cWApmr10wl6W9xiWLUoJrn6nCJsJ4dEn9Mm47LjAv0W4wTiAyfJBdmTUnO9cAzkrk4om
         v6BSwtvEJNmdyTBJUsZuFIwUsldeARfg9cA42gYhGXz7rNCByTtNgG8ISn/ljLOlGleQ
         s0W7bMgFI0TUdVJc58bV6mK0fAdJ+neZSSuFV20r2vjbLudWgt5R8n5C3FpDVGHGS6oZ
         17UQ+Kzv3HUa2X8T5Hfca8NjE8zhRk2rGa4/vDJ6kTo9a5YGzXdonKMKq1HrdvI425zw
         +JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708210; x=1793313010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJNO182l6e+8BfE6OvTk4EQHBvr1+MR3R8s/7W0jVHc=;
        b=VUTmtouE3riTBHEAI6RKaXvL7v/C8pmBLxAFJB/SK0pGFtIhbzOoI4iNeuL16o6FVE
         w7JhF3hWUSAuSTZPV0ogCvOHQ+LGIaS2z2mBmLQ2AsjvtHXUzZsE3aU2mBPHD5DjLkTr
         +PYz9UNo21PCbJhlWvqQfVPIUzmXmfbGKscGBEn1Uw1x/KKilsHN0WyzZYKc6ok8n1DK
         LgxHdLiqqyUTqpWX0yGpF+4/kPrTkQ/VidGPuo64yBWXpLsOhFUWy5602jgSX0iB6Jmx
         KIDHC8BM+L2nEbMGcaGuo7BE7OtGbPB5jpWczD/fFZ+e0uKjz5gJ0HWCKbt/KiEX+yd0
         ReOg==
X-Forwarded-Encrypted: i=1; AKwUvBw1MesXcchvLNb4Z7KPea1Kp2M14zesEz04DWvLGL3glcTWnKoezwSrdJcUOS7es8lR10H+NAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjc+3l541ycgi6alC3s5I9t3DOjPFNNXenO50Li9gkNtRgCvVp
	/EEI9Avbz98SszXKR6Bkn7dTxrUEOsS3/U7304i6Fw7YbNE7tlVvn/LO
X-Gm-Gg: AYBFou1wQf3x9Tu+ya04RApXu3jAmAjVfRp6jEotLaeftEmqrnJvEliK1drtLe7GlxN
	e8An1batWAOXqlO7tvk6+QfMZsWz76/stxMxu6x4nN13S3Z8t+B+T8NLH2VmtfOPG2yCHvTSWrG
	km6JQoOdmNeqsWoNRm1wQRYiBurucB97qaAAyJtcZQZ4ZYXnjr9tL4IMreBqqL4GkhObupTEor8
	FRXRGlkZfH76ApHS7XZ7wNjKiGECj22bzRC5fBu8hmVGJUFLsFJl+v/impMZFUWK0TfP0x5yfCi
	/1o7biKo+RCzTgchVTGMQHg2O5uodqErF6W4D6jjsaPbCuAJgp6bNF6788JTySkoZlVAf2q8Hgm
	IEkm91EgjazzD/PvrIQc8icmrOFJdvmX5eHx5bE7ziiOwVl+4ojTuGqo6TjoFs348Rg7utb4Hug
	PPA4J+Q5HiPQ6mKtsMUfTQxnmuEokbISwnkkG7+xuQL1j76wN3YM4mm/0viznuKqPpcKV2Oc06I
	vNQH+X3qWUAWZwppJigEkldx60QWBp5rNNQU2gk9sxYloa+r8K7mwQTgouwYKz0Seymqb7LWJWo
	/nvN/a7rKOtPPQL7FY8U04MQqZmGXVeFOKmMrOhSgu8dqwDGkqx2cSCeI3bv
X-Received: by 2002:a05:600c:1911:b0:4a1:9663:7633 with SMTP id 5b1f17b1804b1-4a211caf95cmr6181475e9.11.1792708209901;
        Thu, 22 Oct 2026 15:30:09 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a211be8f79sm11958795e9.14.2026.10.22.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:30:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v2 1/4] net: phy: as21xxx: handle corner case with link and autoneg complete
Date: Fri, 23 Oct 2026 00:29:51 +0200
Message-ID: <20261022222955.698722-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Add missing case in custom read_link, when autoneg is started, autoneg
complete bit is reset but link is still not up.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Changes v2:
- Add Review tag

 drivers/net/phy/as21xxx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index d5738117eca6..0db82da8dbdf 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -658,6 +658,13 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 		return status;
 
 	phydev->link = !!(status & MDIO_STAT1_LSTATUS);
+	phydev->autoneg_complete = !!(status & MDIO_AN_STAT1_COMPLETE);
+
+	/* Consider the case that autoneg was started and "aneg complete"
+	 * bit has been reset, but "link up" bit not yet.
+	 */
+	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
+		phydev->link = 0;
 
 	return 0;
 }
-- 
2.55.0

