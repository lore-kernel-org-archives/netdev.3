Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228BC4734CC
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664115; cv=none; b=JzJYdtnwc/pTgKIf956qOo+6irRK0rvMtPF56KQ1rYdXt9Mc/N7nkMphpSrHe9Z9nUtHNsUXwuZSA8qX7SFK3J1p/cpUKcRocUAzUBVd/mZmgi8JtpFjZgRuLEt+UlgQ2Ty1DnH1o8gRiH7+JEpQAGf0QRd0yT7XIlbIc2ZI9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664115; c=relaxed/simple;
	bh=kiobPkwGozes30ZahVyQZIjm/97Bqbne03JNSWW3aLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsFV4SWbxT6z/aDUtAhX3Sb07Yfu0g8SAY/iv25EsjxC0OXEyN/zLauzxoS9d7cOTmawpUotnvIGIPGC0hLdtpLiM3satig4mCSwKJ1YlPa9M8icczK/j9odK4SPF9zr//DXSbsxHG4G68Y43ZmbERinchBvetl2Rh9lOFyzYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67PDLM1x029125;
	Tue, 25 Aug 2026 22:21:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67PDLMfP029122
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 25 Aug 2026 22:21:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <96f33d10-558f-49d5-a95d-ec1e29feea0b@I-love.SAKURA.ne.jp>
Date: Tue, 25 Aug 2026 22:21:20 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: make sure final 'struct net' free in
 net_complete_free() is always deferred
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>
References: <34f44e8a-9fa4-4cb3-822e-5db54fb6df44@I-love.SAKURA.ne.jp>
 <CAAVpQUC672LJN_8KQ5BzadS26FnUrh4ayjyu-n5x=W7U69u7fA@mail.gmail.com>
 <CANn89iJd-s+mocDFXgt2rtFQVBGNJ7xEy=tUMKa5Da+brptXzA@mail.gmail.com>
 <7d6d4139-4389-4083-8569-ab2b7265ce3c@I-love.SAKURA.ne.jp>
 <CANn89iKwWFwRxEDvw7eUPD-tKL_dvYrZeye_3be37q6qYzQ15w@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CANn89iKwWFwRxEDvw7eUPD-tKL_dvYrZeye_3be37q6qYzQ15w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav114.rs.sakura.ne.jp

On 2026/08/17 23:00, Eric Dumazet wrote:
> However, the observation regarding the copy_net_ns() error path is valid:
> because failed namespaces never go through __put_net(), net_cleanup_work
> is not queued, so a failed net structure can stay on defer_free_list until
> another namespace is destroyed.
> 
> The proper fix for that benign issue would be to directly free the
> struct net in the
> copy_net_ns() error path (since it was never active and does not need deferred
> freeing), rather than modifying cleanup_net().

Now that "net: fix a resource leak in copy_net_ns() error handling path"
handed over to net_passive_dec() (instead of calling kmem_cache_free() from
copy_net_ns()), it is time to fix the last problem which sashiko repeatedly mentions
due to commit 0f6ede9fbc74 ("net: defer final 'struct net' free in netns dismantle").

My understanding is that we need to wait for RCU grace period before
calling kmem_cache_free(). Then, I think we can simplify like shown below (either
pattern A or pattern B). Which pattern do you like?



Pattern A:

 net/core/net_namespace.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index da5f881fbd3b..421398149bc2 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -511,19 +511,20 @@ static struct net *net_alloc(void)
 
 static LLIST_HEAD(defer_free_list);
 
-static void net_complete_free(void)
+static void net_complete_free(struct work_struct *work)
 {
 	struct llist_node *kill_list;
 	struct net *net, *next;
 
-	/* Get the list of namespaces to free from last round. */
 	kill_list = llist_del_all(&defer_free_list);
-
+	/* Wait for an extra rcu_barrier() before final free. */
+	rcu_barrier();
 	llist_for_each_entry_safe(net, next, kill_list, defer_free_list)
 		kmem_cache_free(net_cachep, net);
-
 }
 
+static DECLARE_WORK(net_complete_free_work, net_complete_free);
+
 void net_passive_dec(struct net *net)
 {
 	if (refcount_dec_and_test(&net->passive)) {
@@ -536,8 +537,8 @@ void net_passive_dec(struct net *net)
 			ref_tracker_dir_exit(&net->refcnt_tracker);
 #endif
 
-		/* Wait for an extra rcu_barrier() before final free. */
 		llist_add(&net->defer_free_list, &defer_free_list);
+		queue_work(system_long_wq, &net_complete_free_work);
 	}
 }
 
@@ -712,8 +713,6 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	rcu_barrier();
 
-	net_complete_free();
-
 	/* Finally it is safe to free my network namespace structure */
 	list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
 		list_del_init(&net->exit_list);
-- 



Pattern B:

 include/net/net_namespace.h |  2 +-
 net/core/net_namespace.c    | 18 ++++--------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index e5ee673b9fcf..9419a198faf7 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -81,7 +81,7 @@ struct net {
 						 * or to unregister pernet ops
 						 * (pernet_ops_rwsem write locked).
 						 */
-	struct llist_node	defer_free_list;
+	struct rcu_head		complete_free_rcu;
 	struct llist_node	cleanup_list;	/* namespaces on death row */
 
 	struct list_head ptype_all;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index da5f881fbd3b..2ce0f281922d 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -509,18 +509,11 @@ static struct net *net_alloc(void)
 	goto out;
 }
 
-static LLIST_HEAD(defer_free_list);
-
-static void net_complete_free(void)
+static void net_complete_free(struct rcu_head *rcu)
 {
-	struct llist_node *kill_list;
-	struct net *net, *next;
-
-	/* Get the list of namespaces to free from last round. */
-	kill_list = llist_del_all(&defer_free_list);
+	struct net *net = container_of(rcu, struct net, complete_free_rcu);
 
-	llist_for_each_entry_safe(net, next, kill_list, defer_free_list)
-		kmem_cache_free(net_cachep, net);
+	kmem_cache_free(net_cachep, net);
 
 }
 
@@ -536,8 +529,7 @@ void net_passive_dec(struct net *net)
 			ref_tracker_dir_exit(&net->refcnt_tracker);
 #endif
 
-		/* Wait for an extra rcu_barrier() before final free. */
-		llist_add(&net->defer_free_list, &defer_free_list);
+		call_rcu(&net->complete_free_rcu, net_complete_free);
 	}
 }
 
@@ -712,8 +704,6 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	rcu_barrier();
 
-	net_complete_free();
-
 	/* Finally it is safe to free my network namespace structure */
 	list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
 		list_del_init(&net->exit_list);
-- 
