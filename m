Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE7212FAD
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670430; cv=none; b=tXRhF3XSBjB7jQ0X7hMILYcC2Ja7WioitAFprDXF5Ah3JWhG6jFwBGYYthzSa+Bl+11WjFk6DbhgC2KEBehDOuvLYz095eVcqdVwp506/DNYOH8UQ+WeL4AjEBCBXje+pZXljpAInX+ddoNCk06udUHzYdHEIS+ibe9sIpP7Xwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670430; c=relaxed/simple;
	bh=ly7897731+VvttzNl0094AzP1tPEtuY5mxRbjgz//oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXiOPjjHt+VJGwyDs2OKbM5TyExwTP1OgiMGRfjWL5hL6n2OsFJ5EoYXibo4A1tf0m9ab/4EqIpaRc9pmjChDOpcwLWiot1HcQfgddkHJ9uYzu76lCi4uTcbVT6ul5n6xMOky9ff0n6RvV4nFcP2/iNPSvcIA+PrEmiE4rKmSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=twByNmWt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="twByNmWt"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so1006306a91.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1787670422; x=1788275222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TEcUlcO5OMpU25UL/7E+tl0pMAtyazvUdbJKhRWj8jU=;
        b=twByNmWtQ5gNVvoaKpasCNt+Zus+RKDfKUMDcT4JQRb/JPB/boeWDQz4ovz/NslBQY
         NNqpywXptmU8xkIdY4UyxlLgKPLH1/YUIdcUmg2BHYvP+SYbnqjJdwn2xtpYWiAq8cF+
         7IbXxIr5OiGCI7Xto1J4orgEtx+6RAPgDlkzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787670422; x=1788275222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEcUlcO5OMpU25UL/7E+tl0pMAtyazvUdbJKhRWj8jU=;
        b=nMuxni4JqC37MzaaksoG0j6exSPG7GQlyQ8TxOcjW/ZzNd14Cn4zGk4iOUeJi23qAW
         YzJXLFs48/8PoZEp0Ttt9yHzgKnyq/Fz5Y/Hyt7YNYmpXch9tNq8rw4UzziQwk6hX/Mj
         YIwkDzFE68CoyOwVjoWAWnuNXmDBT6SQhZ5RmZJrxDEC5HqjTtGbM/ZJowZmtpU/zJnb
         LYLJDiFJG0mfL2lY9QOOuwyFj6z3OxmMqyyPMr5HhDXDzfYDf/7lky6y3paRC4o4Zxs7
         r0aj77Kmrwqoeg7a7bXSDHTeRnsHMZgK/59HAh0cJrJfaDNRs5Wy0jDFYhU3uMqY8AAU
         MZrA==
X-Forwarded-Encrypted: i=1; AHgh+RrQkSOQRIZ1GzBX3a4/Gs4hsW3QgzJCl0CE+pkrxoCmxyWgORt+F2cFI9YvYOHaaS3HMcn7zdY=@vger.kernel.org
X-Gm-Message-State: AFuF++lIkWJ7JT9Tq8KIDS57eKZWaYcB0JOoDggP9QgyKuSg1Mk50n9K
	P0Bp0XMBgBeCA3cV+OgSIwVv1CxOtmy5fWu+kIJb6HPd/kIAfacnhQ057OuDY9eeMmk=
X-Gm-Gg: AR+sD10jgtPB2CQT+i/liCtHpdbSbbF5hCw35MwMz3Irwm+gicD2a0aLb8vs8xctM8v
	ITUw2I5b0GGGFH1RE8huz+c5OHi4iqOmywui4G7P4WHyNp/kphUdbkLDyhhi91IP/+nl6iFRF2U
	q87hOtyyu71UcdG1A380W1CD4mtB+1KgycN8q1CHuiOcFGf9txwimmsxZ2B8poCyWQe5TvhP0+2
	oWu5rCtPf/4vCLl0hODcjM9ki7KT9d5m8mJxXBRwYlu0GYwR4hFaD+9Kflw3zGiC6Q8/YtPw5Cb
	lsfpM2lCC3WC3eCWyJndb2d9d/n6HJY7OIbg4Uq5OM8X9vcfSedN5NBI2iCJfjZGzNKyZ89EwAb
	rs13vuCSts92ybT82X66sgc+/pwY9jQAoMIs48M6PAmizls6czBlk25W2pLdVpBOqtOsa4UzqZ1
	F4y6DBuBYZ25qxuklsoy2StflxGs6GCA0rS7kMPIRTjmiPsXuqagLrRB4MzYPQz+TmNjv/Pr5HS
	vKlnGxUgZHGAkmk6KX3yA5Z/0KdnWoRVOBYMCLU+vP2tUG4h7agPUkHn6Vt7rQCEPam3Rw72U45
	JnwOpAGrQGowcnVBAJw6JxqHdSH0Iaw8dvVnkAI9VtBtS3V/nuHz+Q==
X-Received: by 2002:a17:90b:3b48:b0:393:1cf4:d972 with SMTP id 98e67ed59e1d1-395dee55f7emr47103024a91.3.1787670421953;
        Tue, 25 Aug 2026 08:07:01 -0700 (PDT)
Received: from leesin ([147.46.121.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396448095c5sm1433154a91.2.2026.08.25.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:07:01 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Cc: 726ksm@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: slab-use-after-free Read in slip_receive_buf
Date: Wed, 26 Aug 2026 00:06:54 +0900
Message-ID: <20260825150655.1450271-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We found a "KASAN: slab-use-after-free Read in slip_receive_buf" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root cause,
so we do not have a proposed fix to offer.

To reproduce the race reliably, we applied the delay patch below to the
kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
crash log we observed, the delay patch and the reproducer are all included
below.

The following kernel config options are required to reproduce the issue:
    CONFIG_SLIP=y
    CONFIG_LEGACY_TIOCSTI=y
    CONFIG_UNIX98_PTYS=y
    CONFIG_TTY=y
    CONFIG_KASAN=y

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index faae711cf793..328f54553cb5 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -689,6 +689,9 @@ static void slip_receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 			     size_t count)
 {
 	struct slip *sl = tty->disc_data;
+	if (sl && strncmp(current->comm, "syzrepro0", 10) == 0) {
+		mdelay(1500);
+	}
 
 	if (!sl || sl->magic != SLIP_MAGIC || !netif_running(sl->dev))
 		return;

==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef N_SLIP
#define N_SLIP 1
#endif
#ifndef TIOCSETD
#define TIOCSETD 0x5423
#endif
#ifndef TIOCSTI
#define TIOCSTI 0x5412
#endif
#ifndef TIOCVHANGUP
#define TIOCVHANGUP 0x5437
#endif

#define T1_HEAD_START_US 30000

static char g_marker[16] = "syzrepro";
static int g_fd = -1;

static void set_thread_name(int idx)
{
	char nm[16];

	snprintf(nm, sizeof(nm), "%s%d", g_marker, idx);
	nm[15] = '\0';
	if (prctl(PR_SET_NAME, nm, 0, 0, 0) != 0)
		printf("repro: prctl(PR_SET_NAME, %s) failed: %s\n",
		       nm, strerror(errno));
}

static void *thread_use(void *arg)
{
	unsigned char ch = 0x40;
	int r;

	(void)arg;
	set_thread_name(0);

	r = ioctl(g_fd, TIOCSTI, &ch);
	if (r != 0)
		printf("repro: T0 TIOCSTI -> %d (%s)\n", r, strerror(errno));
	return NULL;
}

static void *thread_free(void *arg)
{
	int r;

	(void)arg;
	set_thread_name(1);

	usleep(T1_HEAD_START_US);

	r = ioctl(g_fd, TIOCVHANGUP, 0);
	if (r != 0)
		printf("repro: T1 TIOCVHANGUP -> %d (%s)\n", r, strerror(errno));
	return NULL;
}

int main(void)
{
	int iters = 10;
	int i;

	setvbuf(stdout, NULL, _IONBF, 0);


	for (i = 0; i < iters; i++) {
		int fd, ldisc = N_SLIP;
		pthread_t t0, t1;

		fd = open("/dev/ptmx", O_RDWR | O_NOCTTY);
		if (fd < 0) {
			usleep(200000);
			continue;
		}

		if (ioctl(fd, TIOCSETD, &ldisc) != 0) {
			close(fd);
			usleep(200000);
			continue;
		}

		g_fd = fd;

		if (pthread_create(&t0, NULL, thread_use, NULL) != 0) {
			close(fd);
			continue;
		}
		if (pthread_create(&t1, NULL, thread_free, NULL) != 0) {
			pthread_join(t0, NULL);
			close(fd);
			continue;
		}

		pthread_join(t0, NULL);
		pthread_join(t1, NULL);

		g_fd = -1;
		close(fd);
	}

	return 0;
}
==================================================================

Crash log:
==================================================================
BUG: KASAN: slab-use-after-free in slip_receive_buf+0x89b/0x8b0 drivers/net/slip/slip.c:696
Read of size 4 at addr ffff888107d24a80 by task syzrepro0/400

CPU: 2 UID: 0 PID: 400 Comm: syzrepro0 Not tainted 7.2.0-dirty #3 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5e/0x80 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x64/0x70 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 slip_receive_buf+0x89b/0x8b0 drivers/net/slip/slip.c:696
 tiocsti+0x165/0x1c0 drivers/tty/tty_io.c:2290
 tty_ioctl+0x76c/0xa40 drivers/tty/tty_io.c:2706
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7b142e575d6b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007b142e473e60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007b142e4746c0 RCX: 00007b142e575d6b
RDX: 00007b142e473ec7 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000064
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffff80
R13: 0000000000000000 R14: 00007ffc1370b9a0 R15: 00007b142dc74000
 </TASK>

Allocated by task 399:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kvmalloc_node_noprof+0x36a/0x620 mm/slub.c:6905
 alloc_netdev_mqs+0x8c/0x1170 net/core/dev.c:12059
 sl_alloc drivers/net/slip/slip.c:763 [inline]
 slip_open+0x280/0x970 drivers/net/slip/slip.c:824
 tty_ldisc_open+0x83/0xc0 drivers/tty/tty_ldisc.c:432
 tty_set_ldisc+0x2f8/0x4b0 drivers/tty/tty_ldisc.c:563
 tty_ioctl+0x822/0xa40 drivers/tty/tty_io.c:2728
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 401:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x3a/0x60 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x16c/0x3e0 mm/slub.c:6692
 device_release+0xbc/0x1b0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x142/0x1c0 lib/kobject.c:737
 netdev_run_todo+0x392/0x10b0 net/core/dev.c:11760
 rtnl_net_unlock include/linux/rtnetlink.h:135 [inline]
 rtnl_net_dev_unlock net/core/dev.c:2180 [inline]
 unregister_netdev+0x10d/0x160 net/core/dev.c:12532
 tty_ldisc_hangup+0x163/0x3d0 drivers/tty/tty_ldisc.c:705
 __tty_hangup+0x50c/0x770 drivers/tty/tty_io.c:621
 tty_vhangup drivers/tty/tty_io.c:691 [inline]
 tty_ioctl+0x27f/0xa40 drivers/tty/tty_io.c:2732
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff888107d24000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 2688 bytes inside of
 freed 4096-byte region [ffff888107d24000, ffff888107d25000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107d20
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888107d21011
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff88810004a280 dead000000000100 dead000000000122
raw: 0000000000000000 0000200000040004 00000000f5000000 ffff888107d21011
head: 0200000000000040 ffff88810004a280 dead000000000100 dead000000000122
head: 0000000000000000 0000200000040004 00000000f5000000 ffff888107d21011
head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888107d24980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888107d24a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888107d24a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888107d24b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888107d24b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


