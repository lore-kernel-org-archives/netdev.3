Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08839A7E0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273646; cv=none; b=S1lbTvhQcKwRiHTYZGRoVwYSTC9Ec8wt78iaAIn5ZdKeBULI9gwlcjC5RpFy594qorcxIukfwqlxzjfMYK+tfDgeRTRrsnwqS+x1Cd7thE/vTADsMir7AXLV6PRmaHRflLPdvsaCQcIAoeAXdExyuiYPBBJwOe8K/aXRk+yljHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273646; c=relaxed/simple;
	bh=v2JSzVwwnS/dpB62AduQ+oW05MhvfuCI0+c61ugZ5GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5s+tig41vpUnfPx85CCIQW4k+18C339/kHQ4ZOYVOQWJk9uuoE+15myxHE31cM57GzmvOTsUtu8FRSz6y/omcju9Vf2nj+IAOUxTLEMdC5GMiYvq92p9hZJYGOq8lP8e6VgJdtEXoPWMPN2TbrtK3Pb9VtV1L0Up1Yy0DHK50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=uruEDvk2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="uruEDvk2"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8534d507f59so5422662b3a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788273643; x=1788878443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wb/xg2ItTEDE2HDoMf5+AFnyECZN7iCW1y4MQtvdLyY=;
        b=uruEDvk2Gwhwm6i+OW/7FI6oF+VChTF3fG2C7q1P56VawHyQEGXo22H+e5JSISsrim
         H5Rk4AvNWpv02CmohGLKTK1XSvNdsV3Pqjnhiow4F+TNBAfzEjSNTkpeVmj4eX4c875g
         jnqqexeebIayySezFaIYzilEp25O0BvHYrWx8jJgegl//mKyqo7Wz0JCFvmFW8XZXN0Z
         vdtDy66x5SU/RaLQKxPswRgirt+uqR8+HZy775kF31BzURs6nMzQIJjoqh0CPqlmB/Im
         qlS3TNOMlIORApMPo1srXvIg2rGfray728GcNvJh+PBXxypkfLtALlmZdHz7m95OdoP9
         wGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273643; x=1788878443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wb/xg2ItTEDE2HDoMf5+AFnyECZN7iCW1y4MQtvdLyY=;
        b=A3OaqqD2hP0h6LupF7fEWEXRoCrPxqLB7stVJe7VPiGYCZdBWT7yrsBb9k6ecsfGxw
         5//Wg1xXuy15L5SOsOahyvfMBARs0BxVC9ztANS6Gn6uVdUdBBZ+OeIiAiGJ42a1kT8c
         EqUPCSgxI5sMM6bYIw8NZW+LbnRaBocI+vLh0awFTc3iXx7gzPBwdWDibw4LikM7+6hH
         lFFLc8h/k5waWl5YjVKbY4hGPf6LfPMGKDBp6TM7abPLTVhGWW+q4Ydfsrq/2p7WZPMY
         lbOf4jDrxsy7YMI0ScW6C5mzf+umKd6SezSftstOyBWyAU+awQWZU7lI+YIqUhLxn/Ke
         7cQA==
X-Gm-Message-State: AFuF++mOz0aqWl7iszaycVxBAyh1bNWDd9t/nixIMIbjifn5KnT4hO50
	YGNHUe0e3z9duYuzab5DoqQKsdEOYEBbRTO0eUvPKU1KEuXCWVPERpEaoMgLZcyeQrroqeZaq+j
	49JEg
X-Gm-Gg: AR+sD13aAfVU40R9s2c3Uo0R/NaFM9T1VHRxRJQuwvtX3byjf7U9OV3YJ/BXst4atq1
	vvR4tw02C3bZz9o+PbLdpLvI51wYSP2RgYM2KGuplFuAJWGL3SJj3eByG3RQspX9vROzDlb7bGf
	E7agXUSBokesxS6E8ZFoOnVEK7KRZ/WPvFUDw0DNkjWc55e/fkxZGk5rXczgxU+i/6nffpHBaDD
	n21fbzbCTxeeeb+FCbGCdnqkGeOsz/ISEC3G6rIWLE+AuOsqtB/tiKdufQ+sUUarqY8Yr0DSn/o
	XVp8rNPWibfzceor2fZxyYbOkZNfOHfxywkwIFUmybpymLKWJT/UfG55gNMa4g3xgNWq+IpYIrW
	KcYLRsuWec/GG/glV2kXq1AvI8zK7g5Zn5Rnf6y3zsZuh2F9T0qc0YbskTXgzbJpUdabPfOgTck
	8Ia5k3/HiuwB61VbjHd+PQCJRPljESYqwBU1xGaB6QA6R114uTGO2YRuNauAarQqoIBsBqMxWiI
	IDg7mv5giJ58JTc/8jLWLOVn3w=
X-Received: by 2002:a05:6a21:7a9c:b0:3d3:ae0f:5269 with SMTP id adf61e73a8af0-3d3ae0f5ee0mr40507287637.21.1788273643085;
        Tue, 01 Sep 2026 07:40:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f301f166sm6376279a12.0.2026.09.01.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:40:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2-next] ss: remove /proc fallback paths
Date: Tue,  1 Sep 2026 07:38:08 -0700
Message-ID: <20260901144034.437569-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the old /proc/net fallback code in ss command.
The sock_diag netlink interfaces were all in 3.10, over 13 years ago.
No longer need to carry all the additional text parsing code.
Having less code also reduces the potential for AI scavenging of bugs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ss.8 |   2 +-
 misc/ss.c     | 568 ++------------------------------------------------
 2 files changed, 18 insertions(+), 552 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 3871612d..0e934c40 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -317,7 +317,7 @@ closing. It supports IPv4 and IPv6 sockets only.
 .B \-s, \-\-summary
 Print summary statistics. This option does not parse socket lists obtaining
 summary from various sources. It is useful when amount of sockets is so huge
-that parsing /proc/net/tcp is painful.
+that dumping the full socket list is painful.
 .TP
 .B \-E, \-\-events
 Continually display sockets as they are destroyed
diff --git a/misc/ss.c b/misc/ss.c
index 26520cee..708b5cf7 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -473,17 +473,6 @@ static void filter_merge_defaults(struct filter *f)
 	}
 }
 
-#define net_tcp_open()		generic_proc_open("PROC_NET_TCP", "net/tcp")
-#define net_tcp6_open()		generic_proc_open("PROC_NET_TCP6", "net/tcp6")
-#define net_udp_open()		generic_proc_open("PROC_NET_UDP", "net/udp")
-#define net_udp6_open()		generic_proc_open("PROC_NET_UDP6", "net/udp6")
-#define net_raw_open()		generic_proc_open("PROC_NET_RAW", "net/raw")
-#define net_raw6_open()		generic_proc_open("PROC_NET_RAW6", "net/raw6")
-#define net_unix_open()		generic_proc_open("PROC_NET_UNIX", "net/unix")
-#define net_packet_open()	generic_proc_open("PROC_NET_PACKET", \
-							"net/packet")
-#define net_netlink_open()	generic_proc_open("PROC_NET_NETLINK", \
-							"net/netlink")
 #define net_sockstat_open()	generic_proc_open("PROC_NET_SOCKSTAT", \
 							"net/sockstat")
 #define net_sockstat6_open()	generic_proc_open("PROC_NET_SOCKSTAT6", \
@@ -809,7 +798,6 @@ struct sockstat {
 	int		    rq, wq;
 	unsigned int ino;
 	unsigned int uid;
-	int		    refcnt;
 	unsigned int	    iface;
 	unsigned long long  sk;
 	char *name;
@@ -2481,55 +2469,6 @@ static void inet_stats_print(struct sockstat *s, bool v6only)
 	proc_ctx_print(s);
 }
 
-static int proc_parse_inet_addr(char *loc, char *rem, int family, struct
-		sockstat * s)
-{
-	s->local.family = s->remote.family = family;
-	if (family == AF_INET) {
-		sscanf(loc, "%x:%lx", s->local.data, (unsigned long *)&s->lport);
-		sscanf(rem, "%x:%lx", s->remote.data, (unsigned long *)&s->rport);
-		s->local.bytelen = s->remote.bytelen = 4;
-		return 0;
-	} else {
-		sscanf(loc, "%08x%08x%08x%08x:%lx",
-		       s->local.data,
-		       s->local.data + 1,
-		       s->local.data + 2,
-		       s->local.data + 3,
-		       (unsigned long *)&s->lport);
-		sscanf(rem, "%08x%08x%08x%08x:%lx",
-		       s->remote.data,
-		       s->remote.data + 1,
-		       s->remote.data + 2,
-		       s->remote.data + 3,
-		       (unsigned long *)&s->rport);
-		s->local.bytelen = s->remote.bytelen = 16;
-		return 0;
-	}
-	return -1;
-}
-
-static int proc_inet_split_line(char *line, char **loc, char **rem, char **data)
-{
-	char *p;
-
-	if ((p = strchr(line, ':')) == NULL)
-		return -1;
-
-	*loc = p+2;
-	if ((p = strchr(*loc, ':')) == NULL)
-		return -1;
-
-	p[5] = 0;
-	*rem = p+6;
-	if ((p = strchr(*rem, ':')) == NULL)
-		return -1;
-
-	p[5] = 0;
-	*data = p+6;
-	return 0;
-}
-
 /*
  * Display bandwidth in standard units
  * See: https://en.wikipedia.org/wiki/Data-rate_units
@@ -2798,98 +2737,6 @@ static void sctp_timer_print(struct tcpstat *s)
 		    print_ms_timer(s->timeout), s->retrans);
 }
 
-static int tcp_show_line(char *line, const struct filter *f, int family)
-{
-	int rto = 0, ato = 0;
-	struct tcpstat s = {};
-	char *loc, *rem, *data;
-	char opt[256];
-	int n;
-	int hz = get_user_hz();
-
-	if (proc_inet_split_line(line, &loc, &rem, &data))
-		return -1;
-
-	int state = (data[1] >= 'A') ? (data[1] - 'A' + 10) : (data[1] - '0');
-
-	if (!(f->states & (1 << state)))
-		return 0;
-
-	proc_parse_inet_addr(loc, rem, family, &s.ss);
-
-	if (f->f && run_ssfilter(f->f, &s.ss) == 0)
-		return 0;
-
-	opt[0] = 0;
-	n = sscanf(data, "%x %x:%x %x:%x %x %d %d %u %d %llx %d %d %d %u %d %[^\n]\n",
-		   &s.ss.state, &s.ss.wq, &s.ss.rq,
-		   &s.timer, &s.timeout, &s.retrans, &s.ss.uid, &s.probes,
-		   &s.ss.ino, &s.ss.refcnt, &s.ss.sk, &rto, &ato, &s.qack, &s.cwnd,
-		   &s.ssthresh, opt);
-
-	if (n < 17)
-		opt[0] = 0;
-
-	if (n < 12) {
-		rto = 0;
-		s.cwnd = 2;
-		s.ssthresh = -1;
-		ato = s.qack = 0;
-	}
-
-	s.retrans   = s.timer != 1 ? s.probes : s.retrans;
-	s.timeout   = (s.timeout * 1000 + hz - 1) / hz;
-	s.ato	    = (double)ato / hz;
-	s.qack	   /= 2;
-	s.rto	    = (double)rto;
-	s.ssthresh  = s.ssthresh == -1 ? 0 : s.ssthresh;
-	s.rto	    = s.rto != 3 * hz  ? s.rto / hz : 0;
-	s.ss.type   = IPPROTO_TCP;
-
-	inet_stats_print(&s.ss, false);
-
-	if (show_options)
-		tcp_timer_print(&s);
-
-	if (show_details) {
-		sock_details_print(&s.ss);
-		if (opt[0])
-			out(" opt:\"%s\"", opt);
-	}
-
-	if (show_tcpinfo)
-		tcp_stats_print(&s);
-
-	return 0;
-}
-
-static int generic_record_read(FILE *fp,
-			       int (*worker)(char*, const struct filter *, int),
-			       const struct filter *f, int fam)
-{
-	char line[256];
-
-	/* skip header */
-	if (fgets(line, sizeof(line), fp) == NULL)
-		goto outerr;
-
-	while (fgets(line, sizeof(line), fp) != NULL) {
-		int n = strlen(line);
-
-		if (n == 0 || line[n-1] != '\n') {
-			errno = -EINVAL;
-			return -1;
-		}
-		line[n-1] = 0;
-
-		if (worker(line, f, fam) < 0)
-			return 0;
-	}
-outerr:
-
-	return ferror(fp) ? -1 : 0;
-}
-
 static void print_skmeminfo(struct rtattr *tb[], int attrtype)
 {
 	const __u32 *skmeminfo;
@@ -4231,10 +4078,6 @@ static int tcp_show_netlink_file(struct filter *f)
 
 static int tcp_show(struct filter *f)
 {
-	FILE *fp = NULL;
-	char *buf = NULL;
-	int bufsize = 1024*1024;
-
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
@@ -4243,52 +4086,7 @@ static int tcp_show(struct filter *f)
 	if (getenv("TCPDIAG_FILE"))
 		return tcp_show_netlink_file(f);
 
-	if (!getenv("PROC_NET_TCP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_TCP) == 0)
-		return 0;
-
-	/* Sigh... We have to parse /proc/net/tcp... */
-	while (bufsize >= 64*1024) {
-		if ((buf = malloc(bufsize)) != NULL)
-			break;
-		bufsize /= 2;
-	}
-	if (buf == NULL) {
-		errno = ENOMEM;
-		return -1;
-	}
-
-	if (f->families & FAMILY_MASK(AF_INET)) {
-		if ((fp = net_tcp_open()) == NULL)
-			goto outerr;
-
-		setbuffer(fp, buf, bufsize);
-		if (generic_record_read(fp, tcp_show_line, f, AF_INET))
-			goto outerr;
-		fclose(fp);
-	}
-
-	if ((f->families & FAMILY_MASK(AF_INET6)) &&
-	    (fp = net_tcp6_open()) != NULL) {
-		setbuffer(fp, buf, bufsize);
-		if (generic_record_read(fp, tcp_show_line, f, AF_INET6))
-			goto outerr;
-		fclose(fp);
-	}
-
-	free(buf);
-	return 0;
-
-outerr:
-	do {
-		int saved_errno = errno;
-
-		free(buf);
-		if (fp)
-			fclose(fp);
-		errno = saved_errno;
-		return -1;
-	} while (0);
+	return inet_show_netlink(f, NULL, IPPROTO_TCP);
 }
 
 static int mptcp_show(struct filter *f)
@@ -4296,11 +4094,7 @@ static int mptcp_show(struct filter *f)
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
-	if (!getenv("PROC_NET_MPTCP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_MPTCP) == 0)
-		return 0;
-
-	return 0;
+	return inet_show_netlink(f, NULL, IPPROTO_MPTCP);
 }
 
 static int sctp_show(struct filter *f)
@@ -4308,140 +4102,27 @@ static int sctp_show(struct filter *f)
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
-	if (!getenv("PROC_NET_SCTP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_SCTP) == 0)
-		return 0;
-
-	return 0;
-}
-
-static int dgram_show_line(char *line, const struct filter *f, int family)
-{
-	struct sockstat s = {};
-	char *loc, *rem, *data;
-	char opt[256];
-	int n;
-
-	if (proc_inet_split_line(line, &loc, &rem, &data))
-		return -1;
-
-	int state = (data[1] >= 'A') ? (data[1] - 'A' + 10) : (data[1] - '0');
-
-	if (!(f->states & (1 << state)))
-		return 0;
-
-	proc_parse_inet_addr(loc, rem, family, &s);
-
-	if (f->f && run_ssfilter(f->f, &s) == 0)
-		return 0;
-
-	opt[0] = 0;
-	n = sscanf(data, "%x %x:%x %*x:%*x %*x %d %*d %u %d %llx %[^\n]\n",
-	       &s.state, &s.wq, &s.rq,
-	       &s.uid, &s.ino,
-	       &s.refcnt, &s.sk, opt);
-
-	if (n < 9)
-		opt[0] = 0;
-
-	s.type = dg_proto == UDP_PROTO ? IPPROTO_UDP : 0;
-	inet_stats_print(&s, false);
-
-	if (show_details && opt[0])
-		out(" opt:\"%s\"", opt);
-
-	return 0;
+	return inet_show_netlink(f, NULL, IPPROTO_SCTP);
 }
 
 static int udp_show(struct filter *f)
 {
-	FILE *fp = NULL;
-
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
 	dg_proto = UDP_PROTO;
 
-	if (!getenv("PROC_NET_UDP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_UDP) == 0)
-		return 0;
-
-	if (f->families&FAMILY_MASK(AF_INET)) {
-		if ((fp = net_udp_open()) == NULL)
-			goto outerr;
-		if (generic_record_read(fp, dgram_show_line, f, AF_INET))
-			goto outerr;
-		fclose(fp);
-	}
-
-	if ((f->families&FAMILY_MASK(AF_INET6)) &&
-	    (fp = net_udp6_open()) != NULL) {
-		if (generic_record_read(fp, dgram_show_line, f, AF_INET6))
-			goto outerr;
-		fclose(fp);
-	}
-	return 0;
-
-outerr:
-	do {
-		int saved_errno = errno;
-
-		if (fp)
-			fclose(fp);
-		errno = saved_errno;
-		return -1;
-	} while (0);
+	return inet_show_netlink(f, NULL, IPPROTO_UDP);
 }
 
 static int raw_show(struct filter *f)
 {
-	FILE *fp = NULL;
-
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
 	dg_proto = RAW_PROTO;
 
-	if (!getenv("PROC_NET_RAW") && !getenv("PROC_ROOT") &&
-	    inet_show_netlink(f, NULL, IPPROTO_RAW) == 0)
-		return 0;
-
-	if (f->families&FAMILY_MASK(AF_INET)) {
-		if ((fp = net_raw_open()) == NULL)
-			goto outerr;
-		if (generic_record_read(fp, dgram_show_line, f, AF_INET))
-			goto outerr;
-		fclose(fp);
-	}
-
-	if ((f->families&FAMILY_MASK(AF_INET6)) &&
-	    (fp = net_raw6_open()) != NULL) {
-		if (generic_record_read(fp, dgram_show_line, f, AF_INET6))
-			goto outerr;
-		fclose(fp);
-	}
-	return 0;
-
-outerr:
-	do {
-		int saved_errno = errno;
-
-		if (fp)
-			fclose(fp);
-		errno = saved_errno;
-		return -1;
-	} while (0);
-}
-
-#define MAX_UNIX_REMEMBER (1024*1024/sizeof(struct sockstat))
-
-static void unix_list_drop_first(struct sockstat **list)
-{
-	struct sockstat *s = *list;
-
-	(*list) = (*list)->next;
-	free(s->name);
-	free(s);
+	return inet_show_netlink(f, NULL, IPPROTO_RAW);
 }
 
 static bool unix_type_skip(struct sockstat *s, struct filter *f)
@@ -4569,10 +4250,13 @@ Exit:
 	return ret;
 }
 
-static int unix_show_netlink(struct filter *f)
+static int unix_show(struct filter *f)
 {
 	DIAG_REQUEST(req, struct unix_diag_req r);
 
+	if (!filter_af_get(f, AF_UNIX))
+		return 0;
+
 	req.r.sdiag_family = AF_UNIX;
 	req.r.udiag_states = f->states;
 	req.r.udiag_show = UDIAG_SHOW_NAME | UDIAG_SHOW_PEER | UDIAG_SHOW_RQLEN;
@@ -4584,139 +4268,6 @@ static int unix_show_netlink(struct filter *f)
 	return handle_netlink_request(f, &req.nlh, sizeof(req), unix_show_sock);
 }
 
-static int unix_show(struct filter *f)
-{
-	FILE *fp;
-	char buf[256];
-	char name[128];
-	int  newformat = 0;
-	int  cnt;
-	struct sockstat *list = NULL;
-	const int unix_state_map[] = { SS_CLOSE, SS_SYN_SENT,
-				       SS_ESTABLISHED, SS_CLOSING };
-
-	if (!filter_af_get(f, AF_UNIX))
-		return 0;
-
-	if (!getenv("PROC_NET_UNIX") && !getenv("PROC_ROOT")
-	    && unix_show_netlink(f) == 0)
-		return 0;
-
-	if ((fp = net_unix_open()) == NULL)
-		return -1;
-	if (!fgets(buf, sizeof(buf), fp)) {
-		fclose(fp);
-		return -1;
-	}
-
-	if (memcmp(buf, "Peer", 4) == 0)
-		newformat = 1;
-	cnt = 0;
-
-	while (fgets(buf, sizeof(buf), fp)) {
-		struct sockstat *u, **insp;
-		int flags;
-
-		if (!(u = calloc(1, sizeof(*u))))
-			break;
-
-		if (sscanf(buf, "%lx: %x %x %x %x %x %d %s",
-			   (unsigned long *)&u->rport, &u->rq, &u->wq, &flags, &u->type,
-			   &u->state, &u->ino, name) < 8)
-			name[0] = 0;
-
-		u->lport = u->ino;
-		u->local.family = u->remote.family = AF_UNIX;
-
-		if (flags & (1 << 16)) {
-			u->state = SS_LISTEN;
-		} else if (u->state > 0 &&
-			   u->state <= ARRAY_SIZE(unix_state_map)) {
-			u->state = unix_state_map[u->state-1];
-			if (u->type == SOCK_DGRAM && u->state == SS_CLOSE && u->rport)
-				u->state = SS_ESTABLISHED;
-		}
-		if (unix_type_skip(u, f) ||
-		    !(f->states & (1 << u->state))) {
-			free(u);
-			continue;
-		}
-
-		if (!newformat) {
-			u->rport = 0;
-			u->rq = 0;
-			u->wq = 0;
-		}
-
-		if (name[0]) {
-			u->name = strdup(name);
-			if (!u->name) {
-				free(u);
-				break;
-			}
-		}
-
-		if (u->rport) {
-			struct sockstat *p;
-
-			for (p = list; p; p = p->next) {
-				if (u->rport == p->lport)
-					break;
-			}
-			if (!p)
-				u->peer_name = "?";
-			else
-				u->peer_name = p->name ? : "*";
-		}
-
-		if (f->f) {
-			struct sockstat st = {
-				.local.family = AF_UNIX,
-				.remote.family = AF_UNIX,
-			};
-
-			memcpy(st.local.data, &u->name, sizeof(u->name));
-			/* when parsing the old format rport is set to 0 and
-			 * therefore peer_name remains NULL
-			 */
-			if (u->peer_name && strcmp(u->peer_name, "*"))
-				memcpy(st.remote.data, &u->peer_name,
-				       sizeof(u->peer_name));
-			if (run_ssfilter(f->f, &st) == 0) {
-				free(u->name);
-				free(u);
-				continue;
-			}
-		}
-
-		insp = &list;
-		while (*insp) {
-			if (u->type < (*insp)->type ||
-			    (u->type == (*insp)->type &&
-			     u->ino < (*insp)->ino))
-				break;
-			insp = &(*insp)->next;
-		}
-		u->next = *insp;
-		*insp = u;
-
-		if (++cnt > MAX_UNIX_REMEMBER) {
-			while (list) {
-				unix_stats_print(list, f);
-				unix_list_drop_first(&list);
-			}
-			cnt = 0;
-		}
-	}
-	fclose(fp);
-	while (list) {
-		unix_stats_print(list, f);
-		unix_list_drop_first(&list);
-	}
-
-	return 0;
-}
-
 static int packet_stats_print(struct sockstat *s, const struct filter *f)
 {
 	const char *addr, *port;
@@ -4777,10 +4328,6 @@ static int packet_show_sock(struct nlmsghdr *nlh, void *arg)
 	parse_rtattr(tb, PACKET_DIAG_MAX, (struct rtattr *)(r+1),
 		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
 
-	/* use /proc/net/packet if all info are not available */
-	if (!tb[PACKET_DIAG_MEMINFO])
-		return -1;
-
 	stat.type   = r->pdiag_type;
 	stat.prot   = r->pdiag_num;
 	stat.ino    = r->pdiag_ino;
@@ -4905,10 +4452,13 @@ static int packet_show_sock(struct nlmsghdr *nlh, void *arg)
 	return 0;
 }
 
-static int packet_show_netlink(struct filter *f)
+static int packet_show(struct filter *f)
 {
 	DIAG_REQUEST(req, struct packet_diag_req r);
 
+	if (!filter_af_get(f, AF_PACKET) || !(f->states & (1 << SS_CLOSE)))
+		return 0;
+
 	req.r.sdiag_family = AF_PACKET;
 	req.r.pdiag_show = PACKET_SHOW_INFO | PACKET_SHOW_MEMINFO |
 		PACKET_SHOW_FILTER | PACKET_SHOW_RING_CFG | PACKET_SHOW_FANOUT;
@@ -4916,58 +4466,6 @@ static int packet_show_netlink(struct filter *f)
 	return handle_netlink_request(f, &req.nlh, sizeof(req), packet_show_sock);
 }
 
-static int packet_show_line(char *buf, const struct filter *f, int fam)
-{
-	unsigned long long sk;
-	struct sockstat stat = {};
-	int type, prot, iface, state, rq, uid, ino;
-
-	sscanf(buf, "%llx %*d %d %x %d %d %u %u %u",
-			&sk,
-			&type, &prot, &iface, &state,
-			&rq, &uid, &ino);
-
-	if (type == SOCK_RAW && !(f->dbs & (1<<PACKET_R_DB)))
-		return 0;
-	if (type == SOCK_DGRAM && !(f->dbs & (1<<PACKET_DG_DB)))
-		return 0;
-
-	stat.type  = type;
-	stat.prot  = prot;
-	stat.lport = stat.iface = iface;
-	stat.state = state;
-	stat.rq    = rq;
-	stat.uid   = uid;
-	stat.ino   = ino;
-	stat.state = SS_CLOSE;
-
-	if (packet_stats_print(&stat, f))
-		return 0;
-
-	return 0;
-}
-
-static int packet_show(struct filter *f)
-{
-	FILE *fp;
-	int rc = 0;
-
-	if (!filter_af_get(f, AF_PACKET) || !(f->states & (1 << SS_CLOSE)))
-		return 0;
-
-	if (!getenv("PROC_NET_PACKET") && !getenv("PROC_ROOT") &&
-			packet_show_netlink(f) == 0)
-		return 0;
-
-	if ((fp = net_packet_open()) == NULL)
-		return -1;
-	if (generic_record_read(fp, packet_show_line, f, AF_PACKET))
-		rc = -1;
-
-	fclose(fp);
-	return rc;
-}
-
 static int xdp_stats_print(struct sockstat *s, const struct filter *f)
 {
 	const char *addr, *port;
@@ -5263,10 +4761,13 @@ static int netlink_show_sock(struct nlmsghdr *nlh, void *arg)
 	return 0;
 }
 
-static int netlink_show_netlink(struct filter *f)
+static int netlink_show(struct filter *f)
 {
 	DIAG_REQUEST(req, struct netlink_diag_req r);
 
+	if (!filter_af_get(f, AF_NETLINK) || !(f->states & (1 << SS_CLOSE)))
+		return 0;
+
 	req.r.sdiag_family = AF_NETLINK;
 	req.r.sdiag_protocol = NDIAG_PROTO_ALL;
 	req.r.ndiag_show = NDIAG_SHOW_GROUPS | NDIAG_SHOW_MEMINFO;
@@ -5274,41 +4775,6 @@ static int netlink_show_netlink(struct filter *f)
 	return handle_netlink_request(f, &req.nlh, sizeof(req), netlink_show_sock);
 }
 
-static int netlink_show(struct filter *f)
-{
-	FILE *fp;
-	char buf[256];
-	int prot, pid;
-	unsigned int groups;
-	int rq, wq, rc;
-	unsigned long long sk, cb;
-
-	if (!filter_af_get(f, AF_NETLINK) || !(f->states & (1 << SS_CLOSE)))
-		return 0;
-
-	if (!getenv("PROC_NET_NETLINK") && !getenv("PROC_ROOT") &&
-		netlink_show_netlink(f) == 0)
-		return 0;
-
-	if ((fp = net_netlink_open()) == NULL)
-		return -1;
-	if (!fgets(buf, sizeof(buf), fp)) {
-		fclose(fp);
-		return -1;
-	}
-
-	while (fgets(buf, sizeof(buf), fp)) {
-		sscanf(buf, "%llx %d %d %x %d %d %llx %d",
-		       &sk,
-		       &prot, &pid, &groups, &rq, &wq, &cb, &rc);
-
-		netlink_show_one(f, prot, pid, groups, 0, 0, 0, rq, wq, sk, cb);
-	}
-
-	fclose(fp);
-	return 0;
-}
-
 static bool vsock_type_skip(struct sockstat *s, struct filter *f)
 {
 	if (s->type == SOCK_STREAM && !(f->dbs & (1 << VSOCK_ST_DB)))
-- 
2.53.0

