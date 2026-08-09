Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A231E83B
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267025; cv=none; b=Q0e0LGe/jjt+IyL/Pfm1Wrbae1OX+dZDtOG6Rl7Y8Q6dfa882B3z1gO0AtJaUe62dmib5j1Tyl7Aj6/zIMZ8gzLPR/ooAtES6G6e2TxvBkcVawk7cFGhy72KGj+L6up1geh3D9lA/OQ8u0fjOjU+7/lxFkrOGWLp7cQ1z3q/B+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267025; c=relaxed/simple;
	bh=9doRA+1sWwyjLbVQ522xpNREC3rpQr6NfZSlNioXjik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2BEQ1Rp4R0prf4nQvJjoeCuwUUlpbdBqU2h9lY8JAagzsgwwUzA7HTp0tUEEuzKNQ1zaPgOKIdER9w7x8Eo9b/UVNfFPhqLihNabgp386/wYTcbZ8StjH2+g4+IZsObux2rVw+CrOkTmj4CyHkpyB7J7ePFVtDB7cA+pWBjm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=TccpCHBM; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="TccpCHBM"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efbafa1bacso4973136d6.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786267023; x=1786871823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Obn2pyh0n848Fa0t+qEhzbG3dNJa1Fltj/IPDQO7Zgs=;
        b=TccpCHBMSuhia4dUK4GYR9lN7DpAemoPH44cvCP5MTgwdDnUTrDPZOEi/zZQi/EL5N
         j6zl0jzQbk8faglhmGfewPCzi05XA5a32rfx/QXWMKxUYI8weQWTyBsON3rZZuKSCobK
         py8b76XwlXsijgr2JDOktDotlvMY7ZolhZ5gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267023; x=1786871823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Obn2pyh0n848Fa0t+qEhzbG3dNJa1Fltj/IPDQO7Zgs=;
        b=LCB4eZmjE+N0xTfGgc6VslcqMv2eIsjNJyZKNntIfT/yoObfm0MmOfosQ+q+s3Dgk4
         3xCrfGpA7W713TSImE+uygWbiyUF74mw5JJuLh8zXALKKs6vF2Vb6nhgqjJUCkgUomz3
         XJJveYJmeXyzz2sLBN5HIK7h8eomkwq7FHtvBMiN2X440EFg553dd0kbg5Jne+4QvVd7
         dGFFiPZDocxHjplY00G4wFDZimkU4r6pBDsSyrIav/x4KRcujCVoEqS8BPLpcAoPKYGW
         WVxwvWHHY2UvQ+pmkf/EEMcE5oXqm4RF892iBCLSjIoFCqpvckQU/i78nQLxt/LepUU2
         kZ0Q==
X-Gm-Message-State: AOJu0Yz+Io6/LMKcQ7Q9tCHxXR/+AA58L3vQkb1ymp+L/n/biblTeFfg
	xgGszBCyj5jyFEBRoKPVKUQehzydTqRWBu0QRiMzSDlkueHNpq7DORUanDYcOZBhleRtCmiKDfA
	TCp4=
X-Gm-Gg: AR+sD11uxLaBrbg4UzQzv2hY4CFoYu92NMK1dHe0CoRjaUn8FGaUN95HgwRi9Yxdvn0
	Ohc5kdIyayCJ6GuF9hOPhxq9fGTzBfpXAwOEzvma8uPUXSsVcns10AoH8mm3CsgCrxugYqiFFF3
	S1PqsvGuN715Xk4fNG45BpWC+FohOrmHeoXBXezJgbnrOsvNHE6WDFMYIudGhKA9ytr4YCVUZEo
	5c3nIKeIjYDDVf1EUiRX2o3hDrCcnpJnt3FV2J25pIiQNSNcp72TqGaQXU6/cRR4tCsrBebXVqG
	034TBDD77HbdAr8KS7Ag+USwnjlmIB2HFDoQto4UcuflD+JfsonC6NL3JYHe+Ba1crMmP90fQac
	Qk8bLsYwtUg3zDa3GapoVX4XHPw/jAlbeWjMyR1mZzO8+h6ket94jVkWJHopTaePQQwEjkqPT5h
	x8oGtOm8ePosXrAfgMwDC4cEJWjZKSN9DlD6rQ7j8UNRskqUutfAhVSTF6gF4EsWNQDal5NJHKu
	T9HW4BSfpabIh4OvFkWAdPc4zhuoLCE4b8RBZOLFXgs+c4=
X-Received: by 2002:a05:6214:3115:b0:907:c31d:dfad with SMTP id 6a1803df08f44-908811ae4b2mr425112586d6.9.1786267023033;
        Sun, 09 Aug 2026 02:17:03 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a918db45sm46986446d6.4.2026.08.09.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:17:02 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	David Ward <david.ward@ll.mit.edu>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net: sched: gred: fix 32-bit backlog wrap in gred_enqueue
Date: Sun,  9 Aug 2026 05:16:57 -0400
Message-Id: <20260809091657.879929-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gred_enqueue() admits a packet when the current backlog plus the packet
length fits within the queue limit:

  sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit   (default VQ)
  gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit (configured VQ)

sch->qstats.backlog and q->backlog are u32, and qdisc_pkt_len() returns
unsigned int, so both sums are computed in 32 bits and wrap at 2^32.
Once the true backlog exceeds 4 GiB the wrapped sum becomes small and
admission keeps succeeding, so the queue grows without bound and the
kernel can be driven to OOM.

Promote the sums to u64 so admission stops once the true backlog exceeds
the limit.  The limit is u32, so the bounded queue stays below 2^32 and
the stored u32 backlog never wraps.

Fixes: a3eb95f891d6 ("net_sched: gred: add TCA_GRED_LIMIT attribute")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_gred.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index fcc1a4c03636..f04f425c6c44 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -179,7 +179,7 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 * if no default DP has been configured. This
 			 * allows for DP flows to be left untouched.
 			 */
-			if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=
+			if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
 					sch->limit))
 				return qdisc_enqueue_tail(skb, sch);
 			else
@@ -244,7 +244,7 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		break;
 	}
 
-	if (gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit) {
+	if ((u64)gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit) {
 		q->backlog += qdisc_pkt_len(skb);
 		return qdisc_enqueue_tail(skb, sch);
 	}
-- 
2.34.1

