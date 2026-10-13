Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943D5476C1
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922108; cv=none; b=Nq+fWd/NAwDX4JuZRaUPip7IjJ8OVapDJoYU2bb9mrCkHDFynICAl5KsPrFMqSyFiuGWDFPz71gi4tSjX4Tc9dVr7xYRSrEjz3w81cR6faT9a1KjfVxWgvdOgYKkLpQWE1M0ZEpJb9UmVm+S5tsLSGPMj3b+e77BAS0tQeUe/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922108; c=relaxed/simple;
	bh=HRGi3+8s+xZ0Pv2YLVltUZU5MS3BORmziEe4ICaxj2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnKYfk8mNNFmzdinwnAcb/PUSUIqjyFP6H7w4nT7AVli4F0g77lJwrDHR5Ho2yd1KIt6MfwKWNJgpUPJv0WujAvaN2QBvMLnij6plLCxJbq5/pnRJnBKR2CU72TLkq6kWg6DVrM+uMxF3HeDa/7PSxPvLAN17LSjLNekema7pM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T2mVNeGo; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T2mVNeGo"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ac397836fbso1017232a91.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922103; x=1792526903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2ErZj7OvfiHzwXbTEuEIcm9vf6VpN09VWgyrHzyJFw=;
        b=QG+H88HCPeSiqe3CFjxyZCzYKnFGXlAU2nl/knLAm6ppNDp0c+QJixMbk0MMj1CTMl
         WnLmq5utWUeqD5+Sg6vpsRFfl68a3HpwW0eMVsdMA76uhrifPb9CpOEUJ98ZYYc0gfkt
         V48WE2lC5b8oK2VdbFtZgkadyZ8kXYzZRXGgrqQRObLVYbnglLPDlGoTpCZBXEMr/Eut
         a9veImNeiWAu9Y2YbtVD6N1kl86zoCzTpxcyFu/HUReGKQvqTCEl4nSzS0J+3u11gCwK
         tDWF7Dx1LMlJK3shAaSoA4/HTkrSAG5T9e/Pb0an+l4XM8tGV8KXoWCm/n3RoTjOpkIC
         vlww==
X-Gm-Message-State: AFq9FYLGVQHAq1qHjJqWJCNAuU469TuFWZ2ekqVIfTUJrFPesGzQvoGt
	g9duwUxsGYE2einX0WXB8vmn6LcSSou2N29kNsJeX/deB4uEradeQnuG+zVrxejTfPPkJ7ydAQO
	P3uQeT6yjNZTnjCJQoJqe2nMpCVszlrhu3tAPXPeGzHKhx03zPcE5LCH5dJ0/+KcxLf3E92ijRQ
	ru1Lzp5iryyeSPgr56DDRx5MyN202ZlO7WcMndEjLt/L5+EcMF5lcJCdrf5nQf56oqJIbCZyx+g
	RNF4bK2C3fG1tHf02sOVoo=
X-Gm-Gg: AYBFou3Q1qGm+l6sOAqKSI5wvWsfWsaNuFC0lNE7P0b+ORklWFJD0XB9JzuXGcufKf7
	F+jSBi9GZB1ndkmas17jr1u3WqmTpzVqJRSpiXr4CEOxo/TXE/+Xg8hNFFWvZA4SseU6EGPwvze
	xqeK+B/VZUy+ou8cL/mfIgkC4nJYU7yK/kHp99rBkHuNA69k5Pt2We4uPq0XL/moVrDamlJV5Wa
	7popA9PjorgE9rEeGDXzZ3hMvX94xRaUKoitAVA6ZhjW6hFCRPPARpPE4GvecBvLYGd6zI7I4Y8
	Z4mp9e5QiWo1VOP4KhSdmyd+GPHKve/xINHN4aU42H2LS4pwqn/iufuJTevRibrUh4NtQ1AwhiV
	7S4ZPBD3sZKLEkWo7cLu0cq0fX7q0WyppId6FjGrEKeuFPx++5OG2ro5eH8trF8tAUS4ze4/Akw
	297nSTZfqP0o+0KedbtFJLg3jathpPlSAT+gIKgraaobiA
X-Received: by 2002:a17:90b:1d4f:b0:3a4:a592:4cfa with SMTP id 98e67ed59e1d1-3ab3a79d9f8mr11143018a91.45.1791922103099;
        Tue, 13 Oct 2026 13:08:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac60395c4fsm310247a91.6.2026.10.13.13.08.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:08:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so13565256c88.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791922101; x=1792526901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M2ErZj7OvfiHzwXbTEuEIcm9vf6VpN09VWgyrHzyJFw=;
        b=T2mVNeGoIkhbtajAiAk8t2Yan2lNEPw5td6IHwmTyso52eE0XRx6VgrD59Zdm5k0Uc
         Y7OkFbAOnCW7If826p2Q9fMrnIGhdID563YCgnT+H0xodLs8UNFdfiqRIpcoqq1MuqKC
         AmXRs6F3XjgEUMUwq9GMNoLkJ16uD8NjT6MHc=
X-Received: by 2002:a05:701b:4583:10b0:149:cfa4:9b3b with SMTP id a92af1059eb24-16a5b2c7120mr18196186c88.3.1791922101159;
        Tue, 13 Oct 2026 13:08:21 -0700 (PDT)
X-Received: by 2002:a05:701b:4583:10b0:149:cfa4:9b3b with SMTP id a92af1059eb24-16a5b2c7120mr18196156c88.3.1791922100434;
        Tue, 13 Oct 2026 13:08:20 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm39526585c88.11.2026.10.13.13.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:08:19 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Subject: [PATCH net-next v3 4/5] bnge: make irq_tbl layout depend on BNGE_FIRST_OPEN_NQ
Date: Wed, 14 Oct 2026 01:36:44 +0530
Message-ID: <20261013200645.1346299-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
References: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

NQ0 will be created at probe, before the aux (RoCE) device has been
given its MSI-X vectors, and must keep its vector for the lifetime of
the driver. So the probe NQs must come first in irq_tbl, followed by the
aux vectors and then the open NQs, instead of putting all NQs after the
aux vectors.

Describe the irq_tbl layout once, next to BNGE_FIRST_OPEN_NQ, and add
bnge_nq_irq_idx() and bnge_aux_irq_idx() to compute the irq_tbl index of
an NQ and of an aux vector from it. bnge_fill_msix_vecs() uses the
latter to hand the aux device the vectors that follow the probe NQs.

The ring_idx passed to the aux device changes meaning accordingly: it is
the irq_tbl index of the vector, not an index within the aux range. This
matches how NQ rings are created, where the ring index is used as the
logical ID that ties the ring to its doorbell and MSI-X vector. The aux
driver uses the values it is given, so it needs no change. The total
number of vectors is unchanged.

BNGE_FIRST_OPEN_NQ is 0 for now, so the layout is unchanged. No
functional change.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     | 19 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    |  4 ++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  2 +-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index fdd8bca01440..13452caa9081 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -241,6 +241,10 @@ struct bnge_dev {
 /* Index of the first NQ created in ndo_open() and destroyed in ndo_stop().
  * NQs below it are created at probe and destroyed at remove. It starts at 0,
  * i.e. all NQs are open NQs, until NQ0 moves to probe.
+ *
+ * Layout of bd->irq_tbl: the NQs created at probe (none yet) come first,
+ * then the aux (RoCE) vectors, then the NQs created in open. The ring_idx
+ * the aux device receives is its irq_tbl index.
  */
 #define BNGE_FIRST_OPEN_NQ	0
 
@@ -290,4 +294,19 @@ static inline void bnge_db_write(struct bnge_dev *bd, struct bnge_db_info *db,
 bool bnge_aux_registered(struct bnge_dev *bd);
 u16 bnge_aux_get_msix(struct bnge_dev *bd);
 
+/* irq_tbl index of the i-th aux vector, also used as its ring_idx */
+static inline int bnge_aux_irq_idx(int i)
+{
+	return BNGE_FIRST_OPEN_NQ + i;
+}
+
+/* irq_tbl index of NQ nq_idx */
+static inline int bnge_nq_irq_idx(struct bnge_dev *bd, int nq_idx)
+{
+	if (nq_idx < BNGE_FIRST_OPEN_NQ)
+		return nq_idx;
+
+	return bnge_aux_get_msix(bd) + nq_idx;
+}
+
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
index 0955b488b6fe..0393bfea7b65 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -34,9 +34,9 @@ static void bnge_fill_msix_vecs(struct bnge_dev *bd,
 	}
 	num_msix = auxr_dev->auxr_info->msix_requested;
 	for (i = 0; i < num_msix; i++) {
-		info[i].vector = bd->irq_tbl[i].vector;
+		info[i].vector = bd->irq_tbl[bnge_aux_irq_idx(i)].vector;
 		info[i].db_offset = bd->db_offset;
-		info[i].ring_idx = i;
+		info[i].ring_idx = bnge_aux_irq_idx(i);
 	}
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 0d98223cd703..dc6cf3525034 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -539,7 +539,7 @@ static int bnge_alloc_nq(struct bnge_net *bn, struct bnge_napi *bnapi)
 	}
 
 	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
-	ring->map_idx = bnge_aux_get_msix(bn->bd) + bnapi->index;
+	ring->map_idx = bnge_nq_irq_idx(bn->bd, bnapi->index);
 	return 0;
 }
 
-- 
2.47.3

