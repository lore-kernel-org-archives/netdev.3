Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425646;
	b=ydqF/F7dlpWtiS4+oEAyceTdn1chOIEixdiq+3XT5vO8zm6aRBbTYo+bNYgy8lH8QSnW
	 Zzb/qf6mpFvfV0h7puhFYm3UhPRCJLpeXwosBZTUWuMQxRV9WHwJvudMj0HkBbCOjtKQ1
	 aXSpx8hInehUCZaJpa2dkKrC6I+0+eRSk9VCzGOTx7mkjRMEuPhUXzDSX5vbBIm8VVHgN
	 zT/ATS/E0UcOiVj2hJOt3gOfG6bF9AEs1EqGyPvDgLfRAt15g30adfS9yTUrOF86ZiT2Q
	 0uyXG8kq+ppJUAudIxwtB9UxpfauCcBf9YmI5l38T2FOFHk8oTiYlh1rqQMy1jhITXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FN7WEcBosTWIWdp5hKIFXESN4FwIgX/bUYsZFvycnqI=;
	b=ySuqynVT30XrKXF0TMRuh91KfnqTOc3qeZWM1UM767JCVShR/PQ/7jKluuQ6EiUWezCi
	 5m51jYusuQQOdBs9PtXg4qkamx+7XcaHIbBPfqTzG9J4o4KmDUdg3D57H7EDUK2OEr8fH
	 bKTAW0s84e6/EilCr/muDw2D+3UraPDRP5x9VxFnUrODtq8s46WFGuqLAGfdZCixOU/t1
	 S8T1hdD/d8cQK1zurMie6Ladq3DhJmi/iUGsCZb9jzRZQNSGFk+Al+dyTyYFGSW/25lrN
	 1vqrqcSdL+fyBSu8QVCEvXh4Dd8Gyk30TlpOT+mbu7MiDWBBILtH3ThjPEazTN+4L9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=aUPlm9ZM;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD4606AF9C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CBD4606AF9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=aUPlm9ZM
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917ad52d7b6so26680916d6.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792425645; x=1793030445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FN7WEcBosTWIWdp5hKIFXESN4FwIgX/bUYsZFvycnqI=;
        b=aUPlm9ZMa6mKXzzf2Uo0GEF3/bAJNvsWXRhkVyRihXQegS4ttSyUvbUSZKLfCZcW1s
         4Fs+ExT9BYxX11Og7xYkd6WxLD4CxD1SeSEf+MR6TC8niKdCJy3oFb3YU6urb2+x2doH
         7aPXA02UcchOESypg1CoWtDOk69b+z/vrzFho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425645; x=1793030445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FN7WEcBosTWIWdp5hKIFXESN4FwIgX/bUYsZFvycnqI=;
        b=rtwUoKCH2/2rjizSLDy4QriGsmffZJLXAepSzI7P8SpuubcOHdPPSEKzTLwB/Deyz5
         AjoqV2HD+IoI0l0WWYIAIdBFYFZ7nwRpMeL8MtT2YrAKYFQCBgKl73m7tXh5lH8njzPh
         ReMk9QbKq9WbzZWijdaqxlXrzYbqv7kj67KFpD7uH9ogyYr5Zs2fEDaLhKXpzI/di3vb
         mW/G78MfNUmR6kkhebKuXgYqeeoKPfXAioFvcErkBPOVlYTDFqA6bj2niz8mnv5bhvFa
         fvVk5WPbE/SRT4gFSofrtHVoRH4FVM4ibqJXQGB7Ax2P2aijPpKOMbe2P5/zo1wgHPh3
         W5pw==
X-Gm-Message-State: AFq9FYJNndS0djB1hGCQ3AqdcIqUVhuE4w8J0Uqbv96yRGe+oBYp1mzC
	S5ZpAQwOWHukArGcafCXNUIL7b/I1LZ5rQLYUtIRDRZSEzb40Lo5ObjqErCgOtaJWtcKXOooR4l
	1Oc8=
X-Gm-Gg: AYBFou0Zc9H8mCYqQCsJHchL1NFvjGD7kgt1IkYA/61FTGonGFEaofFFFwarfxMDL84
	zOruzBZd9djU5pkqjEidlxjyeFMceu0ult3fBoScBuVX3WvDVyQXc06Nwp5+Mrnevrv9jXYX2n9
	VYFn6WTkkpjA6u/oZomLET995yJtM6TEA83sFg+MZmSdf7T4KYuH7axp1aRDHqFeITFTmV6pOaI
	s1RCTR1JJTvAObJTFrOMHqOcM7NlphOCmacpr1XEbviJWZ5KvlqBWjS5Uza5+ta1DYyT6JQuBGQ
	WyIFZ5vjf6j1bNO1Mhg7qSKo3Cs4Q2LmA4A3keLmZsbfeEuYisU+uO3VbaK1nfJqjOZLPqgjsUT
	CDE2BwYhP+QnmQHf9zTRQGKXFpQ7l/CrCRevV3Qg4NTiEUMSE2YRPDEMW7fXYW49St08Y1tnqDV
	nJohIURH9JQyCQA8oWez9ZoFO+t4PCx6ugGe07vrVijqFBibMZg+8g5YP1pGeduzCn+8h7YWlax
	AZAvjcDoQPfq7Pt4gzPQHVuPaSdoKxmCt25hkvxnjFV
X-Received: by 2002:a05:6214:2246:b0:919:88b7:f043 with SMTP id 6a1803df08f44-91bdf2b2152mr150504206d6.42.1792425643821;
        Mon, 19 Oct 2026 09:00:43 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91be9d8acb5sm64846846d6.0.2026.10.19.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:00:43 -0700 (PDT)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v7 1/4] net/sched: cake, fq_codel: return the classifier result to the caller
Date: Mon, 19 Oct 2026 12:00:32 -0400
Message-Id: <QDISC-BA27.v7.r0.20261019115505-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
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
 net/sched/sch_cake.c     | 35 +++++++++++++++++++-----------
 net/sched/sch_fq_codel.c | 47 +++++++++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 26 deletions(-)

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
index e6c87a32950f..011b8fc54d84 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -73,22 +73,38 @@ static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
 	return reciprocal_scale(skb_get_hash(skb), q->flows_cnt);
 }
 
-static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
-				      int *qerr)
+/* Run the qdisc's optional external classifier. Returns true when the
+ * caller must drop the packet, with the reason in *qerr: a terminal TC
+ * action consumed it, or no valid class in 1..q->flows_cnt was
+ * selected (no filter matched, the result carried no class ID, or its
+ * minor was above q->flows_cnt). Unlike cake, a packet with no valid
+ * class is dropped here (a BYPASS drop) rather than falling back to
+ * hashing. Otherwise *idx is the 1-based flow index, or *do_hash asks
+ * the caller to use fq_codel_hash().
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
@@ -101,13 +117,16 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
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
@@ -188,17 +207,19 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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

