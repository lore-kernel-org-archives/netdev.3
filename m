Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249D3ADB89
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752949; cv=none; b=F86u0PDCCm4spjx9nFFXwFZ2aeTI3cpnItvzrCnocP8z4Q1ZwMczKsf7+zUz6pbKLP43AtC76bAmcpyzGGOLSmx2U/HjGVawDqnYQkcQZxAI4/7Abdy+iA0nucYTpKwxRgIKjLU1rWPyqg3Xrv8MH6hYqAGU+O8AEDhwfbXgArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752949; c=relaxed/simple;
	bh=Yo9N3CVUQis3ifdL4Am42GZGorxhEBCJduHkifmx9h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0SOs1fYoyoeJets3YUlHPVSEq51xQyqM+WipOxZ43PKl94gvxS4poY7EwCZG4q+8jcp+1PA+EdjgDrmJiFglhBO6T18fg1cfQDlF64l3e1PT1gBcvBvxNmddRyPwYPfsn9gCGVwJLQuQ3bmoGXE7ul9E8NE7B7Hkv1sV+DtiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NJP+6/mm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lf/P6Svv; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NJP+6/mm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lf/P6Svv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B42A1D00100;
	Wed, 22 Jul 2026 16:42:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jul 2026 16:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784752946; x=
	1784839346; bh=NjVLGrxHTWaYBGPc2vt5Y3pVVVaI3WRsJV+56T9uyzY=; b=N
	JP+6/mm5Ym2aiGGDQrPN7lc5Y88CnBgbva0hMCAw+lzrUoYG7cILWjDxfxdCIrS+
	0iOB6+F8314kt5mliJWHUCZdEhM0pp2aM3sO4PrqDDSDXR1FmEpLihhRFGxD1dda
	l0AN3inC/BF6KGr81IW35VwOI0tirB5BhT63mISPYN2R/mxXpM4JgFveMqK1LZbp
	6eacUNDfwEt6rtLxQEqOY3JMYGOT52VoMCtvzXppKrQavXzlojMAzB1wK/1YffaN
	Uuj7Nx6SU8cp4PkuQnu6rNeNK5EN7XI+3vbAOmcI1EN5LhNT0zt9KdrlBOZJXJgZ
	4rHnn2MLZ0ubORRQaL6RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784752946; x=1784839346; bh=N
	jVLGrxHTWaYBGPc2vt5Y3pVVVaI3WRsJV+56T9uyzY=; b=lf/P6SvvSYMkhW8be
	Ejb8Lqo35Jmvg0oMTPAvlSwK8oHzWa5ci4+sfyaMELF+PiC1OV99PVYteB7zHLOa
	p0DFKlITCONpRWgEdwYsvZhwqTT1f2dkDiFaKDeEqZp7Up05WhwJAJUSPwJCqI9E
	GlVvQom0XBb+szh2QdmHqRWrrWhze/MDkRVDFFwwLLCNBOgH0p2ZVmXh+IrHSAxM
	cQ8bKtgqxCiE20hHherqmjkSHMezYKugPaDatUrtDPuzMdkLSmwsOLW1UBdf5RCW
	ifDYE8UcnKwPwyL5yTS+CcaYgI2sLGsKN/kOGfNj4lJTV2g2EphVQqWPOLjWfzYW
	NqIlA==
X-ME-Sender: <xms:Mithaq88nGwT92iq6O1uIFpHE6gvNQMa5_axPr4xrGvQjmG37ppbBQ>
    <xme:Mithahn3i2ufWZvqu_aEwcXtMcvAXKrViqDW65NIBMHjh5L6VxAmevNDgaEo9Uchd
    pKjkp9MXTBWHqAf_-UYJYsRORFY3MjWyk0igKLKI8wiP4pW34JqhalO>
X-ME-Received: <xmr:MithaoU-t6bnNw14Of01f24gvjuA4NQLFPMX1SlQ9c7mnUa-ukd89ndQgdIKBrkWLW7K2PG4n-v0bcRXlU5ibw>
X-ME-Proxy-Cause: dmFkZTGMaMMv/yG8qV6rSLlYdT+03Cs6SD8+SL94WusRhlbYK0NPxoASYIkmVsVbNVfNaY
    HtABXPiLvhB3xWouxxNKmKylRKAM5Qnelc7nzDl8vDrJn7bXDdIhb/T77qaUCvnhneePVp
    CgcOtGFb0iSrtBFvH++S243v3xrCQUhjwbNk/jRUxnZl6aRLSAP0Ki6faUEQjByIHGosCL
    NxJ8j+WoA5zCt1XnbPpIvhfLFKxusoLJjNfPDyP0MqA6VAija4h+Mx9lBV+pLo8FbehXuc
    WVzJrWrUGQqIeIe6FDVjKh/md2b+6Xd53QA79xYvwVMeFS0yOd/6wKIDEHMVG4Xj3m2SZs
    QJfoKKdK+wIT8W4eZ1y51uIKfAEZ47R7YVsceyi+QYCNdWZztY7MqExy9szZWli24TRoSi
    HGRllawYmtNs0I5cARjCGgQlt2/tVaDqXQwvdxPd9EYBXH6PZUNo4TlqMrmxHT8/YhEPCg
    JJEBMsVQicApCzTfwoe235as8CfuZJxhj7lt3f3KZWYBLG1plWxPRFoMm1gQiT54WOyCui
    JoMMmkhSRUhYi32/J4D/VdV6XcXtlaCBmVhN9aOu7N8xcEAee+YPRhQFpeJRLYKdNJn/DM
    eI+mzXk1neajb1w3rfCLySyuqE0irZH7bO9eM2QUCE1N9AHlJ1wmWhaP3HlQ
X-ME-Proxy: <xmx:MithauFGbhyfoNXlShr8qDhqmK4yN3UxM4e7-PL3cbReoQ_mDi7T1Q>
    <xmx:MithascQJNmMJG0yDxLc-57IHqWFJBbWP8SsVDKuIlV02kee5DOnvg>
    <xmx:MithanJI3uj_G1CgIZn_36ltuHtZrXc5RFLK7Vs1i1L7PyyNNtnkNQ>
    <xmx:MithapGMDNeyU_b4W3YPv3TOYrAeTfXMRZGCo18E1NohUgQo495dVg>
    <xmx:Mithat4yMBJCvCt9uaXCAVKaFqBh5f-HrBd6-jvQKQSyRxXdOx6i3sUg>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 16:42:25 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v3 5/6] selftests: net: add multithread server support to iou-zcrx
Date: Wed, 22 Jul 2026 15:39:49 -0500
Message-ID: <20260722203950.58550-6-juanlu@fastmail.com>
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

Run the iou-zcrx server as N worker threads, each owning one receive
queue with its own io_uring and zero-copy receive (zcrx) ifq, so the
test can exercise multi-queue zero-copy receive.

The main thread owns the listening socket, accepts connections, and
dispatches each to the worker owning the queue it landed on by matching
SO_INCOMING_NAPI_ID against per-queue NAPI IDs.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   8 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 297 ++++++++++++++----
 2 files changed, 237 insertions(+), 68 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3cab3b4adbb2e..946938371c763 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -7,14 +7,11 @@ HAS_IOURING_ZCRX := $(shell \
 	     'int main() {return 0;}' | \
 	$(CC) -luring -x c - -o /dev/null 2>&1 && echo y)
 
-ifeq ($(HAS_IOURING_ZCRX),y)
-COND_GEN_FILES += iou-zcrx
-else
+ifneq ($(HAS_IOURING_ZCRX),y)
 $(warning excluding iouring tests, liburing not installed or too old)
 endif
 
 TEST_GEN_FILES := \
-	$(COND_GEN_FILES) \
 # end of TEST_GEN_FILES
 
 TEST_PROGS = \
@@ -72,6 +69,9 @@ YNL_GEN_FILES := \
 	ncdevmem \
 	toeplitz \
 # end of YNL_GEN_FILES
+ifeq ($(HAS_IOURING_ZCRX),y)
+YNL_GEN_FILES += iou-zcrx
+endif
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 7bc61f3b70ca6..f85c4fdecd7ea 100644
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
-}
-
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
+	sqe->user_data = conn_idx;
 }
 
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
@@ -322,28 +310,118 @@ static void server_loop(struct thread_ctx *ctx)
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
+	struct thread_ctx *ctx = arg;
 	unsigned int flags = 0;
-	int fd, enable, ret;
 	uint64_t tstop;
+	int i;
+
+	flags |= IORING_SETUP_COOP_TASKRUN;
+	flags |= IORING_SETUP_SINGLE_ISSUER;
+	flags |= IORING_SETUP_DEFER_TASKRUN;
+	flags |= IORING_SETUP_SUBMIT_ALL;
+	flags |= IORING_SETUP_CQE32;
+
+	io_uring_queue_init(512, &ctx->ring, flags);
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
+	pthread_t *threads;
+	unsigned int ifindex;
+	int fd, ret, enable, i;
+
+	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
+	threads = calloc(cfg_num_threads, sizeof(*threads));
+	if (!ctxs || !threads)
+		error(1, 0, "calloc()");
 
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (fd == -1)
@@ -358,29 +436,120 @@ static void run_server(void)
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
+	{
+		struct epoll_event ev, out_ev;
+		int epfd, ready = 0;
 
-	tstop = gettimeofday_ms() + 5000;
-	while (!ctx.stop && gettimeofday_ms() < tstop)
-		server_loop(&ctx);
+		epfd = epoll_create1(0);
+		if (epfd < 0)
+			error(1, errno, "epoll_create1()");
 
-	if (!ctx.stop)
-		error(1, 0, "test failed\n");
+		for (i = 0; i < cfg_num_threads; i++) {
+			ev.events = EPOLLIN;
+			ev.data.fd = ctxs[i].ready_fd;
+			if (epoll_ctl(epfd, EPOLL_CTL_ADD,
+				      ctxs[i].ready_fd, &ev) < 0)
+				error(1, errno, "epoll_ctl()");
+		}
+
+		while (ready < cfg_num_threads) {
+			uint64_t val;
+
+			if (epoll_wait(epfd, &out_ev, 1, -1) < 0)
+				error(1, errno, "epoll_wait()");
+			if (read(out_ev.data.fd, &val, sizeof(val)) != sizeof(val))
+				error(1, errno, "read(ready_fd)");
+			ready++;
+		}
+
+		close(epfd);
+	}
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
+	{
+		int conns_per_thread = cfg_num_threads > 1 ?
+				       CONNS_PER_THREAD : 1;
+		int total_conns = conns_per_thread * cfg_num_threads;
+		int accepted = 0;
+		int connfd;
+
+		while (accepted < total_conns) {
+			int idx;
+
+			connfd = accept(fd, NULL, NULL);
+			if (connfd < 0)
+				error(1, errno, "accept()");
+
+			if (cfg_num_threads > 1) {
+				int napi_id;
+				socklen_t len = sizeof(napi_id);
+
+				ret = getsockopt(connfd, SOL_SOCKET,
+						 SO_INCOMING_NAPI_ID,
+						 &napi_id, &len);
+				if (ret < 0)
+					error(1, errno,
+					      "getsockopt(SO_INCOMING_NAPI_ID)");
+
+				idx = find_thread_by_napi(ctxs, napi_id);
+				if (idx < 0)
+					error(1, 0, "unknown NAPI ID: %d",
+					      napi_id);
+			} else {
+				idx = 0;
+			}
+
+			if (ctxs[idx].nr_conns >= MAX_CONNS_PER_THREAD)
+				error(1, 0, "worker %d connection overflow",
+				      idx);
+			ctxs[idx].connfds[ctxs[idx].nr_conns++] = connfd;
+			accepted++;
+		}
+	}
+
+	{
+		uint64_t val = 1;
+
+		for (i = 0; i < cfg_num_threads; i++) {
+			if (write(ctxs[i].start_fd, &val, sizeof(val)) != sizeof(val))
+				error(1, errno, "write(start_fd)");
+		}
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

