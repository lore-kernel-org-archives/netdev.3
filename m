Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368283;
	b=PJMKD3Re/SKpmu5Cm/O1avpmJ+AT7R76EduPvtT0HMXSFUJ0czqtxDAmRvF4VU1IO1bj
	 e7muC2A0UjSYhLe47ug2lAGNIGxU5qci9b5YWBQyRyyFxR+SDZMsHBydiQyu2nVhEwAes
	 fVMbRZPQi2SwUuEXPubyQFAMLKI/hmTj7BzC45vWZx9Mt/7iO3r4arwEWU99gSAJ5U0+d
	 K6HQvSxaqJZMOYrbdplddePEN2DiOnIQQs/kijLsZLVomkyEY8BGoP5ImnsPhRKa1EzAk
	 9m9IbtgEYk4JvR/2UHr9GplIHwXdONzEc+idKJfBzrp1ndlgGFFwGfGlfPIdQFyqAlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368283;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FWL1F1vUJ7Rasf3dRTG7SOA/ia/4OoBsj5jwSa+rk1s=;
	b=tMorAepY9U/6JIREX13g8FGcyj7/IgklNbMHfkmTqytlMC9a08cCLy57UoIRo3VBw01s
	 ZqSD2N9SAPMJLRuGFcze8B/+B3h4czMgclBPhiyXEbyEKBXAwWBqp0m+DuY/PAA6FS7gg
	 4a2eJJd2E/ZNeJQpWtdBcMXkAm8M1F58eiL0aPpmXgmln6LHb7D94DWJ8NQOxQWSsJa7H
	 6K6YVOahp7AkzooQbFl+udKOB286nFVp6pBNiVrbGwEa2+LCgL2oUenhsqFDDxt1ILLsO
	 GxEKh9Gbw7ePvqnQgzYsVR4aIRO7LZbLAyEo4NcCtIfhjdiN9juR5+6AM9Kxb9bheAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=weEB+vu7;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8E18C606A33A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E18C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=weEB+vu7
Received: from kero.packetmixer.de (p200300c597124Fd839580C360D3ed6F6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C4F24FA2F0;
	Fri, 30 Oct 2026 14:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWL1F1vUJ7Rasf3dRTG7SOA/ia/4OoBsj5jwSa+rk1s=;
	b=weEB+vu7I//jKEx/ZyXAZsMGs3Hr4ki0P+ytfDCwrTX7/4g4R6jdErl9XeIaXJI5bG3tjl
	r/MysQdsxPCuK1giVx6k19vp0404XIDz51GdBRzjkEbiiz+UX/V0umHpdqatu28Rca7yVX
	Bex/aml1ZNkVpP6RlANijFpdUv5yTFAvUWJLw0rhd/We2EUd13eiF7MLa6/US4oiAN5f5I
	8asOGtXk+ajWe3tQ1zdRigNWbdoJPT1DTXmCV8dILPTMobYvl1lySzAxfOYTYTq9u6Dnr3
	qi0uYsQk25HLpLuD74GgsKCQ7UwptmbXzp2NH8MBUY5MDVb9Hh7LSOhrp5a6Zg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	stable+noautosel@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net v2 14/14] batman-adv: tt: limit local table to single TVLV response size
Date: Fri, 30 Oct 2026 14:51:05 +0100
Message-ID: <20261030135105.2555887-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
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

The reservation of local TT entries and VLANs only limits the local table
by (int) packet_size_max. But the full table response is sent as a single
unicast TVLV packet whose tvlv_len (covering the TVLV header and the TT
TVLV) is only 16 bit wide. The reservation must therefore be capped at the
minimum of both the packet_size_max and the maximum theoretic table
response.

The size limit was already missing the 16 bit tvlv_len cap since the
original packet_size_max check was introduced. But this check was only
reachable with fragmentation disabled and a hard interface MTU larger than
the maximum unicast TVLV packet. In this case,
batadv_tt_prepare_tvlv_local_data() refuses to build the full table
response and no oversized packet is created. It is therefore mostly
affecting the commit 85fb027f611b ("batman-adv: tt: reject VLAN/TT entries
before reaching size limit"), which should prevent this kind of
overallocation.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de?part=8
Fixes: a19d3d85e1b8 ("batman-adv: limit local translation table max size")
Cc: <stable+noautosel@kernel.org> # requires 85fb027f611b, old behavior only affects MTU > 64KiB without fragmentation
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 69 ++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f0100ccf93deb..46304069b3b75 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -26,8 +26,10 @@
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/minmax.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
@@ -253,7 +255,8 @@ static int batadv_tt_len(int changes_num)
  *
  * Return: local translation table size in bytes.
  */
-static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
+static int batadv_tt_local_transmit_size(unsigned int num_vlan,
+					 unsigned int num_entries)
 {
 	int hdr_size;
 
@@ -266,6 +269,25 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
 	return hdr_size + batadv_tt_len(num_entries);
 }
 
+/**
+ * batadv_tt_local_transmit_size_max() - get the maximum size of a full local table
+ *  response
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * The full table response is sent as a single unicast TVLV packet. Its
+ * tvlv_len, which covers the TVLV header and the TT TVLV, is only 16 bit wide.
+ * This limits the response size even when packet_size_max is larger.
+ *
+ * Return: maximum size of a full local table response in bytes
+ */
+static int batadv_tt_local_transmit_size_max(struct batadv_priv *bat_priv)
+{
+	int tvlv_size_max = sizeof(struct batadv_unicast_tvlv_packet) + U16_MAX;
+	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+
+	return min(packet_size_max, tvlv_size_max);
+}
+
 /**
  * batadv_tt_local_reserve() - reserve room in the transmittable local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -290,22 +312,23 @@ static int batadv_tt_local_transmit_size(u16 num_vlan, u16 num_entries)
 static bool batadv_tt_local_reserve(struct batadv_priv *bat_priv, u16 num_vlan,
 				    u16 num_entries, int *table_size)
 {
-	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+	int size_max = batadv_tt_local_transmit_size_max(bat_priv);
+	unsigned int entries;
+	unsigned int vlans;
 
 	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
-		bat_priv->tt.reserved_vlans += num_vlan;
-		bat_priv->tt.reserved_entries += num_entries;
+		vlans = bat_priv->tt.reserved_vlans + num_vlan;
+		entries = bat_priv->tt.reserved_entries + num_entries;
 
-		*table_size = batadv_tt_local_transmit_size(bat_priv->tt.reserved_vlans,
-							    bat_priv->tt.reserved_entries);
-		if (*table_size <= packet_size_max)
-			return true;
+		*table_size = batadv_tt_local_transmit_size(vlans, entries);
+		if (*table_size > size_max)
+			return false;
 
-		bat_priv->tt.reserved_vlans -= num_vlan;
-		bat_priv->tt.reserved_entries -= num_entries;
+		bat_priv->tt.reserved_vlans = vlans;
+		bat_priv->tt.reserved_entries = entries;
 	}
 
-	return false;
+	return true;
 }
 
 /**
@@ -339,9 +362,10 @@ static bool batadv_tt_local_reserve_entry(struct batadv_priv *bat_priv,
 		return true;
 
 	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
-				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
+				 "Local translation table size (%i) exceeds maximum table response size (%i); Ignoring new local tt entry: %pM\n",
 				 table_size,
-				 READ_ONCE(bat_priv->packet_size_max), addr);
+				 batadv_tt_local_transmit_size_max(bat_priv),
+				 addr);
 
 	return false;
 }
@@ -374,8 +398,9 @@ bool batadv_tt_local_reserve_vlan(struct batadv_priv *bat_priv,
 		return true;
 
 	net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
-				 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new VLAN: %d\n",
-				 table_size, READ_ONCE(bat_priv->packet_size_max),
+				 "Local translation table size (%i) exceeds maximum table response size (%i); Ignoring new VLAN: %d\n",
+				 table_size,
+				 batadv_tt_local_transmit_size_max(bat_priv),
 				 batadv_print_vid(vid));
 
 	return false;
@@ -724,9 +749,9 @@ static u16 batadv_tt_entries(u16 tt_len)
  */
 static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 {
+	unsigned int tt_local_entries = 0;
 	struct batadv_meshif_vlan *vlan;
-	u16 tt_local_entries = 0;
-	u16 num_vlan = 0;
+	unsigned int num_vlan = 0;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -4727,16 +4752,16 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	int timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
 	bool reduced = false;
-	int packet_size_max;
 	int table_size;
+	int size_max;
 
-	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+	size_max = batadv_tt_local_transmit_size_max(bat_priv);
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 
 	while (timeout) {
 		table_size = batadv_tt_local_table_transmit_size(bat_priv);
-		if (packet_size_max >= table_size)
+		if (size_max >= table_size)
 			break;
 
 		batadv_tt_local_purge(bat_priv, timeout);
@@ -4745,8 +4770,8 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 		timeout /= 2;
 		reduced = true;
 		net_ratelimited_function(batadv_info, mesh_iface,
-					 "Forced to purge local tt entries to fit new maximum fragment MTU (%i)\n",
-					 packet_size_max);
+					 "Forced to purge local tt entries to fit new maximum table response size (%i)\n",
+					 size_max);
 	}
 
 	/* commit these changes immediately, to avoid synchronization problem
-- 
2.47.3

