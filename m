Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177438423A;
	Tue, 15 Sep 2026 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456549; cv=none; b=RZP52a40PDmZ7KyKyiF9wdwzn+yDkp49+xGUzosZHgp4otAG1VNKhe+0mPERA+XmWJP/14yUVdxE7A1lk/UXowePD9u6DWUII30pOIPY4XbTdDTZfWxUFm+5savBDG8YAXZ9dlOhuFdJIfFbiyIGi0MtAjqPCrfDyH6nRcZavRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456549; c=relaxed/simple;
	bh=dbDofAJzOD7kRcaOMCUP8xSI/nvZSHZ3HdUg41Vv+GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gjXzaKzypHlVZxsZY7XPLSpA80NLga8fNXkO13oAWZlDpkDYMlwhFtOuQfg9S1W/nafWwLmMkopXU2HhWNyHmopi8FtxuMnMgcST315cXkQS6jsC77wFHR5SDFtRUEeFkrHvMh2cNFTunyKXHRuMzwHMS4GFXqZcRSSXHYnacMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jbZUfewF; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jbZUfewF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mz
	w8wjlNPlBuD8FWvB+1DdecCrMSj+FthQONbcurIVE=; b=jbZUfewFMGt+X733RM
	eo1SelXIZ4scom2ERX0LqtplBAgOEV8z1+jcvCXKoR4MhobcUj5+P7jofsSgBJ/d
	NTznWVzEqJXkEpnXZnQFtSeQvWMA8nhz56l503IJf0qm7mkjOK3nF8l01eJSCedH
	/DBJCth+dSNPKBNk8JWZkCSzM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXF8J58KhqsRw2BQ--.17892S2;
	Tue, 15 Sep 2026 15:15:07 +0800 (CST)
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
Subject: [PATCH net v2] ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
Date: Tue, 15 Sep 2026 15:15:03 +0800
Message-Id: <20260915071503.465875-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXF8J58KhqsRw2BQ--.17892S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4kCF45Kr1ftrykur48WFg_yoW5Xr1fpF
	W8AasFq347Xay3AFs2qF47A3W8uw4Fya4F9ryIk390vwn8X343XFySg3sY9as8ZF4kXw43
	AF4kWr1UArWq9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpVb9UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRsf9Wqo8Hun6wAA3d

From: Linkui Xiao <xiaolinkui@kylinos.cn>

fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
source address with no lock held, while fib_info_update_nhc_saddr()
stores a new value from another CPU as soon as the preferred source
address of the egress device changes.

Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_genid
and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE()
in fib_result_prefsrc() after syzbot reported

	BUG: KCSAN: data-race in fib_select_path / fib_select_path

but it only covered that reader. fib_select_multipath(), reached from
fib_select_path(), is a second lockless reader of nh->nh_saddr and was
left bare.

Moreover, nh_saddr is only meaningful when nh_saddr_genid matches
dev_addr_genid, as established by 195374d89368. fib_select_multipath()
skips that validation, so it can score a nexthop using a stale source
address and skew the ECMP selection.

Annotate both reads with READ_ONCE() and add the missing genid check,
mirroring fib_result_prefsrc().

Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
V1: https://lore.kernel.org/all/CANn89iJhFL2LNQCXTANQAx8B1GVdGTJgrDwPTZOjbH8k1ygtsg@mail.gmail.com/

V2:
- point Fixes: at 32607a332cfe, which introduced the bare reader
- add the missing genid check as suggested by Eric Dumazet

 net/ipv4/fib_semantics.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 7a362f2e2c2b..e2bfc11aea09 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2184,6 +2184,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 	bool use_neigh;
 	int score = -1;
 	__be32 saddr;
+	int genid;
 
 	if (unlikely(res->fi->nh)) {
 		nexthop_path_fib_result(res, hash);
@@ -2192,6 +2193,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 
 	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
 	saddr = fl4 ? fl4->saddr : 0;
+	genid = saddr ? atomic_read(&net->ipv4.dev_addr_genid) : 0;
 
 	change_nexthops(fi) {
 		int nh_upper_bound, nh_score = 0;
@@ -2204,7 +2206,9 @@ void fib_select_multipath(struct fib_result *res, int hash,
 		    (use_neigh && !fib_good_nh(nexthop_nh)))
 			continue;
 
-		if (saddr && nexthop_nh->nh_saddr == saddr)
+		if (saddr &&
+		    READ_ONCE(nexthop_nh->nh_saddr_genid) == genid &&
+		    READ_ONCE(nexthop_nh->nh_saddr) == saddr)
 			nh_score += 2;
 		if (hash <= nh_upper_bound)
 			nh_score++;
-- 
2.25.1

