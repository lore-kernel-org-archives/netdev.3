Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86639488232
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962594; cv=none; b=QjUf8pNREdYRojchk83I0BHRjbMtyawA6z2o1gREA/DCgDV7VX6NWAA+PnyMLa8lcmtCaGTcVKrN2bUY18g4hJBxJr8mYr8BjtEBDL2p0gQzjmd0aIcJ+rMh9GuA9jcKBt36251qgyUW6qmkJbr0sXgHzGoottS7HKa+WDp1e2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962594; c=relaxed/simple;
	bh=E3PFYMvecW3iHYbCYGdAhKiumjMtP9bvopg4I7rWNEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL7ldfKjqwH54hNoNJ/lABo5CJfcavCcaN31gq9xpX4Bqjev9O85uuMRll+Vmtj39gH0ItqU0Utyy/gNZBvneRPv9o9Zu65vqR1IwpF/JzeoNF9pIfBxM65MOomEtIKDIedBgp5E8QSJlpqDoXaL8ClOnMiiXt9rvjoBcUDdloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmzHGBKh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmzHGBKh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a02718da81so29705435e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962587; x=1792567387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUGfe7wFqlQiSC0eGjj4e04EQS1TgsUFwNMlSY0cEig=;
        b=cmzHGBKhOZ/CvQR98dIKCZ6HUGtRJWrYaKPYCdWuVPQpveDqXJByPR8RQkM3Vh3Dfm
         69nchZcMCDuVeoRQd2+sNi3YbrB1CGnqDvWEZg3oQLv6LEhEp/bmT7fiBpNCDIjefeev
         UgFJgM/BaQZ0MMLHqVx8JAJp86O5UV33HiGLBY7eYsjRfeWKCfk8lrRRX1xhvJIA+ifW
         QYL9Np+spKgZ2vblTblxEKXiGLmvuKLF3UtfrgC8hXq8r5FKBphTjKVMJpes+BPg8dQm
         KtTV3gp66h8qKwQaISzlFoR+L5ZxOrtAW5sm4GNFo5epxPeJTWNDzUUNQanhR3TmW08N
         zwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962587; x=1792567387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUGfe7wFqlQiSC0eGjj4e04EQS1TgsUFwNMlSY0cEig=;
        b=fRNI2aS9JolAyfQ83rzPVnABOmpi8zOy0u7S0ODrz1pj4TC0l2zvp7CZVeYPu4LSxH
         +XT/V8mmLDcEAg0ifNTGOK9rhG/GSvUHeH8VjesLdpFGwfPV97l6RHK4AnVqmbXucHd8
         Jhsbm5jZXLTndVbX5x+FSxu/YdsDbd107vQdLZGJe80qCVyX2m1mSiVR+eRtSlNErfCp
         yPlO+ZfTyxHwiCgYmGoKiSRDCwKN08MdbKLy8Ac7Fms3A228qsOgcmhK/eXdlE9QZizR
         /OdmhI0gY/LnsQeSxGQe1z8kVXJCJ/n30WAJwVAQZSHh74W+uyOcTfj62gUEbWmIhyoM
         4pzQ==
X-Forwarded-Encrypted: i=1; AKwUvByxhJgq9gUe+M8khBao0rBpyc0X/qwIV60GqqI/HJx3S5U8rABDhO87hCP9/S0LSpkgg7F/xYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4IEH+yt6+BSQvXKziLrNnAWwxlEfdNda/vZMseEcFCpXxbVNx
	Dgo83L3NffW6zcZnbpTe+dHFUGUlXkI69Xg4S3TVawzkNfbShAyuaiBW7VxYM8KPNFUpqg==
X-Gm-Gg: AYBFou3OHTrpfKz3DExqM7CrknPzEPHKTkBQAcXUwLOT9UZ+vCRprLjyBINoGvGA1MI
	qo660Ywz2ZUFm/MHAo85SFEsimYeMEi3FxKcjNIAkxyQoRDih5pkf7C+6plSlrzGGMVNsxAs0U9
	pCvq4o4tnb7lcPdQNfImr0jIyTq69CpVOuHj/uuPjb5IR1MBYAfrAoJnk/gBAlNXKvSTUhGnUKM
	31Be27qAsbFjXDhyyYAVvnssOaM2tBkuUl/y+EJYI/Jqtr42efOFlLduBNcfSbjsoB1vcCGrHN0
	bOFSME/jE1vUGrLd18/Vkehz5JRMN8e2vfU3lYMxIagkfCdnI8WVHBdl773nTJATaYmj4MV64E1
	7TD3TxkN90ZjXYlcuZzrp6VxlrcF62EW/6bfy9mx1PO3pvlcv93gxT9V6kyTPEW+CIwkbwwSVDz
	FyPkRaBSAe/c+l8vI9/O7yE9RspkncBjsbmjQu7/mS66SPjP2bGrq0+g5ExIlD62CQOz4boWDa4
	PqgOvqzBM6MkiclBVput73h2sDJ7da4IFKpc5uObka++BFRwi0ak6ShVvCXvUcGLyaJ16+HvFAa
	SNFWilRlYiK2Qve5yoIM8ROLT4+KOh9HCXHBi+AuuQyjhNnzKwEaFUnKpPAJWZetFvG2u4xy
X-Received: by 2002:a05:600c:1c07:b0:4a1:b044:9ccd with SMTP id 5b1f17b1804b1-4a1b0449d00mr79484415e9.28.1791962587425;
        Wed, 14 Oct 2026 00:23:07 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm8500933f8f.35.2026.10.14.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:23:07 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/24] dt-bindings: net: Add ZTE ZX279128S MDIO controller
Date: Wed, 14 Oct 2026 08:20:54 +0100
Message-ID: <20261014072109.1759502-15-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the MDIO register block and its work/register clocks. External-
PHY pin selections use pinctrl rather than direct syscon writes.

Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
---
 .../bindings/net/zte,zx279128s-mdio.yaml      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/zte,zx279128s-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/zte,zx279128s-mdio.yaml b/Documentation/devicetree/bindings/net/zte,zx279128s-mdio.yaml
new file mode 100644
index 0000000000..fb12414ab3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/zte,zx279128s-mdio.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/zte,zx279128s-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE zx279128s MDIO controller
+
+maintainers:
+  - Navid Ghahremani <ghahramani.navid@gmail.com>
+
+description:
+  The MDIO controller of the ZTE zx279128s reaches the PHYs of the integrated
+  switch and an optional external PHY. On boards with an external PHY, the
+  default pin state connects the interface to it.
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    const: zte,zx279128s-mdio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: work clock, the source of the management clock (MDC)
+      - description: register (APB) clock
+
+  clock-names:
+    items:
+      - const: wclk
+      - const: pclk
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/zte,zx279128s-crm.h>
+
+    mdio@9a101000 {
+        compatible = "zte,zx279128s-mdio";
+        reg = <0x9a101000 0x18>;
+        clocks = <&lsp1crpm ZX279128S_LSP1_MDIO_WCLK>,
+                 <&lsp1crpm ZX279128S_LSP1_MDIO_PCLK>;
+        clock-names = "wclk", "pclk";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@8 {
+            reg = <8>;
+        };
+
+        ethernet-phy@a {
+            reg = <10>;
+        };
+    };
-- 
2.55.0

