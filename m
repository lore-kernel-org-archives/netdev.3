Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609E38A72B
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098886; cv=none; b=KdJMV/WnEtUr0wBfcXafNuoqBVhJMuFwGG6FxW7Mqu/0uXNeWOiOb2KlDPBdAFIT3rZbDks3jhVoqHYaZPjgWqo+AcskuwlvzVxlxzyu7MuQv0ZlIN5Gl3T3h/1JiyM2+487W5HxD4Ui1tO/blZPbJxzbz98x8ZDXQMuOqovlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098886; c=relaxed/simple;
	bh=7ZGFJi1Tw0QxpKzaA4112Co/fYEKIQvtec5peI9QIT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KyPneVdjaKyUTCTG/WyEquSdxF8CaV4TRrzSs4iqW3qdDzadSeI4VCyoHX7+cyGFAWaeVnYVTXdpUAptj1akEAw1AVssXwsi5ojLCQ9JHWCUdwBQL4qvErgziK4S0UUMIEpNdfzJmUperfVUcUWOqvggveBBoLRb7Tu7uoKW4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sf0TmQvN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf0TmQvN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93703cc9e2dso31262785a.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 17:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787098876; x=1787703676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=srzljoPEhNJ1BkMUMJRW9e/8iKXpV+6wETzcN3+pJcQ=;
        b=sf0TmQvNd0k3RK8VzTNEhyAMiCq5XEEvIom8XTI14EkDufZ5aPXsYfV1QD2ple5ZQ0
         urCpkgeHO2IquKNGx8h4q6i7YAmETYVopv/vhNfImWetaS6VR4RcesG/GNAaZoKG+rGD
         g1puMCzuimvIVDCbiqCfPU/RncmuXulPzSjhz7WTGt0CQ7i+ZAqOmFyYkZxvK3ZOpFf4
         pi0kOdXCLoHgo67iHMcY8d23RvwZjSih7pwOhm3huNnipuLlbB8GpBI97ru9A0obUWZ9
         Oky54pMuUX7y4Xn3TYc6ZpZzlto30oOcrFnss+Yp2MnnDFZc0oQKR0yPCMpE3uu3EfD7
         jnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787098876; x=1787703676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=srzljoPEhNJ1BkMUMJRW9e/8iKXpV+6wETzcN3+pJcQ=;
        b=LfKiOx/aq275yHzIGPpoUJ72C744Yzugnc6CoLmgghp3n6H4/vOYwgugJwzcxsdFo3
         qtEygpIzKC0shC+Uh/zKxmgg5fiwQFOSNRxUEQN3Jr14Xp3+FutrX+nWs1o9sKOKM7CW
         GzfOla+dhfD2WVBP+0ASP+2H8ATouckZqYjUQibOwP4QhIlNNK5XinmlA7d2E1DDP93j
         +bLkbqtvidZ+ydjhWFcMXBPA50XEzdBuAVNfUtYdtUYlMe1xY2i8ESYemdd94VcoUs+7
         c8DaMDrl56n1GwgivWr6ipXTLVhxSTDn8AWc3eiI81NVDrl8arJcFC/+sOWIJJGh1EFB
         II5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqmWLvNpjZAlQArRbXyAroSdwyRMO9QP0BGvh6RLThoqjOj+50iLwUy/MI9tVdOsCnxth6GFgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBETVlVkrQyPutjPiSzGikUwnOz0y6F4IXtJg3h+HbFB4G79fh
	kf9mpqvzxnziA8ntjBemfbUNgBUQAOI+VPx6R6cKFUNE/8DmXI11Oos7rljRPRSX
X-Gm-Gg: AR+sD11xpJYZN2nMUCjhZ4WiYyTuqw8XeX+cdoz38Cchsf2JxxgyVDhtkjasgaUjvNw
	2XqpRdj2O5jOSypBaWxXU95hVNjxS+VCQaEpT9C4RY/gxjn0U3Y+FBVDjkVZOdgVaNguoS0nda/
	bc9rjusbRJMnmgfCNa0pQ6XMoPqrWVgiL1Mi/8yPu/4bWURvGy2rtZlaRHNuxR70BZk357Rzypf
	gbEOd8UWy7kKcgyNFM29PjeDvZBALhN84hxU23aMlSAR6WyraaeUJoG3V3U69wgZPqL/NUX/8W0
	IoBSsxmJ9aZfqTAj2Mb+39TtmUO2eKDJakjbYc5jkNIql6IIcVIpKF4zpu8eIjWqcO4EuNg8A6C
	CNn8yO5IPK1PkrNZV1Z3IXDbrMOA8b7L8OxWX9WvUc/j0F+8q4dm+6THpU2ChNRrbywf2dF9BKo
	MD5QlLzQbAFeIBAwEWBgJ2mSMhQV4F17PUtlDKoXtkL8NV8qsdYIqjcjEx0iKJz3yEHQeFpN1RQ
	VSfLktM3kSNSprw+Q==
X-Received: by 2002:a05:620a:4708:b0:930:f306:8275 with SMTP id af79cd13be357-9371e20fed9mr109795485a.9.1787098875889;
        Tue, 18 Aug 2026 17:21:15 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720582980sm15764985a.33.2026.08.18.17.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 17:21:15 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] nfc: KASAN: slab-use-after-free in nfc_llcp_rx_skb
Date: Tue, 18 Aug 2026 20:20:45 -0400
Message-ID: <20260819002050.3476701-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in nfc_llcp_rx_skb

on commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c (2026-01-04)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/70e3bdc241dbd675970fe89f30f0b84e

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

Decoded source path:

use: net/nfc/llcp_core.c:1185 in nfc_llcp_recv_disc(), reading sk->sk_state
     after nfc_llcp_sock_put() at line 1182; DISC dispatch is called from
     net/nfc/llcp_core.c:1483 in nfc_llcp_rx_skb().
free: concurrent socket release drops the final reference through
      net/nfc/llcp_sock.c:646 sock_put(), then sk_free() releases the same
      struct nfc_llcp_sock allocation.

[   81.172360][  T830] BUG: KASAN: slab-use-after-free in nfc_llcp_rx_skb (net/nfc/llcp_core.c:? net/nfc/llcp_core.c:1483)
[   81.173044][  T830] Read of size 1 at addr ffff888119369812 by task kworker/1:2/830
[   81.173940][  T830] Tainted: [B]=BAD_PAGE, [W]=WARN
[   81.173941][  T830] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   81.173943][  T830] Workqueue: events nfc_llcp_rx_work
[   81.173946][  T830] Call Trace:
[   81.173947][  T830]  <TASK>
[   81.173952][  T830]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
[   81.173959][  T830]  kasan_report (mm/kasan/report.c:597)
[   81.173965][  T830]  nfc_llcp_rx_skb (net/nfc/llcp_core.c:? net/nfc/llcp_core.c:1483)
[   81.173973][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
[   81.173976][  T830]  process_scheduled_works (kernel/workqueue.c:3262 kernel/workqueue.c:3340)
[   81.173980][  T830]  worker_thread (./include/linux/list.h:381 kernel/workqueue.c:946 kernel/workqueue.c:3422)
[   81.173984][  T830]  kthread (kernel/kthread.c:465)
[   81.174000][  T830]  ret_from_fork (archkernel/process.c:164)
[   81.174011][  T830]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[   81.174014][  T830]  </TASK>
[   81.187221][  T830] Allocated by task 4409 on cpu 1 at 75.384100s:
[   81.188593][  T830]  __kmalloc_noprof (mm/slub.c:5658 mm/slub.c:5669)
[   81.189018][  T830]  sk_prot_alloc (./include/linux/slab.h:961 net/core/sock.c:2245)
[   81.189420][  T830]  sk_alloc (net/core/sock.c:2301)
[   81.189779][  T830]  nfc_llcp_sock_alloc (net/nfc/llcp_sock.c:979)
[   81.190222][  T830]  nfc_llcp_rx_skb (net/nfc/llcp_core.c:971 net/nfc/llcp_core.c:1478)
[   81.190656][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
[   81.193365][  T830] Freed by task 31 on cpu 196609 at 78.490492s:
[   81.195183][  T830]  kfree (mm/slub.c:6670 mm/slub.c:6878)
[   81.195531][  T830]  __sk_destruct (net/core/sock.c:2285 net/core/sock.c:2384)
[   81.195937][  T830]  nfc_llcp_rx_skb (.net/sock.h:? net/nfc/llcp_core.c:233 net/nfc/llcp_core.c:1194 net/nfc/llcp_core.c:1483)
[   81.196379][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
[   81.199084][  T830] The buggy address belongs to the object at ffff888119369800
[   81.199084][  T830]  which belongs to the cache kmalloc-1k of size 1024
[   81.200297][  T830] The buggy address is located 18 bytes inside of
[   81.200297][  T830]  freed 1024-byte region [ffff888119369800, ffff888119369c00)


Best,
Shuangpeng
