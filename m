Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589174;
	b=iCE73ktWh5gUB0kfZes8bgnv0n9/q5P0Gr/6ZkFiN+WFcUskUUgXCn5QsQFgh1x26k28
	 g/+S7ONB+WSQsDDdJgdcV96tCPCeDXVUTSb/FeIBROwSrdobrrhwz+f2bB4kRIYRXckl2
	 o1oUH/q2bCBLdrOB2TsF74jWjF4RKXMZlUWBTsI0Yx0PVIKtpKEMwhR2FpbhwUanV24Ed
	 7EFW6YO7Sx+ojGGwUdbelMJWkRDPqKA0l9dGZwqoy8AoaqZSU2NeJRCgK8FnM/wS8bWcP
	 kwIovi8W5Jjt/qSxkYVyMs9sm/LRj0LbtGev30T4XTuXDoop8fJGOqN8hgApQsq96cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589174;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZTucedN6m0KwEN9d0lHvkfVd1kXevg7Xyv01phdbIxY=;
	b=pUT5eMe20Cd9dscMfV2VQLsctGYvwSH1QWNBQ2BvgmBf6CoYtPAlK4n8iKrAYpy6lywo
	 t+vAW+1uHj4Ri3gMI8Wqgku/ll9+afm0WVFptYaEHpsgaZNNdM9pjwCVv7c72NA99+n7+
	 XRgAsLLxYQ/oDadmHzLXuloveIi2HCsUDU6Y8IxKgzI8VWuJ8DPXHj1cIg13TfdQ6iFsB
	 xnQKuatYTAqZsQ2ubJcUa0C+ku5X3YRFFyjMjpXdNgndbqGzHmtO9GSL5hW3Q3WJm/yBO
	 a+o9csXzbnipk3e3UNmBzgos36pbTp6tismaadJiA4S5BWTyw5qHd7tSKqINw+SUVsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwS7duiV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052260A381A;
	Fri, 13 Nov 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwS7duiV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589174;
	b=mwtBSWUijqbUNieXINqGreDmkorXJoMy0EGCVwK6SL4A3wZQWTZ4yZ6K8V2JxFMG9qft
	 FhBdykKQcTMty9QeqN0hrvasU5NnwWtwfOYqW3DlD3MLjRdENVLATkEkKhF+jZCoip3ZE
	 magAapiWcVHWxIB8ceXN0NFj/e9xQEUuJ2IKwvlalH6tUKa5OTbPYmYjN8DixHGANPUP7
	 pADvBLrs8Ou349UmEQXECIPL42zvGbI/lNqVyhoegzyGAdstKxFU/4uJe61Nz9Fj0BgoG
	 WQGHgI/t8cI9fE3eUpV6ZmxZnjqACia6RCKT7O+2kTulBNOKnP+fBFXzKJ/Xp2Uq+Cw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589174;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZTucedN6m0KwEN9d0lHvkfVd1kXevg7Xyv01phdbIxY=;
	b=Wfsn705Ay1zZ2AriZk430tpsKicgjsGjMfhKlJLxiul6ZoCqvNm9OqGeh06VEnSDBoP8
	 vBsVlCquSpaUQTIfeSVA3RSATEzhbi3Sw7ne3UNpqjVXdSFOhcl8hFsRS1T6Tz7OtGeO1
	 ED4T7xsQfRRpcz+EGqUT6V/g3zUB49Z3ohLQb2eDsNGFuRMTtdCFAsxd4Qhh+QfamKbtx
	 FXT5iacngkX+3wqXdtD0wSf6N5T6NawV908PttM/ZFQtyptX+kjV2XMVTkJoaP3wZ5wqd
	 kwvtdCYkYazQpKFMbbDCuWu08p5Dqq/CCgcigD22Cbc0p2DSXoSYpHWb0FEalRUsdJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C265C1F000D3;
	Fri, 13 Nov 2026 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589174;
	bh=ZTucedN6m0KwEN9d0lHvkfVd1kXevg7Xyv01phdbIxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nwS7duiVYWSLR6oSWS1gSJFhnEiN03CFPLIJsOlTy0EtCI1DC2F7739uchZojKUOT
	 /CNS3AC64B9urW1HfophJhpmYcW++HL3izYR4eakMN2lcX3ygl2tC6mTWGz70eDxMc
	 HkIyy8cy6IOflKniumczh/YOBe4VTWSWMYfAC7TeUx1ZNOEJF/h3u4WIZvPvvgj5OM
	 57Yaf9x0nYnPX884f49RdiiTDdKFnm+EwnApeIdC5fcHBybhQnkNtMYRoEP3njvkj4
	 PTwqPR9VZi7IvuSxL9SU10mnZO/spY+OchNCm7yi5VrV6C4tyHAkL2MPMOMgUPhPPe
	 YOX75ThCEoB/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B2EB249A2F;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:28 -0800
Subject: [PATCH net-next v11 09/14] net: phy: ncn26000: Enable enhanced
 noise immunity
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-s2500-mac-phy-support-v11-9-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=2405;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=iAG7lV9gijg3z6XNjiMZoINHKklWCTR9M+HVJm+0cQY=;
 b=zflYKp3NW29ITGTeZqKbIdOuwjnCjgA7yNjVcQAf8y41uSt1lI61G/69krDWbv5pcYIsa5sl1
 fAvRKJIGBj6Di/HQLTnqOpemvxaNwWts24JW1kL9UZFM+r4ZizuH2yZ
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Intercept PLCA enable/disable requests in set_plca_cfg() and set or
clear the proprietary ENI bit accordingly. By setting the ENI bit,
noise immunity is improved and it is specifically meant for PLCA
enabled nodes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Updated commit message to be more accurate
changes in v10
  - No change
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
 drivers/net/phy/ncn26000.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index cabdd83c614f..888d74b83125 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -35,6 +35,9 @@
 
 #define TO_TMR_DEFAULT			32
 
+#define NCN26000_REG_PHYCFG1		0x8001
+#define NCN26000_PHYCFG1_ENI		BIT(7)
+
 static int ncn26000_config_init(struct phy_device *phydev)
 {
 	/* HW bug workaround: the default value of the PLCA TO_TIMER should be
@@ -100,6 +103,24 @@ static int ncn26000_read_status(struct phy_device *phydev)
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
+			      NCN26000_PHYCFG1_ENI, eni_cfg);
+}
+
 static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 {
 	int ret;
@@ -151,7 +172,7 @@ static struct phy_driver ncn26000_driver[] = {
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


