Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A552C236B;
	Wed,  1 Apr 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026804; cv=none; b=nVHksAdKzU3BizezJbhMbifGBU/jt/yYeRhcmNAO/QYgzgDJgUUkLFXR3ig4vHG1R7zNOHke68kExUeo3Y3VFldb3wOaUWNwGr+kOdR8pKCkfiWn4F0JMZCXD7Ze5OGXMvbB1UIQg6h7zRKN0VOj7DrYpV7SuuYxPvWr1TLzswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026804; c=relaxed/simple;
	bh=6pMjNZLYTRCNPh+LH/UowsTNfqvG8Ua5lTl8fcBHYIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tq9uIGHOTLTNV3JsjXxAyTnswNbIzZkYnef9magQLB6SY+JkIV960vwoM8PDcTqlkVFJWxJWYUQcLB2lLuYd5gdqXJP0gZ/HlErGhntjEBEuYJtetfCQEcsv0F/JXpOfx5vT3/xIn3kJoOFs7NvoYaPVEAatwUKc8E5C0AYhiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxeYdYnA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxeYdYnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEC8C4CEF7;
	Wed,  1 Apr 2026 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775026804;
	bh=6pMjNZLYTRCNPh+LH/UowsTNfqvG8Ua5lTl8fcBHYIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BxeYdYnAlXhQpY/8acs08vQtk0+bpqd6R+lO3NfNZLpevU9bx/kY0qG8GnbXuJDZL
	 lX8znRKoKkFyTL7bUnGLLswSqE6f87VHwl3jjvnIm1jDkOAmumEo+Ilim7iuYYoSPQ
	 KGTwfzp2kfOvL0AlbWR3esVissCxKeiYCMXFkFmdEkJjv6miYBEfOWHlNeCyF5Yfqe
	 7xhAZTyWX4FhF8SThVzwgzws0ZcxWhPWvYk4SRI3v1gania1MIiUbTNzDIUHZHvhjB
	 lI2491ff5p7vHQ7BnLP19Wa5vUXzn7kRxQwMN0rWs9OkbuykyD/6lTB19ZfWNrctGo
	 7/MPCiNk9Lj3g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 01 Apr 2026 08:59:19 +0200
Subject: [PATCH net-next v2 01/11] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-airoha-eth-multi-serdes-v2-1-ac427ae4beeb@kernel.org>
References: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
In-Reply-To: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

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
 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 44 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index fbe2ddcdd909cb3d853a4ab9e9fec4af1d096c52..ebbd433e9c9fbfaefd8d07c3678cabc91574d125 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -130,6 +130,30 @@ patternProperties:
         maximum: 4
         description: GMAC port identifier
 
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^ethernet-port@[0-5]$":
+        type: object
+        unevaluatedProperties: false
+        $ref: ethernet-controller.yaml#
+        description: External ethernet port ID available on the GDM port
+
+        properties:
+          compatible:
+            const: airoha,eth-port
+
+          reg:
+            maxItems: 1
+            description: External ethernet port identifier
+
+        required:
+          - compatible
+          - reg
+
     required:
       - reg
       - compatible
@@ -191,9 +215,27 @@ examples:
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
2.53.0

