Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A653CC300
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878527; cv=none; b=sYHeVaGllRPqqhQCoFHGnEkqb3iSWhRjB1zlBVy1dryFt8kHHSYNDBsUsVNR1f6gU9o5M8RLXG9w3NTJ4SuX+/XNm9CynPrh0NSNUjbdOMYSBh43EMvf26wOFV1k4b078QUB8KiKrVIqRBJ4F5O/aJwbTlhSn7HFWqnjNWcCCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878527; c=relaxed/simple;
	bh=2zLm7RlnurqXvRbrccT+ycD8kdQyyLk1WfUg98jqGuU=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=s0KE0EGwQWLzBpWdhzDmIIJa9Tt24tu7xM9oOy9BYZeYdTI2iGLl3//8MKfhu6vudL/I0wxZ32mosxNX7Y7mMeCtLNAeuIkPlFIgDAaajrk+tBAMtkQg3/YieK91h7DdASq9ClRIQ53BWouYnylhzodvkYGpMT9yF/wrfSHEQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67GB8LA7074979;
	Sun, 16 Aug 2026 20:08:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67GB8KKf074976
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 16 Aug 2026 20:08:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <34f44e8a-9fa4-4cb3-822e-5db54fb6df44@I-love.SAKURA.ne.jp>
Date: Sun, 16 Aug 2026 20:08:17 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
        Network Development <netdev@vger.kernel.org>
Subject: [PATCH] net: make sure final 'struct net' free in net_complete_free()
 is always deferred
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp

Since there is no serialization mechanism (e.g. the RTNL lock) between
llist_add() in net_complete_free() and llist_del_all() in
net_complete_free(), it is possible that net_complete_free() finds 'struct
net' as soon as net_complete_free() added it to the defer_free_list.

Fixes: 0f6ede9fbc74 ("net: defer final 'struct net' free in netns dismantle")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/core/net_namespace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d9dafe24f57e..6e9a0c29a9a0 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -514,14 +514,10 @@ static struct net *net_alloc(void)
 
 static LLIST_HEAD(defer_free_list);
 
-static void net_complete_free(void)
+static void net_complete_free(struct llist_node *kill_list)
 {
-	struct llist_node *kill_list;
 	struct net *net, *next;
 
-	/* Get the list of namespaces to free from last round. */
-	kill_list = llist_del_all(&defer_free_list);
-
 	llist_for_each_entry_safe(net, next, kill_list, defer_free_list)
 		kmem_cache_free(net_cachep, net);
 
@@ -703,12 +699,15 @@ static void cleanup_net(struct work_struct *work)
 
 	up_read(&pernet_ops_rwsem);
 
+	/* Get the list of namespaces to free from last round. */
+	net_kill_list = llist_del_all(&defer_free_list);
+
 	/* Ensure there are no outstanding rcu callbacks using this
 	 * network namespace.
 	 */
 	rcu_barrier();
 
-	net_complete_free();
+	net_complete_free(net_kill_list);
 
 	/* Finally it is safe to free my network namespace structure */
 	list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
-- 
2.55.0

