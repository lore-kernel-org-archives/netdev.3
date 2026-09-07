Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6638F3CAE8D
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769116; cv=none; b=E0KQJ2t7qZqhWpfRbi7AYpSI8hAHS9ihNIsBsXuH+EhdK1EPVDb7Ewsivdp/jpuDL2tCNA1aN9tT7QjYDXI41S8xHe+YgItWkJpdo2YgqzKQC6AU74JwjcKZeQNZnY4QYqKdyiLVF4vOnHAxVsH/tjJanSVp+WweGoTAjm8rAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769116; c=relaxed/simple;
	bh=cHaKNcEM0ptzXaTIE8Tz33qktONuqUY9B90RCS+36ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eon10loNfNtWVrC2cG/MIOExdu6brGgkk4Vf7GFaOFovDiXCRPw6WQyYvxG8tpCFFP2gfVgmCI0NZ3xdN2YEYL2L5La4iFLDBjgxLTtJLXPOWF38Rgr0pt92UN1tz1u78ZvxwjFnq2z7bxKSemnF7gRed05BL+IAhPIuFPDfuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=RaceJ/Mt; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="RaceJ/Mt"
Received: from kero.packetmixer.de (p200300C59748D0d8C3747188E6DFE6c0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 76A18FA039;
	Mon, 07 Sep 2026 10:18:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PosylnRdopBGGbUx4+CxBeYiMFQkzo2EZ1jdqvLtlIk=;
	b=RaceJ/MtCpQ9FxDp0co5fyGxRc6GljIG2OMNq9amuStL0VaK0PTzmSj38uD2SN3C/nm2Id
	HJ2EDZSTCb2cQ7RttsKDIz9Q+n5J6lZdRaloP6vJvGi80HFda4PIavlZ6lGUKlNbCD7uT0
	VCm4Bpsd6+zmX6WgOBgGddAbOC0zwUHqe+dnW3Jvs3iWphNVpJXRwTNNezQTiPPPWghAoZ
	h9O91i5VvnZQRsmOkpnNuYMe5CweTq9vXbhh0ED2e1kU2wHjG1qrkAsW4WDYMhjWl8omGD
	Bviz8yzdq3BDjpQIkMA5V1L7c7EcQriFDpmPEkesw/LxglKzUeWkUUCuvuH3Gw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/15] batman-adv: tt: look up wifi state of incoming interface in helper
Date: Mon,  7 Sep 2026 10:18:10 +0200
Message-ID: <20260907081824.2474040-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_add() only needs to know whether the client was seen on a
wifi interface. But it kept the net_device reference of the incoming
interface alive until its own cleanup section, together with a "net" and an
"in_dev" variable which are of no interest to the rest of the function.

Move the lookup to a small helper which acquires and releases the
net_device reference itself.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 41 +++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 44a8cf89382c6..1c22db348267e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
+#include <net/net_namespace.h>
 #include <net/netlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
@@ -693,6 +694,32 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 		batadv_tt_global_free(bat_priv, tt_global, "Roaming canceled");
 }
 
+/**
+ * batadv_tt_iif_is_wifi() - check whether a client is connected via wifi
+ * @net: namespace to search the incoming interface in
+ * @ifindex: index of the interface where the client is connected to
+ *
+ * Return: true if @ifindex refers to a wifi interface, false otherwise (which
+ * includes the case of an unknown or missing incoming interface).
+ */
+static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
+{
+	struct net_device *in_dev;
+	u32 wifi_flags;
+
+	if (ifindex == BATADV_NULL_IFINDEX)
+		return false;
+
+	in_dev = dev_get_by_index(net, ifindex);
+	if (!in_dev)
+		return false;
+
+	wifi_flags = batadv_netdev_get_wifi_flags(in_dev);
+	dev_put(in_dev);
+
+	return batadv_is_wifi(wifi_flags);
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -712,12 +739,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
-	struct net *net = dev_net(mesh_iface);
-	struct net_device *in_dev = NULL;
 	struct batadv_meshif_vlan *vlan;
 	bool roamed_back = false;
-	bool iif_is_wifi = false;
 	int packet_size_max;
+	bool iif_is_wifi;
 	bool ret = false;
 	u8 remote_flags;
 	int hash_added;
@@ -725,14 +750,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	u32 match_mark;
 	bool modified;
 
-	if (ifindex != BATADV_NULL_IFINDEX)
-		in_dev = dev_get_by_index(net, ifindex);
-
-	if (in_dev) {
-		u32 wifi_flags = batadv_netdev_get_wifi_flags(in_dev);
-
-		iif_is_wifi = batadv_is_wifi(wifi_flags);
-	}
+	iif_is_wifi = batadv_tt_iif_is_wifi(dev_net(mesh_iface), ifindex);
 
 	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
 
@@ -881,7 +899,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	ret = true;
 out:
-	dev_put(in_dev);
 	batadv_tt_local_entry_put(tt_local);
 	batadv_tt_global_entry_put(tt_global);
 	return ret;
-- 
2.47.3

