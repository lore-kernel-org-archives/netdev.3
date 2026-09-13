Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A82FF672
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332079; cv=none; b=lCzQZPlXNBfSaX56V6XvWZvkFP0plt0AGrMWwvCLLpWoCN32Re1W0JTygbDM+l3mDVVsQ8surOFR/xX8eQ7AoDSUCJLB5B0q44FtzLVTKM2FaZGKf0Q6jy3mv+0pLRVWdwJIVKDSg3t4koCBV4V5iF0QSs0wJdD3Zf6o2StzfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332079; c=relaxed/simple;
	bh=iKlS5rdEb+K1g+xyBv39aa4hkcRyjb3P19zjf0ocvlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9tldEWRxyYaJdZzwEd5TKy5AqWweJqt3nyocBBTTwa1JuyEm8Pt9ighc8h9cx7aSQqWXZDv29W79hc4zdy/pR9Bz/8LK/9WNisc3f4A+S/bMw5v2dypqphLOzd0F71FwTcClwjyxYwjY0wTqaTyNJFZ9XrtHM+V4A2YnYhvCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLtbhiYk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLtbhiYk"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90cc64570deso28866376d6.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789332077; x=1789936877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+CNpe8/W4LNtmYoGjyzLBCqquLi4Tz0KDmEKn8Ugoaw=;
        b=cLtbhiYky5zh7WwC0yVMxqQNxjTTDzjQ29CCFR+XunrI4kO+UVXvOeMH/+460FF9SC
         snuckyNZ8fWInezdOOQ/GUuvY0YxQ2e3G0ra24V4cmYtBExAi40D9/yPkrPZ+UjWJQW1
         dXb7clrR92Zt8m40rIitfW3r9hH1zNH6QPAOM1pmHy8dCKu7oDBprXSfgaDtWn74ijQy
         Vuh7xnpCCSUH8DN4R/p/TuqVlzY6ZImf87tksin0i+SapHU5UaOJpp7YX6I7Mvji9WOJ
         C0Owjuul95OoWSLL5WZVWK1/6FfJcg+9xrEHTADlFrles/l0ZhP32dOyV8sWwc26fOuY
         xnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789332077; x=1789936877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CNpe8/W4LNtmYoGjyzLBCqquLi4Tz0KDmEKn8Ugoaw=;
        b=Zk6vkaFOWAPSDpukBrclgA4yKJhIdWgtlClL1A4IHfvn4G5EiBNvHIQ/4GD1Z3M2Kt
         A10QvbJY7Mtp59Cuy4foIE8pWXfq4F5z/p8wvgEhkdpDHIcTiBssoEatffEPUpyPspKT
         T7GSoLkkmrTV/oPRdBw2NZsJQBxDLxEYZQ0TRC17XyXCdP88eIPvJgseqV7vwC4mDAB7
         7R3NfDejNZ84Vt3zdS/8b1AicZZgL/sX6VGQG9xDz43za83NT77Ahk/sv2kjKe90b4XA
         hi45XZDcX2yQMcX/JpxBPAjJ9ypXODeXLdeKCJwoGJxql2IR/ahGYZdl2kCtYyj2lzWu
         +JPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5Yi8etjgdwUf4NXckiPXCMhEKX/Uc601fhJBBDjGyxXAQSSVg6anJnw74iX+lbrTXq0dXg10=@vger.kernel.org
X-Gm-Message-State: AFuF++l6IQE8dY7yhh7tJKMO/dvWDclHbZaqhngMbBkQixWzw9Dpctu2
	xAQZhXWrDt1B4d1OTTmMsr3gZXAShZIjw0PFJNG1xlyao6MMtKMQSPc=
X-Gm-Gg: AYBFou2mZyAkLyWDNiOJOQ80+6IidjdB2TxzMugZ58NdAsOmDbGzXcnlrB+Rjc3lMSO
	ijroftdi/GhSyt6VzIbYKke8n8qPQ9dfnhGeN3B6ZpiMi8FXY163wsjVBM9Smzek/FDZs/9dQGf
	h5RMAH52Zmw+NXN1v1yOjuDjKxicEOgIrY8aEpT09xtcDx+HEqU/Tn4d9I3vTMCRQe6fxK0rSxb
	esx+N1k/OSEsYHLM5/C+BB8s7fkvcaDeKQqxjxFdhI0quPBIxwpAGw3AMIr/XA2IVNuFS0hRATL
	lfQakjoRP63Mo89VGLHzMVBNPf1+wH9zEiPedofGUBwSV0utwHEHpcA5V5W+++r+lc+QGaAcwBg
	H/y78TOelN5My54pVSIAsEuyIklLFAOUt8JdfMQQquGouoMA5pD2Qvaxk9M4Gcl723i4G8PdE3Z
	FPdDvnNKhtGYPX92btguXFpKmJ2eW0PFSNg2axXUohMRYizOnkMfhJ3JLVNZnOYeNH2rpI8s4mZ
	VF87RZlRo8zs28T5o+tkpNMgf2bAkqHT2ISsednqalGCqfEWcAhiYTqdNI5u17vkaUyBInwiJd2
	OJCTV50ENhcZIIaQMwzOosvCnyHmDtXp2G4=
X-Received: by 2002:ad4:5c85:0:b0:910:3923:cc6d with SMTP id 6a1803df08f44-91226bba65cmr48657356d6.22.1789332076955;
        Sun, 13 Sep 2026 13:41:16 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f478bf1sm78134706d6.25.2026.09.13.13.41.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 13:41:15 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net-next v3] net: 8390: pcnet_cs: release PCMCIA window on setup_shmem_window() error
Date: Sun, 13 Sep 2026 16:41:04 -0400
Message-ID: <20260913204104.53408-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_shmem_window() acquires a PCMCIA memory window using
pcmcia_request_window(). If pcmcia_map_mem_page() or the subsequent
ioremap() fails, the function returns without releasing the requested
window.

pcnet_config() treats shared-memory setup failure as non-fatal and falls
back to setup_dma_config(). Probe can therefore continue while socket
window 3 and its reserved iomem range remain unnecessarily held for the
rest of the bound lifetime of the device. pcmcia_disable_device()
eventually releases the window during teardown.

Route error paths after a successful request through a new release label
that calls pcmcia_release_window(). Fold the existing buffer-verification
cleanup into the same path, keeping iounmap() before the window release
when a mapping exists. Leave the request failure path unchanged.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v3:
- Drop Fixes and stable Cc as suggested by Simon Horman.
- Add Simon Horman's Reviewed-by tag.

Link: https://lore.kernel.org/netdev/20260910231400.31919-1-mhun512@gmail.com/

Changes in v2:
- Clarify that the window remains reserved only until device teardown.
- Make the DMA fallback and continued probe description conditional.
- Avoid claiming that every request failure leaves no resource held.
- Restore the surrounding indentation for the new goto statements.

Link: https://lore.kernel.org/netdev/20260731161740.44955-1-mhun512@gmail.com/
---
 drivers/net/ethernet/8390/pcnet_cs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 19f9c5db3..0cf3c0f3c 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -1434,14 +1434,14 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     offset -= offset % window_size;
     ret = pcmcia_map_mem_page(link, link->resource[3], offset);
     if (ret)
-	    goto failed;
+	    goto release;
 
     /* Try scribbling on the buffer */
     info->base = ioremap(link->resource[3]->start,
 			resource_size(link->resource[3]));
     if (unlikely(!info->base)) {
 	    ret = -ENOMEM;
-	    goto failed;
+	    goto release;
     }
 
     for (i = 0; i < (TX_PAGES<<8); i += 2)
@@ -1452,9 +1452,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     pcnet_reset_8390(dev);
     if (i != (TX_PAGES<<8)) {
 	iounmap(info->base);
-	pcmcia_release_window(link, link->resource[3]);
 	info->base = NULL;
-	goto failed;
+	goto release;
     }
 
     ei_status.mem = info->base + offset;
@@ -1475,6 +1474,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     info->flags |= USE_SHMEM;
     return 0;
 
+release:
+	pcmcia_release_window(link, link->resource[3]);
 failed:
     return 1;
 }
-- 
2.47.1
