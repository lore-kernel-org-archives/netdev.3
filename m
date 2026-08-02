Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7D3C819C;
	Sun,  2 Aug 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688371; cv=none; b=NgBH0xfyYtQAZbgQUUh4RRtIKV80CdgnZalJnYG7BzlOBRgA/HT804DuJaK1sG2nNxLoe7rQcqW6xLn3elq5euEybG6r809+aVWw62kGPDk3cb7t7bGNAwYyOzLd07WnooJuEhz2o7qc7h7vs1U856Y/R+ALnM7icn5RpREtAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688371; c=relaxed/simple;
	bh=8icT4J/o3lofd7IFk7tygDgW00qwK7iZKkAxg2q4LnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXDsblBN0lY2jZCbE8aOn9XBMPiXl+UD6suRxcpdNqS0vkvCIRMmGn8VwfQb1qE0DCInKwf3LCT+np3r1XQZN//Pr5qBjZvBBIH7Vn7fVzFuv9DVx5xHGaiWTWCpT7NTMuWM7/6lGLzOeuK/Dpcx3Ph/h9PJ/FZ5aO0cUDEWUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=iJJnrdPm; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=UQ5fcCfP; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="iJJnrdPm";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="UQ5fcCfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688366;
	bh=8icT4J/o3lofd7IFk7tygDgW00qwK7iZKkAxg2q4LnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iJJnrdPmOO2gAulUwyipeXEadRdYZ1okAv7KW/fGuHc6HznMg5FNJN9Au5+Bsvzd7
	 vh4wWERm7iqKK85oJH4XrezARjOGPNOMyJwf014h+p1WaeJKdOZPQ4bzMqnxKwjPoq
	 NEreddvLbvjR7k27v+oElCKVX7pwDkIvSToBukjxAUOLkLmCXWXYcFnYOlMVZmr0An
	 0G53eIetkPtOsFrV+JRwLm2n0b7LrEZVIJBtwkfKYqMQBn2kik2T5wg0DQw1vIPjhJ
	 DvLenNvRUcEv2gman+CXbW8j5bxgTtav6Vb6ZT9Ap6Q+9sUEUpt8imnSuVNQ1kQgtk
	 8Q/8oiCLYMN2w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 55FBE49658; Sun,  2 Aug 2026 16:32:46 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688357;
	bh=8icT4J/o3lofd7IFk7tygDgW00qwK7iZKkAxg2q4LnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UQ5fcCfP2JJYwfAP9/QYNZWcP5r/zmFHYdIIHhx9RmfxW16CSNcVjtpRZ0RN4QsFs
	 78gUS0jnOI3ikhdpRj/U6DqySKFKXfNJ2qHavIwSD3/519AUNr5JJOUgG4/A+blK3X
	 htqvGXRYQTU943ffycqaHLkznLHYqtlgeeNs4XJYAPsdfOx82M2x8aB3CmRql8fEib
	 1Xu0s/J1msmiXeM/TY+h0uQd5ws7PINFY6U3qXlAF2+4C0pY+EwR4/jx7YAewxrmAU
	 noGYeGiJxvaA/63CMcWMjs2ZDyCEynIMIBdhuON/JsQujPgPhI3ecr9v4vo/HNkp3k
	 ETfw6oT5Mplzw==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8F62449654;
	Sun,  2 Aug 2026 16:32:36 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:32:08 +0200
Subject: [PATCH net-next v5 10/13] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-10-dcb9fea4acd4@birger-koblitz.de>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
In-Reply-To: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
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
index 4a3c2e77b1baba7e0c5bd5425179dfd1180b9b09..37a55ff5464c6569ac72901378763ca419dd306a 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -201,6 +201,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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
 static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts)
 {
 	struct ax88179_data *ax179_data = dev->driver_priv;
@@ -310,6 +324,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

