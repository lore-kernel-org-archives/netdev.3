Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814C3BBFD1
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942234; cv=none; b=e8lX7lMW0U0SmGjwoUd7MQnd/KUIiKN/ogWXJozbLdxZP+6OKRoEpuarXuGFrd7seEdSfOIvNveQeRTiYYlHrRjtdGMt+K2vVwwxNqW/UAeR+UXAlMGKNa1YZ4apXgDkkL+jPNjJ+tv5g4no5eaA6bQxuBUE5uZUYfLwxWRd970=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942234; c=relaxed/simple;
	bh=zjHDsehBCOqQ1l2pcWJOwFbsoM0UJHSovkLOK6ivmbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5SxmsiNdmugOpJt/Xn1mauhFvlN7By4Aq7O2GcQjNaYtz2WoxoDckUcJjWMbpb43YFmeoNCD0Hy9A7aw4LRKanXhEU1gLPfdB7gfDk35yrFhTqNYn0LP4QJbFWURLvet+vKqHWRP7wu8kXbuiWtPhMHSBv+83creREduULlZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvTU+X86; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvTU+X86"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845a29d8c1eso1380825b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942230; x=1783547030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrfWP4J8NamGUqoZvGkUkZq7RY5EALV+MfBW1YW5ZyM=;
        b=dvTU+X86Zrlycl6zLUZ5RENd1mjpC2NeeXRoz3gJQn6O+ibeQxTjpFHiTNc1eHhdVP
         K6cz9ksIqe3B8oZit7cmJBbbH55EsOe0ubZ/tUmwJ+rbbYWpOa8974Nul6XctAYz48rt
         0pZCseEltFLlVCS8ag6wc+AXPMXku9IJCqVH5VTi+Mll0AFyvTgxpyiP9dsgMDQWJlGY
         ppQVJqDxv+0u6eBKxq6TFKp4dkHfDI2ulzvr5VgI7gwe7uy/4ud6/0X3oQ6Vwmxx3+ZY
         jGU/Z9W+FAr0pmpQmoefs+mvwIF4qSu0CRQhvtipOA4up47ST5EtnV4arFRagsIC1TYk
         JpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942230; x=1783547030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrfWP4J8NamGUqoZvGkUkZq7RY5EALV+MfBW1YW5ZyM=;
        b=ptIn5QoPXa3jK0KwhR0GA5XWRFXdi/uWMiCkCFh7QA+xk1cQIlw9aiOFDLJJBTAp2D
         eJAJHhu8lrPieXuKInPVOBHFWCcHf0SIPbnHyEF1wEOQU5dTkwXQtPl0qxEIvwdgYhrP
         kZMSVLPaqPVVQJ+IyYmeUvhQEf8V3MHDB6S0V7nQaiAPXVVR1C35wxdUxroshNm4Pfo0
         EVd8yAuqFySKW7T8BuRUZg2cbkXsopHUJAYQ//Q0mwyIetiueaxczV5hui/wnKoOJ/nW
         YHYV0mDkkXRfbdUnEbzAWgjmINeXGNXmdEnfjq1NY9Jv3PuuELBllwGFcTPkLfivgqHx
         76lw==
X-Forwarded-Encrypted: i=1; AFNElJ8i5dKRmszsglpF8vR8dXYhPdDRi7ERYrr3RdH+zsDa6yxWvkWaJnKMRZXtJpUOWXqatOfGCq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxw3jVaco1il9XoKtELY4ZqfEpHNZIY2+w7f4ETl5ypRUJ5Ta7
	dJVYswd1NbA+T8IeDyFeKlzuO3Nw5WBl8zQuwXNwI4ytHdNToRottkLX9coCYQmuMBq4232haDQ
	3MQkhig==
X-Received: from pfbct21.prod.google.com ([2002:a05:6a00:f95:b0:847:aec3:8acc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c14:b0:842:5a8d:3036
 with SMTP id d2e1a72fcca58-847c0988898mr3011545b3a.35.1782942230268; Wed, 01
 Jul 2026 14:43:50 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:47 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/14] bareudp: Protect bareudp_list with mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct bareudp_dev.net is the netns where the backend bareudp
socket resides.

struct bareudp_dev is linked to the bareudp_net.bareudp_list of
the socket's netns.

During netns dismantle or module unload, bareudp_exit_rtnl_net()
iterates the list and queues devices for destruction regardless
of the devices' netns.

Thus, once RTNL is removed, the list can be modified concurrently
from different netns due to device removal.

Let's protect it with per-netns mutex.

bareudp_newlink() is still protected by rtnl_net_lock()s, so
acquiring gn->lock twice in bareudp_find_dev() and
bareudp_configure() is not a problem.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/bareudp.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 5ef841c85526..7dedf4867e7b 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -36,6 +36,7 @@ static unsigned int bareudp_net_id;
 
 struct bareudp_net {
 	struct list_head        bareudp_list;
+	struct mutex		lock;
 };
 
 struct bareudp_conf {
@@ -636,10 +637,15 @@ static struct bareudp_dev *bareudp_find_dev(struct bareudp_net *bn,
 {
 	struct bareudp_dev *bareudp, *t = NULL;
 
+	mutex_lock(&bn->lock);
+
 	list_for_each_entry(bareudp, &bn->bareudp_list, next) {
 		if (conf->port == bareudp->port)
 			t = bareudp;
 	}
+
+	mutex_unlock(&bn->lock);
+
 	return t;
 }
 
@@ -675,7 +681,10 @@ static int bareudp_configure(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
+	mutex_lock(&bn->lock);
 	list_add(&bareudp->next, &bn->bareudp_list);
+	mutex_unlock(&bn->lock);
+
 	return 0;
 }
 
@@ -692,7 +701,7 @@ static int bareudp_link_config(struct net_device *dev,
 	return 0;
 }
 
-static void bareudp_dellink(struct net_device *dev, struct list_head *head)
+static void __bareudp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct bareudp_dev *bareudp = netdev_priv(dev);
 
@@ -700,6 +709,18 @@ static void bareudp_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
+static void bareudp_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct bareudp_dev *bareudp = netdev_priv(dev);
+	struct bareudp_net *bn;
+
+	bn = net_generic(bareudp->net, bareudp_net_id);
+
+	mutex_lock(&bn->lock);
+	__bareudp_dellink(dev, head);
+	mutex_unlock(&bn->lock);
+}
+
 static int bareudp_newlink(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
@@ -776,6 +797,8 @@ static __net_init int bareudp_init_net(struct net *net)
 	struct bareudp_net *bn = net_generic(net, bareudp_net_id);
 
 	INIT_LIST_HEAD(&bn->bareudp_list);
+	mutex_init(&bn->lock);
+
 	return 0;
 }
 
@@ -785,8 +808,12 @@ static void __net_exit bareudp_exit_rtnl_net(struct net *net,
 	struct bareudp_net *bn = net_generic(net, bareudp_net_id);
 	struct bareudp_dev *bareudp, *next;
 
+	mutex_lock(&bn->lock);
+
 	list_for_each_entry_safe(bareudp, next, &bn->bareudp_list, next)
-		bareudp_dellink(bareudp->dev, dev_kill_list);
+		__bareudp_dellink(bareudp->dev, dev_kill_list);
+
+	mutex_unlock(&bn->lock);
 }
 
 static struct pernet_operations bareudp_net_ops = {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

