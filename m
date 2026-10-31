Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428746;
	b=SQicW/82a/mx+mjwv1y+oMSOBKa7t2WotPJP5cztugxCltxsmsE+0ldB/kYMpChV5tAX
	 wc/ZLXNQZlZqa0ZYFczaGeAsIFjADv6MVjN1j/F1NTRyvtwZdSkMYjwGhEJVAKVmEBN+a
	 nTCFWvrdT3Cv79QxxhcyZE9Tp0SMkYY+Txdl9ov6Ko3ky/FIpodz4OIyu14p+gmgQvksd
	 MVfTR2ll89nFX/X5qHxSot57A/l4fgqvhHEkD5YocKPV2FPatD4+l+eo/91/XNjzKe5BS
	 +keNYpQ1kcLaqVTX5d3ojWxQYTORz7m/8LI+lm6bnZLn+XWPmTEcd4+cp2eJsjPXL+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428746;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=LYnyOHvC5Bif32h/JnLdLhaS59dZvHk6unATAY9XyAA=;
	b=s9Zc5I4mKcjDOm7S8BWBn3dSPpVMH5YtrGndylm3g2A47LZmOdU0ESKr2AChCA0VMPTj
	 CohLdBbzC7MmV8tZYcrN/Xn4st1jNEeHm14Bqz6B2rvFpFM5PpFF6VdiChD2arpCP047l
	 hk2viUFeWBejgD8v6cMyfKrRdqgXE592GokSnhlXjgR3W5NY7AtLUoW0C+znVWLIb4K0B
	 DfhteoQ8x5NY7cGOthUS7/dWuE78GyOkV7/GRaXrL11AETcexhnAOgqMbXMFe8V3LAyxu
	 L9JuZm/ZCBeLM9ladmtMEe5I+ohXx7gjxbbTTK7TV0ZkUGg5HNLwKgDa5H0tzVHH8Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fx7xmGB+;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2931606A31A;
	Sat, 31 Oct 2026 06:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2931606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fx7xmGB+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LY
	nyOHvC5Bif32h/JnLdLhaS59dZvHk6unATAY9XyAA=; b=fx7xmGB+h1Y14brqia
	yMnrqjD/hkC8JUgj4FSxa6g3dOjv0nq4/C1qft3pg4By/PXrBSGjYn07ATftfkJE
	t8CFCurqa45d5IPCZdlnqkGLP3/tpCKxPI7ohaM4WJhcDADLjXkZNObtKpU7yS9P
	banVDofU4kesvbFUmjLco7hgU=
Received: from flipped.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXv9jfjOVqDwKbDg--.29841S3;
	Sat, 31 Oct 2026 14:38:26 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: netdev@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] sfc: fix use-after-free of filter_work in efx_realloc_channels()
Date: Sat, 31 Oct 2026 14:38:22 +0800
Message-Id: <20261031063823.876645-2-congei42@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031063823.876645-1-congei42@163.com>
References: <20261031063823.876645-1-congei42@163.com>
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
X-CM-TRANSID:_____wDXv9jfjOVqDwKbDg--.29841S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1xCry5GrWDXrW8ur1rJFb_yoW7WF15pF
	W5t3yjvr45XF9xG3Z7Jw4kAa15Jw48G34jgryDtw1rZwn8ArnxCrsYq34Ygr4DtrWxAr4a
	vr4Yvr48W3Z8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jemhrUUUUU=
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbC0wJvYmrljOIftAAA3W

With CONFIG_RFS_ACCEL, efx_poll() queues the per-channel aRFS expiry
work. The work also re-arms itself every 30 seconds so that filters
can expire even when the channel receives no more NAPI polls.

efx_realloc_channels(), called by ethtool -G, copies the channels and
frees the old structures without cancelling their filter_work. A queued
or running expiry callback can therefore access the freed channel and
re-arm a timer in freed memory. The work lifetime problem dates back to
the introduction of asynchronous filter operations; the later periodic
re-arm makes it possible even without recent receive activity.

Introduce efx_free_channel() to cancel filter_work synchronously before
freeing its channel. Use it for ring reallocation and final channel
teardown, keeping this requirement inside the deallocation helper.

The copied channels retain the installed filters but start with an idle
filter_work. Re-arm expiry on the channels that still have filters at
the common reallocation exit, so expiry continues without another NAPI
poll. This also covers allocation failure and probe rollback, when the
original channels remain in use. Apply the same changes to Siena.

Identified by code inspection. The missing expiry re-arm was pointed
out by Sashiko review and Paolo Abeni. Neither the issue nor the fix
has been tested on hardware.
Compile-tested on x86_64 with CONFIG_RFS_ACCEL enabled and disabled.

Fixes: 3af0f34290f6 ("sfc: replace asynchronous filter operations")
Link: https://lore.kernel.org/netdev/179310908138.3134.11515982039281965575@kernel.org/
Signed-off-by: Sicong Huang <congei42@163.com>
---
 drivers/net/ethernet/sfc/efx_channels.c       | 23 +++++++++++++++++--
 drivers/net/ethernet/sfc/siena/efx_channels.c | 23 +++++++++++++++++--
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index f4dc3f3f4416..44943345fa87 100644
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
@@ -898,10 +906,21 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
 		if (channel && channel->type->copy) {
 			efx_fini_napi_channel(channel);
 			efx_remove_channel(channel);
-			kfree(channel);
+			efx_free_channel(channel);
 		}
 	}
 
+#ifdef CONFIG_RFS_ACCEL
+	/* Re-arm the expiry work on the channels now in use: the copies on
+	 * success, the originals after a rollback.  The copies inherit the
+	 * aRFS filters, so they must inherit the expiry too, or a channel
+	 * that gets no further NAPI polls would never expire its filters.
+	 */
+	efx_for_each_channel(channel, efx)
+		if (channel->rfs_filter_count)
+			schedule_delayed_work(&channel->filter_work, 30 * HZ);
+#endif
+
 	efx->ptp_data = ptp_data;
 	rc2 = efx_soft_enable_interrupts(efx);
 	if (rc2) {
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 1fc343598771..388bef4be468 100644
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
@@ -932,10 +940,21 @@ int efx_siena_realloc_channels(struct efx_nic *efx, u32 rxq_entries,
 		if (channel && channel->type->copy) {
 			efx_fini_napi_channel(channel);
 			efx_siena_remove_channel(channel);
-			kfree(channel);
+			efx_free_channel(channel);
 		}
 	}
 
+#ifdef CONFIG_RFS_ACCEL
+	/* Re-arm the expiry work on the channels now in use: the copies on
+	 * success, the originals after a rollback.  The copies inherit the
+	 * aRFS filters, so they must inherit the expiry too, or a channel
+	 * that gets no further NAPI polls would never expire its filters.
+	 */
+	efx_for_each_channel(channel, efx)
+		if (channel->rfs_filter_count)
+			schedule_delayed_work(&channel->filter_work, 30 * HZ);
+#endif
+
 	rc2 = efx_soft_enable_interrupts(efx);
 	if (rc2) {
 		rc = rc ? rc : rc2;
-- 
2.34.1

