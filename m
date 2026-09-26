Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC9372049
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442304; cv=none; b=Ljti9xQpe/aHxeVLw+8LvpXH4tMtHjbrzLP++dN8qaLH5NrVCrItCFq0cTrp26wGz0d1RqIzjnDQ+DC8s0XmMxDu3TZQwCTPfadRYafurRSRI7ntv7jPRoBGYgK46wUsRcXY5swx3tmwCPb2b/V/+JzGpiEpKuHBAbmgW9e2h48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442304; c=relaxed/simple;
	bh=Fi/1kfxh/5xJvhFsjZtyC8k+s6AHgCpHivjoRYy1j5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHH12s+i4mpVx0sSKXVk/y5mye5t3fUq9L6PBTvR7VCQu6gdyMdB9Y4z2J7LMFlIYMOW8MncY/steS9c6dX5V0DkSx4MyEEFI85ZpcqCDcjyZgTycH214PaDVXsHJzIAcaUyQkPPv1q0wpB76OMQJJPmKuprj1Pq73yjqEVFPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=uYbKHKj1; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="uYbKHKj1"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e5eso713419a12.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790442302; x=1791047102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3r5hOlOFibYDjtqVxddRZ/SThl5LCtzkfgboA5uvPc=;
        b=uYbKHKj1oq1QJR0SXlc5EdsZ+DOxziN4z5VOBuGpGOfAzhrM+45ugAjSCX9s+Ewrbm
         c8xptd7IimPFeW6CMnWzncl5orj41czCogbKMqWay4yTT0zYsgpP7YCjAFajV5HUe4mu
         v7OIuL5zhb1Q34QLiHHOvYnhE6s9673S0zIybTjqGV0onkX+wo21QodxsT73TaXXjBAK
         /jQxSa1SfdBtug7F0YR+nWOkL4ZTDPURtenu3suhFot7ajIRBEayKTrUrpebtCgUG1s+
         kzR6MFMTxdGRRM0sGHeAyVAVHO42kN7qOTDfMrSp7TasmbiSK3B9dcUrmp1udv+OB0CU
         Y5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790442302; x=1791047102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3r5hOlOFibYDjtqVxddRZ/SThl5LCtzkfgboA5uvPc=;
        b=eiZA+bA8y8xJ7WRA5oahpNRhSQByySjbcxKJCv4LCUnLKv87ySOnczB14QuGnMNME6
         v+irMR6cmbVSPGD7fQ1KqIYdC3rGuZYB5sxlo+Kj93TUQcwxHCGrROVw1vNG8689ciHl
         W4KkFGmBPd91Yva8KkXemL9MhezUlKpHJBCTUSWRaydFWhLxEBJBYCuTv/CHFCJ5Kow+
         PfABn9slwaJKJAhg3lRUwIQVyFc0CO66ZloKCOqXiukgtek40Lx7pjRWrCebR77LHnwZ
         0MmCMnrNdLsw4GbkoTCEVEgmOiVngMaX2yffemQq0qMyFE7HTxIfBsiq2IZqNGzCnt/4
         Fckw==
X-Forwarded-Encrypted: i=1; AKwUvBzNJZ7ejn7tFuVHAoHV1oKZgR9JOLM3nYX2KHj6Qn/CEodQotM+TfKlNVzhpuNjL6bmhuI4ht8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLs1lIvnCoSXxTqQbdn/ml1FW0Layh80AQicpxKQNjTuMW1FVRz
	2fzDVnSkq/WYDwkZmRJ4YQk8teMTVmCOMwC+h3SXOkWEVlSAQqoVYSOFZM0/upRxWxAL
X-Gm-Gg: AYBFou1TjhuixEzZ9vAunjhjfr06BjTWMGP8cHJn8nlU5LR8i/SWo7/wB0aJEKvvJxN
	fhUwaFgoLNht1r3cVrJHY+M+TUEdpXD1ySRcliPV3jXuI+yla4Oj007riPVLlTnbUusE4yfOQB1
	Xs0H+32R/CM2s7fRYh3G0fgptLa9Xk1mvBYPWzyUuRqqJxNiPzM4JdKlMKklfXHTsgY/MsnjRsB
	eAj2PwUckGYlcHuzhhnPEkjxIQEDjyh86ucdoh6jRZTErZZcrWf1oZ/RV3pLRLwsbGQ3N0SsUZO
	UZt+GF7U1PUd/Q95KAP3bRcUSI9UIp3fLD2fUW5nKpxtHblgkrbPK7TZaSbPPSmdkHngKYQ8jtw
	NqPyhqHmS90M3+oKy4Yb/95yOWrt5wDWAHiLyAqIPKfD3lhUiacnlFaYie31I3YLUWqAuMcG2b8
	aXxa2QIM/VKMA7TdpoAD1zfjB8jgw/fY8F3gceRPPnVKU49c6Z18Yfu5+r99mHcHFVeuJAumYB/
	ILBrunj
X-Received: by 2002:a17:90b:3c87:b0:39e:4c7e:f040 with SMTP id 98e67ed59e1d1-3a098b9e6f8mr7273421a91.29.1790442300945;
        Sat, 26 Sep 2026 10:05:00 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791c072sm2540444a12.15.2026.09.26.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:05:00 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: bridge: avoid recursive multicast port cleanup
Date: Sun, 27 Sep 2026 01:04:39 +0800
Message-ID: <22b6678adf1451f4dd5bdd34b4f5288d725dd13f.1790323012.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790323012.git.petalzu987@gmail.com>
References: <cover.1790323012.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

br_multicast_sg_del_exclude_ports() removes automatically added STAR_EXCL
port groups by calling br_multicast_del_pg(). For S,G entries, that
deletion calls back into br_multicast_sg_del_exclude_ports(), so a large
number of STAR_EXCL ports consumes one kernel stack frame per port and can
hit the stack guard page.

Keep the complete port-group deletion path for cleanup, but suppress the
S,G exclude-port cleanup while that helper is already walking the same
entry. Normal deletion callers retain the existing behavior.

Fixes: 8266a0491e92 ("net: bridge: mcast: handle port group filter modes")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/bridge/br_multicast.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2f9bb30e1a1f..3fbad7b59769 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -81,6 +81,10 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 			 bool blocked);
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg);
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports);
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx);
 
 static int br_mc_disabled_update(struct net_device *dev, bool value,
@@ -458,7 +462,7 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 	for (pp = &sgmp->ports;
 	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
 		if (!(p->flags & MDB_PG_FLAGS_PERMANENT))
-			br_multicast_del_pg(sgmp, p, pp);
+			__br_multicast_del_pg(sgmp, p, pp, false);
 		else
 			pp = &p->next;
 	}
@@ -799,9 +803,10 @@ static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
 	kfree_rcu(pg, rcu);
 }
 
-void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
-			 struct net_bridge_port_group *pg,
-			 struct net_bridge_port_group __rcu **pp)
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports)
 {
 	struct net_bridge *br = pg->key.port->br;
 	struct net_bridge_group_src *ent;
@@ -820,7 +825,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	if (!br_multicast_is_star_g(&mp->addr)) {
 		rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
 				       br_sg_port_rht_params);
-		br_multicast_sg_del_exclude_ports(mp);
+		if (sg_del_exclude_ports)
+			br_multicast_sg_del_exclude_ports(mp);
 	} else {
 		br_multicast_star_g_handle_mode(pg, MCAST_INCLUDE);
 	}
@@ -832,6 +838,13 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 		mod_timer(&mp->timer, jiffies);
 }
 
+void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+			 struct net_bridge_port_group *pg,
+			 struct net_bridge_port_group __rcu **pp)
+{
+	__br_multicast_del_pg(mp, pg, pp, true);
+}
+
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg)
 {
-- 
2.34.1
