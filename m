Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7446AA6F
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373080; cv=none; b=O9RBJ7xlBY6K7ofUY6v4/NxIfDtpXLK8Mv+Tszko9n2026fCpaYtXOZZP6s9SWl1Ch4nfQBDWX4X5FupO+Vxkln33UbWM9+d/GzaHr+NZ4lwovZG9rgptDU1yf+OfyoTgArukvGgwcK44lmYkYzHjXFzJlb/724xQwIZTJ2kUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373080; c=relaxed/simple;
	bh=c4EmFjJ4JEjAQP8KkBvZyL7vbWmRywDyaPF2doUxPU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LawwthM3SBiaI14gLbzLT0WEXYJqyXOND15glQY7p4v9FP1x+Zexa/5H+lKrc4SJfP/ATnEO+2S7WbQXaJp6B4BvrwPzaypbJnGfKVRhT3asNLLmHHmzKI9NuRD5IkLJhq+Qc/EC/zdGw2SsAPRh6xk63N+86VgPyueR6M7kqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4iZNplq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4iZNplq"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81f3b227a4aso22721927b3.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373078; x=1788977878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noiPd+dtknL5wRGIaMoPZvkWKtGEHO9MCj3Co1BCdKY=;
        b=D4iZNplqOXF8CWjt2a78LS8t2vJQF3Y2acbIzd+Y+JZVPqMpaUVxoBmrEefGHisAc1
         y3rACwWU+hvV7kqnKdy1DDZyI9PFMdIDE0vYd+HvLl107ch0eCxSGT4g6pXAmfFn56zx
         GGHeStVqzfwSRDoajRL1gnifG9Xaeqx2uQSX98/U0P8D8v60RyNQt8tE0z90lFAPiMFv
         hysXoBmgXHZGDDKCjCTAkbm55ogc3PCvCj994NH+kVHyS3VC+lxYDJaO2gyDyesK3lZA
         ofoFn2PInkQOK6mJjeMHn42b6BXZOVQ7nWrcwNmKfbOD0SOpP+e2EBAloIHBObjh+Dja
         vqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373078; x=1788977878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=noiPd+dtknL5wRGIaMoPZvkWKtGEHO9MCj3Co1BCdKY=;
        b=BS4tJjCYJ81YcLngwz/sQ6grcf64sCASSv7M7gnnpOjlV2Q4wJtROuc1attbKLC0AZ
         YYg8dPDsnr3hMqE6SQpCGebvE3PyheFydOjKuEtUWbnSBGD4upCcTzZBuzHN/UeAHvL5
         mZITy+XCsjUizAc2IddyDkQMR91XR36EySdo6WqeS3Jl8UMJzQTmy5MP3tQ6z+7REsxY
         QxZPa9CmMj1xiKKQhhkozVgt0szOKPsoqSgO/vgkqt3qs8D3jbshiqXlMlmVJrQ/QoH6
         E9u+csScanA+WFZUdp8bM1bJflzPjg6OfsoJJsOCLso7FPAwa68iV10Ak1T06Yn0TKW+
         jlfQ==
X-Gm-Message-State: AFuF++lR+AdZck2kF8eJB3uBo0TCDs5d+1c4iCkwag5mnTIO2+25Peqv
	nQpCZxLrDgs6iL6R3nan/pZNAYrUod+u8Yt4hV3L8AEKw9b03z/KgjpXTcOJqA==
X-Gm-Gg: AYBFou0+moE0Q8Xl4u7acmsyIQIxIn1ojFoGyF/bXr2stw4TzET+tqCD9YZKC+ve1S+
	nz8HjUmBS3S4NlFXTPbT+nxRcEEW1qDXl0z0ITcHsgCpbRxnZAx7+UfayPqRRtjE/zdGflxC5tn
	Nb+mmYBGL0a3GdHWQYIH28OBJgG9i0WY6P8Lvjo6AaLXJTqjLz75DWmm557eZqlyP9o4ebimaeX
	6YM9G1EV7sC6yqONSzzRuh4qsOMeRe0kgjVWLOfvEqaXDFL5aRiTXulYSfvpiR/1c6jr3/z9gqk
	CO4OuYQSE/M+/xY9LFy2aMyvdX0cw4dMu8LlYjFB0fuP+e0tYwBaYeNTCuiUcflcgyeMcb5USmj
	rZeVhbhT4FPslLi7GMGTSmjdAitSjAx1M03NHAxsHh+fNvrGMhA0oIcgeVJ4aEPJDbSCTbZG7O1
	xgdSGJFA7ScVddDiPUZPbVe/P2JI1gYxNWMPJXj8NvtaJXZO7olgMFq3Ak3zbbPlp1FnH3kvqcA
	GJ+HFi9TH+M0txNW5XTQ/MLSo+EJ//vI3n040I7Oe+UiqzxlsaLznoWfd8Q3R2Waw==
X-Received: by 2002:a05:690c:e18d:10b0:855:2d6d:2db5 with SMTP id 00721157ae682-86c4f669886mr27005617b3.12.1788373077998;
        Wed, 02 Sep 2026 11:17:57 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784192bsm23162297b3.30.2026.09.02.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:17:57 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v8 5/6] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Wed,  2 Sep 2026 14:17:15 -0400
Message-ID: <20260902181747.2483351-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
In-Reply-To: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
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
2.55.0.970.g62bdec98f9-goog

