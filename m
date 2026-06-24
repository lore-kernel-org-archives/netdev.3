Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354316F27F;
	Wed, 24 Jun 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313402; cv=none; b=YVidABfMlI6QOKYb9pvYKUKcRojemFaadZmJ3IslVnDRONW1zF6Btp+m7z/pLPWpYsEPDzLxVJMezptfy+9s2/l6ApV4pSsJTB1sdLbDogNKI7jhXFajFp210vJCQOc4bSlWTZKauQLfUHtCu4+MFt6OsqfHnL2qQhvufIzkdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313402; c=relaxed/simple;
	bh=EgeMv3LeUurApowpd/AA+HwFECgYzVaHejtU6nS2KPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajlXmaohAIu6MbcEkE3caWsKAnMGQQ6mAWEPK7EP70rZH25JCV9Ya0txV4zyVF1LKkJeRXIZV3pdEqHw+hTgOXH3it4rh9iiHRysbWixI0iMuIDr8m1g7PB927Lwy6p4Yfq8nb/+40SitjEzJdxbuRtcIzn7E+cj/+tr8CZCZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDk659yU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDk659yU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF491F000E9;
	Wed, 24 Jun 2026 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782313400;
	bh=8unGs6rbGg9eZccPCqQKdo02LVUJ1cmOkH4JAvhO2s4=;
	h=From:To:Cc:Subject:Date;
	b=KDk659yUXsZ1T1YM9gK0zBqyv1q0UuxepuHjtUsBiEmdZlwZzeyqG1Cyzn5oC5FRu
	 PyeuILawOEY7SALc/WG/s1JocO07eh8ZxeftRXwyrX5QYD3uC356b/9FbS9DEW1RLS
	 ovzzKMHbfWaaPeGapbvF3tDI4lJZAZXFAlFElRJV/JxkAmboUqY98my6yioZiq7xg5
	 WGzdIHLc9ENlLUg6gjxebQ2aafUmlZ7twpBpqpz/059ZLgKa8O8NC+ZxELn85+c8eS
	 40mr9x3hxprza+i5CrLPT1970IEsmicTS4kHCPcmXUk9Wrj0WqwPUWNtnlMrJjzzQY
	 JBmVfE5sCE7IA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] dt-bindings: net: renesas,ether: Drop example "ethernet-phy-ieee802.3-c22" fallback
Date: Wed, 24 Jun 2026 10:02:50 -0500
Message-ID: <20260624150250.131966-2-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the Micrel PHY in the example which shouldn't have the
fallback "ethernet-phy-ieee802.3-c22" compatible:

Documentation/devicetree/bindings/net/renesas,ether.example.dtb: ethernet-phy@1 \
  (ethernet-phy-id0022.1537): compatible: ['ethernet-phy-id0022.1537', 'ethernet-phy-ieee802.3-c22'] is too long
        from schema $id: http://devicetree.org/schemas/net/micrel.yaml

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/renesas,ether.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ether.yaml b/Documentation/devicetree/bindings/net/renesas,ether.yaml
index f0a52f47f95a..dd7187f12a67 100644
--- a/Documentation/devicetree/bindings/net/renesas,ether.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,ether.yaml
@@ -121,8 +121,7 @@ examples:
         #size-cells = <0>;
 
         phy1: ethernet-phy@1 {
-            compatible = "ethernet-phy-id0022.1537",
-                         "ethernet-phy-ieee802.3-c22";
+            compatible = "ethernet-phy-id0022.1537";
             reg = <1>;
             interrupt-parent = <&irqc0>;
             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-- 
2.53.0

