Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5A4334D6
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171067; cv=none; b=YRid21xiD3n5mGWpQpdJID+iORib+GlN2u4mGicg7nI1sKiQ3Ktx8AanSJMoBXfYP2u+TgpOQe35ivMFbbOGaSYrxzzYkWLI+8IEUK0R1ZuQi9lT3PbgWZnsybBf/HhuR7xqAwROeau6kuJQHB7pt6e2ksOp+9I8K7ruH5KogZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171067; c=relaxed/simple;
	bh=EFap+0Pavz/24ImH3YVroVnD8VJjQLq98anJYXnRkfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEz5LLZ7Bv1q8o1GRg0OGNDIrJfcTgxMUmm3w6NV0YwDilHwhzx5UVb+jp8a3aMxg90DfVRMtt2NHcSwQChKdZmAvLPJClX6XTJee9OIgVrNRsVnrDXA+F486JdpAyOxlQWpBKd02CtAp71Jbw7o2AGFwsf+mL9axsU1Mp1vFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B78cO971; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B78cO971"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceab75934dso37006405ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171065; x=1785775865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BoOYAv6t7HY6tK3WsqfZ2YOFllbvJkY7CtuDzGR4XhA=;
        b=B78cO971YFq2F1M4ORwG2FxejT0cRj3hl7q6AqnSYSpRMfEk7PpgRbKZBgyzUhnj0N
         QhCoTpCA5COhyGPmfzw4taIHfp8EfaNrYwY8dBTSpphZz0PcKz9CCLMUGJuwGhZBqgoh
         KG0H00eJFM5/UqbmyHdLG8g6B1cUyw5IZZ59s8+7bSODTvVEIrvxQAxHRKTDKi3ezI5o
         Q8iyNZcdpktT/M0s+OnpnxOlfRmen0PvPy3FCgZ24HIye6yoLYR0ama4OxNYKVFfNGYG
         xIqB93nQi/Prp0iA0+FbPRMAizKzOH93whJMSBianijPxidDS4BT8PRah52eEfiKqPXo
         VgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171065; x=1785775865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BoOYAv6t7HY6tK3WsqfZ2YOFllbvJkY7CtuDzGR4XhA=;
        b=fMFf44rFSSvp35dMNW5THEZ+c9VB7gSvLUal4Nn7ZqfD299gZqHGMPrQ3jwrgo+CvH
         XNHwz4cuBMBxwo4abC+VGA+tvkOVDrgkppwC08BDeRDQqLFjrQDrny7Ak8S0IeDHd/Wm
         hxXsgd0iYvtNO0ibca0qmmK4b68Og29f98Jf8LAXYOwgdToo+Kw1zdCwIOrAW2KV38Hs
         szlTQ3U4X2mrvaB+U6T0KYVsk+wWuC59ZcDmZu5EVX6vKqx9HTo9E93xW9Yrbp3FpwEp
         S673haj/QpoKId/GyNgKE3vls0jRXuNUCHftC+ka8840MCmfyuheyO7/1lR4UJYyF3ms
         9SNw==
X-Gm-Message-State: AOJu0Yy/BIq+jwruiLZPPYOQch9jGxtjCAOEg7g5IaW8oYxZVtxqMPI2
	NcYrns+CYdbJEl+hvRnoEY4fNUNFVG8GL7UIjGfFBI4Cm9K9L7FwRqvGuwWDtOAK
X-Gm-Gg: AR+sD126SnVzZoiAqFeA6EdtE6xmcDkZZgaWddF8fJJwf/ra4TsxUBwinx8Gh7N6CHw
	fuo8ztW9ToERnN5DLIa89yTWhJDYQtUGXRHYns/6AxC7T7LdX+M0TWlWxwW86OXgOYH1qx9aoXB
	0sgeUIq/aa+jU3Y988QJvQXnQ5BfsZnO1P167zK3qR8TEY+HX+6leAbP9TP6GL7a0U+1ItrR6zs
	O2p+pWLm2E1bfC4o3bvgX8Bio++CNjzjmZ6hS9chIILxacOfLUY5rollMKDPVnP4KpxqDEiz3J/
	8Np8uEBji3dG038w4zg67b2t9Ne4jr4EMapTXv3/bLuoIZlpKdl1rfuRYB60Qsx6Q9+8T1YTH4c
	K0glIqnPt/Xc4k/tbKx4Bm/N4owxgVSXuZC1V2riN4ViKkxX61xaTlmRcZSZXkc4n60Y/diQjhZ
	+SumxER8a/ADlbXmfCbntUcES2cNkx3VaIlAAAAST5MqG1DLJbOMbJjJscLdjn6rY3d62FzFlZR
	qj9AQ==
X-Received: by 2002:a05:6a20:9397:b0:3c0:9c19:65ab with SMTP id adf61e73a8af0-3c67e164003mr9577587637.67.1785171064811;
        Mon, 27 Jul 2026 09:51:04 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:8b84:a60e:2cad:e760])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419e3asm33654029eec.11.2026.07.27.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:51:04 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v4 1/3] tc: fq_pie: add support for printing per-flow PIE statistics
Date: Mon, 27 Jul 2026 22:20:26 +0530
Message-Id: <20260727165028.106817-2-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727165028.106817-1-hemendranaik@gmail.com>
References: <20260727165028.106817-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`tc -s class show` for an fq_pie qdisc now prints the following
per-flow PIE statistics:

 prob           drop probability for the flow
 delay          per-flow queue sojourn time (microseconds)
 deficit        remaining DRR byte credits (signed integer)
 avg_dq_rate    dequeue rate estimate in bytes/second
                (dq_rate_estimator mode only)

avg_dq_rate is formatted using tc_print_rate(), which converts the
kernel's bytes/second value to a human-readable bits/second string
(e.g. 3906Kbit), consistent with how other tc schedulers display
rate fields.

Update the UAPI header to mirror tc_fq_pie_cl_stats from the kernel.

Add `tc -s class show` examples to tc-fq_pie(8) demonstrating the new
per-flow statistics with and without dq_rate_estimator enabled.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 25 ++++++++++++++
 man/man8/tc-fq_pie.8           | 18 +++++++++++
 tc/q_fq_pie.c                  | 59 +++++++++++++++++++++++-----------
 3 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index d1f67ef8..b99312d2 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -953,6 +953,25 @@ enum {
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
+
+struct tc_fq_pie_xqd_stats {
+	/* placeholder for new qdisc-level stats */
+};
+
 struct tc_fq_pie_xstats {
 	__u32 packets_in;	/* total number of packets enqueued */
 	__u32 dropped;		/* packets dropped due to fq_pie_action */
@@ -963,6 +982,12 @@ struct tc_fq_pie_xstats {
 	__u32 new_flows_len;	/* count of flows in new list */
 	__u32 old_flows_len;	/* count of flows in old list */
 	__u32 memory_usage;	/* total memory across all queues */
+	__u32 type;
+	union {
+		struct tc_fq_pie_cl_stats class_stats;
+		struct tc_fq_pie_xqd_stats xqdisc_stats;
+	};
+
 };
 
 /* CBS */
diff --git a/man/man8/tc-fq_pie.8 b/man/man8/tc-fq_pie.8
index 457a56bb..8027783c 100644
--- a/man/man8/tc-fq_pie.8
+++ b/man/man8/tc-fq_pie.8
@@ -153,6 +153,24 @@ dq_rate_estimator
   pkts_in 6082 overlimit 0 overmemory 0 dropped 4 ecn_mark 0
   new_flow_count 94 new_flows_len 0 old_flows_len 8 memory_used 1157632
 
+# tc qdisc add dev eth0 parent 100:1 handle 200: fq_pie target 2ms flows 3
+.br
+# tc -s class show dev eth0
+.br
+class fq_pie 200:2 parent 200:
+ Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
+ backlog 22800b 2p requeues 0
+  prob 0.57679 delay 2.38ms deficit -52
+
+# tc qdisc add dev eth0 parent 100:1 handle 200: fq_pie target 2ms flows 3 dq_rate_estimator
+.br
+# tc -s class show dev eth0
+.br
+class fq_pie 200:2 parent 200:
+ Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
+ backlog 22800b 2p requeues 0
+  prob 0.57679 delay 2.38ms deficit -52 avg_dq_rate 10742Kbit
+
 .SH SEE ALSO
 .BR tc (8),
 .BR tc-pie (8),
diff --git a/tc/q_fq_pie.c b/tc/q_fq_pie.c
index dc2710cd..1b89ee3a 100644
--- a/tc/q_fq_pie.c
+++ b/tc/q_fq_pie.c
@@ -274,6 +274,8 @@ static int fq_pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 {
 	struct tc_fq_pie_xstats _st = {}, *st;
 
+	SPRINT_BUF(b1);
+
 	if (xstats == NULL)
 		return 0;
 
@@ -283,25 +285,44 @@ static int fq_pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 		st = &_st;
 	}
 
-	print_uint(PRINT_ANY, "pkts_in", "  pkts_in %u",
-		   st->packets_in);
-	print_uint(PRINT_ANY, "overlimit", " overlimit %u",
-		   st->overlimit);
-	print_uint(PRINT_ANY, "overmemory", " overmemory %u",
-		   st->overmemory);
-	print_uint(PRINT_ANY, "dropped", " dropped %u",
-		   st->dropped);
-	print_uint(PRINT_ANY, "ecn_mark", " ecn_mark %u",
-		   st->ecn_mark);
-	print_nl();
-	print_uint(PRINT_ANY, "new_flow_count", "  new_flow_count %u",
-		   st->new_flow_count);
-	print_uint(PRINT_ANY, "new_flows_len", " new_flows_len %u",
-		   st->new_flows_len);
-	print_uint(PRINT_ANY, "old_flows_len", " old_flows_len %u",
-		   st->old_flows_len);
-	print_uint(PRINT_ANY, "memory_used", " memory_used %u",
-		   st->memory_usage);
+	if (!st->type || st->type == TCA_FQ_PIE_XSTATS_QDISC) {
+		print_uint(PRINT_ANY, "pkts_in", "  pkts_in %u",
+			   st->packets_in);
+		print_uint(PRINT_ANY, "overlimit", " overlimit %u",
+			   st->overlimit);
+		print_uint(PRINT_ANY, "overmemory", " overmemory %u",
+			   st->overmemory);
+		print_uint(PRINT_ANY, "dropped", " dropped %u",
+			   st->dropped);
+		print_uint(PRINT_ANY, "ecn_mark", " ecn_mark %u",
+			   st->ecn_mark);
+		print_nl();
+		print_uint(PRINT_ANY, "new_flow_count", "  new_flow_count %u",
+			   st->new_flow_count);
+		print_uint(PRINT_ANY, "new_flows_len", " new_flows_len %u",
+			   st->new_flows_len);
+		print_uint(PRINT_ANY, "old_flows_len", " old_flows_len %u",
+			   st->old_flows_len);
+		print_uint(PRINT_ANY, "memory_used", " memory_used %u",
+			   st->memory_usage);
+		print_nl();
+	}
+
+	if (st->type == TCA_FQ_PIE_XSTATS_CLASS) {
+		print_float(PRINT_ANY, "prob", " prob %lg",
+			    (double)st->class_stats.prob / (double)UINT64_MAX);
+		print_uint(PRINT_JSON, "delay", NULL, st->class_stats.delay);
+		print_string(PRINT_FP, NULL, " delay %s",
+			     sprint_time(st->class_stats.delay, b1));
+		print_int(PRINT_ANY, "deficit", " deficit %d",
+			  st->class_stats.deficit);
+
+		if (st->class_stats.dq_rate_estimating) {
+			tc_print_rate(PRINT_ANY, "avg_dq_rate", " avg_dq_rate %s",
+				      st->class_stats.avg_dq_rate);
+		}
+		print_nl();
+	}
 
 	return 0;
 
-- 
2.34.1

