Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DB190462
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787091358; cv=none; b=Z+mV+FxEQUVNgX9qBBmSoU/C2uZSgkGuguDk6aObdJt8ylN80YdY20QxC1kxdTfssZWZHReOWtoXcAc6V4SR2QDil6SNw7OPZAHov6a+StTtYqTX7YvsmDwGlSw/+HHAa91yN1MNvXVCsM2O34HmD+4QLo4Nk0Yb5qXzzBiHalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787091358; c=relaxed/simple;
	bh=HQcLVKQEdx/GwopcQ8ApW3mCaaLk12uWBYhVqybcYfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWFZXjLZvldcj54QPlgyKyWop74HHOYFbZ9dtCTCNLz0pYnBtt7U0Q9hZ0uKpdM+wuVvBimEgj24oPJkZb1tOw9uHzBomfB0zJOB9xhuReJvbP+1i3Qv9U7h3WF3mipxutlrbhq75b+7A9EtUfXsfatambq4O3yuYGTo+JNn8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7zs4x0R; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7zs4x0R"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383cb94f742so508179a91.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787091356; x=1787696156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tom5KvJTlZgFfDPxG6E9RzgBmWXu2l9f4rMAdGVGwTo=;
        b=l7zs4x0Ri6zYZ1YyeQm+oBat6WTvwXh5qWpyxeZasrcDytk+/j/VfUyMeipz3V1eDH
         CV1W3dOwZmVM8rIdSWI1/4w3sq+oNmexDHcaOqfdeiORhI4M3WJsgaWIVpATWVSAQ81P
         8McYVm3yL5lDyHk4SzrgiibPeJhiUhLcyWqiPs4rKY7JgvnOKHp+vfp5pGlu+IIqZomW
         XhVyK02T5XJzE0Og+lNvv8jVxhJU7HHFV+2g1IZlV6ncARPu4MdrODt8KYXrjDvkNTe3
         EufACUlZyQFy+mABFZwWDfYrML+CMPwj7bk89KRYmILlSgdYle3sZctvgjHxMHciFANR
         3ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787091356; x=1787696156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tom5KvJTlZgFfDPxG6E9RzgBmWXu2l9f4rMAdGVGwTo=;
        b=f5TrP6/igyoxxJYep0pRV/9xmwCiZhgtfzAJ1GibncS7oJRN0MkpD9/l71GbAd1aYu
         TEEyluJxlbDnXltM/NmLknreL+cQyFtvuyhkPkp9UMlRTgtrdEpPvrZMt8fhl6V95hCO
         XBpVAAxWj9cAanvkiK5VhC7u53J9JlKJ+Pg2X2CoSDFTE6KT7QPdptTA70oUW8lbXhjc
         yx91ssj3wjAYiM8eN1eiWPWjkOaDwo12ZaooVjpGE33p+UahjgiaxY+2KlOTtzRRwd2u
         zZoS+CRKTUmiL9Wysnjo8chn5tmLiYhas2dsShjo4xMRqaEYbMbSnRLYB/hIDsDQvZKa
         Z33Q==
X-Gm-Message-State: AOJu0Yyvzg+0Jf9vvPWoFeEuKN2j2jzL7PCBqvqbVaECZnE1PRH+f/Z6
	lL7TY5bD+QyhPn3Gm7gTqyg/Qqoi1OXiO28zrYRiIjhqqJ7d43GWzrdUItaLiw==
X-Gm-Gg: AR+sD13ceFJNAs3ulDHS8Yws+x/XnvMXNHA3YnSYALSy+/GBANuMRaARfyoBXtidAlw
	XstVPMm1TPQJMjfIrucKicn/5zHZgAuc4HsZWltFOeMgfevqmzXN+dplE6plxMQvLJj2McV41c9
	levDTn2IB7yjr0CGAgiKgoF8rA4DEJnq2k66uAsSPnQPBrbr1S11BriQrmr2QnlsFj4rYtm5B2B
	3hSMX78dmYhJgsGNLShEuTJsPpEcGSgMm8dsPxF14avfIupwNWOIVTWk7b0TM1X7Z+4sXIJfZSl
	/gOZWEjpXX14Xf1oB6KcvfG/wBbTCCoTCD+cUKbGSuaQJK+HWTAQ0aZwY5nXIdNBYIp0jP1cRUW
	0z2YJOdtopDkdyYWyScJjF/FOq7Ui6NbY6NDfAcKVC7/u9TVgQx9bYoUqGUYUZyJ2IZCEum9eOJ
	ZaqDbrtSnHcuDrblxfnAT1nks16+YFy6aiyiMrpDD+NwJ8Jmv+FyBEfUE1/guMgUGKBqxozf10U
	QhJzeKWbcjRqxNR+dmzGu6Slee7XFFAVBQTxmZzow==
X-Received: by 2002:a17:90b:3d85:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-39580f04a31mr204149a91.5.1787091356067;
        Tue, 18 Aug 2026 15:15:56 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10d497sm223707eec.14.2026.08.18.15.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:15:55 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net] net/sched: act_nat: Fix missing headroom COW and integer underflow in header rewriting
Date: Wed, 19 Aug 2026 03:15:18 +0500
Message-ID: <20260818221519.75088-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818221519.75088-1-meatuni001@gmail.com>
References: <20260818221519.75088-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_nat_act() accesses and rewrites IPv4, TCP, UDP, and ICMP headers
based on noff = skb_network_offset(skb).

When the network header resides in the headroom (noff < 0), two issues
occur:
1. sizeof(*iph) + noff can evaluate to a negative value or underflow
   when passed to functions expecting unsigned lengths, such as
   pskb_may_pull() and skb_try_make_writable().
2. skb_try_make_writable() only evaluates writability from skb->data
   forwards and does not invoke skb_cow() on the headroom. When modifying
   cloned SKBs (e.g. from packet sockets, tc mirred, or BPF redirects),
   in-place header modification via iph->saddr / iph->daddr mutates
   shared headroom data directly, leading to packet corruption and page
   cache corruption.

Fix this by introducing a helper nat_ensure_writable() that validates
headroom using skb_cow(skb, -offset) when offset is negative before
ensuring writability across the modified header length.

Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/sched/act_nat.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index 28cb48419616..1bf5d55b3dc4 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -112,6 +112,18 @@ static struct tc_action_ops act_nat_ops;
 
 static const struct rhashtable_params tcf_nat_ht_params;
 
+static int nat_ensure_writable(struct sk_buff *skb, int offset, size_t len)
+{
+	if (offset < 0) {
+		if (skb_cow(skb, -offset))
+			return -ENOMEM;
+		if (offset + (int)len > 0)
+			return skb_ensure_writable(skb, offset + len);
+		return 0;
+	}
+	return skb_ensure_writable(skb, offset + len);
+}
+
 TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 				  const struct tc_action *a,
 				  struct tcf_result *res)
@@ -142,7 +154,7 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	egress = parms->flags & TCA_NAT_FLAG_EGRESS;
 
 	noff = skb_network_offset(skb);
-	if (!pskb_may_pull(skb, sizeof(*iph) + noff))
+	if (nat_ensure_writable(skb, noff, sizeof(*iph)))
 		goto drop;
 
 	iph = ip_hdr(skb);
@@ -153,9 +165,6 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 		addr = iph->daddr;
 
 	if (!((old_addr ^ addr) & mask)) {
-		if (skb_try_make_writable(skb, sizeof(*iph) + noff))
-			goto drop;
-
 		new_addr &= mask;
 		new_addr |= addr & ~mask;
 
@@ -180,8 +189,7 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	{
 		struct tcphdr *tcph;
 
-		if (!pskb_may_pull(skb, ihl + sizeof(*tcph) + noff) ||
-		    skb_try_make_writable(skb, ihl + sizeof(*tcph) + noff))
+		if (nat_ensure_writable(skb, noff, ihl + sizeof(*tcph)))
 			goto drop;
 
 		tcph = (void *)(skb_network_header(skb) + ihl);
@@ -193,8 +201,7 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	{
 		struct udphdr *udph;
 
-		if (!pskb_may_pull(skb, ihl + sizeof(*udph) + noff) ||
-		    skb_try_make_writable(skb, ihl + sizeof(*udph) + noff))
+		if (nat_ensure_writable(skb, noff, ihl + sizeof(*udph)))
 			goto drop;
 
 		udph = (void *)(skb_network_header(skb) + ihl);
@@ -209,19 +216,19 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 	{
 		struct icmphdr *icmph;
 
-		if (!pskb_may_pull(skb, ihl + sizeof(*icmph) + noff))
+		if (nat_ensure_writable(skb, noff, ihl + sizeof(*icmph)))
 			goto drop;
 
 		icmph = (void *)(skb_network_header(skb) + ihl);
 
 		if (!icmp_is_err(icmph->type))
 			break;
 
-		if (!pskb_may_pull(skb, ihl + sizeof(*icmph) + sizeof(*iph) +
-					noff))
+		if (nat_ensure_writable(skb, noff,
+					ihl + sizeof(*icmph) + sizeof(*iph)))
 			goto drop;
 
 		icmph = (void *)(skb_network_header(skb) + ihl);
 		iph = (void *)(icmph + 1);
 		if (egress)
 			addr = iph->daddr;
 		else
 			addr = iph->saddr;
 
 		if ((old_addr ^ addr) & mask)
 			break;
-
-		if (skb_try_make_writable(skb, ihl + sizeof(*icmph) +
-					  sizeof(*iph) + noff))
-			goto drop;
 
 		icmph = (void *)(skb_network_header(skb) + ihl);
 		iph = (void *)(icmph + 1);
-- 
2.43.0
