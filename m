Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714222;
	b=dFms6N15kUpYjVQoGbm/e8e+qEP3mc1P9EiAH1G0yHXv1zl72nyqyPLyIy9jxcaFXXpt
	 WU3UpwcPafY9v76EBR9xRSKLfWxJLJbW/erNi4fCVusnWuqzOK54Ng5eZGBNDjH+RX+NB
	 MGjeYQSL3D8BCa8sjlfUNPAk+3xD9/CkZAVHdyKz6RIcnyrCSbvYYvsUqJ71E8d2xuwwK
	 X/kp32jqSzKSKmbA8n/blTnvNbIAaiwn8M5hfLc3r3ZdU8rYJ/vK9JSBkwdio1zXvJ1uI
	 Lv0ZS4BU6BQiLRnaTb1CyXlsYHb1/fUlSB7YXau86frhepiGu7aPrLbNutM5txFPh/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714222;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OIBSFohu5Q9kAcAnC9laJfzHMojn+bgUV5gqQvvzvDE=;
	b=Dv74quRfuLOtBL8fgpnZNCXdmVI2OA7Frx1ao2yCM0essXYjKF76He9PEqpp7QtPldES
	 a3RTWFcUXHOtYRuUNkthYUdOC3X4Ac5QvVgxMH/9i7PwfMqCSEI9I6wNxutiXZkcEoSsI
	 bmOyGtggMskaDt4VurHZlXWdC2l/uL44dGJlbkhGpZPenAzvy0VNBtTRS+S81LRIVMY4T
	 9q0AUD51aOjtoc89AXmt+2SdscuxxR4pPE+qd+oZwcoONXcS9g5PE/P3JktGY4PEEusju
	 J72H75qdEPOCdV/OY1tXVlYIdxhciPQnj0J2qQ9X+s9gTTgW7NvBiBp9ZGEMJzkh6xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=hxAUwxzo;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8651606A319;
	Fri, 23 Oct 2026 00:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8651606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=hxAUwxzo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=OIBSFohu5Q9kAcAnC9laJfzHMojn+bgUV5gqQvvzvDE=; b=hxAUwxzoqFCv
	ScpuTX+tzy5eaos1xz/buQ5KYzMoTTdMH3AblIpthF8so7MjibU28tsJo3SOMBBTCG8Zy/zZyJKie
	Isn0goM3Iu9oQSq+AW8N6+gS/YWcQT8W71NE3EfajpydxL1GH2CgMhxMztRaOvSXIxZTaJcvhOfjL
	ERafw+5kPMuhP9l+RlcRV4Pp2VIliggvfM/2naC/C++3AjEFLmgebmunhFLYEpQcMflVStDlpWQhB
	3lmTIlmT/whs3NExc7VlEQICDZJrHzcn8V/aKmg/++02SLMGuf+6JJ+Z8ylJUDN7cME4IGwlBLPSb
	MPAMeaBhlt4UeKdmpo6dWg==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xK2nX-009rzx-1a;
	Fri, 23 Oct 2026 02:09:58 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	syzbot+c6c86a1c56b5131f2d97@syzkaller.appspotmail.com,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	netdev@vger.kernel.org
Subject: [PATCH] net: fix self-deadlock when an upper disables a feature of its lower
Date: Fri, 23 Oct 2026 03:09:36 +0300
Message-ID: <20261023000951.237641-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.56.0
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

When an upper device ends up without a NETIF_F_UPPER_DISABLES feature
(LRO) that its lower device has, netdev_sync_lower_features() disables
it on the lower device, taking the lower's instance lock since commit
af5f54b0ef9e ("net: Lock lower level devices when updating features").

Upper devices recompute their features in response to NETDEV_FEAT_CHANGE
of the lower device, and for ops locked devices that notification is
sent with the lower's instance lock held, e.g. from ethtool. The task
then blocks on the lock it already holds:

  dev_ethtool()                        takes lower's instance lock
    netdev_features_change(lower)
      <upper>_device_event()
        netdev_update_features(upper)
          netdev_sync_lower_features()
            netdev_lock_ops(lower)     deadlock

Triggered by enabling mlx5 LRO on a host with VM macvtaps on top of it:

  INFO: task ethtool:5963 blocked for more than 122 seconds.
  Call Trace:
   __mutex_lock.constprop.0
   __netdev_update_features
   netdev_update_features
   macvlan_device_event
   notifier_call_chain
   netdev_features_change
   ethnl_set_features
  INFO: task ethtool:5963 is blocked on a mutex likely owned by task ethtool:5963.

Reproduced with these upper device configurations, and netdevsim as the
ops-locked lower device.

 - macsec with LRO in hw_features, but masked by macsec_fix_features().
 - macvtap without LRO enabled via TUNSETOFFLOAD.
 - macvlan, bond or team enslaved to a VRF or batman-adv device.

There is no way to tell whether the current task owns the lower instance
lock. Try to take it, and otherwise leave the job to netdev_work, which
disables the features the uppers lack under the lower's instance lock.
In the deadlock case above, the lock holder is the context that sent
NETDEV_FEAT_CHANGE, so steal the pending work at the end of
netdev_features_change() and run it inline, like netif_rx_mode_sync()
does for rx_mode. The lower device's features are then consistent with
its uppers when the operation returns, as before. The work only runs
asynchronously if an unrelated task held the lock.

Tested in QEMU with lockdep enabled. The stacks above hang without this
patch, and with it the features end up disabled on the lower device
without lockdep reports.

Stacks with bridge, bond, team, ipvlan and VLAN on top of netdevsim
behave as before: these call dev_disable_lro() on their ports.

Fixes: af5f54b0ef9e ("net: Lock lower level devices when updating features")
Reported-by: syzbot+c6c86a1c56b5131f2d97@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a6be82b.77639fcc.3d4fd0.0014.GAE@google.com/
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 net/core/dev.c         | 39 ++++++++++++++++++++++++++++++++++++++-
 net/core/dev.h         |  3 +++
 net/core/netdev_work.c |  2 ++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360..d3945140766f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1610,6 +1610,12 @@ int dev_get_alias(const struct net_device *dev, char *name, size_t len)
 void netdev_features_change(struct net_device *dev)
 {
 	call_netdevice_notifiers(NETDEV_FEAT_CHANGE, dev);
+
+	/* Uppers reacting to the notification couldn't take our instance
+	 * lock to disable features they lack, do it now.
+	 */
+	if (__netdev_work_core_cancel(dev, NETDEV_WORK_SYNC_UPPERS))
+		netif_sync_upper_disables(dev);
 }
 EXPORT_SYMBOL(netdev_features_change);
 
@@ -10968,6 +10974,28 @@ static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
 	return features;
 }
 
+/* Disable the features of @dev which any of its upper devices has disabled,
+ * deferred from netdev_sync_lower_features().
+ */
+void netif_sync_upper_disables(struct net_device *dev)
+{
+	netdev_features_t disable = 0;
+	struct net_device *upper;
+	struct list_head *iter;
+
+	netdev_for_each_upper_dev_rcu(dev, upper, iter)
+		disable |= ~upper->features;
+	disable &= NETIF_F_UPPER_DISABLES & dev->features;
+	if (!disable)
+		return;
+
+	dev->wanted_features &= ~disable;
+	netdev_update_features(dev);
+
+	if (unlikely(dev->features & disable))
+		netdev_WARN(dev, "failed to disable %pNF!\n", &disable);
+}
+
 static void netdev_sync_lower_features(struct net_device *upper,
 	struct net_device *lower, netdev_features_t features)
 {
@@ -10980,7 +11008,16 @@ static void netdev_sync_lower_features(struct net_device *upper,
 		if (!(features & feature) && (lower->features & feature)) {
 			netdev_dbg(upper, "Disabling feature %pNF on lower dev %s.\n",
 				   &feature, lower->name);
-			netdev_lock_ops(lower);
+			/* The caller may hold the lower's instance lock already,
+			 * e.g. when the upper reacts to NETDEV_FEAT_CHANGE of
+			 * the lower. Don't wait for it, let netdev_work disable
+			 * the feature instead.
+			 */
+			if (netdev_need_ops_lock(lower) && !netdev_trylock(lower)) {
+				__netdev_work_core_sched(lower,
+							 NETDEV_WORK_SYNC_UPPERS);
+				continue;
+			}
 			lower->wanted_features &= ~feature;
 			__netdev_update_features(lower);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 04fb0e9a571e..c3d9d66bfb5b 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -174,8 +174,11 @@ void netif_rx_mode_cancel_retry(struct net_device *dev);
 /* Events for the async netdev work, tracked in netdev->work_core_pending. */
 enum netdev_work_core {
 	NETDEV_WORK_RX_MODE	= BIT(0),	/* run the rx_mode update */
+	NETDEV_WORK_SYNC_UPPERS	= BIT(1),	/* disable features uppers lack */
 };
 
+void netif_sync_upper_disables(struct net_device *dev);
+
 void __netdev_work_core_sched(struct net_device *dev, unsigned long event);
 unsigned long
 __netdev_work_core_cancel(struct net_device *dev, unsigned long mask);
diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
index e721a06d58df..5a608ba40389 100644
--- a/net/core/netdev_work.c
+++ b/net/core/netdev_work.c
@@ -123,6 +123,8 @@ static void netdev_work_run(struct net_device *dev, unsigned long events,
 
 	if (core & NETDEV_WORK_RX_MODE)
 		netif_rx_mode_run(dev);
+	if (core & NETDEV_WORK_SYNC_UPPERS)
+		netif_sync_upper_disables(dev);
 	if (events && dev->netdev_ops->ndo_work)
 		dev->netdev_ops->ndo_work(dev, events);
 }
-- 
2.56.0

