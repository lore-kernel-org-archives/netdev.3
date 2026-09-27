Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F924A078
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790468698; cv=none; b=UUqLgvaLwQ/WIlN5meiCwCFsGOOIp73AepHom0eny4+YHoBc7X3DxyAPNb8jjubQ7LsUtCgTLQqYpp79sBqNy9JC3DIhQJwW8F79idVIBCJNgE5/sYJEds//LCXWq0ctKC4IEpamAAXnh/vcy8vNM6bPfPsGWMqHHW7MfkgAcMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790468698; c=relaxed/simple;
	bh=uIYCR949bmIVasLC/3K/hACHN1prTGKRkXxg+ZmBrnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF6D476W8Q3c2RhL3JJO/aA9pfk9HolvPjdpCtJeM1rTEJmQUmwgYxx/mRS07IEMntHQfU8v0rcbypn2JqiYTz452QGsrXDBfoUiLz6OJOl+1tFnAay0DBK8ox0vPto3fN2oXHsnsfQm8y3t3X+AhPKCXhPsv1/W38ujkTRVFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt+cVNqP; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt+cVNqP"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469f204f6so939233b3a.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790468696; x=1791073496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LvN9VPqrOGUGshtYxdc+YFqVlRUz1wazj1d3gn6P2Xw=;
        b=Rt+cVNqP3P0cQuY3rdr9NI8VlDQqTnfHczIj0GzZL5JajE1c2Thu7F3nitw2SQdJSm
         UwwQo4196JECaAHqVHGHj8rfs/5ckBHBb+y2pL8LcJZn96t9jpoP7oD8Ea/C194X+IGc
         dAUGHsgOdu9A7RMN2wiMrjIneeApKouvuCYwAkOWjOy3VhO2LfgDxxuXSO05ZbnXzORL
         08+/iD6wT/rbJwMrqSaoyKWdOXXqbN0LL3ERS7fhpApfwv4zNriKgvM+rWNPyF0vUGrp
         jKkRjp6f08Tus9oJbqD7ryU6uimNkSQfJrKp6l/L/xDDXUzA1tbZcgOqSGKzKV1G36MK
         9Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790468696; x=1791073496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvN9VPqrOGUGshtYxdc+YFqVlRUz1wazj1d3gn6P2Xw=;
        b=xiZc+cwOXwJvZi+tFxtEGzzeiq0Wwhk71jkfEEEQYi2ParyaAA99C6h5DnhS1xRnK5
         U60ejkcgJAYCRxyVun/k8ofOvGUsG4livt7U6KyTUL2lmKZhP4iD8NmWRbpZmrjyTrXK
         xtfdVV0jkJr/LV2hjS26ehnwxYJ/CdkJg68OBNCg+R4vrGU7W5mwmJnqR68SGgXCwKlk
         WYduSstlul8XK4XsxUGFV0O7cE2P71Q5EUoWOYrCQxt2wpazzGQYlSGB5AWSOG97BGXo
         42myClcZ6MwUWEKeIb60VVfMfbO3vaQcoXTGFNH4euwNmrETPV621fFVKkmJ9TaNJ/NL
         Ys3g==
X-Forwarded-Encrypted: i=1; AKwUvBxveee0R8ZLskEVbzWz79O/0zs4oStmyIeBBJo7Ml2YI3a0bBuzhqpn39kbv8n5mPG0eq3dkeM=@vger.kernel.org
X-Gm-Message-State: AFuF++l6LMSl3l4NviAmBZo/uTx21zVjNvEMochJQAZcvI0rE19ZF2U4
	fwSNujIhUcMUXNJc6uMA5jXOzX2ERR2kG5/LqaNlqyS7aXqNeFwNMGie
X-Gm-Gg: AYBFou2LuW/AT2oM225HqTmPk6442EpFKtDs+UuWH8pARQGepRD3SLOlLS+GKZlkgQi
	ie3RCr5h4o/kxUW93wzFEbq9DAjkKNGIX2fBGbMWuH/0sXIguPMP6sJeoR/6qqXX/Vl0YKcXQIL
	BJUr2uifKdePRKc+YV99DxHJKqzu1umds0Iylqo5yXi20u2WaHyH1rA0cO8/82mjWWZy2qKRV0p
	12PtSapotMHGkBe+CeLh/AQRMmfl5EbXJe3LjaMKdRPHOfiCEoiiXK+g8q8VfRde0FwP3aFgqub
	3m/M+SxEX9lkWrbIprJ6cnYiflrs8J043GphmbvAeiK/2UhqA+K/kPJojCYPBzprNZKBO4GznQN
	E78OgngjpYcigf2mCU9qfdbEh+9aPYSidmT8ybSNxogNVVnI8YhFsBkEGdnz1bDeJN4JCyIsHXO
	ZFZAbCCktD/uNEJGviqi+FR6xlLwkRGyN5XWC2Bd2LF4E3IZy1FSPHWlboz3XLjcWc90oGI255a
	ES2ewhCGSL0xZ16Oe46hAjEav7jw8czDLQQDDoU6svHMacMA/CLNWEzdiuN
X-Received: by 2002:a05:6a20:2d08:b0:3dd:a197:7361 with SMTP id adf61e73a8af0-3de0e8967f4mr9327637637.58.1790468696226;
        Sat, 26 Sep 2026 17:24:56 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:78b6:7bf6:b1de:12ef])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791c680sm2698224a12.16.2026.09.26.17.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 17:24:55 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v8 2/5] net: add a generation counter for dev->mc changes
Date: Sun, 27 Sep 2026 09:24:24 +0900
Message-ID: <20260927002427.4519-3-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927002427.4519-1-sigefriedhyy@gmail.com>
References: <20260927002427.4519-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A multi-part RTM_GETMULTICAST dump of dev->mc resumes by position, so
entries added or removed between two dump rounds can be skipped or
repeated. The IPv4 and IPv6 dumps report that with NLM_F_DUMP_INTR by
stamping cb->seq from a per netns generation counter combined with
dev_base_seq, see inet_base_seq().

Add the equivalent for the device multicast lists: a per netns counter
bumped whenever an entry is added to or removed from any dev->mc. The
list helpers do not know which device a list belongs to, so give
netdev_hw_addr_list an owner, set for the lists of a device and NULL
for snapshots and other standalone lists, and change list->count
through helpers that bump the counter of dev_net(owner) when the list
is dev->mc. That covers the dev_mc_* helpers, both lists of a sync,
the hardware sync helpers drivers call from their rx mode callbacks or
their own workers and the reconciliation after an asynchronous rx mode
update. It is atomic since the writers only hold the address lock of
their own device.

Used by the following patch for the AF_PACKET multicast dump.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 include/linux/netdevice.h   |  5 ++++
 include/net/net_namespace.h |  1 +
 net/core/dev_addr_lists.c   | 52 +++++++++++++++++++++++++++++++------
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d037faff7c44..69d1cde0a38a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -256,6 +256,11 @@ struct netdev_hw_addr_list {
 
 	/* Auxiliary tree for faster lookup on addition and deletion */
 	struct rb_root		tree;
+
+	/* The device a list belongs to, NULL for snapshots and other
+	 * standalone lists
+	 */
+	struct net_device	*owner;
 };
 
 #define netdev_hw_addr_list_count(l) ((l)->count)
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 46b4c67e2966..d8c681ab5c74 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -71,6 +71,7 @@ struct net {
 	spinlock_t		rules_mod_lock;
 
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
+	atomic_t		dev_mc_genid;	/* bumped on dev->mc changes */
 	u32			ifindex;
 
 	spinlock_t		nsid_lock;
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 08528ca0a8b3..c941c3ec1007 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -16,6 +16,37 @@
 
 #include "dev.h"
 
+/* Only dev->mc is tracked, RTM_GETMULTICAST dumps use the netns generation
+ * counter to detect changes between dump rounds.
+ */
+static void __hw_addr_changed(struct netdev_hw_addr_list *list)
+{
+	struct net_device *dev = list->owner;
+
+	if (dev && list == &dev->mc)
+		atomic_inc(&dev_net(dev)->dev_mc_genid);
+}
+
+static void __hw_addr_count_inc(struct netdev_hw_addr_list *list)
+{
+	list->count++;
+	__hw_addr_changed(list);
+}
+
+static void __hw_addr_count_dec(struct netdev_hw_addr_list *list)
+{
+	list->count--;
+	__hw_addr_changed(list);
+}
+
+static void __hw_addr_count_reset(struct netdev_hw_addr_list *list)
+{
+	if (!list->count)
+		return;
+	list->count = 0;
+	__hw_addr_changed(list);
+}
+
 /*
  * General list handling functions
  */
@@ -125,7 +156,7 @@ static int __hw_addr_add_ex(struct netdev_hw_addr_list *list,
 	rb_insert_color(&ha->node, &list->tree);
 
 	list_add_tail_rcu(&ha->list, &list->list);
-	list->count++;
+	__hw_addr_count_inc(list);
 
 	return 0;
 }
@@ -161,7 +192,7 @@ static int __hw_addr_del_entry(struct netdev_hw_addr_list *list,
 
 	list_del_rcu(&ha->list);
 	kfree_rcu(ha, rcu_head);
-	list->count--;
+	__hw_addr_count_dec(list);
 	return 0;
 }
 
@@ -492,7 +523,7 @@ void __hw_addr_flush(struct netdev_hw_addr_list *list)
 		list_del_rcu(&ha->list);
 		kfree_rcu(ha, rcu_head);
 	}
-	list->count = 0;
+	__hw_addr_count_reset(list);
 }
 EXPORT_SYMBOL_IF_KUNIT(__hw_addr_flush);
 
@@ -501,6 +532,7 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
 	INIT_LIST_HEAD(&list->list);
 	list->count = 0;
 	list->tree = RB_ROOT;
+	list->owner = NULL;
 }
 EXPORT_SYMBOL(__hw_addr_init);
 
@@ -536,7 +568,7 @@ int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
 			entry = list_first_entry(&cache->list,
 						 struct netdev_hw_addr, list);
 			list_del(&entry->list);
-			cache->count--;
+			__hw_addr_count_dec(cache);
 			memcpy(entry->addr, ha->addr, addr_len);
 			entry->type = ha->type;
 			entry->global_use = false;
@@ -554,7 +586,7 @@ int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
 
 		list_add_tail(&entry->list, &snap->list);
 		__hw_addr_insert(snap, entry, addr_len);
-		snap->count++;
+		__hw_addr_count_inc(snap);
 	}
 
 	return 0;
@@ -604,14 +636,14 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
 			if (delta > 0) {
 				rb_erase(&ref_ha->node, &ref->tree);
 				list_del(&ref_ha->list);
-				ref->count--;
+				__hw_addr_count_dec(ref);
 				ref_ha->sync_cnt = delta;
 				ref_ha->refcount = delta;
 				list_add_tail_rcu(&ref_ha->list,
 						  &real_list->list);
 				__hw_addr_insert(real_list, ref_ha,
 						 addr_len);
-				real_list->count++;
+				__hw_addr_count_inc(real_list);
 			}
 			continue;
 		}
@@ -622,7 +654,7 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
 			rb_erase(&real_ha->node, &real_list->tree);
 			list_del_rcu(&real_ha->list);
 			kfree_rcu(real_ha, rcu_head);
-			real_list->count--;
+			__hw_addr_count_dec(real_list);
 		}
 	}
 
@@ -685,6 +717,7 @@ int dev_addr_init(struct net_device *dev)
 	/* rtnl_mutex must be held here */
 
 	__hw_addr_init(&dev->dev_addrs);
+	dev->dev_addrs.owner = dev;
 	memset(addr, 0, sizeof(addr));
 	err = __hw_addr_add(&dev->dev_addrs, addr, sizeof(addr),
 			    NETDEV_HW_ADDR_T_LAN);
@@ -962,6 +995,7 @@ EXPORT_SYMBOL(dev_uc_flush);
 void dev_uc_init(struct net_device *dev)
 {
 	__hw_addr_init(&dev->uc);
+	dev->uc.owner = dev;
 }
 EXPORT_SYMBOL(dev_uc_init);
 
@@ -1177,6 +1211,7 @@ EXPORT_SYMBOL(dev_mc_flush);
 void dev_mc_init(struct net_device *dev)
 {
 	__hw_addr_init(&dev->mc);
+	dev->mc.owner = dev;
 }
 EXPORT_SYMBOL(dev_mc_init);
 
@@ -1348,6 +1383,7 @@ static void netif_rx_mode_retry(struct timer_list *t)
 void netif_rx_mode_init(struct net_device *dev)
 {
 	__hw_addr_init(&dev->rx_mode_addr_cache);
+	dev->rx_mode_addr_cache.owner = dev;
 	timer_setup(&dev->rx_mode_retry_timer, netif_rx_mode_retry, 0);
 }
 
-- 
2.43.0

