Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4424F7CBF;
	Mon, 28 Sep 2026 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623943; cv=none; b=YXpvuAIdiytXpfR/CrqqiXrfn8J7q0s/wM2A1DGdjzL6PBvS8c52uOmKn94GPfMxcOrLXl0k2jcIZLsOiBe+SwrebY0QKiKZG9FaFhM2uqkh30QzyjEw5Pz52EbFITAex+LhFhkxLzAulHH7OgeuaRCCE+RucdPrMcclRLtfhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623943; c=relaxed/simple;
	bh=80X/ZPX6ZbpEtzgyYZENaORaMrF1uKZ1IdlrN2H5ycY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNxm9Rdjq4heoyS6fye+MLUFaYTXjEeY6UUVpgAJWBqgcFxOYcQuyl5bs6zZ2VaXqzJ9xXiTVINP17+byLd218DstNb7xQi0rDKMQbbIpe582qWeXpn+Kwbwp4PPvsnezCKdm7c2zHIDBIgXDkIZHLsotm/aNgsIYqqGItyjJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EdaoR5RT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CCrLZ/wI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EovmgLaO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9BRibGJY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EdaoR5RT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CCrLZ/wI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EovmgLaO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9BRibGJY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A8751F45F;
	Mon, 28 Sep 2026 19:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qo1mK+6exvY7ym1r/42jk9cIkBabDPh0YPHsTGPBx7Y=;
	b=EdaoR5RTYib9TdbPOPPuKZkqNnUijgucQm9mLkmNpS3HvopNreyOWMd505XpALxhJqRJcX
	H+eFcZ+4vdf46gMpo3p8CiD7LbytH8mDVWXj8YvcKrjEUiLxSnZYiEhfN47R8XV+WFpMIO
	vn98a99ZkVOSMUEjSKGgjRyBTdi59pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qo1mK+6exvY7ym1r/42jk9cIkBabDPh0YPHsTGPBx7Y=;
	b=CCrLZ/wIVtgOIxptJOtHfJtCck85Lg2lyA9TyIjXlBjrtUyeU6MUhaDOXB+c11JZa1oIaj
	T43ntlDkF301xhAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qo1mK+6exvY7ym1r/42jk9cIkBabDPh0YPHsTGPBx7Y=;
	b=EovmgLaOfOKh4r6z8lx0cudak5qFXVAZbpqyhC3mdUzCyFBJuyIg2Gp/3bSb9+Jit3szQd
	Wlu5TwJ6z3jSZYWI2XjHOPYPxh2XsP5AVtjxZ27tXbMyNJVplB8Oxwnsm84/3cbKYr8Yny
	ZDU40HrsXFAONMhRnJnaSuTzuKHQXyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qo1mK+6exvY7ym1r/42jk9cIkBabDPh0YPHsTGPBx7Y=;
	b=9BRibGJY7HZQgU5JJ7a3lZarDL/A2HPaOlXFN0Zj7z2fbok+U2jMLve7hpcejp1e86/s9Y
	lm51pZfG7fImHUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 910B01340F;
	Mon, 28 Sep 2026 19:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RBiFn3AumpWOAAAD6G6ig:T11
	(envelope-from <fmancera@suse.de>); Mon, 28 Sep 2026 19:32:10 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/16 net-next v2] tunnels: guard IPv4 tunnel functions with CONFIG_IPV4
Date: Mon, 28 Sep 2026 21:30:06 +0200
Message-ID: <20260928193046.6698-11-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928193046.6698-1-fmancera@suse.de>
References: <20260928193046.6698-1-fmancera@suse.de>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

To enable compiling INET subsystem withou IPv4, IPv4 specific IP tunnel
core functions must be bypassed when the protocol is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/ip_tunnel_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index bab42b9e277f..996e61243922 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -58,6 +58,14 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	struct iphdr *iph;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_IPV4)) {
+		if (dev)
+			DEV_STATS_INC(dev, tx_errors);
+		ip_rt_put(rt);
+		kfree_skb(skb);
+		return;
+	}
+
 	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
 		if (dev) {
 			net_crit_ratelimited("Dead loop on virtual device %s (net %llu), fix it urgently!\n",
@@ -218,6 +226,9 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	struct ethhdr eh;
 	int len, err;
 
+	if (!IS_ENABLED(CONFIG_IPV4))
+		return -EOPNOTSUPP;
+
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct iphdr)))
 		return -EINVAL;
 
-- 
2.55.0

