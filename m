Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7C395D87;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018889; cv=none; b=F6o9tKAiYIVhvpsnIedVwS8CLp9XWF0UJidZPQVdUUM76nG+SEnVcIRvHwGdpSQO4qxk7p3/ZFQA7e2FgZrNCGQVptt6YIQtPfyfbVNolkkQv2LCP+9MxVpV4KSF5Urek6yEEY+/Cp+3U9qghO1O+pME5ZY17OpIZqrtUE/3z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018889; c=relaxed/simple;
	bh=O5JU5bEqNobi8gn4QmmceJYrHR1KOrd196IKTzdqm9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+PJUCr7Yb/fOJeaPPRCYHj/ZlCN37pq8H3MHLTv70kRCVt87netzbl94D3bkAbA80KXl8A+OYUkWC1ymSPeye3xZsDwlXbnOdIvXvIEqpH5HmCPJksBPpbh1c8m4ZyiqudXq/aRq063w9t8AFiRwkfihY8FIaeZzMGmQ5u3e0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm+DCNbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm+DCNbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5524EC4AF1B;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018889;
	bh=O5JU5bEqNobi8gn4QmmceJYrHR1KOrd196IKTzdqm9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Nm+DCNbJ/o+NjnegAoP7vUh/bTLL6ipnY6/2Xir4l7XEH9QbbNSJJwSQyxULzW/DT
	 0NvGxVabmiyIBNOy0qO+yYTH1atRpDNPTeLzw/SlXQ+OCHrq5qZ/2ntxNVrHheJMCj
	 +KSSEEvPexWCg2r5UgVrUMAAN3oBc/5rGnkjf47WNcDMhj7R4kc7SGRiSKjF77XfSe
	 TblpwaWth0pYQmzDRIRsqFh45S+ESPLLwDPjpUXSVsZsRflIje/Mwd79kUhUePklsp
	 xa/bcvY8RyffyJoVBDxazooe9zChewXXZTkZiVN7j1DncwD9VT8zZ8XJ0HZEXDxI0J
	 iHXNTS79ca2QA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C14ACD8CA4;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 18:28:03 +0300
Subject: [PATCH net-next v4 04/13] net: ethernet: oa_tc6: Export the C45
 access functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-adin1140-driver-v4-4-0753e28ee004@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=2337;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=PXhiTLN/eJwzSVDtbuD8NyXEgUV3FNkSSabnshSdzNo=;
 b=A7PKiH/bxz6XS2HkdmifsqnrdQ66IhRJOHb8lUtrlDBMGMV5pbcEkHxqT992Fd7P5aqQ//mWJ
 kYB2vm9d9L1Cqi0Jhb+ThrLT6A5g+wtx9ZXfHeJihcnK2WVhfrpChcl
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
v4 changelog:
 - no change
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


