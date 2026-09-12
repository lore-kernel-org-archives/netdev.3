Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F9430CD8
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236607; cv=none; b=kWHx9PmfVq8I1xunLuDqwfrKlPnC8JT/vjursJrhULFOl8bPoZLNnyizRIqjgIqRcxBYyh/l7bzUrRxRCTk+ydgiIPfPxOZYslSO+M8cO7iRf8ms/eluos65u/F+RgNJDEKZx+BpS8puE7/WFzAXx80ArXeIr9MAW5ni2O/qLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236607; c=relaxed/simple;
	bh=vE/iMULD5K4OtJqkY8NMyQ0D6bTr/R6gco/ovMyKZMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FABljOwqQgr2wUyAStmBaxPROMzayECGezerA3YbvQGtPtEPqLprCtmT/JvZkwc7yFoIX3coqoG0jLJuXw+6T7ISJyQDLWrYgI9l/bGwhmqnjM59tGXVfbK3XjVxn6nAlGbMTToiaTLCtY/Sg3isv+fnT2STFE81GmbO9OUHb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=RHZEMW6T; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="RHZEMW6T"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e4so11967086d6.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789236605; x=1789841405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ySDoRLvhE1YR0u6+GbzkwQ14iMqsOxrciYvvoj9mng8=;
        b=RHZEMW6TyLlV0F0GINS4AxEu5mB+XoNPK6CP9rtF26MtNRLv0/Ib8U3DUh23dtxrgP
         0yOGX1zfaZRASheRRqMI7WNktfjCLnwlfv0r6op9RtARRkk3g94NAat6ff9LWimL6TIo
         1yRTRopQZrZ28n8scPdP5l5CxbAmndL4WwSgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789236605; x=1789841405;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ySDoRLvhE1YR0u6+GbzkwQ14iMqsOxrciYvvoj9mng8=;
        b=fYUOidV1eLj5RX4nS918NtAWlWj8OEOo9PJRQ4RlQcgZBfgMgWX46bANtob4yIbi8k
         Jqpzp2/Ys9pWisDdUbXZ0ulZGCRPxjiXqQrHWX8fCODtmUAMDYiNHmrdHvS/qTNydkzH
         SYgTPIXKw9bVMBRbDV9pvjgsdTahGy9JQ5oMKO2/B5hVmMHVfnicCAFhYpYP8bne7xIg
         5fbgWh9FvNcJjoSOHcBiBFxhSWaky0z8oAV95urgvP6cBOo/UESu7j+7w9xtSOrlM2lN
         AJl59w9k3dGnHRu7Vr8Td7XNeODuSIIg0K5nZGssiYN5m2Bphi6s6gAGM2PhxkXYP4Fx
         xu4A==
X-Gm-Message-State: AFuF++lzw8QuyOmp7Xje4OczSjucOwE8FQkc5SqiX54fx2i61BQp+Aa6
	Qk7rwecGos9wNPFBdUmmSORp/USeq4Sz9JI2btWdVSXxfEy7GTnl3YC11kBQxeu3UcS/HX3ZErx
	jA9XnbQ==
X-Gm-Gg: AYBFou1mWMlzw3epssT8PaSobQHzAcv/GK6ZB6jsgBFFlfYOF3Vn6a0V6EW/yoViupu
	FLWx7QEQV8p5ydLOdEtN4Lpg9o2nE5Tr2HMtEZVXypTSvVrqHyicntEagfxA22qVsoeT9niR+Ot
	kZDAZMQ5pU/Hc4Kh79vmW69CEm2D3xtSl+v3uTWq7dI2qk/kgZT7PpS1e1X0ptOS2XpqcDodrmi
	sjmbyoqGVV1pGgKC5W/u3tszWZjiVA4TbEHe5vCXWdessY7OhXYS1iz+C3JcrXfLhsNOli5NUXe
	molNlboTpXWhOM44mbQ0pq9KkDPPeOD7SiKbdPcUY3oA03s6xHO1ugIjhrv6dxG2my/cjOkyUcU
	flalCmsL21ZD/d+ClZUSRIwXNjE9xYQDCftV3lFqx9BiTA4jkrcWQHw5Ocmnp8ZnPFOWY/1i31X
	Riu0aIwRSR1/k4xoPDiQaGSPS0cYsreI0lHQXFbvh/5nAXqcxF0Etu/hD8OIgaPk0UWt148pWiF
	nf9uZ46JPncKbCFHLue/a7OhAsJPSHvUWoB7DhDz8r4GVhbvkWvqFZuEbyoxU0gYUqM1a06XupY
	Awnn0jVBZHIw2WEzKUr6w4I=
X-Received: by 2002:a05:6214:4a04:b0:910:5447:d43f with SMTP id 6a1803df08f44-9121209d1a5mr157347596d6.11.1789236604758;
        Sat, 12 Sep 2026 11:10:04 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45f1fdsm51713536d6.16.2026.09.12.11.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 11:10:04 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net] net/sched: sch_hfsc: bound the classify inner-filter walk
Date: Sat, 12 Sep 2026 14:10:00 -0400
Message-Id: <QDISC-CTUU.v1.20260908094501@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hfsc_classify() applies the "filter may only point downwards" level
check only when the filter result carries no bound class. A filter
created with a flowid gets res.class set once at bind time, so the
check never runs for it during classification. hfsc_adjust_levels()
can later raise a class's level without revalidating existing
bindings, so two binds that were each legal at bind time can point at
each other; the classify walk then bounces between the two classes
forever with the qdisc lock held and BH disabled — a soft lockup from
a single packet. The stuck walk trips the watchdog on both KASAN and
KASAN-off builds:

  watchdog: BUG: soft lockup - CPU#3 stuck for 13s! [ping:444]
  RIP: 0010:u32_classify+0x542/0x17f0
  ...
  tcf_classify+0x66/0xa0
  hfsc_enqueue+0x166/0xdf0

  watchdog: BUG: soft lockup - CPU#0 stuck for 13s! [ping:340]
  tcf_action_exec+0x37/0x3e0
  u32_classify+0x12a/0x550
  hfsc_enqueue+0x7a/0x380
  Kernel panic - not syncing: softlockup: hung tasks

Bound the traversal the same way the HTB side was fixed: a sane walk
strictly descends the class tree, so it consumes fewer hops than the
level the walk starts at; anything beyond that is a cycle. Drop the
packet with a rate-limited warning when the bound is exhausted.

Conditions to recreate the bug:
- CONFIG_NET_SCHED, CONFIG_NET_SCH_HFSC, CONFIG_NET_CLS_U32,
  CONFIG_LOCKUP_DETECTOR.
- Build a cycle with two legal-at-bind-time flowid binds and a level
  drift: class X 1:1 (child of root) with leaf child 1:10; class Y 1:2
  (sibling of X) with children 1:20 and 1:200; root u32 filter flowid
  1:1; filter on X flowid 1:2 (legal when Y is a leaf); after Y's level
  rises to 2, filter on Y flowid 1:1 (legal then). Send one packet
  (ping on the device). Unfixed kernel: classify spins with the qdisc
  lock held; with softlockup_panic=1 it panics.
- Reachable from unprivileged user via unshare -Urn (CAP_NET_ADMIN).

Fixes: a2f79227138c ("net_sched: sch_hfsc: fix classification loops")
Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260824161809.4147223-1-victor@mojatatu.com
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_hfsc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index e87f5021a199..71744a6c2f38 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1133,6 +1133,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	struct hfsc_class *head, *cl;
 	struct tcf_result res;
 	struct tcf_proto *tcf;
+	unsigned int hops;
 	int result;
 
 	if (TC_H_MAJ(skb->priority ^ sch->handle) == 0 &&
@@ -1142,6 +1143,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	head = &q->root;
+	hops = head->level;
 	tcf = rcu_dereference_bh(q->root.filter_list);
 	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
@@ -1167,6 +1169,15 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 		if (cl->level == 0)
 			return cl; /* hit leaf class */
 
+		/*
+		 * flowid binds skip the level check above, and levels
+		 * drift after bind time, so this walk can cycle.
+		 */
+		if (hops-- == 0) {
+			pr_warn_ratelimited("hfsc: classify loop detected, dropping packet\n");
+			return NULL;
+		}
+
 		/* apply inner filter chain */
 		tcf = rcu_dereference_bh(cl->filter_list);
 		head = cl;
-- 
2.43.0

