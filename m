Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF73E0097
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822372; cv=none; b=F3S6NtGkHqF5+IgFy+8B0FZ+O1IA5mAtdQUFBdKy3QTWLJK4floruLlqdJ0ESXb+zlBr5M7L6D3mzr5LLmW8vBzrU05mYQ3mQNJWRVoSP0Vmdnwj1ToQTe/vH6XlF88WXdTMgczZnV4HOQqywI6QBuZL6nl2saRrkU2iPV+WIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822372; c=relaxed/simple;
	bh=Vpg12s5aCfYhqiZT0MliutjEHvX20bbyVe8NFEbpumw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbpDHalvdviHF83kMj6+KtsFiMJEoHcJkoJ3dmXY/WZ3WuwJq4CX/ck9Z8CnopPNKEE4uyow3vuSMKpTMv9dZt1u4IOJrnMkUuELNOlKCUvgqI3fNpiZ8LgwIBMxAmCaDn4TS7hvkzvohWOK3CXNLX2ng3opyUJKA9ldFQ6/pLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVVXWk06; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVVXWk06"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so1297179a91.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789822369; x=1790427169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWO0yYxZDPAwCYSgicIL5MDEtp9MsL193ldKBirIieA=;
        b=YVVXWk06leO9wt4anGPX3PP3rdKwm8wO6H32qzeMRv1RLuJt4aRTIwZHx5dRSo5n47
         d6fkwSAL9Tsd1es09WuYwLl4JAnwRZLN1vhu4UWnCmh4Jl6qcYMcSV/yWgg/VwMSu5v9
         7FfZ+yojzRH+wCS0hQxZ22q8podyal0ZYHiNpxHo2foCfp8b+Tz4FNrbMciDabkxo2Tl
         ey8BjChT8lTEPoXLnbe0uji6Pn7L83dlW16zOHPMW/jTfRkYouDFxck22yvQit+Gsoc4
         ZvWCIklcb0+c3fe6QbZTGQqaFjqNjUSaYa31gEM0Bi+kYJr6cmYY9YeDudsASiDgtfT0
         hzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789822369; x=1790427169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HWO0yYxZDPAwCYSgicIL5MDEtp9MsL193ldKBirIieA=;
        b=GzOFP3VA/6ImssVbAyeq2vNibu0ILTATs6UfQpfmMEVeJvNOZEGeQvCmcDjh/PenTn
         Wt3O9JE/sDo96aD/ke1bAdWCxIBt30TamIMu6RJ245H25RqwpuE3skQEQZ2n11IJw/A1
         43umDQyXbtIoEXQm5yMwg+dNKaMWLQgFWyJ5C1fo9HjZmnXU6H53lIQAI13vhMvx2AzC
         MUxOzYpI5EcTYFOW1yQqB9eW9NkAbDDLGd4OZ69OV21/awE/7TyHOYkT1Qlzepi5pZ4p
         l+vmQNlVFj+el/qpYkAYpLoUBJPOmgALSESvkcCHPKuPWdT+fOqN3W8g/mSlV07tRmkm
         wIBg==
X-Forwarded-Encrypted: i=1; AKwUvBzpN+4V/29DSr4cs6EyATmjkbAAsACMg/CohbO1VbegWiTizVc2rUoTeJaDbzY07CyiJ8rRvFg=@vger.kernel.org
X-Gm-Message-State: AFuF++lvgd2j5E8melEEr8Ly4yIZwXJD+CLSejyBVkK9WmaNPuBY/Opn
	WjOdYyvTLunXecuJTF5TMUZkTlg5MH9Oay0e6UL+QQvBug7t67120dn7
X-Gm-Gg: AYBFou0R1LPKq9Htw9pMvUhZUn1Wt4ao7qQyW75XP3kQPUaIXHy+tpc4vuE3KICkTXq
	nu6chZkWr0LZ/qcQ3p+vXWTLqP4KjWe6dg/qnFrQNaoYSFHby0NnvLNPLl/bpu4H1c/acNOX7BK
	odrpg4Psey800FtOMqFHFPNL7/xZGr1LdDXP7qPC3LpbRrtw78vpjF1C/OX4yzEs/l2tquOwAeb
	SSVUPDwyPvEwzCSnSWIguTPXgkdOlRzvV2Ft1/1NIiMQZQs0a0UktlDX7qPc8fOkW1FAWNvuGkE
	CEnRHYeirPWwtcLppEPCZ5PdWECy0lQoIrY9CMb0M85Fyvp1btKKjPOEyzg7ar/+jxZ5o6AI+oo
	GyUCgXesnk1E0ZB4JhAvHXrrF2L3mRyxMqSxPB4gyNeVLdjA+sTSrV3eMmBTLCitjYQsDS1j878
	JO1k2f5OkjfB5OvyQVxusJOrfenwTWqBGb2lGp0Sv0MxBhxOy+2wptC+qRqzxMBmTGuOo54SyKC
	BMuz+TA
X-Received: by 2002:a05:6a00:2990:b0:869:9298:ba59 with SMTP id d2e1a72fcca58-874d84a6257mr9842225b3a.0.1789822368852;
        Sat, 19 Sep 2026 05:52:48 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa0026b2sm991805b3a.44.2026.09.19.05.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:52:48 -0700 (PDT)
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
Subject: [PATCH net-next v8 08/11] dt-bindings: net: rockchip-dwmac: document pcs-handle
Date: Sat, 19 Sep 2026 20:51:15 +0800
Message-ID: <20260919125119.2107089-9-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919125119.2107089-1-coiaprant@gmail.com>
References: <20260919125119.2107089-1-coiaprant@gmail.com>
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

