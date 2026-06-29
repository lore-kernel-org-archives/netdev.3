Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3ECA4E
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756752; cv=none; b=LcMf2fXq+dTpP/xEJEzzLCNWOgVi6MFplG+9a1mW001rmVAuhVnFjCvJjzm4uEbirFyIuzANV8feIKgNXWkFOc4vr1k/SpN2CQCV+1jr1YdHENdFC4S3OOwvWhI2YAib4+M44Mo9QVVxbEZaREscyiHJpM7SGThCT3TCQYgoYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756752; c=relaxed/simple;
	bh=r1fGuGi7Q+j+a8TWtJYP40PxHc3c+pQNF+wKYHYIMrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bp/pigf1f/CmvTk2xDhrgx4OnOAEcOHnYl00VnVXbCamaGdyI3Hyj97XPW0qtDa7okNcSuspY3SmFCthKyqdJKoxFofONKSj897JHpNdiJlirxuUKcYpaZNmoflFPuMnAtwl+36Ecp/2BjonnvYc80I6OMG34LG61GS3ahF/kuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoHCda00; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoHCda00"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso1715678a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756751; x=1783361551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gysp/YcclBm+bPktW6dDcgSGSQOWycMxFHIwE1C9oe0=;
        b=BoHCda004FISYzBtYCKYndo0MA+SIw2XA+1Lsh9SKxtc4J8mzyt5QZWsJX/ECZwl3p
         RbDlAtiCxQOnYuVYVQVkSXAOspF3Zsu6d/qP4g8GSiMjOLU+ADWfzVcuWCZO3el0Ucxt
         JDJTUV+ZcVlFxeaTSz/qNPalk9WFYfVkEFcDTOuS0s54wvyWtxDnasLf739ujkpAn87c
         mmU3cRfbLAiviSDWskI3ZO7Y/Wfnu8cLh1aoL0BlV+ghZLjnTozewhhbFPgpRkcMYouq
         Wzcnb7VSFblKFqoAelA13IpS+6Lqg96PBti6URCyAYaLJbkd8yKt+0WpdJAXMnfb+hi4
         8nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756751; x=1783361551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gysp/YcclBm+bPktW6dDcgSGSQOWycMxFHIwE1C9oe0=;
        b=LJx950DKWjNZ63YzQwmojs2cBApwTzF7VGFE8p5WWOo9Z+cam82NERWtOXPkT5OBRX
         ksQl16QKS1QOTOvjrzU3TfxJHEl3km2ie1OSlvrytpFeVoIWFszy/z6Spr7ZZHxJm94k
         z0C//0RnrmYEwb8SuPS2l+AWMiez9aFlwLWF7KGp6Ckrz4FuxzOio9TS8LO/HHi3fOC0
         XfsGBpF5D+RBAv5ZAdqZy9rtd4f/7G6Kw6DiLjX1t9lNJcRxwfvZQw8j4dBe4Hr3gT/f
         oeW/v1Tbz4Qf1srhqttsDJizKAR/uAPFoHia4uI1DtbLGRv07X5oJVG6A31eKYVhlXwV
         Es7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp6IZnlSllFc4mz/5uJjsq+OFVSQ1VWq+wLIFW7pZZYhjoY69ugAJf/aTM21786chXbe0P3my4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotUjAeF1My0GSwPuKHH61pCUmqvVraZS18gQqtYqWby/4AplS
	zJHs1M9uEqCaNROZ8X7qrLywfgyNp22Ox0AnqaVd+NvUkR3TU0NqniTOann7Ih9GjSPiYjVPT76
	/ksU/3w==
X-Received: from pjer1.prod.google.com ([2002:a17:90a:ac1:b0:366:3a03:b66d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1cc6:b0:37f:caeb:69e3
 with SMTP id 98e67ed59e1d1-38052757ac6mr320141a91.23.1782756750409; Mon, 29
 Jun 2026 11:12:30 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:53 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/10] net: fib_rules: Make fib_rules_ops.delete()
 return void.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit d954a67a7dfa ("ipv4: fib_rule: Move fib4_rules_exit()
to ->exit()."), both fib4_rule_delete() and fib6_rule_delete() always
return 0.

Let's change the return type to void.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/fib_rules.h | 2 +-
 net/core/fib_rules.c    | 7 ++-----
 net/ipv4/fib_rules.c    | 4 +---
 net/ipv6/fib6_rules.c   | 4 +---
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index 7dee0ae616e3..f9a4bca51eda 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -82,7 +82,7 @@ struct fib_rules_ops {
 					     struct fib_rule_hdr *,
 					     struct nlattr **,
 					     struct netlink_ext_ack *);
-	int			(*delete)(struct fib_rule *);
+	void			(*delete)(struct fib_rule *);
 	int			(*compare)(struct fib_rule *,
 					   struct fib_rule_hdr *,
 					   struct nlattr **);
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index cf374c208732..961eb709f256 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1055,11 +1055,8 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout_free;
 	}
 
-	if (ops->delete) {
-		err = ops->delete(rule);
-		if (err)
-			goto errout_free;
-	}
+	if (ops->delete)
+		ops->delete(rule);
 
 	if (rule->tun_id)
 		ip_tunnel_unneed_metadata();
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index e068a5bace73..51d0ab423ed4 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -349,7 +349,7 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 	return err;
 }
 
-static int fib4_rule_delete(struct fib_rule *rule)
+static void fib4_rule_delete(struct fib_rule *rule)
 {
 	struct net *net = rule->fr_net;
 
@@ -361,8 +361,6 @@ static int fib4_rule_delete(struct fib_rule *rule)
 	if (net->ipv4.fib_rules_require_fldissect &&
 	    fib_rule_requires_fldissect(rule))
 		net->ipv4.fib_rules_require_fldissect--;
-
-	return 0;
 }
 
 static int fib4_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index e1b2b4fa6e18..5ab4dde07225 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -480,15 +480,13 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 	return err;
 }
 
-static int fib6_rule_delete(struct fib_rule *rule)
+static void fib6_rule_delete(struct fib_rule *rule)
 {
 	struct net *net = rule->fr_net;
 
 	if (net->ipv6.fib6_rules_require_fldissect &&
 	    fib_rule_requires_fldissect(rule))
 		net->ipv6.fib6_rules_require_fldissect--;
-
-	return 0;
 }
 
 static int fib6_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

