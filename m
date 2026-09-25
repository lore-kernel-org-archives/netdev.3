Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7951F2D5925;
	Fri, 25 Sep 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345081; cv=none; b=hhfMvaZRM1uMC4YIGfTKUcydH5VqBkCqwX3RJNBSDwrA2xdH2sGwYaMu2JbVWY1jhAMMA8dYDN7yK7eUOVy4yVt+6IikKPh6p1NvM/UhbsaPoR5fCAtKwOmSINS5MAcUBpk/5uWnhJzmhktoNoaoS0FkzeYZrCHBxmlzOd2nm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345081; c=relaxed/simple;
	bh=wMaxBUKrHc5FymTfjTEP+HaIZhm8YhHAoVn+tyAldP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UC/o7/YO793lWhDbvXzgZTE34/NWR7fRWbUg61ytsXf3zacVwpsNXbtdLYUrlIIHvELxpthfySZWYivArDBk0Ks7y6NLM6oPTbN7/D+cMzZLfynX1vZ0dIm7+ie//rdLvMW6t5DN6f92gCTLstWV60xyZjhpOB/wOQcIFEpCC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSov9Qxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSov9Qxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71471F00898;
	Fri, 25 Sep 2026 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790345080;
	bh=IKbtR9SYMeUdvSaucZ+oKhFaVWnqURjLW+xcgr/40Dk=;
	h=From:To:Cc:Subject:Date;
	b=fSov9QxiXLjRLe0JMfYUpYjDRPlQx9R5S+VXdxeGnivsoySe+ZwSWboV5+SAcMSa0
	 uRwD9DdiJ1EpwfmxP9Lom783bBNETJ7rEdJbrP9PLvG1mpD0ae3/iE34TpR+T8p6D3
	 ntsePzbKDvr6smi16EO80tuPz91WTNsS58a/FAu6D1CwQKyoUzA36maLNsqqh7Ey4o
	 yTeRW8kUGYbYLERMNKfauhf5dH6XCYhIivKHNnWKyEw1teS7mCH4AJGGUXumCooYBo
	 +1cNuv/55BFKmM6nTMJdoZvrDvnnxUWqhODFE4sEYtRx/C/nLgTsN8CapkJtIIXNZz
	 L127T490WAS/Q==
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
Subject: [PATCH net-next v2] dt-bindings: net: Document Marvell PHY "marvell,reg-init"
Date: Fri, 25 Sep 2026 09:04:10 -0500
Message-ID: <20260925140410.1157036-2-robh@kernel.org>
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
v2:
 - Add constraints on item values
 - Correct mask description
---
 .../devicetree/bindings/net/ethernet-phy.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index c3ebb3af8b52..df50c4c33d76 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -269,6 +269,22 @@ properties:
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
+          maximum: 0xffff
+        - description: register number
+          maximum: 31
+        - description: mask of bits to preserve
+          maximum: 0xffff
+        - description: value to apply
+          maximum: 0xffff
+
   leds:
     type: object
 
-- 
2.53.0

