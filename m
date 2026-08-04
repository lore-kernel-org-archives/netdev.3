Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D5474263
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860828; cv=none; b=NVawKxih1F4Z/PjSJlRairCe6bn1mXVOuK+G19fBajL0s/VidmGOHu+yRn80XUh5b0YER2l8RaCX1q/BmOESZsQoCeplLarIv0guywjQwd+jo8RWHRwVCIxZk/nBGC7OhfD91+wUJ/+YUoY8QHEMMW5e5HsTH7zSnJ11azvosuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860828; c=relaxed/simple;
	bh=6nq9wg3ZlgWakpDv03xBSov9XPXM+5rO2amKO4hb/QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHP2cyfbVuXWrJZtC0yQnxVBl8UFa7gDwnBr+wmpZRPBhgnTzLqUHly3ECENbeuauhFv3J9QxgfBMG0qezZtXKX1NnzPtdcxRWzeq9WjL3UVtnR4F+X66M/8EQyhJwKPz8q8wPdzWotTx2i/YEixHk5ljht2Q5Zn8IWCp7lu/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gH07Ni6B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FzBcgoFL; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gH07Ni6B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FzBcgoFL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 3F119138016D;
	Tue,  4 Aug 2026 12:27:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 12:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785860826; x=1785868026; bh=EkjZtRvDtn
	m6mdVaZuCkwu6UOZpZ62jbro04w4BBT9M=; b=gH07Ni6BbJNLwOfPWorWH8bisE
	Lw8ZonIi5l3PRRGeZfsrLI00c/xwpeanMgycHyg+SCKdNNA0aAicsRzQZ/R2NpOG
	wfW8Yqn5/1QJwRJmeZTwEWU2fTG8Tr2Cz2MVRQbhuzmYKlR4cLGamvxlGnSkoBL0
	2hC6l4H3Z0muldPZIvcB1m1zkR3/mG3xQX/bLquL12f4Ucdto8X84vAuCFGM4Po/
	sNnBQnJw8rz8OgLH8cdq7+rSgJNKqc86ThQCqJ0etM+zK0S80kRP9AZOp80YKgc2
	fFc6KApUESUw790gzgf7p0yWG+J75csab8GmnJW/57c/yh6WC+No7/7DhoUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785860826; x=1785868026; bh=EkjZtRvDtnm6mdVaZuCkwu6UOZpZ62jbro0
	4w4BBT9M=; b=FzBcgoFL5+lO5IYG4SBW6WVmnB2dpGazVbhiMGARNLW+7HG3MdR
	t/gzUWUFz74lsM4GHVFH49cI5W1r1lN5cbe+c0huSNlUksSIWLu+KL7zikFVXMyd
	clD0kaMg3ghhZidq+JAlEqKmtAzoI51n+nXb7r3sEpMez1bLVqRW69VIvtcxzSyK
	DImsrvGcpLWK89K56wtUmpWH7rhDLCtnmXqaQtCbMeQ6nlnntP4qRAvc22Tru++u
	hcJN6HxIJeB4ec/FIIQ66cd1qYRo74k/naqk7gJ59US4aqV0Lrt5/FeIvky/K0oC
	qHdQAXqPabk010hntDUf+yTfno5Bk+Ec0Ww==
X-ME-Sender: <xms:2hJyalchAulRMF7Yto5C9VTsS1Nu06wXcuQwVkXQLDNUhOmNgYFHqg>
    <xme:2hJyaqFCPWkvOy33ssLXtOu1N7ZIhtqg799w4F8DLqi_0KQ8NL6ewczbU3QlCSJTg
    ZQp4hJPapR2_i-YdwTj787y5URQz9Nc0g6q9JT8WVw71UbTrITdVLw>
X-ME-Received: <xmr:2hJyam2XcIY3mQKdjzWSaHH14t1E7myHqi8RgZu1TI7_VFB47yHoOqtZnBefHjvwOQCzEF4wy7ocZbIjoBGcKOBI91FoiD8>
X-ME-Proxy-Cause: dmFkZTEGTPSaCUmwRn74Fyr8roSC20OVVsAzD2bH5sbpg0iFBBp3ePU8DYupnj+UJSztSG
    3wr1KiFiBNOWOMjJWGL6tYW7X1NKG/lmwOcFxxuZeaFdGkq7J7xP0t/xx2dCJqK3aGDaPI
    J+vyS6WcyO2ALjarsWZP378ZKpHAuXXrDpoMX9z8jvZMP3txrkobPJn+aZn9P50F2125y8
    XSZodc3ljv8oT4xuCpMk/k2qLBqq+iTRnbi2JKFMo7fvCmh1Czsfo5EQ0pcnnH9scuB/Lr
    n3mMfwl+S+gLk81jWebIrOdAzLJlsQW4+21R/vWAsjVfLuBu37UL53vV8EyTdBbTkKczks
    3JEFBM611wCmoejas+FRB74RGDaY4Sj4hHbdwcVMnIavo4pmNG6JEU72WURrFHRXRqhpMX
    JstFFyqMFopDSZ+dAgNuh/RRd/FGblabUM0Vp3VVbttmsjHyuCTi53OEj9b6VojHFJrvoe
    a1qwLVUFL2kXcALqz08Cz5kLweTyqle23Z02QBmhYl/Zk24kQLeJ1UoMPB+wQbS+2Fi/2c
    NrvckCUaZ5jSFS0iBCajXV0sJi52NHP0nIhX9d0w9YwR/SZVhCLf0HaTiZmccfA6dsiIHT
    EIsf+Sw68meguqaOlViYOfg4uQXmP5wWxP7IPsec6hMapeERUhDGq4ANN5tA
X-ME-Proxy: <xmx:2hJyaqmRGQqX_HvDVTl7kEzXUiBhYRS5SluydT2g3l5g5M8-bh2t-A>
    <xmx:2hJyau-XolCOHN5BYAEYSyLAwuMqKO64FNckK2BKcsPwDsjNIC1woQ>
    <xmx:2hJyanrEC8DOOYSQhNCp9fGwChBGM6UV4zTzP2wyOVCoPUNJzmcwIw>
    <xmx:2hJyavmLOZoydD5mdq7WXxHdkVQFaWfgDuiKyJxu9IWgzfru7EvFqA>
    <xmx:2hJyagMsZMlT-VHv1ib7sv1dGbGZ0uOAlo-gpWltMe4eactpvpfHay0A>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 12:27:05 -0400 (EDT)
Date: Tue, 4 Aug 2026 11:27:05 -0500
From: Juanlu Herrero <juanlu@fastmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v4 5/6] selftests: net: add multithread server
 support to iou-zcrx
Message-ID: <anISNwUQeVl1YNwn@jlhe0197-mac>
References: <20260729221825.42773-1-juanlu@fastmail.com>
 <20260729221825.42773-6-juanlu@fastmail.com>
 <812e3fc9-c8dd-4d9e-93c6-585597422718@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812e3fc9-c8dd-4d9e-93c6-585597422718@redhat.com>

On Tue, Aug 04, 2026 at 12:42:41PM -0600, Paolo Abeni wrote:
> 
> 
> On 7/30/26 12:18 AM, Juanlu Herrero wrote:
> > Run the iou-zcrx server as N worker threads, each owning one receive
> > queue with its own io_uring and zero-copy receive (zcrx) ifq, so the
> > test can exercise multi-queue zero-copy receive.
> > 
> > The main thread owns the listening socket, accepts connections, and
> > dispatches each to the worker owning the queue it landed on by matching
> > SO_INCOMING_NAPI_ID against per-queue NAPI IDs.
> > 
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> > ---
> >  .../testing/selftests/drivers/net/hw/Makefile |   5 +-
> >  .../selftests/drivers/net/hw/iou-zcrx.c       | 290 ++++++++++++++----
> >  2 files changed, 226 insertions(+), 69 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index 3cab3b4adbb2e..035581b58bc66 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -13,10 +13,6 @@ else
> >  $(warning excluding iouring tests, liburing not installed or too old)
> >  endif
> >  
> > -TEST_GEN_FILES := \
> > -	$(COND_GEN_FILES) \
> > -# end of TEST_GEN_FILES
> > -
> >  TEST_PROGS = \
> >  	csum.py \
> >  	devlink_port_split.py \
> > @@ -71,6 +67,7 @@ TEST_INCLUDES := \
> >  YNL_GEN_FILES := \
> >  	ncdevmem \
> >  	toeplitz \
> > +	$(COND_GEN_FILES) \
> >  # end of YNL_GEN_FILES
> >  TEST_GEN_FILES += $(YNL_GEN_FILES)
> >  TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
> > diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > index 7bc61f3b70ca6..16259129df46d 100644
> > --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > @@ -27,6 +27,7 @@
> >  #include <netinet/tcp.h>
> >  #include <netinet/udp.h>
> >  #include <sys/epoll.h>
> > +#include <sys/eventfd.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/mman.h>
> >  #include <sys/resource.h>
> > @@ -38,6 +39,8 @@
> >  #include <sys/wait.h>
> >  
> >  #include <liburing.h>
> > +#include <ynl.h>
> > +#include "netdev-user.h"
> >  
> >  #define SKIP_CODE	42
> >  
> > @@ -91,6 +94,7 @@ static int cfg_num_threads = 1;
> >  static char *payload;
> >  
> >  #define CONNS_PER_THREAD	4
> > +#define MAX_CONNS_PER_THREAD	64
> >  
> >  struct thread_ctx {
> >  	struct io_uring		ring;
> > @@ -99,9 +103,14 @@ struct thread_ctx {
> >  	size_t			ring_size;
> >  	struct io_uring_zcrx_rq	rq_ring;
> >  	unsigned long		area_token;
> > -	int			connfd;
> > -	bool			stop;
> > -	size_t			received;
> > +	int			queue_id;
> > +	int			napi_id;
> > +	int			ready_fd;
> > +	int			start_fd;
> > +
> > +	int			connfds[MAX_CONNS_PER_THREAD];
> > +	size_t			received[MAX_CONNS_PER_THREAD];
> > +	int			nr_conns;
> >  };
> >  
> >  static unsigned long gettimeofday_ms(void)
> > @@ -201,7 +210,7 @@ static void setup_zcrx(struct thread_ctx *ctx)
> >  
> >  	struct t_io_uring_zcrx_ifq_reg reg = {
> >  		.if_idx = ifindex,
> > -		.if_rxq = cfg_queue_id,
> > +		.if_rxq = ctx->queue_id,
> >  		.rq_entries = rq_entries,
> >  		.area_ptr = (__u64)(unsigned long)&area_reg,
> >  		.region_ptr = (__u64)(unsigned long)&region_reg,
> > @@ -226,53 +235,32 @@ static void setup_zcrx(struct thread_ctx *ctx)
> >  	ctx->area_token = area_reg.rq_area_token;
> >  }
> >  
> > -static void add_accept(struct thread_ctx *ctx, int sockfd)
> > +static void add_recvzc(struct thread_ctx *ctx, int conn_idx)
> >  {
> >  	struct io_uring_sqe *sqe;
> >  
> >  	sqe = io_uring_get_sqe(&ctx->ring);
> >  
> > -	io_uring_prep_accept(sqe, sockfd, NULL, NULL, 0);
> > -	sqe->user_data = 1;
> > -}
> > -
> > -static void add_recvzc(struct thread_ctx *ctx, int sockfd)
> > -{
> > -	struct io_uring_sqe *sqe;
> > -
> > -	sqe = io_uring_get_sqe(&ctx->ring);
> > -
> > -	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, 0, 0);
> > +	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
> > +			 NULL, 0, 0);
> >  	sqe->ioprio |= IORING_RECV_MULTISHOT;
> > -	sqe->user_data = 2;
> > +	sqe->user_data = conn_idx;
> >  }
> >  
> > -static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
> > +static void add_recvzc_oneshot(struct thread_ctx *ctx, int conn_idx, size_t len)
> >  {
> >  	struct io_uring_sqe *sqe;
> >  
> >  	sqe = io_uring_get_sqe(&ctx->ring);
> >  
> > -	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
> > +	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
> > +			 NULL, len, 0);
> >  	sqe->ioprio |= IORING_RECV_MULTISHOT;
> > -	sqe->user_data = 2;
> > +	sqe->user_data = conn_idx;
> >  }
> >  
> > -static void process_accept(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
> > -{
> > -	if (cqe->res < 0)
> > -		error(1, 0, "accept()");
> > -	if (ctx->connfd)
> > -		error(1, 0, "Unexpected second connection");
> > -
> > -	ctx->connfd = cqe->res;
> > -	if (cfg_oneshot)
> > -		add_recvzc_oneshot(ctx, ctx->connfd, page_size);
> > -	else
> > -		add_recvzc(ctx, ctx->connfd);
> > -}
> > -
> > -static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
> > +static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe,
> > +			   int conn_idx)
> >  {
> >  	unsigned int rq_mask = ctx->rq_ring.ring_entries - 1;
> >  	struct io_uring_zcrx_cqe *rcqe;
> > @@ -283,7 +271,7 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
> >  	int i;
> >  
> >  	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
> > -		ctx->stop = true;
> > +		ctx->nr_conns--;
> >  		return;
> >  	}
> >  
> > @@ -292,11 +280,11 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
> >  
> >  	if (cfg_oneshot) {
> >  		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
> > -			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
> > +			add_recvzc_oneshot(ctx, conn_idx, page_size);
> >  			cfg_oneshot_recvs--;
> 
> Sashiko noted that the above update is now racy in multithread tests:
> 
> https://sashiko.dev/#/patchset/20260729221825.42773-1-juanlu%40fastmail.com
> 
> Also please respect the reverse christmas tree order consistently.
> 
> /P
>

I will look into the potential race and fix the reverse christmas tree
ordering in v5. Thanks for the review

Best,
Juanlu
