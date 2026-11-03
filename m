Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727540;
	b=qrTPMtiqhugBpXM+FTD+SkyRQvsEmJWNXHFLGBVqG6RcearngUS9jCoy5KNj1xQRrT7F
	 b84aAASABC3iVWIu33eNA32p2YzWbP3OClaOddbmrj1vT/oj5zbM8H9jLJA3DRmU+D+tc
	 fXUaoHIR9ECpWskQYeiamzqN9T5RZphsXibZG4lhQ7p/BiWraIT3lemlVYp1ffcMPGUi5
	 /UhxtAsx8sK4fiUNvsHBN1AwUhOx1xEWdEVXmrN+Xo2S9drQpiTah1p7rYN5n9w4OqRcF
	 VBR8GrNScs8crA262gFNywRSjKBiWB3hxAygn9PP8etfspoaPBWX8KPUHnoGswTmlBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727540;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:X-CM-TRANSID:
	 Message-Id:X-Coremail-Antispam:Date:X-CM-SenderInfo;
	bh=dJKOOQnd+uKmbBZsGQC1rMUTNlbzEWw7XRaQ1Ec3WZ4=;
	b=DWaZeU7SlA0qhYLQm94el6sMjEgi3rcc9IbK1THGSIrywp77mWaPwuwxKEiTqsDAIuUa
	 kTJlu+dAB947sCX1fVnDpfiOEbNute2s0eQCMpeGKjmqz2O9RoBGqk85oWnRBkPtZwuWv
	 gYDUBqVs6wJ7yyCBtu3XqtU0av6Up8/ySSFtxUSeFAVZplt0I3+bVKIJQWLYCnnEjcTEt
	 2QtlUExko85fvNbYCusWU1Cw616Qysw21w6bmQyK3lIMaOlFmYLdEn6HWb7scLouQDKl3
	 //JaDYbMNBCNy1mLJVZxgOSXcCRC9rp5pDLkkOOHaRAn6PjH5B+HK5Qnupyp6PhZ+qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bf8Mew42;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B85606A32C;
	Tue,  3 Nov 2026 17:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B85606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bf8Mew42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Message-Id:Date; bh=dJKOOQnd+uKmbBZ
	sGQC1rMUTNlbzEWw7XRaQ1Ec3WZ4=; b=bf8Mew42/xigjgKb6Kx0kgy8UJCmjLa
	kq8LeDUG44WUxBhgf9JLJaivq14teaZFvFKm7AUymgRVpXEC8PtN746M0VrxykIb
	L7CwwsusBNWAidoakdXeTQ9wyslbX2Fh4B8xvPfZC8FBj7hcqoQ11PPuq9a7+00b
	r/iUxTWNBnfs=
From: shaos <shawnq1@163.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: reset sch_plug epoch state
X-CM-TRANSID:_____wDXv6UjHOpqVNNREw--.49754S3
Message-Id:<6AEA1C24.11E1A7.00008@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWktr45AF1kuFW3AFWrZrb_yoWrWF47p3
	yv9FW3tr1kCF15X3yvkF18ZaySgrZIyw4UZryDJw47Zwn8Gr15Zr1Ikr1akrZ7Wr93Caya
	vr4Yg3WxWFs09FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1a0PUUUUU=
Date: Wed, 4 Nov 2026 01:38:44 +0800 (CST)
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzwRlc2rqHCT7TQAA3T
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

Hello,

sch_plug's reset callback purges the skb queue but leaves the private
packet-epoch counters intact.  If a buffered epoch is reset by a link
reset, a later TCQ_PLUG_RELEASE_ONE can use the old pkts_last_epoch
count as release credit and transmit a fresh packet that was never part
of the completed epoch.

The reproducer confirms this after link down/up: four buffered frames
are dropped by reset, then one new frame is held until a single release
command delivers it.  Three close controls do not deliver the frame.
The same fixed-kernel test keeps it queued.  This breaks the output
commit guarantee documented for checkpoint/replication users of the
plug qdisc.  It requires CAP_NET_ADMIN to configure/reset the qdisc and
is a correctness issue; no memory corruption or privilege escalation
was observed.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
Source version: Linux 7.3
Compiler:       gcc 11.4.0, GNU ld 2.38

The console logs, full kernel config, PoC, and initramfs runner are
available from one fixed-revision Gist:

Console output:
https://gist.githubusercontent.com/shaos26/f514dff98be5c90da07bc3467214ef10/raw/e16e1fa984b297ef7bf18e2c8a5992fc63daa062/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/f514dff98be5c90da07bc3467214ef10/raw/e16e1fa984b297ef7bf18e2c8a5992fc63daa062/kernel-config.txt
PoC source:
https://gist.githubusercontent.com/shaos26/f514dff98be5c90da07bc3467214ef10/raw/e16e1fa984b297ef7bf18e2c8a5992fc63daa062/poc.c
Initramfs init:
https://gist.githubusercontent.com/shaos26/f514dff98be5c90da07bc3467214ef10/raw/e16e1fa984b297ef7bf18e2c8a5992fc63daa062/initramfs-init
Runner:
https://gist.githubusercontent.com/shaos26/f514dff98be5c90da07bc3467214ef10/raw/e16e1fa984b297ef7bf18e2c8a5992fc63daa062/reproduce.sh

Clone the Gist and kernel source, build the kernel with the attached
config, and run the self-contained initramfs builder/runner:

    git clone \
      https://gist.github.com/shaos26/f514dff98be5c90da07bc3467214ef10.git \
      sch-plug-repro
    cd sch-plug-repro
    git clone \
      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
      linux
    git -C linux checkout c03c1a14507dfaf8b856c2608f9ac216021fc222
    cp kernel-config.txt linux/.config
    make -C linux olddefconfig
    make -C linux -j"$(nproc)" bzImage
    KERNEL="$PWD/linux/arch/x86/boot/bzImage" \
      LOG=/tmp/sch-plug-positive.log sh ./reproduce.sh

The runner builds a static PoC and initramfs, then boots QEMU.  The PoC
creates a veth pair, attaches sch_plug, performs the reset/release
sequence, and records tagged frames.  It requires GCC, BusyBox, cpio,
gzip, and QEMU on the host.  The guest runs as root; the equivalent
direct trigger requires CAP_NET_ADMIN and CAP_NET_RAW.  The attached
console output contains two positive QEMU runs and patched-kernel
controls.

Fixes: fe6bea7f1f3a ("sch_plug: purge buffered packets during reset")
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/sch_plug.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -202,6 +202,18 @@
 	return 0;
 }
 
+static void plug_reset(struct Qdisc *sch)
+{
+	struct plug_sched_data *q = qdisc_priv(sch);
+
+	qdisc_reset_queue(sch);
+	q->pkts_current_epoch = 0;
+	q->pkts_last_epoch = 0;
+	q->pkts_to_release = 0;
+	q->unplug_indefinite = false;
+	q->throttled = true;
+}
+
 static struct Qdisc_ops plug_qdisc_ops __read_mostly = {
 	.id          =       "plug",
 	.priv_size   =       sizeof(struct plug_sched_data),
@@ -210,7 +222,7 @@
 	.peek        =       qdisc_peek_dequeued,
 	.init        =       plug_init,
 	.change      =       plug_change,
-	.reset       =	     qdisc_reset_queue,
+	.reset       =	     plug_reset,
 	.owner       =       THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("plug");
-- 
2.34.1

