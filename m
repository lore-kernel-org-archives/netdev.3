Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DE38BF70
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444011; cv=none; b=GdP8GUte4VQFELVeDBgTH15zosaxx7mkEsI4672cBXQwcdorXRLrY+edFmo8E9s5OMivjtMk3SgrGtMdpoElCnrJfWr0zfVhxjCeCxEZfon+YGTqm4hqnH6ohDgbS2latUwG0RPRPagP1p9p4mSyyZTwU4IA8P76e45HeQFAqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444011; c=relaxed/simple;
	bh=RpxlgrHnssCWHv69NQMrQjW6mQn/TfTHaaucDK6GBwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naRwNmAi7Bpu5FwWO7vSsHGDDMNvWEjkSd+pwCEhTYUT7X7LdHOaZj5sl4VL5kvQo4uBHC2LzOXA/6aFRg5gyPkcluUfFiwAQdFI9lMiNl7HYfsRhqjcR71owW6+05x5EvgwncSUPTwnLX9emN1LPgO6hxEjUUh95fSPxNF9rAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5OmZ1Gq; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5OmZ1Gq"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-344213c95bdso2458eec.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444004; x=1791048804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQQtdjlWuU+bgyaicvMDBst8881EjkWz2XZFwKYg1rg=;
        b=M5OmZ1Gqh7K22i/3BztWfuwj4DhY+fk89XujDh0I8Tn4X0+4xtyntRsF6zv0uhDpOL
         45iHHPQHy1Kraj3X58B1SeE6uBsIKtOlq2KbZq/X1oc7RN47KOrDtnffzmok0Pxbo6Xy
         Y6EgBEFJCKOstsZms0huga2Vw60Uwhk3aozRhOMdBEsQqULNzYQDk6kFYLRndWVNntJu
         ywUq6WdGHSo151179aDpyfx7YGe3o75XHFZqtkpHePnc9te0nrA3GF40MY27Zf0RKmm1
         nyGLxuYDJKcBW2ytyrYTFM+/z4GCKMdL3NkqU0PgWtsl1m35Rg89JWuYoRJ07gm/JwSL
         QPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444004; x=1791048804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQQtdjlWuU+bgyaicvMDBst8881EjkWz2XZFwKYg1rg=;
        b=IUZ0mpu46LVen45SJGa2MqkVsHA49QsACbbfvPh56JK/m9+2m7DGchifpFal+UNGJj
         4mgWmKOb5BGdcviEH0M03n5onWj3W+A2tWxHlwGegwgy2SvC1YhUvRgtBud5e4bLOTir
         zOwNQ/sas3AzV1vRNye2uC5StlDn1RkGloDiHN1PbXpM4uZRXW6v2vlUUbZ8ZHVWMNFh
         lgApWy2FA4gCuf5k/nc5sbTMuxphuv6tHLlCqIWwGGcRPYuqRK++S0EuEU8BWDq8Xmuz
         C7HRDBd0pWK0jrkNmmLio4GpvhDsZvGOc1Xxxjkqa/ouKby1zCDovlpPXDmulE9vID9j
         kbXQ==
X-Gm-Message-State: AFuF++kpWf3g6qF5dAvkvO1JaCMRHf3wkxqXtE+rIXSfLcJuQ0jVFLiG
	4eFVMFvp3+kaQHm5vUUmpYdbxs1zFL6BY1oau0kvjc4LmdE61jtZTf3z
X-Gm-Gg: AYBFou3yGstQQSn/l9SDDJsy/QEi3giuvPo6uW5YJixR4y0/ekXqDlF0jFe3aC6ehGB
	idjs2wj37z5vZMqonpLi6+GeS2AkpeHG01hR8RdWW1kXcVrJvjnwL/IezkE0WbvjN5atMFP3c16
	W00DbcdKCTxzYqHrEP5sT3wMcz3D6rEI7muKM0tN90Fqs7Mhxl+yoQtmjUssth5fmAoixeSpnpN
	6jFgNd0jWo/gmV4t0/YVBh5IuEHDA3akOWQr1eJbqxDKEIk0TXSx3XQViNQ+PFr0yhwSHiTH5xh
	TTmvxFayztPvYpNX7uqF9yXKDPr3gppmVE5hkBC5vSz4O7c3+dDFlYdQSqB/RP/yxBKR/YEC9fq
	lL6OmvgYlTxPJ2xzDLcktSOOUN1yBPy3pUFJy949lOPxuQv1qqrTm5ok4xx2NPtgQ12R4VvIUCp
	oaHagnkKXiREKLfmXEpDNmLM0QSUHoJQZJ5KvbVtNa/lNr1Oi8Ji4rKKvQqtinpq2iJqufMtR7n
	ZjByaRzHJqXZM8QhuS5BFZnSh3SXIOrYjN7auTMdTkUiecvkzI1DwrqJiDXsFmCpERnow==
X-Received: by 2002:a05:701b:4542:20b0:139:81c6:67a1 with SMTP id a92af1059eb24-146cf7ee6efmr5862978c88.1.1790444004044;
        Sat, 26 Sep 2026 10:33:24 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c505sm13792059c88.5.2026.09.26.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:23 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net-sysfs: release the TX queue tracker before allowing reuse
Date: Sun, 27 Sep 2026 01:33:15 +0800
Message-ID: <20260926173315.2452612-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An interrupted sysfs_rtnl_lock() can drop the last kobject reference to a
removed TX queue without holding RTNL. netdev_queue_release() clears the
kobject before releasing queue->dev_tracker, allowing the queue to be
re-added while the old release still needs the shared tracker slot:

  CPU 0                               CPU 1
  netdev_queue_release()
    memset(kobj, 0, sizeof(*kobj))
                                      netdev_queue_add_kobject()
                                        state_initialized is clear
                                        netdev_hold() installs new tracker
    netdev_put() releases the new tracker

With CONFIG_NET_DEV_REFCNT_TRACKER enabled, the old tracker is leaked and
the new lifetime's tracker is released prematurely. A later queue release
then reports a double release. The numeric device references remain
balanced.

The kernel reported:

  ref_tracker: reference already released.
  ref_tracker: allocated in:
   netdev_queue_update_kobjects+0x23d/0x5c0
   netif_set_real_num_tx_queues+0x111/0x820
   veth_set_channels+0x327/0x930
   ethtool_set_channels+0x3ee/0x490
  ref_tracker: freed in:
   netdev_queue_release+0xbd/0x130
   kobject_put+0x1f9/0x280
   sysfs_rtnl_lock+0x18b/0x1f0
   xps_rxqs_show+0xad/0x250
  WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x49e/0x6d0
  Call Trace:
   netdev_queue_release+0xbd/0x130
   kobject_put+0x1f9/0x280
   netdev_queue_update_kobjects+0x3f9/0x5c0
   netif_set_real_num_tx_queues+0x111/0x820
   veth_set_channels+0x327/0x930
   ethtool_set_channels+0x3ee/0x490

Release the tracker before clearing the kobject. Use a full memory barrier
to order the tracker access before clearing state_initialized, paired with
the control dependency from that check to the new tracker allocation.
Keep the device reference until after the reset so that the queue storage
remains alive throughout the callback's accesses.

Fixes: b0b6fcfa6ad8 ("net-sysfs: remove rtnl_trylock from queue attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/core/net-sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 352173df7578..b9aadc4c000c 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1906,8 +1906,11 @@ static void netdev_queue_release(struct kobject *kobj)
 {
 	struct netdev_queue *queue = to_netdev_queue(kobj);
 
+	netdev_tracker_free(queue->dev, &queue->dev_tracker);
+	/* Finish using the tracker before allowing the queue to be re-added. */
+	smp_mb();
 	memset(kobj, 0, sizeof(*kobj));
-	netdev_put(queue->dev, &queue->dev_tracker);
+	__dev_put(queue->dev);
 }
 
 static const struct ns_common *netdev_queue_namespace(const struct kobject *kobj)
-- 
2.43.0

