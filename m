Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661A9460;
	Wed, 16 Sep 2026 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529065; cv=none; b=df/obYXP96O2FsmiYQVmiv/SO6GkxWsG1oIRnuHxG14c94qGnJHzCATnzJidEBa3b9bV4B5jD1o3xgrGHVBq5p9gyeAqzZXD54H3xAcZIkyZC2OXyngLe9PE27m5iPQpVvilUr4LaqbgCrUD9GRVa9PnlOOpFes4PEUkIertrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529065; c=relaxed/simple;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=km1vX/lY5Kg318q/6+s2QeoqwOrxBim28k/fvRPpL8JD9hko+vr/6MPY7sQOdF89NoHQhzaotA1wkiRrpDtIRGoP08dB9XdAPc8P/2nsrXAlfZEHzlisWc/yLPbD0ACqmZ1IVCqkBB8NEBV0RxU4D951UNlwxAgtEVEDhMCXmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=sVE7EjgR; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vZLSQTmL; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="sVE7EjgR";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vZLSQTmL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529062;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sVE7EjgR9c2h30F/rd8wXve0hkSKVqP71MWYHzhUWYaqNiDftiu8ls+wpXz0JYsJU
	 LZZsZbFGjURphbYcmvY2PxcsVM5E0g+9smf/YWXEFDICe3P5SROMj1OIEuIrqKoTSh
	 veRxSrEm+0DIoEHoSvvyWVvZ4HL+92oVjGiwYN39W3glJIT49Q5bnxIxXTvG7G6gyb
	 QI3OtSn14lZv0UAtizV28s82fITXXRfhflQ1cLx0kteEh77OwiIUtCkAXzbO697HoI
	 2lO8RYViDj1G7DANPrCWqS6+6CNDxYbdAKWJmrOh4OCJF20fUELpSZjOkqp3NdOktl
	 ZXm1C+7+yp13Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7DB7E3FA7C; Wed, 16 Sep 2026 03:24:22 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529061;
	bh=IW0//u1gpMevyolcBWeSbUdau23fguyuh11+5qqrMgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vZLSQTmLcfbcA7X9FYqr/tQ2ss4tqvDm9rUcONCVNw1UQr9HkmqPWbHaD25GRUti7
	 I1NniDwqOKu51LTIjfO/fw3qFrKGYMKItj/MqloKg+4HLyRbJpJ7lBagg5sEu4mSG/
	 Tkhfmyrs2diBaL3JlSXFLKvxvVc21OMLfwVAJVTIMDKEr1Zakneu4mN3frmP/gHO04
	 NwmGqDVM9AjjjmWWsiu6TMACVOfSQvH9+Lp1eZPQa01WEE0RIVb6hR5CHqMb4h2ry1
	 2iy7ruwRPYsVr9sBAeHSsC3xwu5aso9P5+Rz/GWvObI/iE+HmbGiu9Rh8KHpIuM1aK
	 08k8whL3Pgb5Q==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 415893FA72;
	Wed, 16 Sep 2026 03:24:16 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:01 +0200
Subject: [PATCH net-next v12 02/15] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-2-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
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

