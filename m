Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02275370AFC;
	Wed,  2 Sep 2026 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333498; cv=none; b=mLd/o4SLA8TcYPjoZMWCvJ6Lss9gV5hNZVNZDfhw0Opw1cofo6J88gh05qJAFh8350QAnREOdryxBtVwriULL/9eX8aKhBXQbb0U9tP934i39q1OiOJGu+d4sz7QbXw1WUrYPccZeISfYh+6Dz5FC4EN6EF2gK0aWdqrz0ZAeT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333498; c=relaxed/simple;
	bh=/qcHkGUyQbDXWuX981T2ndPB7rRLiuINK3DuLELJ1d8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LabecfWUfMtHzx14fu9xu4P/CCkNFssOfxzdZ4bvQSd8dHkPXFIiEOHmew1loOkRS2Z0t7KmhczJ2MsV2Q7lE7pkZXtOIAnDdD52u1Ms2Wegq3vmFUnX/AeBRj6tjuxkZWlK26tVcqCewNJS4a/ynOww3nnGiUZZRJ9mGoNrcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TAiwdwhn; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TAiwdwhn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=v1lyVg2s92gRBWagJgLFFSVS9tBW1GPvEb/tTqd4fjU=;
	b=TAiwdwhnXfKEVAFbuGWLLA/dVJcPst7eSSlikNI7sFvuaKfCym0gt/AbFtS5XJY/KNs3nvm40
	GUj9Fs22cD/oleXkhn/w/VNvy76Yr37G/k4AJqI6MNh3HgTXVyOsFoCa/Gz/2Mb3jaoRgTyYCaR
	IoYL3Jktf7ROoEF+UWSLsEE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hZYgV2jP3zpSvd;
	Wed,  2 Sep 2026 15:06:46 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 037BC40579;
	Wed,  2 Sep 2026 15:18:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Sep
 2026 15:18:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <edumazet@google.com>, <kuniyu@google.com>, <pabeni@redhat.com>,
	<willemb@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3] soreuseport: publish num_socks with acquire/release
Date: Wed, 2 Sep 2026 15:19:00 +0800
Message-ID: <20260902071900.395567-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Replace the smp_wmb()/smp_rmb() barrier pair with
smp_store_release()/smp_load_acquire() on reuse->num_socks.
Writers publish socks[] updates via release before incrementing
or decrementing the count; readers acquire the count before
accessing socks[], ensuring they observe a consistent view.

The detach path gains proper ordering between the socks[] write and
the decrement, which was previously unordered.

No functional change intended.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Assisted-by: DeepSeek:DeepSeek-V3
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Split out from following patch set as Kuniyuki suggested.
Link: https://lore.kernel.org/all/20260901024234.135119-1-ruanjinjie@huawei.com/
---
 net/core/sock_reuseport.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 29948cb44b7d..6d3c511d1def 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -125,9 +125,8 @@ static void __reuseport_add_sock(struct sock *sk,
 				 struct sock_reuseport *reuse)
 {
 	reuse->socks[reuse->num_socks] = sk;
-	/* paired with smp_rmb() in reuseport_(select|migrate)_sock() */
-	smp_wmb();
-	reuse->num_socks++;
+	/* paired with smp_load_acquire() in reuseport_(select|migrate)_sock() */
+	smp_store_release(&reuse->num_socks, reuse->num_socks + 1);
 	reuseport_get_incoming_cpu(sk, reuse);
 }
 
@@ -140,7 +139,8 @@ static bool __reuseport_detach_sock(struct sock *sk,
 		return false;
 
 	reuse->socks[i] = reuse->socks[reuse->num_socks - 1];
-	reuse->num_socks--;
+	/* paired with smp_load_acquire() in reuseport_(select|migrate)_sock() */
+	smp_store_release(&reuse->num_socks, reuse->num_socks - 1);
 	reuseport_put_incoming_cpu(sk, reuse);
 
 	return true;
@@ -583,11 +583,9 @@ struct sock *reuseport_select_sock(struct sock *sk,
 		goto out;
 
 	prog = rcu_dereference(reuse->prog);
-	socks = READ_ONCE(reuse->num_socks);
+	/* paired with smp_store_release() in __reuseport_add_sock() */
+	socks = smp_load_acquire(&reuse->num_socks);
 	if (likely(socks)) {
-		/* paired with smp_wmb() in __reuseport_add_sock() */
-		smp_rmb();
-
 		if (!prog || !skb)
 			goto select_by_hash;
 
@@ -634,13 +632,11 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
 	if (!reuse)
 		goto out;
 
-	socks = READ_ONCE(reuse->num_socks);
+	/* paired with smp_store_release() in __reuseport_add_sock() */
+	socks = smp_load_acquire(&reuse->num_socks);
 	if (unlikely(!socks))
 		goto failure;
 
-	/* paired with smp_wmb() in __reuseport_add_sock() */
-	smp_rmb();
-
 	hash = migrating_sk->sk_hash;
 	prog = rcu_dereference(reuse->prog);
 	if (!prog || prog->expected_attach_type != BPF_SK_REUSEPORT_SELECT_OR_MIGRATE) {
-- 
2.34.1

