Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585320ED;
	Fri, 11 Sep 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110881; cv=none; b=EKuMsF3uIr8lKEBSsX+rRERX3DEQ4oQEGTAIM4km5J9vQYhsdrOsmX18NJVV2aIoeQpUfvyPKysP+avO2QY26oWNVKcLw+yl/TZh2NGbgBaVNH5kDXX82H4NxCGjNX/HFL2ihJnqGojzA8vBOJKCa3F4bzL7kKcfeFqS2tAI9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110881; c=relaxed/simple;
	bh=qWY9hVgY6JF2D4bkyAnANcA5jzSF1wFhQrfBoEqih2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kDCM2uj4PG/vAtLvyvz0oyx9NZ4UVBXBHcSQSeh7TlM57V9FH/NddpMl32/E6nC3RuasIGROKhLLWNdqsbnM41utcKcZGlSUQONZLiBuF1Ch6onoE5zrOUQQr5WUlDKFFSwlinQeYhCuMAxbbME8YZFm5+7D+Ha68JBhpaT9jO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=M3eRAOk+; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="M3eRAOk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kG
	qOUqnfzYy7wMuZUB69+N3g6PnO7wVTQtDDeeJYN9g=; b=M3eRAOk+1fQ0NwW8HK
	pVQK+ESxOUt+kRSy+X0DsS56rjNliX8JfgAqG5wkgnbO5lmtc8Fr8wljjqdgmxpb
	qGo3D3b5h+HxYDca8WadB6U7Qb66te1lI4GX0AbUmYvp00Asf3OZGrqwi169Ag71
	ZUQT91vW86K+6bsMm2aG09cCY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXrzTqqaNqO7v6Aw--.29361S2;
	Fri, 11 Sep 2026 15:12:42 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tgraf@suug.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] net: fib_rules: add FRA_GOTO and FRA_L3MDEV to fib_rule_nlmsg_size()
Date: Fri, 11 Sep 2026 15:12:41 +0800
Message-Id: <20260911071241.2701784-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXrzTqqaNqO7v6Aw--.29361S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryDXw1xXFWUXr18Xry3XFb_yoW8WrWDp3
	4kuw1xJ3Z5ArW7ZrsF9FyruryrXF97Xa15J34vkay8trn8tr4xWFyxKFyjgay7Zr4kWr98
	Zr4DWr42grW8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uzv3nUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQoo-mqjqeonugAA3i

From: Linkui Xiao <xiaolinkui@kylinos.cn>

fib_nl_fill_rule() emits FRA_GOTO and FRA_L3MDEV, but
fib_rule_nlmsg_size() reserves room for neither. Its only caller,
notify_rule_change(), allocates the notification skb with that size and
treats a failure as a bug:

	/* -EMSGSIZE implies BUG in fib_rule_nlmsg_size() */

A rule that has both a goto target and l3mdev set needs 16 more bytes
than are reserved. nlmsg_new() rounds the allocation up through
SKB_DATA_ALIGN(), so the slack hides the mistake most of the time and
the bug stays latent, but the accounting is wrong and the notification
can still fail with -EMSGSIZE.

Reserve the two missing attributes, keeping the order used by
fib_nl_fill_rule().

Fixes: 0947c9fe56d9 ("[NET] fib_rules: goto rule action")
Fixes: 96c63fa7393d ("net: Add l3mdev rule")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/core/fib_rules.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 7df216c17c67..5e84bc740191 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1133,7 +1133,9 @@ static inline size_t fib_rule_nlmsg_size(struct fib_rules_ops *ops,
 			 + nla_total_size(4) /* FRA_SUPPRESS_IFGROUP */
 			 + nla_total_size(4) /* FRA_FWMARK */
 			 + nla_total_size(4) /* FRA_FWMASK */
+			 + nla_total_size(4) /* FRA_GOTO */
 			 + nla_total_size_64bit(8) /* FRA_TUN_ID */
+			 + nla_total_size(1) /* FRA_L3MDEV */
 			 + nla_total_size(sizeof(struct fib_kuid_range))
 			 + nla_total_size(1) /* FRA_PROTOCOL */
 			 + nla_total_size(1) /* FRA_IP_PROTO */
-- 
2.25.1

