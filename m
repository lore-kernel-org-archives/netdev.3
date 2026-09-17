Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6084E021F
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677802; cv=none; b=bS+M1crJXh/kKFVKD0NqtgdZE3wgMIPJUM7irvmwJXhY+tmNi48w0Wu4OIwgISQSR7nx3qChsU1+NcyINdh1QAwo9lRDxmsvXTEDPnOiJn68TTaR0QsGEGCMyQxKnSLcWuE8qfhA+i1o/TCsb/DyKFv0Gm1jeXZ+wpVoouBwENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677802; c=relaxed/simple;
	bh=eC8elISB5qtIOUKXlO0FLQhcvu/y2EQ3rutmmhPEjZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3QifBPt7Aw5EIqzrvlEpQMLgM7LXnNUOY+kyrY3J6saEJ9ruHJF3KkPBqqV8vixiefDTAfskX2WxmdhrvH8+XWTFlysPTMHGizQ6999QlrPgDpSXmp6MSY0xL5XPNTmr+l5l7j5W/f47BxThSUolROIe4PoH8lu+LhNJumZvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRG3rN5I; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRG3rN5I"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed1368so708545ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677800; x=1790282600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HBzd/E1kcUqxPm/kCqliBG780TsQKu465rZObaAoL4=;
        b=dRG3rN5IBueuca1fDMkhM7MGmr6jmv8jjSZL0skRmlv/RJXetwiRTtm3IuipEqKAzN
         2+uf4RLRoTWX7QTt3ax9GJ9wnPqSHVAA56MYZTGM+L2dyXcl33xTLXHFRIyGHQVrzhKL
         WG5U+xidaDp0Wqefjk00XhTDw8WZ3LY0mLHHkqlVS/yLB0rU4FnOm4z/l2LeK+ozWIMg
         xt+ni/PUCI32sozMZtoSN9rD3DFagLihuUU2FqiKdJrb5HwosWBiW8RuptYhCn8+93iQ
         zgv8OZQ7dyJj8Cck9qY7KykfWcdmm+Kz9Px9j4wDjkclHY3Zkn9cN4VTg0aOcQtRgX+t
         KrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677800; x=1790282600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1HBzd/E1kcUqxPm/kCqliBG780TsQKu465rZObaAoL4=;
        b=APcd3VQAcYmxhOUJscysT6f/azxlftOJTKaUiUn1CJ2LPuJMPq3izfQvlaGkOEYZum
         Nm0gibwmIJx1KQPtvIQKx4CSgLRw6z6HSaNoVpbWqz/O7jSN5NQPFNPxKyXF0vSPifmA
         x0djRBeSuZGniFQbeA+a3TEV648azkw9+EoP1Sd7kVv0Mjp3mLdKtpbH4T1Rco2b7oNA
         cvgijcK9FEAkpFnLLiCXSB/JB8nhcjJFMOOeOf87PEzwsNTcueFfUWo83dzzjFDK5gNk
         O5sQxDcoZcRYkTaXfsCdkY0kDc8+ipzI9hwpcXt1IN8Fn2ceCyxS6jbf1tCVnW0r8JER
         49wg==
X-Gm-Message-State: AFuF++mDgDJpW63nmGZtIfqnbglzs8OxdpT5txfvvsaYsBRnLQaW8Xlz
	K1HNsYZAdqAyt9LnXlwYSKiFHiTwqbK9K7lVTVBYwDchKBkfKlNn8XqSsJtPPqRf
X-Gm-Gg: AYBFou3Kbg8MXCLvpmyhyuSL+Y6OUeVJqX+BOCmPhUg8S8JwQ9uQHIBOrfoD/CVnRHu
	5W/Hn4hS6NWQPuhLpztd/3BaUUzR/LYZd+314fMC7jarShrCfwer76oeCXdBFxMqNaJHQnvhpUX
	6oToObj3qiMiTEhNt0M16uFCDqJ9hhT5HeuBSc2q6V1WxpHH6dS+fBg8BK9MmvGzVEzyM3CuApg
	4eXef4aiczjlMbjHOSJbh2GzoYIrkXOkXQGiJX8/wwvZvDJxHmz+WmYBcOqZhSNIuW+m5ZN4vBR
	5SDhF2sFa/Mwz2+JzPzfdpunVzuQEhs9qjXV1NFKEX/d4cmTfG1JaIdzS1rub5FviBKWv5lCfYe
	LjuXzZiQ9GZRXOehTRxiQxbE+eQl9Q03D3onPWWA158gFwgvUd/d5geZSKrVrOdekOKyDluF5C7
	GZ6FpQlA2PweGwKDYbfByKF1F+ZqCzyFMwxNQoSWMGyYDb5teo+BEr6Zc2jWbTcFCdvcXFsvWu0
	6V8/TqTh5ICOYm6/kDWTsQf1xPx3gFFHTI+9qipKohVoiWKBr03yZc9CZNFJdmwzNf6J4CkaWiY
	j8eBJQVGPw==
X-Received: by 2002:a17:902:db0f:b0:2d8:d4d0:7931 with SMTP id d9443c01a7336-2ddb1b995a3mr6577915ad.21.1789677799963;
        Thu, 17 Sep 2026 13:43:19 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:6248:69c:ea81:be26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c1943f4bcsm3620046eec.21.2026.09.17.13.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:43:19 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v6 1/3] net/sched: sch_fq_pie: add per-flow statistics via class ops
Date: Fri, 18 Sep 2026 02:12:23 +0530
Message-Id: <20260917204225.275251-2-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917204225.275251-1-hemendranaik@gmail.com>
References: <20260917204225.275251-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FQ-PIE schedules independent PIE controllers per flow but exposes no
per-flow AQM state. Without class-level statistics there is no way to
observe the per-flow drop probability, queue delay, deficit or dequeue
rate from userspace.

Extend tc_fq_pie_xstats with a type discriminator and tc_fq_pie_cl_stats
for per-flow metrics. The nine existing __u32 counters keep their
offsets, type is appended at offset 36 and class_stats follows it,
growing the structure from 36 to 64 bytes.

Wire up fq_pie_class_ops with walk, dump, and dump_stats only so that
'tc -s class show' reports per-flow state (prob, delay, deficit,
avg_dq_rate, dq_rate_estimating). Filter attachment callbacks
(.tcf_block, .bind_tcf, .unbind_tcf) are omitted on purpose.

Derive delay with div_u64() from the full 64-bit nanosecond value rather
than truncating to u32 before dividing, which wrapped for sojourn times
above ~4.295 s, and widen avg_dq_rate to u64 before scaling it by
PSCHED_TICKS_PER_SEC.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 16 +++++++
 net/sched/sch_fq_pie.c         | 86 +++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 490efd288526..9c0c9787f0c3 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -953,6 +953,20 @@ enum {
 };
 #define TCA_FQ_PIE_MAX   (__TCA_FQ_PIE_MAX - 1)
 
+enum {
+	TCA_FQ_PIE_XSTATS_QDISC,
+	TCA_FQ_PIE_XSTATS_CLASS,
+};
+
+struct tc_fq_pie_cl_stats {
+	__u64 prob;			/* current probability */
+	__u32 delay;			/* current delay in microseconds */
+	__s32 deficit;			/* number of remaining byte credits */
+	__u32 avg_dq_rate;		/* current average dq_rate in
+					 * bytes/second
+					 */
+	__u32 dq_rate_estimating;	/* is avg_dq_rate being calculated? */
+};
 struct tc_fq_pie_xstats {
 	__u32 packets_in;	/* total number of packets enqueued */
 	__u32 dropped;		/* packets dropped due to fq_pie_action */
@@ -963,6 +977,8 @@ struct tc_fq_pie_xstats {
 	__u32 new_flows_len;	/* count of flows in new list */
 	__u32 old_flows_len;	/* count of flows in old list */
 	__u32 memory_usage;	/* total memory across all queues */
+	__u32 type;
+	struct tc_fq_pie_cl_stats class_stats;
 };
 
 /* CBS */
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f8..675861f578b8 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -511,7 +511,9 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 static int fq_pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
-	struct tc_fq_pie_xstats st = { 0 };
+	struct tc_fq_pie_xstats st = {
+		.type	= TCA_FQ_PIE_XSTATS_QDISC,
+	};
 	struct list_head *pos;
 
 	sch_tree_lock(sch);
@@ -563,7 +565,89 @@ static void fq_pie_destroy(struct Qdisc *sch)
 	kvfree(q->flows);
 }
 
+static struct Qdisc *fq_pie_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	return NULL;
+}
+
+static unsigned long fq_pie_find(struct Qdisc *sch, u32 classid)
+{
+	return 0;
+}
+
+static int fq_pie_dump_class(struct Qdisc *sch, unsigned long cl,
+			     struct sk_buff *skb, struct tcmsg *tcm)
+{
+	tcm->tcm_handle |= TC_H_MIN(cl);
+	return 0;
+}
+
+static int fq_pie_dump_class_stats(struct Qdisc *sch, unsigned long cl,
+				   struct gnet_dump *d)
+{
+	struct fq_pie_sched_data *q = qdisc_priv(sch);
+	struct gnet_stats_queue qs = { 0 };
+	struct tc_fq_pie_xstats xstats;
+	u32 idx = cl - 1;
+
+	if (idx < q->flows_cnt) {
+		const struct fq_pie_flow *flow = &q->flows[idx];
+
+		memset(&xstats, 0, sizeof(xstats));
+		xstats.type = TCA_FQ_PIE_XSTATS_CLASS;
+		xstats.class_stats.prob =
+			READ_ONCE(flow->vars.prob) << BITS_PER_BYTE;
+		xstats.class_stats.delay =
+			div_u64(PSCHED_TICKS2NS(READ_ONCE(flow->vars.qdelay)),
+				NSEC_PER_USEC);
+		xstats.class_stats.deficit = READ_ONCE(flow->deficit);
+		xstats.class_stats.dq_rate_estimating =
+			READ_ONCE(q->p_params.dq_rate_estimator);
+
+		if (xstats.class_stats.dq_rate_estimating) {
+			xstats.class_stats.avg_dq_rate =
+				((u64)READ_ONCE(flow->vars.avg_dq_rate)
+				* PSCHED_TICKS_PER_SEC) >> PIE_SCALE;
+		}
+
+		qs.qlen    = READ_ONCE(flow->qlen);
+		qs.backlog = READ_ONCE(flow->backlog);
+	}
+	if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
+		return -1;
+	if (idx < q->flows_cnt)
+		return gnet_stats_copy_app(d, &xstats, sizeof(xstats));
+	return 0;
+}
+
+static void fq_pie_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	struct fq_pie_sched_data *q = qdisc_priv(sch);
+	unsigned int i;
+
+	if (arg->stop)
+		return;
+
+	for (i = 0; i < q->flows_cnt; i++) {
+		if (list_empty(&q->flows[i].flowchain)) {
+			arg->count++;
+			continue;
+		}
+		if (!tc_qdisc_stats_dump(sch, i + 1, arg))
+			break;
+	}
+}
+
+static const struct Qdisc_class_ops fq_pie_class_ops = {
+	.leaf		=	fq_pie_leaf,
+	.find		=	fq_pie_find,
+	.dump		=	fq_pie_dump_class,
+	.dump_stats	=	fq_pie_dump_class_stats,
+	.walk		=	fq_pie_walk,
+};
+
 static struct Qdisc_ops fq_pie_qdisc_ops __read_mostly = {
+	.cl_ops		= &fq_pie_class_ops,
 	.id		= "fq_pie",
 	.priv_size	= sizeof(struct fq_pie_sched_data),
 	.enqueue	= fq_pie_qdisc_enqueue,
-- 
2.34.1

