Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F20353A8C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537850; cv=none; b=PlvNn7VmNBq3NXKSqhvA2wyt4GjM8sJfluFgID1Ykv2m16N1A/ElUc7DU4QzymJSWQZkHNdqCYn07+DrD+BwHI5AXJ5JT4WcmPG+e/YRugvwVOuKMr0XSrBOrpNLhHeYdqFEYMpvKH6Ni1LQbxUwWhj8fEFqjmOszWbzj7PO0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537850; c=relaxed/simple;
	bh=xSv6I+VfUYRYk9pzdS5zqRN7Rqftt5/T/NJTW9vg2fM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UnbNy8cyXg79atmpUU4XjS6JRk/DdzNgumrwCbxa+SuaOiS1absEIgh8O4w8N7TL6ZASau8+ruTWNrmAYLxKd/6GCX/Q+86OhtUiIeMNP7IrylSfTgjf3Fd4+MV48oQXLAEaTAeU/qXuPFhDcs8qsrKr8mwe/CIzq27V30Z04K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSx2g4Dr; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSx2g4Dr"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so1987370a91.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785537849; x=1786142649; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCrnJj7GG7K8BbNzmbQejDx7evCtmM9rwr7UsDt3JDo=;
        b=bSx2g4DrjPzct6AvMUKlckx6R2Uej/YPfkFn/x1Q9m079+63kK5YgYJu0BUgzxRBpQ
         q96Wm6k9+kDQAjPrbE7QTWFnhQP09ROkNUHncuf0Z/54jcicedQ9LrnEDO6yjoGaGwSH
         hlvYb50zmzZKqD7i6y8yEW5adyWNZ0KgQWh0twzT5VVsaZKC31w4ht3xEBWPPhcfvZJH
         mmFM7Kmskm2ZFP7qaH9SAoVIHLZ2y3RfwWOwzpuP0yG9II4Up2UTXh9115Su1O1DhcZ5
         98naMrS6zZYnMrxyWH7JZtxD8iucADk30dBtTqLm5lLvdi2XhfgZQj5kp1ZLgES7I+9g
         oDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785537849; x=1786142649;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCrnJj7GG7K8BbNzmbQejDx7evCtmM9rwr7UsDt3JDo=;
        b=qT7USLgTNbgDTpsNyTmm/QhpjGOxXAC+yUKy8CYw8ij8ZPj1munaVr9Lzw7NTDHIVB
         4DEAr/D5jrU4U6kzHmOi/3a+Al3tQ8BEyrcpxmEeCHYmKqy7zuGklkSpcfzROI7xNQXK
         q3JdOJsc2diGEtADJzBYhDT07TXJjRrF9s/TskQgq2YMvzjdwZb1JJTlG4tAP0OMPB6o
         wYPzDOqZx6TJ4AvynqcTqgiYP+mTJJPkTHo93ZvxK1YhokBPCuAIQ0ij00M9Jy4dCmr+
         Q3FcWxKqOlYVyf2MBEjsXPtaamQXVBZ0HtgLMFPV2Uvvgtwkx53AayoyMIE5c/lnbNZJ
         QXGA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7lwXz8MEWyxZPUHBS5EfxaByM6OMtAxuY2P14F9EXW8AlzMlL9R7/vbd0HZ/RwVcIHSGm9Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnXKwtR9DV7KPDhn7CWF1VtGDumnHYTwHE3QfjTFbzzJvD0y7b
	OSh4b13Z1TQxpMMEUEziKuxq9QzeRwr+YaVQF8IrFdnS/ibV/2Ggemybai++jfdF0ZZ/3Qcn9or
	YlVVYQg==
X-Received: from pjbgn23.prod.google.com ([2002:a17:90a:c797:b0:38d:ed16:8b30])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5626:b0:37e:9e9:6ffc
 with SMTP id 98e67ed59e1d1-38fbc4cbd5amr1231136a91.25.1785537848540; Fri, 31
 Jul 2026 15:44:08 -0700 (PDT)
Date: Fri, 31 Jul 2026 22:43:40 +0000
In-Reply-To: <20260731224406.2444121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731224406.2444121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731224406.2444121-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/2] pfcp: Protect pfcp_net.pfcp_dev_list with mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct pfcp_dev.net is the netns where the backend pfcp socket
resides.

struct pfcp_dev is linked to the pfcp_net.pfcp_dev_list of
the socket's netns.

During netns dismantle or module unload, pfcp_net_exit_rtnl()
iterates the list and queues devices for destruction regardless
of the devices' netns.

Thus, once RTNL is removed, the list can be modified concurrently
from different netns due to device removal.

Let's protect it with per-netns mutex.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/pfcp.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index d8e4d60f5834..45f9c5d3cb20 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -29,6 +29,7 @@ static unsigned int pfcp_net_id __read_mostly;
 
 struct pfcp_net {
 	struct list_head	pfcp_dev_list;
+	struct mutex		lock;
 };
 
 static void
@@ -209,7 +210,10 @@ static int pfcp_newlink(struct net_device *dev,
 	}
 
 	pn = net_generic(link_net, pfcp_net_id);
+
+	mutex_lock(&pn->lock);
 	list_add(&pfcp->list, &pn->pfcp_dev_list);
+	mutex_unlock(&pn->lock);
 
 	netdev_dbg(dev, "registered new PFCP interface\n");
 
@@ -223,7 +227,7 @@ static int pfcp_newlink(struct net_device *dev,
 	return err;
 }
 
-static void pfcp_dellink(struct net_device *dev, struct list_head *head)
+static void __pfcp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct pfcp_dev *pfcp = netdev_priv(dev);
 
@@ -231,6 +235,18 @@ static void pfcp_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
+static void pfcp_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct pfcp_dev *pfcp = netdev_priv(dev);
+	struct pfcp_net *pn;
+
+	pn = net_generic(pfcp->net, pfcp_net_id);
+
+	mutex_lock(&pn->lock);
+	__pfcp_dellink(dev, head);
+	mutex_unlock(&pn->lock);
+}
+
 static struct rtnl_link_ops pfcp_link_ops __read_mostly = {
 	.kind		= "pfcp",
 	.priv_size	= sizeof(struct pfcp_dev),
@@ -244,6 +260,8 @@ static int __net_init pfcp_net_init(struct net *net)
 	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
 
 	INIT_LIST_HEAD(&pn->pfcp_dev_list);
+	mutex_init(&pn->lock);
+
 	return 0;
 }
 
@@ -253,8 +271,12 @@ static void __net_exit pfcp_net_exit_rtnl(struct net *net,
 	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
 	struct pfcp_dev *pfcp, *pfcp_next;
 
+	mutex_lock(&pn->lock);
+
 	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
-		pfcp_dellink(pfcp->dev, dev_to_kill);
+		__pfcp_dellink(pfcp->dev, dev_to_kill);
+
+	mutex_unlock(&pn->lock);
 }
 
 static struct pernet_operations pfcp_net_ops = {
-- 
2.55.0.571.g244d577d93-goog

