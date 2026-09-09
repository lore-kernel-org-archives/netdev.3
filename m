Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95336E466
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974368; cv=none; b=kHXEVlI3zPkUTmRVeSwYJtKcorXUfyPFumCbeEvsjgrGE0GmL9I8sv2oClzeSDcUR638774Idv+UePXj7+8pw2f9fX60SqtPFdG45Nj8H6olIiSyvssB95P9rn6x0/vQ6vuuH14ejlulPtlP65XgziQm//MWwUEw/fI7MqyBWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974368; c=relaxed/simple;
	bh=8kIFCP4E8pMff/4MvsJkIzUFTt+S8MQ7T6gh0N3KGQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yk0pjiTgAnfhAglR85qLxYtrePsbPGEnrQrhyQgAfGnvaiIlCAUICk/570bW6HjI8R98KVYc+nyPWx3+HW1dLTJLGU/TkPZA/vmEfQbhw+XouC5VxNfMK4+gleJzBOwRPtOKYsJHhpcle/S7m/HFtP78g+PZz6+4cjSLKiX9JeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=BSrQc1r0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="BSrQc1r0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so48922145e9.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1788974365; x=1789579165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2lankMhKljfGqcOe/+EwZWVYhmCbtsmCmxJQsu9Mi40=;
        b=BSrQc1r0vFm6c5sG1ENKp3JVDR2s9pP5GHZZlYhvYCWzOptNBGXs0NSXk3UzJeYYKH
         2XJL9WCeKmoDrpSiG9YsKFU4Yvmb0tP+PTyDuu2WRmiIyLar4qgMy5siw2fQhc8XN5zd
         RJbtBQsSXDECVRr4nQyWXqo7fmx4qBXrzuGfprQ3LVLFU4x4v9eTbukL060ft3KXNp1H
         ufxYs81j3I7nhDykwvbeypo5rKp/0qlbxT5i5xnRz2Lq0pbprk6YLQKLsOZkzNQMz1zd
         ciK+UYaAhYpi9xCvLELWfAPaQQmtEQdh9wjEsCzaP3iZ8AxSYX26wgYqGLrstOy1X8m/
         KBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974365; x=1789579165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lankMhKljfGqcOe/+EwZWVYhmCbtsmCmxJQsu9Mi40=;
        b=qaiR9C+yCq/pPd3ELqZdjFwQIl64Hw6vqlqNA9KOKcfxFgmzYsASg0oMsy1Ne1pEd7
         54EAYyLHvzekTss5Ba8BkafFh6n2qLWzmTSG0X+OytVJhDhfs/wRC2Xck9dRK6ETDavR
         Nup/W5V9MvIznzar2cvqa9uXt9YCdYKo9qGmLyJu2zRjZCKnnZ6nskTdQc6s2iQb29Vo
         B1kZgzUldOrvOLdL08o++1/jXzySyPkBLiSb7SON+DnRWmAB40CqzDujQvnE0Ka0JLQ2
         4e2OmdXZzZyOkjv1RiGXkVVWinyXhzCzalvj3MV/W1jIjmUoDfVWxzU//9he2dsgIhlc
         L0eg==
X-Gm-Message-State: AFuF++nhCrXQoXZPg73enp/CcnHvMBVManOA640GMBPLT2eUcrk/9ej3
	30fvnc7m2KdC0nLMz6vp6LDf+g+zTGdm5N4vZ2OLNgzDWSRx/9aWo8IxLLDZ5wecOrlv0fQqhLT
	jc8kN
X-Gm-Gg: AYBFou25fEEx3pvlVM7c0yXTwdlEOI43RVpEPCIAn3wFTEi4kSawhSISJkwRRlr5YcC
	vvMIeIhKoFOSH5eLURlI5b9fuNoTMzXiAVbfCWUgUoJcxWwQ3OnFCCkCCLySdxU63gPkTmB0a3l
	J0nXxU/mImWGCrTc9OTaFPyyOwETyG8TUj8TyzVuOqflfDkWQTcgjHh1TvA3vQW44XyG7xdQC5y
	rZtw1TCXSYW386rwOfSYyBuLtVvUK2kbEWKhnuD0Mi29gWeeKFXgaQ0NLcMcJUIQ2kXQ7ND8wEw
	4C+4rDThSwvLA56SDR2zrscz9eTj0skC8hHvMMLKde1f8PZpHqQP+VKqXZEKHT6jil+VnkXeTsT
	NL48MshLHmcnwuKhsSbYafKHPg1GvZ/0lBTziFRajg2R2O4wixSRdracCya3epQP/i+VcCdwWr/
	qwJvU+XhrmDHI7pLzas7ziABClE1hXeY3CT22mtrpVmiucxv08Hdg9G+qH4BfetOlG44E=
X-Received: by 2002:a05:600c:5247:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49cf81dadcamr337791325e9.2.1788974364647;
        Wed, 09 Sep 2026 10:19:24 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3062:5db2:b6f:d44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2985dsm7395915e9.6.2026.09.09.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:19:23 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	"Denis V. Lunev" <den@openvz.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 1/1] openvswitch: disable BH once per netlink dump instead of per item
Date: Wed,  9 Sep 2026 19:19:20 +0200
Message-ID: <20260909171920.1001074-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis V. Lunev <den@openvz.org>

ovs_flow_cmd_dump() and ovs_vport_cmd_dump() release a BH-disabling
spinlock once per item they emit: stats->lock in ovs_flow_stats_get()
for every CPU that has touched the flow, and nsid_lock in
peernet2id_alloc() for every vport that lives in a foreign netns.
Every release is a local_bh_enable(), and each one runs the pending
softirq backlog in the dumping thread's own context.

The skb bounds how much work a dump callback does, which is why no
dumper carries a budget of its own, but it does not bound the softirq
work the callback absorbs. On a CPU that carries the box's packet load
the backlog refills as fast as it drains, so the dumping thread becomes
that CPU's softirq engine. It never sleeps and it has no reschedule
point, so under voluntary preemption nothing can take the CPU away from
it: neither the ksoftirqd the kernel woke to take the work over, nor
the stopper thread the softlockup detector dispatches to refresh its
timestamp. The watchdog then panics a node that has enough flows and
ports to keep the dump running.

ovs_flow_stats_get() used to do exactly this. One local_bh_disable()
around the whole per-CPU walk was added by commit 4f647e0a3c37
("openvswitch: fix a possible deadlock and lockdep warning") to close
an ABBA deadlock between two CPUs reading each other's stats.
Commit 63e7959c4b9b ("openvswitch: Per NUMA node flow stats.") dropped
that region the same day while reworking the stats layout, and replaced
it with a spin_lock_bh() per item. The deadlock stayed fixed; the
single region did not come back.

Hold BH off across the whole callback instead, the way
ctnetlink_dump_table() does. Both loops already run under
rcu_read_lock() and cannot sleep, so this forbids nothing that was
allowed before, and the nested spin_unlock_bh() in the callees stop
draining softirqs.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Aaron Conole <aconole@redhat.com>
CC: Eelco Chaudron <echaudro@redhat.com>
CC: Ilya Maximets <i.maximets@ovn.org>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
---
 net/openvswitch/datapath.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 631a03136fa1..ae2c9924aeb0 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1533,6 +1533,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	ti = rcu_dereference(dp->table.ti);
+	local_bh_disable();
 	for (;;) {
 		struct sw_flow *flow;
 		u32 bucket, obj;
@@ -1552,6 +1553,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[0] = bucket;
 		cb->args[1] = obj;
 	}
+	local_bh_enable();
 	rcu_read_unlock();
 	return skb->len;
 }
@@ -2565,6 +2567,7 @@ static int ovs_vport_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		rcu_read_unlock();
 		return -ENODEV;
 	}
+	local_bh_disable();
 	for (i = bucket; i < DP_VPORT_HASH_BUCKETS; i++) {
 		struct vport *vport;
 
@@ -2585,6 +2588,7 @@ static int ovs_vport_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		skip = 0;
 	}
 out:
+	local_bh_enable();
 	rcu_read_unlock();
 
 	cb->args[0] = i;
-- 
2.53.0

