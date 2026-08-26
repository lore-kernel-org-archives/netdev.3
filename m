Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2C2D94BA
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754831; cv=none; b=bUFVgz+syblJiK06MxwdY+i+vIX1C5Ur7GD1Gr8OE32p+V/VT6eF5GJO7jZsn6PlMOQreRGRNrueLSDKuywWpzGJ+JrSxfavl/fmqMdCWviGTzqE2tfilxRiSBAexu+H329SomnKlhyNeN/wccmzH3phO49yTPCk4ajlbg+scRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754831; c=relaxed/simple;
	bh=cWtcSD1aVGl/l5FrVNBbCsmXWKZxOQmaos7Ej0w97dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=llCazYJVg5NWYQYL79kAspn87Q9zg/MUkgIsee1CIrl0WqevyC5bIB9+RxH1fyJdJawoLhG9WS6EjWk7o5ht6KDFZpzkASXTJ0fgfNV3lhM53J04k8MVpGjvqRaB7zzbz51zBnnWk5FotJonQpVG6K3XCT1/ggv+6+ofVVHQ7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cL0/TDPM; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cL0/TDPM"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-747355a8565so402274137.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787754828; x=1788359628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D2Eltb4XjJtEUEC3rTx67Ix4EpQUpDEVTRuEwidhbk4=;
        b=cL0/TDPMETQnTCtK82SnTL2znbhnd2Q2mxkCUZN7ZNDS7fF2Viioojecw31VLOa2a4
         WqbHr8uNG4/B6oIkG/LPQsDJNQ9+PdTBQMOo/jTNPrPoDwzpqq3PIHqncSNvthJwvWd1
         qqAYmcjV0pNS6Q9AOBKmaW252eEtlxDeTxAWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754828; x=1788359628;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D2Eltb4XjJtEUEC3rTx67Ix4EpQUpDEVTRuEwidhbk4=;
        b=VD6ZWKu9Ps72A0NzEwSDtPizx5qfrun6jRbjCNaYtdKL242fjsEAZB/tlGfZ4hy8kp
         87iz2DqA58VSqfxHuXS6juYVfBED2+a8/T0VLTFYLiWNM0oFhJ33keex+xhlIRPC6JyF
         Ex1ar8n7hoqYrnjC//HztBzUtY7Xn41QdKqjqL/1OIGnAxDdlrNXl56YjofkYx7s/2vK
         MKDasdqxJIt44c5bi0Crvi22Q0CB2zFp7BNSFJwgXn/NgUBOgiCOVLCqJJRw2V98tqVi
         sFQTw3UHrJhob1lAtTW3rlU/vJoVZpt0aK2/ojfC9H1EPZiAorX5DFzYH1+oHm5UBsCM
         S+Fg==
X-Forwarded-Encrypted: i=1; AHgh+RrJYN6qg4auNMEGYeb7z+k31Dw76loPS/xH08YEOOyYru4MftIMUZvsZ+aHdjBp04m5XHUigKI=@vger.kernel.org
X-Gm-Message-State: AFuF++nI+00zpzUOCEUbKCq//4sHte0WRqCLNeB4Bafhl8zbxUdy/9++
	Mdp/HG6SoYDGi2OGlrom1ceaaJq73ZAgsJtMOLRXnnc9+WcMAQVl+EovyN+xU2uDrQ==
X-Gm-Gg: AR+sD107koL8a/pN7EPAj47SWm8QT00PmftW84sJsqXzuIHLL0SVGdIS5fAJqJf8anL
	taPt3Fci8o2JI/fgfb1jDcTKRMC9jAS1xHoaybkNrHtManx/0JU1+bgA8AQdOoXQx6Q4J2oCpWq
	RdaegHx5FIl1X7hFIct9kfpXrnoOqvuizV608cfxUSN5GBeV7kXGWhcWqDxH26fj5ER/wK1YVCy
	tYmn+VyhbL5i08oDLuNaw9Xvt2mXQ9HtIvfBVf1UWEQgNTKwHGTjbG/3wIzOC18C0twstkrixzW
	xzPb60fz5bx3XNwA7crZtMAjRHFqVYdaksAK6PQWzDZe8tlA6X2wUveLrs/pTWzjbNSV53dXwbs
	Za7ZcX2OH7yfTOF4A8GAwJhUf7RXrjgs//dtLDX/ZtOwSRhrBfDVXe/aFB5qG+UAFyveg3e2+hV
	BRztVAiFsj2/G6HWfbLf1Pu2BeePEGozQPlLkZy6Oh1cLgV+tUbjQ6HA==
X-Received: by 2002:a05:6102:441b:b0:77b:2881:580b with SMTP id ada2fe7eead31-782bffdabbcmr2235690137.4.1787754828221;
        Wed, 26 Aug 2026 07:33:48 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97ccc0f4963sm12969241.12.2026.08.26.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:33:46 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2] net/sched: sch_htb: limit htb_classify inner-class filter hops
Date: Wed, 26 Aug 2026 11:33:39 -0300
Message-ID: <20260826143339.271935-1-victor@mojatatu.com>
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
rate-limited warning once the bound is exceeded. The counter is
incremented at the point the inner filter chain is picked up, after the
TC_ACT_* switch has consumed the classifier verdict, so a terminal
TC_ACT_QUEUED/STOLEN/TRAP on the last permitted chain still sets *qerr
to __NET_XMIT_STOLEN and the packet is not charged as a drop by this
qdisc or its parent.

The bound is TC_HTB_MAXDEPTH, taken from HTB's own parameters rather than
from the qdisc hierarchy depth limit. Class levels run from 0 to
TC_HTB_MAXDEPTH - 1, so a traversal that strictly descends in level can
take at most TC_HTB_MAXDEPTH hops. That descent is what a sane
configuration does, but it is assumed here rather than enforced:
htb_find() resolves a classid against every class in the qdisc, so a
filter may equally select a sibling or an ancestor. The normal
root -> inner -> leaf path takes a single hop, so the bound does not
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
Reported-by: Vega <vega@nebusec.ai>
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Count the hop where the inner filter chain is picked up instead of at
  the top of the loop body. That way we don't ignore the run's verdict
  for the last iteration (Sashiko)
- Fix reverse xmas tree declaration ordering for the new hops variable
- Add a name to the Reported-by tag
v1: https://lore.kernel.org/netdev/20260824161809.4147223-1-victor@mojatatu.com
---
 net/sched/sch_htb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index fdac0dc8f35a..1ba67b121de4 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -224,6 +224,7 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 	struct htb_class *cl;
 	struct tcf_result res;
 	struct tcf_proto *tcf;
+	unsigned int hops = 0;
 	int result;
 
 	/* allow to select class by setting skb->priority to valid classid;
@@ -266,6 +267,10 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 		if (!cl->level)
 			return cl;	/* we hit leaf; return it */
 
+		if (++hops > TC_HTB_MAXDEPTH) {
+			pr_warn_ratelimited("htb: classify loop detected, dropping packet\n");
+			return NULL;
+		}
 		/* we have got inner class; apply inner filter chain */
 		tcf = rcu_dereference_bh(cl->filter_list);
 	}
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
2.55.0

