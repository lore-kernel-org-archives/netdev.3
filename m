Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27EF43F4B7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363539; cv=none; b=l1WboAtfR7dEtG70bjl12uc4VGlRBxvl/GtZZfUsCP0bSWlyCB/ZV5mZdCWy4KZH2nNSCaQ2/u/95KP7lnHo4JaSmkgJyNbzDSKiRHQDmuBO1gws+3sxlmJlTEDZaI1PJuInzuTQhADgZbVnLGg+Gn33bHL9Z+tvT7RxfqWOBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363539; c=relaxed/simple;
	bh=ZWPFvoRyrvnJsflPTlk63Xy5ZT27x7jwQlCWWZ/pct0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcdau20tplgPbqHETDqm+Q6R7Sefs2qSmEnA4kcaRb4mACZkRMHbxcYq/Af02y3o0oLhy6O7j1XPAd6O5Bc07NeYNF6pmw9vGXFSxGEinsz7gl8DlorRCzIZXpr9zlqLjLdDBWhHg/9ffEVMxTtjz/qrjJX7EKuhnqLHK7gTxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lkMWypNj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ecry4dst; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lkMWypNj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ecry4dst"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 665CE7A03C7;
	Wed, 29 Jul 2026 18:18:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 29 Jul 2026 18:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785363536; x=
	1785449936; bh=Pkr0bWo5PyfxNbPe7FMXAwo56pMSREqoXVUV6Z5Ur04=; b=l
	kMWypNj9rPJBDD8Jw2W5IxGcEmTSop9WCF3p605krffwBZwUKbk3b0g3HgOACIk2
	k581J79I4NwdODe1lL1mAhb0aeDy8P0Ue9m4/WRaqwU8WYCb06ZmsdmOjUnyqMZ+
	0+ntJIcIJr9oskqEmRJi5o/CrAGCbrYnzl5fM+oDwuDWI6tyaWsMekyMkhDHicAs
	yexucLtAQyD5rgB38K+ykyl9LPXgf2ZQxyv6ZwF926PfED4mxRMSDmx51rdx23HT
	niyR05yJr9s+WMZBB/DCmMURYpE0OxUx3wvEiqmu13lKThRaIxVFa2AjkRTukxBa
	ZKMNx/dwcoemfeH6Y5eVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785363536; x=1785449936; bh=P
	kr0bWo5PyfxNbPe7FMXAwo56pMSREqoXVUV6Z5Ur04=; b=Ecry4dst5LZer0qmb
	eMfPFb7FaspTc5LTajGHYSbO42cYm8QVTDaRCanIqeDFn/EpULSJfJ/Ka7d9p97Y
	FHHhF0NYs4hub5kX9yVvnrrT8fZyvlLVQ/JBqsPxZT7pnMrkX1DAHp8HEPknNS9s
	Hio9OigEhEHB0HQMDUId9W8YL6iIR1QcapD+qYfZ0hPl2Gtqoy/UeWSFShWgC42G
	cBfkQCHParUDsdYY2/XcnIqxGjdWvw5RQ4ND47MtGLuArBG4g1u1Ktug/2BbJ//F
	Hd+eEDCwl024+p+2doF6CqMKZmrBkePEFQVXoipW/poey4oVsm5gmlbSAT4vc2rF
	MJM3g==
X-ME-Sender: <xms:UHxqas_4ZZV4ydo7tv8hmlEaebJMcBB4mfGIycXXJgBEqZH4QdMzdQ>
    <xme:UHxqarnQ9TWoLhHtP1HMaHdw6975wLgNdFsSKX0Vwg7MbV-FJLo0sAT95MjBdTfxO
    J2AIKxh8d4XTKsVrTMMj5Yz5VmQ14zNde-_WPm9GipN7FK23XXECA>
X-ME-Received: <xmr:UHxqaqWnzk6GHel_CjJnlTWpJ3HQepUa475CBE_zewmie27hyEWkYdOd644i6F_Nr6uF5XPubzGFQXJQZZ0_>
X-ME-Proxy-Cause: dmFkZTGYxrxOA2kX45FjE7uWqEUywGWHyDyBWaser44hAwDMI7rJ+0mpvuMoO5poBkjbAN
    aH3CsQ3LZCMu7NFu/0dJnJTDGw38j08D0bDmRjODkSV35yDvnTovlndu+6M21iwHBKZ8f2
    dlxokyeyx9aW+sx2aGuIgjtEskeNuIJ0u+C3A5epNRiNkvqpOySB16Nw7o8RUBTmtlf9S4
    C4vZovergqyIt9UTPPajW6CQsSxoPffB4/UAyQFOeDfXtOLCXWCBpBqN4hPTP7DXcOc9iN
    XpDV+g2WODVskwBYgMy96aTglqISzcxU2Hsj+qBq6+hkVmXvdwnpOX91vEGx1Ayp+aqmGy
    mla96316n56PmMiD9oQf4/6LVw72AYBwZnlT3FqEAQeMAggGqFdrAtAldFOgleuiB8NOid
    CS1pbCzJ//0iWPdJUl/Pwy+zZBiXsh/BEU28Wz6bNMTdiOVKVpdB6bnvZUHV3nd2oBGzBN
    ZmI2+SdSOHtg5c1jiaJ3GK8txvsTxaLJXITHw7WXqyVeFoAHIPfHCeuGAtwZHOu2srNaLB
    SHBlxu34K1gJN4H3adD94naUJPxLsHfK5vF39HngVIaDEGmiNCBdbPFEDVMzcnQh9vo8kr
    l0lv+v9LFc6VQiT7T966OugdA9Ao/f5kDqKYepODV0mKeikagKqVTOdyEHHw
X-ME-Proxy: <xmx:UHxqaoHJWGDr0vuwupOhIFaGJ0BB7Cm1obnsMwes38lVAIrhof2BhA>
    <xmx:UHxqaudu2aB3qLy-ReLAKjbHzvu0IgYB5XARLlOw68lUR6qxGYybBw>
    <xmx:UHxqahIcKGkd1E_QLYh1QTMcFE19Zu84nw34kWNIu9IZiZFnlWNv4w>
    <xmx:UHxqarFnHaL0C30Q47STNWxXNwk8PICLlZEofsEwfMQ3Tr4Bti6J-A>
    <xmx:UHxqajH1-fplg8J3rhT2pQJhLB2CAIcKvQWEmd_WMTVXKB-GWW_AXvVF>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 18:18:55 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v4 3/6] selftests: net: refactor server state into struct thread_ctx
Date: Wed, 29 Jul 2026 17:18:22 -0500
Message-ID: <20260729221825.42773-4-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729221825.42773-1-juanlu@fastmail.com>
References: <20260729221825.42773-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move server-side state (io_uring ring, zcrx area, refill ring, receive
tracking) from global variables into a local struct thread_ctx. This is
a pure refactor with no behavior change: run_server still allocates a
single context on the stack and runs single-threaded, using io_uring
accept and recvzc as before.

This prepares the ground for the multithread server support in the
following commits, which spawns N worker threads each with their own
struct thread_ctx.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.c       | 156 +++++++++---------
 1 file changed, 80 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index c6dbd0ad53681..9b62fd0703e61 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -87,14 +87,18 @@ static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
 
 static char *payload;
-static void *area_ptr;
-static void *ring_ptr;
-static size_t ring_size;
-static struct io_uring_zcrx_rq rq_ring;
-static unsigned long area_token;
-static int connfd;
-static bool stop;
-static size_t received;
+
+struct thread_ctx {
+	struct io_uring		ring;
+	void			*area_ptr;
+	void			*ring_ptr;
+	size_t			ring_size;
+	struct io_uring_zcrx_rq	rq_ring;
+	unsigned long		area_token;
+	int			connfd;
+	bool			stop;
+	size_t			received;
+};
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -138,7 +142,7 @@ static inline size_t get_refill_ring_size(unsigned int rq_entries)
 	return ALIGN_UP(size, page_size);
 }
 
-static void setup_zcrx(struct io_uring *ring)
+static void setup_zcrx(struct thread_ctx *ctx)
 {
 	unsigned int ifindex;
 	unsigned int rq_entries = 4096;
@@ -149,44 +153,44 @@ static void setup_zcrx(struct io_uring *ring)
 		error(1, 0, "bad interface name: %s", cfg_ifname);
 
 	if (cfg_rx_buf_len && cfg_rx_buf_len != page_size) {
-		area_ptr = mmap(NULL,
-				AREA_SIZE,
-				PROT_READ | PROT_WRITE,
-				MAP_ANONYMOUS | MAP_PRIVATE |
-				MAP_HUGETLB | MAP_HUGE_2MB,
-				-1,
-				0);
-		if (area_ptr == MAP_FAILED) {
+		ctx->area_ptr = mmap(NULL,
+				     AREA_SIZE,
+				     PROT_READ | PROT_WRITE,
+				     MAP_ANONYMOUS | MAP_PRIVATE |
+				     MAP_HUGETLB | MAP_HUGE_2MB,
+				     -1,
+				     0);
+		if (ctx->area_ptr == MAP_FAILED) {
 			printf("Can't allocate huge pages\n");
 			exit(SKIP_CODE);
 		}
 	} else {
-		area_ptr = mmap(NULL,
-				AREA_SIZE,
-				PROT_READ | PROT_WRITE,
-				MAP_ANONYMOUS | MAP_PRIVATE,
-				0,
-				0);
-		if (area_ptr == MAP_FAILED)
+		ctx->area_ptr = mmap(NULL,
+				     AREA_SIZE,
+				     PROT_READ | PROT_WRITE,
+				     MAP_ANONYMOUS | MAP_PRIVATE,
+				     0,
+				     0);
+		if (ctx->area_ptr == MAP_FAILED)
 			error(1, 0, "mmap(): zero copy area");
 	}
 
-	ring_size = get_refill_ring_size(rq_entries);
-	ring_ptr = mmap(NULL,
-			ring_size,
-			PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_PRIVATE,
-			0,
-			0);
+	ctx->ring_size = get_refill_ring_size(rq_entries);
+	ctx->ring_ptr = mmap(NULL,
+			     ctx->ring_size,
+			     PROT_READ | PROT_WRITE,
+			     MAP_ANONYMOUS | MAP_PRIVATE,
+			     0,
+			     0);
 
 	struct io_uring_region_desc region_reg = {
-		.size = ring_size,
-		.user_addr = (__u64)(unsigned long)ring_ptr,
+		.size = ctx->ring_size,
+		.user_addr = (__u64)(unsigned long)ctx->ring_ptr,
 		.flags = IORING_MEM_REGION_TYPE_USER,
 	};
 
 	struct io_uring_zcrx_area_reg area_reg = {
-		.addr = (__u64)(unsigned long)area_ptr,
+		.addr = (__u64)(unsigned long)ctx->area_ptr,
 		.len = AREA_SIZE,
 		.flags = 0,
 	};
@@ -200,7 +204,7 @@ static void setup_zcrx(struct io_uring *ring)
 		.rx_buf_len = cfg_rx_buf_len,
 	};
 
-	ret = io_uring_register_ifq(ring, (void *)&reg);
+	ret = io_uring_register_ifq(&ctx->ring, (void *)&reg);
 	if (cfg_rx_buf_len && (ret == -EINVAL || ret == -EOPNOTSUPP ||
 			       ret == -ERANGE)) {
 		printf("Large chunks are not supported %i\n", ret);
@@ -209,64 +213,64 @@ static void setup_zcrx(struct io_uring *ring)
 		error(1, 0, "io_uring_register_ifq(): %d", ret);
 	}
 
-	rq_ring.khead = (unsigned int *)((char *)ring_ptr + reg.offsets.head);
-	rq_ring.ktail = (unsigned int *)((char *)ring_ptr + reg.offsets.tail);
-	rq_ring.rqes = (struct io_uring_zcrx_rqe *)((char *)ring_ptr + reg.offsets.rqes);
-	rq_ring.rq_tail = 0;
-	rq_ring.ring_entries = reg.rq_entries;
+	ctx->rq_ring.khead = (unsigned int *)((char *)ctx->ring_ptr + reg.offsets.head);
+	ctx->rq_ring.ktail = (unsigned int *)((char *)ctx->ring_ptr + reg.offsets.tail);
+	ctx->rq_ring.rqes = (struct io_uring_zcrx_rqe *)((char *)ctx->ring_ptr + reg.offsets.rqes);
+	ctx->rq_ring.rq_tail = 0;
+	ctx->rq_ring.ring_entries = reg.rq_entries;
 
-	area_token = area_reg.rq_area_token;
+	ctx->area_token = area_reg.rq_area_token;
 }
 
-static void add_accept(struct io_uring *ring, int sockfd)
+static void add_accept(struct thread_ctx *ctx, int sockfd)
 {
 	struct io_uring_sqe *sqe;
 
-	sqe = io_uring_get_sqe(ring);
+	sqe = io_uring_get_sqe(&ctx->ring);
 
 	io_uring_prep_accept(sqe, sockfd, NULL, NULL, 0);
 	sqe->user_data = 1;
 }
 
-static void add_recvzc(struct io_uring *ring, int sockfd)
+static void add_recvzc(struct thread_ctx *ctx, int sockfd)
 {
 	struct io_uring_sqe *sqe;
 
-	sqe = io_uring_get_sqe(ring);
+	sqe = io_uring_get_sqe(&ctx->ring);
 
 	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, 0, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
 	sqe->user_data = 2;
 }
 
-static void add_recvzc_oneshot(struct io_uring *ring, int sockfd, size_t len)
+static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
 {
 	struct io_uring_sqe *sqe;
 
-	sqe = io_uring_get_sqe(ring);
+	sqe = io_uring_get_sqe(&ctx->ring);
 
 	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
 	sqe->user_data = 2;
 }
 
-static void process_accept(struct io_uring *ring, struct io_uring_cqe *cqe)
+static void process_accept(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 {
 	if (cqe->res < 0)
 		error(1, 0, "accept()");
-	if (connfd)
+	if (ctx->connfd)
 		error(1, 0, "Unexpected second connection");
 
-	connfd = cqe->res;
+	ctx->connfd = cqe->res;
 	if (cfg_oneshot)
-		add_recvzc_oneshot(ring, connfd, page_size);
+		add_recvzc_oneshot(ctx, ctx->connfd, page_size);
 	else
-		add_recvzc(ring, connfd);
+		add_recvzc(ctx, ctx->connfd);
 }
 
-static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
+static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 {
-	unsigned rq_mask = rq_ring.ring_entries - 1;
+	unsigned int rq_mask = ctx->rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
 	struct io_uring_zcrx_rqe *rqe;
 	uint64_t mask;
@@ -275,7 +279,7 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 	int i;
 
 	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
-		stop = true;
+		ctx->stop = true;
 		return;
 	}
 
@@ -284,56 +288,56 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 
 	if (cfg_oneshot) {
 		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
-			add_recvzc_oneshot(ring, connfd, page_size);
+			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
 			cfg_oneshot_recvs--;
 		}
 	} else if (!(cqe->flags & IORING_CQE_F_MORE)) {
-		add_recvzc(ring, connfd);
+		add_recvzc(ctx, ctx->connfd);
 	}
 
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
 
 	n = cqe->res;
 	mask = (1ULL << IORING_ZCRX_AREA_SHIFT) - 1;
-	data = (char *)area_ptr + (rcqe->off & mask);
+	data = (char *)ctx->area_ptr + (rcqe->off & mask);
 
 	for (i = 0; i < n; i++) {
-		if (*(data + i) != payload[(received + i)])
+		if (*(data + i) != payload[(ctx->received + i)])
 			error(1, 0, "payload mismatch at %d", i);
 	}
-	received += n;
+	ctx->received += n;
 
-	rqe = &rq_ring.rqes[(rq_ring.rq_tail & rq_mask)];
-	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | area_token;
+	rqe = &ctx->rq_ring.rqes[(ctx->rq_ring.rq_tail & rq_mask)];
+	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | ctx->area_token;
 	rqe->len = cqe->res;
-	io_uring_smp_store_release(rq_ring.ktail, ++rq_ring.rq_tail);
+	io_uring_smp_store_release(ctx->rq_ring.ktail, ++ctx->rq_ring.rq_tail);
 }
 
-static void server_loop(struct io_uring *ring)
+static void server_loop(struct thread_ctx *ctx)
 {
 	struct io_uring_cqe *cqe;
 	unsigned int count = 0;
 	unsigned int head;
 	int i, ret;
 
-	io_uring_submit_and_wait(ring, 1);
+	io_uring_submit_and_wait(&ctx->ring, 1);
 
-	io_uring_for_each_cqe(ring, head, cqe) {
+	io_uring_for_each_cqe(&ctx->ring, head, cqe) {
 		if (cqe->user_data == 1)
-			process_accept(ring, cqe);
+			process_accept(ctx, cqe);
 		else if (cqe->user_data == 2)
-			process_recvzc(ring, cqe);
+			process_recvzc(ctx, cqe);
 		else
 			error(1, 0, "unknown cqe");
 		count++;
 	}
-	io_uring_cq_advance(ring, count);
+	io_uring_cq_advance(&ctx->ring, count);
 }
 
 static void run_server(void)
 {
+	struct thread_ctx ctx = {};
 	unsigned int flags = 0;
-	struct io_uring ring;
 	int fd, enable, ret;
 	uint64_t tstop;
 
@@ -356,22 +360,22 @@ static void run_server(void)
 	flags |= IORING_SETUP_SUBMIT_ALL;
 	flags |= IORING_SETUP_CQE32;
 
-	io_uring_queue_init(512, &ring, flags);
+	io_uring_queue_init(512, &ctx.ring, flags);
 
-	setup_zcrx(&ring);
+	setup_zcrx(&ctx);
 	if (cfg_dry_run)
 		return;
 
 	if (listen(fd, 1024) < 0)
 		error(1, 0, "listen()");
 
-	add_accept(&ring, fd);
+	add_accept(&ctx, fd);
 
 	tstop = gettimeofday_ms() + 5000;
-	while (!stop && gettimeofday_ms() < tstop)
-		server_loop(&ring);
+	while (!ctx.stop && gettimeofday_ms() < tstop)
+		server_loop(&ctx);
 
-	if (!stop)
+	if (!ctx.stop)
 		error(1, 0, "test failed\n");
 }
 
-- 
2.53.0-Meta

