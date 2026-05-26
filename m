Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B83C37B4;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832340; cv=none; b=eweDJDZRPppX9ieWe0xt7qaU52/nWrfvCquwpU7XTrpWVfM2l8FvgeWW6IRW3/C4zi/eDMaVqFzinDoBWeRtWMGm8bGq4O2Ix+kGjgSdMOb59kpzwCr3Nql6cB83TGZdvhxjXHf7iLenCcQPyg7m2ndapy3U4eGIolieLNgVEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832340; c=relaxed/simple;
	bh=+q+36NxgtETrUBoFeSMXCRVVSS2rQ61Hb75r4jxKEW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJndL0I+H+mSujfUvvCZOKJ9CMH3J/wdySOsJFJZ+8ipSH2m5CcA21lvS96DlHR7ReffbGmO08aXMUvgs/scxGZ+a58nkHL9y4nq3uSVT+EhesUtztFH6E8KBmw1pyOItckKhtFDAngGJO0YxvsYm9F0/StiA18+g8SXGXgU/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW9ary2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW9ary2p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AC3CC2BCFB;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779832340;
	bh=+q+36NxgtETrUBoFeSMXCRVVSS2rQ61Hb75r4jxKEW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qW9ary2ppRzddgsH/neVurBcDbZ1eXXaFnUIzhQ5o2yxx9tbGCr/CELiP3b6qYKuK
	 jPK2PgX28fA8vFuzMJUZtkKZiBFu57V66lANrfJm2me+mVZ5E/VWF+BuzPwFaiB1OR
	 n9jOc0uE+wIuODf/IY/XAgHdJVKXv7vBN933GUn3TfW3/ytcNBOj9NP7Im5lZk5lns
	 WIXclLhyTmx2xyaVwzNB68fH9s9jBknfGegGfwM3xn0kAtzPYVAQP8dBVGuQSqidqU
	 dTvBDcKANG3LdV5tZ2wZhDDH735nBF+T2fkClXw6uhXfqkpc/VKwhphHdrbrJkmLHb
	 D262wHsxQnxtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CF4CD5BD2;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 27 May 2026 00:51:52 +0300
Subject: [PATCH net-next v2 07/10] net: phy: add generic helpers for direct
 C45 MMD access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-adin1140-driver-v2-7-37e5c8d4e0a0@analog.com>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
In-Reply-To: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779832338; l=2612;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=7mroT6JJ6YFYiL9jDdwaD4TEYFyc1gd5zGLfb5xFPLw=;
 b=WOSYYZ/LEUut3iSGgtDq/bazAuPqPWvCh5EO0TnO4VdZL/I4gLYNqSQAV0BeE8SjJcdAGJOX6
 gzT62vGD9AODbssnyXUzsiEF2L50sYnDUesiJA054sz+mRNvdYwPGNA
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com

From: Ciprian Regus <ciprian.regus@analog.com>

Some PHYs support direct C45 register access but not C22 indirect MMD
access (registers 0xD and 0xE). When discovered via C22, phylib routes
MMD access through the indirect path, which won't work on these
devices.

Add genphy_read_mmd_c45() and genphy_write_mmd_c45() as read_mmd/
write_mmd callbacks that bypass the C22 indirect path and use the bus
C45 accessors directly.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v2 changelog:
 - New patch
---
 drivers/net/phy/phy_device.c | 25 +++++++++++++++++++++++++
 include/linux/phy.h          |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..d33d096e700d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2764,6 +2764,31 @@ int genphy_read_abilities(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_read_abilities);
 
+/* Some PHYs support direct C45 register access but not C22 indirect
+ * MMD access (registers 13 and 14). When discovered via C22, phylib
+ * routes MMD access through the indirect path, which won't work on
+ * these devices. These helpers bypass indirect access and use the bus
+ * C45 accessors directly.
+ */
+int genphy_read_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_read(bus, addr, devnum, regnum);
+}
+EXPORT_SYMBOL(genphy_read_mmd_c45);
+
+int genphy_write_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum,
+			 u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
+}
+EXPORT_SYMBOL(genphy_write_mmd_c45);
+
 /* This is used for the phy device which doesn't support the MMD extended
  * register access, but it does have side effect when we are trying to access
  * the MMD register via indirect method.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..432d44188dbc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2297,6 +2297,9 @@ static inline int genphy_no_config_intr(struct phy_device *phydev)
 {
 	return 0;
 }
+int genphy_read_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum);
+int genphy_write_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum,
+			 u16 val);
 int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
 				u16 regnum);
 int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,

-- 
2.43.0


