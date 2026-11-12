Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513652;
	b=r+Y5QVPu6iRL4cVKQnCiBcqBjq6EkPY9UtASAhQUGxscOzburyXvU8TlOCIfxeYgoRZy
	 Kx3ZjKjicW3XcS3PiL2Z1e7Z7lVX9Le27folHvvxJsT2z9yFwaHBFVMtv6h47DN5vGOD0
	 uVilSQ0f4frvMc+MMpJ23SFjpDEteaq4rHj6Um2CMVPGQwMSaQ69xe+WUYsadGWZmcWVb
	 8wkxlGyjiJzgAuuT9S1yVxtfuBzVcNnnxAc6mAY5+SNOc8ys0aw+ymtsqWcxxt+/57pJb
	 XoXLB0D42uDnL/24wFjNeEL+rZhz9vmn2VZz1cTua4hqPKCsiJBgfF/MnMZZQpIdsLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cFbEUdx173v4E98/u7fzfTGeKT8RRaWRFQ8SI44i5Qw=;
	b=K4dUUrnuLkjlV51wBRZK8KRRMHPs99wWieCFS2blT/aueR/dwq4HT01IOuDN26QVhRAY
	 22/CcsZhakrhRu8VYELnvVqxKXOylM7PgILhLsJxfaQJZIkjXOmLiHsfoZOh1EkPF1pxC
	 pGJgZqULpx/RzAIat0AEt/hvHMo80ebBUv+kpjR3pvJy7iqEDckPia8nRdX0+N+2alykG
	 6/3xDItqZ0qaDDQFLxmp9m/mYOVW9Fw9JKc/vAHBOarDgDFE3dYQtg3DHyNiJHZdtXcW4
	 wd8xAQujKKVjMyXJeH4gOVwBP4VnVT22rI2pf9HrSNSKgGhPOpKhVcjJrEupDzLnURg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=R8M+Fxv6;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59EC606A338
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B59EC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=R8M+Fxv6
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so150929a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513651; x=1795118451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFbEUdx173v4E98/u7fzfTGeKT8RRaWRFQ8SI44i5Qw=;
        b=R8M+Fxv6eBN4NbKiIVs3F9yUplWC0EqG/BqvM1c/AXqS6doIeOXTYC3Ngqoutqc9Md
         ij6sBzsNFg8lUA0AzJQpnuyiRYH6Fs6KyP5DU32MKSsnuuNEvbr0e2EQqjioQMaDUqtP
         381TvtdK45TLqQEWMOB901CoPh0tX4mJwz/GykUiXNoZY/Tn//PGEyxhFggNoX6ggYD8
         yqIq7qx4Fl5pRMox8MoiA3ZaiunNPRD5b05kdJWs8jd8NyanoovZcLFu960w3srbueJL
         DU1coGH9jJ63dvMHTg95yrSUItxTFa7ev7MOZVXb4w5Yi0GBWDHrff+a1d7O6UxDJdTI
         7OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513651; x=1795118451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cFbEUdx173v4E98/u7fzfTGeKT8RRaWRFQ8SI44i5Qw=;
        b=y5svNjuulS7TApM5qTMwh/skrPZR7LVea2wk/rYxiYO8pPWhJUbO6SXkkc8ECxoG+A
         fwC6z2LWJlA1KrkiqAGqfsmscGjmGhE0aNyvFDXeU5yHBlITdReTH23xo+Ah7+9JESkB
         PR1n68nvsWz6At3UgVIEXMrcPN2SeolJDOFEpm/oOjcZyN74qzIg9cQDhDqVckyvCiWD
         8YI8lGw+IyAXIdjrAP51pGc8gZu5HTeMIU9q7lTlTrt0peftMTHYXv8QvOldki1wWAHK
         TYGc6eG4iiVz5lFmCohbLBhNGcMZ3x4/s3+EQY/Kmkbe9mDvWpoVSivYU3MZ71L1pPcl
         sa0Q==
X-Gm-Message-State: APuU4Z+joFBK+77nOMUls1b9x99zbGq92U0xNI6j7lQjOULIwtU3dqwc
	PpDsb320eR+kpONh7/m8ot5vaW1epwA7m7TMogjgl/QVNN0v6iIxOIbRlGXO21qUgUQO5Edld6f
	nqERfWjE=
X-Gm-Gg: AYBFou01mK9GDj0Z8anj7sdSjVPUuGLH1UbnpEnkqIWgAO0ibgkpTwrxM5DCfWpfLP5
	Hoqw6K8ouRU9divzKUmHOpj48mWmbBqtSkVMsAE6f8QaMxhIMiX5YO0gKoYkn3qddsfwm30KrDH
	VjUnXQPDeBJiqqaaNh/OWsEWtmOZj6pakW2c3LAeVd8YzaF1sXug924sZsXVljmUqrWUVFd73RY
	Yqn9FdB/r0gnyNOjY8nkWu9i39CJeqdZba96GuhYhxKK+I7fhqn0yQsXeRolMazxKUvsZQJM4Bf
	AFU62OX1gIUYSv7QsK38wFfioYxIHI3wdJNoYkWw9UsJh0fge9kAwfIkoXjMstadJ1ErzR1pC2A
	OYrufTaj749xOEFjZNmIJ8+IR2MMR5ZhpHrFBKVq8qdPfH+iEmaNqCA7iKnoBKfh3JDVpTUXYQT
	QQlYnPaRC2LQBUfuT6oxGT/1l1uApH/SjmXOYYuTLHfTeCPoH6/5G9JnUzp1RWMG/1VT1ysJOSG
	8r2FBb+pRI679pQDofMD3Xf6iT5GVp8u+m8cbTjJEPOI6uZZvg0KuRLtCs7xJuM6QWVxlqZUPu8
	LSur6Boe0PpsMHUG1JDVuOMairBuPC6HLduwwAlvJ7Nhj42jZDiO7++yxf+iVZ6OJWR+NJg=
X-Received: by 2002:a17:90b:4ec5:b0:3ad:b86d:dbad with SMTP id 98e67ed59e1d1-3b1b0a0dd02mr147371a91.30.1794513650806;
        Thu, 12 Nov 2026 12:00:50 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 02/11] ss: drop /proc fallback for socket listing
Date: Thu, 12 Nov 2026 11:59:15 -0800
Message-ID: <20261112200046.2164391-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
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

All socket families ss lists from /proc (tcp, udp, raw, unix, packet,
netlink) have had sock_diag support since well before the oldest
supported LTS kernel. The /proc parsers are rarely used, untested,
and trust file contents that unprivileged users can partly control;
a unix socket name containing a newline can forge a /proc/net/unix
line with an out of range state and crash ss.

Remove the fallback and print an error if the kernel can not dump a
socket family. The TCPDIAG_GETSOCK retry goes with it; that request
is only needed for kernels older than 3.3. /proc is still used for
-s and process info.

Reported-by: Anthropic OSS scanner (ANT-2026-TNFMK5ZB)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 626 +++---------------------------------------------------
 1 file changed, 28 insertions(+), 598 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 674ed8e8..b93df60f 100644
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
@@ -2477,55 +2466,6 @@ static void inet_stats_print(struct sockstat *s, bool v6only)
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
@@ -2794,98 +2734,6 @@ static void sctp_timer_print(struct tcpstat *s)
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
@@ -3867,76 +3715,6 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	return 0;
 }
 
-static int tcpdiag_send(int fd, int protocol, struct filter *f)
-{
-	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
-	struct {
-		struct nlmsghdr nlh;
-		struct inet_diag_req r;
-	} req = {
-		.nlh.nlmsg_len = sizeof(req),
-		.nlh.nlmsg_flags = NLM_F_ROOT | NLM_F_MATCH | NLM_F_REQUEST,
-		.nlh.nlmsg_seq = MAGIC_SEQ,
-		.r.idiag_family = AF_INET,
-		.r.idiag_states = f->states,
-	};
-	char    *bc = NULL;
-	int	bclen;
-	struct msghdr msg;
-	struct rtattr rta;
-	struct iovec iov[3];
-	int iovlen = 1;
-
-	if (protocol == IPPROTO_TCP)
-		req.nlh.nlmsg_type = TCPDIAG_GETSOCK;
-	else
-		return -1;
-
-	if (show_mem) {
-		req.r.idiag_ext |= (1<<(INET_DIAG_MEMINFO-1));
-		req.r.idiag_ext |= (1<<(INET_DIAG_SKMEMINFO-1));
-	}
-
-	if (show_tcpinfo) {
-		req.r.idiag_ext |= (1<<(INET_DIAG_INFO-1));
-		req.r.idiag_ext |= (1<<(INET_DIAG_VEGASINFO-1));
-		req.r.idiag_ext |= (1<<(INET_DIAG_CONG-1));
-	}
-
-	if (show_tos) {
-		req.r.idiag_ext |= (1<<(INET_DIAG_TOS-1));
-		req.r.idiag_ext |= (1<<(INET_DIAG_TCLASS-1));
-	}
-
-	iov[0] = (struct iovec){
-		.iov_base = &req,
-		.iov_len = sizeof(req)
-	};
-	if (f->f) {
-		bclen = ssfilter_bytecompile(f->f, &bc);
-		if (bclen) {
-			rta.rta_type = INET_DIAG_REQ_BYTECODE;
-			rta.rta_len = RTA_LENGTH(bclen);
-			iov[1] = (struct iovec){ &rta, sizeof(rta) };
-			iov[2] = (struct iovec){ bc, bclen };
-			req.nlh.nlmsg_len += RTA_LENGTH(bclen);
-			iovlen = 3;
-		}
-	}
-
-	msg = (struct msghdr) {
-		.msg_name = (void *)&nladdr,
-		.msg_namelen = sizeof(nladdr),
-		.msg_iov = iov,
-		.msg_iovlen = iovlen,
-	};
-
-	if (sendmsg(fd, &msg, 0) < 0)
-		return -1;
-
-	return 0;
-}
-
 static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 {
 	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
@@ -3951,9 +3729,6 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 	struct iovec iov[6];
 	int iovlen = 1;
 
-	if (family == PF_UNSPEC)
-		return tcpdiag_send(fd, protocol, f);
-
 	memset(&req.r, 0, sizeof(req.r));
 	req.r.sdiag_family = family;
 	req.r.sdiag_protocol = protocol;
@@ -4131,13 +3906,8 @@ again:
 	if ((err = sockdiag_send(family, rth.fd, protocol, f)))
 		goto Exit;
 
-	if ((err = rtnl_dump_filter(&rth, show_one_inet_sock, &arg))) {
-		if (family != PF_UNSPEC) {
-			family = PF_UNSPEC;
-			goto again;
-		}
+	if ((err = rtnl_dump_filter(&rth, show_one_inet_sock, &arg)))
 		goto Exit;
-	}
 	if (family == PF_INET && preferred_family != PF_INET) {
 		family = PF_INET6;
 		goto again;
@@ -4222,12 +3992,20 @@ static int tcp_show_netlink_file(struct filter *f)
 	return err;
 }
 
-static int tcp_show(struct filter *f)
+static int sock_diag_error(const char *what)
 {
-	FILE *fp = NULL;
-	char *buf = NULL;
-	int bufsize = 1024*1024;
+	if (errno == ENOENT || errno == EOPNOTSUPP)
+		fprintf(stderr,
+			"Cannot dump %s sockets: kernel lacks sock_diag support\n",
+			what);
+	else
+		fprintf(stderr, "Cannot dump %s sockets: %s\n",
+			what, strerror(errno));
+	return -1;
+}
 
+static int tcp_show(struct filter *f)
+{
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
@@ -4236,52 +4014,9 @@ static int tcp_show(struct filter *f)
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
+	if (inet_show_netlink(f, NULL, IPPROTO_TCP))
+		return sock_diag_error("TCP");
 	return 0;
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
 }
 
 static int mptcp_show(struct filter *f)
@@ -4289,10 +4024,7 @@ static int mptcp_show(struct filter *f)
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
-	if (!getenv("PROC_NET_MPTCP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_MPTCP) == 0)
-		return 0;
-
+	inet_show_netlink(f, NULL, IPPROTO_MPTCP);
 	return 0;
 }
 
@@ -4301,140 +4033,32 @@ static int sctp_show(struct filter *f)
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
+	inet_show_netlink(f, NULL, IPPROTO_SCTP);
 	return 0;
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
+	if (inet_show_netlink(f, NULL, IPPROTO_UDP))
+		return sock_diag_error("UDP");
 	return 0;
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
+	if (inet_show_netlink(f, NULL, IPPROTO_RAW))
+		return sock_diag_error("RAW");
 	return 0;
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
 }
 
 static bool unix_type_skip(struct sockstat *s, struct filter *f)
@@ -4579,134 +4203,11 @@ static int unix_show_netlink(struct filter *f)
 
 static int unix_show(struct filter *f)
 {
-	FILE *fp;
-	char buf[256];
-	char name[128];
-	int  newformat = 0;
-	int  cnt;
-	struct sockstat *list = NULL;
-	const int unix_state_map[] = { SS_CLOSE, SS_SYN_SENT,
-				       SS_ESTABLISHED, SS_CLOSING };
-
 	if (!filter_af_get(f, AF_UNIX))
 		return 0;
 
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
+	if (unix_show_netlink(f))
+		return sock_diag_error("UNIX");
 	return 0;
 }
 
@@ -4770,10 +4271,6 @@ static int packet_show_sock(struct nlmsghdr *nlh, void *arg)
 	parse_rtattr(tb, PACKET_DIAG_MAX, (struct rtattr *)(r+1),
 		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
 
-	/* use /proc/net/packet if all info are not available */
-	if (!tb[PACKET_DIAG_MEMINFO])
-		return -1;
-
 	stat.type   = r->pdiag_type;
 	stat.prot   = r->pdiag_num;
 	stat.ino    = r->pdiag_ino;
@@ -4909,56 +4406,14 @@ static int packet_show_netlink(struct filter *f)
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
 static int packet_show(struct filter *f)
 {
-	FILE *fp;
-	int rc = 0;
-
 	if (!filter_af_get(f, AF_PACKET) || !(f->states & (1 << SS_CLOSE)))
 		return 0;
 
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
+	if (packet_show_netlink(f))
+		return sock_diag_error("PACKET");
+	return 0;
 }
 
 static int xdp_stats_print(struct sockstat *s, const struct filter *f)
@@ -5263,36 +4718,11 @@ static int netlink_show_netlink(struct filter *f)
 
 static int netlink_show(struct filter *f)
 {
-	FILE *fp;
-	char buf[256];
-	int prot, pid;
-	unsigned int groups;
-	int rq, wq, rc;
-	unsigned long long sk, cb;
-
 	if (!filter_af_get(f, AF_NETLINK) || !(f->states & (1 << SS_CLOSE)))
 		return 0;
 
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
+	if (netlink_show_netlink(f))
+		return sock_diag_error("NETLINK");
 	return 0;
 }
 
-- 
2.53.0

