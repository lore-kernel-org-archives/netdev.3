Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423743;
	b=Y5hcARJPs+o/DcQJcukbOkGRwZ46CdZezmQCYeWLvnwzU1P1w+G6fhA0T7Uk9QHECHVQ
	 WfQthge1mA+tH3mNFGPcXEQPayIc/cPZiRqV/pkHBNxoWgyT2iGgn7MdAxWxESQDF0Wnt
	 quEx2OLB5Q9hSMzvcGJXqhAlvdv1HfnVg/bc1vmFXz5G+TL4h4DL3i13imTR7WNYQccov
	 ak4xxBllT6hlvDcsOs9Mw5bX/fTHHWI01lD/RP33JYF9EHyre4D0bdWBVG1Ty2FGyJDxk
	 JnDgKSiVLNAyxS2wd9JktZLNy0FZw+4feVWbEDH0KYA7FD43d1g9y+cmdjzbL9soTTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423743;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=TgoELlNLV+Tg/+EMMPS7V53hbcJ09kF4geHWbDiPE0Y=;
	b=s4YoYWV/9lbW/fd6xUt3p9q9+j8d/r09bENVuaFMrjKD8gxQpRyDKGTUWJNIzMCMH8Wr
	 Vjiknq6fDw/1gHdt6oIEt2UPHbtYeB1gykH2PdycMDEj7o48lsXC+jpFF9JGxefbhvtoj
	 slhFFHfzdG4wrE8ZqPKCDm9KkJT1FAGjFPMKDMsIV+mFvgWEBJm/ZlgIgYLgMAQl9i0FZ
	 JA4+E62npa01AK2ZwbQDYt8NR4k4vL9NDTydxW4580byDG0YSR/cFBVqxYAwi7DO9tyUZ
	 WICdClM65axLKO/1c+kxquSw0aPOjf8EEyz3nbPNjAlhGFGJ44GFHwemlJ5izCJ8XQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DWaXy19r;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDC60A260D
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AFDC60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DWaXy19r
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso2603731a91.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423742; x=1795028542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TgoELlNLV+Tg/+EMMPS7V53hbcJ09kF4geHWbDiPE0Y=;
        b=J0/zJvqx+PHpESWWpJ58NxvdGweXDI5snr/3jDh5sDTdNcrNNa6+E0uUlosdB9KajY
         ksu/yZFlSlRTWnJH2bA0MxlDhbb67EgTf30a1wgzXoA1WZtpK/mZF/UNrNa+9LefPqEm
         ptDfnqMaxsn4uPWzjKRRVQu1na70mn7Kj2cmESww6Rjcz5iUV+tzjzViTzIA3Y99Eyzo
         gEpC04x3KvDt+aNldL7DxOZjnB7toea0jW1DAs0PuSVAm7a0c0K+QBxsMcD4l/fKFrYP
         /DAyhCflmNkbwy/yKeduLilSEspVTLIg6llMmJQQsCe2A+hv9ca/YjvwGUg0tvwNTxI6
         fnYw==
X-Gm-Message-State: APuU4Z8ymwGHmXh+SCBkFSnK2iVc959CdNmVR4r+HSk1m70+Gb5JzIwO
	RXK5O41sCAJJlbLPOduKPOxAp448k2qeRxx0NddZlu+/RQvY/CvKpGnbaf1IjJt0vyIa+OG8IZu
	MxLR8nns3vKwtHK0giAJX8VzukzSWPvplVpOsiGZVD0Qh84Dx/VRwLB7/ykI8ZnL44m3hEFFxvA
	rNU5dTqcWLdqAQY9GgNT/9S+jj4hGGpSKrW7b+RT4lwNNl/rV0U+g7qQAYpgpv+1XwZ7OYLYfgF
	4Ui/abAal2jHAMAvw==
X-Gm-Gg: AYBFou2h1BhcIkRFQp7DR/mRiT7yVaC/+WPWYMU2aGMTBJVG2T4rLDdP4hyubHC9fgx
	e9LzadL1q7EFE3jmELOCPFDvR/1TiCLtwEniJ11FREzTgSn862DNKYeN4PBp3LUidKaheqGf1Ey
	3xwfglrxtQR3JKIxkdztLltcszE42RTMmXp58v2HxMeCu1nQXWKZHGX+ykuV2XAHlw8vhBFLjTs
	eNUlURHZ/I/R51oyZkM3ybmewiGwTOKMjPqW+g/zEGcboOR5S21sCCm7QUEIDo0aHU5Hv//Vook
	ilsMqQx1xv4W0fvkvSPaBZuGFQYeexz0FBldhpHiBj61xzkBIcj7jmBVUU8Nm5vXEloUeEYBH8f
	GlvEQw8G4tKFZbY5QG2KYIePkmV48yjprYmZau8UuCmsH8Lg3HFrEWIzjKhWuG9o8mP1ibIgceg
	8WH3dCUDT92QJFIyuPdu2HYubrgT+FHjH6+xoadbeQQQ==
X-Received: by 2002:a17:90b:3ec5:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3b182f298f7mr3276347a91.52.1794423742158;
        Wed, 11 Nov 2026 11:02:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197cdf4dbsm204437a91.8.2026.11.11.11.02.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:02:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso6631363eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794423740; x=1795028540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgoELlNLV+Tg/+EMMPS7V53hbcJ09kF4geHWbDiPE0Y=;
        b=DWaXy19rC2ebBsGyJgllq5sZgPHnGDZs06hMWt9WMJBNXkJYPZlhTjHDzizhvtAHfB
         7v0bxyf8hKdxt7lLnHJ40SKKU6Q7m5FtIvhAgvgwVNXBD6LiELb9ChjwKG9fitHFGsfw
         RsUdUrKrrCmiB2GSDe1ZGTmGCUeqtXJNZulxE=
X-Received: by 2002:a05:7301:2907:b0:369:fdae:c9fd with SMTP id 5a478bee46e88-376850ce224mr4973797eec.13.1794423740043;
        Wed, 11 Nov 2026 11:02:20 -0800 (PST)
X-Received: by 2002:a05:7301:2907:b0:369:fdae:c9fd with SMTP id 5a478bee46e88-376850ce224mr4973743eec.13.1794423738865;
        Wed, 11 Nov 2026 11:02:18 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212ec002sm20860468eec.26.2026.11.11.11.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:02:17 -0800 (PST)
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
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>
Subject: [PATCH net-next v4 4/5] bnge: make irq_tbl layout depend on BNGE_FIRST_OPEN_NQ
Date: Wed, 11 Nov 2026 19:00:10 +0000
Message-ID: <20261111190011.53437-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111190011.53437-1-bhargava.marreddy@broadcom.com>
References: <20261111190011.53437-1-bhargava.marreddy@broadcom.com>
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
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     | 19 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    |  4 ++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  2 +-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 5cc08177ff86..5f7147baaf83 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -240,6 +240,8 @@ struct bnge_dev {
 
 /* Index of the first NQ created in ndo_open() and destroyed in ndo_stop();
  * lower NQs live from probe to remove.
+ *
+ * irq_tbl order: probe-time NQs, aux (RoCE) vectors, open-time NQs.
  */
 #define BNGE_FIRST_OPEN_NQ	0
 
@@ -289,4 +291,21 @@ static inline void bnge_db_write(struct bnge_dev *bd, struct bnge_db_info *db,
 bool bnge_aux_registered(struct bnge_dev *bd);
 u16 bnge_aux_get_msix(struct bnge_dev *bd);
 
+/* irq_tbl index of the i-th aux vector, also used as its ring_idx */
+static inline int bnge_aux_irq_idx(int i)
+{
+	return BNGE_FIRST_OPEN_NQ + i;
+}
+
+/* irq_tbl index of NQ nq_idx. @aux_msix is a single bnge_aux_get_msix()
+ * sample shared by all NQs of one allocation.
+ */
+static inline int bnge_nq_irq_idx(u16 aux_msix, int nq_idx)
+{
+	if (nq_idx < BNGE_FIRST_OPEN_NQ)
+		return nq_idx;
+
+	return aux_msix + nq_idx;
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
index 197a9032bbeb..400ada1023ed 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -540,7 +540,7 @@ static int bnge_alloc_nq(struct bnge_net *bn, struct bnge_napi *bnapi,
 	}
 
 	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
-	ring->map_idx = aux_msix + bnapi->index;
+	ring->map_idx = bnge_nq_irq_idx(aux_msix, bnapi->index);
 	return 0;
 }
 
-- 
2.47.3

