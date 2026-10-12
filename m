Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91604E9C1D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842951; cv=none; b=cgcwYloixMJvaUDLeT30xybcF8VdXMRxvG42PRHCpKMJze5nRoOKV9cAlPPBKgHu6gYCV33si1HQxakMy76UKjDdDuDpjFOkQlG4WKAzKFWDtCd87zTBU5el0LvPg1C+RhE3B7UlbA7J0+hhJX1b/jVOGUGCcCzIOWvnebZdBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842951; c=relaxed/simple;
	bh=Zg9ccL9N8Ew7QvdORqz/ocEYZ7U+xDtK1MUO9c1oj3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8bEbUEvWZuz7kmMCl/4Vp8FBLXgyRs88RbrGoIEq/l/z86Euk7uCqiN5XLJpAbPV0rIWaCkKs/jhZo/e1s9X+phwjpPNIybunok0KzwbXrb7loI9/iCGC1V7oYP/5Nx2oHOcq4wcJ7OH7uUexhhYP+2ZqpSKh1Hq8umO5PWpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ONhsUpgX; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ONhsUpgX"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-91b83459526so14089226d6.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842949; x=1792447749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1I6drmsfAm6UrHV44UauGF5uDNzhgY40eYoFvt/W+k=;
        b=Mzk+nPJaSp3Bopn9HJfQlEhp3kDa2heSvmB++8OsqN0yTZzbzxdhnznUyvU9X0WcTb
         DLLAPy39G7hqi+kdfMJ5I3tUTDJ7HqZBNYgfK99urCOqCc9fsLWgfSvdvILBhbEMzH2Z
         f28yRgX4xcRio3kreQq2hpaY7J3bLHNx9uAhqNJXhQMP49XECknsDDduFkWyArqsys65
         xxKNNvk42fsk5c3y9WPPnY8FW5yxV3+LsVnfbIktypEARZD40phUfKrl8I1s+mEDmns8
         I+vvcxFUbFnsJeIFh56u9961RctJPUgUIcfv2vv4B9crmJPll6qNPcIGFz3aciCVYhOH
         YvDg==
X-Gm-Message-State: AFq9FYKu1uRiFsIKJOOlGSPw4K7uCM1J4DXmvAAhCrK+jGhRhcFEXmmf
	58yhDs3SvuhrPv7nHH9Bwlm/tkuaOxhcbuaXA7bPJZXpjQAC0WZyRsQgln9pq+KAUpXqtDXxBzW
	Gi0LDS95j4v6wPYYHWx9KQA23jluIFIOpRTpOnMxPFTyWjbsv7eBnZUHGDC99Az6DZ65ciXsqa8
	ODmywGS7lXJ2ACYP1cuaQtRUd6Twcf1WUQqpYZ9sb7jtS9eTzscPXp6vGRzS0tX7uSStWghpu4/
	W98hQC9/R8=
X-Gm-Gg: AYBFou3j3frq/7PIAfvUi1M8gtVCqoMsKfWOD9XgBfuKMsKe6F2rrzD7FM5lqsfsUGY
	m01TiZr9larQsiqZzDm0nSsomU9TzoEWk5B8q4XIql0HN5QjkrAkwdzmzLhB/dwzqiwQRKaOCf+
	ykoF/iRcGFHAfU/vb9EjOrQEW5quoROh+o8xEjfKa8mLVLUGxy+HEPotyz459bqaDt4LaerO3tG
	ebYTXR0DmYwldh+zLeTsPqWOhEhUXwbM5QGcZPCirAm7teP3Fv52LYJin0z0DUjnOo5mO1weWih
	/gcHqF5RZr+irjIwvMfyk/xPDJ8PuDpRdRG6eIJB4XlmDXysbGL0wnIjzCS1fbnouwlcOnF+KDh
	edp51sXjmfkdioTo9HfLBe/AhTpGlNkaPL7/5ZorMiiO8e4najFrHexfphqkl3T1xYGX74kV0bY
	HVLlJXRxC8DpjB2YFZmRCrCbbpKKJyyFKRFXHhFg==
X-Received: by 2002:a05:620a:650a:b0:93e:4bbf:cc32 with SMTP id af79cd13be357-93ebd2607f3mr1738286185a.35.1791842948790;
        Mon, 12 Oct 2026 15:09:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93ef503b538sm20503185a.8.2026.10.12.15.09.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 15:09:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-151ba226e1bso2000341c88.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791842947; x=1792447747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1I6drmsfAm6UrHV44UauGF5uDNzhgY40eYoFvt/W+k=;
        b=ONhsUpgXZK37mhMrfKpvcS7xIimB+n3xYHmI3AuhRqh5wi026NafZ1BtLM/s9VIawO
         d03qMF8rD3fGBHuYmrmb9/cstDnsGXG0Po3JVpLGmMslbLiQlTW5/f5coPaNWPuZZ+gg
         GBYIkoBPqCazMQlAwMRXoB9WmbcCCM6BAN8lU=
X-Received: by 2002:a05:7022:3b87:b0:143:8274:1697 with SMTP id a92af1059eb24-16a603450f4mr19221454c88.29.1791842947534;
        Mon, 12 Oct 2026 15:09:07 -0700 (PDT)
X-Received: by 2002:a05:7022:3b87:b0:143:8274:1697 with SMTP id a92af1059eb24-16a603450f4mr19221412c88.29.1791842946801;
        Mon, 12 Oct 2026 15:09:06 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm12483206c88.13.2026.10.12.15.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:09:05 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 2/7] bnxt_en: Fix bnxt_reinit_features() when irq_re_init is true
Date: Mon, 12 Oct 2026 15:08:22 -0700
Message-ID: <20261012220827.340998-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261012220827.340998-1-michael.chan@broadcom.com>
References: <20261012220827.340998-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

bnxt_set_features() takes a snapshot of bp->flags, closes the device,
and then blindly restores the entire bp->flags.  bp->flags contains
statistics flags that may be cleared and the memory freed when
irq_re_init is true.  Do not restore these statistics flags until
bnxt_open_nic() reallocates the memory.  bnxt_open_nic() can
potentially fail to allocate the stats memory and the restored flags
can potentially cause NULL dereference of the stats memory.

Fixes: 93e90104bd12 ("bnxt_en: Create and setup the additional VNIC for adding ntuple filters")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2bd2c039ce43..d23b40b0cb92 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14090,7 +14090,8 @@ static int bnxt_reinit_features(struct bnxt *bp, bool irq_re_init,
 				bool link_re_init, u32 flags, bool update_tpa)
 {
 	bnxt_close_nic(bp, irq_re_init, link_re_init);
-	bp->flags = flags;
+	bp->flags = (bp->flags & ~BNXT_FLAG_ALL_CONFIG_FEATS) |
+		    (flags & BNXT_FLAG_ALL_CONFIG_FEATS);
 	if (update_tpa)
 		bnxt_set_ring_params(bp);
 	return bnxt_open_nic(bp, irq_re_init, link_re_init);
-- 
2.51.0

