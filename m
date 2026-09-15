Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97F3B71AE
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475048; cv=none; b=k8HMc9c5tXfPe9dgZSd8H5LEKGRLIT0ZGZwVaXNrdSbR6YYfv2ThvEm6BKPsWiceX6a2dlN5n/3pkX39ugvXjSFQVXoUxnASXLbAhtswr1kqbye9PkfoG6PcDS7xRqmoljyAaCMFchAHVbzGY9Jv2vafBQuSI3DAkxBjM4VerW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475048; c=relaxed/simple;
	bh=R/nHfQc/bcze3C4lj/8T0wT3ntxfbJYLiVnjlf3/JGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fo/PVXPeoDy3cRi/U9J1d9YaKmeDZU/aQspw+klACeomN4CBbFPB+q6sXFF7mNVyIW22YLFEJ4xJ5iB7Oc/ENX/woUKt+aQFK7Nb+mTb3CMPeLndRrj7HBZdZHPKdMYDbZP+lpHXBmE87lmOnmYYmqLqYC//5/rGZmyeYdl2Eds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=bk6c3rRV; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="bk6c3rRV"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so1552535e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1789475044; x=1790079844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+zcSg7Pwq9UEUFOofd5bITUlp4qVFA73ui/ymxwgtw=;
        b=bk6c3rRVlOUmVQcQNzxmxB9hRCQxWvOR8m8mwgznrmVL3YKKH6JPg+1wZlOlWwPMc7
         BzzwYuZf4cU1f3J6IsPx3fR6RC2WrPBch95SeRed+dT6n7R4lPRlXRRge3XFLCj/mIkL
         Dn4vxg2Gt7LGhEv6fAAkmTdiYGy3Zb83x4p+wJAW8YYoR6l1PNHMsGCrVwzO1Fx/q8gf
         irgBXWWCUC14gn650lrQnbkRLcGbk2WhDdsPGdDA4UCR6/BrRMFrlxfyW4f4tYmjgask
         Ns6h37aevEKBP0rUk4cKof0TRk4BpLHmQBu7MO52nx1Mwx9qLtJU1VTeOeAcdhQ914WK
         8qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475044; x=1790079844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+zcSg7Pwq9UEUFOofd5bITUlp4qVFA73ui/ymxwgtw=;
        b=erKMrcFxl7sYut2OSp7eABw0YKvysBQkD5sBFuBtcdBb3OBxadZO8/a57kyfmgIfW6
         mR6nCx3rLETScouG8uau+OtSbFKUl62lpCJ3t+phD+7C+pQ1ocHsXkgTSeyAaLhTpirs
         QFvCVCGfT6pynOxh7lHuQrjfXfHd1Jq9da0SsNtt8L8a3cG62Go9fren6UGRtuv5h02L
         VhdXNmNe7dqLy78G/+ICtSIaVeShMltu8hVYCaPBsFdkH7s+gfxrPuELLeoM8hBdb8V0
         TsbMMsuzvC8MLdISJA2sLMuDYe6SVWLVcGe2rbFjM4j1V/Yba+1f7S2iL9VJaqL2F6fP
         DAow==
X-Gm-Message-State: AFuF++nn2HMY/X357j8IB+NxZi93gPm7S8778WdM1sT+5/HhqAT38jM1
	YK9AhUtCgbAhqstLxSFoOFjh7MTagJXwZ83U2o2/r+eP4p8W1gkehH+jrDycx+J307wEzoD1cv7
	Rua/t
X-Gm-Gg: AYBFou1dJNEfh46Yi82aPxiPtZu65vNMjhStnsG8rxH8K8VWQI6BYFDTNBVpJi6Tl/9
	qBtxw7mTgmfkBIPHZt3RTGGe7uRDYKyCTrKirQooRIcMJqlvXWakzL5BkTd/9QxfyLYrXtvSMEJ
	N2z3YdFxfDXKqv9XbRIuCeKgC9Tu3wr18bzdr/o1FsQMVOvGyV6f5vH4wf3MLaDmZIsLjM7+SRU
	REwRtT/J7BLW5T71K/LQ6/AMveXEo672jyQi4MFr9BvR0vYJwo1FuaBrr57QS9RTEnTwgDzO9Uo
	CY49wCwvl+vFezzxjYFH4Uq3Q9RhWUNeUbSQyXYvvCVIDH7hEthT7rdG5efcaHyr1252AtbBChT
	OgIqBskMs8TxnZphinRTDHbhxscIg9OB4URQhylj4DYKYOHxsy471BwhZCPAz5xPr2v3PUgwxiw
	v5ZCVdm3t/bZ33rS48SMGuWNZHbEpET5W823Xmyih+aXYAYep2zzRWCN4XDSCj0HUr1RZg
X-Received: by 2002:a05:600c:4743:b0:49d:29ab:540b with SMTP id 5b1f17b1804b1-49e8225b594mr14042915e9.15.1789475044562;
        Tue, 15 Sep 2026 05:24:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:33e6:6107:4678:322f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef7eca3sm54080305e9.10.2026.09.15.05.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:24:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2] openvswitch: fix soft lockup in the netlink flow dump
Date: Tue, 15 Sep 2026 14:24:01 +0200
Message-ID: <20260915122401.3910188-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis V. Lunev <den@openvz.org>

A production compute node carrying a few thousand datapath flows hit a
soft lockup inside a single netlink flow dump and panicked.

ovs_flow_cmd_dump() calls ovs_flow_stats_get() for every flow it
emits, and that releases stats->lock with spin_unlock_bh() once per
CPU that has touched the flow. Every release is a local_bh_enable(),
and each one runs the pending softirq backlog in the dumping thread's
own context.

The skb bounds how many flows one callback emits, and a large but
sparse table adds only a walk over empty buckets, so no dumper carries
a budget of its own. Neither bounds the softirq work the callback
absorbs. On a CPU that carries the box's packet load the backlog
refills as fast as it drains, so the dumping thread becomes that CPU's
softirq engine. It never sleeps and it has no reschedule point, so
under voluntary preemption nothing can take the CPU away from it:
neither the ksoftirqd the kernel woke to take the work over, nor the
stopper thread the softlockup detector dispatches to refresh its
timestamp.

Hold BH off across the whole callback instead, the way
ctnetlink_dump_table() does, so the nested spin_unlock_bh() stop
draining softirqs. The loop already runs under rcu_read_lock() and
cannot sleep. What it gives up is preemption under CONFIG_PREEMPT,
since a BH-off region is not preemptible outside PREEMPT_RT. That
region is bounded by the skb and the table size, where the softirq
backlog it used to absorb is not.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
v2:
- leave ovs_vport_cmd_dump() alone: nsid_lock has not been BH-safe
  since commit aed4969f2bdf ("net: net->nsid_lock does not need BH
  safety"), so the vport dump never drained softirqs
- disable BH before the table dereference and say in a comment that
  the region is not there for safety
- drop the ovs_flow_stats_get() history, note the empty-bucket walk
  and the lost CONFIG_PREEMPT preemption in the message
- move the Cc list out of the commit message, add the net prefix

 net/openvswitch/datapath.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 631a03136fa1..a80bac81c043 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1532,6 +1532,11 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		return -ENODEV;
 	}
 
+	/*
+	 * Not needed for safety. Stops every spin_unlock_bh() in
+	 * ovs_flow_stats_get() from running the softirq backlog here.
+	 */
+	local_bh_disable();
 	ti = rcu_dereference(dp->table.ti);
 	for (;;) {
 		struct sw_flow *flow;
@@ -1552,6 +1557,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[0] = bucket;
 		cb->args[1] = obj;
 	}
+	local_bh_enable();
 	rcu_read_unlock();
 	return skb->len;
 }
-- 
2.53.0

