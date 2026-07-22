Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E70142E8F1
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753109; cv=none; b=YHOgQXoau5tP9MKPILMrl6I4SYFtmSr1DZDOKf1qW6nYxQL1Zty61s9ngHWzRao5/oGeWJgicafvrCGXQFGlzaBdc+vveTBC1DL1ktj6SpYs12wxkrWLj4dzIahOUxtuIduZdtVE105X7Aity6OP1lfsapHgEPFrZCpf43W8nPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753109; c=relaxed/simple;
	bh=ualrFxAJy1W5bMR758u7WUxfqrNPotQ4bZrqQRXG+NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ9AX5sbjTdTxFlPd8/YfSmEu1PpXPTz5cSi7nyrMIOwniBfUN3hERkusjsBOb860poxeGXqL7YnHf1jXoBWyCreH/R7DOXtnJ+70eQNRyjsJILdg9opQ8sOFaWdllWYeyiRUUL2IPWGOtZJ/Ok0Vb1lwEiOphAvFeu++C4/WcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYESJTrQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYESJTrQ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ee41aaec1so71868597b3.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753106; x=1785357906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GafyVlzH7EDgm5ibwIIRkoiXMQm85aGHNK/M7ty7ih8=;
        b=RYESJTrQGEJieBAwx7pJv2U1415dLSoTcDFwCtaTa/rMW9HGZxbU17zk3RWO2Lr7kv
         qt4KXVMAb4wbFOOHtYgH/Rie7EEwIIL0wvqeSuBvpwNZXtQpFg4UXblDVdKelC7kCgbD
         jTTBdbEjz8S8SssRk+DPwqbhnyV9tFcjXOVIGKXBZNucDMP4f5QHyJGZOBbXk3rj87KA
         xJ8On3OmQHf3pP68mUgsuVf9ytwq08CsxLpOqQvke7aMEKP6r3Pkha8hYfL2Yo0Va1Ll
         3sqBMoB+Y3UGUTFBl8Bkxw1/PWVzvRmthtz33vyuPmxhjiFFFJE23Pb4yY+lLbuwDkjw
         rapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753106; x=1785357906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GafyVlzH7EDgm5ibwIIRkoiXMQm85aGHNK/M7ty7ih8=;
        b=HZrTCS2OtBYh5iq38SzxMQOvmHk0NYiMsIgsvABrd4le8YSj81BR7Pgb1zkZt42hWs
         lIm2zVMMcoVBmaueCwFU1J184cwxDUKvhJXoiEGl0QdnLOZG3yad9LfklWygTmp2u791
         cEOpasOkE2ksuFhOpsNu/BdUkPq+A0OjHW9a57jawSUgb4mLtjX0h+JT9Q0BENtwhybg
         fbigD5ZqwcwCG7aqcnqTkxsVqm4i96/NIA4OJs9gzJswWmDbdQzri+K8LByk8GzvHR6H
         vYBP9J+CVrjlhfxADnkAbB3KYRi5h332igJMyOqlNQ4s87X8AZWJamiuZPFN7jrMJtpc
         AHsw==
X-Gm-Message-State: AOJu0YysWfofa4895fKuqRYdhrqzH0TO9zaRfeRMu+0QDWDPWAC2ibeR
	JG9IAmQleWO6EePscWa+8NDs5gOJT/e947Ni8L2Zm7hrJOa7rPRgFJl6L9e29mWI
X-Gm-Gg: AR+sD10aNOO31jjGk0BYk8u6k4u7gRK4mYixOgqFy2BXzKpykZo6XWMiN8Qttv0//y8
	nXihozth50kcRM0oIsVDtR2VMOUA6W6Z7pn2xs64w1k2u/HW0KUk2M2VJ6AJNsWsUiEpk/iQCp5
	RVi3OAHMjQgV2kb5syE1wsOUf2/EskklAlootz4uh2Fo/P3wsSs1NJkkyWNGWbxzB4MIZEru82m
	nRQBoZ/0oK7O/E9S43kPwNyaCI4U/5/w1j5cMwruFRhcNAlEH6cz4xuJ/DNwy6NyWG+LkyM0e1o
	YtDdBt0inKg7RdXx9axN4BeDCuWS7CngP4KG6W03QcMVIBa5SiEPSLqm4shtWaDD9nlDuqlbsII
	1+IFerFfDKtMUymUT/xDLaRLk/+B270vPC9Uhd0/ngtan9DDGIPaySYOK385p2H7Z5fjDhbV8GH
	IJl7GTBZn8pe98Gkf+PZd9Rj9qs2I3i/gcDbaKWV7tOF60JLqwM3X7tGukqBfYEVF5J7pEBrB/z
	1OUZFsW5PHOXcPx
X-Received: by 2002:a05:690c:670f:b0:81e:6fd:7ca5 with SMTP id 00721157ae682-81f4c2c90cdmr578017b3.44.1784753106417;
        Wed, 22 Jul 2026 13:45:06 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33bf2df0sm19506797b3.6.2026.07.22.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:45:05 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 5/7] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Wed, 22 Jul 2026 16:43:51 -0400
Message-ID: <20260722204454.3234605-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Detect software pacing in so_txtime.c using SO_TIMESTAMPING.

If '-h' (hw) is passed

1. measure sw tx delay with SOF_TIMESTAMPING_TX_SOFTWARE, and
2. fail if delay exceeds a threshold, indicating pacing

Also reorder getopt parameters to make them alphabetical.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/drivers/net/so_txtime.c | 81 ++++++++++++++++---
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 7364ce2bec0b..5900ca97957c 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -42,8 +42,10 @@ static bool	cfg_machine_slow;
 static uint64_t	cfg_start_time_ns;
 static int	cfg_mark;
 static bool	cfg_rx;
+static bool	cfg_verify_hw_offload;
 
 static uint64_t glob_tstart;
+static uint64_t glob_tstart_real;
 static uint64_t tdeliver_max;
 
 static int errors;
@@ -191,12 +193,32 @@ static int do_recv_errqueue_timeout(struct sock_extended_err *err,
 	return 1;
 }
 
+static void do_recv_errqueue_timestamping(struct sock_extended_err *err,
+					  struct scm_timestamping *tss)
+{
+	int64_t ts;
+
+	ts = tss->ts[0].tv_sec;
+	ts *= 1000ULL * 1000 * 1000;
+	ts += tss->ts[0].tv_nsec;
+	ts -= glob_tstart_real;
+	ts /= 1000;
+
+	if (ts > cfg_variance_us) {
+		fprintf(stderr, "sw delay %" PRId64 "us exceeds bounds\n", ts);
+		if (!cfg_machine_slow)
+			errors++;
+	}
+}
+
 static int do_recv_errqueue(int fdt)
 {
 	char control[CMSG_SPACE(sizeof(struct sock_extended_err)) +
+		     CMSG_SPACE(sizeof(struct scm_timestamping)) +
 		     CMSG_SPACE(sizeof(struct sockaddr_in6))] = {0};
 	char data[sizeof(struct ethhdr) + sizeof(struct ipv6hdr) +
 		  sizeof(struct udphdr) + 1];
+	struct scm_timestamping *tss;
 	struct sock_extended_err *err;
 	int ret, num_tstamp = 0;
 	struct msghdr msg = {0};
@@ -222,16 +244,30 @@ static int do_recv_errqueue(int fdt)
 			error(1, 0, "errqueue: flags 0x%x\n", msg.msg_flags);
 
 		cm = CMSG_FIRSTHDR(&msg);
+		tss = NULL;
+
+		if (cm->cmsg_level == SOL_SOCKET &&
+		    cm->cmsg_type == SCM_TIMESTAMPING) {
+			tss = (void *)CMSG_DATA(cm);
+			cm = CMSG_NXTHDR(&msg, cm);
+			if (!cm)
+				error(1, 0, "timestamp missing ip err\n");
+		}
+
 		if (cm->cmsg_level != cfg_errq_level ||
 		    cm->cmsg_type != cfg_errq_type)
 			error(1, 0, "errqueue: type 0x%x.0x%x\n",
 				    cm->cmsg_level, cm->cmsg_type);
 
 		err = (struct sock_extended_err *)CMSG_DATA(cm);
-		if (err->ee_origin != SO_EE_ORIGIN_TXTIME)
+		if (err->ee_origin == SO_EE_ORIGIN_TXTIME)
+			num_tstamp += do_recv_errqueue_timeout(err,
+							       data[ret - 1]);
+		else if (err->ee_origin == SO_EE_ORIGIN_TIMESTAMPING && tss)
+			do_recv_errqueue_timestamping(err, tss);
+		else
 			error(1, 0, "errqueue: origin 0x%x\n", err->ee_origin);
 
-		num_tstamp += do_recv_errqueue_timeout(err, data[ret - 1]);
 		msg.msg_flags = 0;
 		msg.msg_controllen = sizeof(control);
 	}
@@ -256,7 +292,8 @@ static void recv_errqueue_msgs(int fdt)
 		if (num_tstamp == cfg_num_pkt)
 			break;
 
-	} while (gettime_ns(cfg_clockid) < tdeliver_max);
+	} while (gettime_ns(cfg_clockid) <
+		 tdeliver_max + (cfg_variance_us * 1000));
 }
 
 static void start_time_wait(void)
@@ -301,6 +338,18 @@ static void setsockopt_txtime(int fd)
 		error(1, 0, "getsockopt txtime: mismatch");
 }
 
+static void setsockopt_txtimestamping(int fd)
+{
+	int val = SOF_TIMESTAMPING_TX_SOFTWARE |
+		  SOF_TIMESTAMPING_SOFTWARE |
+		  SOF_TIMESTAMPING_OPT_ID |
+		  SOF_TIMESTAMPING_OPT_TSONLY;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
+		       &val, sizeof(val)))
+		error(1, errno, "setsockopt timestamping");
+}
+
 static int setup_tx(struct sockaddr *addr, socklen_t alen)
 {
 	int fd;
@@ -314,6 +363,9 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 	setsockopt_txtime(fd);
 
+	if (cfg_verify_hw_offload)
+		setsockopt_txtimestamping(fd);
+
 	if (cfg_mark &&
 	    setsockopt(fd, SOL_SOCKET, SO_MARK, &cfg_mark, sizeof(cfg_mark)))
 		error(1, errno, "setsockopt mark");
@@ -354,6 +406,7 @@ static void do_test_tx(struct sockaddr *addr, socklen_t alen)
 
 	start_time_wait();
 	glob_tstart = gettime_ns(cfg_clockid);
+	glob_tstart_real = gettime_ns(CLOCK_REALTIME);
 
 	for (i = 0; i < cfg_num_pkt; i++)
 		do_send_one(fdt, &cfg_buf[i]);
@@ -446,10 +499,11 @@ static void usage(const char *progname)
 			"  -6            only IPv6\n"
 			"  -c <clock>    monotonic or tai (default)\n"
 			"  -D <addr>     destination IP address (server)\n"
-			"  -S <addr>     source IP address (client)\n"
+			"  -h            verify hardware offload (tx)\n"
+			"  -m <mark>     socket mark\n"
 			"  -r            run rx mode\n"
+			"  -S <addr>     source IP address (client)\n"
 			"  -t <nsec>     start time (UTC nanoseconds)\n"
-			"  -m <mark>     socket mark\n"
 			"\n",
 			progname);
 	exit(1);
@@ -461,7 +515,7 @@ static void parse_opts(int argc, char **argv)
 	int domain = PF_UNSPEC;
 	int c;
 
-	while ((c = getopt(argc, argv, "46c:S:D:rt:m:")) != -1) {
+	while ((c = getopt(argc, argv, "46c:D:hm:rS:t:")) != -1) {
 		switch (c) {
 		case '4':
 			if (domain != PF_UNSPEC)
@@ -488,21 +542,24 @@ static void parse_opts(int argc, char **argv)
 			else
 				error(1, 0, "unknown clock id %s", optarg);
 			break;
-		case 'S':
-			saddr = optarg;
-			break;
 		case 'D':
 			daddr = optarg;
 			break;
+		case 'h':
+			cfg_verify_hw_offload = true;
+			break;
+		case 'm':
+			cfg_mark = strtol(optarg, NULL, 0);
+			break;
 		case 'r':
 			cfg_rx = true;
 			break;
+		case 'S':
+			saddr = optarg;
+			break;
 		case 't':
 			cfg_start_time_ns = strtoll(optarg, NULL, 0);
 			break;
-		case 'm':
-			cfg_mark = strtol(optarg, NULL, 0);
-			break;
 		default:
 			usage(argv[0]);
 		}
-- 
2.55.0.229.g6434b31f56-goog

