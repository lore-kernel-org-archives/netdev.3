Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CB49CF55;
	Wed,  2 Sep 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368254; cv=none; b=D8XY7Rw7lLNTGkLMOpBhAmHi4X0WWaEDVS8lwIlzhxCVXCclemT70+BB382Q9zF9kWboGErzxRgH/Y+erK5tyiPp6PRoFdVDPSpUxgX/dt85oGg6lEqVqG79Zo8cGLcjdfmPi0+c064gSCvwqczaKkR1VLtIuNVCronW0OdBw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368254; c=relaxed/simple;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHU1CLUmPQ+fTvdoekEc8wx5gRDDZhZTBF8q+UhfBb0B+v85vTc7GVQrtaAIZhDQRZbhTAeXHyuwI9T7nlFzzDbgrAVTRbKBXeiyuro66zw6Cfs5oaJuCYFojy6+ziXxNQuTrbftN6bglrFxPUJOz7Ymtjpf0HjexyI/bM7Kw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=oDk+9SLL; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=nt7MHwgR; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="oDk+9SLL";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="nt7MHwgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368245;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oDk+9SLLCd3VxnMKeypUgMXe8ptVKp1tzAY7nz+pqJEEw+3UVRLeuucXks74wdQ2/
	 lotKto11oXTNY4n5c6p5MGCQyHKcITlmEBgZh4Whf4YDJOL223dx7GUxbt0sWpo5El
	 r0UYHeGYJEEzsaP7IwoMdmoW4tP9ndgp400EBvuDNSJix2PNRKzU8PiGpNtYcWLMVF
	 ju1LWA4Eb4748Ag7/w9tAJVRcgpYN9qdMvrey84PbmdTLmnsfQBpNPIF3KPFvoysmi
	 JGEjYMSMM++o6zl17tChe/d+lGd7McgkWODPLG0nblIrEc+Lf6uhZaIBVrJ35J5yBQ
	 5iS/m4EM+OqQg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 65E213EF24; Wed,  2 Sep 2026 16:57:25 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368243;
	bh=73U+Om09CTj2ym0rVGjPeN4Mm2JBCPoUyOCgnLcEhPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nt7MHwgRifATtn1pL7f+wC7891cAi5wJ/VAzJ/VdsmsHUEGFuRnlduAAZq1ai/RA6
	 TMb2NKlF60bEXL/4LiyfumSZ6AQyEXEYuioK8iesASMoZW+4Bz8yG9xge8bT0HrIkW
	 JQdxLj+kAGsTsOYbrcmjaqCIaO6XdQQp9puwzNrprUKvJY6CEMZQkc0UOTbzULmIAQ
	 Un+QXi5MxkZ7booe6Ph9QtUvEKR3rKl+2BACi853a3ew+uMdjBD02vXgAPedyCgZnS
	 25r9gYDv2qnEBn9aecPGk/T5U02q71mQL6Jd33hfZGyf6Klbpft3oam/8PweqFs+yw
	 fJabvpL1KMCLQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 599723EEF8;
	Wed,  2 Sep 2026 16:57:23 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:15 +0200
Subject: [PATCH net-next v9 01/15] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-1-8e6d7710a2ae@birger-koblitz.de>
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

Add the phylink_mac_interrupt() function to phylink, which
passes a link-change interrupt received by the MAC to phylib.
This function can be used by drivers which want to avoid
polling the PHY and instead rely on an interrupt received by
the MAC when a link-change happens.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phylink.c | 16 ++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3ec3bb43910953f3d57a4601633d0c3be65e959d..96ed13458e9f399fa911a145613d213b1c4433c8 100644
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
index 1dda5c7ed5f146930d1acc6f06072e6755167af6..f6c1db837fb5062c6d42ffc6489ec06ae84e535b 100644
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

