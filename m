Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710586;
	b=BVaDz2CMzPKxt5MJQvxYgW+Mhru6xMVjPIQFqqDYMQZQkN2M6ugzNzSdch/LNZjKUGX4
	 O10SxcmPC77jYiUpBbWWUf6yMFKuDSwQQot0A3DS+VHkAsDhOoNJ9UC6YgDmy8QMKh4KP
	 Er7kHZhcodaXd9E9hBzO/F3A8dgmxzNsHH/U8XjgLyI8qdtRcEhNAa5/o3bqV6dzQhVuV
	 upa5Je6GE2YZwAHLw3eyEFvHlZ6RjU+jp+ITPYgQzHyvdscaP7g78I+PyMlc7XMGWGS+o
	 gpYADOq/Mdel689/tpI7ljExz3o707ojmQtRLqYIaHw5NvPICaljBxP7l8u6TjCnt/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710586;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uH13mQpzV9Qg3C7Gc/dwTDgVhjZUqj2wVampWKWbNZ4=;
	b=JMjFtAEieRBbCLad2aF5ZT4wZJY5eocpKEowo0yChydNkQpaUS167aLEuiBTH+ZYHIpb
	 AknoEvyioBhDHvSdSLv6fEyvdr5UMg81Nkn497ZcPb6yzvbCZNyZ3tK2uI2lRHCmvUm9Q
	 fnZa29WQFQ6itHbWSd0WVGwHZtS55wes1qnu2rcll950+foW48FdhVT1cTaEOq+oBJvkK
	 T/WpNepZQa6ZgszLSo6m75bLLZ2qd7hcdHV7n+ZkToZsYUId7QAc1haPqZxF9nEcS0t6u
	 qKJiE5URlZk7ovt+MBscQfnY9E9Pu/zfB9i1J57th11R+eT2ZHjb+7jByAhve8Al+aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S4VmdxU9;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E90606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E90606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S4VmdxU9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793710585; x=1825246585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IP1VZKNwfr8A3wSU6Q8+OlxxcXib24VpMvF5OTsmXFY=;
  b=S4VmdxU9CHw8C3f1qtFTJ+71Sm66aW3T1++gHsgY/Rx2N9/TkUxUuSm+
   l1K+7MKZbNOQ2vzJIT0xggjBrLCiDGb53AQQDEcdiwlD8Xd4GJjtzrJIs
   3eOJbQE/eu82D9xL1lOTr/xnx0oIsD2bu9+AtEsX/tpVyU4QaicrnESSJ
   x2xgQ41iQrj6c0705FMo7PtzCof8Vhtncy044h0Sp++rAOM2uoEnc6LMT
   2/BKZHY9vOCiZUATfVNx3ErBYKHXCbkrYceU5A+Zj46tCYMZGKNY6Dsmi
   72GobYEa+58SWiJaWNGLf2H57eYL6axc6DK4dHPFl7qEyV3p/jYM3kRXa
   w==;
X-CSE-ConnectionGUID: D982JkhSSveZr/dzJrgdDg==
X-CSE-MsgGUID: VLf1N4z+Qmu1kTWddCCHjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2460807"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2460807"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:56:24 -0800
X-CSE-ConnectionGUID: TFQRSRCiRPGx64D5YioraQ==
X-CSE-MsgGUID: MZaRRrDuQFmi0FnquCQ8VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6316907"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 03 Nov 2026 04:56:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 10B2880; Tue, 03 Nov 2026 13:56:21 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] net: thunderbolt: Prevent Tx descriptor leak in tbnet_start_xmit()
Date: Tue,  3 Nov 2026 13:56:20 +0100
Message-ID: <20261103125621.1111198-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261103125621.1111198-1-mika.westerberg@linux.intel.com>
References: <20261103125621.1111198-1-mika.westerberg@linux.intel.com>
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

Sashiko pointed out that tbnet_start_xmit() may leak one Tx
descriptor on three error paths jumping to err_drop because frame_index
is not yet updated but the Tx descriptor is already used. This will
accumulate over time and in the worst case run out of Tx descriptors
completely.

Fix this by subtracting the correct number on error path.

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Closes: https://sashiko.dev/#/patchset/20260902082128.1148463-1-mika.westerberg%40linux.intel.com
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 30b3568a83fc..febf5e5a8be3 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1148,13 +1148,13 @@ static netdev_tx_t tbnet_start_xmit(struct sk_buff *skb,
 	struct tbnet_frame *frames[MAX_SKB_FRAGS];
 	u16 frame_id = atomic_read(&net->frame_id);
 	struct thunderbolt_ip_frame_header *hdr;
+	bool unmap = false, index_used = false;
 	unsigned int len = skb_headlen(skb);
 	unsigned int data_len = skb->len;
 	unsigned int nframes, i;
 	unsigned int frag = 0;
 	void *src = skb->data;
 	u32 frame_index = 0;
-	bool unmap = false;
 	void *dest;
 
 	trace_tbnet_tx_skb(skb);
@@ -1208,6 +1208,7 @@ static netdev_tx_t tbnet_start_xmit(struct sk_buff *skb,
 				src = tbnet_kmap_frag(skb, frag++, &len);
 				unmap = true;
 			} else if (unlikely(size_left > 0)) {
+				index_used = true;
 				goto err_drop;
 			}
 		} while (size_left > 0);
@@ -1244,6 +1245,7 @@ static netdev_tx_t tbnet_start_xmit(struct sk_buff *skb,
 			src = tbnet_kmap_frag(skb, frag++, &len);
 			unmap = true;
 		} else if (unlikely(data_len > 0)) {
+			index_used = true;
 			goto err_drop;
 		}
 	}
@@ -1253,8 +1255,10 @@ static netdev_tx_t tbnet_start_xmit(struct sk_buff *skb,
 	if (unmap)
 		kunmap_local(src);
 
-	if (!tbnet_xmit_csum_and_map(net, skb, frames, frame_index + 1))
+	if (!tbnet_xmit_csum_and_map(net, skb, frames, frame_index + 1)) {
+		index_used = true;
 		goto err_drop;
+	}
 
 	for (i = 0; i < frame_index + 1; i++)
 		tb_ring_tx_more(net->tx_ring.ring, &frames[i]->frame);
@@ -1274,6 +1278,9 @@ static netdev_tx_t tbnet_start_xmit(struct sk_buff *skb,
 err_drop:
 	/* We can re-use the buffers */
 	net->tx_ring.cons -= frame_index;
+	/* Return back the current slot as well */
+	if (index_used)
+		net->tx_ring.cons--;
 
 	dev_kfree_skb_any(skb);
 	net->stats.tx_errors++;
-- 
2.50.1

