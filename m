Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C001344C66D
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840181; cv=none; b=StOPQy15AK1IZKM7hxwiwJUMcfPcmQJzIQPE6UNxpBdoOllKjWLJZXEstsIBk4ldbKg4QCo+SnE4TgW+1VFLkmRFbBJpZZ+XTNQbXkb2vRs10JM9l65/0cKCbGMg3Gu4ARW6tyCtl5v6tnzFSfAjzSULE2Ea+dCZtF9U1TXhfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840181; c=relaxed/simple;
	bh=iCyyqpVbxs5j5Sd7VeLtNzrj4NGJms101Q4ZO3XFAtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBMsAd/ZiLQWe8IkUEsbRSpmegmKG3SkixF7tbaV0BOuQrtWyjcL6FJyqqhVB987e+3C8hY9dloRzQYPtn8Fh8EDL0uMoLrCnWaSrNVDrN9g8w5wN7zirSTqqE4TiZ1F4ROtS0s+Y1QetGaeYHL2M8UDL1CEkjCRKLjxJWbsuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJrbku2F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZgaU8O5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJrbku2F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZgaU8O5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785840176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN2+b+sEyPisGwyTmsQztTYLHAnHe44B4co/nKSeUyw=;
	b=dJrbku2FwxBbloOzC8hKAzUqsi0U9ke6x18OSB8m8HcxWVEqzvslI3jrkYwkw7bLusVIgq
	Z4jubOJAH9upPkSUouO743YWoMlQu6zXoWQpz+IOSEiBYGN6M6+2XfyhEjkBnHCq68Q1V0
	G2W4PxsRVUUBv7dsz3uSh4FAO1//6oE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-s9TzkWxQP3a9S8PFU3rdHQ-1; Tue, 04 Aug 2026 06:42:45 -0400
X-MC-Unique: s9TzkWxQP3a9S8PFU3rdHQ-1
X-Mimecast-MFC-AGG-ID: s9TzkWxQP3a9S8PFU3rdHQ_1785840164
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so20524785e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785840164; x=1786444964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KN2+b+sEyPisGwyTmsQztTYLHAnHe44B4co/nKSeUyw=;
        b=NZgaU8O5k1HpwsIZBjvfphNxcyMyssc6WiboQ6vvKjk9ZXlArouPSIssmB+B7mhBlx
         LPj9qEuL1PjKMVrPe/lJ8VOlT0GlAPK38Z6MACQKXHN+BW4iiYVsonddD2Xy9YLzgHOo
         zViaBxH4xT525y3SlmHXgjn4+dWJHaoQXVZx6d9tx0LhSQpK4DaHr9xSNVBaJf15CzlT
         KFrTRG59MW2lyUFWcy1dAcJ/0lYSkOFHsqHT0cGEwyHZoLKTiauuCvlEMt5ikliPPoRN
         CPrDUKWbiUIwN5c+eC/bqbeH9ilRmvtrOoZG7LsI6LPyO8Z44FsUzFT0sEsWrYL3vXrq
         G+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785840164; x=1786444964;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KN2+b+sEyPisGwyTmsQztTYLHAnHe44B4co/nKSeUyw=;
        b=Km09S6Dz0i4fVfIkIx8uJEskx3jSZ0bK+6i1gp0401P9ohatgiyXazU83wHfivnYGS
         iTxTlEIPMIIyntq2Awx76BuYvRU4PQA4FbvPUQ9OvlfxEOG3UbIyZCOb9A+A1JH00NXk
         cdDBmKIBRYpwa8KbJ77gdwOtOqwWJ3rM7txidYHoR0C6tQaKmdUNN6YeqzJAt05KDubm
         PCGgVZuobH3GbYIw+vvzXxUn8Vcpk8+Qkg6nIiTSoo+d6HsIIp8DHWZT7Mt0W4w/0edy
         kZ9+CaM1uEQtgCITU0Bvb2NJP5454WBP4NLyzYs5xLIU6aHSq/OYOlQHnAZ8qJ0sxce+
         Ruug==
X-Forwarded-Encrypted: i=1; AHgh+RpEiylIHw/80AISo2XD8lfX5Uj6AyHvrtrkVS2KIBgcr9YD0yk27xpU+fYy1QgKJHsscVyHc08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDPD/8sfVQzPO84nkVhdFjcrvS30uWCIRcw43gkgSA9a/hsmk
	EtT+aLVwcyjAim1A3NgMLMwTU08Dp/ZWctK+jjzkS/xhpnh8In7iTqYSd6Cjops4Fjh2LjSJu45
	LezND09vrdMagNGDfbeI5HYqwJUfehElSAU3xgfDFin8sLD7LS1HaIk5d6i4K/8EKwQ==
X-Gm-Gg: AR+sD136JPFKZTw3m+5ToRbzJz6tQ3BW+waR/zSqJaYNVHlLCrSREpfSTXJIVDqhoF5
	bRp0/AvbwyM8kcjnDS7j6CHP24esdjIdqKbo9u+fs0XvxpNJGj9cIBzZ5eV9WawDR2p/DUZzVdW
	2QzUNDVXTTvFe4MdzUQ59K6icp6xJkIgxJvixFjoQMi1RDmrvV2xFCGBwm5QeSo8jrkibzGogtt
	h2oqSL0ZZk6b3FiO7ZOmzu+IL4Knnx+D4rS1i6jxropWPF9YIGycEU6b5xRunbJZ9JYd8SFuvf7
	unr+sZfupAx8biWxewZWsNrM6xWRMN9VDpAG8vPbcS9mYXm/UITRMKJynAjRDbrSmqjjTTkfwzb
	2T/GYbM5lFT9Q/kd9kFztDCGt0dLYc4Agp38GysKncdjbHw2NrZS4fIaqdADZo0RKM1CkkNyL6T
	A=
X-Received: by 2002:a05:600c:871a:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4980c66c991mr370118965e9.8.1785840164076;
        Tue, 04 Aug 2026 03:42:44 -0700 (PDT)
X-Received: by 2002:a05:600c:871a:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4980c66c991mr370117995e9.8.1785840163627;
        Tue, 04 Aug 2026 03:42:43 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc6d82sm79769135e9.1.2026.08.04.03.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 03:42:42 -0700 (PDT)
Message-ID: <812e3fc9-c8dd-4d9e-93c6-585597422718@redhat.com>
Date: Tue, 4 Aug 2026 12:42:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] selftests: net: add multithread server
 support to iou-zcrx
To: Juanlu Herrero <juanlu@fastmail.com>, David Wei <dw@davidwei.uk>,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
References: <20260729221825.42773-1-juanlu@fastmail.com>
 <20260729221825.42773-6-juanlu@fastmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260729221825.42773-6-juanlu@fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/26 12:18 AM, Juanlu Herrero wrote:
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
>  .../testing/selftests/drivers/net/hw/Makefile |   5 +-
>  .../selftests/drivers/net/hw/iou-zcrx.c       | 290 ++++++++++++++----
>  2 files changed, 226 insertions(+), 69 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 3cab3b4adbb2e..035581b58bc66 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -13,10 +13,6 @@ else
>  $(warning excluding iouring tests, liburing not installed or too old)
>  endif
>  
> -TEST_GEN_FILES := \
> -	$(COND_GEN_FILES) \
> -# end of TEST_GEN_FILES
> -
>  TEST_PROGS = \
>  	csum.py \
>  	devlink_port_split.py \
> @@ -71,6 +67,7 @@ TEST_INCLUDES := \
>  YNL_GEN_FILES := \
>  	ncdevmem \
>  	toeplitz \
> +	$(COND_GEN_FILES) \
>  # end of YNL_GEN_FILES
>  TEST_GEN_FILES += $(YNL_GEN_FILES)
>  TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index 7bc61f3b70ca6..16259129df46d 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> @@ -27,6 +27,7 @@
>  #include <netinet/tcp.h>
>  #include <netinet/udp.h>
>  #include <sys/epoll.h>
> +#include <sys/eventfd.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <sys/resource.h>
> @@ -38,6 +39,8 @@
>  #include <sys/wait.h>
>  
>  #include <liburing.h>
> +#include <ynl.h>
> +#include "netdev-user.h"
>  
>  #define SKIP_CODE	42
>  
> @@ -91,6 +94,7 @@ static int cfg_num_threads = 1;
>  static char *payload;
>  
>  #define CONNS_PER_THREAD	4
> +#define MAX_CONNS_PER_THREAD	64
>  
>  struct thread_ctx {
>  	struct io_uring		ring;
> @@ -99,9 +103,14 @@ struct thread_ctx {
>  	size_t			ring_size;
>  	struct io_uring_zcrx_rq	rq_ring;
>  	unsigned long		area_token;
> -	int			connfd;
> -	bool			stop;
> -	size_t			received;
> +	int			queue_id;
> +	int			napi_id;
> +	int			ready_fd;
> +	int			start_fd;
> +
> +	int			connfds[MAX_CONNS_PER_THREAD];
> +	size_t			received[MAX_CONNS_PER_THREAD];
> +	int			nr_conns;
>  };
>  
>  static unsigned long gettimeofday_ms(void)
> @@ -201,7 +210,7 @@ static void setup_zcrx(struct thread_ctx *ctx)
>  
>  	struct t_io_uring_zcrx_ifq_reg reg = {
>  		.if_idx = ifindex,
> -		.if_rxq = cfg_queue_id,
> +		.if_rxq = ctx->queue_id,
>  		.rq_entries = rq_entries,
>  		.area_ptr = (__u64)(unsigned long)&area_reg,
>  		.region_ptr = (__u64)(unsigned long)&region_reg,
> @@ -226,53 +235,32 @@ static void setup_zcrx(struct thread_ctx *ctx)
>  	ctx->area_token = area_reg.rq_area_token;
>  }
>  
> -static void add_accept(struct thread_ctx *ctx, int sockfd)
> +static void add_recvzc(struct thread_ctx *ctx, int conn_idx)
>  {
>  	struct io_uring_sqe *sqe;
>  
>  	sqe = io_uring_get_sqe(&ctx->ring);
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
>  	sqe->ioprio |= IORING_RECV_MULTISHOT;
> -	sqe->user_data = 2;
> +	sqe->user_data = conn_idx;
>  }
>  
> -static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
> +static void add_recvzc_oneshot(struct thread_ctx *ctx, int conn_idx, size_t len)
>  {
>  	struct io_uring_sqe *sqe;
>  
>  	sqe = io_uring_get_sqe(&ctx->ring);
>  
> -	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
> +	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
> +			 NULL, len, 0);
>  	sqe->ioprio |= IORING_RECV_MULTISHOT;
> -	sqe->user_data = 2;
> +	sqe->user_data = conn_idx;
>  }
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
>  {
>  	unsigned int rq_mask = ctx->rq_ring.ring_entries - 1;
>  	struct io_uring_zcrx_cqe *rcqe;
> @@ -283,7 +271,7 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
>  	int i;
>  
>  	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
> -		ctx->stop = true;
> +		ctx->nr_conns--;
>  		return;
>  	}
>  
> @@ -292,11 +280,11 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
>  
>  	if (cfg_oneshot) {
>  		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
> -			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
> +			add_recvzc_oneshot(ctx, conn_idx, page_size);
>  			cfg_oneshot_recvs--;

Sashiko noted that the above update is now racy in multithread tests:

https://sashiko.dev/#/patchset/20260729221825.42773-1-juanlu%40fastmail.com

Also please respect the reverse christmas tree order consistently.

/P

