Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D947F2F2;
	Tue,  7 Jul 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463681; cv=none; b=muaPQFnMkZnNT3jtQhflh/ux3UtAw9D1zPh30ngY1xRJ7UAPz6mOhhzU/IIme/IkFJJjE6+XWfjtAYzLkBZdXC66s/TgXjJ26KMHtq11sCHsEfsLJs/PJOevqBr6rMMIH5vwAWlyrOj45TxgEUT74mjMO1eQJiej5v/JSmHHDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463681; c=relaxed/simple;
	bh=kd76Iszgwz+ouj9TEuU0D6wpHDqOlc8+fnPUqiVVTYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8gFnBQsIvGf1VYonnIY6L2+O+AxRqVkn9LS0znPnDohVmHMkWGg5Cicdcbwln6dGlOCsrKoVQ4I8JxoaduT3glXsQ+0AqOlrSie12tPRngZccc3nGkiQj0E4+BJ0A4DM/EbVns3DgAehK+O3Am7Cw2b7JgYDIkwkx8DqHDdB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3JPZsUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3JPZsUr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44E68C2BCB8;
	Tue,  7 Jul 2026 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783463681;
	bh=kd76Iszgwz+ouj9TEuU0D6wpHDqOlc8+fnPUqiVVTYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T3JPZsUrhVXNFqCp7ynHIxWEMFAFypOOkf7Q4emoUG93/NRrmxG8XaGHsm/qGDVLj
	 HUIOcmiMMjMb3IFWOqU6IhtaMtYi2LKNZJYC2YZYwO7eX80PAiitEeX9QEArMVPopB
	 n7n2c5+3Hh5s7yOYbYzrcx+Ne9FnafzGQV8sI7UtFkp9mazzGUdXgEdzqk5PLlbiFT
	 DSOv1HnsZE45wkSP621h2qAtHsTEWw4dgPH8iS0DRdNNO96hs5MScBQSYOOwNCbKrn
	 cgJ8sixTg8IwfKuKZ+L+RMknKyd1SucaVxoOq7RJ74bVzEV/ClaIn6frTkXLyB/LPj
	 IHnEPkm/cqB3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E38C43602;
	Tue,  7 Jul 2026 22:34:41 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 08 Jul 2026 01:33:38 +0300
Subject: [PATCH net-next v5 10/13] net: phy: add generic helpers for direct
 C45 MMD access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-adin1140-driver-v5-10-4aca7b51a58b@analog.com>
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
In-Reply-To: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783463678; l=2740;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=EHzSGgaRZqyD058Nt1gOhvpafqZGPgMplM/rsPkXGh4=;
 b=w180mchxhudHbUfkSe7XmEaKPIbC3HPrS3a0/UiIURqMRisbzOxsUNkOpjBfumyEdXpnHVVUG
 0nrPRot5hR0CFMGFvzAZ9K4VNjnaUqGa+tflkKe7Cw9UY45PhbmUh5l
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v5 changelog:
 - no change
v4 changelog:
 - no change
v3 changelog:
 - no change
v2 changelog:
 - New patch
---
 drivers/net/phy/phy_device.c | 25 +++++++++++++++++++++++++
 include/linux/phy.h          |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef..94b2e85e00a3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2770,6 +2770,31 @@ int genphy_read_abilities(struct phy_device *phydev)
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


