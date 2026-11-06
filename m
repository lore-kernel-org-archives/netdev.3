Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985303;
	b=JmsHdAj24eU0HLwcfeY+qq5F9ifQqxDe2xlhgVO7GbfUStNGUNCfbWMPmK7gscJkhBOI
	 XFzvxvYH2/XL0YdC9nqv4s87jz5nkFyAC/ooJW8VI7uwtMoZsKW62QjIRcYvyXSfjq5qI
	 eFk9qsyzLlVq182HXZbJe9JjW1xznY5CFRFeAgiWk4Bp1U6e8rvzvANnr2H/v0r1QCMen
	 H+Vsey+98X0qjiI/ZliMZEvSY/BSVvpFims0oDjYuX/gY2k8Cd3+HI/3D3NQKHcsjE6sd
	 8/4ReAw2sGplIBCrpCcQJ73PuIrx5ADNx4WCj5nKPBjGcsq2F897/0qSXQ9xQ8zCUAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1S4mR0QPoC6nO8yYpDVgFwSwnBHCQTPEsHvUyW429Rc=;
	b=U0PG7yPyisbDwFpe8dA+Lyc6hsu35FwnBpbfoUpLXTJPiPznZHktbDYytK6wJpJXUAWS
	 eq1g28X3RH7d7cUKaTkUR7xng7qDUTHWF+GsU/w7hdhl7POMBX/yYTu6K9p3T54S+5ywd
	 EdRFHHZTwrjrY2yVrgTXSHG/NDWATSSSKkPa1vSqqRMEXvkhuuanOb5mL81D3TsPJbQxo
	 TJBYfGms2CuPOYvUXk+XobN5IuNo9YltF4dPkdOGOsgE6VtgbDgI3VuE5KzU4iCVIw8B/
	 o2ecvpmHquXxHtUJHc3a5AoA+Pnvz4/jW8ALog1KY8Zsyg5D67X+r9c7aiJ05kRbNFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCX3loN9;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B8606D804
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F04B8606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCX3loN9
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so7728385e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 09:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793985287; x=1794590087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1S4mR0QPoC6nO8yYpDVgFwSwnBHCQTPEsHvUyW429Rc=;
        b=WCX3loN9CbTwZTJ3fT8dhK2OpMhEDhmrTp2p+I4v9aNr8BkWSbNAPaDAUFis2zb37H
         dAg0nJlkO8mtwFqgAobQdD1+1LDKdkMmwY2Xy2kyV1wrMDBaSyTWnaV12noKRyXcayzM
         WoKEEMwtX6aHJa8pQJiw7uM2lxsuZdxDwtS8OaFod3k1RtJsOtNq5Hr3jmcFL3Ldkp9j
         Kqyryy0Vy2FSm0KC5CJ3PdExVN+4OSRHdWUtAAILX+McR+hr1Wrxw1xAXGR1wDY9x9aW
         xLYnyP8RhwYUD4/tepKFDph2R7AAzbhsiND64uLFXv1mUCOMIOgc5fcPD/HooHX+68o0
         KR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985287; x=1794590087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1S4mR0QPoC6nO8yYpDVgFwSwnBHCQTPEsHvUyW429Rc=;
        b=ZKw6dWVZ5iRFoGYjrKlmfpEamkC6AgUHu8jw3lvyRaV3KXz5diCrrVns4wOIE72tYp
         FXZ2C9T2LSytNe4qweDJQgB7eIZfWA+u77gA/7dRbMldjm7WjmND84L3O5EMxJsc4OOl
         jbDuRc6Xo7zHFba06UH2OtdLwsxEZmfkyVLPhebkk+XVudF98KvOAK1CNPEihuxzjeE9
         vVjXnpc3PKmP8UugFUVGNRm7IrERPPsL/tipKhWGWyfW4xpb5G5SJWbIgAnApjhe9ykO
         z9K6ocpUjA0L44sR7a9qD690hYtVmrchqDrl1iFVDVbpWNpFZQHUWSjfuksOVXnSauBm
         cdaA==
X-Gm-Message-State: APuU4Z+G3h4jQqoTVUab+R04pWzTWSLL3LgJXgqw8FvfyERA+w56exSz
	f3DHt+MgZR3DjQb8F/hOm5lSfu87rU4TM9wMh/6EzL5p3ZjS7SAljLWSVj2UiB/2
X-Gm-Gg: AYBFou1cfQr7ZT/kyb0NffEbGqXrnmDi2xvBWvTIW/g6fGiiCYMYnpeS7RE35mspDIZ
	y4jSl6ciQjAI46F/hgPWAGnny4LNLmqAlxUhBoytJ/WS0U4kGUGydaGu3ZnxLRbXbl3OP9pz6AS
	Y9VJdez8vhPHyEP5VKT1rboKW6YBT6S2yFVxJgAtxf49ASaN/FaphTCNT2B+GquXy3IgncFKJee
	1C3AnmMrKql8p5FYI/9zLQOFa9sVJTTWM1+nASvUE2KI4BLa7KF9W8zk3A0xDy5NACZhuZjG8DT
	FBZ1FhangOPSTOypEwu9n2xBx0lDULChNmvCWwwBqzSkbzT17EXxvdgeoL2xQlPB9zR7qTFqcsA
	PhIOsBc5lxk5RqvPpr7BWrgoyHY1HOoqctQOkmRc1ihbu2f0o8y5d+br9hvXS+Ky2aOB89De7Mh
	rCSuyADXQS8Xt+Juz+b5pSJo5yKrOh6N21fy/GTnbzpwwBevK0oZC3wRO2IcadsLk4snOhCezrK
	bDufzyZdEkZ2ll2sh3ncpoBU0NIPQQx8FQP/+poFhuUNhedZHBuztLjfdKhGwNFUikUu9T95YNC
	7ztsor+I/G4U8owDzmp6LBw7vtlDXGi1MTrI2LubPQtU73BQmLEpQpQFuP/Oas66c/heRJfew/1
	n9G1vDN0VC8IvmzO4tJrtBnha3nh3F81KBpqNcf2IhVCY/RLQywQN6VWFq1EsT4N/4B+PXXmbdE
	vFni6i1NVKGCr2kP4zBfbJiRTvQcLuwfn96q78+2Vj
X-Received: by 2002:a05:600c:818e:b0:4b3:9540:47a6 with SMTP id 5b1f17b1804b1-4b6dff86e38mr52698025e9.28.1793985287188;
        Fri, 06 Nov 2026 09:14:47 -0800 (PST)
Received: from localhost.localdomain ([90.95.39.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46489sm148071985e9.3.2026.11.06.09.14.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 09:14:46 -0800 (PST)
From: Florin Badita-Nistor <baditaflorin@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 2/2] selftests/net: cover odd-sized local port ranges with one free port
Date: Fri,  6 Nov 2026 19:14:42 +0200
Message-ID: <20261106171442.31811-3-baditaflorin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261106171442.31811-1-baditaflorin@gmail.com>
References: <20261106171442.31811-1-baditaflorin@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leave each port in three- and five-port socket-local ranges as the only
available candidate and verify that bind(..., 0) can allocate it. Cover
both lower-bound parities and repeat allocation to vary the random
starting offset. Use the existing IPv4/IPv6 TCP, UDP, SCTP and MPTCP
fixture variants.

This catches the false EADDRINUSE caused by rounding an odd-sized range
down during TCP port allocation. Without the preceding fix, the TCP
and MPTCP variants fail on both IP versions when the last port in a
three-port range is the only free one. With the fix, all eight variants
pass.

Allow the loopback bind helper to take a port so the test can hold
explicit binds on every other candidate. Retain the existing helper for
automatic binding and run under the existing isolated-network-namespace
wrapper.

The regression test was developed with Codex assistance and exercised
on booted x86-64 KVM kernels before and after the fix.

Signed-off-by: Florin Badita-Nistor <baditaflorin@gmail.com>
---
 .../selftests/net/ip_local_port_range.c       | 67 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 3d32b33cb..c17d95045 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -44,7 +44,7 @@ static int get_so_domain(int fd)
 	return domain;
 }
 
-static int bind_to_loopback_any_port(int fd)
+static int bind_to_loopback_port(int fd, __u16 port)
 {
 	union {
 		struct sockaddr sa;
@@ -57,13 +57,13 @@ static int bind_to_loopback_any_port(int fd)
 	switch (get_so_domain(fd)) {
 	case AF_INET:
 		addr.v4.sin_family = AF_INET;
-		addr.v4.sin_port = htons(0);
+		addr.v4.sin_port = htons(port);
 		addr.v4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 		addr_len = sizeof(addr.v4);
 		break;
 	case AF_INET6:
 		addr.v6.sin6_family = AF_INET6;
-		addr.v6.sin6_port = htons(0);
+		addr.v6.sin6_port = htons(port);
 		addr.v6.sin6_addr = in6addr_loopback;
 		addr_len = sizeof(addr.v6);
 		break;
@@ -74,6 +74,11 @@ static int bind_to_loopback_any_port(int fd)
 	return bind(fd, &addr.sa, addr_len);
 }
 
+static int bind_to_loopback_any_port(int fd)
+{
+	return bind_to_loopback_port(fd, 0);
+}
+
 static int get_sock_port(int fd)
 {
 	union {
@@ -301,6 +306,62 @@ TEST_F(ip_local_port_range, single_port_range)
 	}
 }
 
+/* Leave each port in turn as the only available one. An odd-sized range
+ * must not report exhaustion while a port at either end is still free.
+ */
+TEST_F(ip_local_port_range, odd_port_range)
+{
+	const struct {
+		__u16 low;
+		__u16 high;
+	} ranges[] = {
+		{ 40000, 40002 },
+		{ 40001, 40003 },
+		{ 40000, 40004 },
+		{ 40001, 40005 },
+	};
+	int i, j, port, free_port, fd, err;
+	__u32 range;
+	int fds[5];
+
+	for (i = 0; i < ARRAY_SIZE(ranges); i++) {
+		range = pack_port_range(ranges[i].low, ranges[i].high);
+		for (free_port = ranges[i].low; free_port <= ranges[i].high; free_port++) {
+			for (port = ranges[i].low; port <= ranges[i].high; port++) {
+				j = port - ranges[i].low;
+				fds[j] = -1;
+				if (port == free_port)
+					continue;
+				fd = socket(variant->so_domain, variant->so_type,
+					    variant->so_protocol);
+				ASSERT_GE(fd, 0) TH_LOG("socket failed");
+				fds[j] = fd;
+				err = bind_to_loopback_port(fd, port);
+				ASSERT_EQ(err, 0) TH_LOG("bind(%d) failed", port);
+			}
+
+			/* Exercise different random starting offsets. */
+			for (j = 0; j < 16; j++) {
+				fd = socket(variant->so_domain, variant->so_type,
+					    variant->so_protocol);
+				ASSERT_GE(fd, 0) TH_LOG("socket failed");
+				err = setsockopt(fd, SOL_IP, IP_LOCAL_PORT_RANGE,
+						 &range, sizeof(range));
+				ASSERT_EQ(err, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE) failed");
+				err = bind_to_loopback_any_port(fd);
+				ASSERT_EQ(err, 0) TH_LOG("range %d-%d, free port %d",
+						       ranges[i].low, ranges[i].high, free_port);
+				ASSERT_EQ(get_sock_port(fd), free_port);
+				ASSERT_EQ(close(fd), 0);
+			}
+
+			for (j = 0; j <= ranges[i].high - ranges[i].low; j++)
+				if (fds[j] >= 0)
+					ASSERT_EQ(close(fds[j]), 0);
+		}
+	}
+}
+
 #define REUSEADDR	0x1
 #define REUSEPORT	0x2
 
-- 
2.51.0

