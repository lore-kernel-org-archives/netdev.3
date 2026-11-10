Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325259;
	b=tT3hKrCWcV3bchJJjN1PICvGJjMNa0VGa2mr+ACBjWKganA54dUSgvtNNyAdnwOumZOS
	 o8FOUxby+OnkTfV2hULKXcJGNKjJqIYn6SIp2b0WSE8y6yxS09YgcAJeLZVJB9BjF20dJ
	 BtmjxCKEgl/kdKjW03pAk4T+UUsDx7+dR2wSsVeJeDIMT531rrsL2pSjVeX5TzWaj8v6Q
	 BHz+0PpeXCR8d+H88qkXW7JzA8tmPHra254MV0aKCBtdpU73EzJxFN70DUY8IUK4dwXD2
	 pbWNU6zvGN9uxuzBcQgz9lVAX70EGD5NY3a1eAjsoJwCxnatjyUdsUp2HP6Klykk4LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pEh2q+SQxGTFTicWzoJ7e3G2PCnq6llm/Gr90hwdzVM=;
	b=1bezXrbJT7jFJMPcrssVhpcDccNn93wGLqS930ooiulmg8Ic5XxNz628X28kgajOkJqL
	 W8HdnhzFaHX9CEekCnGP1E5inV7jpy1rrtAOal6CEINLzm6yJ2+nzZ6k2MCDbrxwPI1iI
	 OcBl9xQRxMyu0Uhg9s0wdNkMUs4m1DUt86mJQha33o8dw7ObCWQ2JIvVs0TxylVBisDCr
	 oedC0YjHx2ClecHsoFFJaoD5GFhsHJWwQ8ER3kfCaxFp1bCTzYmcFNHa+i7cBQMpcsqEE
	 0UdgIX4ZYi0wxVkbRcPpFaNOG1D1xs2ExaBZv7nxXK8yic+FsFwStaIaSNwPtRyMLqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="te2rN/EU";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389FA60A2600
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 389FA60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=te2rN/EU
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b1ce85287aso2275990c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325257; x=1794930057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pEh2q+SQxGTFTicWzoJ7e3G2PCnq6llm/Gr90hwdzVM=;
        b=te2rN/EU2GdvcDM/OlJqGNZZdgxT8FjRp7O9Y9FDlBc3zGieP19AFAFhffFfG+WQiK
         94ptcHN25f3CHEpmj+6oECHy2TsAWF09+eCVGw8KIno53XOqN5gZzJK8NebdkbAERiis
         zpo014YhQtUE/DcTL6YBjJKoxfD9bZDBhJ3LT/OpCBR8kWkGa03WO2h8tZizkTm1ExNh
         7HaSlBoCe0iA0pCUdkVKmEY7rmLXWItDAASHQad4SSyOGKbHN7Q0gyp3i93r2npjpi2y
         P1PwLhNLGa1K9cFukbX/nchwWaoytY2NcaV4XwCvDWdhk5H057O2Q7bdj4dNCJDMmg3V
         fvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325257; x=1794930057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pEh2q+SQxGTFTicWzoJ7e3G2PCnq6llm/Gr90hwdzVM=;
        b=GwKQ+EXqPYohJhJinPt92yQDq25sBeFZlgFciOsGz9I4QIMuUL+3S6D418A1e76TN0
         x+G5NWsbYLGxB5IkHCmPHiuhDGSnXNDMWh96kmcNQ+JMGnTs527yeFX+t193UoDYTKPM
         wD7BQr+a6NFbl0GGPWSFMiYlWsaK1AUG4/XO0c0BpWCZzqAIWGuO9fs3bGoArnTq/xYB
         Z4qhwEc3Ixhlc9LXygYx4ULEjmQEX3CUVclqNJouv1NdoXEN/oTacoeiQNbVZ4qkp2Tb
         R1AsZyKBfOn38g9+x31FefllPBKZ12hBK3p9juVXvyrJYsrVUEOWoFP404UMeS5GGRnV
         DUZg==
X-Forwarded-Encrypted: i=1; AL+hErFaNqtNnDNwS5IPpSE1w9H8UCQhdi+C1v8e7+A0peW/u/AHDlvkizW5oJp/ePCjM/KWj1ncVmE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yJfzcmJK33Pt8IN318DSBHWsxTUlbWfwCkPR+bPxMh+PxAzu1
	nA90EhADniqECXkAWXw66x460roTthtHPTYapdhyuxf3U8ayAeHIkqg6
X-Gm-Gg: AYBFou3BRwvmytub4MDH/wgHNWsFoJ3bVSP9fSH1LO4znTLYWFid7i/G7FguoG+3O4R
	3DEmxRueho4W+KWHHWoQAUatWBqAZZ6resStA27M3Ik2xIinU1GoceYwC5bUhpvR46vkAfijTgq
	rpT5/VVaOBom7QEIbpefA6wxQOj5kQKqGorF9Vdttcpi6L5cgfeYF5+9GYh5BA00E5S6WGJQluO
	B9QiqEm37KqgXucE0VBZVWa5qHunuYUu4dlyn0rYQk8LbxlamtXzhu5DJ+Yc6xBaWbsjI792CA/
	kz+IgLslyD/9B2TkLf60rp9ziY1/d/9O0Mp2ZaAtxk/iozoOTUEfMSAjuALbo2rlVr+SDg99ZdG
	SWfZVnLsTmFyy0RThgxy5+s/5nRIbaj75NgNCFD1YIxIwcQbd8JknXBPw4wlmOz7HM4t30UNO3J
	yyOSUP+WMUmJ3XR9AnyjcH6RA6Yimb1rmU9IHjT4u3JitIj4dl54wkBBXvu8yngqez59FntROfQ
	2u4QxxLaVGDZApFTEtjmBu9P/DZkB58jN+jLf1EdMdc0uO0RjfD9/hVH/wGxvYIebgyTSlW1UKU
	NiAs1L9RqMNWwbcpIMeqfgfdCaYUqVniazUlIN/COWkS8uMsusr8/XqWFP3mpQs+BuYOcKd4D57
	fBm8MKcphun79YToBoF95EV/UfAHCUi27Cmu23T0sFb8VF2TYvawkwkWbW1YejJUxyo6uK9wk60
	jIT3q4BjrGH6mGW6BUw8+WWc9y00AVQgbqUoiQXN0tOw==
X-Received: by 2002:a05:7023:a4c:b0:1b2:60ab:1e9a with SMTP id a92af1059eb24-1b3b605b765mr3487347c88.10.1794325257070;
        Tue, 10 Nov 2026 07:40:57 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b72ce0sm8746958c88.18.2026.11.10.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:40:56 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com
Subject: [PATCH net-next v2] vmxnet3: stop DMA mapping the adapter structure
Date: Tue, 10 Nov 2026 21:10:29 +0530
Message-ID: <20261110154048.143227-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

vmxnet3_probe_device() maps the whole struct vmxnet3_adapter with
dma_map_single() and passes its address to the device as the "driver
data" (misc.ddPA/ddLen) in the shared area.

The adapter is the netdev private area, and alloc_netdev_mqs() allocates
it with kvzalloc(). struct vmxnet3_adapter embeds 32 tx and 32 rx queues
and is well above PAGE_SIZE, so when a high-order allocation fails the
adapter ends up in vmalloc memory. dma_map_single() then warns
("rejecting DMA map of vmalloc memory") and returns DMA_MAPPING_ERROR,
and probe fails with -EFAULT. syzbot hit this with page allocation
fault injection.

The driver data is only informational. The per-queue descriptors in
this driver already report no driver data with ddPA = ~0ULL and
ddLen = 0, and other vmxnet3 drivers, such as the one in DPDK, never set
misc.ddPA at all.

Drop the mapping and report no driver data in the shared area as well.
This also removes a probe failure path and the adapter_pa field.

Reported-by: syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8eed6f83440ecdaf4be6
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Retarget to net-next and drop the Fixes tag (Jakub)
- Drop the "never synced" part of the commit message (Jakub)
- Add Simon's Reviewed-by

v1: https://lore.kernel.org/all/20261021221221.502428-1-kapoorarnav43@gmail.com/

v1 was tested in QEMU (q35, KVM) with KASAN, CONFIG_DMA_API_DEBUG and
fail_page_alloc: the syzbot reproducer no longer warns, and the emulated
vmxnet3 probes, gets link and pings, also with order>=4 allocations
failing. The code is unchanged since v1. Not tested on ESXi.

 drivers/net/vmxnet3/vmxnet3_drv.c | 19 +++----------------
 drivers/net/vmxnet3/vmxnet3_int.h |  1 -
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index f8df83f9965d..3a9fb5b63e9d 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2921,8 +2921,8 @@ vmxnet3_setup_driver_shared(struct vmxnet3_adapter *adapter)
 	devRead->misc.driverInfo.vmxnet3RevSpt = cpu_to_le32(1);
 	devRead->misc.driverInfo.uptVerSpt = cpu_to_le32(1);
 
-	devRead->misc.ddPA = cpu_to_le64(adapter->adapter_pa);
-	devRead->misc.ddLen = cpu_to_le32(sizeof(struct vmxnet3_adapter));
+	devRead->misc.ddPA = cpu_to_le64(~0ULL);
+	devRead->misc.ddLen = cpu_to_le32(0);
 
 	/* set up feature flags */
 	if (adapter->netdev->features & NETIF_F_RXCSUM)
@@ -4044,14 +4044,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 
 	spin_lock_init(&adapter->cmd_lock);
-	adapter->adapter_pa = dma_map_single(&adapter->pdev->dev, adapter,
-					     sizeof(struct vmxnet3_adapter),
-					     DMA_TO_DEVICE);
-	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
-		dev_err(&pdev->dev, "Failed to map dma\n");
-		err = -EFAULT;
-		goto err_set_mask;
-	}
 	adapter->shared = dma_alloc_coherent(
 				&adapter->pdev->dev,
 				sizeof(struct Vmxnet3_DriverShared),
@@ -4059,7 +4051,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	if (!adapter->shared) {
 		dev_err(&pdev->dev, "Failed to allocate memory\n");
 		err = -ENOMEM;
-		goto err_alloc_shared;
+		goto err_set_mask;
 	}
 
 	err = vmxnet3_alloc_pci_resources(adapter);
@@ -4312,9 +4304,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	dma_free_coherent(&adapter->pdev->dev,
 			  sizeof(struct Vmxnet3_DriverShared),
 			  adapter->shared, adapter->shared_pa);
-err_alloc_shared:
-	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
-			 sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
 err_set_mask:
 	free_netdev(netdev);
 	return err;
@@ -4381,8 +4370,6 @@ vmxnet3_remove_device(struct pci_dev *pdev)
 	dma_free_coherent(&adapter->pdev->dev,
 			  sizeof(struct Vmxnet3_DriverShared),
 			  adapter->shared, adapter->shared_pa);
-	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
-			 sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
 	free_netdev(netdev);
 }
 
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 9f24d66dbb27..2c2a446a8e4a 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -438,7 +438,6 @@ struct vmxnet3_adapter {
 	struct Vmxnet3_CoalesceScheme *coal_conf;
 	bool   default_coal_mode;
 
-	dma_addr_t adapter_pa;
 	dma_addr_t pm_conf_pa;
 	dma_addr_t rss_conf_pa;
 	bool   queuesExtEnabled;

base-commit: 6db9448a443afde26231aaed7b112ed17b33f468
-- 
2.53.0

