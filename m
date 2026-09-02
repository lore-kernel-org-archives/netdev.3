Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027C03E3C73;
	Wed,  2 Sep 2026 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334373; cv=none; b=u0nZHfvwGz/55AErhGZW8xDyaAWWfgi62jmfYSZ0KW4Id11jATePbpoZ1cVw9V/ZxsY0jOG/ty6hiEvSJt/KkEG7jNWc0fXr9JS+l8L9VHKoae48v+PGuR3nCRxvePgXJFqiDIR2vMWaldITBVJWc8Ufj5U/UCCsxLAob1MWgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334373; c=relaxed/simple;
	bh=FEXr74+mRZDY5P0+8AX8vb2OHgI+CdK3+b71vGoRlz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soeZ27yq1Us1uv6aNAr09NmH4OO7laBs/WoackvXe5I+VfDbFyeiyVZ75nrflW2G93KTgToFwYo1Ns2dz+D2wkX5fc0ngFq09b1YdJmYi2TXOoqoxHmFoduWx0Nq/Dus8RuVnPBpYqJB8mEb8WdcZwhVMxT6oTBp/6yCVuE3j+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=m6929SfT; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="m6929SfT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TqoaAhRMVIzc4ysdOfxdXVObD5EzvCeXtJZE1w2pbag=;
	b=m6929SfTYgjwMKoPvxZhsQs6ohVfL/lfiH4TcTvOo9BEXsDD9vCPGdxf9c3hCzBJPzxDY20GR
	fPT6JnNSQqXCGKqhVl7qXYAUiAILvf4RfKh43k8g2UhoOj1y6Y3tx0/UDyU3wBUX8Iyf3m2fiOp
	a5ntZL+UgHiQWWXZCWum0hM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hZZ0t4j5VzKm6S;
	Wed,  2 Sep 2026 15:21:50 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 49E7F40563;
	Wed,  2 Sep 2026 15:32:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Sep
 2026 15:32:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <nb@tipi-net.de>,
	<kuniyu@google.com>, <sdf@fomichev.me>, <liuhangbin@gmail.com>,
	<da-x@monatomic.org>, <jeff@garzik.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3 1/2] 8021q: Fix data race when publishing vlan net_device pointers
Date: Wed, 2 Sep 2026 15:33:33 +0800
Message-ID: <20260902073334.397685-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902073334.397685-1-ruanjinjie@huawei.com>
References: <20260902073334.397685-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

A plain C read and assignment of the net_device pointer
in the vlan_devices_arrays leaf entries lack proper atomicity
and ordering barriers. A concurrent lockless reader on the packet
receive fast-path could observe a torn or partially initialized
net_device pointer, leading to a potential out-of-bounds read or kernel
panic.

The data race occurs between the netlink/ioctl configuration paths
(holding the per-netns rtnl_nets_lock or RTNL lock) and the softirq
receive fast-path (holding rcu_read_lock()):

  CPU 0 (Writer, rtnl_nets_lock/RTNL)      CPU 1 (Reader, rcu_read_lock())
  -----------------------------------      -------------------------------
   rtnetlink_rcv_msg()
     // RTM_NEWLINK handler with RTNL_FLAG_DOIT_PERNET
     rtnl_newlink()
       ops->newlink() == vlan_newlink()
   OR
   vlan_ioctl_handler()
     [ADD_VLAN_CMD] -> register_vlan_device()

     register_vlan_dev()
       vlan_group_set_device()
                                      netif_receive_skb_core()
                                          vlan_do_receive()
                                              vlan_find_dev()
                                                 __vlan_group_get_device()
                                                  // Speculative / torn read
                                                  [Loads bad net_device *]
           [Plain C store]
           array[vlan_id] = dev;
                                                  // Dereferences bad pointer
                                                  // during device status check
                                                  vlan_dev->flags (PANIC!)

Fix this by using rcu_assign_pointer() in vlan_group_set_device()
and rcu_dereference_raw() in __vlan_group_get_device() to enforce
proper ordering and memory atomicity for the leaf entry traversal.

Cc: stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Dan Aloni <da-x@monatomic.org>
Cc: Jeff Garzik <jeff@garzik.org>
Fixes: 5c15bdec5c38 ("[VLAN]: Avoid a 4-order allocation.")
Link: https://sashiko.dev/#/patchset/20260825095422.3166067-1-ruanjinjie%40huawei.com
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 net/8021q/vlan.c |  2 +-
 net/8021q/vlan.h | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 2d2efb877975..6df80cad40a2 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -49,7 +49,7 @@ const char vlan_version[] = DRV_VERSION;
 static int vlan_group_prealloc_vid(struct vlan_group *vg,
 				   __be16 vlan_proto, u16 vlan_id)
 {
-	struct net_device **array;
+	struct net_device __rcu **array;
 	unsigned int vidx;
 	unsigned int size;
 	int pidx;
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index c41caaf94095..3cb4c8294130 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -22,8 +22,8 @@ enum vlan_protos {
 struct vlan_group {
 	unsigned int		nr_vlan_devs;
 	struct hlist_node	hlist;	/* linked list */
-	struct net_device **vlan_devices_arrays[VLAN_PROTO_NUM]
-					       [VLAN_GROUP_ARRAY_SPLIT_PARTS];
+	struct net_device __rcu **vlan_devices_arrays[VLAN_PROTO_NUM]
+						     [VLAN_GROUP_ARRAY_SPLIT_PARTS];
 };
 
 struct vlan_info {
@@ -54,7 +54,7 @@ static inline struct net_device *__vlan_group_get_device(struct vlan_group *vg,
 							 unsigned int pidx,
 							 u16 vlan_id)
 {
-	struct net_device **array;
+	struct net_device __rcu **array;
 
 	array = vg->vlan_devices_arrays[pidx]
 				       [vlan_id / VLAN_GROUP_ARRAY_PART_LEN];
@@ -62,7 +62,7 @@ static inline struct net_device *__vlan_group_get_device(struct vlan_group *vg,
 	/* paired with smp_wmb() in vlan_group_prealloc_vid() */
 	smp_rmb();
 
-	return array ? array[vlan_id % VLAN_GROUP_ARRAY_PART_LEN] : NULL;
+	return array ? rcu_dereference_raw(array[vlan_id % VLAN_GROUP_ARRAY_PART_LEN]) : NULL;
 }
 
 static inline struct net_device *vlan_group_get_device(struct vlan_group *vg,
@@ -82,13 +82,13 @@ static inline void vlan_group_set_device(struct vlan_group *vg,
 					 struct net_device *dev)
 {
 	int pidx = vlan_proto_idx(vlan_proto);
-	struct net_device **array;
+	struct net_device __rcu **array;
 
 	if (!vg || pidx < 0)
 		return;
 	array = vg->vlan_devices_arrays[pidx]
 				       [vlan_id / VLAN_GROUP_ARRAY_PART_LEN];
-	array[vlan_id % VLAN_GROUP_ARRAY_PART_LEN] = dev;
+	rcu_assign_pointer(array[vlan_id % VLAN_GROUP_ARRAY_PART_LEN], dev);
 }
 
 /* Must be invoked with rcu_read_lock or with RTNL. */
-- 
2.34.1

