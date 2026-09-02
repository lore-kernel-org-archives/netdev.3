Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14FB38F929;
	Wed,  2 Sep 2026 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333424; cv=none; b=Ro7PUTDrs7rgvYOr6V9xqbVTRfRv9wwMZWyedCPlVna76jix1lBxdQ3RDb5Dghfe8AeevODoxXnh9AkDWsJrlW6BLtXz9kZxqMseocHjPa/rMxU5O2gXvObJNZxmNeeFa+YU+0crufTcBPU9a7/fY6c6uyFeCIuZCnT18aHbCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333424; c=relaxed/simple;
	bh=FAt2u36WZLrgsvlhYwAmtJVjR0LTSa8I3DJKL2YMedQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xmlu66NyQ+k4J8CEkX1MaixLCpqmmFl4UMpfvKK23Ewn2dgpgE/IeC1ABZUX3MztlCKbRFh+zm+PJ/cD4o4RaPs/eqzLJ6+M9kYtSogcaRGc8s+0p71OzKigYtpo/uokd8/fQEe8DnRqXquVgdi+rsMM49gk8n/pmmEYfHMkSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5knGDMY7; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5knGDMY7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dURJbGOT+nGQin/vz2Ejo4WJffZ3tf2RMyqU1ScFMTE=;
	b=5knGDMY7e5CAb6N16lAvzBJYUSZrtxDIpwhcvvxjWLNoly2vmR0phPR7jnC1yDIa49b9vsLQK
	X9Jtn0RfAbUbwuTdrAodlLM4oHdmi/W82bhTy+ZLrRj+oaRPoiCzg3CJLCaLTAg8REfEFKqTc/l
	UNO9RcqZ0SNnB3ts6xxXsZk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hZYdv5c92z1T4Mc;
	Wed,  2 Sep 2026 15:05:23 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 38E3540579;
	Wed,  2 Sep 2026 15:16:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Sep
 2026 15:16:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jhs@mojatatu.com>, <jiri@resnulli.us>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3] net: sched: act_gact: use acquire/release for tcfg_ptype
Date: Wed, 2 Sep 2026 15:16:59 +0800
Message-ID: <20260902071659.395509-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Replace the smp_wmb()/smp_rmb() barrier pair with
smp_store_release()/smp_load_acquire() on gact->tcfg_ptype.
tcf_gact_init() publishes tcfg_ptype via release after writing
tcfg_pval/tcfg_paction; tcf_gact_act() acquires it before
dispatching to gact_net_rand()/gact_determ(), ensuring the probability
parameters are visible.

No functional change intended.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Assisted-by: DeepSeek:DeepSeek-V3
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Split out from following patch set as Kuniyuki suggested.
Link: https://lore.kernel.org/all/20260901024234.135119-1-ruanjinjie@huawei.com/
---
 net/sched/act_gact.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 565860cccba6..d4f39f98e2cf 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -25,7 +25,6 @@ static struct tc_action_ops act_gact_ops;
 #ifdef CONFIG_GACT_PROB
 static int gact_net_rand(struct tcf_gact *gact)
 {
-	smp_rmb(); /* coupled with smp_wmb() in tcf_gact_init() */
 	if (get_random_u32_below(gact->tcfg_pval))
 		return gact->tcf_action;
 	return gact->tcfg_paction;
@@ -35,7 +34,6 @@ static int gact_determ(struct tcf_gact *gact)
 {
 	u32 pack = atomic_inc_return(&gact->packets);
 
-	smp_rmb(); /* coupled with smp_wmb() in tcf_gact_init() */
 	if (pack % gact->tcfg_pval)
 		return gact->tcf_action;
 	return gact->tcfg_paction;
@@ -133,11 +131,8 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 	if (p_parm) {
 		gact->tcfg_paction = p_parm->paction;
 		gact->tcfg_pval    = max_t(u16, 1, p_parm->pval);
-		/* Make sure tcfg_pval is written before tcfg_ptype
-		 * coupled with smp_rmb() in gact_net_rand() & gact_determ()
-		 */
-		smp_wmb();
-		gact->tcfg_ptype   = p_parm->ptype;
+		/* Pairs with smp_load_acquire() in tcf_gact_act(). */
+		smp_store_release(&gact->tcfg_ptype, p_parm->ptype);
 	}
 #endif
 	spin_unlock_bh(&gact->tcf_lock);
@@ -160,7 +155,8 @@ TC_INDIRECT_SCOPE int tcf_gact_act(struct sk_buff *skb,
 
 #ifdef CONFIG_GACT_PROB
 	{
-	u32 ptype = READ_ONCE(gact->tcfg_ptype);
+	/* Pairs with smp_store_release() in tcf_gact_init() */
+	u32 ptype = smp_load_acquire(&gact->tcfg_ptype);
 
 	if (ptype)
 		action = gact_rand[ptype](gact);
-- 
2.34.1

