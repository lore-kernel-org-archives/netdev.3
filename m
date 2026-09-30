Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA003D8122
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761574; cv=none; b=YmLeA7GkHlQgUQ5zsBB7oh4Vvr3oymAmNLH1rWcZKbYRnFy5JU/Y7Y178YVhzVWoTTQvri1tdDEZMqErMFepgTfjlc0hZv9a4oYmgfefAXdI3IdwubJ49Quszkp5bsaOaSReGoWEBvQJ2SdiZa01fFZg8VlcxgRUM+l08CZmzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761574; c=relaxed/simple;
	bh=Uf1pgxi9Y/GvOo5oB6PFkk/m8upzo7HE3SmLVfMWlXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZjIvXmzLEssgGV+TfuJkwT04dsJjIHxvVKLzDUVJvOSnTCEMk3NmZgn6/ciP2HthwAPrtUw9lY+s9UY/xPL4hTUljGuAzi+1HGeVfu+WEbQp2M7PM0QQL8OhlWnCdD5XNNWS9wUYpUpsPJNYYAgjbVFK7qAwb7p/wAeXRh91Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=ctgBmlRQ; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="ctgBmlRQ"
Received: from kero.packetmixer.de (p200300c5970E81d8Cf20e45a7328D917.dip0.t-ipconnect.de [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 61EE2FA25D;
	Wed, 30 Sep 2026 11:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ve/lpZCjWQRCIB2J7HQC4dwF/OKFBr6arbGesv1yjA=;
	b=ctgBmlRQyW4XzoD59JEv6UaqvjKNrN+WOwUc+GzZpA/OjXCHFt7GMLe/zm5W7soU6HoXIW
	IoMSxL5HlYV+HjKc5hJpDsKA06Skz2MHMMfnv4oGB8RnWhlApc2Hh5v8vG9FxbFFJV7Rjh
	O9agTeUjHHNGBH9XAcyL2GFf+5N2/o7WnZ3Ef3Fay0cTk+M0sl00z1BnBKXN6vMfvpAHC4
	NmIhdy830qiAa/SZoty0FxoQNqVQv2nYjiLIheiohi7z0IemJUqSLuAsAlOlRVsw7F5bc/
	X0t4VSDSv8RgIPDbMyxmBvs72ZgTTacyUUbwRVRsPtTITkznH3DTY+FgYhzu7g==
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
Subject: [PATCH net-next 8/9] batman-adv: tt: reject VLAN/TT entries before reaching size limit
Date: Wed, 30 Sep 2026 11:45:57 +0200
Message-ID: <20260930094558.3723766-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The translation table is announcing its current state via the TT TVLV in
each OGM(2). If another originator detects a desync with its own copy of
this state information, it will request a full table sync. Each originator
must therefore be able to send a reply with its full table without hitting
the size limit of this response.

The translation table code already tries to limit the amount of local TT
entries. But the code itself fails to achieve this task because:

* the size check uses shared, unlocked information
* the size check isn't done for VLANs

When enough VLANs + TT entries are created in parallel, then the TT will
need more room then allowed for a full translation table reply. Other
originators will then send regularly requests for a table sync but never
get a reply.

To avoid this problem for new VLAN and local TT entries, each new entry
must reserve "room" before it is actually allocated. Only when enough
"room" is available, this reservation is granted. This makes it possible to
keep the reservation handling locked and therefore safe for multiple
parallel contexts.

For now, over-reservation caused by a reduction of the MTU is not taken
into account.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c              |   1 +
 net/batman-adv/mesh-interface.c    |   8 ++
 net/batman-adv/translation-table.c | 194 ++++++++++++++++++++++++-----
 net/batman-adv/translation-table.h |   3 +
 net/batman-adv/types.h             |  19 +++
 5 files changed, 194 insertions(+), 31 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d89d44706269b..6c54a8d4be3ec 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -198,6 +198,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	spin_lock_init(&bat_priv->tt.roam_list_lock);
 	spin_lock_init(&bat_priv->tt.last_changeset_lock);
 	spin_lock_init(&bat_priv->tt.commit_lock);
+	spin_lock_init(&bat_priv->tt.reserve_lock);
 	spin_lock_init(&bat_priv->gw.list_lock);
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	spin_lock_init(&bat_priv->mcast.mla_lock);
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 63af21954cf90..1ce707aaf48a0 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -561,6 +561,8 @@ void batadv_meshif_vlan_release(struct kref *ref)
 	hlist_del_rcu(&vlan->list);
 	spin_unlock_bh(&vlan->bat_priv->meshif_vlan_list_lock);
 
+	batadv_tt_local_unreserve_vlan(vlan->bat_priv);
+
 	kfree_rcu(vlan, rcu);
 }
 
@@ -614,9 +616,15 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 		return -EEXIST;
 	}
 
+	if (!batadv_tt_local_reserve_vlan(bat_priv, vid)) {
+		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
+		return -EMSGSIZE;
+	}
+
 	vlan = kzalloc_obj(*vlan, GFP_ATOMIC);
 	if (!vlan) {
 		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
+		batadv_tt_local_unreserve_vlan(bat_priv);
 		return -ENOMEM;
 	}
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 481dc6afaaba1..3349376a9087d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -234,6 +234,162 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 	return tt_global_entry;
 }
 
+/**
+ * batadv_tt_len() - compute length in bytes of given number of tt changes
+ * @changes_num: number of tt changes
+ *
+ * Return: computed length in bytes.
+ */
+static int batadv_tt_len(int changes_num)
+{
+	return changes_num * sizeof(struct batadv_tvlv_tt_change);
+}
+
+/**
+ * batadv_tt_local_transmit_size() - calculate the size of a full table response
+ *  for a given number of VLANs and local TT entries
+ * @num_vlan: number of announced VLANs
+ * @num_entries: number of announced local TT entries
+ *
+ * Return: local translation table size in bytes.
+ */
+static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
+{
+	int hdr_size;
+
+	/* header size of tvlv encapsulated tt response payload */
+	hdr_size = sizeof(struct batadv_unicast_tvlv_packet);
+	hdr_size += sizeof(struct batadv_tvlv_hdr);
+	hdr_size += sizeof(struct batadv_tvlv_tt_data);
+	hdr_size += num_vlan * sizeof(struct batadv_tvlv_tt_vlan_data);
+
+	return hdr_size + batadv_tt_len(num_entries);
+}
+
+/**
+ * batadv_tt_local_reserve() - reserve room in the transmittable local table
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @num_vlan: number of VLANs to reserve
+ * @num_entries: number of local TT entries to reserve
+ * @table_size: stores the resulting worst case table size in bytes
+ *
+ * Add the requested number of VLANs and local TT entries to the reservation
+ * counters and check whether the local translation table would then still fit
+ * in a single full table response. The reservation is dropped again when it
+ * would not.
+ *
+ * The reservation has to happen before the related object is allocated. This
+ * way two parallel allocations cannot both observe enough room for themselves
+ * and end up with a local table which can no longer be transmitted.
+ *
+ * A granted reservation must be returned via batadv_tt_local_unreserve() when
+ * the related object is released or was never created.
+ *
+ * Return: true when the reservation was granted, false otherwise.
+ */
+static bool batadv_tt_local_reserve(struct batadv_priv *bat_priv, u16 num_vlan,
+				    u16 num_entries, int *table_size)
+{
+	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+
+	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
+		bat_priv->tt.reserved_vlans += num_vlan;
+		bat_priv->tt.reserved_entries += num_entries;
+
+		*table_size = batadv_tt_local_transmit_size(bat_priv->tt.reserved_vlans,
+							    bat_priv->tt.reserved_entries);
+		if (*table_size <= packet_size_max)
+			return true;
+
+		bat_priv->tt.reserved_vlans -= num_vlan;
+		bat_priv->tt.reserved_entries -= num_entries;
+	}
+
+	return false;
+}
+
+/**
+ * batadv_tt_local_unreserve() - return room in the transmittable local table
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @num_vlan: number of VLANs to return
+ * @num_entries: number of local TT entries to return
+ */
+static void batadv_tt_local_unreserve(struct batadv_priv *bat_priv,
+				      u16 num_vlan, u16 num_entries)
+{
+	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
+		bat_priv->tt.reserved_vlans -= num_vlan;
+		bat_priv->tt.reserved_entries -= num_entries;
+	}
+}
+
+/**
+ * batadv_tt_local_reserve_entry() - reserve room for a new local TT entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @addr: the mac address of the client to add
+ *
+ * Return: true when the reservation was granted, false otherwise.
+ */
+static bool batadv_tt_local_reserve_entry(struct batadv_priv *bat_priv,
+					  const u8 *addr)
+{
+	int table_size;
+
+	if (batadv_tt_local_reserve(bat_priv, 0, 1, &table_size))
+		return true;
+
+	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
+				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
+				 table_size,
+				 READ_ONCE(bat_priv->packet_size_max), addr);
+
+	return false;
+}
+
+/**
+ * batadv_tt_local_unreserve_entry() - return the room of a local TT entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
+static void batadv_tt_local_unreserve_entry(struct batadv_priv *bat_priv)
+{
+	batadv_tt_local_unreserve(bat_priv, 0, 1);
+}
+
+/**
+ * batadv_tt_local_reserve_vlan() - reserve room for a new VLAN
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @vid: the VLAN identifier
+ *
+ * Each VLAN adds a per VLAN header to the full table response and therefore
+ * has to be reserved before batadv_meshif_create_vlan() allocates it.
+ *
+ * Return: true when the reservation was granted, false otherwise.
+ */
+bool batadv_tt_local_reserve_vlan(struct batadv_priv *bat_priv,
+				  unsigned short vid)
+{
+	int table_size;
+
+	if (batadv_tt_local_reserve(bat_priv, 1, 0, &table_size))
+		return true;
+
+	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
+				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new VLAN: %d\n",
+				 table_size, READ_ONCE(bat_priv->packet_size_max),
+				 batadv_print_vid(vid));
+
+	return false;
+}
+
+/**
+ * batadv_tt_local_unreserve_vlan() - return the room of a VLAN
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
+void batadv_tt_local_unreserve_vlan(struct batadv_priv *bat_priv)
+{
+	batadv_tt_local_unreserve(bat_priv, 1, 0);
+}
+
 /**
  * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
  *  for free after rcu grace period
@@ -246,6 +402,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 	tt_local_entry = container_of(ref, struct batadv_tt_local_entry,
 				      common.refcount);
 
+	batadv_tt_local_unreserve_entry(tt_local_entry->vlan->bat_priv);
 	batadv_meshif_vlan_put(tt_local_entry->vlan);
 
 	kfree_rcu(tt_local_entry, common.rcu);
@@ -550,17 +707,6 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	__batadv_tt_local_event(bat_priv, common, flags);
 }
 
-/**
- * batadv_tt_len() - compute length in bytes of given number of tt changes
- * @changes_num: number of tt changes
- *
- * Return: computed length in bytes.
- */
-static int batadv_tt_len(int changes_num)
-{
-	return changes_num * sizeof(struct batadv_tvlv_tt_change);
-}
-
 /**
  * batadv_tt_entries() - compute the number of entries fitting in tt_len bytes
  * @tt_len: available space
@@ -584,7 +730,6 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 	struct batadv_meshif_vlan *vlan;
 	u16 tt_local_entries = 0;
 	u16 num_vlan = 0;
-	int hdr_size;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -593,13 +738,7 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 	}
 	rcu_read_unlock();
 
-	/* header size of tvlv encapsulated tt response payload */
-	hdr_size = sizeof(struct batadv_unicast_tvlv_packet);
-	hdr_size += sizeof(struct batadv_tvlv_hdr);
-	hdr_size += sizeof(struct batadv_tvlv_tt_data);
-	hdr_size += num_vlan * sizeof(struct batadv_tvlv_tt_vlan_data);
-
-	return hdr_size + batadv_tt_len(tt_local_entries);
+	return batadv_tt_local_transmit_size(num_vlan, tt_local_entries);
 }
 
 /**
@@ -803,23 +942,15 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_meshif_vlan *vlan;
-	int packet_size_max;
-	int table_size;
 
-	/* Ignore the client if we cannot send it in a full table response. */
-	table_size = batadv_tt_local_table_transmit_size(bat_priv);
-	table_size += batadv_tt_len(1);
-	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
-	if (table_size > packet_size_max) {
-		net_ratelimited_function(batadv_info, mesh_iface,
-					 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
-					 table_size, packet_size_max, addr);
+	if (!batadv_tt_local_reserve_entry(bat_priv, addr))
 		return NULL;
-	}
 
 	tt_local = kmem_cache_alloc(batadv_tl_cache, GFP_ATOMIC);
-	if (!tt_local)
+	if (!tt_local) {
+		batadv_tt_local_unreserve_entry(bat_priv);
 		return NULL;
+	}
 
 	/* increase the refcounter of the related vlan */
 	vlan = batadv_meshif_vlan_get(bat_priv, vid);
@@ -828,6 +959,7 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 					 "adding TT local entry %pM to non-existent VLAN %d\n",
 					 addr, batadv_print_vid(vid));
 		kmem_cache_free(batadv_tl_cache, tt_local);
+		batadv_tt_local_unreserve_entry(bat_priv);
 		return NULL;
 	}
 
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 618d9dbca5eac..ca01d20ee2d7f 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -16,6 +16,9 @@
 #include <linux/types.h>
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
+bool batadv_tt_local_reserve_vlan(struct batadv_priv *bat_priv,
+				  unsigned short vid);
+void batadv_tt_local_unreserve_vlan(struct batadv_priv *bat_priv);
 bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 unsigned short vid, int ifindex, u32 mark);
 u16 batadv_tt_local_remove(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 67872927cfb50..c19caa84e6920 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1055,6 +1055,25 @@ struct batadv_priv_tt {
 	 */
 	spinlock_t commit_lock;
 
+	/**
+	 * @reserved_entries: number of local TT entries which are currently
+	 *  allocated or about to be allocated. Together with @reserved_vlans it
+	 *  describes the worst case size of a full table response.
+	 */
+	u16 reserved_entries;
+
+	/**
+	 * @reserved_vlans: number of mesh interface VLANs which are currently
+	 *  allocated or about to be allocated. Together with @reserved_entries
+	 *  it describes the worst case size of a full table response.
+	 */
+	u16 reserved_vlans;
+
+	/**
+	 * @reserve_lock: lock protecting @reserved_entries & @reserved_vlans
+	 */
+	spinlock_t reserve_lock;
+
 	/** @work: work queue callback item for translation table purging */
 	struct delayed_work work;
 };
-- 
2.47.3

