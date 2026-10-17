Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F823AAF73
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255161; cv=none; b=ECAol5EMcKvyUFePqs4Ibwl7RNodxHYNfbmH8tlW4lcb933ncuqbvtW1o/ZI3FIe51v0PBd61WFdwAQ7nPaXnsRfq4w8ivcVqcwTGETBcMkESNFtQ/c9JJAMy/ide+aQCDlK1tu/1b/OwnAg9D/46ngSkDw07OrV5XS0RffXjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255161; c=relaxed/simple;
	bh=zgAncej2VMKtRTstMEpHtZxGPB+wKyq/+2Fwhv76YLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpZWyHQlvOfkIr28Etskr3+a1q42knSyTNP6P5M+YlYpdh9Ho3yIvOvVNTPrZakNz98554Z6cciczHtmzxGhGpou/dzl7NpVqfhu8kufNWu9nXr/7r0f3w9hIljCWuvSzNkTBlr4k2aE/usAZcmly1HfCOltOBLO81ny7Okt2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccQ8Xth2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccQ8Xth2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e812e2b31bso4311255ad.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255160; x=1792859960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2c71ftOjOMZN/elNUQWQLQS3OBsPaj6ABPEs543IIw4=;
        b=ccQ8Xth2tvbO6FAGHCSQJO/wPKr/t4JyzUeKx6RXeZn8u4KCGKRGgqkmB/2R5WTSBf
         hOFp9vEyQhctswgIGzPVzNklaWd+04ACGCK+W5tFQ9nwYNKpH+fOFsXfz69EGQqgQrbZ
         12nioGVcD00iZvzu4jZO1tzK/Xp//ia2SeYNcds6M+BMqbwZI7XcsIPaLK+uI4M64M3p
         bHWccqWZ8kHxf4UqlzYlZ6Zd3vNw4sUxS43+nSDeLDux+yuqgoiGBg58NIWGFfRL0n0b
         K4cvTyQR3zHafOJfgj2KGQTMXGyot823mt1tZgEiYv/MUNxGwVS10phXKRIStWqFB2d6
         tYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255160; x=1792859960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2c71ftOjOMZN/elNUQWQLQS3OBsPaj6ABPEs543IIw4=;
        b=lnJZ4Qd37ZtfQDLZy18z61a6mRzbVj3MxUImxl+jaCV13JOXMdSFpAnRWENbDvblAk
         kdOJG58MDqsbgmyZ6UXXXRR8auF0W6yRisb6xJFMdovxz3GLbVfh/UoW2FDx1JgQir6F
         2BG2ohLAPJmzkJ0Gfogb9wa/CAEfuQc5TDTXtq6GrMXQidcApSGc4Unc+3txCFAY6T/H
         FeuIoijJlCNsDZ97e+2hZjO9ia+m6bbhfCXPKe1nOv6FxkDb6NiRc/mmhcEzWYTD7JOG
         e1zCJMQltuGQDoRioICPJar49K+1srL2NHHZuNuzcFQfYKVSqlqL10eu9zaAxbVYzLNs
         nsNA==
X-Forwarded-Encrypted: i=1; AKwUvByJou9Lj427B627pfqvlZslfB11r+Lzb4FGgTF9T0y782fFBaBfIx0OVd2SEMlxx8zs5MmLrFg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLB4WMjJQ1ARfIE+OJC4NYhFflkhH8BtGP8OYnlKTOrhfYf3fim
	H7RUTLaT96DB8GJ1k9+fcPgkslBxaOLc4IVYa1HAqtc1vHxv50zHwT/y
X-Gm-Gg: AYBFou3kP2Ev9Kd1ikEJnl1yjRI1P+JOiJesFyNlVD3eelSgF5sGVeXvYcqmE55JnKN
	yiP7yrGM89Zwn5c31H5ff+EwL4seeF1STu4qd3voSYolELOCp6okTgqFlKmgQrk4IHCihrzZ329
	uyWjmc6AO3fNhzQayMfWRF4oQ9j5tot3yyrjPDcacINChzYcSz0xNsNKCSCJkJ1fdN8wr0iRapt
	5xAuXIEYZiIWmqT9rRqvYvCqC1xLE33Zqm4zjIhp+ifhVxewXzrUvN1WHu1flKI2mqRsBvSx+61
	C9D8FgfRWllYbj0L30HTT0D1TDGQKrbtjj3x/0p43VSGmlZQ/Qs/JHU+f2mX0NGrPO0dSMMPFzL
	fI0uHGuGCif8UoJ7KkRGDniWYdUuN71OZqvyw9S1dXUQzpFaW1w1t+YzGthcYPAAz3/iMBCSiC/
	Fx4K8Ekhf1/i7ZKSw5TwHhapYacSOkObm4kAid1La8ZNBEeMD3J7W7NtYErVfL7Y2Y0EFsrsB0m
	iDnBENU88/4Te8sCycSzrUs/1BugR3xjXQ5F4I13darYKdRG3artRY2BjZI9twCNvrdvtwxhhJA
	1bhqmni4FSM1rXmA00AdOWXjzqx88XGU8V6DXkwRT0U=
X-Received: by 2002:a17:903:2a86:b0:2e9:69ef:ff38 with SMTP id d9443c01a7336-2e9a6d1d163mr28164385ad.55.1792255159958;
        Sat, 17 Oct 2026 09:39:19 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5c311bsm22577835ad.10.2026.10.17.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 15/43] bpf: Fix NULL deref in the sk_storage map iterator
Date: Sat, 17 Oct 2026 16:37:17 +0000
Message-ID: <20261017163745.3341787-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_sk_storage_map_seq_find_next() hands out an element only if its
local_storage pointer is set. __bpf_sk_storage_map_seq_show() then reads
the pointer a second time and dereferences it without a test.

Since bpf_local_storage_destroy() unlinks the elements with
bpf_selem_unlink_nofail(), the pointer is reset to NULL when the socket
which owns the element is destroyed, so it can change between the two
reads. Reading the iterator while sockets with an element in the map are
closed ends in a NULL pointer dereference. The sockets need not belong to
the reader: where a program gives every new socket an element, an
unprivileged user who opens and closes sockets is enough.

Skip such an element, as the TCP and UDP iterators skip a socket which
has been unhashed.

Fixes: 0be08389c7f2 ("bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/bpf_sk_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index b5349bec5695..aea67b446c7c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -813,6 +813,9 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.map = info->map;
 		if (selem) {
 			sk_storage = rcu_dereference(selem->local_storage);
+			/* reset since ->next() looked: the socket goes away */
+			if (!sk_storage)
+				return SEQ_SKIP;
 			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}
-- 
2.55.0

