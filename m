Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F24ACC7F;
	Wed,  2 Sep 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368259; cv=none; b=WLoXGxeonWsQFRb485DXycNjymsLpoGyJuiAfJQTjSsGWJ20KOLTweXiB0TUh+jiwkCJbKWjCcJQJpx3krnWSyuyw/AyMHfkZu/29R0iW8+rQEFiG5WdJCmgvL0n1uyNQPAM2JRfnFcz0pO/mLVQ5n4t6vxeMB0VL3UNRZQmfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368259; c=relaxed/simple;
	bh=TcM51VgpmAtjZUnO2/Vnu7mWxS13rla/fhD6xggxIhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijIv0bWM3PBjok3ohMajuetP3EZvj6PS9pjnHlp7uhdzCaLXssZdXjtFRePN9Ql02OMMwbhSHjTWtwRZFjoaAoiKomGpdMX7+KCv/1vQ+xij0/OoStL/+Y++hB+jOVNi7nVRQNbf07oUxrnnBpstDnUHbwN6JpI2Uq48pvWJTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cCwUnvKF; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VojEyn6O; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cCwUnvKF";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="VojEyn6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368255;
	bh=TcM51VgpmAtjZUnO2/Vnu7mWxS13rla/fhD6xggxIhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cCwUnvKFg9wxjzhB7zwsrtf4sCCvMlAvurk6rHzAqOMXjhHXQg/uEDYKzoXhAWtuZ
	 hFB7mwcDA2kv9/zqyOH2lSpPpttr7xCWVFeKDbDpZL7hOdTejckCXLWJ8XWo8byTv0
	 +meB755yuACMqVVBpFStu2pG643vANPLlNCNVLkb7JHOBLxB+qkk5UYmJYxb9/dVjC
	 dYumofjEEhIIbuoPvmZZy7/iXHW1teivuFF0pNsjbg+5f+fFn6698RS2jB56GLY1Tw
	 GESgFlp86f9edrBiaxc9ae3V30ZKetp+MtJGZP5da5j/rs+yDH7gzDtZEaBQnMt3La
	 C3YdGrzGLn7UA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9AC6B3EF21; Wed,  2 Sep 2026 16:57:35 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368245;
	bh=TcM51VgpmAtjZUnO2/Vnu7mWxS13rla/fhD6xggxIhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VojEyn6O9FwLn5ABXdo8VF3YW8674cVIYy+KNU67nFZC52d3Y5FMeM6FluyEYBytJ
	 IMwerLXGnNf1e5jEoYK23575+mDkie6knoIcfi/tg6sJDeZuqjyztPDjI/yqE3W8V/
	 PLYkJW6hyGvN0aonDdD2VeX7yY/y8ezFKtbeWqB1uvzAV+XE2y154c5usdYJ/oycE6
	 i9Y/4ievAn19g2+stpI0E3VPVc94+Dz/eLuZTa31+P+0TJTuEu4jcCUBT4CydnQ7Jg
	 oLyCc7/jQum4sZKmUYQnsMvwqvOekGsTm1QjOK4+ktH6sYruzw/pUlPtcLulGj/2HQ
	 CDBydLzRlo9SQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 661CA3EF25;
	Wed,  2 Sep 2026 16:57:25 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:21 +0200
Subject: [PATCH net-next v9 07/15] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-7-8e6d7710a2ae@birger-koblitz.de>
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

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for this EEE enable/disable register and replace the EEE.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 57fc70ad704ae6b31c4addc9e8701ee4a7fef1dd..92e1512f62852d7687ae27f97351f07fa13057fe 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -382,10 +382,27 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
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

