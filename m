Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848B35DA40;
	Fri,  2 Oct 2026 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916488; cv=none; b=pdfMigPpoUXdmdiVu/MuUiGDnABMxsOuW5opsXIs/YCaJ5+jIb0gCkI6RJQ5yQ9COeYmoXZHkLf37yW5Skw66lcGkFSlJQBSXVtp8+0V0FMmFi1vLiN92X834RjjMNGHQs/awCEXONdD5WWmoz0F9ctFVP9boPayGvbYX4P9EqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916488; c=relaxed/simple;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clgTXR3T9ITj+t+96ZKinj3nRw9g3W0dW3FQSzp3gU83C2sGnFMbBKDn2Dy4QPjHWhWO5doK4LK+bUH6sxdWuNeAntBjZ9PgymhzwCWrtfVqQQhVSiP5kwxxrhpOWLJEi5wcPoS/g//I4DgN86g6TIRxKzYV16w/gDID8kZeso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DdKhufxd; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EKEXRgX5; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DdKhufxd";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EKEXRgX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916480;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DdKhufxdfGcru1fEXBhCsjQy2Ky1SIcXlOVLxZlhSh7MmrQMRSf+W6kTX9nCJBnpD
	 qzyuXJSgd7H3mdWQB2ZpKcVS2iFEayBbxlYgvx/cWruIJiCwr/gfQjxHqdSnTcGkKf
	 BlhNfNvR8zstuSabae7SVBAuoxMyqnmqo5fA6X9ZnlT3yPEdt+nei1C1xu7OivuD7j
	 YB2w+XSu9z57w3etmTylFKlsFCFJx0BWcTMn5E3qkhOKdt8eJOSrGvb5+d9d1tMN/Q
	 9jUQLygU2tZq6BT05zplSwQUfjk3fQ7xM/xezhHWCIYAefGkn7ar8o1BWMNqZeRhPt
	 pjZQAy/bt7oaQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 49C81481D9; Fri,  2 Oct 2026 04:48:00 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916477;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EKEXRgX51bCVGFJFxV1ulY3AlFkrEnlcJDlvK+/4L3OLIo1Rdeob2jb0hfpBpytta
	 DX2OeLaW8ijoNG7LraZwm2YHmf+696Q4XVoElmB7DXHanYr1vezzzRheSExl3hc8Wc
	 Q3gmQEH3cnYFSAUxCUyk3StilzKPx7xP4kXlYlkH059evLasT4d8nuVYh+r7ZCopeS
	 1UMQCWlAEk8kilSolUIdys60gUFiYtbxgI9oeI9aeZjs/XNfvpCaH201Lf5ZpqhVY+
	 7w8KUguyFdFzcDz1JYnjiEsmSx5S+ZLvOkS2ILZz8JmvKutL2p99P6eIEAuA1rzzFP
	 CuJleOKbrJmxA==
Received: from AMDDesktop.lan (p5798b2cf.dip0.t-ipconnect.de [87.152.178.207])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B1A0147DF6;
	Fri,  2 Oct 2026 04:47:57 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 02 Oct 2026 06:47:45 +0200
Subject: [PATCH net-next v15 01/13] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-ax88179a-v15-1-131d9286fcd7@birger-koblitz.de>
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

Add the phylink_mac_interrupt() function to phylink, which
passes a link-change interrupt received by the MAC to phylib.
This function can be used by drivers which want to avoid
polling the PHY and instead rely on an interrupt received by
the MAC when a link-change happens.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phylink.c | 20 ++++++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a7d086cdc9b2516571bbcfbc3bf3fb37fc4bf6f4..a3ca7993eb7e0090941843194ca1b924cf8d9e89 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1612,6 +1612,26 @@ static bool phylink_link_is_up(struct phylink *pl)
 	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
 }
 
+/**
+ * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Passes a link-change interrupt received by the MAC to phylib.
+ * This function may be called in interrupt context, and therefore cannot take
+ * a mutex. However, it is safe to assume that the reference to phy does not
+ * disappear during the call, as only an SFP module may be unplugged to make a
+ * PHY disappear. SFP modules however do not support interrupts.
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
index 3a88a69882a610afb868b55df6f6e77aea918649..a7b6294cc4a075bd2aaa43ed6484de17a6cb88b1 100644
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

