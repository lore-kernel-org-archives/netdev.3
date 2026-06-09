Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9620436376;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018889; cv=none; b=ScD8TUZMuFIvG3yLCu15KjV0qwowLPkdqSgHjhs48sKcbrvyoIeTU5ytFnapEeYfRCr+iBLwjVgSsI6k3BwuDuXdx9S7DcF15uva5m4awrd+GD1ZqLQXF4cLJC/nIkKXYllWx65DiDLixQN13HJaHbtCay9AtdDluE+VivZSsds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018889; c=relaxed/simple;
	bh=m/FIu6qt0hNJQb3nl4ytdh/+INTcw8K4AA5BWJZ+FvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFXXHUfC7+LGSXOoMWs7ZZk3xLvcNHWIRy0PDH22k8XF18SnSmXmjp4uzLCH4Vk3M9lyMQavJNl7A8Tbth5v1FeDIR+QX6mkCKPwd1mtY4ELdz6ASTbb6DDGKIXKUQzPuVrJYys2ucb5qhFCiyXrh9EesDXNwWpsaWzs7RySDTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7yvrJAg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7yvrJAg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B79D1C4AF13;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018889;
	bh=m/FIu6qt0hNJQb3nl4ytdh/+INTcw8K4AA5BWJZ+FvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U7yvrJAgPJOL859E0mXAjDRtcioUcCS+sYcLt37VyMno1EO1yMvi5Wq+sUOKJ/1HJ
	 ZuUeqT4CdDwbn28iOeJhCVYEFx7g5ti8xCNADXGJM3+dNdrc0to53OMiIfS0sP9j8q
	 G1+4myhyLzhCbjO5nCQON5+JLf0M4jSqhgjohrOOc+NNuakqqkrMeeCrbA7P99S6CU
	 LepjIWTlTm/0efmoOXiJSIU/XOnKCemb9j0psgnnFq5w2Se0jajlEsecGFAzhdY7ZY
	 CgYPC3deK4WX8LE7dasL9Pruix32G/Rpfxs46sOCCfg0ASHIHUiYA12iawA/VF7lQu
	 SwkR1n3iyqWqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E2CD8CB9;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 18:28:07 +0300
Subject: [PATCH net-next v4 08/13] net: ethernet: oa_tc6: Use the
 read_mms/write_mms functions for C45
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-adin1140-driver-v4-8-0753e28ee004@analog.com>
References: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
In-Reply-To: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=1871;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=n+v3Et1n5CH3CnGMVrMQzwNu5dBpoIheUP+9vqKRaUQ=;
 b=6xNwc8F7pOFiMv5ghbJbhcK74F3aEWZOCYdhu7TXL8Vo+oCBwXiMPB60C1P+9jI0AWIGd0vfO
 Vo9sR89WIjXAmJnSMSbkJGYL51h2iboBIXuxs5Ug2bNS7w3dH6XXWYC
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com

From: Ciprian Regus <ciprian.regus@analog.com>

Accessing PHY MMD devices requires control transactions to registers in
a memory map other than 0. Replace the current formatting of the
register addresses with the oa_tc6_{read,write}_register_mms()
functions. While we're here, introduce the mms variable to store the
memory map returned by oa_tc6_get_phy_c45_mms() instead of ret, in order
to improve the code readability.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v4 changelog:
 - no change
v3 changelog:
 - New patch
---
 drivers/net/ethernet/oa_tc6.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index d32a1a323d48..4fe4e41136c1 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -500,13 +500,14 @@ int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 {
 	struct oa_tc6 *tc6 = bus->priv;
 	u32 regval;
+	int mms;
 	int ret;
 
-	ret = oa_tc6_get_phy_c45_mms(devnum);
-	if (ret < 0)
-		return ret;
+	mms = oa_tc6_get_phy_c45_mms(devnum);
+	if (mms < 0)
+		return mms;
 
-	ret = oa_tc6_read_register(tc6, (ret << 16) | regnum, &regval);
+	ret = oa_tc6_read_register_mms(tc6, mms, regnum, &regval);
 	if (ret)
 		return ret;
 
@@ -518,13 +519,13 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 			     int regnum, u16 val)
 {
 	struct oa_tc6 *tc6 = bus->priv;
-	int ret;
+	int mms;
 
-	ret = oa_tc6_get_phy_c45_mms(devnum);
-	if (ret < 0)
-		return ret;
+	mms = oa_tc6_get_phy_c45_mms(devnum);
+	if (mms < 0)
+		return mms;
 
-	return oa_tc6_write_register(tc6, (ret << 16) | regnum, val);
+	return oa_tc6_write_register_mms(tc6, mms, regnum, val);
 }
 EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 

-- 
2.43.0


