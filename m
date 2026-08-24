Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545453FBEA5
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585962; cv=none; b=TgFuhJpoFUbktxQbIqCoXuM/N+g2/fW2kZjyC2e+D0owaCWn8LR6u7Z4WHHLJtUhdDAFf8zaFTyQgSjn3wBYrp7hwPMYpYm3nYInCtwDq8gFKD8lDRurkgtczUGU7KTEcVlaTgullNF5ZY14IrBvLVcHgqCyTzBYuxJWvIEI2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585962; c=relaxed/simple;
	bh=VJN7nKbx3j43OoUyn7joaISSozobbWcv/bO7UF/uLP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2VM84eE7U3DFUJ/ps4ro0d6zC63laK47sVyEhnLSTY3jWJD3qfdjoZ1lqwkCnJpqh5rq1xREAxVa+IBvXw8XfSazYzWgFCUVjZkbx6IBkcaPEvaNCpgeL2Xx5y05sTuBTVFiYT6qab8va4HKX1si1eh5CDPU4J7GPPfatfCvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=iBs0qcHL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="iBs0qcHL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d560775ca2so29564195ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787585960; x=1788190760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5wPGUWNwJZ0R83xYyj6DyDc36mA65uN+lqlHoSz4qJ4=;
        b=iBs0qcHL81B+wTzSGZejedUR+PgJt3gW1CFEloGQYmV/lqF7e9hR79hhFMwxrYaK6N
         uM714oEBqRsyrmjRe7sisJhX8ZGXpvPm6rJ+9uHKojpyelr8MTrcwFUKi6gQohpT1aKU
         MO5On1mo9fdX1mCF/M2ifDxzEGHvvkpYD90i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585960; x=1788190760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5wPGUWNwJZ0R83xYyj6DyDc36mA65uN+lqlHoSz4qJ4=;
        b=M7+6wm9mZDQAXEFdscfGNjtVLkprR0Fjdjr7yRvN10jz5+UlB0YaicwoAb2GTys4Pp
         k326SNnOVt6P3g6Z0LekspVqL5rJh0qkRed08E92PrqX3OQgDyhkUhJ9pQMHGaah48Jw
         U26iWU/QTs09jRzEumUuELe00KIkstSGA86omDMGCjyNrjLG6t9XDeOZtU/Px2unNK9K
         H6osQiBZrql+7yRLm1IfWZ1WC2K72SWisGZsE32Srx90zwkCJ76wkLz08rS0j47fKX19
         BxLvY/5z/VDLFue8XvDwWM/mvXaWk4cT02wkwMumiNtxylEtK7b7zDH7LZFF5fpj3jhR
         J9Zg==
X-Forwarded-Encrypted: i=1; AHgh+RpZdsjrw+ns+eIA8Ba4MO4xF359jHVfzpYkrG2lB3mdi3qU7vmYtLbOEn+K9aTyxPku1b07/Ig=@vger.kernel.org
X-Gm-Message-State: AFuF++kutkphFA9DV2w9sa0YfaZil2PZqqOdLeFtNGENIsvoD+/yeBrh
	BQ9ysg5pZSmy46H5++hw+Mk5ZE2xeI4Cd+1mKNQDSTBYyImo/XcXeL64cJmgRIHTtQ==
X-Gm-Gg: AR+sD12E5Wbt8Em30e74MTeMWpwHR9TRkOCiaEVUyrh04E0TDv/c98YJa80nOG/qV1G
	DyrOdB+S1jqt50UIm+BxYEi1t8IcU5voFwtmLggBUqI4tZtVVlehOF56JhZUl0IlincsmTHLAjh
	lBaxuItB6Oo2PbCdi5kZhdJINRbup6vXim4WPdlopy8t9V0zIj64CURp5B4dkMIQVG8y8rAAkfd
	G+rVOS2oU7uWXS2vWTiV6aBlF+AHbnYLH0s+v4txR4oQONKOhkxBjZGR/3jH6e6IV4x5jSR4Xva
	gMnxpc5g1ndvtxPXyj49KF8cIdRFMT6dgJ/+REFKneKgyxDuQV+AHVmC1y+uZVnlDfnEIS0EcTl
	KSTza7ORPBgLpVkPULnw6i7pfmLI2UlhpX3Ftnztl2Uyuf824YAojvH1SPzRJ77hUge6372Zm+e
	UnablnOBawsFttyo8nOAVbF/yvVuQTTo3WK8Csbldb4OYN
X-Received: by 2002:a17:903:fa6:b0:2d6:5beb:8692 with SMTP id d9443c01a7336-2d670bb5042mr388410515ad.6.1787585960063;
        Mon, 24 Aug 2026 08:39:20 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767b0aeesm18704585ad.36.2026.08.24.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:39:19 -0700 (PDT)
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
Subject: [PATCH net 3/4] net/sched: act_api: fix skb sizing and action leak on reoffload delete
Date: Mon, 24 Aug 2026 12:39:02 -0300
Message-ID: <20260824153903.4143642-4-victor@mojatatu.com>
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

tcf_reoffload_del_notify_msg() sizes the RTM_DELACTION skb with
tcf_action_fill_size(action) alone.  Unlike every other notification path
it never wraps that in tcf_action_full_attrs_size(), so the nlmsg_put()
header, struct tcamsg and the TCA_ACT_TAB nest that tca_get_fill() emits -
24 bytes on x86_64 - are not budgeted.  As long as the single action stays
well under NLMSG_GOODSIZE the floor in alloc_skb() hides this, but once its
fill size crosses NLMSG_GOODSIZE the allocation is exactly 24 bytes short
and tca_get_fill() runs out of tailroom.  That is now easy to reach for an
offloadable act_pedit with a large tcfp_nkeys, which commit 8e2efb3f45a5
("net/sched: add get_fill_size callbacks for actions missing them") started
accounting for properly.

When that happens tcf_reoffload_del_notify() returns early, before
tcf_idr_release_unsafe(), and tcf_action_reoffload_cb() discards the return
value:

	if (tc_act_skip_sw(p->tcfa_flags) && !tc_act_in_hw(p))
		tcf_reoffload_del_notify(net, p);

The action has just lost its last hardware instance and is skip_sw, so it
is left installed while processing no packets, and with no notification to
tell userspace about it.  An -ENOBUFS from alloc_skb() gets the same
treatment.

Fix this by budgeting the message header the way the add and delete paths
do, and release the action even when the notification cannot be built -
dropping the notification is strictly better than leaking a dead action,
and there is no caller left to report the error to.

Fixes: 13926d19a11e ("flow_offload: add reoffload process to update hw_count")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164357.1653956-1-victor%40mojatatu.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_api.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 20b6501fd33b..37eced84dfa5 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1867,11 +1867,13 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
 static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,
 						    struct tc_action *action)
 {
-	size_t attr_size = tcf_action_fill_size(action);
 	struct tc_action *actions[TCA_ACT_MAX_PRIO] = {
 		[0] = action,
 	};
 	struct sk_buff *skb;
+	size_t attr_size;
+
+	attr_size = tcf_action_full_attrs_size(tcf_action_fill_size(action));
 
 	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
@@ -1888,15 +1890,18 @@ static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,
 static int tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
 {
 	const struct tc_action_ops *ops = action->ops;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	int ret;
 
-	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC)) {
-		skb = NULL;
-	} else {
+	if (rtnl_notify_needed(net, 0, RTNLGRP_TC)) {
 		skb = tcf_reoffload_del_notify_msg(net, action);
+		/* The action has already lost its hardware instance and is
+		 * skip_sw, so it must be released whether or not the
+		 * notification can be built.  Drop the notification rather
+		 * than leave an action behind that processes no packets.
+		 */
 		if (IS_ERR(skb))
-			return PTR_ERR(skb);
+			skb = NULL;
 	}
 
 	ret = tcf_idr_release_unsafe(action);
-- 
2.55.0

