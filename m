Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680A2E8DEC;
	Tue, 22 Sep 2026 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081767; cv=none; b=Q2WGbSge3udfpA/6CyAa5Yn0a7FiOaoRqdzjAb2/skeotaNFCrE38cGXwdBkNCw97rhFJLeicmY6cpgFG9tBYnOGtIa/k17imDu57QcOJNv1Hvlo5PN1Mw1YeXaKJZy+72vMYRr7mOq3B7aGw/6+fJsvtuOP1JXH+BHuxOpSyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081767; c=relaxed/simple;
	bh=Fq+L7Nz+SlJHfRIG0KoeCOKimB6Chwp7clqkc6Bq2Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAIF0Ejm4VTqtRy5Gsz9FRyQSgzUuEjdo48DVWzWBNSmV/c3oNk/kVgzLInTqg7rSnvxfmjTvfmXQUcEtOzc0vRRDAYrSOiwrBg5QTDtl0e/QRE9hhRxBdfKRuAS2VBT4Ets0n9hSZCfkqkICB5L/huh/KhiY6yfrYNlCxpp7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c+Wcw1qX; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c+Wcw1qX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Wu
	OTXUCWcBCzTWfeUtcHQgqBVy2fBn5gbP2wjjitG8s=; b=c+Wcw1qX0d7oVLNAFx
	SF3aeXkMloDypUmYemKB2ZcukKQpuDrQCvbxHKBwN/zWySBlReDN28nRJxLA/U+0
	+eNBDQaS76THzjVn3i4H5zNb85JKpMlqManRPBSIplYM6mERl2QOpTAsZrohIUWe
	H00kj8mS/XjlEN7S/iS9Z1XWE=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_5yVerJqdyt6AA--.52817S2;
	Tue, 22 Sep 2026 20:54:47 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <dengbinbin21@nudt.edu.cn>
Subject: [PATCH net v1] net/mctp: publish the mctp_dev only after it is initialised
Date: Tue, 22 Sep 2026 20:54:43 +0800
Message-ID: <20260922125443.133110-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_5yVerJqdyt6AA--.52817S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw18Kw47Ar13tw4fuw18uFg_yoW5GF4xpF
	y8XFy3KrW8K340qrWrZF4vg34UWr18Z3W3CrW2q390kr45trWSgry3Kr9rXFyrZrZ7WFyv
	qF1j93yjvF10vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAo7tUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+xcL7mqyepeenAAA3+

From: Binbin Deng <dengbinbin21@nudt.edu.cn>

mctp_add_dev() links the new mctp_dev into dev->mctp_ptr before mdev->dev
is assigned, so a reader that picks the device up in that window
dereferences a net_device pointer that is still NULL:

KASAN: null-ptr-deref in range [0x00000000000000b0-0x00000000000000b7]
Call Trace:
 <TASK>
 ? __pfx_mctp_sendmsg (./include/linux/sockptr.h:49)
 ? __pfx_mctp_dst_output (net/mctp/route.c:41)
 ? selinux_socket_sendmsg (security/selinux/hooks.c:5278)
 ____sys_sendmsg (net/socket.c:775 (discriminator 1) net/socket.c:790
 (discriminator 1) net/socket.c:2684 (discriminator 1))
 ? __pfx_____sys_sendmsg (net/socket.c:1131)
 ? __pfx_copy_msghdr_from_user (net/socket.c:2590)
 ? update_cfs_rq_load_avg (kernel/sched/fair.c:5478)
 ___sys_sendmsg (net/socket.c:2738)
 ? __pfx____sys_sendmsg (net/socket.c:2625)
 ? perf_event_task_tick (./include/linux/rcupdate.h:838)
 ? sched_tick (kernel/sched/core.c:5818)
 ? clockevents_program_event (kernel/time/clockevents.c:372)
 ? fdget (./include/linux/rcupdate.h:873 fs/file.c:1100)
 __sys_sendmsg (net/socket.c:2770)
 ? __pfx___sys_sendmsg (net/socket.c:2751)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
 </TASK>

Fix by publishing only once the object is fully initialised:
__mctp_dev_get() runs under rcu_read_lock() only and hands
this object to readers as soon as mctp_ptr is assigned, so
they must never observe mdev->dev == NULL.

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Signed-off-by: Binbin Deng <dengbinbin21@nudt.edu.cn>
---
 net/mctp/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 822120e860c8..b76715ea50e1 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -344,13 +344,18 @@ static struct mctp_dev *mctp_add_dev(struct net_device *dev)
 
 	mdev->net = mctp_default_net(dev_net(dev));
 
-	/* associate to net_device */
 	refcount_set(&mdev->refs, 1);
-	rcu_assign_pointer(dev->mctp_ptr, mdev);
-
 	dev_hold(dev);
 	mdev->dev = dev;
 
+	/*
+	 * Associate to net_device.  Publish only once the object is fully
+	 * initialised: __mctp_dev_get() runs under rcu_read_lock() only and
+	 * hands this object to readers as soon as mctp_ptr is assigned, so
+	 * they must never observe mdev->dev == NULL.
+	 */
+	rcu_assign_pointer(dev->mctp_ptr, mdev);
+
 	return mdev;
 }
 
-- 
2.43.0

