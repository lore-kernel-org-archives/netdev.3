Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259566;
	b=znG9r6CVR/tioK1fuwalePaFHOIrRsJqp0h/zxhTA133i/x/ajzLw9Ee84cY8EyrMPv9
	 20BJoMl+zrYqcxEUlRzK5lCtOiB9rGm62CTqkvwm0d9D3zpIrFLOqb3PTb2YAgaQ09nrY
	 lOJCrtuewhmkEoTzy6JC9YQtgKxky23rWhHz3Mzhd8b3QLBrasq5EUQZ2TSe7tsnK2ndx
	 qIgq/C9ly9+G+ZNABitWuNpsis5os3gSM3zuRhQVmKXbXaSLGgUl+2nVLInEQQ1867Z8i
	 hC5BFRIjahgt0Ima3I9GopGGI//nqf4L5gefO40v/SHrfFCEvUA3nRG2b3bS2tJlqbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lM1S3yCi7W1L8pGhLjYyZcTdL1R1hF1+jBWugbgus8w=;
	b=F6TXicpV0nlI0ENFGztFG9MstkThIeauE2k1q3GiqmiCy6+qLvMLn8tXKQY9unn4OLn3
	 kwqLbAdD5SkQuKGrjR1Pf1ShByXDNDTLi8c1Dxx6YoQr66cIhFgNrKH+Dy5tkLgO8/dnw
	 QdXCF8W1J/vUeP/tTzC7uQWvO53uqzJSe65HaVMnqmwb3bl0kjtMP8K1hn+ThOOWjkJmG
	 +uhQ4sqvSIjeDKzs/FLIBQRbM5abwU55nwpO5k9jsNs4OV+fB0y7FS6BWTWnxsy8IJmyX
	 axi1f32MXpITkbsh9DCp3xj3n/duVRsrbfxpjlFrFgHDtbMPPuH8gc7WKVOCIshlv0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Qn3th/TA";
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF7606A33B
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69DF7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Qn3th/TA
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so746827b3a.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259565; x=1794864365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lM1S3yCi7W1L8pGhLjYyZcTdL1R1hF1+jBWugbgus8w=;
        b=Qn3th/TAh2uOzjSS6O9ztu+diDxQK2XVxUo6spi29q3fnHrvzn9agPf4mFVQYrdETN
         Eg2ccnfq309yqLKCMIahFUSDAl0u8qZQgEmO875xGCU03zSQzucHmj/Tfxh3Rzj8RNQZ
         44kfQj1wLo0+0jaX/b2ub3JDS+kOvHf9BUMWRpmNKNinQvAI1iMMOBj5fYFS3LxZa1p0
         MNIzB07M/l10D5MpfHbbhbbZ/hG9GILQU4aqjSzedZiJhD/TLlL752ZdqVOYRi3HT7Tu
         wd6O02ySV5rDorO2XrNmpD2D4mWAI3KXSb1uvkKH+cwt3TW0Fqyds5FcFOpEAs8Xvcki
         kbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259565; x=1794864365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lM1S3yCi7W1L8pGhLjYyZcTdL1R1hF1+jBWugbgus8w=;
        b=exnJQ4c2e9uYDpB5GEAeyfiyKL623ea7/VQneGRlVsc4qNdhD9X9y5j5qnhbqRkW82
         2M9cQz48eQMzwkWbfIlqcjQg0ajWD0PwrRaISnscTMo5aDyNSf71Ty/Cz4+wYngbKy5f
         0qAC+8vI8CWccqduQTLs9nmzt22UKwx2aGIDzIX2lPpXJ/wCvxNZRp7eP9BCo0IA94q8
         ObuO2Bi4I5bLYcORKk05eKPYah0vQZGvhzGQgcc/rLC2P80lXwwXILNCzwSERfScaOxv
         8w7pWnCr6AbTiGZnyr4wumn5rK7HMh2ceuT0WQKNuL9RqPBuiWt11fY1hP8CtkY7HW1g
         SdmQ==
X-Gm-Message-State: APuU4Z8JgjbAogRjzKyvem+/rCZEwfDsBIkkYFVdgZRfR+exwJSs93Np
	FbhDxBjzfq4c+TgHzFmKBstjLB5QfDxwWNOfmUn75szSx+z5kvFiRNwvoJ4w2CjaXjUgGaj60Sf
	iFs5NQ7E=
X-Gm-Gg: AYBFou1LtKbC9EXz538CEF7RRxKYvAhhIWUNitxCtxBahjTydONBYYC8on1H7ZkgUsD
	DR+SQP6NHNRe06fWkj+8D/TP6/xm9jpq0EEVGSdbP2UoBRtlBzgO4YwIls1V98jLa1c9u4Yfop8
	FyHcuMb2YBxHm6Kg6fn5h7ej9RTlanFx3q8uvtua/6DXheeIl1hn9gnOWvRCca82NsW9sIdc7ov
	5he14jEErImmYftNYjy92K2bzHMq6cEvuxC2apnRg7BDv0RiIV3AIYz4KmYshYxb0Vzkfn1NLL4
	Zrv6Y+zA3vDs0Vep+ao8YiJtI6tVON3HTwGIDkMJIJN9L+Zhsp6rocK/WtiZJf8f5nd/gK/mDqE
	gZdx5vk1/4+NA90R8v+noVrKSTZmSLp2oXHt6cAMeZr8iCFCXD/YkLFOKqsjV71uAeotzOdqafA
	cjULg+wYhnjHnBh61QxlF2uMZjL2ZYESZV4lf0xeXIBYit1lgFcl0Ey06FIuZMqsRQb430ncGCX
	rnFEZ/YdHOekwRX7V5ZW4cfH93hcflLTAXqowRWKl5FziBnVy13z6djKxcESvx6mAFqPSYs2kdw
	pBpUS/ffz7Z8TdE/Wmtj8a89YmxykHTsbSNpUJrUJDRAQrIouI3sWAMYchL8jEQGJF0uGQ==
X-Received: by 2002:a05:6a00:1802:b0:8b9:3df3:5106 with SMTP id d2e1a72fcca58-8ba94740427mr521804b3a.7.1794259564569;
        Mon, 09 Nov 2026 13:26:04 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 02/11] ss: drop /proc fallback for socket listing
Date: Mon,  9 Nov 2026 13:25:18 -0800
Message-ID: <20261109212559.39661-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109212559.39661-1-stephen@networkplumber.org>
References: <20261109212559.39661-1-stephen@networkplumber.org>
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
Assisted-by: Claude:claude-opus-5
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

