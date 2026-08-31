Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D03A4521
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211953; cv=none; b=C817lwf2MQVqMKWKwbXuHS0tZvIY/bQ51Xed2BjwwRSxeNtbdTS9y4UcZ0+4wYSrGuDroqwszsO/mQ5VO4FWWAQMNtY6Ilc6xuQXV02Ed9S0k2/abBtKkD2gWswaNuq/2GRIzLJst4m4wcKcVZqwkXSJwA+wvQzd7WgDcw3Kix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211953; c=relaxed/simple;
	bh=7xArqL975HP71MsAVtrR7428MD4fqGsKJUF8oSAihEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV/s/HCCYqEb0+0HA2O7w4WJ6mekAosynE0y5ZXeG0B3LqKdEodX/Jhgv5nD8n8KmH+R/NgaWc/gNKfiRw2fJDVuyfwv2oYlcks+BagfNZufmdLmKv1yFAY8Ki5VszkZ9ubok4DBiU5NUywMYnVDJem4NL5Fk3DaZ7eMg6ads7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9OpeuJ2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9OpeuJ2"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-855c26cf490so1803907b3.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211951; x=1788816751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H8rgUF6vlHam3nlVyIIARrl27kIetdBUVEhc8pNhOTc=;
        b=p9OpeuJ2JwYCih84HJkfZ2HhCGAMQ31XmvPp95D8RQu7LF6rfVA+gTw4Qm/dcYYN9/
         iSqi17XE3yHLH+/P/8jyjDssxBUdZwnTbSvBDcGIj1ApDL5zaGGO4xbTEhGCSJ7e8kev
         me2GvHNTQUVMNJjQB/6rPFu5oI+KfwZ/msp2GVFcBDQxysnFHLlGle53rfajsl7kcbzY
         28KjtAeEEcS/qEwdVv+N1fGsW6Pj+E7Gn2kae9NzWd9ssnh8KlKUoFNVCZWoSkAPWCw0
         wQZmCRa4kqQpZP4NitXpr40P7wMzDaHFRI7dKv0r6MkLKEp//aspXRYeHGJkdKy9bXTA
         ZKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211951; x=1788816751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H8rgUF6vlHam3nlVyIIARrl27kIetdBUVEhc8pNhOTc=;
        b=aqXfESxx9ZHTh/xDoOX1XI9z4eAS827dOf4yVOow5NUYwQZxvSisL+wV1klE7oX8tH
         6pXmkOI8N+Br4ghCG99LYArC4B06GkSg8JVDFXwSU9h5L/PDPWSMzTw4d98LMGOF9zNn
         u3RHs7K8WtGP0UCfxma9f9IrhR3t5Z93x8jzzXNo34jbswCJptxWba/DMNrJ5KDxoTQg
         rIgprCBVVI7g/ypcyczREs63JbZskwXZyBIYeONA6q1JDozYPKHk4CeKX0J+Iyx+FPka
         BZT7BbmchOINFY3bhLmgABGuygRduLidHmryVpG2pSR+EpBCH727zWPx5VzyL0j8Guzb
         2V8w==
X-Gm-Message-State: AFuF++lQXYmGulLevcbJWDTsZPOu5sRFGz6Be0uVFTG/heyf92NtOnoF
	VbIqXYiUHqyFbc8WH/qLT3avL0Y2JSM2i2Ae+5hPbcxyumaOhSn4pYOF3jxQWA==
X-Gm-Gg: AYBFou10rRitM0nmErtOuSalcE1bVVeHiwdaT/rEaAq2CFbdH444LG7FXoIZhyFsJaX
	HhHmh+wuEYsHRxiwi/nnAJ/DWAPGLHcZR8lZjzg6ghCmrN2A/20dTaTYknFO50ESvQn7X1dB2MS
	cfY/JVpSW5Uo0Xs9bQ2kXQmNbo2GK6QPXjneM8oWmvfizmwaQyYj1Qa3ZxK+3z9Em+qU/02IDbu
	ZoKWH9GnJIM8YuPTHAYOXdEttGoAZnxbI0N/DE5oHcvKisd4P5rcfMt/aDIrqqn45gpj3x2jzd5
	wuH8YuO5i+MyLyTqs9X2N93rwQIR5Mnb6fs1zQ/ZiMwFMLrhUkutabHVJrAH6Zn0ixblwxYRv4c
	USmQ1WHTjnP9qcCVRat7Rt23Xmh7dvpn0loSI+qfWEhEjpbKTQkV+onV70UKZCGbt028UbCmV97
	l+jF/WhQfjdbfExynzY/v6rn+cxCFNHhRixJrqGkQQIkpuXXfIPok5BNp/wGkYTILqUgiv130wP
	FKAM9sC6IEfn6bl6A9My5UNXcP5AepdSUYrxaUOeJBab4n007iu0sUruYsoarBf
X-Received: by 2002:a05:690c:f13:b0:859:6fe3:7352 with SMTP id 00721157ae682-85d69e01771mr107005457b3.9.1788211950794;
        Mon, 31 Aug 2026 14:32:30 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8616243a833sm45474307b3.13.2026.08.31.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:32:30 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 5/6] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Mon, 31 Aug 2026 17:26:14 -0400
Message-ID: <20260831213221.1370774-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
References: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Detect software pacing in so_txtime.c using SO_TIMESTAMPING.

If '-H' (hw) is passed

1. measure sw tx delay with SOF_TIMESTAMPING_TX_SOFTWARE, and
2. fail if delay exceeds a threshold, indicating pacing

Also extend while condition to account for possible variance.
This applies to all tests, not just the new '-H' variants.

Also reorder getopt parameters to make them alphabetical.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v6 -> v7
    - gate missing tstamp errors++ on !KSFT_MACHINE_SLOW
  v5 -> v6
    - initialize tdeliver_max to now (glob_tstart),
      as otherwise not set for -H tests without delay
  v3 -> v4
    - rename -h to -H to avoid aliasing implicit getopt -h
    - count sw timestamps to verify that they were actually checked
    - (minor) do not ask for SOF_TIMESTAMPING_OPT_ID as not used
    - (minor) remove unused parameter
---
 .../testing/selftests/drivers/net/so_txtime.c | 95 +++++++++++++++----
 1 file changed, 79 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index f6f3253ed174..9ebe9f91227c 100644
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
@@ -191,12 +193,32 @@ static int do_recv_errqueue_txtime(struct sock_extended_err *err,
 	return 1;
 }
 
-static int do_recv_errqueue(int fdt)
+static int do_recv_errqueue_timestamping(struct scm_timestamping *tss)
+{
+	int64_t ts;
+
+	ts = tss->ts[0].tv_sec * 1000ULL * 1000 * 1000;
+	ts += tss->ts[0].tv_nsec;
+	ts -= glob_tstart_real;
+	ts /= 1000;
+
+	if (ts > cfg_variance_us) {
+		fprintf(stderr, "sw delay %" PRId64 "us exceeds bounds\n", ts);
+		if (!cfg_machine_slow)
+			errors++;
+	}
+
+	return 1;
+}
+
+static int do_recv_errqueue(int fdt, int *num_ts)
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
@@ -222,16 +244,29 @@ static int do_recv_errqueue(int fdt)
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
+			num_tstamp += do_recv_errqueue_txtime(err, data[ret - 1]);
+		else if (err->ee_origin == SO_EE_ORIGIN_TIMESTAMPING && tss)
+			*num_ts += do_recv_errqueue_timestamping(tss);
+		else
 			error(1, 0, "errqueue: origin 0x%x\n", err->ee_origin);
 
-		num_tstamp += do_recv_errqueue_txtime(err, data[ret - 1]);
 		msg.msg_flags = 0;
 		msg.msg_controllen = sizeof(control);
 	}
@@ -243,7 +278,7 @@ static void recv_errqueue_msgs(int fdt)
 {
 	struct pollfd pfd = { .fd = fdt, .events = POLLERR };
 	const int timeout_ms = 10;
-	int ret, num_tstamp = 0;
+	int ret, num_tstamp = 0, num_ts = 0;
 
 	do {
 		ret = poll(&pfd, 1, timeout_ms);
@@ -251,12 +286,20 @@ static void recv_errqueue_msgs(int fdt)
 			error(1, errno, "poll");
 
 		if (ret && (pfd.revents & POLLERR))
-			num_tstamp += do_recv_errqueue(fdt);
+			num_tstamp += do_recv_errqueue(fdt, &num_ts);
 
-		if (num_tstamp == cfg_num_pkt)
+		if (num_tstamp == cfg_num_pkt || num_ts == cfg_num_pkt)
 			break;
 
-	} while (gettime_ns(cfg_clockid) < tdeliver_max);
+	} while (gettime_ns(cfg_clockid) <
+		 tdeliver_max + (cfg_variance_us * 1000));
+
+	if (cfg_verify_hw_offload && num_ts != cfg_num_pkt) {
+		fprintf(stderr, "missing timestamps: expected %d, got %d\n",
+			cfg_num_pkt, num_ts);
+		if (!cfg_machine_slow)
+			errors++;
+	}
 }
 
 static void start_time_wait(void)
@@ -301,6 +344,17 @@ static void setsockopt_txtime(int fd)
 		error(1, 0, "getsockopt txtime: mismatch");
 }
 
+static void setsockopt_txtimestamping(int fd)
+{
+	int val = SOF_TIMESTAMPING_TX_SOFTWARE |
+		  SOF_TIMESTAMPING_SOFTWARE |
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
@@ -314,6 +368,9 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 	setsockopt_txtime(fd);
 
+	if (cfg_verify_hw_offload)
+		setsockopt_txtimestamping(fd);
+
 	if (cfg_mark &&
 	    setsockopt(fd, SOL_SOCKET, SO_MARK, &cfg_mark, sizeof(cfg_mark)))
 		error(1, errno, "setsockopt mark");
@@ -354,6 +411,8 @@ static void do_test_tx(struct sockaddr *addr, socklen_t alen)
 
 	start_time_wait();
 	glob_tstart = gettime_ns(cfg_clockid);
+	glob_tstart_real = gettime_ns(CLOCK_REALTIME);
+	tdeliver_max = glob_tstart;
 
 	for (i = 0; i < cfg_num_pkt; i++)
 		do_send_one(fdt, &cfg_buf[i]);
@@ -446,10 +505,11 @@ static void usage(const char *progname)
 			"  -6            only IPv6\n"
 			"  -c <clock>    monotonic or tai (default)\n"
 			"  -D <addr>     destination IP address (server)\n"
-			"  -S <addr>     source IP address (client)\n"
+			"  -H            verify hardware offload (tx)\n"
+			"  -m <mark>     socket mark\n"
 			"  -r            run rx mode\n"
+			"  -S <addr>     source IP address (client)\n"
 			"  -t <nsec>     start time (UTC nanoseconds)\n"
-			"  -m <mark>     socket mark\n"
 			"\n",
 			progname);
 	exit(1);
@@ -461,7 +521,7 @@ static void parse_opts(int argc, char **argv)
 	int domain = PF_UNSPEC;
 	int c;
 
-	while ((c = getopt(argc, argv, "46c:S:D:rt:m:")) != -1) {
+	while ((c = getopt(argc, argv, "46c:D:Hm:rS:t:")) != -1) {
 		switch (c) {
 		case '4':
 			if (domain != PF_UNSPEC)
@@ -488,21 +548,24 @@ static void parse_opts(int argc, char **argv)
 			else
 				error(1, 0, "unknown clock id %s", optarg);
 			break;
-		case 'S':
-			saddr = optarg;
-			break;
 		case 'D':
 			daddr = optarg;
 			break;
+		case 'H':
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
2.55.0.897.gb25b4bd76c-goog

