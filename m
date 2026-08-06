Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059837F312
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983305; cv=none; b=Y/FVpnp0Hz2+nwlOpg7rPoNzKWhqpr2jPBOiFt6OB4xH4QhxuItsgv3+J6gEaxooYD7EXsKUYjiwZBQ9NGXSeTomqXgBDy3BZgPhlQGqThyOynWeO1lDJH2mqQxM+0Po43bmZI130CzyiTe7WOcovew1CwysF2Y0vhqD8lCd1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983305; c=relaxed/simple;
	bh=EPuS4F7JlxgoaqYuV/14IldhH9XtZsdXOwjC0bk7440=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNH6PpkDRSrYhbXcxNMHkGphSQBcQzJNANKVkoduH+VlSRZa0Yyb24al74/i400q4/iliXrE+HLPSSVqhMpzguXvEYP/akF5S+0H2YctLo+99so/uYPLz+fEiODSJNKkdFcrM+YtA5t5jm1BkdD4U4Z6Le2Fj2hsFO9KdyK/Bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieCP6mdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieCP6mdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07181F000E9;
	Thu,  6 Aug 2026 02:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983304;
	bh=4cKUdmnZ4ppx+2Ind2nhuOT3zmI7AKm8kYtes8dldic=;
	h=From:To:Cc:Subject:Date;
	b=ieCP6mdb9AC4OuchyXfxl5ZqEp7nxp1+8Q1lpZrx4mKCGSUCH7pzvEdSWndag/Bkq
	 NSmYDevPuVkJMkAJTijdWnqtYSGI8MIs65BFSejP6LO9h41V0B8m2Shy16RipvmSxF
	 31g+que5twzHed6sR7Fsrhz6w/N8X+GX0jAzcsIO8kDe5WDJg2lt4njhAWu3nvfvs8
	 pS9uFu4sq9SPfyJNZu8poiQ9p0w0X1Huifi5E2ST531IokkBASlcVqgmufmg2L+mwZ
	 D5WDA4Dkp/wtzJEDWxHX5pilEAn0gu8N37eFfse2oQb/WW95LoDQ2JWyLamjT+4lBZ
	 +IykZ1zNM5CyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH net] net: avoid theoretical races with ref drain
Date: Wed,  5 Aug 2026 19:28:21 -0700
Message-ID: <20260806022821.2079945-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Technically, it's illegal to take a ref on a netdev just because
we have a pointer on which we already hold a ref, with no other
protection. This is because our simple per-cpu refcount
implementation cannot atomically read the count.

Let's make sure we cancel outstanding work and never queue more
work for a device we know is dead. This way taking a ref on
a dev we know is on the netdev_work_list is always going to be safe.

Jiangshan Yi reports that the issues is caught by ref tracker infra
leading to a warning:
  WARNING: lib/ref_tracker.c:322 at ref_tracker_free
  WARNING: lib/ref_tracker.c:246 at ref_tracker_dir_exit

Reported-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Link: https://lore.kernel.org/20260731035135.3917308-2-yijiangshan@kylinos.cn
Fixes: 12c765be84d2 ("net: turn the rx_mode work into a generic netdev_work facility")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.h         |  1 +
 net/core/dev.c         |  1 +
 net/core/netdev_work.c | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/net/core/dev.h b/net/core/dev.h
index 5d0b0305d3ba..b757faead4d1 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -179,6 +179,7 @@ enum netdev_work_core {
 void __netdev_work_core_sched(struct net_device *dev, unsigned long event);
 unsigned long
 __netdev_work_core_cancel(struct net_device *dev, unsigned long mask);
+void netdev_work_cancel_all(struct net_device *dev);
 
 void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 			unsigned int gchanges, u32 portid,
diff --git a/net/core/dev.c b/net/core/dev.c
index e50ed677de72..fca25797eeec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12478,6 +12478,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_tcx_uninstall(dev);
 		dev_xdp_uninstall(dev);
 		dev_memory_provider_uninstall(dev);
+		netdev_work_cancel_all(dev);
 		netdev_unlock_ops(dev);
 		bpf_dev_bound_netdev_unregister(dev);
 
diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
index 3109fae132ad..e721a06d58df 100644
--- a/net/core/netdev_work.c
+++ b/net/core/netdev_work.c
@@ -31,6 +31,10 @@ static void netdev_work_enqueue(struct net_device *dev, unsigned long events,
 		return;
 
 	spin_lock_bh(&netdev_work_lock);
+	if (!dev_isalive(dev)) {
+		spin_unlock_bh(&netdev_work_lock);
+		return;
+	}
 	if (list_empty(&dev->work_node)) {
 		list_add_tail(&dev->work_node, &netdev_work_list);
 		netdev_hold(dev, &dev->work_tracker, GFP_ATOMIC);
@@ -61,6 +65,18 @@ netdev_work_dequeue(struct net_device *dev, unsigned long *pending,
 	return events;
 }
 
+void netdev_work_cancel_all(struct net_device *dev)
+{
+	spin_lock_bh(&netdev_work_lock);
+	dev->work_pending = 0;
+	dev->work_core_pending = 0;
+	if (!list_empty(&dev->work_node)) {
+		list_del_init(&dev->work_node);
+		netdev_put(dev, &dev->work_tracker);
+	}
+	spin_unlock_bh(&netdev_work_lock);
+}
+
 void netdev_work_sched(struct net_device *dev, unsigned long events)
 {
 	netdev_work_enqueue(dev, events, 0);
-- 
2.55.0

