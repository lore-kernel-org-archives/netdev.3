Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DB367B79
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585954; cv=none; b=uT99IbfZLP3UrFnHfaMcX1HW52jbw9mC4KrPbQpx+hVChJql3qMPZ1XRaElhJLV7EX8OaZIz22DzhakIdeR+TOWTHRm9BvhpFWWWbga1P49iA4eBrmKYgwXG6nPkjvEe0lAM+c55z6SVqukby4G1C1Eoe0AdnJ+dupiqsSezJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585954; c=relaxed/simple;
	bh=swoesQZIltJ22OHMvL3Un0/NLQqfQ0o6gl9BQ0u9jwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgWVxTeWX5EXdCnDwsyirnNPDGHcOuUQCUbDp0dChGmaRqOI4bDP/uTFMFoA8A5YWC+XIwOVf5fJD95iyHq14pzaO470fBQdPNfnOlikOp3mc7wJWo7rExqMGI1LGSYPZfB7n8QUCK+2zwex1bEQTzPiaUFCKfpRNY8gzEdwdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=olgkgCrd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="olgkgCrd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so32846495ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787585953; x=1788190753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhklnfRUHdtMhv0l5jDWsSZ1eyW+Pbc/Kg76fc2kWkw=;
        b=olgkgCrd6773bLZHcHHQV/8KysSDM55T7txFkyISpjHpUs+IzvOl2bdnYQzF5vrBSb
         sx7hRvAw+DKKusIybcY30/NKzo/gukVcwKBp3m6pHNgEFeM1a3YWlHR7ee0maeGydHDh
         5inobOxJT/xirym5+IatxMuez4yVTF9enXylU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585953; x=1788190753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhklnfRUHdtMhv0l5jDWsSZ1eyW+Pbc/Kg76fc2kWkw=;
        b=rFEd1Q6Ad3/q+0G42JdWBtMBEovIDoLU3FFB7PjJg9Onpj4J74EikbypWU8j6UDVF8
         Yeeqp3/5CL2AqK0IROXaq65+7nCcPO1WQ2VGO554APe73wGZ+BMB2GlaGALRAJbs1JIf
         6j/tvgnT4W5TmVNrBktMWxyc/EnyYAVBxVm6vTdtI5ZRdgc5zgPUlWaxpZ9wocjQ13pT
         ZwYYD2fDuaqNLhVAoaK9JbzfYoldDa2oznW73QskvmXnWVA5H6DLV7eZT0O9xOuuothF
         f+qyAxwDCJ+PVC7NcdIocB6Vqw8Pf85TasP5nut1B3jU+TWMvAemu4E3RhBk2/azLCD+
         FhTA==
X-Forwarded-Encrypted: i=1; AHgh+RqQpEKzw71SzDUY0ag8VlfDQaYf6WUNCkHIZBycQM26iMYXqDoC/khxWhOu71CpjCwBMubXcJk=@vger.kernel.org
X-Gm-Message-State: AFuF++kw2pdr4643ksrXt06gMAqTwG7MFlX7fsGIFGSesG9dE9YheY50
	dbB0lf+5m3vkJAd9NYaV/A/UKx6wIoSoPiUZip2Rr2aFTfpv71bHeINFbXjGHERPxA==
X-Gm-Gg: AR+sD10/msOjITyMC+TRuAzyzS9rUO8HNn3nELFH+zASFJLK4m2seYMw9MwM3ousvQs
	zT2j3lK1mD61MwzzqfIxHBMBCDaCurxzZEsmriT5P6mpVlaNke0rIMI5dHX83fdi4Er3362GRvv
	AYdoFVlJqMDHIzc1mKLA4+JOSdwUVpaghRZXZ4d93h1LBuSjWYWHCM1VUVo43B9gW68OMESyorK
	9gcwTuwk8zXtjhYqpjK6A+xAjO4Mk94Da/dKWUtMH4L2Jt8J7O+LPxBMEnVPM3AZZLekm8Kb7OU
	AVK6PUjvmMhx97AyahCmOVb6Czis1ryuEZ4pGWmtGXVu+CnZDjgA7f5oz4PY7J/6nlIZ5/K+aGR
	ns6yHysiisT8/FNzJE4yuTCE7AUYuRHuTP2BFnekxNKg+4VPVDb3DGkCi4dp/o/MAgbvChvYpfB
	W7fqy2I7n8i1msm077EbXOpizJ1aIgyceJSBCbF6IAXdI=
X-Received: by 2002:a17:902:e812:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2d6dca613a9mr1258025ad.2.1787585952787;
        Mon, 24 Aug 2026 08:39:12 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767b0aeesm18704585ad.36.2026.08.24.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:39:12 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	baowen.zheng@corigine.com,
	louis.peens@corigine.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org
Subject: [PATCH net 1/4] net/sched: act_api: budget all shared attributes in notify skbs
Date: Mon, 24 Aug 2026 12:39:00 -0300
Message-ID: <20260824153903.4143642-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824153903.4143642-1-victor@mojatatu.com>
References: <20260824153903.4143642-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_action_shared_attrs_size() is supposed to return an upper bound on the
netlink attributes every action dump emits outside of TCA_ACT_OPTIONS, so
that tcf_add_notify_msg(), tcf_del_notify_msg() and friends can allocate
an skb large enough for the reply.  It has fallen behind the dump path and
is now an underestimate for every single action.

Attributes, such as, TCA_ACT_IN_HW_COUNT and TCA_STATS_BASIC_HW are
emitted unconditionally and never accounted for. TCA_STATS_PKT64,
TCA_ACT_USED_HW_STATS, TCA_STATS_RATE_EST, TCA_STATS_RATE_EST64 require
specific conditions, but are also not accounted for.

Fix the issue by budgeting all of them so that we have a legitimate
upper bound. Even tough for of them require specific conditions, they
are cheap so, to avoid overcomplicating, we opted to account for them
unconditionally as well to account for a real worst case scenario.

Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event message size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164357.1653956-1-victor%40mojatatu.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_api.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index b4415d358c91..766162b0b810 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -443,12 +443,21 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
 		+ cookie_len /* TCA_ACT_COOKIE */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
+		/* TCA_ACT_USED_HW_STATS */
+		+ nla_total_size(sizeof(struct nla_bitfield32))
+		+ nla_total_size(sizeof(u32)) /* TCA_ACT_IN_HW_COUNT */
 		+ nla_total_size(0) /* TCA_ACT_STATS nested */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_FLAGS */
 		/* TCA_STATS_BASIC */
 		+ nla_total_size_64bit(sizeof(struct gnet_stats_basic))
-		/* TCA_STATS_PKT64 */
-		+ nla_total_size_64bit(sizeof(u64))
+		/* TCA_STATS_BASIC_HW */
+		+ nla_total_size_64bit(sizeof(struct gnet_stats_basic))
+		/* TCA_STATS_PKT64, emitted by both of the basic copies above */
+		+ 2 * nla_total_size_64bit(sizeof(u64))
+		/* TCA_STATS_RATE_EST */
+		+ nla_total_size_64bit(sizeof(struct gnet_stats_rate_est))
+		/* TCA_STATS_RATE_EST64 */
+		+ nla_total_size_64bit(sizeof(struct gnet_stats_rate_est64))
 		/* TCA_STATS_QUEUE */
 		+ nla_total_size_64bit(sizeof(struct gnet_stats_queue))
 		+ nla_total_size(0) /* TCA_ACT_OPTIONS nested */
-- 
2.55.0

