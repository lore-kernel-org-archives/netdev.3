Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65822493633;
	Sat, 22 Aug 2026 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787386733; cv=none; b=mHbOiJAEAylsqUm6f+dw/XCzt9xBVrL727+iyc4G7ODsUVE4Z3t/+MlAWwc4Rf6OMC1Vuc3SsGYiU3kDC/EgSaDJ9qHbt1E5q99nbHUb6LZu7XpZaGNCBRkfxnDXCzahN35HSqJVzM3xHxyz1XOzkMcfzXRHe00IcUwjd5clun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787386733; c=relaxed/simple;
	bh=T1oMhPI7zsbVSTWjx9HjAfEFXZ9hM3irZws/OAyiC5k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YKTsUdjPLpjor6K9d49q0Fg0EfnyJ8bePlLoc31M/LsqKKQZ11P0H6yaJD/NMTmuPNqCBfD1qXW3Brs6jDO9kntv709GSAPAp1Tk0Dhb5vlY4y9vX9Z82BlXFeQzC5p6vIZ6YmMR1/oFCELPddW1vHE8+CLkfH4RUUZ2SvRXabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67M8IWnh093300;
	Sat, 22 Aug 2026 17:18:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67M8IWkt093297
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 22 Aug 2026 17:18:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c182cf90-1ed7-435b-88f7-9f00e88a0487@I-love.SAKURA.ne.jp>
Date: Sat, 22 Aug 2026 17:18:31 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH net] net: fix a resource leak in copy_net_ns() error handling
 path
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp

Currently, preinit_net() does two things:

  (1) call ns_common_init() which might fail
  (2) initialize resources which does not fail

However, preinit_net() is returning early when (1) fails, and copy_net_ns()
is jumping to the dec_ucounts: label. As a result, resources allocated by
net_alloc() are leaking. We need to call key_remove_domain() and
net_passive_dec() in order to release resources allocated by net_alloc().

We cannot simply jump to the put_userns: label when preinit_net() failed,
for (2) is not yet done. But we can reorder (1) and (2), for there is no
dependency between (1) and (2). Therefore, this patch decouples (1) from
preinit_net() and changes preinit_net() back to a void function, and calls
ns_common_init() after preinit_net() succeeded. Then, we can jump to
immediately after ns_common_free() of the put_userns: label.

Reported-by: sashiko (no mail address)
Closes: https://sashiko.dev/#/patchset/af7dabf3-d0d7-46dc-a878-e1715b3c9ac6%40I-love.SAKURA.ne.jp
Fixes: 08027f6b790b ("net: use ns_common_init()")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/core/net_namespace.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 9166f467293e..da5f881fbd3b 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -400,14 +400,8 @@ static __net_init void preinit_net_sysctl(struct net *net)
 }
 
 /* init code that must occur even if setup_net() is not called. */
-static __net_init int preinit_net(struct net *net, struct user_namespace *user_ns)
+static __net_init void preinit_net(struct net *net, struct user_namespace *user_ns)
 {
-	int ret;
-
-	ret = ns_common_init(net);
-	if (ret)
-		return ret;
-
 	refcount_set(&net->passive, 1);
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt");
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt");
@@ -431,7 +425,6 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	INIT_LIST_HEAD(&net->ptype_all);
 	INIT_LIST_HEAD(&net->ptype_specific);
 	preinit_net_sysctl(net);
-	return 0;
 }
 
 /*
@@ -574,12 +567,14 @@ struct net *copy_net_ns(u64 flags,
 		goto dec_ucounts;
 	}
 
-	rv = preinit_net(net, user_ns);
-	if (rv < 0)
-		goto dec_ucounts;
+	preinit_net(net, user_ns);
 	net->ucounts = ucounts;
 	get_user_ns(user_ns);
 
+	rv = ns_common_init(net);
+	if (rv)
+		goto put_userns_no_common;
+
 	rv = down_read_killable(&pernet_ops_rwsem);
 	if (rv < 0)
 		goto put_userns;
@@ -591,6 +586,7 @@ struct net *copy_net_ns(u64 flags,
 	if (rv < 0) {
 put_userns:
 		ns_common_free(net);
+put_userns_no_common:
 #ifdef CONFIG_KEYS
 		key_remove_domain(net->key_domain);
 #endif
@@ -1293,7 +1289,8 @@ void __init net_ns_init(void)
 	 * This currently cannot fail as the initial network namespace
 	 * has a static inode number.
 	 */
-	if (preinit_net(&init_net, &init_user_ns))
+	preinit_net(&init_net, &init_user_ns);
+	if (ns_common_init(&init_net))
 		panic("Could not preinitialize the initial network namespace");
 
 	down_write(&pernet_ops_rwsem);
-- 
2.52.0

