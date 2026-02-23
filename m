Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83628C869
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860709; cv=none; b=olFY41LWk5ZtHrjqYk06VDKLFkj8iYUa4ufYdXApyVbPcek81P9pMm/qNZOpx6s5bwIVsmyulEbNINnM/dREKqtpEtLrYyBgHDr9ZqBbYLCIgtK1hRR7rBBkB0Gq8hfcckqjxTxACwK2lQRSAAQXDfzEYcPD53GlHXfu+7eDB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860709; c=relaxed/simple;
	bh=o1oLg0nB+YiY80Uun+MNDhJ52gcIHXMtNOATqmaeKOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCmZlMhQUOb/7oaam7vOqQ+Kug5NNnXb7bn59e7A22t3L/Ny3QnwMeFdn8nMVC96vCD0aVBSfpDypIb7TUnBoggoVQzxeWQzzb/P9keMBBxma3ALmEnOg5mLUnn2XPLnYF5bRX0HsF889r8RLMMAoKhtQePmf9nb5G7vbRQxpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E7AEE5BE60;
	Mon, 23 Feb 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 459F73EA68;
	Mon, 23 Feb 2026 15:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eEuxDeJynGkINgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 23 Feb 2026 15:31:46 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tgraf@infradead.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net-next] ipv4: bump rt_genid when a relevant devconf value changes through netlink
Date: Mon, 23 Feb 2026 16:30:45 +0100
Message-ID: <20260223153045.32044-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223153045.32044-1-fmancera@suse.de>
References: <20260223153045.32044-1-fmancera@suse.de>
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
X-Rspamd-Queue-Id: E7AEE5BE60
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

When modifying IPv4 devconf values using netlink for some relevant
fields the rt_cache_flush() call was missing. In addition, if forwarding
is enabled on the interface then disable LRO.

This is needed to avoid possible connectivity issues and ease the
responsabilities of user space tools.

Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/devinet.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 590c68e979f5..9f55c13a9c1f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2159,6 +2159,8 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 {
 	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 	struct nlattr *a, *tb[IFLA_INET_MAX+1];
+	struct net *net = dev_net(in_dev->dev);
+	bool flush_cache = false;
 	int rem;
 
 	if (!in_dev)
@@ -2168,8 +2170,27 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 		return -EINVAL;
 
 	if (tb[IFLA_INET_CONF]) {
-		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
+		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
 			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
+
+			switch (nla_type(a)) {
+			case IPV4_DEVCONF_FORWARDING:
+				if (nla_get_u32(a))
+					dev_disable_lro(in_dev->dev);
+				fallthrough;
+			case IPV4_DEVCONF_NOXFRM:
+			case IPV4_DEVCONF_NOPOLICY:
+			case IPV4_DEVCONF_PROMOTE_SECONDARIES:
+			case IPV4_DEVCONF_ROUTE_LOCALNET:
+			case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
+				flush_cache = true;
+				break;
+			default:
+				break;
+			}
+		}
+		if (flush_cache)
+			rt_cache_flush(net);
 	}
 
 	return 0;
-- 
2.53.0

