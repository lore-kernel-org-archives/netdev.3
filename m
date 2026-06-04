Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB847ECF5;
	Thu,  4 Jun 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589456; cv=none; b=ruC6dCjBAaTf0sZyD9rz0zW9WWWyVkc8nN9DFAJyHQKncZi5ucRI0o1gnOBLwxz0/vFFcdeoHh9Omf8dT60p3aolA9z1vyOVqsyHplD58RwIC6kOiTsNVpTRpYaIlAsa7R5e778742xqOh02agjGqML0W2U28xytO+4wzVlBN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589456; c=relaxed/simple;
	bh=S/tioB8E4yjoHelD68jHcbW7LtEhi/qm6INDh3a3irs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5QaHdZ3A/le4THCwrWXB/I8zoVAEbGtolU26bW7bjvL/TLYuok6kIJi85KuVbbG5pNSiiWwYItN1VGAZJxHjUaRpWI/vfPe1lhEPs2dYJSzGaHKZ6fsMfcXSZOG0YEz3uiwSv4tJcNkuBEnqDvGxVS23vr6Ywm9BeJJLnUI6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TGkhr+z8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="TGkhr+z8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ULGRiCBgOfQhFNziT9TpZzJXG7cduMsUKF3R4NCV58w=; b=TGkhr+z8IlcYNgW96cw9mh60BL
	/CnWc/Ao/1edd0wfFKBbYDM4VP+LmlT9uVDZn5w7Uq52eEh0Q9E08AU/zFEpaIHlU/rr49B8m3kvZ
	yADsyz4RgbRo2TbRJvNHVytH9XulysxXXmqNJhq355jP3/PfDt/hwV5+gk5eWmUd4oB2/RiqPD+VK
	jmDAyfaJknCNY8+tp8Tg2B5EZGziC/c198m1+AarZegEhBV+xDlgsrFs0odOYf0EWA3LbPs2Kqwbh
	NtsLjV2bppmP3SrCQKgjZxD4nVmTAnGDwblLey7rYdQOE9xnv8C9yr4+CSL7KWaAilQH/O6AmRMqV
	g6sMFdYg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVAeg-004dOT-0G;
	Thu, 04 Jun 2026 16:10:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 04 Jun 2026 09:10:13 -0700
Subject: [PATCH net-next v3 4/5] netconsole: clean up deactivated targets
 dropped before the cleanup worker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-netcons_fix_before_move-v3-4-ab055b3a6aa5@debian.org>
References: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
In-Reply-To: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3175; i=leitao@debian.org;
 h=from:subject:message-id; bh=S/tioB8E4yjoHelD68jHcbW7LtEhi/qm6INDh3a3irs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIaN1bm14IxovQRtRwrR/kGwxQJT2vbvuz0Cw9
 Q9XK0B8o0GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiGjdQAKCRA1o5Of/Hh3
 bSjWD/0bSsumN1UloKcM4sWNEGyBHSdoLaN1r9qL/eF86/KFkGj6YoiG8mPbODyQrEkqHvfPBQR
 tT7Q5DccyzYgrBBcwbGZWB/Z1uOMBx997IZ0X8gW8Y2nMA9h26e8bKpZf3i9ZbRRtrdmavSVsPP
 hhuOxtF8p4wj3a4vkUucO00+VON1yl0UvWD5w+lN7ZaVJXr1Ej7vquhU7j5ZpKFt6Ga5sWDs6te
 +B9joKLj1+U+xuBJlKKblnrzqj4acFdvLJXS7nz+bQqjwL3MnjG6ak7bs1iqjMLmYZ3z5XmDiUC
 gFis80BbJZ5TKJ0qySFcHtSzH/Rcf/gJxHqruj4VYBWGi/T0ADZ+XrLlqpcHL1VKtW+md7ISCrp
 4wT7twr4+Mo0k0vvJ0J2qb0ZSKn7DtNOq4u2clV5BHz61TLg34+qWV1veElvHDuAaDyr5dKuH3G
 e7ePv4OjYnDJVp5yiiOMk8pMGOiPnd35xAXKkkZyU+ThaOXkAj2L/+efvb8fWThg38DIjjIjxLa
 AoGe8+Q2wesY1+Ri6Nw9iDxQP+Jvhs9WNhZ4D3Bg/t1ycSnwWE9oYn0EFbS3S4rOTU7eh6v4ela
 MnELOjGKmVlL6vjJcUReNU7JYck/96c94jBzj6YxZwtP8ZZD8ddQ8rCTB88iWkB6uuaeo1A1EeT
 zlz8+60Ev1JXrKA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

drop_netconsole_target() downgrades a STATE_DEACTIVATED target to
STATE_DISABLED and then only calls netpoll_cleanup() when the target is
STATE_ENABLED. A target becomes STATE_DEACTIVATED when its underlying
interface is unregistered: netconsole_netdev_event() moves it to
target_cleanup_list, and netconsole_process_cleanups_core() is expected
to run do_netpoll_cleanup() on it.

Now that drop_netconsole_target() takes target_cleanup_list_lock around
the unlink, a configfs removal racing with NETDEV_UNREGISTER can pull the
target off target_cleanup_list before the cleanup worker processes it.
The notifier drops the lock before calling
netconsole_process_cleanups_core(), so the worker then iterates a list
that no longer contains the target and never runs do_netpoll_cleanup() on
it. Because drop_netconsole_target() has already rewritten the state to
STATE_DISABLED, its own STATE_ENABLED check is false and netpoll_cleanup()
is skipped too. The net_device reference taken by netpoll_setup() is then
leaked and unregister_netdevice() hangs forever in netdev_wait_allrefs().

Capture whether the target still owns a netpoll before the state is
downgraded and clean it up for both STATE_ENABLED and STATE_DEACTIVATED
targets. netpoll_cleanup() is idempotent -- it skips when np->dev is
already NULL -- so it is safe even when the cleanup worker won the race
and already tore the netpoll down.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d8be2fef3826..80c5393ffa1c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1449,11 +1449,21 @@ static void drop_netconsole_target(struct config_group *group,
 {
 	struct netconsole_target *nt = to_target(item);
 	unsigned long flags;
+	bool needs_cleanup;
 
 	dynamic_netconsole_mutex_lock();
 
 	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
+	/* A STATE_DEACTIVATED target may have been moved to
+	 * target_cleanup_list by netconsole_netdev_event() but not yet
+	 * processed by netconsole_process_cleanups_core(). Unlinking it below
+	 * hides it from the cleanup worker, so this path has to clean it up
+	 * itself. Record that the target still owns a netpoll before the
+	 * state is downgraded.
+	 */
+	needs_cleanup = nt->state == STATE_ENABLED ||
+			nt->state == STATE_DEACTIVATED;
 	/* Disable deactivated target to prevent races between resume attempt
 	 * and target removal.
 	 */
@@ -1475,8 +1485,10 @@ static void drop_netconsole_target(struct config_group *group,
 	/*
 	 * The target may have never been enabled, or was manually disabled
 	 * before being removed so netpoll may have already been cleaned up.
+	 * netpoll_cleanup() is idempotent (it skips when np->dev is NULL), so
+	 * it is safe even if the cleanup worker already tore the netpoll down.
 	 */
-	if (nt->state == STATE_ENABLED)
+	if (needs_cleanup)
 		netpoll_cleanup(&nt->np);
 
 	config_item_put(&nt->group.cg_item);

-- 
2.53.0-Meta

