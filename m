Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB75514750;
	Fri,  4 Sep 2026 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542938; cv=none; b=Mgq7Jvm7N/leNm1d2iO75EaZ2CyiiTdHUElsttp1jASU8M2dyb3rsQ3DTlNT1PD0wWY9gYHRQD1IcnOerCu4L0+D5Z2dU/Pw9d7eSXmgqjjIX89PVpSJzDIull/QsWP2Zo1aHJ9vZRJP2zmkr0zacSuxS5nE6wlAZyTqGcwNx2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542938; c=relaxed/simple;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QplWMZiQ5N/SRXlgjtO7lRdaCassyob5bHxWOWEHTPgn5BPs9ke7O7bmjkuB9Y1vf9UPaofyIBSyHFY/VROf6Yx0MiU1LsXa8HLU881nR6By95Ww9LJb0hU0e8AmdV8TcCpF6+HfZoHqjD/b29SD/9js/bdJeWhJbohJ0hZ82Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2bUqPTUL; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RB01nhRw; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2bUqPTUL";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="RB01nhRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542920;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=2bUqPTULgB8zBHkBgbPpbpe0vVLaHhaKFi0IE0MC9myx3o5vDYWoH+sqF4eoR9Udr
	 +7zmoDvCKoGwxBf6quQ/nhwheKmDVHFFN0VC0b02h2relBRlQIJkyZ5/9TnpfETPpJ
	 amRWUruTbccOmCoxkZyO2Xhhzs4PoRvd87mJNTyatuJjynrGY8UKcerg8pFQITvGQ9
	 dbJ3hbLYkUrpUSwigtNv9fIH8gqPeNwzt1+9RJXCZOLLWcqBNKV6q1Lr6ohYJL+Qy7
	 VMfSa+JxZ5DOe9oxSFa/elxsRKSrxUkypk3mIlFi6nz0QJQz2sb5U7gwYiKCbHU9gG
	 hIjakDOzHEoug==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id F1E5D3F0EE; Fri,  4 Sep 2026 17:28:40 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542915;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RB01nhRwHMV5IsBU/Y6bqu59IlRsT7Q1efEHAQtNiiJJBMjxAV1BhH3Fwp6Luwvko
	 m+4Q0rrY5O8AHtbHozFwybTM3l5Kp2kl81C+3l6T6RtjaV5p+N7cvr2GOZ+cfCSAZX
	 KjE9giXhPBv536MQzc+UY4a+roWVLIZ6wg1Waw4gqhj8yOoIf1hQqspRY7D89Zn80E
	 KytdrwA7zqJCgzQwXeVSkOSf2wHGWb/GPGFSbB+XGt57986IJ4Syh6lLwJGo9j9BH3
	 mEGk9b+qpAZ/cfRluAmA3AvGLPxGEyCIKKqu/PnFNZ40VSDcBAwG6PWNuiRZuFJguj
	 cYkoimRSL6Fgw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id AC2C63F0EC;
	Fri,  4 Sep 2026 17:28:34 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:30 +0200
Subject: [PATCH net-next v10 05/15] ax88179_178a: Add netdev2data()
 convenience function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-5-b5e60eca7690@birger-koblitz.de>
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

