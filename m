Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57F2E7390
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992285; cv=none; b=XLIPyX38jYEley+oQjZ+32yfAdJrPOfVUPgJA0hGJ5UFX1OXXOgGLlBk9p+2hTEXlt1+TTAqk9PRHZtlx8vlNe3dQRKJP7yzB6S0rK/H5endSpgtLw5Jr2wrBEnIFN+XaxbeEf/n0VbRWAfWt4ZgsJyOktoqH58yAJOe3M0K2JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992285; c=relaxed/simple;
	bh=urFPXC2bDGFRb3YEWf5ToWXnZVSrmuUPwVRzUD+dqlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiuSH5nNbujJ2EqyOyY9gSnemaqsCKbI5hLd/hZOMyErVlr0md26NEN4apIr7nCvcUqpMFVGDWVzl8mWZMxEOuARQTIUCu0HaBCEYEInK0r1Q2MB8C/YhWENNFKBgN7Dz2u443nrhnv0VUWX3bc6XSvJSwtt17I11l/rYxf6J+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUGcmjJa; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUGcmjJa"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1671583a91.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784992284; x=1785597084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
        b=HUGcmjJaF49QjZp91ug3O3BARHAqXMAghSBmeV8elA7uICu9Mgt++EQR4PurpIibcq
         hv1OwAT4ZJFydRiG7DtL8Ra9AVsAb3OxY9sd/mwa3Srnj9I74iB5o3/x5y2Etna2zay0
         ZPmCl98JZGJE+ID7ESNmnGI6SRT7NJl33hSjVqFbSoKX0KfCclst1dCNfXbHRrjEGFQl
         asRFzg9m6hHIXM3q2X3G2BGtH38q8FlHV+ZmocWzYSPEE18XQ1U9pm9EZaAKnISxljSX
         kUG6KrspIFthPZ2wprdiaxDwdzl3DCL85xhxYouDhL8eai7hQZD+/3vft3yy4MKWKOHh
         Hq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784992284; x=1785597084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
        b=Y+j4XsL9u5pl7ef495bloKnToIdw70XvnbLNLjEheT3o/fsIi4BZ5f0SSSgugs6mKX
         5BRC0N/qoJhzEjU7tDSmccUHIqGGrYhjY+8xawba148XfbZ+fdR87kp1btbo3ztVkx8q
         9XL8faYG9Qt7KkQNp4jE5MH9Yt+WGFlOmxCSUDKWhQZw0nrbYM81lkyf7aK9MbHfgPc5
         Kmn8Ss6yaOvUwMvF+TnsXZZ/GobfxILbGsbVmBkej5wdPOC+qKkQRYmTd/uMqW/nzGI6
         ESyhI5BQqLUrURmc4Ue4ynA7GklAOBuh2yjR1RMa+QLrliWY1IYkbSvJrntK8M1I+0Ak
         pa6A==
X-Forwarded-Encrypted: i=1; AHgh+RrZTAKQAIRGcYdp9ioHAklANl+yFOim+C8AygEWGYF+mN4FEEQ54cDfAQ36VM8QhXBhmhiuckc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99bjVDnk/wDviQ4OBCVAMJDHZRG6IW7adobpqcKASOS03zdo6
	sH1n0dSoWsvDEM38WG5+eSSXtA+T0yAMSOAFJEP9PougW2HrQBBRfV1a
X-Gm-Gg: AR+sD135KViMoDwWYGwZM00ceITMH1qvK7iDiDMbVnt/oSCN9kSAWn8kmO3r6TBJ7aU
	qtJwBxHJGdVuBIU/5r2G/JqKWQrMhVUC0xnfknuxU7q43gJRHmfGNant7GEm+3xzj+tT15cVklN
	jnNt72H6LliDlK2NmM3pDnDSVhbwGZxSusF5nByddIT9wPuDDS8sHwjeLkhwFF2yNrA/v8HKLQy
	gyQ1HWdFVs6k7smwudjQ1zv1a+8zDdopnGLrvJhCxVrb3ZFvDZ7+sIMyuRIuJ73PtvD7f5q965o
	20W0vlEh+Q3Ro8SeQsbIWSmgzmKG3sc+HiZaeEf7TyeKWAHbi4XcAtTg3AJ8zvY97pLJwys/yj3
	2adhiOWLLltV4a1JqKppRjEFWRwvfNGCmIoSsmJAy0OvlWFlKaj1rTR9aeyZJzbAePh10vFRZGw
	1PVqDtGEk=
X-Received: by 2002:a17:90b:4c8f:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-38f294f144fmr2785423a91.17.1784992284028;
        Sat, 25 Jul 2026 08:11:24 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f031d1d6csm2907665a91.0.2026.07.25.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 08:11:23 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: kuba@kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: intel: remove conditional return with no effect
Date: Sun, 26 Jul 2026 00:08:52 +0900
Message-ID: <20260725150852.859188-5-ekffu200098@gmail.com>
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
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +-------
 drivers/net/ethernet/intel/igb/e1000_i210.c | 6 +-----
 drivers/net/ethernet/intel/igc/igc_phy.c    | 6 +-----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..0cd0e5597c90 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4864,16 +4864,10 @@ static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
  **/
 int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
 {
-	int ret = 0;
-
 	i40e_control_rx_q(pf, pf_q, enable);
 
 	/* wait for the change to finish */
-	ret = i40e_pf_rxq_wait(pf, pf_q, enable);
-	if (ret)
-		return ret;
-
-	return ret;
+	return i40e_pf_rxq_wait(pf, pf_q, enable);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 9db29b231d6a..784f9a7bcbed 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -756,11 +756,7 @@ static s32 __igb_access_xmdio_reg(struct e1000_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 4cf737fb3b21..b758a7e0f013 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -675,11 +675,7 @@ static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
 }
 
 /**
-- 
2.43.0

