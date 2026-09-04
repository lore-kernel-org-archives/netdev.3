Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B04E8E19;
	Fri,  4 Sep 2026 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542931; cv=none; b=BTHMrXBCk8fOfqrCNFCENYTUOdVTe+wnjw9TySevHby1gXu1k3WFWJNv92Xm/wB+lhmwnateWtKtPp+svyK7zl0jgukFyPEnGZ25gfYpr/9ZE3DcoNXBjw4kE5rzl8423xPbsh8sxOh1JWQhpQGkEqQ43SDaXgDCm/Jsv1JZC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542931; c=relaxed/simple;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9xGT5v2nZtKEfGy9xHtYRq5tOmp0ZN0Rs2q9qWTuLPkWB/iTACPDrTEYnKxs9ipsO9jISBbv6n4k0IDe/OvljEmbou3a8o1Klh1P8Fnv3BkxlvZM7N8+b6jiKd76WUJ594UC6uRdwqWbiMV2xYLJMrPZ4znsW6LMP6y8k45veI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=iwK6U2HW; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KQcMNHn5; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="iwK6U2HW";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KQcMNHn5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542916;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iwK6U2HWtMA0VLtcICqELFMvMG+JdtF5tGdU4jomkZwpMB2xVonDdL08p2XA8b4GG
	 At3QSt59tUmjY05hZ7odErggIbSvFPyCCw/kyfK7AlVNFTQjzau2wzT2TBJm085f+L
	 A3seFuztRZxBIjRE7xRn7DV0Cgpb/1HefUDnOdmstQ87qw5mhoairTg7MYPmUu2Zb6
	 hqiEnTi+U5gcadS24Xhn5/eMHcc0yCwearGinMWay23BsZWS7Cu+A44Ma3WU+L9GwE
	 +cT/kuVwwLfDAGsVFJWRf5MFOqb9PPCr5O1+gsiJnCJfLcyBHq7tA79MqadzbdYpDQ
	 0cbldfrjDdYxg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 132943F0E5; Fri,  4 Sep 2026 17:28:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542913;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KQcMNHn57slm8fqpWiRK4kbtz5/0sOPQiVPmBIRNs0G0JH+XF/gzFpTddquogXM1U
	 n/oUX0vLgTedYhoDJzZdHY8mP5pFbm3v2TWsKRZcizNbYtS05T7yX9+eZsu6fQUDhY
	 CN2gtiKuP3ceme34qroM2lrO+uEXTko6KKuGJ+4hfRAXFA+eyVDzQ6tr5+nDHx9vhx
	 NjXaK3dplggij7CjOrl0v8z+zjxThMSwyQnrKZNrzZzRqJvfe3S+qrsQ39dDWJnVAz
	 xNWvLg0JpUjWgkY6ARhCWd1Qyx/Ym8x38bg6rinpbMBWQ6aZZDKAUVdgdVdTmIW789
	 BxfT8fkDXdp2Q==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7A20C3F0D7;
	Fri,  4 Sep 2026 17:28:33 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:27 +0200
Subject: [PATCH net-next v10 02/15] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-2-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add support for PHYs which only supported auto-negotiated
speed modes. This prevents a kernel warning and stack-trace within the
phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
because they do not support forced modes.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy.c | 4 ++++
 include/linux/phy.h   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be3304b408c9f3ec9b5b95c76d3680a88..b83f938fe7c3bd619ae453434fd9582c0a055a57 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1190,6 +1190,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	      duplex != DUPLEX_FULL)))
 		return -EINVAL;
 
+	if (autoneg == AUTONEG_DISABLE &&
+	    (phydev->drv->flags & PHY_BROKEN_FORCED))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&phydev->lock);
 	phydev->autoneg = autoneg;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868e0ff558c163421cfea5a6f3bd73a53e..d5f8e527ce8dfefd40a8b34e7c2f9adbcd6c87c1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -64,6 +64,7 @@ extern const int phy_basic_ports_array[3];
 #define PHY_RST_AFTER_CLK_EN	0x00000002
 #define PHY_POLL_CABLE_TEST	0x00000004
 #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
+#define PHY_BROKEN_FORCED	0x00000010
 #define MDIO_DEVICE_IS_PHY	0x80000000
 
 /**

-- 
2.47.3

