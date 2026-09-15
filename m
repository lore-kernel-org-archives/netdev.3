Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89274A4996
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475922; cv=none; b=Q2gdKynfYYZoUGcrf8WM0NqLOY8Fh8x5MJZ8856WXWQHz6GZbu4qK1nOd/C35HudtQ9b5PbJIAlxOGOmFwYqBRoOYK1DoQzHB8fKCk0vPQl7GYC4Ms0xXPgeELwDm5evyTx+rsduyIVmyzppbKnkoELLnQ8I3DGE1ZwICOQCNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475922; c=relaxed/simple;
	bh=EcLMSIMPzyh+0/FB0Gs6lMGD0LoZklRZjkrW967TF1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+VuKV6iTUy1Gy7nzSsw0Ymc4lVW+LRUnC5ZkP1c1Ot1eKIkmIErRbxy19QV2w65IC7CnIbIvmIgBepAApsHqFxIEwVz24diNaaH9ZWtL34auqHF/QOEh6LHc+VS8/0T5AtWgGys5Q9LU5+FjCorSNHtnXZnwY2eZEh6VoALHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmUEU6Mf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmUEU6Mf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so1729875e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475918; x=1790080718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9DiXn+phYCGaEDpGaEGNQSOv3DEFlZqBn0YDd/SEo94=;
        b=OmUEU6Mft5xtkdH29u3QXVXMsJaQUQTqRt2HygZlikmQeoWryuWvEXpNzLwJy7FQf6
         DO4wZrdS4SGLixWrOokbrtRcPm6It2N0E7885rgu/LszreIzG0CYZPIjqPv/SJ5Le82x
         GDYxxAcYWX6Rl/OIehOOTRRGGtM/A3imLbXXosDreHNS1TzTXnsAhrHBspyPUdodovW8
         pNSiwf6GpDvV23Xn6N1eA8geqF6OhZ6Pb+uiEkeCCb3uJ4/12W71Z+C5EsyJknBQ1kkl
         sdChuJ2caJLXuj8yLnfdYOf1ZHunigsOWxB8FUv1Tpt8UCixGV+rE0/lC332J/mvDC5l
         YF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475918; x=1790080718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9DiXn+phYCGaEDpGaEGNQSOv3DEFlZqBn0YDd/SEo94=;
        b=g+y7sAtcFuLOhFEojvNrjT0XW4R1ObQUVvDtZ7pUJ6ZJM1hDsu3/rkbG2QvLPLUpBB
         SAqjsCuITO4aE05htZs/ijfwHj9zR3Ntd1MpN7i2ZHpIWxwowqUfi3VMGzRs/Z6vhXd5
         yR1vRkPwnK5IFjW9fGbUMOHQZNPl5VCDxWQ8xj7pPqUVPde7bC9ihB2PessHPscxL951
         1ry7uiNKG3c6BgHgCLff1yGKkQxsiePkPqB2sI2tAmWlmImehJay4SM/2+MctBRGHYyM
         3aQAr6fKGamEvrmURRiy25VLd3mqwRTGMXozYEWwZMU5Yx44Z+v2GU6JXNmS13+vuJ4g
         BN9w==
X-Forwarded-Encrypted: i=1; AKwUvBzYzUtS8NdwrJ1MxQiuss187FQ0QCljO+bWpXg0k+/FS+tHljkqa6vfKI+okrcXU6qkLTpJs7Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mPhvdmiTqnTaGfvZRic9v49kaNw816lzSz4TZDQjkvk9/H0fKT
	Xkz6ABU3+3WHUmhMH6k+owUp5RK4rfRbLdTj3sX7tdFLTY5WJoAcXNo3
X-Gm-Gg: AYBFou2pfzGR051+EoU+VYWJ0V4gaZK3oc/EfFWVdfTJfKZgrwhXEBMF1J75byJPgbi
	GfN2PCUaB92uOdjF7ovjmELOaO5QMYn7KavP3jFMYnH7ID4SVI3TTqqeG+cS0SAqRLz2EHEnZjR
	6eLLDDeACWCAtI8awgt7tctTOvaN9D5uLjOzAKCXGZtNZwik8jUEEslb/xUSvZTwXWg+9dAKjhT
	yO6eWQVDJmdaSRIgdwjrYlWYHfhcykYphL0sQdYCjgpSRdfs3pc3aMorQzxmwQ++wm3U24gPNBP
	Oo1xiH6qElsXxjPN/Bv+TBxFt6VsDm97SEXiGziSLygh2jZ79dQuS9qAzAxSBTotevFWG915gYP
	0c2WM3+TP1cef/gE5mTVsYhDmz2wIy8m82gWahr/HpNyJ7qi2SuDHesOy6N7ZCB9KWwSWJxRtGu
	7qE7tc0KwIbJPD0asNx6ecfNs9z8FzngR1WVwp8SHSCcDA2NYyNfxv4ZB4ggKP2ul8y6K9DJDLx
	12QLhWu9D7+inRhj6LoYMoj+DYLiWqhn/pGKHKpiVd1h5SEJRGD3nIHwuUhdLhtEBEaZiS34YQ=
X-Received: by 2002:a05:600c:1d01:b0:49e:6de9:62e8 with SMTP id 5b1f17b1804b1-49e8222c825mr13854845e9.6.1789475917733;
        Tue, 15 Sep 2026 05:38:37 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a8d5asm62958635e9.9.2026.09.15.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:38:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v22 7/9] MAINTAINERS: add myself as maintainer for Airoha AN8855 Switch
Date: Tue, 15 Sep 2026 14:38:04 +0200
Message-ID: <20260915123812.14747-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915123812.14747-1-ansuelsmth@gmail.com>
References: <20260915123812.14747-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e04d92d1b09..afe9d363ddf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -759,6 +759,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.53.0

