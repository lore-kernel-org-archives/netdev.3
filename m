Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7C44C673;
	Fri, 11 Sep 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112372; cv=none; b=P3Ny1QsMS9yxKqSt58ANTUxX+Sj2+ru+/KxgYV8FmgyPvAoRqvQ1RGrt9DoE2a7GWqKmrvf3x4nnsMF9vdOss5mYtd608qvG1+PUHnRNsq80fH+ItGEBAvtp93lakdrgISB8AvPmIuN4dq6K0aiArmpF2opExavjY9sg1dXxix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112372; c=relaxed/simple;
	bh=jcaPddHxnis9Fy2+D7XUgY/tqCsFfXE/Z7fGiWyXyIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JN+19GdQsWCNhIt7Inz/22X0aW4oAAFgiIyclAdmIwMj01wdvWR8rUnjbtNTpbt7zUuXphLuxJmt/a+MunEYfxT4zURoRn2WV+WK/6dJrgs6Ojq5sZv+FhMpljXli0rGx2229LUCgLT3jOEjS8qb7hlLLVxuTIBgkSBu2nTHT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OEu4lUgy; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OEu4lUgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Th
	0q5rhxAnTzMnHFl9dU63J9nNJ1DUrtTNWxu2BhRYo=; b=OEu4lUgyNwpqiiNC68
	BoDiNyVAXBMdxjQdXnnkc2T72F1I114PMtwd30B8iqdyR4X6F497vMfL+0UfVBf2
	72ovG4oCd1y4fMtinOYE/2zgRjm8QNltxC3ghCzBJK8M01gdChZNzpGSugczc0z0
	X8dJOb5OBTOWM/3pS2en4zXLE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgA3FbkDsKNq3gzWHQ--.52159S2;
	Fri, 11 Sep 2026 15:38:43 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] ipv4: fib: annotate data-race around nh->nh_saddr
Date: Fri, 11 Sep 2026 15:37:58 +0800
Message-Id: <20260911073758.2714564-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgA3FbkDsKNq3gzWHQ--.52159S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW8Ary3tr1fCr48Jw4Dtwb_yoW8Wr47pr
	WxAasrta43Xay3GFs2qF48A3W8uw4Sya1Sgry2kwsI9wn8Xw13XFySgrna9a4qqFs7Xw45
	AF4kWw1UJrZ09a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYiiDUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQOvhmqjsAOCagAA3R

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
left bare. Annotate it as well so that the value cannot be torn or
reloaded while the per-nexthop scores are being computed.

Fixes: 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/ipv4/fib_semantics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 7a362f2e2c2b..885c6fae5232 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2204,7 +2204,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 		    (use_neigh && !fib_good_nh(nexthop_nh)))
 			continue;
 
-		if (saddr && nexthop_nh->nh_saddr == saddr)
+		if (saddr && READ_ONCE(nexthop_nh->nh_saddr) == saddr)
 			nh_score += 2;
 		if (hash <= nh_upper_bound)
 			nh_score++;
-- 
2.25.1

