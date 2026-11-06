Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949704;
	b=x8vYuuNleHbXskG19XiH+JSwIf48WQbKNuFB2GDACHruKc5gd50pt1fcu/EqA5Fuj9Ra
	 vSsFs7oBsQ1usM2LkU1M9Ar9JRHwM/T305cZaCutxEc06DWY+cq1x3fkncCrguueBUtSZ
	 Als5h9Y2LOD0QzUfoXmy3a1hRKTFryLCRq5K/lAScNjVD/nom+EIHExuChkpitYisanv/
	 Y4VLhItWOcoJumO52uotzjSMN1UIcakTDuIg0HokT1Jt0S9tNo8xIt5M/N5TDDXkqI68j
	 OEW5t/QhWy+pjF8P4/zhqKUTtcmFx5SzE1MXQ0QBIca3//Wa0ow6DyPxJmd0TPOOGXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949704;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=/ln1CUdYFcwFEe4dDBRhaA7UnFZFQE3qSIw+JXD++nI=;
	b=N4HbSn7KWmdJUTQU8CG0PMkDXu1iCGhM3zI6zTmdKTAA10Sxs0nT0Ig3h19tncixQQOS
	 Lr8OLu88di/8pX0iQu+B9HUxd3vH9mOptXPXaOGM3VkUOHoYctcIbVoprpvM6veXrpP6+
	 rXlRQpPfS0SP/PTTpa0Mf2GHjweMu3BoQGASpVexc8cHLJ6uuWU1NrqQxTPl9ZYaaBpOf
	 RNtX/05f3LNbi4lXV5CCOxWjkuhanbKkGIdRNrvMufVKhQhccmr0jxml0Tm944t7qdE7y
	 TBqdai6JmJGhdIitu79DhwzkimedxnC/QR/sZzflx8edb0r5XJcFl7lDtYbrSC+gktw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=hoRogZaR;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=BNKXePev;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF406082BC1;
	Fri,  6 Nov 2026 07:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF406082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=hoRogZaR;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=BNKXePev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949702;
	bh=1JQfZA672J6OveCAyEFBpwt3mdwIiAJM1L5TlYtB+GE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hoRogZaR/EFF4KvYhLJmbOcgeI09sG0jSC1mXnEP9JmnlsAJ/ulxbQJcnA5tRcsz9
	 gbDhPlSM5aWdOUQVNJAR4r6ShGsrwdTnndTWthjT95e9W8gqEt2zI9yUU9Nq5v5ish
	 P0MOBudus+F0+6KZNq9nNxU/ApLbsR1iKpQ57tm9O+TLl7uf1dVJB6FJfsDKHYrNjr
	 T2zu7eVPq2p6z4n8bF61yshpzK3Wdh5PgiFRKYK/+Ykc807qPAFCKrEVFzXsrUvr9C
	 e8eev0Lto4v/5w8p+UVHGSMgDsvaTjlVefIFIhBcYbYWGXN1htGx46uUEdnx7E/ljX
	 DUEzEqoTpEBwg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 605B648B8F; Fri,  6 Nov 2026 07:21:42 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949688;
	bh=1JQfZA672J6OveCAyEFBpwt3mdwIiAJM1L5TlYtB+GE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BNKXePevWtYHnNdCwgiJQ32HETeMxRQEM4UNVAkW2pWPaDNO5nvTMz5utNU40DSsD
	 TySg+as/0bcDZjqxgwGTN9GBcOC0bu0HNKNLu+axJNa6FZlSqkSDv5iTf2qXKaI4MP
	 4sfLRRQjQiRJQco53fdCHCmmNHMeYw1TFK1GiAdbHY0YBiYKiKeCgDiropBiLSGB1h
	 8W7S71S2h0bLiiMvtgLHizm+RGIpUzjz050/p+JfrPi8xBgEiCQfqw0Rjl29Zb87Yq
	 BrQUNUPG1y1AyO/H2yGSo7WBVKJlx2DZcek+hlfhAXxM3QxQwCkqzomhtEeQD3N/Vm
	 7l/uKYG1i1ObA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0AB9E48B95;
	Fri,  6 Nov 2026 07:21:28 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:25 +0100
Subject: [PATCH net-next v20 10/13] ax88179_178a: Add ethtool get_drvinfo
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
Message-Id: <20261106-ax88179a-v20-10-37b5a1189983@birger-koblitz.de>
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

Add ax88179a_get_drvinfo() as implementation of get_drvinfo, in order
to provide information about the device firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/ax88179a_devices.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 01d6a35f68b2c56f79acbe2875ce8e99ccdfb197..69095110e70435806a99274c50d79e86016ec9a0 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -235,6 +235,20 @@ static int ax88179a_resume(struct usb_interface *intf)
 	return usbnet_resume(intf);
 }
 
+static void ax88179a_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
+{
+	struct ax88179_data *priv = netdev2data(net);
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
 static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
 {
 	struct ax88179_data *ax179_data = dev->driver_priv;
@@ -340,6 +354,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

