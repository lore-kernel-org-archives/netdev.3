Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321AF478E20
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806694; cv=none; b=kx81plO0TXm5ujtAoXrARr9QFpaYj5xpUiWtcCSH9aCsA5mipVPjogfLqvGRIvek72h4HBpU2TZCH/m5E9VCvgb29wMRhFjFtSQajVh15KQkKChny4AH0xJl3Mm+8EBq+s0FOolojMKtsgLoUcOzK8vD77P2qRX2BKAQZKVVPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806694; c=relaxed/simple;
	bh=8dxMAz/3bVniLT9GlqZAEGuXrm/1/vBKQ5LFvnkTugg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qcTtW7bCJ3Q4Q5Wvb78Aj2mqkFZUksRMfQ/LvyFstiyReGcuUbYsoH38ITH+K9BzzbK6LkAbbdZT65yMqXMFYE12PT0vdyG42K2rJZgZYHo2hLzhZ5f5B/mqTrvb2KRs87Acfkm68Hb3GJRU7g1VPbK6PR7b03nhiAvKodSYt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9jSPJND; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9jSPJND"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b0496f4bbcso1175522eaf.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806692; x=1792411492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mHvTL1gZeI43MeOEN91Zyrc10MwgGLl2JxNH17x0Xk=;
        b=Q9jSPJNDx1Tkq8AcV5u+537hlyXVR8kKjCwQEK36RpH0rr7qxmkh8U6gUm6d3rTR3Q
         WBeTNXCS+WVyW8G/7wGywAW2B94VNaeNeC8+bqbYle7dHdV/msE/iqS8qGKtKRBflWPq
         GV6oHkK1MvGz4TAkwVPUbQhSk7m1tsCQy3ptu5Jj/6HmB8AYH8WSw0Sc66j5VRuQgb1b
         VFMTnq+DjFEIbGAkYoooG3obOfSGwMc4VK7JZWAim6d63ACeWuSx5KfYPW46V7MScpQ+
         3Qs2x/6QKqTWoN+f0PM1v5arYEtZpkD0CYU6VoY2+u8wO+lH/wK57EAB6EKV8IXh9LKt
         xPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806692; x=1792411492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mHvTL1gZeI43MeOEN91Zyrc10MwgGLl2JxNH17x0Xk=;
        b=11MdNOnPPL5mQ6u1KRtHYrAGMM041ueZmkBQ73mR8ubl8Q6keBroWAPE9fIbaglgsc
         q1L2JjO5tDJJrXzKHIO1ll6oSL9/EgnYDBQPZvsr+MX/pfDlT0aQX3giGF+nFe7K/F1G
         QWiC7msn0nOPvlF905E01er3hiLu+OEBNmX0LCJ9R3kgPQxux/NNjeVMvIjXCUarKTXv
         gDCfkEMrVb5aGjZHfEWafm+9Aho6taWfb8Cj9zpWLVKR0lnqKSF3oWz27dxNKN1/Xkj4
         Pc37SLpl9EteND8JNqWns9FUuPPOg85vLGXY/BZCPO8IjPx1S+5N2p8hfgr7j+nLv+wK
         JkBw==
X-Gm-Message-State: AFq9FYKvqAeg6ghKTN33SkLVgD0S7ZMlxnUPyeSxu05o6LXIkQNQw5h8
	lem2mlgwne7+iZWj0La5l0mgw/8kTx3+GRR1n7LWzRJxkEEM16+0oMzi
X-Gm-Gg: AYBFou0+ZAXibhoYiwklEtWI9QYG5OpmOuR2g+pbFpuGvdvTOa7dD+O+opqDhtp9SvT
	yDSVA0n2mwmhtbnB7x5eSIJLMwtuQJA9s4xDKYUlpFJyzCiaa7Vl4mEVOAsKi8E3onckpuKOhet
	z1s+Dz1NCwxkmy6rh+3d6H+HabZWnQJ5EEf61Q/dEJ1W14zhd7Jd8jrOG0g3VVTF8NK9EqMbtHW
	W15+OZfNIieAt2dysFd30nFcGoFTWTl5TP7xREwE7AGysr4j8Lmp0zmWrhTm9A8I0piWKM/Qqtk
	PfeayhpWoQppt+0tgtj0ykEpRtHz9xQVeDxQt9EFlO64/AWa0u8OBZe/TYUQ1XW7XLVFEqlolNU
	Wmpa4D8rIJ0Nm3+QbD74ViLZdg8fkwdXqJnPmAE0FeoVmVOmnFTSXcIE4ludMLxqfyYXx6MHFS+
	tEEot8Mw9R1J52z0CyS9ULvQyoFEEvGaoG3M9A5H7at6fBfkbd9/1yCKfeBxtL7AyI5xY=
X-Received: by 2002:a05:6820:8185:b0:6de:2f70:dae3 with SMTP id 006d021491bc7-6ef0f7a3622mr7157468eaf.29.1791806691967;
        Mon, 12 Oct 2026 05:04:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a858aa3esm9471911fac.12.2026.10.12.05.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:04:51 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Mon, 12 Oct 2026 05:04:35 -0700
Subject: [PATCH net-next v2 2/4] eth: mpnic: report per-queue stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mpnic-counters3-v2-2-8afba81c2d5a@gmail.com>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
In-Reply-To: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
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

