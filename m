Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5944BC005
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873285; cv=none; b=pbHGH1Us7YdkH4xGPrhdkTSa2BpoDBsxuDBeikvwfpiSInrxMoIDe944H9j2fRqy4qQ3Fd07q6aFYo+1V+j6B0VdHs1i7z8V1k8LdtlT43A9ydRxDM1SNG1X43hWXGDRVOz0evWRGak0XAOvfA9hPtjzMuE4PmVtX8HzeT0JraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873285; c=relaxed/simple;
	bh=jjz/OpZVihg/Kx5nQcLIoclbGSq+IMlWBjuoAw0mQto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRxMpJvEDhe2NCh7NH2CcudLdDis9aHCari5RMxR85sYwDwof0F03A1P6jDGJnXInl3Br/fNW7VbwSpwLWf6ESh70/1cKlKSqPTkonk6Rgy6Jf7dEtL0n6xWq8U81pKQcgJybFZ4307LWxSuAA9910r17VmT2ZIX7kS6QdZcYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LE+ltHLe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxhlZyYO; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LE+ltHLe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxhlZyYO"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id E823813807D7;
	Tue,  4 Aug 2026 15:54:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 04 Aug 2026 15:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785873280; x=1785880480; bh=uK15SfGgE8
	1xP0k+WHiZihgEXFHXW9Iy5DtdNNjYheQ=; b=LE+ltHLebFdBW3aZksf5r+Pcs7
	mxE2cZNqOsdVfQ0KmerTdQ23w6slKP74JojSd1nu7P2+oL0BZhxVVw8M4gkKL0dN
	TJEs9ntR1RA5p9NLfzWqhHKkpj7ndkv51287279xOdsFhp7Ylxr5zh98PotuzZnm
	P7j3JFlrY2tG+99J9LX3dRK7+zYqZQCtXL+OLNPxP7YwYgZod9bLDLW8JAoRfmom
	j72o40gqSpthb0063pcUuZQ3Wf8Av3VgZ28zKvTpE7d2GiDKTMfXPrOSDWXCOoMO
	BR+ixqZtL3MPwg9Xx8oPAEUTldGBZiXp6zkQwJrlRVcTaqpZERwZ9IUHgutw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785873280; x=1785880480; bh=uK15SfGgE81xP0k+WHiZihgEXFHXW9Iy5Dt
	dNNjYheQ=; b=KxhlZyYO6DW5SwEK+NXut3QvBqlw/mlp3rdwWxaWG0LDDvBz3qK
	zEaA8zbEAv7rSQmDDHMlRffOUvFGvkAXXS+V/VpHHPD5NcQ2c9ZPQXhTeOzJJV5A
	PR0ecxAdP/w+IbnVSbO94Ovc67UYRPuhkAdZFmy5azRkE1/l4ICSPbBJP8CjCxyi
	4bR2r7ZRn+I6p1bLXiy99yEuK1Vm31MS7UYmfe7i+fj0eg8PCLW5oct8mk7kV3Af
	FHLSIVbkf43sV2yyfMdpNgkGU6PsKWPB4+/wm8RFpq/DM11ckQwSmOfDWqyavpLP
	CzW7AUY0GWg51KBJsvy5UiH5mSQZUA0hM8g==
X-ME-Sender: <xms:gENyar9XHbAB-x5ayfdbq8zRm8h-eM2zlFyxRq_HOneuPb3bH2-bTA>
    <xme:gENyauu2lkK3lg8pHgRLNP45n0iJDtzeLpbe4s8RZvsVyrIjXK9-C3Pws6wEsnKEN
    FxwvVPpATP2-rA7RW-3xKEZjZZxVrV_iAQ74VWAMlyIup7cTIhtCC-->
X-ME-Received: <xmr:gENyauAREZsnvkthvEqvDGQmWHMB-54TUbWEYr6uYvtzNwie97fZSzxebtzjNU1HB1d80NAE4bO9dNDUj-ibeS166tVc7uo>
X-ME-Proxy-Cause: dmFkZTFRC3nJj5irZdakI7/ou0n7rUcZ7wNiy3QaApK785pVFR2MCMqkMmcxRFVI3/wcJp
    YF6XBJtQni7DvTReo2NlA51dj6cw9Mx0HPE4iymsQYtXDrqFeNDTSDJi2wO0BGT+hAAe9Y
    AYGsnOIgnRIhd1HkUbH7gIaG0wtuMTL7yZzczDg+IO8Mwlhi3OGTC4PvXtfuxZ/oKer0gQ
    cDLqB56s2FZ5TPFRU0NFy701uQgmgPQf3yAp6aLXNIz7iYrYvyLLQfeAkUTgROXw+H4Oew
    iLDDu6S8TfzJ0gy8GPHJEEiZYngBTQSzY7kAiZ/jWmWMzPAdsj+sESYp7kbJShAgQJoAH1
    AVyVesl/dlYmtvBIpgUsqJ/yrVr7GXAuizVk8uMFofw7gHXiRqSXOu11rIxW0T8O1kvX/O
    3SRHi0WlQXpfm5BP+S95g1TSYMhMMO7CZsDA9lUqCyt/olIsw4vG1XPAJbpk6hFSyc5rfa
    s885qfE+UDGGWjdH4NB2Y8wNYtrZ/pvzjEEAQnf8vT8mhu9Ydu1QLBAQwO9Q3pVzE1Gb4c
    YkdYAGoc+QmOsxEw0BhUCyzuO9xbufous6Y2SzfPVOJMhr04tNrQv2PcU8GdHhcEDm+x8s
    p6NzZPSoW6GuAPMTA/BnH6xi/6VIJbcXjmrnPOIMHcWv8N6UE7DbemeQksVA
X-ME-Proxy: <xmx:gENyamXq8--Jwm0PVfQ_-fBOHsj-4p3jmsMNewHHl4ZCkSIg8tseWQ>
    <xmx:gENyasDAzqeGjACTeuUZPG4HuZFh7CNUEyDF0wU2CBqNVVEYf9Jj6A>
    <xmx:gENyap_fyrOXrfOL-KIS6WU6RWbZw51FskIs4t95A6rG7Pwqaj4HcA>
    <xmx:gENyajEkyWKjPtBgYh7HP5cBcavxb5K-bhcZ9XjG3WeoZm5fArnitw>
    <xmx:gENyambmeI6OFJpryASVR6VYsZjq-tCohJZDSok9VMJtu1AidF0TXpZf>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 15:54:40 -0400 (EDT)
Date: Tue, 4 Aug 2026 14:54:39 -0500
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v4 5/6] selftests: net: add multithread server
 support to iou-zcrx
Message-ID: <anJDFTKOcncNQUeL@jlhe0197-mac>
References: <20260729221825.42773-1-juanlu@fastmail.com>
 <20260729221825.42773-6-juanlu@fastmail.com>
 <461c426a-8690-4a3a-b9bc-1429c5e1dfd2@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461c426a-8690-4a3a-b9bc-1429c5e1dfd2@davidwei.uk>

On Tue, Aug 04, 2026 at 09:45:05AM -0600, David Wei wrote:
> On 2026-07-29 15:18, Juanlu Herrero wrote:
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
> >   .../testing/selftests/drivers/net/hw/Makefile |   5 +-
> >   .../selftests/drivers/net/hw/iou-zcrx.c       | 290 ++++++++++++++----
> >   2 files changed, 226 insertions(+), 69 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > index 7bc61f3b70ca6..16259129df46d 100644
> > --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> [...]
> > @@ -322,28 +310,124 @@ static void server_loop(struct thread_ctx *ctx)
> >   	struct io_uring_cqe *cqe;
> >   	unsigned int count = 0;
> >   	unsigned int head;
> > -	int i, ret;
> >   	io_uring_submit_and_wait(&ctx->ring, 1);
> >   	io_uring_for_each_cqe(&ctx->ring, head, cqe) {
> > -		if (cqe->user_data == 1)
> > -			process_accept(ctx, cqe);
> > -		else if (cqe->user_data == 2)
> > -			process_recvzc(ctx, cqe);
> > -		else
> > -			error(1, 0, "unknown cqe");
> > +		process_recvzc(ctx, cqe, cqe->user_data);
> >   		count++;
> >   	}
> >   	io_uring_cq_advance(&ctx->ring, count);
> >   }
> > -static void run_server(void)
> > +static void *server_worker(void *arg)
> >   {
> > -	struct thread_ctx ctx = {};
> > -	unsigned int flags = 0;
> > -	int fd, enable, ret;
> > +	struct thread_ctx *ctx = arg;
> > +	struct io_uring_params params = { };
> 
> Reverse christmas tree.
> 
> >   	uint64_t tstop;
> > +	int i;
> > +
> > +	params.flags |= IORING_SETUP_COOP_TASKRUN;
> > +	params.flags |= IORING_SETUP_SINGLE_ISSUER;
> > +	params.flags |= IORING_SETUP_DEFER_TASKRUN;
> > +	params.flags |= IORING_SETUP_SUBMIT_ALL;
> > +	params.flags |= IORING_SETUP_CQE32;
> > +	params.flags |= IORING_SETUP_CQSIZE;
> > +	params.cq_entries = AREA_SIZE / page_size;
> > +
> > +	io_uring_queue_init_params(512, &ctx->ring, &params);
> > +	setup_zcrx(ctx);
> > +
> > +	if (cfg_dry_run)
> > +		return NULL;
> > +
> > +	{
> > +		uint64_t val = 1;
> > +
> > +		if (write(ctx->ready_fd, &val, sizeof(val)) != sizeof(val))
> > +			error(1, errno, "write(ready_fd)");
> > +		if (read(ctx->start_fd, &val, sizeof(val)) != sizeof(val))
> > +			error(1, errno, "read(start_fd)");
> 
> A pthread_barrier_t is more idiomatic and you can get rid of the epollfd
> in main thread entirely.
> 
> > +	}
> > +
> > +	for (i = 0; i < ctx->nr_conns; i++) {
> > +		if (cfg_oneshot)
> > +			add_recvzc_oneshot(ctx, i, page_size);
> > +		else
> > +			add_recvzc(ctx, i);
> > +	}
> > +
> > +	tstop = gettimeofday_ms() + 5000;
> > +	while (ctx->nr_conns > 0 && gettimeofday_ms() < tstop)
> > +		server_loop(ctx);
> > +
> > +	if (ctx->nr_conns != 0)
> > +		error(1, 0, "test failed: %d connections incomplete",
> > +		      ctx->nr_conns);
> > +
> > +	return NULL;
> > +}
> > +
> > +static int query_napi_id(unsigned int ifindex, int queue_id)
> > +{
> > +	struct netdev_queue_get_req *req;
> > +	struct netdev_queue_get_rsp *rsp;
> > +	struct ynl_error yerr;
> > +	struct ynl_sock *ys;
> > +	int napi_id;
> > +
> > +	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> > +	if (!ys)
> > +		error(1, 0, "ynl_sock_create: %s", yerr.msg);
> > +
> > +	req = netdev_queue_get_req_alloc();
> > +	netdev_queue_get_req_set_ifindex(req, ifindex);
> > +	netdev_queue_get_req_set_type(req, NETDEV_QUEUE_TYPE_RX);
> > +	netdev_queue_get_req_set_id(req, queue_id);
> > +
> > +	rsp = netdev_queue_get(ys, req);
> > +	if (!rsp)
> > +		error(1, 0, "netdev_queue_get(q=%d): %s", queue_id,
> > +		      ys->err.msg);
> > +	if (!rsp->_present.napi_id)
> > +		error(1, 0, "netdev_queue_get(q=%d): napi_id not present",
> > +		      queue_id);
> > +
> > +	napi_id = rsp->napi_id;
> > +
> > +	netdev_queue_get_req_free(req);
> > +	netdev_queue_get_rsp_free(rsp);
> > +	ynl_sock_destroy(ys);
> > +
> > +	return napi_id;
> > +}
> > +
> > +static int find_thread_by_napi(struct thread_ctx *ctxs, int napi_id)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < cfg_num_threads; i++) {
> > +		if (ctxs[i].napi_id == napi_id)
> > +			return i;
> > +	}
> > +	return -1;
> > +}
> > +
> > +static void run_server(void)
> > +{
> > +	struct thread_ctx *ctxs;
> > +	struct epoll_event ev, out_ev;
> > +	pthread_t *threads;
> > +	unsigned int ifindex;
> > +	int conns_per_thread, total_conns, accepted = 0, connfd;
> > +	int fd, ret, enable, i;
> > +	int epfd, ready = 0;
> > +	uint64_t val;
> 
> Reverse christmas tree.
> 
> > +
> > +	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
> > +	threads = calloc(cfg_num_threads, sizeof(*threads));
> > +	if (!ctxs || !threads)
> > +		error(1, 0, "calloc()");
> >   	fd = socket(AF_INET6, SOCK_STREAM, 0);
> >   	if (fd == -1)
> > @@ -358,29 +442,105 @@ static void run_server(void)
> >   	if (ret < 0)
> >   		error(1, 0, "bind()");
> > -	flags |= IORING_SETUP_COOP_TASKRUN;
> > -	flags |= IORING_SETUP_SINGLE_ISSUER;
> > -	flags |= IORING_SETUP_DEFER_TASKRUN;
> > -	flags |= IORING_SETUP_SUBMIT_ALL;
> > -	flags |= IORING_SETUP_CQE32;
> > +	for (i = 0; i < cfg_num_threads; i++) {
> > +		ctxs[i].queue_id = cfg_queue_id + i;
> > +		ctxs[i].ready_fd = eventfd(0, 0);
> > +		ctxs[i].start_fd = eventfd(0, 0);
> > +	}
> > -	io_uring_queue_init(512, &ctx.ring, flags);
> > +	for (i = 0; i < cfg_num_threads; i++) {
> > +		ret = pthread_create(&threads[i], NULL,
> > +				     server_worker, &ctxs[i]);
> > +		if (ret)
> > +			error(1, ret, "pthread_create()");
> > +	}
> > -	setup_zcrx(&ctx);
> >   	if (cfg_dry_run)
> > -		return;
> > +		goto join;
> >   	if (listen(fd, 1024) < 0)
> >   		error(1, 0, "listen()");
> > -	add_accept(&ctx, fd);
> > +	epfd = epoll_create1(0);
> > +	if (epfd < 0)
> > +		error(1, errno, "epoll_create1()");
> > -	tstop = gettimeofday_ms() + 5000;
> > -	while (!ctx.stop && gettimeofday_ms() < tstop)
> > -		server_loop(&ctx);
> > +	for (i = 0; i < cfg_num_threads; i++) {
> > +		ev.events = EPOLLIN;
> > +		ev.data.fd = ctxs[i].ready_fd;
> > +		if (epoll_ctl(epfd, EPOLL_CTL_ADD,
> > +			      ctxs[i].ready_fd, &ev) < 0)
> > +			error(1, errno, "epoll_ctl()");
> > +	}
> > +
> > +	while (ready < cfg_num_threads) {
> > +		if (epoll_wait(epfd, &out_ev, 1, -1) < 0)
> > +			error(1, errno, "epoll_wait()");
> > +		if (read(out_ev.data.fd, &val, sizeof(val)) != sizeof(val))
> > +			error(1, errno, "read(ready_fd)");
> > +		ready++;
> > +	}
> > +
> > +	close(epfd);
> 
> All this can go if using a barrier.
> 
> > +
> > +	if (cfg_num_threads > 1) {
> > +		ifindex = if_nametoindex(cfg_ifname);
> > +		if (!ifindex)
> > +			error(1, 0, "bad interface name: %s", cfg_ifname);
> > +		for (i = 0; i < cfg_num_threads; i++)
> > +			ctxs[i].napi_id = query_napi_id(ifindex,
> > +							ctxs[i].queue_id);
> > +	}
> > +
> > +	conns_per_thread = cfg_num_threads > 1 ? CONNS_PER_THREAD : 1;
> > +	total_conns = conns_per_thread * cfg_num_threads;
> > +
> > +	while (accepted < total_conns) {
> > +		int idx;
> > +
> > +		connfd = accept(fd, NULL, NULL);
> > +		if (connfd < 0)
> > +			error(1, errno, "accept()");
> > +
> > +		if (cfg_num_threads > 1) {
> > +			int napi_id;
> > +			socklen_t len = sizeof(napi_id);
> > +
> > +			ret = getsockopt(connfd, SOL_SOCKET,
> > +					 SO_INCOMING_NAPI_ID,
> > +					 &napi_id, &len);
> > +			if (ret < 0)
> > +				error(1, errno,
> > +				      "getsockopt(SO_INCOMING_NAPI_ID)");
> > +
> > +			idx = find_thread_by_napi(ctxs, napi_id);
> 
> Make the helper take in a connfd and return the index directly.
> 
> > +			if (idx < 0)
> > +				error(1, 0, "unknown NAPI ID: %d",
> > +				      napi_id);
> > +		} else {
> > +			idx = 0;
> 
> Don't need the else, init idx to 0.

I will make these fixes in v5 of this patchset. Thanks for the review.

Best,
Juanlu
