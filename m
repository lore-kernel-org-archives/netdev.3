Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB037BE7A
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256843; cv=none; b=ejypnn5P3elBAua81CY33bwwsg/9oP4ql1qBiWTwcOvS1pKVqPSEBwqNULwnNQMdInJEzIuX5p1DbI22Xy4lUggKeXTTo44/w6UjSXZQCcitMgqmxzschC1DHBtl/dKUX6AmKqR1hjedjNCGyw1JiFG4aVeQPJQ4dqqVMUs927E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256843; c=relaxed/simple;
	bh=u57Y3ly3Mikn3NRTinMzRWZQrlV0fSsyW5PNpcystyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCUwAxqiajHThBvlLJeFgF599/3WBp/F5qomH/U2NJOV6VoFc/S85ywXFp13BINQZNSdlHOrYRfMQIykwKs98l2w8m74dnDTLzM5t9JREcsK/8cmG/QHEIabacRvQsUufMD2C8GmHXFmC9UcLHOM51fUUQI5VDtFWUw0E6+gCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=HlVZs4sG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="HlVZs4sG"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1299650a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775256841; x=1775861641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2k3u3e0T3EvlMkAt/EHcB6OYy81gW05GswqFmm8eAU=;
        b=HlVZs4sGbG6oarWjk+UUNeJOCLHpU9+sA8PpblYXsFNuKD7pTP9onTAmbYVT54GiO5
         cTEpFyBcgFP5+EfIOm5RYXEaugCcU+RuVknAfhMkDkEp+E5/SUQN57q7mJXWCShtu634
         ifBcxQRuD+C3JuZ2vANbuJ4STxXXLTQcLx1Sgunu+iErmUgZVkoANpWuI53APuGL0qCB
         fQroBLHHgM4o57ALyWmfu4RQ7fV/vEcgBfyxFrEjm/hxv8HkXmbSBlnFtXWSBi0Py6MR
         VhOhOoDY4UjieM2Yza1tvpLfavEqILNmmrvTTnzglqvaRZ+JI4qrPlNckaJQukpdNFOV
         vg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775256841; x=1775861641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2k3u3e0T3EvlMkAt/EHcB6OYy81gW05GswqFmm8eAU=;
        b=VEUav3TZYXvE63kD/Ix/7g2AT7EM6rA38yUaof0AiYEeXXCrKtKLcLeb22b0uKyMJf
         EYqoaY+J8vDEqVl5h9b4fJd+C0D/UBOleZLcjy9W0OMmTBYe4LEbIDXv3BtmB7k/MgZ0
         ASXT3cRknkzbQFEufJ+C0FDwTYGhZl536unr0VqxyHJ32ZwL0bkh+ydp2qENFhvnaThC
         T87YI/c+EsEJTI9cd3e/pfKdxY0mcjdQczLiJkCi1/j6IGaHNWl5TM+6G9cTmbm4p1lj
         U4kI2gLEecRud9A3F69uzXez6frnvMT4AYJwTlhB/6Nv0uEM9uMpgY/xkyPHknc+6A8C
         Jkbg==
X-Gm-Message-State: AOJu0YzJHtGTSA11SCmE5Ee7s6wV3IyLyIY2GQ1rwoUorf5j8uBONywn
	NMqFIJ9hvd5Mu/fN243L8A5CJkcSUeYMMpmRmgC44/73cPrrSPvFK6ma5b/J6gSmy84UJ8DzPRe
	t+HSb
X-Gm-Gg: AeBDiesksAURtnydyuseKPe5skzVpEktiBtGW9SsPMXGrPS0SVQL18rN6c8AjuQ6VjQ
	4ci+e4Lnn2p3X16y8wqUNaOJ0mnBXDiZjTpjjMqcm9XwOjFKEFYvAOyhwD6Fg1hsivqYbu5w8HX
	48agcmIAD08r8CgiYet1aW4/CTwNzBViShsGLqjIEmTovlxSh5ajIDDDNeTYizIqaaNCZx6fEX3
	YKcWPZ1aiat7YmKj20RCg40i1fJfuIR1XxeVaRWOlm1FqDSKmC4J7QiMouRpulpiptqM6ZlNj/b
	BwHZiZ3neYPNvq/bjSQFl1l7dlU7E2pyU2Ni1EvD3my39xBCQdO5DoP2qXEKb0p3OBP5tdWEvPC
	QPdNkujNsNBsk+v4FxQfogJD4/uZX+o7+xCzorZK7W/JWOQF7erF456Dcdbok4V08pqSygFezJW
	uTmatUznVnzZfovD88cL/97ODbjYWgELIi
X-Received: by 2002:a17:90b:4ac7:b0:35d:a8d9:3b4 with SMTP id 98e67ed59e1d1-35de678f7d7mr4156998a91.4.1775256841492;
        Fri, 03 Apr 2026 15:54:01 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de5197472sm1624944a91.1.2026.04.03.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:54:01 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] net/sched: netem: handle multi-segment skb in corruption
Date: Fri,  3 Apr 2026 15:52:10 -0700
Message-ID: <20260403225324.476787-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403225324.476787-1-stephen@networkplumber.org>
References: <20260403225324.476787-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The packet corruption code only flipped bits in the linear
header portion of the skb, skipping corruption when
skb_headlen() was zero.

Use skb_header_pointer() and skb_store_bits() to access the
full packet data, allowing any bit in the packet to be
corrupted regardless of how the skb is laid out.

Replaces d64cb81dcbd5 ("net/sched: sch_netem: fix
out-of-bounds access in packet corruption") with a more
general solution.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 6dc1ba8e999b..9b5731a8cd15 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -525,10 +525,18 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			goto finish_segs;
 		}
 
-		if (skb_headlen(skb))
-			skb->data[get_random_u32_below(skb_headlen(skb))] ^=
-				1 << get_random_u32_below(8);
-		q->xstats.corrupted++;
+		if (skb->len > 0) {
+			unsigned int offset = get_random_u32_below(skb->len);
+			u8 *ptr, val;
+
+			/* handle multi-segment skb's */
+			ptr = skb_header_pointer(skb, offset, 1, &val);
+			if (ptr) {
+				val = *ptr ^ (1 << get_random_u32_below(8));
+				skb_store_bits(skb, offset, &val, 1);
+			}
+			q->xstats.corrupted++;
+		}
 	}
 
 	if (unlikely(q->t_len >= sch->limit)) {
-- 
2.53.0

