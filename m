Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C33D9DCC;
	Mon, 10 Aug 2026 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365238; cv=none; b=RvrvhZh1gqxTzuncATvIYgiL3XxSv2lOum73Rn4p2k6w/PgNJffzHASwES1gzOeW/KHbcm7NUtjZ9JZyewCyrL2E1UPH0cSt1KjpgzxHwB79pNv6ROB9Gnj9s/LPAQUpOvVGgw8d5Z+flbRTDTq0q9L8woT5wueBoxsrI9iM7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365238; c=relaxed/simple;
	bh=arPauO7pr6LiIFEB02AC20aa7I/MpHlsHswf3y6HSb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syMEK6lTvOLhLMBakVu7GhwHtIF7OEG9tR/jVNb3QNAd5Gxc6npE0VPTnqHORgCMEVTJksCRTIoVgZVq4df4GzeKMrr4wRBRkBKGrRhoZXVkLuBJnOZA63BNHARF6lkgu2nkZjiWaBV5/NQ9sWR3qepPERopiu0RN1oBQ6KNhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ZTpafRMu; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Jdzj48CE; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ZTpafRMu";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Jdzj48CE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365235;
	bh=arPauO7pr6LiIFEB02AC20aa7I/MpHlsHswf3y6HSb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZTpafRMupnCDD0UEg2vGrs2JeP2wstmDitVzecfWAqpCsnWGjP8TDf97Yr780lv1H
	 raDoksQBy9wX6skTrzX1xM2DRkTrsvRlFIBJq9IL1NDBnX3WZQHqxEPIu+9iZKNQ0B
	 qrvqzY7ZB56iyBUy4wpMoWC0W1ShrkARJXvSwAijHoqHfrp0tV4SJsgFaBQ2Mm1uTJ
	 UoYNbk0XJA84ePybeXkA6NjtUqZZY/jy/L5Np7MtjIlLqAb+M9CzupCltWdjW31czK
	 BcKBLGI0BGhABpqk78GSxX2NAS69JqDMhR/ogIZ5Cj66ZFuDZKqzns0NuD1XQaeF6d
	 b77BogL5OV3HA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D82904977E; Mon, 10 Aug 2026 12:33:55 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365217;
	bh=arPauO7pr6LiIFEB02AC20aa7I/MpHlsHswf3y6HSb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jdzj48CEEz2Jyhb5gqyEhJ1GhjTwX0QuhVzvbxVzjdTDQWhbygcAx7Qm55u940NX8
	 KBBqb5KXg3d3YDUx2rqmyDaOoj2VhgIXeNhyJde9Q7qRBwHxXZmhoWHFOkhs28yXhY
	 43psEuMxgvpR3UBjrUO5nvNHBRKQBbv8hQWCGe+W7cBFVts3ffS0To9H0aROPlFqQS
	 ecpwbgkDEHkEMNgWNOf7ahJdmCGXXdWQca4+JhZWKJgYvIvggeAcdKxDSgquz5PDxi
	 yCzKPUYHTh6nYxhl1YmbhsCRE7WvDBxwZvc3jR43l3pg3UBUw/TEu0SdpMeaP7Fbu9
	 cmBWMOXG8aYFg==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1880B49771;
	Mon, 10 Aug 2026 12:33:37 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 10 Aug 2026 14:33:29 +0200
Subject: [PATCH net-next v7 04/14] ax88179_178a: Add netdev2data()
 convenience function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ax88179a-v7-4-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
In-Reply-To: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
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
index 2a9111cead3073aae225def0b5f8a5a4f40c8439..60888b3fb4fb579b6ddbfdd8033c9afb2bffa88c 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -137,6 +137,13 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size
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

