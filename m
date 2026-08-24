Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990EE417BD2
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572778; cv=none; b=p7D2buJyuxeOPlmcUxCP3mb1wyOolrWPA3HMZSRPNKY4LM62i1nUlHB0as6qnQZRyFoxMpL+I0qu4UgPP23M+YOkkJHGs2qOsMpi43Qzi4XSjwlFnrTdBdQ0FELQKozJHDJFcxUG/N7G4jiknyAutKUZMEg8zqU/2hNjPq3Nzj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572778; c=relaxed/simple;
	bh=2bI4USJhE8vSZpLg3neqVj8QPvDXfbETdN8Qc/q0wP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9OYDYLC4ogp54Uy5MxgLFuCUwOfqQP0jtbvl8R6/jwwmHahsPJhkPCTPvNKz+mPTgQlnjfhARj7clkj44fAFCvxVblTlWoJLDzGtZQfDLDe6HxYuDi6vK8sQ/dDpBA92vsH4Z3LhnUX6IdDOZFZ8y3VyqBY31RKewXTiKrq5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=P7n5lXBu; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="P7n5lXBu"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9696319e14dso1065244241.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787572775; x=1788177575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KFWlM388Lf40pRKG1/HIw4Wzf+kCFF6F/8bkvIfvbTY=;
        b=P7n5lXBuhXfLQk5Y91UtOQpbCqsYKTKeu7/V/6afm9w+0h+7ci3bVXqb8j6zFuz1yf
         +ywKtTX1Vs26Q+4KJuJibF6PJNlg+vr6tnA2W6rV3yLVf4c4VHOAH/zJFUPW/QPemlI/
         0hfheEHpvlVbrkFvqagHV47ukN6FwWEBkGNsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787572775; x=1788177575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFWlM388Lf40pRKG1/HIw4Wzf+kCFF6F/8bkvIfvbTY=;
        b=nScM5lCoiw+ikh4E7dY3s7toz/XY0BO2NY56w9l/sJ4t+k3kR46cxI+CE8UWn0rJvD
         O7lhM5yxadxb1gvppFQt+Hw3eb8edAdvzlk4NHZHdzvwkB0i1Yd4rLyp4G5jluxbUSx0
         qc8aVY8zLStmi4uUChJ2HM6ciwlZXTsOwDrkn0tNV0OO+BQ9Yhl9+8GAyLmE/+/xCIl8
         CACL8u5aATapqlNb9rKMc6KwJnym7JMMj4NtJ5o4/oPYtsyERSJ+/Bn0+lhm13KbvI8f
         CIsPnHY8gl4YXUpIRmqfUckhQDunImnbSaDUwcNUONZ8e0o6+qmtd+lfZNoTVzMFVnmD
         eeFw==
X-Forwarded-Encrypted: i=1; AHgh+RomqzT9F08yFYCo1kLpCycsKYU2Gmzx+lKkLhSUTEJbm1awPm6CUPCmH9UVmzAKrqaAJltgEjs=@vger.kernel.org
X-Gm-Message-State: AFuF++kofOO8p0+uHtYDD0VLcOrNLjXIoB2+xohPtRfLdFkIMDxHn5a/
	zKDvOrP6Dzlc8yrOTYIVfG0SCHOdT6pCyJNSx5k+Cv0EUq8ZbuQpu9TEFT087UnSfA==
X-Gm-Gg: AR+sD13L/UrFqlyFx48/U71HtxYciXKn72XFqgoVP/E2Z3luQTz9Ya8q9mP9kEsHKX9
	PgLTEj1gASVHI0xBD5o9apaJRTKbOUPLqtFgduyx8wtJzQEhdEKIUMcV5EHzWIPIJLZ3MO0/VOg
	enExMsnLGavDbqwJP4vJUKXCU423QV7aB1pExk1K2UC8LCFOS3XW82UsJ4wRzlckqjSXYWl/6j1
	wxu2SWqn+in3C3LkvWBz9NMLPPGKCAh9/1QGOGeTmeZOV1v3ozzAV4IeU+iNjkOohFhOwS6z+2N
	fhhhWPv2k20HVJ4IlRI70eylmu9hJGxtV6aolyXMP3XIraVD2rPe9otiOrvFUIXYYho8bjy4Uin
	iWbpmtXQF+93D4JQkFFXUsvWppBntcrA5Rr3EaetKaNPy0ZjgPp/DOFA9lZAlC++wQDdcZayBtQ
	4lr0p1NZRF89sIFPOdGPR4AYUVMX97nG7HmbcZUmHtSSETupTYLMsMZdw=
X-Received: by 2002:a05:6102:3714:b0:77f:7df:c9ef with SMTP id ada2fe7eead31-77f07dfde0dmr875076137.0.1787572775352;
        Mon, 24 Aug 2026 04:59:35 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-77d85beba4esm2717892137.10.2026.08.24.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:59:34 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	bestswngs@gmail.com,
	vega@nebusec.ai,
	netdev@vger.kernel.org
Subject: [PATCH net RESEND] net/sched: sch_teql: restore skb->dev on the slave failure path
Date: Mon, 24 Aug 2026 08:59:28 -0300
Message-ID: <20260824115928.4099988-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

teql_master_xmit() sets skb->dev = slave before calling the slave's
ndo_start_xmit(), but never restores it when that transmit fails. The
skb then walks on to the next slave still pointing at the previous one.

If a later slave has no resolved neighbour, teql_resolve() hands the skb
to neigh_event_send(), which queues it on that neighbour's arp_queue
with the stale skb->dev. skb->dev holds no reference, so deleting the
previous slave frees the net_device while the skb is still queued.
Whatever runs next on that skb - arp_error_report() on timeout, or
neigh_direct_output() -> dev_queue_xmit() once the neighbour resolves -
causes a UAF like the one below:

BUG: KASAN: slab-use-after-free in __icmp_send (net/ipv4/icmp.c:914 (discriminator 2))
Read of size 4 at addr ffff888106e100b0 by task flood_packet/527
CPU: 0 UID: 0 PID: 527 Comm: flood_packet Not tainted 7.2.0-rc6-g594d90519502 #1 PREEMPT(lazy)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
<IRQ>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
? __pfx__raw_spin_lock_irqsave (./include/asm-generic/qrwlock.h:122 (discriminator 4))
? __icmp_send (net/ipv4/icmp.c:914 (discriminator 2))
kasan_report (mm/kasan/report.c:595)
? __icmp_send (net/ipv4/icmp.c:914 (discriminator 2))
__icmp_send (net/ipv4/icmp.c:914 (discriminator 2))
[...]
ipv4_link_failure (net/ipv4/route.c:1251 net/ipv4/route.c:1258)
? __pfx_ipv4_link_failure (./include/linux/skbuff.h:4327)
? _raw_write_lock (./include/linux/instrumented.h:55 ./include/linux/atomic/atomic-instrumented.h:1301 ./include/asm-generic/qrwlock.h:98 ./include/linux/rwlock_api_smp.h:230 kernel/locking/spinlock.c:304)
? __pfx__raw_write_lock (kernel/locking/spinlock.c:175)
arp_error_report (./include/net/dst.h:438 net/ipv4/arp.c:296)
neigh_invalidate (net/core/neighbour.c:1077)
neigh_timer_handler (net/core/neighbour.c:1169)
[...]
Allocated by task 505:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
__kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
__kvmalloc_node_noprof (./include/linux/kasan.h:263 mm/slub.c:5334 mm/slub.c:6905)
alloc_netdev_mqs (net/core/dev.c:12055 (discriminator 2))
rtnl_create_link (net/core/rtnetlink.c:3721)
rtnl_newlink (net/core/rtnetlink.c:3903 net/core/rtnetlink.c:4044 net/core/rtnetlink.c:4159)
rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
[...]
Freed by task 536:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (./include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6692)
device_release (drivers/base/core.c:2636)
kobject_put (lib/kobject.c:689 lib/kobject.c:720 ./include/linux/kref.h:65 lib/kobject.c:737)
netdev_run_todo (net/core/dev.c:11756)
rtnl_dellink (net/core/rtnetlink.c:157 ./include/linux/rtnetlink.h:135 net/core/rtnetlink.c:3651)
rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
[...]

Fix this by restoring skb->dev to the master at the end of each slave's
iteration.

Fixes: 0cc0c2e661af ("net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit")
Reported-by: Vega <vega@nebusec.ai>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_teql.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 5c42a29a981c..9e52afc2d980 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -377,6 +377,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			nores = 1;
 			break;
 		}
+		skb->dev = dev;
 		__skb_pull(skb, skb_network_offset(skb));
 	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
-- 
2.55.0

