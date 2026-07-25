Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105B3033FE
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992282; cv=none; b=p9B/jEBryWKLyL1bnmnrx+XWC3AH7Kw1afxFhbQOiWJE35iHHmCt7V6eIV1oM9/hUkeFM/HYfgk8X9DpZhOoLQzc4VSB5nyK6C2BTfYSHqELRy6KmGwXbhnFL6+vHh2BC38aGC/9xFyNQ/F+oNByNWQQbYSVzBZ7J4efeT7kxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992282; c=relaxed/simple;
	bh=B6lymHMejMusKsix96D6ZvtfN+w//IbnFJ1SbsO3Lew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOLv6R2kcMLDDQnkqvtpDtbKSwcXcLepQu6fFHV7D4CpLqXXbuz9yaADt8Q5VlTVXbu4oXQRJKL4Qw0CytBSLykPQYqdtFX2zKOBykeeHGWmCHyQWtB9pPt5BW05eIFtBkpVPGP00NJlFnjqZylGxIqrG+jreMVD0JmNWimjqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faYD63Jv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faYD63Jv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so965636a91.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784992280; x=1785597080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXxSD90foPdzE3hbVwfCejb05zTmh4PTg573m1DJENI=;
        b=faYD63JvPaxAhJdYanP2hkw3lsybKW2gT3wiwPgjTcLpq4ETOL0Py0AfoRQWUfdEe5
         HJ5KU08fG7n4iq1nqjsA3f32IAJKlcl4FfeoPd5bC9YY00RZcH3wDuZG+Q4vs93NcQpQ
         3/9Fv32xgVYblQGWUu9ALFU9q7sAI6xM7zTaMu4jjXqem2fJyqU8eRmXujfLWy3kIEh1
         otYFXFecdG7ne6RDgaxVNikoGZf3HFdas1xW94Hb6WHPXwW+1s5Lqz0nfVadFCez7wQv
         pJFyRkIX/0c7LcLjm74VYrYKl3J4KjsACGzRa48T6LHcQ1Fry9c96OwF61COwdm8JShD
         9SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784992280; x=1785597080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXxSD90foPdzE3hbVwfCejb05zTmh4PTg573m1DJENI=;
        b=hGoHMsBsPPZhTUwMAvWm3GuJY88vUJQyTzyE6+bRNjaX3YlWeRqqpiuAvyGlkSR+hu
         9Bc/IKOEDByf6fRiRMfR5vTSQ6GDsDSu5NWxOE+mDCP+4FHeTc4aPsRgLaivOOz4aRe2
         Vf9YIu1fj6bYcASidBZNcMzfTNBx7iQ0ZizlRMnJh5ThQy8I6VNU8pQW76DARRgtEKjH
         DqdWyU3Uwx+lt4JMGIVIdhhnp2Vpp80EgZnBgu14UZF/z5+C62LBVOQf7eCsNhH38MUt
         y7swb3vE40XVQ1E/ClUOeDiSHRwzAsAiTaJ76Z7buu+V7JXN02uX0p24tFL7uAuNotz5
         Uugg==
X-Forwarded-Encrypted: i=1; AHgh+Ro52RY5TrimQ46p87MLtlHI5PlxCa9xv8Eyhw8Yd8Y5tjV04EJC4GEwHl+cccifh+HaD6M36GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpDbkhofAonYSnsSA+66ZncacmZfwhesX0lj3EAT2ubdkQxDS
	aLtZfU6eUOehV3BDYEOGyhOpVDpt15hQf8XOlcoObQU4XDfI6j3pEJuT
X-Gm-Gg: AR+sD10HqenmaoAil1Hb4kBJY6i0ly9MZ2ygR5VfTvTo+aIEJ/iuP7rdpcx39ZKRjcr
	rAx5m6qCAM7bOZjSVHbkgByqeGzmIR8FqM3EHEjD1H0wBNguY8M8X9ORGJ2f6t2aE6MFndDUFPn
	NZvzsvGalgaKh3Qx34EQ/kMIRrxRTuXvv4uMQS0MHQvWo8EThNgdRdpboxN0xA7LYb9ewRtt2fK
	xrhmvria2En95wQ5GAJvAeoPY26CS5EU60DhGSZjbi1VF+VgqVVD11Aj+u8WOmuoh+Kg4jZwryW
	GnqaOCWFpxNWSqfU9Wh8WMBrrUGgaS5CdjeBE1eioFKZ1X8cVyrTgFQhFBH0JW682r+hmzNLU2M
	VaEJMNbCB/sQyx2ZjJSPpxIcU/4xlPVPB9sOavppnOjBFsHd3YhkSEkFo5YaL0oGjh2f64pCb
X-Received: by 2002:a17:90a:c2d0:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-38f2a953af5mr1796822a91.5.1784992280596;
        Sat, 25 Jul 2026 08:11:20 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f031d1d6csm2907665a91.0.2026.07.25.08.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 08:11:20 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: kuba@kernel.org,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v2 3/4] net: remove conditional return with no effect
Date: Sun, 26 Jul 2026 00:08:51 +0900
Message-ID: <20260725150852.859188-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725150852.859188-1-ekffu200098@gmail.com>
References: <20260725150852.859188-1-ekffu200098@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

