Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0873AA9F8
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144275; cv=none; b=Zav8RArG4iZTSoA3PW//H/8HslvUNCYvEWtFuJZDZ1g/XM+OZwrvEd1405wdtJbU4w/Yj40ll+rld4/Px+m3YIph7POf1ARXxT0bi3kObgd+zeYi8ycN83mUMpSXLiWuduXtofLgmgWD8mjxyMTL5j5VKw4+epocGrRmCCoYpVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144275; c=relaxed/simple;
	bh=lfY2RhQhaWqIhWYP0obgVIU6X8GKvQsFT99WA3GgH70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tHImYMR29NbQ/GULY4KJVqMEW+dyi9tYDPB5sJWAvRT6A1iqcQ4P28jkwZYDfNykTXm0TBp92mndVZo4Q3SHoD8QOaSn8CvWegXVFWVX7ZDSB1nYxLgq3RBwLlGHKMSCLsy/wPJeVkB8qlai3Ez39ZIJ3EH0vBw39ELy90Wefbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AsTP/wrJ; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AsTP/wrJ"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso4230255a91.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788144270; x=1788749070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm6M/4E4nJ/db2ojJE+QdcoipKTWh+OSMKYakPMCVYc=;
        b=EN9rSVJhH5A+3SBw+ogqtBTF5fgRNdKAKgR27B5mkzACNaK1wWr/2QRva+89fHjuc3
         iPhr/IfC+ZblSHRZelJmfgyI2rsbi5EhgEMzeZLLW/CcVuB3lNhprquNKTiTCFbftbvo
         AluJGe3OP1ML8WV3Z1jhJGy+SeqycZa93oEE6VXq3Hcd9SJs716uycLKWlEnSro/QTjv
         YaSsL5K4sl4UxbLimf/erOO63bUKAedYKW33LM4TtDBw6Is10VXcuEUbvplQnsaGYfhL
         W8nDgdx9ffaGeCJU+h5gM2hWJ2Od/KI5xtYYh69UFgDos/XpCUgD5Mcsv2n6VUjBBLDY
         lG2w==
X-Gm-Message-State: AFuF++m/jg7z/C0vLNzBsjA5E7z/4dgd3h9QHKMMJ1sqw6eZjLJ5//og
	thr+0Onr8hR78ErRsjLaNqm9t3f1gp+PWtVUxttKqMupoT42b6/lSz712rzpmxmjFh4p7Z6Yy7u
	zsg2beXAIn9InWMHjFi9EIBi9azh7xyxgevT/ibnx3UF6J9cO20K3IWqwvDifyygqEpHD61cD7q
	eDqJxiGtxMm7gwPv/0rpBPvyZ6xZvjSmvIiU0jlFPeHoQ9zrzQ97DqMJ93dkQFFMFOjG38bE/w+
	di9H21baKM=
X-Gm-Gg: AYBFou2xoQ1NThmNF/h4I+3iqDzDIUfxzCexUd5mwhoM8uKPBxtM73MLl/I7PF/3bl4
	apW80HJarqe6uaDMQtzLWCobjPMF14cNasO8t5vosc1NbHcYrQB1pbLysV9ys1FbAhiGQrkJ5o4
	K7x3Hd7N73wycYT0Tkw4cJM+tJ5y7DWSdkSqTi8IRN5/G93sBwHs3W+gLbUVzIWL6vh0QRs49v3
	5Yosk1LkgmnqL//myaicLFmx1yelExQhBzfK1VyneF5eSsY/UCi5fXph1g/IiJ6czExRG7K0cFy
	o7LdKRBWfPFh/sGjGjHx17TjWb94jckEwZyeaF8tfzw5tFrO1cAf9K80cwduzKQ38HrSgR93k7s
	rZq3HQ5ELql+jNLgHiLTPjum7GV7jC88qq/xCL5WKsWteLyK3RUA/y1YYk1NV2skBY1URUfJOS2
	ipjeUx9ncPoKliqOsBrSv6grU9dUEs4mRb+FI=
X-Received: by 2002:a17:90a:dfc8:b0:398:e1f4:bda1 with SMTP id 98e67ed59e1d1-398e1f4be7dmr5969708a91.21.1788144269696;
        Sun, 30 Aug 2026 19:44:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-396ddcbd559sm3941515a91.11.2026.08.30.19.44.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2026 19:44:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso7242236a12.3
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 19:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788144268; x=1788749068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gm6M/4E4nJ/db2ojJE+QdcoipKTWh+OSMKYakPMCVYc=;
        b=AsTP/wrJv80FQpVbnDqGQxjrwzqkokBW3Nllgq4fGDrbT0MRtR+3rGJFJEKtxX9jd8
         gI68xw52Hxgq9mMO8HwBCwklIQLMbOZTXItYirkyPE9ZDO8A6kARITKzXdUw0yGrUbA5
         MRm9Yu51Ap6rTqnk/RcdavcP4PRJhqsSyQVuI=
X-Received: by 2002:a05:6a21:339c:b0:3c3:64cb:9b99 with SMTP id adf61e73a8af0-3d265a3df5amr32767364637.6.1788144267978;
        Sun, 30 Aug 2026 19:44:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:339c:b0:3c3:64cb:9b99 with SMTP id adf61e73a8af0-3d265a3df5amr32767323637.6.1788144267526;
        Sun, 30 Aug 2026 19:44:27 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm26421728eec.27.2026.08.30.19.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:44:26 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/4] bnxt_en: Bug fixes
Date: Sun, 30 Aug 2026 19:43:38 -0700
Message-ID: <20260831024342.2161156-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patchset includes 4 fixes.  The first one fixes the ring
accounting logic when FW is unable to reserve all the rings
requested by the driver.  The 2nd one is a refactoring patch to
add a bnxt_clear_bars() helper needed by the 3rd and 4th patch.
The 3rd patch fixes a possible error during driver init. in the
kdump kernel by rewriting the BARs after FLR.  The 4th patch is a
similar fix in the PCIe AER code path for non-fatal errors.

Michael Chan (3):
  bnxt_en: Fix ring accounting underflow when rings are constrained
  bnxt_en: Add bnxt_clear_bars() helper
  bnxt_en: Fix driver init in kdump kernel

Pavan Chebbi (1):
  bnxt_en: Re-write the BARs following any type of PCIe errors

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 70 +++++++++++++----------
 1 file changed, 39 insertions(+), 31 deletions(-)

-- 
2.51.0

