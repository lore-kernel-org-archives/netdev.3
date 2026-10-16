Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DF4ADD9D
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155684; cv=none; b=Kcdq427+m8I20zUxmR4a3bpHaoZgtkDcWdWicD4Sb6xmHoJ23rouGS6HKHk1nzNSBvAp/JYEdVn852Dw64YfgHL3BVHEsGg+wCStZG67mZkCeJlf1i3WO5Bpg3JghD3f3pOxoFLshL9KFwt9Lxs/b//0pyfiesixYKxK5FIRLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155684; c=relaxed/simple;
	bh=zLNCi/x43r+dPYZ+ZjrT65xXB3nkdcDSz7QxgPGzn80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFfvyModPtaRExDQSuGc2DfJng3b8G3KSoOYm3RgSnfLGchqhGzI2ktYjHK/V6/PxvLQy8YEo7zRwLpgES7tEIAGMZ/GCwVKEB9HGQTlNDl1YXRyDW9lX+TRWmaAhI+Gj8DUNMSIB8oqrZYN6D01xKJz6EUPTj2YXdTYSZfFw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfJUyhjp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfJUyhjp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48af4ba4425so1001315f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792155680; x=1792760480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D6SG43mHsHGUs5imH1Rk9lZLOCzzEMaWfOhJt2v6hsE=;
        b=OfJUyhjpk5iJiJJBLciyxNtmfHa/lMAgpFGFyWWxfZjqjW1kY3fy8pbMJc9KtPQHBA
         CSozXvMJebwvarT8jnWOS7M7BzIJqNobk/pU7T5MkyIdlrGE62i8fnGM6rHXvgg0E2Nl
         nOVUzk/RmXX96KiHBwPFLRodHlZhVe38XI8J8tn/2IO4s9qcKBQom2iXkHjHNlSj5SsB
         6vidzkJKlOtFqcwbopdsTR0aD/veIE8ImFtwjOpsXagqj6LHZPA7p4oEhxdwnB9B2PbA
         25Kfmhk8OhzgTFGPL9tnu7UrQe+BJUsjRqNapuPL+0FVcRtoXr7FW2dCha6FMw0uxxl3
         Ig5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155680; x=1792760480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6SG43mHsHGUs5imH1Rk9lZLOCzzEMaWfOhJt2v6hsE=;
        b=lmVTBtgNSXiqe+x+9rfmVq5pUHGMI2xtPwURH4GmYqqtKEWFf115HeDpxeQWbmRL+4
         v9mwkTkx2ThF5qsdQxgdb/S3u7KdfaHhb07eONL2pgtUbijGqBRZ3RfEyIV4phz1Yc/v
         0OtkP491fVFVoQk+rAthzRSKBkqIdVmx5rdoeTKupImDShbqWOLbqfGX83oC7ntzI0Ay
         8kqElMVgnX9yFnKXqzT+MfFrL8/iadM6RvB9OPIwhKdL+Jg/RKaZakFpi6sAWMlbTLia
         vgUrB8XweXlpdqBMKBXNLNpOc56TgKVlreyBsguYsn1m5PlJ1TkGK7jvsOBzhtm9uqWD
         nphw==
X-Forwarded-Encrypted: i=1; AKwUvByiKOmQYniO92Xh/u5gybn9jGKZLv4pJkzmHa3ZIJG84cjc4vUonS75onFwIpfdcp6Kw0c7i2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2427rCnT1uLRnETqtPiEPx1QPoiVlZ2QEfPcUh8wOF+Icwi8G
	zXTIC0PYKXwIHP3haBwjSBugzENE5vt05hAc0ilZSqnxjLVgqeQWQC8D
X-Gm-Gg: AYBFou3p0EDVGRMiYjTEBRdTKIGh6eu116DCn5Pgzr9p+yiXGDm0+MVqNJfHbZ6+xw5
	b0u1IsYSFfnfebXWXBD53sKbs/oj6BWB+O8iv36er3T9Fcvu7WDPJnAYwvqKhq+YDgL5MvVhGBI
	alq+vxTqAxr4lGzNXNDzGY9EzqrxNrxkzAWmwc4oQVi+/1cJesgkVNVM/I2rjTNzffW75XVQPJz
	kxIgg4I5MDlHrOBIooL59k9ABmoJoiLx1FAMsjX3qrRjODCxWk3JGDYGuM519hpT9wpdRFu91v4
	ujtBANH/cltJ1NppMoamwkPl9JGmTZLtICZf76rdqYmb8ojyPLaOUzFrfAblMBAHZaXacQUjE/C
	cVKttFHPZyzLeyye/KttYgtsdqIhacCURmEHpCSFF0QHHDosFLJbEvQG1pXFt2Tq+z5vA7Xuu/w
	hcgH8Wuy4CmvtH7bALhbCx1BE4k51tWX0KGlrseQIEywnVtH7t8P2ira6XH88vCXOfjFMGgZShi
	QPrTyXw8mYBq42Iw8Bd38C6ScZDmn1nzQks8BGW69TUuOnFDNlGCsA1vSHRyaQR4Vs=
X-Received: by 2002:a05:600c:404f:b0:4a1:d05f:3efb with SMTP id 5b1f17b1804b1-4a1d05f3fe9mr18704235e9.0.1792155679827;
        Fri, 16 Oct 2026 06:01:19 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48dfd471a35sm4331624f8f.7.2026.10.16.06.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:01:19 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kevin Hao <haokexin@gmail.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:TI ICSSG ETHERNET DRIVER (ICSSG)),
	netdev@vger.kernel.org (open list:TI ICSSG ETHERNET DRIVER (ICSSG)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ti: icssg-prueth: Fix dma_unmap_single() direction
Date: Fri, 16 Oct 2026 14:55:28 +0200
Message-ID: <20261016125534.36024-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In emac_send_command_sr1(), the command data is mapped with direction
DMA_TO_DEVICE. However, in prueth_process_rx_mgm(), dma_unmap_single()
is called with direction DMA_FROM_DEVICE. It seems like the buffer is
written to by the CPU before mapping the buffer; and, after mapping the
buffer, the device writes to the buffer. The DMA_TO_DEVICE direction will
handle well the cache maintenance operations, however, if the IOMMU is
enabled, it may cause issues with device write permissions.

Change direction to DMA_BIDIRECTIONNAL.

This bug was statically found and compile-tested only.

Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index b8115ca47082..6f4a3f64ad39 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -98,7 +98,7 @@ static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
 	tx_chn = &emac->tx_chns[emac->tx_ch_num - 1];
 
 	/* Map the linear buffer */
-	buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_TO_DEVICE);
+	buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
 		netdev_err(emac->ndev, "cmd %x: failed to map cmd buffer\n", cmd);
 		ret = -EINVAL;
@@ -108,7 +108,7 @@ static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
 	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
 	if (!first_desc) {
 		netdev_err(emac->ndev, "cmd %x: failed to allocate descriptor\n", cmd);
-		dma_unmap_single(tx_chn->dma_dev, buf_dma, pkt_len, DMA_TO_DEVICE);
+		dma_unmap_single(tx_chn->dma_dev, buf_dma, pkt_len, DMA_BIDIRECTIONAL);
 		ret = -ENOMEM;
 		goto err_unlock;
 	}
@@ -303,7 +303,7 @@ static struct page *prueth_process_rx_mgm(struct prueth_emac *emac,
 	page = swdata->data.page;
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 
-	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
+	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_BIDIRECTIONAL);
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
 	new_page = page_pool_dev_alloc_pages(rx_chn->pg_pool);
-- 
2.53.0

