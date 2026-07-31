Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE424503F4
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525043; cv=none; b=udEEFK4IdXoRXC4DZPeWh+cLyssYAqMzpyceZo2Goz3oY3Z/XsXYXlSQmMEtiKBKi5xM97/f74XGCuR9pmGayHNyDMqgCmZ7c0y/eqQc37wrNdOr19KwM5AEx0Xulu1l4naYOoYEXr7wxvyGYq0VVq29H6rfsZO12ivDL7R6Kjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525043; c=relaxed/simple;
	bh=0r0T7JfFDzq2JcEZ9wyhFyiQiryz4yvrrQl9mG4zrqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTXtS6dl80lnFXJp29T96I3T42KAXWZZ9S/5i08GMKRg2vUYsWu55neNMOVquxPFAES//lmfrvqgIaiVeTTyU+i9i3F9u7ABOTfmRLx6OhG5vfROADEOyOK4sk+IdMrE5GVa1A3RAWBX00EST8V9qHtZJh85ff8xSAnUOxR9Y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CilYmALF; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CilYmALF"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-848593533cbso931218b3a.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525042; x=1786129842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+ajiPN0JgPvfhIM8VYosd8xR3L1OxN0W6yK8gD07J4=;
        b=I9P57L09oMFvBwQZ+Rb2pvP/SA7LKm7Qms2+KXRcURWKeVGKKsMIcO/dkwdka3jRqu
         k2Sko+XiwmAmi4BzueolFTRCnA13THclQxl5ZX0HqU98mosvpY3wkm94IsrvkLj/0Gy9
         9+l3ituvDlA80Dai8Id3wbb9Lw31Qga9zIo08oGiunlrPb9VhLY1sgBsEYpOeYXqGVGO
         iP+yKIQroQqzORucMthor0TWZCWPQC0BlE4SrMnkMm8ZvYYWyCYb48vCaUmLPQS7Cbyk
         VBi7vK/sKp6O65p77hw2xgllb8Z5DCKTLek2KxKiRkCeL9/rF3A71gzQDq6klWfYCiUa
         0/Hg==
X-Gm-Message-State: AOJu0Yxv1pzaM4IBGlf2Yk9ZN2j5ABbfFMhFAK8soHMTjj4iTHU1tBCv
	GNQFEK38Ve12zw4S7UsdpSEYrlLEs6pmV396t5bp1DFAPySfh+EZx36QkIoTw/9GgdmDqm+UDRx
	DdX3H/F/YRXV0gQG7i2uZ1PsrwHV6IRHWJ1xxRtI48us8kK0ZiPxyj6Eg1vGWRDLaqaznx++C//
	9f9uYw+6STBZf38apc/5s1IR3X8sDsGfedujd0A1PhjoKj4DWfexA8lI59hkFb/990lMypw8D9e
	CMvjPxXOhM=
X-Gm-Gg: AR+sD12NrA8wIslVKoSW6AcLsEXuH1xXTzDFFELgfs8OnYYafrLlpZqCMyc+jMijhCv
	nBsuAWArFsBng6F9IE/QAmulDi+FpDBNW3d/BJBbxlJJkON7lmv5OaLxlYCtduIHBmTQBTWM/GW
	O/WTV9zz9H3K12fjbohGXAqJTI8wGVBtIH5gqQ97WwIUYdrblHEnCDMJZosUYUWKSDJLbYzHhs+
	HhvPL/mTnKmJ1IcjosLmLWvZ66ZcNETHIPiNQ1bIVNJ57bSENFdNzOY2RPb7Q8UCLq/Q2p/ogIe
	eajVLUps1jxrcAcqOVfjssHCu4M4QvlpeAb9xch0p764FUREH78tQzBSP65Fs7lvZzXGDspzxQ+
	Fbf7XNMkoPO8BoT1h/v8F1VS/nwPk1O5WCLTFCTG368FKqOLq9zQpIibrSURiTrYbN0zsEXr01P
	ioIthsS5MedJ85BrzeVS8lsHGE7lLxGkYy9ko=
X-Received: by 2002:a05:6a00:4b0d:b0:847:8acd:747c with SMTP id d2e1a72fcca58-84ee4813a5cmr741188b3a.13.1785525041749;
        Fri, 31 Jul 2026 12:10:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbe39eb86d4sm158341a12.10.2026.07.31.12.10.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 12:10:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so1043752a12.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785525039; x=1786129839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+ajiPN0JgPvfhIM8VYosd8xR3L1OxN0W6yK8gD07J4=;
        b=CilYmALFZ/23daW3kGqM70YK0PtaRbHsWoS33+1dOL5JrFv+ltSpz/MYwxESQM8CKr
         Jrlt9uDyCdI5bgzSh2JQAyhjQ7unMzfxjUirJQVRzwnHeztMqynin1fOtxexXK9AJzhk
         isNqnBLKXYPiPL2+/W1OuRGeLOMjFz8zfBF28=
X-Received: by 2002:a05:6a20:a11d:b0:3c0:9c19:659b with SMTP id adf61e73a8af0-3c92a94da37mr817503637.67.1785525039072;
        Fri, 31 Jul 2026 12:10:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11d:b0:3c0:9c19:659b with SMTP id adf61e73a8af0-3c92a94da37mr817452637.67.1785525038508;
        Fri, 31 Jul 2026 12:10:38 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8667714eec.10.2026.07.31.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:10:36 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 4/5] bnxt_en: Disable EOP for TPA on all chips to prevent data corruption
Date: Fri, 31 Jul 2026 12:09:36 -0700
Message-ID: <20260731190937.807270-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731190937.807270-1-michael.chan@broadcom.com>
References: <20260731190937.807270-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

EOP (End of frame padding) on the AGG ring may cause overlapping of
zero padding at the end of one segment with the next segment's data.
If Relaxed Ordering (RO) is enabled, the zero padding may overwrite
valid data in the next segment and corrupt the data.  Older chips
(P5 and older) do not automatically disable RO when EOP is enabled.
On some ARM systems, data corruption was reported on 57508 (P5)
chips with RO enabled.

Always disable EOP on all chips on the AGG rings when TPA is enabled
to fix the data corruption.

Fixes: bfcd8d791ec1 ("bnxt_en: Add fast path logic for TPA on 57500 chips.")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 97cae19643c3..a0ea8c994b32 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4611,11 +4611,14 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 		type = ((u32)rxr->rx_page_size << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD;
 
-		/* On P7, setting EOP will cause the chip to disable
-		 * Relaxed Ordering (RO) for TPA data.  Disable EOP for
-		 * potentially higher performance with RO.
+		/* Disable EOP if TPA is enabled to prevent overlapping zero
+		 * padding with the next segment's data.  On P7_PLUS, EOP will
+		 * automatically disable Relaxed Ordering (RO) to prevent
+		 * potential data corruption (and may degrade performance).  On
+		 * older chips, RO will not be automatically disabled and may
+		 * cause corruption.
 		 */
-		if (BNXT_CHIP_P5_AND_MINUS(bp) || !(bp->flags & BNXT_FLAG_TPA))
+		if (!(bp->flags & BNXT_FLAG_TPA))
 			type |= RX_BD_FLAGS_AGG_EOP;
 
 		bnxt_init_rxbd_pages(ring, type);
-- 
2.51.0

