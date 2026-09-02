Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC5411FB1
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384571; cv=none; b=UVfDtNJaut0l0acAOgvGideEkD/LHra+Lx/08EnTMsPR6EuDt7dLJCidO6Ip9MsXFS4ZGsmfMzplPP6+vLLsuyW/8WyDrJCZs/j8GHef9M2QSDWccmKm56o5LsY8vGUzW7QXVaSuwe6yZSk2JAiT0zos4QW3bHXkCEKnMZmyayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384571; c=relaxed/simple;
	bh=Rwpti7iQwDFikXIDN8JqQyuYZyRBY6WxLhROo8inQYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uk91He5sVz0J0eOZqjzJgMw4Uw+Kxv4oI8Di0ivEp/CsRsmhSn9Is0er/dcUlv1snoMqlsOJP7Y/ZoHUDD416A/4uA1QsPUrVGndudCetIxveb4o/CQiGnvAoSzcUG4P0GjEhrUVmVwrEVEq/3taeBkCgtl9xe/wL7eBEAz15aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=u2SB/1k4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="u2SB/1k4"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90cd4631090so4402696d6.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788384556; x=1788989356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uHUCSjdJ+fy55MfodjzYcXnnlacL4uHKJaK4zHusjHE=;
        b=u2SB/1k43+lfI1ZGf7AG5Mrf/Wfs1DWpAUi8wfoJ7yaFzYHuUh6nDd1vsL1C/Zf1iB
         2Y1bGkAtKwwObVv5dksqI3mi8bw270+BU9+9lu8e+9+trhNmbkeG5u3Vo+kYJKDFDB+O
         ylDd4+Bg5n2DIz2xN02Cq+sXPtkKZUm3YI0To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384556; x=1788989356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uHUCSjdJ+fy55MfodjzYcXnnlacL4uHKJaK4zHusjHE=;
        b=QFInibtOCYugrdVihUre6jSjIAqkyEvDYRCt/EDSo9zqzGOLS43hq13K/2rOeL73kU
         O72DZjes963oEfPGukk69oBVutPL00m5CqXYztJWnxhm9YkHVN74TB+emvvEeT/LK2Kc
         1YsEQvBtXprwTD+VdQxTBCwx/wLLQuw9+ww3MuckCDZT/dbhI7yl53OP2oEa4q8XWm5G
         Zg9S9s43oFeI7PNMJI0bmHlRtn5XUXbx16AFX9fc/2jspCOR4I02YUmgFalf+1qabic+
         38dPjztN4yMGVpbGa+QFPQ/OoMuVugrQDM/HLKFJeCWt5QVXxQj1EvwBJIf30yvT2bz3
         txkw==
X-Gm-Message-State: AFuF++n7KnJsNBW+HL39VCVT9/sd+nAivv0Uun+HHvciebl6ehW78a6v
	+TjRYm0uaCKQo36NLs0j/Y/R+0RqsS8tHG17ZNvyp61X0fBt7zb7pRwuSztPME5XU3cYUNtmXrI
	5BP946w==
X-Gm-Gg: AYBFou3t8+HL366iOIqjeOxgwveOGPyucg3swtLizhtLKL8P2ONlgN1rk8aUWJWztBO
	9QOSoDst++N8RvL1wWy866ZFqS4gpreTZIx/++GlxZseLQtLPRGgJidTJpfzqQWt7ZeE9j770JT
	a43Jzim4zj5XeuIZcLStbjbeL/kR+jYVUSDe0gDhgUTkFBuhGuhiplHoJCb+AkoehRi+Aul/YxF
	NJV8RO8V7NqGkEgwVX68YDCD7J98642s51cPpkppJDmsrLUmxEH3ViuZFkpBIAVHTRKAh681aJb
	eqJXFg8sOdAYCmFh7oM9ivWdxmoQlwlfcjNjLWBE7BRzeAxX2LpRUCWg8Rl60OsIj5myNS3XWK8
	b9TJEcpOZDGW8WKCxIABbmz0zw7CBBQps4CTbXJTw2hqbj2wljptoiZcjCRWDUcYETjm9iaPLcv
	IzOgsbzlTinxWt572FgZjd6/C4x6uWCdcVgC1NLsRYeO81Ae2VQP+fmdN7Hu3YiFAxJgwXJms+Y
	/9d9RaMiiwtEs5EwCEaKGyOIF+pPCSySZONr8M=
X-Received: by 2002:a05:6214:f2f:b0:90c:de0e:d741 with SMTP id 6a1803df08f44-9103476d3c5mr25060216d6.15.1788384555713;
        Wed, 02 Sep 2026 14:29:15 -0700 (PDT)
Received: from majuu.waya ([142.159.91.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm27169086d6.2.2026.09.02.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:29:15 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vega <vega@nebusec.ai>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 0/3] net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
Date: Wed,  2 Sep 2026 17:29:07 -0400
Message-ID: <QDISC-2899.v2.20260901233641@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260902212907.SarAMZD0WSkfjiNod3aUoZfxUv5N56McECcfcnO0hMg@z>

An unprivileged user (via unshare -Urn) can set a huge tx_queue_len
and exhaust global memory through ring allocations sized from it
(pfifo_fast skb_arrays, tun/tap ptr_rings).
The reproducer from vega@nebusec.ai set the following params for
illustration: txqlen of 500000 -> ~32 GiB/ring attempts, 1.6 GB tun,
~960 MB tap. Gets worse when you consider qdiscs like mq.

What we fix: every path an unprivileged user can use to install
an oversized tx_queue_len is rejected with -ERANGE before any ring is
allocated; per-ring memory is bounded at 256 KiB.

This is for you sashikos: What we deliberately _do not fix_
bound the NUMBER of rings. With the cap in place the worst case moves
from "one knob" to the aggregate of ring x queues x devices, example:

  ip link add v0 numtxqueues 4096 txqueuelen 32767 type veth
  tc qdisc add dev v0 root mq
    -> 4096 * 3 * 32767 * 8 = ~3.0 GiB (one command)
  50 tun devices x 256 queues x 32767 x 8 = ~3.1 GiB

Unfortunately tx_queue_len is a bit ambigious in meaning:
In some cases it means a ring size (which is pre-allocated, ex:
tun, tap, and pfifo_fast); a cap of 4096 seems reasonable here.
but in other cases it is used to indicate a queue limit ex:
the qdisc consumers that allocate nothing (pfifo/bfifo/gred/plug/sfb,
htb direct_qlen, qfq, teql). 32767 is a legitimate high-BDP queue
length, so we are going to keep that value.

Getting back to you sashikos, after this is merged and shows up
in net-next we will send followup patches as follows:
this series is not misread as "closes the OOM class"):

a) Per-site ring limits at six identified locations
    - pfifo_fast init/resize,
    - tun attach/resize,
    - tap minor/resize)

   if you can spot more in your review we will take care of those as well.

b) memcg accounting (GFP_KERNEL_ACCOUNT) for those ring
   allocations: contains a memcg-limited container's ring memory.
   Not GFP_KERNEL_ACCOUNT has no effect on the unshare attacker
   but will protect against containers  (memory.max in its cgroup)


Patches:
--------

  1/3 net: cap tx_queue_len at S16_MAX in netif_change_tx_queue_len()
      (netlink set, sysfs, SIOCSIFTXQLEN choke point)
  2/3 net: reject oversized tx_queue_len at netlink parse time
      (IFLA_TXQLEN policy: closes the create path + veth peer nest)
  3/3 selftests: tdc regression tests (netlink, sysfs, create paths)

Changes:
--------
v1 -> v2:
- new patch 2/3: close the device-creation path (Jakub Kicinski
  flagged that rtnl_create_link() bypasses the cap)
- rationale reworded: the 32767 ceiling citing NLA u32 range
  policy can express (s16 bounds), replacing the invalid virtio
  ring-depth claim
- rebuilt tdc coverage (sysfs path now tested; nondeterministic
  resize-rollback case dropped)

Sashiko v1 review links:
https://sashiko.dev/#/patchset/20260828121902.66837-1-jhs@mojatatu.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828121902.66837-1-jhs@mojatatu.com

v1: https://lore.kernel.org/netdev/20260828121902.66837-1-jhs@mojatatu.com/

Jamal Hadi Salim (3):
  net: cap tx_queue_len at S16_MAX to prevent oversized ring
    allocations
  net: reject oversized tx_queue_len at netlink parse time
  selftests: tc-testing: add tx_queue_len cap regression tests

 .../tc-testing/tc-tests/qdiscs/pfifo_fast.json | 209 +++++++++++++++++-
 net/core/dev.c                                 |   2 +-
 net/core/rtnetlink.c                           |   9 +-
 3 files changed, 211 insertions(+), 2 deletions(-)

-- 
2.43.0
