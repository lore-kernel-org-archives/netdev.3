Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253730;
	b=k82KRISjXCDtHdFU2iFaUfcr3B5oXvyL4FTrFrq6gRjur90X0pVl8Q5+8vX4Al3SFlm3
	 WyTcvpQFfmOoc6DL/qgVKgEuDllZYO9slW1kzLwxMJyE0Z7wKhggkRZo58e/78gvC/lLF
	 me4W2dvUNbZqumaVQxNeniWF5UN3L3Efvz0BMIxghknRIfDzP6FpngCxLQEEchbpOYb73
	 gJ1oRlSVT9Si27fw4LbqsqwMWitH2axxBAZS6KIZEEXrDisDBcf3rHlqxAsYKuYjThNoR
	 ChRh+ekci5Z06htuaMwO7bCiEHkDtP6EFXrDpK0OP0/IgVhpVRkazY0k53PEfZqXT2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JluyNnfzlofDibcPGuzgbp7f1N0uQMHdpBZKXJUebd4=;
	b=dTZxp+8bIzyzTFXgj1rY7k9ZM7D5djHKfnakQ7bndhhrH06fhKLgtozumGh9Nx23Ska1
	 Kb4yOLl6WBYunU8NjSNHK4zWWj7gd0YZo5A/fPsn01OkiJk2WtG9ZQ5GeHAJyNbiuwhQX
	 9W/On9OdlYPiNCqaMo9enjfgKtiAVJoDLi5Z3wfMbC8t2ZP2hjkBVCrXrSM2o6CtWmF7C
	 PXDaK+peg8/MH/n6XIUBF4fSvgmSQ++OpZ5jytgHZOhMa+QlJZf+5PdjghG+RaZOl8DHb
	 OG7ftgySlx5cNdE3+oqsWISsD07n4CbKKLSSaMGzNrkL/v0A6YFy8a9T6gMeGwlZSJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqb46EAt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D28606A335
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqb46EAt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76961F008A3;
	Mon,  9 Nov 2026 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253730;
	bh=JluyNnfzlofDibcPGuzgbp7f1N0uQMHdpBZKXJUebd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cqb46EAt3ffKU7vlLDy+LgsqX99Z9lUxv+7jVaN7fkQa63AALiREivafZPVGsGnnj
	 e5q1EpLefedrFK4kPxPoRp6Ht1kO1L88PYSTxpI/fZeMAnRbQyz/f7GnJTgC1U1tDu
	 4i2ey/FvuuqHL7OnJSs931X79BEtR3Fnk31F9Lx4zJwqP670KQX64th2kuDs2UXRBq
	 sqmal9HnbFKOKWWn0wrqFFfGF2DJQ+vwn8cHq6hqaLfQ+rH4Aq096lVZ4QvHKmrioF
	 h9XeyaLUdnXrX/StDCYmnqXJworsFMTOb3OnaqS0JWneum3Hthq/dQ9+PqoPdNnDXC
	 WX8bxu3MarG2w==
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
Subject: [PATCH net-next v2 2/5] hv_netvsc: hold the VF's instance lock when installing XDP on it
Date: Mon,  9 Nov 2026 11:48:40 -0800
Message-ID: <20261109194843.1353592-3-kuba@kernel.org>
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

netvsc_vf_setxdp() has two kinds of callers. netvsc_register_vf() runs
with the VF's instance lock already held, either by the NETDEV_REGISTER
notifier or by netvsc_probe() taking it, which is why the propagation
moved to the caller-locked netif_xdp_propagate(). netvsc_bpf() runs with
just RTNL, so the VF's ndo_bpf() gets called unlocked. For a VF with an
ops lock that trips the lockdep assertion in
dev_get_min_mp_channel_count(), which netif_xdp_propagate() calls, and
races with binding a memory provider, which takes only the instance
lock.

Take the VF's lock in netvsc_bpf().

Reported by Sashiko during core rework, the race was not reproduced.

Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
Fixes: 3ec523304976 ("hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>
Tested-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
v2:
 - commit msg: say that the race was not reproduced, rather than that
   the fix is untested, as functional testing covered it
v1: https://lore.kernel.org/20261001014131.310771-3-kuba@kernel.org
---
 drivers/net/hyperv/netvsc_bpf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index fcc60729384e..ec8edfaebf0b 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -14,6 +14,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/kernel.h>
+#include <net/netdev_lock.h>
 #include <net/xdp.h>
 
 #include <linux/mutex.h>
@@ -162,6 +163,7 @@ int netvsc_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	return 0;
 }
 
+/* Caller holds the VF's lock, see netdev_lock_ops() */
 int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 {
 	struct netdev_bpf xdp;
@@ -172,6 +174,8 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 	if (!vf_netdev)
 		return 0;
 
+	netdev_assert_locked_ops_compat(vf_netdev);
+
 	if (!vf_netdev->netdev_ops->ndo_bpf)
 		return 0;
 
@@ -218,7 +222,15 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 		if (ret)
 			goto put_old_prog;
 
-		ret = netvsc_vf_setxdp(vf_netdev, bpf->prog);
+		/* Unlike netvsc_register_vf() we don't get the VF's lock
+		 * handed to us here.
+		 */
+		ret = 0;
+		if (vf_netdev) {
+			netdev_lock_ops(vf_netdev);
+			ret = netvsc_vf_setxdp(vf_netdev, bpf->prog);
+			netdev_unlock_ops(vf_netdev);
+		}
 
 		if (ret) {
 			netdev_err(dev, "vf_setxdp failed:%d\n", ret);
-- 
2.56.0

