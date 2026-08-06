Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FA4CA27C;
	Thu,  6 Aug 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044976; cv=none; b=sAQOOvq0joVdubXbHhERwE3EtH8SmSDgR3L4BMwH9imvAjJ/0/kFl0qLz6wx736gfChXrgB8pSVQGLyVM94WntdMSCIh/a8KXfj3JUeFkud8fpaDxw96UeiQd0AT9DvxwLqhUr8iIbgiOdL88Xvj2FSwfD55zIwKXOACkXNrTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044976; c=relaxed/simple;
	bh=yRi8jBaqbfynPuMJPR5f2PCXewOqVYetgytxgxOuGYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mh7FPWxgGC9EXoxvWGvmAgZ8nF9F6bAiIDY+FDiBRnvwg6K+HoB9M2uNlf+WNgYDLOyAmD3V6ecaAUh2QskeYgGMS2TLi1x+a3Cjz1e4Fv6P7cyVNIt+wMMFTLfVKwAuxkwn0tsjqTV9P+isaflFIA/XuNkU6V3aPbt4PZAp27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CCkZSGjl; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=UR5h+Yrf; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CCkZSGjl";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="UR5h+Yrf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044973;
	bh=yRi8jBaqbfynPuMJPR5f2PCXewOqVYetgytxgxOuGYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CCkZSGjlmlYvvLWB6hFflS9b2vSlkLNZNxtCzzP/vQMTXKpAS1/zc63T97CrAgjB3
	 vbMewEuhSoz0/RuBs7BHNBq2m13WsPKtxGJuaD9KFlDPKRvGnIRIkcC6orJTqdJxGF
	 Pd26du+SnPP/8BczXcvdz6QWFV8yOb5x+67mavePFssvVdF29qLYLb41FCXghlRzmW
	 dNLmJbKlGYLr077WeIhqDo3SlIOSW5m8ffKLFAc3Se49YYWGvhaHOQKSnYlDhNqBns
	 O73t7qQcGrlzIA2OI8K2bZe7/fHBJgV+r5U+ZLJJ+m2vwPOKjedr09OzzlsIFRaQ8x
	 JVnzQE9Qwo2ag==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E8533496F6; Thu,  6 Aug 2026 19:36:13 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044967;
	bh=yRi8jBaqbfynPuMJPR5f2PCXewOqVYetgytxgxOuGYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UR5h+YrfCB15ONN66VgzlcBbVGxqQHPD1yrP4/FUVExOjtSCCzXwBU86VTfOC5Uwp
	 lEPqiAToVmdBpERCe7/V0CyudfTjsZUfBnudc6xrHbJiHmnx6OL/QyC8a+zHC8DhVm
	 BjmWz53VBkSCZvlFKvGwJ+Gu26db93DsB46DSljm9ElJdX8urCbVas3qa4Cf8G34oA
	 7vLbPFFjbWnJvmcxmSz5r+AM+PPcBSeCkJLGOIOp7cp3HQs+hAe8lHz/hUPfj3X8xt
	 yzTg1I/ZRBu1rYMVlT5bIBguCtbXgI0er6MCvPSQGQYotFMt+NKPCO7XJ5J9ZDswQY
	 YD4iXfxwDl7kg==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E2B90496F6;
	Thu,  6 Aug 2026 19:36:06 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 06 Aug 2026 21:36:01 +0200
Subject: [PATCH net-next v6 03/13] ax88179_178a: Add netdev2data()
 convenience function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ax88179a-v6-3-fde7414619e6@birger-koblitz.de>
References: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
In-Reply-To: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
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
index 7b5c17a01df2deac2cc0210bc88193be1abfbe23..34350ba3b96b94bc82072a578802a91ebffd7a6a 100644
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

