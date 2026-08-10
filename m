Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BD3AE6E5
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365549; cv=none; b=CeME8fsg1CAw+r8YyvL7DNQgKUKmjv7zUpESmlz/IdvBjvti+ABdHDxXOxHZUEpTkZSzD4Hx4FpX+/s1LZyAo0tIDrGcauVk6dNZqediOkEO1Gz0ls+wAZfkYM0FGHbVjs5yhi1LV/MfrYbJH0cZ6koBrpMk7wWfPRk3y11jn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365549; c=relaxed/simple;
	bh=RiauInVACv9oIOx+NqLlF7ICmj/eQk5U/vnXep2iR8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAnObhXQ7mYNKju+1HlLJkV5pPD6DrtML/jyNsBO1wHGLh2T1fmJNjln5wFS74pSquk18EZ1yvulr+W0k6T58mk1vxfdB+f1K3cQ0t7w7/xEiJcj1xySjQfvAlz4HmXJFmK1INaiYX7X66peh3Ifm55JVOkOR0OXVYkJSv0ZjSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqEySO9w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqEySO9w"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954df200ddso12288475e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786365547; x=1786970347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZEdQ2A6GGoHnGpTa3UasQyiE4AH49ki9i07irxjtKrk=;
        b=UqEySO9w3x8xyMDxGmoCOf81zMDxJzL1AxZapNkzrESHXKd6vViKBPmixI3F0xUOAf
         GMQ5VyUtscAY8SgvrHS87OsaqF5eZME7O0Wu0lYxGYlP1i0vc6eVMM0JVRXnk2rycDya
         +fO6cC2OKwsoyDv/lj6cKztKe9Z4tS1eeU1b9SPDtNZPYmoV2yJyMg5dpOru/w/HmFux
         a5FnfDAi+GGv391g18L2XaYjhNYUkyX4FmS3eNCN6UF7h190ZxXWkTiT4NY1TqkKP0r9
         s0HUm2QxwrKVgLJbMFpj8nxNgfaYqvjuFGMJcWPBrYdHf4bSTt0g2rY9uhk7b/0Bbqmh
         JF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786365547; x=1786970347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZEdQ2A6GGoHnGpTa3UasQyiE4AH49ki9i07irxjtKrk=;
        b=p363R0MINiBp5kHehkK89a/xNAj2hD3NC6LjgmUAXxXYfDWaQ17CPdR75GBPI8Lh53
         nQ3Evtf2oGC42zXilVEs+q9eidKxW2Lkt1XaZeJ8vzGnrPo0KagC5wFkOCqlZSH2AERW
         Z0I4DNM77PsQpEKgThX7r+pbEsCD+q66BXsLFQAIYXYBup9PclyNYzweeXI7J9PobBhW
         pHqh7QqcP6x4Wx6TRMvqPlVuAR6qR6BW4P8oBMoaAyTE3IAo0WBNqeg5H/NrT548aF6r
         GLeMhLpGGaBOB5pS+Bz2jGENyhrTDH5bTWi6p9HUjJ9/tpdOCyvGyZzYNiUAHjUvDeYd
         fWuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rol2r8hpA6oSsd02gAMHh73hZ/Tg1ZP8eq061kTxYUEesnHlht62TjynP8hrPiBmwlnF0nY80c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCceDq5YeXC8+p0mQ5uJeLt/AjvChVypLxEzIqGGZopEqbfF5S
	JnsRRJsjOXydeFv++3poMeLQUGph84Jtb8X93ulcHuVQVQEQiMbbroT/
X-Gm-Gg: AR+sD128DfqGV4XLDeOoyLEtvI8yXk+W/v74XXl+QzRCzoxGS36NktQSCBnG3S2E2pY
	qfv8eKA/s6UEhw+y6GTcaC+z3anHSxVGp482dpR7CFbPnDi/58IFSIcuLZktNY55QWJQb7VVPsT
	MZlwE1QaQM0MP8tFtebR4dsF+z/9CNnL7eVR9VAZP9DIwqZ9Xy9ATJ7xf2ryvKoHrKqlIid7h6T
	VLtDUQYAthUZ+PonAaGwmIyGpjE8Pj5wdf+UAAFcts2X+QVP+4ChecNAKGI4WqtCSA/6ZJ2UHJz
	dP1Fl7jwfMnNwtiLQfeumg0olE1HH8BgXi+kKQGy8CYnT/pSTTsBwBnYG6gKU5P0I5nRaGFY51m
	qK3i5tlMlKkNZP0J03GcY07fOfzxcMxgKnFO+B33kKGSNQs99xGdFjIk/rjOTujWAaD60Y0NusV
	QrXLzb3SefLPTQswhZ3mF80heaRtpwwsZiR/0dyUUrb3AOZSoZ+wJMoZASk079Xfs898k=
X-Received: by 2002:a05:600c:4f4d:b0:498:ff3:71ed with SMTP id 5b1f17b1804b1-499727b9053mr17974925e9.17.1786365546389;
        Mon, 10 Aug 2026 05:39:06 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm421460675e9.10.2026.08.10.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:39:03 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y] net: fec: do not release NULL pages when RX buffer allocation fails
Date: Mon, 10 Aug 2026 14:39:02 +0200
Message-ID: <20260810123902.2611897-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

fec_enet_alloc_rxq_buffers() leaves the loop as soon as
page_pool_dev_alloc_pages() returns NULL and jumps to err_alloc, which
calls fec_enet_free_buffers(). That helper walks the whole ring and
hands every rx_skb_info[i].page to page_pool_put_full_page(), including
the entries the allocation loop never reached. Those are still NULL,
because the queue was allocated with kzalloc(), and
page_pool_put_full_page() dereferences the page, so an open that runs
out of memory oopses instead of returning -ENOMEM:

  Unable to handle kernel NULL pointer dereference at virtual address 00000014 when read
  Internal error: Oops: 5 [#1] SMP ARM
  CPU: 0 PID: 384 Comm: connmand Not tainted 6.18.43 #1
  Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
  PC is at fec_enet_free_buffers+0xb0/0x2a8
  Call trace:
   fec_enet_free_buffers from fec_enet_open+0x1e0/0x504
   fec_enet_open from __dev_open+0x114/0x238
   __dev_open from __dev_change_flags+0x190/0x208
   __dev_change_flags from netif_change_flags+0x1c/0x58
   netif_change_flags from dev_change_flags+0x44/0x74
   dev_change_flags from devinet_ioctl+0x3a4/0x768

Seen on a Colibri VF50, 128 MiB of RAM, on the first ifup after boot.

Skip the entries that hold no page, and clear the ones that do after
releasing them, so that a later failed open cannot release the same page
a second time.

Mainline is not affected. Commit a2ae70c0efe4 ("net: fec: add
fec_alloc_rxq_buffers_pp() to allocate buffers from page pool") replaced
this loop with fec_free_rxq_buffers(), which skips and clears the empty
entries. That commit is part of the XDP zero copy series and is not a
stable candidate, so this is the equivalent minimal fix for 6.18.y.

Fixes: 95698ff6177b ("net: fec: using page pool to manage RX buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3341,8 +3341,15 @@
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
-		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_skb_info[i].page, false);
+		for (i = 0; i < rxq->bd.ring_size; i++) {
+			struct page *page = rxq->rx_skb_info[i].page;
+
+			if (!page)
+				continue;
+
+			page_pool_put_full_page(rxq->page_pool, page, false);
+			rxq->rx_skb_info[i].page = NULL;
+		}
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
-- 
2.43.0
