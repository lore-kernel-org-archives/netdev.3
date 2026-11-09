Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228387;
	b=R3HvV1tJmFCJiXtVI/K7D+cqpB6bCBvhLr99epCVgNf7uHzzxuAztC9DL5qpnwsVZuJ8
	 BEC4C0U+mQVoJACYyQhzeUOzxHHt0s3PUU5ny5qAPG1DDjM1DjHTcBb1e+mKbRhMXWyzc
	 9+6/OOeU7/6z2s973w/XI9AgdofvRW44lNSoUt7zYF4/BrLKfmVBhSFfrslR774SpIWth
	 dbay4seDPXfbSb4+BUFo3iQaIo5dIFW+FcYPSus6DVgv3wZpCL2HEaHjsustyIV41BDuZ
	 XT9vP1BchIwuzPsiioG9y+XbmFIm26O9wzezMPS4wtuWJhULhLH45EX29Q7mqIxr0nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228387;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EKdgune0cGqt6/AY9I68TYJpr0PZJ4H+VDEta8AqWf4=;
	b=XuPE902s/kLFiuXzaU0M15HKwgWxpeilLlK8+FfEJDyQKwcIbcJu1Q5dmN5WiNz3L2E0
	 M3LyfX8i8hNlcVlIF8gR3wJ4Rdcbck279auteKgkYalaBv0j7bI3o4O1gSmSKuHV3128f
	 F1DRHEMnnLafX8vZiqXFMjst5nPBF6ooF6lkVQeCzaM2TJ3sLLI7z1+n4B+RzAbocwXev
	 toiLGgGHsycN/L4dp9T1/aCeF0JIJS92ZIO+qCnEMFsjWTY39dFHpXbFA1NbQ5XLCAeL5
	 eCWGYlIK7JymwDZbVMuHILGJCG/pi6m4mngmIgra/FBLrmFl69cMUZ//QlLmX8+qVfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=iykR8Pb1;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41F606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C41F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=iykR8Pb1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794228384; bh=LUj29t4Yt8O6F7xuB72VLvUPnUnGRY3ko9wrhVlHUJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iykR8Pb1MVMZVVSG7wbFrP/lBizCObuN+z2H7nHw9Ei2FRt24lleLo4UCgQsqbvDR
	 7xOa+3R+z2ASzAV6vPxU3/QCRov4l5kikCUu1AnuyxZzgpfZBSUg1+PGhNoMwwkUyU
	 Sz9Mos/3U8cX/k/UWAgT7gvW8ovAWQzHmpFZCfzXw4Zb5IQOilRz2DiTmAJlIi4P5Q
	 /nx6KOCkwhKmepuovHERZvCyrqM+Z5ce3tfORtwcy/89Nyyb2FzrQdy33w4ahUB3xw
	 XMH9Wwu6iPbweV8lhJe/E4oVfK/9KI8vPmrs8aPWiskXx8tE3cEqxjbYY2jWoECVEW
	 Y4u6Y+mT8Y/7g==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 5E64D44C0618;
	Mon,  9 Nov 2026 13:46:24 +0100 (CET)
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
Subject: [PATCH net-next v3 3/4] net/sched: act_api: pass the filter offload flags to action init
Date: Mon,  9 Nov 2026 13:46:14 +0100
Message-ID: <20261109124618.933149-4-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109124618.933149-1-acassen@corp.free.fr>
References: <20261109124618.933149-1-acassen@corp.free.fr>
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
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
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

