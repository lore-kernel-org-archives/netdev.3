Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5F3F076C;
	Mon, 31 Aug 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170893; cv=none; b=smlRV09Qkfxxm14s3Nhjn449gM3uVZVP2eLE1nQ1b4J/gh1Q+2IYTQ7weEaMqoWIR5oFlgkhsDfQY2oqeBpfP3d5RVBdOl+ebN7oOQoi69H4kGs0KsHLBEP3b2YuizToTTt4MYAZqy2HBvQT2sZkng8jGGuS8Zq1ADFjx9EcEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170893; c=relaxed/simple;
	bh=rAVODRDhcET/CUSYtvLYeAVApkLFYcWf0htwDO93Yro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWw5rYkQuXeIFTDK3bi6G2zKzzwPwIMY4sisEgTeSE4G1EPKPlqfQcENI1C/t8WxhSne0d08BXpIJUpqqvE+YAhTzSKqDGmi7tMced25PjDnUSa9n87vDeLIG6nuWafFjdPfvFdrzjEZtsOUOvpV43/RN0XCNu1TVf53zmYoNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WusjQUGn; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WsOtWgT8; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WusjQUGn";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WsOtWgT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170338;
	bh=rAVODRDhcET/CUSYtvLYeAVApkLFYcWf0htwDO93Yro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WusjQUGnRy/ChxO+2o9DBcKwSURM090VRKmGKdNhBowsW7r2c+uZ+omwxdZYlH5pw
	 ocEiipZzrQ1SspVFwQ/GGMJRb5rtX+A9GDGmDr1A5rLO8P1tcbYPB+I6Qdyr5aaGoN
	 idVm0zwztBztRpotqrvAdkzHBLbxmg2Ju/XKh2bqYcuTZqZm354+SxtDbC4c/weu9W
	 Ha3XBND6gx4ZYpXTZ9kdiYk4DPc4GhXhiA9yPWpgM6IQJtlYMUZfYegjd0NZXR69v+
	 1hdkDaQXwAj0VKGsHEoLPJt4Rjr55wUR8mM367FUpXLjvN+vQ7ZFh+ljCwZTERLK9F
	 czqiuAWmfypdw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C37783EC83; Mon, 31 Aug 2026 09:58:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170337;
	bh=rAVODRDhcET/CUSYtvLYeAVApkLFYcWf0htwDO93Yro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WsOtWgT8GJlcKYhQsloDl7VzEO4fV5bX/wU6OHddqw+wfVEGS1yLeghVcXpHkKaVY
	 hrV1gYCH5depi/2yRdhl2QjczaUmDg6n3Hloe/jqf1yg5xQryKU7DXbBVR94ElR5oh
	 0Bzknt/WeC4UPB/ia5AOKfqvLSYn5XkVTN0HvrZ+KDTlhd2ZqIi1pKVmHD4b1QUyiL
	 uufNGhdjgp1+kkhvZ+vKg1zKS9rLSQynOCaNLcnHqbGMwBUcjI5CyCnOXtBinQeH8/
	 YdwJXsZ2wKHWMeqeGHGcqbtDYw57zztggM4/0afPu5z7z1wpE5u9HDScKl9MdAYHLp
	 iLIUKlmUJANbw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C29C23EC32;
	Mon, 31 Aug 2026 09:58:56 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:58:50 +0200
Subject: [PATCH net-next v8 01/15] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-1-de905f2ee426@birger-koblitz.de>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
In-Reply-To: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add the phylink_mac_interrupt() function to phylink, which
passes a link-change interrupt received by the MAC to phylib.
This function can be used by drivers which want to avoid
polling the PHY and instead rely on an interrupt received by
the MAC when a link-change happens.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/phy/phylink.c | 16 ++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193d790d20bf5739965669a7adf654c..2ba1d76872a235b0d75722e059d7fd5e35d3aebe 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1612,6 +1612,22 @@ static bool phylink_link_is_up(struct phylink *pl)
 	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
 }
 
+/**
+ * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Passes a link-change interrupt received by the MAC to phylib.
+ */
+void phylink_mac_interrupt(struct phylink *pl)
+{
+	struct phy_device *phy;
+
+	phy = pl->phydev;
+	if (phy)
+		phy_mac_interrupt(phy);
+}
+EXPORT_SYMBOL_GPL(phylink_mac_interrupt);
+
 static void phylink_resolve(struct work_struct *w)
 {
 	struct phylink *pl = container_of(w, struct phylink, resolve);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2bc0db3d52ac8d51e1180e197e5af9ef61878e06..21f960a827b6fa7786f9e1051942988270f12323 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -768,6 +768,7 @@ int phylink_ethtool_set_eee(struct phylink *link, struct ethtool_keee *eee);
 int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
 int phylink_speed_down(struct phylink *pl, bool sync);
 int phylink_speed_up(struct phylink *pl);
+void phylink_mac_interrupt(struct phylink *pl);
 
 #define phylink_zero(bm) \
 	bitmap_zero(bm, __ETHTOOL_LINK_MODE_MASK_NBITS)

-- 
2.47.3

