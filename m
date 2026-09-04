Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8143131E49
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491194; cv=none; b=Pk58Igj3UBZjHhR6bcDZ53pWl11s5EI5YPtqRUy+jq8PTSCP8mei8sERrG0VczoQFANZ74tWTlOVkGoo93u7mYTFexjXYWiLNC0xGwDOsvAlSLK7FCyVAD4omeu3JKKT2BhxDP1BmybcFjh8tGCkH98ZlfJ2yO2fAktReWPqs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491194; c=relaxed/simple;
	bh=xO1v/K05ml8TxHnMvt5jeec4Eqlj4gLIrenGiffxu08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmD53J7++4bhpY+0A+gD5j6F0mWsB/Uf4ZfzU+GqkP1QOjT6PeVt8fgAq40kIfKj0Ioga5uZtz3npAZMmmdnUnyzEirK0N093W1Rm4CYP+SGMWYlokrshOcxXz/bbXQnxi0IMfBvdthtkxPkpRADb3mDRrs3u59EHe4pD1VgDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJSRGLb8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJSRGLb8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-85aa9c1308dso5730847b3.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 20:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788491192; x=1789095992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p61UzFOYpxeFjBn2UekMhjM/CoL9dyhbBmO8TL8ddaw=;
        b=SJSRGLb8EIZ97iXZGBhwKJpibMJxULWY3A4rAxRZUOvtie2pGlifCDdCQipIeOX1gz
         6aUgO2qQxOeUQYxmr/QdY2JZTlLwbTa9M2H4hSnHDzuwcUryuLjXOGmStVMcIffi4t+s
         qZ2NCVASkEO0w0EroujsMGTQgPmhBI9yOMpx7KmtdMF1I23XjqcYjY2Df7QBesEhK/km
         lVTyZ95ey7kbCeTbn3p3Lw9BPWQ0gUnUj61Sl46BuxQQsJImw2oAgsBOTGmX1dlWiMx0
         PxRY5rzTK9CiXNZx9GgbZWi1IMkymuGNYOsZOuEXMhDNep2weuumSDvIcwR97alr/mrd
         QvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788491192; x=1789095992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p61UzFOYpxeFjBn2UekMhjM/CoL9dyhbBmO8TL8ddaw=;
        b=JVisaZKWNFwPm7fpHeFmhvxawFxKEiQP92yXnTx0PIa2pfqi+opKN+57H5l4KGAu98
         sATxK0lbJx9DLgb3svWMSfHSJR5K5ZtFoHI3GgHuuBqWeg281JXpWKs+FSV4/hoEkYyB
         xYq/e09GFgXnofyHUAon5LMEaiqplc9ok8tN00AORzYZVY6OVxAgwi7GSx4m5Wiu+BNJ
         CHhYGzJSX9yJpbnmq0SzwsPPp+n5JSN1KzDfdV39HFSa29Gm9IsaSm3sAJbYYPMYKsTS
         JYFrKDpNU/SRrkSJF7Q1LpfEUYMQgQbASr5iSbTONy3BjeOCrK5Doavcdx0EXvKfDtTg
         50Pg==
X-Gm-Message-State: AFuF++k++L2CZZRTSceVYSTT0JlDnsrNcCyvmecqls0U+vjB4g/1pOsM
	WXZ9tddehTg6i4sEUKyrO2oTugVyT/C+lcub8fcyqyPfUlhlhIn21thMdRlwNA==
X-Gm-Gg: AYBFou0pmaqP73MP5hcKHBjo1DYIdpY17P78dTvylZeggI6D1kCgCHWAWMmZnzXrVMW
	eRn8HdJPXNjTnPXI3OVZZvaNY5FDwGv3hLj9uAWtJvKSh7xmkzN1JTCE9z7GlJclGCKaMweK7Hp
	5CVd/uQvnl1FzZrUK3qGy7yJ+8laL/BJxlT7F/IobBxmepsVEtL6Tbx93QWRPYjkh1umAmKqnJA
	NNefODAI4aR4exxruFXe39ZZiU9RaJdTg5Vu8pTi/qMUVmrYUps4nrqLrJ/xhjM4lVNIJxgHvI3
	gMdhyr5o3sbrok2lRihI1LNB0JqqsMRCoFtyKkFGnCsVwiQMRO5N3yFDKdUmPKduNz4PmhebKQY
	FfgyWGoYqh+0C8U2GaRNiqQTqxpMN8pi1P6yqyqzOR61bqZWl7p8cBphkZNALX8/IEz5uJ0uPGX
	J/BUSVNtnDjIw4BPwcOiH+zMF/bwin1Z2t7oeOkGqD62FJWbILqJPE1gezQlNwedL+jQtYGyOdE
	03V1q/Aoq/WxzTW53S1pPjWwHebWS15BNpzq7C0yEKdVQZR+9OLVQsFyu968krM
X-Received: by 2002:a05:690c:670b:b0:816:b469:ccfd with SMTP id 00721157ae682-8712727669emr18253457b3.15.1788491191697;
        Thu, 03 Sep 2026 20:06:31 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b720e57sm9625237b3.40.2026.09.03.20.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 20:06:30 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2] selftests: net: csum: filter packets by source address and port
Date: Thu,  3 Sep 2026 23:04:42 -0400
Message-ID: <20260904030624.3833721-1-willemdebruijn.kernel@gmail.com>
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

During tests expecting an invalid checksum (-E), background packets
(with a valid checksum) fail the test.

Also
- add an inter-packet delay to avoid drops from bursts.
- remove a comment that is no longer correct.

Fixes: 91a7de85600d ("selftests/net: add csum offload test")
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v1 -> v2
    - also check udp socket, with recvfrom

v1: https://lore.kernel.org/netdev/20260831210128.1359978-1-willemdebruijn.kernel@gmail.com/
---
 tools/testing/selftests/net/lib/csum.c | 43 ++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index e28884ce3ab3..5c8f9d175dd3 100644
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
@@ -571,15 +570,38 @@ static int recv_prepare_packet(void)
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
+			if (!cfg_zero_sum &&
+			    sin->sin_port != htons(cfg_port_src))
+				continue;
+		} else {
+			struct sockaddr_in6 *sin6 = (void *)&addr;
+
+			if (memcmp(&sin6->sin6_addr, &cfg_saddr6.sin6_addr,
+				   sizeof(sin6->sin6_addr)))
+				continue;
+			if (!cfg_zero_sum &&
+			    sin6->sin6_port != htons(cfg_port_src))
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
 
+	if (!cfg_zero_sum && udph->source != htons(cfg_port_src))
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
-- 
2.55.0.979.g7e5102b832-goog

