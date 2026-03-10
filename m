Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7603D523C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166045; cv=none; b=Pzs4NOF3+Fcjnv3O2p+PfpNHzUhDpxAGuXQv2OUu3s5L8Vv2AriFnTAQCuxzM0K0ZIu1p9g5oDduJS8TsN6u5rJv4bJXJi99BH+oj4MIG7eDZQ7gEsHMBcSGJbkYONjDljtaAW2+jjVtc9jUic6Ixz3NaaWsu4JY6fwX/TkYL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166045; c=relaxed/simple;
	bh=wEGBvkQYMgUF8egWnBXey4Tc6zBz/jMQvlIIlTzqwEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQdUyn1dwThYVQi92AdPG6S+37uGezJIqNY/R4CvVcLnPS+o54oH0MnPQls1QlGh5tXJADbpG6xJZkdvZ+WOYrxyPEbq7fgZ1D6oVBNugO/G/I0lvhOc3GFvr6uJhd72iO4fF739UxHIP8Nkafb3vwnaJ0rASbr5YBYhAxrALzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZhQUhGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZhQUhGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773166042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItHa40O2/2EVwSij+ma5AQEvfIbQivE126r3/veGmPE=;
	b=hZhQUhGN27r7QEgRU8pqjMRn2k6QhP9mVZDEe6ngsO0BSvYCdJ8rrtFKtdQwxtZ40Dhgld
	xx1Dmya4RF1hHXpWFTCd58VwtmyhOH5WPoTP4SZEYqo4gbRer43m+pMcgE351mb5nz8uRw
	IWRjTBUIxdiV+x7oTt3GX3yjXZt8j80=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-DppmOQ0YPv26A4FD5HvLuw-1; Tue,
 10 Mar 2026 14:07:17 -0400
X-MC-Unique: DppmOQ0YPv26A4FD5HvLuw-1
X-Mimecast-MFC-AGG-ID: DppmOQ0YPv26A4FD5HvLuw_1773166036
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3A1F1956050;
	Tue, 10 Mar 2026 18:07:15 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.226])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA97B1955D71;
	Tue, 10 Mar 2026 18:07:12 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 3/4] netdevsim: support ETS qdisc offload
Date: Tue, 10 Mar 2026 19:06:30 +0100
Message-ID: <0e42bd00141bd0030d59e79cb2e86a8865d4ee0e.1773165520.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773165520.git.dcaratti@redhat.com>
References: <cover.1773165520.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Extend QDISC_OFFLOAD_HANDLERS() and TC_QDISC_SETUP_CASES() to add "fake"
offload for the 'ets' qdisc.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 drivers/net/netdevsim/tc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
index 358fa5bb835f..ce0a8e6a611a 100644
--- a/drivers/net/netdevsim/tc.c
+++ b/drivers/net/netdevsim/tc.c
@@ -2,6 +2,7 @@
 
 #include <linux/netdevice.h>
 #include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
 
 #include "netdevsim.h"
 
@@ -16,6 +17,8 @@ static LIST_HEAD(nsim_block_cb_list);
 #define QDISC_OFFLOAD_HANDLERS(X)					\
 	X(taprio, tc_taprio_qopt_offload, cmd, TAPRIO_CMD_REPLACE,	\
 	  TAPRIO_CMD_DESTROY, TAPRIO_CMD_STATS, stats)			\
+	X(ets, tc_ets_qopt_offload, command, TC_ETS_REPLACE, TC_ETS_DESTROY, \
+	  TC_ETS_STATS, stats)						\
 
 #define QH(NAME, OL_TYPE, CMD_FLD, O_REPLACE, O_DESTROY, O_STATS, STATS_FLD) \
 static int handle_##NAME(struct net_device *dev, struct OL_TYPE *offload) \
@@ -45,6 +48,7 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 	switch (type) {
 #define TC_QDISC_SETUP_CASES(X)						\
 	X(TC_SETUP_QDISC_TAPRIO, tc_taprio_qopt_offload, taprio)	\
+	X(TC_SETUP_QDISC_ETS, tc_ets_qopt_offload, ets)			\
 
 #define SC(SETUP_LABEL, OL_TYPE, NAME)					\
 	case SETUP_LABEL:						\
-- 
2.52.0

