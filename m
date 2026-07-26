Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2BA231832
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097757; cv=none; b=W2lVobJlarURi70KRgCmm9SAd4k+dMR+SB82VWB4IUf0f37yM7u1VNLeCf3TQWu7bbPcn0Jsbd+RYhb7dRFJOvLRj3wxjRdOvJSg0TCojrs3lLKHirs9DrI2D57l5q9iqa/8LbI7PLZWi72FGop7RG2xYdxuDlT8ZCy1NlyheCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097757; c=relaxed/simple;
	bh=ualrFxAJy1W5bMR758u7WUxfqrNPotQ4bZrqQRXG+NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnecwSJvOg5XX8T3jqeN5gfAmHn/QhoBDA5rgIS2RN8XKRzp/cLoEMGzShE78Raf6uJQTVznfjHLSPgvu5cbLZvvHeFS/k4H9UAHIWdwFXaMAIA2A3y88clllFH0zlcLFgeg1Zn1NL7ifd+WhzaG04lttkh+Zj2oi4XsacfIRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFE/TKp7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFE/TKp7"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80dc4a68e4aso21854217b3.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097754; x=1785702554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GafyVlzH7EDgm5ibwIIRkoiXMQm85aGHNK/M7ty7ih8=;
        b=dFE/TKp7lA913P86AlsIz+xncvYl5sata2D3bFyg7Nqx4aSpn1+Zghbu5bnQCkKSt9
         rxLMDLTbGUdngwhkCs1JAHLCwL6UEbtPhpaF7RL0Zxhz+7lxVhRXp5qJKNr8w9c26wS9
         /R4+u9CpycDzGhD0TVEI3kz6fH/dJLVTUFtAkaowV+eFNf2NIWF56iigtUAkydLMkYkE
         nLzLBM8rviJ99UigEEFbiFDwQGVtbYvSMIfcSGJax4dMM0ykL5tDMa+JV3Bbws5OHs5N
         tuY/ejzSI6rxZXoW5DUOPBYZBFhCBWKuOTnoIxirIAFrcuQE/VVpe5v32taIBGlsSJF4
         HbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097754; x=1785702554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GafyVlzH7EDgm5ibwIIRkoiXMQm85aGHNK/M7ty7ih8=;
        b=PYF+ftgouqNm1jQqUn8DBvgJqzw+q+oFtUaiZTvtdb4AR/3Xx/e8Ll1LerMrLAZUbB
         sUNOCjQmRKmNgMIkyiiXTZcsBtFt/M8nScZdnc4DkW9F3KyFd2dQKl915g5QWtxuMQaE
         G7cSkTxt3jeIr95A4glTZpfBzGUN2KF8phJzO9lkYPVxl9lIXBTZ2T32YomrHPLxKHqy
         9TSC59+FkmMOjLDFU0uJmf1OK0PZNx4TaOAAZqNhekF8sKHqU8hYSbbGmcunJ1+G01Oe
         B8pbdOg34bUjEUJ+fZDa9ImIh2+hRcLOBwr0nBFX6BMKNx7oJ3RsmGW9gfUFoIHEGwKx
         rGYw==
X-Gm-Message-State: AOJu0YyyaIe2/cjz0ul2QyBvkkNpi1DT2eJ7eYe4OryvNgZMYZLMrfS6
	ic1qOT1ehZEHKH3IhgBMD5s86h9huXzRo3c9503vMupH7fmG3Iw6DYpjduwqdrWy
X-Gm-Gg: AR+sD12ZgHQdHfcDz/NEe9OqxvV4QdQQZFLv+HpQs415Xyo3P3Xf7Wiv3T2XvVMp5UD
	UDPmKNvhGu11KplZq8SVx4+u6KAcn8YTiwUjoAZLkLMZWO7pd/SXswD1yAkj9lZUlc0IZIcYjol
	CTXsJYqATQ4bHfmrbboFIe6orkUICBwsUwPswO6GnfQkihKZAKrs0OgTr4Ga4eCiciqAlSqT1GX
	NL9klDHuqPwx3OGaFqXY674DMq6Y+agxTCDhNG/S7lf9FZH3duAfPXUpyc7De60fuTchnYk53pO
	Z0mS44DEbkMhe8Oi6DhNyC6VuGrZrXhCIARPLTRmByGjkDu8kNoR7usgPzCtNqXPgxcgzUMoapL
	mk6cGf1KLXoQlYlLYKSX7j6Npf18TYsiapF2bakITFEkqFLLqieJgjsZ2nHaKGNZ5XzfBSZDP6E
	i4eAq5MfAy88eCqyhD4Vwb3APlSK8bQsxEx8v8N1LD9eeu1ukh0apzvr0MLKolG64JKgfcaivd
X-Received: by 2002:a05:690c:650c:b0:80c:85c6:8993 with SMTP id 00721157ae682-81f69eba9f4mr22277607b3.66.1785097754124;
        Sun, 26 Jul 2026 13:29:14 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm23339467b3.13.2026.07.26.13.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:29:13 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	mohsin.bashr@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 5/7] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Sun, 26 Jul 2026 16:28:49 -0400
Message-ID: <20260726202902.760552-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
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

