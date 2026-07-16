Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4B44606A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228689; cv=none; b=kPUFt1M5vUFQOnZcSYXOFXWxkFJoVIVwaZ/z5irS8OIxH+z65kw1I1HYelPZWBNKWhjs2VodqV2ARt4+ixIDbFFpJrxWkCBddiMzLaouzGYsGKxw3qaVMZR444FDJj0mtQsOXq8EdWXP/pmIFlHnUktpO7LfZcZePJ8TcrN86yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228689; c=relaxed/simple;
	bh=74hhdpkR2SQ9xEqjDXLASI3jl5YFzG4ZscXJcDbyIm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdYaVH9yRgwtNLOt6wY0eurhACkRgWecBFo3Lpe8dv6GWL10FyZpOHnqjWz0ifqJfA2SwuAju2VM8TVLb0BTYneTqhn+O8wR0dZOJpIsOVTaq8V7VA5ywqTmeC6qrA14sWmL6hxrjss5cISxZ8LuIlTfQktB/+GpGAc99msTCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1X8spmQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1X8spmQ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso4594820a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784228687; x=1784833487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zgfrO/0HYYLRVpjEObCMBNM2xUCOM8AeWfh935gmJc=;
        b=J1X8spmQjsztN3hMZV5ECwSUjBof55vw/0c1xBUHFFWMUeDwh9D4q1Ormj+no86+9h
         s8xRQstjoExRFElkTJORzs0/GEsXWJnuXFgLZRnRQQCVsKoKg7YBATXP/LkqS5MdoukM
         DhJjrPOQO4yTzO6AqymURi1tN/CB9Ejp7g3KXk9fQwzT85jhRfsLGR5dZoOixKdZMN1A
         mmSz/pRhdLhfM8LsR/3K1AbrSAcjF7ai4jfNX0S4OjF7O5+vfeJlBzpzw3K+FHBhEDxC
         8qoG3BGUHG44c0jCtaBjnMpJc1+PNFpxTuxXTxHcq6UvFAnou5er3nYgNxLJh/WOgwOt
         hO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784228687; x=1784833487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2zgfrO/0HYYLRVpjEObCMBNM2xUCOM8AeWfh935gmJc=;
        b=O9W8yxI2sW49IpLWuUmraAaOjt27WaU013Lj6EjqVx74uS3s7Z6lZnRmC9FwyVffEw
         l0Y0oYVlMuwsHx87MoOfhSoes7NGx0zPczkusnLdK5sI30y9jL0Ky7Z9Ynd6PfnyRVOk
         nH3QGnIVuC0GzlLzqjATEeVfzYIaHwxVkjiDT4fEpCdCpRmtkGoPnp88iSPFjD4rrNZV
         nZQYjM/oi95Qf9jNIBZBMph6dBNkE4WWek0XKup4dsg2RtWm37uwtvSJFMq8XCQ9g1qy
         zAht6LFp7V9ttAmoqWURpBKDpMWFrfY52VsNfAfjB7U29E9l+JmV3/pYiUyeVNtdTKyz
         8zcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9pMvvg9HTVHpX19TLnKcFCQLq+6NWYQ+E0L1Fg+HQs+LeSKxJXYTqN0Z6CaMD5ABZfDMPejk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyNpz/3W07hCz6iKzYCMLL4NYPJwNA6PCZ7xShA1nM9r7HveR
	Yp290pdZCCLBeqyr3Nt+NeyAJ7PWdrgBM2bO2QWv0x1GwYZ8fN+r3LNu
X-Gm-Gg: AfdE7ck2DOPa5Ikd5s2308Ro1O9AV3mRwRtl69xEqGPbOBDuM+1MTbfVuN3Uus710LV
	9N6T4UeHdUQDX085T0TdIx525vINablahh1UsAp4goKYw1EQY4B5e5KDWIV8QeXWHRhMxdz6F1d
	AVJ3yhlySUTKR6MOpjYVlbVdRq2zWsnRwepX0YdFh6gHfySBEHHoA292AAv+Rpu+PvUIIB6bpWK
	CGTP7T0fm7GCJWD4c85RMqw+JQdCSE8zhEadiQR671vGK9jLfmkY0Py+Win7C6so/qvXp2b/tMG
	bpPQ7INoMyCndSe/qRWDZMxdavffCLsWM3JI2hl8FabT5WiLEBnKVfMK/h7frMZ1WKEZB4V+4cH
	tgmIN1FuAF4eSFY8DzpPjJh6o7msZ4pYNy1lGhFsm368DV7RtzMnIZUPsrRUkg0bvxLMItilxnY
	nykb/cjPCvmkZMDDZJy0M+eFroMXF84rvW0sYg0EAcjR6X4hc=
X-Received: by 2002:a05:6a21:a517:b0:3c3:89cf:f55 with SMTP id adf61e73a8af0-3c389cf13d3mr4836407637.61.1784228686811;
        Thu, 16 Jul 2026 12:04:46 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4341a37sm11580151c88.12.2026.07.16.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:04:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Hoang Huu Le <hoang.h.le@dektech.com.au>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4 2/2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Thu, 16 Jul 2026 12:02:05 -0700
Message-ID: <20260716190204.100895-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716190204.100895-2-bestswngs@gmail.com>
References: <20260716190204.100895-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

named_distribute() ends by stamping the last_bulk flag on the tail skb via
buf_msg(skb_peek_tail(list)). When the publication list is empty no skb is
enqueued, skb_peek_tail() returns NULL, and buf_msg(NULL) is dereferenced.

tipc_named_node_up() runs this on &nt->cluster_scope. With a node-id
configuration cluster_scope is populated only later by tipc_net_finalize(),
so a peer link that comes up first reaches named_distribute() with an empty
list. It is reachable by an unprivileged user (TIPC genl ops use
GENL_UNS_ADMIN_PERM) over a UDP bearer in a user+net namespace:

 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_udp_recv (net/tipc/udp_media.c:392)
 Kernel panic - not syncing: Fatal exception in interrupt

The peer holds back this node's later name updates until it sees a bulk
with the last_bulk flag, so simply skipping the send would stall it. Emit
an item-less bulk when the publication list is empty, so the peer still
receives the last_bulk flag and opens.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/name_distr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..a8bb7bd101ea 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -192,6 +192,20 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 		skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
 		__skb_queue_tail(list, skb);
 	}
+
+	if (skb_queue_empty(list)) {
+		skb = named_prepare_buf(net, PUBLICATION, 0, dnode);
+		if (!skb) {
+			pr_warn("Bulk publication failure\n");
+			return;
+		}
+		hdr = buf_msg(skb);
+		msg_set_bc_ack_invalid(hdr, true);
+		msg_set_bulk(hdr);
+		msg_set_non_legacy(hdr);
+		__skb_queue_tail(list, skb);
+	}
+
 	hdr = buf_msg(skb_peek_tail(list));
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
-- 
2.43.0

