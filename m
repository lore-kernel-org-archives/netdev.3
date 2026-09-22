Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEE1F938;
	Tue, 22 Sep 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101968; cv=none; b=swV8oEG++/h5n0ohXn3ykmZ+VkdaJk6fGH7Xmmx2wR49MTB41GVD5xPXQo2ktoIB6t8Xk0PuuazQDuTcA6vLdsVEZtxqFskBGVxloXtePkyzbnp9ZMJSR4Mnt/uFRqJOekv4eLOZ3YcoiKaV+kItQRaFgRGVWficNCD41wPfEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101968; c=relaxed/simple;
	bh=Ag2czitZaMZfA2I3HD81mCBDFf+korFtdKZCqcxA71g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taKZd6WH4qQWgYc03bBgNEtI/GdE60hBTnzsfljojx3AiKOdjR6wKzneP2XbsLxXUWwj/VjlMqeiieC4/Rkgx0SDmInlQRP7npHZUl7CHuLhZWF/+tWXYTFTzFczcd3n8BlUgCjs7Z5WiBWsAi82NJeBlb3EerhJPOy35J7FuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGCF/+X2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGCF/+X2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4861F000FF;
	Tue, 22 Sep 2026 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101966;
	bh=p2mEjYJyJpQQ2ZRFzX8VBX04nxjYh4V+goELORxWKno=;
	h=From:To:Cc:Subject:Date;
	b=jGCF/+X2CkGo09kz36OdMYB3+f6ugQcOnu3atMmE/MFVro8sXhWqC6s8yl8WulFS/
	 RK8+8f9qtPOUSF88/o8l2sUqq24gjWFtQP78eKRaeXbsrYFceRaqy7qqm+GzJLaQCA
	 oY43P3qPDRKEsyMjFRr3qSq4VXEQlR6RWp00hrmjXHV6SZyyXRNvmiSmBwVyREq2fv
	 O8cgkF29fhiWcZPx8+0ljhY/xmB0WxlOPDvviW3ZUcdhLAnU3jZAHuuoOqgOileSnD
	 pUW1dIiQbhYoaR7JNeoZIIzsJE1WgzYQIAFdNLdt6dJtdLwtxU/MA4ntsxwR5dvrh7
	 xY77b5IOiC3wg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: Document Marvell PHY "marvell,reg-init"
Date: Tue, 22 Sep 2026 13:31:57 -0500
Message-ID: <20260922183157.291091-2-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Marvell PHY driver consumes marvell,reg-init as one or more
<page register mask value> tuples. Define the property so dtbs_check
validates the existing board descriptions.

Existing users have no compatible or just "ethernet-phy-ieee802.3-c22"
so this has to go into the generic ethernet-phy.yaml schema. Marking it
deprecated both for that reason and because opaque register
initialization values are discouraged in DT.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/net/ethernet-phy.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index c3ebb3af8b52..336f73f9c43f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -269,6 +269,18 @@ properties:
       have to be placed on board. When omitted, the PHYs default will be left as
       is.
 
+  marvell,reg-init:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    deprecated: true
+    description:
+      Register initialization tuples for Marvell PHYs.
+    items:
+      items:
+        - description: register page
+        - description: register number
+        - description: mask of bits to clear
+        - description: value to apply
+
   leds:
     type: object
 
-- 
2.53.0

