Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4754EEAE
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882945; cv=none; b=jalwNBNShcToLnm8aTEICi9FtXDlwtpqXQ4+13hpd3L7DzcrOU6oqQu6GFGaTsLzW+WqUk/GYsLzspcjray6mvomdlrOytMwoOotvuzW62P+pzDQg5A/B4hoUPwZmO4NHC5Oy4sdlVXxegYWexbTQosF3nSSiQYjL5d4AT2TYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882945; c=relaxed/simple;
	bh=Fr0xxasfpoCdqyW2Y+wnB0SRm0CawnQKI+wUYZ9sMYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9ewrrKhUdza5R0gsiKkLUYypUN4yAwW60cyVRZ9shOzLYbnwe+K5s6vLqxhvNqoO4lufzJKc8taiUJnSRDuMX7Wsq4vkcvI7hkIC6PetIlo9XmhAGKReo5CtNpqmkGMf/4nIhr7dMcxq/gpGAcQ7JyWXFOCAawbvOqQ5pifNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSLy1wkf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSLy1wkf"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-861f30636f9so70553127b3.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882943; x=1789487743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+h93Z2EsFFcXgx5aRvzZ3nxYHcEqvVXtZkykR/Wpr5k=;
        b=JSLy1wkfBgy2MLrdeHunAHb9LLTT2DeBliYpgn/cXrcL9DT7hYmXKSLw2t10wJCcwM
         PYdZdWzAsaeBQozI96c98sHiRAndrRRqgKHpK1iRsxcMgqFQMRA+NlkjtK2aJ2lVQCU4
         O4O6ZPV9n6/VR+b5iBm3h3N+6dEkjeQHgpcSpOUb/YGWKwUaMxBie/WO9grMB+VcUTUR
         ZGgviusf2NQS5JcKHbKrjaC/bxOszDHXSE8tM6dcDGz5sSxxunKIX9UutFwI6yvAugOo
         jaFvwMVzHQIKFzj61QKLjYlg6y6TxwcwJc/o+Hw89IDC1f1QFH0AMKMzf+H6JtjgUsjB
         0mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882943; x=1789487743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+h93Z2EsFFcXgx5aRvzZ3nxYHcEqvVXtZkykR/Wpr5k=;
        b=NI4Jj4WHbRLigpEBNg6mK1O0ZeeZ6OF3/ptU0yt3F9ee0LeByU84JQ5XzXJ4c3I7mO
         joxqm++rfq2e3Ln77Uxts0GM7kJG3/ZB17D8WkMzpO+3JXIM4yeKvrPZoOFmBI/1Totr
         Md1b4bRHz15pw5gqSeyWUhoo24l9ZTrsGfVftTJkPjv4ZGCnd+D8NezlveZybwBphKuP
         yyJF4LIkvI9CWC94AvOU+6l3kjC3F/HZ/9pHThencVEJYyukOUmlNAFHs59IKwBEZN1P
         SyeeDYIzZE5cjpxyLhl62CXyxXNr1smHI055080wODtj4oQdFHXpT8MAWqSIDkBfBS1D
         pcvg==
X-Gm-Message-State: AFuF++mPUCKIwb+riOiWXHfyH0Ea67WqU+6AGB2tZB2eZIvjv2qrExAD
	8mWMTVrL0zVjielI2/NBNCZ8g9NnbPi4nhp6M76z6WwQuCG86QFSVoTinyi6qw==
X-Gm-Gg: AYBFou30MmodX0mX4ZgZccmRo8VrMNEhl8umEQtQW922U4og090nfwiV5DBF/SDM+xN
	Qt48fYmZV1lFSNt37bIevE9GUwTJw//X0ifDO5XXFGGDUqOvc03vumSPLWGcIrXN5j7S3c1jKVq
	DdsJDNiCNYtsSP5qwZ1EXnY25ntZkrhtfl4XS5WeiMTqw4jQjzDhrxtXKv0IBgGfOHDbkEVOrhU
	c5Rwq5I4NHE4A9TApRIJkhQh6FhKW5q6PGJUCfVv5ut3MbmEhomHrSIPtMCZjKJIzflwqQoYWlz
	NVUHG9k7/YyFFKYc8bHTosyh4/ieBgwmjWTUf6Yt7w4ZEzMJgGTMcDiozmRlsVwfUIf4D++S3Jv
	aXJBwpiW9X13/j5t3TxcNlbfg2BJAMu6zmA/7lE1gqbnc5wN1DsgAlbDTN3uWm6pXHsdKzf70yL
	UVjHJhcch8xciokgF2YWI+Tlb65DvbrSRSiGhbcynkkPSgxeX8ISIA070Z+gaA9G4HSfD7ZBlv+
	5m9bq/3z+r2lDPf9t9WsAgl/q64BMsVtExeSWAbSdw8e3NxACTXkJBezwTYbpyG7luS3+fJwlo=
X-Received: by 2002:a53:9310:0:b0:66f:c1bc:4031 with SMTP id 956f58d0204a3-66fc1bc465amr5613629d50.94.1788882942839;
        Tue, 08 Sep 2026 08:55:42 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb49763bfsm10598362d50.19.2026.09.08.08.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:55:42 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3] selftests: net: csum: filter packets by source address and port
Date: Tue,  8 Sep 2026 11:54:29 -0400
Message-ID: <20260908155537.813889-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Add source address and port verification in recv_verify_packet_* and
recv_udp: non-matching packets are skipped.

The receiver reads from PF_PACKET and UDP sockets to verify incoming
packets to test hardware checksum offload. It did not validate the
packet source address or source port.

During tests expecting an invalid checksum (-E) or zero checksum (-Z),
background packets can fail the test.

For -Z, build_packet_udp chooses a specific source port that causes
the checksum to sum to zero. When running in receive-only mode (-R),
call build_packet in do_rx to compute the expected source port so
that source port filtering can be applied to -Z as well.

Also
- add an inter-packet delay to avoid drops from bursts.
- remove a comment that is no longer correct.

Fixes: 91a7de85600d ("selftests/net: add csum offload test")
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v2 -> v3
    - also fix same issue for zero checksum:
      calculate expected src_port by calling build_packet on rx side
  v1 -> v2
    - also check udp socket, with recvfrom

v2: https://lore.kernel.org/netdev/20260904030624.3833721-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260831210128.1359978-1-willemdebruijn.kernel@gmail.com/
---
 tools/testing/selftests/net/lib/csum.c | 55 +++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index e28884ce3ab3..ad960e07e31b 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -2,8 +2,7 @@
 
 /* Test hardware checksum offload: Rx + Tx, IPv4 + IPv6, TCP + UDP.
  *
- * The test runs on two machines to exercise the NIC. For this reason it
- * is not integrated in kselftests.
+ * The test runs on two machines to exercise the NIC.
  *
  *     CMD=$((./csum -[46] -[tu] -S $SADDR -D $DADDR -[RT] -r 1 $EXTRA_ARGS))
  *
@@ -236,7 +235,8 @@ static void *build_packet_udp(void *_uh)
 		uh->source = 0;
 		uh->source = checksum(uh, IPPROTO_UDP, sizeof(*uh) + cfg_payload_len);
 
-		fprintf(stderr, "tx: changing sport: %hu -> %hu\n",
+		fprintf(stderr, "%s: changing sport: %hu -> %hu\n",
+			cfg_do_tx ? "tx" : "rx",
 			cfg_port_src, ntohs(uh->source));
 		cfg_port_src = ntohs(uh->source);
 	}
@@ -249,7 +249,8 @@ static void *build_packet_udp(void *_uh)
 	if (cfg_bad_csum)
 		uh->check = ~uh->check;
 
-	fprintf(stderr, "tx: sending checksum: 0x%x\n", uh->check);
+	if (cfg_do_tx)
+		fprintf(stderr, "tx: sending checksum: 0x%x\n", uh->check);
 	return uh + 1;
 }
 
@@ -571,15 +572,36 @@ static int recv_prepare_packet(void)
 static int recv_udp(int fd)
 {
 	static char buf[MAX_PAYLOAD_LEN];
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
 	int ret, count = 0;
 
 	while (1) {
-		ret = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
+		addrlen = sizeof(addr);
+		ret = recvfrom(fd, buf, sizeof(buf), MSG_DONTWAIT,
+			       (struct sockaddr *)&addr, &addrlen);
 		if (ret == -1 && errno == EAGAIN)
 			break;
 		if (ret == -1)
 			error(1, errno, "recv r");
 
+		if (cfg_family == PF_INET) {
+			struct sockaddr_in *sin = (void *)&addr;
+
+			if (sin->sin_addr.s_addr != cfg_saddr4.sin_addr.s_addr)
+				continue;
+			if (sin->sin_port != htons(cfg_port_src))
+				continue;
+		} else {
+			struct sockaddr_in6 *sin6 = (void *)&addr;
+
+			if (memcmp(&sin6->sin6_addr, &cfg_saddr6.sin6_addr,
+				   sizeof(sin6->sin6_addr)))
+				continue;
+			if (sin6->sin6_port != htons(cfg_port_src))
+				continue;
+		}
+
 		fprintf(stderr, "rx: udp: len=%u\n", ret);
 		count++;
 	}
@@ -620,6 +642,9 @@ static int recv_verify_packet_tcp(void *th, int len)
 	if (len < sizeof(*tcph) || tcph->dest != htons(cfg_port_dst))
 		return -1;
 
+	if (tcph->source != htons(cfg_port_src))
+		return -1;
+
 	return recv_verify_csum(th, len, ntohs(tcph->source), tcph->check);
 }
 
@@ -647,6 +672,9 @@ static int recv_verify_packet_udp(void *th, int len)
 		return recv_verify_packet_udp_encap(udph + 1,
 						    len - sizeof(*udph));
 
+	if (udph->source != htons(cfg_port_src))
+		return -1;
+
 	return recv_verify_csum(th, len, ntohs(udph->source), udph->check);
 }
 
@@ -659,6 +687,9 @@ static int recv_verify_packet_ipv4(void *nh, int len)
 	if (len < sizeof(*iph) || iph->protocol != proto)
 		return -1;
 
+	if (iph->saddr != cfg_saddr4.sin_addr.s_addr)
+		return -1;
+
 	ip_len = ntohs(iph->tot_len);
 	if (ip_len > len || ip_len < sizeof(*iph))
 		return -1;
@@ -680,6 +711,9 @@ static int recv_verify_packet_ipv6(void *nh, int len)
 	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
 		return -1;
 
+	if (memcmp(&ip6h->saddr, &cfg_saddr6.sin6_addr, sizeof(ip6h->saddr)))
+		return -1;
+
 	payload_len = ntohs(ip6h->payload_len);
 	if (payload_len > len - sizeof(*ip6h))
 		return -1;
@@ -940,6 +974,9 @@ static void do_tx(void)
 			cfg_payload_len = rand() % MAX_PAYLOAD_LEN;
 			buf = build_packet(_buf, sizeof(_buf), &len);
 		}
+
+		/* avoid bursting */
+		usleep(20);
 	}
 
 	if (close(fd))
@@ -952,6 +989,14 @@ static void do_rx(int fdp, int fdr)
 	long tleft, tstop;
 	struct pollfd pfd;
 
+	if (!cfg_do_tx && cfg_zero_sum) {
+		static char _buf[MAX_HEADER_LEN + MAX_PAYLOAD_LEN];
+		int len;
+
+		/* calculate source port that causes csum to add up to zero */
+		build_packet(_buf, sizeof(_buf), &len);
+	}
+
 	tstop = gettimeofday_ms() + cfg_timeout_ms;
 	tleft = cfg_timeout_ms;
 
-- 
2.55.0.979.g7e5102b832-goog

