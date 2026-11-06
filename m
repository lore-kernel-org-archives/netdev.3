Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949696;
	b=UM5/Po1PzbkT3Zh3nn8bEfXN4qx7sAlSWYD1NVrmummcHcjngYcYZ7e3225pnZ31TbYX
	 W049elRU3hEQhUv7V7jr/XQjWinuwavlNxKAfwn059hPrL+WKfMhnYVvLXAzy1cj9To/D
	 SJGkxyYeQasrBpMAvrJRHQ35qO6DAqsuGeaY0m7mP1ssjv9mLn9SFMQc8onMDzigVM4h+
	 K9zr/PgVQyszyUQzFhgBeb8fN9CVcZACxvHA4urG0gxpUGz7qOGN+iwLBiKbVns9y6cli
	 UqxEVHNT96xC6yXOg8XM7xIclM4XRf9M2m/yRSJh+SGPuolDk9ALzDfVOqLpQ788oLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949696;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=GygRlI01+cPXv/DoLTlbQ1cIRi1q+Mc9UFQJg7H+g0U=;
	b=R69gjg4fYq7uJIEoDDw+RF41xJDStMt5RqAaS5sbxHwvVnDiC4ab5vo339oJBbH37j6q
	 YF595JOv/7DHUP1ggjKk2oPHKqGIJ7GCVpPIr8SxL07+fczZ2TzDTzgcm5UHicsmwVOMU
	 IdAsKU7U8P6qC3iT8z9Ys/pUGm8CBl96NlWG54VDiO5EctaZoMwitFSLYBEupEvLZ/iTa
	 BDjcp77ve+mTVPJ+ZVBRn6t36WVC6gir40GG7IiU1E1VW4QJvU/k5vFuSDOrUNlM89hRF
	 0gpeL73WtEpQqhOP61wJiAJ+hhB6DTSZgLJ+lbjhCgzcnXt6r2kEOwIBuPqHi13Oz1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=YSWa8uin;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=x9TTDlWT;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B69606A33E;
	Fri,  6 Nov 2026 07:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85B69606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=YSWa8uin;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=x9TTDlWT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949688;
	bh=P6OG2gM1klz3dLoSZQfBExeLecMGKof44yOnBaFhd8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YSWa8uinALBgNbykYS/uDzIDqplRmNDcgTie7gXi/0RRQP/MRkyhf6IkHgST7LDzq
	 etWAVlGG6/E8eFWaZlf5sb53NTlP8wI//jUxvvAX+vSR/uvC2956JIOgvEuhYvhpQA
	 ObrKu58pGsQ/G00ZZSwZ4DtM7n9Bw2o4MdVOdPUa6xTsUAest0caOPbxKHRsmy+as/
	 jHtlgNupQICeRHNdRugxdjTq9PAHz55Mv0vZqSBDPzblt6CN5T5KpKhCzgZrG66Oaj
	 byWnbjW/x9vqXmaeUSYK5hbYv3KljqNEwIfAOlm/nPCcF8JfyqOPvmF3pF5gTfamB3
	 jPhX5QKL87kSQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5FF0448BC5; Fri,  6 Nov 2026 07:21:28 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949684;
	bh=P6OG2gM1klz3dLoSZQfBExeLecMGKof44yOnBaFhd8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=x9TTDlWT5ViSU+7tefhDnyXVuDHRhKktXGcX1K5vryHY7PUC/8JnJuoNp1jYG1qeQ
	 D/gHr4TRejsFy5P1dgGtzu7Ymix96rzC9Qr3SXVCwWdcD4WDhPWXKtvE2gMlqefkja
	 Bk7M1cQcFWlPiser/B/MY4CMZVCqn07ZMqQTY3FumOln59Im9oTCqvxzQ7edRTMdVZ
	 /dv+a9ad5kcr8Wr2l/1Vp6/PH4syrUGXOCeYeDSg27QiP4qfxtyyfpkarYySjfBZ0Q
	 0rlYaMJjzH8xchh37BlvmWsuS8UOyIHruSh+OedJXxlMThUBXiTNCANW11ZgbeLfm4
	 5UBvYdKy6PByg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0E5B048B8B;
	Fri,  6 Nov 2026 07:21:24 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:17 +0100
Subject: [PATCH net-next v20 02/13] phylib: Add support for PHYs with
 broken forced mode
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ax88179a-v20-2-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
In-Reply-To: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Emir Beganovic <beganovic.emir@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2

Add support for PHYs which only supported auto-negotiated
speed modes. This prevents a kernel warning and stack-trace within the
phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
because they do not support forced modes.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy.c | 7 +++++++
 include/linux/phy.h   | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be3304b408c9f3ec9b5b95c76d3680a88..079c53516f424ca5f8d50292f1912af04b45b07a 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -354,6 +354,9 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 			switch (devad) {
 			case MII_BMCR:
 				if ((val & (BMCR_RESET | BMCR_ANENABLE)) == 0) {
+					if (phydev->drv &&
+					    (phydev->drv->flags & PHY_BROKEN_FORCED))
+						return -EOPNOTSUPP;
 					if (phydev->autoneg == AUTONEG_ENABLE)
 						change_autoneg = true;
 					phydev->autoneg = AUTONEG_DISABLE;
@@ -1190,6 +1193,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	      duplex != DUPLEX_FULL)))
 		return -EINVAL;
 
+	if (autoneg == AUTONEG_DISABLE && phydev->drv &&
+	    (phydev->drv->flags & PHY_BROKEN_FORCED))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&phydev->lock);
 	phydev->autoneg = autoneg;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21afc2082b1741ff276a9588246c2f98351464f5..f1b1ad1dd82f5c51ddd2f0759666e17802894c96 100644
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

