Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828781;
	b=ZzQufIa+8mdNCOzlkPTrZiuXQAxkpqB7ePacLPXxKXgvqmXonXZZHPs2lKBvDsIqLuFQ
	 JsB8y3KLJxwHny6XIlDhOr7W8c9SJVgi+Bm07PQM7QyK0rdAhQLdJq/ZOfJPFaTb249t3
	 ra8pqg5ymc3tZt01CAvTRL9nb1B+sO8eRRe38sOw1AA4Pg+D82+Xa5hvDEPCJ492uJ7YA
	 WXY+CNXU2Svwj7Bo9CVTV4xbTMcaQVCOaFuwurGtu1pEG69LdYvXWMI0BIcqdZGncxrgZ
	 /0LVI8wDAbwktgAdmeqoXpGSmNsx36UUoWK0Cdcc95PqNl4OTCDnoVaegtietyePWZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828781;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mHZc8+YQF2EtSdEWVUQndOkbLFBfBDM9FI4AIDv+tqo=;
	b=NZd3W7KKY2BL4L40mh75s5sY8bK1ACOMFaorGcuKfpL2vZwnUnSCQo+piBj+8WW8pbzL
	 mXzVSikE6eebQE+dnD3z+rYD7/Vc+mTQf/Vz9g+LmuYoNzqNKCFECgzDfy0Ga/bw19294
	 yQDzcksj3JFIyDYmAIlVToLjd5Z5QYIdtJJH03f4cGtztEiJyvyy9iIgOYNmOjR4xdEx2
	 1Gg7XJy0uS2zia8V6gd4bdHb9JylkVcB3DoExabyyql36JGp155wfSFlS+Q7GX0jt3Pm3
	 VTaesgGwdSKIDMAx5eytWPO8iOcK7AjhbjIVBsBoiyBWPg9jnDUgB7tIGkSSObrDNHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=ZZB526cZ;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA7606EEBF
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23DA7606EEBF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=ZZB526cZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1793828777; bh=h/hC71b64OsrfSdyZupVKYVsUNv4wkpiGAFci4awMt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZB526cZKYLCKD4dveNqVCDUZPKVUEUDkD9uXlpTmmEAfQqs81lufi8bi5IbpjAB4
	 40M2oWnado44ZsVufycbuPzxqPknmqIlflU4++6wDuxu1Qk7TdKljJLn3DSwHQZwFD
	 CbzBSaqlOjsqYf85cgKbD+oUBo6FWEV8qL3n6NA+U/HotBiqc6IaBt/65wdsYKCMd3
	 yHXsxsqxunKiPpApg7AOZmxlTOe4NNMnLd0GWdbQDNKp2jq7xwIBV17obFfVQXj1Ax
	 vJibkvdCfumHoQzg9BNb5YUnzok+wOP5D/F8NSlhe1UjbmSSl+/o0tASDB/oRhrkZ7
	 PEss2H9lt3aUg==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 76E0F44C04D7;
	Wed,  4 Nov 2026 22:46:17 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net/sched: act_api: pass the filter offload flags to action init
Date: Wed,  4 Nov 2026 22:45:56 +0100
Message-ID: <20261104214607.556269-3-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104214607.556269-1-acassen@corp.free.fr>
References: <20261104214607.556269-1-acassen@corp.free.fr>
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

A skip_sw filter gives its skip_sw flag to its actions only after their
->init() returns. ->init() then cannot know that the action never runs
in software unless the user also sets skip_sw on the action. Since
commit 34d35b4edbbe ("net/sched: act_api: deny mismatched
skip_sw/skip_hw flags for actions created by classifiers"), this action
flag also needs the filter one. The Sashiko AI review [1] of the
tunnel_key dst cache patch reports this limit.

Pass the filter offload flags to ->init() so that an action can skip the
state only the software path needs, like the tunnel_key dst cache.
tcf_idr_create() stores them in the new action, which replaces the
inheritance after ->init(). Since commit 9463e8d8c692 ("net/sched:
act_api: inherit filter offload flags only on new actions"), this
inheritance only applies to new actions, so the final action flags do
not change.

No action reads skip_hw at init and only act_skbedit reads skip_sw.
Since commit 4a6a676f8c16 ("act_skbedit: skbedit queue mapping for
receive queue"), it requires skip_sw for a receive queue_mapping. The
filter flag is now enough for this check.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051930.3619697-1-acassen%40corp.free.fr [1]
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
 net/sched/act_api.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e142d33dc5ef..13317d1abde1 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1531,6 +1531,12 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		ops[i - 1] = a_o;
 	}
 
+	/* New actions inherit these flags and init can skip software state */
+	if (tc_skip_sw(fl_flags))
+		flags |= TCA_ACT_FLAGS_SKIP_SW;
+	if (tc_skip_hw(fl_flags))
+		flags |= TCA_ACT_FLAGS_SKIP_HW;
+
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		act = tcf_action_init_1(net, tp, tb[i], est, ops[i - 1],
 					&init_res[i - 1], flags, extack);
@@ -1549,9 +1555,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 				/* Action is created by classifier and is not
 				 * standalone. Check that the user did not set
 				 * any action flags different than the
-				 * classifier flags, and inherit the flags from
-				 * the classifier for the compatibility case
-				 * where no flags were specified at all.
+				 * classifier flags.
 				 */
 				if ((tc_act_skip_sw(act->tcfa_flags) && !skip_sw) ||
 				    (tc_act_skip_hw(act->tcfa_flags) && !skip_hw)) {
@@ -1560,13 +1564,6 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 					err = -EINVAL;
 					goto err;
 				}
-				/* Other filters share an existing action */
-				if (init_res[i - 1] != ACT_P_CREATED)
-					continue;
-				if (skip_sw)
-					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_SW;
-				if (skip_hw)
-					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_HW;
 				continue;
 			}
 
-- 
2.43.0

