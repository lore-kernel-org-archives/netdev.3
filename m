Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6A3D75D3
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861929; cv=none; b=Rw/2Ao8wyxtbeF36k50XWy39ZMbnJqWwOJpB+EXwGleHNFQ3Xr0NL/vYQDTDNELKdEvEAaEv9GF5FVOm25KPoasVlyKoCxDLqz1Vb7hrmKsMsmIzCvmQUCjzxS/2P8H3l1PtukwllQ9vK0H+SLjVNxDGoV6qKMYqWJ4gpeqkv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861929; c=relaxed/simple;
	bh=yN28ec4jBa5LLU9bGT3G6tKtO4l5j1difV02nJyeTFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t66i6jV9oekjPp4AlVUHkDBjntdsumc7z9XjIF29SNZWma67cztG/ltMe4fKZxkP0VjVx4pWhNj6AqgatBuC8NgrduGc0sdZbJfP2mmh0sP6KPEl2d/zqg7DXG6M6Wj28rlHVD6GJMYGEmBYy4+w9eXMTElGS2bunFUDC7GkhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=ZdDgbvk4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="ZdDgbvk4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cedda2ce6fso579725ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1785861909; x=1786466709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZnVC1HbfWxJ+ijjPyquaQklNAIDBulGDAgRyInwAac8=;
        b=ZdDgbvk4I2iz2VSw6bxJ4fNkpxIDqT6+cR08hgCg0r6NY0BrOIoyyzDzb3gSzsooUZ
         ESquRMp68Lb4449pDi8hL2zZ4aAWvlz1UAZpIyahmoCEaNX1aQxN9bY77dsE1DR7bBM8
         2OkH10KlBjZvyShtmifuUUKL9ZliOeS1kD/OeUTaNsBYQpoKzo0D6cKGthwT+gr9QqpF
         S6ERMPGbr4bARJC3WE9ELAeRgi5XKw+z7GbSrWliBJ2W21plZ+lHJD1DdfrINdVHqrcj
         bpx2qvNCGolhUJOC3jZ+TqWYcz4rwa3zORzL3RXn6V3Rph5OtuRtGvczl2QhhWO+K5iN
         DacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785861909; x=1786466709;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZnVC1HbfWxJ+ijjPyquaQklNAIDBulGDAgRyInwAac8=;
        b=VsLve/YHNtwygg+auqcrZ3zIqzwYPk7GHudHdztd1RSLxC9Wnphf3JXRGcv9xNArHf
         W6XTQ2JYLpqVcgRLNmgSBc+MbMXIShZSOnQ9AYAHahdGdTuBpMa/YV4eAdJqSoDI4Ek+
         GNIvFGksw2DWxcYsRY0Lhm1Pb+S+2lewq957/BiHxzfQ5nJxzP9z4wJVqcO6CF5xkzry
         +cZFZ+JIWshpYoeED7xQOGIv3WE+mhLJpRsg2ATyPGlmIK3ssgTW7oEmmZYnRE+2SdHA
         hOh+iCwOyxjzESVAHcKQrB80SI1aOEbnImW5luqHjZ4UUorNOUmnb89IORnaUC+2ImVD
         mGwA==
X-Forwarded-Encrypted: i=1; AHgh+RrocXTz4aWrzUQdTXlSwChj7gYNArsN6w4bA/PWtOqxYMQr4GDj+XCJP1pekYMwR+sNe4obBw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3fsuhyLlcxQosLW2zbxT6sRyrfRPZfPMw2k9KnGvajGHRrKp
	bTlQtzMVK+kIlABKuQtErppwAZek5NiCydc713ycB4vYNJjc0Z0P6NawB1UvM+azzYY=
X-Gm-Gg: AR+sD103Fz3EupVXYaVV/LCJH/vYlEakIXydxh54R8YZ62+bquecfKYhfsxLLiBmkoA
	4dMmyRBeHNXS6O3xBzmqAGdccpd6W04K0OG1EOhS4YSPryeWLsbBBdkWgfVExxC+ar0i8iFoUrB
	Esafh8PaC6QIMpfS/5V4KQFCakDLxUvYbYCzUZFD5WHTGHy3HbJ8PVh63+qbiQliIROa0UmL3Ek
	yhmMSDm54L+TsvH9kIPQZh4fZsI4DFPKEtzIBOethLV2RdHUmW9VYid07lwyOb/Dh4dplAZBddh
	IRelz7LdqKXGYgUFbXpfNhdONzT9fNv56JmHSvWWdw1NC/V4Cy/qT1WwlL26Rrk/AwtLNRkhJ7O
	eCx6Ma1arQs5erZ1GixdwIyryeYhA7ceEfrgyT6BUa4NQFDDgtQbZ35Otk/8NrUx22YAw4DuCSS
	KkkwjSNwgTmbW+OKUWm3W56FiyI+3T5rIudhEHxfqbNUm1b7WpZoQR8A8Wqi0CfCDP97hZHai8e
	se4zBJAGsWJQu3rFo7KWbOdSMYZZXRlfJIE2GPJYwt/F28fXl9VFSpRHMYs2hOQ/tKfkgg=
X-Received: by 2002:a17:902:ce84:b0:2cf:9f0b:b562 with SMTP id d9443c01a7336-2d0ca9904b7mr886245ad.22.1785861908815;
        Tue, 04 Aug 2026 09:45:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:a:73:30bd:a4b6:294c? ([2620:10d:c090:500::6:55a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673b7b2sm6503385eec.19.2026.08.04.09.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 09:45:08 -0700 (PDT)
Message-ID: <461c426a-8690-4a3a-b9bc-1429c5e1dfd2@davidwei.uk>
Date: Tue, 4 Aug 2026 09:45:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] selftests: net: add multithread server
 support to iou-zcrx
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
References: <20260729221825.42773-1-juanlu@fastmail.com>
 <20260729221825.42773-6-juanlu@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260729221825.42773-6-juanlu@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-29 15:18, Juanlu Herrero wrote:
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
>   .../testing/selftests/drivers/net/hw/Makefile |   5 +-
>   .../selftests/drivers/net/hw/iou-zcrx.c       | 290 ++++++++++++++----
>   2 files changed, 226 insertions(+), 69 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index 7bc61f3b70ca6..16259129df46d 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
[...]
> @@ -322,28 +310,124 @@ static void server_loop(struct thread_ctx *ctx)
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
> +	struct thread_ctx *ctx = arg;
> +	struct io_uring_params params = { };

Reverse christmas tree.

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
> +	{
> +		uint64_t val = 1;
> +
> +		if (write(ctx->ready_fd, &val, sizeof(val)) != sizeof(val))
> +			error(1, errno, "write(ready_fd)");
> +		if (read(ctx->start_fd, &val, sizeof(val)) != sizeof(val))
> +			error(1, errno, "read(start_fd)");

A pthread_barrier_t is more idiomatic and you can get rid of the epollfd
in main thread entirely.

> +	}
> +
> +	for (i = 0; i < ctx->nr_conns; i++) {
> +		if (cfg_oneshot)
> +			add_recvzc_oneshot(ctx, i, page_size);
> +		else
> +			add_recvzc(ctx, i);
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
> +static int find_thread_by_napi(struct thread_ctx *ctxs, int napi_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < cfg_num_threads; i++) {
> +		if (ctxs[i].napi_id == napi_id)
> +			return i;
> +	}
> +	return -1;
> +}
> +
> +static void run_server(void)
> +{
> +	struct thread_ctx *ctxs;
> +	struct epoll_event ev, out_ev;
> +	pthread_t *threads;
> +	unsigned int ifindex;
> +	int conns_per_thread, total_conns, accepted = 0, connfd;
> +	int fd, ret, enable, i;
> +	int epfd, ready = 0;
> +	uint64_t val;

Reverse christmas tree.

> +
> +	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
> +	threads = calloc(cfg_num_threads, sizeof(*threads));
> +	if (!ctxs || !threads)
> +		error(1, 0, "calloc()");
>   
>   	fd = socket(AF_INET6, SOCK_STREAM, 0);
>   	if (fd == -1)
> @@ -358,29 +442,105 @@ static void run_server(void)
>   	if (ret < 0)
>   		error(1, 0, "bind()");
>   
> -	flags |= IORING_SETUP_COOP_TASKRUN;
> -	flags |= IORING_SETUP_SINGLE_ISSUER;
> -	flags |= IORING_SETUP_DEFER_TASKRUN;
> -	flags |= IORING_SETUP_SUBMIT_ALL;
> -	flags |= IORING_SETUP_CQE32;
> +	for (i = 0; i < cfg_num_threads; i++) {
> +		ctxs[i].queue_id = cfg_queue_id + i;
> +		ctxs[i].ready_fd = eventfd(0, 0);
> +		ctxs[i].start_fd = eventfd(0, 0);
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
> +	epfd = epoll_create1(0);
> +	if (epfd < 0)
> +		error(1, errno, "epoll_create1()");
>   
> -	tstop = gettimeofday_ms() + 5000;
> -	while (!ctx.stop && gettimeofday_ms() < tstop)
> -		server_loop(&ctx);
> +	for (i = 0; i < cfg_num_threads; i++) {
> +		ev.events = EPOLLIN;
> +		ev.data.fd = ctxs[i].ready_fd;
> +		if (epoll_ctl(epfd, EPOLL_CTL_ADD,
> +			      ctxs[i].ready_fd, &ev) < 0)
> +			error(1, errno, "epoll_ctl()");
> +	}
> +
> +	while (ready < cfg_num_threads) {
> +		if (epoll_wait(epfd, &out_ev, 1, -1) < 0)
> +			error(1, errno, "epoll_wait()");
> +		if (read(out_ev.data.fd, &val, sizeof(val)) != sizeof(val))
> +			error(1, errno, "read(ready_fd)");
> +		ready++;
> +	}
> +
> +	close(epfd);

All this can go if using a barrier.

> +
> +	if (cfg_num_threads > 1) {
> +		ifindex = if_nametoindex(cfg_ifname);
> +		if (!ifindex)
> +			error(1, 0, "bad interface name: %s", cfg_ifname);
> +		for (i = 0; i < cfg_num_threads; i++)
> +			ctxs[i].napi_id = query_napi_id(ifindex,
> +							ctxs[i].queue_id);
> +	}
> +
> +	conns_per_thread = cfg_num_threads > 1 ? CONNS_PER_THREAD : 1;
> +	total_conns = conns_per_thread * cfg_num_threads;
> +
> +	while (accepted < total_conns) {
> +		int idx;
> +
> +		connfd = accept(fd, NULL, NULL);
> +		if (connfd < 0)
> +			error(1, errno, "accept()");
> +
> +		if (cfg_num_threads > 1) {
> +			int napi_id;
> +			socklen_t len = sizeof(napi_id);
> +
> +			ret = getsockopt(connfd, SOL_SOCKET,
> +					 SO_INCOMING_NAPI_ID,
> +					 &napi_id, &len);
> +			if (ret < 0)
> +				error(1, errno,
> +				      "getsockopt(SO_INCOMING_NAPI_ID)");
> +
> +			idx = find_thread_by_napi(ctxs, napi_id);

Make the helper take in a connfd and return the index directly.

> +			if (idx < 0)
> +				error(1, 0, "unknown NAPI ID: %d",
> +				      napi_id);
> +		} else {
> +			idx = 0;

Don't need the else, init idx to 0.
