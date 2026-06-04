Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145E3B637C;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590780; cv=none; b=s4nPDqGmwq+Qr2zC+uDnx7RaLZK9XFlszCZ6yjXflnXhfPEQNe1j1QgiMhgi66X3vdx+kSp3AgIDV71k9RVl5GNlIWVKHNm0vAmt0nPltO84Y1EsfxXj8F/aSQHEeKKwF9p+7iYafe6DD/IFPxoNMWOXAP8xgF0Zp5OGHJStPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590780; c=relaxed/simple;
	bh=7e0V/xq7Qkbu9Dbbj2MlePvt6HUgkRd3jbrGzKEUKgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVik+w14+pA6UAGy+MbnuWSZ5PtbOIHXYdaEELtECJ1jg1X9LtCcdZSju+9nPerVsDAWBkVUBIdZc5G77UIwLDiVgRxuQe2YvWTbk4ase97DtkEIHOYVnq4ZSuboSg2fJTpTrTeLid9yUvysMgmqBUF4dNlQ0otkGgDINy0BAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su/F/RqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su/F/RqH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2E81C2BCFA;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780590779;
	bh=7e0V/xq7Qkbu9Dbbj2MlePvt6HUgkRd3jbrGzKEUKgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Su/F/RqHvuoW2RrahDIpopswRuiO8GI5iUAvA+MjWsQX6SbSEjwbaNSAYob239/JT
	 XADkQjDmDLSV/yeIJXm2+N4B2KGk7UNZ+cPRbd7B79Y1J2NmXXzAE4b/BbH1DSqeEX
	 WrHmikZC2s4PDRPtEwZoe+fsInQJ3wTyoCOLjH9aCZmFIUNRTpr1FMHtU6/SI3X/3A
	 rghN3w5NJL1bQ66K/UPliwvzDRqWWK63eH3xxaKXgzGdUx3QNljqEWqw5d3aCtP/RK
	 ig+eev3qRa6R5/KZ+smb3G8H0f4OzIa1JaJpjRuB3ei2C7U0HlucWc+TY5e867LFsI
	 p8YAnF7k0taBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7747CD6E75;
	Thu,  4 Jun 2026 16:32:59 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 19:32:49 +0300
Subject: [PATCH net-next v3 04/13] net: ethernet: oa_tc6: Export the C45
 access functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-adin1140-driver-v3-4-5debdb3173c4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780590775; l=2308;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=z7cSpX5t5HgjHdWjBI4GiWiysbSWbBu/ywbEFt955do=;
 b=N+F+ekPwZJy9QUJTAP1uYY26DS+HbG307fN9yNEgWxFo1noQ9rfAv9zd7mDhqvQCAW31UfhWk
 Pg20+29VhecAKdzHFApUtmzTleWmeIOe7+VGKnCyDgtFaVv4JR3taKD
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com

From: Ciprian Regus <ciprian.regus@analog.com>

The C45 access functions can still be used by some Ethernet drivers
which set the OA_TC6_BROKEN_PHY flag. Export them.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v3 changelog:
 - no change
v2 changelog:
 - New patch
---
 drivers/net/ethernet/oa_tc6.c | 10 ++++++----
 include/linux/oa_tc6.h        |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 2a72f0c4b009..b37e398e30e3 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -499,8 +499,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
 	}
 }
 
-static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
-				   int regnum)
+int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
+			    int regnum)
 {
 	struct oa_tc6 *tc6 = bus->priv;
 	u32 regval;
@@ -516,9 +516,10 @@ static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 
 	return regval;
 }
+EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_read_c45);
 
-static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
-				    int regnum, u16 val)
+int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
+			     int regnum, u16 val)
 {
 	struct oa_tc6 *tc6 = bus->priv;
 	int ret;
@@ -529,6 +530,7 @@ static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 
 	return oa_tc6_write_register(tc6, (ret << 16) | regnum, val);
 }
+EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 
 static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 {
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 62e3d89f80ed..2660eefa3504 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -31,3 +31,7 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
 int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
+int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
+			    int regnum);
+int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
+			     int regnum, u16 val);

-- 
2.43.0


