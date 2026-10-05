Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CE395AF2
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233007; cv=none; b=RdddjItjVnQnYMd8v50b+yb2vpJD/cUXfy4PL+AwSP50pSfDNPXhSBawPZvUVH6g9OLOGhHOMRyMakC+FOBKPp4oz0ZN0FjSHZ3+BZSHk+uZOuYaz/eM69Z+NOKiuyqHFm775uGyFeapNZ/dq16ehnL9sx4v732l7C6lGXGyeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233007; c=relaxed/simple;
	bh=SJXtG80VezqmvJjA5OSEgRCFZB5TZAz1G7FlErxVIb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pD1rAmS/ZYWP/C6ZzFzKW41QnEm6U8gxHGWzwVFXoOBMTOvO0PJ1SODZpI3Gvy7gv4qqQt8KUMF5GHCW77HnQBlwmIKXZvHh4PoVUJ9abgVvw1V3IUk4C99QTbrIa6xVI8Ryam/qrxU+uzgM4oPg4NPQZyRXPjYqFOH5GRSi5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DAyxhgc5; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DAyxhgc5"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-66c9995ca60so221534d50.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791233005; x=1791837805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WMv7IMUKAa53pHUdESqhNQyHFGPLaLTdIWo9Wt65/+4=;
        b=VrKEkliVkTW6pqrLcPyFENZIJzikytGEMBNvJvCZS9L9wLfKMEEXXsnSITi5aw+vqO
         kJXutc1VOGihDzai4sYwvYCpL4wIiL3IpMDPHCey9ySnz2qbe4oxsxkiaNs2qrjmQCqX
         X/d4CSvNz5sxkdRVcc/4b7uZ9fZkIif21REBMB9eqXVU8Zbsw6nNvaU/0ckVDJcgFzPT
         RVthdXfP/ehpn8yN3X2VfZ5leJqumAt/YosHU/sHu3wXqBDVpUwPlOPYJCgjC+kSsfoV
         OMyM27qrSbIp2yusaPnUfJii7p52zuEidJbQA1HRnThdVlpOOi120WOtj/zzk0sqU33V
         A6Ng==
X-Gm-Message-State: AFq9FYKxHY2VxuazlnBBeV87mZJWnVRCsQoNp8/uxc5fTsIYAGUEWiDf
	DWQu/bERu4EsGxaKrQLFVyXHLoomhxvbBHmmW5pQAyIYT4b3bzAIhgyHQCW33jZD0BfDdhTuDQJ
	FNSTEJFHCsookiQ2zZWeNIJ6agvuwXDaipiV5AyKvFUNPtH7D/L5ZJiV5YPGKZ9v/IIqrZ0AyIb
	ZkEesgdUTDaO7YOvtE3FnHkgOl3N27gNB7ePJbi7zAs8HjJUMtGQs2T7KY02mlWSZv9a5tWDcEO
	xwOgL1Ix60=
X-Gm-Gg: AYBFou1FMS1syzQNWYmqnbsMb9qEXVz9opZGwdjQy0S+Y+/9lU6lowewvzM6q2i90p0
	Mn5O2KXjnaFJRPgihMtrs6/0URujeUb+7coe/jPRKoPjnsZwApAMHGc4ckKNMtReCTtJcyGLaZ5
	Qsu1aWsV8dh3WjeZnQ8hEfU+A4q91U/bICxGqPSz2g8qq+wy9KLhDFNIgGeVmYe6K7rB1xZK5Rm
	hrRVvAsVW2SCKRMRL+8ZpQHdNgxtPJce574HQWp4AlVcnslk+orANPm+WtkZ5xXoBlnYCU8olfy
	9RNsEoohM4y6ajzwDyQZDWQczRqp4UliwtqWy6+hTGsRW6Q9jeu3tKcRAVtk+UDHLUMYnXz3ZFs
	/AW3tJ5vmxQt8qxL5c2iwSspkoYDOeR5nOq3yhDK20r8rJfcZJYS/NjP8WjTsboCXS8P9SpVP4/
	7mg394jZWJbWHXx5cPNYbQlDI0161ZCetjoH6JGg==
X-Received: by 2002:a53:d014:0:b0:677:ceec:5eae with SMTP id 956f58d0204a3-677f1579e23mr327752d50.24.1791233004554;
        Mon, 05 Oct 2026 13:43:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-677c1b127d8sm1426151d50.12.2026.10.05.13.43.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:43:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9196b477c4cso6168806d6.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791233004; x=1791837804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WMv7IMUKAa53pHUdESqhNQyHFGPLaLTdIWo9Wt65/+4=;
        b=DAyxhgc5k4ftao0S4X8st8wQ766dSDlDk8fHjK6Eq0Q/DetNqNJG+nBcCVBvlmqsg1
         815Q7MV9qrhvr3uOV89kvukrEPoOW/ufExUnBQL43UyYydjCIvQRtjaRYfjA9f2t+VT6
         kiQfFaDpS1d/UJ0lgtyFMyFiqHo4OpG9I1/MM=
X-Received: by 2002:a05:6214:5693:b0:919:5356:3c1a with SMTP id 6a1803df08f44-9198580f210mr13643306d6.4.1791233003656;
        Mon, 05 Oct 2026 13:43:23 -0700 (PDT)
X-Received: by 2002:a05:6214:5693:b0:919:5356:3c1a with SMTP id 6a1803df08f44-9198580f210mr13643086d6.4.1791233003259;
        Mon, 05 Oct 2026 13:43:23 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d593b457sm96914086d6.4.2026.10.05.13.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:43:22 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	joe@dama.to,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net v3 1/3] bnxt_en: Add bnxt_clear_bars() helper
Date: Mon,  5 Oct 2026 13:42:44 -0700
Message-ID: <20261005204246.3822563-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261005204246.3822563-1-michael.chan@broadcom.com>
References: <20261005204246.3822563-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

In bnxt_io_slot_reset(), we clear the 6 BAR registers.  Add a helper
function to do that.  The helper will be used again in the next patch.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d7728d0c5b6e..8ce8a82d3453 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17111,6 +17111,14 @@ void bnxt_print_device_info(struct bnxt *bp)
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
@@ -17598,7 +17606,6 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 	struct bnxt *bp = netdev_priv(netdev);
 	int retry = 0;
 	int err = 0;
-	int off;
 
 	netdev_info(bp->dev, "PCI Slot Reset\n");
 
@@ -17627,11 +17634,8 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
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

