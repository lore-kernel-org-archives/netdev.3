Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163552;
	b=gcVAWs037msJKKzdzXM8/l6p3Q7Xq7ZuB6hTRNJoMoFQ4pe70yokcV2eCwia4pXhdW8h
	 ZlXSrsA5AJGFJZtyLnHo0O3Y0SVsPS15wvt9EbIDvmt+3zGgs3KbWcArtENz+z1NJ1tz4
	 Ft/EVoQp4jgjjqzggm+r/AD91r7+XfKD2IdLOFiR2WFHKlOXvVQ98KiMwtoKQ0YgnbSV8
	 ZLz6PGXwmfdWsTSx6AgGmifpmoBMx5Yes4P0apFvoU3895a8qCiX5s2BQ2VDGb8ZtAAsS
	 chleD9T3XiTk7ZtOCDdVTmAIQfBKUVkO+Kzp2w1E9jVg7EARQP8oSLVIyKr44M/ELKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163552;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YnVXjbVHXvvZOcIS/H5qlfvrL3Uc9t/RPStARuKZcOc=;
	b=Bu4yulsTxYLwrcFkJGFTWvzUgLI3kydYKNrBTJJKpScxTCjLNACXcKCLlq4puGXAKVkP
	 TmwzcVv9TbgxmylvDyTfB5lalwYKMgKUwENxJpTvRjg/uS0g3s9EaN3lcWTgUwnkHr9+s
	 ZD2/3E/ybC8u3gvlWgFMZLvzApHOOG5XAmiCBYuMPVK9v6dLXK8UPfJNCbOpaCJZNGLdw
	 qzLc1+uawksnB23KX8i8grCzNUS6dKJ3clIVRMXQwpfQW+//UtPnP6tg1IrdKLWX6VXCW
	 hGKjW90W3uJg7DVwHVpWIADKaqsDvVXKopaUXA6/bqHmkyslCONKsVT+UsCk6Nur8Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=jQkdMcxd;
	arc=none smtp.remote-ip=203.205.221.242
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AF606A326
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D5AF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=jQkdMcxd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794163546;
	bh=YnVXjbVHXvvZOcIS/H5qlfvrL3Uc9t/RPStARuKZcOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQkdMcxdP3NfiRlh6mUVlMWqt1oj1rrowcmfLTYFVjnWiOcfpbi8X6Q+bQtQDF2tw
	 P/+5/e3MjuyO9sl9lXRez2mXd5nu35bcGWl6z8Z928QKYDA5yBjt+SArdRGcA35XAJ
	 kMH6xpv8FJerYaO+Es/jFBPr3eBLyWG+BQmL0Z7s=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id B6A9EADA; Mon, 09 Nov 2026 02:45:42 +0800
X-QQ-mid: xmsmtpt1794163544tnio22w09
Message-ID: <tencent_8006708A5820F7E91C2584F5CFADC3E50C07@qq.com>
X-QQ-XMAILINFO: NHTNowOA4hJdCBJvAUSXHaaU/10PjGxjUWXhanrO2Y5v2GZ8gDMMcCEKwDXUfR
	 8CLVmtSTSB0rr7rwKpNJGp1uarS2aLxNYr9kxmgcwJxs6oZpkctSBzfcvnQ4dg6smLODvmuCBFwP
	 sk0UV7Vahk3l+/EqGFB1y56+JTD4JnvbbxDp5bu53Ik33HaSF4DmjhuvB/e0xgs6c+oa2U/nHky2
	 pxBXvfmpXBFPZ/uEmZHlfk8C0GyZ5B7vLZgohmvUDpeaApBXz8FjS/xNTirj7IEhlREMfnGZNV/k
	 yL+o15q6bEkM4ncBdO0hEqfykjXUElrmU2DnVJg8dTS7vTOKTCs5BIFAVfLio6x8WWps7Q77Uowc
	 O7WbZZdHHAgARsudU55xfSl4QXIo0O5+L1HUnDgN6C0icRadd3Zocuxzu/ItKsxfDHAL80qIxoVf
	 elIkJLvh7paeYROO5r03HpX15IzqQK7TiSQDA/q1wW2m6W1m19yC3XZ9ymztoL9SkA/aYnlW7UVb
	 E8HCp8uV37RxhRxFzwOmr3Vv/A9PAaSvsjm3NvTPplPnHOMfz8CbVFaKHPJBMgyjXEBeULZEG2wu
	 5j5DNezR/T0l1ZVRrM8ykrFve5dgw9OtTddkbXBZ10U+TPDdjSaFfdZFOtI3bAZUqQjPRlJ3Wlav
	 HaZjhIVG5uyE5ZcXhBWwYN5X3wyW/X6MdI3uOoY/5V5WSqljt1hfd84CyIjmZ67RyiorlHkMlOPt
	 c2PngjzQjT6HjuH6sRlA4tPeaIS/W4Z4pMhIfZUo+k3bUOEboPJfmsemJrSemmBYu9xRzg5zxlpM
	 5v5Drwo4SSx2cWR93+iUvDK7TGQGtFe6BGTuh/tbghpDfGg0eYYGf8lAwsDfWDwANuIVJ1QXCB5I
	 Ys6TT0fk6Adxl/bRRen443fzI/kDS6n7PsP4R8nzfFBDvR0Dp7qCZQKemtwfB/2tIzzBpYB89IrL
	 tJ04HmFbD3vvsHar2UNKXPTqdtNcAJgPvfWDj16NWSgyzP9oLWktYpzf/isTlVAe6T+IZ2cPoy+l
	 0k016+PRw0WKHVWsVNP9Q79ZHhxfI=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	79190669+memoriaru@users.noreply.github.com
Subject: [PATCH net 2/2] net: lan969x: fix RX ring stall on frames from inactive ports
Date: Mon,  9 Nov 2026 02:45:41 +0800
X-OQ-MSGID: <20261108184541.74618-3-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261108184541.74618-1-memoriaru@foxmail.com>
References: <20261108184541.74618-1-memoriaru@foxmail.com>
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

From: Zhang Hewei <79190669+memoriaru@users.noreply.github.com>

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
Signed-off-by: Zhang Hewei <79190669+memoriaru@users.noreply.github.com>
---
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c

+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c

@@ -3,6 +3,7 @@

  *

  * Copyright (c) 2025 Microchip Technology Inc. and its subsidiaries.

  */

+#include <linux/err.h>

 #include <net/page_pool/helpers.h>

 

 #include "../sparx5_main.h"

@@ -113,8 +114,15 @@

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

@@ -258,6 +266,18 @@

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

