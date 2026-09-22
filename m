Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433B569F14
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094903; cv=none; b=oRaiZyhyt0oNYRQXVG4AuBsMWVjobn+Tj8ON4zUlolqkFfWdB6ZTNmQKyeE2cBHhX4gKOzKTjkal/b2UIz0cRNS21h4yq2r4K+6nY5yGS36iMSAdoPtXwE9JJWeAF3461JIQ5hJEX65O5ZEK59jlu/VRZKrj3fApTquO7RSP9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094903; c=relaxed/simple;
	bh=BB6dwNTdtcHi9uunM0bqFt+8k9jA0Qk9qrS84HL6qKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oipnvd6t12vCOWdkCnGF1ENsk31/+jzlVvyxBvJVSOlNfKyLR9cstw5K3j1h2VPS58kZvnS5JvayFzEjNM6/pikrsfP8RZgkp3MCoXzVCaqOTEQ8ICK4dBiU21GpJ6YB3UcVYHMu+eY01B9LLYOvPLOCryJIu+jGagFw+1czj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJ76Waw9; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJ76Waw9"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530256c61b4so1480561cf.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790094901; x=1790699701; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ok4MWBbItiOTuHBrYY/Sl72bi3aafQGdcryORVOWZhc=;
        b=eJ76Waw9OyFi3Y3BVExBXk9RaJZREF5kLFNTBkGUZ/p7hHbSlCKGJHqgliLIYT8+Rc
         QKJh1Dv7Xi1hZnjey1Paw8GNKvxBe8WS8ntRLtWjG7w7vX3WmFrvfVC2VcCuApuMdXnG
         84kfCZ8usgTASVlKnbztntrafltiSdlw0oqkhFn3BbbKfwEUJfVt7ZB0D/jCi4p5ccq+
         iT1aOqUrujy8kW1+SOqw/pDjDn/Irxqlt47vgpOlsu0yhD9+gv0Tf/NgStXNwFKUSJxC
         IVJEMz0Bi/b/0KInTFMapZWQDurCzw8EES2KTUygcU/KncmMbnz4+lFKtWYsFUwV+4dF
         5sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094901; x=1790699701;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ok4MWBbItiOTuHBrYY/Sl72bi3aafQGdcryORVOWZhc=;
        b=pi2Wv9TXHvA9DUsf6PVeofNf/2QSgZSDWmW20rPNXtHIzckUhX65yxzudof+9HKyI/
         mtvAd36JDvJYL58GTal6M4YVKDYLcpo+r7iNWDH2ih8DNhCHE2d7QpVumHbHzXRa4Fr8
         hDpQwsK81n4GpH9tbMIaj+0Wzu9KsBPEKnKLBZ2oh/i5/6zfCRIdZjIaMljFF95XKvk/
         zA+fQQG6F1COOCZm+O6SMTCquQKKZ1u8osqsHdDf2nwjD50zOy3QAXDXfm1utLBWK9NA
         SADfD3NZ10DUyq9O76ucpp0MsU5xUdKy8+J5IX/+qzznC6tL9aPjGOouDxixhSWMm838
         lXBA==
X-Forwarded-Encrypted: i=1; AKwUvBw1JcJDNvG7P1sWA7ApRqPMUV+G62RvB4FaRLI94HXoC9Tu8oyxSiuRjAMM/SNiF8x2jLr0Gk8=@vger.kernel.org
X-Gm-Message-State: AFuF++ly3fj5aVlHeD1ltjfk/oqOKiXRUC8Zsqzgr1x4t+a0A2ZYGwDe
	7txbzrXQwx9km7igKpx+8aK6fX0z/4+38EAdRP9p9zC8VE8mFDuhUerXVz4cSEnTGXL3mswGA3W
	GwFAH7uxv53tp9A==
X-Received: from qtbay29.prod.google.com ([2002:a05:622a:229d:b0:532:ad07:89a6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:580e:b0:530:b2e4:d598 with SMTP id d75a77b69052e-532ead55dcemr1649031cf.51.1790094900435;
 Tue, 22 Sep 2026 09:35:00 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:34:55 +0000
In-Reply-To: <20260922163458.3900996-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922163458.3900996-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922163458.3900996-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] net: synchronize proc_do_rss_key() with netdev_rss_key_fill()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

proc_do_rss_key() reads netdev_rss_key[] without synchronization, so a
concurrent reader of /proc/sys/net/core/netdev_rss_key can observe a
partially populated key while netdev_rss_key_fill() is initializing it.

Publish a boolean flag after an smp_wmb() once netdev_rss_key_fill() has
populated netdev_rss_key[], and pair it with an smp_rmb() in
proc_do_rss_key(), printing zero bytes until the flag is set.

Fixes: 960fb622f851 ("net: provide a per host RSS key generic infrastructure")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.h             | 1 +
 net/core/sysctl_net_core.c | 7 ++++++-
 net/ethtool/ioctl.c        | 7 +++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index b757faead4d1a3e445e54d2f468c38c9e09b6762..0127b4d03e5251e0ad695aa649d0c52c2248bc8c 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -95,6 +95,7 @@ extern int		netdev_unregister_timeout_secs;
 extern int		weight_p;
 extern int		dev_weight_rx_bias;
 extern int		dev_weight_tx_bias;
+extern bool		netdev_rss_key_initialized;
 
 extern struct rw_semaphore dev_addr_sem;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 23310581f494553e3ad8c4e010c7799e04f976c0..473c162736d6928d13d22e9902262a43705196d9 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -337,10 +337,15 @@ static int proc_do_rss_key(const struct ctl_table *table, int write,
 {
 	char buf[NETDEV_RSS_KEY_LEN * 3];
 	struct ctl_table fake_table;
+	bool initialized;
 	char *pos = buf;
 
+	initialized = READ_ONCE(netdev_rss_key_initialized);
+	/* Pair with smp_wmb() in netdev_rss_key_fill(). */
+	smp_rmb();
+
 	for (int i = 0; i < NETDEV_RSS_KEY_LEN; i++) {
-		pos = hex_byte_pack(pos, netdev_rss_key[i]);
+		pos = hex_byte_pack(pos, initialized ? netdev_rss_key[i] : 0);
 		*pos++ = ':';
 	}
 	*(--pos) = 0;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4b0bc503f9307880e436d5ee30f75476264a0c6b..b2820f02ca2790a8a3c13395e20040ee6976006f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -34,6 +34,7 @@
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 
+#include "../core/dev.h"
 #include "common.h"
 
 /* State held across locks and calls for commands which have devlink fallback */
@@ -1302,11 +1303,17 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 }
 
 u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
+bool netdev_rss_key_initialized __read_mostly;
 
 void netdev_rss_key_fill(void *buffer, size_t len)
 {
 	BUG_ON(len > sizeof(netdev_rss_key));
 	net_get_random_once(netdev_rss_key, sizeof(netdev_rss_key));
+	if (unlikely(!READ_ONCE(netdev_rss_key_initialized))) {
+		/* Pair with smp_rmb() in proc_do_rss_key(). */
+		smp_wmb();
+		WRITE_ONCE(netdev_rss_key_initialized, true);
+	}
 	memcpy(buffer, netdev_rss_key, len);
 }
 EXPORT_SYMBOL(netdev_rss_key_fill);
-- 
2.55.0.1082.g2b9226bbc0-goog

