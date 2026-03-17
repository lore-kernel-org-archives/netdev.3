Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E032F39CE
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763839; cv=none; b=qhEa8C5C+iGLZSkhXN23NRT+QF7pH0zgxWZf1lqh/OgU4UDb4Qiz1KyxKxUe3HfIqPGm8fRfd5NearRlsVbRRFeGKp6IOtbvoHm5QZah6FVYr1/6ReEILja8qXlvs7dJzanqoiGpq/Ynz8SzHvE5Kvu291nzRo8A9um1JZvc+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763839; c=relaxed/simple;
	bh=n5Ki+kJXfh5+3mQvMa4ZwbM1xXTDKOezRbqWOSVCEuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdcZ6Unxj72OfGfXzhE/FdXcAqGGwCqPWt34UIEg69QijAzwIESud+cC8US8A8FCN6yVEs7Duthd67//nOIWskyszMpBsK/4qNk32m3UdpUOKk955NMTDRN3sQpL1eEn8EH46Z6/ZwUc+BZ+Q1I39yWyJYasmL+jnTXcTyOohz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5yKgNQd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5yKgNQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5952C4CEF7;
	Tue, 17 Mar 2026 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773763839;
	bh=n5Ki+kJXfh5+3mQvMa4ZwbM1xXTDKOezRbqWOSVCEuM=;
	h=From:To:Cc:Subject:Date:From;
	b=I5yKgNQdHgpcmKWxVbIQQlnX9kyrsyeI34tN/hpQK7q1/2P7bPYjgH5HwxYCuQab3
	 O1ErWIjY63ykYBXf/GdapyllXaVwpUb1uWrc+DQocVx9defxdOb3CjsOv5hGTxYG7d
	 mWr+/wOAftVSDJuh/ZQ/wHuWZXE1idITdo7nQFeJY1HLF2InXyN6QVeOTTDZD+Cukt
	 K1U/ZGwH57KehmqSn1gOMo6tRFusAthW8MlxDvYyrVj5HWIdFD2iNoys5l0QinX6q0
	 xentk1wsKCnBd9cjJ6oPC/08A6/2+Opom8+skaivGx/V8NRyjdHhA2+ZZ1+Jkpho8j
	 P2xozJ8veQSEw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	p@1g4.org,
	ast@fiberby.net,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/2] net: shaper: protect late read accesses to the hierarchy
Date: Tue, 17 Mar 2026 09:10:13 -0700
Message-ID: <20260317161014.779569-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We look up a netdev during prep of Netlink ops (pre- callbacks)
and take a ref to it. Then later in the body of the callback
we take its lock or RCU which are the actual protections.

This is not proper, a conversion from a ref to a locked netdev
must include a liveness check (a check if the netdev hasn't been
unregistered already). Fix the read cases (those under RCU).
Writes needs a separate change to protect from creating the
hierarchy after flush has already run.

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Reported-by: Paul Moses <p@1g4.org>
Link: https://lore.kernel.org/20260309173450.538026-1-p@1g4.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 3fd6629cb999..6b4c87e12f1f 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -65,6 +65,21 @@ net_shaper_hierarchy(struct net_shaper_binding *binding)
 	return NULL;
 }
 
+static struct net_shaper_hierarchy *
+net_shaper_hierarchy_rcu(struct net_shaper_binding *binding)
+{
+	/* Readers look up the device and take a ref, then take RCU lock
+	 * later at which point netdev may have been unregistered and flushed.
+	 * READ_ONCE() pairs with WRITE_ONCE() in net_shaper_hierarchy_setup.
+	 */
+	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV &&
+	    READ_ONCE(binding->netdev->reg_state) <= NETREG_REGISTERED)
+		return READ_ONCE(binding->netdev->net_shaper_hierarchy);
+
+	/* No other type supported yet. */
+	return NULL;
+}
+
 static const struct net_shaper_ops *
 net_shaper_ops(struct net_shaper_binding *binding)
 {
@@ -251,9 +266,10 @@ static struct net_shaper *
 net_shaper_lookup(struct net_shaper_binding *binding,
 		  const struct net_shaper_handle *handle)
 {
-	struct net_shaper_hierarchy *hierarchy = net_shaper_hierarchy(binding);
 	u32 index = net_shaper_handle_to_index(handle);
+	struct net_shaper_hierarchy *hierarchy;
 
+	hierarchy = net_shaper_hierarchy_rcu(binding);
 	if (!hierarchy || xa_get_mark(&hierarchy->shapers, index,
 				      NET_SHAPER_NOT_VALID))
 		return NULL;
@@ -778,17 +794,19 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 
 	/* Don't error out dumps performed before any set operation. */
 	binding = net_shaper_binding_from_ctx(ctx);
-	hierarchy = net_shaper_hierarchy(binding);
-	if (!hierarchy)
-		return 0;
 
 	rcu_read_lock();
+	hierarchy = net_shaper_hierarchy_rcu(binding);
+	if (!hierarchy)
+		goto out_unlock;
+
 	for (; (shaper = xa_find(&hierarchy->shapers, &ctx->start_index,
 				 U32_MAX, XA_PRESENT)); ctx->start_index++) {
 		ret = net_shaper_fill_one(skb, binding, shaper, info);
 		if (ret)
 			break;
 	}
+out_unlock:
 	rcu_read_unlock();
 
 	return ret;
-- 
2.53.0

