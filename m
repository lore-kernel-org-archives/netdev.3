Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167034F85BC;
	Mon, 28 Sep 2026 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623947; cv=none; b=iGrntFzkgFv2d1nHU2sYtBPhNWijIJz7rElqTUz+ANAO4WbWkgKxYRKc+Xpjt0gdHSnJCVNLxuYM/qsxTULG9CXlnyQ0UFw623TyFfuoIkFFiAy71tpkjBoaBg1kYw/FtXOAExGBrvYlLx7tiZZPScqp2PFdVzIuSTkhTkARQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623947; c=relaxed/simple;
	bh=kfb1dRu7liQpWDiuQJLPakDul54tIvSkuwQTdOq9Ld4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJNroczyZk9kx+RRNh06cunOcP9OjcVcc8iypU3BdBcxfzqLJAAKhUsVVckpKMpPltYvdE/HJYf+d0uUNWiRvl0ssO2EFONGWn+LQL78Q6NhFBsqyduMhNulDEETct0rcS2BKcWOdL0ZslK7PdQV0ZS3ChiBAv6hnpjwFWnMvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dQWM0ucV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wmcyjv79; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XgA43nch; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=enKmJcI+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dQWM0ucV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wmcyjv79";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XgA43nch";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="enKmJcI+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B549F1F79F;
	Mon, 28 Sep 2026 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhPJpdhIUspIJvHWCvGGYi/s/olftLeuNqqNdpTj8hk=;
	b=dQWM0ucVggnvKTix1fBYbsSse1EAxP/SGpBKjiknRW+UodYcc+riBEulWWpB1eXk7dfoRe
	D2UwWeidxx1/sCviYJRLTDgRKjgu020g1n11PWLQ+9V7gyjxO6g5WW0wIuiW9o0tIefzuN
	vlkbUS/xza+QYynZJpL5ZDliXPwSouQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhPJpdhIUspIJvHWCvGGYi/s/olftLeuNqqNdpTj8hk=;
	b=Wmcyjv79dhR/htv+nN3nH6xyT25EXt9JSxg0YzJVYp66Mz4/3aW+3Z/yNRfMbY6AruyXDR
	ZdHIxDBK97yPLcCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhPJpdhIUspIJvHWCvGGYi/s/olftLeuNqqNdpTj8hk=;
	b=XgA43nchgYPk2IvabLik7qva2BgiTXhhgzhmgW2RpJeT0nMSI3Jjo2+OClyW2PiwTJLbom
	ZmAYlAIrMF4xylVni73tgLw3wOYpqngn6fwPy0F0ZCRqjEYB7X77YnsEGvQO4kWM5rJsUY
	0t05m1TzSiQVqAVQOCBL45aiLkvQc94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhPJpdhIUspIJvHWCvGGYi/s/olftLeuNqqNdpTj8hk=;
	b=enKmJcI+v2EOMUhntk4GiBB6k3sJG4FHlVbxqXMnbsRthwL+GCkuKhJrneXyCYWNCXIEww
	DJYlQQUVYzIuEGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C86A213418;
	Mon, 28 Sep 2026 19:32:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RBiFn3AumpWOAAAD6G6ig:T12
	(envelope-from <fmancera@suse.de>); Mon, 28 Sep 2026 19:32:13 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Eric Dumazet <edumazet@google.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/16 net-next v2] ipv4: disable IPv4-only sysctls when CONFIG_IPV4=n
Date: Mon, 28 Sep 2026 21:30:07 +0200
Message-ID: <20260928193046.6698-12-fmancera@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,suse.de,google.com,nokia-bell-labs.com,icloud.com,gmail.com,nvidia.com,vger.kernel.org];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com]

To avoid noise and unexpected problems, let's hide all the sysctls that
are related to IPv4 only when the kernel is compiled without IPv4
support.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/sysctl_net_ipv4.c | 407 +++++++++++++++++++------------------
 1 file changed, 205 insertions(+), 202 deletions(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 0e7fef5973db..6096e9e4d82d 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -31,8 +31,8 @@ static int tcp_min_snd_mss_max = 65535;
 static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
 static int ip_privileged_port_min;
 static int ip_privileged_port_max = 65535;
-static int ip_ttl_min = 1;
-static int ip_ttl_max = 255;
+static int ip_ttl_min __maybe_unused = 1;
+static int ip_ttl_max __maybe_unused = 255;
 static int tcp_syn_retries_min = 1;
 static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
 static int tcp_syn_linear_timeouts_max = MAX_TCP_SYNCNT;
@@ -48,7 +48,7 @@ static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
 static int tcp_ecn_mode_max = 5;
-static u32 icmp_errors_extension_mask_all =
+static u32 icmp_errors_extension_mask_all __maybe_unused =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
 static int tcp_min_rcvbuf = 4096;
@@ -201,8 +201,9 @@ static int ipv4_ping_group_range(const struct ctl_table *table, int write,
 	return ret;
 }
 
-static int ipv4_fwd_update_priority(const struct ctl_table *table, int write,
-				    void *buffer, size_t *lenp, loff_t *ppos)
+static int __maybe_unused
+ipv4_fwd_update_priority(const struct ctl_table *table, int write,
+			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
 	int ret;
@@ -441,9 +442,9 @@ static int proc_udp_hash_entries(const struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
-static int proc_fib_multipath_hash_policy(const struct ctl_table *table, int write,
-					  void *buffer, size_t *lenp,
-					  loff_t *ppos)
+static int __maybe_unused
+proc_fib_multipath_hash_policy(const struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
 	    ipv4.sysctl_fib_multipath_hash_policy);
@@ -456,9 +457,9 @@ static int proc_fib_multipath_hash_policy(const struct ctl_table *table, int wri
 	return ret;
 }
 
-static int proc_fib_multipath_hash_fields(const struct ctl_table *table, int write,
-					  void *buffer, size_t *lenp,
-					  loff_t *ppos)
+static int __maybe_unused
+proc_fib_multipath_hash_fields(const struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
 	int ret;
@@ -492,9 +493,9 @@ static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
 	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_seed);
 }
 
-static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
-					void *buffer, size_t *lenp,
-					loff_t *ppos)
+static int __maybe_unused
+proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct sysctl_fib_multipath_hash_seed *mphs;
 	struct net *net = table->data;
@@ -636,15 +637,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
-	{
-		.procname	= "icmp_echo_ignore_all",
-		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_all,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
 	{
 		.procname	= "icmp_echo_enable_probe",
 		.data		= &init_net.ipv4.sysctl_icmp_echo_enable_probe,
@@ -654,56 +646,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
-	{
-		.procname	= "icmp_echo_ignore_broadcasts",
-		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "icmp_ignore_bogus_error_responses",
-		.data		= &init_net.ipv4.sysctl_icmp_ignore_bogus_error_responses,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "icmp_errors_use_inbound_ifaddr",
-		.data		= &init_net.ipv4.sysctl_icmp_errors_use_inbound_ifaddr,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{
-		.procname	= "icmp_errors_extension_mask",
-		.data		= &init_net.ipv4.sysctl_icmp_errors_extension_mask,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &icmp_errors_extension_mask_all,
-	},
-	{
-		.procname	= "icmp_ratelimit",
-		.data		= &init_net.ipv4.sysctl_icmp_ratelimit,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_ms_jiffies,
-	},
-	{
-		.procname	= "icmp_ratemask",
-		.data		= &init_net.ipv4.sysctl_icmp_ratemask,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
 	{
 		.procname	= "icmp_msgs_per_sec",
 		.data		= &init_net.ipv4.sysctl_icmp_msgs_per_sec,
@@ -774,13 +716,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{
-		.procname	= "ip_dynaddr",
-		.data		= &init_net.ipv4.sysctl_ip_dynaddr,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
 	{
 		.procname	= "ip_early_demux",
 		.data		= &init_net.ipv4.sysctl_ip_early_demux,
@@ -811,15 +746,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{
-		.procname	= "ip_default_ttl",
-		.data		= &init_net.ipv4.sysctl_ip_default_ttl,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= &ip_ttl_min,
-		.extra2		= &ip_ttl_max,
-	},
 	{
 		.procname	= "ip_local_port_range",
 		.maxlen		= 0,
@@ -841,36 +767,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_large_bitmap,
 	},
-	{
-		.procname	= "ip_no_pmtu_disc",
-		.data		= &init_net.ipv4.sysctl_ip_no_pmtu_disc,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "ip_forward_use_pmtu",
-		.data		= &init_net.ipv4.sysctl_ip_fwd_use_pmtu,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "ip_forward_update_priority",
-		.data		= &init_net.ipv4.sysctl_ip_fwd_update_priority,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler   = ipv4_fwd_update_priority,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "ip_nonlocal_bind",
-		.data		= &init_net.ipv4.sysctl_ip_nonlocal_bind,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
 	{
 		.procname	= "ip_autobind_reuse",
 		.data		= &init_net.ipv4.sysctl_ip_autobind_reuse,
@@ -880,13 +776,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
-	{
-		.procname	= "fwmark_reflect",
-		.data		= &init_net.ipv4.sysctl_fwmark_reflect,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
 	{
 		.procname	= "tcp_fwmark_accept",
 		.data		= &init_net.ipv4.sysctl_tcp_fwmark_accept,
@@ -952,37 +841,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_douintvec_minmax,
 		.extra2		= &u32_max_div_HZ,
 	},
-	{
-		.procname	= "igmp_link_local_mcast_reports",
-		.data		= &init_net.ipv4.sysctl_igmp_llm_reports,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-	},
-	{
-		.procname	= "igmp_max_memberships",
-		.data		= &init_net.ipv4.sysctl_igmp_max_memberships,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "igmp_max_msf",
-		.data		= &init_net.ipv4.sysctl_igmp_max_msf,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-#ifdef CONFIG_IP_MULTICAST
-	{
-		.procname	= "igmp_qrv",
-		.data		= &init_net.ipv4.sysctl_igmp_qrv,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE
-	},
-#endif
 	{
 		.procname	= "tcp_congestion_control",
 		.data		= &init_net.ipv4.tcp_congestion_control,
@@ -1154,42 +1012,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_tfo_blackhole_detect_timeout,
 		.extra1		= SYSCTL_ZERO,
 	},
-#ifdef CONFIG_IP_ROUTE_MULTIPATH
-	{
-		.procname	= "fib_multipath_use_neigh",
-		.data		= &init_net.ipv4.sysctl_fib_multipath_use_neigh,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "fib_multipath_hash_policy",
-		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_policy,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_fib_multipath_hash_policy,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_THREE,
-	},
-	{
-		.procname	= "fib_multipath_hash_fields",
-		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_fields,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_fib_multipath_hash_fields,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &fib_multipath_hash_fields_all_mask,
-	},
-	{
-		.procname	= "fib_multipath_hash_seed",
-		.data		= &init_net,
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_fib_multipath_hash_seed,
-	},
-#endif
 	{
 		.procname	= "ip_unprivileged_port_start",
 		.maxlen		= sizeof(int),
@@ -1563,15 +1385,6 @@ static const struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE
 	},
-	{
-		.procname	= "fib_notify_on_flag_change",
-		.data		= &init_net.ipv4.sysctl_fib_notify_on_flag_change,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
 	{
 		.procname       = "tcp_plb_enabled",
 		.data           = &init_net.ipv4.sysctl_tcp_plb_enabled,
@@ -1656,6 +1469,196 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ONE_THOUSAND,
 		.extra2		= &tcp_rto_max_max,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
+	{
+		.procname	= "icmp_echo_ignore_all",
+		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_all,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
+	{
+		.procname	= "icmp_echo_ignore_broadcasts",
+		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
+	{
+		.procname	= "icmp_ignore_bogus_error_responses",
+		.data		= &init_net.ipv4.sysctl_icmp_ignore_bogus_error_responses,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
+	{
+		.procname	= "icmp_errors_use_inbound_ifaddr",
+		.data		= &init_net.ipv4.sysctl_icmp_errors_use_inbound_ifaddr,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
+	{
+		.procname	= "icmp_errors_extension_mask",
+		.data		= &init_net.ipv4.sysctl_icmp_errors_extension_mask,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &icmp_errors_extension_mask_all,
+	},
+	{
+		.procname	= "icmp_ratelimit",
+		.data		= &init_net.ipv4.sysctl_icmp_ratelimit,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_ms_jiffies,
+	},
+	{
+		.procname	= "icmp_ratemask",
+		.data		= &init_net.ipv4.sysctl_icmp_ratemask,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+	{
+		.procname	= "ip_dynaddr",
+		.data		= &init_net.ipv4.sysctl_ip_dynaddr,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
+	{
+		.procname	= "ip_default_ttl",
+		.data		= &init_net.ipv4.sysctl_ip_default_ttl,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= &ip_ttl_min,
+		.extra2		= &ip_ttl_max,
+	},
+	{
+		.procname	= "ip_no_pmtu_disc",
+		.data		= &init_net.ipv4.sysctl_ip_no_pmtu_disc,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
+	{
+		.procname	= "ip_forward_use_pmtu",
+		.data		= &init_net.ipv4.sysctl_ip_fwd_use_pmtu,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
+	{
+		.procname	= "ip_forward_update_priority",
+		.data		= &init_net.ipv4.sysctl_ip_fwd_update_priority,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler   = ipv4_fwd_update_priority,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "ip_nonlocal_bind",
+		.data		= &init_net.ipv4.sysctl_ip_nonlocal_bind,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
+	{
+		.procname	= "fwmark_reflect",
+		.data		= &init_net.ipv4.sysctl_fwmark_reflect,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
+	{
+		.procname	= "igmp_link_local_mcast_reports",
+		.data		= &init_net.ipv4.sysctl_igmp_llm_reports,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
+	{
+		.procname	= "igmp_max_memberships",
+		.data		= &init_net.ipv4.sysctl_igmp_max_memberships,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+	{
+		.procname	= "igmp_max_msf",
+		.data		= &init_net.ipv4.sysctl_igmp_max_msf,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+#ifdef CONFIG_IP_MULTICAST
+	{
+		.procname	= "igmp_qrv",
+		.data		= &init_net.ipv4.sysctl_igmp_qrv,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE
+	},
+#endif
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+	{
+		.procname	= "fib_multipath_use_neigh",
+		.data		= &init_net.ipv4.sysctl_fib_multipath_use_neigh,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "fib_multipath_hash_policy",
+		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_policy,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_fib_multipath_hash_policy,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_THREE,
+	},
+	{
+		.procname	= "fib_multipath_hash_fields",
+		.data		= &init_net.ipv4.sysctl_fib_multipath_hash_fields,
+		.maxlen		= sizeof(u32),
+		.mode		= 0644,
+		.proc_handler	= proc_fib_multipath_hash_fields,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &fib_multipath_hash_fields_all_mask,
+	},
+	{
+		.procname	= "fib_multipath_hash_seed",
+		.data		= &init_net,
+		.maxlen		= sizeof(u32),
+		.mode		= 0644,
+		.proc_handler	= proc_fib_multipath_hash_seed,
+	},
+#endif
+	{
+		.procname	= "fib_notify_on_flag_change",
+		.data		= &init_net.ipv4.sysctl_fib_notify_on_flag_change,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+#endif
 };
 
 static const struct ctl_table *ipv4_net_table_dup(struct net *net)
-- 
2.55.0

