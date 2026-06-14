Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC61FC7C5
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441439; cv=none; b=O/pccHACkCATzhM8FDq84R71nFIh4JXIQJGFgCo+bVm9354l5A10iGZFMxrK1nPpr01U2ifkGIF0eKZJGjmxsInh5mHju6GWuCsz7El0JV9fJlZLF4R4eQjEo5U8aYyqXdRrlewwLGvpenNU0ipyEaMviet5GkYo6EnzzUOTIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441439; c=relaxed/simple;
	bh=O4ZQftSfdzDvQBw4QDT5W/g58Ju49uaSr9GgemzTkh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mm3+C2g7G83hWn4JGu4FdlOOkDcGBQJWRubQF3h7tj8LmEr+MH93y1T71Yx+kIq8zGLf2Ht91Iee0UMaSDvdeaSFZK0sJTFWht261dXQNS48++ADAINsiLFGXlp/979Q18uVfmr6QV+VcM4EWyrf8UZh8JzrbZhVtz8+ruRq+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+RvWZLm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+RvWZLm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c168baac83so10877835ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781441438; x=1782046238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BUkD9fnh6nUhU2UKLYYekm+TZegtL0faOVIIvIfCto=;
        b=Y+RvWZLmGycBtbPps+p6jClbfZp3HddRukSYDtJHy/zYoEOrvFNnifznGjGatM9QgQ
         /9h/EC4EUS2b1OXpXjqEsQjC4vVpdazQHM0mCTYyhe+31gwsd0Fjwge7QqL/ZuqsUOpB
         JiOzIZk7BgesqysCA6vrW+QBZDDdqh/vkIj31HEMExDCtjOon+Ae+a5xUpUt8TkuVNb1
         qUYvZ4Hb59LhKEiTVjfJbFeRjpCZIfazBWBgYi5FyiGjYUQMlOSNQPqR1iKNbpCclib+
         szL9smRVuvVXnDXEqXFcAfDZtaltJAlPAGXXmIF4yTxK8tNzGleJS3Sazlfp7MEaOwuK
         wl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441438; x=1782046238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BUkD9fnh6nUhU2UKLYYekm+TZegtL0faOVIIvIfCto=;
        b=NYgFGKMuLFzJp2sdowPBGozoTU06lGoq4GAjuoX9FdZ3Rcwz9NO9xE1E1FsvPVN3Yt
         oupOoY3sLw4zuWGP3CuCUoV8tlYT4C4/uc4cddUP9thIoVAU0TNHsNu4SLOFWr4jqRyC
         MXe6Wj06Ouhg1Wy1cl9fuORkuHv62kw4NPQ1B4hk/HhiBU7SV7hgoDXK0EDb8p0EEQ0v
         wX5OyTbpE+WdJsCLGGMSJCNjs/wTaBIyMKBQGvsl6Bu80lgY9EMCTMGIFuVqxTgYrZPO
         TL/dMdrK/veRN6n/eIus2HP1FjCpw87ZjYEmNK1b4awfFaIx/xQGV9JTWK1SB9NzLtEA
         k8bQ==
X-Gm-Message-State: AOJu0YxvVTLqcIYpNVCPodHAZbhCIKKq8q4ARb1myA1sm+Vq84wRdFd7
	E9Ko+OtCQTgFwy6xsEKrRxLknDZ0R4vxiyWDCTo8jWdo26I1YCIpcNzYjl2uL0IPlxPjeQ==
X-Gm-Gg: Acq92OFYMFvqPLQW60J29ySJWJWz10aJo15W+DeO6GYm//lF1NsWWmIkPGOQD1OX17I
	P8TCqsuraNgPauc3xWm4PDHsuImus4l6QqJ01xw6dqmBJKX18p+/AY5tDuBuYjZon7nqQjDVYrP
	F1shtpxtZxyjmWRsez7IkpIQ+nVg4C9EUFhsA1GWXLdYlMb7f7dhzD5A+OwDxj0+cxkVgSvjo9k
	C5vHbcvY8ub7WVflUOpLhQZIM0357BqsXupBY/NcWm+jliF7PfKv5lfuyCOcgbcFQOT3bPHZFEL
	Gqtz17Ei5kBOfsIT4g6+n1xQmV3ktKf3wJqpottA/P31+yII/bvm/Yzw6oKauwSgsVhvvgygo6b
	gBr3GEOuWoTCs/FQueqUgHYZWekAaUqph5uieXzKwawh0k80vaFQrxvCSRgg7HOEfLZB+TlhveI
	tVFZRP5deqIp6N2DfQPD3Gy2kZ5Q7aJwxYMQh90JU=
X-Received: by 2002:a17:902:da84:b0:2c0:d9b7:b7b0 with SMTP id d9443c01a7336-2c41216fae7mr121815405ad.31.1781441438112;
        Sun, 14 Jun 2026 05:50:38 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:90b2:9957:66e9:8cb4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac79fsm66426825ad.45.2026.06.14.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:50:37 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v2 0/2] net/sched: sch_fq_pie: add per-flow class statistics
Date: Sun, 14 Jun 2026 18:19:58 +0530
Message-Id: <20260614125000.6058-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 FQ-PIE runs an independent PIE controller per flow but exposes no
 per-flow statistics. This series wires up fq_pie_class_ops to expose
 per-flow AQM state (prob, delay, deficit, avg_dq_rate) 
 via 'tc -s class show', following a similar pattern as FQ-CoDel.
---
 Changelog:
 v2: Addressed ABI backward compatibility issue for tc_fq_pie_xstats.

 v1: https://lore.kernel.org/netdev/20260531125314.22492-1-hemendranaik@gmail.com/

---
Hemendra M. Naik (2):
  net/sched: sch_fq_pie: add per-flow statistics via class ops
  selftests: tc-testing: add fq_pie per-flow class stats test

 include/uapi/linux/pkt_sched.h                |  29 ++++-
 net/sched/sch_fq_pie.c                        | 118 +++++++++++++++++-
 tools/include/uapi/linux/pkt_sched.h          |   4 +-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    |  22 ++++
 4 files changed, 163 insertions(+), 10 deletions(-)

-- 
2.34.1

