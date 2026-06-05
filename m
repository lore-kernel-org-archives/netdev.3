Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EB38F654;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663299; cv=none; b=M0s7caiD17jR5oMIlxV26LiEUgtKQmWsdqQmmrNHAIRwzXrU8IFBSN9G7PA/2697VrCGKcv0PTDrwHyPCk4YPbH1hgDbvcbOqvoTE4xUWJZbojclaFWoK/BaGeUGtVhFXb5CoHM4BW3nxZaMWXjZyhK+syW5b7j+h+C73tVJSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663299; c=relaxed/simple;
	bh=Xw4DKj40SdH5fG0f1lsN3gM94qCWap7opuJXIrQQIEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNMXumrTT7vl7KJXm2IKRndtRQKlzNPfVHhbg7yrBpK7QNNHO76l/ArlRlxToR5jcV79/wR0vnjh+e3ekglE4moAn/OQJkFPp8HZe8Nnd/eQs6Z5KfV6JZDu0VYeu6YEiH1MbBXSp+4aFiMfLosWfAAVJldUxLH/RQJnFCso7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjJnN2KY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjJnN2KY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40F43C2BCB9;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780663299;
	bh=Xw4DKj40SdH5fG0f1lsN3gM94qCWap7opuJXIrQQIEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IjJnN2KY44F6m5b5xxLkO4tjCKJlPY4OVdNegd6Rc8z5NXFpK8krip8t8NkXLCEHO
	 /3Mob2jwPM04Cq0bpM+NnHjUn5Nre4AgqTrPk1ibLns7CVIvvHAnWWGHyyZ8/WTvuS
	 5INlJtcrPPSmflpvSL+64Mzqhx1HXiBBDrfOQgavTLd/ECyz4EaSW3PsIlBVvh9nis
	 8t2sYmtsiCwHdO0b+gpFc42mxLfTWCwPM1zoLhlV047thpAeipcKK0LZvMTwn9JfyP
	 LDKKZIlGdAWSW4jbIqJw0kXLgOhHPZDR7zvJ/jRK5+AF8qkaevX1rbEPW3QTkxrNqy
	 p+rLBiRwORjUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEDCD6E74;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 05 Jun 2026 16:41:28 +0400
Subject: [PATCH v3 3/4] arm64: qcom: ipq5018: Add GEPHY RX and TX clocks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-ipq5018-gephy-clocks-v3-3-f232d9ca0966@outlook.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780663297; l=888;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=Z1oXdm/oaqpMEY4mYVlyCRP8DswbVCqV7erO/GmnBEk=;
 b=38YiGYWPsZh8N1z8PW3HfZaQp2Da+JNm4VRzfseDHyRQfaK1qgNaZcRMf6ymW0Z8gar2OsDHu
 yy3vjnBowSbBRdf1P4qrvA4r7ZKKj6EM2HZoU0lV73TLvlBT2b9EWbg
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add RX and TX clocks for the IPQ5018 GEPHY to enable the datapath.

Fixes: f5f2b835e316 ("arm64: dts: qcom: ipq5018: Add GE PHY to internal mdio bus")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 6f8004a22a1f..60c27a6f2b10 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -229,6 +229,9 @@ ge_phy: ethernet-phy@7 {
 				compatible = "ethernet-phy-id004d.d0c0";
 				reg = <7>;
 
+				clocks = <&gcc GCC_GEPHY_RX_CLK>,
+					 <&gcc GCC_GEPHY_TX_CLK>;
+				clock-names = "rx", "tx";
 				resets = <&gcc GCC_GEPHY_MISC_ARES>;
 			};
 		};

-- 
2.53.0


