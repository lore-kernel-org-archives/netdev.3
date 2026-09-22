Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B054A7EB
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111538; cv=none; b=nMrnGjCBBgv6nXwX6CMGk6rm4AAmMRuU7tBDukGrwchRVGENWnV9sWYDGhmf8jL838siDpu7mR0FN512o8Mxu1aXO1WIHI62uFLG0GPJa2bSqIc1qjl1oD+YtdL1W1qAuYgyMG9DxWsFgnxdpaUZIQc2/mlSTNV4wUWWq4WYNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111538; c=relaxed/simple;
	bh=d2swiA7I6cFbtKN9uMLHwpoHtcqZjjVynhBD4VanSRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KabCF/ph2eQ5AsMPNSv2HXTJj7380ShMcKd380RV7RtMOfshwWOVmVEvYwS1SrciIirVCOE9Rm+ouWSAul9xJvt5dkv/6TFKBwXZG9w3VQe6rZXIZciBTPmf/im6fwAJKjX0ezSTrMooSCMj2x9QjCSHaqZVefxqPqFzp/ubsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7GfO7Pq; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7GfO7Pq"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso289730eec.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111518; x=1790716318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKobARkBm3jckAeWzRLINPL374n1cjc6XoeTqsHKNiU=;
        b=T7GfO7Pq2trlZMPGV12Q81tV4rf/yUOhUNcc2pR+U6lTrw1bhtdd2wIgjYvVC5+mbK
         kFtdiQRpjNjX1LIRlg06Ajc8PHeSVBuuxQqKg8Jm7dN/xT1FRDQRsIZCVBI3u+cXCIV7
         vgfXXRYrZM/Bqj5tGQQj5G6CFV/mVSlCO1OF1iRZeTUIq69lmWVbNIekSaNjK3zgx8X9
         17JgpFlfNVtd5Zq9qdXm+NPxtfAOvm5Kw40waA1xRViRXcYaYGS3ZdMhWSb1QeWih+nE
         4dHKsdjoav+dyTn3GwP8mdPVMRWqak6Ge/YOsyMPNWP0igMwFgnnG37Exf1v3OW0Nfry
         6kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111518; x=1790716318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKobARkBm3jckAeWzRLINPL374n1cjc6XoeTqsHKNiU=;
        b=CAtM8ELFEGcG4qrYwAaylIEYGLCm7fia22CPO3OtKO6Ugjb6Dqq5HQteoqAyvzZq1v
         Z44gGicv2mC/gu9GM7kYtXNq6PR/FnQ/xs+3NSB74++rsk7NrGbFmxbxULd3SJ5Czhpu
         /esuM27tv0GukIuRGcnpqDIaK0Uvzq5kjLy2Erjxo8RpBbhpxeioQOo/FWeZPa0BObHR
         JQSRi4BnAHdUlFMkbP6LyKhnlFLfid3i3DMHncL6lvcoHcVILRoar0yMCsr7pLnSF+ML
         70jtJZlhitnvwbGfWTj7vmDGM+yBVPlc94gc3eaIpN43zKoEpl7Pwn+TVfinBGOntVZx
         jbrQ==
X-Gm-Message-State: AFuF++kS5caYn7o4ULINPyazb3Wlc+T+1/udYnMoU/DvddTptEpL/2s/
	EkisUzXQFicB54mLrpcgLb6mG31SAJ+86P1NwgYBouCtoTvsROaV98U93olDpBkA
X-Gm-Gg: AYBFou18M8cJB3uwezhTWDQrOrz4mLpOjH4DpeKj3EOVCOO+ctr0e9x0iz1hYMG2HD1
	8uW75hCSKZseQULJ+EAtENaLd2dlYiwK0e5qZ5fr2bkc/DRIUOg+TarVyd34lG+zVIfKQ9utXoJ
	h1zBaKyH/2onW5w4x5C6S3WCsQ7KrlKlbuGYMKHlMI2hM4Nu4qRVXNMM09tUOoRt8dt6yEPuFAc
	CmX4Kn49T+XmVvYvo6ctdPnTMmazaeBdHv5VUXZTZTii0YdG1aVqohYyKV66ROFDfw0w+o833IB
	/K8Eng9bNjzJbcBWK/xPP1mnyMyK1SxFT8NCMwUiKbkh4gyJx9ZzspdL05u4m+P2GRa1eO7xoqU
	m9sziuQ6/F48l1bnVVSdmTc9Gyjo0Ynl1XZld2Z1A6wJNy0HBp4LC6LtjPyCqE+CIPul9jU/wyL
	aYbiJ4mSpKgInOoOHHo0PZ8D14B5jdgGGTuGhFmflZkV6gxcMkQg/Ns7/WtyU39mRxwqBYz3Lzb
	TGGjp7DRMDTzCRUWqSj7FAzL5buYGYL6ZPr4amMEa7oA1x80GB7+qyeqx2oYd4e3h98Rwi1xKQ=
X-Received: by 2002:a05:7300:dd05:b0:33c:357c:d33e with SMTP id 5a478bee46e88-33e8dcbc59emr508003eec.28.1790111517740;
        Tue, 22 Sep 2026 14:11:57 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:f16e:2102:25ad:9cdb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm943147eec.4.2026.09.22.14.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:11:57 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v7 1/2] tc: fq_pie: add support for printing per-flow PIE statistics
Date: Wed, 23 Sep 2026 02:41:38 +0530
Message-Id: <20260922211139.38570-2-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922211139.38570-1-hemendranaik@gmail.com>
References: <20260922211139.38570-1-hemendranaik@gmail.com>
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

Add `tc -s class show` examples to tc-fq_pie(8) demonstrating the new
per-flow statistics with and without dq_rate_estimator enabled.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 man/man8/tc-fq_pie.8 | 18 ++++++++++++++
 tc/q_fq_pie.c        | 59 ++++++++++++++++++++++++++++++--------------
 2 files changed, 58 insertions(+), 19 deletions(-)

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

