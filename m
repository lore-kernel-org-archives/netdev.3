Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244BF2F7EE6
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881687; cv=none; b=aKVwi4c93VFrz/QZrXQCwC3sjcrLAk+JvTDyJcOh7rY8TzTL+mb7Fdewt7/7sBEetWhWSTHv+915vEg3ex/yJdWgERb7uTri3IOroMuV1A0BOVlrOssj8kubmjHsI4pxnAnOIK8vGekOuN1n0oK3zlsE2BE5Jhs5sUmuKbXmHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881687; c=relaxed/simple;
	bh=L8xrOVBxE3LumJuxkxnHSQvqDs9rlGiRaRTwo94hFng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=um97gwS34/3M/4Z0BveWVOJ+5w/EHzJ7cgwcIJqQJv4P3pSujQEwTEiJKUt2wsoTiZZzbONIjlubdF2gndbHfFgBLbj9aps5qZE4JDUOKBsCQ1nAjkK63MCpqTlydgj/HsfZBjOPb6pOh5WDz8b17DvPAyxQLuVkusPJia6qoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=HoclGCBW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="HoclGCBW"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5339173489eso30254331cf.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791881684; x=1792486484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjWn6WAVhrP+rzyIRO4PcivsKRGzsPFO0IKeIkU4m1E=;
        b=HoclGCBWfTC3QKBQzZhBywI4VC4tXaBkYtrQtmSLikmUBkVX9BMdPrSs6eBVyyraCL
         6Ixm9kU2hXgBw2jE7doYNh6zvOs9gOusEpqZhtfw50KaoIIKN2YHKVOU14uXRSP/8pt5
         gdGK2MbGFdGw9MeNo+nV3CAKxPl+n+uwngK+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881684; x=1792486484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjWn6WAVhrP+rzyIRO4PcivsKRGzsPFO0IKeIkU4m1E=;
        b=sibiWsBVnuYQ3XG9TygA07In+YYt2bkWyVB6nYuFMXwaaPkDdtg9cMktZu6MteJk4g
         O2ljlswLIQHRHm0yyHjT15stl+n82Wgz9nNv2jdVKXrP4//qpB5FoW/OzWAoiYqrJm26
         mezCK+pg9oKbtvT6UG1thMiJ0l7l51QGuy/vyGaZ8IaeHbfNjwL9nJREjAj9noSHmJ/y
         w5c2Ce23qRhVNQCxExZFPnlKY8Lc7DNLZRtuzvWcTHadB5Ajru4yzXqH6HXpYItmypky
         GrWt0LudPbyjNaMWcv//ceWP1ZQao6khuYoXKmouGdqc7XPnkXG1Cffj20ebwL7xnFYc
         auow==
X-Gm-Message-State: AFq9FYL8qx338g3MCqgNKRJEKpn4npgKht4fnpLjrr/vHnf4ssJhKhJv
	PM29N3CCewAfpv0IH27AsbpRunj2ZIuE46V0i5Gzj6f5qDMRDfJWphDvTvdNNlFwyi2CZsDc6TL
	xYgU=
X-Gm-Gg: AYBFou0u/Wsbtjx2WoE+BK7pUf21UMQrMOPcZg/qx43cTGKNpYZf6AqBe0lmt+iGEWt
	ka+Yzaf3yos9symlV/VxtcOoFXMZ3XGSADkXIl1gdMYACrlwkdKXI963/l5Wxf26hDgcIZo1kPB
	Qy/85l8eNai2TOlZU7Fb80l+I8DzdjKgCXsM0xgGx9E9E62js5y/msh2e7aQQdmHBaB04/+Ztbc
	SaDzqR5cLd7Re9tNwVRL/zJiz+VZolhKoHJLoPF9jD6Er0+oCqIjN3CoH304kTuEHHLikDRlyzm
	+b6og9nG6SVlqaduywpgdVOPttZ5ExGG2nPabCHQaQhJww/6OOySlT+kyeEKDmgmaV3JwSZT8A3
	F4PqfTn+cg3HEgJUj4J/qOu6FHyIzo1vrLVB+D/sPEmGbHX8TNDXWm6zkjyRweCEfnRt9ohcOfP
	GUQtq1JfMoQVnjd/Xvaj2LJQ1s6uG7loQtYjeMrv1WYSeNT0gYLdxDuWzarURv10JQD2z0L468I
	5kucaE/kY+aIUJVmnathTuWNUvanpppRRQ5o5/HWa/j
X-Received: by 2002:a05:622a:4086:b0:535:231d:653e with SMTP id d75a77b69052e-5359fb8efc9mr178678761cf.45.1791881683824;
        Tue, 13 Oct 2026 01:54:43 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b731a6csm97763401cf.11.2026.10.13.01.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:54:43 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next v3 2/5] net/sched: act_api: keep an add that created its actions from failing
Date: Tue, 13 Oct 2026 04:54:28 -0400
Message-Id: <QDISC-H19Z.v3.r0.20261012193813-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com>
References: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spotted while fixing the dump sizing reported by Sashiko. This references
commit cfa165cbfbed ("net/sched: act_gate: budget the per-entry list in
get_fill_size"), which is only one way to trigger the issue.

The issue:
tcf_action_add() returns the result of tcf_add_notify(), so an
RTM_NEWACTION is reported back to user space as a failure when the event
notification cannot be built, even though tcf_action_init() has already
inserted the actions into the idr. The realistic trigger is an action
list whose TCA_ACT_TAB exceeds a u16 nest (the notification can never be
built), or a memory-pressure -ENOBUFS from the notification's alloc_skb().

The Fix:
Drop the notification failure on the add path: the created actions
stay installed and the add reports success, with an extack noting that
the event notification could not be sent. The extack is set on a
successful ack, so iproute2 reports it as a warning; it replaces any
warning tcf_action_init() left there. This needs no idr/refcount
audit - tca_put_bound_many() already runs unconditionally after the
notification, so this path releases exactly what the success path does
and only the returned result changes. A create that ignores a
notification failure is already the filter-side norm: tc_new_tfilter()
does not look at tfilter_notify()'s result.

This is net-next hardening: it corrects the reported result of an add
that already took effect, not a regression.

Conditions to recreate the bug:
CONFIG_NET_CLS_ACT=y; CONFIG_NET_ACT_GATE=y. Send an RTM_NEWACTION whose
actions create an aggregate TCA_ACT_TAB larger than a u16 nest, so the
notification cannot be built; before this change the add reports -EINVAL
although the actions were installed, after it the add reports success and
the actions are present.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_api.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index d57e897cd363..949cbc4523a9 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -2167,12 +2167,17 @@ static int tcf_action_add(struct net *net, struct nlattr *nla,
 	if (ret < 0)
 		return ret;
 
-	ret = tcf_add_notify(net, n, actions, portid, attr_size, extack);
+	/* The add has already been committed, so a notification failure
+	 * must not turn it into a reported failure (cf. tc_new_tfilter()).
+	 */
+	if (tcf_add_notify(net, n, actions, portid, attr_size, extack))
+		NL_SET_ERR_MSG(extack,
+			       "Action created; event notification could not be sent");
 
 	/* only put bound actions */
 	tca_put_bound_many(actions, init_res);
 
-	return ret;
+	return 0;
 }
 
 static const struct nla_policy tcaa_policy[TCA_ROOT_MAX + 1] = {
-- 
2.43.0

