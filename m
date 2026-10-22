Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676556;
	b=r11EKekhpk2TAbz2WMTAvRNKFA2OwUENvtVqBuBSNaX3hQhvM5tmm1ZIkgMUwP5p9oWh
	 AJVFZUThTJrAblAcOHEJ5FS8pBh1oh4S8KMgYjkikR3UFRWc3hPqwH1nFypsUHBzESUvA
	 rgnrjYzF7pk1QGG417IGyzeMV0E2fhGOWAsorLqlUVRNlXNNMgLEw5Z5tsq0PeFQZH8GB
	 OnbyC8gQl2VRUhxeuGDErMthxFjC0er+3gk0FOOj0jmQSRy91PpqLYL6EVoBOykpa4j9P
	 mQtB9U0T5xSzQEx+/XX36eQTk6VX3LKaVVJglodtNwf1DY1vTLsJ6oRjl7jDvDL1IpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676556;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=dq6zyqOD1OLLx8fYAI+0jT8oHPgoBuLFM3qApv3melY=;
	b=pLs8OB3y+ddnRyUTWc/h8LRYcGlD6cyrwuHL+z54ptwzPc8mhqTngIUWirgSkK/yR0D5
	 t1Q6YA6dWL7IyQLl8QI1Se4inRuJnlBxvq975vU9oJI5fT4RKSHPGskXlp3/e6RSjoOMH
	 pEQkfsrgGmtH8q+8NpkQouytObNHzztL0ru1aG7aDYWgIJj+XXMxpPCSEExBeg0h8Lfj2
	 tewTl4ZzXboL+MduHrfJbTiZGXAGRuK+C8fd065faTbp+mCQMFgDPBDQ+LGyHso2RE5Vg
	 lkSqR14hQnVzKb9NfuLUBmNUEbN+/+DwUZbWnB7l0rfkyirVHvqBRnDpY68mWZwNCvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cu5WGbJQ;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E6606A323;
	Thu, 22 Oct 2026 13:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 805E6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cu5WGbJQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dq
	6zyqOD1OLLx8fYAI+0jT8oHPgoBuLFM3qApv3melY=; b=cu5WGbJQqY3qP0n6Jw
	OYsR0OUt2AYMIZXoGA4f59+kve3Tlii9jTDt+9yFJD5XHAfhpkFqkv4ASr7/TgI5
	Y5S29LDEaacAt+l/74RbsXzuYTZ/CpDrnk+qa+tnIA8SFrgdWP9kLkuYuqtHDQhu
	I4dEd/F3k0VAE2lZnS3VeVNAE=
Received: from flipped.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHR24QEtpqBWOrBQ--.45010S2;
	Thu, 22 Oct 2026 21:39:29 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: netdev@vger.kernel.org
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Sicong Huang <congei42@163.com>
Subject: [PATCH net] sfc: fix use-after-free of filter_work in efx_realloc_channels()
Date: Thu, 22 Oct 2026 21:39:27 +0800
Message-Id: <20261022133927.3860186-1-congei42@163.com>
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
X-CM-TRANSID:PygvCgCHR24QEtpqBWOrBQ--.45010S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury7AF18ZFyrWF1DKFW3ZFb_yoWrGryrpa
	y5JrWUXry8Xay5tF1vqw18ZF1rGw4DGw1jgrn5Kw4ru3s5AFnxAFsYq3WY9F4DJrWxAr43
	tr4YvrWrX3Z8taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piivtPUUUUU=
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbC1BHZzGraEhHrGQAA3R

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

Fix this in both drivers by calling cancel_delayed_work_sync() on
filter_work before freeing an unused channel. The work does not take
the RTNL. It only trylocks efx->rps_mutex, and the filter table locks
it takes are never held while waiting for the RTNL, so waiting for it
under the RTNL cannot deadlock. On the copy failure and rollback paths,
the freed channels are new copies whose filter_work was never queued,
so the cancel does nothing there.

Signed-off-by: Sicong Huang <congei42@163.com>
---
 drivers/net/ethernet/sfc/efx_channels.c       | 3 +++
 drivers/net/ethernet/sfc/siena/efx_channels.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index f4dc3f3f4416..3773a70e1e7d 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -896,6 +896,9 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
 	for (i = 0; i < efx->n_channels; i++) {
 		channel = other_channel[i];
 		if (channel && channel->type->copy) {
+#ifdef CONFIG_RFS_ACCEL
+			cancel_delayed_work_sync(&channel->filter_work);
+#endif
 			efx_fini_napi_channel(channel);
 			efx_remove_channel(channel);
 			kfree(channel);
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 1fc343598771..d20144f1679a 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -930,6 +930,9 @@ int efx_siena_realloc_channels(struct efx_nic *efx, u32 rxq_entries,
 	for (i = 0; i < efx->n_channels; i++) {
 		channel = other_channel[i];
 		if (channel && channel->type->copy) {
+#ifdef CONFIG_RFS_ACCEL
+			cancel_delayed_work_sync(&channel->filter_work);
+#endif
 			efx_fini_napi_channel(channel);
 			efx_siena_remove_channel(channel);
 			kfree(channel);

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

