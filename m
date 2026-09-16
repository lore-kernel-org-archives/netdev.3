Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB363BED71;
	Wed, 16 Sep 2026 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529118; cv=none; b=mkvKNduwKuhlY7m5kH669Fgv35btrxpGbdxqYdr8sbA3qc/tB9wFRVcnJyqIAY1oOuPXkQEVdrDMo6TOvWU1/dyZ4j2lQcaTxX7muYJI/o8/sO6ulG41jqabEKF3Xj9EptajxgyVN7AOnSP0RVKaxzpImIgEUkoN4t1akfyLFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529118; c=relaxed/simple;
	bh=UycHjv35v2b8ptI4Xk7Ev3ErbXHCmXL8d3dB02epejw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chGh0a2rXZpJ3dyhs3kKIk1VjEtHvrX6bDwxfG9OIi5Yhew3irXtJG1KUzZCGoLPNCFLa1FY4sFrqpvrEWCT6GdTZ/Z2d+mVELK9bF/GVZk/OPecQ4zH6sIjpcQ/uo3aXvFogrr9MgXfxLGbrPA29xNFIz2YcohrFNEcw+BQmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WVQiJjuV; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=c7W00RaF; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WVQiJjuV";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="c7W00RaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529114;
	bh=UycHjv35v2b8ptI4Xk7Ev3ErbXHCmXL8d3dB02epejw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WVQiJjuVajHNg0BYwhHny4UNW4zzXQ77xwGP+yIAhBe3aEAMdserLgKHUZF7BhB8T
	 YDFBe2J2RLYd159X6Mf969sQpcwGE1kVZsNtfdv+fWBcTL7wUDWiK/JTPIzCSu2Wzr
	 y4S7rmurtsAKkWGWNrzwnWUje/oYn95/bvbd96Y9SEdybFL62kTL/MJvOTtcYxSNIU
	 RFRCUm0W9ebAGYAVmWNZQoRyAzvAI2ykV5gcLtuvfF0oRYzFJBxRcjglFoA/YLy6Xs
	 /TIiAYpOdkDgsgEpzFNhFEpex5F6Mgc2GuVCMpvxP5+0OTD8AGAnmPM8x/93EGDiN8
	 41KF25Aq28g4g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7B07E3FA75; Wed, 16 Sep 2026 03:25:14 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529113;
	bh=UycHjv35v2b8ptI4Xk7Ev3ErbXHCmXL8d3dB02epejw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c7W00RaFaL93qT009+pkM8hkNJKvyzAxk2pGQ5A4uwRCh4D89Z+lC2rkQbSdOkn+6
	 YUWOGNcADeveT/sXSgmibzgp4acp4/BmLcg8he9Y0Q1rMnlttg6ZjaNRLU30VteuRb
	 YLAw8ymmAUm7WvasiQVXP334+oorH5W9pdN9eO/LJz/WgqoZXo03Jb2vfUlvem+eQM
	 x2IrPpO/YhjUxQ55EB5ibIHS2c+hkc5Ye2iRu/jDsJHeuejxq/eArhzYDjM3CAOLWm
	 RyR4oh15iqbuDydlltu2P33r/YmMYOyaavimVtZ8tUWRmsUhoetlzZP4OPiCIcw31O
	 izmfHftUgBGBQ==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id DEB9E3F6DB;
	Wed, 16 Sep 2026 03:25:09 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:11 +0200
Subject: [PATCH net-next v12 12/15] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-12-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
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
index ff41d20c219d46392c2633a1eaff021385490b0e..6225b88681e623a570cf75aef8d10e70d3ab2cbf 100644
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

