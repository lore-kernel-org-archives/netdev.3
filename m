Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D23264F7
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787483251; cv=none; b=t6F9vtMIITGQ+ODqi8DTt2meuKtYufKIMxKQq3Z5TazHRetshs8Irowht+3x/zAJbkTtMDLGqGsM4Ur7l80K5wfmbsdwQhPVC+2J56ZY+S5lcr7u1qbd2bdxkvRiPT9XH8Bin3Z3OUxoagReeN7KGUfF8I0pmmb8O19JtI8qySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787483251; c=relaxed/simple;
	bh=a4s2lrW1+8Eqk8+YHkDNoira6cknP3N1yXhpUmLSJwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XA9Yj0CK/FtJp62T9VsW8peazpJ+Vvu8mY1s2l0J30cyj6GlGMd6dp+qXF1JnuFpFk+3qTwhQ5oKcVzZ63k1jhyj1uGTm2rgQ3bIBBWUnH69LUfOliOVAueeigxnPXW03ThswZI0vp+Kv65WDfgRiEmzJ/teE2K8tFAz/DccC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbSlMTpq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbSlMTpq"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c74722e27so36461331fa.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 04:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787483248; x=1788088048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eeSk+EAhWojYnT5x4iIQpR2MeE2lPHzUfwVXBPxnCYQ=;
        b=FbSlMTpqMYoBkYQ+ccDNB9sNQGgltl5C4he/ad7AXNK7pRJNP6sF+cpYeVaK3mX4DP
         JCR2MlIvGASaq5YrUqCDL0RvaIOL8EKIF/0gB6XWzxaYw6cDJ3RsiQp/aApqDzFPsa42
         PgI0B79FJnt/+/rIUBlviTDfXznNBVhOwRuBykBBEA4DZIgOWtcp5mqZWO+gXsjxnDzT
         +9gtshs4R6q0jdDEP8laRAs93/MEGUnuFkBpws03EUlVdIq5GYM3O/gEEDXz/bJprgIZ
         +qOcPUjpI90qO/fjEYRwKm8AbIx44N/m9jJwPxf5Z0XcPoFRgo/b7JE8h0Wux4Rkq4LV
         u0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787483248; x=1788088048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eeSk+EAhWojYnT5x4iIQpR2MeE2lPHzUfwVXBPxnCYQ=;
        b=C5n3gcUSL6pyAP1YjcA/wt7zaJUr143o+x+VSCWbSay+X3sFjce9vMHROFU6KKvyB2
         OgEXeqayaYC/J5kdOI6gsNZpwNtBXJBB+xbOjGmU0clXxRUZjDZAYmhBeNO6DZOESsSq
         WeNZg1V6mvuIV5KW0t8Ii7+uWFSU042OD6zehPb6ugXQuONjEB05BN12NQ2mPCmbdhWB
         dPM0sT45ko+XMDjeV3o6riryrG3imf25aa/Bt5oMfCR0WGARTmoXsk3d6byQ8dRQYHqk
         pibisyg1Y1iSLYk/hZZmtcBdi2thZJ39ztazNkS6Y6GYa55IunkY3EHPQ0N9yFKmsObT
         6ufQ==
X-Gm-Message-State: AFuF++mxdfNJGHSRNR86vO8qfVc9lvfGAHSwuuacPJu2ifwdvJyhflBQ
	P0gTWyESLMarE4YKKpHW3w2n1HJAIaQlWr29HoYzM6+GiidW85FL5JXXLtZl5VT8QQ==
X-Gm-Gg: AR+sD10ft+6/TM2+X+b9Odkg1FUZohsMynyGuPCLlEiZleYQlvcO83TH50xz60ZIItN
	1Bqgc4DpV7RnccTD6B/cEJGj+xkNPHUjmKT3Kcy+hLutvP4abqYM6E1Uqoza8oxxA1OUY8D9jgZ
	7KaRCYnvo1r7OSdhwRGLuTjCLQFIZe26WM8ZJyKWcJtrK669oRq/0qztWiK7eI97YevlMKJSsow
	o05HfZmq/aypG/3GJOxm9RHlm/49eOR8ZrYhGr+JE5rDEchnGudU31PptBNWEPxenQ0IfZMPpfs
	ve1dW07mEDBOl5Vl0Jp9Yq4ASWG40FGaI53GnR9Cpa9XvmT9tSWYEaTcJSQV/iLJiR7N/mGDG5f
	j2rjy1Zq1khg6FvI0emeUygtjgpIh6+I+ithO1666ZX2SWditU2e/Hcp8o8rqdtHNXHi6F3joq0
	00DgWi76tniE85Vu1iNP4Wprq61+Az4K7ajJ9SoKkvGZ2ykAHoyjs=
X-Received: by 2002:a2e:ad85:0:b0:3a1:4530:fb2 with SMTP id 38308e7fff4ca-3a196a59b6dmr42000161fa.5.1787483247917;
        Sun, 23 Aug 2026 04:07:27 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda2627sm964748e87.19.2026.08.23.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 04:07:27 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: netdev@vger.kernel.org
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
	Mikhail Zhilkin <csharper2005@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] net: phy: air_en8811h: move LED GPIO configuration to config_init
Date: Sun, 23 Aug 2026 14:06:36 +0100
Message-ID: <20260823130638.1166453-2-sochnev.v.74@gmail.com>
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

The LED GPIO pins (GPIO3/4/5, mapped to LED2/LED1/LED0) are only ever
configured as outputs once, in .probe(). But .config_init() restarts
the MD32 MCU via en8811h_restart_mcu() on every call after the first
(priv->mcu_needs_restart), and that restart resets buckpbus-mapped MCU
state, including EN8811H_GPIO_OUTPUT. As a result the LED GPIOs fall
back to inputs after the first event that re-triggers .config_init()
(link renegotiation, ifdown/ifup, resume), and the PHY's LEDs stop
reflecting link/activity state even though they worked right after
probe.

Move the GPIO-as-output configuration from .probe() to the end of
.config_init(), so it is reapplied every time the MCU may have been
restarted.

Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
Suggested-by: Mikhail Zhilkin <csharper2005@gmail.com>
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index edd49c193e47..0eeb7b9a4e26 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1173,13 +1173,6 @@ static int en8811h_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* Configure led gpio pins as output */
-	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
-					  EN8811H_GPIO_OUTPUT_345,
-					  EN8811H_GPIO_OUTPUT_345);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -1324,6 +1317,17 @@ static int en8811h_config_init(struct phy_device *phydev)
 		return ret;
 	}
 
+	/* Configure led gpio pins as output. Must be redone on every
+	 * .config_init(), not just once in .probe(): en8811h_restart_mcu()
+	 * resets buckpbus-mapped MCU state (incl. this register) on every
+	 * call after the first, e.g. on link renegotiation or ifup/ifdown.
+	 */
+	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
+					  EN8811H_GPIO_OUTPUT_345,
+					  EN8811H_GPIO_OUTPUT_345);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.55.0

