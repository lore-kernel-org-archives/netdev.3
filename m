Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F841CB31
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588300; cv=none; b=T0R6x2hNfqMlCQhus8fGSHsR/7RcDw8VYO28rNL09wuCU7meafgPzU9/6z8T0j8qMZ9NtHMYDyugcmDG/TrYGciAnuvZcHpnnsZXLFu3bSUUw9rV1NlAQqmLyfWP43YjCV4heAG3GY+y4LYWPZSFe+71Doyvw9Ou6Jo2zl4kt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588300; c=relaxed/simple;
	bh=HslPR8ZYQBhbevF0C2EYXsjKWzGu2hSX/WmLq7tebP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BUG5SZdXSexGO7H9q7cijz832pvlv0oRzBbCm9X4iOfQVdYmssr9J+NakEN8PxhK6/LAfF5/AObFVMP4ueXh4blULFuZS1vFhGBQJAOo75BU/Ev6oGSgpNvC2zg8edItXM4pQxPXsBUZ12z2kYHHz+kWaCTEgc9NXFiDyGrICQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=n82P9Dc4; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="n82P9Dc4"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836cb2fa1bcso55633377b3.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787588297; x=1788193097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=suymr98Vys0A2HGJDFwXWu1AM9UuG83yUIpdzSnUrsM=;
        b=n82P9Dc4NdNn3rhUd0lScVce0nRUIvsDULvPEvFzRXvb4q1Qv2S8wwePorpHNfkkTn
         Ms1QCSLe0/D4f2/YCwOQ4Prkq6ooSHjMGTp6nykDdoU38/LUqjYWsVVJ9Qv0lO934v3n
         VaRFvTogMtZkeQobPZrS9Zt6Z/HPlLNpdHZ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787588297; x=1788193097;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=suymr98Vys0A2HGJDFwXWu1AM9UuG83yUIpdzSnUrsM=;
        b=n+nUYhOemAklSTQMpUn8HWHFMUz0NJdjsOu0zvB0P7ykKAnnmzxkYsE1w32UXw0fOk
         L9+sGPeXQy2VyyZiSwi2fFQDp7bWnQpn/UzQb9K0/gi/b73LgPt0I8DnhfZG7JNBtbHE
         bMkALjk73ZCqfY3GSY+m8pTKeBUl9jR8IHqfLsy4vsm/a8gG8V2iAo0cQAWaEKkkZbhz
         BWT6zfHuZClR+0PI0+k5qMnvNpOF8rqusz8zWEhAvuiUyivi1Ewueh41eGsy5KDlpVIr
         PqIxGBoXfkKLtYvUQS1TUcijE7RNqcsO77dM4t0MaJqjBOWBymXJKV9nDCicBubE0EjL
         OOKg==
X-Forwarded-Encrypted: i=1; AHgh+RrGrYQulokvInPv906Rlpy3yQsZFf4AMXeq9CVAiLAss00I8XAmZvJ11N7VxnWkNfEO8BlOrSY=@vger.kernel.org
X-Gm-Message-State: AFuF++mJIxfyCvNwezJS9M4kUmhzodfcjwb7H9oQsKO5qHlgeyFsWfBp
	icUehi9gB+9IEUjV3aFDMgvgCSeaKEvhtAxC394MHrk1vZ3+BeMqoQAGm6Oh1eJRAw==
X-Gm-Gg: AR+sD12hr9exBGconB2gxAt/62sEaZj0wKtNLDxRCtz7ZLCwAb3GYkeBOrtl975g04t
	dYmS+bkDD2SFdRIxzlWBTfATSjqQdNa/ZSZm3fKYrPRqLJdfD+iKY+0uoumXtawSNjMcZ65F0ne
	trgrB438M7wukx4XZRIA6u1YCX4Gq65BpDPdb1Jm//Xf/fXjkUJJzNozHNZNPEqoyTaHWrwnMYj
	FdkyJnopkCbo59NzeRQN0ktLCriWGQ1qEfcC8K7XZW8VRHvRzZe6cjp8CHxm0MiOU4WBXAUbc83
	cGyDh34KXXIYRd0WqaSfezPBrSeF/MLBtvFcOIAj1AcwzrxVp9Lu+XUXGnFIT6OI//BPw9Lz1s1
	5xWW5NkKLLKTTmwb1XGSYfbOBo5uATBk+X4Ua2AufjizU4+of/VXvqx4goNCvsH7N6oN+7Q4gSC
	ewETDIdy/RVZ24JHni+h+VdXMVDezoLpkhH7TZB5Pmjiw=
X-Received: by 2002:a05:690c:ec8:b0:7d1:dd7b:b71f with SMTP id 00721157ae682-84c9b31d980mr65036197b3.29.1787588295569;
        Mon, 24 Aug 2026 09:18:15 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caabb82ecsm36781487b3.30.2026.08.24.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:18:15 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] net/sched: sch_htb: limit htb_classify inner-class filter hops
Date: Mon, 24 Aug 2026 13:18:09 -0300
Message-ID: <20260824161809.4147223-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jamal Hadi Salim <jhs@mojatatu.com>

htb_classify() follows each filter-selected inner class by switching
to cl->filter_list, but never bounds the number of hops. A filter on
an inner class can point back to itself or to another inner class that
points back, creating an infinite loop in the packet classification
path with the qdisc lock held and BH disabled — a soft lockup / panic
from a single packet.

Bound the traversal with a hop counter and drop the packet with a
rate-limited warning once the bound is exceeded.

The bound is TC_HTB_MAXDEPTH, taken from HTB's own geometry rather than
from the qdisc hierarchy depth limit. Class levels run from 0 to
TC_HTB_MAXDEPTH - 1, so a traversal that strictly descends in level can
visit at most TC_HTB_MAXDEPTH classes. That descent is what a sane
configuration does, but it is assumed here rather than enforced:
htb_find() resolves a classid against every class in the qdisc, so a
filter may equally select a sibling or an ancestor. The normal
root -> inner -> leaf path consults two chains, so the bound does not
affect legitimate classification.

htb_classify() can now return NULL irrespective of CONFIG_NET_CLS_ACT,
whereas previously every NULL return sat inside that ifdef. The NULL
handler in htb_enqueue() therefore cannot stay conditional either, so
drop the ifdef around it. This matches hfsc_enqueue(), which has always
handled a NULL class unconditionally. Without it, a kernel built
without actions would dereference a NULL class instead of dropping.

Conditions to recreate the bug:
- CONFIG_NET_SCHED, CONFIG_NET_SCH_HTB, CONFIG_NET_CLS_U32,
  CONFIG_LOCKUP_DETECTOR.
- Create an HTB qdisc on a device (e.g. lo), add an inner class
  1:1 with a leaf child 1:10, install a root u32 filter selecting
  1:1, and an inner-class u32 filter on 1:1 also selecting 1:1.
- Send one packet (ping). On the unfixed kernel the classify loop
  spins with the qdisc lock held; with softlockup_panic=1 it panics.
- Reachable from unprivileged user via unshare -Urn (CAP_NET_ADMIN).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: vega@nebusec.ai
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_htb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index fdac0dc8f35a..01bf7a564b15 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -225,6 +225,7 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 	struct tcf_result res;
 	struct tcf_proto *tcf;
 	int result;
+	unsigned int hops = 0;
 
 	/* allow to select class by setting skb->priority to valid classid;
 	 * note that nfmark can be used too by attaching filter fw with no
@@ -244,6 +245,10 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
+		if (++hops > TC_HTB_MAXDEPTH) {
+			pr_warn_ratelimited("htb: classify loop detected, dropping packet\n");
+			return NULL;
+		}
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
@@ -633,13 +638,11 @@ static int htb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		} else {
 			return qdisc_drop(skb, sch, to_free);
 		}
-#ifdef CONFIG_NET_CLS_ACT
 	} else if (!cl) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
-#endif
 	} else if ((ret = qdisc_enqueue(skb, cl->leaf.q,
 					to_free)) != NET_XMIT_SUCCESS) {
 		if (net_xmit_drop_count(ret)) {
-- 
2.43.0

