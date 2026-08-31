Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51E3ACF10
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144279; cv=none; b=KSfaNTHzyo9Uag2/JIGIKQhKiVotRZmUIv51Fl+aWWE0ewFuCExVNM+N1AYNCUGvvw1okAeEAjoQxRE2cYAQhBuQRDnUA0IuPKdsFgA/IGlXAaY1J3qec+CbF0HmffKFdqsUvoKb02r2fhPkxCcl5qrXVeoogNehgnpOmUdibsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144279; c=relaxed/simple;
	bh=u7A7DgJ/MFnPGP9GqIhdkIllM5Go9uOG8J9oA7oZWsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn4e4jpShFaXsQ2zDyH7M+Cw8N26zlPbOaBPpXhUXywroj0XxScF5ZxIUTqOURhX7foL8DNcNZ9h7AwkU0cbhFNMJFXFoVTDXqiweoIDj9xTFXR47n3qdUAEXqLhLp/mCRs9OkoF/KFyCtaKlxSf7siJRQKn4zEMGEpmEgpHa2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G4ELv7G3; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G4ELv7G3"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-6b13496112cso953416eaf.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788144273; x=1788749073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdz5/R0k5KHtW/tsLxJrzESJi2y+eKaK4L9u5tiDUiQ=;
        b=cS3Sm9BVX+s++RsRzHxnGntmW9U/KVQxX8JKSesr0F+Furf7ExAKbytHH3jtG7bWGH
         L7DoRhzJG1gdaDXE1/RHO5wM1EIyP+WHyHA/lngb0IvXjIm+mQF4uvjZ0rzLTkEs8cst
         bdMzG8rGh6QIyigbhZINQPqny3Pkwwpk3NUWkldo93R65AZ5/2sTtB7xqgxG8/W/hlmR
         DRfSW5fW06V5oo6WFfZEbWNg89luvG3CI22xbVMevHqVV94Yj5gTSqZUBB0u9BqiYzlc
         hLMqcKrudMnB9pHY3Lea93ZL8IZAfNYie4S+UwSWBKi24vP6XvXI9gY3uJBbknBOSV0J
         tbYg==
X-Gm-Message-State: AFuF++mdOE4Xlkx5Z+E82qwxBrLZOGMvF+/pw7wksAyuhDYiImBCOp/l
	mq+4e4qo7e3UpG1DJEOd6rCnWL+RPlecuD0X6ovB3pinEjWJpwqGdv5yMTTGpE6/WlymMazvAuM
	NjNiAvoMJWfcuBybg4JCk6ynsaYHC7nFkemOYvJoKFqKRGGMsalTLLcxebVQNrwtJg3bAX5j+nE
	12aOCqEU8lrcYpQXrRZy+vNATFIpan+IRNo4Rlu2LtGOwJrhUumjMu4+miquBgi8H0n/1citzlH
	b4Z8Y3TI+0=
X-Gm-Gg: AR+sD13wnriX43fo/IlM1f13W7s3HZ217sO6HhH7uV9lNjWBQbc2yTZcjv9e5L3gIWe
	rAp3ZZQ2+T66E2ZDfrYcy/wHXZwpBC78XweWoWXzvQGN1e6gi1VYldLlRirKFJMuSRm4frSGoNi
	lRjvJfQMG6jftRXVEU/35ADN/OZsjz5QmsMdlnL/ckGgIRPjExabGffeSJo9SG3LVA2ldsKHs/y
	/lrXroYzCtKKkiktBXsmTn5S2olUl/WjeSB4TTcfCORgZsprCiRIW80w/ZH2+4c+xZw7QQcH31g
	DWVO3MgAjo8Sa1P3zl/nRHHpq/H9IcuJRn3BOJROxlewU+LE3EYr97eNwKgFR9F/DzcXu+ZYKji
	qcOXtzOru66RFDViOhTqBW+wHFO+gP3orK+mQGTqGUT66DNTkxSOfCqzuqjJNjN3P9jfy4pe0rR
	OhglR+9cUNf8aC3FHznNWu+fyREOzNhd5RtRA=
X-Received: by 2002:a4a:e6a6:0:b0:6b1:4357:9fe9 with SMTP id 006d021491bc7-6b1c6421e9fmr14110755eaf.6.1788144273006;
        Sun, 30 Aug 2026 19:44:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7f4fa94562csm740725a34.4.2026.08.30.19.44.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2026 19:44:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so5067790a91.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788144271; x=1788749071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdz5/R0k5KHtW/tsLxJrzESJi2y+eKaK4L9u5tiDUiQ=;
        b=G4ELv7G3v8QhHphaYChNovWqZYYKcZNecK3RBxaRkUaeZtBNYf7nk//nSY3TMl/hbg
         j5SstdB8ScKqCwaC/YtDFwwYv4HoP0lnTQbx3NXmc05y7aEyiLdLFaALOgWYw0whYIqC
         4UyN6djUL7IxXqv8hFaS/quma6cdeok+0Kq/c=
X-Received: by 2002:a17:90b:3c8d:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-398e9698ae3mr4303012a91.24.1788144271480;
        Sun, 30 Aug 2026 19:44:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8d:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-398e9698ae3mr4302944a91.24.1788144270950;
        Sun, 30 Aug 2026 19:44:30 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm26421728eec.27.2026.08.30.19.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:44:29 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 2/4] bnxt_en: Add bnxt_clear_bars() helper
Date: Sun, 30 Aug 2026 19:43:40 -0700
Message-ID: <20260831024342.2161156-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831024342.2161156-1-michael.chan@broadcom.com>
References: <20260831024342.2161156-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

In bnxt_io_slot_reset(), we clear the 6 BAR registers.  Add a helper
function to do that.  The helper will be used again in the next 2
patches.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 219a6f551f1d..a76674fd0d6b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17063,6 +17063,14 @@ void bnxt_print_device_info(struct bnxt *bp)
 	pcie_print_link_status(bp->pdev);
 }
 
+static void bnxt_clear_bars(struct pci_dev *pdev)
+{
+	int off;
+
+	for (off = PCI_BASE_ADDRESS_0; off <= PCI_BASE_ADDRESS_5; off += 4)
+		pci_write_config_dword(pdev, off, 0);
+}
+
 static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct bnxt_hw_resc *hw_resc;
@@ -17550,7 +17558,6 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 	struct bnxt *bp = netdev_priv(netdev);
 	int retry = 0;
 	int err = 0;
-	int off;
 
 	netdev_info(bp->dev, "PCI Slot Reset\n");
 
@@ -17579,11 +17586,8 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 		 * write the BARs to 0 to force restore, in case of fatal error.
 		 */
 		if (test_and_clear_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN,
-				       &bp->state)) {
-			for (off = PCI_BASE_ADDRESS_0;
-			     off <= PCI_BASE_ADDRESS_5; off += 4)
-				pci_write_config_dword(bp->pdev, off, 0);
-		}
+				       &bp->state))
+			bnxt_clear_bars(pdev);
 		pci_restore_state(pdev);
 
 		bnxt_inv_fw_health_reg(bp);
-- 
2.51.0

