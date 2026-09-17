Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE536407CDF
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678098; cv=none; b=cBkAjgak/JVeYOywBO5Th5xOZqB6qI3UZlTJA3mt3ePU279tZ4ivoP4BNh7CKZNr0pviPm7l4FjJAmBa9TIsMl4qQjAIMQDwUbu77m/oSDjQJjD+E6E28Cuq0rtgfyCJGaC/fE/VJeqHf38LBmZfJGdNT74cOyws+YyJRSH3MkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678098; c=relaxed/simple;
	bh=Vpg12s5aCfYhqiZT0MliutjEHvX20bbyVe8NFEbpumw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHADt/YP4/lU/93YOz5v+bf+ywysn8xgC9OSFsF8P9FujBs9oe5UIL3cBuGc202ciZ8NvzV2phziKzhWyph3xeDePqwxCLeWKiir5crsYJlKt9g8Bha7LZHrCcWb4cFGbwKNAHmiq3Oo0GZoyiFk3VH06Eq7ke6svu2UdcBh7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVM3qwg5; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVM3qwg5"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a384b5f7so56544a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789678096; x=1790282896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWO0yYxZDPAwCYSgicIL5MDEtp9MsL193ldKBirIieA=;
        b=nVM3qwg5FLDOsrZ745hiNOkU+KE30LI3UQL8R8cv2t/iEdn0UcFZBsK5TAcGzKeg22
         6D7SsqpM223SfL4vYvg+juGty7d0FenmgqC5Piqig2HALHtFzHkyPhKU74NDMIWJ+6Qi
         KEVJ1I6NAWLRCuKucGgCXnTAa/oWHY8q0k9Lbs0pcShN+a7n0hf0klfbPMmJUiX9sirS
         LxgvlGSb3rBq4l5XChrKLWwpuoeApDVKzNKFaaQdb0OJvg8SISa66S8bqZ4sJSKogEnb
         db3gqrDl5OxLdTXszhzesgrbTbpPn04Fvm/dOG0kYmAcQzkMFqNNCGkTQFLPd93YyoJ0
         vh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789678096; x=1790282896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HWO0yYxZDPAwCYSgicIL5MDEtp9MsL193ldKBirIieA=;
        b=kCpDjcM2/+vCw540W/ERKw9B1uXRCYjZVgM7OFtKN6aWDZYBQRnUr3LWgUBbU1cUUA
         wUQ4oZlimDoO3fM4n0TkGKVlhWjZbP7toNFqrdGpQp5dxXB1V/lprDCV1JZTKGxa/qL5
         bxjtWVRdtX3wJJr4OjuVI1CQ9tAu2SY8X0HVkvctejo8IvVpuiGejDyfNfv8VnHbM52H
         6Bf7yNHglDrbsv/GzcZCrMaVFBe2A68WcDItVViY6HUUoSC2P/raUEUPLTr0lIMHNZkg
         c7c6GSrTVfAs0nm7VA/i2aO7GQYn/UYpJcrTuI4CYSvmnXaff9oevV014PdO6imvDSIr
         jCNg==
X-Forwarded-Encrypted: i=1; AKwUvBzYY7f3pRfoHgRfojzOryUpXQ4wH0b7VKR10Cmt1lLwNoNr1Qb3KKZCRtJEXD1MbmtyE8yiLtY=@vger.kernel.org
X-Gm-Message-State: AFuF++m6vLAYvg5Zppdr1LumzXlXdf1qM0SPHhVkCO5WrhMScqjtIKg8
	Vzxxjsd1XakYp8VyWG7T9+hLxl4z0NHAZhSTONO9OBbTyq6YXxRFLFeQ
X-Gm-Gg: AYBFou2eDWkh/OjX5tASE80thHUC25V7GiRj5dfMQkj1dLsIfAfopLkD97uZ1v18r37
	q7RwuQ/qEXGsViJuYA9wcGZO+YyLjvq7IqqY9D+boeuQzWDQZjfSyH8iaTKNCj8iTImC+jjpiLJ
	QC1KThAdaf/Va1YkVrSJujEMQogx864KHI/vOCZDdBbXQ9znva0HDX26xx2T1iguFgs1slmVJUE
	lM7BftkVJYNAtGJ6CLFT/zHIRPaPVLjhTvn6+nJ8P+cP9ftBb4CGAUb+7SYj03fokXWxfbeRW3c
	AAIbS09reFR0c9ZTSvRCc7xLpb1SaikoFSH8WAbP6a1sA6iOO+orJtuJr7XgvcnsrMntJ6DzFBq
	BllrW5jOf3KEawJWZkYsav8wqAHitI8+RRB2O30V+PGe0nLFi+8dTlAFWzGbm3ajx9Z1CJysu0l
	XcikUQ0YgVnKT69mtBOchyWNUW6gw2od6oiBpAC6GXHF5hyhqKqMl8eg6QeBVpIhOCNpSuj2YPR
	asSttK6
X-Received: by 2002:a17:90b:5305:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39e54dcd917mr1044616a91.6.1789678096241;
        Thu, 17 Sep 2026 13:48:16 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm1232196a91.17.2026.09.17.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:48:15 -0700 (PDT)
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
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v7 08/11] dt-bindings: net: rockchip-dwmac: document pcs-handle
Date: Fri, 18 Sep 2026 04:46:19 +0800
Message-ID: <20260917204624.2427486-9-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917204624.2427486-1-coiaprant@gmail.com>
References: <20260917204624.2427486-1-coiaprant@gmail.com>
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

