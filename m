Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67E49F134;
	Thu, 10 Sep 2026 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051862; cv=none; b=Mbh2Iq6P0rQnYZdZlPE/R4kKPlVF+45qHZwmD5R+cc/F8sA5d42AuFmexrmKXOS+0p116AytZRYHudFToG86yrqJCd02aB//RtQC1ag8fiQALAMvv7JtoNsCJLOMX3k0PRyLANy4pZzbyLXPNSNeeF4UgNBBNsVIA5ij0AvjMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051862; c=relaxed/simple;
	bh=lr+8HyrcMRL7rhR7oRHV6PZEB+gRlPdEmvNQJz1W3ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcvyN5SkiH7TcVEVZjBdOnVEmi9iwm85YhrfNY9qm0L82G9PAhfjnQxX1z3BWwFOT4YJkordW6DBHNfRAyPm2MIAi81o5DJSdSFp5GhfSeTjEPZjSKE7PXL+sgMmWrFZJQkNjk9mnaWTnu8ABYRAX7862orzXJw8TOl9Ap2sVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50F6A1FC84;
	Thu, 10 Sep 2026 14:50:57 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69A31137FD;
	Thu, 10 Sep 2026 14:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SGoJF9DDomogZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 14:50:56 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/13 net-next] net: ipv4: disable IPv4-only sysctls when CONFIG_IPV4=n
Date: Thu, 10 Sep 2026 16:48:37 +0200
Message-ID: <20260910144914.8025-13-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910144914.8025-1-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
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
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 50F6A1FC84
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

To avoid noise and unexpected problems, let's hide all the sysctls that
are related to IPv4 only when the kernel is compiled without IPv4
support.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/sysctl_net_ipv4.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index f6c7b755fa7e..f86883ea0c20 100644
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
 
 /* obsolete */
@@ -199,6 +199,7 @@ static int ipv4_ping_group_range(const struct ctl_table *table, int write,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 static int ipv4_fwd_update_priority(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -214,6 +215,7 @@ static int ipv4_fwd_update_priority(const struct ctl_table *table, int write,
 
 	return ret;
 }
+#endif
 
 static int proc_tcp_congestion_control(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
@@ -439,6 +441,7 @@ static int proc_udp_hash_entries(const struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
+#if IS_ENABLED(CONFIG_IPV4)
 static int proc_fib_multipath_hash_policy(const struct ctl_table *table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
@@ -469,6 +472,7 @@ static int proc_fib_multipath_hash_fields(const struct ctl_table *table, int wri
 
 	return ret;
 }
+#endif
 
 static u32 proc_fib_multipath_hash_rand_seed __ro_after_init;
 
@@ -490,6 +494,7 @@ static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
 	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_seed);
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
 					void *buffer, size_t *lenp,
 					loff_t *ppos)
@@ -515,6 +520,7 @@ static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write
 
 	return ret;
 }
+#endif
 #else
 
 static void proc_fib_multipath_hash_init_rand_seed(void)
@@ -634,6 +640,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "icmp_echo_ignore_all",
 		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_all,
@@ -643,6 +650,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+#endif
 	{
 		.procname	= "icmp_echo_enable_probe",
 		.data		= &init_net.ipv4.sysctl_icmp_echo_enable_probe,
@@ -652,6 +660,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "icmp_echo_ignore_broadcasts",
 		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
@@ -702,6 +711,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
+#endif
 	{
 		.procname	= "icmp_msgs_per_sec",
 		.data		= &init_net.ipv4.sysctl_icmp_msgs_per_sec,
@@ -772,6 +782,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "ip_dynaddr",
 		.data		= &init_net.ipv4.sysctl_ip_dynaddr,
@@ -779,6 +790,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+#endif
 	{
 		.procname	= "ip_early_demux",
 		.data		= &init_net.ipv4.sysctl_ip_early_demux,
@@ -809,6 +821,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "ip_default_ttl",
 		.data		= &init_net.ipv4.sysctl_ip_default_ttl,
@@ -818,6 +831,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= &ip_ttl_min,
 		.extra2		= &ip_ttl_max,
 	},
+#endif
 	{
 		.procname	= "ip_local_port_range",
 		.maxlen		= 0,
@@ -839,6 +853,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_large_bitmap,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "ip_no_pmtu_disc",
 		.data		= &init_net.ipv4.sysctl_ip_no_pmtu_disc,
@@ -869,6 +884,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+#endif
 	{
 		.procname	= "ip_autobind_reuse",
 		.data		= &init_net.ipv4.sysctl_ip_autobind_reuse,
@@ -878,6 +894,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "fwmark_reflect",
 		.data		= &init_net.ipv4.sysctl_fwmark_reflect,
@@ -885,6 +902,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+#endif
 	{
 		.procname	= "tcp_fwmark_accept",
 		.data		= &init_net.ipv4.sysctl_tcp_fwmark_accept,
@@ -950,6 +968,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_douintvec_minmax,
 		.extra2		= &u32_max_div_HZ,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "igmp_link_local_mcast_reports",
 		.data		= &init_net.ipv4.sysctl_igmp_llm_reports,
@@ -980,6 +999,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE
 	},
+#endif
 #endif
 	{
 		.procname	= "tcp_congestion_control",
@@ -1152,6 +1172,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_tfo_blackhole_detect_timeout,
 		.extra1		= SYSCTL_ZERO,
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	{
 		.procname	= "fib_multipath_use_neigh",
@@ -1187,6 +1208,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_fib_multipath_hash_seed,
 	},
+#endif
 #endif
 	{
 		.procname	= "ip_unprivileged_port_start",
@@ -1561,6 +1583,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE
 	},
+#if IS_ENABLED(CONFIG_IPV4)
 	{
 		.procname	= "fib_notify_on_flag_change",
 		.data		= &init_net.ipv4.sysctl_fib_notify_on_flag_change,
@@ -1570,6 +1593,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+#endif
 	{
 		.procname       = "tcp_plb_enabled",
 		.data           = &init_net.ipv4.sysctl_tcp_plb_enabled,
-- 
2.55.0

