Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498F4CE688
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545730; cv=none; b=Tf3hiScr6350WGcooPflxUjEg7G3a6b7FzuALZDbVOSvVZKI/1KCk+CmpkgCyjZMd8t1ROczw7hT3UBjehSbLjQc3FY5NU6YHus3PG+SjhtdPB5AmMnpRamN9SbWT4llv23uuVaoTOxuxhXWKuERezkv3+T9yuO7s3WiE+WkGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545730; c=relaxed/simple;
	bh=8dxMAz/3bVniLT9GlqZAEGuXrm/1/vBKQ5LFvnkTugg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYKBv7wzAEeeS3ZswkFlJD/6ZfNRbAXkqjPf8UudYOOIOi4DrL6++D9nImCcKxdV75SJJ0R/ZgUamyD94mmHuPrigIuOaP7EDkGZNPe0mwjH2d00BkYLIsfuL6Dm4U0L/1zDoBeoMTFR6Ey30eKVgww4/Orz4FcixEDLgu9meeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsjQgJgf; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsjQgJgf"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8252259f6d2so2570858a34.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791545718; x=1792150518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mHvTL1gZeI43MeOEN91Zyrc10MwgGLl2JxNH17x0Xk=;
        b=SsjQgJgf0jfRmXBvzgC1C3x7dWYQvWGCRETZtxy5pPYoLOO7VxdSt48mT2Zh5W9TwM
         0eqpTEUgJVErR0dlSVQvcnfW3RoisGZEMNlMzjbsyNShQBwUNC+9nzwNzU5d28Xl1aVQ
         zsxhLyrZByAB3rc7sLzS07T3yfZsjMlUbV+QR5+g0Xb0dJR4rG6o9yreXhfROeWBFQZh
         Q1pF5PMZVtrJPiZXSQzLzS0UdwO3yImuT4TGmih1Uw9vRvhy1/asVwzTwA8ogw3bLghg
         Y9Qw6Z4Zs2wbVKh4qJz/SeDj43Up/aNbuSTNfA3v4Fcfhue76V7C0QPsR3Gd+n6w3Cxe
         5Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545718; x=1792150518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mHvTL1gZeI43MeOEN91Zyrc10MwgGLl2JxNH17x0Xk=;
        b=qPghrI08/3+eSlu2saEHNrmUCRjtYO40HhK1kKrLVoTo//b/8+HsJpQvVAj9GPeF+F
         /M/BPX7tFCWfbQpE1uF65h2i4DfgPnKuONKb0zges4pLSdhtDOCrmV1h9tbj4W6kgba6
         th07TN/V8yVOeVyrbUhv1dLxVskFjl0cdgChJLM/nhm4Nmti8FgBEiZ1frL0Cg7PghtB
         HUBYyRm2SPmroi9gcDQPsFm/WB+ogauWK/jgU4KlvC0XSXj0S+HaHjJ2JWccqjQ0I3hj
         Q+QWAVX5G41nCF1jmbKedfSo1pJQswHRmTohdVKeUPQZbzv+2RuE7hb/zDkMxXNuEkqV
         8/xg==
X-Gm-Message-State: AFuF++nh7YFJ6URmIUmIJ/OeazGJDhpTdyQWUOVGerA+hnwz7NfDxm1E
	fw5bMEQKuSWDa0rKePIG8l8ni8JhpViW+nS1RT6zrrwSMtHMUXJ6yaWz
X-Gm-Gg: AYBFou1LPj+i9DsN5hXK2qgs56si9ScnCGEAhKCy+mDu62TNmXrRCpgVlwbm3MIFMIo
	ikp7vgW0+gdRMFSfywCEyoTLrEHpZoj8ZDndegzsIhGHsuoTTLypolr2NrsVqLIfiPf4gDvntzw
	1DeR9zCwvUHVSBk/ke+O2H0Hs9yhaIjO2UsCmjVip9W1CzSmWWEd1Er99aP+LryeUoCfLkfceHo
	IxtvKXOgi/d6dw/AgGQRed/C6VXiLcOCyg5kSrfyylV9LTDS1Xs/agmWPQ5dJrlh4ABLcrFB32+
	4OYc7XJ690dacI7xiI9jg1Bkmk7aFcQqRQER25YADoOk+E2WLuv9MKVfL0Noyp/TbTMl2MNd9ec
	6SfTwM/fdQ6Hj7uJ4imohwicyPmvntbCGVrkqAZeqQ1/JWu8SgpsM1dssrygyKvD3mJmWQQwMKA
	FeK0jCHUX1iBvmUJYi+WJ5mbLOrg2Z6Ikdh/moIbrgk+Ul1CTLzoG18d3x4ja2bdaSA2Q=
X-Received: by 2002:a05:6808:4fde:b0:4f3:e98f:fa26 with SMTP id 5614622812f47-50c56deebe6mr1294753b6e.58.1791545718327;
        Fri, 09 Oct 2026 04:35:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c120ae6sm1609891b6e.17.2026.10.09.04.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:35:17 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 09 Oct 2026 04:35:05 -0700
Subject: [PATCH net-next 2/4] eth: mpnic: report per-queue stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mpnic-counters3-v1-2-7dc7644cc500@gmail.com>
References: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
In-Reply-To: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Expose the per-ring packet and byte counters through the queue stats
API. Counters for deactivated rings are reported through the base stats.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 73 ++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 5164475a0f94..c2f4a326a8f0 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/types.h>
+#include <net/netdev_lock.h>
 
 #include "mpnic.h"
 #include "mpnic_netdev.h"
@@ -146,6 +147,77 @@ static const struct net_device_ops mpnic_netdev_ops = {
 	.ndo_get_stats64	= mpnic_get_stats64,
 };
 
+static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *rx)
+{
+	struct mpnic_net *mpn = netdev_priv(dev);
+	struct mpnic_ring *rxr = mpn->rx[idx];
+	struct mpnic_queue_stats *stats;
+	unsigned int start;
+	u64 bytes, packets;
+
+	if (!rxr)
+		return;
+
+	stats = &rxr->stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		bytes = u64_stats_read(&stats->rcq.bytes);
+		packets = u64_stats_read(&stats->rcq.packets);
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+	rx->bytes = bytes;
+	rx->packets = packets;
+}
+
+static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_tx *tx)
+{
+	struct mpnic_net *mpn = netdev_priv(dev);
+	struct mpnic_ring *txr = mpn->tx[idx];
+	struct mpnic_queue_stats *stats;
+	struct mpnic_q_triad *qt;
+	unsigned int start;
+	u64 bytes, packets;
+
+	if (!txr)
+		return;
+
+	qt = container_of(txr, struct mpnic_q_triad, sub0);
+
+	stats = &qt->cmpl.stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		bytes = u64_stats_read(&stats->tcq.bytes);
+		packets = u64_stats_read(&stats->tcq.packets);
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+	tx->bytes = bytes;
+	tx->packets = packets;
+}
+
+static void mpnic_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	struct mpnic_net *mpn = netdev_priv(dev);
+	struct mpnic_base_stats *base;
+
+	base = netdev_lock_dereference(mpn->stats.base, dev);
+
+	tx->bytes = base->tx.bytes;
+	tx->packets = base->tx.packets;
+
+	rx->bytes = base->rx.bytes;
+	rx->packets = base->rx.packets;
+}
+
+static const struct netdev_stat_ops mpnic_stat_ops = {
+	.get_queue_stats_rx	= mpnic_get_queue_stats_rx,
+	.get_queue_stats_tx	= mpnic_get_queue_stats_tx,
+	.get_base_stats		= mpnic_get_base_stats,
+};
+
 /**
  * mpnic_netdev_free - Free the netdev associated with mpnic
  * @mpd: Driver specific structure to free netdev from
@@ -176,6 +248,7 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	mpd->netdev = netdev;
 
 	netdev->netdev_ops = &mpnic_netdev_ops;
+	netdev->stat_ops = &mpnic_stat_ops;
 	netdev->request_ops_lock = true;
 
 	mpn = netdev_priv(netdev);

-- 
2.52.0

