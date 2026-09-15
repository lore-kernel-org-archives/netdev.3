Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870A4B1269
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475976; cv=none; b=YGY+lG/AZuv5kH7V2vRitwxBzvtjohAEIMkKmyiLlZmhSSzg95ej6fRLE5Yf+EArvswkntQ67V6AojOsebgMgis/T/+tfrxuZBrYgL46VcSPxCvRDbbpxjBaArpaapPFvXa9S8zeM40dvtxbk9PgWwDWQ/IxUNN4doYCVnN8+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475976; c=relaxed/simple;
	bh=/XopV8KTgRYgJTjrUXTlaOTR0QRZ8vtOfg0QiwkYOPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg5JwPpCYLmhLbP9fdVGDFFWV+E8fiuEu/+djM4BvsZW+yOfc64qAzKoWIiAb+m/KaZhowvTLaayZgJm6K/SjCLVyBri6jvBV8mSsxStnZtyc/wSsZNq03sLiPGhP591VVNPpXVw7LQHDLAloCyaTDExl58GhJWkX75exCwAB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOgkKz3L; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOgkKz3L"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a0a87595so4266195a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475973; x=1790080773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJZ0PecvDJzl0BEu7eLa+JMyHq2Op9t0/swrRCuqxn8=;
        b=rOgkKz3LtvesydlkjTKzxKgitfcHUvPmves4RRJDkLF5WgLl9MjjyMTav5Vmr2nieU
         hGhh4v7tyNgjalbnQZ6UfKV4SMSeJmxTgLStWWNsWocUFyjisyLO/E0mfIZvOCBFMtYt
         F//22igbXL4jG6z6/lOOUzQBIwG4exCCqqS4bkFI3OqayveEbdypppCbH+FOakTmXKCE
         9ogLiTFeN3nvRZ24AWBv9XeVkHvqiKBx494T//QWrU51frd/oFgD239q+jc/iSjzJQc6
         RzLql/AP2xA4hjwasFOfcIpjkOV+bsE6sSk2fte9zfLourL2EfuGj9M3kgZYd3Q37Ek+
         kHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475973; x=1790080773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJZ0PecvDJzl0BEu7eLa+JMyHq2Op9t0/swrRCuqxn8=;
        b=JmXC6WBlZ2HzzwrcOaOd0r7BFWwmbkK0DX1FPYBF0099pKFabwz7nz1Xok/PQbw2NE
         gbt5HBnZWeTIlqM7CClgLt71kBvKp8v5qgnV+lx3qvacA9ILokK6sOiShboGi46LHqyY
         y71ts8hrxk50ovwt3mh+c1OCf4sxJ+EZJSxIbDYSTwgH04QZzex53UA7s9NJG47Qru+2
         fcWTq0QhoOHYent6pS5ABFXbrpFgh0hnX+l7tuSHwDKNTA2QHd3ie6kBlQMD66N0kV3Z
         lvEQxa0/PkoRNeFaTgg4+BAjCgfsabkgzxQB0i1dJJ3jBaGN9LLFlcU8noXqw4OUD7ro
         y8Aw==
X-Forwarded-Encrypted: i=1; AKwUvBx2r/whD5OlnZgzE7hIvghesDd7eAEx6SNRpDj728AAG7uaKQyvD1QhfN7n00KVyv1aXdSAIxU=@vger.kernel.org
X-Gm-Message-State: AFuF++mJz6KEEGJlWYFZoq6wN5OterTaLMEnTjWS+SmbYKlfzYJw6aEB
	TpozYRd3Yr4oXJqAy6IFdZoKUF810xHSnf7Fm/n5RV2AyRSDCn2118zc
X-Gm-Gg: AYBFou18OOUqy6A4+v6ZG/P2glXETuLpD2MCJPzXLfAKe8pRvsKU5bULeSsM1mSHXc6
	mRjuMLMfHtOLN3KTvkRSGjUOZjFgrAR4kdOmu5dXg7Oq+/t92WNgcDen7o+56CW9AxrFLegv+X8
	jGfYpoh8RVnsZq+bBvhzbHhP+cOuBX1QHSOMjskQhp2zd8VB6uAlBtfVWB0CZxsR4tP+eIBAB7t
	+ri3qBQDAeKwys3WPtsjGzeX+BtUoI3r+Y77VXHQO2f59Bm3ac5CKsZS/zMtbhl3WAavrjSSM13
	z9IDiXeowxLUkFLLnbdZ5OWTh5JGa4X1zkzv8ruPc6iD7z+nQRSKxG6P1ROVlt7iohoKZLm8lNP
	OJv8BJIvS8c9HPiBqa0W8bi6liCCYSE/Sz7ItzzSMsAhQjAdYScKGlV/3CybtrhrH/BhzlASRAx
	E0stk4tDu7JgyYgqDzzCU5HQ1XpZVDdv0REWYxz2e9Wd5Ybd5bEQr1rd2p+vR++Pv5iS9Bm/8=
X-Received: by 2002:a17:90b:1e41:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-39e10e2e451mr1383583a91.9.1789475973476;
        Tue, 15 Sep 2026 05:39:33 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm5307259a91.10.2026.09.15.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:39:32 -0700 (PDT)
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
Subject: [PATCH net-next v6 08/11] dt-bindings: net: rockchip-dwmac: document pcs-handle
Date: Tue, 15 Sep 2026 20:37:57 +0800
Message-ID: <20260915123802.1561724-9-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915123802.1561724-1-coiaprant@gmail.com>
References: <20260915123802.1561724-1-coiaprant@gmail.com>
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

