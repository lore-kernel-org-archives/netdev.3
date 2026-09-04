Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DE3BBFDB;
	Fri,  4 Sep 2026 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542936; cv=none; b=kYTZ+NaH0s7j6oSI/9lVThUDBPo0B6baY3+FuCvoqNoJHSpjmOxypqvZ9FJIiNQSE++ZB3tNZBv2CovM/DMAkFP6aEbxmy2f5mn6n70uF2N9dIenxA6X6bDmDx3eaPEWe2Af+l6q/zx1wGycx5jtO20MKIMW5EU4Y6y2uIvJ1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542936; c=relaxed/simple;
	bh=aYulhTCEirFYn9qXiq+ayODNlE/zotCF4oMEfNcds8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fj1RjRSXeG+FJ9BvWz42mN0PNvMr+wvAEIp7Q5tJxPAeCX8xUA0lu4PRfp0ApTAIgbVfbyNGdlH+xhNHOahDUj8oNox8gwy9xry/ojbWlWaU6kX3DzuYeIWLubb0bJ1QP5Idi3091MCyKGCbgYsPIoqJpFToTvaES00jFj4Y6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=v3QGcHZ3; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=O+815+UQ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="v3QGcHZ3";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="O+815+UQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542925;
	bh=aYulhTCEirFYn9qXiq+ayODNlE/zotCF4oMEfNcds8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=v3QGcHZ35KfKhBgNlK0EQxyAWmwkDgPV8c1rWg3wuxJSuUSF64X2pEG6aKCLkCkKT
	 AZ5O9BAdolGxMUF0OiRqIaBgTfLoUxGl9JAD8RZfkfjdRdcDiY7nqJWl4Wb8RaXJG/
	 Y0QrVb4ydB+I/awOW/7DvvmJfk+Hpt9bwpSeXQkDzn+77VN0sVbol4PIRMfquWWkqf
	 APVL9wCKJNd2Gg6mUJCEGp6ExrzqPDZOk2UlUiBCf2FCSLVoUzvAJpBzsvm5xs2REx
	 zFOGKUPaQ+abMIcl8mlGj6x34Cf8QWSK5z177TObYenWZDtgcx7T6xR2zscyy8SBaB
	 RTq9U2y3KzIUw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3648D3F0F0; Fri,  4 Sep 2026 17:28:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542915;
	bh=aYulhTCEirFYn9qXiq+ayODNlE/zotCF4oMEfNcds8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O+815+UQQLRYf2/uV9Y4T6DM+770GwFM6bIqdf2qTZ9snh9vTI9ONMRiulfklpxiP
	 AUFxzwZ3wu/TwQKZG4LpWL1gnXwNw5ZYYAuXb3lggY0Qtd0ugOIVIRxmIxd4GW+9k/
	 n19h9cUyI4ZDZBU3ybF1G+iBCpaqjiM0qHjeAbJNzm3oi2WsbKRR9wr26uSHzqvfbX
	 FRMp8VOt6ippnz5YWH2APbA5ewrLj0IIZ9oOKdMbNy9b7nt1k5woySXXslSFVB5cMB
	 a2PUQICcAs+4ZbnPUxf/39J/NAJ+4qkSU//snLgAu6pO5vnv7YY3KydPdGk44ZzPO6
	 XRFkkcn16IbOQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7B36D3F0D5;
	Fri,  4 Sep 2026 17:28:35 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:32 +0200
Subject: [PATCH net-next v10 07/15] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-7-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for this EEE enable/disable register and replace the EEE.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index c1646c63b0785db15506f488580779ac0a087a6a..6cd9bd6197280e8cf56295b8de4f6a19112092c5 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -384,10 +384,27 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
 }
 
+static void ax88179a_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
+
+	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
+}
+
+static int ax88179a_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
+{
+	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
+
+	/* AX88179A does not provide LPI timer registers */
+	return ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, true, 0, NULL);
+}
+
 static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
 	.mac_config = ax88179a_mac_config,
 	.mac_link_down = ax88179a_mac_link_down,
 	.mac_link_up = ax88179a_mac_link_up,
+	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
 };
 
 static int ax88179a_phylink_setup(struct usbnet *dev)

-- 
2.47.3

