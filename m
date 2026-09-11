Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087A4BEE45
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163543; cv=none; b=BvXhGeyuhJBJKsN945fJvBftGKNa8wbRtglws0Dh7JoVPUpeMF25wQuqwQU+Z5g2dptlOlRrGVPn2KsPTf5THm4weRScm1yuZaIq0kXp6/i9+3zOvgoC34K3T1ISIMtfqzFIjZEMfpy9/Ckc9gI8nM1SDXApczWct8ZDrvN8rGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163543; c=relaxed/simple;
	bh=8fizyRXRwZWA30/x0S5/rc5j+e9AYRKrUbag3/LipDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fyReVv6SJMk6WWR0X5HzOSgFBJenXLfTTN86r6ox8T81tdft1KiQ9uk4/iXZHx/MryiKg9QqvR/r9d7UnAMH+IkiRHpQ5nJ4FGCILJT3oF8Eg2/yrok8NlHzBxAgLQqgsq2dttgaRU5nB0RdYLyZDpOXxKt1+Je/2K9W1P6IsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJZMqffW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJZMqffW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso11742055e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789163539; x=1789768339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPdkLtNhMgfXo64yGcGD4Px98Z89kU0OqiOuJ6Ovxxk=;
        b=pJZMqffWPY4jqWhBvkEBwCkiKj/osrGIorH+a0KYmvm6iLC6BQIGknS7iEKvJxHkWD
         d+6cQ6J5jsnW/vLJWfwM3Y+5eg/oZiPMcF4DIe2VfHl8fT+EReEpnOW1MXRrWgZOWvPX
         debaPPZpXc5SZjGUblsLjwXtR9fTlCRVvZjazMs1DbP2OlDyoFdyvRQMlJmuizbNfCwI
         9K/+mShGwWR1tiKT6jeX9EqpO+PTzU0HKg6AClyBHNsLtXynJ+qRKVPYiEMaa/Gd+ilx
         5zw1zDuUcc8fmZHcE0kNEnq4ISaAV0MFLLxxhZHZDehbaKfEj9mBSqehSvaiHFCrfXy4
         qqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163539; x=1789768339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPdkLtNhMgfXo64yGcGD4Px98Z89kU0OqiOuJ6Ovxxk=;
        b=XbyLP9iXKGldj7ZNyY88eOUNikOUoIaGEXBmiQtz3jaj5fxC72BXiXTSIkYhvruYWW
         7r8VNQWt1Q/4SS8vI4d0enhaFUz2S5a68l7fpv2+MwjT2316hIw43VI3l4DZY8KsDz+S
         3EKqmNLwoR2LFhxXF+cFX3CfNKfimoccCMOBqE1zb6amInUaQ7rkoNRHqYd4Kz0P4g2i
         L7rYhxNb2rLjTNCWCrygXaa9kxc6RswL+KNRYMxuEJ0uXPk4O9jppjyu86eguVwsGTc3
         5CDQUOu2ncyyjc1tUJOPVRuHjYK9T5K2YOVmaDqNXIEpOrUld1lh6gWEaEwmqjIkglOD
         q8Kg==
X-Gm-Message-State: AFuF++nMhLTAyo/eng/sl9xySZUnGnFJEUeG3JhyXNTDn+y0ilZJHzkC
	PDG0Ig6lP2Ws5QWbLnlJJ2gnv0jpnWumm/QQw2fub+dmM3vE0CovQJpTGBjdofeLTig=
X-Gm-Gg: AYBFou3dH9vSldNBIVBJezclPAr9SUEE/sQpCBc58Fqnks5SpQsWY7uUYRbpZpjLPSf
	MR8ts+oeoUy5Ff2ctYnyl8KxV10596gwbFiF+1Xr62ApT03brzw8FtCZ8ZP7UWe8IGUuhSX0v4t
	xUHJmojE5fDf1g8Vl8umZ2VEv7HkRCpOClGRLnJ+ghBFhY7VznZu1/0lThOpsqu1DPw/zOWnISe
	rbsIjifSU5/c/EsFreTHICXRWK67d4N5V+FWqDiWY0wdAsfm8Gqk/2f/IjCizxaU7/tbXxI7xRi
	DJKyawv4fw4oqcdeXzu1ZjLxUVLmufplo7s8mkmV9ZZHJ/npd7KXq4ncfF7hJRehk0E8MP3Rw7a
	MRN+D0JXPrIbb5T/XjFCLb3IOA9HBHLLcRNOFuaIQYOjp8RiQIiJM/ideOyg/OS7oAgx5t0z4Uc
	MKoDlgKD2+Ov2u/KkjNSME+3GE4ZorB+Vxd4qh4pIVmuGy2yzKuZrJYRjevykst6+gG3y8j2VSL
	cwQNd+f8N1xULJnpP2HVsHr
X-Received: by 2002:a05:600c:3b1f:b0:49c:fc89:59cb with SMTP id 5b1f17b1804b1-49e61983468mr75782205e9.5.1789163539317;
        Fri, 11 Sep 2026 14:52:19 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm177081345e9.3.2026.09.11.14.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:52:18 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	roopa@nvidia.com,
	bestswngs@gmail.com,
	xmei5@asu.edu,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net v2 1/2] vxlan: report whether vxlan_fdb_update() created the remote
Date: Sat, 12 Sep 2026 00:52:02 +0300
Message-ID: <20260911215203.3054653-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is plumbing only and changes no behaviour on its own.

The rollback added in the next patch has to tell an FDB entry that the
failing request created from one that was already there, and today it
cannot: vxlan_fdb_update() returns 0 in both cases.
vxlan_fdb_append() does return 1 when it links a new remote, but
vxlan_fdb_update_existing() folds that into its local notify flag and
returns 0 regardless, and vxlan_fdb_update_create() returns 0 as well.

Add an optional bool *created out-parameter and set it in both paths.
All six existing callers pass NULL, so nothing observable changes.

Every statement added here is either a signature or argument change or
is guarded by the new flag. tools/testing/selftests/net/
test_vxlan_vnifiltering.sh gives 27 passed and 0 failed with this patch
alone, identical to the base it applies to.

Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c      | 29 +++++++++++++++++++----------
 drivers/net/vxlan/vxlan_private.h   |  3 ++-
 drivers/net/vxlan/vxlan_vnifilter.c |  2 +-
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index be95af64a1f5..0652dc471dca 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -974,7 +974,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 				     __be16 port, __be32 vni,
 				     __u32 ifindex, __u16 ndm_flags,
 				     struct vxlan_fdb *f, u32 nhid,
-				     bool swdev_notify,
+				     bool swdev_notify, bool *created,
 				     struct netlink_ext_ack *extack)
 {
 	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
@@ -1042,6 +1042,8 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 
 		if (rc < 0)
 			return rc;
+		if (rc && created)
+			*created = true;
 		notify |= rc;
 	}
 
@@ -1078,7 +1080,7 @@ static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
 				   __u16 state, __u16 flags,
 				   __be16 port, __be32 src_vni, __be32 vni,
 				   __u32 ifindex, __u16 ndm_flags, u32 nhid,
-				   bool swdev_notify,
+				   bool swdev_notify, bool *created,
 				   struct netlink_ext_ack *extack)
 {
 	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
@@ -1101,6 +1103,9 @@ static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
 	if (rc)
 		goto err_notify;
 
+	if (created)
+		*created = true;
+
 	return 0;
 
 err_notify:
@@ -1114,7 +1119,7 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		     __u16 state, __u16 flags,
 		     __be16 port, __be32 src_vni, __be32 vni,
 		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
-		     bool swdev_notify,
+		     bool swdev_notify, bool *created,
 		     struct netlink_ext_ack *extack)
 {
 	struct vxlan_fdb *f;
@@ -1129,7 +1134,8 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 
 		return vxlan_fdb_update_existing(vxlan, ip, state, flags, port,
 						 vni, ifindex, ndm_flags, f,
-						 nhid, swdev_notify, extack);
+						 nhid, swdev_notify, created,
+						 extack);
 	} else {
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
@@ -1137,7 +1143,7 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		return vxlan_fdb_update_create(vxlan, mac, ip, state, flags,
 					       port, src_vni, vni, ifindex,
 					       ndm_flags, nhid, swdev_notify,
-					       extack);
+					       created, extack);
 	}
 }
 
@@ -1275,7 +1281,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
 			       port, src_vni, vni, ifindex,
 			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
-			       nhid, true, extack);
+			       nhid, true, NULL, extack);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	if (!err)
@@ -1491,7 +1497,8 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 					 vxlan->cfg.dst_port,
 					 vni,
 					 vxlan->default_dst.remote_vni,
-					 ifindex, NTF_SELF, 0, true, NULL);
+					 ifindex, NTF_SELF, 0, true, NULL,
+					 NULL);
 		spin_unlock(&vxlan->hash_lock);
 	}
 
@@ -4034,7 +4041,8 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 				       dst->remote_vni,
 				       dst->remote_vni,
 				       dst->remote_ifindex,
-				       NTF_SELF, 0, true, extack);
+				       NTF_SELF, 0, true, NULL,
+				       extack);
 		spin_unlock_bh(&vxlan->hash_lock);
 		if (err)
 			goto unlink;
@@ -4485,7 +4493,8 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       vxlan->cfg.dst_port,
 					       conf.vni, conf.vni,
 					       conf.remote_ifindex,
-					       NTF_SELF, 0, true, extack);
+					       NTF_SELF, 0, true, NULL,
+					       extack);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
 				netdev_adjacent_change_abort(dst->remote_dev,
@@ -4806,7 +4815,7 @@ vxlan_fdb_external_learn_add(struct net_device *dev,
 			       fdb_info->remote_vni,
 			       fdb_info->remote_ifindex,
 			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
-			       0, false, extack);
+			       0, false, NULL, extack);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	return err;
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b1eec2216360..e52755923c31 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -193,7 +193,8 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		     __u16 state, __u16 flags,
 		     __be16 port, __be32 src_vni, __be32 vni,
 		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
-		     bool swdev_notify, struct netlink_ext_ack *extack);
+		     bool swdev_notify, bool *created,
+		     struct netlink_ext_ack *extack);
 void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc);
 int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e0886..7e8abc55ef53 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -488,7 +488,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       vni,
 				       vni,
 				       dst->remote_ifindex,
-				       NTF_SELF, 0, true, extack);
+				       NTF_SELF, 0, true, NULL, extack);
 		if (err) {
 			spin_unlock_bh(&vxlan->hash_lock);
 			return err;
-- 
2.53.0

