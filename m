Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73F3DB620
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174844; cv=none; b=UcaEo4f+FGa2rPmPBFiy8ys51wghuuGZiFNUaM9O7SlLrOZsfwDdB2xiBk640RNQ8aQ75ORXTc5jAJNpc5no82z1JWmA345Q4MqT1wB/xKH6N1p7muGJm75GfFX3EZbphARJOzqbqobQDEW3/mFJzl6Jg6yjTvY0vTjPpQQPYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174844; c=relaxed/simple;
	bh=6oLHWoiKE6PxbL40mPCFbnvkhnQ7KTpkUturhUz+hPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlnFRm25vdlYrYSIf7VEmRhhLsoYwj3lMTtskjc6nkegJlYkivLqtge/NLg/nX56zZtaNmxMqNy5o9aUhiqxZ2TviVVyaQ+Cx9WAP7Edi0TcSsBEw9txHz9wgXi60k1O/UGfrA15XQcvNK4twfbb8ooNqLy2uZh7yQfqQZHv0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3zeQyxe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3zeQyxe"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-855d2bfae95so3397682b3a.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788174842; x=1788779642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/7mL4yqWLEKqVvJuqvWtKvTVqgdZx0s+TSdJcgWJMQ=;
        b=M3zeQyxeJ1x/YJxQdUeZmf/JfrgaZB+HBLciaRosKYjjbT/9mOmcBbCS/WNW5JocKs
         9X8EjrVHKG3fQSGZ7rqF8sLh5NdpX5e4GolQfzp1FVOaexU77E01wVa5c8v4rU7q+p/O
         wwRNKWwJn2WCl32Qd/G84NOX59UOpoSL7fLrw8dvv6Na2jwdIL8MaWmARMjCO9KguqUJ
         47swK1WlAEnmWTTUrLOcHNYVhoz3qLxJSnlXgNFYyVJ5m58i1OsgRirEhb8Tu1fEvC0C
         XwVPczhqz+91zKKUSLOJRnHuzHG5Ge3m0sNMgrq2ay7vC0z+42cYaCtR2gpFmlTD6SCn
         9hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174842; x=1788779642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/7mL4yqWLEKqVvJuqvWtKvTVqgdZx0s+TSdJcgWJMQ=;
        b=FCKng/gLrSGdQIoRnYfiTF+wJR4mwj1I6//rDNudFpVmBfiZDV+CwZ/439ZYUuZiu7
         Rt3ByhFWZjYX398Qbl9cKouuLm5Hu4mMOgZVexc2+598PMd5j0T/+T7KEqxT71+Gv7wP
         Rp7um8+Szt7YBxs4VoGk38ByQPEkWrk8Tp+Cu9djDEXUZ+pdGeGMMqK7iPpNWpu6BTE9
         hApUxMQnFhde4WJWBlTk7nz5KH8SYdOWimI7xNAKTStcUQXN8JK2yEM8vR2WqlVk2zgv
         pNYNpm2x8Jq+QcNQR2tKAEzwmON1hg2D0FRIUeCrFDk1WcAeejU0Q+F4TyPM/T2s9Q40
         WhhA==
X-Forwarded-Encrypted: i=1; AHgh+RoIiqfeNY+KKxA640cbSujNWMWkbLPKiXVjpIIv35axGX6wXkmz0UZOuyKW0XU6onKRHo7FU2I=@vger.kernel.org
X-Gm-Message-State: AFuF++n9XVwFUld7w2QZw7SdbPI4zMlOrQwWfq+V/8YHFt4aybnQr9BG
	2QeaRTQOnxWDsS+kmDRPm5Kgcuoo5TqZ2x4+GIKba5D7sAqlwwVzmE/F
X-Gm-Gg: AR+sD12tu8cY+xn9Bfotsat45p2LVTK3m7Bp/dWT6MlvKbvLrcAEm0gMJqp/q/UhUVl
	XEfHSTjLaoGamRmcKCkU4B97ulm9P5BuLyJ2guNcaG04+A0zLZWP3S7qJeYWDswGuM6lLDsXkMf
	bliTN9NYNw6WYwuYpIyjfd7FN1mmgM1WFKCcyUTlAurFdAuoqWzYThxZAEgCOpYvq0OUc1Zjo0R
	EG6zBjW4I+6m3hCfb3rtHicKKXdzq0z9WiSggs1B4gXN+36jR0+r+j+6rbq4MdSGRxz0ZVi/OJ7
	IsG3iPpZV5RxJ3E0XDIrr25u6MLSlg6Lu6ZJ7bphaeYuholVD4ugPXrdozYpBlA/+4Q5RE5gwgA
	ZkABJKX1Y+EQNjrtfJlY6fW/J04ygbjFYYvjAZ0Pi094Vt478j98RjADCEHl/Bpmv7Q43+prK4B
	BEcVx1H8Jdb8c3svxekCE1DYWmNVkORdAGSTawDa4cSQeeaHqHSbfrIEjFMANA8siA2lx/nYb2I
	g==
X-Received: by 2002:a05:6a21:3216:b0:3d3:aed2:6f27 with SMTP id adf61e73a8af0-3d5da1aa7bamr6686426637.27.1788174842238;
        Mon, 31 Aug 2026 04:14:02 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36aeb7esm4133282a12.15.2026.08.31.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:14:01 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>
Subject: [PATCH net v3] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Mon, 31 Aug 2026 19:13:04 +0800
Message-ID: <20260831111330.199543-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__br_multicast_disable_port_ctx() and br_multicast_del_port() walk
port->mglist with hlist_for_each_entry_safe(). However,
br_multicast_find_del_pg() can also delete other entries from the same
list through br_multicast_fwd_src_remove() or __fwd_del_star_excl().

If such an entry is the iterator's saved next node, hlist_del_init()
clears its ->next and terminates the walk early. The reproducer triggers
this in both teardown walks, leaving port groups in the bridge mdb with
a dangling ->key.port after del_nbp() frees the port:

  BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
   __mdb_fill_info+0x1191/0x1320
   br_mdb_dump+0x594/0xe40
   rtnl_mdb_dump+0x1cf/0x5d0

Use hlist_del_init_rcu() to unlink the group while preserving ->next.
br_multicast_del_pg() and the teardown walks run under
br->multicast_lock. The GC worker must acquire the same lock before
detaching the group for destruction, so the node remains alive while
the walk uses the preserved pointer.

Preserving ->next means a walk can now reach a group that an earlier
iteration already deleted as a side effect. That group is off mp->ports,
so br_multicast_find_del_pg() would fall through its port scan and hit
the trailing WARN_ON(1). Skip such groups at the top of that helper: a
port group is put on port->mglist when it is created and only unlinked
when it is deleted, so hlist_unhashed() identifies exactly this case.

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v3: skip already-unlinked groups at the top of br_multicast_find_del_pg()
    instead of in each teardown walk, per Nikolay's suggestion, so the
    preserved ->next no longer leads to the trailing WARN_ON(1).

v2: https://lore.kernel.org/netdev/20260826014200.362304-1-littleddfu@gmail.com/
    Use hlist_del_init_rcu() to preserve ->next, as suggested by Nikolay,
    instead of restarting the walks.

v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/

 net/bridge/br_multicast.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..ea0a50eb8b77 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -808,7 +808,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	struct hlist_node *tmp;
 
 	rcu_assign_pointer(*pp, pg->next);
-	hlist_del_init(&pg->mglist);
+	/* Keep ->next (held under multicast_lock, freed later by the GC work):
+	 * a port->mglist teardown walk may have latched this node as its next,
+	 * and deleting other groups of the same port must not truncate it.
+	 */
+	hlist_del_init_rcu(&pg->mglist);
 	br_multicast_eht_clean_sets(pg);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent, false);
@@ -835,6 +839,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 
+	/* A teardown walk over port->mglist can reach a group that an earlier
+	 * iteration already deleted as a side effect. It is off mp->ports by
+	 * now, so skip it instead of falling through to the WARN_ON() below.
+	 */
+	if (hlist_unhashed(&pg->mglist))
+		return;
+
 	mp = br_mdb_ip_get(br, &pg->key.addr);
 	if (WARN_ON(!mp))
 		return;
-- 
2.43.7

