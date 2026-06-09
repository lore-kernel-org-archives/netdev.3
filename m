Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BE14F112
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963942; cv=none; b=WRNjf367DqinbyXuDCj7MJVA6qHOEdy8H8nceaGVsN9mpjUURL6E8BlX85wr8ff4qJ0IQc65hL4Y/Zo0bg3Ie/z6dOAsWlvCN85rX3Bv4JjXq54qH3/dnMPY7l1T8X3DoKnu6HZsiR6AQIKVl6bp8Q2UgOBkEU6aus3Pn9M/TWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963942; c=relaxed/simple;
	bh=FE2BYEud4F6T/jjIbzzlLoxrgCJJfFsR7Q1lcy/N04I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhwoXiOKgHRaEMvfLZuXiyRLxbHkoVkB1hs3qc4yMZPmIG9WEX1NbY5NbEDhDYqfOAfQwm3l3j1BYdvR/3eKruAPEdT64P6v8datqA/ZfaZFmXZ2GIe/DEhGvEIko9UNdurfDc40ia1zWJ2X5kmKjgLXHfvyfSk4/lAzdi/p3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=UUjBh0OF; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="UUjBh0OF"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so62281226d6.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780963939; x=1781568739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5Z96zNze5IyXrDRsTbqA5i5H8QbybgZd0h7PaXldxQ=;
        b=UUjBh0OFOHowjEFYJ7nxjiXuJbcuC3sSkJ00oQIFrBXKsCRKdW4WycbE9ZHoG32mLL
         umw6hbrT1nNUso1wN4J/bJL0fGSw0U86ftZggWuSVclc9OllhBow7+RS6lg5pv21//Xa
         ouPtHmXSGMldIxqjY48NE6htLmRXRNJlHB20y6qPEyzWk1IIiGTV5hivexZTtlS1+ITd
         5vCwqN77zVn9XbXY0d/aPp/u65CYNpzvofLbpBbnVAPdAJMueI3CH41X+Hp+TNo0+Wsy
         MaVvIfNEzd8i9vSDBl4Bz60fR5mA/aMWFh6crcwk3AfR17AWdJN8hgclOfp3N0rLhXxg
         CRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963939; x=1781568739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5Z96zNze5IyXrDRsTbqA5i5H8QbybgZd0h7PaXldxQ=;
        b=M+UlmGcD2w7YFxdD6EhdZhJOxknrTDOP437FJAqiuGAAJijcq9jiqBe7HsIKbSDYzr
         0b9+UCMlvgF1+pvIufDUFHPo3LHRahwOUBt/urLgj50oaIh0Wspl2qwI0NtZOevcqSNf
         Nfp/pNJEvNSV6bwEo5YFQf+wsgXHoz+8zAJ81CMr+MmhQKtRR1iMNuQpV2AEc/+DmSuI
         Ssu9Ah5gSdFu++w/7ZJeJWxX1ftvITdK7/ogDtSau4V/o/efdhH9enl73QGIRBOYJ/6j
         np9C4CQpmZTdcLgLe2X3DxFo8voXEd3oGJFTWOSuh+oaplrfKs79HK+bCuA17ve27cPa
         0WWw==
X-Forwarded-Encrypted: i=1; AFNElJ/B8S63YeXh/9sb8w3w0vG+nDxy9b0JMxqaEQEHXirLN7DUvtQvPXJykXjYxkhvNFKw/Ws8LOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu5wbPWkizoGucBSsfOEUq4phsOEncLvKyu/abgAbNne449Y6I
	GhrCKv+pvZYWY5yoRr89sorJDWqZGb2xQieeY8SwJAzf+O5XNGoYHU4Wx2OZFetLeT8=
X-Gm-Gg: Acq92OEEHuYwyzCgRl76mUqkUsg8NdqztiiZv1MqMXWxDEa4ZKpKwb3afrCQI8323is
	GUpxO7XbB4fvmTHtHl1UHVT6ZTh9Smda8CXF8dqP9s9d5uSiFIQWPwqPeRSdD78NqvEFXI8BX86
	yLlVxVG0z0gIQjIlK4+VOgcrYZ914nNFSZOddxIVOisGeiKcRjEdNS143mmose/AfaYeEtpO3L6
	L/M/VCp72sDhtACqLPGtxwhd95HGE6Kl8z25/Yq7JMEcXtRzokVwPB6ph1ClCh+gbDh3kF3iLWJ
	V2aTSi8tP/U6ItgDOS1/iczHpmJRXk3TpQX2V+y2y6lj/zmWAhsxqI1gukktGkulc46RNVGoTW4
	zunpRlcq6POafIWClFyMR58ufqXWZ4wtBDbrhyONw9jDtdBKyzjk2HVlkVe00uJxOlreSjMn+y5
	h66CQ2dhhSJiMeefqPKoI5IwB4wnRfDKXuB6KQsA==
X-Received: by 2002:a05:620a:254a:b0:915:9943:d760 with SMTP id af79cd13be357-915a9db892dmr2757785785a.43.1780963939412;
        Mon, 08 Jun 2026 17:12:19 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a3bf5dasm1898179385a.36.2026.06.08.17.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:12:18 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: codel: refresh CAN_BYPASS when limit changes
Date: Tue,  9 Jun 2026 00:12:14 +0000
Message-ID: <20260609001013.1234755.d884b9e2028f.codel-limit-zero-bypass@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sch_codel and sch_fq_codel update their packet limit without refreshing
the queue bypass state.  Changing the limit to zero can leave CAN_BYPASS
set from the previous configuration.

The enqueue path can then bypass limit enforcement even though the new
limit should prevent queued packets.

Recompute the bypass flag whenever the configured limit changes.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_codel.c    | 17 ++++++++++++-----
 net/sched/sch_fq_codel.c | 17 ++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 317aae0ec7bd..b8de40e63822 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -97,6 +97,14 @@ static const struct nla_policy codel_policy[TCA_CODEL_MAX + 1] = {
 	[TCA_CODEL_CE_THRESHOLD]= { .type = NLA_U32 },
 };
 
+static void codel_set_can_bypass(struct Qdisc *sch)
+{
+	if (sch->limit >= 1)
+		sch->flags |= TCQ_F_CAN_BYPASS;
+	else
+		sch->flags &= ~TCQ_F_CAN_BYPASS;
+}
+
 static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
 {
@@ -133,9 +141,11 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 			   ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT);
 	}
 
-	if (tb[TCA_CODEL_LIMIT])
+	if (tb[TCA_CODEL_LIMIT]) {
 		WRITE_ONCE(sch->limit,
 			   nla_get_u32(tb[TCA_CODEL_LIMIT]));
+		codel_set_can_bypass(sch);
+	}
 
 	if (tb[TCA_CODEL_ECN])
 		WRITE_ONCE(q->params.ecn,
@@ -176,10 +186,7 @@ static int codel_init(struct Qdisc *sch, struct nlattr *opt,
 			return err;
 	}
 
-	if (sch->limit >= 1)
-		sch->flags |= TCQ_F_CAN_BYPASS;
-	else
-		sch->flags &= ~TCQ_F_CAN_BYPASS;
+	codel_set_can_bypass(sch);
 
 	sch->flags |= TCQ_F_DEQUEUE_DROPS;
 
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 24db54684e8a..2695181cb046 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -364,6 +364,14 @@ static const struct nla_policy fq_codel_policy[TCA_FQ_CODEL_MAX + 1] = {
 	[TCA_FQ_CODEL_CE_THRESHOLD_MASK] = { .type = NLA_U8 },
 };
 
+static void fq_codel_set_can_bypass(struct Qdisc *sch)
+{
+	if (sch->limit >= 1)
+		sch->flags |= TCQ_F_CAN_BYPASS;
+	else
+		sch->flags &= ~TCQ_F_CAN_BYPASS;
+}
+
 static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 			   struct netlink_ext_ack *extack)
 {
@@ -422,9 +430,11 @@ static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 			   (interval * NSEC_PER_USEC) >> CODEL_SHIFT);
 	}
 
-	if (tb[TCA_FQ_CODEL_LIMIT])
+	if (tb[TCA_FQ_CODEL_LIMIT]) {
 		WRITE_ONCE(sch->limit,
 			   nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]));
+		fq_codel_set_can_bypass(sch);
+	}
 
 	if (tb[TCA_FQ_CODEL_ECN])
 		WRITE_ONCE(q->cparams.ecn,
@@ -514,10 +524,7 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 			codel_vars_init(&flow->cvars);
 		}
 	}
-	if (sch->limit >= 1)
-		sch->flags |= TCQ_F_CAN_BYPASS;
-	else
-		sch->flags &= ~TCQ_F_CAN_BYPASS;
+	fq_codel_set_can_bypass(sch);
 
 	sch->flags |= TCQ_F_DEQUEUE_DROPS;
 
-- 
2.43.0

