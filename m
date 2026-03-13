Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349F40DFB7
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422672; cv=none; b=kMjjRdRF49qBkXWqrtRAfOQG+MLRVhn0zCLZLSSzynh3NpoYi5mGtPHizpKFj3sD7mryHX+DDZm80ZThrjcbWWz/Onk5aNXI2CPVd4zpFq/6NkXWVbqMomFDukm8rQV55fuTVYPwp4YuhkO9vFz28YEfVLxl0M2Gl6O+FBNTKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422672; c=relaxed/simple;
	bh=JqNyWM7p2vCYD9mgrJnuRA/fd5IaVRa1NeZJoJKh+hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9eM406Be+ca4+C2l9MOD9siYaAxe7Igp2rTL1zI+JXIiCFMMN233Q3BjusLYNYxusy8AJbQeiXRJcN4wsZpwoZTQR04vAZr+wHus1J4fh2UKR9hgZK8bIbVdJn0t9y9qb8DY+36BUy1V5ZJwHe+HAiYLbrpnsGTJzSn198sWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ip6I7PY4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ip6I7PY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773422670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFKQknAk0rDRa3+EK/FazM3WCJIecpHVAzOyuYpKR7E=;
	b=Ip6I7PY4xY1b28Yygk/z/McslTenBP/yi4Da/hIT0HdesKSTucOWKOvv5NqCXGrNsE5gfw
	lPDWFVV7FcMgH0a7XJtPHR8hnKn/maeZ0bddX42bpmnfUFegNPy+eULvwavZJniLmN1EJk
	tAxGvh9ZOj7V6b48CRmbe+WTneAiC2c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-WliL9pGeMV-Q3LZJxVDNPA-1; Fri,
 13 Mar 2026 13:24:26 -0400
X-MC-Unique: WliL9pGeMV-Q3LZJxVDNPA-1
X-Mimecast-MFC-AGG-ID: WliL9pGeMV-Q3LZJxVDNPA_1773422665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47FE619560B7;
	Fri, 13 Mar 2026 17:24:25 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.226])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07A9A19560B7;
	Fri, 13 Mar 2026 17:24:21 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/3] netdevsim: support tc-ets offload
Date: Fri, 13 Mar 2026 18:23:57 +0100
Message-ID: <ab67b0e2f8d7718aacc0faae75d89454ebfcf352.1773411667.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773411667.git.dcaratti@redhat.com>
References: <cover.1773411667.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Extend netdevsim to accept ndo_setup_tc(TC_SETUP_QDISC_ETS) calls, so that
it's possible to run tdc on ETS offload code path.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 drivers/net/netdevsim/tc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
index 8a1960f5f99e..8f013a5895a2 100644
--- a/drivers/net/netdevsim/tc.c
+++ b/drivers/net/netdevsim/tc.c
@@ -2,6 +2,7 @@
 
 #include <linux/netdevice.h>
 #include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
 
 #include "netdevsim.h"
 
@@ -36,6 +37,25 @@ static int nsim_setup_tc_taprio(struct net_device *dev,
 	return err;
 }
 
+static int nsim_setup_tc_ets(struct net_device *dev,
+			     struct tc_ets_qopt_offload *offload)
+{
+	int err = 0;
+
+	switch (offload->command) {
+	case TC_ETS_REPLACE:
+	case TC_ETS_DESTROY:
+		break;
+	case TC_ETS_STATS:
+		_bstats_update(offload->stats.bstats, 0, 0);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 static LIST_HEAD(nsim_block_cb_list);
 
 int
@@ -46,6 +66,8 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 	switch (type) {
 	case TC_SETUP_QDISC_TAPRIO:
 		return nsim_setup_tc_taprio(dev, type_data);
+	case TC_SETUP_QDISC_ETS:
+		return nsim_setup_tc_ets(dev, type_data);
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &nsim_block_cb_list,
-- 
2.52.0

