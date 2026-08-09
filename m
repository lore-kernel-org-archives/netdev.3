Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF63B7746
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786266461; cv=none; b=c27SWzDkogK9TbpDgBJXSv2U3tSeT8PTC1tQe9TooeLShYadAnyzNK0azJl45Dv8Peq0aQE92Pw5zOLQzMkk/GYZnv9NBHN5KcLrqDXnavTrAKdjJuafHJJ1KvU27L3vlP6ECnrdDZoRR8saUCiuab5WYTQCMC7ikZLMWc/2NBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786266461; c=relaxed/simple;
	bh=5fMhEZBs1Za4/paEsMllPrG/Vj1KhK6BFKcqbNIRgtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cekmA/6PZewrjMgYSYFO+zYGFI0Yon6LtDEox9EeGkrm+53JEbKvO27XBmyZe7jL/ruyEdFc75F1Ql0AOiTHqPedQ+Q6R/4Y/AAzaWinWAIjYBF5gSSg8QCYXVfKrm6njzYOOCZDQtpTgS/TLjRWXXpuV43knjuEZrzZm2TWnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=tpG6OSWh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="tpG6OSWh"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f032b47e3cso6175896d6.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786266458; x=1786871258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7dUTAoZtVqdPM8YZqDodqEpMlJ3A6YyseiZWnN9riiI=;
        b=tpG6OSWhzTPvSEdv7UT/Wjuq0iJ3NW2sVJtIX4DTPjuQbXOyNDqK+TNo47yMDXRn/L
         K4f7YiVUPVSYug2eUvnSIJFs1N1Jih14CBXY1rghzIBmURnm4Rd4ayCVZxlHrXqI07mu
         mpmOh+YMSmqwjNibLPH+k/VR/ewzSEbNO+B58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786266458; x=1786871258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7dUTAoZtVqdPM8YZqDodqEpMlJ3A6YyseiZWnN9riiI=;
        b=AcOm23TI4BZg3zbveh88qmlKhZLwYA8XeHs++yXZWrLpCdbCOBL60hgAYCn/5SX0Zx
         5Zcc0vmjUe2SpGgsZMckekiFqOlV0mrBfYjvwQvTh9mFFlHa+XzfPWKpjshymlLJ06eV
         8uP3ngPyHnS3wg2tO3qzMg9NquP7/AnNQfH8BRZzUbsP9oPN7U8Uyy+PWj9eT7Bq4OZj
         Gpmbvp6o1hvyd4recFNAYk8YoMAPgykqA9aZt3/SVWgu1IH9HgOA7DrPrVr5Fa3O2G/b
         26ClVUjpLIw7nOkFQp3xa/1CA8cpG4uzUGAtsdZDbzKzCaAputm1Flhd+enHccDJZ1fv
         bSsg==
X-Gm-Message-State: AOJu0YwfDcgEGtLdPVn2X7D3gDu15CyZXKkTuAp2unQFqHkRypvUEuyb
	YsZ78+srHCVTafCDMIdFd/BNf342KRjQ25xxMTpj4JaRJANEwbd9s7LJ5A3z1REYAEft+YjDsQH
	MxxE=
X-Gm-Gg: AR+sD117wviIN6gy96eMpfvr9HsZWNcv+JV1aWatL5JQZBFCHm+jTzLpx/mGX+30hsA
	D0Shy/5DlK5IaBUrjKs7aADPVTb8kaAF0bkG55SX76aVM5CLI8D4LICF+IvWxKkqjZjQohW3+Fq
	XYrkFFXSC2JcAMOXfJwxlCUZ0kjZpkqgFwj1WcPqVWmetIrGdgQCStM44OvhQSPQKi+JjbU+6gR
	Iq0FupZ2s65QqdfHxg4NWMjJErpCLgBdY+u27oOtP2HdWAEhW+eUbytEgKVqx2sDp5VcCzsKrUn
	EGA+V/uHX5GOjCPUNUx7/gzUkQ+1mJu93cfOyt2Ec8c11G0l8wYxzsxwSo2n7leg9bcZvwEp71M
	MraLuDzekTjWex3yqN1K9VJiz6SzWySAhUFBqjwbFcKWbAZ77pCbkG5UBWTqfdQTRrFMq+YA+l+
	bLOoe9CLssjfR6m1YhZmK+398PQxi6JKrlL3Lb/7Z8640BwshF4OTqcltmsf1m+z4I2HofECyD5
	IltABRbh2rf+lX7rf3PURVD/hN2Sij9xdnPAHEwVZUKSefO318ZEYtCQQ==
X-Received: by 2002:a05:6214:4a88:b0:8ef:4ed2:316 with SMTP id 6a1803df08f44-90881098e74mr463332616d6.1.1786266458432;
        Sun, 09 Aug 2026 02:07:38 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a918dc65sm47112476d6.6.2026.08.09.02.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:07:37 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
Date: Sun,  9 Aug 2026 05:07:35 -0400
Message-Id: <20260809090735.865439-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
rcu_access_pointer(a->goto_chain) and then calling
tcf_action_goto_chain_exec(), which does a second, independent
rcu_dereference_bh(a->goto_chain) read and immediately dereferences
chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the gact
replace path) can clear a->goto_chain between the two reads, so the second
read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.

Fix the race by doing a single rcu_dereference_bh() read of a->goto_chain
in tcf_action_exec(), checking it once for NULL, and passing the resulting
chain pointer into tcf_action_goto_chain_exec(). This turns the split
check/use into a single check/use on one value.

Fixes: ee3bbfe806cd ("net/sched: let actions use RCU to access 'goto_chain'")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_api.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index f141634df214..600b7804befd 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -41,11 +41,9 @@ int tcf_dev_queue_xmit(struct sk_buff *skb, int (*xmit)(struct sk_buff *skb))
 }
 EXPORT_SYMBOL_GPL(tcf_dev_queue_xmit);
 
-static void tcf_action_goto_chain_exec(const struct tc_action *a,
+static void tcf_action_goto_chain_exec(const struct tcf_chain *chain,
 				       struct tcf_result *res)
 {
-	const struct tcf_chain *chain = rcu_dereference_bh(a->goto_chain);
-
 	res->goto_tp = rcu_dereference_bh(chain->filter_chain);
 }
 
@@ -1170,12 +1168,14 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 					return TC_ACT_OK;
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
-			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
+			struct tcf_chain *chain = rcu_dereference_bh(a->goto_chain);
+
+			if (unlikely(!chain)) {
 				tcf_set_drop_reason(skb,
 						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
 				return TC_ACT_SHOT;
 			}
-			tcf_action_goto_chain_exec(a, res);
+			tcf_action_goto_chain_exec(chain, res);
 		}
 
 		if (ret != TC_ACT_PIPE)
-- 
2.34.1

