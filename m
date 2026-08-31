Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53049396D28
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199740; cv=none; b=C+dNZXpCLA/LjnlakZyuUNUGTYFSkGMyh3nB2rQ/w8H9Pfa3tOMbA3mKUb1X8lQd6//LLZtF3DF9nnN/x0/TREOnIWvI0mXJJ1poTl+GqS7BYUWSd5yflhQJFtf5Q8Vjfr/G4R0nZQAesHbvTA/qE5WzJC5gn1Jpt5dZar+H4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199740; c=relaxed/simple;
	bh=ktgLtqk2PNocAuxzteWqMuniT7CfUWJjO4o3NouzSrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XupPM3vlsEyU4zuu0Hz6dCTCkvb/+PmVpoYPa0DW6n7/3gGDbqvzaxi7kXuiuCdxUFIbv1XGlpI7LCeHiFUPEg1kDcfiqKHtwJqxA31sFaymUh47fjo/mBgzNgZTzdmLGh/Rhqfaey8797F2MlISqcVU/QhtqeioHR5r8PnIZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=Ow7tSnhO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="Ow7tSnhO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8548db7428aso3508591b3a.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1788199737; x=1788804537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3OPRSSQbvSa0krgRMx3xW73TWZ6GLGWWyRkYudAAg30=;
        b=Ow7tSnhO/5ua+wKBRU9oUvrFKzd8EXQ7jEdVT8wczF6dF6S+HSfZ1hSQHukq0CTHHR
         oE+Wcf+Lgbj0OGqzcrxLWNOp9nr+EVBWkV5iXtcpq3I0rojucbPKABx5yNvByNiiwfCL
         VY5EfPgEtx4+uW+PQHpm7rFpIyDe2UWrhpPFbDmjcqhPh1wl0Uuqxuph4hz1IllY0YTj
         G2rchksyDmsn03UoTpircaAq7UOX8+CFhOTpsjTyMCH7c81kMB/L0wNAr+PIu1osFTAz
         RizNjayopHMkcMc+Ho1IxMR7OEIr7I9WoZMr/UN8dJRehFaTs5OXGxiNcFmdPZq+l7CA
         pvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199737; x=1788804537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3OPRSSQbvSa0krgRMx3xW73TWZ6GLGWWyRkYudAAg30=;
        b=A2i3rr93nTuKTYAiQeI/BdxFFlcZC8y0jhXPl2dzFTrR8mZ4M0d5qi+bfinmxMQrUq
         izT0v1YuE/xX+wJcpsAT3ejVt4pzhf6ITJkhsFvexoQZVxD4DjbC89HjYsMNl1EdJ3t4
         91YIzb5UKU2fE+lsj/8yW6WFsAn5Aorv4quLC1YmPhSRXx2RXekoEQ/EqI2KwDNikuSB
         zrieCXxe5qHnRqyytCTStuMdj6WA0aVTvSYjQVKQnYgKTrRGVFXd47UV+zaPh+zHtHSR
         l4XiUtMp8j6niZ0PKy1Mmz0FUzbt0THdjkk475/+dYQgFsGZdfy5njV8HuGL3rB1yELJ
         aT8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rol+NaFqfP68m0ciVAbdfScLRy6e4s8+Fxy7sqkAelg4Sq/pyLpfl9gG34q4KeahuulLBKs7vk=@vger.kernel.org
X-Gm-Message-State: AFuF++m5e8UqHADYBouDXQ86eo/dHd/5QGj9EBZxgZaH+w2zmXORwz1H
	oFkPDtIK4n6NFCjUyfoX5TUyOcL/DerC6Ir7oEt/19SR8/ihjWErInkkJSQzMqZQiVk=
X-Gm-Gg: AR+sD11zpgwpawtz8mJ0LIj6kRzYEM6FLSabiqXh3G2iwwseFklOn4MWa6jXWMuTzZ7
	EFVlU1pY3sO6TAaSVkc27LBSu8+EAns7B+iVxsxxDM7Au7DkE1MHSAv0afeQYG71Sz+nxlq7Mzs
	glqjr8nrgDZ0f8uAK0OhiDt6zeRuTOyk+uMCdNGDX2hqPMURpfjY/WYcpYctOciltDlPH+VeosW
	JibreC2pNwDPpl5joCwgy8U5GCC9P5DSJTCENSsGVhApLLtqHT0+VdMiPtbpudkIwIKKvCubLYC
	IJHBYdTK90YR3Wo97XiAl1o5H/u+Trs9TONLWpj2zGpOOw25DP4QVUyTnQFNghz0K0hjWHc4nrq
	LJAZYaCL05JjcNFHbQllc7evSxNNX3OGr8XZaq1Cmikv2PUzSQp1/QBvwihtcaQXWLSNZyy8/+V
	UTj/+IiKGDwb2eebYy1xRsULnEWPEFXPJ0PQjBMHSx4Zw0tgET65/yo6WPOtN8FZ0OB0ezhxaQM
	PvS783h4ZJTphp5LSzJZDuG1Ve8lenubsXuLz7OFHu9yX4WYI5ZM9iXBIk4fnPF6than1YySw==
X-Received: by 2002:a05:6a21:400d:b0:3d3:ae0f:526a with SMTP id adf61e73a8af0-3d3ae0f5eebmr29486048637.22.1788199735058;
        Mon, 31 Aug 2026 11:08:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:1753])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f552473sm34996761eec.0.2026.08.31.11.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:08:54 -0700 (PDT)
Message-ID: <a1d70456-5d1d-4e90-8009-2292e1851a42@davidwei.uk>
Date: Mon, 31 Aug 2026 11:08:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/6] selftests: net: add multithread server
 support to iou-zcrx
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
 pabeni@redhat.com, shuah@kernel.org
References: <20260831-iou-zcrx-v6-0-02d1d012f0fd@fastmail.com>
 <20260831-iou-zcrx-v6-5-02d1d012f0fd@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260831-iou-zcrx-v6-5-02d1d012f0fd@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-31 10:34, Juanlu Herrero wrote:
> Run the iou-zcrx server as N worker threads, each owning one receive
> queue with its own io_uring and zero-copy receive (zcrx) ifq, so the
> test can exercise multi-queue zero-copy receive.
> 
> The main thread owns the listening socket, accepts connections, and
> dispatches each to the worker owning the queue it landed on by matching
> SO_INCOMING_NAPI_ID against per-queue NAPI IDs.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> ---
>   tools/testing/selftests/drivers/net/hw/Makefile   |   5 +-
>   tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 263 ++++++++++++++++------
>   2 files changed, 196 insertions(+), 72 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 37023ba580de..f613c88fffc5 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -13,10 +13,6 @@ else
>   $(warning excluding iouring tests, liburing not installed or too old)
>   endif
>   
> -TEST_GEN_FILES := \
> -	$(COND_GEN_FILES) \
> -# end of TEST_GEN_FILES
> -
>   TEST_PROGS = \
>   	csum.py \
>   	devlink_rate_cross_esw.py \
> @@ -74,6 +70,7 @@ TEST_INCLUDES := \
>   YNL_GEN_FILES := \
>   	ncdevmem \
>   	toeplitz \
> +	$(COND_GEN_FILES) \
>   # end of YNL_GEN_FILES
>   TEST_GEN_FILES += $(YNL_GEN_FILES)
>   TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index f793a6c04e41..29905cb3b243 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> @@ -38,6 +38,8 @@
>   #include <sys/wait.h>
>   
>   #include <liburing.h>
> +#include <ynl.h>
> +#include "netdev-user.h"
>   
>   #define SKIP_CODE	42
>   
> @@ -90,6 +92,8 @@ static int cfg_num_threads = 1;
>   
>   static char *payload;
>   
> +#define MAX_CONNS_PER_THREAD	64
> +
>   struct thread_ctx {
>   	struct io_uring		ring;
>   	void			*area_ptr;
> @@ -97,9 +101,15 @@ struct thread_ctx {
>   	size_t			ring_size;
>   	struct io_uring_zcrx_rq	rq_ring;
>   	unsigned long		area_token;
> -	int			connfd;
> -	bool			stop;
> -	size_t			received;
> +	int			queue_id;
> +	int			napi_id;
> +	pthread_barrier_t	*setup_done;
> +	pthread_barrier_t	*dispatch_done;
> +
> +	int			connfds[MAX_CONNS_PER_THREAD];
> +	size_t			received[MAX_CONNS_PER_THREAD];
> +	int			oneshot_recvs[MAX_CONNS_PER_THREAD];
> +	int			nr_conns;
>   };
>   
>   static unsigned long gettimeofday_ms(void)
> @@ -199,7 +209,7 @@ static void setup_zcrx(struct thread_ctx *ctx)
>   
>   	struct t_io_uring_zcrx_ifq_reg reg = {
>   		.if_idx = ifindex,
> -		.if_rxq = cfg_queue_id,
> +		.if_rxq = ctx->queue_id,
>   		.rq_entries = rq_entries,
>   		.area_ptr = (__u64)(unsigned long)&area_reg,
>   		.region_ptr = (__u64)(unsigned long)&region_reg,
> @@ -224,53 +234,32 @@ static void setup_zcrx(struct thread_ctx *ctx)
>   	ctx->area_token = area_reg.rq_area_token;
>   }
>   
> -static void add_accept(struct thread_ctx *ctx, int sockfd)
> +static void add_recvzc(struct thread_ctx *ctx, int conn_idx)
>   {
>   	struct io_uring_sqe *sqe;
>   
>   	sqe = io_uring_get_sqe(&ctx->ring);
>   
> -	io_uring_prep_accept(sqe, sockfd, NULL, NULL, 0);
> -	sqe->user_data = 1;
> -}
> -
> -static void add_recvzc(struct thread_ctx *ctx, int sockfd)
> -{
> -	struct io_uring_sqe *sqe;
> -
> -	sqe = io_uring_get_sqe(&ctx->ring);
> -
> -	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, 0, 0);
> +	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
> +			 NULL, 0, 0);
>   	sqe->ioprio |= IORING_RECV_MULTISHOT;
> -	sqe->user_data = 2;
> +	sqe->user_data = conn_idx;
>   }
>   
> -static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
> +static void add_recvzc_oneshot(struct thread_ctx *ctx, int conn_idx, size_t len)
>   {
>   	struct io_uring_sqe *sqe;
>   
>   	sqe = io_uring_get_sqe(&ctx->ring);
>   
> -	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
> +	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
> +			 NULL, len, 0);
>   	sqe->ioprio |= IORING_RECV_MULTISHOT;
> -	sqe->user_data = 2;
> +	sqe->user_data = conn_idx;
>   }
>   
> -static void process_accept(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
> -{
> -	if (cqe->res < 0)
> -		error(1, 0, "accept()");
> -	if (ctx->connfd)
> -		error(1, 0, "Unexpected second connection");
> -
> -	ctx->connfd = cqe->res;
> -	if (cfg_oneshot)
> -		add_recvzc_oneshot(ctx, ctx->connfd, page_size);
> -	else
> -		add_recvzc(ctx, ctx->connfd);
> -}
> -
> -static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
> +static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe,
> +			   int conn_idx)
>   {
>   	unsigned int rq_mask = ctx->rq_ring.ring_entries - 1;
>   	struct io_uring_zcrx_cqe *rcqe;
> @@ -280,8 +269,9 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
>   	ssize_t n;
>   	int i;
>   
> -	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
> -		ctx->stop = true;
> +	if (cqe->res == 0 && cqe->flags == 0 &&
> +	    ctx->oneshot_recvs[conn_idx] == 0) {
> +		ctx->nr_conns--;
>   		return;
>   	}
>   
> @@ -289,12 +279,14 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
>   		error(1, 0, "recvzc(): %d", cqe->res);
>   
>   	if (cfg_oneshot) {
> -		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
> -			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
> -			cfg_oneshot_recvs--;
> +		if (cqe->res == 0 && cqe->flags == 0 &&
> +		    ctx->oneshot_recvs[conn_idx]) {
> +			add_recvzc_oneshot(ctx, conn_idx, page_size);
> +			ctx->oneshot_recvs[conn_idx]--;
> +			return;
>   		}
>   	} else if (!(cqe->flags & IORING_CQE_F_MORE)) {
> -		add_recvzc(ctx, ctx->connfd);
> +		add_recvzc(ctx, conn_idx);
>   	}
>   
>   	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
> @@ -304,10 +296,10 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
>   	data = (char *)ctx->area_ptr + (rcqe->off & mask);
>   
>   	for (i = 0; i < n; i++) {
> -		if (*(data + i) != payload[(ctx->received + i)])
> +		if (*(data + i) != payload[(ctx->received[conn_idx] + i)])
>   			error(1, 0, "payload mismatch at %d", i);
>   	}
> -	ctx->received += n;
> +	ctx->received[conn_idx] += n;
>   
>   	rqe = &ctx->rq_ring.rqes[(ctx->rq_ring.rq_tail & rq_mask)];
>   	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | ctx->area_token;
> @@ -320,28 +312,124 @@ static void server_loop(struct thread_ctx *ctx)
>   	struct io_uring_cqe *cqe;
>   	unsigned int count = 0;
>   	unsigned int head;
> -	int i, ret;
>   
>   	io_uring_submit_and_wait(&ctx->ring, 1);
>   
>   	io_uring_for_each_cqe(&ctx->ring, head, cqe) {
> -		if (cqe->user_data == 1)
> -			process_accept(ctx, cqe);
> -		else if (cqe->user_data == 2)
> -			process_recvzc(ctx, cqe);
> -		else
> -			error(1, 0, "unknown cqe");
> +		process_recvzc(ctx, cqe, cqe->user_data);
>   		count++;
>   	}
>   	io_uring_cq_advance(&ctx->ring, count);
>   }
>   
> -static void run_server(void)
> +static void *server_worker(void *arg)
>   {
> -	struct thread_ctx ctx = {};
> -	unsigned int flags = 0;
> -	int fd, enable, ret;
> +	struct io_uring_params params = { };
> +	struct thread_ctx *ctx = arg;
>   	uint64_t tstop;
> +	int i;
> +
> +	params.flags |= IORING_SETUP_COOP_TASKRUN;
> +	params.flags |= IORING_SETUP_SINGLE_ISSUER;
> +	params.flags |= IORING_SETUP_DEFER_TASKRUN;
> +	params.flags |= IORING_SETUP_SUBMIT_ALL;
> +	params.flags |= IORING_SETUP_CQE32;
> +	params.flags |= IORING_SETUP_CQSIZE;
> +	params.cq_entries = AREA_SIZE / page_size;
> +
> +	io_uring_queue_init_params(512, &ctx->ring, &params);
> +	setup_zcrx(ctx);
> +
> +	if (cfg_dry_run)
> +		return NULL;
> +
> +	pthread_barrier_wait(ctx->setup_done);
> +	pthread_barrier_wait(ctx->dispatch_done);
> +
> +	for (i = 0; i < ctx->nr_conns; i++) {
> +		if (cfg_oneshot) {
> +			ctx->oneshot_recvs[i] = cfg_oneshot_recvs;
> +			add_recvzc_oneshot(ctx, i, page_size);
> +		} else {
> +			add_recvzc(ctx, i);
> +		}
> +	}
> +
> +	tstop = gettimeofday_ms() + 5000;
> +	while (ctx->nr_conns > 0 && gettimeofday_ms() < tstop)
> +		server_loop(ctx);
> +
> +	if (ctx->nr_conns != 0)
> +		error(1, 0, "test failed: %d connections incomplete",
> +		      ctx->nr_conns);
> +
> +	return NULL;
> +}
> +
> +static int query_napi_id(unsigned int ifindex, int queue_id)
> +{
> +	struct netdev_queue_get_req *req;
> +	struct netdev_queue_get_rsp *rsp;
> +	struct ynl_error yerr;
> +	struct ynl_sock *ys;
> +	int napi_id;
> +
> +	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> +	if (!ys)
> +		error(1, 0, "ynl_sock_create: %s", yerr.msg);
> +
> +	req = netdev_queue_get_req_alloc();
> +	netdev_queue_get_req_set_ifindex(req, ifindex);
> +	netdev_queue_get_req_set_type(req, NETDEV_QUEUE_TYPE_RX);
> +	netdev_queue_get_req_set_id(req, queue_id);
> +
> +	rsp = netdev_queue_get(ys, req);
> +	if (!rsp)
> +		error(1, 0, "netdev_queue_get(q=%d): %s", queue_id,
> +		      ys->err.msg);
> +	if (!rsp->_present.napi_id)
> +		error(1, 0, "netdev_queue_get(q=%d): napi_id not present",
> +		      queue_id);
> +
> +	napi_id = rsp->napi_id;
> +
> +	netdev_queue_get_req_free(req);
> +	netdev_queue_get_rsp_free(rsp);
> +	ynl_sock_destroy(ys);
> +
> +	return napi_id;
> +}
> +
> +static int find_thread_by_conn(struct thread_ctx *ctxs, int connfd)
> +{
> +	socklen_t len = sizeof(int);
> +	int napi_id, i;
> +
> +	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &napi_id, &len))
> +		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
> +
> +	for (i = 0; i < cfg_num_threads; i++) {
> +		if (ctxs[i].napi_id == napi_id)
> +			return i;
> +	}
> +
> +	error(1, 0, "unknown NAPI ID: %d", napi_id);
> +	return -1;
> +}
> +
> +static void run_server(void)
> +{
> +	pthread_barrier_t setup_done, dispatch_done;
> +	int total_conns, accepted = 0, connfd;
> +	struct thread_ctx *ctxs;
> +	int fd, ret, enable, i;
> +	unsigned int ifindex;
> +	pthread_t *threads;
> +
> +	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
> +	threads = calloc(cfg_num_threads, sizeof(*threads));
> +	if (!ctxs || !threads)
> +		error(1, 0, "calloc()");
>   
>   	fd = socket(AF_INET6, SOCK_STREAM, 0);
>   	if (fd == -1)
> @@ -356,29 +444,68 @@ static void run_server(void)
>   	if (ret < 0)
>   		error(1, 0, "bind()");
>   
> -	flags |= IORING_SETUP_COOP_TASKRUN;
> -	flags |= IORING_SETUP_SINGLE_ISSUER;
> -	flags |= IORING_SETUP_DEFER_TASKRUN;
> -	flags |= IORING_SETUP_SUBMIT_ALL;
> -	flags |= IORING_SETUP_CQE32;
> +	pthread_barrier_init(&setup_done, NULL, cfg_num_threads + 1);
> +	pthread_barrier_init(&dispatch_done, NULL, cfg_num_threads + 1);
> +
> +	for (i = 0; i < cfg_num_threads; i++) {
> +		ctxs[i].queue_id = cfg_queue_id + i;
> +		ctxs[i].setup_done = &setup_done;
> +		ctxs[i].dispatch_done = &dispatch_done;
> +	}
>   
> -	io_uring_queue_init(512, &ctx.ring, flags);
> +	for (i = 0; i < cfg_num_threads; i++) {
> +		ret = pthread_create(&threads[i], NULL,
> +				     server_worker, &ctxs[i]);
> +		if (ret)
> +			error(1, ret, "pthread_create()");
> +	}
>   
> -	setup_zcrx(&ctx);
>   	if (cfg_dry_run)
> -		return;
> +		goto join;
>   
>   	if (listen(fd, 1024) < 0)
>   		error(1, 0, "listen()");
>   
> -	add_accept(&ctx, fd);
> +	pthread_barrier_wait(&setup_done);
>   
> -	tstop = gettimeofday_ms() + 5000;
> -	while (!ctx.stop && gettimeofday_ms() < tstop)
> -		server_loop(&ctx);
> +	if (cfg_num_threads > 1) {
> +		ifindex = if_nametoindex(cfg_ifname);
> +		if (!ifindex)
> +			error(1, 0, "bad interface name: %s", cfg_ifname);
> +		for (i = 0; i < cfg_num_threads; i++)
> +			ctxs[i].napi_id = query_napi_id(ifindex,
> +							ctxs[i].queue_id);
> +	}
> +
> +	total_conns = cfg_num_threads * cfg_num_threads;
> +
> +	while (accepted < total_conns) {
> +		int idx = 0;
> +
> +		connfd = accept(fd, NULL, NULL);
> +		if (connfd < 0)
> +			error(1, errno, "accept()");
>   
> -	if (!ctx.stop)
> -		error(1, 0, "test failed\n");
> +		if (cfg_num_threads > 1)
> +			idx = find_thread_by_conn(ctxs, connfd);
> +
> +		if (ctxs[idx].nr_conns >= MAX_CONNS_PER_THREAD)
> +			error(1, 0, "worker %d connection overflow", idx);
> +		ctxs[idx].connfds[ctxs[idx].nr_conns++] = connfd;
> +		accepted++;
> +	}
> +
> +	pthread_barrier_wait(&dispatch_done);
> +
> +join:
> +	for (i = 0; i < cfg_num_threads; i++)
> +		pthread_join(threads[i], NULL);
> +
> +	pthread_barrier_destroy(&setup_done);
> +	pthread_barrier_destroy(&dispatch_done);
> +	close(fd);
> +	free(threads);
> +	free(ctxs);
>   }
>   
>   static void *client_worker(void *arg)
> 

Reviewed-by: David Wei <dw@davidwei.uk>
