Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D52D9EE4
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786154172; cv=none; b=FCnU8UncX4zsUUuUYuLy52TBgHdJNgGn9a496Glu14zEF4n+YkM2gNlnGmGRHUk5yYWl8jFVmWMG1RBx2UNN1GfYX4FwWQ/ttK0ecs2Y7+Gm4nhQREEvW+V5lsZTK5RyGjfLaD6iQucqFDZf489xftN5rMM8Ete9tC2w7jHLxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786154172; c=relaxed/simple;
	bh=0Hj0QlaYSTyFYEXSfFbeWe+iEXPNu+H/OM3iwIGQxoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdQgpZ9bxdTytQtosZzhGktzDdQ4lm3v07fIjm85yVSaBfm7UMm2LE6gi1wDzuZUOOmH/75/FuxibDJlC2r0/lGABAdDXh3obKOWwXC2+0xnhzJBgncXjhDCflXOhk3T6HIIpET5Uqgw3p08QwyD46o7R41WAzoGVKkwqEZC31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVdr1cFH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVdr1cFH"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso46124a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786154170; x=1786758970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bWoXHbpk4foxcIrHN4t0PDZwpmsKGgehGiQpXNvjYU=;
        b=NVdr1cFHI6fd7ghx772PFo8znIbjNvyH/hyZ0/gfXrldpaoSlO0svNwfhJ/8Xdg69q
         gsNxIhDn6rjvPVn+sGloQCzGJNL9hGmdlwggTvAELYfkMbTs0UCt9Y+h8SkQkMOBzbKF
         wekF1KULKQArDtEwhngMoJGMY9VD77ZxUOs02PDuWIxTPwK//r/73rj5WbfaIuf657hS
         rA9MTj+4RIc/nl2jm9tGD47YJCA0Ql5aZVMdiJvSYRbxTEK/nJXdXqa8Nc9rV1//s7gj
         LJc5rEYBrezLq8gwzTZ2PJ9+h1YMhaLm7ohcM/Jykn7g3j93g45e3SGjcvTOBZ57dm+r
         LAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786154170; x=1786758970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bWoXHbpk4foxcIrHN4t0PDZwpmsKGgehGiQpXNvjYU=;
        b=AC91yqVq8GnrNF2Sh2Prwz7eBWFbzz6YIj+SqrzxdUO8yBunGQqoPk3M5kXvySntJ2
         EDt7BaHNn6tXb6AvLwBsxlVFxrcrSQ86xKKDTK7rA6at8UT7m9DK/Tfmy6WnOXzEZh1R
         P2v8XpEeWJpEfu5Wk4wSW+ch2QImBrArtMhU+UYsT9Z3s4T+/QC+bmH/rM0nlAfhTUSi
         aCQtuv99j/ktX70nj9mzhBg96kikRf1mOCO6M+lg7noyhLgTt1jq/RKHhTZGbSohgRVz
         IpSKvYF+RGYGKV7VvG2gY0zDu5wd+DNCuGq5a6NVFp0FHxwCngGIgmEbYROWe9EZ+GDD
         ScTg==
X-Gm-Message-State: AOJu0YyM3Sd5Kd907AdfncYFoBu9l++9mBvmKP6c8lW4vp1yCc1yNO2I
	tCG0IeKfuGtrjs0wYFv7aYPxNZK0sL0zFChMkszuiUlVuaKCAaShYEXg0IAYj4X1c1g=
X-Gm-Gg: AR+sD12wvHE5WIUtaKAQbejNfoOB6z4/R+QbTZwR1yjTz4PeKg0wNChYNU2qfS3UHKc
	Nvca724unwE+HYm+5x8uq/jROKiI8ioUtuDIaM0DJwd9JZ3avLHNsp1SyAh81dxap5DaCMcDpwt
	qU7xxM7wmItkF2YygfZnplhOKlqrOgzhZ1SScro1flkvUz/0HX7kFTrrV9ADfjRKyUoQDf7iXnW
	VZiMjl1U32786gglajxzwbbMgCGhHG/kHeRJoWBBEFMt6zQfuYBSlNIkCzsew0npzb73/UDlMnB
	P3ThAuEYMoW6AfwXl3azdu6US4sZXmOfVoaOXALdqwSxzt4UOp2+33FWrq5dEuJCvQpFTqVYdhD
	XOtlkBMSDsM5ODw5bErIEiWV714QVMNDQ1s3IN58Sfc06uW/AqhSLNOhjRGrbkzyuuoYZhKLgzY
	C5K2xXK5CsTkhXN0+nsoTb2TwZmkQltPBe1Lv+0wGCQ35cW6RvLkhOY6nJGs72TC0phSi07f6Rc
	/ZIynZjnewP8RBaTqnOo6pBTJSF74GSl9cESGlTb+xajpmeSXirSA==
X-Received: by 2002:a05:6a21:6da8:b0:3c3:bee9:8eec with SMTP id adf61e73a8af0-3cbadc10910mr14428014637.19.1786154170362;
        Fri, 07 Aug 2026 18:56:10 -0700 (PDT)
Received: from ubuntu-openwrt.tail1b3f25.ts.net ([123.201.0.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm19544823eec.18.2026.08.07.18.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 18:56:09 -0700 (PDT)
From: Sandeep Sondagar <sandeepsondagar@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Sandeep Sondagar <sandeepsondagar@gmail.com>
Subject: [PATCH net v2] net: phylink: treat PSGMII as an inband capable interface
Date: Sat,  8 Aug 2026 07:26:03 +0530
Message-ID: <20260808015603.787467-1-sandeepsondagar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807194937.785825-1-sandeepsondagar@gmail.com>
References: <20260807194937.785825-1-sandeepsondagar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
from the PHY back to the MAC through per-channel in-band SGMII words,
exactly like SGMII and QSGMII.

However, PHY_INTERFACE_MODE_PSGMII is missing from
phylink_get_inband_type(), so phylink reports INBAND_NONE for it and
phylink_pcs_neg_mode() falls back to PHYLINK_PCS_NEG_NONE. The PCS is
then programmed in force mode and its control-register speed bits (which
default to 1000base) are used, so a slower copper link - e.g. 100base-T
- is reported as 1Gbps and cannot pass traffic.

Classify PSGMII alongside SGMII and QSGMII as INBAND_CISCO_SGMII so the
PCS negotiates in-band and the resolved link speed comes from the PHY
in-band word.

Fixes: 83b5f0253b1e ("net: phy: Introduce PSGMII PHY interface mode")
Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>
---
 drivers/net/phy/phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 18d2ead97aa5..983a1a3cee37 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1040,6 +1040,7 @@ static enum inband_type phylink_get_inband_type(phy_interface_t interface)
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
-- 
2.43.0

