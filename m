Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794120777;
	b=4cgATf9DDKZeA6U8V6yBY051v6xfAkddQGZDfztLE7ee4S1rNguI4Rjlx41C8qUUDrKP
	 xH+PqkLkn+0BhvZy5Jiy17bfwwKUx72W9HjCTiq8mpWpTAmbvrHBFsiRGNUvRVlpqqpVM
	 0hYaDmtMxj6sP8KMNBTNe2JkInCmlKGScuFOReqp/EKm6lHd0TBMv7oGm97aXCCOdxCpn
	 DvksRMQFVBCrKz89cD2OxsAHw8bz1gjxvSkgFpXQiRWx6swUmQwiWG0rSEvh2P/AjFTAN
	 5HeTnzqV5haZhRQ3HcEPEni5dS/la5o7E6ltgQwXPUutFqGnFgcKPO1oHR/BW5n7M6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794120777;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=dJebYUd8pyS8Z+2CVSNXS7zJ6v/TxgKHnB9NFofUJ3w=;
	b=ysD1TizutNsA0jbixh5Pz3HW1ZN4CgD+K9iRi4rVui5K9whZEZEOv4SCRoI4jbGlFAUG
	 h6bdukuDVyB28Xdw0GnW541RgZos7WNODG3LqG5i+eSsgsSIpBFJT44TSBFLRsY6/uhw0
	 Bm36Xb7hVNlU/bwcBzqctLvfLVdj0kMWzPHq9q2ywGaymqfZ5LX4TY5+iVawMfxn5SwQm
	 F+iNFv0EwaYMTHRMUGkuB4mqgGmrLTloZ9goTL+5QR9O909w180DE6J9en5b+TmuSiVd/
	 6hAFBFvI98GTstTXP4qI4KEpOnSlqVpOiTwb6Iek0+ZNGj/iuCpIX1h3xYEEhSvDGxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZEeEsS+C;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699E606A31A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A699E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZEeEsS+C
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso107594a91.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794120776; x=1794725576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dJebYUd8pyS8Z+2CVSNXS7zJ6v/TxgKHnB9NFofUJ3w=;
        b=RTj4jmA8NzHKuXoAyrrOjjVOLcfKNI8EcWtKyZv7bs1GFBgfPF43s5eFOMcQmmtPBS
         ZBcA7X8E3UrhIuuAAirbqElF7ZAJ0QaZ2zAgfjxjAQlH7RRx2P+4U7jIYvOyZRgSeY75
         DN9QuBDZG32o8GArWDwMkb27dmMd0fVWP+JFHNBv32yGMLGcbnf+STKgMmOAoDmq7gH1
         4l0bGZnY3hJ2EUzfxfbDHDSeYguud74dOGEWu6Iu9Km659toMrScie4DzrFpMIi0Kxv6
         sIjoP+OcA/lFKPlixf0f7KM6z3AI2psbydoce30vzOw6F2Pe2B8bCYrNImJNR/f97MsE
         5s8Q==
X-Forwarded-Encrypted: i=1; AL+hErE8GcChS21NGD+O5VmtV+NbedbcjJKTCw4zY80mf21l8S7Brefb4Puo4sBwRQMGIrro67WxlD4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GdTz6h1Tx5UmYFdiG2XesWQ5GSC48Jxov2W6KrPcegIGqGdja
	KzbJP82oZyWAAztIugMGSRRo5HWONU3jMML+B0axazJ1bxKqz5wrL0sfpQkva440ZvCYloq1IYH
	k2R5h4wzyf9bMg3kfHOwUBIfx3TmnYsDShSQwalDsVGYlU8WpctMstz2QlYISBRmiWDd7H8oK/b
	B4im3y2rJPrYFOXQjO1P/NCD+7XGfc7xtPhxeeeCTAGaEhGhW61Ra092VDtvE0WrsFK2ECLmApw
	91OgAJ8T3lfEQ==
X-Gm-Gg: AYBFou2UYrcZRDYcNU48WOZmJjMgNy7VlejaNUPJ8RzlWMo4nQhwMMpjGYru7qVA1i+
	6I30KbctLi2ciq3WpPUzLzQqt5fB3G1IZaehaD7Y02bP5JH3vPcmYY1PeNvDjK4nSc0hOeZecLK
	pIG8ReZZtsgjLcXaCpx0vptJgJZFtzAInngkHBFMLm9I4GpAfqSJPGfjbCsqvmTRjh3DWGPHAIM
	LdhW3ZLvK2pNdaNq4kiaSL0ra79LBTeh+PHX2pOmBh7OcbV7QBH7oOX8Q4SrggXwYN93g0ICHIb
	nkd3FYQ1RZgaWhIITC5s46knRJopb0/dSHcVkMmNWFUw3Ew0mWfYy+rb/oD2Bkg67bqjcsuXiog
	3/pn+jQdRdWz1DblLJkz1zLUs4i7rY6PQ4TRvLU8gWO8g9u65C0aXtxzOYcYXn01swKZz/0mDx7
	lU6ptbhkYf2qRVxS3qUHUUx+ZPqXH5/mRjq+M=
X-Received: by 2002:a17:90b:4a10:b0:3ac:c005:cf07 with SMTP id 98e67ed59e1d1-3b12d54b71dmr581840a91.42.1794120775873;
        Sat, 07 Nov 2026 22:52:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b12744d264sm939908a91.0.2026.11.07.22.52.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 22:52:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso191234c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794120774; x=1794725574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dJebYUd8pyS8Z+2CVSNXS7zJ6v/TxgKHnB9NFofUJ3w=;
        b=ZEeEsS+CL36E4tlIIPrwrk1X9j/6XZx7Ku4X0nDpkYCNpVIZG59Crzq9hPQNhMz7wF
         68WswVpErxN5Z0TmrQtoLtFb/lnS5MaJ5b7d0I+geFlp1WxY6xSE/ESh5h/DJhH6UAaW
         J8vphteaF91QwUNW28ulDE1ddoZTeKYnWhXFI=
X-Forwarded-Encrypted: i=1; AKwUvBw3GGqflK4A0m21X1mmv/xOgqb4oSk0dcUZbS+w0tHLrbYk8qivAHNUcNoRZ1F2VSWb5YOPZxI=@vger.kernel.org
X-Received: by 2002:a05:7022:1101:b0:1ae:e7c4:9a15 with SMTP id a92af1059eb24-1b39fe2fe97mr1295173c88.3.1794120773947;
        Sat, 07 Nov 2026 22:52:53 -0800 (PST)
X-Received: by 2002:a05:7022:1101:b0:1ae:e7c4:9a15 with SMTP id a92af1059eb24-1b39fe2fe97mr1295145c88.3.1794120773188;
        Sat, 07 Nov 2026 22:52:53 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8a27sm3497993c88.7.2026.11.07.22.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 22:52:51 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH net 1/4] tg3: Don't fail probe if 31-bit coherent DMA mask is unsupported
Date: Sun,  8 Nov 2026 12:25:23 +0530
Message-ID: <20261108065526.710152-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261108065526.710152-1-pavan.chebbi@broadcom.com>
References: <20261108065526.710152-1-pavan.chebbi@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Commit 614f4d166eee ("tg3: Set coherent DMA mask bits to 31 for
BCM57766 chipsets") lowered the coherent DMA mask to 31 bits as a
workaround for a spurious address overflow error in the hardware.
The result of dma_set_coherent_mask() is fatal to probe, so on
platforms that cannot satisfy such a mask the device fails to probe:

  tg3 0000:01:00.0: Unable to obtain 64 bit DMA for consistent allocations
  tg3 0000:01:00.0: probe with driver tg3 failed with error -5

This was reported on a Mac mini (Macmini6,2, BCM57766) running a
kernel built without CONFIG_ZONE_DMA and with IOMMU passthrough as
the default. Without CONFIG_ZONE_DMA, dma_direct_supported() only
accepts a mask narrower than 32 bits if it covers the highest
physical memory address, so with direct mapping a 31-bit coherent
mask is rejected whenever memory extends above 2GB.

Treat the 31-bit mask as best effort.  If it is refused, warn and fall
back to the mask used before 614f4d166eee, so that the device still
probes.  Platforms that accept the mask are unaffected.  Where it is
refused, 614f4d166eee never protected the device, it only stopped it
from probing, so this restores the behaviour of kernels before that
commit.  Warn when a status block lands at an address matching the
pattern described in 614f4d166eee, so that a resulting TX timeout can
be identified.

Fixes: 614f4d166eee ("tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets")
Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Link: https://lore.kernel.org/netdev/CALjTZvYKHWrD5m+RXimjxODvpFPw7Cq_EOEuzRi1PZT9_JxF+g@mail.gmail.com/
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 95827df4cf6a..2cf9d2ea069b 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -8867,6 +8867,13 @@ static int tg3_alloc_consistent(struct tg3 *tp)
 		if (!tnapi->hw_status)
 			goto err_out;
 
+		if (tg3_asic_rev(tp) == ASIC_REV_57766 &&
+		    (lower_32_bits(tnapi->status_mapping) & 0xffff0000) ==
+		    0xffff0000)
+			dev_warn(&tp->pdev->dev,
+				 "Status block at DMA address %pad may cause TX timeouts on this device\n",
+				 &tnapi->status_mapping);
+
 		sblk = tnapi->hw_status;
 
 		if (tg3_flag(tp, ENABLE_RSS)) {
@@ -17756,6 +17763,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 	u64 dma_mask, persist_dma_mask;
 	netdev_features_t features = 0;
 	u8 addr[ETH_ALEN] __aligned(2);
+	u64 test_dma_mask = 0;
 
 	err = pci_enable_device(pdev);
 	if (err) {
@@ -17895,15 +17903,22 @@ static int tg3_init_one(struct pci_dev *pdev,
 		persist_dma_mask = dma_mask = DMA_BIT_MASK(64);
 
 	if (tg3_asic_rev(tp) == ASIC_REV_57766)
-		persist_dma_mask = DMA_BIT_MASK(31);
+		test_dma_mask = DMA_BIT_MASK(31);
 
 	/* Configure DMA attributes. */
 	if (dma_mask > DMA_BIT_MASK(32)) {
 		err = dma_set_mask(&pdev->dev, dma_mask);
 		if (!err) {
 			features |= NETIF_F_HIGHDMA;
-			err = dma_set_coherent_mask(&pdev->dev,
-						    persist_dma_mask);
+			if (!test_dma_mask ||
+			    dma_set_coherent_mask(&pdev->dev,
+						  test_dma_mask)) {
+				if (test_dma_mask)
+					dev_warn(&pdev->dev,
+						 "Unable to set 31 bit coherent DMA mask, workaround not applied\n");
+				err = dma_set_coherent_mask(&pdev->dev,
+							    persist_dma_mask);
+			}
 			if (err < 0) {
 				dev_err(&pdev->dev, "Unable to obtain 64 bit "
 					"DMA for consistent allocations\n");
-- 
2.52.0

