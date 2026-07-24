Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970613B4E88;
	Fri, 24 Jul 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878625; cv=none; b=Bp/dHpbFE/iLffGy9gmtooeJUkW/aQkNVg0v8FKhXsQ51Ojn+U7w/NkE0PhkqDCc1T/ZRHtR18JQeGllv4WdgP1pdRZ6u0RhG9xL2qA1mwuUT3BQiJpE4bHcKbXQWvI84U8sU14DDv+Bb+sTvb6GBRLSNlEvDMq/EWhLzUx0xAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878625; c=relaxed/simple;
	bh=XLqTh+EKqLwqHVaL78vW5c6DtoEBej9pbGdKMEgmVq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DU2TMlvOkS9b1AZhWXpjK4v7NQ0tfQF3W6hS1IzWnZ71Gvyr6V+pRf6J+7hbnth3wPt7+YkTvh1lhRDGegeODixBoPWMD+d9X5/Q3Tz9uOuhX6bl6TjpoGoRlm/PF/pa+0OEySMW+iFUpP9GfyLV7mzDSBwiu9NF3/bUs1hinc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=c+8uCjRj; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=21e2eGm8; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="c+8uCjRj";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="21e2eGm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878621;
	bh=XLqTh+EKqLwqHVaL78vW5c6DtoEBej9pbGdKMEgmVq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c+8uCjRj01AN9MpwGyGuu6Y9mUdryrTb9Sd5XS9Hz1MwOKt6Zj/ZJtKR8mss51oAz
	 L15P2Q5W7dbCp9IKmsOYjZOy6Q1HR5DxZIj20wUSjK9gL1tYgiMTZsXKR2gvX3nztf
	 XAsRZNj83hjxJ87IUjCHWw4Kqsp/Jy2HwoRTwyNrRSN46R1fuU1xGmMgZ1J3fnij6F
	 +lEYEJDQ2SjM8qGxJ4CXeuOrH8XADx+NOrRwp1lb32Z6Wd+oCqHAHTsUJItkgfdbfA
	 L30lvBQ/51RwHYtzV7N61/evXKXIomlxGFRuo1kZVXFfnN9wK7g50xFSrlN8MzhkWl
	 D/JmRrUYKycMA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B93F74946B; Fri, 24 Jul 2026 07:37:01 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878609;
	bh=XLqTh+EKqLwqHVaL78vW5c6DtoEBej9pbGdKMEgmVq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=21e2eGm88z3Cea0BB/lmBWAuHtlCHIp9o9A4wlueqFglsoIirYLKQphUG0PSliF3s
	 8fkXqeEw2ZH/oDTQW+1vbEHvJ7xOMjcdzxawA1yC3CJMvraGHsptqHXY41l/+RFE3P
	 u1cv1yGcMz1a1YFtqyhTQQZk+8zMKBXBSwEaaev0hsmY/zDI4UFZRAoM0iKLPvtvIC
	 j7QDr4WN3SnEFYM5/AeM16yh9m2lqiAx7e/Uvz05jqwV7emxykmmegy0YQdbcxpmNI
	 UvqRrvS/uhNZzNaPPlt0gJHC6B+EfBNRS7cppFE1bq1jbILTQyGrwWpDaCZrMyneSB
	 HQbmCTGzYQYPg==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6BC54493BD;
	Fri, 24 Jul 2026 07:36:49 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:53 +0200
Subject: [PATCH net-next v3 10/13] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-10-bdde4f905883@birger-koblitz.de>
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

Add ax88179_get_drvinfo() as implementation of get_drvinfo, in order
to provide information about the device firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index d8617dad5990f38d39b4569a6347e219856c6f2a..ae07bd1cf5eb1b15a089b3f67d2f89cf56c10f8f 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -827,6 +827,21 @@ static void ax88179_disconnect(struct usb_interface *intf)
 	usbnet_disconnect(intf);
 }
 
+static void ax88179_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
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
 static void
 ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
@@ -1184,6 +1199,7 @@ static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179_ethtool_ops = {
+	.get_drvinfo		= ax88179_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

