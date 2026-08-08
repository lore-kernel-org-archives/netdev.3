Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77098379ED4
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786176091; cv=none; b=bnDaNNdA8I5wD8E0ukZIWoQG+5SFutm5EItSQqIvgs/cL3UU9uIZrLMcUqE+MoXlGzRasxMiywdjT23OYIDcKk/ayV7IYEF2xq2a6eNOfHwuEOJ97CpV10dUz3fzDHj0j2slgQWgINYeFxGjsnbuoT7qnj83O5M4a+/ZsrtI4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786176091; c=relaxed/simple;
	bh=La62smyhpydhtQfRa5LsL5zk3vXpL61o7xnIoOZUr44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3BCHETBnBRNT6CNNaKc8qW12uT+HPnzMdEP3sceF4KKPUq69zfq/sHFOm+FfBL2eY1cMOoR41IIlSyGJpVwJu6vHokmWvqU1gqcDJN3hymCfG/7lp0gaXwRwsqGDqZcJAU+VjETaOse/osfJ8/PH37kgvPP3JxoDLhgLiBaCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=dR1SSfuP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="dR1SSfuP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab973140bso5215615ad.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786176090; x=1786780890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KER0Kcj+/JmswUcYkAWJEnTqyoqqQGV9eZysF4747us=;
        b=dR1SSfuPZSY0xQvoCjWMsT7zWMKeQcpkDyMH+aSCsV2YS+OAJWnwDEINEE1nefbZjP
         c2dz+R5M+Od6s7Mc28Ik9kUAtIBKTs+ph0+tBpjTqy/UxfNj7GN6aLVcpsNa7MRMQsu0
         BdCuejFMG481BHHAKKcPOrcfaePG+KRvwoK4tb+Gu+WZMuYKqObOAJZbjNqnE9OGfhv9
         icJQqf4zo84FcrxcI2rQTT8RY5zpuWNLfzN8nXYujKRw2ywxNrcqJRTUOj1k3qRNAdE7
         iTBFs/8I8TsuRctnqjdW2D9/iFzCuEIwHwUOcjvRDqCL5OJEl3ls1hioECI8cPffWBH6
         BO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786176090; x=1786780890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KER0Kcj+/JmswUcYkAWJEnTqyoqqQGV9eZysF4747us=;
        b=MJBEGJAxcER30IsgmwAQ6/Goltaihl3ybTnMjL4K7OiF/6u39at+/tcc5kFId3jKCb
         rN05gmOXFleM4oDjKSt+chJ04qR6fOg9ASWRt4RFop/7ZpiYzbs218pb+JLfkML9Hh60
         D+xADfaEjRyQGuzmIMHJwNRKjgLoulZ/zN35okkZP9CaeA4LLUCcpbqpX7K8Nkel6PVK
         IFvZsaSf+0M6cc6rVPdlRLS5UkbDRaMa2cjlvlvlF7VN2PaQx7qMRs/m8J0iRfoMTPIW
         ySvKzLeYB7Y12K3gGAFnQiC8X3baWEopHKdKHjIQnj3we0L+c7ShE7jiHan6GYYiFIya
         srZg==
X-Gm-Message-State: AOJu0YzipiHC2rcF1o8WWnclmeiambSDuu77vltFgwrbwgLzeacYG0yo
	BPD7xNzmE7t1GbMWE/ut17bBJBpEhS56zPdCJNdRX/7ey4XQAeuYdpKF22A00Mz0TqxlZvw9EOp
	qX1B5TsxV
X-Gm-Gg: AR+sD11v0a+Jroek51r3FwNejA9W8aA61xQDr5/ZL9u2YWuhRALZH9c/Nfd91FkFwLZ
	GyH4E7gCcLQb3MkrnPMVp+oaYXmfpLNJ8ULEwcEgShbvC3ONtOQ4aJnlC+GaKi8U1lYmmhOJ+2H
	wQVWLjFYHiEDywxP7++Eh3EVSR/wJNjHnkeyg4O4n13nblOjw8Bh4cz6OMH/AS4BIPsXI+znvJt
	qLjMrfwz7XsozY+z6BUgvpSUGzKX2PVbqxXRtcZoJSTP2NdH5gZatKdq2I1XuPXfwjR1JqdRl1G
	fCtt8HYXnx0kObNPXJ9t542ZQJf4SCiGY+gLm8/1n3oSpJzLeoaG83s/tnWdt09p+qCQpQBF5NN
	LmVpq+2zHdQjlfjZUXYZ770hgh6aKjzVio/xMvzFWkvhM8YMDmo+Gss98G+9egeaXvYYzrgiqoX
	kKWfKXQg0jDAm0VkAspRyjubUX1rlH1BCd/nukcBf2sQhQ3QMXT8sjjdwl50+PQJdDnVNaWBTyS
	qz8vgLx
X-Received: by 2002:a17:902:ea02:b0:2ca:d172:7228 with SMTP id d9443c01a7336-2d2a8d3b96bmr71022425ad.11.1786176089623;
        Sat, 08 Aug 2026 01:01:29 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a773esm16766705ad.65.2026.08.08.01.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:01:29 -0700 (PDT)
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
Subject: [PATCH net 1/1] ipv4: reject RTAX_MTU values below IPV4_MIN_MTU
Date: Sat,  8 Aug 2026 16:01:15 +0800
Message-ID: <ccd14fb1411b8b9c466065582e43f6a6c0743842.1786094799.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786094799.git.edragain@163.com>
References: <cover.1786094799.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

ip_metrics_convert() caps RTAX_MTU at the IPv4 maximum, but it still
accepts undersized non-zero values from userspace.

A route installed with "mtu lock 20" can later reach the IPv4
forwarding fragmentation path. With a normal 20-byte IPv4 header,
ip_do_fragment() reduces the payload MTU to zero. ip_frag_next() then
keeps producing zero-length payload fragments, so the fragmentation
state never makes forward progress and the kernel loops until the
softlockup detector fires.

Reject non-zero RTAX_MTU values smaller than IPV4_MIN_MTU while keeping
the existing "0 means use default MTU" behavior intact.

This fixes the bug at the route metric input point and avoids adding
redundant checks in the fragmentation path.

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
index ad40762a8b38..10575c6af908 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -44,6 +44,12 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			}
 			val = nla_get_u32(nla);
 		}
+		if (type == RTAX_MTU && val && val < IPV4_MIN_MTU) {
+			NL_SET_ERR_MSG_ATTR_FMT(extack, nla,
+						"Invalid mtu, must be 0 or >= %u",
+						IPV4_MIN_MTU);
+			return -EINVAL;
+		}
 		if (type == RTAX_ADVMSS && val > 65535 - 40)
 			val = 65535 - 40;
 		if (type == RTAX_MTU && val > 65535 - 15)
-- 
2.53.0
