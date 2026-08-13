Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C81339362
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586755; cv=none; b=HQgrFJfRwuS0jIzbX9WcSkaTPefR0t5xm/Hjf9LLJZURlvtuCMVgEGzEHc8S8IEwwicPGlYEO0SHdSOVmDQDFc/OA/D4z5uTbhe2gizvuAr/FShSfWvgVFPiTQXUfzJ80VEZW37qFuii2Fzej2APvoxGcME9R7BnxEF9lTZCLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586755; c=relaxed/simple;
	bh=9tKvuF6yr75xbtD3lNFGDMGMWwop7Mlu6ntzZr6SuHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0aeFHtkEUPoC7ZoxK4tBnlelLMlxrlS/TxsgVldLlZADHx1DMEua1KpYAg5+7uxc9gjz4jxcaJR6Z9tKoPL99XkgbkRdrM1uVDK684hNHeY3WwULVh5mtLjmlMyqbtAZIiJTMMKYkkjuRRNeqPmRxbVhZadQnVuHiKuzCkBqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsXJPVF/; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsXJPVF/"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-667bae10ba3so1654084d50.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786586752; x=1787191552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3g5hp49mf2gBSi2nMEMUY/ybia5hbF3uzaaPpHrjlE=;
        b=YsXJPVF/FTO8mtqEB/xScJIQZYsVVYZ8LgUwSzNjXE1RxMch7qk5aMiUf0LtydOElH
         2vROpqKZp864bO1cf5U7CebIgYuT80yCRCgjKXSISrW5g8P4sBX9vN3D6ulwsEKYmV7h
         I88dxXztdP1UWEN8BEmSnhD2B+dlDnir+pOn/1Of5WTNBxcVxJd2Q2kFbc2kbEsCOr7p
         wvs4oW0HwbJiCbALavIm+wIrLvAuE7EzT2JYzOsMgERmacBfT/ETn4LSk9o1xDj8JmJ7
         9s+dfQG4/DEH4jRFp9V9o8cuCaKIz/EHq+T1rL2VxVF9hrgQ548VBJJJgPHrEXPIkoGm
         nBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786586752; x=1787191552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3g5hp49mf2gBSi2nMEMUY/ybia5hbF3uzaaPpHrjlE=;
        b=nUkCpDXUL2mMdDMw2WoUP3mtoOKayVsfXsE7CX8BvOhwapAoGl0a/wEUjXx5nEDgyG
         9VPPyo8BMGhrk+vg0/vtOun3PE6p6HW9Qc4N1SZj6r09RVB0L8nQuAORdWO+ItgThVrQ
         mEqDzqwJJQucC37duPMcdwxpAhbCyy5shwLtlIOsXH4m92BPEp1AS8Imb/ZhNAbume3/
         YMD+M7cR80kWjFtR0jbPkpSyKqxhomUgfVZ+i+AQ3lXDroCfalPiCIGfhBP6cu6DhQTP
         mJ8opU5jsuJE+7GU6eyVbCK4BBDY7DIHva/tUn7atqXsOr7Ssq0dtau+WfwpMJ1rXlPv
         wBGA==
X-Gm-Message-State: AOJu0YwJqLLQ8V3daDo5kJev4s9X3GhRtklJ+hZxZlBQE96KiA/JbIiU
	YjHX4b0UfZPjHke/ubSyTEyMVmN55SVO2G2SN4sZsbXQQHx5ZxrlaSw3sYRgvA==
X-Gm-Gg: AR+sD12YGa5S4HscDx3a+7et1pU5Y9IXaCuil1EHK4lSRdbSNr+OlZGnBLI1PZwn+Zz
	gKsijIR2jR3taIUv5Jv7WXhAiE0/BJeALphDbuYLUQ9XhPN6mQOzhoR/SQ9k8sb0TB0u7/qnF2U
	Bc7m/RYkqn0G5kxkokC6MdMEPShV+K//oFZdAJ5RhjgXcrORcnD3Ua0BFHxk+EeD2z2XUC8fVXh
	UWFoMMWKlTb6rY50AeaFWWBQQCdl1Qe2EVBkz8vyzmFaUpZ9MK9t5lP4EUckkARnL3fudc48iu1
	J5Cts/IIBBZh4nZx41/SSDTbzTXKBExgvDiz4rWRnEm9W/Xgxif1O5P7JeLROvn6Lm8ocmniKr0
	5ZcpKybZrsE2ZXQXmXME4xGk4FuupcfBii+w9e4HL8Y654nZ2qPQWKMdEaAy/Z2pxEdHjboEi3I
	u8o9xFbOmhF77C2vp8FeFY/eRaipT6KTSTg8nteNSbW9kTpHHmaXkhe9z/78P0FTQ/bN/4N5tlh
	zlC85TPs6pYn16LqrfNtdCFh9TA/cHacEVMFPETY2m4rN5yYAjES/8Kq2o=
X-Received: by 2002:a53:e90d:0:b0:669:7cee:597e with SMTP id 956f58d0204a3-66c5146679cmr1075816d50.9.1786586752400;
        Wed, 12 Aug 2026 19:05:52 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e74870sm226899d50.6.2026.08.12.19.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:05:51 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 5/6] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Wed, 12 Aug 2026 22:04:00 -0400
Message-ID: <20260813020529.3506539-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
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
  v5 -> v6
    - initialize tdeliver_max to now (glob_tstart),
      as otherwise not set for -H tests without delay
  v3 -> v4
    - rename -h to -H to avoid aliasing implicit getopt -h
    - count sw timestamps to verify that they were actually checked
    - (minor) do not ask for SOF_TIMESTAMPING_OPT_ID as not used
    - (minor) remove unused parameter

Reading timestamps from the error queue is never particularly slow,
so errors are always counted, not only if !KSFT_MACHINE_SLOW.
---
 .../testing/selftests/drivers/net/so_txtime.c | 94 +++++++++++++++----
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index f6f3253ed174..c40e24cdef69 100644
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
@@ -354,6 +410,8 @@ static void do_test_tx(struct sockaddr *addr, socklen_t alen)
 
 	start_time_wait();
 	glob_tstart = gettime_ns(cfg_clockid);
+	glob_tstart_real = gettime_ns(CLOCK_REALTIME);
+	tdeliver_max = glob_tstart;
 
 	for (i = 0; i < cfg_num_pkt; i++)
 		do_send_one(fdt, &cfg_buf[i]);
@@ -446,10 +504,11 @@ static void usage(const char *progname)
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
@@ -461,7 +520,7 @@ static void parse_opts(int argc, char **argv)
 	int domain = PF_UNSPEC;
 	int c;
 
-	while ((c = getopt(argc, argv, "46c:S:D:rt:m:")) != -1) {
+	while ((c = getopt(argc, argv, "46c:D:Hm:rS:t:")) != -1) {
 		switch (c) {
 		case '4':
 			if (domain != PF_UNSPEC)
@@ -488,21 +547,24 @@ static void parse_opts(int argc, char **argv)
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
2.55.0.691.gc56d675ccc-goog

