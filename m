Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635212;
	b=bPGM0V2/chBknfsC6Hm6hN8OY7jECstKg7Sx+t8XtRiItW1LryrGu6UA75fwql+pKXvt
	 IVSyAlkywOpInfp5WuRoOP4UKVkhJPptepLud+HmsCEBc2yYrsmxpYBcUlLc+n8SHXyBn
	 1PWhZzvhPjiqVxduYWscMSEK/A9nUfb1p8E+yPhKmVqXtGHqiChnINCZ5roNxE6WqAb44
	 CckRIwe0Jaqtrz1l5llebxzjfMPLAaNux9L2/6dN/j3TNMBSiTFnCAAcr7UeGNi4Hy6SF
	 YShb8zI1i8UbTOm0RlavrDIkODx1r8SQFrTUPVQrkaXYqqpBZ8Mcr4DYe/0l/GU8DLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635212;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=Pg1wDIY8BiNpI5IDe+jrxWlCwW4v0BIs43q1oidq33k=;
	b=HjDRwdtam4PkFrr4JObcSgJLLf7OnDQIGCqWTfEp84NZWYkdqj3S38InE+3T+08vntNo
	 tF+dY5t838RxHDllVbk8Q2+B0637BdTH2bYeIGU3TMaPqvN6C9xqeeGQOGMCe1p2GSfq4
	 6dnD+BobFV36pIdNIqQx+Ou/cnDoPTEoF2WfAwY8Re3hTxAkolqJ4W35KcBSTBMFjPSuu
	 DVd+7w3F/DoQ9ujeNWzCzDvg6JXQJNefbiusgqRvOAYrbpsW3vPkVeFZM1n6jP7eIBWDo
	 fbbnidggsGxfoEqvxVT9R2P+fN0BgXb/ZDElBSBS5ZYjdwhiuM4Zz5gTn4EowpLN0UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="jg/o4KGo";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=14F8YsT2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="jg/o4KGo";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=14F8YsT2;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87403606F3EF;
	Mon,  2 Nov 2026 16:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87403606F3EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jg/o4KGo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=14F8YsT2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jg/o4KGo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=14F8YsT2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63AC11F83A;
	Mon,  2 Nov 2026 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793635208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pg1wDIY8BiNpI5IDe+jrxWlCwW4v0BIs43q1oidq33k=;
	b=jg/o4KGoEzvhaMkeqyPhlyJYijgqwCjocMKrqGdpzdBzsRSRkFPz471reoxh37AX5pePey
	8umHEcZDwjkh5B+eM5Z7ikjVkegjXrLwM/507LkGgqlQx5sAzywu8Fg6CZccDmAFPy0Z89
	Ef67soJ912sAGoabGR6g97ZYCxjRbWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793635208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pg1wDIY8BiNpI5IDe+jrxWlCwW4v0BIs43q1oidq33k=;
	b=14F8YsT29aoloZKGDYRdjsFwK6EdgQaUda9aTh5QiRGj5hsb6xYwQjO7FQoJNDdWOE6pNB
	CLsl1y+e9dcY/TAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jg/o4KGo";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=14F8YsT2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793635208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pg1wDIY8BiNpI5IDe+jrxWlCwW4v0BIs43q1oidq33k=;
	b=jg/o4KGoEzvhaMkeqyPhlyJYijgqwCjocMKrqGdpzdBzsRSRkFPz471reoxh37AX5pePey
	8umHEcZDwjkh5B+eM5Z7ikjVkegjXrLwM/507LkGgqlQx5sAzywu8Fg6CZccDmAFPy0Z89
	Ef67soJ912sAGoabGR6g97ZYCxjRbWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793635208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pg1wDIY8BiNpI5IDe+jrxWlCwW4v0BIs43q1oidq33k=;
	b=14F8YsT29aoloZKGDYRdjsFwK6EdgQaUda9aTh5QiRGj5hsb6xYwQjO7FQoJNDdWOE6pNB
	CLsl1y+e9dcY/TAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F30E5134B3;
	Mon,  2 Nov 2026 16:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ybPZMYez6Go+HAAAD6G6ig
	(envelope-from <rbranco@suse.de>); Mon, 02 Nov 2026 16:00:07 +0000
From: Ricardo Branco <rbranco@suse.de>
To: netdev@vger.kernel.org,
	rbranco@suse.de
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] ipv4: add ip_process_options sysctl
Date: Mon,  2 Nov 2026 16:59:58 +0100
Message-ID: <20261102155958.60436-1-rbranco@suse.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 63AC11F83A

Add net.ipv4.ip_process_options to control handling of IP options in
received packets, modelled after FreeBSD's net.inet.ip.process_options:

  0 - ignore options; the packet is handled as if it had none, and
      forwarded packets keep their options unmodified
  1 - process options (default, current behaviour)
  2 - drop packets carrying options and send an ICMP "packet filtered"
      error, as FreeBSD does

Most IP options are obsolete or rarely needed, and are commonly filtered
(RFC 7126), yet the only existing knob, accept_source_route, covers just
the source routing options; record route, timestamp and the rest are
always processed. Netfilter can match and drop such packets, but unlike
TCP options it has no way to strip or neutralise IPv4 options while
still accepting the packet. A sysctl gives a simple switch with the same
semantics as the FreeBSD one, which also eases porting existing
configurations.

The check is done first in ip_rcv_options(), so it takes precedence over
accept_source_route and skips the skb_cow() and option parsing.
Ignoring options is safe because IPCB(skb) is zeroed in ip_rcv_core().

Note that mode 2 also drops packets whose only option is Router Alert,
e.g. IGMP, which can break multicast on routers.

Tested with veth pairs in network namespaces using "ping -R", both for
local delivery and for forwarding through a router: mode 1 records the
route, mode 0 returns no list locally and forwards options without the
router recording its address, mode 2 drops the request and ping reports
"Packet filtered".

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 Documentation/networking/ip-sysctl.rst | 15 +++++++++++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/af_inet.c                     |  1 +
 net/ipv4/ip_input.c                    | 14 ++++++++++++++
 net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
 5 files changed, 40 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index d3523c9064a2..fdbd34384453 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -172,6 +172,21 @@ ip_forward_update_priority - INTEGER
 	- 0 - Do not update priority.
 	- 1 - Update priority.
 
+ip_process_options - INTEGER
+	Control processing of IPv4 options (source routing, record route,
+	timestamp, etc.) in received packets.
+
+	Possible values:
+
+	- 0 - Ignore options. Packets are accepted or forwarded as if they
+	  carried no options; forwarded packets keep their options unchanged.
+	- 1 - Process options.
+	- 2 - Drop packets carrying options and send an ICMP "packet
+	  filtered" error. Note that this includes packets carrying only
+	  the Router Alert option (e.g. IGMP), which can break multicast.
+
+	Default: 1
+
 route/max_size - INTEGER
 	Maximum number of routes allowed in the kernel.  Increase
 	this when using large numbers of interfaces and/or routes.
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index cb7f8bf15671..3bbd15be505d 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -162,6 +162,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_ip_default_ttl;
 	u8 sysctl_ip_no_pmtu_disc;
+	u8 sysctl_ip_process_options;
 	u8 sysctl_ip_fwd_update_priority;
 	u8 sysctl_ip_nonlocal_bind;
 	u8 sysctl_ip_autobind_reuse;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7677b0343abd..2f22e69fa3cd 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1798,6 +1798,7 @@ static __net_init int inet_init_net(struct net *net)
 	 */
 	net->ipv4.sysctl_ip_default_ttl = IPDEFTTL;
 	net->ipv4.sysctl_ip_fwd_update_priority = 1;
+	net->ipv4.sysctl_ip_process_options = 1;
 	net->ipv4.sysctl_ip_dynaddr = 0;
 	net->ipv4.sysctl_ip_early_demux = 1;
 	net->ipv4.sysctl_udp_early_demux = 1;
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..d1616ecddfa8 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -271,6 +271,20 @@ ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 	const struct iphdr *iph;
 	struct ip_options *opt;
 
+	switch (READ_ONCE(dev_net(dev)->ipv4.sysctl_ip_process_options)) {
+	case 0:
+		/* Ignore options: IPCB(skb)->opt was zeroed in ip_rcv_core(),
+		 * so the packet is handled as if it carried no options.
+		 */
+		return SKB_NOT_DROPPED_YET;
+	case 2:
+		__IP_INC_STATS(dev_net(dev), IPSTATS_MIB_INHDRERRORS);
+		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PKT_FILTERED, 0);
+		return SKB_DROP_REASON_IP_INHDR;
+	default:	/* 1: process options */
+		break;
+	}
+
 	/* It looks as overkill, because not all
 	   IP options require packet mangling.
 	   But it is the easiest for now, especially taking
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index bf193e7ec516..9bdf5ad23614 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -847,6 +847,15 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	{
+		.procname	= "ip_process_options",
+		.data		= &init_net.ipv4.sysctl_ip_process_options,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
 	{
 		.procname	= "ip_forward_use_pmtu",
 		.data		= &init_net.ipv4.sysctl_ip_fwd_use_pmtu,
-- 
2.56.0

