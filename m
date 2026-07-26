Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD637D10E
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078506; cv=none; b=M//zIMbHwVgc3W+zM9BE9rGgVXBjPEBy7iWO25f9TxuzdtGodQi+OetBh685qCIKuXbjG6xWSXVb95rU9fHZljNXXv35KvtY1VcBYvEFYkZUhG+k2H0aqfAEmmk3IU7FM8jKmGB3oduHza+kURF0S35oo8F9WJ07PT74lhNeczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078506; c=relaxed/simple;
	bh=0B4u1eyhoxlUI94b50Ih1wtB/9Q8UezhyMJY/waYykk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgLz4f6UBMCp7mas6EeVvcOUc+vsBBXsCeg6XsY7JniQGkPmb3zDIRRtVs28A85VqiZLA4fD2z0iTteBLL6k2n27RuPqaocLJiibR58kzp1nHMgB6XJBcAEO8UVTQouU2XKQaOGafMAHurxn1f2EyfxViXh+J6RM0TJX4WR38hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv92bgUL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv92bgUL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so4406405e9.2
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785078503; x=1785683303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L4vPQLIFIU+PH7XILzDD9oxog/yFBBjc7oRz0GykxrM=;
        b=iv92bgUL/9imxF5nBruERK2D6aS1M0WyGPJzin/alf2+uu3PdTQpze6+uTT3BOjbxl
         W29F42kyl8KpE82IBHFR4qmlwZI+aOqBQlc/VK9UoDHaXk4Uu4o+Nhvxxp8sT6+umnaO
         eGr5Zuy982N3/ZTCuY+1nLOpGBo+i3pxJtYwYTvWDnLFdLBB4M/Lj9vjFDnVHfljTj6+
         JfFniKgXQXIpwDFAXXH1P2BgSHkuFLT7gs0Z0iwATTNgE6xYOBOyx2oVLlOIMmuhZRy8
         j/RoVXRKSmwRF8IlT6a8UjVScI4goAJw+d/szGxlv18FhAjS6vL6JgmAhNQZwxyJPe51
         oS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785078503; x=1785683303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4vPQLIFIU+PH7XILzDD9oxog/yFBBjc7oRz0GykxrM=;
        b=nzKB5SFJ9mOvSO2J9ar5L7sfVzOS97csBDZnsO6rQVCNr8SvI57Amb8ZfKS+bxHWrI
         Y9tE1Tov3uG+856zFlG7mkq4NyqEO3MbojKyNeTDxpWgFA5PSImzWVK3JUSq7L1E+GUE
         3G/wtZHWWOTJ4rTFt+MoJR4gBOjlDjl/CI1h42rACu4pZwxcVtEajTbeSzjO3DAQGLTq
         h7bhoFLN8z5cB4iaN5In7tJPyBwfXSXj2pPYupzsiOPh95vhDMJc+YB4/0AVUsuJgQF6
         yzAYxBh3zS4iRhHAfdJvHnvoZ70GK4TLcPDQvNjkHz5dup/WwCLlLD5AtyCdTSfm3EwZ
         sE+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr9q3IrjoULLQ3/2JW3efT3z9+z79b4hrEguU1aaRhE17yD6LJatH3YRp/yxNUDpD+Fw1+1EZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSjgw4Osai3msGdilS4RlXoAG8NXRjSIcY+slLU3EfkYIJd5C
	lTo8C4YGusgjjFlOHH0SXSStfj9UJ038lO5/7p8tk7WyNaJUMUaWDx7G
X-Gm-Gg: AR+sD115hbM+Q4gA5Of4Yi/ffWXoEXaePjLuMBhDozcV8TJ6oaS8kSFfom9jrbihHdV
	Oc0JVqVmKty5yF7yaWzSXvhArJgYf9uRWvaobYd3BVImsEV7DPPG9nPYYc55tgk2uAnCpHTNbYP
	aco/abSqdBJ7I+B2ppSbe+dwj6oSq3D5PrmhLla9eqScf2rcTcEl8YirGpLQWpIY/PTb9XClVTe
	bfmgpiYIIj9oT8jtbIocLdIEPN7o0Lk+tWC+Uu5ercnxEzrfH69+OKQkpjL/mH2L5dyu4LRLq60
	XiSkPRwuPfuFwfTdccsWgHwUsMt+FD90xVcw5G5DNYjFCjsSJy6fMD+qYqwQGMjKl2wM4ndAbvz
	8zTy03cdxaMUIF5kFOl2bnxK3qVQKeUTSvUcHEraEvDfDtQQaRr2vbF2KhZe96Ia5561yhpsbTq
	qsmJrVwfuT1UzE0lBa7s6nHYtP1gQ0UulYiU3353L16NTnREwjBipXjKmErbf8Bw==
X-Received: by 2002:a05:600c:45d5:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-496b56bbe92mr63228665e9.4.1785078503412;
        Sun, 26 Jul 2026 08:08:23 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-0-193-91.retail.telecomitalia.it. [87.0.193.91])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4957bfc2ff2sm166262005e9.4.2026.07.26.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 08:08:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net] net: phylink: put link_gpio if phylink_create fails
Date: Sun, 26 Jul 2026 17:08:05 +0200
Message-ID: <20260726150806.2437-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In phylink_create() if phylink_register_sfp() returns an error, link_gpio
obtained by phylink_parse_fixedlink() is never released. While this is a
very unlikely scenario, it's worth to fix/handle this.

This was present from the very first implementation of phylink but got
relevant only with the introduction of ce0aa27ff3f6 ("sfp: add sfp-bus to
bridge between network devices and sfp cages") where additional function
were added after phylink_parse_fixedlink() making the release of link_gpio
needed if such additional function errored out.

While at it, restructure the exit condition of phylink_create() with the
goto pattern to reduce code duplication on handling error conditions.

Fixes: ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59dfe35afa54..f40acc0d4133 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1874,8 +1874,8 @@ struct phylink *phylink_create(struct phylink_config *config,
 	} else if (config->type == PHYLINK_DEV) {
 		pl->dev = config->dev;
 	} else {
-		kfree(pl);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto free_pl;
 	}
 
 	pl->mac_supports_eee_ops = phylink_mac_implements_lpi(mac_ops);
@@ -1908,28 +1908,29 @@ struct phylink *phylink_create(struct phylink_config *config,
 	phylink_validate(pl, pl->supported, &pl->link_config);
 
 	ret = phylink_parse_mode(pl, fwnode);
-	if (ret < 0) {
-		kfree(pl);
-		return ERR_PTR(ret);
-	}
+	if (ret < 0)
+		goto free_pl;
 
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED) {
 		ret = phylink_parse_fixedlink(pl, fwnode);
-		if (ret < 0) {
-			kfree(pl);
-			return ERR_PTR(ret);
-		}
+		if (ret < 0)
+			goto release_link_gpio;
 	}
 
 	pl->req_link_an_mode = pl->cfg_link_an_mode;
 
 	ret = phylink_register_sfp(pl, fwnode);
-	if (ret < 0) {
-		kfree(pl);
-		return ERR_PTR(ret);
-	}
+	if (ret < 0)
+		goto release_link_gpio;
 
 	return pl;
+
+release_link_gpio:
+	if (pl->link_gpio)
+		gpiod_put(pl->link_gpio);
+free_pl:
+	kfree(pl);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(phylink_create);
 
-- 
2.53.0

