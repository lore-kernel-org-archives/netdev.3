Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E97345725
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204365; cv=none; b=EV5RNw9no1eD9hksmKahzxHAp3ECIRbDRRQ7s2AXZyFSpPg8uGg7m2hHAfHH8YQwQ/GLd/80y8Ew7m0l4BpRE2SRmdTPtCOUq0DAuU2OkIxRxkFjDGQpNaCK6nbpT2M0VHYWQk1HFU79fP9wg3oA5zv5wOswKER+fKvgseb/VbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204365; c=relaxed/simple;
	bh=CRKqXtch1uz/GpDuCPGJyuZJfoei3xhr++H8DgVKrNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR95w0xGWHilKmRxNSg4yULIA8GM7VPO7+6DHh/2JzqUyqkrm7orCIoKMowvLN7+kGclQgW+OSDCcqmsJrHlA7euzhZ737jrCNqYy/R/HWDn4y5CL/o0DBY0KTXQ6nKopNnS8B2BFOAVzK3qCgFSvx9+2R+oK24G/jt/nd4EiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpFt0dXD; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpFt0dXD"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-825fdc558d3so3339447b3.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204363; x=1786809163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kMvizLUHUgWoAQ2a15IzPnCt/bdK0Ped3AtGw1CCqzs=;
        b=bpFt0dXD6JfVuWH2Abz2IDWbWcYcAlk3hSGf8Qtg3XOx+J2+l4zykOjbRumzx0fL5J
         YuLMCJcgtO4o/Y7blcw6wMPlf0i76I3wUFZoJsZGF1T5KsTyBgHlczlfgdE8nmCWR/LG
         Kxb2Xcw2QeHFGXQIx7RlmK2Trfk7CuQsSDIzmEnwYgaXtLCsxH+/jcMpSIIJmT+7gxLE
         PW//rDsmDnvGyAlcbcCSWRJVY8DS4sPb4eoBYsUvL0U6MShnW7weOfN6vaMP1rvCLRge
         ZJtwmexnmwJ6gHodPQ6JEuSIzEvpFkkxNN8KpQ5lEbCijfuhDhCkD/Jno7ERbv37H2qi
         JqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204363; x=1786809163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kMvizLUHUgWoAQ2a15IzPnCt/bdK0Ped3AtGw1CCqzs=;
        b=jOwtC/s0eV5lkAt8FMNsoEcGZciAXB7754a3m5O+Muceu4PJSLLjeeWLAn2VkyxMe1
         WX4MTwTL10KJHutDyEi3QTgxQBf4uqT4icH8bL8Ldc5hU0p5Ix49WQx5O3ielP//8mrA
         hYCVchMmCFa62uV8StUfGOiHo+2yWhKnZAgoMqJPvkmwszh2wNBI73r75ivUoSMJ26G6
         3DagY5dHEG03rgubGUMxVVDrbk5a1djqhSj5X4vCYuFBKow8zVR//EQCLXEhGuuI9Js4
         +0agps3pfvWYJkr19l7FEN1H/hFHTWTbsRHHBwxLWVX9gQpj2/o5ovpPdiF7uJ9LqRGX
         Ilqw==
X-Gm-Message-State: AOJu0Yzul2OWmJpN9tfYnTlpYV33W5oBsFYmbOB94UhR0BZfpQLzQ/Tn
	gmFHjZM1N4DA80h3sMYFYF4/qyPbD2tiDdr2diFsc3jrRq5CjnyuZQALm0AstQ==
X-Gm-Gg: AR+sD102/oR0ZJg0gJUoTWotKD7lrNjfMCZkXRYzS0yb12+OF+OeASYAnXIlYZ9gtmC
	qnEgDZYkeKF09d09o4RqOS3E27zrwT8fS9V3qM07sT4c68B1hhHQGh36RSimCfmyvElOLpsZ7pS
	EA+KjjlN1jroC9yTkH/gKaP6m83kUt1tKbhRYqq9fpguLbolOks+Qwawtt0eEwVd5cWHOpK0qgk
	gPPO5Kh/mzVTWrxqNfogyERUHrc0qcL9fOGdz2PpqWnIJ+gdZqYK76aXPlOg82eLxHhhy5i0Npt
	EChebEiVNgK4RqSjl/2tGGDg5+LDt4ZC74okUw64YbY9mLWqi4XEdWqwjPjGK9wWbFYWWrP0qZc
	hW9BEgdEEndQjG+STicAAP6YhI39E6YGAVde5ku+xjs+7wMCIe6K/0vWdn/Kmn1MbMpYhOqB8aa
	naljaHEUeyekB48oNas4GyAWVX0TGXlgvfhUJebV6V0UP3lNph0j8KTGpwRZKoPqQckGh8MMvBI
	RsVj1avfusX5rzy3Z7RGlZZQWhRDVdm0FK8W8WJMvXayyeSUeC7PGqt42wrampfMnWTQw==
X-Received: by 2002:a05:690c:7344:b0:81d:5806:ecc7 with SMTP id 00721157ae682-8243fdf21c1mr62669627b3.1.1786204362906;
        Sat, 08 Aug 2026 08:52:42 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f79a6c6dsm27839747b3.48.2026.08.08.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:52:42 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 5/6] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Sat,  8 Aug 2026 11:51:43 -0400
Message-ID: <20260808155217.885299-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
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
  v3 -> v4
    - rename -h to -H to avoid aliasing implicit getopt -h
    - count sw timestamps to verify that they were actually checked
    - (minor) do not ask for SOF_TIMESTAMPING_OPT_ID as not used
    - (minor) remove unused parameter

Reading timestamps from the error queue is never particularly slow,
so errors are always counted, not only if !KSFT_MACHINE_SLOW.
---
 .../testing/selftests/drivers/net/so_txtime.c | 93 +++++++++++++++----
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index f6f3253ed174..951312e67b66 100644
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
@@ -251,12 +286,19 @@ static void recv_errqueue_msgs(int fdt)
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
+		errors++;
+	}
 }
 
 static void start_time_wait(void)
@@ -301,6 +343,17 @@ static void setsockopt_txtime(int fd)
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
@@ -314,6 +367,9 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 	setsockopt_txtime(fd);
 
+	if (cfg_verify_hw_offload)
+		setsockopt_txtimestamping(fd);
+
 	if (cfg_mark &&
 	    setsockopt(fd, SOL_SOCKET, SO_MARK, &cfg_mark, sizeof(cfg_mark)))
 		error(1, errno, "setsockopt mark");
@@ -354,6 +410,7 @@ static void do_test_tx(struct sockaddr *addr, socklen_t alen)
 
 	start_time_wait();
 	glob_tstart = gettime_ns(cfg_clockid);
+	glob_tstart_real = gettime_ns(CLOCK_REALTIME);
 
 	for (i = 0; i < cfg_num_pkt; i++)
 		do_send_one(fdt, &cfg_buf[i]);
@@ -446,10 +503,11 @@ static void usage(const char *progname)
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
@@ -461,7 +519,7 @@ static void parse_opts(int argc, char **argv)
 	int domain = PF_UNSPEC;
 	int c;
 
-	while ((c = getopt(argc, argv, "46c:S:D:rt:m:")) != -1) {
+	while ((c = getopt(argc, argv, "46c:D:Hm:rS:t:")) != -1) {
 		switch (c) {
 		case '4':
 			if (domain != PF_UNSPEC)
@@ -488,21 +546,24 @@ static void parse_opts(int argc, char **argv)
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
2.55.0.679.g6767b8d81c-goog

