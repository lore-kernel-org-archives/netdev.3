Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9451C84C0
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884658; cv=none; b=PtD2wAIx8ottZ9BkYpWmjNlQLteWwExCbxAasUSSjTcCtxZpmxYDkTxEVADZvirA5zyjHMgMTdiOaTR50NFRH0T/0wXQ+wqLX1wCUYKydg9goPhbcsZgNPSCWcBIDXLZVWaZWGfDTKqfAgaPYz7SFsRCAghD7v1p+qVhPe+NAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884658; c=relaxed/simple;
	bh=6F7GlSBhfhCzzHqQSGAC8dBIMUJ7Di7q0SzrsMNF7to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+Ypegj6w1Tz6MKHyVBsqmF6oh73m01Dr5N0v/pQXU0MtSLcLicuzhOYMz+EibOY4XcTuMioPUTcLsRaPya/sfNxERWmjVV6O66PSkmgU0mHakkySpTcdG0d6LNP71Kip0OQsij+54wG6IBehWFVHUYVpRNUgRStko8t4TsdRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=nXDpwyYH; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="nXDpwyYH"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b6f9a50eso1147143a12.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884656; x=1776489456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWvbw0d9mEdG2QPsokMXtYXxMHXyVGmFUfcW4m7NBTM=;
        b=nXDpwyYHexNXzlnPaapoIyp0FzpRMnpdSl3DwT1nYj+dmWLRe32Z8oyJSD6TP5Pc86
         5PRDMq1ZSg3fQj0dvMugG8Z9ZhSPnzjcwtB7f/sQj7TlaiofYaESkV1DX9S690QFuEtq
         zoo9oumWhmrbW26u/9vr3yvJkPYfvpgc+BNFQZcw7f5mOj1YLt7k/l+wqEogxZuK9DDp
         rd5hiCXmQ74mPzwP8G/5BwHeJcCBNPOjgvixtN18ohM4oNK4weUaXOU0J/Yb9hMezI1j
         XmibBlr+8qkSaNd6XSX+ssgQyOk5cNXaaUdoBb6sROAJk+iaosVBozOktTxPJBjY2ZgU
         L9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884656; x=1776489456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wWvbw0d9mEdG2QPsokMXtYXxMHXyVGmFUfcW4m7NBTM=;
        b=bE1S44f36T+qGexBU0whELY4lPXiSMaEfMdunddk9XLGJa8yQbEtZzm+sQO8LgXzaZ
         sUroxLYOEL0LuSxPAiWDUy8SvSWCYHtJQgybetDBnVjW6KRcyVQdsKffR4Ruzx6zXXZL
         ByW1WzI++wlnHBEJQ3HT+iljsuMyLl0bGXGu0xlD5AhvDd2QhhYL2YXb/y403yCGxJGG
         2EVVbZpBeLiheMHb1uJiM92dOkXzbwW+zqpsLF4xy4gBzy52Y+6ihjweFKPrnch0x+h8
         079UVn9zHBJpLAfovqzSwi93mm3C/KeHDGhzmAtvaJk0FHM2niMr9RN/UgVbyzerPTUv
         6POw==
X-Gm-Message-State: AOJu0YxJ7tPWPoz38pSL+qyF3VDUA+FliwT6Bt4Xue74/v2OnRVedVgB
	OrbRg1PUz7N5x6NBVV8PtoG2NioPZrwCLMf088/a6zso6boJ4HYFz6NRZcW8Ne8+IkVgMXEg8n4
	MFnRG
X-Gm-Gg: AeBDieuoBw2jJROfDbd8GzaJyCMXQUaiv27QW5+aXVM2kXx9oWCXqQb43mFUgPmVOFQ
	g7ihgBe9gkWIdoqcn968JZftWFPtPjhTmp4/B2SkS8J5dVvRAqG0IGkrAUp+HJmiN/4cuoa0kM8
	XFvCtxYcI+jQyn8KH4WWwWOxKMM1TkitvyiJdpZsKopYU8XZSQ5Eb6P98VEb8PW5Sf+xR8u3YKj
	0W6EEqlipwt57pjEoR196MvUyIQ9usk+8ZUIk8QBr2hlH8wmDD0MTSEdJA6syk5g4sDFlsn/jJl
	mgPpOsSwx83krHn1LT6w7rioo0N/iO/gj9bWzIY3sygxZ/zHOrzzwtQJT4bKoVyqhlNgDW6iiAR
	sMmiJsL6iyOPhMt52mhumY1a0xh3qWgWgqIlS9IcKt84CGQ+eNVUydQta6fsxL9J/bdN5snIiJH
	u7FkJbyZqJVo3Z7P5cmMiGJMj5ZggOAVjD
X-Received: by 2002:a05:6a20:2594:b0:398:bda8:d8cd with SMTP id adf61e73a8af0-39fe3c2d6eamr6251515637.7.1775884656559;
        Fri, 10 Apr 2026 22:17:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v5 5/8] net/sched: netem: batch-transfer ready packets to avoid child re-entrancy
Date: Fri, 10 Apr 2026 22:15:54 -0700
Message-ID: <20260411051700.311679-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411051700.311679-1-stephen@networkplumber.org>
References: <20260411051700.311679-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netem_dequeue_child() previously transferred one packet from the tfifo
to the child qdisc per dequeue call. Parents like HFSC that track
class active/inactive state on qlen transitions could see an enqueue
during dequeue, causing double-insertion into the eltree
(CVE-2025-37890, CVE-2025-38001). Non-work-conserving children like
TBF could also refuse to return a just-enqueued packet, making netem
return NULL despite having backlog, which causes parents like DRR to
incorrectly deactivate the class.

Move all time-ready packets into the child before calling its dequeue.
This separates the enqueue and dequeue phases so the parent sees
consistent qlen transitions.

Fixes: 50612537e9ab ("netem: fix classful handling")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 48 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e264f7aefb97..98931bb4354b 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -734,8 +734,10 @@ static void netem_slot_account(struct netem_sched_data *q,
 }
 
 /*
- * Transfer time-ready packets from the tfifo into the child qdisc,
- * then dequeue from the child.
+ * Transfer all time-ready packets from the tfifo into the child qdisc,
+ * then dequeue from the child.  Batching the transfers avoids calling
+ * qdisc_enqueue() inside the parent's dequeue path, which confuses
+ * parents that track active/inactive state on qlen transitions (HFSC).
  */
 static struct sk_buff *netem_dequeue_child(struct Qdisc *sch)
 {
@@ -743,31 +745,33 @@ static struct sk_buff *netem_dequeue_child(struct Qdisc *sch)
 	u64 now = ktime_get_ns();
 	struct sk_buff *skb;
 
-	skb = netem_peek(q);
-	if (skb) {
-		u64 time_to_send = netem_skb_cb(skb)->time_to_send;
+	while ((skb = netem_peek(q)) != NULL) {
+		struct sk_buff *to_free = NULL;
+		unsigned int pkt_len;
+		u64 time_to_send;
+		int err;
 
+		time_to_send = netem_skb_cb(skb)->time_to_send;
 		if (q->slot.slot_next && q->slot.slot_next < time_to_send)
 			get_slot_next(q, now);
 
-		if (time_to_send <= now && q->slot.slot_next <= now) {
-			struct sk_buff *to_free = NULL;
-			unsigned int pkt_len;
-			int err;
-
-			skb = netem_pull_tfifo(q, sch);
-			netem_slot_account(q, skb, now);
+		if (time_to_send > now)
+			break;
+		if (q->slot.slot_next > now)
+			break;
 
-			pkt_len = qdisc_pkt_len(skb);
-			err = qdisc_enqueue(skb, q->qdisc, &to_free);
-			kfree_skb_list(to_free);
-			if (err != NET_XMIT_SUCCESS) {
-				if (net_xmit_drop_count(err))
-					qdisc_qstats_drop(sch);
-				sch->qstats.backlog -= pkt_len;
-				sch->q.qlen--;
-				qdisc_tree_reduce_backlog(sch, 1, pkt_len);
-			}
+		skb = netem_pull_tfifo(q, sch);
+		netem_slot_account(q, skb, now);
+
+		pkt_len = qdisc_pkt_len(skb);
+		err = qdisc_enqueue(skb, q->qdisc, &to_free);
+		kfree_skb_list(to_free);
+		if (unlikely(err != NET_XMIT_SUCCESS)) {
+			if (net_xmit_drop_count(err))
+				qdisc_qstats_drop(sch);
+			sch->qstats.backlog -= pkt_len;
+			sch->q.qlen--;
+			qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 		}
 	}
 
-- 
2.53.0

