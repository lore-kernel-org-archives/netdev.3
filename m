Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538AA3E0230
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139394; cv=none; b=r64Q7/Tl39HBzpdiweMmSjgHWX3HWwuD+zaV7f/ZeRUwppwNPzJvStpF9G6Sa03T2KABR0C/vGQqr3IB+I92IeMfZzyvvNeGKD5vE2j7brws5chrJKVBeMmhBtLEmM+L8lVwe5cXoCByjtE9xJqCcZO2paA6Ndu/pMAQ3fMi14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139394; c=relaxed/simple;
	bh=ieSAsQ0y548BNMnJ472yGH+KhvpzsF/yp3+FUAQfOp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOWRKyKhy2n7PrgNwSmGE/MMUL2bDNEqkZhLq7QmXrlY0ASmTDdKl3NWRgy388X8GqSmk7LBiDvxWxp3pL/nxVCnBvXTwg7pR/qIwsJnJ9M5KmwTLjdR2XisKeRUGTmaICcvuE81xHVPlBTKgXxVyGJEdcfRm872HomUTElLFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=DtXEeVjv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="DtXEeVjv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf27856f9cso30177035ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785139389; x=1785744189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Tm2X0pi/lU+RwWD3OympRfnFsE8L6GJ39TGJpdkpUg=;
        b=DtXEeVjv4SHLVVsAQtkEtR1Nd6ItsU6ZQdx+e7Oa7peABJTCTyZHl60m9CC/JyWt2k
         cxmuPrAuD2Pj2mfz8TteokK6Fjcr9IK7lC5AoJcDnnSuF86X5prPmcOdyUVAwfdIBVnv
         5rEr5nYB2t9yURYKI708kzXAtzPzCVAEDfLCttcemec0Z4VanCM5lWrIrj4wcQHwj81D
         x39cCQ+6XsSGp78Ecrcl79DV6C/mez3RVBHA4PKf0dyv/LoAV0kfMop4gayWmUb/KG+Z
         9hHsidMEa2C7dAuUKWfvvuUC+YUYjJI/98mkIhNu2K5Dv1trR7gBM8IyLAROJAHegTUg
         pNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785139389; x=1785744189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Tm2X0pi/lU+RwWD3OympRfnFsE8L6GJ39TGJpdkpUg=;
        b=HB813tZLdjj/oSkM5C1y5KNB5MNss4jfoWVNETXjk4QJ4phFD0AM9oX0Ig6rDvyJmQ
         H78pGyzaUS2jGRm01gJoSKDjRs9htCS1ZjQ2j6GCQRZG4u0WffIwZQXYCpGjabKa5yjq
         eLTU3EwQ1XBa5vVCHvDybGHgJYQGBF+WGFKj4kd5+rMuRUvMYiLrZOCfJ97iR+yrDEfl
         8kSDDL17ordJ5Mn7ka0nGjtIuSzF62trs+IjYUADNVWQUuFVJuXAjL6hqWYgSIMJGFED
         nS4bUXJBLA90KzkmkRekZQLskvD3KEnazx0WE6n3tP9u5h0J/sFBcRZ/irp/eQq86jtL
         RcjA==
X-Forwarded-Encrypted: i=1; AHgh+RqYXOAd+Lj7NtlzM3Oc+LxRlbMNgP8HQevKAGnqIDf6uEc4W6JLkLIahSqKCnN48G6582ILAfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjyknd1KSyixKVct0hJZb4MniWfvlCmvZfiT55ya1T3IneiXy
	vYbp3Z40kmwnssju1mA0fw3A1PvdAx0hOg+PI/s/MwVdp05BkRUPHLPgAGtBjdo0Q94=
X-Gm-Gg: AR+sD13en8XiLdEB5VoDytLp5fF1oUsj8+DjpGVQZ58s3wcVMK2ZtrSDCwOukIVaCqR
	kSYKq5GJAA5TkRKq1FaKpJ8Fdq5z2wHnIOLOHN6YEAs1bUVjZwpNt2UPWuLOIqXmn3Mq8MLlLwl
	UigZ9Oj2irZHtawH+mzAjgrfUY7HU6GQLcXunTKKx5WTX1FWuqbABtwaSUg5G4E1ODtwZPKbl4X
	e5X5KV3SxrDJdBFh0XgLc/LMmzrRAcl2+3XVuAUApwR1GUNrWWdAsyXRKgVFi/0DtQvukCCqS32
	X8UKEl4ksw38ZG4gx9PScwOPSvuWQLUrJ7JOAw6W4sUX9MwSc7scYvo3ruQZyZkal5qFEt6d1AG
	AA/aic9/fkrQBgWUwBNDIyyhYMgQJF1Fw/U5VTvG9Y+anvPaOt1kbO3VzSqC4kc4PTC0/hAIwqo
	vmghC7RGJtJslCKiqhNe9Z3P2HgUduGwE9W6iUUUE03k39UoYy4kUJ1PfT93dqd7b2VZJefz2Md
	oRg/0kxWJquSBEdIPEboCL/W8roFtBW
X-Received: by 2002:a17:903:1846:b0:2cf:b6b5:9cce with SMTP id d9443c01a7336-2cfde89378amr69538425ad.46.1785139389264;
        Mon, 27 Jul 2026 01:03:09 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cfde59bb13sm31072945ad.1.2026.07.27.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:03:08 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: andrew+netdev@lunn.ch
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] liquidio: Fix possible memory leak in lio_reset_queues()
Date: Mon, 27 Jul 2026 13:32:56 +0530
Message-ID: <20260727080258.86279-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated in lio_setup_glists() and setup_rx_oom_poll_fn() is
not freed in some of the error paths in lio_reset_queues().
Fix that by adding the corresponding free functions to the error paths.

Fixes: 4b6e326b2d34 ("liquidio: Per queue oom work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index c849e2c871a9..222ef0b661da 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -1242,15 +1242,20 @@ static int lio_reset_queues(struct net_device *netdev, uint32_t num_qs)
 
 		if (setup_rx_oom_poll_fn(netdev)) {
 			dev_err(&oct->pci_dev->dev, "lio_setup_rx_oom_poll_fn failed\n");
+			lio_delete_glists(lio);
 			return 1;
 		}
 
 		/* Send firmware the information about new number of queues
 		 * if the interface is a VF or a PF that is SRIOV enabled.
 		 */
-		if (oct->sriov_info.sriov_enabled || OCTEON_CN23XX_VF(oct))
-			if (lio_send_queue_count_update(netdev, num_qs))
+		if (oct->sriov_info.sriov_enabled || OCTEON_CN23XX_VF(oct)) {
+			if (lio_send_queue_count_update(netdev, num_qs)) {
+				cleanup_rx_oom_poll_fn(netdev);
+				lio_delete_glists(lio);
 				return -1;
+			}
+		}
 	}
 
 	return 0;
-- 
2.43.0

