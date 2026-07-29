Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145B382F28
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363544; cv=none; b=PTkgMpCT72xcgv0e24EiTGd8Ngq0Om7ts4wRNBRyF5993BY6OurgPOZox79A4rjQ6DstHl501ZXQpgK2YuzqtRtfEQgA+05qiD1g+IWf1piLJluJHbUfhdlFh/LKXcV9YSCVb6+BLl1TNrtSUi0j3MiM80/Akv9wamjpa+SFTm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363544; c=relaxed/simple;
	bh=rLekRUkX346SnvBPk5zPiIOOceOAGLeri4nl51E2ZKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fb920MM1czlKYvh70tkneF4v2xW7VUVk8DQH5XjmsuIl3YmvbcfaL/NaV/VldifaMF/K678trZCIrtNYpp/KnZ6DC2KYavFMGF8OKwxcFhds4xoGMKsdqHds0x885w8pzLGNT1+zHuYbBNc7XpzOo7vf0328QQG4BQA0oz05M7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hCB37ujE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Go7MdLJi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hCB37ujE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Go7MdLJi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D3501D0033A;
	Wed, 29 Jul 2026 18:18:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 29 Jul 2026 18:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785363538; x=
	1785449938; bh=SZVZOqoi4Ks2bWtAYciufICla0IzyOWQ058R7QkyTL0=; b=h
	CB37ujEYi+U0kA6imjjMQ/gQZWt/kSPQ3QZRytJsFQNRoxHOxs++mYyP2ydOj5Qs
	lIFouRDbnL0Ajfgdz5dws2RFbSaETt1y93JoPoBrOMbmw6sFuJl4wzKgBdoiQId4
	Uqh1hlM2JrtJrU9D+Dp86R2NAFEQ6qVC/LIFeAkQrcE9NdnOu2SXSJZjzF1vy3JT
	wliKQlOCh8cgigUHt/9Bt2vwDwMzqZ24Zz3kOROtqWVmtKnjaNbVLE0tG/qF5Q7D
	AX9JfsNX7PbYEPLIQ7PyprkCeWjXDf4EXelNcC/8IlY8Z/RZT78i2FxgYGLC6INp
	K8BmwSiEbbUvGc5lSuZFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785363538; x=1785449938; bh=S
	ZVZOqoi4Ks2bWtAYciufICla0IzyOWQ058R7QkyTL0=; b=Go7MdLJia7Uy+/BIo
	jrViNU/khjV6P9gbQOFQyzQUUF7IkRzJZifklilJTHvRy8ihsDeZaqI9OcL32fDI
	9FTTj5PhvzsbNopvSTIh63j3UJTH0AQHHURqeZBv43jl1veqGQZ5nMwPVCztqspe
	Q0suJ6n3MgEiaRzV5Or368NDhR+SPvnNiRzizBMzncM9Nl2JCJ7zzMh60FatJbon
	Df5+O8YFACJHIZcUWoUtwj/mjaPDE3kH3VX5TjSU7iWX+A0ZPfRlj1SzLqobuqBU
	DrlKk43qDGuQopIuCyvb0z6E24htPf1wVWV33VhSNlsl6GYNI2eCewWNaQXtNT06
	65guA==
X-ME-Sender: <xms:Unxqaux_twAcl62mIYKj2cJTgDTN8TmMPb_A3INoG8XidWKLJtWsIQ>
    <xme:UnxqahJmzNv2hAFZCmL5Jii1cFRIEva5IYXKBgnItOTRpSTQyVzFTI_MvNXqkJ-CG
    aBmC6OAgvWa2FVVT0imnXFYghIIY_MeSwmQWcFF6RiCyQ_0XneATf-T>
X-ME-Received: <xmr:Unxqaoo0ZpFKM2TScLiV0WvbxKRf8FUnm00kjmZ4s5QA6HUPP9Ud8cZ70ywTT5StVM9yO7uQ6iryWEug0jxN>
X-ME-Proxy-Cause: dmFkZTFMDyKK2y+dzORRfZPJ89JgoASg/Qb0GjVQW+8GrOVCcEGdUAgKHlUa8Un+iIRNDq
    OLu1eEmGdL9LiaJp4vb7aukO46GaCpXJmsv06q7iKnx98tky4DIzGBqbiPBus49S5LJbjW
    1qneKCbP5VuWaw/dwy14ncWM3IhzR+3ff1uRI5OY/HT/Tdbg57FnUba87bbWN1jKovJr55
    sbfMefc2frq11MXRuj+ZJpguqDFLHUgtPkCHXQJMLgPRwlLsxFCNklRZ3mgQ7tCBlc2WIX
    rh68MohCmoqsoOTDpc51ZVxRPdFWAIUIMHouI949040nP6WpUNPwFRA0R5WLQtXwav4IN4
    1J7hH6Y1MrvIFYm/jCa818NDa1LBArrFFpOlKXmWfBgXL8DGyAUJBypfWPO6pBE3ksM91g
    11dKgKJAmMg8OpjBMUONplj7tfKNwsw9ua4Rn9VnY15aVLS3SNXQsMxPZKwMknfeCZUW0A
    mnxbXCOaSIEu+yNa+GV1/eYU6j6FLX9rhXDOGvjlE28/hbZePqH8YnBwz7shMneTm3CImD
    fOT3LjM+/Dp5OWHym8Fi7XY6FIewqhDQ4uWWHFP+AeclM/VF6VhtXNJhyQhIsYPA9iteUI
    +MuBqGXqqeuTTbLw8mWfr8HQ1KLeLJfJdcZwdqZUg2hQrJXMdDtjulAw00pA
X-ME-Proxy: <xmx:UnxqagKFkVzaBBVf8r6lO77DgRJaTyxRzU50UhVu5UimEbJZ0QfoVg>
    <xmx:UnxqatQqY7Zd8GCSnWyn-PHHFV-EsruPw52BAkFoCOOPvcaYDcmOSA>
    <xmx:UnxqavsNIBjn8-q33pdHwTsSHjdEOkFpiX3P7Ftk2wm9pPTLK-A4xw>
    <xmx:Unxqaua90vWFUxmLKNL0C7wm_iPb8PL3KVAT5arP-GicA6OG7yRHtw>
    <xmx:UnxqalrVeOgbvC_Vv5U9lu8pGyGc1D5Jg_26w6K6elfluC_DsNv2Waeh>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 18:18:57 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v4 5/6] selftests: net: add multithread server support to iou-zcrx
Date: Wed, 29 Jul 2026 17:18:24 -0500
Message-ID: <20260729221825.42773-6-juanlu@fastmail.com>
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

Run the iou-zcrx server as N worker threads, each owning one receive
queue with its own io_uring and zero-copy receive (zcrx) ifq, so the
test can exercise multi-queue zero-copy receive.

The main thread owns the listening socket, accepts connections, and
dispatches each to the worker owning the queue it landed on by matching
SO_INCOMING_NAPI_ID against per-queue NAPI IDs.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   5 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 290 ++++++++++++++----
 2 files changed, 226 insertions(+), 69 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3cab3b4adbb2e..035581b58bc66 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -13,10 +13,6 @@ else
 $(warning excluding iouring tests, liburing not installed or too old)
 endif
 
-TEST_GEN_FILES := \
-	$(COND_GEN_FILES) \
-# end of TEST_GEN_FILES
-
 TEST_PROGS = \
 	csum.py \
 	devlink_port_split.py \
@@ -71,6 +67,7 @@ TEST_INCLUDES := \
 YNL_GEN_FILES := \
 	ncdevmem \
 	toeplitz \
+	$(COND_GEN_FILES) \
 # end of YNL_GEN_FILES
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 7bc61f3b70ca6..16259129df46d 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -27,6 +27,7 @@
 #include <netinet/tcp.h>
 #include <netinet/udp.h>
 #include <sys/epoll.h>
+#include <sys/eventfd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/resource.h>
@@ -38,6 +39,8 @@
 #include <sys/wait.h>
 
 #include <liburing.h>
+#include <ynl.h>
+#include "netdev-user.h"
 
 #define SKIP_CODE	42
 
@@ -91,6 +94,7 @@ static int cfg_num_threads = 1;
 static char *payload;
 
 #define CONNS_PER_THREAD	4
+#define MAX_CONNS_PER_THREAD	64
 
 struct thread_ctx {
 	struct io_uring		ring;
@@ -99,9 +103,14 @@ struct thread_ctx {
 	size_t			ring_size;
 	struct io_uring_zcrx_rq	rq_ring;
 	unsigned long		area_token;
-	int			connfd;
-	bool			stop;
-	size_t			received;
+	int			queue_id;
+	int			napi_id;
+	int			ready_fd;
+	int			start_fd;
+
+	int			connfds[MAX_CONNS_PER_THREAD];
+	size_t			received[MAX_CONNS_PER_THREAD];
+	int			nr_conns;
 };
 
 static unsigned long gettimeofday_ms(void)
@@ -201,7 +210,7 @@ static void setup_zcrx(struct thread_ctx *ctx)
 
 	struct t_io_uring_zcrx_ifq_reg reg = {
 		.if_idx = ifindex,
-		.if_rxq = cfg_queue_id,
+		.if_rxq = ctx->queue_id,
 		.rq_entries = rq_entries,
 		.area_ptr = (__u64)(unsigned long)&area_reg,
 		.region_ptr = (__u64)(unsigned long)&region_reg,
@@ -226,53 +235,32 @@ static void setup_zcrx(struct thread_ctx *ctx)
 	ctx->area_token = area_reg.rq_area_token;
 }
 
-static void add_accept(struct thread_ctx *ctx, int sockfd)
+static void add_recvzc(struct thread_ctx *ctx, int conn_idx)
 {
 	struct io_uring_sqe *sqe;
 
 	sqe = io_uring_get_sqe(&ctx->ring);
 
-	io_uring_prep_accept(sqe, sockfd, NULL, NULL, 0);
-	sqe->user_data = 1;
-}
-
-static void add_recvzc(struct thread_ctx *ctx, int sockfd)
-{
-	struct io_uring_sqe *sqe;
-
-	sqe = io_uring_get_sqe(&ctx->ring);
-
-	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, 0, 0);
+	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
+			 NULL, 0, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
-	sqe->user_data = 2;
+	sqe->user_data = conn_idx;
 }
 
-static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
+static void add_recvzc_oneshot(struct thread_ctx *ctx, int conn_idx, size_t len)
 {
 	struct io_uring_sqe *sqe;
 
 	sqe = io_uring_get_sqe(&ctx->ring);
 
-	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
+	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
+			 NULL, len, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
-	sqe->user_data = 2;
+	sqe->user_data = conn_idx;
 }
 
-static void process_accept(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
-{
-	if (cqe->res < 0)
-		error(1, 0, "accept()");
-	if (ctx->connfd)
-		error(1, 0, "Unexpected second connection");
-
-	ctx->connfd = cqe->res;
-	if (cfg_oneshot)
-		add_recvzc_oneshot(ctx, ctx->connfd, page_size);
-	else
-		add_recvzc(ctx, ctx->connfd);
-}
-
-static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
+static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe,
+			   int conn_idx)
 {
 	unsigned int rq_mask = ctx->rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
@@ -283,7 +271,7 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 	int i;
 
 	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
-		ctx->stop = true;
+		ctx->nr_conns--;
 		return;
 	}
 
@@ -292,11 +280,11 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 
 	if (cfg_oneshot) {
 		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
-			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
+			add_recvzc_oneshot(ctx, conn_idx, page_size);
 			cfg_oneshot_recvs--;
 		}
 	} else if (!(cqe->flags & IORING_CQE_F_MORE)) {
-		add_recvzc(ctx, ctx->connfd);
+		add_recvzc(ctx, conn_idx);
 	}
 
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
@@ -306,10 +294,10 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 	data = (char *)ctx->area_ptr + (rcqe->off & mask);
 
 	for (i = 0; i < n; i++) {
-		if (*(data + i) != payload[(ctx->received + i)])
+		if (*(data + i) != payload[(ctx->received[conn_idx] + i)])
 			error(1, 0, "payload mismatch at %d", i);
 	}
-	ctx->received += n;
+	ctx->received[conn_idx] += n;
 
 	rqe = &ctx->rq_ring.rqes[(ctx->rq_ring.rq_tail & rq_mask)];
 	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | ctx->area_token;
@@ -322,28 +310,124 @@ static void server_loop(struct thread_ctx *ctx)
 	struct io_uring_cqe *cqe;
 	unsigned int count = 0;
 	unsigned int head;
-	int i, ret;
 
 	io_uring_submit_and_wait(&ctx->ring, 1);
 
 	io_uring_for_each_cqe(&ctx->ring, head, cqe) {
-		if (cqe->user_data == 1)
-			process_accept(ctx, cqe);
-		else if (cqe->user_data == 2)
-			process_recvzc(ctx, cqe);
-		else
-			error(1, 0, "unknown cqe");
+		process_recvzc(ctx, cqe, cqe->user_data);
 		count++;
 	}
 	io_uring_cq_advance(&ctx->ring, count);
 }
 
-static void run_server(void)
+static void *server_worker(void *arg)
 {
-	struct thread_ctx ctx = {};
-	unsigned int flags = 0;
-	int fd, enable, ret;
+	struct thread_ctx *ctx = arg;
+	struct io_uring_params params = { };
 	uint64_t tstop;
+	int i;
+
+	params.flags |= IORING_SETUP_COOP_TASKRUN;
+	params.flags |= IORING_SETUP_SINGLE_ISSUER;
+	params.flags |= IORING_SETUP_DEFER_TASKRUN;
+	params.flags |= IORING_SETUP_SUBMIT_ALL;
+	params.flags |= IORING_SETUP_CQE32;
+	params.flags |= IORING_SETUP_CQSIZE;
+	params.cq_entries = AREA_SIZE / page_size;
+
+	io_uring_queue_init_params(512, &ctx->ring, &params);
+	setup_zcrx(ctx);
+
+	if (cfg_dry_run)
+		return NULL;
+
+	{
+		uint64_t val = 1;
+
+		if (write(ctx->ready_fd, &val, sizeof(val)) != sizeof(val))
+			error(1, errno, "write(ready_fd)");
+		if (read(ctx->start_fd, &val, sizeof(val)) != sizeof(val))
+			error(1, errno, "read(start_fd)");
+	}
+
+	for (i = 0; i < ctx->nr_conns; i++) {
+		if (cfg_oneshot)
+			add_recvzc_oneshot(ctx, i, page_size);
+		else
+			add_recvzc(ctx, i);
+	}
+
+	tstop = gettimeofday_ms() + 5000;
+	while (ctx->nr_conns > 0 && gettimeofday_ms() < tstop)
+		server_loop(ctx);
+
+	if (ctx->nr_conns != 0)
+		error(1, 0, "test failed: %d connections incomplete",
+		      ctx->nr_conns);
+
+	return NULL;
+}
+
+static int query_napi_id(unsigned int ifindex, int queue_id)
+{
+	struct netdev_queue_get_req *req;
+	struct netdev_queue_get_rsp *rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int napi_id;
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!ys)
+		error(1, 0, "ynl_sock_create: %s", yerr.msg);
+
+	req = netdev_queue_get_req_alloc();
+	netdev_queue_get_req_set_ifindex(req, ifindex);
+	netdev_queue_get_req_set_type(req, NETDEV_QUEUE_TYPE_RX);
+	netdev_queue_get_req_set_id(req, queue_id);
+
+	rsp = netdev_queue_get(ys, req);
+	if (!rsp)
+		error(1, 0, "netdev_queue_get(q=%d): %s", queue_id,
+		      ys->err.msg);
+	if (!rsp->_present.napi_id)
+		error(1, 0, "netdev_queue_get(q=%d): napi_id not present",
+		      queue_id);
+
+	napi_id = rsp->napi_id;
+
+	netdev_queue_get_req_free(req);
+	netdev_queue_get_rsp_free(rsp);
+	ynl_sock_destroy(ys);
+
+	return napi_id;
+}
+
+static int find_thread_by_napi(struct thread_ctx *ctxs, int napi_id)
+{
+	int i;
+
+	for (i = 0; i < cfg_num_threads; i++) {
+		if (ctxs[i].napi_id == napi_id)
+			return i;
+	}
+	return -1;
+}
+
+static void run_server(void)
+{
+	struct thread_ctx *ctxs;
+	struct epoll_event ev, out_ev;
+	pthread_t *threads;
+	unsigned int ifindex;
+	int conns_per_thread, total_conns, accepted = 0, connfd;
+	int fd, ret, enable, i;
+	int epfd, ready = 0;
+	uint64_t val;
+
+	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
+	threads = calloc(cfg_num_threads, sizeof(*threads));
+	if (!ctxs || !threads)
+		error(1, 0, "calloc()");
 
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (fd == -1)
@@ -358,29 +442,105 @@ static void run_server(void)
 	if (ret < 0)
 		error(1, 0, "bind()");
 
-	flags |= IORING_SETUP_COOP_TASKRUN;
-	flags |= IORING_SETUP_SINGLE_ISSUER;
-	flags |= IORING_SETUP_DEFER_TASKRUN;
-	flags |= IORING_SETUP_SUBMIT_ALL;
-	flags |= IORING_SETUP_CQE32;
+	for (i = 0; i < cfg_num_threads; i++) {
+		ctxs[i].queue_id = cfg_queue_id + i;
+		ctxs[i].ready_fd = eventfd(0, 0);
+		ctxs[i].start_fd = eventfd(0, 0);
+	}
 
-	io_uring_queue_init(512, &ctx.ring, flags);
+	for (i = 0; i < cfg_num_threads; i++) {
+		ret = pthread_create(&threads[i], NULL,
+				     server_worker, &ctxs[i]);
+		if (ret)
+			error(1, ret, "pthread_create()");
+	}
 
-	setup_zcrx(&ctx);
 	if (cfg_dry_run)
-		return;
+		goto join;
 
 	if (listen(fd, 1024) < 0)
 		error(1, 0, "listen()");
 
-	add_accept(&ctx, fd);
+	epfd = epoll_create1(0);
+	if (epfd < 0)
+		error(1, errno, "epoll_create1()");
 
-	tstop = gettimeofday_ms() + 5000;
-	while (!ctx.stop && gettimeofday_ms() < tstop)
-		server_loop(&ctx);
+	for (i = 0; i < cfg_num_threads; i++) {
+		ev.events = EPOLLIN;
+		ev.data.fd = ctxs[i].ready_fd;
+		if (epoll_ctl(epfd, EPOLL_CTL_ADD,
+			      ctxs[i].ready_fd, &ev) < 0)
+			error(1, errno, "epoll_ctl()");
+	}
+
+	while (ready < cfg_num_threads) {
+		if (epoll_wait(epfd, &out_ev, 1, -1) < 0)
+			error(1, errno, "epoll_wait()");
+		if (read(out_ev.data.fd, &val, sizeof(val)) != sizeof(val))
+			error(1, errno, "read(ready_fd)");
+		ready++;
+	}
+
+	close(epfd);
+
+	if (cfg_num_threads > 1) {
+		ifindex = if_nametoindex(cfg_ifname);
+		if (!ifindex)
+			error(1, 0, "bad interface name: %s", cfg_ifname);
+		for (i = 0; i < cfg_num_threads; i++)
+			ctxs[i].napi_id = query_napi_id(ifindex,
+							ctxs[i].queue_id);
+	}
+
+	conns_per_thread = cfg_num_threads > 1 ? CONNS_PER_THREAD : 1;
+	total_conns = conns_per_thread * cfg_num_threads;
+
+	while (accepted < total_conns) {
+		int idx;
+
+		connfd = accept(fd, NULL, NULL);
+		if (connfd < 0)
+			error(1, errno, "accept()");
+
+		if (cfg_num_threads > 1) {
+			int napi_id;
+			socklen_t len = sizeof(napi_id);
+
+			ret = getsockopt(connfd, SOL_SOCKET,
+					 SO_INCOMING_NAPI_ID,
+					 &napi_id, &len);
+			if (ret < 0)
+				error(1, errno,
+				      "getsockopt(SO_INCOMING_NAPI_ID)");
+
+			idx = find_thread_by_napi(ctxs, napi_id);
+			if (idx < 0)
+				error(1, 0, "unknown NAPI ID: %d",
+				      napi_id);
+		} else {
+			idx = 0;
+		}
 
-	if (!ctx.stop)
-		error(1, 0, "test failed\n");
+		if (ctxs[idx].nr_conns >= MAX_CONNS_PER_THREAD)
+			error(1, 0, "worker %d connection overflow",
+			      idx);
+		ctxs[idx].connfds[ctxs[idx].nr_conns++] = connfd;
+		accepted++;
+	}
+
+	val = 1;
+	for (i = 0; i < cfg_num_threads; i++) {
+		if (write(ctxs[i].start_fd, &val, sizeof(val)) != sizeof(val))
+			error(1, errno, "write(start_fd)");
+	}
+
+join:
+	for (i = 0; i < cfg_num_threads; i++)
+		pthread_join(threads[i], NULL);
+
+	close(fd);
+	free(threads);
+	free(ctxs);
 }
 
 static void *client_worker(void *arg)
-- 
2.53.0-Meta

