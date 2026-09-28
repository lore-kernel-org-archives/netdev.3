Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F83515F7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571065; cv=none; b=txcKccYKMEWdBHO4Ukr+cSPiSDi2Mi+nf5jesStbB3Xy/zCxB4G5yAfMbxk88/yIf5GSC7i8W0tKmmBaKxqYKroBMdzY+0oNWPNZfeU5SdqzvD+r441BLm5cHC9hAJ2ztaNmNnnfazINJL6P9s+ymuy8v2KVEz1DTJxNSCab8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571065; c=relaxed/simple;
	bh=Mu0frYNG961E9MrWNHyD/bKWnVTPw+zQgOncEvVsdog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVYocIwyrDNsP8kqh6WgePwhq98pywXzbl5ad2YEEMFMT9Rf4CyFOYGTQy69JpHMS8MVq3teLqDXnC5Z1HbsWgXAqjo2rbC8naRxOUmldGE4x+d9u2pvBqW4zydeGHYqSLmixTSNSzzP1z96Cmk2lP7m4MJwy4A8KW8dnAw3M80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev; spf=pass smtp.mailfrom=q-lab.dev; dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b=qecHHOUg; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gnoMyJBV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b="qecHHOUg";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gnoMyJBV"
DKIM-Signature: a=rsa-sha256; b=qecHHOUgZgMmKF0IPDu3rIqFJjD3pXSGbH8z3eZUbIAn0TrG9Yvf+KTmhNq5h8lP+hNIlIwFo+h2QwX/BiFmkhaRS8gAF0ouCRzsXqvRg+AyRAkfUgSulNhbpC/IASjcsPytWS4oBNSe49fBa96srIqn5qtZLyxW02yygaY9NLVeg1k+P9y87PdcsTiH+HNYIFK1eKiwouOuNb9opAvWrd2G18so1I9GkaHcTmzSgwNoFD2i86QslbRNA+O+eTh+Uahp6o7PADjD7OKIARsFcGgajVuAtV9C2Ffw3/mKnYYQAAnag9vqXSivdNJL2dyzjIp8B5iE8d5DaBjWKz29cg==; s=purelymail3; d=q-lab.dev; v=1; bh=Mu0frYNG961E9MrWNHyD/bKWnVTPw+zQgOncEvVsdog=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gnoMyJBViSkQkc0uFtQBajT/CsFyyTyya4bYrQ9S8PtiYxetZYqSeh894wyVmjAAyYPN6t6y9LaDBxCnuraRXlIGKeB7pNglgjlUjhb2kom6NuK6HHuhX8FEKipXrFFHn9N5sHBEU02sCdrzFp8gZIaX+74a6qt7fPzY+361n3qUpG/qr34X3ya1u4sr0affnBxLZsJAt53dOKoToagWdvz3Tfw5pK9rpT3bU6qDOpeH/p3l+Rh3/TuEH/6G7K2Ro4PPBSYxGQxR32tRgTkG4IvTpvYJW5mmIZGdPO/zk1alxYitKQaqWpRJ1s0vFAckjHoAx7KuFTz0o8Bex7jzXw==; s=purelymail3; d=purelymail.com; v=1; bh=Mu0frYNG961E9MrWNHyD/bKWnVTPw+zQgOncEvVsdog=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 284201:25281:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 46625648;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 28 Sep 2026 04:51:00 +0000 (UTC)
From: Quentin Freimanis <quentin@q-lab.dev>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: sparx5: make ports inherit the switch base mac address type
Date: Sun, 27 Sep 2026 21:50:12 -0700
Message-ID: <20260928045012.30178-1-quentin@q-lab.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

When the switch uses a random base MAC address it does not mark each
port's address as random:

  $ dmesg | grep "MAC addr"
  sparx5-switch e00c0000.switch: MAC addr was not set, use random MAC
  $ cat /sys/class/net/eth0/addr_assign_type
  0

0 is NET_ADDR_PERM, so userspace thinks this is a stable address. Fix by
tracking the base MAC address assign type in the sparx5 struct and
applying it to each port's netdev.

Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")
Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c   | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h   | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/=
net/ethernet/microchip/sparx5/sparx5_main.c
index dad713e9ddd5..b530fb6d3d0c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -898,6 +898,7 @@ static int mchp_sparx5_probe(struct platform_device *pd=
ev)
 =09=09dev_info(sparx5->dev, "MAC addr was not set, use random MAC\n");
 =09=09eth_random_addr(sparx5->base_mac);
 =09=09sparx5->base_mac[5] =3D 0;
+=09=09sparx5->base_mac_assign_type =3D NET_ADDR_RANDOM;
 =09}
=20
 =09sparx5->fdma_irq =3D platform_get_irq_byname(sparx5->pdev, "fdma");
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/=
net/ethernet/microchip/sparx5/sparx5_main.h
index eb57b86fbe22..0f7d8440f614 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -392,6 +392,7 @@ struct sparx5 {
 =09struct notifier_block switchdev_blocking_nb;
 =09/* Switch state */
 =09u8 base_mac[ETH_ALEN];
+=09u8 base_mac_assign_type;
 =09/* Associated bridge device (when bridged) */
 =09struct net_device *hw_bridge_dev;
 =09/* Bridged interfaces */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/driver=
s/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 4dedf5d92641..b3725cf2dd44 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -294,6 +294,7 @@ struct net_device *sparx5_create_netdev(struct sparx5 *=
sparx5, u32 portno)
 =09ndev->ethtool_ops =3D &sparx5_ethtool_ops;
=20
 =09eth_hw_addr_gen(ndev, sparx5->base_mac, portno + 1);
+=09ndev->addr_assign_type =3D sparx5->base_mac_assign_type;
=20
 =09return ndev;
 }
--=20
2.55.0

