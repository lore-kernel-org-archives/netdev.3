Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C23537E8
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783824; cv=none; b=tw7A81TtORbytEaKK6QA7vzfpBkNGuhTgeRi2wELR/5tdfsDxIvengjqlgBaj+3IBAHNuMrGWp1UBqnFgrwWk7ItkGzj4JjVRYt7pV5OAFarywpbTmhAfH0OVqTqmt9AiQJ+nGUywRThqhQh+C2foWT+aUByrQ17jJY5TyBtxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783824; c=relaxed/simple;
	bh=CEzhNpLUvOnUj0MajJKzF5fkj2haxm67cObJvM40yHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGAUI96r+epQN4iC+z3VPTsv5QFN+Se01oUQ7H1tJ07x0mq80heEJQK92qrPpOdPlHx8RqtZZ942vFtsTLggBYCmkjdsWtb2GNevcqHpf+BzH+rkkRftXbLmJt0am5NalNmJSw563BAmcMtB7Uzn6Yy8mASbxI9OTsNSxzeV4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E61ci9zG; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E61ci9zG"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so543253a91.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 22:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791783822; x=1792388622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZzB0sfX1Eu2dpHCP/O13BODS55l2cg9tFlwbA80ij2Q=;
        b=sOI6ylfjPNTOb7xzSyXN65pRFUWGKkYFDQ23t87NZav2kmwN5gB3MeSFOHYzyjfpCS
         dFFmd6+bi3bJfvYqL0lNqMhkupP7ymIjJxtqWGc3rouDpSjNvJTqSV0wMCHSPCA673qz
         mj7ajHbzu+ydvqDGdRpuZpwmB/56iocOMS5HeYMNL6vDWiJVLEWKY7sRKWR/gmTDbFc7
         gC6krM7s3bxWPGDtvhjia/ET8UVkLCdaWeAXRavfC/SdoCp6b0Ae7d6r+VjA4QT7fqgT
         im8n/lGKkF5B6xNXetxX8wJnDrErsjdRPdwkZyT6RuHdY47ELdMz3vE9gggZ7J1ra7i9
         vt6w==
X-Gm-Message-State: AFq9FYJ8FlqTAwo5ggVdNJHN11B3HNEJ5Z73fq5VV1OaUgELIYnZLAcI
	oosX2JkwlKHKbKKzAFnQyrpDG7MdovOvNQaNKRZBnGWCTw3Ub18AmHAn1EyW0CZXi96pTW9LfSA
	h21v+r3NbOVEst+nqgcklMnyuhSxChWqMGZr7W06JAwEnVn30Q1PjtLSWQZIEEzXmsL/DKSKGcy
	57qVTxLLRt8Lxlw32fDpBWHmfm5pbfc+sMV+H51oYBHZ+B7FUciln8KrAPMHL8UVY1fuIJdOoUB
	YHrK4voUQ==
X-Gm-Gg: AYBFou3Pfm6Cn30cJNSqcSumNTwVx9Jo8uVBAf+YHXnYs9UZo+MEDY93262/5Yc5Lc7
	RXS9H2OTr0IpdVozk70X0bGivtx5HJYZKUynnYjkc0C8t4Y/l8jkI8A4AOAX70BK6WyQgTybznT
	YcKcxDfOlqvCN930Fph0/v52G4Xx7CHTsQrYlmXXPm4lKdWH3D6FID3mSn02+dmYbW7LF4Sinle
	ol07/WoqQcQNz74FQl9xBS7KMGPmEGIJ0sFD7UcRdtRiSUQE9jHHApSDeoIhLSbQAWk1K95yflN
	26cf1C0iJIkfXZIIoubnesnEGpBAISo2tnzjwH1nm4jDkKWmaelmDYgrjfshMXzD+wtFaN7HYgE
	CUxYc8pVSDAJk1mgqr5L9hySOCk7cAVJ3myT+j+6v5pz2Y+mhoqw1eOc+Kl/9YI/cnQbGYIR596
	K7TSp2XiMgwCh5BaalJ7TgIMcPLKcoAODa9j0C
X-Received: by 2002:a17:90b:4b92:b0:3a0:7d97:37c1 with SMTP id 98e67ed59e1d1-3ab3ac9fb13mr6676993a91.59.1791783822297;
        Sun, 11 Oct 2026 22:43:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab37a4d1dasm5370002a91.6.2026.10.11.22.43.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2026 22:43:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a4aa263a4aso1117603a91.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791783821; x=1792388621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZzB0sfX1Eu2dpHCP/O13BODS55l2cg9tFlwbA80ij2Q=;
        b=E61ci9zGrKQCft9w70vj6BHXSLyPtv4gUBbaljPBjL83zn0cXrudvut3cSWJU5byVn
         2AscCLbRy0+g0tKujbuapbhumC93Q32BzIO6ODCIcvDa0nzbZ/DckQ/FI5U6na8Xb+Sg
         YbW1owi5bY4LLnfrnZhytWydashroLcYtGZb8=
X-Received: by 2002:a17:90b:5444:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3ab3ab22794mr6797743a91.41.1791783820748;
        Sun, 11 Oct 2026 22:43:40 -0700 (PDT)
X-Received: by 2002:a17:90b:5444:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3ab3ab22794mr6797719a91.41.1791783819785;
        Sun, 11 Oct 2026 22:43:39 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f8277bsm14615587a91.11.2026.10.11.22.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 22:43:39 -0700 (PDT)
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
Subject: [PATCH net 1/2] bnge: fix RSS table sizing for large RX ring counts
Date: Mon, 12 Oct 2026 11:13:24 +0530
Message-ID: <20261012054325.1782819-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
References: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Dharmender Garg <dharmender.garg@broadcom.com>

bnge_adjust_pow_two() adds one block before rounding up to a power of
two only when the quotient is 0 or 1. A larger quotient that is already
a power of two is returned unchanged, so 129-192 RX rings get a
128-entry RSS indirection table and 257-320 rings a 256-entry one. The
rings above the table size never receive default RSS traffic.
bnxt_calc_nr_ring_pages() always adds one, which is correct.

Always add one block before rounding up. The same helper sizes the ring
pages; their count only changes when the number of entries divided by
the entries per page is a power of two of 2 or more, which does not
happen with the default ring sizes.

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

