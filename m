Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792817388;
	b=IIWE8LFLoC1HeIF/S/uPMnHInmwfB3MBD2UnlFMFnBgwt2NHquG81SdpVuJCIDswZoDw
	 4TOEpbHozeCLgxyCYJmyPgBdjNmQFyrRSCyOe9Tw3+xGyItxsvvCq//6VVavjYGu+Fo/6
	 38riB7QoP8DqkBmxFT0BE+qyny7T6UVVREIbhe4hpGsZfS4KP+xbz4gRgO/30/eGAJOzL
	 +tbI/cjXcE+HSbLtlbyYoEYUgICcZa3cz416+QwLMFtZA2wrvLbLhYKg+/sxreOMH+Q/9
	 h6twM0HhISbEDay+bvLBBhPBH9kYHegFoTxWcX3x+j/C6GZ7N9XOS26jrWK9DeBS3Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792817388;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=nbpqjlesvT1Wv4sjUPG1VGTnR0m0XWWmAt2W5g0+KvA=;
	b=RqFMGUvz24U9uPkr/B2Myf5u33mnETg+uzLWNDIt8Col+V0MQDbmWFZJgUT1Ksyu8KAO
	 3eUMIjvlPT8qYV//JGn0+bxnkQlH4UIqJ5wMwrhtskfRPTn323IH3v2nK9/CMFfr64KTG
	 8YS5SNoh10xIUAOgW1dvWWEYUpeQxnfAD5svcvISBqSPa0ocLger0nEpX+lBdPbopHBvF
	 vSPqaULt7KGgygQcMSJaul6k5/zsywuBFqfIWNa2d6hPp9yHfLB4/WI7WwcLJRWxrDFR1
	 BJl0byIHumE+CTlqFMjA1tOE9xLhgKNHY0xLbvbHr6cjiftsbUCb0THHPRhBtO3elog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=etVbqwej;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E469606A31A;
	Sat, 24 Oct 2026 04:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E469606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=etVbqwej
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nb
	pqjlesvT1Wv4sjUPG1VGTnR0m0XWWmAt2W5g0+KvA=; b=etVbqwej0Zw+GiYEYn
	3YjgOzY7GRYhH0/4HU3HgvV2bGY77WWIGZ+RdVowROEY5Q41VqzUcPMBvaf8JfnG
	UfgdFfPKEVC2xKUxpxuCD4zA3/jGBvsZWcasqHoXsWMxntVTEYTwij82LOYOiJ7k
	MXswVDxJ1kxqANg1Sv2gpEyZQ=
Received: from flipped.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCH153AONxqc+zrBg--.26204S2;
	Sat, 24 Oct 2026 12:49:05 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Louis Peens <louis.peens@corigine.com>,
	Hui Zhou <hui.zhou@corigine.com>,
	oss-drivers@corigine.com,
	linux-kernel@vger.kernel.org,
	Sicong Huang <congei42@163.com>
Subject: [PATCH net] nfp: flower: fix use-after-free in neighbour update work
Date: Sat, 24 Oct 2026 12:49:03 +0800
Message-Id: <20261024044903.1130380-1-congei42@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCH153AONxqc+zrBg--.26204S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr1UAry8Gw1kGrWUKw45ZFb_yoW7WrW7pa
	y5K3y8CFWktw15W398Z3WUZF13K3W8K3W5CF1xCw1Y9an0q3y2kFWDKFyjk3WrArZ5G34F
	yrWFkF1fA3s8trUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMKZXUUUUUU=
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbC0wEQA2rcOMHg9QAA3b

The netevent notifier handles neighbour updates and redirects by
queuing nfp_tun_neigh_update() on system_highpri_wq. Each work item
holds a reference to the neighbour, but only stores a pointer to the
flower app.

During device removal, nfp_tunnel_config_stop() unregisters the
notifier. This waits for notifier callbacks to return, but does not
wait for the work they queued. The teardown then frees app->priv and
app without waiting for these work items. Flushing cmsg_work in
nfp_flower_clean() does not cover the neighbour update work.

A pending work item can therefore run after the app has been freed.
Its call to nfp_flower_get_port_id_from_netdev() can then access freed
memory while checking whether the neighbour's device can be offloaded.
Even notifications for unrelated devices can reach this check. The
same problem affects shutdown and probe error paths that tear down the
app after the netevent notifier has been registered.

One possible interleaving is shown below. The neighbour belongs to
another network device that remains registered.

  CPU0 (remove)                   CPU1 (notifier / kworker)
                                  nfp_tun_neigh_event_handler()
                                    queue_work(system_highpri_wq, ...)
                                    return
                                  /* Work has not run yet. */
  nfp_tunnel_config_stop()
    unregister_netevent_notifier()
    /* Notifier callbacks have finished, but work may be pending. */
  nfp_flower_clean()
    vfree(app->priv)
    app->priv = NULL
  nfp_app_free()
    kfree(app)
                                  nfp_tun_neigh_update()
                                    app = update_work->app
                                    nfp_flower_get_port_id_from_netdev()
                                      app->priv  /* use-after-free */

The work items are allocated per event and free themselves, so they
cannot be cancelled individually, and flushing system_highpri_wq is
not allowed. Use a dedicated workqueue for neighbour updates instead.
In nfp_tunnel_config_stop(), unregister the notifier and destroy the
workqueue before cleaning up the tunnel state. This prevents new work
from being queued and waits for pending and running work to finish
while the app and its resources are still valid.

Found by code inspection.

Fixes: 0ad722bd9ee3 ("nfp: flower: fix for take a mutex lock in soft irq context and rcu lock")
Signed-off-by: Sicong Huang <congei42@163.com>
---
 .../net/ethernet/netronome/nfp/flower/main.h  |  2 ++
 .../netronome/nfp/flower/tunnel_conf.c        | 24 ++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.h b/drivers/net/ethernet/netronome/nfp/flower/main.h
index 2b7c947ff4f2..bd4399758ed4 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -94,6 +94,7 @@ struct nfp_fl_stats_id {
  * @ipv6_off_lock:	Lock for the IPv6 address list
  * @mac_off_ids:	IDA to manage id assignment for offloaded MACs
  * @neigh_nb:		Notifier to monitor neighbour state
+ * @neigh_wq:		Workqueue for neighbour updates
  */
 struct nfp_fl_tunnel_offloads {
 	struct rhashtable offloaded_macs;
@@ -103,6 +104,7 @@ struct nfp_fl_tunnel_offloads {
 	struct mutex ipv6_off_lock;
 	struct ida mac_off_ids;
 	struct notifier_block neigh_nb;
+	struct workqueue_struct *neigh_wq;
 };
 
 /**
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 3b47e9fe64e1..46b6cda7f3d3 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -736,7 +736,7 @@ nfp_tun_neigh_event_handler(struct notifier_block *nb, unsigned long event,
 	if (!update_work)
 		return NOTIFY_DONE;
 
-	queue_work(system_highpri_wq, &update_work->work);
+	queue_work(app_priv->tun.neigh_wq, &update_work->work);
 
 	return NOTIFY_DONE;
 }
@@ -1509,6 +1509,13 @@ int nfp_tunnel_config_start(struct nfp_app *app)
 	if (err)
 		return err;
 
+	priv->tun.neigh_wq = alloc_workqueue("nfp-flower-neigh",
+					     WQ_HIGHPRI | WQ_PERCPU, 0);
+	if (!priv->tun.neigh_wq) {
+		err = -ENOMEM;
+		goto err_free_macs;
+	}
+
 	ida_init(&priv->tun.mac_off_ids);
 
 	/* Initialise priv data for IPv4/v6 offloading. */
@@ -1521,13 +1528,17 @@ int nfp_tunnel_config_start(struct nfp_app *app)
 	priv->tun.neigh_nb.notifier_call = nfp_tun_neigh_event_handler;
 
 	err = register_netevent_notifier(&priv->tun.neigh_nb);
-	if (err) {
-		rhashtable_free_and_destroy(&priv->tun.offloaded_macs,
-					    nfp_check_rhashtable_empty, NULL);
-		return err;
-	}
+	if (err)
+		goto err_destroy_neigh_wq;
 
 	return 0;
+
+err_destroy_neigh_wq:
+	destroy_workqueue(priv->tun.neigh_wq);
+err_free_macs:
+	rhashtable_free_and_destroy(&priv->tun.offloaded_macs,
+				    nfp_check_rhashtable_empty, NULL);
+	return err;
 }
 
 void nfp_tunnel_config_stop(struct nfp_app *app)
@@ -1537,6 +1548,7 @@ void nfp_tunnel_config_stop(struct nfp_app *app)
 	struct list_head *ptr, *storage;
 
 	unregister_netevent_notifier(&priv->tun.neigh_nb);
+	destroy_workqueue(priv->tun.neigh_wq);
 
 	ida_destroy(&priv->tun.mac_off_ids);
 

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.34.1

