Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113039;
	b=0GS4Q/1sEKDmO9yv0gtiBB8A5ZbdMZ8z1O9NevoeSxqQMwxT2iMzkvrjMK9sqcxKUbdU
	 aj6kfv5PD+Ut+Zpb4u5cg28XOL8xcaX5A/c75B1+rIO7BRcpo2rHezqraOCmwCVENG/hH
	 WbZrYPjO8O+4sgxpGAbXz+zy3iLbmc6H5qE7/ta+G/dr82XGuRIT09plFsSYpg5/caMgg
	 +c8PiNcamOMkdUjQd+xckIOm+h9vk2wKn415Z6LkZsH9AC9ifxPSwNVURBZS0yvfQuW5M
	 lC1Dk7dW2smfdayqieOhnbheXKdAumaPaKBaAjHDbo7Z7/MZSy47DYGA0ASQui2VCJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113039;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Bvj+VEfapM0R1/crUGbkmB9nlGglctmeDzltg5vYsMA=;
	b=RbwxOaJ/3XhDWeRCCKWo9wDKZ2z+rAQgv4YEj90g4dO5jXM5JVS3xqgauQSWS1Q36bG6
	 uYezewISXArKFzcMEb+GMAYFiXETJZkNUSEN4gUH93mP0NaXB6nhegPcqc3fG+RDwxtB2
	 FpoL5v0UrF3L0sN2/y+9Ay5tcMxI1lHvdL8nqAUvK0j7m5+++RhggWo9JOEaotkQWkaFX
	 frGdiagKblKMUh5sutGb5K8dsHwLsecmHqlejVjoGhNOLr+JAwGojckZs0+aI+0X7eyoz
	 ATMIZJNNrBf8I4dB5L386jGqjhhrr+hWYAneV9W8bOAO9OcyeHJfV4g97+8VwnVCVmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=tN3fofTP;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508F606A31A;
	Tue, 27 Oct 2026 14:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8508F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=tN3fofTP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=Bvj+VEfapM0R1/crUGbkmB9nlGglctmeDzltg5vYsMA=; b=tN3fofTPUpWv
	F8Dlif9CUns04hM+TM7EQoSaI6bJcsPiSZikR2ecvNpMzU/zZRQPnJmxkaXZW55Pxt2/dBshLpoQE
	ouZCooicxEuxwGhRRivxVyzyjXtvAQaIeiKb0/vnOjIGEX6zGWQ+MbLnEaJQkgUw4dMZ0arC/xVLG
	uLuFkAoDJCJDL/IKueDX/KkujoKlkoFEPJwTkSA8UIhtPaI7DSSp1T2FNjZxlIQVtIlfJbfBgOsEw
	4kfqckP9m+IQrvh5309YOhxPl8Pn25wzU8mcv40bA8WEEQGCc2eEDQFoJRWHjBXwjL5U27Fq81IZr
	7P6BaOha4H+mbxb1yC6x6g==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xLiXw-00FAir-2k;
	Tue, 27 Oct 2026 15:56:47 +0100
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org,
	syzbot+c6c86a1c56b5131f2d97@syzkaller.appspotmail.com,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	netdev@vger.kernel.org
Subject: [PATCH net v2] net: fix self-deadlock when an upper disables a feature of its lower
Date: Tue, 27 Oct 2026 16:00:49 +0200
Message-ID: <20261027140121.1192299-1-eva.kurchatova@virtuozzo.com>
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

Changes in v2:
- Send no NETDEV_FEAT_CHANGE when disabling the feature fails, the upper
  deferred the job again and the recursion overflowed the stack.
- Run the deferred job on a detached device too, instead of dropping it:
  before the patch the caller waited for the lock and then disabled the
  feature regardless of the presence.
- Correct the kernel-doc of netdev_features_change() that it may disable
  features, and explain its locking.

Link to v1: https://lore.kernel.org/netdev/20261023000951.237641-1-eva.kurchatova@virtuozzo.com/

 net/core/dev.c         | 47 ++++++++++++++++++++++++++++++++++++++++--
 net/core/dev.h         |  3 +++
 net/core/netdev_work.c |  4 ++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360..853e34d5765e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1605,11 +1605,20 @@ int dev_get_alias(const struct net_device *dev, char *name, size_t len)
  *	netdev_features_change - device changes features
  *	@dev: device to cause notification
  *
- *	Called to indicate a device has changed features.
+ *	Called to indicate a device has changed features. Also disables the
+ *	features which upper devices of @dev have off and could not disable
+ *	on @dev while its instance lock was held, so the caller must hold
+ *	RTNL and, for an ops locked @dev, its instance lock.
  */
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
 
@@ -10968,6 +10977,31 @@ static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
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
+	__netdev_update_features(dev);
+
+	/* Notifying a failure would make the uppers defer this again */
+	if (unlikely(dev->features & disable))
+		netdev_WARN(dev, "failed to disable %pNF!\n", &disable);
+	else
+		netdev_features_change(dev);
+}
+
 static void netdev_sync_lower_features(struct net_device *upper,
 	struct net_device *lower, netdev_features_t features)
 {
@@ -10980,7 +11014,16 @@ static void netdev_sync_lower_features(struct net_device *upper,
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
index e721a06d58df..097c9535845b 100644
--- a/net/core/netdev_work.c
+++ b/net/core/netdev_work.c
@@ -118,6 +118,10 @@ __netdev_work_core_cancel(struct net_device *dev, unsigned long mask)
 static void netdev_work_run(struct net_device *dev, unsigned long events,
 			    unsigned long core)
 {
+	/* Not gated on presence: the caller used to wait only for the lock */
+	if (core & NETDEV_WORK_SYNC_UPPERS)
+		netif_sync_upper_disables(dev);
+
 	if (!netif_device_present(dev))
 		return;
 
-- 
2.56.0

