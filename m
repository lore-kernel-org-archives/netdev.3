Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510586;
	b=FRVEp5ybzKoPECqC+Ga4zZ1W2XY9NKiizWELehp7NZarQelTP14pEKaeJ3rOV1qwwySR
	 gNFrCI6zgJ8Wg41KNUKU0OXO6EoDpgk8EkMm7X5JX1SpJk5WQBRVx1wAujyx4Te/IrEyy
	 K8he8pIP1hMvxqiuS4ReeYBZFR5ec31YvL0NG3uerR5pNSUNNL4PkebQVpy/cRRu8cYv8
	 EGhbsTLjNU39ulonps8Kf/mQVPo53aTAB/pCXJO0RwNEIaRxPizLAwQ5tlPL3x9wNW9a3
	 TeEfQfNa74OMqL66yDJ2Hj7a8AfVfFqUn2OSWsNl4eAvWuQGcx/pIIHkVGEKIKFeh/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510586;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sJQr+gvBgyWCXNcDuYBIUccK+tp9NBCw7G3cq8vaix0=;
	b=JanyXVXeAg2cjXUKW6y5Pob0oQe9//aFPJy5iwpE72Zm8TEEqqEZyfWDZWWUvsbi3VKD
	 j8URLbM9lGqTw+m4HubOPrmRJ13xnVwdL2ZicJlnTNy0FIUQu2kMA41LdEsWZKRK7LT3B
	 SVbWCL1wEcnD1F/9qIZyZDkpXkFkp8q4tLLIe2V7SZxH50N1KRJhew6xKfj+u1M0R0zxy
	 0m3mz5zftMLmwbc5Ca+4pO9HkVRfaTgHHMhhB5WXwn3I3pyRJV1KdPauFNzi0Dv+T8MrT
	 tWHVHwYjBUbkPcj7GCwocH6JfnfHB5zfe+bYBtG4sIifNfA6ZWcO55ZELfJeRph2PPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054E606A338;
	Thu, 12 Nov 2026 19:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A054E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1403:f2fc:83ce:6656:246:c906] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xRaAw-002XyJ-2j;
	Thu, 12 Nov 2026 20:09:34 +0100
From: John Crispin <john@phrozen.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	lei.dong@airoha.com,
	Linqi.zhang@airoha.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Rajeev.kumar@airoha.com,
	upstream@airoha.com,
	Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: [PATCH net-next] dt-bindings: net: airoha: add AN7589 MDIO controller
Date: Thu, 12 Nov 2026 20:09:28 +0100
Message-Id: <20261112190928.1318743-1-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AN7589 carries the AN7583 SCU MDIO controller three times, the
third one at offset 0xd8. Document it as a fallback pair on the AN7583
compatible. Allow the new offset for the AN7589 only.

Signed-off-by: John Crispin <john@phrozen.org>
---
 .../bindings/net/airoha,an7583-mdio.yaml      | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
index 3e7e68ec1560..41dc295ce6cf 100644
--- a/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
@@ -17,14 +17,20 @@ description:
   The other 2 (that this schema describe) live under the SCU
   register supporting both C22 and C45 PHYs.
 
+  The Airoha AN7589 has a third controller of this kind under the SCU.
+
 $ref: mdio.yaml#
 
 properties:
   compatible:
-    const: airoha,an7583-mdio
+    oneOf:
+      - const: airoha,an7583-mdio
+      - items:
+          - const: airoha,an7589-mdio
+          - const: airoha,an7583-mdio
 
   reg:
-    enum: [0xc8, 0xcc]
+    maxItems: 1
 
   clocks:
     maxItems: 1
@@ -41,6 +47,21 @@ required:
   - clocks
   - resets
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,an7589-mdio
+    then:
+      properties:
+        reg:
+          enum: [0xc8, 0xcc, 0xd8]
+    else:
+      properties:
+        reg:
+          enum: [0xc8, 0xcc]
+
 unevaluatedProperties: false
 
 examples:

base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.34.1

