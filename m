Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841952853F3;
	Wed,  2 Sep 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368263; cv=none; b=d8vn/ZGR9OjH+EjTSA+BZs+O/OAlt2KeSD0yPoYOFAbLUQJqYOr61/x87BmiVH52c5uHjvRQjROj24/xYGSfcrmCPiPxKwpa1O2HBBV9lJbzi+EIKYqkaiHl7/5ctiHW0Xh5RGihC/10dq1F0iMhtO4cZc58q3kd8YmRXisTAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368263; c=relaxed/simple;
	bh=P0LMkAf9uVPDEluerStNQawIvDumaDGROnHo7xNZtSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ejbWPd8BkdrmW2qi5VtfJlX+yr9LKnwbC0YbXh5NTSU9UGgbTf5XTFI4bEcgSvAutlAs7g/dPhzKeedMiHQV4NsKCQQ2pjpkjU1507ueQYBnv8JdP4/6w8k3pAW5dV+whUJLLe/EnPBJrSB0v7j/b25LfeO+jC5018h/OWf/YVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=TXcTdhn6; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pktVw93t; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="TXcTdhn6";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pktVw93t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368259;
	bh=P0LMkAf9uVPDEluerStNQawIvDumaDGROnHo7xNZtSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TXcTdhn6t+ftcgiFbGdym6duYLgQ8hQD5BltYRFgNFzhYYMBLJ4FpIedKQ1SRsHzO
	 gLr8Y7Fiu3HsMdVPjzM36DJ9jrRYiW9qVdzOWknyJYunycW/LqIzXVgopE+kN4boy6
	 dEL+y3kaMA/V4Rg5pljqkLRnMHyOenDIj2N2xkM8hQSWIxGaD1AImPHQsA6qxmCgxt
	 N46iPmtc/IYsFLZn65EQlUWxJtjGqMJneUA4qosgu5IDa48bt/o3oU6iN/5/4CWGu2
	 ni9u719yfIbFQYX68dlB1MZzYCi5WS671VFqtiZeZeZAEzRZbZ2MjfrRH8fDG1OayM
	 rNQUG51CRVt5Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B22E83EF0B; Wed,  2 Sep 2026 16:57:39 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368247;
	bh=P0LMkAf9uVPDEluerStNQawIvDumaDGROnHo7xNZtSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pktVw93tZYdTP5w3IFmYjW42pqQnWejvFohAz0TWDLClo2jeaYpuS6HXqLPd2EPA5
	 /cI8zPbMOcWTEuNPHmrUW52QcBWEVPC4YmjU8pizh/pnowL23IW9R4P5cg/tCMLjbu
	 5JLZ7s5cVcOaodmBYs7h1rH+MeL9cYkMKCzeXT/YPqCa6ndJzevUcMvIAoo/FA1cHH
	 E1EsdDXd7CY45DXg6g7C8FGhcElrx1wGWuzW2ASS6nMUHJcFRSZVkIn0rc1ePPxzHq
	 5CgT/MRstpafXgTuF/gwbk7JTMX4pUmBT/7tQl70FZkjmfDvdMw+F8y0zYKjN6NoD1
	 W2NZMHusR7JBw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0D90A3EF08;
	Wed,  2 Sep 2026 16:57:27 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:26 +0200
Subject: [PATCH net-next v9 12/15] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-12-8e6d7710a2ae@birger-koblitz.de>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
In-Reply-To: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 5ef55f29d64a534747e5480faf192b06817a61f4..7408ac8c87a843a63e1719d765dd61e718432e01 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -216,6 +216,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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
@@ -305,6 +319,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

