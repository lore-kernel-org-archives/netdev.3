Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727170;
	b=s3EOZLkPshh1wF1tSiOwmgnbR1K2LczbJYAYebTb7HQLNqKwIWC0sUGefiIROrwB2db5
	 9X8IP9NgyUDJ+Gc/qvcw2gfrHRr2vzrhQ8pfz3peuYUQ61vI6kBoD9fdmm0ez1gzm8DtP
	 4O1P4EoSLtqrJ/r0rrIAMkxTxL3FtJuiER3jXghb0P5O2A87i+LNYr9xAq2QRwSwc+YMn
	 MGzCRiqNKOZLD140V47Zi8MZ1WD+f9C3NRFf5KJsJTgtCUF46fHxgvWRyccySA1hvJZ6s
	 wzweFAnpGyvysgnwkhwsFfWjtc3H8rTEJHbDi9Mk/bBjYZq9KTeM2dpOkep4qOiGttQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727170;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:X-CM-TRANSID:
	 Message-Id:X-Coremail-Antispam:Date:X-CM-SenderInfo;
	bh=Aju8KAZFxk/1gaiaPxC01GnHpokhvQUAGgMBB/gWK/U=;
	b=foEmMHJheam7ER89QosR3mrWyF1t1LxoVhZVtJ3SkGcwD4PqGbwJXBNCXb/wSbPdplq5
	 gIppu4YEUsW57b8LXqg1dJJCTL79scpCfIsl/Wncr0ncw9GmPnPcPA+oL1pqK+dMgIJEV
	 mkUVSVlX+P086zAc6n2e9qu38l78vnmfvN3jcvJddd19Tr2y5OfICS49t/riLciOVdHIJ
	 kCu3OoroESUN6+6FcExQLSiDNjsfxog8+1z131ECaMQjxDmlideh/IX9StzbqQRdl/k7Z
	 cwoTa1J+j2hIaC/TFeMgpLh2NHOlPk/9vbA9U7frRM0rRQmEQKiipvnWdavAFQirFFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JErVdhSt;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EDC606A324;
	Tue,  3 Nov 2026 17:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EDC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JErVdhSt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Message-Id:Date; bh=Aju8KAZFxk/1gai
	aPxC01GnHpokhvQUAGgMBB/gWK/U=; b=JErVdhSt4ihPVzXXIXY47062q1JjL0u
	3qoNBrsviJEU3rlfLHJk5LCVtxZa7rpZoAn332AzXckcsWHchKxSyZnf9YMoW/xA
	j0Pyibjls2IS/VzoPplYDQaeGjgsroiFNLZm/sPDaY9DeIjZKN7macvskc3N1wl6
	d+AmNOa+/xwI=
From: shaos <shawnq1@163.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: fix cls_flow SKUID/SKGID userns mask
X-CM-TRANSID:PSgvCgCXagqsGupqnkg9Dg--.50703S3
Message-Id:<6AEA1AAE.2E7978.08739@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1rur48Jr47ZFy8XFyDAwb_yoWrAF17pF
	savry3KrZruF18A3s2kF109a1rWrn7GryrCFyDX3ykZ398Gr1j9r4ft3y7K3sFvrWUGayF
	yF4jv3s7Ka1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1zuAUUUUU=
Date: Wed, 4 Nov 2026 01:32:30 +0800 (CST)
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8g4HFWrqGq5ViQAA3G
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

Hello,

flow_change() checks FLOW_KEY_SKUID and FLOW_KEY_SKGID as bit values,
although they are enum indices and TCA_FLOW_KEYS is a bitmask.  The
current expression tests bits 0 through 3 instead of bits 14 and 15.

A process with CAP_NET_ADMIN in a non-initial user namespace can
therefore install SKUID/SKGID filters despite the user-namespace gate.
Those keys use initial-user-namespace credentials.  If another user's
locally generated traffic traverses the attacker's qdisc, the filter
can expose a property of that UID through class packet counters.  The
same typo also rejects some ordinary flow keys.  The demonstrated
cross-namespace inference requires such foreign traffic to reach the
attacker-owned qdisc; this does not disclose an arbitrary UID or grant
privileges.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
Source version: Linux 7.3
Compiler:       gcc 11.4.0, GNU ld 2.38

The console log, full kernel config, and reproducer are available from
one fixed-revision Gist:

Console output:
https://gist.githubusercontent.com/shaos26/a5571f1bfcd37c68c7270d296f1c12c0/raw/b3acb75e61d1cb703c7488ce0400651cd8c84b16/console-output.txt
Kernel config:
https://gist.githubusercontent.com/shaos26/a5571f1bfcd37c68c7270d296f1c12c0/raw/b3acb75e61d1cb703c7488ce0400651cd8c84b16/kernel-config.txt
PoC source:
https://gist.githubusercontent.com/shaos26/a5571f1bfcd37c68c7270d296f1c12c0/raw/b3acb75e61d1cb703c7488ce0400651cd8c84b16/poc.c

Clone this Gist and the exact Linux source revision, then build the
kernel with the attached config and run the PoC as PID 1 in an
initramfs:

    git clone \
      https://gist.github.com/shaos26/a5571f1bfcd37c68c7270d296f1c12c0.git \
      cls-flow-repro
    cd cls-flow-repro
    git clone \
      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
      linux
    git -C linux checkout c03c1a14507dfaf8b856c2608f9ac216021fc222
    cp kernel-config.txt linux/.config
    make -C linux olddefconfig
    make -C linux -j"$(nproc)" bzImage
    gcc -static -O2 -Wall -Wextra -Werror -o init poc.c
    mkdir -p initramfs/dev initramfs/proc initramfs/sys
    cp init initramfs/init
    (cd initramfs && find . -print0 | \
     cpio --null -ov --format=newc | gzip -1 > ../flow-oracle.cpio.gz)
    timeout 180 qemu-system-x86_64 -m 768M -smp 2 \
      -kernel linux/arch/x86/boot/bzImage -initrd flow-oracle.cpio.gz \
      -append 'console=ttyS0 panic=-1 nokaslr rdinit=/init oracle_uid=424243' \
      -nographic -no-reboot > /tmp/flow-oracle-positive.log 2>&1

Change oracle_uid to 424242 for the even-UID control.  Run the same
command with the corrected-mask kernel to check the fixed behavior.

The vulnerable kernel accepted both restricted filters in two fresh
boots.  UID 424243 produced a 7/10 packet split between bands 1 and 2;
changing only the target to even UID 424242 put all 17 packets in band
1.  The corrected-mask kernel rejected SKUID and SKGID with -EOPNOTSUPP,
accepted the ordinary SRC key, and showed all 17 packets in band 2.
The fixed-kernel harness prints ORACLE_RESULT=FAIL intentionally,
because its predicate expects the vulnerable behavior.

The guard was added by commit a6c6796c7127
("userns: Convert cls_flow to work with user namespaces enabled").
Use shifted enum values when checking the TCA_FLOW_KEYS bitmask:

Fixes: a6c6796c7127 ("userns: Convert cls_flow to work with user namespaces enabled")
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/cls_flow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -433,7 +433,8 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		if (fls(keymask) - 1 > FLOW_KEY_MAX)
 			return -EOPNOTSUPP;
 
-		if ((keymask & (FLOW_KEY_SKUID|FLOW_KEY_SKGID)) &&
+		if ((keymask & ((1U << FLOW_KEY_SKUID) |
+				(1U << FLOW_KEY_SKGID))) &&
 		    sk_user_ns(NETLINK_CB(in_skb).sk) != &init_user_ns)
 			return -EOPNOTSUPP;
 	}
-- 
2.34.1

