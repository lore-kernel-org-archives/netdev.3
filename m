Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E367244694
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786155003; cv=none; b=rOeC5HO5ODVeliARBVS4RyaPXHKNg0qjW9RklJgLs0/Jz+4bA5jTFXS/sTNEo8u0E4t3F/g8JC263OpY76y6eLyTQmVxsdmNfNcyOroqZeHwBeIWmzbc7MUy7ers4VivWkMDbziyy46Sf/HpRhXBrhkZ3GA6Ot7xqKtY291g6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786155003; c=relaxed/simple;
	bh=0Hj0QlaYSTyFYEXSfFbeWe+iEXPNu+H/OM3iwIGQxoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu71Z3QsMKFWYBLz5RMIpvFHQCB6sviuIYeFPHinxnnFfSMJxIZd2dIRs278kJ59pdMPiqjzXtc5Q+BznW08bVcQOQ4RFqe9SgC1ZGiQ0M0RfkGTSSpgrRTmk+ktaYUVoC6+7sdgPH5QLidIjNPxj/GH/iq9ttawYTWEBM1nesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9x0tnT4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9x0tnT4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacf197759so3262905ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786155002; x=1786759802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bWoXHbpk4foxcIrHN4t0PDZwpmsKGgehGiQpXNvjYU=;
        b=h9x0tnT4DHG21LE0EQSEiQ7UibZ+7MrknKpJ1CsDPwmkWqDep011G3VfTzfAmb3eqV
         S7IaXeEyjTSCyTPKC5jvNUnIA8OMQnyHj+YZctl85dWifPbxdDzGGuvFnzVFz7Nl4A+3
         iOwJZVDO9c8ckDg/Hqs3SVOwBvhjssNKsw/sidE2+wc32EHoEleQk3hDyAxvZG5DrCxv
         xr1wS8+Ce9226munF16qOlX/sS9Da65mQCrAhGPHIC2V1tvVHg5ZjbCaoXmIE7Rs6MyF
         qmMQvhwsdm8OVE7FyiXwnoi4ivf11QYd24Kh5ToRfNwBQOl1LeihyCgSzD/BoZyzYhPH
         on/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786155002; x=1786759802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bWoXHbpk4foxcIrHN4t0PDZwpmsKGgehGiQpXNvjYU=;
        b=OhxK1knleQLTy64mb3Inywi2NrKxdfNrSBeQugjtHSh8KexEbgFLQRdj8JS8SUzBgA
         VcYXF+paCokXRq/Xc0/YtKEQNxti0EHKqNRG7JcvXnd4wM6ehEMg5Q/l4MisLqpIpvy0
         kiOLkdGDmIioBoOL5pM51YL7/vqYO293C5aA9zTvQLWktJvtlHieT1SlVQHUjJv0RF87
         Y4cI3qk92XZDBnFy0pbVyvMRZibHUP2lbM8r3ek1+aivKPhndVVLUHJzaE462wTJ5T9w
         RU/jX+Q11TWFgMMbmhGC8aA5F95mM8xRwrpcUq4ZxI3CbUOj1a/HaU630fg9Fp6Ukhau
         r2xw==
X-Gm-Message-State: AOJu0YzAFbCzQNc7jmogFRWe+1dX+5GYroKuA8iOjn9/ZbZbhZSaF5MR
	hxwjLHRRDWR78TeZBqJMMRMISMHGbl+2kc3+IU8b3HU306QDfmS0oHm+jBlKgSQNEEY=
X-Gm-Gg: AR+sD11VelsRo9IV8uit4JxpY8uNvxrlhu+BreZ+QybRAtOCoYWwCWNerwkWzCJQlcZ
	YvfeYNNDcC+YWN1Cxm05mi8SwkciMA4tFwdexKywKEs0LSJZbBP26gCGxRIRB2H1QwYNj5UmxEf
	oWxH1vUoNt4St3nu6405FzumhyGqe9xQxsmM3M3sJirhvB35mkMpTWyjUQrFE+8cfljjN7dN2bR
	mRWKk6LNrFQ+BBUg/Cc83KBPgcfNxazqnfZp0HK0P8Et+wOLTu7IIINsNfZFXqAZ71k59NfaraH
	6VEbwzac2ks1GLP1s/22L5w/Ja3z5tJq4bRrN/sZ6ptn5Mb2zhBVmgSR2UEa4nRCPMSccXBNvAm
	DcbRn41ogsLHQ2leD+rEhU81Ee900LT2ZW2dJ0505Wy2BlpSfw94IYzoR6UfEcqoL7fxBNv9YFA
	7Jo3hX++uLxWjt3wTLTlS+PzFa5fKCliVLEbZNWH/bkY8jUWO5GGTyQnQztllX9z5UVVJMyoOs8
	2Z+QemrkffAhsWiDkhTm+RzqEvtzJZX/bI+0wB4c5XxvAjeW/NUdA==
X-Received: by 2002:a17:902:fc85:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d294b44102mr107977335ad.8.1786155001847;
        Fri, 07 Aug 2026 19:10:01 -0700 (PDT)
Received: from ubuntu-openwrt.tail1b3f25.ts.net ([123.201.0.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e917sm14910162eec.5.2026.08.07.19.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 19:10:01 -0700 (PDT)
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
	j4g8y7@gmail.com,
	robert.marko@sartura.hr,
	Sandeep Sondagar <sandeepsondagar@gmail.com>
Subject: [PATCH net v2] net: phylink: treat PSGMII as an inband capable interface
Date: Sat,  8 Aug 2026 07:39:55 +0530
Message-ID: <20260808020955.787569-1-sandeepsondagar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712194937.785825-1-sandeepsondagar@gmail.com>
References: <20260712194937.785825-1-sandeepsondagar@gmail.com>
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

