Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800637;
	b=gRgwUtHScDUT1bLzWdStBrmj21Xc3OmVeOyN5d7zAYYElQHzIs+RcxpXibhMjlIHnlfZ
	 fOa4pGGQQ5m2IlLk9iPibpMIQn6UkE+VzIwfRJr+zJNJTff4CfkVEgHhqpq9WQ/RKanyS
	 swhCDauyqAQZIVoxeZknVXcjbHPh8U76Wh2TiOvWqm9CUiJ1y9FO49qKtX5aOvc1mMXpT
	 CFALL/mgfrCKSpos/cllFuNNDD1bSUt78e3Zm9+hSNteGE5iPdmMPPJFrOIrWqQGUorhD
	 X05WDhV1rO5aMJtIV/gbKfKpT9vXyTRIxYUJU/UaJBJKOuHh9s/it0zxNuBs41vGLXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=haHVT4PZ9PXffYNKH4oPjoH22TuHQLCrduNNLuH1+/8=;
	b=GC5k/pinv40NSE4l2vLJQEBind7lpM13L8Lou+ggqVgX88p0EELjfrshbucugT6jOVMN
	 UC4lWOpZFAyimkhFum3Gwmjxh/yeoqKWTp2edJedhy9bldmRQXVwbFzW7hW9PZTlRC+O+
	 OhbwRphuzm7ynexY6RqkPu9vwlGZ3IuyfIrqltSNhRp894N8s1gul5IKTGbtvi0smv4II
	 vRUPXNG/ZALe3aszuJpS/XeqjTG+TcwAP6vMcXvOcWwkEc5Hu6G58NusFCPKVLKD3OkK1
	 OonBVpgc+4RfHYCS0wPc/sGB3SApoKruZBWI2akT7uqLRm1VwKK+r8uUdSwks53Xh6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=copperfault.com;
	spf=pass smtp.mailfrom=copperfault.com;
	dkim=pass header.d=copperfault.com header.i=@copperfault.com header.a=rsa-sha256 header.s=google header.b=xggg5735;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0080606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0080606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=copperfault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=copperfault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=copperfault.com header.i=@copperfault.com header.a=rsa-sha256 header.s=google header.b=xggg5735
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a8cc11ac42so913226c88.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 05:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=copperfault.com; s=google; t=1793800636; x=1794405436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=haHVT4PZ9PXffYNKH4oPjoH22TuHQLCrduNNLuH1+/8=;
        b=xggg5735NPUVs7RS0iWotP6MUxWilqOi9E24Hr6xdsB7X1niq53syvtN4GBOyG+n5V
         SsotSCgBPmwP1z9gPbzuVyVGaVgmMUXWemY3EQ+t5fZRg2YLeJC567peEtV3KNTfs0iB
         xxVEWSw9qKSjWwBvz8g8B9btW9RdHNJ8bDksN4NgS6iPAuIVnlQWK9lzWfvRjQFrjnl5
         bQQ3rBBewXvr+AdZfFl0LOPdDXde4kjJrE2T+0Lg5D4m+XtoNu+6b+vZA7XRLL94Rs4l
         ZUL64aQRwJM1A1egWqY9/pFyPyK2BaNi6VwNX93EVz+0ny9F3ba6zDRo3+cLkpgp+ljx
         94gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800636; x=1794405436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=haHVT4PZ9PXffYNKH4oPjoH22TuHQLCrduNNLuH1+/8=;
        b=cMSNurqB8d4AmT4Dg6iqdiLn2miTSr6iGI80Z0JtdK+HRy6qA7j33qnE2LuPbKwh04
         VnPk3SrkQN6XvW+yKzMFVH7msU/fvbW/8oJR7uAJFIp9nF9Z2RmJLK0NM4ToIewwWx6K
         68BLzkhnTyg2OPHjU0rLQ7cjmiFhtskH996c17F434fbsx6buWzHO1oih9Q4ZdOHE8Xw
         ghqurwacjI9eT4ljmdOsImr4wxOq/CX95VOJo9E775ck+d0xRleWN1qO31SrzqA7gQs4
         hV9ZDwcAxoUUiA9tX526TCHgClfm9DhOBriCUxvyD8vijpBeYkC5+PPXIo3tOjexo6X2
         aEmQ==
X-Gm-Message-State: APuU4Z+mVG+kqugyMOLE4IirX7o9w/LrYdINspsDrgbeNe0EA75TNaMK
	T+11dlZCo5E6UX93sysMbMHH8FmWkah+GJUna4NGhmvbWBXWBv+OKJvzoyRqjAEEsW+L
X-Gm-Gg: AYBFou3dIqQhVyGHjBXvf0U9Xqdr/DZSsm90sH76+PIgxtj03Wrf/KIfkhwYOoQhyDy
	Rp84Bxdjin3w5DUvulm7/fgUr9zZpcFp8Y/REg2Hc4r3WfqdDiM+jJN/No/GjLOB2oHy73HUkLg
	QZ70ZmyC1emDlOrhn42KmehY/47Yz97W+QBhcFZ6bcOrOiTGXmO6kzh3BW4ueuA8vR7dX0zxtjG
	7A9r5v4pVriWB0/akmqoWik049RDvHaYOLtMUnf7SlxlJrY4EvnQPP+/X190SmEhOAp+ZjOVc5N
	T0TcPfz+hRa3TIZJPKXud0pZpLnyOryZeyB9qfGB9rIz0m+lbZ6NwDrIxFDrYFsZFxbgdmyHCbj
	zKOhuJ5OHaXY/QocCunTJMB37TGb2m0APTFJvDxYzr1a/pz1Cx/NVJrETTzgS6/i8nGuUdMm7uu
	w7amv0fumbprK2vVP4NXNIRJlFM3ltDTWG9x2fT/RCJXxKpARatzN/oqCkrHLSD7YG9cHfZSA6A
	6uWgTmW/vyrWgPntHHEnM+hMQVJE2fzZ7E2dEvnlGQCk8xIDpMVR5bmLr7hRjkn2osIyStCg14/
	W5YZcOH7SJ4EAehA1XjhYvv9zD+0PJhZgiRfJLk=
X-Received: by 2002:a05:701b:2816:b0:182:94d7:f76a with SMTP id a92af1059eb24-1ac6088a34bmr22912657c88.43.1793800635357;
        Wed, 04 Nov 2026 05:57:15 -0800 (PST)
Received: from Riley.taild1547f.ts.net ([104.35.194.45])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm10281764c88.21.2026.11.04.05.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:57:15 -0800 (PST)
From: Riley <security@copperfault.com>
X-Google-Original-From: Riley <me@riley.kitchen>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net/sched: etf: propagate dequeue drops to parents
Date: Wed,  4 Nov 2026 05:57:07 -0800
Message-ID: <20261104135707.725-1-me@riley.kitchen>
X-Mailer: git-send-email 2.53.0
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

From: Riley Kitchen <security@copperfault.com>

etf_dequeue_timesortedlist() drops expired packets via
timesortedlist_drop(), but that path only decrements ETF's own qlen and
backlog. It never calls qdisc_tree_reduce_backlog(), so a classful
parent keeps accounting packets that no longer exist.

With ETF installed below QFQ, this leaves QFQ with a nonzero qlen after
its last active aggregate has drained. qfq_dequeue() then skips its
empty-queue early return, qfq_choose_next_agg() returns NULL, and
qfq_peek_skb() dereferences the NULL aggregate, panicking the kernel. An
unprivileged (uid 1000) process can trigger this deterministically after
creating user and network namespaces; no race and no modified kernel are
required.

Count the packets and bytes dropped in timesortedlist_drop() and call
qdisc_tree_reduce_backlog() once the local queue state is consistent, so
classful ancestors see the removal.

The issue was found and the fix developed with AI assistance. A
standalone C reproducer, run as uid 1000 with no kernel changes,
panicked v7.3 and mainline d135ab453a74 under KASAN; with this fix the
reproducer exits cleanly and parent and child backlogs both reach zero.
The reproducer is available privately on request.

Fixes: 25db26a91364 ("net/sched: Introduce the ETF Qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Riley Kitchen <security@copperfault.com>
---
 net/sched/sch_etf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index aaafcf640bc..7e7532ea099 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -201,6 +201,7 @@ static int etf_enqueue_timesortedlist(struct sk_buff *nskb, struct Qdisc *sch,
 static void timesortedlist_drop(struct Qdisc *sch, struct sk_buff *skb,
 				ktime_t now)
 {
+	unsigned int dropped_pkts = 0, dropped_bytes = 0;
 	struct etf_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tmp = NULL;
@@ -220,6 +221,8 @@ static void timesortedlist_drop(struct Qdisc *sch, struct sk_buff *skb,
 
 		report_sock_error(skb, ECANCELED, SO_EE_CODE_TXTIME_MISSED);
 
+		dropped_pkts++;
+		dropped_bytes += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_drop(skb, sch, &to_free);
 		qdisc_qstats_overlimit(sch);
@@ -227,6 +230,7 @@ static void timesortedlist_drop(struct Qdisc *sch, struct sk_buff *skb,
 	}
 
 	kfree_skb_list(to_free);
+	qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
 }
 
 static void timesortedlist_remove(struct Qdisc *sch, struct sk_buff *skb)
-- 
2.43.0
