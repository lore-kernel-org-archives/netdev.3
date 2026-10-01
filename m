Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23B2C3768;
	Fri,  2 Oct 2026 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900998; cv=none; b=VHMfbGNb1oT3Ueb6sp+t75R4M8Su0/FHC/W0CRw/OGMD0rEd6yup3/6+fFDEAjfa9qh2cK6nwhJQQu53FgNWa0MKg4HtNRPd2CXXcCokKxpXHCrarLY2HFGUao/hKaL78maOg9RObCkHTEVE5ugjMrNk4BfOi8SsKSIwS6LWt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900998; c=relaxed/simple;
	bh=rKCAgp2TZE07lWEEJcWOKWsYHKIMqeKHJec2jV6ttFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjLJuQTcli91TVz9G7c8hRi9B8nrk7BVnuBkfBlFr8RHAGz9T5s4NlPm2CbVBNsbnNt7wyJ823ODDr/3YRv8wKLcp2ma3f5jxcKgUlq8Xf2mhmW9YEvcYUiVhWlrHKGO0Y2V33eh1h1UUCGL76fr2Jg4VvCqjxGdEkpyWJD8I14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=dvZ9wRI7; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="dvZ9wRI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dvZ9wRI725Rdttus2j54+qGIFkOp5vu/PxcLgTsT8KaNjfKXhM70JwDTc0Lb901ontKcxr/iH7Q7J
	 cfz2t6wnYil4CEoIL+SKGws8JT1oBv5kbqzP6vyzMx+X4G0koUIwo/59iyaExbfYl4xXvX4J1G2kmF
	 xPm804WKYJcY3eG8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26abefaf829b-d028e;
	Fri, 02 Oct 2026 08:29:45 +0800 (CST)
X-RM-TRANSID:2ee26abefaf829b-d028e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66abefae08d1-31f43;
	Fri, 02 Oct 2026 08:29:45 +0800 (CST)
X-RM-TRANSID:2ee66abefae08d1-31f43
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net] devlink: fix devlink_rel reference leak when notify work is pending
Date: Thu,  1 Oct 2026 12:22:32 +0800
Message-ID: <20261001042232.222987-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devlink_rel_nested_in_notify_work_schedule() takes a reference on the
devlink_rel for the notify work and then queues the work, ignoring the
return value of schedule_delayed_work(). If the work is already pending,
nothing new is queued, the work runs only once and drops only one
reference, so the extra one is leaked together with the devlink_rel and
its index in devlink_rels.

This is easy to hit. devl_register() of a nested instance queues the
work, and if the instance is unregistered before the work has run,
devlink_rel_put() queues it again while it is still pending. The work
also keeps rescheduling itself for as long as the parent devlink lock
cannot be taken, which widens the window. Registering and unregistering
a nested devlink instance 100 times while holding the parent lock leaks
all 100 devlink_rel objects.

The reschedule path in devlink_rel_nested_in_notify_work() has the same
problem: if the work was queued again while it was running, the
reference it holds is never dropped.

Drop the reference in both places when the work was already pending.
The pending work holds its own reference, so this can not be the last
one.

Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
Assisted-by: LLM
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/devlink/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index c53a42e17a58..bddbbbf000fe 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -112,13 +112,19 @@ static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 	return;
 
 reschedule_work:
-	schedule_delayed_work(&rel->nested_in.notify_work, 1);
+	/* The work may have been queued again meanwhile, which took its own
+	 * reference. Drop ours in that case.
+	 */
+	if (!schedule_delayed_work(&rel->nested_in.notify_work, 1))
+		__devlink_rel_put(rel);
 }
 
 static void devlink_rel_nested_in_notify_work_schedule(struct devlink_rel *rel)
 {
 	__devlink_rel_get(rel);
-	schedule_delayed_work(&rel->nested_in.notify_work, 0);
+	/* The pending work holds a reference already, drop the new one. */
+	if (!schedule_delayed_work(&rel->nested_in.notify_work, 0))
+		__devlink_rel_put(rel);
 }
 
 static struct devlink_rel *devlink_rel_alloc(void)
-- 
2.43.0



