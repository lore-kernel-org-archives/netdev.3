Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD66351C3B;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895366; cv=none; b=cVL/mkgREc6pZU0RiP94dKkFivKNEeLef2Vp01CAtbxGZysaaeWZNOYb/dt2eILx0Syoyb7zKdcHsmjW2OfMo/p0nvDhynbiSEpwnG0JNEgz5RVGUFcyskCDsAHYqgv5kVVkOniilgW54GxJDxY6W1k2g7WKX+HgwHpG7iiWoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895366; c=relaxed/simple;
	bh=MHonpYPDMxu6OCmszC5LL+NjrY8r/y0Ipf59wp1R70c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BH9YTRIENY+V79LmYRpMY4xIOZ7p8QFERQZuiJzT9V3WoBn5yuhiMmBMxcoBN+j4RgzJaRdZ6bcK0l5Ln1sVm1ykOPCZcJqe7Dk3Kw2cw7yh3zaeCKwH2fkMCG9CGqAqf/4qJc4+CtQ7/wz6ENuOgySQjjHFBkwnBEXTQbU3pAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG5by0qH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG5by0qH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 410ACC4AF0F;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780895366;
	bh=MHonpYPDMxu6OCmszC5LL+NjrY8r/y0Ipf59wp1R70c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jG5by0qHVXXZQ5k3d9mTz3N6zOtAbsqKMGrpyhhSeehg5fNTkeIuk6PnsQa1kGvw2
	 6PxvAjz7WKbFY1Ks91HgZG1/lDJ+u15Zu59k+kB2bI6cVq4iEzcnA7J6NdF5GY0DUr
	 QEkgwGo4XyRNgLp/A0C8+5S8NyRBnZLDn8bzmc5IG8CRLniMk9QUZ5DM+jF8f5OUb0
	 WMo9TGqjGuHhN/DXPaJMuqyQcZOI3ivEENihNZhB+eKiC0fnVZRyI31EnEVjoQWvsH
	 Aw905p73vKFnxPEb1rK8Eb6j8tAHgDmHjOzwylWvzZSfZPG3SW7zO6E230LuZ0sHvU
	 CCrYugV41j7/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C1CD8CA4;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 08 Jun 2026 09:09:17 +0400
Subject: [PATCH v4 2/4] dt-bindings: net: qca,ar803x: Add clocks for
 IPQ5018 PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ipq5018-gephy-clocks-v4-2-fb2ccd56894b@outlook.com>
References: <20260608-ipq5018-gephy-clocks-v4-0-fb2ccd56894b@outlook.com>
In-Reply-To: <20260608-ipq5018-gephy-clocks-v4-0-fb2ccd56894b@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780895363; l=1860;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=9Z6aakN1HhLaGxa1OIpuGJQY0KdKMjoTdfWwUAWMHF8=;
 b=LFiQLhl1FVNGLEM516fSBbYg8lSXLhkWN81pTJCG8OTIG3vU3BNpXECY+Lu3BxKynEH5/ryOX
 ra0oht7UxLMDwb1HAxQD9mBLxbNlt61o7RTYCabPTmcpTChqGFPytqU
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


