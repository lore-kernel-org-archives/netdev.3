Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E307E4F7986;
	Thu,  6 Aug 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044986; cv=none; b=FY3wnVCTs3eWMvKLuidZt7n7Cn00gQlozt7Zzq4E00pm0XvnQbXPX0hLYQg79rfVqHk7BH9G1wiL6Tz6rKyJX7nw6nf7b0v6/BLrt9tXwEoaoTsA73+13TvbYl4MCBnbfNYdyTVNfjKb35O/m3WDL0+u5RafX/falhbw8vKKdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044986; c=relaxed/simple;
	bh=nppdL4+A99MDKnuJZ3Tn9eB1KxODQRtMe2SJk6KvvGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IONqQ51LwOtt66Ox5momlfyqINDDtNSjO8DoDzAyx4VPmMAkXrJmbLrYxLiFq15iSrElQNVHAU9CMWhYAj0bPIe9ibdq0zdMbsle2KsVHmu669YwnYeUq1r6IyDlNr1z1rfp5/eIwmrfav6tYD30uW2VRdeZj/e3BKoTzluWSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=un45O5vO; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=MeeYzNnM; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="un45O5vO";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="MeeYzNnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044983;
	bh=nppdL4+A99MDKnuJZ3Tn9eB1KxODQRtMe2SJk6KvvGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=un45O5vO0VAoVWJeIDr/lWZndxBMmK1l2Zg+EvoNC+o+4WbiaKW09NxE2FDQ+bgPY
	 Gww2oX75nWN23kZ6TDbeAPj8nWW0UW3KtHKj5LLVQMa7W5maJ5IH2RSu84gi0s5nMa
	 NjiwcExUCMxfRF5fX/qQMOnOkUT4m14R4KAwH9B0G6eqp4CsCCBHdxK9huPO0dEqIK
	 Uf/F6aX0rsYfIH1JnaVsONGY0qfzHYSUgSRj0kQa+YiESrptr5cywqRbrEBxY1JV4Q
	 hW18yqcyXHlVRAdw6zEkhcHs8qRCfwk6eOJLKEpIfK0O1XIWPxs7bKHr/Xrpns325h
	 LEuJgau8WQMCg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3844A496FE; Thu,  6 Aug 2026 19:36:23 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044970;
	bh=nppdL4+A99MDKnuJZ3Tn9eB1KxODQRtMe2SJk6KvvGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MeeYzNnMizDRs/kU7MwwOEwcoXlQTD5DyOUxz6Kb/qinE0RylueNjohQeGn04yOwT
	 hZtBA2CWsLQdaLS4Ve6Udds3e7YHG5H0LYzTcjfZwOnEakIH1nMdzcLJIfKzG1jjlV
	 9f+WN9Rs4lhKUVfEUyCyb8qc/nqxscJcEQmLzq9gV9ZB7mYo7x4Z2WqLzEFpd1geCe
	 bJyAUJv+HUBYwhDnWy6BE4J0e0q9Tn7lBbU48Xnz7/drSwp1vs0MTUe3cnueglM0Tu
	 ykkBRoucpovRbd77RlStWKC3bb68ykE4lIwcBAfkda9vmcZqWoNm+OKaOYPwUFr3qH
	 eAH+pRgmlLV0w==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4362F496FC;
	Thu,  6 Aug 2026 19:36:10 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 06 Aug 2026 21:36:08 +0200
Subject: [PATCH net-next v6 10/13] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ax88179a-v6-10-fde7414619e6@birger-koblitz.de>
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

Add ax88179a_get_drvinfo() as implementation of get_drvinfo, in order
to provide information about the device firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 8e868613a778c8072d00545e91ebbdf7db4cbc0a..a75133e25f89dd9c8887379a9e5b9b11a6ac2666 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -208,6 +208,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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
@@ -297,6 +311,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

