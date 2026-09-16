Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B222FDE6;
	Wed, 16 Sep 2026 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529081; cv=none; b=QSzOqPESJE444VMszCUdFj+cvg0yNLan7BgXVhcU72tlrxZch2Veyb1Q0zfzNVxGIv5oUH7Qglxl6QB8Mug4PpghCSagtPkfl/p1kg3fbIZLuaripNM3zaijH3jhBdMmrO6ZNLqlHyKCL26TFV4UZ+rqaLo8xibr7+3iKt4pQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529081; c=relaxed/simple;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+0f07c3tchZbDcV9g23farnANT061X9WGIlpbMfl7uQXEYejDTaZM+ArZ8Sd68bjj1DmA7HHAMq07YDkwUtZ/YpfODhnpS3cp7bCMKjV5okEJgecM48Tl59OQ+z3pjhN0qKGtheuS4+GPND344+IsyNrRUb5q25M0vZpq6hGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=flbWCJtP; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=flbWCJtP; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="flbWCJtP";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="flbWCJtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529077;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=flbWCJtPPyBZWXHz+aRrfq8mkTxdJvpSthZDdepJWHo6tvjaI6Ws3dhdYrsv5TfEO
	 ZZCpFLXCCa5OFS18APd8asajSoly1d1+EMnylalCbQ6k1W/U/GXQUyF6WmtgTvIG9S
	 PV1uQ7l/NJokUyLmUaUblXzQ54cKi/YK4hnnczncj15vnTXPLj++2kjvfZxRBDY05B
	 jScm7yVPibQWzt2jidaXlvYBoYEl9hpRIl9Gkd0lrcXX/fO7ZYqsdwCKYjzBk/vw81
	 zKdJwawoRbQKZD4ot7JpO/Ocot4ElBesHZGATaZTErUPt9mva0C0VtOt4CJKQqVPpk
	 R12uq7trbaouA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EDEDB3FA80; Wed, 16 Sep 2026 03:24:37 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529077;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=flbWCJtPPyBZWXHz+aRrfq8mkTxdJvpSthZDdepJWHo6tvjaI6Ws3dhdYrsv5TfEO
	 ZZCpFLXCCa5OFS18APd8asajSoly1d1+EMnylalCbQ6k1W/U/GXQUyF6WmtgTvIG9S
	 PV1uQ7l/NJokUyLmUaUblXzQ54cKi/YK4hnnczncj15vnTXPLj++2kjvfZxRBDY05B
	 jScm7yVPibQWzt2jidaXlvYBoYEl9hpRIl9Gkd0lrcXX/fO7ZYqsdwCKYjzBk/vw81
	 zKdJwawoRbQKZD4ot7JpO/Ocot4ElBesHZGATaZTErUPt9mva0C0VtOt4CJKQqVPpk
	 R12uq7trbaouA==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 37CB73F6DB;
	Wed, 16 Sep 2026 03:24:32 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:04 +0200
Subject: [PATCH net-next v12 05/15] ax88179_178a: Add netdev2data()
 convenience function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-5-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add a convenience function for the ethtool ops that use
phylink and need to retrieve the ax88179_data structure from
net_device.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_lib.c | 7 +++++++
 drivers/net/usb/ax88179_lib.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 761701ebc0692338b5c0a9f73d0b6965cda87d6e..ea36aef3d3e45ee4f84362a1b87628a12a355bbf 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -128,6 +128,13 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	return ret;
 }
 
+struct ax88179_data *netdev2data(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	return dev->driver_priv;
+}
+
 void ax88179_status(struct usbnet *dev, struct urb *urb)
 {
 	struct ax88179_int_data *event;
diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
index b2ee1356727cf4b3fa05f0b0d5fd863ac3f9a87d..9ff2a94a6fb2de4ee85f25e913ae2fe263bcea7c 100644
--- a/drivers/net/usb/ax88179_lib.h
+++ b/drivers/net/usb/ax88179_lib.h
@@ -181,6 +181,7 @@ void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 			     u16 size, void *data);
 int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc);
 void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc, int val);
+struct ax88179_data *netdev2data(struct net_device *net);
 void ax88179_status(struct usbnet *dev, struct urb *urb);
 void ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
 int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);

-- 
2.47.3

