Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E038A70C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144280; cv=none; b=QxeKs5kkPMuBUQXzGx08o/u8GitOwlnO+juEEZB0IieAGG+pNddPuit4e8/XIt4WjB21qgxbgdGJSWspHwu2FkmGPPwsaxRdY7NTuZk4W39tvS6xaIe51W6ViYxc2MwcLc2Qod1NIDbUGHBkVfYklFbYTPyVs5KdYgkti9aAHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144280; c=relaxed/simple;
	bh=7qiD1yZEFABldTFuxJIvzKmjfHO49sZ7e4ZTVKBZ1hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjAzsKcoPwIpDIa8Pbh2TfQLqUI26x0omZI+S70LwEMjZ8paVfCcnCwi9OpQ0OBs5UrcPSH0l6Hneu4FBfMvIXo8OlPjqC9Bdo38SebOXvEV5BTCE7RcgSikfiQB+i0zGwjPrDZUrFOrMXTRoRyKdHnzKTgvVBj/DGgoEXpuHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N1bFr0kH; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N1bFr0kH"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-398a5aad413so1331131a91.3
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788144275; x=1788749075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezJW/T9+x/sMhmS+vBN9yj4zaCeV3URTs8Usy3AKJQU=;
        b=cKFuQCBmsbgKvOXdCaNcTORMg799HdpaxYPkKBU7PSxK7BlMIbD5QZ3UqsM4g7IMrj
         IsTo4E9I9LwKsffXnyou0550JdDXpHPtPcZpo6hXXH/d+hjHzeTRTXpNRHt13m6WEkyx
         0xAa0hdglPBJSDoSnrYOJogbIQ5q5oElc+ddETCucus2kow7d+KFHB93ODrrV7elzaTw
         klkfdcVG/LfS783p9NzVYQq72DpG7yfy+6RixE+VKe0yhUGa1ked866128AtXusTGMdy
         Z3VyJBvesRFyQUy13GE/QOX6B2oHEF7JNeLH0lJKWJoiqqMgPdp7esEIWoGR6E8nKRzT
         mk1g==
X-Gm-Message-State: AFuF++l82Z7zzkIq0fWrvhmEq0yXIim9eQCv1qae3oEQ1CPkFmXdzRxj
	5svW9KOeTxEXfWrDTm4b8UDWhs2/X7fMItWbpAQH0HsviXQTnAn/lGKzXPvq7puj+1dkiZ4FfZs
	Xx1ZWWvZ0q8htLdgp6VKl3ToSJR36LWkDm++KhNVf/ngyFYOrqCx9XPpT0ve32O5d9GUY3BFnaA
	SxV+WTMBWFtVE72ll5fykgByRD3d6z07QP8Sg/SU5CAJuCMTT7Dh9yd/rRMtdOz6ze/OKi79GHX
	OxkkXPQsOo=
X-Gm-Gg: AYBFou2cHPq3RimIDv4Mu+UU1x4yhpVnH4g6ZNPlgOiNYcOt6NcylxRnChU8YcLNQnU
	1eG5PjFETCfjts8udBuEN79fcWpP4yWCpS92SWGz3ZWuxcuetwAPQHv4hOwTRx/xPcJqFn2dz8u
	vZ0IJZ0HQWE2lo7Wp2UF0/IkqtagKHF+I1t4aK51VkJvStrFyHwq3GjWmubBG8u/DJLutI35g8N
	stFQBb3xQjMTGs3iYIGTG6+LKG+880E7n34LJg7DkC/iWSTrfRHF4bdNElEKMe8ZcBLKZvQ/PZG
	r9aHzZSn1wT7hoMm0y0jJlwsSPR+WWYYOJinL1Bogk1Y31nTZD3CyjkfcZIgCdAqu6IJIbURFjv
	nSh8b2N4vbqZsaztecdPpy8AZJPNDNUMI1MIdgo0+bv1fsFoePb6ltWQYJoMusu6ndiqH+MKXHy
	oFcVCbjnzQpDkL3uJmkLw6hvz5E8oaghC+icM=
X-Received: by 2002:a17:90b:17c7:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-396d0fc1b2fmr34540103a91.16.1788144274823;
        Sun, 30 Aug 2026 19:44:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-396d29cf863sm909617a91.1.2026.08.30.19.44.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2026 19:44:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8538a72b430so3354606b3a.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788144273; x=1788749073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezJW/T9+x/sMhmS+vBN9yj4zaCeV3URTs8Usy3AKJQU=;
        b=N1bFr0kH1i9v7w1RV/N0CsQT9Ano63aEDn1U1ZCxmPFkvZzWWQrnLFYsyoB6NExUxK
         s7LMNzMBh6fGDkuwExpRLRqzTQ/W4mY0lwuxmyiB2t/KFx0BXLQFw1sMbw9c7vJFJvKk
         fhBWAkZt2SOeidulAFSeRT1XXWIVtAO5WCQ5o=
X-Received: by 2002:a05:6a21:62c1:b0:3bf:b84c:2984 with SMTP id adf61e73a8af0-3d268ef9eecmr37290825637.11.1788144272839;
        Sun, 30 Aug 2026 19:44:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c1:b0:3bf:b84c:2984 with SMTP id adf61e73a8af0-3d268ef9eecmr37290793637.11.1788144272398;
        Sun, 30 Aug 2026 19:44:32 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm26421728eec.27.2026.08.30.19.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:44:31 -0700 (PDT)
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
Subject: [PATCH net 3/4] bnxt_en: Fix driver init in kdump kernel
Date: Sun, 30 Aug 2026 19:43:41 -0700
Message-ID: <20260831024342.2161156-4-michael.chan@broadcom.com>
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

The driver forces an FLR during kdump kernel initialization to reset
the device.  If the NIC is behind a PCIe switch in synthetic (smart)
mode, the switch may need to see that the BARs have been initialized
before it will pass Mem read/write TLPs to the NIC.  Save the PCI
state before FLR and restore the state after FLR.  The BARs have to
be cleared to ensure that they get re-initialized.

Fixes: 8743db4a9acf ("bnxt_en: Issue PCIe FLR in kdump kernel to cleanup pending DMAs.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a76674fd0d6b..c3d561ac53dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17091,7 +17091,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	if (is_kdump_kernel()) {
 		pci_clear_master(pdev);
+		pci_save_state(pdev);
 		pcie_flr(pdev);
+		bnxt_clear_bars(pdev);
+		pci_restore_state(pdev);
 	}
 
 	max_irqs = bnxt_get_max_irq(pdev);
-- 
2.51.0

