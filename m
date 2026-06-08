Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE13546C1;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895366; cv=none; b=PFcrFBw1zmRJCE2pcykA0s5lgAfgQkvkJJWy8gjD2uls4jSiviu4EYCdVJGRgqeS1S1V5EQHdkrt91s29KOzcc3UIcXg0HhHRZGW6ASGF70F28xQYxRhSUEZiRc038Hq0sT9kSXJJmuX/GGuMyRXWVJWETg41S77Aec4wp9PRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895366; c=relaxed/simple;
	bh=Xw4DKj40SdH5fG0f1lsN3gM94qCWap7opuJXIrQQIEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYClmiZ9da4htifRBDUxbQgzjQEajxjPYpYy0OA6EHxDlcS//g1Y0PtJ/4D/mFt2u59fuo8gVkYDJ41ln5x/UvOPqNhWDbQz+jm8tvfX3s89vvgoEi1tCQOYdGnsFKzBtJ/jhqYrTdQdAOPtLJMcbmNkwc1e1Q5mIcoQq3+4Yi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N94r/c1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N94r/c1r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57D82C4AF1B;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780895366;
	bh=Xw4DKj40SdH5fG0f1lsN3gM94qCWap7opuJXIrQQIEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N94r/c1rUr851hxTu6EovYvp9xfvqxvULlBCMPKnwxfHzFPY1a6fPPHTUZ3RpxRIK
	 VAxDFcXfTwrnSR88GxNAwZsH/9CC4A3SLY1mYGpmf+tI3Q5uJQL2oe0hD+IGg3Fwuv
	 QznSXxRx90PzzHm6yqN33l0Ho9ZSvvMnKFVF+RKrhtzVS1DJBRgbl0nVuN/KRwXENj
	 IxqQyFpvVigeDL1gbGhzgWXdSEfZgGgWB3fUbaGI2jfDrg3D96gX9zFFGtCphBnjob
	 5PEX1ybsNeG7DWKZyJiizhqBQzkMtbA4JHzfbL5cr62pzX6kbWUeN61STHYlLv8Egz
	 4wimtQZPBFdWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB2CD8C9D;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 08 Jun 2026 09:09:18 +0400
Subject: [PATCH v4 3/4] arm64: qcom: ipq5018: Add GEPHY RX and TX clocks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ipq5018-gephy-clocks-v4-3-fb2ccd56894b@outlook.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780895363; l=888;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=Z1oXdm/oaqpMEY4mYVlyCRP8DswbVCqV7erO/GmnBEk=;
 b=cidoJHgdf8W6s5uWKnmnxBwtu76YjO25rxB9oFIenoX8PaniBPJc0NnYv0arFY4/ALXc7W1sW
 n66AmB2Nm5XDZKGcJrdHOMFK5dQ2eUNIv43E5vdqQmvWY3YsVP6iCkZ
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


