Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD254707E
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133112; cv=none; b=r6IlplrfT7e8EeXtingQ43ChUdYUoTgD2PLt2a9qwJqp1CFRxBDAi76gbscC/PAKAS6/TMkFHtbmthEJ4aUS7mkB1s5mlB/RZIU8ZDKsUk1NainN8+TXVbnDNjO110zCpSNN54jTivRxuds1ApcD5uE7sud7ryR00lr48bcPx2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133112; c=relaxed/simple;
	bh=aXuvwEEsYQjHeNpSy7eyCVgvOchZWSrNm3gkycIxe3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLvvhaoP8kjUVMDLlyCYR5HJbW5tNf4nEklC+KQBXP5w5LsPTejUPDyC3QkVGDw8bgSOWYKuolL+Hr2sm1gMOOGGc0Q1i3g1uWKAGcqV8t9W7FZFB+9IYnOe++JIfFndBj6p7DD9SBo/LprwqaWOCnULDN/Kdd8xsF5Ux6IPZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dwieb+uS; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dwieb+uS"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso2633118a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133110; x=1792737910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uwtCJXK4mDF1bqmjQDtWE4HfJpklOj0nTFnbDSYtK0U=;
        b=cNhn+PHmv5oDIDryDUXtkuCn/NcBQfhufQ5GCq4rySxFTTHbnnkWaDEMktirB8lHYB
         tsQunBTAPaE/q1u3ohZCG0HzCddHfokUbszxRPCle+afUnO0R9YDeksDyPoo8vlEcvFI
         FwyyehyS4nPoUDqYehZjvm2Ni3YHWWthuHK9e0i2C1GC7Ej2pFxwGM743m0oJj/DASAt
         AHqlXakL2Z0kl2Ojf6tfkh5OO1r2cdbe9IqExHxIjE+u4BYweYsQvLydbOho43zGQx77
         NYUEPQhhlx31gXj6bB/P+5BBIaHJH9/J3CRSFRtJgWj1etlTWCHEq8SS6mYOtnzrTKnU
         w+OA==
X-Gm-Message-State: AFq9FYJWelb36lKBuPyXRYcVV+A7Yuu8Zmr00d7V3l/05UD5VPfMz4ex
	7VJnL5RFt6FGC53qIzyWxmy1mUH6L6MA2YE202B3WWwVtlC2B9Rc/eizwj3RqNgLH8hvah+AHZh
	NiTRA1ZInDKWJHZML6JlvNDR1Xv3/mevkvyk5WILpwEG/WqlPUBAUy6xO3M8m32QvtE0BEXBTMy
	/Yi/hndgafwnvoSczUcBArkbViY8C8hQy7Et8D4XtcXuBxNOo00zZ0q95+wnnRKgrCRjEKNDZdD
	hwl63lBNck=
X-Gm-Gg: AYBFou0YJy/ch42fX0wDfOlKiwjK4epDwRq7wispemmITQHjxrzcYd9F9jbNavtfSTx
	RVBFbt0RYRsY8+DnA3Zyoj4qKcqajTS8xqFhvyP5r4WI9OZ4pg44jvvUTQ6ZNld3gFR4slRmQYr
	NA4n5YHnS/Ba+5Rkdzl0gO3Lj955cl4JMdU/kIOq0sJf/OclqgLE+4GP0IMQwQxCnpk3ZAArW+m
	0Tz5UOgbCwlLgqoYFD0sUg06x+xHX5lVnEesPeHbwAjTuVX6ZZz8LLmdkgbx9ZAYB+rfnmMSl29
	PO6k8ZAo+/Vanv0VqxQPUHr5YV3/xLEZTkL5DxE6QYlEqNgLAHDGuLo5krHrq//MsUGveWHL4IN
	IH+UeXTMVVYVMcEowEJPNL3EsiFRJg820eR3eyPLxQ4/d9jWLmud46Swno9F/jh2ojJNlhqRdzx
	Q4ddTfdWlwJ5q+njdX8r796lRovWw4UMNb4fm34g==
X-Received: by 2002:a17:90b:134e:b0:3ac:9259:122c with SMTP id 98e67ed59e1d1-3ac9259151cmr4724632a91.40.1792133109886;
        Thu, 15 Oct 2026 23:45:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac9476901fsm2969347a91.5.2026.10.15.23.45.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:45:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so22163948c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792133107; x=1792737907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uwtCJXK4mDF1bqmjQDtWE4HfJpklOj0nTFnbDSYtK0U=;
        b=dwieb+uSxNAVbh0ltmLLnDi9uPGbMJyc8+UvPnd3FppaDYOinKweeeS/fabMPeUbWn
         evpJ3J71EB3ubwGax3bpA5rxSlo4kS1MgD4Spf1W3a2WLGmpcci8kvk/u58Yegy4kHit
         yw3+VqHSLNXoVxhGHs+hIZXXQ8BP8ybxqxB0Q=
X-Received: by 2002:a05:701b:231b:b0:141:4c37:a212 with SMTP id a92af1059eb24-16a586a3140mr30492144c88.2.1792133107075;
        Thu, 15 Oct 2026 23:45:07 -0700 (PDT)
X-Received: by 2002:a05:701b:231b:b0:141:4c37:a212 with SMTP id a92af1059eb24-16a586a3140mr30492093c88.2.1792133106296;
        Thu, 15 Oct 2026 23:45:06 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm3791401c88.0.2026.10.15.23.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:45:05 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 0/8] bnxt_en: Ring accounting fixes
Date: Thu, 15 Oct 2026 23:44:19 -0700
Message-ID: <20261016064427.496944-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The main purpose of this patchset is to fix ring accounting bugs
specifically when FW is unable to reserve all the rings requested
by the driver.  This issue was first reported by Sashiko when
reviewing the driver patches to support kTLS (patch #3 of 15):

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810051358.1244418-7-michael.chan@broadcom.com

kTLS support requires the new MPC rings, so the patches touch
the existing ring reservation logic and exposed the issues to
Sashiko.  The issues are real but only likely to be hit with a
large number of VFs, stressing the ring resources to the limit.
These issues were not found in the lab or by users, so Jakub
suggested splitting these out and posting them to net-next.

The patchset includes some refactoring and some related fixes
in this code path.  The driver will now scale down the rings
properly when FW is unable reserve all the rings requested by
the driver.  The default RSS context is also reset if the RX
rings have been reduced if needed.   Note that additional RSS
contexts and n-tuple filters have similar problems if the RX
rings are reduced and the fixes are deferred to a future
patchset.

Patch #6 is new and removes support for the obsolete NITRO A0,
to make the fixes in patch #8 simpler.

Patch #7 is new in v4 to refactor 2 helpers.

The patches were tested on 5750X and 5760X chips using production FW
version 237.x.x.x.

v4:
Improved patch #1 to fix a possible NULL bp->irq_tbl issue reported
by Sashiko.
Added a new patch #7 to fix the ring trimming issue in patch #8
reported by Sashiko.

v3:
Split from the original -net patchset (patchs 1 to 6)
Updated to address some more Sashiko comments.
Added the new patch #6 to remove NITRO A0.

https://lore.kernel.org/netdev/20261012220827.340998-1-michael.chan@broadcom.com/

v2:
Updated to address some Sashiko comments.

https://lore.kernel.org/netdev/20260928041712.3467803-1-michael.chan@broadcom.com/

v1:
https://lore.kernel.org/netdev/20260831024342.2161156-1-michael.chan@broadcom.com/

Michael Chan (8):
  bnxt_en: Clear bp->total_irqs when disabling IRQs
  bnxt_en: Fix bnxt_reinit_features() when irq_re_init is true
  bnxt_en: Refactor RSS table check logic
  bnxt_en: Refactor IRQs required logic
  bnxt_en: Reinit IRQ when configuring LRO/GRO/HDS
  bnxt_en: Remove support for the old NITRO A0 chip
  bnxt_en: Refactor bnxt_num_cp_to_tx()/bnxt_num_tx_to_cp() helpers
  bnxt_en: Fix ring accounting and validation when rings are constrained

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 480 ++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  14 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  22 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |   2 +-
 4 files changed, 234 insertions(+), 284 deletions(-)

-- 
2.51.0

