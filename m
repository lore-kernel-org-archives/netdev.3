Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744093;
	b=M0eCpR2pLF0pmypN9jkHd9FZeRmLA1i4T8klxFSrSjR5GKPM94p4lsAfpDbiqTRPBGQp
	 cHrTkBxyFEMmwM0NbyU+QBKaRO8iz+QQdLlrOM95jlIqLKIgvDpgho5RYRdB9yYoRqm/f
	 970mA0SbYGhCyA1QL/rfwnpbRbrspERZCLu6THBZmEdY1RrJbolRPe4NlXhiZ3R+42rKi
	 09H+61UE7BCwWsYQDZkNncM1fqvZi20+gkL+nWzD9XkauWF1uGXyFogyjgP8rxRZEMYCu
	 91/QI0g7MtTvMNWp5fFuHB+aKGoS6onxPtR1WHWFf3PoVtmbakDZN6yqwFdBcF0vx5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+Gr5bWZcYgumQbnVFUL+12XP1Z/UJrPiizeHxuglwVk=;
	b=HgryekwMSQp7RQ6+TfpWAR8ZSzxB6OfcE0oZDhULwSwXGvPV1dWBNRXK1Q+RfbjTg3uF
	 9ZmzUaIAtvjcna+1Yf5dB5yD5Yh7by7P/d3AdX282zp+3JB4TcxwvkJoLuUeO+H81DrYd
	 QdGtLUkiVcnRCUlIyGam7WHEVftJ3ie0RkLaW1zrd1h81RFx2Q2gw2rihaolgUNATAcW8
	 zWOBDmwmnuBc0KiC15PyX5k833Zyc+sU3oej/K4BY/jSyxWLdA6n6GBbsqANBe+8si81R
	 BuejbfNMXs1NU1EaLAA5W9Ps7hJ6TUD/Qac9ofuvCkyknMoKPJGgrwzSeGirwCK8h3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nc3fbsAF;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F610606D813
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F610606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nc3fbsAF
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48fd2e38825so48622f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744091; x=1794348891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Gr5bWZcYgumQbnVFUL+12XP1Z/UJrPiizeHxuglwVk=;
        b=Nc3fbsAFwQLcZ+tb7po6KLX6VdqQ+Q6fQLjoTUXMMwFjDeKa28sKPm6Ji9A/N+75Nl
         jgWylAHe57MoMhsCSYmX9/g9xE5ctQZtZqXTXVyEDthM0Xaw95kMgF0Rnr41U+4xToBu
         9oveUtKAeRyVgFmYvUFW84WYknTA1FCmEKlQDT1S2SnxbNSpbo0v3pOI6VAy0fuupiD0
         1HnldulSer/eS52AbkIYCrIcsGLnIyzhCRMnLoNX57PTOBl3/1NN6a/UWLo7+G0NKhKJ
         j6rSCfNt/qMScvorIMP6m9DAhhevIBh930aF02E2DtBSPFlZhPDcHZRjMIKP9dt0UAP/
         yD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744091; x=1794348891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+Gr5bWZcYgumQbnVFUL+12XP1Z/UJrPiizeHxuglwVk=;
        b=JR/Ngi6TVjzexa8eyEzLnBzq7rbSz6AL/MeLVua3auM/vNZkGcbRMpyjiMDypANNAa
         QFXptmU8SxRe3QvQVtcaT2OMpMejt4uMt5QeeP40U7CrPQpbjGrdbug9j738evsmEY+N
         Ogxz4bviC8eonLZP0fe6fhCj1Lktp4VWmNXpKMc1VLbeJ/j5H7rLOQkwJiDl8Z7PCHZs
         njuuYxqtFAza2lFwoHOTmxSrww0x9JCrYWUsk3hyx7z/WCzRsM5Wn1hHX9V2trAf+Hrc
         ZZb78BmZK6mh9MOOjFHwdvnB0Tm8VIwemp2jILPt9FoMF5wYSNlmhoESgJPeTeeV5mnk
         Nlrw==
X-Forwarded-Encrypted: i=1; AKwUvByAfjprQjx/SyXuxFNCzAizHOJKmZm3NRtxObMRaKijDa49+h7m5N92QtcHr43qStmK5FnD+u4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Kj0AM0cd49KW29d4iIe8bn/Gco4/ZcE6paIT0y+hfX9pyuNFA
	nDS7mZwBwANRiNlph2UH2GfLqPSh4eRRozP9sXiAOs+EV8ILZxdzbdzkCsvVAA==
X-Gm-Gg: AYBFou0qF+PYY+7EmNHUCxTv46QtracZUF/3M2HqBmYYSGVlsIom/+Xr/9g86/QxegY
	SIuwCZ5W0gxxzLR97t7Oo8B8qpEC1vboDt27uvEFiffo3e74cz91ISJp1plpuPkoH1iCWU7PBsP
	fh4tjGRLyiIiZmdweH6zO39dLgTVMDBJf3zILmTY2/alLRGgSXiZWTJVEmSSwjgTN8/Mg2VPQaR
	VWfdbMoIy1M2dPLXTVk3hslWlZel8+zeVlUsgrWHqcOKNUd8vzTOJVC8nlCJZhJaOf8zBTtKWfL
	xaeZe4eT06k6JDtI1y8DfqJ0U9Mfbkct5cQSE8mGzkva+gvytvZBJJXmWvazZpNhuvCgNzCWp9q
	kw+6Ib1SyWEnwE6yhu9S7y4GaofouSKTIwGwSKy4mKdR29F+VnSEgdVF5a7dWm4Suryvjp22G3k
	69dAythoIVAi9LAP2sGWEiBFhu2ex07oNHkjfSO6vXOzykE3/2MU6gzm3hXppOHP1RWk3l9CbSi
	xidEwgfhFxYfqMXyz/MRziyV0hPDa4AYI6gxBWQ5Y5Yat5Rl375Ig2eQAlFgpzvDHILLxvRCC+C
	O9gMt4sYDdJE/vcxG2eo8BPTB+5RMMwlwRMVS4K8jLF0bH1S4rBZXGlI5xJfT51l5nOcQBIYjaG
	NL1LNyk5sF6GtFdR5x0aB9KctWhYXXgWmSQ==
X-Received: by 2002:a5d:5d06:0:b0:48d:ff71:dd87 with SMTP id ffacd0b85a97d-48e6e303f29mr32359299f8f.17.1793744091527;
        Tue, 03 Nov 2026 14:14:51 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm328556f8f.14.2026.11.03.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:14:50 -0800 (PST)
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
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v4 1/6] net: phy: mediatek: export __mtk_tr_write
Date: Tue,  3 Nov 2026 23:14:32 +0100
Message-ID: <20261103221439.30502-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103221439.30502-1-ansuelsmth@gmail.com>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

