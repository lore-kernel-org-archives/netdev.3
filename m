Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58305368D4D;
	Fri,  2 Oct 2026 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916506; cv=none; b=rOca5ERBvj3BRs28n/KcOXwzD9UY1GqUElk8fkeikPUnBiInFZldZn2oFngLwaEXm5NnU0Hpkg0a3K2WYtUBuqJTx4wh1VsPDIVHnox97LoN0RR5eHCQhjfWpdSRApPkv/gK+IwDdvP9ocVnJMq7MmEVcy1DkXLODcLOgCiCbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916506; c=relaxed/simple;
	bh=DSnWQE7w5FHRTPoFKEEPlTEVr028IIf8Lm3EMd/13Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rrW6yKMP4Xv3w5pjB4rIxzcbuF2EYFcgfPe9Qnb+0oHOFj8zAz1daRVndpRJ2NXrnB1YzSH/t3zE8tWWQXkIEgkIZGb9ZsGPCI6E350eHvYpIPz6vgvYBSbKe2lrU9MbT/a10e0CBdQR+Qypc7zLQLEHsXdmGU+NhF4aoHC2NWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=z7F00yhI; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=q1XDSNxV; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="z7F00yhI";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="q1XDSNxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916494;
	bh=DSnWQE7w5FHRTPoFKEEPlTEVr028IIf8Lm3EMd/13Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=z7F00yhIh95S8VySFV61CcOpq0jCFC6QqrdpqOqDIe+R4MSjBVvMVNyxoMD2ycPsR
	 A0fI0p1lbCLKLp0gd8nylfkl8Iu+AnDhzIVrpzXR9b4UKW1XWXPyglm3rqD03jFYoT
	 YT2YMF6lkkoKx+m2PHfY74/A7vygZi22SAsA24dRHhBoDvmcuGPRbdtqpCzG2PspUx
	 Y24gP54KpOZOr3F/82f1dbXCsqPYZvx3YmN0BicDGISMJzyMVGZ7tGXWjBO3nWI/mg
	 xccADWseIM1ggyfRd3irQbt8ZRPjBVn9HoQ9bhie2qFdg1zz7WM7Ez6qmpQMZ+q4dZ
	 Yh0TC/CoZz+eg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A8B1B48186; Fri,  2 Oct 2026 04:48:14 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916480;
	bh=DSnWQE7w5FHRTPoFKEEPlTEVr028IIf8Lm3EMd/13Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q1XDSNxVK5lsKLx2YaR/a4k8egR8C3yGeOpOFb+OV4Fh/Tv9sToOI+yJ9+A9U8/4a
	 NRxA7D/BtyugVGLVxV9Ok9gRUg/9sR/Os9teGvzdiWq3znwH8bkkQSQAEPT2Vg65gg
	 SAmcbYFmkucUrF3Xyk/CvDnG2zSfzRMazwdWblX1pbeWrRAPYwk6H+Q1EN1CL21WBA
	 zwwl0DhXZ04Fgg++Pm6L0kS1ij0FuaZdDpySsizRK90vvBED8bWdGH36AzQQ8JN29J
	 uEX08H27PvhsoBnwQ9F5Jx2sJuLnMQbrlDn6NSql7QdAPoxUuHLQCYqLXSJBTSFpIv
	 cczueajAf7vqg==
Received: from AMDDesktop.lan (p5798b2cf.dip0.t-ipconnect.de [87.152.178.207])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E446048196;
	Fri,  2 Oct 2026 04:47:59 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 02 Oct 2026 06:47:54 +0200
Subject: [PATCH net-next v15 10/13] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-ax88179a-v15-10-131d9286fcd7@birger-koblitz.de>
References: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
In-Reply-To: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
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
index baf91ebee9e35a855b1aa902ba099169277330a7..16b441feaf08f739a5991cb2b7ec8304ec80ec5a 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -234,6 +234,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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
@@ -339,6 +353,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

