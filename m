Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D748C8DA
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521250; cv=none; b=cRbJ4/3vh08ulgV9WBnqwO6xukJOwRbdCyAm5yQV4/hj4lLvxYL5cH4+9WPhQk6RLU8HO4FbGAm/EX8TqfUwTLfyE22BuE2FWew+Qh2PMbK3ymi4beoicwh+zILemmOUU2GQahdLOCUntG0OTKIU1+FdOfde5tNSOCSlXuhxvBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521250; c=relaxed/simple;
	bh=WqnOhyozATOrBQQKHuez9BICxmZbVLOp38KMj4rrD9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jV5mICeQ+cnjCkoJ+3PzrEQCIdp0Fu6CZnzDDVtvsocKAvuOIQdXnXTa6luOE5GjjQASSBwkst+uMFpc6sbETFMdvwaXiJwsUPmLCOgzCXJkNYZ7bzJ6KosUWfBPItB0MkTd230zbr4oWfZrRhWP3yZcyTGjYA4lH+MpqwKz/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixQoGAKb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixQoGAKb"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c96d2bebca3so469438a12.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783521248; x=1784126048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJCoIdZrkBsmsYLxqMMI+XolD7vuNxL63Fiftk6n9Yc=;
        b=ixQoGAKbNlf+MLeKlQpCJGemwuTedYtJ0kZxotserNeTeX7zUWyQl8rwQMNcVbmWM+
         L4caswpMiaJ+w4fiQhb9WTgRqmReXL2oLgJxq+ST5NwH+qHNNcv+kPtnkny9ZlTAPk85
         zvJPN4pitr/ANyKaqs6lHiJqw2vJegKp0P7o1aOWWHzgAciMtAu/Bgk1hNCVbVZkaEdE
         cxt3hYJmbfPw7Mi1YlE9RUs2nC74LH9FjUtchXcG2Cwmxj3NoMhaERjBj7WHljmrT/wQ
         /sgP4UC27OidqsaRJreOK820DihF286fa54+9KxhxQGjwGuaL7QJTbyWMTGkSqIo4z/j
         TeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521248; x=1784126048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJCoIdZrkBsmsYLxqMMI+XolD7vuNxL63Fiftk6n9Yc=;
        b=U8yMPgOCdwzznmTkguEGHa1DofLNbw0Y69n+tNn7Ojjf61Z9OAvygiy4nwjKhCaIMb
         8t04VDjxSxMrqeIG4Mn7mxK3N4pE3sv3WpAu2721mIZmTDx1JgN1CmtmZ+7IkfwExjgv
         CdXjD7mXOghF/0SM1RGVLtsHSa0M5EIKbkkweuHx67DD3x1/5hjBxoPq2i5a52zTZ0vP
         R5T7HT9TZbSl+vwJ02m602vSDAh6HVvgiIeUTfbF9jgT+JHqsapApBiBlphvvVxbVPRJ
         Nk1Ndx5iF2I4pF5YXkiL0ZGxhLA429ITJuK6Kbb+MOk/S5F9VBj/cVx6t0pryMA99/sI
         WYjw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2BFhtc0jJbEcS8dyrEdfwEqOJw9Wv/STIO0dc4hLs1r9JcZcOGBrypOzroITaSjKUFaD0YE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpfBXQgjUiJiCT30G/Yqx5OGLBDblLAfAmhJu9DIcN0baq5ag
	0bnxT3w1VrCxRkOAU4qWhw+soCfPbKjErcoDUYk6r63WozQVHc0De9cG
X-Gm-Gg: AfdE7cmeq2PJa+KAl3tDWWl33g9nx2wolxdSoxiTeTFZV2qOQFEUxtUKHWNp6qMFWo0
	c+vQsRonlVGsJfVQlW7qmrcvkuvVRoiUJdmHIOOWi4goj9e41nEz14Fd2rpcMQ5gZU6DOUwQejl
	5LNcS5G75K7lM9Qj5A2qergSE/WqxOc6XKFf3oXUjR6a8994fLmSEj5bLKYov4FFTPj+QE3B6UP
	IqnSom/FAAQbi359Un637P+knVJBNJUslooRpHi24/EUupIH4entsvQzBz7VfkQyJQiT6Spevf2
	E7gNgYmiPZzq0opYDrZG+cO5xElX3y4XASBjpvAjndj9TZgqYfMj8bsLK38LjoNI6H3hzK1Eb58
	XCCLs9Y21mtSTeakRL0DJ5SK65FxhpS5Pnmd4PsfRp07SunFD81Fsisjmx5Op91izjVx+cpBKaE
	EK+PCcgpCr1j4SA+FtniLIJ8gEb6eCRUsI
X-Received: by 2002:a05:6a20:c998:b0:3bd:203b:982b with SMTP id adf61e73a8af0-3c0bcc487demr2883242637.16.1783521248442;
        Wed, 08 Jul 2026 07:34:08 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:1b95:b995:f60c:5c67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162f65sm2414387a12.21.2026.07.08.07.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:34:08 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jacob.e.keller@intel.com,
	andrew.gospodarek@broadcom.com,
	vikas.gupta@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] bnxt_en: Handle partially initialized auxiliary devices
Date: Wed,  8 Jul 2026 22:34:01 +0800
Message-ID: <20260708143401.3167477-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_aux_devices_init() calls auxiliary_device_init() before allocating
and attaching the bnxt_en_dev and ULP table.  After
auxiliary_device_init() succeeds, the auxiliary bus owns the embedded
device lifetime and the driver must unwind later errors with
auxiliary_device_uninit(), which runs bnxt_aux_dev_release().

The release callback currently assumes that aux_priv->id, aux_priv->edev
and edev->net were all populated.  If the bnxt_en_dev allocation fails,
release dereferences aux_priv->edev while it is still NULL.  If a later
failure happens before aux_priv->id is assigned, release uses the zeroed
id field and can clear the wrong auxiliary-device slot while unwinding a
partially initialized device.

Set aux_priv->id before auxiliary_device_init() so the release path can
identify the slot, make release tolerate missing partial state, and clear
bp->aux_priv[idx] on the unwind path where release cannot derive bp from
an edev.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 194fad5b2781 ("bnxt_en: Refactor bnxt_rdma_aux_device_init/uninit functions")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 5c751933da6a9..e85d1b6c9fb1f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -472,12 +472,17 @@ static void bnxt_aux_dev_release(struct device *dev)
 {
 	struct bnxt_aux_priv *aux_priv =
 		container_of(dev, struct bnxt_aux_priv, aux_dev.dev);
-	struct bnxt *bp = netdev_priv(aux_priv->edev->net);
+	struct bnxt_en_dev *edev = aux_priv->edev;
+	struct bnxt *bp = edev && edev->net ? netdev_priv(edev->net) : NULL;
 
-	kfree(aux_priv->edev->ulp_tbl);
-	bp->edev[aux_priv->id] = NULL;
-	kfree(aux_priv->edev);
-	bp->aux_priv[aux_priv->id] = NULL;
+	if (edev) {
+		kfree(edev->ulp_tbl);
+		if (bp)
+			bp->edev[aux_priv->id] = NULL;
+		kfree(edev);
+	}
+	if (bp)
+		bp->aux_priv[aux_priv->id] = NULL;
 	kfree(aux_priv);
 }
 
@@ -571,6 +576,7 @@ void bnxt_aux_devices_init(struct bnxt *bp)
 		aux_dev->name = bnxt_aux_devices[idx].name;
 		aux_dev->dev.parent = &bp->pdev->dev;
 		aux_dev->dev.release = bnxt_aux_dev_release;
+		aux_priv->id = idx;
 
 		rc = auxiliary_device_init(aux_dev);
 		if (rc) {
@@ -598,12 +604,12 @@ void bnxt_aux_devices_init(struct bnxt *bp)
 		bp->edev[idx] = edev;
 		if (idx == BNXT_AUXDEV_RDMA)
 			bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
-		aux_priv->id = idx;
 		bnxt_auxdev_set_state(bp, idx, BNXT_ADEV_STATE_INIT);
 
 		continue;
 aux_dev_uninit:
 		auxiliary_device_uninit(aux_dev);
+		bp->aux_priv[idx] = NULL;
 next_auxdev:
 		if (idx == BNXT_AUXDEV_RDMA)
 			bp->flags &= ~BNXT_FLAG_ROCE_CAP;
-- 
2.51.0
