Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A44379998
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789798398; cv=none; b=BOFCLpXEbNP56O+Jos75uc2MmySJfvKq500Ik1yxNxvZ5k1yOos0E1W5PDijU6DZelF5rkNDmMiQwKxMR0lmck7mXNFLN8CfbUhWDdTNH2PAr811EV0Y/V9lNIU2lloizuUE3CbVkbtl4fZ7G1pblAnGQYyWkxn3S4gY3tvGiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789798398; c=relaxed/simple;
	bh=y61k6gZOnEK28c4elLqVh4jmqgYX1qNkC+5TeBcNnvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyVW7nrr3BuYb2YwAHXBId1f2el1yZR07YluKMwaIsBz/nUOiNjUxK9N+A2zGiTSCRtaElsYqYepGajcmVi7kSjao0hnzx7fwCFGYmM0WkhgoSHS9R8q9bXiImPsO5I67mSYaY0BT3J69oRCZwTmdvGw80nOMhzUYFNBaA+KR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyMe7cBl; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyMe7cBl"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50db3so826518a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789798397; x=1790403197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrD9gQVR4gBczVkX17GB94+S3KMBMN9yoFZXXeZXVNY=;
        b=TyMe7cBljiPEUQDYcipv0nOGMD6sAPnmVegeWQN1D6eGQhrgOoQyEza22hROXbRnTQ
         ltC7nbi5pGNT4AtCsievskGMt8cq9lne0GEWeQiSoJfzSinYLJEL8yw3j5dmhcLpReP/
         k/iiwEMrHgGWA8Z130By5wXkJzB5VYZyc4Ap1L3jI7AE0PSe6oioRmecThaecm7Sf2br
         QK1bTbY8dkLjy8WykvyvaTeRv5Jrq72eqijeIropzQB8Oy+yX7z2Y/Ty5Lx5qVXkmxGi
         Y4KS4BfLPGiX8Vio8TGSD8vo5hsw5XUbCtRzKRdEtbEnkJZtWW+sjGVoG9x3Up8INmPr
         98PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789798397; x=1790403197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrD9gQVR4gBczVkX17GB94+S3KMBMN9yoFZXXeZXVNY=;
        b=ZbULqHoVZlacdqtp2M5S/EO9E9b1PZOysaviXTXcnfRVEaAcZj7CXm1jWyuGeqop/K
         pQ+M3sj/lZgst8acTqlS6drxTN5gm+b1xW6y1+AcY/s0YrgkIfHw/L0zj+KoMaLP5UCs
         MI1QGqSaTQ9bCWSHrpcR5/NJFn4E1+/9b2ys9ZVmIA4NqIuDuiuOtAe/9D/cX8MyH/9p
         0RRI9k4PKawgzcv8V93eVKhEhDS2j9EDPcyqoPmYOa1QrsNk/nE6f2i0dLvhNF6h7lEn
         eNvJyYCkv8KhB3WjJrMFtmrozkjzjJy6K3SF7OQG2dgtVJhn6s6oxv1FX93PNn4zXswV
         4Cdw==
X-Gm-Message-State: AFuF++lLVsYBO8ywGVy0/EZg91XbKFs7hdmHuQBTdh/1HOwrKEPoiprJ
	IRZecKkF256Cq/kfOx+JDi3lqfELXi9O7FIKHJoRcDLWKIVaoA1U0bJoYesDoqbYKgo=
X-Gm-Gg: AYBFou2icFOGHA/icD/ehWLYdmJ4QYzydytCvCe2uqmD3ygDO/ca8xa/q9owl/fVPJ7
	QR9RDer5BCa2vRfdhjhHX5rwjg9l9TLrcsxn0GHxnOJzjP6EfEtKWvHLgUy6nts2kyIESxGyqmX
	A4QAbDebXVkNBv/1JPDCa3W9siGMMmTXe9Ixm0NpU6QDIfFHRaoxDWMe31YZXxKslbMaJxprZs4
	vkhRR3VXClxCqsPY7/KJAL2fJgawAGZdld2InaeTft1vEz87JWU+ju6oK0rcDAOTY5HOdZspUxh
	m8GVU4+hHE8fltsMNroiCNZc7xSXd8eqwm0ioX/w1ZmQvlJCzTrhb1Ci2e/uR63+0W5ssRGgCEf
	64yBpoCfqaLrl9Busnc7FHkRsIonppZFIqhRkcsO0UbQxEkYv6B9yD14E0jEmtoMpj5e/0mqp25
	B++1+xIJiwN5jwUXE0LXIGdgkcg9L+/MrVDDx9T+XmvHjw8NgdeZOWEQGA7jYiQW/3XSnnWtVBw
	aWm+8WRVRc/tFo16AiKIttiLtJzaFEUjFZ+aWo/9Ce/P03nEqFfc7YEPnZCtujWTBW/1ViJakfy
	0zjBqUi1Bw==
X-Received: by 2002:a17:90b:2ccf:b0:39e:6a7e:ee1d with SMTP id 98e67ed59e1d1-39e6a7eef8amr3450727a91.41.1789798396697;
        Fri, 18 Sep 2026 23:13:16 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:d11b:773b:fa83:c49a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55f299fsm5781280c88.15.2026.09.18.23.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:13:16 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v6 1/3] tc: fq_pie: add support for printing per-flow PIE statistics
Date: Sat, 19 Sep 2026 11:42:52 +0530
Message-Id: <20260919061254.39678-2-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919061254.39678-1-hemendranaik@gmail.com>
References: <20260919061254.39678-1-hemendranaik@gmail.com>
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
class_stats is a direct struct member (no empty qdisc placeholder).

Add `tc -s class show` examples to tc-fq_pie(8) demonstrating the new
per-flow statistics with and without dq_rate_estimator enabled.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 17 ++++++++++
 man/man8/tc-fq_pie.8           | 18 +++++++++++
 tc/q_fq_pie.c                  | 59 +++++++++++++++++++++++-----------
 3 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index d1f67ef8..b03ee5f7 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -953,6 +953,21 @@ enum {
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
 struct tc_fq_pie_xstats {
 	__u32 packets_in;	/* total number of packets enqueued */
 	__u32 dropped;		/* packets dropped due to fq_pie_action */
@@ -963,6 +978,8 @@ struct tc_fq_pie_xstats {
 	__u32 new_flows_len;	/* count of flows in new list */
 	__u32 old_flows_len;	/* count of flows in old list */
 	__u32 memory_usage;	/* total memory across all queues */
+	__u32 type;
+	struct tc_fq_pie_cl_stats class_stats;
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
index dc2710cd..0c85e17f 100644
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

