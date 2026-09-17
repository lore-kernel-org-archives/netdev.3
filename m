Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4D4D0CF7
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642675; cv=none; b=eiG0/LWFbgaCreVAvXQkwukzQ5Bs+E8yEupR8mz6SHK7CXaWQndOpVgjbuVZO4zkI7g7DTKOY03sslD7tymuT6+lfyiOpNdvewZYXYlxLJwDoe9cWHM4p2/H7UkT5h+A1mPQbxWGYojUkwzXGmQJ102y8aPP8yBEN4ftcnM0Fig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642675; c=relaxed/simple;
	bh=6WphH0iaoUOVd7gCTr0W64KAb/Lez93Le5WcMoKyw5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lyLiEPmNapbDmYgZ2sTjKzg7RQ8mahHCjGF5oHTqzzK7v/O5giJVyvU88yZqI6ZtSTNVfGdq/Cv4JeSETcx3JK+F2VhWwsrvoXePIfPps2CYyyvyCHN3mYPFTh9q5t0lFxyQDXYB4zpnNtyPgPU4donB3PPLJthXXZhW+Ijvx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WhjIohz7; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WhjIohz7"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso5564036d6.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789642659; x=1790247459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wUQFWgQPZP16/JVsZ0enaTBouhX04N65nfi6O1qWoik=;
        b=WhjIohz7EC8dkz7lu0D3ckGdtmzZXhSniWOu0dwsO+Lqbs2sZ0eAPnjOrzemrUo00M
         arjo5mZsDsULpC1Ho7X9YLcWjQCJYMJebzCc+RItQKe0x5PRphuutb8FZbuMnTh01vZl
         DlJdwSblkc0d84OaYy7a9DzWXT+kgBV1n/wDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642659; x=1790247459;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wUQFWgQPZP16/JVsZ0enaTBouhX04N65nfi6O1qWoik=;
        b=zWheXKHQ7Ecw58uQzIdl7wExGEuzsfJTtp+pRXpY85Pxz7iv6KFlkBmafqc3vNdbj5
         I5yOcY3xribGsguGjWNqoYQAqWiUfvGBmklSDGnSAMK5yQUfMUSzptmm2k34FWn0NHIs
         A+nvCqKpct6M+r5zYDIvqqrUBULR4QaFw0BahwMl1rctJv54LU+/dTIt7oxhzTyMvNxn
         9ZECvsGCiQkX2QFQZMTgTCvlnku6WRHvIvT84gP6OpY91OY2RvVZOoPx+cEgFXi0x0iH
         5kLtha5QnTTjiBOxc46Rr3wyOVFaPxfahBQ+kHIwqVDB+Y6wSaAASyq/PhATYNxPxdUa
         CwlQ==
X-Gm-Message-State: AFuF++lZRmurBL8CZVG18jyZeI1yFuKSB2RYu/t4cggzHDg5FbE1hiDs
	fMcIVxW5eiHjdQoVbagMNGXRTmx+FUvnRb1epy/YU2ZRIHbM2Eo6cqNIC+kvE3cIXPI/ieYQkAm
	GYbrqUg==
X-Gm-Gg: AYBFou1XUex+AmDjHhrvsIQR4k72B2gBQZGsVvwZhoKpd7AYZJR5aOVHsfkke5jy4wt
	o42RsFDDC4L5UqTDCMHEwVbpzumSr+BfS4HG4JknnOHgrbUmBdtaUIUATPHF3W7DpJb9jJu/1Ib
	VQvflyP/teAUHHLuXfZxfP9xkaDKkxuwGwy+XAG6ZExKp6YzL6NoAAMWe7rRDb7zsI6r4VU770x
	Wn361Ph30k8dzlT5ZTL3jgBdaaU7tczEIOJR2KxLN0KgTmEpRkL5rogTramLKYGyd7eUJb3/B6+
	b2vLrnVJVqbRZVK4GFy+pvp7IVcAkUUEyJewKQpWhzROR6zxBRgFQhSvwePYisfzKmS5mMI/7fo
	ZNoZQCHY1GYHKceyNbIn0ok9dJkqcz6CK+/dr7IadT2b4RwrvbJCLLsVM/wNKykvPNSAQ4pByj9
	0jpTfQtABstTREWq2eH1IlOmF5j4p23uUhotyeORKiP9+5GswJ/gOvAgduJwlTN29pShmKGC/q4
	O0dS7eMVGCaFZD+5iqNVxa7y/0lmQhzeewbIn+VqqWFgfXlaFsyc2BW0FsZ
X-Received: by 2002:a05:622a:2304:b0:531:17a1:a020 with SMTP id d75a77b69052e-5327ef109c1mr98781791cf.37.1789642658526;
        Thu, 17 Sep 2026 03:57:38 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620c2ffbsm46914451cf.27.2026.09.17.03.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 03:57:37 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3 1/2] net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget
Date: Thu, 17 Sep 2026 06:57:32 -0400
Message-Id: <QDISC-CTUU.v3.20260916184908@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hfsc_classify() applies the "filter may only point downwards" level check
only when the filter result carries no bound class. A filter created with
a flowid gets res.class set once at bind time, so the check never runs for
it during classification. hfsc_adjust_levels() can later raise a class's
level without revalidating existing bindings, leaving two binds that were
each legal at bind time pointing at each other; the classify walk then
bounces between two interior classes forever with the qdisc lock held and
BH disabled — a soft lockup from a single packet. The stuck walk trips
the watchdog:

  watchdog: BUG: soft lockup - CPU#3 stuck for 13s! [ping:444]
  RIP: 0010:u32_classify+0x542/0x17f0
  ...
  tcf_classify+0x66/0xa0
  hfsc_enqueue+0x166/0xdf0

Bound the traversal with a budget of non-descending hops, the only way a
configured walk can move without descending the class tree once levels
drift after bind time. The budget is cumulative over the whole walk and
is deliberately not reset on a descending hop: a chain that alternates a
descent with a lateral hop would return the budget every lap and never
trip. Descending hops never decrement it, so legitimately deep trees are
unaffected and a terminating lateral chain still classifies normally.
Drop the packet with a rate-limited warning once the budget is exhausted,
mirroring the merged HTB fix.

This is a follow-up to commit 729c4896ab82 ("net/sched: sch_htb: limit
htb_classify inner-class filter hops"), which bounded the same classify
loop on the HTB side but left the HFSC walk unbounded.

Conditions to recreate the bug:
- CONFIG_NET_SCHED, CONFIG_NET_SCH_HFSC, CONFIG_NET_CLS_U32,
  CONFIG_LOCKUP_DETECTOR.
- Build a cycle with two legal-at-bind-time flowid binds and a level
  drift: class X 1:1 (child of root) with leaf child 1:10; class Y 1:2
  (sibling of X) with children 1:20 and 1:200; root u32 filter flowid
  1:1; filter on X flowid 1:2 (legal when Y is a leaf); after Y's level
  rises to 2, filter on Y flowid 1:1 (legal then). Send one packet (ping
  on the device). Unfixed kernel: classify spins with the qdisc lock
  held; with softlockup_panic=1 it panics.
- Reachable from unprivileged user via unshare -Urn (CAP_NET_ADMIN).

Fixes: a2f79227138c ("net_sched: sch_hfsc: fix classification loops")
Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/QDISC-CTUU.v2.20260913192614@mojatatu.com/
Link: https://sashiko.dev/#/patchset/QDISC-CTUU.v2.20260913192614@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-CTUU.v2.20260913192614%40mojatatu.com
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v3:
   -  Reword the budget comment and the warning to describe the
      cumulative non-descending hop budget that is implemented, and
      explain why it is deliberately not reset on a descending hop.
      (Sashiko: gemini, nipa)
v2:
   -  Replace the absolute hop bound (root->level) with a budget that
      counts only non-descending hops, so a legal lateral chain still
      classifies. (Sashiko)
   -  Reword the "strict descent" changelog claim (Sashiko).
---
 net/sched/sch_hfsc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index e87f5021a199..284490fd6ca9 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -386,6 +386,15 @@ cftree_update(struct hfsc_class *cl)
 #define	SM_MASK		((1ULL << SM_SHIFT) - 1)
 #define	ISM_MASK	((1ULL << ISM_SHIFT) - 1)

+/*
+ * Cap on the non-descending hops a classify walk may take before its
+ * filter chain is treated as misconfigured. A flowid binding that was
+ * legal at bind time can become lateral once hfsc_adjust_levels()
+ * raises a class level; a few such hops are legitimate, an unbounded
+ * run means the chain cycles.
+ */
+#define	HFSC_CLASSIFY_MAX_DRIFT	8
+
 static inline u64
 seg_x2y(u64 x, u64 sm)
 {
@@ -1133,6 +1142,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	struct hfsc_class *head, *cl;
 	struct tcf_result res;
 	struct tcf_proto *tcf;
+	unsigned int drift;
 	int result;

 	if (TC_H_MAJ(skb->priority ^ sch->handle) == 0 &&
@@ -1142,6 +1152,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)

 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	head = &q->root;
+	drift = HFSC_CLASSIFY_MAX_DRIFT;
 	tcf = rcu_dereference_bh(q->root.filter_list);
 	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
@@ -1167,6 +1178,17 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 		if (cl->level == 0)
 			return cl; /* hit leaf class */

+		/*
+		 * flowid binds skip the level check above (res.class is set
+		 * at bind time and levels drift after), so a walk can follow
+		 * lateral hops without descending; a bounded number of them
+		 * is legal, more means the chain cycles.
+		 */
+		if (cl->level >= head->level && drift-- == 0) {
+			pr_warn_ratelimited("hfsc: classify hop budget exhausted, dropping packet\n");
+			return NULL;
+		}
+
 		/* apply inner filter chain */
 		tcf = rcu_dereference_bh(cl->filter_list);
 		head = cl;
--
2.43.0
