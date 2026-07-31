Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE8453A58
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516380; cv=none; b=uM9Zcz1zZ+WppVr0LRllJYh9E5UUPVrO8/UWeHPKYvfSxCS4qFAI1wB+nK6mjfg7OlIMnyY4cQXLtn2gshsPCdJwYJ3lueNKq11qv7nLVsBaaMhrvbuZCSUfWf9P76kiMv5JIfvT+ZR0cguqOb2rDg6kSbFp3vI+w7hf8kODMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516380; c=relaxed/simple;
	bh=pwgx+sC6SSUDd/8kUfAiH9sIYsd6s+PHNDSDurJwFFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JKCBBMC5JBzpyCkF0+1hb/Hf2D5G8l8UpFfwJeqiJIMjCgv08YYdPCjTouwbUhbqKYnMIEGbRiO8fUgaPgwjHqZSKvGvG2yhDpGFh3mN9WAb7/XEb0sFJ9ZcnbB39YfBj+pYjwfLrXVCP0URogfE7sh6pFoDqDcLnPEzjnTEwmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEmsiOgi; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEmsiOgi"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab041eced3so1757654a12.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785516378; x=1786121178; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PanEok8fSnYMZdwwOxkGeAQ4Au3tCnVOSw8JT8i3V0=;
        b=EEmsiOgiHcmws3Ig/lllDpSsfo3pOgoIPSyjxvw0/SpvcQZeM+PxE/FNOoH1Y1PsYf
         hmCGis0Q1XsNEsXpxIWk8U7fri9hpYT6K8PbmdSkvTjsA54BzAdPLMO/VnwRFQEBHVy0
         Bww7i7gDnJNNX3WVJZ13um0hrT68PI+++1qBKWMZ2SuoN9FQWL/Q5AofwAfc4lGXEGBl
         xIekbuHUp4KP9dj6Pu1uRqqTI0wEmp70y7ayMKYqUdWvdyk0jmoS//rQ8Muqdv9i6Prq
         szPJHK+ZaerIot0fhk7k0Ds+sd3UiWcJt+H9T042eUnwrMs6UCfcZUXdUTiMrgQZnK8w
         T50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516378; x=1786121178;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PanEok8fSnYMZdwwOxkGeAQ4Au3tCnVOSw8JT8i3V0=;
        b=g5i18UMEXzKpJhiQZVrnADRfeoCirgaToGz7+2zQ+E4e1a54C4haaSWxjC02eOE4Ai
         JQuApanNhPMYVdxTAd+6ZthEWwOCPoCJDv9iVwa5UUbGANdQIVzNzCJaPzeVAC7IUT8d
         O7aAbu6oe7E6CzIqEclzg9QtmNoCXAGCeGigD44gMthuVdg25Eil2cYhYugXXracRrtp
         Jn5fV65vEo9fVwADq+ljja/YWnEgKoTlPhSFy7FJBVLLzcyzIFGgMWkRolXvibGwf9RP
         hve4VXdRARmXaMYFLhSxZPHkLrDV+n9mAK3ibUZhFA97RhOhOXjKqWkLiCRKzXdWu+J8
         w/Eg==
X-Forwarded-Encrypted: i=1; AHgh+RpSaOtlMnjDMKJn5d3j1fdPCkBPDgxDlx/Bjw7sSMbb/LAdYyP85APIYuwmllfkfMZChaW0iS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2F+Rn9fsB8nl5s/7x5L+ATgPBBJMols/lD2NN8ma0Yv+dbRHh
	maT4Bsr9ztaUdUAZBRY9t9DrlW3RWMB8USsvNbjVYo3k11gGL7JifRyvyvKplrSYXzTSq3R4cdh
	OqsXd7A==
X-Received: from pghm13.prod.google.com ([2002:a63:f60d:0:b0:c9e:a22d:15b4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cc8e:b0:3bf:a638:4371
 with SMTP id adf61e73a8af0-3c92a4c8830mr509635637.10.1785516378147; Fri, 31
 Jul 2026 09:46:18 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:45:54 +0000
In-Reply-To: <20260731164612.2148830-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731164612.2148830-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260731164612.2148830-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/3] geneve: Protect geneve_net and geneve_sock
 with per-netns mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct geneve_dev.net is the netns where the backend geneve
socket resides.

struct geneve_dev is linked to the geneve_net.geneve_list of
the socket's netns.

During netns dismantle or module unload, geneve_exit_rtnl_net()
iterates the list and queues devices for destruction regardless
of devices' netns.

Moreover, a socket can be shared by multiple geneve devices in
different netns, and geneve_open() and geneve_stop() modify
geneve_sock.vni_list and geneve_net.sock_list.

Thus, once RTNL is removed, the three lists can be modified
concurrently from different netns due to device removal and
link-up/down.

Let's protect them with per-netns mutex.

geneve_newlink() is still protected by rtnl_net_lock()s, so
acquiring gn->lock twice in geneve_find_dev() and
geneve_configure() is not a problem.

Note that udp_tunnel_notify_add_rx_port() is moved outside of
the mutex, otherwise gn->lock -> utn->lock ordering would trigger
AB-BA deadlock in geneve_offload_rx_ports(), which acquires
gn->lock under utn->lock.  Even without gn->lock, geneve_sock_add()
and geneve_offload_rx_ports() are still serialised with (per-netns)
RTNL, so there is no race.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 82 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index bd4fc6dba2fa..f456a85dca77 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -69,8 +69,8 @@ struct geneve_skb_cb {
 /* per-network namespace private data for this module */
 struct geneve_net {
 	struct list_head	geneve_list;
-	/* sock_list is protected by rtnl lock */
 	struct list_head	sock_list;
+	struct mutex		lock;
 };
 
 static unsigned int geneve_net_id;
@@ -1035,9 +1035,6 @@ static struct geneve_sock *geneve_socket_create(struct net *net,
 	for (h = 0; h < VNI_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&gs->vni_list[h]);
 
-	/* Initialize the geneve udp offloads structure */
-	udp_tunnel_notify_add_rx_port(sk, UDP_TUNNEL_TYPE_GENEVE);
-
 	/* Mark socket as an encapsulation socket */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
 	tunnel_cfg.sk_user_data = gs;
@@ -1056,6 +1053,7 @@ static void __geneve_sock_release(struct geneve_dev *geneve, bool ipv6)
 {
 	struct geneve_dev_node *node;
 	struct geneve_sock *gs;
+	struct geneve_net *gn;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
@@ -1073,12 +1071,19 @@ static void __geneve_sock_release(struct geneve_dev *geneve, bool ipv6)
 	if (!gs)
 		return;
 
+	gn = net_generic(sock_net(gs->sk), geneve_net_id);
+	mutex_lock(&gn->lock);
+
 	hlist_del_init_rcu(&node->hlist);
 
-	if (--gs->refcnt)
+	if (--gs->refcnt) {
+		mutex_unlock(&gn->lock);
 		return;
+	}
 
 	list_del(&gs->list);
+	mutex_unlock(&gn->lock);
+
 	udp_tunnel_notify_del_rx_port(gs->sk, UDP_TUNNEL_TYPE_GENEVE);
 	udp_tunnel_sock_release(gs->sk);
 	kfree_rcu(gs, rcu);
@@ -1135,22 +1140,31 @@ static int geneve_sock_add(struct geneve_dev *geneve,
 	struct net *net = geneve->net;
 	struct geneve_dev_node *node;
 	struct geneve_sock *gs;
+	struct geneve_net *gn;
+	bool created = false;
 	__u8 vni[3];
+	int ret = 0;
 	__u32 hash;
 
+	gn = net_generic(net, geneve_net_id);
+	mutex_lock(&gn->lock);
+
 	gs = geneve_find_sock(net, geneve, cfg, ipv6);
 	if (gs) {
 		gs->refcnt++;
-		goto out;
-	}
+	} else {
+		gs = geneve_socket_create(net, geneve, cfg, ipv6);
+		if (IS_ERR(gs)) {
+			ret = PTR_ERR(gs);
+			goto out;
+		}
 
-	gs = geneve_socket_create(net, geneve, cfg, ipv6);
-	if (IS_ERR(gs))
-		return PTR_ERR(gs);
+		created = true;
+	}
 
-out:
 	gs->collect_md = cfg->collect_md;
 	gs->gro_hint = cfg->gro_hint;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		rcu_assign_pointer(geneve->sock6, gs);
@@ -1166,7 +1180,16 @@ static int geneve_sock_add(struct geneve_dev *geneve,
 	tunnel_id_to_vni(cfg->info.key.tun_id, vni);
 	hash = geneve_net_vni_hash(vni);
 	hlist_add_head_rcu(&node->hlist, &gs->vni_list[hash]);
-	return 0;
+
+out:
+	mutex_unlock(&gn->lock);
+
+	if (created) {
+		/* Initialize the geneve udp offloads structure */
+		udp_tunnel_notify_add_rx_port(gs->sk, UDP_TUNNEL_TYPE_GENEVE);
+	}
+
+	return ret;
 }
 
 static int geneve_open(struct net_device *dev)
@@ -1743,6 +1766,8 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
 
 	ASSERT_RTNL();
 
+	mutex_lock(&gn->lock);
+
 	list_for_each_entry(gs, &gn->sock_list, list) {
 		if (push) {
 			udp_tunnel_push_rx_port(dev, gs->sk,
@@ -1752,6 +1777,8 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
 						UDP_TUNNEL_TYPE_GENEVE);
 		}
 	}
+
+	mutex_unlock(&gn->lock);
 }
 
 static struct geneve_config *geneve_config_alloc(const struct geneve_config *src)
@@ -1968,6 +1995,9 @@ static struct geneve_dev *geneve_find_dev(struct geneve_net *gn,
 
 	*tun_on_same_port = false;
 	*tun_collect_md = false;
+
+	mutex_lock(&gn->lock);
+
 	list_for_each_entry(geneve, &gn->geneve_list, next) {
 		const struct geneve_config *gcfg = rtnl_dereference(geneve->cfg);
 
@@ -1982,6 +2012,9 @@ static struct geneve_dev *geneve_find_dev(struct geneve_net *gn,
 		    !memcmp(&info->key.u, &gcfg->info.key.u, sizeof(info->key.u)))
 			t = geneve;
 	}
+
+	mutex_unlock(&gn->lock);
+
 	return t;
 }
 
@@ -2076,7 +2109,10 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 		return err;
 	}
 
+	mutex_lock(&gn->lock);
 	list_add(&geneve->next, &gn->geneve_list);
+	mutex_unlock(&gn->lock);
+
 	return 0;
 }
 
@@ -2466,7 +2502,7 @@ static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
 	return err;
 }
 
-static void geneve_dellink(struct net_device *dev, struct list_head *head)
+static void __geneve_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
 
@@ -2474,6 +2510,18 @@ static void geneve_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
+static void geneve_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct geneve_dev *geneve = netdev_priv(dev);
+	struct geneve_net *gn;
+
+	gn = net_generic(geneve->net, geneve_net_id);
+
+	mutex_lock(&gn->lock);
+	__geneve_dellink(dev, head);
+	mutex_unlock(&gn->lock);
+}
+
 static size_t geneve_get_size(const struct net_device *dev)
 {
 	return nla_total_size(sizeof(__u32)) +	/* IFLA_GENEVE_ID */
@@ -2692,6 +2740,8 @@ static __net_init int geneve_init_net(struct net *net)
 
 	INIT_LIST_HEAD(&gn->geneve_list);
 	INIT_LIST_HEAD(&gn->sock_list);
+	mutex_init(&gn->lock);
+
 	return 0;
 }
 
@@ -2701,8 +2751,12 @@ static void __net_exit geneve_exit_rtnl_net(struct net *net,
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_dev *geneve, *next;
 
+	mutex_lock(&gn->lock);
+
 	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
-		geneve_dellink(geneve->dev, dev_to_kill);
+		__geneve_dellink(geneve->dev, dev_to_kill);
+
+	mutex_unlock(&gn->lock);
 }
 
 static void __net_exit geneve_exit_net(struct net *net)
-- 
2.55.0.571.g244d577d93-goog

