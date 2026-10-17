Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966023EA942
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215913; cv=none; b=qCrv3rlFRoDd8gQyu1mDS8abz0PdR9mINwgAaU3I3W9aJkYBeCgXwTILtVHq74A/RGpOSTCNxBeN0W94RIGfPPeuViiVZ+eGt7k7qThVbjECwSZrF5W2bm+E/RLlbn6VOY3x5udywBv9bxJx2wZYElHpKEE0OUc2l75Wg26r/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215913; c=relaxed/simple;
	bh=3JZb0ui9185DkLL+vQqRLAgo4SmmslSADMqlHD752Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfmmX1kJXLS2q8rHDiF4CRf28VdIerucBXXIhWE3skS1Ol918cAJ1WxMi/6Q3C7OdPM9JldRHD83t1IrHyZp58xxQ5eePNFbbWMR1RhtwkNnTzZX/kuuBCHRimDEU+GBfwMaB3H3HrzPZYQJxvZFTjCzBuYWXjvDWnFh01IOysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoNanWus; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoNanWus"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-cc147d86bebso418857a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792215912; x=1792820712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxuxc5T1ripM4n0F4O5vkglU3x7CEQrB8YPn1E2u+7Y=;
        b=IoNanWusElzMrf069Ziw0qe9+O90UKWs78KQKo232aYYMesF+q1O9QWcrrNKubBege
         uZGGgNcn6RQdhYvNf5xiKWroSg7P8QUpOxUf3rJY6W/0Mhb6VjsBCAf69sYm1urZMdgT
         iTpq7XXiPPni+W/fcdHnheGZ4WjCTFBnWYmIq2VkyA7F1zBvDSX2XQHwypQQxoPH7Dq2
         HU702Om9pNEInn0AHJfLcIsZWFibaE29ZF7dlId2HyyOX1gypXOGITpXRidU1jIbzd8p
         rqNdDNotVQy38G1wG8WChESSYcl5ElEpBnOEuBqH4lC+mZP57RAOOAqDr1kddohFsYpD
         aqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215912; x=1792820712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxuxc5T1ripM4n0F4O5vkglU3x7CEQrB8YPn1E2u+7Y=;
        b=f0qpFfsipMl4r+gywbxk8ermJ5bu8l4iSJHNjzJKe1w0XQiY5mylccZQ0igH+chFfd
         WSl7PEQbXXMzbU0fu1G33HGnMoEi9WrBTbJ24J+i2CwQzyrlR/AL+OkeNTdLSno88bPd
         QaSOULDXL0SzhvLTJb7AhdAuYLOYm2Cjapbcyky7JbwWirN0o+yCy02AdfDiMcE0yz0j
         /fWPNP6hPHM8DV/lNsK68Wtm1SWflKhN32NVpeI3M0PM5GnViU12SEgBCYGPAwhemYPd
         ZOtqyNdXamVPZ6J3Qs71GyQ5cOTMKM5bN+XHKVIiLMps4YiCNs+6coEqqn4Elo1meQBC
         EoJA==
X-Forwarded-Encrypted: i=1; AKwUvBxFSZDyhntOgfi5lekr/kCgJ0ggKdmKerZ+GpuQByA1KQq+7V6YEbgwIScSnSKhaO6XRUXcflU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmgzOtU4okq4dztc58+UVxjchIZDZmPwopf9hnDxo1JGZMM+mJ
	mkszA/0AFS3OJ+efolI3JCchtM3Py8fhlnAk11yOjLW56ouQ0N9x6+Pm
X-Gm-Gg: AYBFou2PGb6/O6RwXJofmCpfN0pwaKqBDhQjec6x3fvxZruwiBLkH0IQE2ioY/8XWbm
	UznNo1RQXLUiChTdREi/xHvAXT3TEqroKCBMnSs9KzYdKaAUN0kcEjcbhJ6IbmoP5usUwjneIu+
	WtIrLROx1UJ5LEg9l444wwli/9s5xvtGMPod53CVprm27mzj8HVK80QX8MesTCUbBylC+EWHO8V
	oFgT56u2h5YnsIoZ4zRkBjEJh156Xl9BhHkG5RdR0Mu2DzE2kpKDqsSkRFBZ1jCAaiFAq7JekCc
	TxVytzVmkw/GqmWSGhCeQoyXcuNkFotH6WAxrU3RJuGhAE9mF32qwDSh0np9TU+715UsshHHYWw
	vIZ4nCA7LP959Wrce6xuxNzxEoGCu40ZCIWatx58tboCuTsVNqaD4pbmZoZhVOSOriG4tVWKIlL
	dHA2NC6spiw9OVeQRSX7oJA047pBC38yQNJ71v5TS/YI0cE1ihS7kw5Aeq0u0sg97gZiUN
X-Received: by 2002:a05:6a00:1389:b0:89e:7b15:d934 with SMTP id d2e1a72fcca58-89f2214f36dmr3388109b3a.45.1792215911894;
        Fri, 16 Oct 2026 22:45:11 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57269315sm1958225b3a.23.2026.10.16.22.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:45:11 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v12 4/6] dt-bindings: net: rockchip-dwmac: document pcs-handle
Date: Sat, 17 Oct 2026 13:44:02 +0800
Message-ID: <20261017054406.1828061-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017054406.1828061-1-coiaprant@gmail.com>
References: <20261017054406.1828061-1-coiaprant@gmail.com>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/net/rockchip-dwmac.yaml          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 80c252845349c..c434450fd07ff 100644
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
 
@@ -159,6 +165,27 @@ allOf:
         clocks:
           minItems: 5
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-gmac
+    then:
+      required:
+        - phy-mode
+
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

