Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762990;
	b=Vm6nLF95de/HHX6eEcXmd8lOisgqhW5Vx79AAUkjRINLSdwR2BRRvSpdW75XElGpxNND
	 YKagSGExDbfMmAU9BOWzlsMluX0TyutaSiOtMsXy5NiM468Q+cMa6IbTIEoQ7FmJbl9Ez
	 qLLRhFPJkDE5TCeRjgeOeCV6ftnKITeo3w2oefVu01aya8x94H4NbA1E+wxT17vGOypRR
	 65cOWvBcGyzbud67sEgqmkXABlG22b2G5AUevfZ3Bg22IJkNR/h/6JMqmFEi22S0O1OvD
	 SmH5LtAaarKaBMDB8oTIwdXynxK/G500LnJFLX+HZ/QC/Oj5nMs/TEYoZvGUuM2Dc+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762990;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=TZc0+BmeU6eS10RHwjL0sGapBIE/oV5/5PVBwOg8ny4=;
	b=pQtWgzVHtemTDWeZgWARZYZQZWfsIiUAge6t24CYMqDrtZhzNrXvuuTAEWtz8RNmVxpc
	 P9sU9VDPiV3/Kgiqc2P3176f/CeqBEj7wjKyQfp+qAnUZs3TInzZKaEmW0NkMEyQEg19L
	 eBUqQTmBn+IeDN2C7ummk/pzTmT7X0ELw6RSlj5RGWwP4zhZhrYDwhPHy6nR79LD7rKqt
	 VYxenBnXTo4G3vwBSxuQ09sdiXMIikZ2aglSEuUjj983igJo3bbKUUZIT+vZitpO1fHY1
	 GK+z3mQQ2Z3pja4kS0zFCAjjfi9AKs5Po0IVpS9CEt5bgDqLBfvWtEuoM/gnOjNeaqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PIEMhF2B;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66B606A31B;
	Fri, 23 Oct 2026 13:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A66B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PIEMhF2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TZ
	c0+BmeU6eS10RHwjL0sGapBIE/oV5/5PVBwOg8ny4=; b=PIEMhF2BF4m30Tku/H
	X7bclQi+hzM2Kod0sPHDZ1Uz4MEZ3SC6qXnci1nyCSMW+OQ2xKm3qHp3SD2QgaE3
	6Xa9BNAgEVHC8GH/RSSZpB44bRVrhzVU238Js0BwtHHDmEbuX77Drw49Qf/TSsRB
	OMpWQ62NsXZAOM55MvQSTkWTo=
Received: from flipped.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD33x04ZNtq3eINCQ--.19371S2;
	Fri, 23 Oct 2026 21:42:17 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Sicong Huang <congei42@163.com>
Subject: [PATCH net v2] sfc: fix use-after-free of filter_work in efx_realloc_channels()
Date: Fri, 23 Oct 2026 21:42:14 +0800
Message-Id: <20261023134214.322796-1-congei42@163.com>
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
X-CM-TRANSID:_____wD33x04ZNtq3eINCQ--.19371S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww1kJFy7Kr1xtr4xXw1rXrb_yoW7GF4kpF
	W5JrWUXrW3XFZ8GFn2qw1kAF4rGw4kG34jgr98tw4rZ34rArnxAFnYqa4Ygr4DJr4xAr4a
	vr15Ar48X3Z8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKsUtUUUUU=
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbC9hu4q2rbZDtmewAA3N

With CONFIG_RFS_ACCEL, each channel has a delayed work item,
channel->filter_work, that expires aRFS filters. efx_poll() queues it
with mod_delayed_work(), and efx_filter_rfs_expire() always re-arms it
with schedule_delayed_work(dwork, 30 * HZ). Once efx_poll() has queued
it, the work is therefore always pending, queued or running. It is
only cancelled in efx_remove_filters(), which is not called on the ring
resize path.

Resizing the rings via ethtool -G calls efx_realloc_channels(). It
copies each channel, swaps the copies into efx->channel[] and frees the
old channel structures. Nothing on this path cancels the old channel's
filter_work. So the old filter_work can fire after its channel has
been freed. The timer core and delayed_work_timer_fn() then access
the freed delayed_work. efx_filter_rfs_expire() gets the freed channel
back via container_of(), dereferences it and re-arms the timer inside
the freed object.

A possible race is:
CPU0                             CPU1
efx_ethtool_set_ringparam()
efx_realloc_channels()
efx_stop_all()  //NAPI stopped, timer still armed
efx_copy_channel()
swap(efx->channel[i], ...)
efx_remove_channel(old)
kfree(old)  //free here!
                                 old->filter_work.timer fires
                                 delayed_work_timer_fn()
                                 efx_filter_rfs_expire()
                                 channel = container_of(dwork, ...)
                                 channel->rfs_last_expiry  //UAF!
                                 schedule_delayed_work(dwork, 30 * HZ)

Because the work re-arms itself every 30 seconds, this is not a narrow
timing window. One successful ethtool -G after efx_poll() has queued
filter_work is enough to trigger it.

The Siena driver has its own copy of this code in
efx_siena_realloc_channels() and has the same problem.

Introduce efx_free_channel() to cancel filter_work synchronously
before freeing the channel. Use it in efx_realloc_channels() and
efx_fini_channels(), and in their Siena equivalents. This keeps
cancellation of the per-channel expiry work inside the channel
deallocation API.

Fixes: 3af0f34290f6 ("sfc: replace asynchronous filter operations")
Signed-off-by: Sicong Huang <congei42@163.com>
---
Changes in v2:
- Introduce efx_free_channel() to cancel filter_work synchronously
  before freeing the channel. Replace the direct kfree() calls in 
  the reallocation and final teardown paths with this helper in 
  both drivers.
- Add the Fixes tag.

Link to v1: https://lore.kernel.org/netdev/20261022133927.3860186-1-congei42@163.com/

 drivers/net/ethernet/sfc/efx_channels.c       | 12 ++++++++++--
 drivers/net/ethernet/sfc/siena/efx_channels.c | 12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index f4dc3f3f4416..3e29b892e90c 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -561,6 +561,14 @@ static struct efx_channel *efx_alloc_channel(struct efx_nic *efx, int i)
 	return channel;
 }
 
+static void efx_free_channel(struct efx_channel *channel)
+{
+#ifdef CONFIG_RFS_ACCEL
+	cancel_delayed_work_sync(&channel->filter_work);
+#endif
+	kfree(channel);
+}
+
 int efx_init_channels(struct efx_nic *efx)
 {
 	unsigned int i;
@@ -589,7 +597,7 @@ void efx_fini_channels(struct efx_nic *efx)
 
 	for (i = 0; i < EFX_MAX_CHANNELS; i++)
 		if (efx->channel[i]) {
-			kfree(efx->channel[i]);
+			efx_free_channel(efx->channel[i]);
 			efx->channel[i] = NULL;
 		}
 }
@@ -898,7 +906,7 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
 		if (channel && channel->type->copy) {
 			efx_fini_napi_channel(channel);
 			efx_remove_channel(channel);
-			kfree(channel);
+			efx_free_channel(channel);
 		}
 	}
 
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 1fc343598771..1a8985c153f9 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -563,6 +563,14 @@ static struct efx_channel *efx_alloc_channel(struct efx_nic *efx, int i)
 	return channel;
 }
 
+static void efx_free_channel(struct efx_channel *channel)
+{
+#ifdef CONFIG_RFS_ACCEL
+	cancel_delayed_work_sync(&channel->filter_work);
+#endif
+	kfree(channel);
+}
+
 int efx_siena_init_channels(struct efx_nic *efx)
 {
 	unsigned int i;
@@ -591,7 +599,7 @@ void efx_siena_fini_channels(struct efx_nic *efx)
 
 	for (i = 0; i < EFX_MAX_CHANNELS; i++)
 		if (efx->channel[i]) {
-			kfree(efx->channel[i]);
+			efx_free_channel(efx->channel[i]);
 			efx->channel[i] = NULL;
 		}
 }
@@ -932,7 +940,7 @@ int efx_siena_realloc_channels(struct efx_nic *efx, u32 rxq_entries,
 		if (channel && channel->type->copy) {
 			efx_fini_napi_channel(channel);
 			efx_siena_remove_channel(channel);
-			kfree(channel);
+			efx_free_channel(channel);
 		}
 	}
 

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

