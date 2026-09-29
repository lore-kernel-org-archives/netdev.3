Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B24349B0;
	Tue, 29 Sep 2026 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651960; cv=none; b=g9U5W1jas5Y1gDC7elh94NjK7AxCetJ7NLjjOtoGhfSKHZuQkovDszkjZXKJCuuhsI3AYujVYK9YoXc9/ZsJ/U5JAPQDDMmnkTiC4809mlEbi0Q3ajNk7mJ+t/K+sx/n1FXEJvntHfZTg0ULkY7cZhIXemve07HcKbTI1Z/Op4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651960; c=relaxed/simple;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdAL08jGK3LX2ypAC6vtlvN0o6wUFfVrW/F3d5JDFBlnOIyE8d7tA+o/LY55eg895codEr3f8xvaH6ai9TN6TwdaeJmAaHITd5Sed98vOemY4dfsn2P4gcndAgXrEwVxlD5OZitVpvsTuZAEmObU9SxrR8MNVXt/X6culrd+xIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=A6u2RN3R; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cVaUuEvi; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="A6u2RN3R";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cVaUuEvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651943;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A6u2RN3RuVhRjmp4vmTis7OiYInkz6fdqhdGMerOARAc2vlhJSDMVUTroWaUxjJAo
	 njON0MPE4QvGsdTlZr9q8iGoT+RNejMJLp7iIsz01iLlj2g+8lBiz3hnnHpFKRYDkp
	 J0hp4q29uERoU7za0rdGFt7Ut5VzrrW6xg7srLqFqqKZLiavTBcuLdVjBoNpv5jRGn
	 qMiC5qsRQnh9wAo3pSX276nDOQemJ/py9rpZmwC/1noSySQUMbcu/VeBw8iynqx4yO
	 nwv6HWC7zrCrFG0aRTkLthGVhfKVNzlV8xfqp1JPdRBfMW01XhQDXEKsP5e6y91VKM
	 gZzTTi02nMQsw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 87C55422C4; Tue, 29 Sep 2026 03:19:03 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651938;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cVaUuEviMGaiJCFmUF3/xJdcGw7ZCUz7qPQwBgH9shQYSVR8OvqbME8+FSeOZG8zO
	 JqJcIqQjZGK6qxMMBvxsVPC4gCGQ/DZHsWWpbzZL5lOXgdcPSOF6jR0HMJpdm9G1ER
	 iFSJ5YRJksSnGlfco1oSQJZChw7YRgpo5HjfKfbVcLGPiIiqmASQRq8XoPVpO4h8Lq
	 XzNK4riQ6ekrsYGc80H7O8ngDHeBT4fpzdINrQQK0jjoYo/mcnynW7IeoOaM+BFSs/
	 x8IQIOUnAAYNUbQQU4cx7vvn03U2usU8Lfc9Yv7kA0r32supDq9NB7pYkfXIJL9mUc
	 COxcxFaqcfWGQ==
Received: from AMDDesktop.lan (p5dd1eaf2.dip0.t-ipconnect.de [93.209.234.242])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5484942257;
	Tue, 29 Sep 2026 03:18:58 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 29 Sep 2026 05:18:50 +0200
Subject: [PATCH net-next v14 02/14] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-ax88179a-v14-2-a1f2249e42ea@birger-koblitz.de>
References: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
In-Reply-To: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
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

