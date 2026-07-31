Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD05361979
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537851; cv=none; b=JZIVw6W3ym1tWp4/ndxZirJJTHzH65sMkQGibKRbvMVMNXdseo66Hvt90mr6e8St0IHuvbLldahVXjXjPPKS6zEP3rVsU6sZUyzZK1NEdzTwG/+iAaDZSRLE4LeicLdqKIh7P/1Acou74SHbASNeoPT/sDiGjoVBh7jaBYoFrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537851; c=relaxed/simple;
	bh=0Q79DSoepNM/zz+IMjHLBhfph2a0w4J1oNLwbFbDKzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bMih7NqyAYYeBaBInyVnjE8cE3crIP5x0yVAkdZi6UtTDZIDKVyGTdrN4od52Ay0Fd5x+FghBjEjM0Zzu4w+8dJtiyqAHv70NOftzHExQc/evq5yFMhqgXjB15E6X9IvDy1+fZZIpA/bKUL13ebEZcwreckR7ZCxiF0XYj5Laow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/4qnf5n; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/4qnf5n"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso1723238a91.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785537850; x=1786142650; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMmVeD64D+jD9h8CXETecn/G4AMshL7nnqP6GuU2Cek=;
        b=i/4qnf5niRQlnbJ7ZC8A+sA5NCU0UpyYNZico2BBFPi6N+NW7HSsurPCQgHAZq41rL
         tuDA6C567jBpfb60Z4nEvg48Fjy3kevA5Ec8gEomDvfnUKkEq1zjyAgU5yBXqKBEBdoD
         ExCnCAeJcLor+hNbrYgdMlvKbu4pwprFrgvOG0OnG32/KRTW6+21MjignnAqLhpec4X7
         ld2UrsCrHnKN4GE3XtxKe9VLzQQLjkv1RGJL/WAWWpvp0/P+jOcdQdlJsSffsm410kwX
         ygxA5Halh3xiyjgsDsmGJ8ExUREcDjiWpNFGOlQ1wKr9ksjamif8u2OXljA0DXgRo63l
         loww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785537850; x=1786142650;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QMmVeD64D+jD9h8CXETecn/G4AMshL7nnqP6GuU2Cek=;
        b=MNOeLEvM2+l8+1Mi2+Le0e5USU3u0m7RF6mzBmlWmm180TnO344myH2xAwfz6ENFx1
         SyYsDrq5qMphw/FKy7OSp2sDpII7ujQjw3J34kQJapNGxt7ObFuggC86p8o2PbnfgiaP
         vgTKrD7Qc+vUy1OKBD0lf5vsBR44/Kh2I5XgLNE6p7dMl5ybo8qtYo5iOOgK4eXm1FNg
         QLoCRwbVJQf6AhNIyYQ5tdSK7Tc0O8TwyqoUxARRHPWLRN/ljGjWO1D3CxJeSV73y0bQ
         PUj+i/ymeopBos9wmPlk7QAP7c1257DBU+NVx0aC8+oz9rijsqx1fxLHhp5i2/z9Mx5k
         ggFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTmwG+cdWGABURXCfMXEHOJoR3aIgdYm4qYeQLxkrqj15YZKFvZCYeGixbKiw1YldQVutUSnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7ghWqvAdbRVd4uEMRXEsFWjQE/hUhKqpf2OIeBWpfMsJfmXD
	wcZ5y4r+i6HgZPaQqBikHXB6ui8Dk9DejSxcSdGtYMZFzEJIXJTTOPIg+vGxl/qWAbJ95146+MW
	eE74aWg==
X-Received: from pjbee8.prod.google.com ([2002:a17:90a:fc48:b0:380:6618:e058])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c0e:b0:38d:c74d:29c5
 with SMTP id 98e67ed59e1d1-38fbc495711mr1268379a91.19.1785537849300; Fri, 31
 Jul 2026 15:44:09 -0700 (PDT)
Date: Fri, 31 Jul 2026 22:43:41 +0000
In-Reply-To: <20260731224406.2444121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731224406.2444121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731224406.2444121-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/2] pfcp: Support per-netns netdev unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pfcp_net_exit_rtnl() iterates pfcp devices whose sockets
are in the dying netns and queues them for destruction.

So the devices may reside in different netns.

Let's use unregister_netdevice_queue_net() to support per-netns
device unregistration.

list_del() is changed to list_del_init() to avoid queueing the
same device twice.

Even after pfcp_net_exit_rtnl() queues a cross-netns pfcp device,
pfcp_dellink() could be called concurrently for it (once RTNL is
removed).  In such a case, __rtnl_net_unlock() will perform the
unregistration.

We can see pfcp0 below is unregistered by the per-netns work
instead of cleanup_net().

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:pfcp_dev_uninit {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }
  kprobe:pfcp_net_exit_rtnl {
      printf("PID: %d%s\n", pid, kstack());
  }' &

  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add pfcp0 link-netns ns2 type pfcp
  # ip netns del ns2

  PID: 12
          pfcp_net_exit_rtnl+5
          ops_undo_list+702
          cleanup_net+1122
          process_scheduled_works+2538
  ...
  PID: 462 | DEV: pfcp0
          pfcp_dev_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/pfcp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 45f9c5d3cb20..e1cca779d2ec 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -227,12 +227,13 @@ static int pfcp_newlink(struct net_device *dev,
 	return err;
 }
 
-static void __pfcp_dellink(struct net_device *dev, struct list_head *head)
+static void __pfcp_dellink(struct net *net, struct net_device *dev,
+			   struct list_head *head)
 {
 	struct pfcp_dev *pfcp = netdev_priv(dev);
 
-	list_del(&pfcp->list);
-	unregister_netdevice_queue(dev, head);
+	list_del_init(&pfcp->list);
+	unregister_netdevice_queue_net(net, dev, head);
 }
 
 static void pfcp_dellink(struct net_device *dev, struct list_head *head)
@@ -243,7 +244,8 @@ static void pfcp_dellink(struct net_device *dev, struct list_head *head)
 	pn = net_generic(pfcp->net, pfcp_net_id);
 
 	mutex_lock(&pn->lock);
-	__pfcp_dellink(dev, head);
+	if (!list_empty(&pfcp->list))
+		__pfcp_dellink(dev_net(dev), dev, head);
 	mutex_unlock(&pn->lock);
 }
 
@@ -274,7 +276,7 @@ static void __net_exit pfcp_net_exit_rtnl(struct net *net,
 	mutex_lock(&pn->lock);
 
 	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
-		__pfcp_dellink(pfcp->dev, dev_to_kill);
+		__pfcp_dellink(net, pfcp->dev, dev_to_kill);
 
 	mutex_unlock(&pn->lock);
 }
-- 
2.55.0.571.g244d577d93-goog

