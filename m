Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C944C65B;
	Fri, 31 Jul 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514771; cv=none; b=tp4MPTVqgSFoc0kYw7ONbMnmGmo++nMs7HA4NAxcPSGCh8IYNb7YNdLiTJmjcyoxTqFFtBUbEMOvRmkokZoPY8gakPEr0ru2BSUhS0zKQLuIboau6KmhJvsqjYMlj0oGK6NcH8/5dSWyQ6D8ZoHOw1gA+c6CbBsGEgjNFzPQ7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514771; c=relaxed/simple;
	bh=K0DX1ldt7+a8Cp4MzTw8GFsHnGuADXhy68uOO+IXFWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpBEiPL1weV/HSlAMnZr5dU83RVDizRyyUkGSkZJbi9RYby03ZejbdZsyhisz0/YfdBQh3PbhL1uZUamXiCa8R2B/UmwN+wU0oLQq0ULzfDVkbRBT7fdRJHKAIJXaP1gf9zdV50G/kTw47Pto+qgcjVnL1Oq3ZvAuu6kNEFA2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ZGtlLBBx; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=sMefXqDA; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ZGtlLBBx";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="sMefXqDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514757;
	bh=K0DX1ldt7+a8Cp4MzTw8GFsHnGuADXhy68uOO+IXFWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZGtlLBBxaUTnk4kTQ83jEbDIbPoChBpE1NsmDGP9XdTqeL2penca9obOk8bq55x7y
	 xwsVnD7yvKqotnMajyFL2nHc3PQePshdmN1HYoKITcT7oBU7k7dffiqADlP9fbRIvP
	 dQ02Rs2KCrXmH9TMgcLOLH6Zme/85P2i6sZQou+nDPjZxIxOxF7HXFKlrQk7Wub57h
	 5ZOTaXzU0LdCqcpixXQKP1UwKRi/SuWPAg2g6J22RoVa2Dcd6ihHvxqYno0kUWEc8K
	 g72l9Ia7TqygYCr7kssKfgwxdOvhXAf7s4R3L+f26J3+t9SfZGuYeCP7Xg+GThH+3P
	 g1WX9eOD+Acmg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C8A55494FD; Fri, 31 Jul 2026 16:19:17 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514746;
	bh=K0DX1ldt7+a8Cp4MzTw8GFsHnGuADXhy68uOO+IXFWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sMefXqDAp32SCBbg+HM+DGC+1jSzRUMa4YVJfxbSJzxBmzBaqpOWPmBNAISJheyfk
	 r4QAMiFX3Km4V4YI6jF+KwnlIG94hJX0CbZf1TVEueBFJQiGAp3XdS2abnzXK4lpuz
	 1A0RtAinzYbSdBeWJcgCb70icmWH7rpYRyOj+7CsQKAoUnCtUFNQjD+BXh/gQuzw4Z
	 O3/nzK6wo6fQaBl+xVywfKj2wp97oo2Ll2ZGGeusRXfn9u0HFzac9zUvk3qHDime1V
	 JiJhTeW/jLXjwaMGbo5ed5xz76l2IriZsRxulTKhqkA6sX5Cot2dAhJoKuuE46oEEq
	 ZjG+yvvpiXILw==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id CE8C3494ED;
	Fri, 31 Jul 2026 16:19:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:09 +0200
Subject: [PATCH net-next v4 09/12] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-9-2cf1f71b1dd2@birger-koblitz.de>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
In-Reply-To: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add ax88179a_get_drvinfo() as implementation of get_drvinfo, in order
to provide information about the device firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179a_devices.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 24ff28acc9366385c2e7c0f7e412635786995568..7634c39b5c986a8fd1aa15ecaf386e0d802f0bee 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -202,6 +202,21 @@ static int ax88179a_resume(struct usb_interface *intf)
 	return usbnet_resume(intf);
 }
 
+static void ax88179a_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *priv = dev->driver_priv;
+
+	/* Inherit standard device info */
+	usbnet_get_drvinfo(net, info);
+	if (priv->chip_version < AX_VERSION_AX88179A)
+		return;
+
+	snprintf(info->fw_version, sizeof(info->fw_version), "%d.%d.%d.%d",
+		 priv->fw_version[0], priv->fw_version[1],
+		 priv->fw_version[2], priv->fw_version[3]);
+}
+
 static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
 {
 	struct ax88179_data *ax179_data = dev->driver_priv;
@@ -329,6 +344,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

