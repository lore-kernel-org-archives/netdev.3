Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E64490C08
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058971; cv=none; b=t+oizyYAOVU5axQjYszB5cy+Rwix/4+T7nnm5IEILN4Aw5u8LEGSlkIVYacs+6EG2Tn0BFpH3V3VW/6ngJ0xF+rQYTcsQAIo6xhewD/cYVPwan+X8rYbzbR9itTJkJhDnQPSmxMmjp149qFXOjjuvRxN9K7XyibVI/aqp5Q59bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058971; c=relaxed/simple;
	bh=CRKqXtch1uz/GpDuCPGJyuZJfoei3xhr++H8DgVKrNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/kIcIbb4JZo+aBusJZF1LWPDhXX6PX/zydybJJepICcBkkwARqdFQraSSyKTm5NPxBzdF0s+gp11j3PI6xrkrWnB7ou1wp2Ir6Q4k/vdibUwyy4V1REP0UZMiGo3KdghJ+SK47NTOh7FT/tN3EQH1UKTEF5+NSpOeTtTEuAFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfCypP65; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfCypP65"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6680ae2031fso2814134d50.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786058969; x=1786663769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kMvizLUHUgWoAQ2a15IzPnCt/bdK0Ped3AtGw1CCqzs=;
        b=DfCypP65glMT7hsAwIp2GokgWt8t76UcmP3eRkca0BkB696k+ae22+A2aEzsvpriAS
         ePHKB92lfZF10JkKK9fpVTWlSicCDprtjCsRokmtZryuH6su5mTia3yP5pNksiFYdHpS
         lacF91bbDPv2uNUHqnIH7LNGVfjB4ZrWS/F7mihZkzSEbcPBUjn5yngKNHtVQYtAnvvZ
         IQEyAvHyYX41uV636VyscgMmVQ8HzYm764I3Fi2HmMbK/pBtqwgN2Ik4AE5Vl8+jAMXv
         JiY+8wBeGvcGP4w2gVOgasocjOyKUosxanvnLoG5C/AGGI4QH5ftHcZLYfAfCbpFQHp1
         Tl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786058969; x=1786663769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kMvizLUHUgWoAQ2a15IzPnCt/bdK0Ped3AtGw1CCqzs=;
        b=IY5F1JDKCt96dGLIGhIu70CEv55P9/ZshiEkrlhcFpMZzRn9O0fkgPYjIpU92hSe7k
         nG5zWkL3Tj31sd0arsOxRxMBflWSKzIhTbZb0RcB/KnEd3Apj+97JlgRdVEUJ/d/OTT+
         JYWEmmHJHUyJ7b/Cu4wV768wljrrMfakqlgjZWC7nVH8KnTYCpckB0BP2lKdVp3JbWts
         QnSVyzyk9yueJd0G9O1CRjD6tdocHfOaWrTWW/Ofr/srTOBkAuu8UKDPhNHM1Zpdiv7o
         CMttrPH75zJ9G4HXIwECPDIjwppQKKh0keSPy425MPQY61TJMA5+PfEE8KoGxvOu4CRq
         92Kg==
X-Gm-Message-State: AOJu0YxTkynXD7WVWLXtB1VtGyOANqglKDo8k7EbIU8cSoE2Y+2yliHD
	8dLQSOs4kFnrrwdUuhcaxTYegJ3OTz/Oo2TmqIDc8yM5bEAfKJImzsQNq942NA==
X-Gm-Gg: AR+sD12qe40fPJKweWhgnRGpfzPx0rQkwpk7b5lpIB36o7ZGFySg8lGkDVow3x4I9Fb
	yVCfS+Nf5sQee69lWXCmYgRBSderU8TUqxF7s+y+UZvzQMCaRsenlYQ1zcxvhSgojN35Jg7/r6w
	F/sXDEOK64tS4rBawQgN4rr4t1NK3AZ1Tr2OQDYbND7rAXa9InIVaN6rdcugMlhHsOlNFn4mmQh
	KZaouO5OXOWXu8DotNpDnOKEPxInZ4Vo2m4wuR6ou8xfRFSMoAuMJM0ECGZyrlFg4anVRekQ5Uh
	bilQKMqirngZnHxwU8KMjak/1H5AMh5mwDDonpm0DkUXP5cUfotXJn4gRHg1bR48fmPSLPHBYkE
	bNkBOdnxIt4T0ltBiUo5x1R1RW3YsHOdrsXt6OtUDJ/zFOnWEUXCl5v2f7od28/l5Bsltjk86rF
	yy8bBhpv+swxctODMBnnEupoXu7n24alcWgie0en530X0jJ1kw/crxsToHhZTFUXiCWBytyRcz7
	LSAOjjlkdyr/sZy1Dh4tGve+iyihK0H5e3TiBYpOpood7Uzykmhx7d6c1PaPYowbda5lQ==
X-Received: by 2002:a53:e141:0:b0:664:cd4c:83ef with SMTP id 956f58d0204a3-66ac2fb0dc5mr2297573d50.30.1786058968799;
        Thu, 06 Aug 2026 16:29:28 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:29:27 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 5/6] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Thu,  6 Aug 2026 19:26:02 -0400
Message-ID: <20260806232913.4020403-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
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

