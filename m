Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039936;
	b=NJeAWjMQJzR7/P4SuLYuTAeAydd5nnS9ex4EZeVkEgXamWZuR3Re6SOeeAWs7p2K3wz2
	 JDHNBvf6TcGvi/mCrSQU9Awyc5YnA65CN0XfyrdDWAvAWPJshm3tY33WZOl3nLhQwY9iq
	 sjhUL8SAFka7Gh1Dd0k6WaG13qY3AXhuGfRzrTn3d2YzRnz/AZ7pg7SJgD2hVzct2S4WU
	 60hs319Ue+4ToV7KfCMNCBGssGN1X2XMcpTTWOTkPSZ9s9RPi8dfC+D8RAUTO2HHr2toq
	 J44590su637MfTjAswrgnkoFYE5Ell7txz2ba07VDULCICK//EVfCxyoleoRWNZsrzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039936;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=wuSXNxDCgx+fhMLuKC4fCXfgbDgFI2GvFydwF67bIko=;
	b=gQfuYxclvBw1ZolduH0kVoRnyLTI2AO1FxSlw9kZXtqZ/OUUdxUzkjBELRXSSxw8drCg
	 hJ6Mzs0jIpBm1/ejfA8atAcXWwwqHqX0zIcmQjGXPd8okM91m2UC5Vl1KRcgJpc/0QvXx
	 pdh9p79jUIfRdc682UVufD8zqogI+0WgjnNnLV50z1MInujmLqxOohkFMluK47gT8dwyM
	 y+j8JvVNGSJHrj7Fcjy8htwh5O4ZuyiunPhj+cGtR48rKDpnPtqL/ezCG4ei2dzya+LIr
	 Yu927zxu0M3hz4NScQQz85Y38AMB9oEQ4UtpVyoyA3+ZeZc+LSdc2yzdx2YdsjwCNOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Y40ejyTm;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8B606A32C;
	Sat,  7 Nov 2026 08:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D8B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Y40ejyTm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wu
	SXNxDCgx+fhMLuKC4fCXfgbDgFI2GvFydwF67bIko=; b=Y40ejyTmBmaKZgyho/
	7NXa8Lzk6lvsftRicV6lG6efv0ieB3d5u/5KP3qwgJvHUBsDyorwVk/qsNhOj3es
	BHPyWW7G8s+6lJtd1mn+b8Efk0wBZZ1t+odqo4q7q9MhUpXnEzn7s2DxWEh+DTW/
	PJ7n8+aPSFFc01ggtC64zvI88=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3l8s24O5qm+D+GA--.26729S2;
	Sat, 07 Nov 2026 16:24:23 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jmaloy@redhat.com
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tipc: don't count unjoined publications as receivers
Date: Sat,  7 Nov 2026 08:24:22 +0000
Message-Id: <20261107082422.900347-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l8s24O5qm+D+GA--.26729S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFW7Cr1xJr1fKryruF45KFg_yoW7XF47pF
	Z0k34rAr15GF4kCan7Xayaqa4I93s5XF47Kas8Cw48Zan7tryxAw4Ivw1UCF98ZFWvk3yF
	vr4YvF17Ca15Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo388UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzxicqmru4DjPXAAA3u

Hello,

A local process with no capabilities can block sends from a TIPC
communication group by publishing the matching service range from a
socket that never joins the group. I reproduced it with a root sender
and a separate unprivileged group member on the same node. A third,
unprivileged process binds the same type and instance as an ordinary
TIPC service. The sender's first nonblocking send returns -EAGAIN. Its
subsequent blocking send remains asleep; after 12 seconds,
poll(POLLOUT) is still clear.

The publisher has CapEff=0 and NoNewPrivs=1. It does not need
CAP_NET_ADMIN or CAP_NET_RAW. The guest init enables the TIPC bearer
before dropping privileges. The test uses one local node; I have not
tested a remote-node trigger. This demonstrates a local availability
issue for the group service only. There is no memory corruption,
information disclosure, or privilege escalation.

tipc_nametbl_build_group() and TIPC_PUBLISHED events create
MBR_PUBLISHED entries for matching service publications.
tipc_group_is_receiver() currently accepts this state. Its
zero-initialized window is added to small_win, so
tipc_group_bc_cong() blocks a sender indefinitely when the ordinary
socket does not complete the group JOIN handshake. A real group
member is present in the reproducer, so this is not an empty-group
send.

This is distinct from the group broadcast hang caused by deleting
the last unacked member: this trigger needs no ACK loss or member
departure and occurs before the first broadcast.

HEAD: commit c03c1a14507dfaf8b856c2608f9ac216021fc222 ("Linux 7.3")
git tree:       upstream Linux, local branch master
source version: Linux 7.3.0 (v7.3)
compiler:       gcc 11.4.0, GNU ld 2.38
QEMU:           6.2.0

Raw reproduction files:

console-output.txt
https://gist.githubusercontent.com/shaos26/243e46a190cef51fbe6a1e8cf1bcdede/raw/1cb4d487be1eace60d6d68ab384f85057b296b41/console-output.txt
patched-console-output.txt
https://gist.githubusercontent.com/shaos26/243e46a190cef51fbe6a1e8cf1bcdede/raw/1cb4d487be1eace60d6d68ab384f85057b296b41/patched-console-output.txt
kernel-config.txt
https://gist.githubusercontent.com/shaos26/243e46a190cef51fbe6a1e8cf1bcdede/raw/1cb4d487be1eace60d6d68ab384f85057b296b41/kernel-config.txt
poc.c
https://gist.githubusercontent.com/shaos26/243e46a190cef51fbe6a1e8cf1bcdede/raw/1cb4d487be1eace60d6d68ab384f85057b296b41/poc.c
init
https://gist.githubusercontent.com/shaos26/243e46a190cef51fbe6a1e8cf1bcdede/raw/1cb4d487be1eace60d6d68ab384f85057b296b41/init
build-initramfs.sh
https://gist.githubusercontent.com/shaos26/243e46a190cef51fbe6a1e8cf1bcdede/raw/1cb4d487be1eace60d6d68ab384f85057b296b41/build-initramfs.sh
run-qemu.sh
https://gist.githubusercontent.com/shaos26/243e46a190cef51fbe6a1e8cf1bcdede/raw/1cb4d487be1eace60d6d68ab384f85057b296b41/run-qemu.sh

With these files saved in a Linux tree at the HEAD above:

    cp kernel-config.txt .config
    make olddefconfig
    make -j"$(nproc)" bzImage
    ./build-initramfs.sh
    ./run-qemu.sh arch/x86/boot/bzImage phantom-group

The unmodified kernel reproduced:

    POLL_BEFORE_FIRST_SEND=4
    NONBLOCK_FIRST_SEND ret=-1 errno=11
    POC_RESULT POSITIVE_SEND_BLOCKED observe_ms=12000 pollout=0

The patched kernel was built from the same HEAD and config. The same
test reported:

    POLL_BEFORE_FIRST_SEND=4
    NONBLOCK_FIRST_SEND ret=1 errno=0
    POC_RESULT CONTROL_SEND_RETURNED ret=1 errno=0

The patched run also preserves POLLOUT for a legitimate group member.
The patch passed checkpatch.pl --no-tree --strict and git apply --check;
the patched kernel and static PoC both built successfully.

Exclude MBR_PUBLISHED entries from receiver accounting. When the JOIN
handshake changes a member to MBR_JOINED, open the group even if that
member was not on the small-window list.

Fixes: b7d42635517f ("tipc: introduce flow control for group broadcast messages")
Signed-off-by: shaos <shawnq1@163.com>
---
diff --git a/net/tipc/group.c b/net/tipc/group.c
index 74f6d3dac0784..61fc57d96f365 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -105,9 +105,12 @@ static void tipc_group_proto_xmit(struct tipc_group *grp, struct tipc_member *m,
 static void tipc_group_open(struct tipc_member *m, bool *wakeup)
 {
 	*wakeup = false;
-	if (list_empty(&m->small_win))
-		return;
-	list_del_init(&m->small_win);
+	if (list_empty(&m->small_win)) {
+		if (m->state != MBR_JOINED || *m->group->open)
+			return;
+	} else {
+		list_del_init(&m->small_win);
+	}
 	*m->group->open = true;
 	*wakeup = true;
 }
@@ -145,7 +148,8 @@ u16 tipc_group_bc_snd_nxt(struct tipc_group *grp)
 
 static bool tipc_group_is_receiver(struct tipc_member *m)
 {
-	return m && m->state != MBR_JOINING && m->state != MBR_LEAVING;
+	return m && m->state != MBR_JOINING && m->state != MBR_PUBLISHED &&
+	       m->state != MBR_LEAVING;
 }
 
 static bool tipc_group_is_sender(struct tipc_member *m)

