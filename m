Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFA9468C39;
	Mon, 14 Sep 2026 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390028; cv=none; b=Bxp62w0q2ctnrSSCCoUwFdbnCXxjwrIYBgq+FbQ3h/gzncj4AH7EGaPAnf1dG0Q3IyTwiLLVho3wTE5kwxolDUlReMC23ZoecyJTzEi4dgzHyMVUxwS0zqcWf+IlRVwpeFUMHY+KuSM9jPB/HTvNI0cxfirW1q+Mrc6FZX5PZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390028; c=relaxed/simple;
	bh=XR01hN0qha4e25EJrk6nIbixH4AgEfBG8zHcvC9OSpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnB/rssvO4udWKIro8Uj4axVMSlE4ttrzUUtupUyLbtcq6PnLbipUlsgCdQZBj28ws65zHLoex6hMor6Nld1XmrJOBUwu9RkG01D6o84Aqks5MGErxg7q8jZoENCGlYK6DmNKLfSH88ZWgx11ty05U4jZT3gRotsWYay/rYa/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zIUAeKV0; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=T29ek7qb; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zIUAeKV0";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="T29ek7qb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390025;
	bh=XR01hN0qha4e25EJrk6nIbixH4AgEfBG8zHcvC9OSpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zIUAeKV0ltV+ZRrVk5RvmLmof4ernRe2ZHttv8yQbebrrUjyafskUxzDEx1StrP06
	 CZljPJvfuDmJA/cjJHFMDXk34Ge5kEnTwLGkyEyZ7XQxIcX/akuNK+oW13DGLUvhYo
	 c6z/t+Pgvuk1QadMxwH7m8X0BUivz5Mwi4eMdyw8wFhbzpn6l4Y1v4vCLSVuorDe9f
	 gDhPK4RP/jX4/KXNuCgA+SH67OvzcgSDmm+NTPXwEuo/6NSu/X4W1sGUqT50a7HemN
	 g+4/4rNRbki30lsZmk4wKmM4EWaLy/13DAiybiihZaJyEp7BKxuB5WcG8t0TgvBL7o
	 ThSOZ8vLMdgtQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 84D893F6EB; Mon, 14 Sep 2026 12:47:05 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390024;
	bh=XR01hN0qha4e25EJrk6nIbixH4AgEfBG8zHcvC9OSpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T29ek7qbk8C30VSUkgLCfhmXQdtrQyzCeOrmXoF8SwEkjwrQbB3ry+Fvju4dAjHTC
	 KURj6jCyFL4iSwVc1n/Ssm7BBKHQ7E1gIpco7fQq/1DLaSQjC00Vk8Jkdrms5TnJiB
	 HI91wx+wf3HH+9OCGUYWP2/hbEchDy2AzdoQlyXIzvPyUAOvUU9GFCz8W5+ZNNTATs
	 1XL1yQcIockg1ETqTclO25IZymY4WRg4jlAqcPqec4gbHM9VzAouSgRy5g+xdSVSoW
	 MGYxyURnOVkeEKKLjNRA8mNHHoc4P/vP3dsiSnHBj12CROMEPNdSCyKvVt7dPkG0FD
	 krDzc2SknVswA==
Received: from DELLLaptop.net (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A82113F6BD;
	Mon, 14 Sep 2026 12:47:00 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 14 Sep 2026 14:46:16 +0200
Subject: [PATCH net-next v11 07/15] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ax88179a-v11-7-5ea7a925ba6d@birger-koblitz.de>
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

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for this EEE enable/disable register and replace the EEE.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 21ca71cba52ca84883a05d8be869115395c82af1..80cabe3557cdef8267c365fccc0bc379936bb241 100644
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

