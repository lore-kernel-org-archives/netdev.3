Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EA3BFE21
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723612; cv=none; b=dwREKeJNKEW+bnCeqMQSxM12SGXUx1nyXhzJ4kgRmBx9352CPIkLOp46G88dioOBEOvHpb4pJUKRgODGTC1ERtsSmVPsPUwq8vwIJwTsAkmZdv46jLjO0FxdVOhVksXXx5Dc5B81sqJD/rY8ylKAeUDL6crO0Jlp5DIjt2DEADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723612; c=relaxed/simple;
	bh=uLu76cWf7I+67dUkzFKAUCMO83fVj+kdvowibuGu+Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3bmU01dFXPDxr70mrSCU8eYRv1gJz2f7kVc48H/HeyDZlG4SoDqOEPH+APmo7c6yhMKvBUe3Q7fYoWHTqIEJ6KhC4dxvfnn44vLYPbRtIrj5ZibxtNJxfAq8sCzt/N8U7x14nR4gviCOW9m4rJSHQxmW5ZYZlzt1fU0Jgir79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=rPWn13Ab; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="rPWn13Ab"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b21f09ec76so641957b6e.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1786723607; x=1787328407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXhmdMMiiCtGRS5IKPip21Q5vKDETRQdcSgDS2qOyrA=;
        b=rPWn13AbfHAQriFF7WpiKmQvPZtZB/Gg3j4KDq4XkiEIhz4OYlGsN8UQNYy2LBkx8S
         9aWiHz3fcGTtwjLHPPF2Dj/jAJgll4tFARIDvsmTQz9+XKTUd502OESpLopCO+0lsU7l
         JCPyctUtIDxbRuiMkVxr10uDk2zk39xeQ5tteaicyseI34WlYZu/Af8UYcs/0sQbTiry
         UlYmioGSFtqksDJ46T1H1y2WYAanx7qyy9W6QGnwWApO7J9Sj8wjFMLeKqmpg5X1CstJ
         /kpoOaav4tasCV7k0lwFs3CBrGXkDIMmG5QergqhMEO+QcoMG77DRK63AHveUnH5gFFx
         9q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723607; x=1787328407;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXhmdMMiiCtGRS5IKPip21Q5vKDETRQdcSgDS2qOyrA=;
        b=Z/ju/VfSXy3sQbZjL6f/YzewrNDZYaaBCuPU6k17otJZ/d/NifZ5MRGwg0M9fssjRW
         yKsGA/sC6ACQGnY9cpG/FAMpRicxDeNhPJJL+eMh8BphX5CuT77KHU3/yhoO2ANa+r2h
         yyMvD+WVQZndiqJbVOu/y+Fe+IUBPQSQNqYaoCAQCggxSPNtbV9BQA6eeZVMjDeBK6U6
         g8WqU/6CIH3xtOsUK4wNGn40lnkuRmjECQYDCkY7CXiPFTVBu8QRRbhpMcK0qJzi/ldh
         pAIGrcuhENXpkKu/thiLH6GpcGIBM/yTfrAt3JsrTl98sQZwb3PRCrUHntnOx70Y1a/b
         S0sQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrm0UxZ77+nUGHKq4tj43cNRabkxzeDScIT76swNcS7UomxN9iMlcHBOvXL6Tc7D770wbNf3/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrosyQTEbjeIlMjq/ZrTQiqrW9c9u5xcpHGnU1HoNNCrqe3Ob
	G6piXUSgF22OqLsvgA00YrlV4X1D/DmDa+p94wIAO1hWY9tPBZuWMSpqIT67P4ZRsyA=
X-Gm-Gg: AR+sD13nauPpB1VDFym46DOGTpGjQUXmkqMQt5hhOB/il6Y5rv4QJWjv99bci8ld8dN
	SFLhUxJ2R8ABMHc+vVlEEN2KJOHFQXdZMZdd9Y8nI2pVKDtKYr+HxU2kVqAHd/P34dFBXNVdg96
	aE6m0ejlCoqKNLIb5TjXSxqJqbr9QOjVmJrVwyQtye8FesvlJDysgJtByH0W2WJZCuKQ5GyzBjn
	U/vbm74OFjMyFeJNnwsJ7x0ZAgUMKDKWQHDu0Mvq7h5cj/Th8hklK57MNVeoGG6emXw37E6/Mmd
	JXT+UkNEg9rRWn+LlaAs+AxZckCrwt2xhRz37U6PP4yt9d0glRj0h/otyMFIGrn8vT/MGdfQONX
	J7ZYyVhQRh+v4ZTWzh+tcGXoqd9ddbcoBMZkJESLJ06FcxRjSOF8QwmlfP5x+e9VOYnCwWROlbf
	/2RhU9zs0KEkPNgDVzspbNyrenwbj0aNtEsGi1+ijiDY84WfjAt2eNdKmkKykozTphkOWQBTxAm
	ccgTLpbAorjpPS4oxmPABX6FG6Tm5FQjvM/+9NxhRNTlgxDPvPcqhdU
X-Received: by 2002:a05:6809:2cc:20b0:4a4:ade8:a287 with SMTP id 5614622812f47-4b241ccc905mr4159320b6e.13.1786723607089;
        Fri, 14 Aug 2026 09:06:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::4:a11e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24db65d1asm1179393b6e.14.2026.08.14.09.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:06:46 -0700 (PDT)
Message-ID: <edf18414-5bec-4776-97cb-555230de0c13@davidwei.uk>
Date: Fri, 14 Aug 2026 09:06:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/6] selftests: net: refactor server state
 into struct thread_ctx
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
 pabeni@redhat.com, shuah@kernel.org
References: <20260814012348.46958-1-juanlu@fastmail.com>
 <20260814012348.46958-4-juanlu@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260814012348.46958-4-juanlu@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-13 18:23, Juanlu Herrero wrote:
> Move server-side state (io_uring ring, zcrx area, refill ring, receive
> tracking) from global variables into a local struct thread_ctx. This is
> a pure refactor with no behavior change: run_server still allocates a
> single context on the stack and runs single-threaded, using io_uring
> accept and recvzc as before.
> 
> This prepares the ground for the multithread server support in the
> following commits, which spawns N worker threads each with their own
> struct thread_ctx.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> ---
>   .../selftests/drivers/net/hw/iou-zcrx.c       | 156 +++++++++---------
>   1 file changed, 80 insertions(+), 76 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index c6dbd0ad53681..9b62fd0703e61 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> @@ -87,14 +87,18 @@ static unsigned int cfg_rx_buf_len;
>   static bool cfg_dry_run;
>   
>   static char *payload;
> -static void *area_ptr;
> -static void *ring_ptr;
> -static size_t ring_size;
> -static struct io_uring_zcrx_rq rq_ring;
> -static unsigned long area_token;
> -static int connfd;
> -static bool stop;
> -static size_t received;
> +
> +struct thread_ctx {
> +	struct io_uring		ring;
> +	void			*area_ptr;
> +	void			*ring_ptr;
> +	size_t			ring_size;
> +	struct io_uring_zcrx_rq	rq_ring;
> +	unsigned long		area_token;
> +	int			connfd;
> +	bool			stop;
> +	size_t			received;
> +};
>   
>   static unsigned long gettimeofday_ms(void)
>   {
> @@ -138,7 +142,7 @@ static inline size_t get_refill_ring_size(unsigned int rq_entries)
>   	return ALIGN_UP(size, page_size);
>   }
>   
> -static void setup_zcrx(struct io_uring *ring)
> +static void setup_zcrx(struct thread_ctx *ctx)
>   {
>   	unsigned int ifindex;
>   	unsigned int rq_entries = 4096;
> @@ -149,44 +153,44 @@ static void setup_zcrx(struct io_uring *ring)
>   		error(1, 0, "bad interface name: %s", cfg_ifname);
>   
>   	if (cfg_rx_buf_len && cfg_rx_buf_len != page_size) {
> -		area_ptr = mmap(NULL,
> -				AREA_SIZE,
> -				PROT_READ | PROT_WRITE,
> -				MAP_ANONYMOUS | MAP_PRIVATE |
> -				MAP_HUGETLB | MAP_HUGE_2MB,
> -				-1,
> -				0);
> -		if (area_ptr == MAP_FAILED) {
> +		ctx->area_ptr = mmap(NULL,
> +				     AREA_SIZE,
> +				     PROT_READ | PROT_WRITE,
> +				     MAP_ANONYMOUS | MAP_PRIVATE |
> +				     MAP_HUGETLB | MAP_HUGE_2MB,
> +				     -1,
> +				     0);
> +		if (ctx->area_ptr == MAP_FAILED) {
>   			printf("Can't allocate huge pages\n");
>   			exit(SKIP_CODE);
>   		}
>   	} else {
> -		area_ptr = mmap(NULL,
> -				AREA_SIZE,
> -				PROT_READ | PROT_WRITE,
> -				MAP_ANONYMOUS | MAP_PRIVATE,
> -				0,
> -				0);
> -		if (area_ptr == MAP_FAILED)
> +		ctx->area_ptr = mmap(NULL,
> +				     AREA_SIZE,
> +				     PROT_READ | PROT_WRITE,
> +				     MAP_ANONYMOUS | MAP_PRIVATE,
> +				     0,
> +				     0);
> +		if (ctx->area_ptr == MAP_FAILED)
>   			error(1, 0, "mmap(): zero copy area");
>   	}
>   
> -	ring_size = get_refill_ring_size(rq_entries);
> -	ring_ptr = mmap(NULL,
> -			ring_size,
> -			PROT_READ | PROT_WRITE,
> -			MAP_ANONYMOUS | MAP_PRIVATE,
> -			0,
> -			0);
> +	ctx->ring_size = get_refill_ring_size(rq_entries);
> +	ctx->ring_ptr = mmap(NULL,
> +			     ctx->ring_size,
> +			     PROT_READ | PROT_WRITE,
> +			     MAP_ANONYMOUS | MAP_PRIVATE,
> +			     0,
> +			     0);
>   
>   	struct io_uring_region_desc region_reg = {
> -		.size = ring_size,
> -		.user_addr = (__u64)(unsigned long)ring_ptr,
> +		.size = ctx->ring_size,
> +		.user_addr = (__u64)(unsigned long)ctx->ring_ptr,
>   		.flags = IORING_MEM_REGION_TYPE_USER,
>   	};
>   
>   	struct io_uring_zcrx_area_reg area_reg = {
> -		.addr = (__u64)(unsigned long)area_ptr,
> +		.addr = (__u64)(unsigned long)ctx->area_ptr,
>   		.len = AREA_SIZE,
>   		.flags = 0,
>   	};
> @@ -200,7 +204,7 @@ static void setup_zcrx(struct io_uring *ring)
>   		.rx_buf_len = cfg_rx_buf_len,
>   	};
>   
> -	ret = io_uring_register_ifq(ring, (void *)&reg);
> +	ret = io_uring_register_ifq(&ctx->ring, (void *)&reg);
>   	if (cfg_rx_buf_len && (ret == -EINVAL || ret == -EOPNOTSUPP ||
>   			       ret == -ERANGE)) {
>   		printf("Large chunks are not supported %i\n", ret);
> @@ -209,64 +213,64 @@ static void setup_zcrx(struct io_uring *ring)
>   		error(1, 0, "io_uring_register_ifq(): %d", ret);
>   	}
>   
> -	rq_ring.khead = (unsigned int *)((char *)ring_ptr + reg.offsets.head);
> -	rq_ring.ktail = (unsigned int *)((char *)ring_ptr + reg.offsets.tail);
> -	rq_ring.rqes = (struct io_uring_zcrx_rqe *)((char *)ring_ptr + reg.offsets.rqes);
> -	rq_ring.rq_tail = 0;
> -	rq_ring.ring_entries = reg.rq_entries;
> +	ctx->rq_ring.khead = (unsigned int *)((char *)ctx->ring_ptr + reg.offsets.head);
> +	ctx->rq_ring.ktail = (unsigned int *)((char *)ctx->ring_ptr + reg.offsets.tail);
> +	ctx->rq_ring.rqes = (struct io_uring_zcrx_rqe *)((char *)ctx->ring_ptr + reg.offsets.rqes);
> +	ctx->rq_ring.rq_tail = 0;
> +	ctx->rq_ring.ring_entries = reg.rq_entries;
>   
> -	area_token = area_reg.rq_area_token;
> +	ctx->area_token = area_reg.rq_area_token;
>   }
>   
> -static void add_accept(struct io_uring *ring, int sockfd)
> +static void add_accept(struct thread_ctx *ctx, int sockfd)
>   {
>   	struct io_uring_sqe *sqe;
>   
> -	sqe = io_uring_get_sqe(ring);
> +	sqe = io_uring_get_sqe(&ctx->ring);
>   
>   	io_uring_prep_accept(sqe, sockfd, NULL, NULL, 0);
>   	sqe->user_data = 1;
>   }
>   
> -static void add_recvzc(struct io_uring *ring, int sockfd)
> +static void add_recvzc(struct thread_ctx *ctx, int sockfd)
>   {
>   	struct io_uring_sqe *sqe;
>   
> -	sqe = io_uring_get_sqe(ring);
> +	sqe = io_uring_get_sqe(&ctx->ring);
>   
>   	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, 0, 0);
>   	sqe->ioprio |= IORING_RECV_MULTISHOT;
>   	sqe->user_data = 2;
>   }
>   
> -static void add_recvzc_oneshot(struct io_uring *ring, int sockfd, size_t len)
> +static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
>   {
>   	struct io_uring_sqe *sqe;
>   
> -	sqe = io_uring_get_sqe(ring);
> +	sqe = io_uring_get_sqe(&ctx->ring);
>   
>   	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
>   	sqe->ioprio |= IORING_RECV_MULTISHOT;
>   	sqe->user_data = 2;
>   }
>   
> -static void process_accept(struct io_uring *ring, struct io_uring_cqe *cqe)
> +static void process_accept(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
>   {
>   	if (cqe->res < 0)
>   		error(1, 0, "accept()");
> -	if (connfd)
> +	if (ctx->connfd)
>   		error(1, 0, "Unexpected second connection");
>   
> -	connfd = cqe->res;
> +	ctx->connfd = cqe->res;
>   	if (cfg_oneshot)
> -		add_recvzc_oneshot(ring, connfd, page_size);
> +		add_recvzc_oneshot(ctx, ctx->connfd, page_size);
>   	else
> -		add_recvzc(ring, connfd);
> +		add_recvzc(ctx, ctx->connfd);
>   }
>   
> -static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
> +static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
>   {
> -	unsigned rq_mask = rq_ring.ring_entries - 1;
> +	unsigned int rq_mask = ctx->rq_ring.ring_entries - 1;
>   	struct io_uring_zcrx_cqe *rcqe;
>   	struct io_uring_zcrx_rqe *rqe;
>   	uint64_t mask;
> @@ -275,7 +279,7 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
>   	int i;
>   
>   	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
> -		stop = true;
> +		ctx->stop = true;
>   		return;
>   	}
>   
> @@ -284,56 +288,56 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
>   
>   	if (cfg_oneshot) {
>   		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
> -			add_recvzc_oneshot(ring, connfd, page_size);
> +			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
>   			cfg_oneshot_recvs--;
>   		}
>   	} else if (!(cqe->flags & IORING_CQE_F_MORE)) {
> -		add_recvzc(ring, connfd);
> +		add_recvzc(ctx, ctx->connfd);
>   	}
>   
>   	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
>   
>   	n = cqe->res;
>   	mask = (1ULL << IORING_ZCRX_AREA_SHIFT) - 1;
> -	data = (char *)area_ptr + (rcqe->off & mask);
> +	data = (char *)ctx->area_ptr + (rcqe->off & mask);
>   
>   	for (i = 0; i < n; i++) {
> -		if (*(data + i) != payload[(received + i)])
> +		if (*(data + i) != payload[(ctx->received + i)])
>   			error(1, 0, "payload mismatch at %d", i);
>   	}
> -	received += n;
> +	ctx->received += n;
>   
> -	rqe = &rq_ring.rqes[(rq_ring.rq_tail & rq_mask)];
> -	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | area_token;
> +	rqe = &ctx->rq_ring.rqes[(ctx->rq_ring.rq_tail & rq_mask)];
> +	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | ctx->area_token;
>   	rqe->len = cqe->res;
> -	io_uring_smp_store_release(rq_ring.ktail, ++rq_ring.rq_tail);
> +	io_uring_smp_store_release(ctx->rq_ring.ktail, ++ctx->rq_ring.rq_tail);
>   }
>   
> -static void server_loop(struct io_uring *ring)
> +static void server_loop(struct thread_ctx *ctx)
>   {
>   	struct io_uring_cqe *cqe;
>   	unsigned int count = 0;
>   	unsigned int head;
>   	int i, ret;
>   
> -	io_uring_submit_and_wait(ring, 1);
> +	io_uring_submit_and_wait(&ctx->ring, 1);
>   
> -	io_uring_for_each_cqe(ring, head, cqe) {
> +	io_uring_for_each_cqe(&ctx->ring, head, cqe) {
>   		if (cqe->user_data == 1)
> -			process_accept(ring, cqe);
> +			process_accept(ctx, cqe);
>   		else if (cqe->user_data == 2)
> -			process_recvzc(ring, cqe);
> +			process_recvzc(ctx, cqe);
>   		else
>   			error(1, 0, "unknown cqe");
>   		count++;
>   	}
> -	io_uring_cq_advance(ring, count);
> +	io_uring_cq_advance(&ctx->ring, count);
>   }
>   
>   static void run_server(void)
>   {
> +	struct thread_ctx ctx = {};
>   	unsigned int flags = 0;
> -	struct io_uring ring;
>   	int fd, enable, ret;
>   	uint64_t tstop;
>   
> @@ -356,22 +360,22 @@ static void run_server(void)
>   	flags |= IORING_SETUP_SUBMIT_ALL;
>   	flags |= IORING_SETUP_CQE32;
>   
> -	io_uring_queue_init(512, &ring, flags);
> +	io_uring_queue_init(512, &ctx.ring, flags);
>   
> -	setup_zcrx(&ring);
> +	setup_zcrx(&ctx);
>   	if (cfg_dry_run)
>   		return;
>   
>   	if (listen(fd, 1024) < 0)
>   		error(1, 0, "listen()");
>   
> -	add_accept(&ring, fd);
> +	add_accept(&ctx, fd);
>   
>   	tstop = gettimeofday_ms() + 5000;
> -	while (!stop && gettimeofday_ms() < tstop)
> -		server_loop(&ring);
> +	while (!ctx.stop && gettimeofday_ms() < tstop)
> +		server_loop(&ctx);
>   
> -	if (!stop)
> +	if (!ctx.stop)
>   		error(1, 0, "test failed\n");
>   }
>   

Reviewed-by: David Wei <dw@davidwei.uk>
