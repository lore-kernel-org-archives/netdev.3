Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13A37F33C;
	Wed, 16 Sep 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563255; cv=none; b=AVD2GuzvmTw9mhTQsN4mvYT1EAnhWblbcy1RrWPwBnw7ryiwO2n9Qn7OjBxcnP1NOdeUwiSDTdWv0XJ9M+TF9KLrnxkwTWKuIi0Ct+3uR+dcyQ0Dsz0Lb3pT7cXZO8+abMxft6nhy3xA50VIqIZa4OIOkufmJcXoSu9wYa+SZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563255; c=relaxed/simple;
	bh=zImIvHonBtT04hXaiapfE0jkw5hjkK2GJ2GVk2hMFSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHGeKwYmH6DzdA0SNcLjgfBm6doBQFPVN6ujiBE4mZchxI0JEzGXWPl7HGVLuft6pgNlhkTk5/yRicg4pLJoTcw0LArQu3pBFb1rZ6YfWves6pwlZzlRffzQuBb9OLH42pokN3XJxVyru6lciVDHBo0cXh2U8pYRSRc9h9OmZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=kZ7RNGwX; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kZ7RNGwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nN
	z6UvgI9RLeoxVnXq3+KTZCnkqsS4362EB+sFY/FgY=; b=kZ7RNGwXJZV3fCqM1j
	b/vepziZA+Nb41g7m/di8x3lB9aLnE0NottjVhYaMg7PliKG33hmLXKrIesHj3Gx
	5+aY1d6JZTpwcAXJk2nDD4VsSOdnzMYYex8dIeTVHq5T5RAQZDMuSAhpE0HMJ+KO
	f9mZ7yvytkZClxCzMF6aak3Ko=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgAXf8s+kapqLnIfHw--.57650S2;
	Wed, 16 Sep 2026 20:53:18 +0800 (CST)
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
Subject: [PATCH net v3] ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
Date: Wed, 16 Sep 2026 20:53:16 +0800
Message-Id: <20260916125316.988044-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgAXf8s+kapqLnIfHw--.57650S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4kCF4UAr13tw4UJr45GFg_yoWrJw4rpF
	W8Jasrt347XayaqrsxtFW7X3WF9w4rtFWS9r92kws09wn8Xr13JF9ag3sY9as8XF4kXw42
	yFs8Wr1UArZ0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqR64j2qqkT5gywAA3E

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
dev_addr_genid, as established by commit 436c3b66ec98 ("ipv4: Invalidate
nexthop cache nh_saddr more correctly."). fib_select_multipath()
skips that validation, so it can score a nexthop using a stale source
address and skew the ECMP selection.

Annotate both reads with READ_ONCE() and refresh the cached source
address via fib_info_update_nhc_saddr() when the genid does not match,
mirroring fib_result_prefsrc().

Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
V1: https://lore.kernel.org/all/CANn89iJhFL2LNQCXTANQAx8B1GVdGTJgrDwPTZOjbH8k1ygtsg@mail.gmail.com/

V2:
- point Fixes: at 32607a332cfe, which introduced the bare reader
- add the missing genid check as suggested by Eric Dumazet

V3:
- correct the commit reference to 436c3b66ec98, which established the
  rule that nh_saddr is only valid when nh_saddr_genid matches
  dev_addr_genid (195374d89368 only added the READ_ONCE()/WRITE_ONCE()
  annotations)
- refresh the cached source address via fib_info_update_nhc_saddr()
  when the genid does not match, instead of skipping the comparison,
  to avoid silently downgrading ECMP selection to hash-based for a
  long stale period (suggested by Ido Schimmel)

 net/ipv4/fib_semantics.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 7a362f2e2c2b..5c9021ea3a79 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2176,6 +2176,15 @@ static bool fib_good_nh(const struct fib_nh *nh)
 	return !!(state & NUD_VALID);
 }
 
+static __be32 fib_nh_saddr(struct net *net, const struct fib_info *fi,
+			   struct fib_nh *nh, int genid)
+{
+	if (READ_ONCE(nh->nh_saddr_genid) == genid)
+		return READ_ONCE(nh->nh_saddr);
+
+	return fib_info_update_nhc_saddr(net, &nh->nh_common, fi->fib_scope);
+}
+
 void fib_select_multipath(struct fib_result *res, int hash,
 			  const struct flowi4 *fl4)
 {
@@ -2184,6 +2193,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 	bool use_neigh;
 	int score = -1;
 	__be32 saddr;
+	int genid;
 
 	if (unlikely(res->fi->nh)) {
 		nexthop_path_fib_result(res, hash);
@@ -2192,6 +2202,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 
 	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
 	saddr = fl4 ? fl4->saddr : 0;
+	genid = saddr ? atomic_read(&net->ipv4.dev_addr_genid) : 0;
 
 	change_nexthops(fi) {
 		int nh_upper_bound, nh_score = 0;
@@ -2204,7 +2215,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 		    (use_neigh && !fib_good_nh(nexthop_nh)))
 			continue;
 
-		if (saddr && nexthop_nh->nh_saddr == saddr)
+		if (saddr && fib_nh_saddr(net, fi, nexthop_nh, genid) == saddr)
 			nh_score += 2;
 		if (hash <= nh_upper_bound)
 			nh_score++;
-- 
2.25.1

