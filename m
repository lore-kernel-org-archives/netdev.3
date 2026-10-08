Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D33DAAD6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457813; cv=none; b=dUO6EPgrzYwFfYpIb2LK/TTNklv3JEUwReEr/W0Y7yvUgSOWLRWeg2i6BgecrrobuHr67CggqV5YqbJ9AbmHsmqh8D5nb3q5qZM66DinKz0tlcM4XOGROgAk3Ox+6HRbIajipNbe2hOp92yyJB1w4jVv9wkx/4ehxiYtyUhLjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457813; c=relaxed/simple;
	bh=OQ1sBuwp7i4mtiBMz3g9ZmE1aw++E1wr3jKq7s6Is9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7NsbKiHquXOkDoMOzVqGEi8oZKzUuUGt6k0Q1V0NLPw3xP6WZN+jUbHERvvEo4V9F4/bUEpEEtQr4eHFj6+1Juchw3j9B43tUqn0xpzzRhgcIIIxFJZEkZhwXvxLzgdBTjWsCwk9nAt0V5NNDVdhRU2dDZ5RYwUeYplZhutiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZogCWTIS; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZogCWTIS"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-351767ef18cso83eec.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791457811; x=1792062611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ksAcPAYjWXgsbyCjE4ePPZl3/rW2axHKGjjtYG6aLyc=;
        b=ZogCWTISGrhVp3jKAbuJxOTjT8gNSYBlxpfv6m8XpjPlI6v5mbiZGMdYdo0/aG2p/V
         5N75kwWfz58v2J8EsCKioiFyURB1BT0OvZBFbxBgoBN7VrpVHdYarfhq4KrxP76LbYIY
         nXYFquy+Fmhj+1x6SKS08Dvnb8vMJs3C+2KwDJQaPK9Cz326vRupsS2iSDzN7ORDmFdn
         n9KvTxgGX9dyUg8dHDaaj495zz5nHGHepXAWSSTNPOEl0c8/X2F+f62RpTU//dc7XmrP
         8b2xpwyJc5WfLKZaIqrGu3dEAonMWppuYOXH3N9rnZXWZ2+v1x+VDUXcO1JIoeyeGJ91
         D+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457811; x=1792062611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ksAcPAYjWXgsbyCjE4ePPZl3/rW2axHKGjjtYG6aLyc=;
        b=GL/T7RBr2RmHgi7epWkk7H/PQ8G4sWH4nge1T40bzJD+EX91wU9GiDRNncWFeaKgLN
         jPLjg/QZggdDlKjpYsBvKxKMVUikiH0aSEmzOYSEViy+CdhmugcCA4hxSrYEOnGrM+ju
         vCHtvnLPQr2wocc7IQlvQDCCPjYSS3ux0DW18ytdEtmujS1IODXryCnRkkpiDaH8ZJUt
         1IO8ZYIZV8sRxrypLdxZAATwoVinFj+CHHGUyWe99HlC5hR8DjB86GKcIijvIIfEq8BD
         DS50s+Ea2QCtjQZgmrJHo2/qhvb7w1ML5gcN04piI8rqJimObjpMQeyKvFVevH532VVG
         d2mA==
X-Gm-Message-State: AFuF++nlq/lLCyAnT2UMcp5McYJwQfdmtf+Iiw8TGDNkInLhbIFIlyyI
	hr2ptRrvJWmwM4PlDLlqFWeCdIYS+AbPQuANREMQhZGIeGVdpjx+CNDZ
X-Gm-Gg: AYBFou0BWNz6Xou0QE/eVKBF6OG7hHJbwDyvVtXSZUxKbpjckIcXHoLaHdQynodpmIq
	AqtO9yZgowpq8W3KF/Jc+vaOERVMFsQhatewN/SjMM7BFVmGoTxw5ZzvYY7w6LeSAdoApy0cMF+
	9eGBt1fswl0ftgECkvjkgWAOFOhB/Szu3v62WfibXPA7Kd/iJCzz2MuRvP43BhTZd03xXv0QLtA
	UA5vU8COEsEQ/OVgzVHfC/TcpOXgJ6nSbvT+N1mmg5F7LrBDZpZhEIP1aHAeL1RJMXbruZiIQvl
	ICXNgAJIG8vp1SvOi1WdY+rbhxjrQ1asGGcT5k0q2r5Km6+sAR2M4rfPRahNjv5U4m9ApHrIGU/
	ySp8a4OuCwmJ0w0GdQpGlSQskP2f4jscPiONlFY75rt8VTg3Tgg0pwS8xahJleAPpGPBDu4vyQo
	RkIy8OmjF5A0XXaMHuAc+Lr2JQNLzWEbLqHUMq2PrpBvkDHcnfqIrkjIJIO+qARYZaQOa27XTyv
	D0CJewU
X-Received: by 2002:a05:7301:fd05:b0:351:2958:1740 with SMTP id 5a478bee46e88-3515debbfc0mr4973570eec.37.1791457810536;
        Thu, 08 Oct 2026 04:10:10 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c2esm14847521eec.10.2026.10.08.04.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:10:09 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH mptcp-next] selftests: mptcp: sockopt: test passive Fast Open early write push
Date: Thu,  8 Oct 2026 16:40:03 +0530
Message-Id: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add automated test coverage for passive Fast Open early write data
push in mptcp_sockopt.c and mptcp_sockopt.sh.

The server enables TCP_FASTOPEN on an MPTCP listening socket, accepts
an incoming connection with SYN payload data, and immediately writes
reply bytes before the 3-way handshake fully completes. The client
connects with TCP_FASTOPEN_CONNECT, sends request data, and validates
reception of the server's reply over both IPv4 and IPv6.

Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 59 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 34 +++++++++++
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936..04af7cebc 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -28,6 +28,7 @@
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
+static bool do_tfo;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -247,6 +248,14 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		if (sock < 0)
 			continue;
 
+		if (do_tfo) {
+			int one = 1;
+
+			if (setsockopt(sock, IPPROTO_TCP, TCP_FASTOPEN_CONNECT,
+				       &one, sizeof(one)) < 0)
+				die_perror("setsockopt TCP_FASTOPEN_CONNECT");
+		}
+
 		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
 
@@ -264,7 +273,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6")) != -1) {
+	while ((c = getopt(argc, argv, "h6f")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -272,6 +281,9 @@ static void parse_opts(int argc, char **argv)
 		case '6':
 			pf = AF_INET6;
 			break;
+		case 'f':
+			do_tfo = true;
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -719,13 +731,36 @@ static int server(int pipefd)
 		break;
 	}
 
+	if (do_tfo) {
+		int qlen = 5;
+
+		if (setsockopt(fd, IPPROTO_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) < 0)
+			die_perror("setsockopt TCP_FASTOPEN");
+	}
+
 	r = write(pipefd, "conn", 4);
 	assert(r == 4);
 
 	alarm(15);
 	r = xaccept(fd);
 
-	process_one_client(r, pipefd);
+	if (do_tfo) {
+		char buf[64] = {0};
+		ssize_t n;
+
+		n = read(r, buf, sizeof(buf) - 1);
+		if (n <= 0)
+			die_perror("read tfo syn data");
+
+		n = write(r, "PONG_REPLY", 10);
+		if (n != 10)
+			die_perror("write tfo reply");
+
+		n = read(r, buf, 1);
+		close(r);
+	} else {
+		process_one_client(r, pipefd);
+	}
 
 	close(fd);
 	return 0;
@@ -775,6 +810,26 @@ static int client(int pipefd)
 
 	alarm(15);
 
+	if (do_tfo) {
+		const char *addr = (pf == AF_INET) ? "127.0.0.1" : "::1";
+		struct timeval tv = {.tv_sec = 5, .tv_usec = 0};
+		char buf[64] = {0};
+		ssize_t n;
+
+		fd = sock_connect_mptcp(addr, "15432", IPPROTO_MPTCP);
+		n = write(fd, "PING_DATA", 9);
+		if (n != 9)
+			die_perror("write PING_DATA");
+
+		setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+		n = read(fd, buf, sizeof(buf) - 1);
+		if (n <= 0 || strcmp(buf, "PONG_REPLY") != 0)
+			xerror("Fastopen early write failed: received %zd bytes '%s'", n, buf);
+
+		close(fd);
+		return 0;
+	}
+
 	switch (pf) {
 	case AF_INET:
 		fd = sock_connect_mptcp("127.0.0.1", "15432", IPPROTO_MPTCP);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e850a8742..b3b523ce8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -351,6 +351,39 @@ do_tcpinq_tests()
 	return $?
 }
 
+do_fastopen_tests()
+{
+	local lret=0
+
+	ip netns exec "$ns_sbox" sysctl -q net.ipv4.tcp_fastopen=3
+
+	ip netns exec "$ns_sbox" ./mptcp_sockopt -f
+	lret=$?
+
+	print_title "Fast Open early write v4"
+	if [ $lret -ne 0 ]; then
+		mptcp_lib_pr_fail
+		mptcp_lib_result_fail "Fast Open early write v4"
+		ret=$lret
+		return
+	fi
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "Fast Open early write v4"
+
+	ip netns exec "$ns_sbox" ./mptcp_sockopt -6 -f
+	lret=$?
+
+	print_title "Fast Open early write v6"
+	if [ $lret -ne 0 ]; then
+		mptcp_lib_pr_fail
+		mptcp_lib_result_fail "Fast Open early write v6"
+		ret=$lret
+		return
+	fi
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "Fast Open early write v6"
+}
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
@@ -366,6 +399,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
+do_fastopen_tests
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.34.1

