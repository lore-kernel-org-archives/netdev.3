Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723E438029
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752945; cv=none; b=VR3iZWuAoKC4MflTn+3Z5K/DbGaEiJdULmzOHKoG13uShlj+AOBg5aOHZbVmV7JTQLtDI8I8T3N915fcpGa5cQERmJ04j0aCchoIbiZ+jEXJTptGBc9KDdTC22aRvBMAWmV0wxr0adpSC+odXmYodUIurswLrpejbFkSPbAduSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752945; c=relaxed/simple;
	bh=ZWPFvoRyrvnJsflPTlk63Xy5ZT27x7jwQlCWWZ/pct0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6mqLuMwNRml5/tMgEUDgNcmOrFkChcNdnlCjEZob894uHY/4NxZYXyTqE+OB5ypO+N3YUAW0QBnOIPrsADRnXgC6IWS5XrkTGG3PFhfnzbxzAkTTZ+t93kK+x31PITQg6ZDOqDkdVQ8+YQE7EYsaxlQWX4RKOOJUav8eWL9/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZP1TPYhn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjaOWhHH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZP1TPYhn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjaOWhHH"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76D617A0049;
	Wed, 22 Jul 2026 16:42:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Jul 2026 16:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784752942; x=
	1784839342; bh=Pkr0bWo5PyfxNbPe7FMXAwo56pMSREqoXVUV6Z5Ur04=; b=Z
	P1TPYhnJ0ChK/IXCi+L8ZYKtlDqGyIrmeljdK9zdGmVWUkAWrkIt8+RcdMQswjU1
	n06kKY4MFdMkH+zxbuSiXveyh+vytZWK4RwWxqQABhjxBkLQBII+DKHxYKLYYSiW
	sr7/NHrRVeEFsMmf32CB41dMsJy6wHzqWJNQ/zRxE8feFVQfKfJIpBlNEksVsLlG
	k48lapdMZBftdS/ajMsbmb7PvafHYYODu/DlvyEg4/567L0gD8YM2HafuX04LBPj
	LczFpJJnqVj+RC448Go9nJxvaQMUekYurcbpR/kFlUOWC8xFy4PK+cc+/2Z6SU6y
	FLj+8p/CEx0JQ94O5shfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784752942; x=1784839342; bh=P
	kr0bWo5PyfxNbPe7FMXAwo56pMSREqoXVUV6Z5Ur04=; b=BjaOWhHHDvHu+vEhx
	61rt/Jn0jQw10cNB2IqQnipI5/wr9E4lMtljqSXKx1GycbZbvOvUvv8LSY7NUIet
	BkI56dyLShPmmRfSBA9TWDajt70SI+A20Z3eGZIWj+KWj/H5W/UwA05guL+w3Akz
	UXZWJJs40qYShTLXBze+RB3TtEPC+AWIF7yyRwl7qdhQHz4k7k4BqRuI65exYP6W
	UR5w5xuBGRZM0ND0Mmo1Azz3gVKeLqMJ8JvbUB87aTk6nmgoftm3guwQ7nKNXQRb
	A4ZGZw66fPnTW8KYWyzPfXejmXySIGJgOtVYWVj+R0LJ611A+pWscJET/e0kG+9G
	1ZApQ==
X-ME-Sender: <xms:LithalteRdpRG2yCauLi0J1MK-jnr7VEY--5hXFldW_sZ3Btw5wxTA>
    <xme:LithalXVX0P6mP-R30qKVxS1G_raRPadB-pAJcQkRmuUcu903RU56O4WBFzrgUK4g
    7lzuiPQ58yrRkGAfdYaI5JfpbAiBgjP8VAEzTQxSgDbQSqf2qLToCs>
X-ME-Received: <xmr:LithahHG5sxHU7eLJ3-4omlf9UU4b6k66aOIE5ssq1Ol-EmBE5uQpUBBJTXs0gwI2ptEKVzeFweP51PimCwiXg>
X-ME-Proxy-Cause: dmFkZTElkBiwG5cIhOPJZ8aQ7X5cAdGPqZBNVDJCUNRy0mD9Oc/iqcQxNWQRTcVWxNeXeK
    hb9mo56V6acb1wu6pEODO1csMhIVfAurfOZMPNWy09rHnDjuuGiQDfMPUyhefHkcsZPJe2
    QDzpYB3UxcgUVIhu9WlP4w58PjwxegjsBXRyLZMwxik596AtZDOdsXNAXjPgVLBzhU02GA
    uZBPQ9pQLNio4heUffFko5NMQNOXT+MSEpF2OYZBbYeLH8/tpcCqBd/BzsEVtbeKr4o6bL
    znxDXK3nG8jddPlBMyzWw4jQEkaRCa6dbQkY4Z5XVuLTmS87+B/SQ0HOWCQIkXQJnCZtpe
    iDvN/LjGIE7G5rKnUjpZEmJVpXSMDvlmYTXSIn/DRFBlD4LkPLWLuTcScfGgGzmCZ/ebJF
    wggE9yImvudSHxJPF9rvo2mpMEXS1Wv0yMP8H2Kz8kzcrXJoy4hETrvxAmnRifA0xpRqaJ
    966vykzbbtuFu7Zxf8ZwMPPZUKvQFN23OT/eb9aLUNa757jXnHOwINd7sjuVO6XUtuflXp
    YvdGo97+BGOU3wdrqe+wiEVPGRS0lYrbtktFJstEK8E5cHcahxtvNspYjuOFLpgyiISROL
    Yu0wTReh8FXvbJNDl3Pntj0BQ5on1B0pbi0NpBR/I0REitl9hgMIJkFhIkvw
X-ME-Proxy: <xmx:Lithan3Fgm-Gd16Ou-UTub5Xkm5-F5jXCIwAukwm8XxaahJlMwWojw>
    <xmx:LithajMhbqI-27J3BflNomzuvpmudMevNPh9HhRGImvU0XTjgAV5GA>
    <xmx:Litham5OuPN42miVt7udujFoQhgb13GooezN6F71DPpY68jnGpPccQ>
    <xmx:Lithat2AkWMc9mjv_BrpeTqEwV9AyEdCIkrbriMcSpa1gMN8AQsjfA>
    <xmx:Lithao3udElSWesCKzyvQS40YXTjhX2rrppaatsul-PkA1X33QYtvZkl>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 16:42:21 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v3 3/6] selftests: net: refactor server state into struct thread_ctx
Date: Wed, 22 Jul 2026 15:39:47 -0500
Message-ID: <20260722203950.58550-4-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722203950.58550-1-juanlu@fastmail.com>
References: <20260722203950.58550-1-juanlu@fastmail.com>
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

