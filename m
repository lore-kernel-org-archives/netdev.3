Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803F48125F;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590780; cv=none; b=bHOydkmjtPte1maJAx9IHrWJdOH8kZzScdgMYQz+uM3ElLBfQ9RFIrI/XVhY3gaNvWbTTGl0y3KdDALw7db5DBYeif/lkynEc8D9C/h5HuvgdgcEx8TiFthcA+oT0tLKfvzyCygOwlGv+eGV3jGgx6uTV5ZBzW32fOlmjWmmlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590780; c=relaxed/simple;
	bh=HXCt8R5dcOW7hjKLe33qYN+eVrTlP3zkoE3laTSjjuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBl+Dhodq09cla/v9H48zV79rw09Mwng1VGk80PxCzaJZJ7e826qaR0ZiTkNqv80C6PSJ4APu2UzhFrqLNWTT+YXAHAMFhjwTvEPkXCjPCzdVOOAgopwf8ySUVKhtIvoCI0G/PSsBjVKPDqBlE/qWSyORybd5dvzsyojVruMTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChGe8d4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChGe8d4f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FE2CC2BCF7;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780590780;
	bh=HXCt8R5dcOW7hjKLe33qYN+eVrTlP3zkoE3laTSjjuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ChGe8d4fF6FrD1oGtE86w6G6gnrzTIKABhocRxVjhT/Xjo9KkjKHSuXheuUdhMmPo
	 wWSSgArG0lILMa1Vwckhs1qXu9RZpOfGoPuMnUaLw+xueDxYhUacFVjYs9wkI/XYWz
	 MRzwGyigC3FVXe0skHcqEvoumSEhN03SqC2sbDb92MOcfbyT/nZxR0+T8oV32PMYZK
	 94v8E7eREa+uzmBpECyH7GM3jaVKhLzW4wkEf7/6V5gaVzJ1mynJ3iRzB+7YGuKaAu
	 uT3IaBOy0dMKoFwrIhTMQeeQht/SedBXlClI4ve/TIiWATYJbDVG4BQEZydGdZALLD
	 hGF2Zwz+nmFHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05003CD6E7B;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 19:32:53 +0300
Subject: [PATCH net-next v3 08/13] net: ethernet: oa_tc6: Use the
 read_mms/write_mms functions for C45
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-adin1140-driver-v3-8-5debdb3173c4@analog.com>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
In-Reply-To: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780590775; l=1799;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=No7tofzB9UMLLlyfh1zygeZv8UoG526Pzr9YB3ygxVg=;
 b=+fIixh8ZhMl1Lv14YnbJKghAPM029c0RB8C8Mi04rvRxQf3WieUkK83N3GXWdts2wP7ttZ137
 KOuV0kmn92wCwquyqoyNtwfnc2k9xCqGnKhdj47UmrW4QZX9OCMMKFs
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

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v3 changelog:
 - New patch
---
 drivers/net/ethernet/oa_tc6.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 3807265bf0b5..691d293b8ee2 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -503,13 +503,14 @@ int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
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
 
@@ -521,13 +522,13 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
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


