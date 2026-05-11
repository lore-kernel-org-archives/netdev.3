Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AEA3D9DA8;
	Mon, 11 May 2026 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496594; cv=none; b=HELioK9LkjbaeLd6Uyj0NozQMZEAmdVuyPyJduFKUrCuyUBXvJkQcJRRbn53tKuECWFkjODLG3iKQzH44dc9LlQam2Ic5GOemRePRzeoXNRm3GFVcJUtPBDRB9bfG4izgbjtyTa73R1HJjHX1YcqF6dw2DghnSllPaKxQInFw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496594; c=relaxed/simple;
	bh=QxxhC8LqLTcT8vx7bsRBEu1M260skhi5xrm4q3nrnjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDaY5Io9OfPfEKPa6lYtYuGIL7P6K4aQZNPU+s2c8+/jVBSEg1tzX1vySxD+l9AGamCDau+g+8PvsLmXoz92fCxebBUUpwGReN/lH0Z70torx6YBWoI+zzrLz7gq33d0A2LyDsV3CHh/DN3420BXkJtcMiAGteewEUZCkvz2+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTow40m/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTow40m/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A370C2BCB0;
	Mon, 11 May 2026 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496593;
	bh=QxxhC8LqLTcT8vx7bsRBEu1M260skhi5xrm4q3nrnjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QTow40m/m0fbxLGFhmg8DdaHsTkkcC5nNQgJtCDqM9N8LFXAruVLMsUGdcnr/fnL5
	 AXBiAFfrD5MdvhQDy/vlhs/00FzdFzLbf7ITcM+5ZFVC3iNPeei06eZ0mIxWLQkFZ5
	 Rc8TMxSrwRxQHgobA9lwlaEKCSOH2eHihly2nccYphf1cD7u2Om7GEa82plJITcVqE
	 eNS7m3xK/p9vFVlI36WM0cntBbzvxjt152WDe7O/FJkELQ9zCaJ8PTf7bJ5mjGYisM
	 CX+759eq5ur8qI/W1uo6QqQyfqWdoDomotP4LhFI8KH+mElkokC4JLSAtKxFS0xF0F
	 0rapBC6HumHrg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 May 2026 12:49:27 +0200
Subject: [PATCH net-next v6 01/12] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-airoha-eth-multi-serdes-v6-1-c899462c4f75@kernel.org>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
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
 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 64 +++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index fbe2ddcdd909..642f300c0945 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -130,6 +130,50 @@ patternProperties:
         maximum: 4
         description: GMAC port identifier
 
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
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
+            '#size-cells':
+              const: 0
+
+          patternProperties:
+            "^ethernet-port@[0-5]$":
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
+                  maxItems: 1
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
@@ -191,9 +235,27 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        mac: ethernet@1 {
+        mac1: ethernet@1 {
           compatible = "airoha,eth-mac";
           reg = <1>;
         };
+
+        mac4: ethernet@4 {
+          compatible = "airoha,eth-mac";
+          reg = <4>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          ethernet-port@0 {
+            compatible = "airoha,eth-port";
+            reg = <0>;
+          };
+
+          ethernet-port@1 {
+            compatible = "airoha,eth-port";
+            reg = <1>;
+          };
+        };
       };
     };

-- 
2.54.0

