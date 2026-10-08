Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198043E3176
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493401; cv=none; b=EcZKg0EERsWi05oAvoCOdNx1Ubh1Ee//C1dGcbDcS1eJBX9jycnFKS5SVOn6kzGfiO5WdLhf2BAMgC75iHTEkIp2IEAjwm/CJZOXfEn+hb13lyCSRRt5ucKyDZEXK5J3E/rtFDOpEk+URQJhoRWdIcwndz1goho8nttmw80At10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493401; c=relaxed/simple;
	bh=uEkT7bvpoCXxFRYilwrMqw4m/avYlKD/tw+E4y7qkfI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IuwGL/uRaiCxNDjCRphY+ZqRXf8zENlVM6BT7ap98OXI0TZgeOBdJyn4B61KwHGO9+8BO7giUJMtvb4e0cJUe7ZjDlRU769Wmz+20YTt72oliVzyQoS9nm7EC/SBcWqbWqBX/c8y11tNXyLn/7CB13WPzFcv3LtYgTs2ulp+keM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=sWaKa1Yt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="sWaKa1Yt"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53397325663so55067281cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791493398; x=1792098198; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=veWMGuSVswTQSpRQuCY1UJnPdK7Vk9Kj0h3fikv2+bk=;
        b=sWaKa1Yt6/ACY1MKyd98vcKtVd6NILBB4Xejwrhaw4aoMvcDf98jjnq+//bs+1i59u
         giqY5NQPD3sm5GMUocNNqf8QCzVMm2VU2mk5uxgjHg7YX584IUnJG06tgapPb/nFLL3d
         L+hujMwoJ251OEbcXsleATcoiILk45ksX5xN8Bp1rqFyd4PgZ82tlz6aICFpTpTzRpxx
         LJgUssaO5PSDqaiHOcz2jnjXTTxO1eG9lWzy5X4cpkwqQdMgE8tOcPmcfQc/t6iKDo52
         HN7F5Hz5Geb8JbOrNXKPft5gwrPGGncgfGFebC6KoidO+PC8v3RQp1jQmV70rPrQjXBY
         Wgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493398; x=1792098198;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=veWMGuSVswTQSpRQuCY1UJnPdK7Vk9Kj0h3fikv2+bk=;
        b=bDpec73hALX9nsAtgPjIYiGhn9LFhgBC3leGw/VmdbypWOABkX2Unr5tJ4Wtr5G8AD
         H0l2PFjJq6Ehl8DuWJPbGL93IA6v4MHLnxY2iS5ch9Ze/SDHZ4OnMuzbgkjgjiSo4Xd+
         th9Otw1f8ZBamO5HM0lX2eENbhs62S8AN+dOGFarsE70WzCDRw9th8+KB8TXmHyXDGMJ
         uPW8KUakeLDw4PcaG5OY0xzHzjK1o+D4oONQkZhXfGvcqCQT9ma4o2SoxO3UHmpeJhfo
         fP9jFHqxMMJxBlkB7mnoV1htb7KpyKD4szdZgFMjGUendM4rgnHguMe9w+XIwNtsJFbG
         fNww==
X-Forwarded-Encrypted: i=1; AKwUvBzd4sJgui7iHUDp8MEfIjDz6TEb1HcPMAMbNT0CrSdcRCcqQMBiPx+AaFjt1xtmdg8rYEvDvLU=@vger.kernel.org
X-Gm-Message-State: AFuF++kehhxVmp7xaa35yg3zExetry/jPB8mcuNrxjA0g/ilwxX1qk99
	iRP1ZJqKIwSKLhHJP3h+hjsd9HhJFsA8+pVQoHL0WwmAgJdqme9kQBZouyMGYjmQJrk=
X-Gm-Gg: AYBFou0obkBEhiep3VF+ZVueab+govhLgwnzX9QqJ77sCtUMcU6SiDBfy8qVX3cT6FJ
	8IQ/pvroSfsTSBJUQcQvp5hoqY8YhmoN9/Txc6o1vOWGkAesL/qN7K5BbbhHWANJCAPEx81YsTp
	0/9TA1z+WRjVt7Yj7prF0FfGTaZ4ZpfXMnbo3uVDfLD/WUBZuImPG2tsxXOreR32E7g+6UXnEye
	Sbpngc/lBUzlj7LfD5P5F6NI8lyI01iLkMDWYSh+6eS1kb6p1kWxP+oI2Itnr+b0ILdvGgUUlQu
	xa1XffpXzBApu7aZc073rq0ZhzaekOv6/0tYcr7Q8oviYxjARiJJmFC5Suwg4SXe4sfU8ptdqH4
	N2oR4y5FmxbWtnbzE1BXmJKVh3jQyC/7vrFGir2Fm7ZwByJ9JAm5YEmPIEg9shX2RmwwpXobhNf
	nlVTOZNx/MQKETtziU8u7Vue+rB6DAkgH+cxcf2didqRgz237/0k+qt0EdG7pmnNaCXfyowUJyB
	VTnyT1fVKCUZZU=
X-Received: by 2002:a05:622a:1f1b:b0:535:70b3:aa38 with SMTP id d75a77b69052e-5357573e670mr108763961cf.74.1791493396306;
        Thu, 08 Oct 2026 14:03:16 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7dd1a0sm3101431cf.27.2026.10.08.14.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:03:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next v2 00/10] net: stop calling __pskb_pull_tail()
 from drivers
Date: Thu, 08 Oct 2026 21:02:47 +0000
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPkEyGoC/32OwW6DMBBEfyXac7exLQqip/5HlYPXrMMmxFi2g
 4gi/j1Ae6x6nNmdmfeEzEk4w+fhCYknyTKGVZi3A7jehjOjdKsGo0ytlaqRKoz5Shjvw4DFyoB
 dkolTRu8rT6atK9YW1nxM7GXeu78hcMHAc4HTzyXf6cKubNXbL9nMSMkG12/WEI9UHXfz77Et0
 0suY3rs6JPeV34pm38oJ40K2w9tSHlqm4a+yjiLizZ09t2NNzgty/IC68Wn+BcBAAA=
X-Change-ID: 20261006-b4-pskb-pull-tail-drivers-ff4fb2964e1a
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493384; l=4998;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=uEkT7bvpoCXxFRYilwrMqw4m/avYlKD/tw+E4y7qkfI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCXCcPzYE6MckGlWvZs5GlcBhgvsQUwMKctcIvHVU60iM6MoRF4p5/Zxb/dlkHyUCxdBM8d4+e7
 75wiNZDfujgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com/

v1->v2:
- New 1/10: skb_drop_empty_frags(). xen-netfront, netxen and qlcnic
  relied on __pskb_pull_tail() releasing zero-length frags even when
  there's nothing to pull, which pskb_may_pull() doesn't do (Sashiko).
- xen-netfront, netxen, qlcnic: call skb_drop_empty_frags() after
  pskb_may_pull().
- skb_drop_empty_frags() checked with a boot-time test under KASAN and
  kmemleak, on cloned and uncloned skbs.

--- Original email (v1) ---

__pskb_pull_tail() is the slow path behind pskb_may_pull() and
__skb_linearize(), and drivers shouldn't be calling it directly.  It
takes the number of bytes to pull relative to the current head and does
no bounds checking on it.  Ask for more than the skb holds and it BUG()s
in skb_copy_bits().  Ask for a negative amount, which is what a caller
computing "len - skb_headlen(skb)" gets once the head is already long
enough, and skb_copy_bits() is handed a length of nearly 4GB to copy
into the head.  Under KASAN that shows up as an out-of-bounds read of
size 4294967288, after which __pskb_pull_tail() returns success with the
skb's head and paged lengths no longer matching its frags.

It also returns NULL on failure with nothing making the caller look at
it.  Eight network drivers call it directly and four of them don't
check.  All four are RX paths where a failed pull is followed by
eth_type_trans() or skb_pull(), which BUG() in __skb_pull() once the
head is shorter than what they pull.  As far as I can tell none of the
four can fail today, since the skb is fresh, isn't shared and has room
in the head, but that only holds because of how each driver happens to
allocate.

pskb_may_pull() and __skb_linearize() take the length the head should
end up with, check it against skb->len and fail cleanly, which is what
every one of these callers wants.  Convert all eight drivers to them,
check the result, and drop the packet on failure.

The last patch makes skb_condense() check its pull as well.  It can't
fail there today, but it would undercount truesize if it ever did.

The callers left in aoe and xen-netfront are fixed separately, through
the block and net trees:

  https://lore.kernel.org/r/20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com
  https://lore.kernel.org/r/20261007-b4-xen-netfront-short-head-v1-1-12d7113a7e4e@toxicpanda.com

Once those are in I'd like to stop exporting __pskb_pull_tail() so new
drivers can't pick it up.

Testing: every touched file builds with W=1 on x86_64 allmodconfig
(ftmac100 on i386, it's 32-bit only).  e1000e under QEMU, which hits
the converted TSO workaround on every TSO packet, passes TCP traffic
between two emulated 82574Ls, and with failslab failing 5% of atomic
allocations the failed pulls drop the packet and nothing falls over.
The same setup with jumbo frames and copybreak off makes
skb_condense() pull frag data into the head tens of thousands of times
a run.  xen-netfront ran as a Xen HVM guest under QEMU's KVM Xen
emulation, with the backend changed to spread frames over 18 and 19 RX
slots, which takes the converted pull in xennet_fill_frags() and its
overflow path.  The other drivers are compile tested only.

Thanks,
Josef

---
Changes in v2:
- Link to v1: https://patch.msgid.link/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com

---
Josef Bacik (10):
      net: skbuff: add skb_drop_empty_frags()
      net: ftmac100: check for failure when pulling in the RX header
      net/mlx5e: check for failure when pulling the Ethernet header after XDP
      net: niu: check for failure when pulling in the RX header
      xen/netfront: check for failure when pulling in xennet_fill_frags()
      e1000: use pskb_may_pull() in the 82544 TSO workaround
      e1000e: use pskb_may_pull() in the 82571/2/3 TSO workaround
      netxen: use pskb_may_pull() to pull excess TX frags into the head
      qlcnic: use pskb_may_pull() to pull excess TX frags into the head
      net: skbuff: don't reset truesize in skb_condense() if the pull fails

 drivers/net/ethernet/faraday/ftmac100.c            | 10 ++++-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |  5 +--
 drivers/net/ethernet/intel/e1000e/netdev.c         |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  9 +++--
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |  3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  3 +-
 drivers/net/ethernet/sun/niu.c                     |  6 ++-
 drivers/net/xen-netfront.c                         | 26 +++++++------
 include/linux/skbuff.h                             |  1 +
 net/core/skbuff.c                                  | 43 +++++++++++++++++++++-
 10 files changed, 84 insertions(+), 26 deletions(-)
---
base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
change-id: 20261006-b4-pskb-pull-tail-drivers-ff4fb2964e1a

