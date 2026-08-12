Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EB352027
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524884; cv=none; b=fej+ZSE9OAwEorJ1Sy93qQBRGftU67LtbywIQM3S3ih+UXa4/v2EREb/swgX2pCLRWe8XrE+uZXcivMnkxh7EsxAor1boGyZZNr4SdaohL8ufwEBnuR/Q4TkfVj4JRLQjq0gKsqT+huaiy9/kOvpec0CYTBn0PoKLw80H+V9Gtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524884; c=relaxed/simple;
	bh=8laasiKnt6XQjfrd8WqX3E4XGCHTAlIMrhz3mlvy+ho=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H48CuybuvbaVJFfcYEJUN73vsetymzElSkTP9HP445oNVvqtbsCaezzGgajRulb2l3AM04NTCoJJOLRGpYEFuO3SmE0EyY9unYEhQcIJUmAQ5EFwgLtHGZ7tjKAig57OrpueRKyRmOTC9nIjhCNJJF18YvulvQ7B9DBFgrt3QYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMvmBaz1; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMvmBaz1"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ac0a54110so82156385a.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786524882; x=1787129682; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dIxt4fJN8uUjrMuy3IGL/3oO3iEUAVsbMjaouvxwMKs=;
        b=tMvmBaz1xI7qbTItA2uyojg4SJJygDe08FJtfoEOaqY++sBWdqVDkkVSrUT13cfqkQ
         W4BAnQhtq3303uhyiDtxrl5kPvezt3ilPSw0Ljh3l5nHew8G6awea9Sci2qfFmw5KsLG
         i1EbS0iENUxo3yZkoXTaI/+O55wyUNOMHG+rXIprTQ/gx3WyzeyW8VLD5gjENEslw5RD
         Ma8ABjpej4sIKeKQAlX/G2raNjKhitJB8/wRpGfv/VjcGMqmL+MNjWQ04jdvH/hIRbkv
         sOeYFW8gb81FGGIzmUDrJ7PwFz2Klgv74O//R9ZBTVeHne0bAq7MYaWNFyWv06yvb5aN
         L5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524882; x=1787129682;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIxt4fJN8uUjrMuy3IGL/3oO3iEUAVsbMjaouvxwMKs=;
        b=kh7az3BNdnzDWmc+tFny6vt73viOuTei0VM64ZgbmP415sD0QD0TnGvwQdEoasIuTQ
         GZtM+mj1mXVMIZ1htvosqy1lWylQ22KupAybqiwLxfx83cRCp1dhX9ZyEcOv4boYj7Vu
         40oLF80v6Boy2GtY4GN4Af3WZG08tKi/oPvDcpnOvJAOo3oNmVWOqdlT9fBZFCjZews0
         9vqOWzAgsGaJeJsoRQV+PybUgO1oq3K9yRJhyKKp1tF12qazrWCpPul25X5BgZWUnd4t
         DD2ZXaTcHYBi4ropu6Fl0HNOVsU9zNQA3gsYBEIusg20ixaTcvAeTr3H+DrhFiDEPxk+
         72sw==
X-Forwarded-Encrypted: i=1; AHgh+Rp85NZg04KLXENbt7ALlzeKuRzQr75eoHWE8GwDvg00QlH1WV9TzUHa1/ChtPdZziFnoIYyvoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0F/fhNecCh59MY99XwdZx/O0lMKiTjzmJta44nrSTdSh3aX/
	WQDl1K5yM1Bu1SufnfWAUkl43uwUk8qyzbyL0mmd7A8Wa9at4Suc3gggghjt3biZKNzvVNTde5p
	lyCNqGtdnhFA2Vw==
X-Received: from qkgx7.prod.google.com ([2002:a05:620a:b47:b0:914:c024:5186])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a11b:b0:930:c12d:b915 with SMTP id af79cd13be357-936b3a5283dmr248802185a.18.1786524881743;
 Wed, 12 Aug 2026 01:54:41 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:54:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260812085440.3917924-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: prevent lockless data races in net_device
 TC structures
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+a181d44496a497911353@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

This patch series resolves lockless data races between fast-path packet
processing / qdisc schedulers (e.g. taprio advance_sched(), XPS queue
lookups, skb_tx_hash()) and control-path updates modifying traffic class
configurations on a net_device.

syzbot / KCSAN reported a data-race between advance_sched() reading
dev->num_tc in netdev_get_num_tc() and control-path updates writing
dev->num_tc in netdev_set_num_tc():
  ==================================================================
  BUG: KCSAN: data-race in advance_sched / netdev_set_num_tc
  write to 0xffff88811ac5c036 of 2 bytes by task 4434 on cpu 0:
    netdev_set_num_tc+0x... net/core/dev.c:3158
    ...
    tc_modify_qdisc+0x102a/0x1550 net/sched/sch_api.c:1844
    rtnetlink_rcv_msg+0x6a7/0x720 net/core/rtnetlink.c:7085
  read to 0xffff88811ac5c036 of 2 bytes by interrupt on cpu 1:
    netdev_get_num_tc include/linux/netdevice.h:2684 [inline]
    taprio_set_budgets net/sched/sch_taprio.c:667 [inline]
    advance_sched+0x58f/0x730 net/sched/sch_taprio.c:984
    __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
    __hrtimer_run_queues+0x1f8/0x510 kernel/time/hrtimer.c:2096
  value changed: 0x0000 -> 0x0001
  ==================================================================

Further inspection of the TC metadata structures on struct net_device
revealed three separate issues under concurrent lockless access:

1. struct netdev_tc_txq holds adjacent 16-bit offset and count fields
   that are written separately in netdev_set_tc_queue() (and cleared
   via memset() during reset), allowing lockless readers in fast-path
   helpers and drivers to observe torn/inconsistent states. This is fixed
   in Patch 1 by wrapping count and offset in a union with a u32
   combined field manipulated atomically via READ_ONCE()/WRITE_ONCE().

2. dev->num_tc is read locklessly in fast-path lookups and timer
   interrupts without READ_ONCE() annotations, while control paths modify
   it using plain writes. Patch 2 adds READ_ONCE()/WRITE_ONCE()
   annotations across core networking code and drivers.

3. dev->prio_tc_map is similarly read locklessly in fast-path helpers
   such as skb_tx_hash() while control paths update entries or clear the
   map via memset(). Patch 3 adds READ_ONCE()/WRITE_ONCE() annotations
   to netdev_get_prio_tc_map() and netdev_set_prio_tc_map() and replaces
   memset() with explicit atomic store loops.

Reported-by: syzbot+a181d44496a497911353@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a7c3457.d5f0ebe7.22d851.000a.GAE@google.com/T/#u

Eric Dumazet (3):
  net: prevent torn reads in netdev_tc_txq
  net: add READ_ONCE()/WRITE_ONCE() annotations for dev->num_tc
  net: add READ_ONCE()/WRITE_ONCE() annotations for dev->prio_tc_map

 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 12 +--
 drivers/net/ethernet/intel/igc/igc_tsn.c      |  8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  7 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +-
 drivers/net/ethernet/sfc/falcon/net_driver.h  |  2 +-
 drivers/net/ethernet/sfc/falcon/tx.c          | 16 ++--
 drivers/net/ethernet/sfc/siena/tx.c           | 12 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 14 +++-
 drivers/net/ethernet/ti/cpsw_priv.c           |  2 +-
 include/linux/netdevice.h                     | 21 +++--
 net/core/dev.c                                | 77 ++++++++++++-------
 net/core/net-sysfs.c                          |  2 +-
 net/sched/sch_mqprio.c                        |  4 +-
 net/sched/sch_mqprio_lib.c                    | 10 ++-
 net/sched/sch_taprio.c                        | 35 +++++----
 16 files changed, 143 insertions(+), 85 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

