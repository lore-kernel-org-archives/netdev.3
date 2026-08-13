Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530D499F14
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640746; cv=none; b=dTLif1N4qUGBa483ig2Aa23S6gzWmehbK+w0kDVLEF6w+HdvP0PjNxDUMEXWNSPCb0XBs1R89LYpa8koRphxJ37lK1MM2AwRyb4aH4CoIjlRer6u6SiUc3vlKHy0MJKSFhouaZXMgsoOo4AboKpjNWtQIvA4NDcE6VKSAlAGIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640746; c=relaxed/simple;
	bh=PWbLl7/NjY1yNDVIg4XpNehMc1CfJea868Ft1HhmzEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNffWS3sKtda/089Kw0pjymGzVt9hkUUhdJGG+4x6Iv1Vyz6JyDiSdv7JRDuKTlruGah9k7GJm0PmMTpnYhv4UCqHEJoRXNTGm6nYwM57Iu1D45qR6BrwNLZOs0ykvr/7UOwpJnwu34gp6+pH+THvp/lkvyATGgje0FrueNjgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Iky8LINA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Iky8LINA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8485ef63b68so3122239b3a.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786640744; x=1787245544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EdQXWhem+0pJKfeWyyElvWf5jpQ5mDNhNAFzw6qPrus=;
        b=Iky8LINAcpJDNBfjR89Og286fVrT/3O61EDe1tb9UJLxwYDHayY7uN8B27UWcX1uhB
         LVThsqVRPFUn4DeKYjdPL2xZ3Njt3bl8sBPgqm3UpLUIhdjfoj6TkV4J5o6ZBy4ahq/S
         m0/ee+IF7TH0yrMC2x2mnv2BWtBCR7QYYpUtowYqdRR8RK2/R6hHeXrr7tDKegbZS8Du
         CMavKl7pKtsm5paIf4biZ1XmqK0NHSw4xSCFKjC3af4GHAxqYlW98VQw8wECtgwrCRk2
         upRr5BBopN4J1qFZI7801soqEj3GbICncRt6r6jNMYGGBA36d+sCokoiPq9krBLo03Nd
         dwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786640744; x=1787245544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EdQXWhem+0pJKfeWyyElvWf5jpQ5mDNhNAFzw6qPrus=;
        b=aOgeHUjnwiz8Q1JrcwplQ7z/vUvILUR/Mr2Y6k63Nwh7HIHy+vF6inJtNn2POx0OuW
         vQ//WG0m3A5S63u5Ci9f9JmpquNOdStjbtqL4+AXPGQjaSSRwbjJoOs8ae0kgnuHFM3R
         lWuOdFWfLzinWGN8PYrz36cBl79d9jqgmVY0G9SVg8RfdVaTiyiUyzwXI9hGM8lzG2xV
         Y4+y+hO6jWw6Kt4nIZc1PqyNggJGwUlP3z9pNZVqii9UV54E+6vajKH1msVEOMqTbVx3
         fzv7KsIa5toO743nkEWgVErnleX8fKQaXfHOaCoHVefLXhAmVQx+BEXn+M4FQBTI9QA8
         gQvQ==
X-Gm-Message-State: AOJu0Yw9boUtxIKZOzcxL3HdEtceKabN7+b3UYYCgbvr6Qh0FzrMwopj
	lfPubmd+w6AD15/1r7xZPGUJKbZpOeSHZZm4HgTDZDTgCCjaTZ2iTD5VVHZnjY5hM/ynjMw5PpE
	4OAO1B+dH
X-Gm-Gg: AR+sD12HfjnOTyJIfhhzKzb6ufsX9hfFX8+0FfewSwvAZznYmtKjXb9sJo78z3WpoLV
	LpvQsaz8sT86wTUg/wdfSp/lpUW6lwhODt7R0yPNk2UzSsfmZXqn3eNB/qbCuFJJNc0uWGa8YdR
	zGHA8heDOrg2sYASSFiN0sO6xFDc46+Pj9EphoHPvPtukuWKXmRiQIrQpz6u7XCkDCowbzu6/Pp
	Ox8GU46ogEDu2SN80jmXY0jj/c/n0P93UHaO9iNjEvxL0nICKhOMHErj8kM9aAnDu3wpsgM8F+S
	9SiEdqw4L/c2vWLSQO4HUZH6I4+gca9Sw7rIx5M1gBlHGkT0MUTIgFLO2hlOoHSp3c/jVMytnmo
	/7IU4XwyCbxC0Eqx4EDOr4nqMXb9NR5r/XwT5aOI0HAFkwz2JLE94FhxpWbU7+59z4/y7wAQmQj
	ohgyHLpA0LVh22e/SzVxQP74MXyGTV1sTl4fsZ3AJKaJ7VZEtGyMDxCf0JPYOLJeIqy9dhmg==
X-Received: by 2002:a05:6a00:3d08:b0:845:e8f3:bdd0 with SMTP id d2e1a72fcca58-84fc768cae3mr7381229b3a.33.1786640743669;
        Thu, 13 Aug 2026 10:05:43 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc5aa75c7sm1239379b3a.61.2026.08.13.10.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:05:42 -0700 (PDT)
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
Date: Fri, 14 Aug 2026 01:05:34 +0800
Message-ID: <2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786610865.git.edragain@163.com>
References: <cover.1786610865.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
