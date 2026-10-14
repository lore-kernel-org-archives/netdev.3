Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27F25B08E
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971741; cv=none; b=VPNChmribU0lpDP8G5tmZAtJg3x+TOaItLZDY0aUwNtXgSEu/aUG2I/tE/jBLnC0nYFpKWpZIEpJjxXe/GlWbYE6engJ3D2zorPs9ZVz2hbkHtme+X5F3EyskQ9X2agA9O9woBNpS/tsaEtdGXP4su24TEq7GqrvTZDx008azDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971741; c=relaxed/simple;
	bh=5eZ33TkLPpXKjBT0h6vp57x4Bm/qRgwI8XVeoSaiaSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OPQDa4K30yE1/tJs6c+MVY0cEJS1hEFz68HqXze8SIWJc0SKaO46cMtqzhhw3yMLHd6bPWP3zQYia/zhJV4rzn5zpAmR6sP5858lUOGjuX4kzI2sYPmwboTi9Kvl/3PIQzghsHaS5h2MW93NQ+Qd9XN1UELqKH0ZdOCjCj2Y740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=lSUQi1Y1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="lSUQi1Y1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53512cd2f85so50068391cf.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791971738; x=1792576538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQV0Fcz4XhYiKhgXtDp98wuypaR6LNxiYitvQA87yVg=;
        b=lSUQi1Y1b4bonemd+tPYBcf4iyudeW2fluFXaPl3Z2dWyDaVFiE+YhctCNw6CbJ9br
         fYNrk7cVuGcb7emfbTTaS5l3a99hSRUaffeDC+TuoYW6jiQIY7Kt4tNrk/NVTZJcxTR0
         CkS2om7qmwwi8XHAMef7nu61KWRjkve8En664=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971738; x=1792576538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQV0Fcz4XhYiKhgXtDp98wuypaR6LNxiYitvQA87yVg=;
        b=KmRJKolfE0FsMzvb/ZQxRUP1KzCyVD1qdApJVuqY2poW78+vySAe8/zLL+5PbBQ2n0
         6xb+Ek5Lt32wFrC2SzY0dG06aGOg096CcfDfy+S6I6dzSyzOtrXSdapEFBAa59DCrsNR
         IZMKhVslXfa7Erkus20jNl+1EO6s3UUYuNWGwRQYUN1gMtKpGrXogwZ7McLdRFL5diZ9
         +bGZPF0Hblnjz1we3m5I8mvY9wSToRSCoVR0u0KiX1sGfaneIeRW0ZVHCzyVSrisaUNw
         YDaqa+Y6+ep1/PtRqQNfs29m+fkUNoIpE15Qxr0v7jfdfnQ0tsDyyluqKGXn301hzrJh
         Oddw==
X-Gm-Message-State: AFq9FYKekLlH3EIhvcWSXRRGdnr1+hG4Qxq5CA566HfPcwZ/CCSeSBpR
	vaQTC9rY5VzufFrpzL5Sq+UiWhqqiM1Z/WZJmC/49CKIDGtN5Lvkl8xSqzftVf60P4qYMfEhHCp
	Wto4=
X-Gm-Gg: AYBFou2iazoVHLQGLLl8uOZb9V9kQ10GuzkejwXpMJCY7OZ8VgQT22BF/HLlE0mjfDH
	aDFkkOVoW51Bre1IhPHrTgQcl4jpmRe0eaLPTBBQ5De7c0YkxR7aBZhBrs5xvwVwwLIfGvzX44X
	yMkQmQ7XngKhPqVDMLltpnW3zoW3TySpHFbV/rxESaw3RMwKNGRsc2c4rujchrPvRemFHrubmtp
	NhBQtpqLdCAVXvBZsctkIFcfuEkxd9K/z7/FI1oexS5bZsCXHyprOiDGs+7c2TxQJ4QKpupNYN2
	urhJ9fkQrT/Flby4T/vyl8p2j7FbBJNCbCefgHqP6fYYe7e4VnTc6YiMz73iBzGcUVDL4Rj8pVD
	1rB0zkwxB4GOhAjDuI0hOOUoH8qlEsrrcJgrD2B2Ozirf1SsbLNLDVaVQRq57kYywUTZ3uzJqQ4
	C+lf6RW+if7II/sWX3jW+jwUQp7RsTjQ1iEHMieQmoxcu4TkgOWuX7pS1uJHS8qtrF6TlVr2scv
	sxdOWfiq9WVrRWS4LtPWZScnmippT3ZDf+5/C6rj3qxabrCyOF/1Qk/+t6a
X-Received: by 2002:a05:620a:6f0e:b0:93c:8f50:8c65 with SMTP id af79cd13be357-93ebd2763bdmr2371964185a.64.1791971738420;
        Wed, 14 Oct 2026 02:55:38 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5055eb3sm453074985a.33.2026.10.14.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:55:37 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v6 1/4] net/sched: cake, fq_codel: return the classifier result to the caller
Date: Wed, 14 Oct 2026 05:55:29 -0400
Message-Id: <QDISC-BA27.v6.r0.20261014054826-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v6.r0.20261014054826@mojatatu.com>
References: <QDISC-BA27.v6.r0.20261014054826@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Fix:
cake and fq_codel run an optional external classifier from their enqueue
path and then compute the flow hash inside the helper. Have the helper
return the filter's overrides (cake) or a 1-based flow index or a request
to hash (fq_codel) instead, so the caller owns the flow selection.

This is preparation for the accounting changes that follow. Packet
classification and flow selection are unchanged.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v5 -> v6: split out of the single v5 patch; the classifier refactor is unchanged.
---
 net/sched/sch_cake.c     | 35 ++++++++++++++++++++------------
 net/sched/sch_fq_codel.c | 44 ++++++++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..6432d10c992e 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1712,18 +1712,24 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
 	return &qd->tins[tin];
 }
 
-static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
-			 struct sk_buff *skb, int flow_mode, int *qerr)
+/* Run the qdisc's optional external classifier. Returns true when a
+ * terminal TC action consumed the packet, with the reason in *qerr;
+ * otherwise *flow and *host hold the filter's overrides (0 if none).
+ */
+static bool cake_tcf_classify(struct Qdisc *sch, struct sk_buff *skb,
+			      u16 *flow, u16 *host, int *qerr)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct tcf_proto *filter;
 	struct tcf_result res;
-	u16 flow = 0, host = 0;
 	int result;
 
+	*flow = 0;
+	*host = 0;
+
 	filter = rcu_dereference_bh(q->filter_list);
 	if (!filter)
-		goto hash;
+		return false;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify_qdisc(skb, filter, &res, false);
@@ -1737,17 +1743,15 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
 		case TC_ACT_SHOT:
-			return 0;
+			return true;
 		}
 #endif
 		if (TC_H_MIN(res.classid) <= CAKE_QUEUES)
-			flow = TC_H_MIN(res.classid);
+			*flow = TC_H_MIN(res.classid);
 		if (TC_H_MAJ(res.classid) <= (CAKE_QUEUES << 16))
-			host = TC_H_MAJ(res.classid) >> 16;
+			*host = TC_H_MAJ(res.classid) >> 16;
 	}
-hash:
-	*t = cake_select_tin(sch, skb);
-	return cake_hash(*t, skb, flow_mode, flow, host) + 1;
+	return false;
 }
 
 static void cake_reconfigure(struct Qdisc *sch);
@@ -1758,20 +1762,25 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
 	struct cake_sched_data *q = qdisc_priv(sch);
 	int len = qdisc_pkt_len(skb), ret;
+	u16 flow_override, host_override;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
 	bool same_flow = false;
 
-	/* choose flow to insert into */
-	idx = cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
-	if (idx == 0) {
+	/* Classify first: a terminal TC action consumes the packet. */
+	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+
+	/* choose flow to insert into */
+	b = cake_select_tin(sch, skb);
+	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
+			host_override) + 1;
 	tin = (u32)(b - q->tins);
 	idx--;
 	flow = &b->flows[idx];
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index e6c87a32950f..4cf3d379b8e9 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -73,22 +73,35 @@ static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
 	return reciprocal_scale(skb_get_hash(skb), q->flows_cnt);
 }
 
-static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
-				      int *qerr)
+/* Run the qdisc's optional external classifier. Returns true when the
+ * caller must drop the packet (a terminal TC action consumed it, or the
+ * result carried no class ID); the reason is then in *qerr. Otherwise *idx
+ * is the 1-based flow index, or *do_hash asks the caller to use
+ * fq_codel_hash().
+ */
+static bool fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
+			      unsigned int *idx, bool *do_hash, int *qerr)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	struct tcf_proto *filter;
 	struct tcf_result res;
 	int result;
 
+	*idx = 0;
+	*do_hash = false;
+
 	if (TC_H_MAJ(skb->priority) == sch->handle &&
 	    TC_H_MIN(skb->priority) > 0 &&
-	    TC_H_MIN(skb->priority) <= q->flows_cnt)
-		return TC_H_MIN(skb->priority);
+	    TC_H_MIN(skb->priority) <= q->flows_cnt) {
+		*idx = TC_H_MIN(skb->priority);
+		return false;
+	}
 
 	filter = rcu_dereference_bh(q->filter_list);
-	if (!filter)
-		return fq_codel_hash(q, skb) + 1;
+	if (!filter) {
+		*do_hash = true;
+		return false;
+	}
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify_qdisc(skb, filter, &res, false);
@@ -101,13 +114,16 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
 		case TC_ACT_SHOT:
-			return 0;
+			return true;
 		}
 #endif
-		if (TC_H_MIN(res.classid) <= q->flows_cnt)
-			return TC_H_MIN(res.classid);
+		if (TC_H_MIN(res.classid) > 0 &&
+		    TC_H_MIN(res.classid) <= q->flows_cnt) {
+			*idx = TC_H_MIN(res.classid);
+			return false;
+		}
 	}
-	return 0;
+	return true;
 }
 
 /* helper functions : might be changed when/if skb use a standard list_head */
@@ -188,17 +204,19 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	unsigned int idx, prev_backlog, prev_qlen;
 	struct fq_codel_flow *flow;
-	int ret;
+	bool do_hash = false;
 	unsigned int pkt_len;
 	bool memory_limited;
+	int ret;
 
-	idx = fq_codel_classify(skb, sch, &ret);
-	if (idx == 0) {
+	if (fq_codel_classify(skb, sch, &idx, &do_hash, &ret)) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+	if (do_hash)
+		idx = fq_codel_hash(q, skb) + 1;
 	idx--;
 
 	codel_set_enqueue_time(skb);
-- 
2.43.0

