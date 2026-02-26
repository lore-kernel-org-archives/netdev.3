Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BE27F72C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113204; cv=none; b=t6W1KUE1Uc8QtFEuzhHfh5XsK3CcRA/84RBHndyj6vtmk52qpAjWyNK3HQA3uK0f7N1YS+tM3AGgfUPYr9k8MwvYjIFFFrjjDWjkYaQ0X+++D3a/3djl1EwzX0iDODWsua/7S1KpIGAWBjHm+XL4h3Tu6U+Eus1rEwU3pLQPC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113204; c=relaxed/simple;
	bh=nCWy5XNtMtCHnaoGhEGlsJU0+9FuzaU3v8fa1gwk+r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fp+0uRMaORdLJhnds4h1Mn0lzsML0k5EnqMSVnqB95kF3dMioB+5OKy4m8YXgkOv9haH9Yny2oNPVxoJxsrURk8KG0d9N9IyG1QQ0KaEPSkKZfk0ihpNTgWxkUGgIA4n4tEaGr9ztLCFr0W8lpDloT0o4DnMG4IXDTIKpL9+rhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZXslRC05; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bTmRQYZ+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZXslRC05; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bTmRQYZ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZXslRC05";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bTmRQYZ+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZXslRC05";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bTmRQYZ+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C78F11FAA4;
	Thu, 26 Feb 2026 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772113200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R49Ce8TcGG6aK4ZwQqHFCq3Uzu6Ks4dK2cvgPQWuZ5I=;
	b=ZXslRC054wnoIGsr6vReiGpUSPqra/1zRSS6RcePq3ph/eUCo7KZlmVdJEWjD0n0vzHxbJ
	aOtlA8O/fpIzMvUM2ceYoNpGMRxmYSdsYOvipcDT/HJ6uwr3J02ddLLzDdg1NhdD7EUkCl
	3RH2wSDlZOadG1vkRAIGyJwA9yxVuKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772113200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R49Ce8TcGG6aK4ZwQqHFCq3Uzu6Ks4dK2cvgPQWuZ5I=;
	b=bTmRQYZ+C6gcrU3msltaIzRkwTugcpZW/HhEppmdVJ99iPzdr6bOqIvxq7hzKyPcVGUgqJ
	XooF7+mcowPavYAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772113200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R49Ce8TcGG6aK4ZwQqHFCq3Uzu6Ks4dK2cvgPQWuZ5I=;
	b=ZXslRC054wnoIGsr6vReiGpUSPqra/1zRSS6RcePq3ph/eUCo7KZlmVdJEWjD0n0vzHxbJ
	aOtlA8O/fpIzMvUM2ceYoNpGMRxmYSdsYOvipcDT/HJ6uwr3J02ddLLzDdg1NhdD7EUkCl
	3RH2wSDlZOadG1vkRAIGyJwA9yxVuKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772113200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R49Ce8TcGG6aK4ZwQqHFCq3Uzu6Ks4dK2cvgPQWuZ5I=;
	b=bTmRQYZ+C6gcrU3msltaIzRkwTugcpZW/HhEppmdVJ99iPzdr6bOqIvxq7hzKyPcVGUgqJ
	XooF7+mcowPavYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00AD63EA62;
	Thu, 26 Feb 2026 13:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eIN2OC9NoGl/ZQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 26 Feb 2026 13:39:59 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: tgraf@infradead.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net-next v2] ipv4: bump rt_genid when a relevant devconf value changes through netlink
Date: Thu, 26 Feb 2026 14:39:49 +0100
Message-ID: <20260226133949.17070-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226133949.17070-1-fmancera@suse.de>
References: <20260226133949.17070-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

When modifying IPv4 devconf values using netlink for some relevant
fields the rt_cache_flush() call was missing. In addition, if forwarding
is enabled on the interface then disable LRO.

This is needed to avoid possible connectivity issues and ease the
responsabilities of user space tools.

Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: use netif_disable_lro() as we already hold netdev_need_ops_lock()
and use net_device struct passed as argument instead of using in_dev->dev
---
 net/ipv4/devinet.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 590c68e979f5..b1651da3f572 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2159,6 +2159,8 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
 {
 	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 	struct nlattr *a, *tb[IFLA_INET_MAX+1];
+	struct net *net = dev_net(dev);
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
+					netif_disable_lro(dev);
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

