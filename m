Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5738C2A0
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201944; cv=none; b=pPcdraxa9bGOrQzRxL9bP7R+xG1KXj/PXrKyrnulsoxVtONuTW1LS6Me+cSU6SsuCfNPsbf1yVm+ONEjVh17/0AOUwIkkWxYLVQS/O+A0P/gkeivJVw9R1eSOEDXpe85YXGspxCDL4Ijw13TJrW+V++wT9afxtGqA+zWh0CnVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201944; c=relaxed/simple;
	bh=YJmm+HKpkkiTdwMwesviCNckrbU/Cp5fMed5bjBfz9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFGGtbm7vEQPYo+0GF2miqlNOu/OWufKkzQbXlSBpVaPIOor7UWN49j5Mx5mPoQod3DwHZTGueOod4pUtIkl0VbgDlby7SBpBvtE+5Kl2btUxSRXpbUP1ZOijCCXMpkB4qNB9OyfUvdPDDRh+fp72fVK8pDKKp87M8jkMKIunIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iakbT8hb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iakbT8hb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so4108629f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782201941; x=1782806741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELOEUuutMxNNAMcf6UDVW4Cm1ruDQcVU3Uet78R6qow=;
        b=iakbT8hbvg4Q1DQ6NfFJBQaBRTO8rPsysEdYke+fvn/GboCOpElmJyPJssBY5AdpFB
         VoqYBPvUHO6V7SKEdMm90a+b2IF9h7xsSF9yZoQ2d/shuecRQug9F3J7OLTmZAr91CmL
         8YpRc1VB0rfQSVrVZTbASKuKakW3NphsY7LgRYiMfdd502sNkyaBpGzjvdze8TC4Q1Rm
         AH6CZSlDf7ZRdRySf125rBB/S5acauP7dEeA5AVGlRFwIm7Axer9zIzTB2FXnfosFpp3
         O3qefu6L6lxmh12Q/NO+aHruoxXLrxgHolrBuUUd+4XtRMt4PVodXEDkcJUAxE/rZfvs
         mOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201941; x=1782806741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELOEUuutMxNNAMcf6UDVW4Cm1ruDQcVU3Uet78R6qow=;
        b=BfDfipfVq+Gxv/ZPttW2iuxFBUs5pDkSFUzICggVQJH+5FRHkxzJgyF45HF+gdHYHy
         7KsoTm3gckAb5LgHKwOCzqk+3zoVA5zZcBsLLsnc+sGP5bFg8T2DRDQBZBrkqg2SYcbZ
         iuKb0wzqLq90LMBpXGnjqW0Vv1spZMGFwC4Du86RRJ3DeKryc91QygnjOZ7SsgmhEEj5
         dwNuYk9fayFDRzWAg1V4VkCB6WhM5JENZj6JaOZZlF+YgWyNC73uHHHnY2+rMaLnRaKr
         W6v5f7s3IuEVjFe7dwnteeJFiuJNyShkna9NBYPcbU+DGQsFcc2/mP+sEqb4U+u5oeDn
         Jx+A==
X-Forwarded-Encrypted: i=1; AHgh+RrEh22vyWKKMFSpftTWC02cdzp/2NqfWSQvPCl3mgZh2PquiChOWbvr9nJKqSm+WyOmclHGcrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXml9+hD5YRBIFVlNjwe4GsbYUfpXp0H04GcxT82SddTdkbq3l
	3oSR35PSiSU8qZYJHT6VuGik47ZhuTiVRjtGIWbvrzpF/jjereAAM3NP
X-Gm-Gg: AfdE7clcjbTtw0wcrH00OlZQR69m8Epl2eQsNcQ/0T7qrK+mY/QvLvY5JOcXAnTY43k
	dTlDCRr95YRONTjHxxH6F6HNvuWpbVuidwtwKAYY4v7qpY4ecREnv5WmIK3Wlm0BmDix6Ocil8X
	hTVL6rOLwZxZYyeuXYUqHasCSpc17HIIudzxLY67WvuFFVW6YvsfSbOZ+A/a7PdV+NQ0wveUNau
	iVgHW+oYxHLlsD2y64twqltps7twk3t/WADSoTSJ9Eg6frpjwILd23CRy/ZHRpH2JX85UdealLH
	Tq1VgBUOdkceaNAUWgfIDXm2lIGMOFtOVrcQ2BnAH1MmzzhdY+aBobButbldbuBXbj9Q3TjbuM0
	KAHdbvDJDUadj0AAurgAGPs3nTX/Wo7vUz50dEuX/smDt0B3nJUZvti9oko93GvbvE7IVJbjMZs
	aMGt6Y9IuNz7PHwm5SVusjgulC0UxZe+lBedOZGJyoUApt7c6H0JbJ4KqB6e19X1nSLMK+sy53E
	3oPNulFX+mTaOU8Cg==
X-Received: by 2002:a5d:6f1b:0:b0:461:a161:8101 with SMTP id ffacd0b85a97d-46adb5875camr2438044f8f.11.1782201941275;
        Tue, 23 Jun 2026 01:05:41 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46667221de7sm32486503f8f.33.2026.06.23.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:05:40 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	olek2@wp.pl,
	kabel@kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net-next v3 0/2] net: phy: sfp/mdio-i2c: defer RollBall probe + fix mii_bus leak
Date: Tue, 23 Jun 2026 10:05:36 +0200
Message-ID: <20260623080538.7646-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series resends the RollBall bridge probe deferral (a fix for the
regression in commit 8fe125892f40) and adds a related mii_bus leak fix.

Patch 1 fixes a pre-existing mii_bus leak in sfp_i2c_mdiobus_destroy()
that has been present since the helper was introduced in 2022. Patch 2's
new -ENODEV path destroys the MDIO bus via sfp_i2c_mdiobus_destroy(), so
patch 1 is a prerequisite to avoid leaking the bus on that path.

The v2 deferral patch was corrupted in transit and failed to apply; it is
regenerated here against current net-next with no functional change.

v3:
 - Resend: v2 defer patch was corrupted in transit and failed to apply
   (netdev/apply); regenerated against current net-next.
 - Fixed block comment style flagged by checkpatch. No functional change.
 - Added patch 1/2 (sfp: free mii_bus in sfp_i2c_mdiobus_destroy).
v2 (defer):
 - Generalized scope: regression affects boot-inserted and hotplugged
   modules where bridge init exceeds 200 ms; Aleksander Bajkowski
   confirmed FLYPRO SFP-10GT-CS-30M / AQR113C broken when hotplugged.
 - Corrected state machine description (probe runs in SFP_S_INIT after
   SFP_S_WAIT) - Jan Hoffmann.
 - No code changes from v1.
v1: initial submission.

Petr Wozniak (2):
  net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
  net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery

 drivers/net/mdio/mdio-i2c.c   | 15 +++++++++------
 drivers/net/phy/sfp.c         | 23 ++++++++++++++---------
 include/linux/mdio/mdio-i2c.h |  1 +
 3 files changed, 24 insertions(+), 15 deletions(-)


base-commit: b85966adbf5de0668a815c6e3527f87e0c387fb4
-- 
2.51.0

