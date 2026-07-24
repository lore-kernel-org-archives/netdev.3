Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F613AA1A7;
	Fri, 24 Jul 2026 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878620; cv=none; b=spNjZr1us8+CKC1b7XsUAMPDvsiu/TgZsYgjKM7xtpRO0eTlJpLboHv9kc7hDdjqEPbNrCyypLeRNOanMLUNq6A+Pawm291vX2k2Bi9PG0qxtMVh2aWflBUrgsA2Zzm+2ZLiL8gg7CXpDzEC34HSUT5P6V1Z60/nExGMJJBfqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878620; c=relaxed/simple;
	bh=qCvPeS6GlFQC/4Rao6DwJajLeup5Mjt3RQtMo270ucA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWpamI96WzKzRszAKWEg3QCJ8Iskkh/mmLBwM5C9y6T9yYQDz3u/kM2+ZBu1D4CJDHcQ5d4YFhK1HEU4FzrXphkiaB1wPBBt8gMbyzZBFHuJCI8rHskCgT1Wjuosjwm5bI77FROcfyqHQspRZyS00BuL3AOQZhNPzSQjG7z2g0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zHifDaGO; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xXdvJ5fG; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zHifDaGO";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xXdvJ5fG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878617;
	bh=qCvPeS6GlFQC/4Rao6DwJajLeup5Mjt3RQtMo270ucA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zHifDaGOWNUvoNgNMSjqILah5izYlZirjSvm0UIKwRpGaAAwycPS9JRgUEknWKNyN
	 G5NV5lLbsOk4TdVCCLkppbYLgTupDpYPSYmLKi844vVpOJmFp2+mrgxS/chyhdbLsm
	 HEC15NW2YNGgY3GQ8Dc3sqwOnvJcLg7hgktpw2iZ4Wh+q8tn8udRszJmGnKBko4vYc
	 /Vbf/hzQYSUtKIFiaKxfK1tDE4KUtj60ru/CyT2H/dtqHLE+AMaddNNKzFpD405NMg
	 jaUexQko5wpnIS76sh09LBeu9za0ltb8w2xn63CKrD4q5wMlhvhCPRyhOC3hCfjdZT
	 KzvqZdlEe875w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7C1CA4946B; Fri, 24 Jul 2026 07:36:57 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878608;
	bh=qCvPeS6GlFQC/4Rao6DwJajLeup5Mjt3RQtMo270ucA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xXdvJ5fGRy+VzXQQiZFIJCn9E6Kwu2zvVIps4I5hjLzsF15bVYTbrD9MTZbcziSQD
	 XrDuLKr5VhnyxJVPBLrMXLG+Zwf3Ko4+Btzkrj8fC4ILou26sbPgrajj0WfsEJqdy8
	 3fDIDdz1nAW6gtF6NbtfX1h0QQ2FPnE+tQMjh1t09IPUGKoe2CCs1140UCIsmrzTdR
	 fjVyyypeyrJfbuMFcsNupeymv4PX/XDHsc9DsZxIKUfhVqeJV0xkGytA2KSnHf4RBj
	 UY4MG4PwroAj/tIIpfaZ3SD8g29xUFzeYlYFHpaI6tLExZOP7ZjNemgTJxoafs5aB6
	 TxHztirHeqlTw==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 01B4D48EFC;
	Fri, 24 Jul 2026 07:36:47 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:48 +0200
Subject: [PATCH net-next v3 05/13] ax88179_178a: Use phylink in
 get/set_link_ksettings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-5-bdde4f905883@birger-koblitz.de>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
In-Reply-To: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The PHYs in the AX179A-based USB-Ethernet controllers can be configured
via phylink. Use this for link configuration.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 2e2f96a97b8398ece7d70cf349c7db973959629f..136d1d39bf78658758d35372d4a9486e21befd87 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -967,9 +967,15 @@ ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 }
 
 static int ax88179_get_link_ksettings(struct net_device *net,
-				      struct ethtool_link_ksettings *cmd)
+				       struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+
+	data = dev->driver_priv;
+
+	if (data->phylink)
+		return phy_ethtool_get_link_ksettings(net, cmd);
 
 	mii_ethtool_get_link_ksettings(&dev->mii, cmd);
 
@@ -980,6 +986,13 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 				      const struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+
+	data = dev->driver_priv;
+
+	if (data->phylink)
+		return phy_ethtool_set_link_ksettings(net, cmd);
+
 	return mii_ethtool_set_link_ksettings(&dev->mii, cmd);
 }
 

-- 
2.47.3

