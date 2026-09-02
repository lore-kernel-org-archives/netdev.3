Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BE3E3C5F;
	Wed,  2 Sep 2026 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334371; cv=none; b=kcTcJm3hQZw8TJc++oq0eARY7dMq9cjL2uG1G051hfQMTff7hekVDa0ERuqPDqreVFvC9mr77ZaeNL9LJRNHqgrb5kUrNa/qeR4jdC8oQTm/VsoCaoV+h1uxEmh49k1LrVFMlYJxJ2a/ropfNCSOOCs76/FVadg7iEAz5cz9myM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334371; c=relaxed/simple;
	bh=lme/k/mvGWorJ17rEXy+N3WEx8UnBVqykX+blYDUzJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8YDCJisjiR+QtnBXedrhJYeLbWJ+XAP0O8YZGGqxTYOJ/hzjL/FpZg+w23LBTHOp+ULEXKyhjx4UGUxb/Ne6Ycg5FWom5LFrEE7xdNqT0mA3UTwZENj1lGt+ZxeK3niDvVUY1lOF1Jjo4Y43MUTUn9W5ZnD5kIec15WBPcizF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fN3lVLCo; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fN3lVLCo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=atKlvKjiBr25ZmGwIkFEd53L8yH86qCl0s2fZCUjdM8=;
	b=fN3lVLCoJLGmnk6kc3FoBDusLqhOYmsTP4K7tpr9s1xID73mlueIasn7P/RQzdDtHXI2Cpgql
	qVaqPahA0eR9cOtVU8tB7/gIsfpL01c9ZEtWzO4gWgJkeOgyQHRgotibNmYkWRt9BPv6szdPRQW
	w8wqc5ewajiM/rAHubX0d6E=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZZ0W6kS5znV05;
	Wed,  2 Sep 2026 15:21:31 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3334D4057A;
	Wed,  2 Sep 2026 15:32:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Sep
 2026 15:32:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <nb@tipi-net.de>,
	<kuniyu@google.com>, <sdf@fomichev.me>, <liuhangbin@gmail.com>,
	<da-x@monatomic.org>, <jeff@garzik.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3 2/2] 8021q: publish vlan_devices_arrays entries with acquire/release
Date: Wed, 2 Sep 2026 15:33:34 +0800
Message-ID: <20260902073334.397685-3-ruanjinjie@huawei.com>
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

Replace the smp_wmb()/smp_rmb() barrier pair with
smp_store_release()/smp_load_acquire() on
vg->vlan_devices_arrays[pidx][vidx].

vlan_group_prealloc_vid() publishes the array pointer via release;
__vlan_group_get_device() acquires it before accessing the array,
ensuring the allocated entries are visible.

No functional change intended.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Assisted-by: DeepSeek:DeepSeek-V3
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 net/8021q/vlan.c | 6 ++----
 net/8021q/vlan.h | 8 +++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 6df80cad40a2..ec9a7cc8afc7 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -70,10 +70,8 @@ static int vlan_group_prealloc_vid(struct vlan_group *vg,
 	if (array == NULL)
 		return -ENOBUFS;
 
-	/* paired with smp_rmb() in __vlan_group_get_device() */
-	smp_wmb();
-
-	vg->vlan_devices_arrays[pidx][vidx] = array;
+	/* paired with smp_load_acquire() in __vlan_group_get_device() */
+	smp_store_release(&vg->vlan_devices_arrays[pidx][vidx], array);
 	return 0;
 }
 
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 3cb4c8294130..d874ab323d32 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -56,11 +56,9 @@ static inline struct net_device *__vlan_group_get_device(struct vlan_group *vg,
 {
 	struct net_device __rcu **array;
 
-	array = vg->vlan_devices_arrays[pidx]
-				       [vlan_id / VLAN_GROUP_ARRAY_PART_LEN];
-
-	/* paired with smp_wmb() in vlan_group_prealloc_vid() */
-	smp_rmb();
+	/* Pairs with smp_store_release() in vlan_group_prealloc_vid() */
+	array = smp_load_acquire(&vg->vlan_devices_arrays[pidx]
+				 [vlan_id / VLAN_GROUP_ARRAY_PART_LEN]);
 
 	return array ? rcu_dereference_raw(array[vlan_id % VLAN_GROUP_ARRAY_PART_LEN]) : NULL;
 }
-- 
2.34.1

