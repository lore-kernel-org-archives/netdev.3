Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136606;
	b=g8FFxQjQ74UEtslxa65mUdNpwSiHtlNXeVQO5HV6QYht9vcuVtxXpXQ68FWBSdYpC30T
	 kPTM+uDq11fbHDdfhoT8SpB7h7TTlmztC9agts/4VzkYDTkLvKUYc47ZAVdy+mwDVzldL
	 riijcZDeWnPxQGEwystT5WDLJtyvbjF4UY9yYs3Q62iPnMsZATm//BkZVQwXvYioon4Fq
	 hKxG1rk32uE2T8kdbbUYSliobeYN0Fao6HRvwzn1+aOPUAUxEcAecWOnLsxUlbETwtBEw
	 +hdlPe/CqLPlZ6l4W2jGAL7bBe2mqsikqNZBvSKvM6OR143vKp0/XHCNz7JmEljBetg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EP97KCqcACuZR8x/O/WoysPLrZt4tckt8Ahh2JLLpHg=;
	b=cdtb74RgRm3KjHOVKVUZi+gnzK3oxbhqSAn6KZn0rJpOCUuGxodBem+rtVSt8dvNE4qF
	 HZ52vGNe/09vP9T6rP9ZISlwFn7GKkd8ZxIr2Yd8xh78PzibKVYOyL1IouaJl1J8zIxpH
	 s07bT7Hq2R/vuSvubAKgxVz+keaL1mlY1il+vPg/B+VTzo68a+qVuVrLPFVHXcYSnk569
	 PNZTEYb34y3D11AVn1mYTIzBUBqkan6p2g4zqiul5Tc0V2DxUlka6Upjt1QeY0cBPDMPS
	 kHQ2zE5bOtpPBCDpBbJl+Shnd3bVKyGsKLi6bK4FwG6vydL9aQii9/b42JxUJgbY0Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=MH8rnSLm;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1E606D801
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 11:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A1E606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=MH8rnSLm
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d5cb1b181so5093966b.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 03:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794136604; x=1794741404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EP97KCqcACuZR8x/O/WoysPLrZt4tckt8Ahh2JLLpHg=;
        b=MH8rnSLm/yR75OUACDmLkWSc3miSvBhLaRnvmMr0J8664D3Bth9Pgzbu+R02tum8Hc
         Qbme3vPj7jpLuOhIRaeqc7ylBCwxTuMR6KCHHUVATotxDHsSx6r+FF8u7KQN8WiB8ucr
         3IR64R6V2l0d1GVHjQ88Q3JJJoMvsLfh8RuG544bvOdcLX4/9JZead3JiYioKcYY/Sye
         LisGmd2yL5GXBgHdL2PcZU5UBBXxeDb3PtVUv6AtiRGkTiG23yWWsi6rhdR2oy816jZO
         0syIrxJxSbCSUsm2D/ndEEOPl885+nX/wszcJP4x/V88lqrq0clN1XDJGiJ5+vr2Ih2m
         p/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136604; x=1794741404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EP97KCqcACuZR8x/O/WoysPLrZt4tckt8Ahh2JLLpHg=;
        b=Tt5OYQ7Ei1q449vnz4Vf+d1+/fH2bvsHKVOqbTjTwoBy7e3581ZBkODVq73ODEysXH
         E3Iy0M5xDWnBpyVNcc3vukapZvs3DoVjy3wWDb46+R8Soofd5SfE31zBKr1b78d13Q/3
         o+gte4xJo86rzgA0OgkSz8eIdxxLsYfQNS6ACM7VwhG0bw9T8M0f9MB1Wkb9MxPDhw0h
         IjP6iihiEhPndwtzsdK5ex6mlevxq3+bhbnzYsK1yGRlY4xKnEgDGl6xxQqhGhRUqFJP
         S2fECRi7jBg9dXROwSaWvnh7kylb0L2+zshYpQXZVIL3qHRGeVj/ZPaWVYMj2l+Mwbx/
         dugw==
X-Gm-Message-State: APuU4Z+MiEIW22hE3tZDEp0FViFV9qujuPMQFrtXVwL1BAf5UTowf0qH
	RdMJR9AOQGTpd/itmTMfyOSFNPiVWyzqKTvy64SpXIublvaqPY9titns5smqN4uYUQ==
X-Gm-Gg: AYBFou1WpsbXXE1EPFhBBB+sMQ19V2oxGVtL9gWRQDSr3U7kLjTU04hVFriN/UScJks
	Dnz0zewohWvRjTY8djlpqK+vR7ejFOmpPdjblspr9VtmdJqAglXVxA+BpgtkkK6DOs0a5pRfY9z
	A6HcxLsYA6ALoLqWsda+z3XYpYsPRNsQ9ZQbuYwDvxnozTGf5zmhLuVQ7jAmasV5K8JPAofzX+B
	N95QPJkWMSGBvz1/t8KFsCCtb8Zs1XnXAVrUAAuH6Dmu3Lh7LvR7688rhSBdsH1SYCjr6evGQtP
	YbUa/6SXqvhc32IZ7EoLHcHqSHJtisXJYLT6pIjueM+2wkGOiwcUdyYBC3oz8FqYrPt3L2o9+gW
	kgtFh7MtuTwpcZvXfOxdilRUnlJj4niXVIi/L8Ri2sBcLk8RAI4SBcZwvO2H98s9R241HAqSO0c
	z3pwQT/gahx7gi5GNjb++LX6YmENvZQYzzxwri7nWuyBvA8YPTT2LAFtrTRGB/53TacGBDn1CKr
	8vcaJi4MB+du7TeUMIEm7axXAxTEPoYo+TinYPKq9cqf2uJNJZ3slq8aZlKQZPtvDX9enCcxL/M
	eCPFtGm4EmJL3GNVqwIFj2UCTl4WkMapwS9IVmyur+OpHuX5tmMDs98M9hl8J2ZcpvVlMO/GVGp
	ABv3gcyHsa6gCRukYejKS/TdS6N8nZ8Q4yLIH+eUHb+g+iR6NN3GvHi7asKM3YR0W+wwgWv2/3n
	YW0UwIN4V76yxvT83cdYLs8w2Xoe2JHiq3VJ70o8k5lIt45I4b0vW0YiX3LHWNutv0yBhvGqKrC
	tFe2MzTl1/4eISJboyB9ciPv1qD2PPfrvcqaZ2Qstbm/baiJSCoGMuLPwt1d29ZuppFdxtffiUH
	gmRNb15HjgnG2zgpqKY=
X-Received: by 2002:a17:907:c28:b0:c29:5d41:dfe8 with SMTP id a640c23a62f3a-c4d6d865a0cmr82961966b.43.1794136603862;
        Sun, 08 Nov 2026 03:16:43 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a99320bsm54261166b.67.2026.11.08.03.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:16:42 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: dsa: fix host fdb refcount when a bridge fdb entry roams
Date: Sun,  8 Nov 2026 12:16:39 +0100
Message-ID: <682c2f99d3e5c61e620d768a31107b2cc7db51a6.1794134495.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794134495.git.julius@bairaktaris.de>
References: <cover.1794134495.git.julius@bairaktaris.de>
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

A bridge FDB entry on a foreign port is a host address on every user
port in the bridge. When the entry roams, br_fdb_update() notifies the
deletion from the old port and the addition on the new one without a
lock. With two CPUs receiving the address on different ports, DSA can
get two deletions for one addition, an addition for a port the entry
already left, or the deletion before the addition. Counting these
events either makes a deletion find no reference left on the CPU port,
or leaks a reference, which keeps the address on the CPU port after the
entry moved to a user port or was deleted. The first ends in this
error, here from dsa_loop:

  port 1 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2

Instead of counting, each user port records the host addresses it
holds, and on every event holds the address while the bridge has the
entry on a foreign port and notifies switchdev of it. A deletion that
still finds the entry on its own port was sent before the bridge
changed the port, so the address is released. An entry on a user port,
also one of another tree, is notified only to that port and is not
held; an addition there releases the address on the other ports of the
bridge, which also covers a "bridge fdb replace" onto a user port that
notifies no deletion. Replayed deletions release the address without
the lookup. When the port leaves the bridge, or fails to join it, the
workqueue is flushed before the bridge is freed and the records left
are released. Addresses local to the bridge do not roam and are still
counted. The software bridge is not changed.

In QEMU, with dsa_loop given FDB operations and assisted learning, two
veth ports in its bridge and one source address sent from both on two
CPUs for 5 s, the deletion fails and the address stays on the CPU port
after both veth ports go down in 4 of 5 boots. With this change neither
happens in 5 of 5 boots, and the address is removed when the user ports
leave the bridge. A "bridge fdb replace" of the address onto a user port
leaves it on the CPU port in 5 of 5 boots without this change and
removes it in 5 of 5 with it.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/dsa/port.c |  36 +++++++--
 net/dsa/port.h |   6 ++
 net/dsa/user.c | 216 +++++++++++++++++++++++++++++++++++++++++++++----
 net/dsa/user.h |   8 ++
 4 files changed, 242 insertions(+), 24 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 1f5536c0dffc2..e270a0c5e6641 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -457,7 +457,13 @@ static void dsa_port_bridge_destroy(struct dsa_port *dp,
 {
 	struct dsa_bridge *bridge = dp->bridge;
 
-	dp->bridge = NULL;
+	WRITE_ONCE(dp->bridge, NULL);
+
+	/* Wait for the FDB events that still see the bridge, then release the
+	 * host addresses the port holds, before the drivers are told it left.
+	 */
+	dsa_flush_workqueue();
+	dsa_user_bridge_host_fdb_purge(dp, bridge);
 
 	if (!refcount_dec_and_test(&bridge->refcount))
 		return;
@@ -528,7 +534,9 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 					&dsa_user_switchdev_blocking_notifier);
 	dsa_flush_workqueue();
 out_rollback_unbridge:
+	dsa_port_bridge_destroy(dp, br);
 	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
+	return err;
 out_rollback:
 	dsa_port_bridge_destroy(dp, br);
 	return err;
@@ -1040,13 +1048,14 @@ int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 	return dsa_port_host_fdb_add(dp, addr, vid, db);
 }
 
-int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
-				 const unsigned char *addr, u16 vid)
+int __dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
+				   const struct dsa_bridge *bridge,
+				   const unsigned char *addr, u16 vid)
 {
 	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
-		.bridge = *dp->bridge,
+		.bridge = *bridge,
 	};
 	int err;
 
@@ -1066,6 +1075,12 @@ int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
 	return dsa_port_host_fdb_add(dp, addr, vid, db);
 }
 
+int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
+				 const unsigned char *addr, u16 vid)
+{
+	return __dsa_port_bridge_host_fdb_add(dp, dp->bridge, addr, vid);
+}
+
 static int dsa_port_host_fdb_del(struct dsa_port *dp,
 				 const unsigned char *addr, u16 vid,
 				 struct dsa_db db)
@@ -1091,13 +1106,14 @@ int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 	return dsa_port_host_fdb_del(dp, addr, vid, db);
 }
 
-int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
-				 const unsigned char *addr, u16 vid)
+int __dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
+				   const struct dsa_bridge *bridge,
+				   const unsigned char *addr, u16 vid)
 {
 	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
-		.bridge = *dp->bridge,
+		.bridge = *bridge,
 	};
 	int err;
 
@@ -1113,6 +1129,12 @@ int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
 	return dsa_port_host_fdb_del(dp, addr, vid, db);
 }
 
+int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
+				 const unsigned char *addr, u16 vid)
+{
+	return __dsa_port_bridge_host_fdb_del(dp, dp->bridge, addr, vid);
+}
+
 int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 			 u16 vid)
 {
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 6bc3291573c02..6524f67a37a20 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -54,8 +54,14 @@ int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
 int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
+int __dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
+				   const struct dsa_bridge *bridge,
+				   const unsigned char *addr, u16 vid);
 int dsa_port_bridge_host_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 				 u16 vid);
+int __dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
+				   const struct dsa_bridge *bridge,
+				   const unsigned char *addr, u16 vid);
 int dsa_port_bridge_host_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 				 u16 vid);
 int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef0..7f18c7885b9c5 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -43,6 +43,8 @@ struct dsa_switchdev_event_work {
 	unsigned char addr[ETH_ALEN];
 	u16 vid;
 	bool host_addr;
+	bool sync;
+	bool replay;
 };
 
 enum dsa_standalone_event {
@@ -2813,6 +2815,7 @@ int dsa_user_create(struct dsa_port *port)
 
 	p->dp = port;
 	INIT_LIST_HEAD(&p->mall_tc_list);
+	INIT_LIST_HEAD(&p->bridge_host_fdbs);
 	port->user = user_dev;
 	dsa_user_setup_tagger(user_dev);
 
@@ -3627,6 +3630,22 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static bool dsa_foreign_dev_check(const struct net_device *dev,
+				  const struct net_device *foreign_dev)
+{
+	const struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch_tree *dst = dp->ds->dst;
+
+	if (netif_is_bridge_master(foreign_dev))
+		return !dsa_tree_offloads_bridge_dev(dst, foreign_dev);
+
+	if (netif_is_bridge_port(foreign_dev))
+		return !dsa_tree_offloads_bridge_port(dst, foreign_dev);
+
+	/* Everything else is foreign */
+	return true;
+}
+
 static void
 dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
 {
@@ -3639,6 +3658,171 @@ dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
 				 switchdev_work->orig_dev, &info.info, NULL);
 }
 
+/* The bridge notifies a roaming entry without a lock, so with two CPUs the
+ * deletion from the old port and the addition on the new one can arrive
+ * twice or out of order. Hold the host address while the bridge has the
+ * entry on a foreign port. A deletion that still finds the entry on its own
+ * port was sent before the bridge changed the port. An entry on a user port,
+ * also one of another tree, is notified only to that port.
+ */
+static bool dsa_user_bridge_host_fdb_wanted(struct net_device *dev,
+					    const struct dsa_bridge *bridge,
+					    const unsigned char *addr, u16 vid,
+					    const struct net_device *leaving)
+{
+	struct net_device *brport;
+	bool want;
+
+	rcu_read_lock();
+	brport = br_switchdev_fdb_find_port(bridge->dev, addr, vid);
+	want = brport && brport != leaving && !dsa_user_dev_check(brport) &&
+	       dsa_foreign_dev_check(dev, brport);
+	rcu_read_unlock();
+
+	return want;
+}
+
+static void dsa_user_bridge_host_fdb_set(struct net_device *dev,
+					 const struct dsa_bridge *bridge,
+					 const unsigned char *addr, u16 vid,
+					 bool want)
+{
+	struct dsa_user_priv *p = netdev_priv(dev);
+	struct dsa_port *dp = p->dp;
+	struct dsa_mac_addr *a;
+	bool held = false;
+	int err;
+
+	list_for_each_entry(a, &p->bridge_host_fdbs, list) {
+		if (ether_addr_equal(a->addr, addr) && a->vid == vid) {
+			held = true;
+			break;
+		}
+	}
+
+	if (want == held)
+		return;
+
+	if (want) {
+		a = kzalloc_obj(*a);
+		if (!a)
+			return;
+
+		err = __dsa_port_bridge_host_fdb_add(dp, bridge, addr, vid);
+		if (err) {
+			dev_err(dp->ds->dev,
+				"port %d failed to add %pM vid %d to fdb: %d\n",
+				dp->index, addr, vid, err);
+			kfree(a);
+			return;
+		}
+
+		ether_addr_copy(a->addr, addr);
+		a->vid = vid;
+		list_add(&a->list, &p->bridge_host_fdbs);
+	} else {
+		err = __dsa_port_bridge_host_fdb_del(dp, bridge, addr, vid);
+		if (err) {
+			dev_err(dp->ds->dev,
+				"port %d failed to delete %pM vid %d from fdb: %d\n",
+				dp->index, addr, vid, err);
+			return;
+		}
+
+		list_del(&a->list);
+		kfree(a);
+	}
+}
+
+static void
+dsa_user_bridge_host_fdb_sync(struct dsa_switchdev_event_work *switchdev_work)
+{
+	bool del = switchdev_work->event == SWITCHDEV_FDB_DEL_TO_DEVICE;
+	struct net_device *dev = switchdev_work->dev;
+	const struct dsa_bridge *bridge;
+	bool want = false;
+
+	/* Cleared before the workqueue is flushed and the bridge is freed */
+	bridge = READ_ONCE(dsa_user_to_port(dev)->bridge);
+	if (!bridge)
+		return;
+
+	if (!(del && switchdev_work->replay))
+		want = dsa_user_bridge_host_fdb_wanted(dev, bridge,
+						       switchdev_work->addr,
+						       switchdev_work->vid,
+						       del ? switchdev_work->orig_dev : NULL);
+
+	dsa_user_bridge_host_fdb_set(dev, bridge, switchdev_work->addr,
+				     switchdev_work->vid, want);
+	if (want && !del)
+		dsa_fdb_offload_notify(switchdev_work);
+}
+
+/* Only the user port an entry is on gets its events, so when the entry roams
+ * there, release it on the ports of the bridge that still hold it.
+ */
+static void dsa_user_bridge_host_fdb_release_work(struct work_struct *work)
+{
+	struct dsa_switchdev_event_work *switchdev_work =
+		container_of(work, struct dsa_switchdev_event_work, work);
+	struct dsa_port *dp = dsa_user_to_port(switchdev_work->dev);
+	const unsigned char *addr = switchdev_work->addr;
+	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
+	u16 vid = switchdev_work->vid;
+	struct dsa_port *other;
+
+	if (bridge) {
+		dsa_tree_for_each_user_port(other, dp->ds->dst) {
+			if (dsa_port_offloads_bridge_dev(other, bridge->dev) &&
+			    !dsa_user_bridge_host_fdb_wanted(other->user, bridge,
+							     addr, vid, NULL))
+				dsa_user_bridge_host_fdb_set(other->user, bridge,
+							     addr, vid, false);
+		}
+	}
+
+	kfree(switchdev_work);
+}
+
+static int dsa_user_bridge_host_fdb_release(struct net_device *dev,
+					    const unsigned char *addr, u16 vid)
+{
+	struct dsa_switchdev_event_work *switchdev_work;
+
+	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
+	if (!switchdev_work)
+		return -ENOMEM;
+
+	INIT_WORK(&switchdev_work->work, dsa_user_bridge_host_fdb_release_work);
+	switchdev_work->dev = dev;
+	ether_addr_copy(switchdev_work->addr, addr);
+	switchdev_work->vid = vid;
+
+	dsa_schedule_work(&switchdev_work->work);
+
+	return 0;
+}
+
+void dsa_user_bridge_host_fdb_purge(struct dsa_port *dp,
+				    const struct dsa_bridge *bridge)
+{
+	struct dsa_user_priv *p = netdev_priv(dp->user);
+	struct dsa_mac_addr *a, *tmp;
+	int err;
+
+	list_for_each_entry_safe(a, tmp, &p->bridge_host_fdbs, list) {
+		err = __dsa_port_bridge_host_fdb_del(dp, bridge, a->addr,
+						     a->vid);
+		if (err)
+			dev_err(dp->ds->dev,
+				"port %d failed to delete %pM vid %d from fdb: %d\n",
+				dp->index, a->addr, a->vid, err);
+		list_del(&a->list);
+		kfree(a);
+	}
+}
+
 static void dsa_user_switchdev_event_work(struct work_struct *work)
 {
 	struct dsa_switchdev_event_work *switchdev_work =
@@ -3653,6 +3837,12 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	dp = dsa_user_to_port(dev);
 	ds = dp->ds;
 
+	if (switchdev_work->sync) {
+		dsa_user_bridge_host_fdb_sync(switchdev_work);
+		kfree(switchdev_work);
+		return;
+	}
+
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		if (switchdev_work->host_addr)
@@ -3689,22 +3879,6 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	kfree(switchdev_work);
 }
 
-static bool dsa_foreign_dev_check(const struct net_device *dev,
-				  const struct net_device *foreign_dev)
-{
-	const struct dsa_port *dp = dsa_user_to_port(dev);
-	struct dsa_switch_tree *dst = dp->ds->dst;
-
-	if (netif_is_bridge_master(foreign_dev))
-		return !dsa_tree_offloads_bridge_dev(dst, foreign_dev);
-
-	if (netif_is_bridge_port(foreign_dev))
-		return !dsa_tree_offloads_bridge_port(dst, foreign_dev);
-
-	/* Everything else is foreign */
-	return true;
-}
-
 static int dsa_user_fdb_event(struct net_device *dev,
 			      struct net_device *orig_dev,
 			      unsigned long event, const void *ctx,
@@ -3723,7 +3897,9 @@ static int dsa_user_fdb_event(struct net_device *dev,
 
 	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
 		if (dsa_port_offloads_bridge_port(dp, orig_dev))
-			return 0;
+			return event == SWITCHDEV_FDB_ADD_TO_DEVICE ?
+			       dsa_user_bridge_host_fdb_release(dev, fdb_info->addr,
+								fdb_info->vid) : 0;
 
 		/* FDB entries learned by the software bridge or by foreign
 		 * bridge ports should be installed as host addresses only if
@@ -3768,9 +3944,15 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
 	switchdev_work->vid = fdb_info->vid;
 	switchdev_work->host_addr = host_addr;
+	switchdev_work->sync = host_addr && !fdb_info->is_local;
+	switchdev_work->replay = !!ctx;
 
 	dsa_schedule_work(&switchdev_work->work);
 
+	if (!host_addr && event == SWITCHDEV_FDB_ADD_TO_DEVICE)
+		return dsa_user_bridge_host_fdb_release(dev, fdb_info->addr,
+							fdb_info->vid);
+
 	return 0;
 }
 
diff --git a/net/dsa/user.h b/net/dsa/user.h
index 016884bead3cd..dd38104162da4 100644
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@ -33,6 +33,12 @@ struct dsa_user_priv {
 
 	/* TC context */
 	struct list_head	mall_tc_list;
+
+	/* Host addresses of bridge FDB entries held through this port,
+	 * changed from the DSA workqueue, or with the port out of the bridge
+	 * and the workqueue flushed
+	 */
+	struct list_head	bridge_host_fdbs;
 };
 
 void dsa_user_mii_bus_init(struct dsa_switch *ds);
@@ -47,6 +53,8 @@ void dsa_user_host_uc_uninstall(struct net_device *dev);
 void dsa_user_sync_ha(struct net_device *dev);
 void dsa_user_unsync_ha(struct net_device *dev);
 void dsa_user_setup_tagger(struct net_device *user);
+void dsa_user_bridge_host_fdb_purge(struct dsa_port *dp,
+				    const struct dsa_bridge *bridge);
 int dsa_user_change_mtu(struct net_device *dev, int new_mtu);
 int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 			    struct netlink_ext_ack *extack);
-- 
2.53.0

