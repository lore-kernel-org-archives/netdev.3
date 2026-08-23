Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F2339375
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787483257; cv=none; b=bPxI/tCNjRfs4p804JK2fPgsRCx7yklEsxQRB6i7IBnb6SqwQstXZ6mHEJntjnbxwpplhvF4JOJ9gW8b77M3B6RYw1cSTm4NyYUJUf0nTaz+S33KZagcN9LjQXEaxjjvh3DnxVnvFyU4zFjlDHVWU/KJoRf2CrsQgdZuJWmKdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787483257; c=relaxed/simple;
	bh=W/DuI+nr0gj9shWaPiF27XNd9tdBRQmHnx8FVZAqD9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxCAH7+iDei2+0kTNVtnfYJq/b4FjcxDIqhW3Lvj4Y6RUG7OrohoxFKler/dxl8FKT7y5b+6Wsn408XTEwzIJZezijNzrW0mZ/Xulvey7u/jauqqaV+rAc7s2HQZNzi+jxSE0OSmn5XXSwokPAlx6Q4tOBiCUOIltjYwUc79/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVLZLXa8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVLZLXa8"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b01146b205so1683785e87.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787483254; x=1788088054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crnJv4u/P7dZ+szgdnzcD3x8sExiK98RCBXJxISMcjo=;
        b=IVLZLXa8tQUSWWU3V3ypsaHTyM/E1/KWGN0XWdiBPZJZ9+4j8rLlANbgetno6S3mkc
         LgjCu6G4V1w7aGzQKxv7dF3BOtmO6oVsGnOj1glmggl4jvHkSzifoUMwMwWs18dsFA4n
         lm1ErQiPztkKYIuseGpc7U4LdJ7n2dwF2EcYiqNTESKLsEt3EUqT/PClg7jcRVO7P+sm
         EQIwIbefZXNVvJfcgYXjBBrpSRvSnzuITQqnIqV657ygQGt/LpSi7K65a0d/eBCkZ+Sz
         0dLVSvoLgey0o94Q4md+uhLT1oAResmz2bCUtqwbnP4yR3U/0aqRwFE3i5vaz4Cd/DMf
         9D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787483254; x=1788088054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crnJv4u/P7dZ+szgdnzcD3x8sExiK98RCBXJxISMcjo=;
        b=BHd2iZEF7IJp9ZV3drIPNTQZEQ0129fV1N9LueHi+PeM5WXDULXcIHYtBNprIyk41q
         /NRDxCAx20VshAh3lG+uDR3F0vVWWY2nIEOaY6F7OirFo72e3tIjwLqHm2YoJPLAC3WR
         V5Ytp+F+BaomJyhhiakX5mu++kFLJ18T5uuaznrTM5F3cwZvo6yoxKf28tNdTeIeJtjB
         USg/6HEg209+VpZXM461iUejVuKfWBTQ1NtmSoBeNAJOY9abejN27mbbEVhkw+foIDVc
         I+fDW9C/3P6Q9W+GxWM6+jprmN0sJfzURQFW+G6x/gPN1y0z+aSWWRJjPKaDo7s+kKj+
         2aJg==
X-Gm-Message-State: AFuF++lRZkA8i0Pi23LgpKyuhzGfEgZW9sR850B/2a3vk9yNifm2A4mw
	lw/q8QCtaDlyjeA+ejlPwwHBPbxNj4Ch1Y+lNTcs7ubIuOxPiAZfczIDzJchFLuPLQ==
X-Gm-Gg: AR+sD11nniXFngNSRZtQeB9M+77FBt0MuA8bHAIx7Uhxp7T0XEA5LSmrzKoJ4EJhUz7
	tSWkWEjeEooCi0LQO2T82lTiwf2FMKqdragwrXQq+BRfvBsVO/52+bWHulmJthNyzYbVWs8XZqu
	JYY0ObOQqORo2lv9mnBqoV9NlZJqWsvThG+R9rcZ+XT6uK3I08YhXhrQvQQhFGvnswOfbROZJ3e
	IvaAqX7YsWoa/MAtc+BxLGew1rIvURO5PxZpidTh5HCzIbzt6Kr2pUM3+x5jD2lywWAiDQ94nCB
	aIkuV4bs1nDVozl3iBd9gim3W96O0V8AYC+Gw3/UkZHTQPEWqdtMnhnKLvkiwrhx6aZ21vCurzK
	WTyZ3tIkYh8ObykJUpROQ3e6qqNMzcUTcXd716qLd0MJefT3iRb4k/ljABjyku2toZB1A+hOIFg
	d8ANLEhjggl02pPqIOG8fHq7vMaoHBcM9eNMlG1OAEGJqnk/mbSLMyEPkR
X-Received: by 2002:a05:6512:398b:b0:5b0:eda:de25 with SMTP id 2adb3069b0e04-5b48b8842c7mr2996616e87.6.1787483253717;
        Sun, 23 Aug 2026 04:07:33 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda2627sm964748e87.19.2026.08.23.04.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 04:07:33 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: netdev@vger.kernel.org
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] net: phy: air_en8811h: simplify en8811h_probe() trailing return
Date: Sun, 23 Aug 2026 14:06:37 +0100
Message-ID: <20260823130638.1166453-3-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823130638.1166453-1-sochnev.v.74@gmail.com>
References: <20260823130638.1166453-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

en8811h_clk_provider_setup() is now the last statement in the
function, so the intermediate "if (ret) return ret; return 0;" is
redundant.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 0eeb7b9a4e26..8f4498cf0a7c 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1169,11 +1169,7 @@ static int en8811h_probe(struct phy_device *phydev)
 
 	priv->phydev = phydev;
 	/* Co-Clock Output */
-	ret = en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
-	if (ret)
-		return ret;
-
-	return 0;
+	return en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
 }
 
 static int an8811hb_config_serdes_polarity(struct phy_device *phydev)
-- 
2.55.0

