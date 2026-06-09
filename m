Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0B40D58B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037947; cv=none; b=gvK9iDW0vmYI3za2aZpvTpChcgVhrijUoDF4VbXZbXHS3i1sE+FB7zpjTELd0CQc5GGyn9/U2cTqH38NFv6gSupYzpWv9O8WuqowC5tJx9PqjN5F8XdXXszLzi4nkA4IvkB2wDgCoWZ1gQkWHkpt1dKjQjmF2WXRmtqqofXZcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037947; c=relaxed/simple;
	bh=89asEXevv4YE8NLyNqCiW7IlO4v3DKeN/0W7ohqC63Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI+nIvl1OsmTT1ufupAkdK5MrKl2f3VaBz13B4mD52LIYluQZQwmOE899E54eA13nbB61+kOvA3C57cTD6o4Osdp7z4YvTVqEEXcilYIgmjRB3ocorHx5oF8Lh0Jo9kB0hH3l/m7vLktkLB943mFngJm5NQb/iZKg540TCWUgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4083A5D73E;
	Tue,  9 Jun 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CA76779A7;
	Tue,  9 Jun 2026 20:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ExMI3J7KGq7PwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 09 Jun 2026 20:45:38 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH 2/3 net-next v6] ipv4: handle devconf post-set actions on netlink updates
Date: Tue,  9 Jun 2026 22:45:19 +0200
Message-ID: <20260609204520.4670-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260609204520.4670-1-fmancera@suse.de>
References: <20260609204520.4670-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4083A5D73E
X-Rspamd-Action: no action

When IPv4 device configuration parameters are updated via netlink, the
kernel currently only updates the value. This bypasses several
post-modification actions that occur when these same parameters are
updated via sysctl, such as flushing the routing cache or emitting
RTM_NEWNETCONF notifications.

This patch addresses the inconsistency by calling the
devinet_conf_post_set() helper inside inet_set_link_af(). If a flush is
required, we defer it until the netlink attribute parsing loop
completes.

This ensures consistent behavior and side-effects for devconf changes,
regardless of whether they are initiated via sysctl or netlink.

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: handled forwarding notification and disabling LRO
v3: no changes
v4: no changes
v5: no changes
v6: no changes
---
 net/ipv4/devinet.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 8300516fb38f..a35b72662e43 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2161,6 +2161,20 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
 					    NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
 					    ifindex, cnf);
 		break;
+	case IPV4_DEVCONF_FORWARDING:
+		if (new == 1) {
+			/* it is safe to use container_of() because forwarding case
+			 * is only used by the netlink path
+			 */
+			struct in_device *idev = container_of(cnf, struct in_device, cnf);
+
+			netif_disable_lro(idev->dev);
+		}
+
+		inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
+					    NETCONFA_FORWARDING,
+					    ifindex, cnf);
+		return true;
 	default:
 		break;
 	}
@@ -2173,6 +2187,8 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 {
 	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 	struct nlattr *a, *tb[IFLA_INET_MAX+1];
+	struct net *net = dev_net(dev);
+	bool flush_cache = false;
 	int rem;
 
 	if (!in_dev)
@@ -2182,8 +2198,17 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 		return -EINVAL;
 
 	if (tb[IFLA_INET_CONF]) {
-		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
-			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
+		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
+			int old_value = ipv4_devconf_get(in_dev, nla_type(a));
+			int new_value = nla_get_u32(a);
+
+			ipv4_devconf_set(in_dev, nla_type(a), new_value);
+			if (devinet_conf_post_set(net, &in_dev->cnf, nla_type(a), new_value,
+						  old_value, dev->ifindex))
+				flush_cache = true;
+		}
+		if (flush_cache)
+			rt_cache_flush(net);
 	}
 
 	return 0;
-- 
2.54.0

