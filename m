Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477623F58F7
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867686; cv=none; b=UyKqWahM3ccOFiggVxBdnXqe05nEcPn0UfvfoD17r9oW5MaCdEFYuGwIVtFFKE9NFPIMn5Z2S4Jppkyl76D2puge9JGhOPXSZf1HtlaxuWT6L7a2eXZdWnR+QNbxvLlsEHbeEUkVEqsVyIlnNU20W3WJ7xnZssZfH8ZRB2ggem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867686; c=relaxed/simple;
	bh=E18ZmlhKx2vZXzjAGq28ZhHz6/Zwk9XVloSjEWzAZ1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+SdDe3W62iNof/K+YJTNsq+lJ++ucq3K83d+gwvASivsvQ+Iqnctou7L+1LJBpFGq7kwZ622KgGx2HR6Q6wIHRUSJELvg6qCUOeteq+XVDu6wJrFkgmtwnFrdRhJCVabjgh1BXoFc4Q4+PoRXQQZLlm1Km9rUToGHB6sqV1DCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so231445e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867681; x=1786472481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oZeQlNjOge6WMVv6WVdFf9fbDLHuWnzd1YmpbjrG1hA=;
        b=ACTp9UNd5Wbij/m33alc42+e7S5nlITzzzVEq0YmlPv8El/at9fTMvsWKjIZuCBi0g
         JzjovVBYeffIvGkfoQFo63K/ficIuY5czEgwugXsQS4SSiJ87dZ5PAVQ+S7Is9I8pq33
         s9Wg9pGiyzOtB6VTrOAa1WcnKDB7y0VVxjY4d2frZVZkStOYzlGFurQgsXl4zbRlcVpD
         O6/GOGCo0TNEKE0PE2OzFt+0ixKjnXiqUee2XU5a2215zJM4qmH+VBE78qCV52fcAnIz
         oAVx9IvsPCN5fC1eR04R6ZXnAYnogmfKc90GtNIK+8krjUF5LhNAq6DnRYevc4lRhvku
         ASBA==
X-Gm-Message-State: AOJu0Ywru8pGZNYrjU0bTDbg6m5DlgyITrMXB9+5W1DhUsvGy5hQ6m29
	oChqI8lZjfmXRix90tCAB528yJ14ex7Xck0JtMaqYNpd5dDlXiIgDNjbBKksE6ibbQQ=
X-Gm-Gg: AR+sD121FUoo0+2kXAuOhQ1M6J5nMXMB9OErD9w1y+1G3+PAUgiAQqCeGkm/+2Be44O
	KwXVuwlihGrW3hi9MytSjtzsOQ9394TyQG5MoVv8ISn/AZIOrsL1s2FWeNdyepJ0ERnBu4VlRR1
	UVcimywdhaJuBC/lUhl+zyC/hMpnstI+LM9xy7Pzz4pudtVGHYlurLP4kJBJ/IlbuEdCNRSjxP+
	pd5/FvMrmwuF5shTEEbQqtGy1jtWiwILWvnOM5pdKGSX8LXED43/ls6RKCV5DAeQZmOJnTWGUHe
	GvVWhQTzm1ngEg/1IHhHiUalE7aK2vLU/nFm3QNvysPWy4Q6NSrOuC+58tGaRY8WlIktSWkT7tZ
	UjGLjdbsC8m66/xuyAeLnhlr3EA/M1RDkAUTrTdSj7+LCk20Ik8A8CxchrXO3JRP73mqrbv4GJN
	Jx0npScOzFLrYJRIO9o/B2piESh75UlSd6tomE6nIZ184GNDKWhrXbnxv0lzljYEmz5mE2qPuDz
	NAzxXTuHCyDsUorvaWqNInzG5FqzQ==
X-Received: by 2002:a05:600c:4fca:b0:496:c2fd:1731 with SMTP id 5b1f17b1804b1-4994e711309mr3148375e9.1.1785867681458;
        Tue, 04 Aug 2026 11:21:21 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf5c1sm4946925e9.2.2026.08.04.11.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:21:21 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 6/6] net: vxlan: remove unused vxlan_dev_create
Date: Tue,  4 Aug 2026 20:20:40 +0200
Message-ID: <20260804182049.2289754-7-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804182049.2289754-1-i.maximets@ovn.org>
References: <20260804182049.2289754-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vport-vxlan in openvswitch was the last user and it is now gone.

And we can now rename the internal function to have a better name.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 drivers/net/vxlan/vxlan_core.c | 42 ++++------------------------------
 include/net/vxlan.h            |  3 ---
 2 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 25e3fe1ee751..fd5505153d0b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3966,9 +3966,9 @@ static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
 	return 0;
 }
 
-static int __vxlan_dev_create(struct net *net, struct net_device *dev,
-			      struct vxlan_config *conf,
-			      struct netlink_ext_ack *extack)
+static int vxlan_dev_create(struct net *net, struct net_device *dev,
+			    struct vxlan_config *conf,
+			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
@@ -4416,7 +4416,7 @@ static int vxlan_newlink(struct net_device *dev,
 	if (err)
 		return err;
 
-	return __vxlan_dev_create(link_net, dev, &conf, extack);
+	return vxlan_dev_create(link_net, dev, &conf, extack);
 }
 
 static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -4700,40 +4700,6 @@ static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
 	.get_link_net	= vxlan_get_link_net,
 };
 
-struct net_device *vxlan_dev_create(struct net *net, const char *name,
-				    u8 name_assign_type,
-				    struct vxlan_config *conf)
-{
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
-	int err;
-
-	memset(&tb, 0, sizeof(tb));
-
-	dev = rtnl_create_link(net, name, name_assign_type,
-			       &vxlan_link_ops, tb, NULL);
-	if (IS_ERR(dev))
-		return dev;
-
-	err = __vxlan_dev_create(net, dev, conf, NULL);
-	if (err < 0) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	err = rtnl_configure_link(dev, NULL, 0, NULL);
-	if (err < 0) {
-		LIST_HEAD(list_kill);
-
-		vxlan_dellink(dev, &list_kill);
-		unregister_netdevice_many(&list_kill);
-		return ERR_PTR(err);
-	}
-
-	return dev;
-}
-EXPORT_SYMBOL_GPL(vxlan_dev_create);
-
 static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
 					     struct net_device *dev)
 {
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 6e64757151b8..7b8207505523 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -359,9 +359,6 @@ struct vxlan_dev {
 					 VXLAN_F_MC_ROUTE          |	\
 					 0)
 
-struct net_device *vxlan_dev_create(struct net *net, const char *name,
-				    u8 name_assign_type, struct vxlan_config *conf);
-
 static inline netdev_features_t vxlan_features_check(struct sk_buff *skb,
 						     netdev_features_t features)
 {
-- 
2.55.0

