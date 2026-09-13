Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219F3F7873
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326067; cv=none; b=VXwLRWXHq0VKP5TVwrmg0zKb1t6cua2aNp76PXZ60eJ3V4g5Ak/o+WVa0LMwra9QWwS7qVK8XcLMuUaoShn8RQNNVmRQ/zcXOU6j9YHEDg6c2T2XwAbm+xxegSjDZ0kZBQ4Ke2fxmioVGNDSkRdvaGElw5kD5P76b4IQgas77dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326067; c=relaxed/simple;
	bh=/XopV8KTgRYgJTjrUXTlaOTR0QRZ8vtOfg0QiwkYOPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qt74buRaVzTB/5ul+tzckAE7OThVqcCXIt14F9h7sk0VLRwn6CrU4e6fplAlonkPHm7l1DA0BW3lIDQ5v5zYRzTrIKf98r27AekW8cfCwACq2omKVu2ZTP8MQ80FE4zhMgCd8NXb3MnI3fNrWI/X7fvsbWYR8Yx2RNtvw5e5fQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcPwio70; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcPwio70"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2db39df9c51so9594375ad.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789326053; x=1789930853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJZ0PecvDJzl0BEu7eLa+JMyHq2Op9t0/swrRCuqxn8=;
        b=XcPwio70FbxEMR/69nLz2Jkdo3He75E5qKdEijddj/doqM/WCjsfJ75WPIIU3neOes
         v0e3chnisWmuSUN33YqYsjx262nme5HOL0nQJUX6yRFHCzH0SW5eWzbbDk2YNY7LH5IF
         Hx9B5dK8zdZ8EbrqIIKyhAkLjnfx1tc29PWsT9KnTFtdBSy2A2T0rd+SCmlx6PXZqPmq
         S7O6GiBYTcIDzTxygnbXY5+6l4EQYVIp2IGZc6/X2LuZ/7cqyI1OHblvAgRSd+jK2Kb+
         qfHEvNBkK6vJbjYKKFArtiJp4MnzJ9iV1EmQfX0XrQWnI3ddlB/PmJaoeZ3VMuVzEb+n
         l+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326053; x=1789930853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJZ0PecvDJzl0BEu7eLa+JMyHq2Op9t0/swrRCuqxn8=;
        b=HSXNkBvVT7UIt/B2oKhs0h63iT8Qh4Y8nOeEbQc3dLxFK7bf+vxr1yUEmemicBJ9ie
         XwW5mWhf+g6XYHSlR9PognBwSBCNuF1aSBWxGkMhFNtAwMz7i9OCfUJwZBvC0NNenGFC
         vTDjjZFUxkhVHXGXX3TD8JdQqXlBDgUXU48dWeYAp7oa8AVqswf+aOBSi/eYHjWuq0kB
         Gh9v6wgE+atkSMD9JR90hqIQYs/92SRqVbxdqoagi9RDcoO8O2x7bvxkxpeDRIygwFPm
         oYAiOF5ExzAmoHDWFY18aPhRYG+OV8mU8DDVJrIF72K9vusW2gDEuCHyCzfbHNnfVyCx
         R5FQ==
X-Forwarded-Encrypted: i=1; AKwUvBznaL+TzSwp774aCgwtco42x+RyoWgZX6WWIxjjCP7Hx1s7usGxQDaWanBUHdOx4/dp5OGUm4w=@vger.kernel.org
X-Gm-Message-State: AFuF++l7mOfD1WVay0ky0PSE+ix6IcEZnHz/Y7RoduhvFlHQhgPnVXFk
	DeIc/DflcOptdLtDKIHmNTKmAxXqWlEdyhgjShUmxjnW9lyw1nXS1yZf
X-Gm-Gg: AYBFou0FOR9cX+mTo/FnwwmQzH/7Hw62dYRubYpcbNXHN15t8vLYtQNnlcQnywG1oYr
	KYEjDOjPRibzWf2AmONcRb7tNVo5TtARS3Q9gRWRJ8PuGsQLX/lsxsTcuGRpY4rknu7quPN2Nck
	YGlkzACCWteD+sx5zHjRg9K4ODfk+2YZ0XkJh62BoULXuKPheLzeXc9DWtcjnnZD9KR27DMYdNX
	sW/R3kF6LKHonU2bkNVJQPA/uMt6Tq5GVx+N9yvAcZK5j+Jx/DVdaCzavLXZrTxg7lThZzTZi4+
	OzxsdWGzx+/YtIFjHukruzfUkBZoxKUbYsU3aAVtayynObuIbKa8e7p6IyK+9i2182uM7vWy0Hu
	jz3/8rhawvFATOZFpIfBk8hXXNs8IoRnOZxp+Q7h2ylT/3m4RM6PIRMBgEgLVFVer2B5QVVvv9a
	gQnMa07qMncHDEj9WIY3OfAIgoLRObhQp7jseUWWJ/ahGSibraiC5NJd7h72jPMQf9bXTiAw==
X-Received: by 2002:a17:902:ea0f:b0:2dd:319:c9ef with SMTP id d9443c01a7336-2dd2a1c41camr232853065ad.3.1789326052648;
        Sun, 13 Sep 2026 12:00:52 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca6b7bsm36808655ad.3.2026.09.13.12.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:00:52 -0700 (PDT)
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
Subject: [PATCH net-next v5 08/11] dt-bindings: net: rockchip-dwmac: document pcs-handle
Date: Mon, 14 Sep 2026 02:58:43 +0800
Message-ID: <20260913185849.907479-9-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913185849.907479-1-coiaprant@gmail.com>
References: <20260913185849.907479-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip dwmac glue driver now supports SGMII on RK3568 and
requires a PCS, referenced through the "pcs-handle" property.  The
property is parsed by rk_pcs_init() and a missing phandle fails the
probe, so describe it in the binding and require it when phy-mode
is "sgmii".

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../devicetree/bindings/net/rockchip-dwmac.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 80c252845349c..67b21ea77ec96 100644
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
 
@@ -159,6 +165,15 @@ allOf:
         clocks:
           minItems: 5
 
+  - if:
+      properties:
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

