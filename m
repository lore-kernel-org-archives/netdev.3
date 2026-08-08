Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90D4C6D
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786154986; cv=none; b=HGoj2YiGqJdNJVZ4DcremnW/yA6pJCzNsZrFyJEivVzWTq3cCh/kOhgH2VEVSXbyyE9mlQOI5inCvD2vZ1DjM4diiuyqRMs2AlhF91NZktASPEmJuzt90sgRVvzfwHsAGCTmQ1ov1KHgLUz6d2gLp20uW26D6kFc2b3i5JD/XbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786154986; c=relaxed/simple;
	bh=0Hj0QlaYSTyFYEXSfFbeWe+iEXPNu+H/OM3iwIGQxoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5uzqV1UJ46KIThIMJcD3TZAVjot2o641LGKH0lQouTBx9micxZFsbihQ3Np1nqVeSRyFYmg0jupv9w8NbmObosBWxLPykaniUKnJ4wh2GHlwBXuEIpoyD7R5qcaPdKbl0npwhvLXWhMu4G8v1lDRf+SLLoWDXA7hAAnDT3AUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkJYFvcm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkJYFvcm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso2115265ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786154984; x=1786759784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bWoXHbpk4foxcIrHN4t0PDZwpmsKGgehGiQpXNvjYU=;
        b=DkJYFvcm5KXWLTulE8gG5m8ceDKo32Jjld+fn/F/tt0Rm2eaGM8JM+ZLefJ/l4UTAH
         FUM8O3kJmk9boVjvM6aXTcArpyChTiZ/KiTYHhpjWKgPp6ak+FtQ8tcR1TPpnonvFxtv
         oU9X3Buw+54mqEGLL++h2lGDs0oIyCG/iZekdIQeoPvVTLqSs4/oOFN+UnRfXV+8SvKx
         VAwCAUTEaXVld5hUG9WdOiQErfKdd88U7IHmAQuNa/y/sAqPTJWz7cR7MzRZp/uFxoWi
         6FgXcSW9s12qXVpLHik93m0Ol2rxzGBckjGeh2Axlv2NnVtsS57oVXI2TCMg9hj5RRCs
         M21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786154984; x=1786759784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bWoXHbpk4foxcIrHN4t0PDZwpmsKGgehGiQpXNvjYU=;
        b=cvKQ2HRhsY+njYSqO1mHAxSF17xVXgVT38QWoyIA5/N+24ZbN0GGy08cadp4gPxGvc
         nXOqgQcLoIjVxKxdYbn2XzG45M+AxQdJNUB46VfD3Et4l/t8Wnd1huaK3n0mA2Tdd/bt
         ZHcgMYWas70kY0G7vvdzfETisSnpR5oc9jEpGDLy83lHWLKMULVC3Zi3CGkJQR6B32Qq
         ZEw8uXaheeFGtLwXRo/J3jRfsnQ7/nxKmjzDmlcdOysXhKFACzhWCMw+Q3n/vXjL28XV
         EWsiqwnSqZDywKE7Wc/BCHApCVS4pCTXySplk8AxR6k+LFrIWZEGTzkerVd24489KXbr
         ss3g==
X-Gm-Message-State: AOJu0YzafuzcwlTeZNS2WNBdgmkW5SWqbeMwq45G2EmQAoPI9foqdhVO
	TawXYz4bnFjrCtHT8a+3tzR5YABCXuiodCCTdhfLbV/2UL+BkWM3mCQOOzTUONCwGJc=
X-Gm-Gg: AR+sD11yLOM5BRyHeHw2uLAbQOGRqShvII1Wrr68ot/NdUyUEeXiJwboTNqTYsUH4LC
	C/LaYaoiyPRh/zA7bs6cEtP79WAyBimgKLhW1khITszYp21pNbPaLFB6McETnahPNnaDMuStwRS
	eotPciP1e5IXUXB9TW0y8A8XqVWaCqxPjFfttp1xLpL/bpoKECbBRt3YIF6s0HccUHYx4OXejfX
	ypPkzYm3IumK1CE9oGDPIduGIO9M5xx9o+bsCLUC4rhv4Y/8y3+3eJdQyJYJY8NBsOmJ9SO3X8U
	6OwTO5fEUxM69wmQaRWD8iAnOM6i+Do7hVB1VbJtVlr8Czn+ZBIrQdvTq1GNvxN92MwQJM3KvAT
	mjwGpNkxZOY16z0Oeg+NgirmnvEAL21cm+wfV6q8lSek5nTc2ofiN54fWpQLuWeINp+vTFbOyGj
	2OtYGWuxa5kX/yuF+Z3tUaaKOhA55jxUMnsm235vtTo03oIyWvkLQMwe+lEFbo6gb9aNO7lLvxO
	cQFfEIF17JgheaTxZaUbNaQd0I7fJUO3+am8R0LK7WysjvskwAP+g==
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id 98e67ed59e1d1-3903c5c51cdmr28221153a91.17.1786154984223;
        Fri, 07 Aug 2026 19:09:44 -0700 (PDT)
Received: from ubuntu-openwrt.tail1b3f25.ts.net ([123.201.0.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb87d3bsm13851142eec.14.2026.08.07.19.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 19:09:43 -0700 (PDT)
From: Sandeep Sondagar <sandeepsondagar@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernochenel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	j4g8y7@gmail.com,
	robert.marko@sartura.hr,
	Sandeep Sondagar <sandeepsondagar@gmail.com>
Subject: [PATCH net v2] net: phylink: treat PSGMII as an inband capable interface
Date: Sat,  8 Aug 2026 07:39:37 +0530
Message-ID: <20260808020937.787537-1-sandeepsondagar@gmail.com>
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

