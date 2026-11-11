Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400594;
	b=ZerL1uiltp54Rbcm3kr4y6bHwVxWRQ7/aLSr0wbS6xNYb+pZ+71jlwbU74ab/u91m9is
	 QFPfyu1v/ua9PY32vnFAz2XcWS6tswTuvyV6SpJb0OAcbKpso4darMYSREmI2H2H9XaoH
	 1RbmncL0ZjLQB1DabQV4hsblVAM4NDOY29xwY1wjjo5Q/Ihrqi4fMiJ8XoNkMJY6v3pqw
	 Vuw8QgQCSUO5+ILaWqaDLRRPkA4Cbyz4Tcq0egQTochtGgcyAvq43Mk9RstyeP2CHram2
	 Nk23TQ5tyZ5cAZT43V0bQDTMnaYxSq1ZI9miEUZYlp0SE3lBcA0O37tZOvbDAhiI9DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400594;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=dJebYUd8pyS8Z+2CVSNXS7zJ6v/TxgKHnB9NFofUJ3w=;
	b=wIc9pJktXIobvdj50TJcvLPSPBpyNVESHJOjeKYsOyb4eNn4Yksamv3HH/awDUM/Ng7Q
	 DAsdGXN4yNlMF/4pRJZ/WM/S6qxs6VvqtiaWur96p05cH/pXFFl9MapKYMnXW5r0pyWsS
	 peh0G6G5pPDw/E6IzkS62d3pwjK7bDuXKdzTH+EYyaVk7Tz161Oyhc7HVHgUTRv+WtCad
	 MieDG+2mrqTdU5eCjMZE/tLS3kYmOoWuYjiKabEOkq4DVqnr2IwLCuI+bBeW8CWYTHsNL
	 NdBahuY8I9Bs+7X3FZdKsDCbBd891BKOFYuS9CUeKrXT9FRFd7FpuwRrOcV7DezWVtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="VyTd/9jr";
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084B606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 12:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D084B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VyTd/9jr
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1480005a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400593; x=1795005393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dJebYUd8pyS8Z+2CVSNXS7zJ6v/TxgKHnB9NFofUJ3w=;
        b=pcGK0L+GRXWDvLDkLDGolaV1ZsxAaCqLBkc8xXJ50Psymlv7xmpTUzbUkrct2C/f3b
         5TaAgZnkbxb5taYkxm7VKiHlm+Ib8LAvXTOEf2YZniCuo6U48KZy/lNFomW3iHcaFBDX
         SbXWlz/ovAetIp/SpFKii0fsOrKAJ4ObVxKZkVtxPoyIcJKWoPt8xeV1tXzUNdBdFcTs
         JdEf8EMJOadAfZAe5104yFsn4x9nsMaqdxJWAVK2WewrZIXQjnnXETvjwdaVKS1yaxyq
         k0FZUbmV0hskD0oma24/3AD7YM3g8QQYu21pK0ijtRO0BBUzZklbP5kQUk7RhLPFq6yh
         N0XA==
X-Forwarded-Encrypted: i=1; AL+hErGsSlurY02fey+oTognp7117ZLqE0dGwDEAwAQFkXOjgOMy7D+W9QSnM8bVETwnx8dloqFwcI0=@vger.kernel.org
X-Gm-Message-State: APuU4Z90UZde9/bM46mFx9bsJEJB2WmuWojOyeFJCYI3kvIBEWj6LJn/
	Ic0Wqemf6F3/wXW1MEQ/OJisxrSjkyD9RFM9TrGzLQ3kNVVD56xKSfC0MZyTzY3jepjCgvDpyIw
	ZB+VtI//BRzGrToffHL44FIo2azYqI8JRSiZ8U2Y2mOes6C43q8M4Zouyvomf9FL5ZO0TlT7Gz2
	uG0o1LZn47tXBPjnoCtWfYkCN7uCQgaLSEd0z2ostY+v//OuisytjWbP6CnWTUyDiJ97eRUXjCU
	dBro5L4Ie8=
X-Gm-Gg: AYBFou2JOS4bLs0PeIymtYfhX+M4RIeIX8h10lrNrOOL838tWksvUa+fR3FCHEQgZGI
	lZVSVDTBFsOy5hoaPWFunOo6qyq+W2EfwkYUi3m5kwCKLQTyYwTn1Rt2EIf9oZusTc0RNO8zZ4z
	QFtU8TxaKOEO0/QlLku9d7J/UuGlsLM0AFXHzC4RK+5rGlaQu8J9l6NpTgWK+FnXI4j78mZQRTV
	X9w231H32qw/2gsEV8wczxf7j/0IjPxg8m660hcbFfnqT901WrRpmqaglGr3bZVAA86bNXSLZF8
	l9DmWEA7FdM0T3cTZUB6MiMR+27lRPoZEu9U2yIbXX75GHDeSFqHThYvQfwgtwQBHLtQ8dWAF5P
	DBn4FGfRNoy7x5tjAEgs09BJLoS2/EiGvbRt1xIYOpj+9X0yKRgWVJ852e7MXkdd0ORT0JSmfMT
	yaAuH+CGXVVogAZ/+m4kRAGxDEln/753gLGIg=
X-Received: by 2002:a17:90b:17d1:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3b182fd884emr2245189a91.59.1794400592995;
        Wed, 11 Nov 2026 04:36:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b181fa190fsm876348a91.2.2026.11.11.04.36.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 04:36:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36f479b9819so5370952eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794400591; x=1795005391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dJebYUd8pyS8Z+2CVSNXS7zJ6v/TxgKHnB9NFofUJ3w=;
        b=VyTd/9jrML9zcs9uomduEh9xZgo5saMDng/+eErzdlEQVSOXXyxVFf51DuOFbJOT9D
         DhZDTx42zUhesPVNKaL8GypaUo9HOnx1y8ujBjjN3tvrNYd4t4ykrGz1mKHsvOudkjxz
         cOcrCdnj9aPcnGx0QVMwbWG9ugRUJya2p1Rxw=
X-Forwarded-Encrypted: i=1; AL+hErE5mIb9VOjICekWK72x0F4XqEhdf9asg1/bnNIzqTlN7QdIyWkcNL/I2cbo88I/zDOBSohnc3Y=@vger.kernel.org
X-Received: by 2002:a05:7300:c7c1:b0:36e:b05e:9a74 with SMTP id 5a478bee46e88-37686a49cd9mr2558403eec.30.1794400590962;
        Wed, 11 Nov 2026 04:36:30 -0800 (PST)
X-Received: by 2002:a05:7300:c7c1:b0:36e:b05e:9a74 with SMTP id 5a478bee46e88-37686a49cd9mr2558373eec.30.1794400590107;
        Wed, 11 Nov 2026 04:36:30 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm15159947eec.28.2026.11.11.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:36:29 -0800 (PST)
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
Subject: [PATCH net v2 1/4] tg3: Don't fail probe if 31-bit coherent DMA mask is unsupported
Date: Wed, 11 Nov 2026 18:09:13 +0530
Message-ID: <20261111123917.910416-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
References: <20261111123917.910416-1-pavan.chebbi@broadcom.com>
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

