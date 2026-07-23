Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01D4F7981
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832389; cv=none; b=GFWH0JiVa1ZbecqgRkBbvc8B1ZZQiGaPD6D9pHsB0y0xdCApwFyW6UVUykixInYp4GWDMCEga+1+paNb0lbcRs72b3t7GazqKv12m+mhmIT8/Eb8M5y4Tz8Ijl3Of73vUbXYXP/A39HlyM8OxL7+f/pXo2aOqR0Z7uZG0jPPeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832389; c=relaxed/simple;
	bh=pXLTAUkjCgRFuHbdlrm9wPCFAoCGzZnJNnZvsbZon1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOVyvxpuQftdgWAzNyUC3kMVS4o/KKfyIIxpCmDa0ypFw9GJ5hjzfMrLasJ8V4OUnkNPQJ0yZWlWXpqSkkTCzsqES5nFiV3TTWvgkEm3eZWnOh0nH6gSUa6f29A9pOcL/kvfdzlUqPEnw1A28BMMlyeYOL1uaMSm8N5mu7xyiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2SybAu/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2SybAu/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso853208a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832379; x=1785437179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTuJvAzG5mLe5AUB4aEimify+WXcEx2MLUBwrRB2paE=;
        b=I2SybAu/NbDXH3Ob+ZOTehOR3mWbaldDLvt3AnuUFR0g+clbZiHDKZ6XWlIb1aEfup
         g9YEjPIQProUmTUm86KaLeJjNIdrB/v17gdBA7wRsqu+nx7dM/gL3W97BAqtkZg9Caka
         HfOdyq8Bl7JXhGbNolima/104MJD8VXX+8Hu1bT8r6DQmzyNNf74VZSs5oplTgXUoUec
         /tjZG4cFyY6AhbnT2l55Drdw8f6L2xfmuI/1HmTpdF1v/6VUISBmGokBAiddviP9n/n4
         ozG5mxSJc6w16FvPgpg5qw0Ql8jq5J2nJb7G0wu9BRr2EWyY2mvWDRNTpdetldk2obNX
         nGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832379; x=1785437179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTuJvAzG5mLe5AUB4aEimify+WXcEx2MLUBwrRB2paE=;
        b=o77v2lCoBJldNw5YSJE6u3vKsM64pFVq24KoaWxStkGul1TC13gOoKEW2EnFn4TmsX
         9pYAneu+Y5cIS0F/U0mtZIstb6SwFZCldkTfnUieztLRKHty/bzfh+iPY5rxWveYcNtG
         fbExLD/rWWe0H3tzckyEVDr/wdjTsyYb4ygUCT11FHFfflyNgCJOxTw/mnbENG3FDNzo
         Ex3RCnZUDdnFM7JNimbFTUpe+XLPhebC0PlzB2511k4YAo4rOndCNgFYho4IzkoOT/t+
         GGpJYgZ9gRRiy7V4dHX2lNx5znDdgXBA1Pac8vViOpLK60DrMeMXWH6HLud9lwCpBVbS
         ywqw==
X-Forwarded-Encrypted: i=1; AHgh+RonZon/68TSNxYrQ9mAmbGVcE/R6eOLHp1UpvnE+AaHwPt2Uz0mnDYE3LU9W89E8Pw6C7TzXKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmoi5onzHb3W7mIdpKKQ3+7JNzuL2cv2q1mUzrhVb6pXIjhT5M
	T8HMOM5YVjyFTJaEe8NIZU6D228lvqxqZJOH4XMIa608Nifad699XZ6/
X-Gm-Gg: AR+sD130bLtZqNy/eFr/8sZsVjHUZgECMgqRXWGxNjrERs2Etsajw3p/ZeNmqsnkO+Y
	JM08AMLnYMtQdztDWItLLc1VcDQ9XVQKTOhL6sxlKtBIgq08aXx6CQV2LNmUgGsolQB0lznETgz
	aB73wJ5peDROns2sVoHiF3sKCbpOvRHarVe2FsmuwhwCUbGMgD9cXs4bgZ7uy4EB9zTO14OQUBs
	oiUmItPRX5x+OKbAhDFAnkBhv6xX/gN5pS73riPyi6jp0iR07gBWt75oi/EmtxoLOLfF0acTmh/
	2VorvVTNGwC05UUiCnOg5T1v0lEoZJLRLPB3Wjxnff19QEOB0D5exfjPxcCQ+oSpEfJd4pNl1Gu
	jnnTnq3xv1/jhjZ0yxA7cuKr02UlZ0dAIQGeFnAToyW54EcltxKZJ7rvqy+OWsdpSTOTAsOdj
X-Received: by 2002:a17:90b:50:b0:37e:a09:2640 with SMTP id 98e67ed59e1d1-38ec64958fcmr4523372a91.7.1784832379247;
        Thu, 23 Jul 2026 11:46:19 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:18 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH 08/36] net: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:10 +0900
Message-ID: <20260723184538.3888637-9-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/phy/microchip_t1.c | 6 +-----
 drivers/net/pse-pd/tps23881.c  | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 62b36a318100..3292b2235c8f 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -1028,11 +1028,7 @@ static int lan87xx_read_status(struct phy_device *phydev)
 	if (rc < 0)
 		return rc;
 
-	rc = genphy_read_status_fixed(phydev);
-	if (rc < 0)
-		return rc;
-
-	return rc;
+	return genphy_read_status_fixed(phydev);
 }
 
 static int lan87xx_config_aneg(struct phy_device *phydev)
diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 49d6389da067..8a3bbd623412 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -1520,11 +1520,7 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 				     "failed to register PSE controller\n");
 	}
 
-	ret = tps23881_setup_irq(priv, client->irq);
-	if (ret)
-		return ret;
-
-	return ret;
+	return tps23881_setup_irq(priv, client->irq);
 }
 
 static const struct i2c_device_id tps23881_id[] = {
-- 
2.43.0

