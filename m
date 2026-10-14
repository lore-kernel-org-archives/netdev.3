Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F647F2E0
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962283; cv=none; b=hZ2rSG9nJErAeX8GczfnoUEElSomc+H8wkMEDy1PoKk9jjfa3rGIPTgFVXhQW9ycYISdEIrZ4+dVZz/E/8LjBBB67m9Xp0mYqMzzJh7K0xXFjlmziek3n4U9Z2C21MYIc3IUUDiPqKuTyj/+BJuZpm8ckBPKiSAdKx4FXT/vOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962283; c=relaxed/simple;
	bh=d4GLcb5Sehan0oOBDRGYh5uZjLzRhyZtSNxK5RqNJZs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLFb48gtsQPr1rCTkSw1W1iVIrk9XxX/+HiHhWIyJmEPttzqPFB4CGJcBDD8qDQC+FvZr8VmC4Vjfa3hCL/Egus0iIsYp8KI9p5/Fa2WxdKqqP9EWJsvYpGbD9QVh+VSPDr7r6S2A4vvSZARu6uJ/puz5gS8AxLxxlB1q1jwzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfDsyo0f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfDsyo0f"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a16c399641so37024035e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962279; x=1792567079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Gr5bWZcYgumQbnVFUL+12XP1Z/UJrPiizeHxuglwVk=;
        b=lfDsyo0fqAJmiMO6qfwJnfuaEuU4QXcTPu4n27AgE7xoKpcRLA0vARvn3hwN/Kv+ES
         9MoSbXs5G9Br3+J7DIfeulIQszoxluJ140IkTPgYoAH2fVUWo/sbUXUm03S5YTo9W4IC
         OJIt2+OrckKB1bw5q69tB3qPmDVlGXkTe0e0pYWsovRnO+7dSYg84AUCYD+fPFlqGVmE
         GYmDb0qh9EOHEgqvcdyAx/fVKj+nLBDgeCZkIR0lNkaYm+oqUxgBsYwk1/fBQSLPBjJn
         uGRPyr9Drk7erbwyf83NjkMCLar4b7w9FIePp8r9PiVAlp9yrAuooBBr6fNJk4vNpRTi
         5bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962279; x=1792567079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+Gr5bWZcYgumQbnVFUL+12XP1Z/UJrPiizeHxuglwVk=;
        b=LfEjiczLXlEGvldbYAi2j4kCXWTglaxw5hss8zPQ+QKhzq8Vs4xiIK7eEIdEgGQBME
         OjPKvE3ll446xJeCSgicVsjh1mwfwkauwdXdlBQA5z7pj8931zYyv3udNnQp87SqNKKc
         N4xBK2+2VkMvkLLzOqmbUR77ee0jXMAsD0wAkxnOs+u8yqn2hlxEo9UwvLpMx7vbF23a
         DQjlTK83fX1W9iHk/hQ1fir9pxDMk5b5Oh5zveaeO6JTVM5+2dizNdY8DTEPvYryMPxp
         oe4fLRVrrgCqZyYNcj3EIFbXa3WbFxlnY5Mx7eqS8z6LGf/AwsDhkOTr5RQXop3bpPLk
         lDGA==
X-Forwarded-Encrypted: i=1; AKwUvBzAR6t2kaEMCZIwLTSrQnVjS6wwtJV3EYKNoXPEprsMLbLMo4BP03lqLF5g7MmjrTDSP03S6c8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWJlThlhZ9yQQ+TWpgsbPPBfB6XpvwgeYuWrBILcd/BUKqChpY
	mvaCDFG45jvv63eFvcGJMvzuvuE+5FbHJ9CPdId5oNimduZLnzxXfNeL
X-Gm-Gg: AYBFou2nbEhM3oXoTFrBVkfxUpVrTXrOhepOZCSEENvhH382QHCi+VwoX2ymqQblr0u
	fRJPtP24pnU7zeRvv3+OnUGa+yT+6u8ltKdA7R27UdqQdno+qTwxNaaqNZ3n1Idve95wMIZs4o8
	xW8mi60nsdwShwMB1tjiw1Wd2OBUtQw75KCI5kVSKcdezW3LIefjKt4nETBZT4gOjrAL+RqrqR4
	M1/Mshdcahg9ts/JZG8herXgKlPzicMMVNBhroQVz/30fY31VbXnp5AcIjgWcfVO0gkxbHfsoZQ
	Uzw7xE9M2XV1gXe5H4/hWCWFctKdDKzoVoEYTifTi+BD/OEpCAm0TsZoQGSuZVGbdcqDxWrfItM
	yQYf6EB9H5hpDzc4ZNcVssnySZOuNZHGW9Bs3L8dXpWVPYgLjszImLjJYZts+D+creBy+8IvBYn
	1VtLwYznPDuHje2toatu7DzjOGYZHirWG2jDLLMuzoMvUkIkVukANcdZLNv4dl/LDsN3vRZsKwY
	eXDs+5J7qbAkmNEG8BetsTkhcCHjFwFEud79z1f06SRlIYxZKz0ODVLVMSMdsuMiDpe9H7Nju1k
	H2KXsILtif2Xc75h1BeDR4SZYX5R8zaW
X-Received: by 2002:a05:600c:3f0c:b0:4a1:85d9:13be with SMTP id 5b1f17b1804b1-4a18e498471mr318247985e9.20.1791962279370;
        Wed, 14 Oct 2026 00:17:59 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-235-252-189.retail.telecomitalia.it. [95.235.252.189])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1b35d64e4sm18756285e9.0.2026.10.14.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:17:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ahmed Naseef <naseefkm@gmail.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 1/6] net: phy: mediatek: export __mtk_tr_write
Date: Wed, 14 Oct 2026 09:17:32 +0200
Message-ID: <20261014071739.216345-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014071739.216345-1-ansuelsmth@gmail.com>
References: <20261014071739.216345-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export __mtk_tr_write to directly write to debug register.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/mtk-phy-lib.c | 5 +++--
 drivers/net/phy/mediatek/mtk.h         | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index 4c4eca870bde..3e4fb899a85b 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -36,8 +36,8 @@ static void __mtk_tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		*tr_high, *tr_low);
 }
 
-static void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
-			   u8 data_addr, u32 tr_data)
+void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		    u8 data_addr, u32 tr_data)
 {
 	__phy_write(phydev, 0x11, tr_data & 0xffff);
 	__phy_write(phydev, 0x12, tr_data >> 16);
@@ -45,6 +45,7 @@ static void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		tr_data >> 16, tr_data & 0xffff);
 	__mtk_tr_access(phydev, false, ch_addr, node_addr, data_addr);
 }
+EXPORT_SYMBOL_GPL(__mtk_tr_write);
 
 void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		     u8 data_addr, u32 mask, u32 set)
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index 79e09727b81b..3565e39b96a8 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -72,6 +72,8 @@ struct mtk_socphy_priv {
 	unsigned long		led_state;
 };
 
+void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		    u8 data_addr, u32 tr_data);
 void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		     u8 data_addr, u32 mask, u32 set);
 void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
-- 
2.55.0

