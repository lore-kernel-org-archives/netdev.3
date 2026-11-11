Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392862;
	b=nxdfqByT4Wi9iZjULS/xM5LG6aPaUjC5REOQXQ+wCxZtyDsIHpaFHTSs6hHLUxMO82V1
	 foA1Ex04WZRgdH8ZocFol1qlafBwm18Zf/j64JRo/XIyiy21Zs2OYe5NVPZl93wcoVlIW
	 RweUbzduAWXevreAIY6le05J7OBYub4N/bvJg9ZWUVNU3Mj227575CWxXllDPMLt7xBeo
	 /mEBxJ2VHoLOQ+rJ+h5kVEJragUD47b89NSmJpEHuiRKU/7Ej9vVbxC6d2nnEF79Tox3Z
	 I+wLpHDVHzPOeKEnDpPewoTrlgdGk1cmR5qy8Ir0IQaQyMb2lQgG6btNKqAqvViKkrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392862;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lOIbN1WC9f3tYk8ODaLG/icVZKFBVBuOQ0N3217s/zM=;
	b=SbEEHt9igS9fs97wqbaeE9OOJckFLsLy6YYOs3hyF7U8N86NPMYpvrv8X2ub6tKavPtY
	 g6WWTAqlmENeVQhxBCPfNJmv/Jdkx65Pak4YkFtl6vNq/lfqrNPr5dPISqC1pNGzY2ICk
	 c9Zz+JWmUy5ZTm6gpXyDRl544foK7jmYr/j5ZJFuXW/UervrFlMLRS3Meyw1FaioZ0NTX
	 B7u3FuwI3OrA5iUXfOJrBPzJdOWcRO4wCjL4xAln0Dm+03PaX54UbCYzJhpmxdPjULZnk
	 mvGuIB/prNGpVQPwj1Zrj2Ek4RXsDThhz2kmnuGUy7pabfy2DWTxlaWfU+wq4bmm8+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=XWOXunOD;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B4559606A33F
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4559606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=XWOXunOD
Received: from kero.packetmixer.de (p200300c59740DeD843BE7E4A980e9C65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 7EAECFA272;
	Wed, 11 Nov 2026 11:27:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOIbN1WC9f3tYk8ODaLG/icVZKFBVBuOQ0N3217s/zM=;
	b=XWOXunODgWFI2kPC8eaN/q4DOJQzKG3IhUVsS23aG4TBCz151GkJ2Qa6RMoDVkKvkZXDDs
	HA0QKzAcb7SLzUO8D0o/GjHkPZz0IoD5hzMFOLaTw4l22XwqG8D2EQ7P0K3TkjEBO7KPww
	5VPzaYW3C/Rx6G3YlJULZfAJ1GQHKYov6u5bM+zMtS5wBzzU9m1gFM0cmlYEkKFfnhZIlb
	7RBMjv4cNRYallN6FxxcOakSyGGrJbbow4JZq0LbWNAq7v+O/A4Vk0ll5gM8qGNH1iYuEL
	irxwqHKSm1EqKQTxiMkS2K7GN2sRUbAnTY3oI90Kr3ippVDvXqK5/dPkPeTuHQ==
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
Subject: [PATCH net-next 08/15] batman-adv: tt: annotate last_seen with READ/WRITE_ONCE
Date: Wed, 11 Nov 2026 11:27:22 +0100
Message-ID: <20261111102729.2096241-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The last_seen field for batadv_tt_local_entry tracks the jiffies value of
the most recent activity and is used to detect timeouts. These accesses are
not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used
to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 46304069b3b75..76635ae82c84b 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -917,7 +917,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	bool readded = false;
 
-	tt_local->last_seen = jiffies;
+	WRITE_ONCE(tt_local->last_seen, jiffies);
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		if (common->flags & BATADV_TT_CLIENT_PENDING) {
@@ -971,6 +971,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_meshif_vlan *vlan;
+	unsigned long last_seen;
 
 	if (!batadv_tt_local_reserve_entry(bat_priv, addr))
 		return NULL;
@@ -1000,8 +1001,9 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	ether_addr_copy(tt_local->common.addr, addr);
 	tt_local->common.vid = vid;
 	kref_init(&tt_local->common.refcount);
-	tt_local->last_seen = jiffies;
-	tt_local->common.added_at = tt_local->last_seen;
+	last_seen = jiffies;
+	WRITE_ONCE(tt_local->last_seen, last_seen);
+	tt_local->common.added_at = last_seen;
 	tt_local->vlan = vlan;
 	spin_lock_init(&tt_local->common.flags_lock);
 
@@ -1477,12 +1479,14 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	struct batadv_tt_local_entry *local;
 	struct batadv_meshif_vlan *vlan;
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 	u16 flags;
 	u32 crc;
 
 	local = container_of(common, struct batadv_tt_local_entry, common);
-	last_seen_msecs = jiffies_to_msecs(jiffies - local->last_seen);
+	last_seen = READ_ONCE(local->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	vlan = batadv_meshif_vlan_get(bat_priv, common->vid);
 	if (!vlan)
@@ -1815,7 +1819,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
 				break;
 
-			if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
+			if (!batadv_has_timed_out(READ_ONCE(tt_local_entry->last_seen),
+						  timeout))
 				break;
 
 			batadv_tt_local_set_pending(bat_priv, tt_local_entry,
-- 
2.47.3

