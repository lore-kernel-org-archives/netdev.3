Received: from mail-pz2-f2.google.com (mail-pz2-f2.google.com [74.125.228.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E946EC9B
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923802; cv=none; b=I0diA5UQg8k/cV1sMbgozvUiI7PGuHlXyf05RuTd5LZ2JqZ6OeMv+KC2Y9H/6w0l3F2xK3Bl5uKW3dcXn2nmlTcbPhZcvcCebtNnew2Jb1ZTPSLbExRTQc89JTzHnRSW9MJUXy7UoWR4oK5aZMre+JagcoQWZRzQljpkxNuyIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923802; c=relaxed/simple;
	bh=Vpg12s5aCfYhqiZT0MliutjEHvX20bbyVe8NFEbpumw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2HtIuba6QOPyBbGAVuYeZfHjdt65FnVuEyxLLsaBIeLxmXirdWki7SLg2AP3+37AIkGGdHz9bqP0toRyENVl0ncYfbTWlPwtrgeVs0MhZNzzkDYqp5HbTcmO4HHOiB8t906W7ak78QMkgfWv1REtG07XXgyiHrJNhyuNXZHpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwZTNyoe; arc=none smtp.client-ip=74.125.228.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwZTNyoe"
Received: by mail-pz2-f2.google.com with SMTP id 41be03b00d2f7-cc4c181b42bso1622861a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923799; x=1790528599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWO0yYxZDPAwCYSgicIL5MDEtp9MsL193ldKBirIieA=;
        b=FwZTNyoeDaJNgBcS74Wppi5RIdDcvODv6K0TcGuasPWodeMiTjsZKUHMp36N6p2mn4
         eiUv7wtTLJYkoveeAr9FRfrcxvJ/jwEV3Wkl1dEWzRPkLZSrTYBm2+aLqEFlahQzlgok
         K1SmgOSBd6+4WF7xaFviAtEboUhMNhGzFl9OTZQB2EMefmhXICFFus6ETtWeWOrIq6D5
         /CjZgqHBZGGdNserLQHrapM2gLElH1TQi/DMofl6SXz8gngTz/z+IrhOJmOv0zjc/LfA
         AQrOuGrs9JLjzWt3BDYhpHGLgi7GZ64RqVSAfkHmhJgUQUwDB39xwDrCm/ufTr74A6aK
         9zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923799; x=1790528599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HWO0yYxZDPAwCYSgicIL5MDEtp9MsL193ldKBirIieA=;
        b=bKjmy4TZ4+I+Qvc1iKx0l/9JE5NhduPso53GBqJPxoMbF8gv6IvJpV89nU2UUz1b/T
         jVGe8a7VSMTTKf8hWiyH89NBvmYenXufyXKxM3Ityr9PokCm/N7R8k49plzAxw4m3lbK
         chpu/VmUO132iDvgtIVtINCrHnHa9oktjN2NkycxKals/VTtEkAM89us6GpuTpwXWpJb
         Y2cBpqcqmOUhrOAWNielzj1Hc3l5nfBRI7y7qsYTi4Fq97DeFGVSCJbsYblpXR1clpT/
         xN+pK2g0cSaTL5jMKFMlz9mx8QnpOtSmmq+eY0FBxoe/8/CW87u/KwKXqiOENedJ2I2U
         n2Tg==
X-Forwarded-Encrypted: i=1; AKwUvBzXo+l5aEGvU0Wijt/1X2yqlab1clXTbHbYUtZoxkGJZiKxh9NRlXTggrrsZpWgw1oUmwWFhUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++klTp3ax0nhWSdQJXu6cZtOc5tHfbc8cdnwQsgbFKfZ3DGFpRb4
	Wh+DAE8IlIJF1xU9H6dGjhKwwS6lGY9LcQcnVoLMo/9/8xrCgC99Uhrq
X-Gm-Gg: AYBFou03Tv58W7lnRssBoGbqeY9WXOGDLWjn6QX2xYlko+QxYnl4RPnM1p2SkWn6j3S
	uE3bHlDOo7+er80qGbEH6CV5UsLIhAQfJINFgpTgZ1VjclcNpxr3VNQR7WtDo9DV0tNpM567Z6r
	QL7pK+n1yGsgnwngFDSbkyzcdRuCA5NL0wHUYeTf142fCOW/vO1aOFInnETZmbMcJcQ1oCxs1LB
	JkslTE1k9sBu4WoLs6Y8kiQzx1ykoPBEhJG5YNlQ2qykjKRXv3832iNFIINZYAq1g61h1twWXeo
	UiXBzMv6oxPSpN/+yZaAuKKWQMAfsLe/5Fs1LSVzxhAhi1Ob+1KACSw898t8GZ1m5Tv3YQ7Cms8
	2MtKAqOntJ1Z+bKJgCziZg3C17QR4CHeoyEJhe1BDMGUVxsC98UDghibQw2wj3dXzrHpiDCc1tR
	kUdTYqroaR80MvzZiru5rRryAskNSBQQhhwsweX68B3Hu+bwuk1yxhBkUi6FmuG9xEEtIQIg==
X-Received: by 2002:a05:6a00:4b05:b0:878:34d7:6a33 with SMTP id d2e1a72fcca58-87834d76e0emr5109717b3a.39.1789923798674;
        Sun, 20 Sep 2026 10:03:18 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9d07425sm2140646b3a.42.2026.09.20.10.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:03:16 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v9 08/11] dt-bindings: net: rockchip-dwmac: document pcs-handle
Date: Mon, 21 Sep 2026 01:01:12 +0800
Message-ID: <20260920170116.3624104-9-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920170116.3624104-1-coiaprant@gmail.com>
References: <20260920170116.3624104-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip GMAC binding needs to describe the PCS reference used by
the SGMII support added later in this series. The property will be
parsed by rk_pcs_init(), and a missing phandle fails the probe. Add it
and require it when phy-mode is "sgmii" on rockchip,rk3568-gmac, the
only SoC in this binding that has SGMII support.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/net/rockchip-dwmac.yaml           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 80c252845349c..bb7540e838033 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -120,6 +120,12 @@ properties:
     maximum: 0x7F
     default: 0x10
 
+  pcs-handle:
+    description:
+      Specifies a reference to a node representing the PCS device
+      connected to this GMAC. Required when phy-mode is "sgmii".
+    maxItems: 1
+
   phy-supply:
     description: PHY regulator
 
@@ -159,6 +165,18 @@ allOf:
         clocks:
           minItems: 5
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-gmac
+        phy-mode:
+          contains:
+            const: sgmii
+    then:
+      required:
+        - pcs-handle
+
 unevaluatedProperties: false
 
 examples:
-- 
2.47.3

