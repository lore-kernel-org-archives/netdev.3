Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211390;
	b=zLl/hE0rIWe8eMkuzAbOxJPYc6MiAF2ZJYwi6J+aW2+l2AgfuZGVLmJ8iHVq3memNztc
	 HopqCfPa3AeSQnQA4XPJbs8VlDRMx0vwKPJIN3Md0x6js+SnmWkaIBpRFr0vxgL9UzUSc
	 V4zGMvqo/Z2uKeFcyQeW6M/ZKwxiTJoG8lXZbgesWeq5Ie3p+ZXN2eAjUqbGh5Fap15Oy
	 WyjD3UZ8cUqxam0PtPG0fTO5WYScxtLHztPVQ1G0KMIZM3jOmqMKKYaBpFj4+6PjpD+Kn
	 yDT9R5dIm17Cu3tZVrucMisb6/NnRj2pAuqnAwwzQyctpyK24zyPajXxOYbOtYsS1yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211390;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gLD2qdjlkf0C6gK3J3mNyyLmAk5TsTbIQ2KxZYu6xfw=;
	b=b4mB0WPR3alZe7muhd9jE2hrTEXVwja6GsOs+x3ZgAIOLLZzm8PUKxoBLGoMcodyX7CK
	 zphL6CpZThpUDQKj0aC4y5wSlQXYP09xPpkuSwiBLwtqM/V/hdFTHb5++OQTKiInm2vGf
	 kBywTVOPHXjIU1i9ZkImgv9a/JB0S74rmzFOH5nCEFNqH++7cC5YufVbIIjluGo6JDKVt
	 eDriblmjP6+C2reluRQsJyY7VxSGhOCsS3LXOPz1jnSh13xDCvR5Q96YpDltm0rIqozCM
	 VH7bmzUOj0i7em82wC7L8rGqxM0/Loz/4TlDW/2h6iHoXcAA0lhoR6JSYKeNwF+LABQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=fsYrXigN;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9032606A332
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9032606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=fsYrXigN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794211379;
	bh=gLD2qdjlkf0C6gK3J3mNyyLmAk5TsTbIQ2KxZYu6xfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fsYrXigN9BIMDK7MMn7RiqUvqG7i5xVqUpVRGX/QqoAEN+n5FHsLtaZgki3dCjEw3
	 HPnmXBPrGHsH4dG5DNyjjLYAVbyHVBPWz+0lsveTA531y70sC0LWu/C52X1s9FVx6O
	 dOuU719KI8y8shs/FVvDaL796AugEGxs/dNi1T9Y=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B79240B; Mon, 09 Nov 2026 16:02:55 +0800
X-QQ-mid: xmsmtpt1794211377tc6hgx68x
Message-ID: <tencent_D6697325D37592ADABE50686370A7D208907@qq.com>
X-QQ-XMAILINFO: N7NMbzIEsXzdPTi6tMJdatCt6ZYo8LALs0yjKWXBOE4O5wjcz2UuFgHq7o/ur2
	 Oo/BpBOUame5zKuFqPqFW+wgR3c53w49XtVWVTqrLTZ9DZXGIj0Ndzq8uDM+e1gl9BDhdlyd7AW+
	 OVa6OCHoZQ/16jzlS8a0u6J/AZrlX1tX8dR1Q8/c7SkA7Twnm2KWoBSqPbE9XRaFJR7FhOz9nTsg
	 8Ot6n4Arw0tfNw6p9mqD58gLud7idiNgmwq9csVHM/dY0xGg13IpHWafRfIgXVm9CNx/XUroC3NK
	 zW7qQuLou+e8ahzuJE86IrdUc3q+bxG9+/gyYV5mh4HwQY7yT07wDAzCpXTiWE2zPaLKx2I+YFNc
	 MjhxubXvBSFncXL0tp3hZH7GANrYEkjWh42HVKVKBecFF+ETdyRqjo9EHsWAUdk2sWy+LV8k/i2n
	 Ez8pGkLAGwmeMnn28MwCXrShixly+QVvB5ODyxqkNT/CO2Jxdq4gez5YMhKUgcrYEJzmGlVQ9lFZ
	 N9IO88/fgulU4yGT4xCOtnQoH4MAakkBKybJ7aGorlCj9upsUQUk7GcTwbMHu9voTJQNaBhuzROd
	 Hgfe29c5q1NBmF1Ai+JRihkeU5BeixckNxuU4PRXrT8C+vtsKGO4QbJykezEH8F/m/WPLgma3YAP
	 1dqYZNsRNQc2Y4kWDZhkqIr/2Rj7eQf4aNJymqGONm+YRN05XYGlmtJUs0gedYWZykNiLtnqFUJG
	 FdbMUGNDZC+HQ4a83TvTLz8AguObYJFFycomAEad2AjtvjIAZh4fkyuk6nscMJtUjYl6bc1usnrE
	 vFOPIrXwSpGBBk4sjcOVzGgDJ2ohPMSgRQLHMFkO0PlXrSrLLVjsW8tL8mF7h37+eejjxBO2efHV
	 WFZ9K4maVqK+30QOHlY22AIrEpZyVRgbYDI8bDWlvsHvRkKFwt3UHPxAgYYMRE8l9kcGXI1+R46D
	 K+nM9WhVm5LI9PH5nw+KppUJ13NKNZmJM+wByMHez5plL4+H/n0wx1c30djL0DJDyfduWEQ0qeiy
	 SYUG9wGzcnxtFA5tEUT2T6arzLuUz1LXRC63ZkdXtCsHs+t5dR9RPAO4oVdLM=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v2 2/2] net: lan969x: fix RX ring stall on frames from inactive ports
Date: Mon,  9 Nov 2026 16:02:54 +0800
X-OQ-MSGID: <20261109080254.92305-3-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261109080254.92305-1-memoriaru@foxmail.com>
References: <20261109080254.92305-1-memoriaru@foxmail.com>
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

From: Zhang Hewei <memoriaru@foxmail.com>

When a received frame's source port does not map to an active netdev,
lan969x_fdma_rx_get_frame() recycles the page via the page pool and
returns NULL, which makes lan969x_fdma_napi_poll() break out of the RX
loop without advancing the FDMA software cursor.

As on sparx5, the DCB still carries its hardware DONE bit, so every
following NAPI poll picks the same DCB, hits the same inactive-port
branch and breaks again: RX traffic stalls on all ports until the
module is reloaded.

A NULL return currently covers two different situations: a failed
build_skb() (allocation failure - breaking out and retrying the same
DCB later is correct) and a bogus frame (which must be dropped and
skipped). Split the two: recycle the page and return ERR_PTR(-EINVAL)
for a bogus frame, and advance past such a DB in the poll loop.

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.

Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 .../microchip/sparx5/lan969x/lan969x_fdma.c   | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
index 053d125..7234474 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2025 Microchip Technology Inc. and its subsidiaries.
  */
+#include <linux/err.h>
 #include <net/page_pool/helpers.h>
 
 #include "../sparx5_main.h"
@@ -113,8 +114,15 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
 	sparx5_ifh_parse(sparx5, page_address(page), &fi);
 	port = fi.src_port < consts->n_ports ? sparx5->ports[fi.src_port] :
 					       NULL;
-	if (WARN_ON(!port))
-		goto free_page;
+	if (WARN_ON(!port)) {
+		page_pool_recycle_direct(rx->page_pool, page);
+		/*
+		 * Signal a bogus frame so the caller advances past this
+		 * DB. Returning NULL would make the poll loop break
+		 * without advancing, stalling the RX ring forever.
+		 */
+		return ERR_PTR(-EINVAL);
+	}
 
 	skb = build_skb(page_address(page), fdma->db_size);
 	if (unlikely(!skb))
@@ -258,6 +266,18 @@ int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight)
 			break;
 
 		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
+		if (IS_ERR(skb)) {
+			/* Bogus frame, buffer already recycled: advance past
+			 * this DB, or the same DCB stalls the ring forever.
+			 */
+			fdma_db_advance(fdma);
+			counter++;
+			if (fdma_dcb_is_reusable(fdma))
+				continue;
+			fdma_db_reset(fdma);
+			fdma_dcb_advance(fdma);
+			continue;
+		}
 		if (!skb)
 			break;
 
-- 
2.39.5 (Apple Git-154)

