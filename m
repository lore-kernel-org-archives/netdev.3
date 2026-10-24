Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851138;
	b=LCBG1FAFYuP4ZgR+N2VlM+79t01VXk1MWWLYZKNXnLNNCtprAE7S4kSJwbQQnzKUvSVV
	 W8hYal6UdG1Ym+ad1pm2pT7WgUwQdAb1OWNkGa97oRMfnnRcLXzqR15xuYk+lTBdE7/Li
	 1ykxWKFCypS4qjhXTz3LF3RujvCzn7MBXvWC1BOHmeoEMAHLEP5y3X9usqLrTRDjZgWI9
	 4QN/xCTc/hZnhjEiyAlbwHvD852sHIM1ucw5zAqdWgjhKPk8QxbND3vBmaONqdRhYl34U
	 SxsoI4P79mEvM+2vq0F9RzTA+xvR/dmdUNo8TrwiOhLQ9PsUrR++9T3Jh+iVcMo2rgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Yyzh6gFbMrsLZ8iiaehNJIWxExIuWalHcjeFqUeoXSs=;
	b=Zay4q6gtKp30BY8clt8j0v2aNeMOvxB8SJiD7/nQMrNFTKHCAio8NEIV9kDlvDU8zkP1
	 0ROvi/p+i3d0eOyu4r6xt9foDcMa7Bksb4iNr8hrlSjzktEyr2MAfTKC2I7Sb+JdKMsDC
	 t+AYEwROcT4ynr8Q7nVvlb42ABVjdmsOw3DK3cxbcah1eiyyHeaYIuMXd2lwF+S484tB/
	 aV+4wkt7X/U3HzVp4g3I7XRYZ1/fKMM+fbqS5vGsqghDRHewgpyT4EgEBV8OAsQwXXw24
	 3VslWCGWQIs7idFV+7oKdUvTImQA6oCWk813SOo3YYC3s3UmZqN5I1NmsAJMgOZBD2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qTPSVLrX;
	arc=none smtp.remote-ip=74.125.229.132
Received: from mail-dl2-f4.google.com (mail-dl2-f4.google.com [74.125.229.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF020606A321
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF020606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qTPSVLrX
Received: by mail-dl2-f4.google.com with SMTP id a92af1059eb24-1922a6f0d23so490602c88.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851137; x=1793455937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yyzh6gFbMrsLZ8iiaehNJIWxExIuWalHcjeFqUeoXSs=;
        b=qTPSVLrX6KjTaKVZPOnMyQrgKGaDHBlX0k6gTf2OpnLCrCw7VVMO9anns2NZxg8QWd
         tMkqskOA19nxInJIpY3VEoaeAHxlqsmZtPr676u6fm4hY5k7LzBV1vcWQA1ackON6VgQ
         Ar9XnH222I9F/L+MaEYh4H0oBoNYNHnHX39HUgmkHF8t/ZLLLoI7woTa3qMGtoCtiVEK
         aGt8UoF2XxD3ww6fkoBmKn4TzGIVwtDFbAWoNzaels9IVEgAyow056yfdyOgAKfMkUEP
         M15FcJbj4Fo3WnYbQcwaGBkX+iPC+eqs/ZfuLl8tUM9qdwO56Cm8Kk0hyD74gyiofITo
         B4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851137; x=1793455937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yyzh6gFbMrsLZ8iiaehNJIWxExIuWalHcjeFqUeoXSs=;
        b=ToUBezwrB0kT1gNz2rE1yROTfCBprfQDbUCEv3espYNoWngTxDQ6b49miT/A2C6amA
         JKfGTSBT6HXKHpgxbXwosYBSf1Yqc6rm6Ysd/AHtmFsFa+wTwQSIN1a1nlVe5LiCsb+V
         BfccbGf9QjV1RUMN/v/VWU0FB+V71cT+dq8tquhWbD8r7x3yZmfQSVjNVK2gQbRPf2NE
         YAZdN7kRijrzkBkbIgifSf6760x9VhglH65+u/kn/uc9uKq/BIA939TM7iXix4z7NNtQ
         wAiHy65krsOaJfiHzWXB2FBTwRvDbpS+XWF2l9ADQzzkloXAfiClV+YFoe3181qipDsD
         oddQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwQ965PXA/223Rj0oZKaGO/Fc7/WPQvEEe/vP/9392Ynj6nH29bCgn+Hgi9JWA53BS/x7hZJc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZpZ/WLnsyFeZNcfPOzx6seKOTaPfc0bw1wKhDL6PQdFs2ABK8
	lOJ43M4gz0tgOtb/0n2b/2rHKavSQvDr+zjRzxHjFpDiQjUafMbJoB5z
X-Gm-Gg: AYBFou2XsLAOi060ONP9k4tu+XQUPkZjM8gboMk9o9eUOdzCM5HzIapqNVnHVGY9RgT
	mdrOOH6KToj32x7AJnMwPlNqYcs8iNzQwwiQ5OMjwRIc/wdySMeFQ+X4Zl3/YaOpCZDF3pWcNEV
	ubIv1YDEZaK6fJrh/UfDHCo6WUKgHQxP9hRTlM8l1gXTdH55ATYZ6k+PmNHR2vgBPJvhYDwySIc
	DBbr28pcd7mzUayDtcTo8aNWstW8Kr+GKkSUBw6X0gG1Ca5f/CweMb6+cA8/guAKVGEP0G9Q2Pe
	/sR2G+J5ieaQgDozbnNBHukav5CoGwXzRB/mo3GCCabd6aKLJms+cUgNKPf+KQjLRGyWLDu39lo
	wwvdvQ32IvB8J/zo3SG//rppCOiwmY/8+mAv5oqH4xGfO8H7PaYY6PtlBzXN2/Bwex8/TitGiv0
	AI8XasnDZEtFUyjXmaDzjWeHdshiEmM4QnrPUIQBd1y1jw8SLggTQawbAOKEy+23/IwZSra0mcz
	/8YJ4wYiSy7xtOeE/qA2S3V+Bu8TBKS9Rf51uDFGSh4jQSUVBkJ3ieVvsjybX89s1EQ3tOmRvUK
	cpHN/eq+1SdM62qCNbqI/I5b
X-Received: by 2002:a05:7022:ea8b:b0:175:525c:90b4 with SMTP id a92af1059eb24-19935be8344mr2523775c88.20.1792851136789;
        Sat, 24 Oct 2026 07:12:16 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:6887:87ec:7e6f:2a79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19a3736d16fsm6366905c88.12.2026.10.24.07.12.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 07:12:16 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v2 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Sat, 24 Oct 2026 22:11:57 +0800
Message-Id: <20261024141157.59301-3-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261024141157.59301-1-testwrzwrz@gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
 <20261024141157.59301-1-testwrzwrz@gmail.com>
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

Extend test_xdp_metadata to send the same UDP packet both as one TX
descriptor and as two descriptors, and to run the existing metadata and
checksum verification for both cases.

Reuse the existing AF_XDP setup, packet generation, completion, and receive
helpers in xdp_metadata.c instead of adding a separate test harness.

Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 126 ++++++++++++------
 1 file changed, 86 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..1cf70fb800fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -19,6 +19,8 @@
 #define RX_NAME "veRX"
 
 #define UDP_PAYLOAD_BYTES 4
+#define UDP_SPLIT_BYTES (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
+			   sizeof(struct udphdr))
 
 #define UDP_SOURCE_PORT 1234
 #define AF_XDP_CONSUMER_PORT 8080
@@ -56,13 +58,13 @@ struct xsk {
 	struct xsk_socket *socket;
 };
 
-static int open_xsk(int ifindex, struct xsk *xsk)
+static int open_xsk(int ifindex, struct xsk *xsk, __u32 bind_flags)
 {
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	const struct xsk_socket_config socket_config = {
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
-		.bind_flags = XDP_COPY,
+		.bind_flags = bind_flags,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
@@ -133,36 +135,36 @@ static void close_xsk(struct xsk *xsk)
 	munmap(xsk->umem_area, UMEM_SIZE);
 }
 
-static int generate_packet(struct xsk *xsk, __u16 dst_port)
+static int generate_packet(struct xsk *xsk, __u16 dst_port, u16 split_len)
 {
 	struct xsk_tx_metadata *meta;
 	struct xdp_desc *tx_desc;
 	struct udphdr *udph;
 	struct ethhdr *eth;
 	struct iphdr *iph;
+	u16 pkt_len;
+	u32 num, addr;
 	void *data;
 	__u32 idx;
+	u8 pkt[256];
 	int ret;
 
-	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
-	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
+	pkt_len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
+	if (!ASSERT_LT(split_len, pkt_len, "split_len"))
 		return -1;
 
-	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
-	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
-	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
-	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
-
-	meta = data - sizeof(struct xsk_tx_metadata);
-	memset(meta, 0, sizeof(*meta));
-	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP;
+	num = split_len ? 2 : 1;
+	ret = xsk_ring_prod__reserve(&xsk->tx, num, &idx);
+	if (!ASSERT_EQ(ret, num, "xsk_ring_prod__reserve"))
+		return -1;
 
-	eth = data;
+	memset(pkt, 0, sizeof(pkt));
+	eth = (void *)pkt;
 	iph = (void *)(eth + 1);
 	udph = (void *)(iph + 1);
 
-	memcpy(eth->h_dest, "\x00\x00\x00\x00\x00\x02", ETH_ALEN);
-	memcpy(eth->h_source, "\x00\x00\x00\x00\x00\x01", ETH_ALEN);
+	memcpy(eth->h_dest, RX_MAC, ETH_ALEN);
+	memcpy(eth->h_source, TX_MAC, ETH_ALEN);
 	eth->h_proto = htons(ETH_P_IP);
 
 	iph->version = 0x4;
@@ -180,18 +182,38 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	udph->source = htons(UDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
+	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
 	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
 					 ntohs(udph->len), IPPROTO_UDP, 0);
 
-	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
+	addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
+	tx_desc->addr = addr + sizeof(*meta);
+	tx_desc->len = split_len ? split_len : pkt_len;
+	tx_desc->options = XDP_TX_METADATA;
+	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
+	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+	memcpy(data, pkt, tx_desc->len);
 
-	meta->flags |= XDP_TXMD_FLAGS_CHECKSUM;
+	meta = data - sizeof(*meta);
+	memset(meta, 0, sizeof(*meta));
+	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP | XDP_TXMD_FLAGS_CHECKSUM;
 	meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
 	meta->request.csum_offset = offsetof(struct udphdr, check);
 
-	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
-	tx_desc->options |= XDP_TX_METADATA;
-	xsk_ring_prod__submit(&xsk->tx, 1);
+	if (split_len) {
+		u32 addr2 = (idx + 1) % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+
+		tx_desc->options |= XDP_PKT_CONTD;
+		tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + 1);
+		tx_desc->addr = addr2 + sizeof(*meta);
+		tx_desc->len = pkt_len - split_len;
+		tx_desc->options = 0;
+		data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+		memcpy(data, pkt + split_len, tx_desc->len);
+	}
+
+	xsk_ring_prod__submit(&xsk->tx, num);
 
 	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
 	if (!ASSERT_GE(ret, 0, "sendto"))
@@ -224,24 +246,26 @@ static int generate_packet_inet(void)
 	return err;
 }
 
-static void complete_tx(struct xsk *xsk)
+static void complete_tx(struct xsk *xsk, u32 num)
 {
 	struct xsk_tx_metadata *meta;
 	__u64 addr;
 	void *data;
-	__u32 idx;
-
-	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
-		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
-
-		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
-
-		data = xsk_umem__get_data(xsk->umem_area, addr);
-		meta = data - sizeof(struct xsk_tx_metadata);
-
-		ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
-
-		xsk_ring_cons__release(&xsk->comp, 1);
+	__u32 idx, i;
+
+	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, num, &idx), num,
+		      "xsk_ring_cons__peek")) {
+		for (i = 0; i < num; i++) {
+			addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx + i);
+			printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx + i, addr);
+
+			if (i == 0) {
+				data = xsk_umem__get_data(xsk->umem_area, addr);
+				meta = data - sizeof(*meta);
+				ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
+			}
+		}
+		xsk_ring_cons__release(&xsk->comp, num);
 	}
 }
 
@@ -398,7 +422,7 @@ void test_xdp_metadata(void)
 
 	/* Setup separate AF_XDP for RX interface. */
 
-	ret = open_xsk(rx_ifindex, &rx_xsk);
+	ret = open_xsk(rx_ifindex, &rx_xsk, XDP_COPY);
 	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
 		goto out;
 
@@ -462,11 +486,11 @@ void test_xdp_metadata(void)
 
 	/* Setup separate AF_XDP for TX interface nad send packet to the RX socket. */
 	tx_ifindex = if_nametoindex(TX_NAME);
-	ret = open_xsk(tx_ifindex, &tx_xsk);
+	ret = open_xsk(tx_ifindex, &tx_xsk, XDP_COPY | XDP_USE_SG);
 	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
 		goto out;
 
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
+	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 0), 0,
 		       "generate AF_XDP_CONSUMER_PORT"))
 		goto out;
 
@@ -482,7 +506,29 @@ void test_xdp_metadata(void)
 	switch_ns_to_tx(&tok);
 	if (!ASSERT_OK_PTR(tok, "setns tx"))
 		goto out;
-	complete_tx(&tx_xsk);
+	complete_tx(&tx_xsk, 1);
+
+	/* Exercise software checksumming of a packet spread over multiple
+	 * TX descriptors. The checksum is only computed once the skb is
+	 * complete, so both fragments must be accounted for.
+	 */
+	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT,
+				       UDP_SPLIT_BYTES), 0,
+		       "generate multi-buffer AF_XDP packet"))
+		goto out;
+
+	switch_ns_to_rx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns rx"))
+		goto out;
+
+	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
+		       "verify multi-buffer xsk metadata"))
+		goto out;
+
+	switch_ns_to_tx(&tok);
+	if (!ASSERT_OK_PTR(tok, "setns tx"))
+		goto out;
+	complete_tx(&tx_xsk, 2);
 
 	/* Now check metadata of packet, generated with network stack */
 	if (!ASSERT_GE(generate_packet_inet(), 0, "generate UDP packet"))
@@ -518,7 +564,7 @@ void test_xdp_metadata(void)
 		goto out;
 
 	/* Send packet to trigger . */
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
+	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 0), 0,
 		       "generate freplace packet"))
 		goto out;
 
-- 
2.39.5 (Apple Git-154)

