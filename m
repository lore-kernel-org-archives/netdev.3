Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F446983C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516381; cv=none; b=Idh/b8YsI6I3keGUmDMZM2LgHtuoc4MyLsry42NAFHZVNK1c+93ccznbhwUI7agv1mZsw3Q0FdsU6Lo6x2fruBVc7LcNC9M6cV4S4PLZKsDG5g3pzScMT4pSzoZgt8T94DJVymWOpUIhIjbdoBeh1zX7pXOUCsdQf4sJ6HPXSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516381; c=relaxed/simple;
	bh=f2zOfMnqELIQPseQWa4Mp0Gj2VaEWZVceSP2ejyEvCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PUal3gTt9u/t+fPNKucrUhg75n4tFJefGjIQYxlyzxQGp2WUxlhq6o1UmvPtZmPawtNHIb1cq5GX5SRUaznSNICqtH60KWMSQLuMDu+8vIIJugh/rndjAs8EA/LTFMP9AuRqHJKE3LUYiQKyFG6C7Viqh09+HVzTaBB3+JSAA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOC2i0ke; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOC2i0ke"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d004f13426so14469455ad.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785516379; x=1786121179; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDqnuGgop73/EbhNRZcxOeqTjCwMcpmjbPpLXmvFWf0=;
        b=IOC2i0kePxPLDIdzQHQSWZSRdVgG4pH6XLTO7Nt0maASjY3WBIA1u8V2nLeenD8ETa
         lXEUNJ+mPqUGtWwqB7+CjvQLZ6WrXm6iwwo/+zpn8Xp7/+URxvp6kp5ZO0/1NNldgOAO
         BxO3GLEj1rGwP6C8AvwcVnQ2hgZX/+K5WIKc6YClUZvji0RE0lfDEjojRPM9XwzI8BO0
         GPWirN98cw3Wg9CJfC3f5Q4zfmJTMNWoOKb/YNhpNpVZMcKHsf/vnTX3U3Ym7egOJ0tS
         v8VhiABxbEgo5LDcfXtfi2tuhSkeNvBY2XajUEyBR40r6FWucjHCfn/Hwml75qYf4fq/
         RLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516379; x=1786121179;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IDqnuGgop73/EbhNRZcxOeqTjCwMcpmjbPpLXmvFWf0=;
        b=Its/579tIriaQ2qG6JsU67J38xNTRzcFNpdLv/Ca2VBh4P6f29aUdTvDgG7vY/2bls
         HqJToPP7oQr2jX9JLbcqpRCFmYR/IwQHL0Xc26F/S97tYYk0AS7htamdHVuTMi23Rqyq
         QYUTcQycHJ8JwV5LXfa3rc7V8IbXKaI9ZCe0Elo3nMK3qnMjDpPfFdoDNFkLJHpE6VL/
         jXYFcPZylNxoTpJWqwTfOAzBSKOdzj4ey3YpceCf+qGJPAi/v4Q4ionsNF59E0qhEs0a
         BmEjN2f0tyCMiGLf0eFakajHasgjw8PSSVNYQC7x2a1fJbaD40zGyy9HyYzGS72KlC78
         T8UQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyqEdNVJoPEBlB1C4L4CLJ1CuFLy2+nFFutxEkvJjjIkCx3MCGNgC0C54NOmI8xxP+kYWuIBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcbRbGJejWzVeRLBtLEu0e+B4g1Nn6WrSuuP93XBHnw0yXUdH
	0uGCh0a0h4lmFN/fCdCPpRz+XzmuGyp3oRHcpGA6w6/NvMdBvsdDLRz2nGLUH/FmwMhAYqyYT57
	eVj+0dg==
X-Received: from plho2.prod.google.com ([2002:a17:903:23c2:b0:2ca:d6eb:2a36])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c1:b0:2c9:d298:6c06
 with SMTP id d9443c01a7336-2d0523fa272mr6745615ad.25.1785516379008; Fri, 31
 Jul 2026 09:46:19 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:45:55 +0000
In-Reply-To: <20260731164612.2148830-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731164612.2148830-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731164612.2148830-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/3] geneve: Support per-netns netdev unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

geneve_exit_rtnl_net() iterates geneve devices whose sockets
are in the dying netns and queues them for destruction.

So the devices may reside in different netns.

Let's use unregister_netdevice_queue_net() to support per-netns
device unregistration.

list_del() is changed to list_del_init() to avoid queueing the
same device twice.

Even after geneve_exit_rtnl_net() queues a cross-netns geneve
device, geneve_dellink() can be called concurrently for it.
In such a case, __rtnl_net_unlock() will perform the unregistration.

Note that geneve uses register_pernet_subsys() instead of _device(),
so default_device_exit_batch() guarantees that the async per-netns
works are flushed before ->exit().

Tested:

1. Create geneve device across two netns.

  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add geneve0 link-netns ns2 type geneve external

2. Run bpftrace to check that geneve_uninit() is called between
   ->exit_rtnl() and ->exit().

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:geneve_uninit {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }
  kprobe:geneve_exit_rtnl_net,
  kprobe:geneve_exit_net {
      printf("PID: %d%s\n", pid, kstack());
  }'

3. Remove the netns where the geneve socket resides

  # ip netns del ns2

Now, we can see geneve0 is unregistered by per-netns work
instead of cleanup_net() and it finishes before ->exit() to
avoid WARN_ON_ONCE(!list_empty(&gn->sock_list)) there.

  PID: 571
          geneve_exit_rtnl_net+5
          ops_undo_list+702
          cleanup_net+1122
          process_scheduled_works+2538
  ...
  PID: 1047 | DEV: geneve0
          geneve_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538
  ...
  PID: 571
          geneve_exit_net+5
          ops_undo_list+1064
          cleanup_net+1122
          process_scheduled_works+2538
  ...

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index f456a85dca77..a6a8978e3b81 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2502,12 +2502,13 @@ static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
 	return err;
 }
 
-static void __geneve_dellink(struct net_device *dev, struct list_head *head)
+static void __geneve_dellink(struct net *net, struct net_device *dev,
+			     struct list_head *head)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
 
-	list_del(&geneve->next);
-	unregister_netdevice_queue(dev, head);
+	list_del_init(&geneve->next);
+	unregister_netdevice_queue_net(net, dev, head);
 }
 
 static void geneve_dellink(struct net_device *dev, struct list_head *head)
@@ -2518,7 +2519,8 @@ static void geneve_dellink(struct net_device *dev, struct list_head *head)
 	gn = net_generic(geneve->net, geneve_net_id);
 
 	mutex_lock(&gn->lock);
-	__geneve_dellink(dev, head);
+	if (!list_empty(&geneve->next))
+		__geneve_dellink(dev_net(dev), dev, head);
 	mutex_unlock(&gn->lock);
 }
 
@@ -2754,7 +2756,7 @@ static void __net_exit geneve_exit_rtnl_net(struct net *net,
 	mutex_lock(&gn->lock);
 
 	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
-		__geneve_dellink(geneve->dev, dev_to_kill);
+		__geneve_dellink(net, geneve->dev, dev_to_kill);
 
 	mutex_unlock(&gn->lock);
 }
-- 
2.55.0.571.g244d577d93-goog

