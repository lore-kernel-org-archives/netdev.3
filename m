Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA1273816;
	Wed, 25 Feb 2026 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986369; cv=none; b=QMiTVimfE4NA1e3AiPmxYhSoVboqEKcZRE2SNNYcZl9Zde+NmLqzu5cWgdYCs3yBiujDaiBKolbg9kPqOgy7cFVUiwNQ+k2LIx7nVOm+HzB/zKmWuxFCKeENcsXQ/HSP692NNDM3X1SZbjM7SE1RwjNamjctduCuRmpuB9tNyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986369; c=relaxed/simple;
	bh=5q/gy2Ucyfw1Ty2cmZtJ+NPyMI6M6VJcKIRA2HH2AmE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bMQtQVYCf33OlgJCZs3jpd2SSowaH4gJaQEeaPaieCOrksiIQwK/+cTHnpf5jSLQf8T0FC/GRltvpF1HtYy9g79DmzA2QeW4hrRDnhphnPMXRkFMY3ZyV3Y1UKOnUYV1r9F6UUCOU7AEaDzJ+k5gg/B0+RyxbllFUUTauMJ4jPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][net-next] net/devlink: Move health recovery notification after abort check
Date: Tue, 24 Feb 2026 21:10:03 -0500
Message-ID: <20260225021003.1837-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

In devlink_health_report(), the DEVLINK_CMD_HEALTH_REPORTER_RECOVER
notification is sent immediately after setting the error state, before
checking if recovery should be aborted via devlink_health_recover_abort().

When devlink_health_recover_abort() returns true (e.g., due to rate
limiting), the recovery process terminates early, but userspace has already
received a notification implying that recovery is underway. This creates a
misleading view of the reporter's activity.

Move the notification after the abort check, ensuring it is only sent when
recovery will actually proceed. This aligns the notification with the
actual recovery behavior.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/devlink/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 136a67c..e9999fc 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -665,7 +665,6 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	reporter->error_count++;
 	prev_health_state = reporter->health_state;
 	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_ERROR;
-	devlink_recover_notify(reporter, DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 
 	if (devlink_health_recover_abort(reporter, prev_health_state)) {
 		trace_devlink_health_recover_aborted(devlink,
@@ -686,6 +685,7 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	if (!reporter->auto_recover)
 		return 0;
 
+	devlink_recover_notify(reporter, DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 	devl_lock(devlink);
 	ret = devlink_health_reporter_recover(reporter, priv_ctx, NULL);
 	devl_unlock(devlink);
-- 
2.9.4

