Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1A4B8DE8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445947; cv=none; b=j8V5JmJV30gGTrEnY6BvKkEOxtPOY6MpZgoyNRrl0P7qnfk2On+nNJhMqgRuptqX/hrs2ncZK2dx9rPC6qTUlmj7JcNpBu7A4MXUMhzwAl4wWKkDaLlg94UAetQIM61xd/G60klGiCJClDeluyxGloCNOnUeY77QIOGrAmQXeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445947; c=relaxed/simple;
	bh=JQ9WHNXd1zUXM8hq9MaOXxZqBdxkm2SZKoBtKHz7Wpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUr0ez3hjmIWBcL7/L7DDbO9z33Spbip8JFMvohFXPDe7B36jDznmku7h9yXMqZdqZW143IjAQoMOvdcmNYQ9tQEzFVa+xM1J9tL2MLZK++UVPdbtBbX/k8XkdWVvgzJat8246LMKiFc7+1DgpfX+pOnOLl3Q+42mJ+kNUwfcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AJ+D0vBh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AJ+D0vBh"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c250f28f1cdso421403566b.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445935; x=1789050735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYYOG0Do4xCECmpKXiXD6Dgae1lqnmNhz5mhp7Y8ks0=;
        b=AJ+D0vBhE5WLw3xpImD42sDOA8s+255ODQ1metGpZcViaH76DTt6YlyFHvIVvgF1P/
         vvctAD4kCsAIy2rsLtn0fQ+Jmj/WGvpl/FVbbh6VhrAlVbTXM+0t8R7yjNlQQ5EHRLWx
         Dif0QOnnOkf4VDAqNYGz7hchOkOmAMuSVFi842e6itZor/wyeWzn0Q+mghNFADwNHGkA
         ZRzkXFZNvA3jsuG1cjbMuk0+lHTSSHb3gCWVPu5pL/0r0P3R4Z1eaMqLZJo2eiImsWCK
         j8ZsRN00sbLTewgt9DW92TYvYLocSXEJVp5DBDU/Qis0Q703v7QxOAEcscue4Nf66aXo
         ay6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445935; x=1789050735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QYYOG0Do4xCECmpKXiXD6Dgae1lqnmNhz5mhp7Y8ks0=;
        b=BbtV7q0Q5r8n/o1DHAbQKUy8vN59b1wIkwBusXG+XPXtwqBehLCusxKYKDIjEpR4z2
         6c+5AXXUIC72AX48mF6lxi6TastGoJ3hXF4h3FMJn6oGZw3w7RasaY+H0XgaWurhKDfa
         hcSsEc5u/kqwo468TAYl6K3YQ8jt82fm/h9pkKH//VEZ8c6ZY0KzkPIj18k/2/ajz+S0
         GnN4jRAnbejdY0yZRSITwI1zaI0grngQ5MRrrTMaG2DqKAo7JAHSfhp6WTffetPWVTyS
         qpcrG8YBvF4LBYttlpkCfZTr/MZSXJmMJ0UzhiCxIOjqsKQEIj6wFV1UuLO2logOtwYQ
         c5GA==
X-Gm-Message-State: AFuF++lGbYGeMy7Ld4TOx/M3ie3lBYsdK1y0Z+5Qn889NfYP2wmA5mpP
	6wWr2QlB898/JncDZ4ylnelyTkGyauI5fk7WRKVAeZRUMEo3i+yEmac2V7JGhULqUx6++lpf/vJ
	ZRLRGsE0=
X-Gm-Gg: AYBFou2tGIkfkakmUbqAWftFHlLJZhH4koFQ9RU6S8y3Wpnbn1jSePtKqx9TrJwsbEp
	2wkIZmlpnxj5ZxDkO5aEaaNs0zZFsPnolA5cWD/Oo976oV9CC92a5uIKg3/CrDhPzfQzGC+B4ff
	OFBV1c/lnJH1hNenB+A9Qd466PWHKQc0ktsD4A1FCMvhepRZMKIxbUJThBiuZV/zLZkaVXrTcT+
	41EKM+/jUidQZnpky7zHHypJT3AMA99QLVyZIrwKprpQcgx6gLbEoCTQOuALcLn7OyXMLwZozFC
	nCdHh8TE7Gd3F5RL/e2n3O3g6dtje2E8lJKi2mAoHHlRbJLywF1hMUXw/SVbHBxfkr9hhGqKU3S
	v68DWJNDkjOA0bT0XnHfpB/1WcyeWGa+4Ets2zQIhw4Ev3ekd9Ve3qKtEdxFwuTkeOuCQlqrdn0
	+WHQQKXwRwvOEB4CB9s6FJTpl93we0ZjlydwlCiVzzg+31uMAVBbwajjCl7j8KAzuKASeP
X-Received: by 2002:a17:906:f58e:b0:c25:c954:faf2 with SMTP id a640c23a62f3a-c25d563a41cmr836658066b.21.1788445935349;
        Thu, 03 Sep 2026 07:32:15 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c25f42861c1sm107705166b.63.2026.09.03.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:14 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v2 8/9] net: bridge: vlan: add missing tinfo.tunnel_id annotations
Date: Thu,  3 Sep 2026 17:31:37 +0300
Message-ID: <20260903143138.1574598-9-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
References: <20260903143138.1574598-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I annotated data races around tinfo.tunnel_id before, I missed a few
places (e.g. bridge notifications, rhashtable compare), so add them now.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: assign tunid_curr/last later due to long lines

 net/bridge/br_netlink_tunnel.c | 14 ++++++++------
 net/bridge/br_vlan_tunnel.c    |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index e7eceab5b515..e64054628ac9 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -29,8 +29,10 @@ static size_t __get_vlan_tinfo_size(void)
 bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
 			const struct net_bridge_vlan *v_last)
 {
-	__be32 tunid_curr = tunnel_id_to_key32(v_curr->tinfo.tunnel_id);
-	__be32 tunid_last = tunnel_id_to_key32(v_last->tinfo.tunnel_id);
+	__be32 tunid_curr, tunid_last;
+
+	tunid_curr = tunnel_id_to_key32(READ_ONCE(v_curr->tinfo.tunnel_id));
+	tunid_last = tunnel_id_to_key32(READ_ONCE(v_last->tinfo.tunnel_id));
 
 	return (be32_to_cpu(tunid_curr) - be32_to_cpu(tunid_last)) == 1;
 }
@@ -43,7 +45,7 @@ static int __get_num_vlan_tunnel_infos(struct net_bridge_vlan_group *vg)
 	/* Count number of vlan infos */
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		/* only a context, bridge vlan not activated */
-		if (!br_vlan_should_use(v) || !v->tinfo.tunnel_id)
+		if (!br_vlan_should_use(v) || !READ_ONCE(v->tinfo.tunnel_id))
 			continue;
 
 		if (!vtbegin) {
@@ -124,19 +126,19 @@ static int br_fill_vlan_tinfo_range(struct sk_buff *skb,
 	if (vtend && (vtend->vid - vtbegin->vid) > 0) {
 		/* add range to skb */
 		err = br_fill_vlan_tinfo(skb, vtbegin->vid,
-					 vtbegin->tinfo.tunnel_id,
+					 READ_ONCE(vtbegin->tinfo.tunnel_id),
 					 BRIDGE_VLAN_INFO_RANGE_BEGIN);
 		if (err)
 			return err;
 
 		err = br_fill_vlan_tinfo(skb, vtend->vid,
-					 vtend->tinfo.tunnel_id,
+					 READ_ONCE(vtend->tinfo.tunnel_id),
 					 BRIDGE_VLAN_INFO_RANGE_END);
 		if (err)
 			return err;
 	} else {
 		err = br_fill_vlan_tinfo(skb, vtbegin->vid,
-					 vtbegin->tinfo.tunnel_id,
+					 READ_ONCE(vtbegin->tinfo.tunnel_id),
 					 0);
 		if (err)
 			return err;
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 257cae9f1569..04751f15d708 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -22,7 +22,7 @@ static inline int br_vlan_tunid_cmp(struct rhashtable_compare_arg *arg,
 	const struct net_bridge_vlan *vle = ptr;
 	__be64 tunid = *(__be64 *)arg->key;
 
-	return vle->tinfo.tunnel_id != tunid;
+	return READ_ONCE(vle->tinfo.tunnel_id) != tunid;
 }
 
 static const struct rhashtable_params br_vlan_tunnel_rht_params = {
-- 
2.47.3

