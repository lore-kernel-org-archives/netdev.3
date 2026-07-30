Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27B43F8A7
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423377; cv=none; b=Eaoa2u2W3FrF6VPKK/fxgQCVZo6T6IoBkupKQ76qXPVHt5CQ49z58uxfqs8g8k4SsT+5IfXHd+Ihj436AG4fJv4oy76eNH3v+f7YhYFIGzTlCXFGrmbvYyLYs2Dg2GGq0zUNBxL98rNIQ3MiChkcsocvMxu50VJZx5tUik4XZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423377; c=relaxed/simple;
	bh=UrAN4OCt1D4hYKAylCi+a2dtUcFv7D2+39R4Mj9cFgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/sNr76J0lKwiRqIZ+IU3oC263fTgfrwaoJzvLZY+soxGTgw2U+BwPaL9ZmQVwtfVBVxgbPESw9hl41zkQBFE287MtFY1C5rjchSpGk1HbwlOgHBkagFlaIPlaWODqzdRpjm82uHcVgN4vo/mV9HOG7WAyq2sES0Qr11+iTqKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggXqMDo9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggXqMDo9"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2523442b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785423375; x=1786028175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4sCpPfdggw4dNIomKaGnq4IuZW9LM2QCkdx9s2TmYU=;
        b=ggXqMDo94bl35aXEjukBOhIKvormV+2lfOnb2CuTawE0bvDXzQWnUxa7ItA94ip54K
         HKvnoMTdWujhZ4/5c9Ci90jf7TZfM7QSD99P59VcC3GybpjUMJRX9ul9P3TT0ErjRF3N
         7eXxPmyLSqQK0X2HYc/YdNX5qvFQqXVLarskKQKsbvgadUJiufnaDT2G/e3fbv/AqNw8
         cKJ6lLiAOIcSgWEhpLtYqF/rBe+A3h6nNbXZvBmtIQUOm01VanxLm7fVvt+M7W+k0qtU
         5NVzk4yHyylBbcdMJHkosABoVfioIxPjXe1FS4/MOYssBQD6XbNOKAM7AvytTDOHXQnv
         0A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785423375; x=1786028175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l4sCpPfdggw4dNIomKaGnq4IuZW9LM2QCkdx9s2TmYU=;
        b=gjQe10+LzcDgOQnYdXQ8W+kauzOFl5j4FBXo/EfWEQEBmF793Tz73BCs4N9V1izNVB
         z81JkrG7cAEz2VsFsJLEzPXxQCcdpAMVjwraNNPoV+YzfTSMyx5xMfqKBPyAYU5lrEQw
         JUdEmxbsoBgji2mwLmSfUCmTjARrbqMzN09B5UdoVK1jN1yoA3Q7GawnLaGZP4gyRk+p
         NvZmwKCJQz/1EZvZub/tDOHSvXGBlrXW4vVtpqMjDtYM1jMQ291fcTuQkTLKYp4iDhod
         70ejy0tSLRO/ju1/af7kAEOkI5wUGdIGazZ8+Thylh5uRh3hJkKaN4FeCVmok3OEbVSx
         DVAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rol/9A7oOhOQtXT/PofaPJxuMnT6v27BMWas6zctVt3pXN2/9kCUWtEhW/9pUN7nQO9ql7aOAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1TnZtrynG17/eZyhTfWeDEHGIDyHrjxwhgQLBWlJ3dyDjlhds
	gUOB665X4N0FsLnASYnBi8ynYwdS2aMK8aXWsGP2CrLFheBI/ImWJO/o
X-Gm-Gg: AR+sD11K7xUSWDd3BSiRD1syFrIcwQVOi8i+Kb4lzUlmJX22wbXJn9F9jGYakc2qAuQ
	T/3i7Tz6PbxDgAXIVqAkRLln36vqldjyOwzyD+cTEQjpguPsVA+vMaBXJGK6cc/0vS8aQeo062t
	Qdy4do3TrJVan8LY6pCnRu2Is4ZMawaNzcFU3UpBX0G7fV9rIZi7+/ZdiajBGhCmwZcdwuOFxQg
	+R4H0hCa26V6FU+jEcUcboc51i/Vsno+WjD9FJyLdHFGbvO31flpdvnq8eQ+fef0dIrHqLAp+F/
	vfpDtKsXKqi6r6TRt9ZKiL+YvHqgQfT+V/dhg46MCFyNMv2euPcIs1Z2iexMW9RR/eJMTV+E0xw
	pYmlJvbwdLL51sWCNpUV1izwu/kAhIFqvV2u9Jz+IeDsx895dFas09Lii/Mp1RjB743zQEna0jP
	SqgVC+BC7e7JAggC6iOa+raKoOWgQ9pVqQm7/oDPRYiUcAKT7pFl2YhmW/sjRAeRPv7JAcksvq+
	AJdpp6+QKBXs8c=
X-Received: by 2002:a05:6a00:414a:b0:848:5540:2377 with SMTP id d2e1a72fcca58-84ebc24e899mr2806177b3a.17.1785423374556;
        Thu, 30 Jul 2026 07:56:14 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb78ae98asm2265960a12.1.2026.07.30.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:56:14 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ubraun@linux.ibm.com,
	stefan.raspl@linux.ibm.com,
	vega@nebusec.ai,
	lx24@stu.ynu.edu.cn,
	d4n.for.sec@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH net v2 1/1] net: smc: fix splice entry lifetime imbalance in smc_rx_splice
Date: Thu, 30 Jul 2026 22:55:52 +0800
Message-ID: <20260730145552.360287-2-enjou1224z@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260730145552.360287-1-enjou1224z@gmail.com>
References: <20260730145552.360287-1-enjou1224z@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daming Li <d4n.for.sec@gmail.com>

smc_rx_splice() passes pages to splice_to_pipe() before taking the
references that cover the lifetime of each splice entry. In the
VM-backed RMB path, splice_to_pipe() may drop unqueued entries through
smc_rx_spd_release(), while queued entries are released later via the
pipe buffer callback.

The old post-splice accounting also derives the number of queued VM pages
from an offset mutated while building the descriptor, and a multi-page
splice pairs one sock_hold() with multiple sock_put() calls.

Take the page and socket references for every candidate entry before
splice_to_pipe(), and drop the matching private state, page reference,
and socket reference from smc_rx_spd_release() for entries that never
get queued. This fixes a refcount imbalance that can underflow page
refcounts and trigger a use-after-free.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Daming Li <d4n.for.sec@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
---
Changes in v2:
- Keep the offset declaration in its original position to preserve SMC
  reverse-xmas-tree ordering, as requested by Dust Li.
- Add Reviewed-by tags from Dust Li and Sidraya Jayagond.
- Link to v1: https://lore.kernel.org/all/192d1b44ed358ca143f44ef167d14153bccc51e9.1781097957.git.d4n.for.sec@gmail.com/

 net/smc/smc_rx.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c1d9b923938d..5c9e4d8b57de 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -150,7 +150,12 @@ static const struct pipe_buf_operations smc_pipe_ops = {
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
 			       unsigned int i)
 {
+	struct smc_spd_priv *priv = (struct smc_spd_priv *)spd->partial[i].private;
+	struct sock *sk = &priv->smc->sk;
+
+	kfree(priv);
 	put_page(spd->pages[i]);
+	sock_put(sk);
 }
 
 static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
@@ -209,6 +214,10 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 			offset = 0;
 		}
 	}
+	for (i = 0; i < nr_pages; i++) {
+		get_page(pages[i]);
+		sock_hold(&smc->sk);
+	}
 	spd.nr_pages_max = nr_pages;
 	spd.nr_pages = nr_pages;
 	spd.pages = pages;
@@ -217,16 +226,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	spd.spd_release = smc_rx_spd_release;
 
 	bytes = splice_to_pipe(pipe, &spd);
-	if (bytes > 0) {
-		sock_hold(&smc->sk);
-		if (!lgr->is_smcd && smc->conn.rmb_desc->is_vm) {
-			for (i = 0; i < PAGE_ALIGN(bytes + offset) / PAGE_SIZE; i++)
-				get_page(pages[i]);
-		} else {
-			get_page(smc->conn.rmb_desc->pages);
-		}
+	if (bytes > 0)
 		atomic_add(bytes, &smc->conn.splice_pending);
-	}
 	kfree(priv);
 	kfree(partial);
 	kfree(pages);

base-commit: 14fa65d10f5696b063a7d8d26e8291ea84a2c6ed
-- 
2.34.1
