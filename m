Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253732;
	b=ewBzTc5jmdKIgF1ADvAY1AW7dbWbsiivXuRHSaaZpKdHP25EUBof6f061rTOIYIi+VYH
	 sGMqc1e63mqXsQjOVspvf63pvzcA12Mq/QtLSVwp4SxWvuj61TJmbblPDRThIyYxinK8y
	 ggYd/kjPWo+8GmPzwby5ED9L72xuqBNj931XcmJyN5O6feHsjEMpwX9MlmcsQ+SmkJYdM
	 qtob0bH7aNwHlrBzFkwHxj9mydTUCR2WVI3Jyy0CuxRW3cuTLbXU2vSDsX5DPkW+UBjk5
	 BhoL8FyIv5wkVSC9CJ6Rc33oJWpOjaJTQRHDo5a2J6ruJBpnWaJV3YDvPE09y748N0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=15BJSDIi/nEF3D24KgJ08BJsfYANLIf/kLRIFODX9hs=;
	b=Wge7cCPWUBP9vVJNCHLpok/HuWc1lNbSdsxeb7KK8ROg0sY+MPq4B6DE2+TZ+EXBmvqW
	 APP+ZlrFnrCHLEAruixcnhn+ChaFcRfO7ctYHeSO302nbbfW0dLfjtVGjkOpnG7wnmusq
	 sZ7QBZeHPuEaKBb/S18X4CezxCohAGZvZdpVsIZtigUmak+TbGf9ykrspaxOPVGpFXV/C
	 dPcJL8PTr6BjvlyRsYVYvUdiMINH3pz8vMS++QHj/u0t3Gz22Upf8zkXWOJ6gSwyxxdrl
	 9YfU8T+S5RI2obLbc2dmGBBAYtCOuiXV+kn3GoHBdtLh6IggFzDnCGQxrFDwlW9HvGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k8F/Xzqo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455E60A2601
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8F/Xzqo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1711F008A7;
	Mon,  9 Nov 2026 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253731;
	bh=15BJSDIi/nEF3D24KgJ08BJsfYANLIf/kLRIFODX9hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k8F/Xzqo5kidNWiHCctOWX1aQZOEdJ6IzIffiXrRWp8VG3ZGrMj0DgFBoXANfAU4n
	 cUcQiN5wIeTGLl8tJRq83KXlqMPOoOjNtAwB/Rr+3Mj3ne5BsU4NA+fRonUe1XP7La
	 xsr8nfZE0421UfrkrZAfaYriP+APgnqPP0S1+qPiuxU+9XUKkramB7Z4QgRmCZdVoQ
	 eTbNU+iuYwz3B87qQDtjQX/YotfjYTQm1kdJK2BMeIouYJjL77OQWvtqpcD20UH6En
	 IFno6Sn9wRpNlUme/QIKa60+JMVpcftqU8F6/Bl3kVjSh7unVYC+lcspiYtITqYcqx
	 XeeXbCYCK558w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kameroncarr@linux.microsoft.com,
	ernis@linux.microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	stable+noautosel@kernel.org
Subject: [PATCH net-next v2 4/5] hv_netvsc: move a new VF to netvsc's netns from a work item
Date: Mon,  9 Nov 2026 11:48:42 -0800
Message-ID: <20261109194843.1353592-5-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194843.1353592-1-kuba@kernel.org>
References: <20261109194843.1353592-1-kuba@kernel.org>
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

When the VF registers in a different netns than netvsc, for example
because it was hot-added into init_net while netvsc lives in a container
netns, netvsc_register_vf() moves it over with dev_change_net_namespace()
straight from the VF's NETDEV_REGISTER notifier. Since commit
4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP") that
notifier runs under the VF's instance lock, which the netns change takes
again. For a VF with an ops lock the registration then deadlocks with
RTNL held, taking the networking of the whole VM down with it. mana
always has an ops lock, as it selects NET_SHAPER, and so does mlx5 for
its queue management ops, so every VF hot-add or servicing event hangs a
VM running netvsc in a netns, as does moving the VF out by hand.

netvsc already leaves moving its VF to vfns_work when netvsc itself
changes netns. Hand the new VF to the same work, holding a reference
until it runs. The VF still joins netvsc when it registers again in
netvsc's netns. If netvsc gets to the VF's netns before the work runs,
for example because netvsc's netns went away, there is no move to
register the VF again, so have the work take the VF over itself. Close
the VF first, as the move would have, as one which is up already may
never send the event which switches the data path over. Suspend cancels
the work, keep the VF and queue the work again on resume, so that the
VF isn't lost. Userspace now sees the VF in the netns it registered in,
with its uevent sent there, until the work moves it.

Spotted by AI while reviewing the XDP propagation series. Untested.

Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - close the VF the work takes over, one which was up already would
   never switch the data path over (Sashiko)
 - don't drop the VF on suspend, queue the work again on resume
   (Sashiko)
 - commit msg: mention that userspace sees the VF in its original netns
   first
 - Tested-by tags from v1 not carried over, the code changed
v1: https://lore.kernel.org/20261001014131.310771-5-kuba@kernel.org
---
 drivers/net/hyperv/hyperv_net.h |  3 ++
 drivers/net/hyperv/netvsc_drv.c | 51 +++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 4841367fdab2..a7681404df2d 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -1064,6 +1064,9 @@ struct net_device_context {
 	struct netvsc_vf_pcpu_stats __percpu *vf_stats;
 	struct delayed_work vf_takeover;
 	struct delayed_work vfns_work;
+	/* VF for vfns_work to move here or take over, see netvsc_register_vf() */
+	struct net_device *vfns_dev;
+	netdevice_tracker vfns_dev_tracker;
 
 	/* 1: allocated, serial number is valid. 0: not allocated */
 	u32 vf_alloc;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 61109ff9927f..d534e574bcf2 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2311,6 +2311,12 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	return NOTIFY_DONE;
 }
 
+static void netvsc_vfns_dev_put(struct net_device_context *ndev_ctx)
+{
+	netdev_put(ndev_ctx->vfns_dev, &ndev_ctx->vfns_dev_tracker);
+	ndev_ctx->vfns_dev = NULL;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 {
 	struct net_device_context *net_device_ctx;
@@ -2340,19 +2346,17 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 
 	/* if synthetic interface is a different namespace,
 	 * then move the VF to that namespace; join will be
-	 * done again in that context.
+	 * done again in that context. The VF's lock is held
+	 * for its registration, so leave the move to vfns_work.
 	 */
 	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
-		ret = dev_change_net_namespace(vf_netdev,
-					       dev_net(ndev), "eth%d");
-		if (ret)
-			netdev_err(vf_netdev,
-				   "could not move to same namespace as %s: %d\n",
-				   ndev->name, ret);
-		else
-			netdev_info(vf_netdev,
-				    "VF moved to namespace with: %s\n",
-				    ndev->name);
+		if (net_device_ctx->vfns_dev != vf_netdev) {
+			netvsc_vfns_dev_put(net_device_ctx);
+			netdev_hold(vf_netdev, &net_device_ctx->vfns_dev_tracker,
+				    GFP_KERNEL);
+			net_device_ctx->vfns_dev = vf_netdev;
+		}
+		schedule_delayed_work(&net_device_ctx->vfns_work, 0);
 		return NOTIFY_DONE;
 	}
 
@@ -2703,6 +2707,7 @@ static void netvsc_remove(struct hv_device *dev)
 
 	rtnl_lock();
 	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
+	netvsc_vfns_dev_put(ndev_ctx);
 
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
 	if (nvdev)
@@ -2745,6 +2750,7 @@ static int netvsc_suspend(struct hv_device *dev)
 	cancel_delayed_work_sync(&ndev_ctx->dwork);
 
 	rtnl_lock();
+	/* keep vfns_dev, netvsc_resume() queues the work again */
 	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
 
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
@@ -2761,6 +2767,9 @@ static int netvsc_suspend(struct hv_device *dev)
 	}
 	ret = netvsc_detach(net, nvdev);
 out:
+	/* netvsc_resume() won't run if we fail */
+	if (ret)
+		schedule_delayed_work(&ndev_ctx->vfns_work, 0);
 	rtnl_unlock();
 
 	return ret;
@@ -2789,6 +2798,9 @@ static int netvsc_resume(struct hv_device *dev)
 	netvsc_devinfo_put(device_info);
 	net_device_ctx->saved_netvsc_dev_info = NULL;
 
+	/* pick up whatever netvsc_suspend() stopped vfns_work from doing */
+	schedule_delayed_work(&net_device_ctx->vfns_work, 0);
+
 	rtnl_unlock();
 
 	return ret;
@@ -2823,7 +2835,9 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
 
 	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
 	if (!vf_netdev)
-		return;
+		vf_netdev = ndev_ctx->vfns_dev;
+	if (!vf_netdev || vf_netdev->reg_state != NETREG_REGISTERED)
+		goto out;
 
 	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
 		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
@@ -2836,7 +2850,20 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
 			netdev_info(vf_netdev,
 				    "Moved VF to namespace with: %s\n",
 				    ndev->name);
+	} else if (!rtnl_dereference(ndev_ctx->vf_netdev)) {
+		/* netvsc got to the VF's netns first, so no move will
+		 * register the VF again, take it over from here. Close
+		 * it first, as the move would have: a VF which is up
+		 * already may never send the event which switches the
+		 * data path over.
+		 */
+		netdev_lock_ops(vf_netdev);
+		netif_close(vf_netdev);
+		netvsc_register_vf(vf_netdev, VF_REG_IN_NOTIFIER);
+		netdev_unlock_ops(vf_netdev);
 	}
+out:
+	netvsc_vfns_dev_put(ndev_ctx);
 }
 
 void netvsc_vfns_work(struct work_struct *w)
-- 
2.56.0

