Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1065F3CE0B0;
	Wed,  3 Jun 2026 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466465; cv=none; b=rVRxucj/5PYNbOWGetAiOmV5k3/ikKkzeG0AM9Xc3rA2pRG2uEcNVzOJudGaI7bPSGHIPya3+2mI7jsNPp+zhL8yZb1hDMJdPrlv7YegDpWwZgqmhUGP2GASHB8hVhbt1YrsBu1oiOpAV4k61axzqAzvmV39t02JGXke9aSqZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466465; c=relaxed/simple;
	bh=Ao55FmWOwx/Y9r3sNEXJN/Ahfz4UNE+4z30/nsLOMeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zy2ZH8UDc5eOnrkMASqvlnlC93ejTO8ZOL7VptiNKIMvVJ4ufINm+0GMX4Ob2FCryeAi6s4UUQPtnT6KsVWFSIgwE5HGC4MqwuFiCXTB+lVxzSErnxFB2nmvQQktCPCjMHteIH6+iyQzMsVyOIXTufzCig7ydMKsJIwlsl9c3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2w4vwSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2w4vwSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370A11F00893;
	Wed,  3 Jun 2026 06:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780466463;
	bh=Q3bsDHY4zT4OOEbFiIvYw60Y+WRRMdHm85pPHhesy2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N2w4vwSUsct2QPHlmtOhz9IDz3tbqDxeuEzoPRHfBsBO6tKwEjOsVYYfq5P7m2Yih
	 IqrLeLBSJB786r6YYKABjCA+EgxcGpuATMz3RqCAyPAaY+V+Hps6eQPTjbTPPy+OaV
	 XTEUvMx3MSj4vn6VlgQ/QuBbQvl3qELkJiYUzTS5db/O8D9yhLxZWqwaUUP0bofrps
	 iQ79yhSZU5Pwh1He1HAB82I7UbP8F8oUXhY8M0JItXD7ATDrtCyW/JqY7q85KXzzTj
	 Q0cq5+F+eCb2XmUJgkeU5l0j+CtF8oXfjdFxKqZjuhZoO6wu1d/6bgoSmE9dA7qY68
	 j33Nest2DSNVA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 03 Jun 2026 08:00:15 +0200
Subject: [PATCH net-next v9 1/6] dt-bindings: net: airoha: Add GDM port
 ethernet child node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-airoha-eth-multi-serdes-v9-1-5d476bc2f426@kernel.org>
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3

EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
As a result multiple net_devices can connect to the same GDM{3,4} port
and there is a theoretical "1:n" relation between GDM ports and
net_devices.
Introduce the ethernet node child of a specific GDM port in order to model
a given net_device that is connected via the external arbiter to the
GDM{3,4} port. This new ethernet node is defined by the "airoha,eth-port"
compatible string. Please note GDM1 and GDM2 does not support the
connection with the external arbiter and they are represented by an
ethernet node defined by the "airoha,eth-mac" compatible string.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 56 +++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index fbe2ddcdd909..17fe2edf4886 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -130,6 +130,42 @@ patternProperties:
         maximum: 4
         description: GMAC port identifier
 
+    allOf:
+      - if:
+          properties:
+            reg:
+              contains:
+                items:
+                  - enum:
+                      - 3
+                      - 4
+        then:
+          properties:
+            '#address-cells':
+              const: 1
+
+            '#size-cells':
+              const: 0
+
+          patternProperties:
+            "^ethernet@[0-5]$":
+              type: object
+              unevaluatedProperties: false
+              $ref: ethernet-controller.yaml#
+              description: External ethernet port ID available on the GDM port
+
+              properties:
+                compatible:
+                  const: airoha,eth-port
+
+                reg:
+                  maximum: 5
+                  description: External ethernet port identifier
+
+              required:
+                - reg
+                - compatible
+
     required:
       - reg
       - compatible
@@ -191,9 +227,27 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        mac: ethernet@1 {
+        ethernet@1 {
           compatible = "airoha,eth-mac";
           reg = <1>;
         };
+
+        ethernet@4 {
+          compatible = "airoha,eth-mac";
+          reg = <4>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          ethernet@0 {
+            compatible = "airoha,eth-port";
+            reg = <0>;
+          };
+
+          ethernet@1 {
+            compatible = "airoha,eth-port";
+            reg = <1>;
+          };
+        };
       };
     };

-- 
2.54.0

