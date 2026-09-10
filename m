Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69D3C0A18;
	Thu, 10 Sep 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032941; cv=none; b=f6ClgYMaps8XOhtzsDzaAamgJ5NoF+YtV5BGikFo1p2uwhBJ8GTEQnOXhenP/4mghrzWE5vvTxzYHVvmv9qI6/xiyXbxjHyZuasLz0cGd5wDQYEInu4b9Zl4lTFzqj92IrUz7w+pS223I9pjp2jf0fVeG76+k6bXoAybjz3nP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032941; c=relaxed/simple;
	bh=sj2RVM5/qDNCmGF9d4A259TOLFfKQW+GjDaivixoBc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tlopcwFvJdMneENjYY7P0wlr7nEsYvEeltFrAN5QxvBpc0rvQ5gaTHN8imfsLrfyLkAkENpMsytamASmSSVXD9uNW42B7FSzZpg1jz2AN3atlLTRRNyHJwWJviM4PW86dTCtWSp6E7eRqxpLFUh5EGeCetQWVHWoImnRlRlwWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=p54wWvEU; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="p54wWvEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gy
	p362HRExMhdcXl/GqCxGqXMA9jysmN4m9GBjlUN6I=; b=p54wWvEUWKE2vCcrId
	iUhaoc8UJPRtj/7Amt25awceYFYlKtMvsBwyqOOxekWjnKK85DBFIW1yA0rn8Rh/
	ypQD6B0eiPsSuPtxb+e6jyagwCblUGZ0X6ftQnCEZn4yOjEuh+PIuuBr7wDzEkb3
	Een2P5b+ZA5buwE7O4LYcEi1c=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDHdmXCeaJqP05DHQ--.37279S2;
	Thu, 10 Sep 2026 17:34:58 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net] ipmr, ip6mr: annotate data-races in vif_seq_show()
Date: Thu, 10 Sep 2026 17:34:52 +0800
Message-Id: <20260910093452.2070079-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgDHdmXCeaJqP05DHQ--.37279S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17KF4rZrykWw45Wr47twb_yoW5JF1fpF
	Z7t397JwsrKrnrXFnrta18Zr18Xay7CF429rnF9r95KF1DJ39xWa4YkayaqFykAr48ta1Y
	yFyqga47Aw18CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U73kNUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqALRqGqiecJubAAA3i

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ipmr_vif_seq_show() and ip6mr_vif_seq_show() read vif->bytes_in,
vif->pkt_in, vif->bytes_out and vif->pkt_out with only rcu_read_lock()
held: since commit b96ef16d2f83 ("ipmr: convert /proc handlers to
rcu_read_lock()") both seq_start helpers are annotated __acquires(RCU)
and no longer take mrt_lock.

Those counters are updated from softirq context and the writers already
use WRITE_ONCE(): ipmr_prepare_xmit() and ip_mr_forward() on the IPv4
side, ip6mr_prepare_xmit() and ip6_mr_forward() on the IPv6 side. The
other lockless readers use READ_ONCE() as well - ipmr_ioctl(),
ipmr_compat_ioctl(), ipmr_fill_vif(), ip6mr_ioctl() and
ip6mr_compat_ioctl().

The two vif_seq_show() helpers are the only remaining bare readers, so
KCSAN flags them and the compiler is free to tear or reload the values
while the /proc/net/ip_mr_vif and /proc/net/ip6_mr_vif lines are being
formatted. Annotate them like the other readers; these are plain
statistics, no locking is needed.

Fixes: b96ef16d2f83 ("ipmr: convert /proc handlers to rcu_read_lock()")
Assisted-by: Qwen:Qwen3.8-max
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/ipv4/ipmr.c  | 5 +++--
 net/ipv6/ip6mr.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e5f2b1c6150d..36d1b0410a08 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3178,8 +3178,9 @@ static int ipmr_vif_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq,
 			   "%2td %-10s %8ld %7ld  %8ld %7ld %05X %08X %08X\n",
 			   vif - mrt->vif_table,
-			   name, vif->bytes_in, vif->pkt_in,
-			   vif->bytes_out, vif->pkt_out,
+			   name,
+			   READ_ONCE(vif->bytes_in), READ_ONCE(vif->pkt_in),
+			   READ_ONCE(vif->bytes_out), READ_ONCE(vif->pkt_out),
 			   vif->flags, vif->local, vif->remote);
 	}
 	return 0;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3f2ed9b77deb..7a3c795ec68b 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -485,8 +485,9 @@ static int ip6mr_vif_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq,
 			   "%2td %-10s %8ld %7ld  %8ld %7ld %05X\n",
 			   vif - mrt->vif_table,
-			   name, vif->bytes_in, vif->pkt_in,
-			   vif->bytes_out, vif->pkt_out,
+			   name,
+			   READ_ONCE(vif->bytes_in), READ_ONCE(vif->pkt_in),
+			   READ_ONCE(vif->bytes_out), READ_ONCE(vif->pkt_out),
 			   vif->flags);
 	}
 	return 0;
-- 
2.25.1

