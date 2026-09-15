Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C643BDCB;
	Tue, 15 Sep 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494459; cv=none; b=GpN6/dI657DWZZXNuyk7yx7jrYVubX3pGX2LdeXDRBW7H9xlV3iIhqNk37qWxW5kUXZT+0F2ieXShkgn5/+WP/CznoR7jF1KyR9hIJpWHQUiKKEAsaQ3IE+BhhagkLRQB5305wv5E2qSLYfLQ9e7zXWGsMrehMnomsZupH/MSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494459; c=relaxed/simple;
	bh=TqpjP5ctdbMBfjdQ3xchi3iQf5+kqiUB8ayK9Hx6gCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5tK4D806tN1qhqUVX4AczQSaivp31v99XOO9qhTR1yA2w7oq0SUqniaqOOV+RGbJwlShUj9E4P9ziP7qVi497Hdv8DTQK1xnZKLYMY+uVtrfB3jSlgrZ9+Y85XAkeDiXD3ArrSLz9lK94LkzaHVRTGCuF34RKeFzB2bxQ+buRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=oOkVdIbj; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="oOkVdIbj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA8C948E84C;
	Tue, 15 Sep 2026 19:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789494451; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GbZ+kq+bXbuQJ0qyjJXlbpAYIP3f31dn92HzYKo8G1Y=;
	b=oOkVdIbjfxds+BRAwak3MjBBbThgCRfKwQF97ft0RzNuADZIZrZrBn4FnfgTUdexnc3b01
	2Mw6vo7/YXm4F+Go7qoLc3vte35jgCWyzddzUU1JRyz1DrgFOezrSfzunWSB/ZeiH12swq
	QHN69XwxTQtD0gdAq7F/tcxM4Jkl6YzS45ztWZzDRyv7kdU7Uzg+rlvFsUsVdc2O0x7tre
	Sq6eQtqSpnlAAfVbOcaPyvSe8sirXcZpxbgm+wrUZI+nhpF1oiu/Q+pIBrkpFdcw/1RJmb
	u8jsB5lpjcEHBYNGTtecLu3UucJUaWoRhb3JM2IF7ShPgOl2LdYtQFNxq86paw==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	linux@armlinux.org.uk,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v2 net-next 6/7] dt-bindings: net: dsa: mediatek,mt7530: add econet,en751221
Date: Tue, 15 Sep 2026 17:46:42 +0000
Message-Id: <20260915174643.253660-7-cjd@cjdns.fr>
In-Reply-To: <20260915174643.253660-1-cjd@cjdns.fr>
References: <20260915174643.253660-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EcoNet EN751221 MIPS SoC integrates an MT7530 switch memory-mapped
in the SoC register space. It is similar to the econet,en7528-switch
except that ports 0..3 are 10/100 only, port 4 has a gigabit PHY, and
port 5 has no PHY, but is in some implementations connected to a
downstream MT7530 multi-chip module via a TRGMII link.

The downstream MT7530 is similar to the MT7621 multi-chip module and
has all gigabit ports.

Add the econet,en751221-switch compatible with the same constraints as
the other built-in switches and also add the econet,en751221
multi-chip-module switch whose port 6 is configured as a DSA link port.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 .../bindings/net/dsa/mediatek,mt7530.yaml     | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index e29fb8693498..106c4087528d 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -29,6 +29,12 @@ description: |
   and the switch registers are directly mapped into SoC's memory map rather than
   using MDIO. The DSA driver currently doesn't support MT7620 variants.
 
+  EcoNet EN751221 SoCs have a memory mapped MT7530 with 3x 10/100 PHYs and 1x
+  gigabit PHY. Some EN751221 chips such as EN7513G and EN7526G have a multi-chip
+  module implementation of the MT7530 as well as the on-die switch. In these
+  packages, the multi-chip module is connected to port 5 of the on-die switch
+  via a TRGMII link.
+
   There is only the standalone version of MT7531.
 
   Port 5 on MT7530 supports various configurations:
@@ -111,6 +117,14 @@ properties:
           Built-in switch of the EcoNet EN7528 SoC
         const: econet,en7528-switch
 
+      - description:
+          Built-in switch of EcoNet EN751221 SoC
+        const: econet,en751221-switch
+
+      - description:
+          Multi-chip module MT7530 in EN751221 SoC
+        const: econet,en751221
+
   reg:
     maxItems: 1
 
@@ -160,8 +174,8 @@ properties:
   mediatek,mcm:
     type: boolean
     description:
-      Used for MT7621AT, MT7621DAT, MT7621ST and MT7623AI SoCs which the MT7530
-      switch is a part of the multi-chip module.
+      Used for MT7621AT, MT7621DAT, MT7621ST, MT7623AI and EN751221 SoCs which
+      the MT7530 switch is a part of the multi-chip module.
 
   reset-gpios:
     description: |
@@ -223,6 +237,20 @@ $defs:
                 phy-mode:
                   const: internal
 
+  mt7530-passthrough-dsa-port:
+    patternProperties:
+      "^(ethernet-)?ports$":
+        patternProperties:
+          "^(ethernet-)?port@[0-6]$":
+            if:
+              required: [ link ]
+            then:
+              properties:
+                reg:
+                  const: 6
+                phy-mode:
+                  const: trgmii
+
   mt7530-dsa-port:
     patternProperties:
       "^(ethernet-)?ports$":
@@ -330,6 +358,7 @@ allOf:
             - airoha,en7581-switch
             - airoha,an7583-switch
             - econet,en7528-switch
+            - econet,en751221-switch
     then:
       $ref: "#/$defs/builtin-dsa-port"
       properties:
@@ -337,6 +366,16 @@ allOf:
         mediatek,mcm: false
         reset-names: false
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - econet,en751221
+    then:
+      $ref: "#/$defs/mt7530-passthrough-dsa-port"
+      required:
+        - mediatek,mcm
+
 unevaluatedProperties: false
 
 examples:
-- 
2.39.5

