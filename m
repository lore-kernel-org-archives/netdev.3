Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103304;
	b=NVxInEAXnZzi75LEb8Xjt+hdsWJQrRJj9kzBSG7b+GEcS1uskyP6QYvSddXA+iiRhqp3
	 yzFE9biRtWs69IQvDZySlXwJoG5Q2boHj82yPv+rd1R1oOH5bvp54WfsL1cJeLXpfjQfb
	 Dp2lPXlBmmHzHSeFCRGmUdE2paZU5zuJMe2OBpEjf5kX7YAH6teBTPgGSKqfZXIfK7Nyi
	 1hlxjYZa9tqX9UJBCsfTG4Z0Iv6lCTqR/j5mzNfQi+zny0yI+kV7IMNW/y0HzXm35ZfX3
	 JiyQHkmM/7org2QYwgNdAEI3hVCjwWjGsqur/N9RHyegtGTzT9+lCW22dXNYHDDbI/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1s6Zqp4u3sfnKK/Y6nM0BOKcsidnRWEc87L5yFDAZSw=;
	b=4ABKGzH1/oqC8/pDFeCm8tnZ9k6yfj3UA9tLrqMHqbx2RETzJq/WAI8FzwJpjyrinO23
	 fCf2Gg/xuieNHMPf67XLbzE/JjcH2TCzJp6WqK/2HZEepXp/VDub5pTOZ05JCg7p6z8WQ
	 gPHvhiufTCWGsfRYTl7jnIHMSuW1kL/sKF6+pjdm/9CwMbJTjinJxbcOMrTVlzAztYHEO
	 h7z8j5t9U8WKO8dTv3scq2UQOO12Sk/VndSLIfvfK0UC7CvNUiXuxDkq3b/w2/Mj4aNTL
	 8AMphkCTbCBNa64nMESPTON4u3DV+HFg+sdSv8FzsbjLfHRa8sCeJlbNqIOs5Vx1RRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kCaN4kXU;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91860A5BE5
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D91860A5BE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kCaN4kXU
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2107550a91.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1793103302; x=1793708102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1s6Zqp4u3sfnKK/Y6nM0BOKcsidnRWEc87L5yFDAZSw=;
        b=kCaN4kXUWs+WF58zqZU+j0HzC5ztqhWAp79Vb/yVnCTDn/596GNhci3YNYBAE3dKZR
         6txfVXlxwleK3QTSOWFJjYWac6kqW84CUQ/PDKa/7qxL1MA8nW6FoBIplyDAT6dLwq65
         DePtNimtfCqeoz9ndE/jxkFh5M5MbVa8Oyhb/ajzjzn8Kp2N2vXbT/fCjff6KyslXvg9
         c+4vT3ikHiXGj9LN+q7LhS/yYBLkj6D2glsgDewtVfrgdMV6/7t0X30EXQY2ZMjTMpmy
         ik5DYI9/y0qc5RKFKjCs1J63LxZJO4gV7fYwvl6rKUJLoJYr82dSp82Pj6TgVoBLBS2e
         vPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103302; x=1793708102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1s6Zqp4u3sfnKK/Y6nM0BOKcsidnRWEc87L5yFDAZSw=;
        b=G3oqRQbol6Aus+WtcqltzYk8M+63Yp6N5SUMzT4o2/XF1ozIjPsrmoWq4rdshLEn95
         zWLbCZgvgIez/1j6xDrSm/muuZKuCPZIGhZfv1b84lJSHAWZ+xtS9ZBjFAp0z851Gotl
         BDnDJa5jJcGVYsNl9qLfsfDj2Qu4Rg7+P8TH9LdcU0eFGr06AxYNnDumz7JgqkYO2rz3
         Jwxu1XMk8/z+cGW3BdxZ95wF9IPouvQcU3I0mkHl7SbhYYeahKWBKfPmGGzGGWak/OiV
         esMTqnFkWNagMZ0vaQQt+K4iU5CcHo+43xIK/D8CM/ZC1BXSe+jV4e2/g1SGkxnGBjJO
         AY0A==
X-Forwarded-Encrypted: i=1; AKwUvByu8aR3DqjTU+daWOg2iX+tVl1XJB5lW2LwEXb0TaPcyAa0UZG9TXUaCvJ11BoitREQDubkNqM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdO8poQh+mOf7/XA2NUB6Oc24uS2onCUZzkwjHCSO5LAD1GQw+
	9PzAkQXGHcgj1LnetYXc6M9CYqoJ6UIHGYX8h8Wmx1/11YkHpcIipIoclgtywQ85Bno=
X-Gm-Gg: AYBFou2sFSJt3nsCGghJCdCjlwQHihMgR5O3BLdDvxzIoDsuSCRW1WUCukXqkQX7BwL
	XElrpjtcm9jxAp926osN/4Jm3wGnUhI470050HUcANCeyuD1Js5qJ0BwNaPH3bGtAp/hkY/s7S8
	FtqiKqwiXAIZHgo3FjyvlFyN0QkxX73x7SYTZAiL2HZ/RZVZ8QG7SzubIw+A9ABFAAznZA5AnZb
	pAKcQS04ctcyh0w1irBQ5PIFOkhcC+HXar39CymwUmmGxwVCAV/3LmRrD/M7hUIJUCUi/eahrw3
	N9izEr+pZBJtENM0uubgf0hoy6wz04JD9fH7cf21TlF2Fu56yd3uxwPfPy/gCZ9aYsNPaxHxX7k
	KYAoXpejVqH5Yq1/L9gt1b/dB+WujzhuDTSHwBWU47opavLxIDRjXPzoeuCS5S3J84RC+4KACHC
	Yj0P75nZhzeWRgcCNkJ85oOykl2Iyam5y18sROOfcOa2DWoib6z3/c4nTFB/qv26L6brLyfjx49
	iqvwWw3GPN6BSHRbdewbNk1so1jbZXQeIvmbAdbaZklQuag/9jRy1SgdOv+trpgiTcYOovkafVa
	p5FZPsRyBGdyH/8kpKZr+7eASlU8AhTioAnJSLG2pr5rJnMmDTKbBZUSII5d9sA2cA==
X-Received: by 2002:a17:90b:2542:b0:3ac:adce:60a8 with SMTP id 98e67ed59e1d1-3ade9b2cf27mr7977855a91.5.1793103301318;
        Tue, 27 Oct 2026 05:15:01 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:df24:cbdb:a2dc:d464])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cc9073c2sm2915176a12.0.2026.10.27.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:15:00 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH] xen-netback: wait for RCU readers before freeing queues on error
Date: Tue, 27 Oct 2026 21:14:38 +0900
Message-ID: <20261027121438.1266207-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

The connect() error path frees vif->queues without first waiting for
RCU readers, unlike backend_disconnect() which publishes num_queues = 0,
calls synchronize_net() and only then frees the array.

The net device is registered in xenvif_alloc() during probe, so it is
already live when connect() runs. xenvif_get_stats64() and
xenvif_get_ethtool_stats() read it through the usual stats paths, taking
rcu_read_lock(), sampling num_queues with READ_ONCE() and then
dereferencing vif->queues[i].

A guest can drive connect() into the error path by handing the backend a
bad ring reference or event channel for one of its queues, which makes
connect_data_rings() fail and connect() jump to err: with num_queues
still counting the queues already set up. The error path calls
vfree(vif->queues) without a preceding synchronize_net(), so a reader
that has already sampled a non-zero num_queues and loaded the vif->queues
pointer goes on to dereference the freed vmalloc array.

KASAN catches the read of the freed queue array in xenvif_get_stats()
while a guest repeatedly forces the error path and dom0 reads
/proc/net/dev. Generic KASAN labels a freed vmalloc region
vmalloc-out-of-bounds, since the use-after-free label is reserved for
slab and page objects:

  [  160.524029] ==================================================================
  [  160.527557] BUG: KASAN: vmalloc-out-of-bounds in xenvif_get_stats+0x28f/0x390
  [  160.530848] Read of size 8 at addr ffffc90005de06a8 by task cat/10519
  [  160.533831]
  [  160.534844] CPU: 1 UID: 0 PID: 10519 Comm: cat Not tainted 7.3.0-kCTLwide2-15482-g21a7f44fd076-dirty #2 PREEMPT(full)
  [  160.534849] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  [  160.534855] Call Trace:
  [  160.534868]  <TASK>
  [  160.534870]  dump_stack_lvl+0x64/0x80
  [  160.534885]  print_report+0xd0/0x630
  [  160.534918]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  [  160.534933]  ? xenvif_get_stats+0x28f/0x390
  [  160.534938]  kasan_report+0xce/0x100
  [  160.534943]  ? xenvif_get_stats+0x28f/0x390
  [  160.534947]  xenvif_get_stats+0x28f/0x390
  [  160.534952]  dev_get_stats+0x2db/0xb50
  [  160.534961]  ? dev_seq_printf_stats+0x446/0x7b0
  [  160.534979]  dev_seq_printf_stats+0x9e/0x7b0
  [  160.534982]  ? __pfx_dev_seq_printf_stats+0x10/0x10
  [  160.534987]  ? dev_seq_next+0xe0/0x1b0
  [  160.534990]  ? __pfx_dev_seq_next+0x10/0x10
  [  160.534993]  ? __asan_memcpy+0x3c/0x60
  [  160.534997]  dev_seq_show+0xf/0x30
  [  160.535000]  seq_read_iter+0x8f3/0x1190
  [  160.535018]  ? alloc_pipe_info+0x2c2/0x430
  [  160.535030]  seq_read+0x267/0x3d0
  [  160.535033]  ? __pfx_seq_read+0x10/0x10
  [  160.535038]  ? __pfx_do_mmap+0x10/0x10
  [  160.535054]  proc_reg_read+0x1ab/0x270
  [  160.535077]  vfs_read+0x177/0xa20
  [  160.535085]  ? __pfx_vfs_read+0x10/0x10
  [  160.535089]  ? vm_mmap_pgoff+0x24b/0x310
  [  160.535108]  ? __pfx_vm_mmap_pgoff+0x10/0x10
  [  160.535116]  ? fdget_pos+0x1ca/0x4b0
  [  160.535124]  ksys_read+0xf7/0x1c0
  [  160.535128]  ? __pfx_ksys_read+0x10/0x10
  [  160.535132]  do_syscall_64+0xe2/0x4b0
  [  160.535141]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [  160.535149] RIP: 0033:0x463aa1
  [  160.535156] Code: 00 4c 89 d2 4c 89 c6 e9 fd fd ff ff 0f 1f 44 00 00 31 c0 c3 0f 1f 44 00 00 f3 0f 1e fa 80 3d ec 22 1a 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
  [  160.535168] RSP: 002b:00007fff303dbeb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  [  160.535176] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000463aa1
  [  160.535178] RDX: 0000000000010000 RSI: 00007f9becf9f000 RDI: 0000000000000003
  [  160.535180] RBP: 00007fff303dbee0 R08: ffffffffffffffff R09: 0000000000000000
  [  160.535182] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f9becf9f000
  [  160.535183] R13: 0000000000010000 R14: 0000000000000001 R15: 0000000000000000
  [  160.535186]  </TASK>
  [  160.535188]
  [  160.636633] The buggy address belongs to a vmalloc virtual mapping
  [  160.639416] Memory state around the buggy address:
  [  160.641738]  ffffc90005de0580: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.662534]  ffffc90005de0600: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.665865] >ffffc90005de0680: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.669222]                                   ^
  [  160.671430]  ffffc90005de0700: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.674771]  ffffc90005de0780: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.678102] ==================================================================

Mirror the teardown that backend_disconnect() already performs. Snapshot
num_queues, publish num_queues = 0, call synchronize_net() to wait for
in-flight readers, and only then deinit and free the array using the
snapshot.

Fixes: b17075d5c198 ("xen-netback: fix race condition on XenBus disconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/xen-netback/xenbus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index e020f44ac2c717..d1c9e38cfb8ef2 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -835,10 +835,21 @@ static void connect(struct backend_info *be)
 	return;
 
 err:
-	if (be->vif->num_queues > 0)
+	if (be->vif->num_queues > 0) {
+		unsigned int num_queues = be->vif->num_queues;
+
 		xenvif_disconnect_data(be->vif); /* Clean up existing queues */
-	for (queue_index = 0; queue_index < be->vif->num_queues; ++queue_index)
-		xenvif_deinit_queue(&be->vif->queues[queue_index]);
+
+		/*
+		 * Mirror backend_disconnect(): publish num_queues == 0 and
+		 * synchronize_net() so RCU stats readers finish before the free.
+		 */
+		be->vif->num_queues = 0;
+		synchronize_net();
+
+		for (queue_index = 0; queue_index < num_queues; ++queue_index)
+			xenvif_deinit_queue(&be->vif->queues[queue_index]);
+	}
 	vfree(be->vif->queues);
 	be->vif->queues = NULL;
 	be->vif->num_queues = 0;
-- 
2.43.0

