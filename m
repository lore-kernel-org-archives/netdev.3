Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27C472F9A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109527; cv=none; b=PxqWfjMsdehATdwpL2SL4w6Pls0sT69/UNs/JBVFvHk5CxQ9TT4C9lSYj87Msvhx2fYYFlM05UFMTypA+g0JqHSOc1s2VxpnhE2n5+G3t62yykmD5b5SIpoW/fzzxKmp9Vhwt47kSTjCM8m0QPXn84OBfY1g4CRGunM5wTKkCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109527; c=relaxed/simple;
	bh=2bI4USJhE8vSZpLg3neqVj8QPvDXfbETdN8Qc/q0wP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofFNFu0/9hiTwtNddyi3mGiKlh/y9rQtLjPcl4yFfplHra4TmR9zgfWd7Bd/OkBrcP8FGkOC/whyGGgrHEBC7lyqZRyEOMNZdA73EdM8qp/ZolLLnW2Og5xtnrpQVqvuK9F+dYRWGu1qRP+R6qF7Zsm35zD5KaiI5GsCklDUwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=We5Q+IaG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="We5Q+IaG"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso2326628b3a.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786109524; x=1786714324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KFWlM388Lf40pRKG1/HIw4Wzf+kCFF6F/8bkvIfvbTY=;
        b=We5Q+IaGVxwa1NWH51RgEia6cKwS3psCNlepilBOdQ+qfBnuc2w38gV7co12P6AxXZ
         r3vG+weAJtKFSjnUk2HEUUR2EjyZqG+manATbNzXq3YVx11JVGcxMntQL18fj/cK1cCE
         wgFfjTaT7dzoL6PPHfvnBMDqwbLKJ+2qFH9jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786109524; x=1786714324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFWlM388Lf40pRKG1/HIw4Wzf+kCFF6F/8bkvIfvbTY=;
        b=PiTXQ4OafNLW+CDL5HTt3be75e1PpdMxy3ExjSZP81r2/c3HdaT/Vz4aYIx4PS+CJk
         ELKluuZzEkPGLhZUANYjTeJkPZ+PL6lrpPh3YHFwS9FWPpxf7btcmmmsa1VeFxCiF5uf
         NCPFVuRZ+EKnNWdb/1zElOx2EU4hzZzre2tqvBBU6JKUOND1Z43tw8KmjyF8bd4jGXOM
         ZcVDAcd9udstMbZbttKkLscIMdvIKyeeDwFXye68k14Hlgkbqn5rob83bYXWTUvoVF3d
         bVOjzECwUTLWKv139jHL38oEN/WHh5Bec04i0nAEo3j2BU+Ql7igdP7L9WKqdknmwoSL
         Enzg==
X-Forwarded-Encrypted: i=1; AHgh+RoBDd9SwoqnTybzdgbU34OzW7cSsN5NQFaKMMWBWgEpb7RuJOGQoZXk1JUGBP8C/3dLL8K1JU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAI+c3AC4jVPFmzqIJyznb7sIhROcteMQfSQCcEG/h1G6Ywj25
	U2WIOSFa572jner1jbBC+Q0qpbMovfsjIfFc2f0ZRhSGxQJPjh48NVwkmh7Z55yvIw==
X-Gm-Gg: AR+sD11vF9b5OkpBRno9bnDIAoBlEOYPMuf92aU2CAUb1F6xuv433Gcuh2oyiK5KAlt
	/bqMWEqLOIig0roS/XpDNBcoCxnJnsONPJ+6j+psRgLSY91wR4NLgsLxYl8qRGvuoy4Bh1MmRVG
	dLhj9Uud0V31Zo+G/S5TUPKvKSMMhhkym/TE1mDD0N4Et00vCa9AnxR5B0Z/S6fcEK0WuaVIydH
	uP8H6o2Pa8D3iQbQVPkbqFWcJLGe76QivvycbX5iG4x8xYKRoC2odBfRUk3RH46ENs1DgMvIKe+
	fmh0Sw2rb5GoXdOXO2vaKapGZ22HzkiDRBenuD972lBdbToOs/577q+FX/yywwra2goa0UMBSH4
	lZm97n9fz67/5xDJB0QcpmUlEhe7eKMQ/2JeFkYjIoCnkPwFyiUYVpXBmgDP4AzHNqWkLFlPXLB
	qpkPpSW882GWV3I8oelUAJrqAuyh/Q6xP0m719CsX12r4=
X-Received: by 2002:a05:6a00:4287:b0:84e:242:4bb2 with SMTP id d2e1a72fcca58-84f6929f601mr38821b3a.4.1786109524501;
        Fri, 07 Aug 2026 06:32:04 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a552142sm1055307b3a.44.2026.08.07.06.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:32:03 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	bestswngs@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net] net/sched: sch_teql: restore skb->dev on the slave failure path
Date: Fri,  7 Aug 2026 10:31:55 -0300
Message-ID: <20260807133155.1242599-1-victor@mojatatu.com>
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

