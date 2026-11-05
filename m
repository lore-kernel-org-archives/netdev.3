Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876112;
	b=CFCngSL/GY+hr251P0iEY5QxhKIyjqfd+uXx/MSSqvMUsevBOBgWnA3Yy8xRgfo5ipLC
	 aowQLBhlG3yXoU256lNpQhQm8kSUwodCDjsXeW9BJZDmFfGQaPcB1i8YpPFwn5y/2wV+i
	 pQ8GR7/i8gmtrU5//jtStkHra5SHo0hEbJSAMBBZtcCJx5bxKy+8eAJBmaF60x/dSTNoX
	 x5LuekoHwCoWHLza7KtMp6n/qCtYZFPU/rch83Ypc/377jMXuCeoclvxwbzOgk/sXe3m4
	 5BBdQ0FP/q3SSgjAc+VSw+Q672AEqKKrULLC8oqT3w89t1t9tZIsDVq6fZ4S94CE+jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kHN/2mSyJLVzMG4IiCrQSn1f2cnCCP3IrwJXrvsgJlc=;
	b=TJd873AO0KLOrearfmJSbOF/hf2edATlDEQdFw/tsn209T7LwogId1ea5TJSqrZ0fdSh
	 VE9B4ay3/dXe91jzzc0elMQKHcDCbIvQpZjKC//0XSPWBpArkycD9gS+OitwcgCBB+lQn
	 oauyF8YZfIiahni5cEmRu/ZEsSL/8IVp0JtJhteu6RqQlVlm7frTDJz55/Gqs5uewWMDf
	 SXKeRYFgUvP3TdZZTFEzb7+V2ZWpV7wqmC56VXccfhUO+jzFMsviHVbS7fp0vMs1sPa+q
	 iuUNyKg5Z+20TJ7iYdFmNaISZaBNzcaSidYagBu2IvTk60l+i11JG4S37dfsX5O4YQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynkSZpH0;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A7606D823
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 187A7606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynkSZpH0
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a215e64962so16105935e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876110; x=1794480910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kHN/2mSyJLVzMG4IiCrQSn1f2cnCCP3IrwJXrvsgJlc=;
        b=ynkSZpH0dHIEc/UKqrcYGoJ+M2xHHobP19pevRIehKmaqm4RtjAPpP9VywMj4oTHXb
         DmS9HNZi+YOZMsdeTmphTKgiqGVYD4c0Bjmg1kD6mzg9yKT3W4gfexMYRgSoWnZcjKul
         CL7Gwh9kHnUKrspc99N9tIh2q5kNV2Q7/Qn12T2qFVgmpLyw0qHkJX+2c/aCfVE0C8Mi
         myp3LbBbWoShXg4BO/bDGQUrwKUlrphrrfBkHADbA71rugnVZ1Diovvyupc25+0GeAzK
         MIJMYfOi0NZvxv9tcAb7oidOP6zGGsq194YgB03v+kAuQbxSr26VQjwC8lLvs3OthI5T
         DXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876110; x=1794480910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kHN/2mSyJLVzMG4IiCrQSn1f2cnCCP3IrwJXrvsgJlc=;
        b=GA3RBGDqDFq/huRZ899VfMWdZ+A0f7ZepXvpmNTUtQYUJcXHHx4YdCrOA2VsUrERJe
         mFgz0v1P2vkg+y4v0kTl83mNWOlhdoDmyPL62hg473AZOpvFNpxBbkCnNI40wvWIJqac
         Yd+YtZmgR1AMzEKuMQLVDiTm9CMM/Dd/BWbaM50xloceCZjwYOcW5iRPoOGl7Rv/sMux
         A8f96mek0LD8gtYhpLAnBGbNWMvfxsAix/vIvAXQArWT8yV+rXutIA4jjqUWvL2R3RUV
         LaaSL1UfBZlmJrsxoTfBn5JIKmqXTbW25RElCV1bmwod5IjMtKCab+HBVtf75lepLuW8
         Igsg==
X-Forwarded-Encrypted: i=1; AKwUvBzPYXPMg9wD3ZOKWTSGuOWOggi+zTUrNbN41B3S3YxTiObEVVzC5cyLJPSJQBHH5iloVmvJkE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lct/051XRL07LLNRrrkPrrdBggiMNlCm8jBj6ie8QrmNLjXec
	Diq1Wx48AbACahlteAPyhJomQU0PTYjqcMqrPwIw0uYMRM1mmV7edjjP
X-Gm-Gg: AYBFou20qSEh6/ucON3tR7GLRqEgZ1+GAhTnyAsiHmQ+te8inHsmrm4ElHptdRAzRw/
	CDYOKjLrOGa2igZLENI6Zi/OcxUxKJFKV5lu0kuziCFC2kc4rUxsfWE98w2n9o5iUT6rQZIPnIG
	0cg3o0TQPhG297E+Ol7rb3GZen323S9CKDMnSkkIV9wmd+ACWKvTnLYL2fILVeHSeIDVJ8Fdc63
	sVmKGKXmsHqfXUmUskalxdz9ABX1ENDJVgyz6Fqm1XB3K4K7pIS3qobWsqi8wUvPIwBil8IgJRe
	X6N+Vr6RfzOb3KdYXJcTUNlo5WTw8iIxvm9KMN2NyQCpU8UhNcGFhJ7W4V+XgVuODBW4pMMsfS5
	Q1mWO3/TXI9rjExp6ozlaUH3XAGnCZKSYj1jD+IbL8C7PuTi1XpU6qCEl5ClzKWJOjzksHo6g6F
	4UIbjqQhsoEosDxR5uvJGUosiRcPpkmbh/hqHQGrV0A67h1vizhhzTqSK0SRcqSf/Fbbb/rIVdq
	ywh2AwluPFR+yv7t2oR2krh2tIRtQ8VKRmA7sOkEaPJvRnxgLOPrsCg2w9OPQsbtvbcZ3IUFEQ/
	psmoha/mdrOB87t0RYCA/vQLL+K/P99tg7ugy/u/pzdhe0R0mOHH9LxSkttj6fRVxXHgPDVC+Ew
	lBzrZGNUP1Hiul9H4crI5aQt6
X-Received: by 2002:a05:600c:4f0f:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4ac17b2cde9mr476747035e9.7.1793876110240;
        Thu, 05 Nov 2026 02:55:10 -0800 (PST)
Received: from Ansuel-XPS24.lan (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4b57317cb8esm59576355e9.13.2026.11.05.02.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:55:09 -0800 (PST)
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
Subject: [PATCH net-next v5 1/6] net: phy: mediatek: export __mtk_tr_write
Date: Thu,  5 Nov 2026 11:54:57 +0100
Message-ID: <20261105105504.1024-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105105504.1024-1-ansuelsmth@gmail.com>
References: <20261105105504.1024-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

