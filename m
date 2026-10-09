Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06C3CF1FF;
	Fri,  9 Oct 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565946; cv=none; b=S3sFdLzoL8tSDMu0I64E4bCPX9Zr/M7iG+ukhNYQwPAYLPOrZMGl/B3S2VeQEL+RxWWC5AufsS918h4EH+nsaI+AMFXp2a8f3z8ft/9Zj3Itbz/ZM1+xFj46DTiR6ln6CBGF0d7oP7MqWXuRHMPLGgiwtUA2t16LWfTa8T06H5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565946; c=relaxed/simple;
	bh=eMOXyywGw0BS3e1g1XHIor4ugXG/dIpoHIggPtG+LXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P2+aP6Em4TDSXlkL+Mrn5cJyQEmEbH/aBLQOnSINP8FcECBgok+CzoNoM2XDW+NY1ExBZotSZPbR1CDU/mSSHjnYufsUEb2g6cQiYa6B8T3b7I+/FsAiloJLOn3qUd83SgVLLfzZ6EZ0Rto3UF25q02Ul1J9P2USXqJLbY7A/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWxF+AoT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWxF+AoT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 624B4C4DDEF;
	Fri,  9 Oct 2026 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791565946;
	bh=eMOXyywGw0BS3e1g1XHIor4ugXG/dIpoHIggPtG+LXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tWxF+AoTc/h4oOh7xt2oxDVlJRHfiyeghEw6yhr6+IVudVIkP3V5sUWDJF+1P5MOS
	 hIUdoJ1IM4KcnbG774aInkUgC1AZ43vrmOEm3vUi8Eb8UU17PLfL71rHGZbd/2UY/F
	 oEPLWa/VJYJ4wI59kZqWinXZbfqCPvoHCAMPwHI1T7oUfXwX6rGpogFut1bIx/shW2
	 0pojTW3TsYsmJpGxjKLdo3kN3mRuLJFhDxJWnV9en+NsR8Qcd9s6a1i/7LJyYpCefd
	 YBar05YPJpl02rlxBnL0z/D207mqwcykmFbDKIt+sOrXkT71Hh5W4pgv7zO6ntPI/6
	 ENjEOa4vQaErQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E80ECA9EC0;
	Fri,  9 Oct 2026 17:12:26 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 09 Oct 2026 10:12:27 -0700
Subject: [PATCH net-next v9 07/11] net: phy: ncn26000: Enable enhanced
 noise immunity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s2500-mac-phy-support-v9-7-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791565943; l=2243;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=ahQH6+1fC+9lGLEMRpXBFJTueW38fcc+kXYLR88B2Eg=;
 b=fU/15zXL7P0BXKLeEl2vZ/2mOK+BycvGASIWXlT3CUDMeXwtJ+nnabFTpkzcu1vyQdT/L5BPq
 RuIotevC4nnAUgM2M8PCWoyerenYkc+fRqLYvsXAHDbj/CGiP/OElZv
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

By setting ENI bit, noise immunity is improved and it is
specifically meant for PLCA enabled nodes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v9
  - Added Reviewed tag
changes in v8
  - No change
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No changes
changes in v4
  - No changes
changes in v3
  - Moved as a separate patch
---
 drivers/net/phy/ncn26000.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index cabdd83c614f..6d433f4e2c45 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -35,6 +35,10 @@
 
 #define TO_TMR_DEFAULT			32
 
+#define NCN26000_REG_PHYCFG1		0x8001
+#define NCN26000_PHYCFG1_ENI		BIT(7)
+#define NCN26000_PHYCFG1_ENI_MASK	BIT(7)
+
 static int ncn26000_config_init(struct phy_device *phydev)
 {
 	/* HW bug workaround: the default value of the PLCA TO_TIMER should be
@@ -100,6 +104,24 @@ static int ncn26000_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+/* Intercept PLCA enable/disable request to
+ * set the proprietary, ENI mode accordingly
+ */
+static int ncn26000_c45_plca_set_cfg(struct phy_device *phydev,
+				     const struct phy_plca_cfg *plca_cfg)
+{
+	int ret = genphy_c45_plca_set_cfg(phydev, plca_cfg);
+	u16 eni_cfg = 0;
+
+	if (ret || plca_cfg->enabled < 0)
+		return ret;
+
+	eni_cfg = (plca_cfg->enabled) ? NCN26000_PHYCFG1_ENI : 0;
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+			      NCN26000_REG_PHYCFG1,
+			      NCN26000_PHYCFG1_ENI_MASK, eni_cfg);
+}
+
 static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 {
 	int ret;
@@ -151,7 +173,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.read_status		= ncn26000_read_status,
 		.handle_interrupt       = ncn26000_handle_interrupt,
 		.get_plca_cfg		= genphy_c45_plca_get_cfg,
-		.set_plca_cfg		= genphy_c45_plca_set_cfg,
+		.set_plca_cfg		= ncn26000_c45_plca_set_cfg,
 		.get_plca_status	= genphy_c45_plca_get_status,
 		.soft_reset             = genphy_soft_reset,
 	},

-- 
2.43.0


