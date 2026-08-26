Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60253209F43
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708567; cv=none; b=YVpHG1WUaz4FThbQXddfVCIeQZDY9QXyJMw4w8x0Y81OVoZnzgQ/uTPfW2aXaNk9QD7NhKk9vRrDduqfDC+oHasokfNJLmN3xkt7mo2X8+MxJuulB8yqrhGRiqDgtxnc5i/3NaexpBW18Iq2ftLONzrZEftd19Yzh0dp5WwIpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708567; c=relaxed/simple;
	bh=xkHYSMpPHPn5UAznXrMTLNZUM0GY8dMnzzBw3PK9Ecw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJ7DG3E1tGDI95i/Bov2PNBHgrLs8Cv60m/Ps+kaDiUXsOdiUqlzTBvNUfA/039UVqesvx+5UIfGseRF+jjTyvCly31tHWvMfS2wXyx1/ns+H0sbUJYu8Nu+yya71IjCGAmB3AI9QnDAh5LLNcCevGrvy9RxGm12sY9Jk7Lxmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9HoidBc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9HoidBc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so6254985ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787708566; x=1788313366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uX7w3zYS1582cLpnHIAGQCV970wUYP+EwxQlHWpL6X4=;
        b=B9HoidBcZfe0MNEqv7cPNTqvIn2B9ESx4YCTXc7sA/nCA3hQAb4DZ2oStAr7BbfnWo
         4Uvsye6HVBhZxqSZEA51IRGDDeBJUt6rfo8qioljVPGUt2knqgya5Jk1t89WkDcfIy9q
         ofI3QlaByJiUx3PKNhaKfp14dqxzBjVRfM2dSSzP3CSEfuzpTqFTWz0MUyYx/iUHsIpT
         53mxZjPWO5T6/X5pB60hgD9sdTk69yYp72TwWyOJ8CfLQYGMCBUufM55/Um18aNGUHsr
         avaI3LKTZ5DB4AcC+LQHA2U3svJh+Mu0/04k1RfO2GGnoYGnuJeAfo1qepqSbitFf2mP
         pE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787708566; x=1788313366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uX7w3zYS1582cLpnHIAGQCV970wUYP+EwxQlHWpL6X4=;
        b=ARbbj4P+VQKHSQqoAlTc+H69KF1TRjqcgZV6wc3BimM5Ciwdwbl0vvGbh4rZbS0/iY
         DBA5YH3MjHdCVTeYCliiZTJrR+5HrlFD+NaeeYUWs28SVYNxW4Hw1NrMis9g6bZQYXeN
         AFRxVrURWZsDOP/s5jrQGCEFdsAkaMM9ufRzpdQJD0v43V92lgIgy7MN8JThGe1VUnc/
         7zFQTp5rYuu6+waqVXEWz5OzCdC6wvRGtXxGTABgXYXUOh0H98/Tk+EZOvKgJF6C2Ldv
         Nv+ZX8f1w4kFtNLCYl6SMngYDiTzilWMT8HgOL+81rN+it90wtfgynVkySAXor699qHM
         KqRA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1dqUbDuXun+j9XMRW63UTHYHSCHOD+hIpeH5XCkfa7DrEMhpHxC2V/UawSfjGveMbrRim1b4=@vger.kernel.org
X-Gm-Message-State: AFuF++l0qrpEoA/9RQenhR9bJum+7umQgIUg0REESsjkxO1RHWHgs+Iy
	laiMdYSDOz38xo80NINTJZhPz8MTgeN4OjXyYJgyelVlqEQO26sOGZXo
X-Gm-Gg: AR+sD11rv6JwmmtV+wE2QR5EBA9sbK5W82SYGiJmi/RaPfnPnKg6gMy4sAwlo0oXiYS
	UKcByOg9U0PZaviZDbEvyfhIxsiwOrYuOot+6Kkltlj9GUgBiUraV2R5gN3jlzgz9OB20e0hKtT
	dO1GB1ps9dhQdJ/hRZNyaTmz9v/mhecEgVP2ojbBgS7Nr8xtIt9/nRp/xInVTGACUQAckG4K1Pu
	vEcTslpW7dddbjKg546EHSgBYFka8WPktvw4YliSp9K9pnKqgzzAHnfCe2T5vjrDRT46o9p74vp
	dDlUQ3cC6GaGErvCNaEWzh2oz/TUJbjr3t1dB6pYfu+jgAK/ozK4XnxsedL33vsdF8HwCnqUdBe
	mSU31HkGQVLp6JuxJH1/ex43pK7uXMFl8HhWKRhB5xs4+r3T6JaBAkgpmVkPgKsY0A9dX5jSWId
	u7P4MniH06uFFTw5Ek2kqlJcpGT3m4vXtGl0bFwMaHS8McmuxgnB18wJdKxfNtjQ==
X-Received: by 2002:a17:903:2c03:b0:2d6:ee6b:1b08 with SMTP id d9443c01a7336-2d707a2f363mr42050785ad.3.1787708565680;
        Tue, 25 Aug 2026 18:42:45 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7049aac32sm2943735ad.33.2026.08.25.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:42:45 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
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
Subject: [PATCH net v2] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Wed, 26 Aug 2026 09:41:44 +0800
Message-ID: <20260826014200.362304-1-littleddfu@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

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

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v2: delete with hlist_del_init_rcu() to preserve ->next for an in-progress
    teardown walk, per Nikolay's suggestion, instead of restarting the walks.
    Tested on 7.2-rc7 with KASAN: the original use-after-free is no longer
    reported.

v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/

 net/bridge/br_multicast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..8022c7f12169 100644
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
-- 
2.43.7

