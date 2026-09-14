Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6DA47533D;
	Mon, 14 Sep 2026 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390056; cv=none; b=VYVIHdaAMVmXQIesBn48AEwJq9+z5Zc4f7+Y/jPWrzvyUqxTbu4yedqKPch4zeGqAv5Pb/+GC7z5BTUebXUcheQeN+ZXgVma6k/Uk9DzCZXPOcDOVBq1NrKyrZtGbBvMJwi5mQ01lNVmge5HerTCkH5qygqFNA4Ru9DRN8xOpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390056; c=relaxed/simple;
	bh=bUhFkG1xQXb9dCHm5Xi6Cni8ITRf88vBEuKy3YN7fZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AKTXMr1PfWMdtDLQmiVjl05ZGRbS0SYZPXYw7qnFlRxhb5zVAMa/Ml39h2rT/lCfYTClPSrcOuD81/GS4xe49gPVaz7zoRInvvykllRgxSg2+A6i/jjgTeSEJI9CjUgIGRe2XKxSDVUBIhz45oQQcy6HFiPG8qCNARec5x6TyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=M8yzP2cc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=BoLx+kA5; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="M8yzP2cc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="BoLx+kA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390051;
	bh=bUhFkG1xQXb9dCHm5Xi6Cni8ITRf88vBEuKy3YN7fZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M8yzP2ccIBz13i4BOXbHcDi6kBN+a5nSwzxrZmWpKKdRNueoFvPvF1J8qt6jCaKgR
	 f2z+RbmFbtb71NfoYWu+nKhi76aW/vKDBcptPMJnz6v1OR9qn7G1sdPhWURlnp4cVc
	 M2bNv56gw4gA+XiDQ8U5qNAmy/Z3LuFwLxbWqD7BBiUvHn1d3EXWNCGc5dvm0lQiGL
	 1pyD6f2rAZZ3d/0uVtSHFiPwSXuJBsAQY/M8ZUkdZ59+aM3XTj8Lyj/d1jgmHqXw61
	 FfU7msify8RNvtrZJLdOuRkzmb5scefFwoplO7gBXpSKWLMhpL8oLH4OVa7MKAb/Fa
	 ndAS0/JJ3QaIw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 96C893F6E4; Mon, 14 Sep 2026 12:47:31 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390050;
	bh=bUhFkG1xQXb9dCHm5Xi6Cni8ITRf88vBEuKy3YN7fZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BoLx+kA5HWYmbL/txvh4uSA5wEfWqQ3u2MMGLqKc+vX90VWVAwV53JYkCJXxlsfc/
	 qqJqFxZCXtJpN1FQJMHgBzg71YeSLC8JgiUEeuWh8z7a6EVaw3CA25/qtoWB7cZ8M/
	 54Ufrm2Byre3W+E61+Dvx8AX5+IDVwpN7OuPxFt8gm5/SiK5WBDao+xL/njgTqkCTI
	 j0mQBlvGslV06l6njBTAhsbHRLbEYChsGZgv1E2PzMwbsZoVwf3mn5mDHhQ24AuVy2
	 Tf+yTnsBB7uOVeO4KBh05Aeg60pfSdtMZzB7BUK/ZC/QvambwqGXgHGoPOrBYIOJLS
	 lF2q8RkQO2O2Q==
Received: from DELLLaptop.net (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A65DD3F6BD;
	Mon, 14 Sep 2026 12:47:26 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 14 Sep 2026 14:46:21 +0200
Subject: [PATCH net-next v11 12/15] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ax88179a-v11-12-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
In-Reply-To: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
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
index 27836c72ec14aaaedfaa97ef95730bc7980074bc..817d542c4cc085d57837f2cd60d486efdb7f108e 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -218,6 +218,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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
@@ -307,6 +321,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

