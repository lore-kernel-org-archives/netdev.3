Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620751;
	b=iEhcv+aYtq5xs2p9SyBDOlbc/kaKUx4AqgPtV4F9/FCkdxmeQ8mF1FlggXSd+xje+EV3
	 q5Dxov1sDY8eK9s6WB5p5z9glHLMT6k5GhVLIUpOtcvniK4kv4qA6ODZtf34caRE3KIYr
	 +ozs8z3GPRDRdXUGcdJ24apkBWftWGm0mWwotL5cTmnpbrCm3hB0nZ64SVLuKkWtGe0QT
	 mz1w6zm0DTsf3RGdIaRGBmv1JdncqH8Rkj6QQDOYjm68IKmk6oLefVHauwTJPH2lgKLhO
	 Zyv49WGDA9/MbnYdUBx+zw6CerxTyfbxILxl+WZftebJ9HIHQn2vcHuYntXT0FPHzxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0kWLSTkaGmwILUZyU8FNS5QIr+xYWnhodPqsDv2YknE=;
	b=J1s7ugLOC+W4GXxyWc5V4jXk7+IaAPmf35FJCKU0q72c9xWqLa3CHWE41kKpLGmH/i00
	 aDjGSpMpNPg0Y+NTAPTzGru3WXxUGlQAdhPW1sqA6Ox/ObWJ+Y08kP1u+/L+qT8jAZ50H
	 JXDheOd2tJuM6rRRR5K1WSqTSsX8YSVEK+aTvgvp0Xr3wUKkvkBrqtuFXAL3+gUvM0WGx
	 K8ftXB3H+6xed9Jvtjf/gobhrM8/j8M7WXIh0oCALn5wMuvgaZ5Sr88HneayTrK0sRCvz
	 8JZybn3LNM8UcVPDgUVMFnxAJrIK48o4fkbUM1WWUVsQIwawpDYfpzp1NQNHi/qKLQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="s9/i5Cxg";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C57606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C57606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s9/i5Cxg
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2228133eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620750; x=1793225550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kWLSTkaGmwILUZyU8FNS5QIr+xYWnhodPqsDv2YknE=;
        b=s9/i5CxgfCcJEOJxQp2HH3Eo6Yw99tKxurJogPoqYoeoupVDjFTHfE9TWRhjR0KEhQ
         +oKodSeLo30RvYhCPJJWswFvvBeSoqJolN7Q93COkIKGLysC/gHdnswab/8HtJqrvWrM
         eG/ckopEGI9s/Xpxq6NyzTR5J+lrF+GvwTZw8S23U0C0qDOjECAVvjgmeYcwxHRVjVba
         h9uKjhDsah+p5HFxskRmu1gVckbZ9zD+B8gSArUtCV3U6bWDe/c1lbYmi17jy13vu7wD
         +4wRy9hgQ66VtXOFynTzH352ghkJMAPiJ3w1NhOsP4b77Bi6zOlRWSZw7vi5fZZhLbdD
         MDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620750; x=1793225550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kWLSTkaGmwILUZyU8FNS5QIr+xYWnhodPqsDv2YknE=;
        b=OfkJ3T3tQDr3NxeGHGxnmFBehkeLTb7KDEQbR5K1YqTB0ff9and/szofeXYxEoiBV1
         jaUDKoqmWzcwxAwrUbV1MytRQDUee86xbuCot2cXqf1+86fXogYGZAQck/PA4AWPvWeK
         0W7kLQfnlr9yLgsZyoODI7GTI4Y7ac1oYDip+3jOgXC5ymrQPpp2MmrGnsZtmx8phz6r
         uNeDby+mlBH6Htv2XNxd9fnw/dsyWK/XoKfa4L3KI+rG1pN+Cn58qAMy7EbtI8kjx+rU
         qpNdlI4mJ0qR6x647NoTy/0IacyngvkBn6egP943wvOe4wYYyVlGxLBQ0ZrghlruIxjw
         yTaw==
X-Forwarded-Encrypted: i=1; AKwUvBxm7NQ9gjvzACjVZ4GT601ARtPBsfUuDma+Gm6JdThnC6WDNTHFmVAoTyPZc64vEoqIHHc6P6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIp6o3qjNr7NldctLE9A0wmzEdDr5Sz0A4b/cp0rvSjd6JY5i85
	/1xeDhURA8MIzXbEvTcm8hWcGfYbT00gLm1VHt6Ndpub2h9AeQtU5uBZ
X-Gm-Gg: AYBFou0QRUQSH30jLCick4jhtUW0ZPIbuK5kHQ1rJy6CIz5OV3XzD4vFVclFfmrNtmA
	gGYUsJSpFXQ7x6ihM5+ZzwOg1hD8X7uE5KFBnQlRIoXPJV/90fiptrKPZDFFMUb8NqJY/zQqPKE
	H0024EIMaQODp6eu4831stwY9fOpoHN/jrpF4EvCE31Xenj90crDFpznBPNSaFeuN70E6Rc31YN
	XW6EM4PAfa8x3cLXzzklhNA0f/+8lnYf3lRfCwPKroHVmpAafssEXgD3cCDMKv+sYDCjwGhBZV5
	GogF0HE6hWQQuvrpKGSglfxZ1MpoigF/jkCiZJD19iTq90XN91I9+gxigcpFfG1XNzk65pesSmY
	7uUKg1rACuY0bW1hruxshfCVxtbbXJ6wRUWnFSOYT7tOF2tfJ6UCjSaEfxlS4Ns0SgwG1hrEepQ
	Utlw/K2riaIkjrR1QtFp0KJY2qewYwcqJf7LJRnIKPpG8HRuPB52HscfWe8h6BSRae+hO51uirN
	ZfUa/HL2TPh+9Rb/Roatl+Bx8WTxGPpjN5x9/yhu/HcF9U+Pmb1GuQTjVblXkboZVfZBDYyS5D9
	cEkUPVbZ6zKcWt4cMIn1QoakeW9sVvBPixSI5bT96x/l5W+6QOxtnVdw6DQiEAsER1RLhrGzml1
	fVNIRz4YqWnM=
X-Received: by 2002:a05:7301:2224:b0:351:735e:2ef8 with SMTP id 5a478bee46e88-3674d54de51mr4539269eec.7.1792620750150;
        Wed, 21 Oct 2026 15:12:30 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e153519sm10580815eec.3.2026.10.21.15.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:12:29 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com
Subject: [PATCH net] vmxnet3: stop DMA mapping the adapter structure
Date: Thu, 22 Oct 2026 03:42:12 +0530
Message-ID: <20261021221221.502428-1-kapoorarnav43@gmail.com>
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

The driver data is only informational: the mapping is DMA_TO_DEVICE,
done once at probe and never synced, so the device could only ever see
a stale copy. The per-queue descriptors in this driver already report
no driver data with ddPA = ~0ULL and ddLen = 0, and other vmxnet3
drivers, such as the one in DPDK, never set misc.ddPA at all.

Drop the mapping and report no driver data in the shared area as well.
This also removes a probe failure path and the adapter_pa field.

Fixes: b0eb57cb97e7 ("VMXNET3: Add support for virtual IOMMU")
Reported-by: syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8eed6f83440ecdaf4be6
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Tested in QEMU (q35, KVM) on net/main (abeacca61eea), with KASAN,
CONFIG_DMA_API_DEBUG and fail_page_alloc (min-order=4, as in the syzbot
reproducer):

- syzbot C reproducer: before, "rejecting DMA map of vmalloc memory"
  WARNING and probe fails with -EFAULT; after, no warning (probe then
  fails at BAR mapping, as the reproducer binds vmxnet3 to a non-vmxnet3
  device).
- QEMU's emulated vmxnet3 (-device vmxnet3): probes, link up, ping
  works, before and after.
- Same NIC unbound and rebound with order>=4 page allocations failing:
  before, the WARNING and probe fails, so the NIC is gone; after, it
  binds and ping works.

No new W=1 warnings in drivers/net/vmxnet3/. Not tested on ESXi.

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

base-commit: abeacca61eea4f6803df4a595b656ea45c2d3249
-- 
2.53.0

