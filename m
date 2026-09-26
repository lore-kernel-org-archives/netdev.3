Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E6394470
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452156; cv=none; b=Q7hKrIXwSMkvqX0H49YCZPvWJaDCFz/Cz6O5WpqSRrnSQuNVyscDm2jNwDqoQcvFXjbh977Iox48I6wNYmFR+0kgSway06qgr+eXnpcpguJqp3pDANWh3wI6cd3ScjrxBTSNztxRr6iZmPT4FgKuIt1wQ8RlubQM5bz7G1ZO5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452156; c=relaxed/simple;
	bh=86lv4lHujufC/MdEtxBwNtZp5mb9mhoAHIEZILvYMSw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=n97F3g4BFQZVP7Z5pGh4AtERqM/46L4wmWnWz3dFbe6u2+4rtGsXzOcB6CP1+xoFBEmEcrnd5ucJ91UixzZ14iLeaEal3zg+WOod7d3PrkBVuJVwl00nG2OYHw20+q+by2DiC81fcV0CFZDRjTJKrhRQPvetfkkdX5VwGKGdWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s.arstneio.ch; spf=none smtp.mailfrom=s.arstneio.ch; dkim=pass (2048-bit key) header.d=arstneio.ch header.i=@arstneio.ch header.b=krqaJ3/Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RsBN8SxM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s.arstneio.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=s.arstneio.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arstneio.ch header.i=@arstneio.ch header.b="krqaJ3/Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RsBN8SxM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE74C1400080;
	Sat, 26 Sep 2026 15:49:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 26 Sep 2026 15:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arstneio.ch; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790452149; x=1790538549; bh=uEokbQjwrr
	/A8JGoqsYgmfVQOQi2wRbXdjf3mNRRguE=; b=krqaJ3/YmRnHEw+4PZMPgBnEoc
	0ZIHS1E/4Td0WOIWFkznXH1B/eYE92kqxIW7jW+wEbr3m6GQ3dwIQ9HYnNEr4w03
	fVbXYG1q2ztmsWoVS/n9Nh0xm6qQlDcubrLVIo/f+XW87MVdqyzdDDRsTCkmyJkp
	PP2v9T0CjTrceXTHJgtLk+FVjHOehtjvNdK3zK6CrK8Zcp1RZviBCXJkzKQu/dN6
	M6Osi6hHzAHGV+/ZVbSyW+gSsMaS5bToArAJDMCX8WmSdIW1JLVrmDva9ELq1vWQ
	Ni6NiWluuMcagce2y7P3UubJyoDMJn+MgttZ7rv4tmUY9eYx/Qyv2LDjCoHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790452149; x=1790538549; bh=uEokbQjwrr/A8JGoqsYgmfVQOQi2wRbXdjf
	3mNRRguE=; b=RsBN8SxMvrpDjNdeyjdR/BtwfzQyFYOfhjXH5cLaDHPRvOabGvZ
	9RXj2WhfNhXDzRXTsWLRkYc3Pm6+lLy5fHmsmaWMiJ48h5DjFctVHPe8OBv7GzNt
	eoHNMPou0afsHDGFwR4PoU0k4rbmWy8VcKmZ2Nus9mCB1Ks4R1ynhxUou/ImAyDC
	6+MchDWWuCFE90v/+FwfzcJA+Pv90KI7CfZ3gnXD5E10YM1jmowCvc1T7N26owkZ
	46mWAZNgFy/iBM2UtoSzKdHAGpZfXYuYUJuifmYDqFbpR4snK67RTAI5ZlWZcPiz
	tKSxQzi70BaA1JAt3jMr1dt1RKfLO+rwuxA==
X-ME-Sender: <xms:tSG4artVCQyyn1ov912U4S3XHslRS00nfjOqn3JasHo-WEVkZ6BhGQ>
    <xme:tSG4aici943zp1Yf9YisP3QurIkrQQZBBmlwXEJ2v2I6xjbgpayOu_dzqhllCvGPw
    ujF0ssYo4lU4da_Zt_tBvAmcurircxnsnEBUxyKS1C_jsrcdv-Wgk88>
X-ME-Received: <xmr:tSG4asaKJf375ODaEVCOri1pkC4P7Ov2mqHIwohjkfDbLdAeID3C4eHFh3oOkL-1>
X-ME-Proxy-Cause: dmFkZTGvg05u4BulJkIIj1mPnd2FqDeQ4u1lo4ZE1kffl84CrB0nIbO6WOzy0AY4gSu2CA
    96+YjTwajJYi+62HIffoc/iAzQLKnBzfK08cbJA+6J4tot002UpnZtVxrPGApQ9Ru5XQWk
    IYUZ0X3AVFIPOS3am/c5qyABvMcEDEvQGRMFASfHuttDNvotsBxRfcutGNIM4fnue17WkR
    D8zAF3Pj2GmnxAVFmvZQyGa57YA7qTBV8tOuAA/iZmDL3EYFez6l9st3aH/ZocnaEZ+aKH
    kSet0xEjJslkxCTu1u2iq8T3gc7wZWTJNA1PVrTgO7mv9KUI/9pmGLUnJsK1EjRiE5fMrg
    60Gv3uVKEQKYskAjm85oAoI3ClkEpJMab6n4XnozA7NAk8HVFw0+oqPlX1j2fZZUJVgdL2
    WvLS+KuKCj+0hFlizW0/K5UPVUm3CaKvqvDZ9n7ke7/AHNYWn/RjiywkhaNu1KeurlLoYY
    dR1/a1TAQRih+mrwUnT5J4V1ReE3c7YCXEwFQNLCJCGb11+O55PchBBLGfs7XiMfcoA2VH
    wMuuoMELvkNm+QE03MRE6CmUDcV2Z+boF7cIiMlK56Qn86nUW8WllkWrqPB0mxlQO1+IGW
    f5WqXAJ+gPYDsToIY2Vs253tJiqZ8iTh3ANt+GB2W+qSLyTyiupCIQaO8MuQ
X-ME-Proxy: <xmx:tSG4alVDDE7UldZJyFAM8r1huDBW_4n4-ugiBigs_9bF5gt_rSLPHw>
    <xmx:tSG4auiG2fG2atgVzdk9lZmke83zRdu7a9Gp-KK73SfBPaRF_xXjhg>
    <xmx:tSG4ajXMSpRMTaH_Xo2uD-7uE0p4gFF5XuKR-me6EeIlVgHMYOXjJg>
    <xmx:tSG4alNDwWlbznRs143snMDnhbMnZSm2tqegEl2MQPdTtNUTw5nTHQ>
    <xmx:tSG4agLQ5-cPAbXLFgAz85pfAc7V9iD7tueMBkrbuj9biL1FEMbMVcH->
Feedback-ID: if971441f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 15:49:08 -0400 (EDT)
Message-ID: <b382cde0-7a2f-4251-8b9c-6763c3fe4cad@s.arstneio.ch>
Date: Sat, 26 Sep 2026 21:49:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org, sukhdeeps@marvell.com
From: Stephan Hauser <kernel.org@s.arstneio.ch>
Subject: [BUG] atlantic: resume from S3 fails with -ENOMEM in aq_ring_alloc(),
 leaves unusable netdev
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The atlantic driver intermittently fails to resume an AQC107 from suspend-to-RAM.
aq_nic_init() reallocates its per-ring software buffer arrays from the PM resume
path, where the PM core has restricted allocations to GFP_NOIO. With the default
ring sizes these are order-5 and order-6 requests (128 KiB and 256 KiB), which
cannot reliably be satisfied in a context that can neither reclaim, compact, nor
dip into reserves.

Resume then returns -ENOMEM and the device is left half-initialised: the netdev
still exists and is still marked IFF_UP, but has no rings and no vectors. It
passes no traffic, DHCP never completes, and bringing the link down hangs.

I have 3 occurrences in 60 suspend/resume cycles (5%) over 5.5 weeks of journal,
across kernels 7.1.4 and 7.2.2. What makes this worth reporting rather than
filing under "memory was tight": the three failures have three *different*
proximate causes in the allocator, detailed below. The allocation is fragile in
several independent ways at once, which is why no amount of tuning fixes it.

Two distinct problems:

  1. A >PAGE_ALLOC_COSTLY_ORDER kmalloc() on the resume path, for memory that
     never needs to be physically contiguous.
  2. atl_resume_common() does not unwind when aq_nic_init() fails, so an
     allocation failure is converted into a wedged interface.


Disclosure
----------

The analysis in this report, and the text of the report itself, were produced
with the assistance of Claude (Anthropic). Please weigh it accordingly.

What is directly evidenced: the hardware is real and in front of me, and every
log line, zone dump and free-page histogram quoted below is verbatim from my
journal. The failure counts come from scanning all boots in that journal.

What is inference rather than measurement, and where I would welcome a second
opinion:

  - The 64-byte element size is derived from the two reported allocation
    orders, not read out of the source.
  - The TX-before-RX ordering in aq_vec_ring_alloc(), and the claim that
    aq_nic_init() aborts on first failure, are inferred from the backtrace and
    from only ever seeing a single warning per event.
  - The ZONE_DMA32 lowmem_reserve arithmetic in case 3 is hand-computed from
    the zone dump.
  - The aq_nic_stop() attribution for the link-down hang is a guess; I say so
    again where it appears.
  - The suggested fixes were not compiled or tested, and were written without
    the source tree to hand. Treat them as a direction, not a patch.

I have read the whole thing and stand behind reporting it, but I have not
personally verified the driver internals against the code.


System
------

  Kernel:    7.1.4 and 7.2.2 (also running 7.2.7), x86_64, PREEMPT(lazy)
  Hardware:  Micro-Star International Co., Ltd. MEG X570 UNIFY (MS-7C35),
             BIOS A.80 01/22/2021
  NIC:       Aquantia AQC107 NBase-T/IEEE 802.3an [Atlantic 10G] (rev 02)
             PCI 0000:24:00.0, [1d6a:07b1], subsystem [1d6a:0001]
  Driver:    atlantic, firmware-version 3.1.100
  Rings:     rx 2048 / tx 4096 (driver defaults; maximum 8184), 8 vectors
  Memory:    64 GB, no swap configured


Reproduction
------------

Not reproducible on demand. Correlates with uptime and page cache size:

  1. Boot, use the machine until the page cache has filled most of RAM.
  2. echo mem > /sys/power/state
  3. Resume.

In one boot, a suspend/resume at t=11793s succeeded and one at t=52899s in the
same boot failed.


The allocation
--------------

From the backtrace this is a large kmalloc (__GFP_COMP|__GFP_ZERO, falling
through __kmalloc_large_node_noprof() straight to the page allocator), i.e. a
kcalloc() of the per-ring software buffer array — CPU-side per-descriptor
bookkeeping, not the DMA descriptor ring, which is allocated separately via
dma_alloc_coherent().

The two reported orders pin the element size at 64 bytes:

  tx ring  4096 * 64 B = 262144 B = order 6
  rx ring  2048 * 64 B = 131072 B = order 5

aq_vec_ring_alloc() allocates TX before RX and aq_nic_init() aborts on the first
failure, so an order-6 report means the very first ring failed, and an order-5
report means some TX rings succeeded first. With 8 vectors the driver asks for
8 order-6 plus 8 order-5 blocks on every single resume.

pm_restrict_gfp_mask() clears __GFP_IO/__GFP_FS for the duration of
suspend/resume, so the driver's GFP_KERNEL is silently downgraded to GFP_NOIO
underneath it. It cannot write back, and compaction is largely defeated.


The three failures
------------------

1) 2026-08-31, kernel 7.1.4, order:6 — fragmentation at exactly order 6

   Node 0 Normal free:3363056kB boost:283840kB min:348116kB
   Node 0 Normal: 46873*4kB (UME) 74929*8kB (UME) 63460*16kB (UME) 33869*32kB (UME) 5476*64kB (UME) 959*128kB (UM) 0*256kB 1*512kB (H) 1*1024kB (H) 0*2048kB 0*4096kB = 3360844kB

   3.2 GB free, comfortably above the watermark, and 959 free order-5 blocks —
   but zero at order 6. The only blocks above that are marked (H),
   MIGRATE_HIGHATOMIC, and so unavailable here.

   Note what this means: had the TX ring been order 5 rather than order 6, this
   resume would have succeeded. The default tx ring size of 4096 sits exactly
   one order above what the zone could serve.

2) 2026-09-25, kernel 7.2.2, order:6 — below the min watermark

   Node 0 Normal free:342528kB boost:283840kB min:348116kB
   Node 0 Normal: 204*4kB (ME) 293*8kB (UME) 5378*16kB (UME) 1673*32kB (UME) 1175*64kB (UMH) 601*128kB (UMH) 173*256kB (M) 2*512kB (M) 0*1024kB 0*2048kB 0*4096kB = 340184kB

   Here there were 173 free order-6 blocks and 601 at order 5 — fragmentation
   was not the problem. The zone was simply 5.5 MB below its min watermark, so
   the watermark check rejects the request at any order. GFP_NOIO cannot reclaim
   its way back above the watermark and cannot touch reserves.

   No ring size would have helped this one.

3) 2026-09-26, kernel 7.2.2, order:5 — high-order lists drained mid-loop

   Node 0 Normal free:803236kB boost:283840kB min:348116kB
   Node 0 Normal: 37466*4kB (UME) 19631*8kB (UME) 10676*16kB (UME) 8307*32kB (UME) 892*64kB (UME) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 800640kB

   800 MB free, above the watermark, but nothing at order 5 or above; 46 GB of
   page cache (the bulk of it readahead) had shredded the zone. The earlier
   order-6 TX allocations in the same loop succeeded and consumed the last of
   the high-order blocks; the following order-5 RX allocation then found the
   order-5 and order-6 lists both empty.

   ZONE_DMA32 had order-5 blocks free but appears to be excluded by
   lowmem_reserve rather than by lack of suitable pages:

     Node 0 DMA32 free:247268kB min:3288kB
     lowmem_reserve[]: 0 0 61020 61020 61020

     free 61817 pages - (min 822 + reserve 61020) = -25 pages

   About 25 pages short of passing the check, so the fallback zone was closed
   too. (This last bit is my arithmetic off the zone dump, not instrumented.)

Note that ZONE_NORMAL is in watermark boost (boost:283840) in all three cases,
i.e. kswapd was already working on recovering high-order blocks and had not
caught up by the time resume ran.


Log (case 3)
------------

[52902.114499] kworker/u97:42: page allocation failure: order:5, mode:0x40d00(GFP_NOIO|__GFP_ZERO|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
[52902.114508] CPU: 17 UID: 0 PID: 363518 Comm: kworker/u97:42 Not tainted 7.2.2 #1-NixOS PREEMPT(lazy)
[52902.114511] Hardware name: Micro-Star International Co., Ltd. MS-7C35/MEG X570 UNIFY (MS-7C35), BIOS A.80 01/22/2021
[52902.114512] Workqueue: async async_run_entry_fn
[52902.114517] Call Trace:
[52902.114518]  <TASK>
[52902.114521]  dump_stack_lvl+0x5d/0x80
[52902.114526]  warn_alloc+0x158/0x180
[52902.114535]  __alloc_frozen_pages_noprof+0x77a/0x1710
[52902.114544]  alloc_pages_mpol+0xb6/0x170
[52902.114548]  ___kmalloc_large_node+0xb3/0xd0
[52902.114552]  __kmalloc_large_node_noprof+0x1d/0xc0
[52902.114555]  __kmalloc_noprof+0x424/0x590
[52902.114573]  aq_ring_alloc+0x4a/0xd0 [atlantic]
[52902.114581]  aq_vec_ring_alloc+0x9d/0x1d0 [atlantic]
[52902.114589]  aq_nic_init+0x116/0x1e0 [atlantic]
[52902.114597]  atl_resume_common+0x43/0xd0 [atlantic]
[52902.114607]  dpm_run_callback+0x4e/0x160
[52902.114613]  device_resume+0x15c/0x260
[52902.114616]  async_resume+0x21/0x30
[52902.114618]  async_run_entry_fn+0x34/0x150
[52902.114620]  process_one_work+0x199/0x370
[52902.114624]  worker_thread+0x177/0x2e0
[52902.114628]  kthread+0xe2/0x110
[52902.114633]  ret_from_fork+0x251/0x330
[52902.114637]  ret_from_fork_asm+0x1a/0x30
[52902.114642]  </TASK>

[52902.119423] atlantic 0000:24:00.0: PM: dpm_run_callback(): pci_pm_resume returns -12
[52902.119427] atlantic 0000:24:00.0: PM: failed to resume async: error -12

Cases 1 and 2 are identical apart from the order and the aq_nic_init()/
aq_ring_alloc() offsets. Full logs available on request.


Consequences
------------

pci_pm_resume() returning -12 does not tear the device down. The netdev remains
registered and IFF_UP, but aq_nic_init() bailed partway through
aq_vec_ring_alloc(), so the vectors and rings behind it were never allocated:

  3: enp36s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN

No packets are received, DHCP never completes, and `ip link set enp36s0 down`
hangs indefinitely — presumably in the aq_nic_stop() path operating on NAPI
contexts and rings that do not exist, though I do not have a blocked-task trace
to confirm that. I will send one if I can capture `echo w > /proc/sysrq-trigger`
the next time it reproduces.

Recovering without a reboot requires re-probing the device; the netdev is beyond
help at that point:

  echo 1 > /sys/bus/pci/devices/0000:24:00.0/remove
  echo 1 > /sys/bus/pci/rescan


Suggested fixes
---------------

1. Use kvcalloc()/kvfree() for the ring buffer arrays in aq_ring_alloc() and
   friends. The array is never handed to the device, so it has no need to be
   physically contiguous, and a vmalloc fallback removes the high-order
   dependency entirely. This addresses cases 1 and 3 outright, and should make
   case 2 recoverable as well: order-0 requests can be satisfied from clean
   unmapped page cache, which is reclaimable without __GFP_FS, whereas nothing
   the allocator can do under GFP_NOIO produces a fresh order-6 block.
   This looks like the minimal correct fix.

2. Make atl_resume_common() unwind on error. Whatever the allocator does, a
   failed resume should not leave a registered, IFF_UP netdev with no rings
   behind it. At minimum the error path should undo the partial aq_nic_init()
   and leave the interface administratively down, so a subsequent `ip link set
   down` / `up` can recover the device rather than hanging.

3. Worth considering separately: reallocating the rings on resume at all. They
   are freed at suspend and immediately reallocated at identical sizes on
   resume, in the one context where allocation is most constrained. Keeping the
   ring memory across the suspend/resume cycle and only resetting the hardware
   would avoid the problem structurally, at the cost of holding the memory while
   suspended.

I am happy to test patches on this hardware.


Workaround in use
-----------------

For anyone hitting this before it is fixed: unbind the device before sleep and
rebind after, which moves the allocation out of the GFP_NOIO window into normal
process context where reclaim works.

  # before suspend
  echo 0000:24:00.0 > /sys/bus/pci/drivers/atlantic/unbind
  # after resume
  echo 0000:24:00.0 > /sys/bus/pci/drivers/atlantic/bind

Shrinking the rings (ethtool -G enp36s0 rx 1024 tx 1024, dropping both to
order 4) helps but is not sufficient on its own — it would have prevented cases
1 and 3 but not case 2. Note that atlantic does not implement ethtool -L, so
reducing the number of queues is not available as a lever.

Thanks,
Stephan
