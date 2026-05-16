Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D7175A7B;
	Sat, 16 May 2026 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778911051; cv=none; b=TDoe93vKPo+Dz463mO8/FnZWyODh0pQQ2J+oaWKG/HTy1yIM1hrYChshL6ZJPfY75jqK+/gRvtuT/Ez8EDbVEdEdJmgZHxPLqqWow1vlZmFvKFb5TjPEZNYhoPbaR1QwXln3TIm/bTCuDRQoFRMzV6ZKHIGE6BKXfgVS9YCHcJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778911051; c=relaxed/simple;
	bh=wt/iUT/srJA3YrQOY0ISD48p7R6W/7WcnFf24KbsVTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnA+6fxfotW0fYBW1tdZCdmDLaau65M9csPHXU/+EUPvpu+bvY99n16ZckkI3rEJcg8O7uV1NM1yArMWP0amo6vp4S03T601SJE7XPCjqcNcZ0NL3xXovXbsuUh5su2TGOhg+LpdRRrzObk26WmAQYHOP0u29P8pvFnt3ChoOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5ugvjTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5ugvjTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FF6C19425;
	Sat, 16 May 2026 05:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778911051;
	bh=wt/iUT/srJA3YrQOY0ISD48p7R6W/7WcnFf24KbsVTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G5ugvjTRXZZY+7DEVwEk70pafiQYQ3dozOokfWHulTqiUoSPR3rlBkbpfGQSSB664
	 5J+hoOIKgn+nYHULsDfA3abQKM2WJRPcW1fXp9ai+E71I/59kg1c2zInvcQUfhAsHq
	 ScZvltyRHfnx2owfgUh2ftO7RIz4i3aY8iyCUjeuWvqThaX5mW5jwvd7gyMvy+qI5R
	 Hm7/DgX3GjMUwAZDOx5+877sT4Zq+slGSofMaJqDdDRghfpyNeJ/7qM+7mvNqE+sAc
	 XT+y/g5UM3/wTKg1Y3xp+ru7XMFJYodM/CTumiL5kVWq+XqjPOTpc/es7wUH/gxuNg
	 dRnPaSA2fDtag==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 16 May 2026 07:57:03 +0200
Subject: [PATCH net-next v7 01/10] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-airoha-eth-multi-serdes-v7-1-99e0093303e2@kernel.org>
References: <20260516-airoha-eth-multi-serdes-v7-0-99e0093303e2@kernel.org>
In-Reply-To: <20260516-airoha-eth-multi-serdes-v7-0-99e0093303e2@kernel.org>
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
Introduce the ethernet-port property in order to model a given net_device
that is connected via the external arbiter to the GDM{3,4} port (that
is represented by the ethernet property. Please note GDM1 or GDM2 does not
support the connection with the external arbiter and are represented
by ethernet property.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 60 +++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index fbe2ddcdd909..7144d6da7394 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -130,6 +130,46 @@ patternProperties:
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
+                  maxItems: 5
+                  description: External ethernet port identifier
+
+              required:
+                - reg
+                - compatible
+
+          required:
+            - "#address-cells"
+            - "#size-cells"
+
     required:
       - reg
       - compatible
@@ -191,9 +231,27 @@ examples:
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

