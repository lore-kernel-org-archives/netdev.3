Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941B375AA8
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989633; cv=none; b=hVadzFu/jMTBIoe58wFc96BBoUYKCkjEcE+k1+5LqFHA42Zw9lz4e3c4s4Ae0+/ZV7SXexnK+4IgirLH642dbKW+JxNQ5xuda6djADul+MEiXvfU7GvzWdtnV988xhPiCiyAUpqcWlgIiBUN8xDC3vtyUjE8yZsKpijqz7I1ywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989633; c=relaxed/simple;
	bh=PWbLl7/NjY1yNDVIg4XpNehMc1CfJea868Ft1HhmzEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJyVLJjfzfVlY5lzU6jHRD1rkfQ3EFZNfMXyWLn2K4QqDuZI/LpS8sD7xpXVHvL9rCDeoNPfGOFwiLbJXZVIE3uQRm8emPDPLchrwd+RwghX6sqXGVXYRmxspno+Nx20FmAZglqVd4n2neArigX5fZshI7lrm8Ux/fEGaZYjLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=pspRnF/T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="pspRnF/T"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d01663d816so15826765ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 21:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785989632; x=1786594432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EdQXWhem+0pJKfeWyyElvWf5jpQ5mDNhNAFzw6qPrus=;
        b=pspRnF/TaAUioQfmhAYLXtNukVbPkv9D9aBrYPIu1dx4UkFyFfxuBPkaueuMOae2b0
         S53kcmKqshKT5yMhUPC1nCcfghax/DFNV3tOLaLCs2VTDoD+6DQXQxwuhOk2/TYx/Fat
         Lb0wcxls+Nd19BFEvcp3773BRqBEQyEhUA+bqf/o93kMqlLA/wBVl3yszxhtouERyZ+z
         r8K6aB+c7S7fRZ8/cRGWtBj97/Hh4jT4en0WrLqgZ3Mpuoaxprb3cxLvkCCI20ekdzyU
         IWUa0ugnu3GzUou/iKo01oBMJ4sDpu1VujygVr6VitocHne9/ubuNq0RAxAidnJiN0qj
         gf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785989632; x=1786594432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EdQXWhem+0pJKfeWyyElvWf5jpQ5mDNhNAFzw6qPrus=;
        b=di8d231MMqmS03KZk4sCNMl3t0EkJspGJKwibmfilFeif0J2ykHV810uL2v94Op+AO
         iztyYV5PTkZ3xJJUwNTUt9U0wOQBlXB9/GeGWx1CvvNMCnxOHUS0czLsSsRqyqcOOP06
         Mfzdzl6HOhcu8SdXAPheerL7RNOpTt6T9nUVMCZchwgjJOar5FaU97u8ZXEfRpRCfz5E
         Aix7Ib5c2P66p4tuXFNn/vfAidcRBveFqqU81rg934MraQBCGQxwxQNUh0RrghIqE4Re
         DZRManxIOO3UQPeqL0ndS3Mvrdmx+ygWAE2/tvGccK9l1/oDyGGzcBbIFT+GuajXI4gT
         0Emg==
X-Gm-Message-State: AOJu0Ywfi0Xop2RxaHvQc586RBd7cykhQKaFGLKGZap4z/LyNlKtlGrf
	mHM4Xl51PMXrCUFT4Hh2/v0Bk7s4MphGgdSmmLI/TYXA0TuTBPiHANc/bJjz3VpaBj0M88ZHM43
	PjwhYpZwqG9efX0d6fL4=
X-Gm-Gg: AR+sD10zaWXZ1pJkzNivNO+PVfllINITPrxNndfmgY4l6oa0jMjmtK4kMcbD6RQ88Mj
	Lsf5A30WOm1U3VlOgws4GDRoYQR7ZyacxhrYb4HYSPbQfVPpJ/SYG4lkibF9IPTUib/UIFRo2zw
	9vds9AlgjG8DEcb33Mzc3PQpoHxMrVgPag4njN0fHxShK7t4eYkw9deyrVhZk9EpJaK5w1ueBTD
	HDTTvcf/6qz1wni61mKFvXxVi8nX2bpUDqouxPsoncTo7siZTwp6h0EUAjQiPZ+6lsQeH0abLe0
	7XGFFdCJaInUizCSJrJFFXXW3bl4+Bcy8Aego4b72oZY1uOEk7Iva2ag0VL+vbsMMpFUDFTi9x5
	BgUOv7iCk8fX5KwsOgM/s/kuB5CEa0bP/EqmdBLvyt86e6SVlaABEOz7eV3cOKXphLtlhitLoaF
	4BYX1HsmqIOalSjr48Ox5S7szYJAH9J+175xNtTW4aQJ+756LQVrTHzZo=
X-Received: by 2002:a17:903:37c5:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2d0ca77f62emr149275185ad.13.1785989631480;
        Wed, 05 Aug 2026 21:13:51 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4b6c66sm23954505ad.55.2026.08.05.21.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 21:13:51 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below TCP_MIN_MSS
Date: Thu,  6 Aug 2026 12:13:38 +0800
Message-ID: <a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784972917.git.edragain@163.com>
References: <cover.1784972917.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260806041338.VU8oSmj2lIxnC-0fMyrfkPXLf3qi7nQjOrKtLuqVbbw@z>

From: Yong Wang <edragain@163.com>

ip_metrics_convert() only caps RTAX_ADVMSS at the upper bound and
still accepts undersized non-zero values from userspace.

A route installed with "advmss 12" can later reach the passive TCP
open path. When SYN timestamps are enabled, tcp_openreq_init_rwin()
subtracts TCPOLEN_TSTAMP_ALIGNED from the route advmss before calling
tcp_select_initial_window(). This can reduce the effective MSS to
zero and trigger a divide-by-zero in the rounddown(space, mss) path.

Reject non-zero RTAX_ADVMSS values smaller than TCP_MIN_MSS while
keeping the existing "0 means use default advmss" behavior intact.

This matches the existing TCP_MIN_MSS based validation used for
TCP_MAXSEG and fixes the bug at the route metric input point rather
than adding a redundant guard deeper in the TCP stack.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv4/metrics.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..b9b97a0a5126 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -44,6 +44,12 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			}
 			val = nla_get_u32(nla);
 		}
+		if (type == RTAX_ADVMSS && val && val < TCP_MIN_MSS) {
+			NL_SET_ERR_MSG_ATTR_FMT(extack, nla,
+						"Invalid advmss, must be 0 or >= %u",
+						TCP_MIN_MSS);
+			return -EINVAL;
+		}
 		if (type == RTAX_ADVMSS && val > 65535 - 40)
 			val = 65535 - 40;
 		if (type == RTAX_MTU && val > 65535 - 15)
-- 
2.53.0
