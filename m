Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986335C6B1;
	Sat, 10 Oct 2026 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608074; cv=none; b=i16DNVP/eYQZuMpkOY10/o8zLM0ljPRnStvZeBn7tiL9K6Nrwy+mfmH9ZoimIbmeeOoET7dyysrAet2qO0fdPLA7y6H+sg/Vhv3CwlokapmpRRCregGGz5YjRwZQK6Qrmlc1XdturbCEtXz3ZKv5T+1NwAF/wjMfEGAFuTLGt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608074; c=relaxed/simple;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkdDLnMMJXi2L7aFgkvXQn+Ez4adwa1YBqZT1H10FbJr3hv1CHTZ6GVKGl40bAzwd08ffzvSUbyN+n/gCp6Y0LGeeVJWnSXAPGrwXt9VvT8Di+EvPTE1UQ6GIpAAQhP7NVhr6CZJEJi6svwDbjd4J8rqw8q2HP9IAKgLir6KgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0UBNmPTc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Xcyx1cZa; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0UBNmPTc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Xcyx1cZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608071;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0UBNmPTc2OATmBt/qG/m1YsLCufQ6dNhRGMWPaT1xfWSfkC4ne9EXI9ksm/9smHFR
	 kvIi4y5OnaQt0PH6Mb9tmTiEbk4ze8cqm7H3T3O+JxuJmLnWNp3v3ZQTe2uqucbPlA
	 iHpimOzhXwLVTbe9EWy7IQ4RqV4kZ+cfjuKX3bKKzmg8rBUIdO4wN9TTjZYDo5cx97
	 njZN89bPM7RCG55LfFMyUEPik8KC0/QlOdB/q5ueJto7f2VHwNg6EKq82uBBYbKbSY
	 JDlE1C0VIVmeXei4cNP+wXzTrYWXzqeHKvRqXfZkMt6sWTBJWqIqxpK/TbI8ZtZjg2
	 fnvDhOMtpzcZg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 58EE147582; Sat, 10 Oct 2026 04:54:31 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608068;
	bh=X0DTaobSonI/q5DvhIzHNbQTaWz5tCaD+A7zHa+HedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xcyx1cZawN2o+3cdMF4/JST7Mze9nWosDshIMron45rmLusFJT5Ecpib0r1CxU166
	 J61bZnm5DLtNWBl0EfYyUXHDGa9Yka3di5ThwwcUxuckNtHQK5hEloVRbrjnI8+k9m
	 cEIc3ObFZJUodI72ekZG6Ckk1mMEgTDEFh3PpmXC57B7Pp/fhAZA01KeK/hyHSeaP4
	 QhVriae7mx3LnOwQsULQXtKjLYPeA5wuBnI7BUSy43QQL0GwF9+fBhVzjf5RaQmUcp
	 QdxcqjYgekEY5Fd5ftZeBMRiLIU3Ez1aQwPX045+SprUDdqnh1K8sC4XYv1/lS6ZEN
	 xltu+W6TkXKRw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7BD7D47526;
	Sat, 10 Oct 2026 04:54:28 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 10 Oct 2026 06:54:23 +0200
Subject: [PATCH net-next v19 01/13] phylink: Add phylink_mac_interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ax88179a-v19-1-7475173cfb56@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
In-Reply-To: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
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

