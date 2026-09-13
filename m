Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85738655D
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319788; cv=none; b=dQS/IxwsgnSqUzdfl8OAZsFCQ5SE0yj1NuM6cjaciDg2uKnBjn7k7g+s0Jfb+9WkjDnHuYZxPaD/PwFf1eF1NxVi+Y9w4ho0riYZcBBNolAqXgQ5x7pKnUpO+rsg+j3alo4qQ7177AevEJkGK/e70A3C4RfV0ddzJ7CgIvtcYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319788; c=relaxed/simple;
	bh=JeP0/+i4BthO9vnNn49IW2Sz/HCFPi0djjjJvZpQh7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7WWLEFDPmAQcWjTPgmLcNo4nz/z+SNx8t+1TPKk8kfsu8Uo5beLt79Eq3722UTrrBhkpI6JigKRfc0GhB1gKOQ0wsfNEO9+19y8G8roFa5SNY7HQKisBFWUHQ68zDS8n9tbT2ozpiK2pxFVQoRjWCbTwMmIJitoQkJDTVxveSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JirSa2is; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JirSa2is"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdccso10311937b3.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789319784; x=1789924584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GateTyBBPIQQ3kCKpBN9Gh9lEseqwXsnXnPZooaJ/B4=;
        b=JirSa2is9xuukhyjj9k1gbNuE0D3XHuklfjTMNNLrl9ONAm0q69onsmonTYI85lxVG
         +ayhoGGTOP/w87CmV6mgh2yBRDuwjmHp3z8yBepqH3KtGgIlHb+AKknzoLZYvgMm8/Rk
         lFZhrvyy5Yeb0B82uumF6lnBzIBavUbVbUBG2FNnLTnmgxOxhkiq99ggfx8ZBGgx019T
         27j0ozS3JjkeaqqRJcpkUNRrMe8nCv7aZ8jkQJsxv7TdrQ6ObpoJ1w21NyTxBdr6XzDF
         Sp/BwHLT2m7U2yYG2QeQ2350IFc7YHBod/7bsPwD5C0a1h8jcdyymD1typc0I9uFhEM8
         PcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789319784; x=1789924584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GateTyBBPIQQ3kCKpBN9Gh9lEseqwXsnXnPZooaJ/B4=;
        b=LTM/g86d1CUsGjQYpDALc8axATBAQQ4C3ky4fvcVmOZTrv5T7V5rZMfMWrQC8Jppzk
         F4KQ2Bvz2LZ+KjzicBl/z0ym2ZNCScrhMp4Kr5oZqI9/BGAic4ExYetZa2n4IMNfk6Fe
         mbjrBN0o8O3tdj4ZKWv+Ym/qoZjvguzKM4DnZfYhO/4piAg0muTj10fKJBnjMWcMkt8I
         q6Qlk+kL7AXsC5P1dPUKT3toi0n/j24dXGojU7z175NPTqngX/LCLLs51AXNqBgAJYFQ
         1reL3vwsYnC+TAaeLx5rIPNPAZjKMyTOlihyLYCdn1V5Ii1YgD9jmpb8wWFbwjWMEcc2
         C4aQ==
X-Forwarded-Encrypted: i=1; AKwUvByka5msuok7P3aM1LxbeP3vdbIUNpK5XZoREnWED+oTjs9TMcPHvAEJjK3VhUTd90g+P0Hf+58=@vger.kernel.org
X-Gm-Message-State: AFuF++kF3tXrY7Loz43mm6Pi7aPezvMvBUg1xXv5xMDXyhXvPe6Jfeok
	CSDObOcWnOzAeIXjbPEpKWGk8mOqtxfhxp50FmPn+hNxv4yVyVo8n+Yl
X-Gm-Gg: AYBFou1DV0pq15F3LECg5dKic32PqeRzz5+LPxz5hS5+hDhi/1ERg7GG6Cw49/9e+ml
	JVt14sGGbAbMVYPLUrNgU+AXjxUVcj6ljXSz+gBnRFu2BuN2aZu30SHbV2pInygnkztbUb5hU9T
	xt6LsoXMgmZbcjsdgKRfC3mQVEL6A55Uw8FNIxLHY6fGySfv+PYlSi6eA/aEwenPROrQX5OfDLa
	3FNwSV7WLi/lwZfvQwJxIprx4aHM6w92o3sTFe5xNGC9wOYFv4gkZ34GLgmdfLFm+wmmiZtMHBu
	0s9JWcnVPxrIXoteTY6aETbuclguw/cWQ49Zgp+xPv7WKFZG1d7dLZd92csAWVNT2QX6kktXYyc
	fiwMJCr9plSmUZ/Zl8/Fk7YJOAtE7qgKPsDAKTO4Uq42UFimLggoOV42UnYTwCMQQOrV4rR+jy4
	ouLCSV3VvAGtKl26YN972PCOri1VKQkzAtvKDI4V/vfy5YvIYQtZ+VZBNIW7ODnQ==
X-Received: by 2002:a05:690c:a759:b0:882:1d1f:23e2 with SMTP id 00721157ae682-884b387e35cmr40144407b3.28.1789319783900;
        Sun, 13 Sep 2026 10:16:23 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db4476bsm29210607b3.5.2026.09.13.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 10:16:22 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2 1/2] e1000e: fix Rx skb DMA map error sentinel
Date: Sun, 13 Sep 2026 13:15:54 -0400
Message-ID: <20260913171555.89537-2-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913171555.89537-1-tactii@gmail.com>
References: <20260913171555.89537-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon encountering a DMA_MAPPING_ERROR during skb allocation and mapping,
the driver would leave DMA_MAPPING_ERROR in the buffer_info->dma field.
This would lead several buffer_info->dma == 0 conditions down unwanted
paths:

* In e1000_alloc_jumbo_rx_buffers(), it would not re-attempt the failed
  mapping and instead write DMA_MAPPING_ERROR to the h/w descriptor on
  the next allocation call. On cleaning or teardown it would attempt to
  dma_unmap_page() DMA_MAPPING_ERROR. This case would only be
  reachable at MTU > 1518 and page size > 16K.
* In e1000_clean_rx_ring(), it would attempt to dma_unmap_page/single()
  DMA_MAPPING_ERROR (unless cleaned by the jumbo path first). This case
  would be reachable at any combination of MTU and page size.

Use buffer_info->dma = 0 as the sentinel for "DMA is not mapped." Set it
immediately upon detecting the failure.

The map error value was 0 on some platforms (including most common x86)
until error values were unified to DMA_MAPPING_ERROR in v4.20/v5.0.
Since then the error handling in this driver has been incorrect on all
platforms.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
---
v2:
* Add history blurb to description.
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..26f45ee8c7e7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -691,6 +691,7 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 						  adapter->rx_buffer_len,
 						  DMA_FROM_DEVICE);
 		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			buffer_info->dma = 0;
 			dev_err(&pdev->dev, "Rx DMA map failed\n");
 			adapter->rx_dma_failed++;
 			break;
@@ -791,6 +792,7 @@ static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
 						  adapter->rx_ps_bsize0,
 						  DMA_FROM_DEVICE);
 		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			buffer_info->dma = 0;
 			dev_err(&pdev->dev, "Rx DMA map failed\n");
 			adapter->rx_dma_failed++;
 			/* cleanup skb */
@@ -877,6 +879,7 @@ static void e1000_alloc_jumbo_rx_buffers(struct e1000_ring *rx_ring,
 							PAGE_SIZE,
 							DMA_FROM_DEVICE);
 			if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+				buffer_info->dma = 0;
 				adapter->alloc_rx_buff_failed++;
 				break;
 			}

base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
-- 
2.43.0

