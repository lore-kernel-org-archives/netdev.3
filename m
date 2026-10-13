Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981B3BBA0F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881686; cv=none; b=PXlw4ECZfxelccge3TgHZLpgH8sJ/bRG4CIOubwNzOg8PNDWGgTLB60BIqbXmMEYOQouq5PyaEb3vCVx3VDt2CnhZK6BWYVKisA+0pCS8Ddt+EMNfqcFZoa0KpvmaBOpM8s9DLrqo5OFYK7YmOO2KqzFB+wXrMNcRjcxTPPlHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881686; c=relaxed/simple;
	bh=wEa8t95+L0arXTfVBMwIPuIiRCJk2RlF5kS6BwhIVUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tteFS9Em8IF0RrCW1BDuBNc+u+pi9il11SXL4OCMvqPAWRNydm89zAhFBQ0LJ7beAi4sbWoMBszQzgRD3HjTA1D+6zxx0XWRXaDmY5khX8/YtNLCAYjgCQ3ChdpFRR0SCsstlLpQGDfs6YoGsLj9RWWbxjnn9mI0XRa6Ucqm7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ZfReB0vA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ZfReB0vA"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5339381b46eso28617771cf.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791881682; x=1792486482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrYId7e5lyMEy6utRcLHOoL1Zo5nanExfY942f8kSVw=;
        b=ZfReB0vAmkhW92zdWcfP3hZ+rdNpb3f96YC3iExCn44US9ixlHRGoBcLw2wZLB+WYO
         PEIsH1LYS7mRL6cHGb7lR13n1lfNZCIMq016Tl2cJNxFwFMYoSarIkbS96KgxpUmXXkp
         PxY02QMnMr+g3crzxz7ognZQyau2bZDp4tCkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881682; x=1792486482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrYId7e5lyMEy6utRcLHOoL1Zo5nanExfY942f8kSVw=;
        b=i9rS74ZwRUI1VzNiCynCnenHArtpuVf4ViVtByKBWG+B/5AxO7ecFIRzvA1elAnLFY
         eekF49tBknTWEIadO9ALLERFoQeoglZkPfJVVmrho40TG49piKY85Lc2ziRZcoxtU9YP
         37cpAb5PTsmGjq3Zr/pQnSjhFNxrEOPIpN/gTO40R+41dRuUCJSAC0IbLaVlX33Rndbv
         uxmEXH/nBcQ6AN2RHZB+ObrGVr49GiTgQejcFKtruXh2rT+zNjTgWZQ7wqJJrUeFsRYl
         fROvsVwSKv17jviHBx23BUPH9rfgh8X3LyXOYOdQA5ET/KOfbex9n2rAyo6kF5hdzcRg
         k8YQ==
X-Gm-Message-State: AFq9FYJNl7v5ZAL95JJ1kIqx3/S4tIprd6rwHx4y86VyIAtIn1mtzelo
	ndLunz0SsJjFAC9bAZPb/y0doHyh7FfR2xptUwsea1ItSyZbqbBTHsi1gyFBnhYMiNS6U6G7Sg6
	Ry2M=
X-Gm-Gg: AYBFou2v5howL9OzD/Ortnh8bvbvTTqd5WImRHjgJonI30r6euy0bMtO+bMdCzOKaEA
	qAUVysvLiMEymQnz77g3NoI+qggs3JMelqWhtOL/jLEVIRQ0f6/tIhvMvha44WbDK499ymv1Afs
	d4wbzcoNTvuM6BtEBrT6hNsh5NpVWqeVuXrDvfxbX51FD0EJEVwU1ronDjwuZKUnlZ/IVR4GgCO
	r8UII8vs3bwES+Pf3vfSU1DkIWeARKe1zMoCYz7n3ACJQ0vRfOwwJ7DVQoL0GaJU0BAvQJePL8C
	pc4BYDI2mkesNNSTGsbcaiXnTv5RgIe9kqTHZhvAjBlsQl7q8bBxIf2Ei55laFj30KQlg8zWNE+
	zF2zHJNlrXVIBjArC7/gB9GH1dbJ5RatNO8NUEUuTuB6AnlciD9EzHLv8Ay8NODURxgkFByaOOT
	9FoIK8Ta/cioendt/XHvxKHZXTIBOIC/++Nyq8ml9TovIzsmTKyrrQdAMFRswZiVeJ/LcUgzazw
	WCBEXOng+sSiScYLqsUKhZdiFe7+T2286UwfQ6fqRrZ
X-Received: by 2002:a05:622a:c85:b0:535:15a9:2514 with SMTP id d75a77b69052e-5359fbb9fa7mr201965271cf.43.1791881681957;
        Tue, 13 Oct 2026 01:54:41 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b731a6csm97763401cf.11.2026.10.13.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:54:41 -0700 (PDT)
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Paul Moses <p@1g4.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Davide Caratti <dcaratti@redhat.com>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next v3 1/5] net/sched: act_gate: reject oversized dumps instead of wrapping them
Date: Tue, 13 Oct 2026 04:54:27 -0400
Message-Id: <QDISC-H19Z.v3.r0.20261012193813-1@mojatatu.com>
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

This is a followup of commit cfa165cbfbed ("net/sched: act_gate: budget
the per-entry list in get_fill_size") as reported by Sashiko.

The issue:
An action dump is carried inside nested netlink attributes whose lengths
are u16. A gate action with enough schedule entries produces a dump
larger than U16_MAX, and the plain nla_nest_end() closes by writing a
wrapped length: the reply is structurally corrupt. On a CONFIG_DEBUG_NET
kernel a plain nla_nest_end() also warns (DEBUG_NET_WARN_ON_ONCE warns
once per call site), which an unprivileged RTM_GETACTION or
RTM_GETTFILTER can reach once the action or filter exists.

The oversized dump also reaches the filter notification path through
tcf_fill_node(), which reports the failure as -EMSGSIZE.
tfilter_notify_prep() treats that as socket-buffer exhaustion and
retries with an ever larger alloc_skb(); a dump that does not fit a u16
nest cannot be built at any skb size, so the loop only spins until the
allocation itself fails.

The Fix:
Close every wrap-capable nest an action dump travels in with
nla_nest_end_safe(), which reports -EMSGSIZE before writing a wrapped
length: TCA_GATE_ENTRY_LIST, TCA_ACT_OPTIONS, the per-action nest and
TCA_ACT_TAB; the shared action and police containers in
tcf_exts_dump()/tcf_exts_terse_dump(); and the caller-owned TCA_OPTIONS
of every action-capable classifier (flower, matchall, basic, bpf,
cgroup, flow, fw, route4, u32). The output is byte identical for every
message that serializes. Bound the tfilter_notify_prep() retry once the
skb is already larger than any valid message, while a regular dump that
only needs a bigger skb still retries.

The retry bound and the checked closes are one change: it is
nla_nest_end_safe() that turns an unrepresentable dump into -EMSGSIZE,
so a backport has to take both together if either is taken.

Context note:
A delete notification that cannot be built must not veto the state
change the caller asked for. Two delete paths built the notification
before the state change and propagated the build failure.
tfilter_del_notify() builds the filter's delete notification before
calling ->delete(), so a filter whose dump cannot be represented in a u16
nest could be created but never removed by "tc filter del ... handle H" -
and only when a notification was actually needed (rtnl_notify_needed():
an RTNLGRP_TC listener or NLM_F_ECHO), which made it intermittent.
tcf_del_notify() has the same shape for RTM_DELACTION: it builds the
notification before tcf_action_delete(), so an action list whose
TCA_ACT_TAB exceeds a u16 nest could not be deleted either. In both cases
drop the unbuildable notification instead: on -EMSGSIZE the delete
proceeds. This needs tca_get_fill() and tcf_del_notify_msg() to pass
-EMSGSIZE up instead of collapsing it to -1/-EINVAL, and tca_get_fill()
reports any inner tcf_action_dump() failure as -EMSGSIZE too
(tcf_gate_dump() and tcf_action_dump_1() return plain -1 after one of
their checked closes fails), so a single oversized action's delete is not
vetoed either. On the delete paths the rule is scoped to notification
BUILD failures: a
delivery failure after the state change (rtnetlink_send() failing once
->delete() has already committed) still reports an error to the caller,
as it did before this series. The extack that notes a dropped filter
event is set only after ->delete() has returned 0.
-EMSGSIZE here is the general tcf_fill_node() outcome for any ->dump()
that does not fit, not only a u16 nest overflow; the effect of the new
branch is limited to dropping a best-effort notification.

why net-next?
This is hardening rather than a regression fix: the enclosing action and
filter-path nests have wrapped since the actions and classifiers allowed
large entry lists - TCA_ACT_TAB is core act_api and the filter-side
container predates the act_gate sizing change. A plain nla_nest_end()
has always written the wrapped length at U16_MAX; this stops the
corruption at the abstraction boundary instead of imposing a new policy
limit on accepted gate schedules. A separate patch caps the entry list
itself.

Conditions to recreate the bug:
CONFIG_NET_CLS_ACT=y; CONFIG_NET_ACT_GATE=y;
CONFIG_NET_CLS_MATCHALL=y and/or CONFIG_NET_CLS_BASIC=y. Create a
matchall or basic filter on an ingress/clsact qdisc whose action list
holds two gate actions of 1024 minimal TCA_GATE_ONE_ENTRY elements
each (TCA_ACT_MAX_PRIO admits up to 32 actions); the aggregate
TCA_ACT_TAB nest is ~74.3 KiB > 65532 and wraps, then RTM_GETTFILTER
it (or trigger the notify with NLM_F_ECHO).
The same shape as two standalone gate actions is hit on the action path
by RTM_DELACTION with NLM_F_ECHO; before this change the fill fails and
the delete is refused, after it the actions are removed and only the
notification is dropped.
For a single action the outermost TCA_ACT_TAB wraps from 1815 entries
(1821 for the innermost TCA_GATE_ENTRY_LIST); on the filter path the
outermost wrap-capable nest is the classifier's TCA_OPTIONS. Installing
needs CAP_NET_ADMIN in a user namespace; the RTM_GETTFILTER trigger needs
no capability once it exists. The two-action shape survives the
per-action cap added by "net/sched: act_gate: cap the number of scheduling
entries": the enclosing nests overflow from aggregate action size, which
no per-action cap can bound.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-H19Z.v2.20261007062551@mojatatu.com/
Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/
Link: https://lore.kernel.org/netdev/179111893181.434549.13449660670267048994@kernel.org/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Retarget to net-next and drop Fixes:/Cc: stable, as it is hardening
  rather than a regression.
- Patch 1: add seven additional action-capable classifier
  TCA_OPTIONS closes and correct the Conditions Kconfig name.
- Sashiko review of that posting:
  https://sashiko.dev/#/patchset/QDISC-H19Z.v1.20261001053234%40mojatatu.com

v2 -> v3:
- Patch 1: the action-delete path no longer lets an unbuildable
  RTM_DELACTION notification veto the delete.  tca_get_fill() and
  tcf_del_notify_msg() pass -EMSGSIZE up, and tcf_del_notify() drops the
  notification and proceeds with the delete.
- Patch 1: the filter-delete path drops an unbuildable notification and
  proceeds with the delete; its "Filter deleted" extack is set only after
  ->delete() has returned 0.
- Patch 1: the retry bound is documented as part of the same change as
  the checked closes, and -EMSGSIZE is noted as the general
  tcf_fill_node() outcome rather than a u16 overflow only.
- Sashiko reviews of v2:
  https://sashiko.dev/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
 net/sched/act_api.c      | 52 ++++++++++++++++++++++++++++++----------
 net/sched/act_gate.c     |  3 ++-
 net/sched/cls_api.c      | 38 +++++++++++++++++++++--------
 net/sched/cls_basic.c    |  3 ++-
 net/sched/cls_bpf.c      |  3 ++-
 net/sched/cls_cgroup.c   |  3 ++-
 net/sched/cls_flow.c     |  3 ++-
 net/sched/cls_flower.c   |  6 +++--
 net/sched/cls_fw.c       |  3 ++-
 net/sched/cls_matchall.c |  3 ++-
 net/sched/cls_route.c    |  3 ++-
 net/sched/cls_u32.c      |  3 ++-
 12 files changed, 89 insertions(+), 34 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 6e48b4bc2d75..d57e897cd363 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -558,7 +558,8 @@ tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
 		goto nla_put_failure;
 	err = tcf_action_dump_old(skb, a, bind, ref);
 	if (err > 0) {
-		nla_nest_end(skb, nest);
+		if (nla_nest_end_safe(skb, nest) < 0)
+			goto nla_put_failure;
 		return err;
 	}
 
@@ -1279,7 +1280,9 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[],
 			tcf_action_dump_1(skb, a, bind, ref);
 		if (err < 0)
 			goto errout;
-		nla_nest_end(skb, nest);
+		err = nla_nest_end_safe(skb, nest);
+		if (err < 0)
+			goto errout;
 	}
 
 	return 0;
@@ -1673,27 +1676,42 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 	struct nlmsghdr *nlh;
 	unsigned char *b = skb_tail_pointer(skb);
 	struct nlattr *nest;
+	int err;
 
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*t), flags);
-	if (!nlh)
+	if (!nlh) {
+		err = -EMSGSIZE;
 		goto out_nlmsg_trim;
+	}
 	t = nlmsg_data(nlh);
 	t->tca_family = AF_UNSPEC;
 	t->tca__pad1 = 0;
 	t->tca__pad2 = 0;
 
 	if (extack && extack->_msg &&
-	    nla_put_string(skb, TCA_ROOT_EXT_WARN_MSG, extack->_msg))
+	    nla_put_string(skb, TCA_ROOT_EXT_WARN_MSG, extack->_msg)) {
+		err = -EMSGSIZE;
 		goto out_nlmsg_trim;
+	}
 
 	nest = nla_nest_start_noflag(skb, TCA_ACT_TAB);
-	if (!nest)
+	if (!nest) {
+		err = -EMSGSIZE;
 		goto out_nlmsg_trim;
+	}
 
-	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
+	err = tcf_action_dump(skb, actions, bind, ref, false);
+	if (err < 0) {
+		/* Report any inner dump failure as -EMSGSIZE so
+		 * tcf_del_notify() drops the notification, not the delete.
+		 */
+		err = -EMSGSIZE;
 		goto out_nlmsg_trim;
+	}
 
-	nla_nest_end(skb, nest);
+	err = nla_nest_end_safe(skb, nest);
+	if (err < 0)
+		goto out_nlmsg_trim;
 
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
 
@@ -1701,7 +1719,7 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 
 out_nlmsg_trim:
 	nlmsg_trim(skb, b);
-	return -1;
+	return err;
 }
 
 static int
@@ -1988,17 +2006,19 @@ static struct sk_buff *tcf_del_notify_msg(struct net *net, struct nlmsghdr *n,
 					  struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
+	int err;
 
 	skb = alloc_skb(max(attr_size + tcf_action_warn_attr_size(extack),
 			    NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
 		return ERR_PTR(-ENOBUFS);
 
-	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
-			 0, 2, extack) <= 0) {
+	err = tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
+			   0, 2, extack);
+	if (err <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action attributes");
 		kfree_skb(skb);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(err ? err : -EINVAL);
 	}
 
 	return skb;
@@ -2016,8 +2036,14 @@ static int tcf_del_notify(struct net *net, struct nlmsghdr *n,
 	} else {
 		skb = tcf_del_notify_msg(net, n, actions, portid, attr_size,
 					 extack);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
+		if (IS_ERR(skb)) {
+			/* Such a dump can never be serialized: drop the
+			 * notification rather than refuse the delete.
+			 */
+			if (PTR_ERR(skb) != -EMSGSIZE)
+				return PTR_ERR(skb);
+			skb = NULL;
+		}
 	}
 
 	/* now do the delete */
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 6d6d45e03c07..14801c604bd9 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -654,7 +654,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
 			goto nla_put_failure;
 	}
 
-	nla_nest_end(skb, entry_list);
+	if (nla_nest_end_safe(skb, entry_list) < 0)
+		goto nla_put_failure;
 
 	tcf_tm_dump(&t, &gact->tcf_tm);
 	if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a9f54988561f..bd0d635fe3fe 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2149,11 +2149,16 @@ static struct sk_buff *tfilter_notify_prep(struct net *net,
 			    rtnl_held, extack);
 	if (ret <= 0) {
 		kfree_skb(skb);
-		if (ret == -EMSGSIZE) {
-			size += NLMSG_GOODSIZE;
-			goto retry;
-		}
-		return ERR_PTR(-EINVAL);
+		if (ret != -EMSGSIZE)
+			return ERR_PTR(-EINVAL);
+		/* A u16 nest caps the dump, so once the skb is larger than
+		 * any valid message it can never serialize. Stop at the
+		 * bound instead of looping until alloc_skb() fails.
+		 */
+		if (size > U16_MAX + NLMSG_GOODSIZE)
+			return ERR_PTR(-EMSGSIZE);
+		size += NLMSG_GOODSIZE;
+		goto retry;
 	}
 	return skb;
 }
@@ -2200,8 +2205,18 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh,
 				  RTM_DELTFILTER, portid, rtnl_held, extack);
 	if (IS_ERR(skb)) {
-		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
-		return PTR_ERR(skb);
+		if (PTR_ERR(skb) != -EMSGSIZE) {
+			NL_SET_ERR_MSG(extack, "Failed to build del event notification");
+			return PTR_ERR(skb);
+		}
+		/* No notification can ever be built for this filter: drop
+		 * it rather than refuse the delete.
+		 */
+		err = tp->ops->delete(tp, fh, last, rtnl_held, extack);
+		if (!err)
+			NL_SET_ERR_MSG(extack,
+				       "Filter deleted; del event notification could not be built");
+		return err;
 	}
 
 	err = tp->ops->delete(tp, fh, last, rtnl_held, extack);
@@ -3529,7 +3544,8 @@ int tcf_exts_dump(struct sk_buff *skb, struct tcf_exts *exts)
 			if (tcf_action_dump(skb, exts->actions, 0, 0, false)
 			    < 0)
 				goto nla_put_failure;
-			nla_nest_end(skb, nest);
+			if (nla_nest_end_safe(skb, nest) < 0)
+				goto nla_put_failure;
 		} else if (exts->police) {
 			struct tc_action *act = tcf_exts_first_act(exts);
 			nest = nla_nest_start_noflag(skb, exts->police);
@@ -3537,7 +3553,8 @@ int tcf_exts_dump(struct sk_buff *skb, struct tcf_exts *exts)
 				goto nla_put_failure;
 			if (tcf_action_dump_old(skb, act, 0, 0) < 0)
 				goto nla_put_failure;
-			nla_nest_end(skb, nest);
+			if (nla_nest_end_safe(skb, nest) < 0)
+				goto nla_put_failure;
 		}
 	}
 	return 0;
@@ -3565,7 +3582,8 @@ int tcf_exts_terse_dump(struct sk_buff *skb, struct tcf_exts *exts)
 
 	if (tcf_action_dump(skb, exts->actions, 0, 0, true) < 0)
 		goto nla_put_failure;
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 	return 0;
 
 nla_put_failure:
diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index e2a94ba9fba7..ba859110faae 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -305,7 +305,8 @@ static int basic_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	    tcf_em_tree_dump(skb, &f->ematches, TCA_BASIC_EMATCHES) < 0)
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 188cf0f949dd..232796d3a51f 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -631,7 +631,8 @@ static int cls_bpf_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	    nla_put_u32(skb, TCA_BPF_FLAGS_GEN, prog->gen_flags))
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &prog->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_cgroup.c b/net/sched/cls_cgroup.c
index 210fd9fd26d8..28701d3916b8 100644
--- a/net/sched/cls_cgroup.c
+++ b/net/sched/cls_cgroup.c
@@ -185,7 +185,8 @@ static int cls_cgroup_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	    tcf_em_tree_dump(skb, &head->ematches, TCA_CGROUP_EMATCHES) < 0)
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &head->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index a9ac3acf6eda..2ef449706638 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -681,7 +681,8 @@ static int flow_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	    tcf_em_tree_dump(skb, &f->ematches, TCA_FLOW_EMATCHES) < 0)
 		goto nla_put_failure;
 #endif
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 0c4beff18d68..299b1493d74b 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -3759,7 +3759,8 @@ static int fl_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_dump(skb, &f->exts))
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
@@ -3804,7 +3805,8 @@ static int fl_terse_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_terse_dump(skb, &f->exts))
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	return skb->len;
 
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index a462b262719c..0f731595f839 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -414,7 +414,8 @@ static int fw_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_dump(skb, &f->exts) < 0)
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index c14899b935bf..6ece63b82775 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -366,7 +366,8 @@ static int mall_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_dump(skb, &head->exts))
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &head->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index dca812a75269..6f8b4a98bb84 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -663,7 +663,8 @@ static int route4_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_dump(skb, &f->exts) < 0)
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 76ce2d124079..91f4e6458785 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1482,7 +1482,8 @@ static int u32_dump(struct net *net, struct tcf_proto *tp, void *fh,
 #endif
 	}
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (TC_U32_KEY(n->handle))
 		if (tcf_exts_dump_stats(skb, &n->exts) < 0)
-- 
2.43.0

