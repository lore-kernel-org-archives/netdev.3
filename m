Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727541;
	b=KbC5ABiN6r41WT76r3dfQwO13g4VA99KLoZYT32/n/z+CKwOj5bRakTIZaYU+nV018Ti
	 txkOGaeE6W4NBpRF0tus2RKtpOd1SDO3oW0RiBS3PiSA/mkat+TzGv59WGPqYJIrmlf3v
	 p3/YOgrK0i9BEoxA/TjW/cAGreGmQeiUl/ismiAfDIrK5tB6jmt4t9tI6RnEllQli7KQ5
	 euhZ/aKZBune6t4hFKiZpc67dEKNsxg6AJ2F7dAHeGIfpqA77+DkeMtxGrlj7saVz1Ro9
	 gq9QWpAzcTL5UO76+M73s7g6K1GTIOrr+K0Qp6xyhpFPUESgxrdea1shVy27TbsyfMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727541;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:X-CM-TRANSID:
	 Message-Id:X-Coremail-Antispam:Date:X-CM-SenderInfo;
	bh=NCGelH99NdIiK+XLBUHLsPdudRNaMO0Y3JYjrjdoWyc=;
	b=KnGIkASKQnmntw8pEeHydeW+WPLpDCVLTR3PIQkh9h8coejUpqLGqcX7QpEGVhlVRvOy
	 YVJMkpRhZc1CrhYxMjzCzvUOf/CydQL3tzMA41lNOtafK6aO7IrrCacSwA6Jhyo1N3CQz
	 YZhoblqDuiXuNZhZrjV1Lud9bdeAg0iuP/YXcTXWfQ6H+rnBueo8fqi2jojELBh46ogHx
	 wyBeu/bcnYdsRb8HGe86zergh5nog4e9CKdOYQi1OUPoWr8bp558fttCoZstCUV1JtjUR
	 Udblbq/xoeVfZtZb79WtGUl4VJU9E9dakd/qbrwQaosVZDObThmYCxPBA82N2qpj9Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KnGgVeaA;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646A606A32E;
	Tue,  3 Nov 2026 17:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B646A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KnGgVeaA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Message-Id:Date; bh=NCGelH99NdIiK+X
	LBUHLsPdudRNaMO0Y3JYjrjdoWyc=; b=KnGgVeaAbocLq2Zn8K8pVYwr4p451Y1
	FqxUWNDvnTyAAmnFnvQVrTUsH0HFZin1wIyB4/IgrUd7Yp/cNe55s3blJfp0uSR6
	f86xTYwO8lAOydj7m5X8ny5pl2XXy1dx990QMu0XahBYDxDbkUCaHwMblgokvjBN
	uxH2sPEshB40=
From: shaos <shawnq1@163.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: hfsc: clear eligible node on reset
X-CM-TRANSID:_____wDXv6UjHOpqVNNREw--.49754S2
Message-Id:<6AEA1C23.11E1A6.00008@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4kZw43Xr4DWr4DKrykKrg_yoW7Jw4xpr
	Wv9r15KayYga15Ja1vkFyUZFy8Zas3AFs8WF1kWws7Z347uw1IqrWxCryjkr90grWkCayF
	vr4jqw1Iq3yjqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrjjgUUUUU=
Date: Wed, 4 Nov 2026 01:38:44 +0800 (CST)
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwNkcmrqHCP7QAAA3e
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

Hello,

hfsc_reset_class() clears the realtime class counters but leaves its
el_node marked as linked.  hfsc_reset_qdisc() then discards the
scheduler-wide eligible tree by assigning RB_ROOT.  After a link
reset with an RSC class backlogged, the next packet sees the stale
non-empty el_node, skips init_ed(), and leaves the class absent from the
new eligible tree.  HFSC then retains the packet in its child qdisc
without a dequeue event or watchdog recovery.

Two fresh QEMU runs reproduced a permanently queued packet after
link down/up.  An FSC-only class, a drained-queue reset, and a no-reset
control transmitted normally.  A kernel with the patch below reported
RESULT=NOT_STUCK and transmitted the packet.  This requires control of
the HFSC qdisc and is a scheduler liveness/correctness defect; no memory
corruption or privilege escalation was observed.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
Source version: Linux 7.3
Compiler:       gcc 11.4.0, GNU ld 2.38

The console logs, full kernel config, packet sender, and QEMU/initramfs
harness are available from one fixed-revision Gist:

Console output:
https://gist.githubusercontent.com/shaos26/d7ec57d3a631368bd50ad0182ce9c268/raw/6344f32527074498da61f02b58068539859b388e/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/d7ec57d3a631368bd50ad0182ce9c268/raw/6344f32527074498da61f02b58068539859b388e/kernel-config.txt
PoC source:
https://gist.githubusercontent.com/shaos26/d7ec57d3a631368bd50ad0182ce9c268/raw/6344f32527074498da61f02b58068539859b388e/poc.c
Harness: hfsc_reset_harness.sh
https://gist.githubusercontent.com/shaos26/d7ec57d3a631368bd50ad0182ce9c268/raw/6344f32527074498da61f02b58068539859b388e/hfsc_reset_harness.sh
Harness: init.sh
https://gist.githubusercontent.com/shaos26/d7ec57d3a631368bd50ad0182ce9c268/raw/6344f32527074498da61f02b58068539859b388e/init.sh
Harness: mkinitramfs.sh
https://gist.githubusercontent.com/shaos26/d7ec57d3a631368bd50ad0182ce9c268/raw/6344f32527074498da61f02b58068539859b388e/mkinitramfs.sh
Harness: run-qemu.sh
https://gist.githubusercontent.com/shaos26/d7ec57d3a631368bd50ad0182ce9c268/raw/6344f32527074498da61f02b58068539859b388e/run-qemu.sh

Clone the Gist and build the vulnerable kernel and initramfs.  The
kernel source is the HEAD commit above; use the attached full config.
The host needs gcc, fakeroot, cpio, gzip, BusyBox, iproute2, and QEMU:

    git clone \
      https://gist.github.com/shaos26/d7ec57d3a631368bd50ad0182ce9c268.git \
      hfsc-repro
    cd hfsc-repro
    TMP=/tmp/hfsc-repro-build
    mkdir -p "$TMP/rootfs"
    git clone \
      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
      linux
    git -C linux checkout c03c1a14507dfaf8b856c2608f9ac216021fc222
    cp kernel-config.txt linux/.config
    make -C linux olddefconfig
    make -C linux -j"$(nproc)" bzImage
    mkdir -p poc
    mv hfsc_reset_harness.sh init.sh mkinitramfs.sh run-qemu.sh poc/
    cc -O2 -static -Wall -Wextra -Werror -o poc/hfsc_probe poc.c
    fakeroot -- sh poc/mkinitramfs.sh "$TMP/rootfs" "$TMP/initramfs.cpio.gz"

Run the positive and close controls on fresh QEMU boots:

    KERNEL="$PWD/linux/arch/x86/boot/bzImage" \
    INITRD="$TMP/initramfs.cpio.gz" OUT="$TMP/rt-reset.log" \
    sh poc/run-qemu.sh rt-reset
    KERNEL="$PWD/linux/arch/x86/boot/bzImage" \
    INITRD="$TMP/initramfs.cpio.gz" OUT="$TMP/ls-reset.log" \
    sh poc/run-qemu.sh ls-reset
    KERNEL="$PWD/linux/arch/x86/boot/bzImage" \
    INITRD="$TMP/initramfs.cpio.gz" OUT="$TMP/rt-drained-reset.log" \
    sh poc/run-qemu.sh rt-drained-reset
    KERNEL="$PWD/linux/arch/x86/boot/bzImage" \
    INITRD="$TMP/initramfs.cpio.gz" OUT="$TMP/rt-noreset.log" \
    sh poc/run-qemu.sh rt-noreset

The positive prints RESULT=STUCK.  Controls print RESULT=CONTROL_PASS.
For the fixed-kernel mechanism control, rebuild from the patched source;
rt-reset then prints RESULT=NOT_STUCK.  The guest configures a qdisc and
sends AF_PACKET frames, so it runs as root in QEMU.  A direct trigger
requires CAP_NET_ADMIN and CAP_NET_RAW.

The eligible-node marker must be cleared when the class scheduler state
is reset:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/sch_hfsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1488,6 +1488,7 @@ static void hfsc_reset_class(struct hfsc_class *cl)
 	cl->cl_myf          = 0;
 	cl->cl_cfmin        = 0;
 	cl->cl_nactive      = 0;
+	RB_CLEAR_NODE(&cl->el_node);
 
 	cl->vt_tree = RB_ROOT;
 	cl->cf_tree = RB_ROOT;
-- 
2.34.1

