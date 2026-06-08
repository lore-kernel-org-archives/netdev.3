Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE723546C7;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895366; cv=none; b=hA1Zw9L6Vo/xcbngIhaaWD5aZMQldTphWq1Of/IMErNi8KyHRNwrK84W9WfgP9BKdXbWgMNoEo5M9mgtFhB5TEPQDUWeQ4B01ecwcFO6QMXUV7wsyE2yVwFk5N6T+wC9lWBMl/hlOX1ji7j//fBl4UkEOM44BT4w7XBdmMOKlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895366; c=relaxed/simple;
	bh=FTpVYp3SNjDHJXuzqJNM/Yy/p1AidEHECx8m0pNn1cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bsUd7fNNtFMtAnJ+59J4hP30eyisIaTEp/PKUmwRNchtRbyZ3e5g6Wz3GJduQmukmuoJD1ccHAKYRhSpWS6RSHT7XDGFUvveUiETNabW04iIFQ3P+xp89UzLOsr+kby1ADIY+U+XQzyGzWF5lLT+KYBlkUvTFmyxjEARWR+jdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlMqyAlG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlMqyAlG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DB64C4AF0D;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780895366;
	bh=FTpVYp3SNjDHJXuzqJNM/Yy/p1AidEHECx8m0pNn1cA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NlMqyAlG5eHwkQC/4wNbd4nWhWXtMr5Km0GbSRgckdNP3iZ0qa+pivgnlZEnkCbUc
	 CQvF2YdJNAoV1aL35o8vNrZpBdTCc/W+8Q8czESFjxPlZsM7aigbSmxsNMDYmuaEBK
	 z1ILHSqeRJeCq80Y53UwpP7tXq98d3x959mzk9LMwzTH9H3bCelhiQwWcQNXE+cxEJ
	 ZTF2Pvx8+QzDmJBA0xR7omWV2lWmfLMnk/HLiYDsn2L72kOdaNeeJ2PEjQe+BfHAsJ
	 ZdRlXI+2Nd11aRPGxLuWaJMcNBF8Do8HDv4/IFHh0QgBvECblfLRrYGKgHoNe34SJI
	 kVK6hMj3lp2Eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD63CD8C92;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 08 Jun 2026 09:09:16 +0400
Subject: [PATCH v4 1/4] dt-bindings: net: ethernet-phy: increase max clock
 count to two
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ipq5018-gephy-clocks-v4-1-fb2ccd56894b@outlook.com>
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
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780895363; l=1739;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=Z1y1sb/C6IBBeEe8phafQKeS+tps86kaaT04aCdDGu4=;
 b=5YgbBl86exwswdTbg8F7C3+4Qbnpx3RC8aabNiGe0nIwlCo3fl3ekSX411uaPX91bM99W98IX
 TA/pGoNDsGnD08pu041kV00IBFGtdQP2yn92ms/rhtqX7ddYm6Kso68
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The clocks property has a restriction to maximum one.
Yet, some PHYs may require more than 1 clock such as the IPQ5018 PHY
which requires two clocks for RX and TX. As such, increase maxItems to
two.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Commit 350b7a258f20 introduced the clocks property with a restriction to
maximum 1 to the main ethernet-phy.yaml binding for Realtek to add an
optional external clock source. This is restrictive to all PHY bindings,
as some PHYs may require more than 1 clock such as the IPQ5018 PHY which
requires 2 clocks (for RX and TX).
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 21a1a63506f0..c3ebb3af8b52 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -106,10 +106,13 @@ properties:
       by software.
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
     description:
-      External clock connected to the PHY. If not specified it is assumed
-      that the PHY uses a fixed crystal or an internal oscillator.
+      External clock connected to the PHY or RX and TX clocks that the PHY
+      requires to enable explicitly. If not specified it is assumed
+      that the PHY uses a fixed crystal or an internal oscillator or that the
+      RX/TX clocks are hardware enabled by default.
 
   enet-phy-lane-swap:
     $ref: /schemas/types.yaml#/definitions/flag

-- 
2.53.0


