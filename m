Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006902;
	b=4x4UuJTw0h5f1p1RFYSOFNX3ZbZ/aHeLtX44KXVlAv1RoVGiK+7FFIfqYcWvJNMPvpbJ
	 saiPvyCiOr73TuK0HNV9qoFgk8IuXX/dMyA2VCCBv2neaPLRT1eFrABrKFQVMRT4CYqhH
	 YYR3rdhwb22k1KfEu+BweCaGh7gOD9ay1GfrgR2q+sI8V547Zu5Lj0EOCWE6M/jVJ4hTg
	 0/127qAh+WtmFTRMl9o3/q2LYDPe6Uwr0WgyJJZJlYXbYUZcooN/hxJ8gJPMS2gg+EVHA
	 1AmoIj7L4zxAzvaSvM8QhjzosFad0v5IT+F9IhaP+1FlubMHRaRON+7DsC6YBn7qthw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006902;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=1E2k1lqYpcgLA/U9AfcKbavuiY4YjaqtzjrZYfyvQVw=;
	b=HwhibMA/ppPJwIovTyKTkyUsRwg3e5hvsssr8CMjygeNUIntelQqDGZnOLLAebZp0mt6
	 7Hrx0LlDYqb/3QIO2kaZocp8lbLoCNSXxW8L+yEOc5vEG+0fjbhN8Tw7blC+mZ00HY7vL
	 KF6BtGC+PLrOUsOzAclYBBoSMXWaEW/LlJ71ZfJKJq5JCVXY0MAsmgvdG8QPiu2ciRiFf
	 eDDffZB+Mp26qDzc+REPEiZ0LnO5fSIZqzJHU8357hBjkKOMuL/rV7bxH7wxR8+xSTACj
	 nXon78nGJnlUhSQ4I4Zi8cSJUI5EbuNchyTmy9XcjsYM9Jfn7VoXuy8pFxhvCrKQvDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Oltz6a57;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF5606A339
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24AF5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Oltz6a57
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1485852a91.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006901; x=1793611701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1E2k1lqYpcgLA/U9AfcKbavuiY4YjaqtzjrZYfyvQVw=;
        b=c6BDalo3S0INtrDcGHW8a6ZrlqZfsSybLgtpbFmIomqEgij9AJ+BxFcCGm9oCaiwF0
         UuHvsLIwnUg/EJPWPh4iHrlw2JMkI5EaQrKNWmfb43HvWC5Y4efpfLhp8DDRRYkKycKo
         xKhXFSzDxUGgCeOMovVTaazfYSjlTxR4qesISD8Azfb4c4Cyq3Y2tdWJtDgm/NyZRHBO
         nJLclviUF+qE9Qncv2CvmA4kU/6QjCQ7QJD4w94D2HcI8cd6qP4fFcYPOtjAndUumqxI
         /DqMAnddAf3EO5b5wG1392cZ75KZ46YUXPX0kktja3JL6qY684dQhL9/TzpPjWlKoMQs
         dmWA==
X-Gm-Message-State: AFq9FYLDTZjXc/Nuyqk25SwkkMJWijsIfzE1jeLHPgMN9z5ZyUd+8qDW
	UfqThu0uaanORULouftHOBFyOlra+xnsWA5nxtI5yey6ezXr1UFysowfjf/ZEMW1GfMUwkKh4eb
	MZBW5Hiez1U3oMRLJbYm1IHyUZVpXRA6FIyocNBMgHV1oYUK7qZThksusTkbZN8SkQVDU9ZFQNP
	d2SklAfpntGqEHze58UXRKDhbVFNEMvrFw5Eyknw52iYufDVeJl7FESnARsD/l7/Zec+/LGj5BM
	NQjOvdHdw==
X-Gm-Gg: AYBFou1mDXrouP/5K2kljfRKm59YlgEIzHLO+wYONJTtqcPMO5cidXYLU7Ad/MZdxQD
	sC975PS0LCEYp3svXgU8WRIA6llg/rs9ReeOVBkZoRoQqTJios9GwTOJAAVSh7P3Wjk0Yvj7VC4
	uAOELBscDxvYNPD3btoI74RH9Ir3ugQCDsCzfWfATMN6dfXhfnlSYHNphZYTb/ydn9n4tNhQHnc
	7CYmtopYgBxPNJvp1ukQGLyDN0kMBwcWJMsmUF891L1OTXaQP/LE1e/4AySSDtbUxnlBhOzFGwV
	bMTmxvhibubPYxyMDaqyE7Z6b3rmggqc1Vrq+hUYG2ncoXwm570LKwRLOGD20rPJr16SNZzBHBD
	mduJ4+dda0KIJ79K3zgR7UzGXU9u9LEjW5SwWA03z/hy8E3QS3wtRfScxSi5BN9dGsVkUPNTEJx
	MnuzvpX/q6e47Do19FQ2B7kbTfsdu5+DsnMQ==
X-Received: by 2002:a17:90a:ea94:b0:3ad:fb12:9bf5 with SMTP id 98e67ed59e1d1-3adfb12a171mr2932631a91.62.1793006901500;
        Mon, 26 Oct 2026 02:28:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adeba1bd56sm6048547a91.2.2026.10.26.02.28.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:28:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3692c5b061bso10723980eec.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793006900; x=1793611700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1E2k1lqYpcgLA/U9AfcKbavuiY4YjaqtzjrZYfyvQVw=;
        b=Oltz6a57dm7Kxb/KgU07Wa+mM1qJ1PfTE8cvY9N/IHMfRVn5TLWaIGXuNnhdUPwu2Y
         YLvDKo68fkwR+tJ9WbLMqFjlHipCpxv0gmlJQiunu7DLBLBApFG7as7jf82Pxau6X0QQ
         09cDqV2ANy20UdKveCxJOk7d/XsGHynVPRgxA=
X-Received: by 2002:a05:693c:400c:b0:360:5f7e:2eb9 with SMTP id 5a478bee46e88-369e850d1e3mr9667055eec.32.1793006899697;
        Mon, 26 Oct 2026 02:28:19 -0700 (PDT)
X-Received: by 2002:a05:693c:400c:b0:360:5f7e:2eb9 with SMTP id 5a478bee46e88-369e850d1e3mr9667003eec.32.1793006898747;
        Mon, 26 Oct 2026 02:28:18 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm16711294eec.7.2026.10.26.02.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:28:18 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net v3 2/2] bnge: fix RSS table sizing for large RX ring counts
Date: Mon, 26 Oct 2026 14:57:57 +0530
Message-ID: <20261026092757.9168-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261026092757.9168-1-vikas.gupta@broadcom.com>
References: <20261026092757.9168-1-vikas.gupta@broadcom.com>
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

From: Dharmender Garg <dharmender.garg@broadcom.com>

bnge_adjust_pow_two() adds one block before rounding up to a power of
two only when the quotient is 0 or 1. A larger quotient that is
already a power of two is returned unchanged, so 129-192 RX rings
get a 128-entry RSS indirection table and 257-320 rings a 256-entry
one. The rings above the table size never receive default RSS traffic.
bnxt_calc_nr_ring_pages() always adds one, which is correct.

Make bnge_adjust_pow_two() always add one block before rounding up.

bnge_adjust_pow_two() also sizes the RX, RX aggregation, TX and
completion ring pages. For the default 511-entry rings their page
counts do not change. The completion ring is sized from more than
the default depth, so its page count changes where the old code
dropped a partial page. With 8K ring pages, TPA off and the default
rings, its budget is 1533 entries and the page count goes from 2 to 4.
With 4K ring pages and TPA on, when the firmware reports a
max_aggs_supported of 260 to 387, it goes from 16 to 32.
In these cases the old completion ring held fewer entries than
its budget.

Fixes: 627c67f038d2 ("bng_en: Add resource management support")
Signed-off-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index b62a634669f6..c0b6992d7f82 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -81,13 +81,10 @@ bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
 {
 	u32 blks = total_ent / ent_per_blk;
 
-	if (blks == 0 || blks == 1)
-		return ++blks;
+	if (!blks)
+		return 1;
 
-	if (!is_power_of_2(blks))
-		blks = roundup_pow_of_two(blks);
-
-	return blks;
+	return roundup_pow_of_two(blks + 1);
 }
 
 #define BNGE_MAX_ROCE_MSIX		64
-- 
2.52.0

