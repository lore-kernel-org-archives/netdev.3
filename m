Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179D413230
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493917; cv=none; b=spm01VPvHG2oOOZxCkECWWliwxMHs/i44XHPiKCDVNI/tn4wkkaTeUVQyWntMcLq8n1VvejTzKPoCVysci0R8Hrb1/ZLzgrCaHbDzKhEIMW+o6KwQWivtoUcaMyFLmqz09fzQrgzQJZltvfvcqih8UHbRMf7dnHQ/7kWFOE8RHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493917; c=relaxed/simple;
	bh=l2XmKyEnKKH86Y+s9uBbehwwYoRt7UZIO0J7VYolSoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSsgDw/8NyxzPLFbnqw3SNvpvqIF7/FA9cQsEUIvI/4oTlV+lG/P3aPiMQQtq4F0YmYFdjtXBNoT15kI8/4QY4Icnwf84yi8MzMH9/iSmgnbM6sdAZ1m2bnfb18qWyNLTUYxrG3KjAgLTlr1H3e6Ps0Y1FrQN8Ld4/Be4WN7HVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5aQ77XH; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5aQ77XH"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66899fe9077so1116590d50.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785493903; x=1786098703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hyei7gDfbeKUSdPExGhWNp37mXR1uDMA2E8msTrFFIY=;
        b=T5aQ77XHKp/7fxG+GE3rv47632zu63YC6TjqM8VuTBOobU+YrOYvTGHVLEiLDqIo9P
         Xoih5fkvF/hTkM7yqQAinG1v+qaOHIrD7olkg8TLIjUsF0qLis/uCpiVRBNa0S3E/wi4
         8j0A62BIHsU198/Z+HBkahUQY/xGC56luDjt2IiHz3gdND3TuMBID0mCzFeGKZLEcF3o
         nGdZ0VgWB+A4mzltaJn1Bp7hsE9s193RFGD+TEY0/hxSQFgXXBii3p/oMJuhABQTR24E
         AIPttCGm3A5PZDu8o3R67haM5ri32NhF+M/AOS4jF3WXlwSDFjkzL4YGzY8lQ0LhLzTj
         n1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785493903; x=1786098703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hyei7gDfbeKUSdPExGhWNp37mXR1uDMA2E8msTrFFIY=;
        b=VUgAQQWUXDWs0RDRSDhkkGYwXv/hX2PlGmaXQNu/bcc/g0XZPw/qPFJkXyyw46xDVn
         GuO+Xgx1UYzQA4GjHKjoP3dL8shn/hask+GtO5Er523VsV+zj5+rnTsp4E8QM0BmFqhR
         +kMoAe3MaCGzs+5DlwPc5vgkTBipY6+DRgrU60uOk6wZ3oTDxZeUn6U8W2rwTGcJtL6X
         CilUMYRiXlk89VIGeMuUrrsMtdSAP3ObJe8AQai1XbOxhYBwgZGzQn9mId4Sdhwar0vL
         icrNd3ZWOZKg5BERFIsULE5Ef9vjxGUoZQGFI7GC7BIJ3QuVgUSyB0D5rAPccwTRIErg
         kH8A==
X-Gm-Message-State: AOJu0YwyNvBxUrFfC6LNKr4HsrWiQIeNFdr6IpreOtoM5VHBVup4lqP3
	VdKDGHPsp3PuQ8Dcanb0DD913sg/VCQ+aqwMRnMe0bBD2EG+zXXgdj9UOWzV1KMR
X-Gm-Gg: AR+sD109ld8kqx5IhUGmLRjrHcsth+VeccezX9Iylw0s2ny69heFHZObi1j7HN+kGFW
	6ATvmP4LZyjoNsEHpo9QdEMBUL0fZ8rlL/Bnvkh8nl/IBIj7yF9AhfWJzClLSveJF4a/6v7WCHq
	J+ZowYd+fPurL4XjPuU4CNMM7Bw0D4u4H7gHvtjir+Tx4EJKMQ1Jv+1VSDCfMa6VktN7RglmWAF
	mDFr3L5/YA3jFIP8vhQgTZ50IW5QKYXn8QtPrHMz4BNsoa15gma7KOr950vB3eATQKsNlHAVM6e
	5CUXefTKDbDia61cTPB3cRxhcos+IUq2an3u917+lliTZd8PV9wJlqePp23NJjazK57Yfqw1EMr
	NpLa15t5RoLk9guCas7nZruZk1AY9wt25I65rEsHuFOYS+8ZR4pd+lGL7QDEnbNQyULE+Adu6fD
	RtVz449uST5m5qiMBwRXW99pY0FpKrmUZC97JqAK3Rx8t70LlNyeEbXwlTqPx2jmOWq0gpf5I3F
	h5q2L52kqCT6yJKfSJf1QZyfRSgcbwAoemMfK1eRxk1wosVsUyBB9mZzuU=
X-Received: by 2002:a05:690e:4401:b0:667:8495:9604 with SMTP id 956f58d0204a3-66945231726mr858505d50.25.1785493903283;
        Fri, 31 Jul 2026 03:31:43 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948ff8a79sm338530d50.16.2026.07.31.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:31:41 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH iwl-net] idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc
Date: Fri, 31 Jul 2026 06:31:14 -0400
Message-ID: <20260731103137.4000876-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
field in a single operation.

Descriptors are in little endian. Add missing cpu_to_le32 and cast to
__le32 to ensure the fields are written correctly also on big endian
platforms.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

A follow-up so_txtime patch will initialize ts[] from params. At that
point the 32-bit cast can be removed entirely and replaced with a
straightforward u8 store to cmd_dtype.

https://lore.kernel.org/netdev/20260726202902.760552-4-willemdebruijn.kernel@gmail.com/
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c724d429a7aa..91ca75e45463 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
-- 
2.55.0.508.g3f0d502094-goog

