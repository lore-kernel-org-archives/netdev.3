Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1E3C4B91
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264469; cv=none; b=Z6OCqypR8rrNi4dxG3c1+pxkKwZ3LFChYW8/XXndVmCVFsfQ1zTN6Dx1Kvdysa68jxsOAjiwlcSqXqURimPx1tHi+OlNsDGKry8JYvcjfSlfuwCKT/UvcZ4CxzPthRnHbFIl/IbaLldCTv+vgtjxbAZuoHSr+Xk9s51LudBRyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264469; c=relaxed/simple;
	bh=yJfkb3hM5Pba0nKvWUAIgOdfux2UtM7ON45POiZc+dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GF60EpwRXi8eSnTKB1NTVVeLEC0OhTvv3WRzQw1Z4uv4j9XRu27ekEN6ff0HnmzPTZVzFk/VSUFl/ZA17iydCgaeCsktNH9GV1T5xz+UxmILaSan+0+y0Ebz9/+qu/oKXWQAEMfHBgyQEyUjbLdEA3qmdVGoKkFLP4N2c72k79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=jQxtQsD9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="jQxtQsD9"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so37737925e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264466; x=1788869266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HFs9DuHBOZWo0pRLMgZ/aZaO5LCPX7IYZ0kiem5E6M=;
        b=jQxtQsD9T8/2AuY3i5y9a5gdlUzDkRdrD5/1Ii2mre7kDtGlNg5tHoWuCkBqEXDRw1
         w1Ri5KlPCF7vys6CBatR3tWgTautO8t/zMOu4E9dkjT5sFmc5DcxznFyXvGuT009EVOG
         33oWyabis5MXEFpdsLL3aQk2isllnPOtKld2Dqs+kS3BJvvNJ6c5qq3dC4eP1hCR8vxD
         FL46tPJLfcBbJi6Nab5Pfyqpw24OM/tl2TqTADyOlQ4tSsEl7+vN0Dg4c3c1qGNTDLPT
         LQ8cuY5bbD7VzYOb3Byxek9eAwWDXZF0z5nmM27LM2dQHdIAgex3WEU9HwR0KAMzAwPb
         Jxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264466; x=1788869266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2HFs9DuHBOZWo0pRLMgZ/aZaO5LCPX7IYZ0kiem5E6M=;
        b=dPR5I8YzPGD+ztLHw//eMGGF4N6TWl3tDnvvtff4Wqv+KP42OWLa6MNG6oOSneXyIj
         UFSa0Nvdxwmb6mpfxMVio3Lr457TZ2RnmehGGLUYZ/ZCWKRgL6m53AESWg4cWpLovn8B
         v7zkpspW1x9EvHMmfTd235V9rJCv5Vt2tOXGWA8+btv4syaWE+kmtM7iYMO8uhF6ruhh
         7TGprIudN6hLMCCYGJyTgHoIuBOhP3499ErY1dgKVmuITCe3CCq1OqDgY1u4oVKQ5fIo
         pqJPkPhcHVn1cxQS38YDdHQccvFp4dcVi/J94a0hERwQkTt76Uv9wdGNrbM0bOuV3A2V
         jQ8Q==
X-Gm-Message-State: AFuF++kfv9Fb3jf+H073JYgxAGK0hbujdPGwfYLhmwfGV6RKowpsrXGT
	WnfuPTxq1Ecr+XCv2TLkbvKco+IqiX5n2HyDgq9EPUB6S21GaU2beAI4xx5Ilggp1oPkPoaz6Vf
	bD9bkdSH9gQ==
X-Gm-Gg: AR+sD135i3NdY+6p0jZvQHy5aZW92ZqSU5cnrTW4a8nlfbFRdj9BkI6cdGAIUUPg0nz
	+9ABHIsoe1aj1+HHEy/Q6kCJDPw7yKYXoqJF9qzWGRwzrKItewSHQam6FOwFpeazo17dB5Af6rX
	yAXSnv4cktQ7QYwt3i4ShohxtjJITc5EPoW4MndVzmqQbWF2Iyh8Xus/jwFlwwjRN9hBK8nJ1p9
	MmJ747jijuJgPQYrTE/MfEUMLIHGrmSL2bBnBVcRgXp4jZ9Tdod2dg0c++OLVYcb8wVkIM+mtXy
	GOpjYes/VkKobTKITY0ress6KtWLJkOz/mSDQkEKwk8IQ+M7MmvhMIPtx/tD5Y2d4QXScHRvpGa
	MF5vQOvVXM+XnDwtHlYXn2ayrcSo6bSBEsPYR/CTtD+wLRlGOFsw4GaiQ6MR9JHE3pdnQ9sZDqz
	IrA3mHk7YpaH/PSFypOnhyGP93olGDEN7wy2TyM0sT8ADAaaI8nR/Poc7qXGsdzWlgGrnv4nkFn
	qLP3/yzF1g=
X-Received: by 2002:a05:600c:8107:b0:49c:d26a:cf70 with SMTP id 5b1f17b1804b1-49cd26ad005mr330907835e9.15.1788264465295;
        Tue, 01 Sep 2026 05:07:45 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cdce1a3fesm66474005e9.12.2026.09.01.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:44 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 6/9] net: bridge: vlan: annotate lockless use of num_vlans
Date: Tue,  1 Sep 2026 15:07:18 +0300
Message-ID: <20260901120721.747908-7-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate data races around vlan group's num_vlans, it can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_netlink.c |  4 ++--
 net/bridge/br_vlan.c    | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 62ce96d9ba32..ae76df0de05a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -81,7 +81,7 @@ static int br_get_num_vlan_infos(struct net_bridge_vlan_group *vg,
 		return 0;
 
 	if (filter_mask & RTEXT_FILTER_BRVLAN)
-		return vg->num_vlans;
+		return READ_ONCE(vg->num_vlans);
 
 	rcu_read_lock();
 	num_vlans = __get_num_vlan_infos(vg, filter_mask);
@@ -531,7 +531,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		else
 			vg = br_vlan_group_rcu(br);
 
-		if (!vg || !vg->num_vlans) {
+		if (!vg || !READ_ONCE(vg->num_vlans)) {
 			rcu_read_unlock();
 			goto done;
 		}
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 102792f20a5e..95187a607ec2 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -344,7 +344,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 				goto out_filt;
 			}
 		}
-		vg->num_vlans++;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans + 1);
 	}
 
 	/* set the state before publishing */
@@ -367,7 +367,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 out_fdb_insert:
 	if (br_vlan_should_use(v)) {
 		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
-		vg->num_vlans--;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans - 1);
 	}
 
 out_filt:
@@ -417,7 +417,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
 
 	if (br_vlan_should_use(v)) {
 		WRITE_ONCE(v->flags, v->flags & ~BRIDGE_VLAN_INFO_BRENTRY);
-		vg->num_vlans--;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans - 1);
 	}
 
 	if (masterv != v) {
@@ -695,7 +695,7 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
 		return true;
 
 	vg = nbp_vlan_group_rcu(p);
-	if (!vg || !vg->num_vlans)
+	if (!vg || !READ_ONCE(vg->num_vlans))
 		return false;
 
 	if (!br_vlan_get_tag(skb, vid) && skb->vlan_proto != br->vlan_proto)
@@ -757,7 +757,7 @@ static int br_vlan_add_existing(struct net_bridge *br,
 
 		refcount_inc(&vlan->refcnt);
 		WRITE_ONCE(vlan->flags, vlan->flags | BRIDGE_VLAN_INFO_BRENTRY);
-		vg->num_vlans++;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans + 1);
 		*changed = true;
 		br_multicast_toggle_one_vlan(vlan, true);
 	}
-- 
2.47.3

