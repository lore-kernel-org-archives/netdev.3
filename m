Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208713;
	b=yleJ0DWyPdHX0GpkvjViP0XTosPQfnxgYI3HQICnSVaY3aVmD4G1R2bX5xbxPP9CnnmP
	 tIiZzjeDkmYwYFgMeWP7OWR2t5nwbGhdn97QA76dyI9owdG9TlwpcSyldDUK9kZ4UGsUg
	 XumP6ow/x+rcz6mgb6/0udZ/ikvU/OYUi9vfpQGtZoign0/SblkJKTF6IfN7ugAsbj+yK
	 RjIRniHCvduRqi5FmsloUOTbSdry7Oa+GjcW86YHtkEtWpg8XrR/S812IA8qfTpi8gem6
	 +lAyn02ZYa2Is6yR+FyU7WkKJbChbsk/m8i/QK/2vs/d54uSgOdDnW3ewl87y5GDIEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nKobARkBm3jckAeWzRLINPL374n1cjc6XoeTqsHKNiU=;
	b=CyyphaKe25rSk6yzqnreI28Ogia2YBdbXk7pRXhrvMb36XIV1TdsMpp0/o7bWQGwrw0U
	 3W4mFfvHj7c2eEa0uLFw7E8CQrvfrce4eQ3swrToHwoEi7FnaBpJ0bHrPFykXXDF0++ru
	 cF2oY5QecPwqLIBc7XbmHtb9ZIdhD8Qps5Qbz+ft9sSrsBQDpbx9IQCOgXnX72yIT2b33
	 VDKl8ASVLIDMWMhrDXkmK2I79UL5crrwum7MfQH0da782J7uMFus/27ecTF8+l8S4snIQ
	 lk9ira0SfdC45DzrakcjwIlrQWfjaUn3i/RBXdsa9LAt3y7Q/IyaUmgQQALpQmVS6FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHFZmGFj;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D0606A323
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 566D0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHFZmGFj
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1387413eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208711; x=1794813511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKobARkBm3jckAeWzRLINPL374n1cjc6XoeTqsHKNiU=;
        b=yHFZmGFjdpiEy/DkDAhRt+WwDBC/oURvyflBaXZQuRg5Cc+PBOKBXw6l4nF1EC6/Ku
         1w9MEk8iVlicKYKLMibemG/SaCqzMMMa4oCcgRGklWWO+WQg5KEn+lOpKRK2UHLoe3fI
         2LZcnYDdSTOfHpdPH4RpUT5xEQZkU63cNakMDL2Rt8h5o+h/9qefBLXO4lVW9geT4Fqc
         IxAFpd+IKhP60L+4mXLZlVUfEXL7aBEg0poMYFpkTz2rGPAiE+ZqHT4VpzPlv1iR3pjO
         PVnggzySWyHhtz9s64FCmHDnSrsPTKMyGLyfj1FmR+tKzfWDRUBkU+eURV0+mDfRK6ro
         8sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208711; x=1794813511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKobARkBm3jckAeWzRLINPL374n1cjc6XoeTqsHKNiU=;
        b=Q5bQ69DVH8w0G/wyfFTRRFZkvLW39E9FpTO1DkAcR1Qb7AJN7o7FSWUDeuBu1vHL8t
         0G7wsbx1rQcuw4hSRTK8f/ZBcjFO6EAXhC+Lc2QXTa9S7H1J5jivo29zxKz0iNteUZd0
         9uGv7tc7d9q1SpqqmIjKvEzteqdtezIQ4VLwdCAtuyjjjWB83IU6fF1vvASLFH/Ii2bu
         HpJ24Jgty6jOzDabD6tA54DTFZvH4XPt9TRMmqtzzKshk2PwwKz7uVsNWOnqByEbs8M5
         EdrOe44dDA8R7B6R0reAxZE23GpIv0JSPoRpFS+0pyRwvZq8PvzoCY9aIWgyRghy/Pbz
         3Txw==
X-Gm-Message-State: APuU4Z8fq3bcT9XBMNV79UzcSDhQ0Y2U8Ki+efEE3ObBnxzBfSXOb01o
	90nX/GwyFr3Su7DmCuFfN9QY0YIdvtWMOTET/1iLMet9EglmiXpI/RBolXsM4Ohjfj8=
X-Gm-Gg: AYBFou0s0JgynS+2nTw2pj52FYpXGs6aMFsPXfY2gdI+IfktveZsl8e49ppR174DMsW
	CC4B+aMspSqvVpMiq04U7GkqKkhXrNnHFqKWXEpCmion9TdvNWlcWrXOV+0cpV7rehOXIuQ+zCw
	cTXmf1H0FwQEMXOT1ZIFszEcXWhnQrPVoRjQcNUIvCOID7WxMemfrCdA/AsmkOYf6B+w8iI5t8G
	CHNdpJlj2UlsJ46dPo3eKlVmetVKA55MKoxoGzzXFyS2ZvOiB8RZUXCemEeiRWU7DcmLOhN7i2j
	1lFxLD4oQphMsUmNiavwtTc8SBLB2xM462JUwX5vncyC3dyYgNx3USGuWeGe1prfDQIE3QYn+Es
	zwK/25W8/AemwPRX+v7opFhIEI5FIVhmmefDpTDlFdQM7lJUhChH/RcRNHA5lCIrceOkpZGpNyr
	LT8EHi5f9yNcqj/Ok8qz5h7zDIXHS277lozNPZfT0dkIta2o0srEm0VIBs+PV81/0AG1bT7WXtz
	L92916IGhGbWIu65xOGkBnLtxlKTGaK04TZ7W0n91LWl6J98hnoXuz/gcwKx70BVWZCuf59FaHQ
	J0cj0KwLC/70GGL3Y735w7mTWimnIeTFO93vwIWPqNeOqgwiogokZYdy6R9iivwxp24EglMMLm8
	zvjylulJ6TcLTkS7lYSpM9WTgl9PZ
X-Received: by 2002:a05:693c:41db:10b0:351:4866:255c with SMTP id 5a478bee46e88-3725e82af56mr6000056eec.32.1794208711363;
        Sun, 08 Nov 2026 23:18:31 -0800 (PST)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:cc96:e14b:76e:f8f1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12878306eec.21.2026.11.08.23.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:18:31 -0800 (PST)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v9 1/2] tc: fq_pie: add support for printing per-flow PIE statistics
Date: Mon,  9 Nov 2026 12:47:47 +0530
Message-Id: <20261109071748.438946-2-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109071748.438946-1-hemendranaik@gmail.com>
References: <20261109071748.438946-1-hemendranaik@gmail.com>
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

