Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4D3C6A38
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786184472; cv=none; b=XENJXrP2hllkEJpRrukqfF/NFv7iYyRe5m/57Sy+AiRT5hwFyOgl5yyOI+fn8CA3QRLifznsv+H3QF+qktY+TVaqFx8c365Pe9t+IygpNiy5sc5wAqhXVoq+3/UM4Axt/WoMYwWVgasxwghSC8i6mPiihpElqmdkLNGNQKAtlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786184472; c=relaxed/simple;
	bh=RXpVzpt7di1+nGOPxTbhDa4AoMa4uRQ9RAyXrUYqYH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cnesD5ThyY+oVvkCVjeAQNrspNUx7jxs7wl5zrxxtQy0p2N0/yDWbFk1wwkHXARCO7cCQVEEGsic1uOvzC0IqIpJshTb+OWpxKkdItLRyhmfFId5LaQ950sZM7e85FG1nj9i6iFUh6ySOHzNJux3D/q452er8U756rP3ZVBPPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quFBL+oQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quFBL+oQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso2861885e9.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786184468; x=1786789268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQRg1mejXL46bQBa0p78UFbpH6Ut5RwhVRoCIO1su08=;
        b=quFBL+oQvWu8pzBnRtRQEKaW4d/OVtub9aNNuJ0wiEJT7nJ3d5B6i072GUnY5muwZT
         90yZIybX+v/zMJyK0ci92DEUPp5/PflLc+cmDhS5ztxH0Oo8RNmsrqaAYJkIXNpQGaqn
         KWwFuz7rv++8A4YW4EjT6XQiGFC7/+3W7TVGOogoBPwRPc/RJ8vOWIU5MuwNUNR6IJJ1
         Je+oifvhzVdJplKJ8Arnucj4pFkAQCLxmCZQd7tUt9Keiy7NPAEYvm2zWsKPgkdOnKdP
         JVoFpt1h6R50Ys6XTLfLstTB4kC11r1wYyUhUN9+/Avga/Efkl9cof3N+wHUcitXzVvN
         1dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786184468; x=1786789268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQRg1mejXL46bQBa0p78UFbpH6Ut5RwhVRoCIO1su08=;
        b=ntvtSS/z18pMZmHE7fsYQbUydfW45xkeqNxa0WcBX4zo3X19eg9SVSMIn+uoVKKe4f
         FexSjvZCAELsfEaIFf7m6NaRgNiKVHVCal16p1JRdRrqKOA3hr/qdMPTbrvSCpQKPftO
         /vABil2EObeMV68GvH4T+DStDYNwp6S7os5MZAy5MEfOqJtsFmKgogx2XaIYocotp69d
         d8hY1+XYTSsAusHY211cJedowPWNZ3U6HxcEfpZ+wI2InMqRHDmsT/UxR1LWyTfpnK4B
         tG/CXaRdcUkAetpSDQXuOPwnxbu5dGXkrtcVGbsyjvWL3wp8PjIccL/WeSSnhqlFjgwO
         GpyA==
X-Forwarded-Encrypted: i=1; AHgh+RptQvnWcfvHvB5FX1paehLKKrS6VtMo+WH5g4rIvq+aGF6Ldb7ftpwsf3cviTbD02hoYxhJ/MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3qSOs4F/RH4qLbUCn2/ytqIWi3dyEMeeLNNzDX7uYaCMyta3z
	rXHDc5hFLbL1xCgfgbiN2kce3qDBxq7wWA6CcxXj7oVGEHpGVC6/ilrp
X-Gm-Gg: AR+sD12UxRbgPsapvl2IsChZ2Nv5QY7VAFUATKecuKtMWGMfWXX+tNMr2n1dXRMn4sb
	vqTVsJZAvF8nLIWQA5E4mNPCvcd+jYYHUXssxnR2y/9Vob+u8XI4hPZgZ1B6GGFMYC5Gfw3v8RW
	ljqb9+nA6dVwg1w5gHLfQ2sAVZggFlo17GXAjn6fMzT2Fm2E6PedYzrKd8apgMXmclk+dkB9jhr
	cX6gVwMznex/2dX9nyE7mbNkUIShyTecc6gfDsfrqXnNh/kwtTYpvNLEt+jnRE5uWauH+LMvnco
	juWlPA2cFryV91JiBL9tf5R8+s4G+AJgv4kqVRDzZUpK1ZqK75BkT/kLQacNE81PAaAijNNPn8z
	VXjwYhFE+B7j8K2TlJCHN4h06/QfXiqcv14ifKL34Hq6bM1PCaHjfuPhhxhpUx4D+3UTeco76MU
	ij6QdDp7Dv2eODHpEth4pP/o+FyWVDqKvGzQ5HYFCPcRBPN5J5/DrGo2Y8CH8xkW5zp6Bs4a/oN
	dsY5FWWSu1EARdWkyuCn4aWVj5nTVxs6NLcvp/6QkODzQy/bE7a9uCrsdaDK4Ak1/Fsxfw7ngfV
	fEYGld7e5LTp/9hyp9j1
X-Received: by 2002:a05:600c:1987:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4995e0dfb2emr138243805e9.16.1786184468167;
        Sat, 08 Aug 2026 03:21:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm15256604f8f.18.2026.08.08.03.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 03:21:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Javen Xu <javen_xu@realsil.com.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] r8169: give RTL_GIGA_MAC_VER_EXTENDED a distinct value
Date: Sat,  8 Aug 2026 12:19:41 +0200
Message-Id: <20260808101941.57666-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTL_GIGA_MAC_VER_EXTENDED implicitly follows
RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1, so it has the same value
as RTL_GIGA_MAC_NONE.

rtl_init_one() therefore sends unknown chips through extended detection.
If TX_CONFIG_V2 reads as zero, they are misidentified as RTL9151AS
instead of being rejected.

Give RTL_GIGA_MAC_VER_EXTENDED a distinct value. It is only a detection
marker and is never stored in tp->mac_version.

Found by Clang's -Wduplicate-enum and verified with a QEMU stub.

Fixes: 5e3c5a2b85da9 ("r8169: add support for extended chip version id and RTL9151AS")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 0b9c1d4eb48ba..fb772cc043105 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -74,7 +74,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_80,
 	RTL_GIGA_MAC_NONE,
 	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1,
-	RTL_GIGA_MAC_VER_EXTENDED
+	RTL_GIGA_MAC_VER_EXTENDED = RTL_GIGA_MAC_NONE + 1
 };
 
 struct rtl8169_private;
-- 
2.53.0

