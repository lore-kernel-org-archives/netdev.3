Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDADB4FD279
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015884; cv=none; b=n+fPa8azhbmbGLLvzKN03Za4RuHA9KZtDmxfxa5BZOEoKAkUJgDSo8TI+0dHylqCIQ9rcXlq7U4kpX/CZX4uvjx9IqcohHTczNOezIWGxwPy2KktahMwcYK+fDKOYCe6FsU4jHiU7zfr3ir0erLfREOu/0jpw7H8reTkCZAaQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015884; c=relaxed/simple;
	bh=JWXnG65qDAR3nc2NNQVBHHZqC5ePa0NnANIiel3wC1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ysthb28O0kY6MASOjruL8nCkpCK3E1Q0P6idIhSS76eQ0vBhTbVTk3VmRGp+bZflErnrTl+OEz7jS0Fk4jrTl5g+XYCLIeQ4q1mpKSZekTVlMpPj4uy4d58AUg4pw8fuP1KVlDqncDa7sDBBxG5eGF7E2wVHQLo9qXtYkq5mG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5Tzc/vJ; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5Tzc/vJ"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-532abbd5a51so56311121cf.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790015882; x=1790620682; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Gb6zRczsns+UrbrubIMKN7GDeRyCTA3JBV/2d9OGcs=;
        b=Z5Tzc/vJYLwvGy0QiA0N7RaIjSg3A6cO1LiydNG4m3I2COyIjzcQGwF38mIvx5zYnC
         fVF/OKGmLsczOyzZ46jIPaByO0nmkDwCVBaBECyfIuirH23zgy8tVc+2ae5hz15Yp0Wp
         1JniPu8QLzfX/hcjKkha6W5YVTl5EmDqZkYxFRXL7ZYX2g4dciJfaodKAWOjrxiNygpz
         DdsiDrfLaAqxm6DYlGosYEUVzYlL4m0SZ/Xvvm+haMXZ3ypU06Kcl/K3+v4HFswmL3ZH
         WGlqb0cqZ9XxWmpsJhaHvmHVTQ1BxCl/jPEqPfYbCRyxE949teefCLxUvC9lB6Zx+MQZ
         O6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015882; x=1790620682;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Gb6zRczsns+UrbrubIMKN7GDeRyCTA3JBV/2d9OGcs=;
        b=d205QGclTymyP8PtZ+lyQRo7Sx8Udm95EFYT4J7xrLzXPuL4l/hKo5qXBbRzbisKMz
         +U29qatf70jmS62wBxURy7wBszP4Fc/kp6nLvtssk2phfvjI1P5JEVE0BzDj26cAthDf
         eqcsQGNS2s+hecbAqhKDskthHPebSO8o7G8zKPLfZ2Dtblt5W5EE702eUUazI2Kl0kyw
         csSwYxNfhT5YXOD+B05rrQSYPKao+ukCGFt41uPsMoEsWGHZBQ/OmhSdVMjfAj+ICz34
         8lhqyd2Z+k+jzWdwF73Qj7FdNbNpjllVoBbPsedHal/biHf6FNVkEnIeVELqR7UUNZnL
         kvCA==
X-Forwarded-Encrypted: i=1; AKwUvBysMzkOSyXVl0RsR2CnntalLJy7fxDQFhXGRmf8sHRtr5G6opZHIJItqBbK5H4WvlLydpauko0=@vger.kernel.org
X-Gm-Message-State: AFuF++n6GLvk+cOGciZzUo6xzr4hzCIOFbjmEMU8glblKlGtXezYgvjx
	LrpWRh1lk5AtpBaVqZJy0xADN4cEmQOReL4KHZZZVJ9kt9/1mIFdtP/hPrMz06XC9LWJREZvsu8
	yfBc+mlN6+wY/Ug==
X-Received: from qtbdq9.prod.google.com ([2002:a05:622a:5209:b0:530:dad9:746f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:558a:b0:530:41f5:f695 with SMTP id d75a77b69052e-532d8e0cc20mr17417211cf.32.1790015881586;
 Mon, 21 Sep 2026 11:38:01 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:37:54 +0000
In-Reply-To: <20260921183758.1812310-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921183758.1812310-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] net: synchronize proc_do_rss_key() with netdev_rss_key_fill()
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
index 23310581f494553e3ad8c4e010c7799e04f976c0..e30219765db3991f46fdcb96236e7eaf0878a0cc 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -338,9 +338,14 @@ static int proc_do_rss_key(const struct ctl_table *table, int write,
 	char buf[NETDEV_RSS_KEY_LEN * 3];
 	struct ctl_table fake_table;
 	char *pos = buf;
+	bool initialized;
+
+	initialized = READ_ONCE(netdev_rss_key_initialized);
+	/* Pair with smp_wmb() in netdev_rss_key_fill(). */
+	smp_rmb();
 
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

