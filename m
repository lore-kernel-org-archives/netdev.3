Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB283A7F55
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086587; cv=none; b=Pdj19EKmE7QJxI2S8NVex0Gg/wMUsVHdvnA+12TBz6aySfLx5Ea1y2HKfR8GJfGqKYxl/mtbPSwD0PlgWZTnuq/U2e+pAoDdvshWo7A9T4b0ukFuUYmYBj20C6x+FRiQJBFcI0CpboJnWCVBpyvbHYzzw4Popj9y3wPZ7A044JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086587; c=relaxed/simple;
	bh=kU8n87TYz+UCfnzSKQ39bsgXgvURXkwoGXpt3nLZNqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pT+1I1Iknx81bkTv73HsqztkvgqXO+yqRgT/PieX9p+zvNFOGrOnW/w5sPid/vaCS0ty/BKQttAaXNZZzicxTjlOEjkSsMNnGbQoiQetxMCLUzjdJYaSRoFGpRDZpogx7aVkhmZEkofysceVG9B54VmeFXjPz/FEXveRca/yLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lb+M0q4Y; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lb+M0q4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0k
	y09dIta4QjCQbWE773MIrFnSxRcS4gB4I4E5BcI/E=; b=lb+M0q4YTSqVA1X495
	V6bhi7n+kUR1Cl3+bW/VxcoNcMwoAGDBM6eiy5LtMz/PVdlicUNip13iOoy1n3RW
	OegvAiq8ZMPht55lnA5OZxiW7pVwPgVKLdScum38NA1kS/rt8AAmb6ag4fwUaHuR
	LFKhmmnRo5fUmKPp8niOZET8I=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3VhachHVqXqFCLA--.40526S2;
	Fri, 07 Aug 2026 15:09:18 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2] tap: fix incorrect variable used for USO check in set_offload()
Date: Fri,  7 Aug 2026 15:09:14 +0800
Message-Id: <20260807070914.112698-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3VhachHVqXqFCLA--.40526S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1fXF1rXF4xWw47KrW8Xrb_yoW8uFW3pa
	1UCrWjyr4kJrW7Aa1UAw10q3y5Xws3Jay3Cr4qya4FvFy5GFW8uFWS9ay0qFyqg3yUWFy2
	vFy2yFW5A3WDZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrYFAUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-h9Aq2p1hJ-YnwAA3J

From: Rongguang Wei <weirongguang@kylinos.cn>

The USO features in set_offload() incorrectly uses feature_mask and
features argument.

The USO feature was written to the local features variable instead of
feature_mask. All other offload bits (TSO, TSO_ECN) are stored in
feature_mask which becomes tap->tap_features and is used by
tap_handle_frame() for GSO segmentation. Without NETIF_F_GSO_UDP_L4
in tap->tap_features, making USO on tap effectively non-functional.

Keeping the USO handling inside the TUN_F_CSUM block avoids enabling
GRO/LRO when userspace requests USO without CSUM.

Fixes: 399e0827642f ("driver/net/tun: Added features for USO.")
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v2: Fix more incorrect variable in USO check.
    https://lore.kernel.org/netdev/20260806163949.2807698-1-kuba@kernel.org/
v1: https://lore.kernel.org/netdev/20260805072121.117472-1-clementwei90@163.com/
---
 drivers/net/tap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5d2d34d24ce8..d4ca2fee538b 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -883,7 +883,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 
 		/* TODO: for now USO4 and USO6 should work simultaneously */
 		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
-			features |= NETIF_F_GSO_UDP_L4;
+			feature_mask |= NETIF_F_GSO_UDP_L4;
 	}
 
 	/* tun/tap driver inverts the usage for TSO offloads, where
@@ -894,8 +894,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 	 * When user space turns off TSO, we turn off GSO/LRO so that
 	 * user-space will not receive TSO frames.
 	 */
-	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
-	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
+	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4))
 		features |= RX_OFFLOADS;
 	else
 		features &= ~RX_OFFLOADS;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

