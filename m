Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4FD3859D7;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663299; cv=none; b=NshNnbCNKK26HCNdGeq1myJcHYZvKCoabZ9M1PYDKy3qf4RFq57Ph7nO1850VGto7QNKdblJDQVw9v99Yio5mYQ7hi2/UcXcNuJ1+lm7/bKnmI7B1RxHD98L4zUb8QFFIhYISV+JfKr3N80UjdlcpaktoPGBn8WfyLxeMdKkWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663299; c=relaxed/simple;
	bh=MHonpYPDMxu6OCmszC5LL+NjrY8r/y0Ipf59wp1R70c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4/JAplDVZ4CpEwMJ36kda17W/7Of0ecoL+VDgQBh8/r0qj2kYFY6rS7yrcrvc3dhQIVU8Uue1F5w67g7typh/ZuwHHnnzV9WFBxOmHA75t7XixNkje2pA0qlgHmedx5cAOzjtWapArNvoZ8n33kn0VliGYuT73skdRxYoSeX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW9QGRBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW9QGRBV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 301A7C2BCC9;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780663299;
	bh=MHonpYPDMxu6OCmszC5LL+NjrY8r/y0Ipf59wp1R70c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bW9QGRBVPPBPg0XxS2PSC7b0CEnK7TAWqGjyssS45Ub8Gg0kWyf6KKi21kl1T9fHC
	 YvigMwBGdOoQqzJ+pnbAtnAG2cbEUuFlCXNRdQo/KKHFK4FGXWGIXwDEF/OsSoXj1f
	 uxcpDapHp6lbKFr/5n1ttmj4Y0gCjfYAky4fz9wYombzToFVUZYkUGocDsq28BAlaD
	 NpZi4Tql4tkpiDMRcMB3oSN8klfLgPD95fED6yy8PMmkTs/IV99uMW9JSJ68RJtdnR
	 NlilCYHe/IjtD0Ci8gbkw9SW6P5Kw+u5ck6Eg2hCNx1w9IfoRqTBTt0TUNA0o7zweL
	 9ePqjcYX6znqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD5DCD6E7D;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 05 Jun 2026 16:41:27 +0400
Subject: [PATCH v3 2/4] dt-bindings: net: qca,ar803x: Add clocks for
 IPQ5018 PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-ipq5018-gephy-clocks-v3-2-f232d9ca0966@outlook.com>
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
In-Reply-To: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780663297; l=1860;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=9Z6aakN1HhLaGxa1OIpuGJQY0KdKMjoTdfWwUAWMHF8=;
 b=35vQ31A2+T17FdYHX7YbK3+f5sFkkYEKYcD//bJOBSMWqZ/OLQc7yybfbzinL6bN6VT3HtvsI
 HtS42u2mHmVAmzwfUK7DmlabPItaAz96c6JMzn7Fm1rl0Jok8KiZmES
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Further testing revealed that the RX and TX clocks of the IPQ5018 PHY
need to be explicitly enabled. As such, add the required clocks to the
schema.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/net/qca,ar803x.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
index 7ae5110e7aa2..53f648c4135f 100644
--- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
+++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
@@ -28,6 +28,16 @@ allOf:
         reg:
           const: 7  # This PHY is always at MDIO address 7 in the IPQ5018 SoC
 
+        clocks:
+          items:
+            - description: RX clock
+            - description: TX clock
+
+        clock-names:
+          items:
+            - const: rx
+            - const: tx
+
         resets:
           items:
             - description:
@@ -42,6 +52,11 @@ allOf:
             of this PHY are directly connected to an RJ45 connector.
           type: boolean
 
+      required:
+        - clocks
+        - clock-names
+        - resets
+
 properties:
   compatible:
     enum:
@@ -162,6 +177,7 @@ examples:
         };
     };
   - |
+    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
     #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
 
     mdio {
@@ -172,6 +188,9 @@ examples:
             compatible = "ethernet-phy-id004d.d0c0";
             reg = <7>;
 
+            clocks = <&gcc GCC_GEPHY_RX_CLK>,
+                     <&gcc GCC_GEPHY_TX_CLK>;
+            clock-names = "rx", "tx";
             resets = <&gcc GCC_GEPHY_MISC_ARES>;
         };
     };

-- 
2.53.0


