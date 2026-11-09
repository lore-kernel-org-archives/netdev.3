Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253731;
	b=XuGPNkz1IZAt8fb3XKvtDCog5NMP68cl+W0Jvo/rZRLFIH9PKgm/svGTjiL54Umwq5wk
	 KOwUX6teDc0Q5eD5pvE2m+Ow9bSxvlPTCAEeL5I/0RWB7LiAu7MP8GmobR4dq7T9OMc4S
	 xCX1tghl/pGoR3lFmICVQ6s8yLSGkk7mipvxeY3mkqG7SUJm84KaIyuSO/+BssbmIOF6d
	 yp7KizgaBWljFv8o/MMQVUDj99+9xrUp8OeEtBPPehCkHyzlZvv1vQeYLUhW024zt/R9k
	 kDVWhekAEYRF3+Ryemlk/3x2C4zj+x+jxHwe7I4iWpfkyI93pLy+WRGs3kchErXFbRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253731;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KuConC+pXScEJO5LfeTdTDLLz4Y6fyDzyXnR/ab3Z5c=;
	b=tdGj69icIVKoZWEOZWa0uFizdeYTN0WYG0Wq+La/KtdWeJnnyvIyjJ5nR6pF7VaymOEb
	 ag6fiQWIGm8LkQZwucUuw7ZDwEGz2lrR2VsSCykSf1Ezu0TpRpkrkTIWve7qCvNf5o1Lx
	 n5tvRQ8rwSUEG0UY+3P3JWbf0MdZ2ehNIm91LGrPUqrHpDiHL9H34A4DtI7TpB0zAVtKH
	 QjNbWMBdGfZP7/93g98PAmmyrpNm5laio544Nbt/oXTX6GuEuuTEKuQM7eNXxoclMvdr5
	 tltvLaOKl7w4XxtwHhjrKSn0W1cTAc33gHbdzDVV6fxmX+OV3GpV6Mw/tFCFVuRcU9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obTXk1qS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635060A2600
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obTXk1qS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F531F008A4;
	Mon,  9 Nov 2026 19:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253730;
	bh=KuConC+pXScEJO5LfeTdTDLLz4Y6fyDzyXnR/ab3Z5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=obTXk1qSB3XLqjoBvvXhYX8EyULEWzheVLNBamHo/mHQbylDnMxfTYsWXL4iPTm3q
	 V6nqmOP10FGSN+S/zdArnJPqYlCftjwrYyKTpCXdHnd2ebMbbv/QNGU3MrNVQbFrdm
	 gzrjqaj/yHA2+lZt5ZH1nuOFG2t2PxocpWkNnWlMWZ8fP+SOSSL8sSr67ArXfEsC/0
	 FGtnNrSXYDnGTwp4E0Niz7CI3VwHzmwdhp/7JxaPEjaJENVfYYzU4pbiA/kJ4ggpU1
	 7MCYR1KaDz/yeOb17g99xgXRinuH47wLfr/D3+PATzXL8D/yRuqGbn4XExYWWMMPLx
	 Mt1RVhaRuNrSg==
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
Subject: [PATCH net-next v2 3/5] hv_netvsc: treat the VF's XDP program the way bonding treats a slave's
Date: Mon,  9 Nov 2026 11:48:41 -0800
Message-ID: <20261109194843.1353592-4-kuba@kernel.org>
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

netvsc_register_vf() pushes netvsc's XDP state down to every VF it
takes over - its program, or NULL if it has none - once the VF has
joined, and ignores the result. A VF which refuses the program leaves
netvsc running XDP on its channels while traffic through the VF
bypasses it, with nothing in the logs to say so. The core won't install
a single-buffer program on a device with tcp-data-split enabled, nor
any program on one with a memory provider, and the VF's driver has
conditions of its own. A VF which can't run XDP at all isn't even
asked, and netvsc_bpf() reports success for it too. A VF which runs a
program of its own gets it replaced or removed behind the back of
whoever attached it, when it joins as well as when netvsc gets a
program later.

Nothing takes netvsc's program back when the VF stops being netvsc's
either. netvsc_unregister_vf() runs when the VF is unregistered, when
either device moves to another netns (netvsc drags the VF along when it
moves itself), when netvsc is unbound or hot-removed, and on rmmod
hv_netvsc, where unregistering the notifier replays NETDEV_UNREGISTER
before netvsc_remove() ever runs. In all but the first case the VF
stays, running netvsc's program with no upper left to own it. We will
soon track in the core if the program is installed from upper; a
leftover would then become the VF's own, and netvsc would refuse to
take the VF back until someone removed it. netvsc_unregister_vf() used
to propagate NULL to the VF, until commit 3ec523304976 ("hv_netvsc: fix
potential deadlock in netvsc_vf_setxdp()") dropped the call on the
grounds that the core cleans up through dev_xdp_uninstall(). That only
runs when the VF itself is unregistered, and doesn't know about
propagated programs at all, so even then the VF's driver keeps its
reference to netvsc's program; mana, for one, leaks it on every VF
removal while netvsc runs XDP.

Do what bonding does with its slaves instead. With no program on netvsc
there is nothing to push down, so leave the VF's program alone. With a
program on netvsc, don't take over a VF which runs one of its own, in
any mode, or which can't or won't run netvsc's, and say why in the log.
netvsc then keeps its traffic on the synthetic path, where the program
runs, and doesn't use the VF. Nothing retries taking the VF over until
it registers again, just as bonding doesn't retry an enslave it refused.
For a VF already in use fail attaching the program to netvsc instead, as
netvsc_bpf() already did when the VF refused it, but don't fail a
removal over the VF's own program, leave that program be. Install the
program before joining the VF, so that a refusal needs no unwinding and
nothing reaches netvsc through the VF without having been through the
program, and sync the VF's features ahead of it, as LRO may keep the VF
from taking XDP; a VF which refuses the program all the same is left
with netvsc's features. Take the program back when the VF leaves, under
the VF's lock, which none of the paths into netvsc_unregister_vf() hold,
once netvsc's rx handler is gone, and warn if the VF won't let go of it,
as bonding does, but leave a program of the VF's own be, as on removal.
Key that on the program on netvsc's channels, the way bonding keys its
release on bond->xdp_prog; a generic program on netvsc never reached the
VF. Let the VF go in netvsc_remove() before the channels are cleared.

The two halves only work together. The NULL pushed at registration was
all that cleared a program an earlier netvsc instance left on the VF,
and taking the program back without the refusal would strip a VF of its
own program after it was joined despite refusing netvsc's.

A VF netvsc uses now always runs netvsc's program when netvsc has one.
Update netvsc's documentation, which still said that a program on the
VF may get overwritten, and describe the VFs netvsc doesn't use.

Reported by Sashiko during core rework. Unverified and untested.

Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
Fixes: 351e1581395f ("hv_netvsc: Add XDP support")
Fixes: 3ec523304976 ("hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - refuse a VF which can't run XDP while netvsc has a program, and fail
   attaching a program to netvsc while such a VF is in use (Sashiko)
 - fail attaching a program to netvsc while the VF in use runs one of
   its own, rather than leave that to the core series, but leave the
   VF's program be on removal, and when the VF leaves (Sashiko)
 - warn when the VF won't give netvsc's program back (Sashiko)
 - move the documentation update here from the core series, and don't
   claim that the refused VF's traffic stays on the synthetic path
   (Vennela)
 - commit msg: say that nothing retries a refused VF, and that it keeps
   netvsc's features (Sashiko)
 - Tested-by tags from v1 not carried over, the behavior changed
v1: https://lore.kernel.org/20261001014131.310771-4-kuba@kernel.org
---
 .../ethernet/microsoft/netvsc.rst             | 11 +++-
 drivers/net/hyperv/netvsc_bpf.c               | 15 ++++-
 drivers/net/hyperv/netvsc_drv.c               | 65 +++++++++++++++----
 3 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
index 0d464706a59a..7f1731a819f9 100644
--- a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
+++ b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
@@ -109,8 +109,15 @@ XDP support
 
   Setting / unsetting XDP program on synthetic NIC (netvsc) propagates to
   VF NIC automatically. Setting / unsetting XDP program on VF NIC directly
-  is not recommended, also not propagated to synthetic NIC, and may be
-  overwritten by setting of synthetic NIC.
+  is not recommended, and not propagated to synthetic NIC. If the
+  synthetic NIC has a program when a VF NIC shows up, a VF NIC which runs
+  a program of its own, or which can't or won't run the synthetic NIC's,
+  is not used until it is registered again. The synthetic NIC then keeps
+  its traffic on the synthetic data path; what the VF NIC receives if it
+  is brought up on its own is outside of the synthetic NIC's control.
+  For a VF NIC already in use which runs a program of its own, or can't
+  or won't run the synthetic NIC's, setting the program on the synthetic
+  NIC fails instead.
 
   XDP program cannot run with LRO (RSC) enabled, so you need to disable LRO
   before running XDP::
diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index ec8edfaebf0b..143fc0c12841 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -176,8 +176,9 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 
 	netdev_assert_locked_ops_compat(vf_netdev);
 
+	/* as with bonding, a VF which can't run XDP can't carry ours */
 	if (!vf_netdev->netdev_ops->ndo_bpf)
-		return 0;
+		return prog ? -EOPNOTSUPP : 0;
 
 	memset(&xdp, 0, sizeof(xdp));
 
@@ -210,6 +211,18 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
+		/* The VF's own program is not ours: refuse to install over
+		 * it, as bonding does, and leave it be on removal.
+		 */
+		if (vf_netdev && dev_xdp_prog_count(vf_netdev)) {
+			if (bpf->prog) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "VF has an XDP program of its own");
+				return -EOPNOTSUPP;
+			}
+			vf_netdev = NULL;
+		}
+
 		/* Hold on to the old program, to put it back on the channels
 		 * if the VF refuses the change.
 		 */
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1d43c73fd73f..61109ff9927f 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2331,6 +2331,13 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
 		return NOTIFY_DONE;
 
+	prog = netvsc_xdp_get(netvsc_dev);
+	if (prog && dev_xdp_prog_count(vf_netdev)) {
+		netdev_warn(ndev, "not using VF %s, it has an XDP program attached\n",
+			    vf_netdev->name);
+		return NOTIFY_DONE;
+	}
+
 	/* if synthetic interface is a different namespace,
 	 * then move the VF to that namespace; join will be
 	 * done again in that context.
@@ -2349,10 +2356,31 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 		return NOTIFY_DONE;
 	}
 
+	/* Install netvsc's program before joining, so that a VF which
+	 * refuses it never gets used. Syncing the features first turns
+	 * off LRO, which the VF may not run XDP with.
+	 */
+	if (prog) {
+		vf_netdev->wanted_features = ndev->features;
+		netdev_update_features(vf_netdev);
+
+		ret = netvsc_vf_setxdp(vf_netdev, prog);
+		if (ret) {
+			netdev_warn(ndev, "not using VF %s, it refused netvsc's XDP program: %d\n",
+				    vf_netdev->name, ret);
+			return NOTIFY_DONE;
+		}
+	}
+
 	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
 
-	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
+	if (netvsc_vf_join(vf_netdev, ndev, context) != 0) {
+		ret = prog ? netvsc_vf_setxdp(vf_netdev, NULL) : 0;
+		if (ret)
+			netdev_warn(ndev, "failed to remove XDP program from VF %s: %d\n",
+				    vf_netdev->name, ret);
 		return NOTIFY_DONE;
+	}
 
 	dev_hold(vf_netdev);
 	rcu_assign_pointer(net_device_ctx->vf_netdev, vf_netdev);
@@ -2363,9 +2391,6 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 	vf_netdev->wanted_features = ndev->features;
 	netdev_update_features(vf_netdev);
 
-	prog = netvsc_xdp_get(netvsc_dev);
-	netvsc_vf_setxdp(vf_netdev, prog);
-
 	return NOTIFY_OK;
 }
 
@@ -2441,6 +2466,8 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 {
 	struct net_device *ndev;
 	struct net_device_context *net_device_ctx;
+	struct netvsc_device *nvdev;
+	int ret;
 
 	ndev = get_netvsc_byref(vf_netdev);
 	if (!ndev)
@@ -2453,6 +2480,20 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
+
+	/* Take our program back now that frames from the VF no longer
+	 * reach netvsc, but leave a program of the VF's own be.
+	 */
+	nvdev = rtnl_dereference(net_device_ctx->nvdev);
+	if (nvdev && netvsc_xdp_get(nvdev) && !dev_xdp_prog_count(vf_netdev)) {
+		netdev_lock_ops(vf_netdev);
+		ret = netvsc_vf_setxdp(vf_netdev, NULL);
+		netdev_unlock_ops(vf_netdev);
+		if (ret)
+			netdev_warn(ndev, "failed to remove XDP program from VF %s: %d\n",
+				    vf_netdev->name, ret);
+	}
+
 	netdev_upper_dev_unlink(vf_netdev, ndev);
 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
 	dev_put(vf_netdev);
@@ -2664,21 +2705,21 @@ static void netvsc_remove(struct hv_device *dev)
 	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
 
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
-	if (nvdev) {
+	if (nvdev)
 		cancel_work_sync(&nvdev->subchan_work);
-		netvsc_xdp_set(net, NULL, NULL, nvdev);
-	}
+
+	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	if (vf_netdev)
+		netvsc_unregister_vf(vf_netdev);
 
 	/*
 	 * Call to the vsc driver to let it know that the device is being
 	 * removed. Also blocks mtu and channel changes.
 	 */
-	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
-	if (vf_netdev)
-		netvsc_unregister_vf(vf_netdev);
-
-	if (nvdev)
+	if (nvdev) {
+		netvsc_xdp_set(net, NULL, NULL, nvdev);
 		rndis_filter_device_remove(dev, nvdev);
+	}
 
 	unregister_netdevice(net);
 	list_del(&ndev_ctx->list);
-- 
2.56.0

