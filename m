Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDEE2C15BB
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025088; cv=none; b=l6q+itvMc4oOWd5QviFMUeFFBYc8L7RHDtQADPKxFV+QOjR20RF6PfzOuvs+sXBHfbUilCDXeM2s4pY1bCenucWTjDv6E6dwMZXDt05XP5SeAXPtV/SuDn9xkU2SGnuylEyqZPQdrqlY5zFAUEFKEv0TKf2B66BqXHlzonZa7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025088; c=relaxed/simple;
	bh=94wFRIZIazpEMU15kEIPcyxREMBt2gIgkDh1Ak0QIqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gefN7ckQ0nt+jEdFRWSXKmuVhDBBVyHaPkgOCzhPGOJbP93h4rssEh1iUgyzu06/FAdE46mCLIKd+DSe9K7F8Lyyjpga8Z/+y355kxv9v2d1SoOU5VGw/UKm+53bq18MfLmtq8tl5azjnK7PSbFCrO0lzntymDhCVJJXLUnc6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAgcVgFa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAgcVgFa"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e87c66e556so20244415ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792025086; x=1792629886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsRG4r1hoE2DYmfNbBV1Er0PR2Y+q2DB1vZDqv5iDbQ=;
        b=mAgcVgFaPV9C+YwddqG7h1BbNHXnQAPf45q6xgUzUNrBZ4ty6gZJkoCrM827flPn9G
         oBXFVSJYX2gzzbmfBNAj2A9/zWLZrtvNiwekPAGcto7HvKBmFFX95aQWmaZ0ps7rtMvw
         K+5x76M1rolRTlIZU3uUR+bZb+MhuaREzHq5czbstQ2x4BaMAbsZvQZDYq8AC17jGHJt
         ye7IVRuLIKKFOJrV9FLqIhoKJf7kEE0Bxfx3DBpkapEpeKecB2fDbvWSgQAWiVN4NVLn
         7YXQQ3+KPMPXnJL1gUSUeFSZ0GlMm2WDjQEqpC1IvrXVbUHcYiNt/NweO6VSG18k6C7O
         2kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025086; x=1792629886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsRG4r1hoE2DYmfNbBV1Er0PR2Y+q2DB1vZDqv5iDbQ=;
        b=M5a7sm09mSKnaQ9uA+X/RtGOffrN7BXoKLEhhZzfNAvYm3YwtUZL0ou1XB2EVwQmcF
         rJUwzRjm/2QKkMF+U345Cknoqqm77l8N8NEFAbSVnK270OZXiVMBxGTQHNHri+6SBdBR
         s32QKHhJ9dkLtbYKWeFaE6zehfCDHCwoZPu0UAcenyLvRPzMjAFj211phN6T8W8COMWN
         ZQcGP9KF8YSanisdvzYwjVCCtAa5zmivZFhBIlpL0dR79KFl79j4jvurIWw2ZFGuYZCg
         e60z8fLlTLemfKb1/bmavZjJuS3er8NkYWhaei80j9tqhP0JtR2VtkgE7sQo57uv9yRq
         f7kg==
X-Gm-Message-State: AFq9FYID8Ha6Zosi7NwEeIu8T4jZeGEaX5glql2ey4UvuUrwB124pdRf
	UPCuxlL8v8Ql1gCFjAEWSScnYnE14JIr47pLCwe/sHgVI4/JIQjZG1op7tz2liz8+9c=
X-Gm-Gg: AYBFou2RzDsIg8y6DOxorjnnH9DYnJcWpnWq6ynlCwg1dSdDux+x0kR4xBpV4ZOxyzF
	kxZAF4BJc87P7g1VFQwECRiqlQbSPHJMl4L9ISXKUWFqvdJCBOX4lawyOhSZFtB3HwKOZ0WxxOd
	2Rdtkl3PnqmPH4Lr3Svhcqd1lWWavcKxWzCp7iJlemu4wKlRtD/JS3JMGuqUq59ppju5sSAkx1d
	EAnnoNZoxdudDFtz/sjYCnWdI/g+Kg4MP8B2ZImKy9fz78W4pSBegAsz3/NWcA0NvQiYj+YaSqT
	PsI+9wsKzcb27kWpGm8M3HJTWnVSoai5yYm8h4Dm6oF0GxsOkSYcaD7tSagGkVTrcXt56EI9SBT
	tQ1wBZHSwcDwl5vjBlx9BJ4+rCKaqjjZOwRR7UsyzJOj6SdUlANqaIUEaOcuC4Q0bzQVA27VDbJ
	AXE7/MkdXJlB13PM7yGWJ0QV4eRcR6peuIRT181Fn1aCd4vt56kiiAp3qj2tHwFe2bawQF/yAWo
	/Suu4gs/CuL1pl0Ix77In5wLA==
X-Received: by 2002:a17:903:26cf:b0:2dd:86a3:232d with SMTP id d9443c01a7336-2e8404bcd1emr116468335ad.8.1792025086307;
        Wed, 14 Oct 2026 17:44:46 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422da9b1sm75215135ad.66.2026.10.14.17.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:44:46 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: dsa: motorcomm: Remove the redundant MIB clear
Date: Thu, 15 Oct 2026 08:44:19 +0800
Message-ID: <20261015004422.1554104-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIB clear in yt921x_chip_setup() is redundant. yt921x_dsa_setup()
issues a hardware reset first, and the reset itself zeroes all the MIB
counters.

It does not follow the correct procedure either: CLEAN only takes effect
while ALL_PORT is low, so a single-step CLEAN | ALL_PORT write does
nothing once ALL_PORT is latched - and this write is what latches it for
any CLEAN requested later.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2:
  - reword
v1: https://lore.kernel.org/r/20261010231015.2600207-1-mmyangfl@gmail.com
 drivers/net/dsa/motorcomm/chip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 91cc5647f2b6..5218beb77ec7 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3902,12 +3902,6 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 		return res;
 #endif
 
-	/* Clear MIB */
-	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
-	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
-	if (res)
-		return res;
-
 	/* Miscellaneous */
 	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
 	if (res)
-- 
2.53.0

