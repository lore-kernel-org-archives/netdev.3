Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242259;
	b=sDz3jOKD94K/0mXuX3qt9uM1lT/v9SwC9ZbIfrrFLvglGeQ3gc9YzeUr5tz8g3COAPme
	 Khab2ZnGOPi5xgg0Asms51gO7eS4Jfc02gON243wNRT82gpQPYkBerIJ+PVsySdnvaQ83
	 jvP1+eOvi86Li9ypoMNgT2HtsetOK4J+U2PD8CU7Xclv5mq/nUtlV5u0IPcwzeg6aW+lN
	 46PDjTmUEFUbO3UOYSbxxhb7w9JHdRMAIZEWwWFGkYTEnA0vbK0p46ZEJDtsc9R5IS9RF
	 mu1eYf3X7L5GD5PsjJJ2TRhU1n3IxIvLNTG0KqSDKIrKbEtfWeHGFxuPbQu91F5Dq2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242259;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=NQCNgkfgJyeAxy730doKA7+l45jsTlC6fgBoQoaPpsE=;
	b=uwBT+5/NoChk291esKd3/Xgd+odnI/h+6eWz+5WmJSroopx93MXE8KFi/m8P2Z9pEfVC
	 8ZuxYCgNGU5/OhNAymjzjVs8M9c8O0nO/7lDejjoIpWIySeszeapUbvG+r+N01CkcIoVj
	 PFYgY9IElrU3/toBuReVF+R91hTzuPI5xuj7GgLWJvTDVil20hwfKNzIUgNN/bf8cdvCk
	 h9eVrmDbSuCNd9FL6fJImnGyqW+kT2tVf7Ng2BG4KcplHa+Zb0Vesuxhr+IKGC3dR3PX4
	 XrFitEM7x6+99fMhq/2RbTzHbZJSQUrP8BoYszyLyZVLNuk1ZJ3ugBAATS6hQ/aa5kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TA7SIHKM;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41000606EE85;
	Mon,  9 Nov 2026 16:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41000606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TA7SIHKM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NQ
	CNgkfgJyeAxy730doKA7+l45jsTlC6fgBoQoaPpsE=; b=TA7SIHKM7HD0ELzmMJ
	gn4B/KXL4xbYaso+4G5R+7IEa0hmY92DtpV01/wx2va9d2VkQGNyphKNmfA/Grbd
	TFGiSOJiYAoXx+jzxqgkNUGwvBa42IopVv8vWYze6ZpesMUir3hJ/EJo5Enpclbz
	aK+znOw7iYizQMaoqbeqaFysk=
Received: from shaos.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3h6Kg9vFqHg3KEw--.31307S2;
	Tue, 10 Nov 2026 00:36:49 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: gred: reject table shrink with queued packets
Date: Mon,  9 Nov 2026 16:36:48 +0000
Message-Id: <20261109163648.301164-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022144811.66149-1-shawnq1@163.com>
References: <20261022144811.66149-1-shawnq1@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3h6Kg9vFqHg3KEw--.31307S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur45tw4kKryUGr1fJF43ZFb_yoW5Wr4rpF
	ZYyrZxtry8Jr13JrZ3Aw1Iq34av397C3y5CF4xGw4rCan3ur1FvryvkFya9Fy3Krs7CF93
	Awn0v3yrKr4UGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjJP_UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0AP8C2rx9qPimQAA3R

GRED frees VQs above the configured DP count when its table is
shrunk. Queued skbs keep their DP number. If the table is later
expanded and that VQ is recreated, dequeue subtracts the old skb
length from the new VQ's zeroed u32 backlog.

Reject a shrink while a removed VQ has accounted backlog or an skb
in gso_skb still carries a removed DP. This keeps the per-VQ
accounting state alive until all packets using it are drained.

The issue was identified by LLM-assisted source analysis and
reproduced with a purpose-built AF_PACKET/tc test in QEMU. The test
requires CAP_NET_ADMIN and CAP_NET_RAW in its network namespace; it
does not modify the kernel or use error injection.

On Linux 7.4-rc2, the unpatched reproducer wrapped VQ5 backlog to
4294964296 bytes and dropped a probe. With this patch, shrinking
returns -EBUSY while VQ5 has queued packets. After the queue drains,
shrinking and re-expanding succeeds, and the probe is accepted.

The modified sch_gred.o builds with W=1 under allmodconfig and
allyesconfig. Full-tree W=1 builds stop on unrelated warnings in
lib/tests/stackinit_kunit.c, arch/x86/kernel/callthunks.c, and
net/8021q/vlan.c. The QEMU regression passes; tc-testing was not run.

Fixes: 6639607ed9de ("[PKT_SCHED]: GRED: Use a central table definition change procedure")
Link: https://lists.openwall.net/linux-kernel/2026/10/22/1545
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/sch_gred.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index f3d9a7252949d..8ddbd7f058a6b 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -408,8 +408,9 @@ static inline void gred_destroy_vq(struct gred_sched_data *q)
 static int gred_change_table_def(struct Qdisc *sch, struct nlattr *dps,
 				 struct netlink_ext_ack *extack)
 {
-	struct gred_sched *table = qdisc_priv(sch);
 	struct tc_gred_sopt *sopt;
+	struct gred_sched *table = qdisc_priv(sch);
+	struct sk_buff *skb;
 	bool red_flags_changed;
 	int i;
 
@@ -437,6 +438,25 @@ static int gred_change_table_def(struct Qdisc *sch, struct nlattr *dps,
 	}
 
 	sch_tree_lock(sch);
+	skb_queue_walk(&sch->gso_skb, skb) {
+		if (tc_index_to_dp(skb) >= sopt->DPs) {
+			sch_tree_unlock(sch);
+			NL_SET_ERR_MSG_MOD(extack,
+					   "cannot remove a GRED VQ with queued packets");
+			return -EBUSY;
+		}
+	}
+
+	for (i = sopt->DPs; i < MAX_DPs; i++) {
+		struct gred_sched_data *q = table->tab[i];
+
+		if (q && q->backlog) {
+			sch_tree_unlock(sch);
+			NL_SET_ERR_MSG_MOD(extack,
+					   "cannot remove a GRED VQ with queued packets");
+			return -EBUSY;
+		}
+	}
 	table->DPs = sopt->DPs;
 	table->def = sopt->def_DP;
 	red_flags_changed = table->red_flags != sopt->flags;

