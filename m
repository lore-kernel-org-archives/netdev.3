Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2753B616
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060326; cv=none; b=hs+U+v9CA+Pp6evK4Vue3ihCr5AZiKBa9NNTLznWqEMGCoMlAcCfqdw1n0MkgvGI1pGB6HFpZwfE7gVvYkeEQ2+zy9kh0FvdAOdualvh3y7TGOwTZzqqCISJ/rD6Bb9pMl4pKpF5rhw0vClOVkf9BGmQ1S9FPEzw13CfNiHWoEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060326; c=relaxed/simple;
	bh=k/xTPJO+BtmXZtwsadkgBSu86CrO66JMqj6CiVGK300=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st/nQsnZA1rw6ATtZS7J12KjAnJ9nCKWbseC+68RQhucsqCSuM27KIiqc1NO+GOKLX6PjgqK3l4elQ5HUMw9srkEabrfY1XrT161ukAzzt0t7VoiGdiMqsZvorAh+UqHbjXFxnLAvGLmSKzgt9dnw8G3NDhcaZj7kvdowFpeQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDDIoQ/Y; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDDIoQ/Y"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6711f05fb14so962207d50.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060302; x=1789665102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBT27xp1pGPY9LeX8TYSbZ744fuH/VJYabQsj8mOV2c=;
        b=SDDIoQ/Y3GwZnMsJgzIPMaE5Au9ADZHerofumTIM9+Pv3FBBqHyJVid73o+jHHEMVR
         lPr5dnfyT0N/rtQnPXllH5rga1Q3VtnJDrLABTyGa3XoIasLuBYdPnTaOo/tGYh5PczR
         4FO4lQQSBoe1qORubqs5KGHfS/pbwjHZDvjlQVCOUWA4js8EVHgZevCpDzya1r/3qZRX
         PyEFFxr95EY27FUCFGVzeB90cHy2PR7sz5s3hsI90c/usqdpu4sBdGNpn+s57uiUHmoJ
         ONiJqiTDmQunptRJ9BEVmyhUA0hkF3Kl1KREaNAmnnbCCSZpUfWcfKEFLej+nWl/UFqK
         Z+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060302; x=1789665102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBT27xp1pGPY9LeX8TYSbZ744fuH/VJYabQsj8mOV2c=;
        b=mL7lTvFqBdJgsvjas0GOJeHRcUAga0E+Lq1aNEOLTdFhqrdQl8kvG7p8P/EP0N/KQ1
         ol4yLXNeMzBjNAux5CAU00rQKZkAMglXnvVicVJP7kv8Cluy2anEVJX0kJeu2d6/Ou85
         hgiktL3NIzaUZkZBCupdYwH9n/qcQh0M2BAaTbhEt8jTEj7HXbaIM8wus+Yj5YKxFYWR
         HFHx7QNlibMbmU5VS2rjieylnP739ACZBnWSpmJofKT2KK9Vn2WCyattKjNFcNl3QFb7
         NykjqpoQdSAU9soksxGKnVE+fS3XDzrzcIjav6KVn5lahPNbbjXuv2mwmExFXFlZcWI8
         sVKQ==
X-Gm-Message-State: AFuF++k79rRM8Uxx8eWe3WpswQLFM/GyffrIbH4hRj9sph8AnbyzZhX/
	C5X2uZHx86N6zQoZSiaNVIQqXBRWqt2V4YbG+KYFkr0gxs+JTfJrXVDoTNPYOA==
X-Gm-Gg: AYBFou1pz/7h3MsFpj/CVwXvc22CFlF04m8XqK7xlGUCBN15h9AkY5VXISIp3hKWRHf
	xVoERHMN7Q6+jqCKw9Nlao0T+JiypUZuoFW1o+M2X3ocAs/ofxLa0kFWtizQELx57t4NO1ePLjE
	ZMAs1oglY2vuvTX5v8XiahfE9jl09722sG38VOJaCzGTPN3liLgpYpS+9RiHXMjdh7nfiCNW2F/
	tioeAwDSy9gUG97I7O6gT4r4kaj39c+7mE2N+EAX2n2k+bZdxFXwUBkB1wKNqOPw8q8Xd7UIWZv
	pSSMBXCjyAr+d/eIFdIAI/PFSDvnK9rAqYTZFq4Lgsu8LAKvwiUBQtmTzWMuIUbCKqPS9Gel4oI
	Y66hMmlCawto04jsWmkAWZrVifbSOBKLXAN2D9/ThiVnM1W6B7UoZ2mhWjhyREq9Cc0QKnMZnyi
	VtYfmruEPjPOuwIFsCryJSlY/MrdV3FtSFnkyvV9r7VgA6Wm3NIS+YGMQdeXejxMvTc+pzP4Yjb
	yECrhzUh2oCw5yH1KWY02o7h1sSUjjBOzTdXD+VKOi8msdaQkmeO94/beNjcDKQhB9R7nPYSWNr
X-Received: by 2002:a53:ac9e:0:b0:66f:8b35:dedd with SMTP id 956f58d0204a3-6712451a13amr235077d50.6.1789060301630;
        Thu, 10 Sep 2026 10:11:41 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:11:41 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v9 6/7] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Thu, 10 Sep 2026 13:10:25 -0400
Message-ID: <20260910171131.2532487-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
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

This will be used in the next patch in the series.

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
2.55.0.1007.g17ff1f9808-goog

