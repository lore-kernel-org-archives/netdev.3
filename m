Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ADA525A6D;
	Tue, 29 Sep 2026 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708386; cv=none; b=oRce02x/P97f53RYczGuZbQJZURfRYUzHYlOfuIfhS4CpqzR9ikIW9B6eJ9/8UYkIoqFhRvwYNY+B03rKrkJVOY+phHog86ApkVq+8AK5jhsvr75rxkGkSv50HKs+itMkmej8yteN8V6uJZOi4YIFjochN11WeYczB/Iz4cn5D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708386; c=relaxed/simple;
	bh=T7M606s5vldyC2gZPIBAKuihIjTz0Boam0DAU4ulpXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JwryDI/rYLZ50JOOaUpOkjMVDoj0KtnITrHvyWqOZy7i3svxxIFtL8ijv9v2nBsdDPZaLdlOcz30Yh3x3anBQm5TVSF+L0vm1DPUqnqgZFEZ16qpmGmk+g4Ro5dI0hf2NhvYH+eYJPcSxnLdqRMgauAmCly+AvqMfkmI0M+KRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=e1mXWbln; arc=none smtp.client-ip=173.37.86.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="e1mXWbln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2537; q=dns/txt;
  s=iport01; t=1790708384; x=1791917984;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=R4hPtRfaWDKfBwbUfI7yvomeCyTu6BIrnCEYPK06b7A=;
  b=e1mXWblndxXdtT6X1QgR8iS6ppFm3fYM7nHAWkm6lIAnt6+Gnv78wYAH
   E8CnehcTj+sRhgbQ/aJZIIZuWvb9hcO3yvAOAJqLWlZ8QJL3yWofqdQJ+
   KaR1ON4h19qnjiSSqiLJccxksjBDmKCB7GVpQlNJ0H2njGBLdjLaIZ8JH
   +5i5tfPIS8SGBGk0yhOQyhrqmLbaTRB9vXJUl5ES5GiL5o7JlfHRz+1Rf
   yfaq865W1xhXS6q+PDK0SSobcmIicvj1Cm4x9oGqIqFXiJjVrHzUuBkrb
   sMRuV1JqyBU/UrkZd5K1B0yfeGAWEPp36hxHtx5kaYWyzlKourQx+M9ji
   g==;
X-CSE-ConnectionGUID: RV/ookTAQBuXv0Vc1c+lKg==
X-CSE-MsgGUID: BkaOsKKESdumIJkF+k5ybg==
X-IPAS-Result: =?us-ascii?q?A0BGAgDCCbxq/4v/Ja1aglmCGD+BVUNJhFePUoIhmD+FX?=
 =?us-ascii?q?hSBag8BAQEPUQQBAYUFAo4IAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZckBMCAQMjVhAlAiYCAkYQBgESgwKCdQPBQXqBMoEBhH7ZS?=
 =?us-ascii?q?oFoAQsUAYEKLoVygm0BgXGECDuEQScbgUlEgRWDaYQqg3SCagSDHBKCXZJLC?=
 =?us-ascii?q?T+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQdEg8EFjIdcAwnEiwXL1gbB?=
 =?us-ascii?q?gWBHXUUBBOCGSMZNnqBCV6BKylgARAXgQeCBwKCVIIAAgFJQQ4HRVMJJUUSR?=
 =?us-ascii?q?yYiCBIJARMaMAuBGzg+CSg9GA1IESw3Bg8ZBD0BbgeQNx6BbmACEIEPJVqBF?=
 =?us-ascii?q?FWTQoNZjV9roQ+EKIFmoBAzhASTY5MILodmkHQjgjaiAYRpgWg8gVkzGggbF?=
 =?us-ascii?q?TuCZ1MZD44uFoEUAQGSBwG8eycyPgEHAgcPAoFzkX4BAQ?=
IronPort-Data: A9a23:uYNmMK32SiT62Qz7OfbD5QFwkn2cJEfYwER7XKvMYLTBsI5bp2AOz
 2oaCmnSOKuPYzCgftxwPITl9U1X6pPSzNU1Twdv3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4Ej9atANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 rsen+WFYAX7g28uYzpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGNn9xOoobxs9OK3x+6
 6QmI2kGLRSgiLfjqF67YrEEasULNsLnOsYb/3pn1zycVaxgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNU+RC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+OW3aYKOIYTbHq25mG6yp
 Wvh5EfaLyoWKdm+6zmrsXHxl+XAyHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0EY5y8nv6Uu3EOsSdb5Uluzp3vslh4bQd9LO+438geAzuzT+QnxLmsZRDdpa9E8ssIyAzsw2
 TehltXlHzFw87uYVX6Q6J+QsDW0fyMVRUcabCUJSwot+dTvoIgvyBnIS75LFK+zk82wGjzqx
 T2OhDYxiq9VjsMR0ai/u1fdjFqEoJXVQgMrzhvYU3jj7Q5jYoOhIYuy5jDmAe1oNo2VSByF+
 XMDgcXbtLpIBpCWnyvLS+IIdF2028u43PTnqQYHN/EcG/6FohZPoag4DOlCGXpU
IronPort-HdrOrdr: A9a23:mgD7NqANun34jWnlHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: 9a23:izqebm3e1AqDDfe3kZbSHbxfIP5idXre8F7pCVKIFz5XQ+SeCluz9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AJagU9g6H/0qalRTDcMlfSWafxoxC4K2JE2MuvK4?=
 =?us-ascii?q?KpsylFy9eeDTAnT64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,130,1787011200"; 
   d="scan'208";a="521033093"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Sep 2026 18:58:36 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 420DF180000F5;
	Tue, 29 Sep 2026 18:58:35 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 29 Sep 2026 11:58:04 -0700
Subject: [PATCH net-next v2 1/6] net: add netif_rx_mode_schedule_update()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-1-5962c10061b2@cisco.com>
References: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
In-Reply-To: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790708314; l=2543;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=T7M606s5vldyC2gZPIBAKuihIjTz0Boam0DAU4ulpXE=;
 b=uSiMYct1ywXgKUSiME2K1srBST+tvDUqsQdi7iXM8d0JInCzM2JCKu7l+ci3N7kmEm/ehbYnr
 v9o/WtYCcjpCoFkLQ4sSez2X2t3CR/btRKCX07ccVGPHJQ7nhHyxe2R
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-02.cisco.com

Add a receive-mode scheduling helper for callers which start a new update
after a state transition. Cancel a pending retry and reset its backoff
before queueing the immediate update so the preceding operation's retry
state cannot shorten the new operation's bounded retry sequence.

The helper preserves address-list synchronization state. Callers which need
to replay configuration lost by the device must unsynchronize the affected
address lists before scheduling the update.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev_addr_lists.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5d16737167ee..c1807a8f733b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5197,6 +5197,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
+void netif_rx_mode_schedule_update(struct net_device *dev);
 void netif_rx_mode_schedule_retry(struct net_device *dev);
 int netif_set_promiscuity(struct net_device *dev, int inc);
 int dev_set_promiscuity(struct net_device *dev, int inc);
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 08528ca0a8b3..17770a38b5ab 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1337,6 +1337,27 @@ static void netif_rx_mode_queue(struct net_device *dev)
 	__netdev_work_core_sched(dev, NETDEV_WORK_RX_MODE);
 }
 
+/**
+ * netif_rx_mode_schedule_update() - schedule a new receive-mode update
+ * @dev: network device
+ *
+ * Cancel any pending retry and reset its backoff before scheduling an
+ * immediate receive-mode update. This does not reset address-list
+ * synchronization state. Callers which need to replay lost device state must
+ * unsynchronize the affected address lists before scheduling the update.
+ *
+ * Context: sleepable. The caller must hold the device operations lock, or
+ * RTNL for a device which still uses RTNL-compatible operations.
+ */
+void netif_rx_mode_schedule_update(struct net_device *dev)
+{
+	might_sleep();
+	netdev_assert_locked_ops_compat(dev);
+	netif_rx_mode_cancel_retry(dev);
+	netif_rx_mode_queue(dev);
+}
+EXPORT_SYMBOL_GPL(netif_rx_mode_schedule_update);
+
 static void netif_rx_mode_retry(struct timer_list *t)
 {
 	struct net_device *dev =

-- 
2.43.0

