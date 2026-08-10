Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3E37DAAD;
	Mon, 10 Aug 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365234; cv=none; b=JjWZKPzXFezymGIzspMcNAJuAK6JBHsyM/bT31dqPNlzpCBynIw/N9HtaeGQf8tCd9MLCN18KoQYmJp1254bBrAPv2KzoUQU7kLI+0J0VIhLuVZ76MQ16H5fmnhqYN0xZ9s+SwOkgUd4y+i57VUO6aTELnbxspcIaqoIwfE/DlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365234; c=relaxed/simple;
	bh=rAVODRDhcET/CUSYtvLYeAVApkLFYcWf0htwDO93Yro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVD7MltAFCVAQDMAhUFmPeSkjLnmgtx8tvZcYgMXSKLTdRDSBm0ju0JxEyFCuKzCjxbE2tnWb9297dVkFKDqn7MobBCt69qCkENDeYyeJ5HLqckJnNcRo66grJ8qPBQW5NMqtti8h8//rhhDoQA2oPbcGZFChPVjXJJis9UG+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=GoW6Kxf8; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CUxTLSgu; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="GoW6Kxf8";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CUxTLSgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365230;
	bh=rAVODRDhcET/CUSYtvLYeAVApkLFYcWf0htwDO93Yro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GoW6Kxf8BLYguhSeT0VLMzPY4PPCvMsw/c7lKk00nYDVlQ6JendGVKg+ub0BC3eOm
	 EGArXN7QG1QOz6NmlNjlzXPd0zN1E9p6mXOffoPynSdAR11WW0QROnTc7KMoa57OI7
	 lGLx8P3kfVKrBNC0wfhHKtvmNc+FDL3hIC++5dhkJZZ5d6B8mmDZ3ofRdcLF3tnxlW
	 czOUGLox+T/mC/k60vmggsmhjUYIosUuSSmRG3fJ4HZFbGBj2ocA3hbPGDwNUJB46B
	 2fvjcd9+69i1K+9yJbiiiq57JhMO1A7iw5f8xtJFSWGVww3oeOFC+awU3xM1QjLBn1
	 CTYIrFnYdtNTQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A6A1B49781; Mon, 10 Aug 2026 12:33:50 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365216;
	bh=rAVODRDhcET/CUSYtvLYeAVApkLFYcWf0htwDO93Yro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CUxTLSgu3iUq6umLZLISSRGSb1APD4t5UtQKua0xdOzX2/u5YctsHDpIkAb+wBoMe
	 26J/N3byuhXA2BvhdDjvVlYi5TC6Zd7GvIcjZshZ8gxS/2zrQquRpU7OK+tUtjcH8A
	 YXEmUPcqye+MPj0mZJkwoZ1QopMPdFFkpPSko0bzP4L6p1o9LbLOyahSHub30QDE//
	 P8Q7WxJzjmHmZTZ34HVhe3KDL3ZF5UNn539UJHC63WEurLH+ZK6B8TJ6l9VT949fhY
	 ZHV/Eq3ePsgyn/5rTs7KZ4KV2dX9TLP9zSjxBzmr9GnWbIc/3yP0RPGRirBPxgG2SR
	 QxC1QhpZ08FDg==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 263C44976D;
	Mon, 10 Aug 2026 12:33:36 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 10 Aug 2026 14:33:26 +0200
Subject: [PATCH net-next v7 01/14] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ax88179a-v7-1-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
In-Reply-To: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
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

