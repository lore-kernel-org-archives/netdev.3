Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B923D9DC0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231622; cv=none; b=dZtwB6vTs1QmPZVxlLWQVewkIQjFu9RD+55gMYRu4A8+K3Ba/SOL4que9tG/K+ysx0RsIOQ4g56lUez6VYo2nGWQpTWZXSKltS9paWAF95/PxXLriaMqSBCV+hwvzQ8e8NwxhJDpQ5H9zfESEFsP1+t3LrxI7kB7Sg121JW0FdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231622; c=relaxed/simple;
	bh=FE5OPgwnnVq6/EkJf7a+/zJUwDgjDRqkwrS4uw9s8mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpOEtt5cSMXdjqpwpfD7nOJ5qdkWObnnbwtj9h+r4Kyx3xkbrjRS2AQ30ZrFvZh7x1owSgBiCjMrAuyfjBKi/S4wRusJmSZZROyth77rwnJxBj/rjq4FsTsU3iWeS4Vc8p2F/jsK+odSKfAYoJeIxSq+vNlxfpZTRqa642tdOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=IYW53Xw7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="IYW53Xw7"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so4718338a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788231617; x=1788836417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQXrMd6szNFFZL5zIyMougTL9fSbFjixTSxmkZ29BaQ=;
        b=IYW53Xw7/V8QWarNBp5AoNm1nMNs9AuNqq3rZgBhYRQjycxfQLnZ+iG3H52yRbrmpH
         xDWKICHRZcZqEFxz847KS5VcQbTdUTLShJweGpdQQjMp0M1bvJLW/Lz4iLVvl6T+/0Yz
         /IK8p0bOEDAipSs5z/G2Zom6NIw5BAE44+tCgjhZLIGo+L+57RrDjHQw9MDY2ZZI9NYB
         gzWV349H1Y8JE8QVmAubBQZtR7XuborCNIcUDyRtZyUpfg1CPDQNvIgO0CRj/rcuBCXI
         SJC2CfcMbmrtnCZn0xEBM9gL+297RFQhtQ4HLxoR86ybZ5L0NnYHHqUnic6BTcdux7ro
         0RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788231617; x=1788836417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQXrMd6szNFFZL5zIyMougTL9fSbFjixTSxmkZ29BaQ=;
        b=VJoNXzOYCPvcxq2pa/p+N0b3WusiXyG49cP1gR7mVSkSiGBE87BCjNTfyryBZd7MI7
         y9PG1A36QirsEEjlUu5CTr8RO6lJAarBjJL0ZZ+9M7mTWy2WW1UdUYDqI5F8mLSDsQTA
         +BLmIcH+4r/vvysZjiWiDKRGPkBbJ8KFaZbmfkSNepmFTX7j71kHVe32ekPlaQf2d3bS
         kWwg1fmN79E2ChmdXq8ZNMDKeTSvPZG17wt7a0AMbenY8VHzMjeUjxSI4DP8XQ1emADg
         vZVyCkCy56r3MNdeWLv0/TMCxWvnl5bQn+WKtPb2+mtzNRlrEbbOtsfaXubYFp5iJ/ga
         618A==
X-Gm-Message-State: AFuF++nmwRZTE+tZLrkuJWtMy3JT2GkCGDk8pyMe2v3f13eL/rQkX9Rn
	oWArH12Hrcl4eX4KZwPdmBU0CIHnxaYz4GHXcB6aOQzrsipvxCR8A8WwYk2yL9x+cA6ptujlpji
	SqUhvfUEOWBSpgA==
X-Gm-Gg: AYBFou1q0XgYznu8eMvlHWOFg47DiUbt3C7WFQ+lG2Nfp0s1X2ajh3RnG1ou1k17r42
	HxWxrIoRDeKqGBvBA67lH1Q+A6+roL0N3atX2do3L6XWdDOBnX2VcTrk1WrSCuPcxB+kEEhUOrQ
	AFa6+2eY2s79r/SSeKwLVXtPckId4bZkTHftSpFqb6IsrK9rlRb7bzAH7bnpy1O4O05d9sbZ2OJ
	gC7h8VFytYgaDuM4mXPnseO/rp5O5rSNtw9+2IEuw92F19bN0hgtTpR9qCgWMKS0YXx7akAHxs9
	nVlYATM4y13iRHtwYK60ZF2k5GlJhfY1aMAgnZfB+Oyv5hu78UrBowLUsUtkDxaCXzRAfct0ffk
	bVw1zrDASq/35woKSCIN6IbMbMg81ZWg7g+jvCHMYRQr35IYFHyXOS36XM9jcd6Wxpra766xUsM
	/X9h5YhwqW7emXlUk9EXohbfXYGPcCfqeD+X0dROgmnsldovEL4i23Ul9P0O6Rj/Dewp3ahIzOQ
	t3CUZVaAWsdhYhhGoZOtpmV2JYtGA==
X-Received: by 2002:a17:90b:3b41:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39907cd4e1dmr5994892a91.6.1788231616458;
        Mon, 31 Aug 2026 20:00:16 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990baaeec3sm2909012a91.0.2026.08.31.20.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:00:15 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 1/1] ipv4: fib: bound automatic table ID allocation
Date: Tue,  1 Sep 2026 03:00:01 +0000
Message-ID: <7b6bd9bb1bf6bd43db18156f42b2d7f83789a673.1788223735.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788223735.git.zihanx@nebusec.ai>
References: <cover.1788223735.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_empty_table() probes every table ID from 1 until it finds a
free one.  IPv4 tables are stored in a 256-bucket hash table, so a
dense set of IDs makes each probe walk a growing hash chain while
RTNL is held.

Automatic table assignment ("ip rule ... table 0") is an IPv4-only
legacy path.  Bound the automatically allocated ID to 4096 so the
RTNL hold stays bounded, without changing lookups of explicitly
specified table IDs.

Fixes: b801f54917b7 ("[NET]: Increate RT_TABLE_MAX to 2^32")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Replace the bitmap-based O(N) rewrite with a 4096 cap on
    automatically allocated table IDs, as suggested by Ido Schimmel.
  - Point Fixes: at b801f54917b7, which first raised RT_TABLE_MAX
    to 2^32.  1af5a8c4a11c only switched the probe to a hash lookup
    while the scan was still capped at 255.
  - v1 Link: https://lore.kernel.org/all/0a00492a13038b268c1e0a219c138d07cfab92b3.1787982246.git.zihanx@nebusec.ai/

 net/ipv4/fib_rules.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 4edb0dca7be8..060501b376a8 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -214,6 +214,8 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	return 1;
 }
 
+#define FIB_MAX_AUTO_TABLE_ID  4096
+
 static struct fib_table *fib_empty_table(struct net *net)
 {
 	u32 id = 1;
@@ -222,7 +224,7 @@ static struct fib_table *fib_empty_table(struct net *net)
 		if (!fib_get_table(net, id))
 			return fib_new_table(net, id);
 
-		if (id++ == RT_TABLE_MAX)
+		if (id++ == FIB_MAX_AUTO_TABLE_ID)
 			break;
 	}
 	return NULL;
-- 
2.43.0

