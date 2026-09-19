Received: from mail-pj2-f17.google.com (mail-pj2-f17.google.com [74.125.227.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56AE349B15
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828728; cv=none; b=ovkHnd1yScMf6XXWRJqQwzyPM8OyXXzuFkJAy8l7YI4V2QuNWcGN8MOwIf2xOJyHMtrQdmMHlsv0dQaeFCW5RlvpQyCaTxav/hQ0x54ykG/ef8Oi4K72eknQquBPZ5306h8x7az2g7JOhfxfVIqM3Z/PRUwUc7/xmtq54LsbVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828728; c=relaxed/simple;
	bh=qhaAYi0xeH9FiQL/Fcp9twD7G5BWxZiBzWFCQ5oiwSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LXpEDn2jLPD+6D09fWLdYHGsV1OKXVfmJxUbi4sGcTr91wJlz562XzceD2UZxLiSzRqQ/eVpnZFAr9OZSYkNwruxrH8Vxx4AEf1dO4nyJEBE2293F0Oe9oPm92ODZwc+mznAuzNZ6NT+V+ZsSyH27aS/zCh/mQ/a6yPJFyAqOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7w2hmj0; arc=none smtp.client-ip=74.125.227.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7w2hmj0"
Received: by mail-pj2-f17.google.com with SMTP id d9443c01a7336-2db1ca06a25so11547265ad.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828726; x=1790433526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TnKlJs56objPcc1LhBowCQwlO93GKvIAjcZLwH4KNcM=;
        b=G7w2hmj0653+5ISgmb8VOLQGQKs5fI+4QIJHECk7veJtiAzOdhTL/dDWmL5e40E25m
         BjY16cBdiWFmasEYWvyLyk/rrsb5BrRKV/0wp6jndW7G6nCQTb4tKBGbrJ/FSCby72T6
         8pjmpgHtLKp8kvRZnmL9NkelJG4gxpH4zkVtRI+jPIuLft3WT7jcwGc5mbltDQ+e0oK4
         8W3WdwpksJeTsuaIUahe20riRTuQwX1kwuaXv0bbtq3FMzy8T9jUR3zASN0CNU3/cDOJ
         BiojpINwovddCIPE/ddTHVNiZIB1btsztUW2my6Nv9RYlXmmT9loHhW8WZGZ/grdNKXm
         4c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828726; x=1790433526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TnKlJs56objPcc1LhBowCQwlO93GKvIAjcZLwH4KNcM=;
        b=AOwxPIqJw4acJMhMK0Jj2JES23Hmh9D099EEifj0kDU6c4Y6EfdHr4ZkGneb0yOFEY
         ku643P9QP6eykEjtObkVj77K0NfMC7O70+rvsc1st9Kzyv8JG/72MPQp2G0drGczdZNa
         92jEj/oggrp6JwF8NXUbDd/KTXgO4/qyiMs3zgORUNawt8hBd9g5L3zQwnYrWwEfnjjD
         M7UPJ7cfLZp2Y15lIJjYBbe8bGSZ+Y7tW3l0zhf9tPx7rYSUDrMv/aMFpVyEtelQ7zYs
         oSkL2f0wQI3WMqNDLKJ7bbSUGqTGoApsrHNPCwvmrl5TJCB7GQAi5H5NyVpVmKfuPNkQ
         6WOg==
X-Gm-Message-State: AFuF++m8tA87I2m9mHWAOYAb/EAQ6H8o1OYKw8Ssx2Ebunfag5HkJK/9
	e2qpok3psBewYM/XKbIInKa6R0ruYItauR5IEKVYwWYwBk10w6zrGlQ2
X-Gm-Gg: AYBFou3CvVmkTVlyQ/7pUj7zj84kkT04GZ4J1QpaFn2WPJaJgLooQ/JZU5oaV2BJ6+X
	xLl0qaVVNEEUBUxh6sWzpmwAq46xzt8SgIkRfpi3utmk3bNd4ATDrcm5ZWDOlcCb4Hv9JpblzMt
	FxJXdNIX/X0+zotRAKSGfQ4Nabj1/wjRINZF/XVv71IIeDjih+ZeIh0iW18/TCtNmbCcjpu7aUU
	T2uqpuMbdbuVY+Byg6CF/nQSSkY2lC/LeJwp5FFhsaHd22lG8rT5SzPesV7AifeQrhUtkHSjKfR
	/R0mx6KyP5OQALx9uHm98fN9yWP89p04W34HlNmg6GwfIJtInU7BBLIUugwtOpIcCjD2pkQuSHn
	oeqWbqt9kxGOS4z8roxc3BF/SFlmxuI7CQ00cenr7/JYNah/u7VceZ/V5Ek5qZYoWA5a3tXqwpv
	XscASEl9QStHnQ+o8ll4d0JzV4g7GNXcopf5zrhDfPmmhwlsrTa+cmeMA8A18CfHbimDS9evfS3
	GUGdDWoGsFnPgDW8gPZKyn6YdcKuNI9jISKtVj2X7riOy3P1c+KNoQohzxrG2+BzBW08kiaSAXK
	1wE1tow2gmpFe154CHmrP/UGX9IdByDIYFS+F/9/VblVlbYLbrOcvs4x6TEDfLjgGEXo2Q==
X-Received: by 2002:a17:902:e889:b0:2dd:c100:80be with SMTP id d9443c01a7336-2ddc100818bmr40188995ad.57.1789828725559;
        Sat, 19 Sep 2026 07:38:45 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:38:44 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@gmail.com>
Subject: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
Date: Sat, 19 Sep 2026 22:37:23 +0800
Message-Id: <20260919143732.11772-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@gmail.com>

Greeting,

It's BPF Timestamping 2.0 that aims to observe the packet latency
more efficiently and simply for different protocols. The current
series is only focused on TCP protocol.

At Netdev 0x1a/Netconf 2026, the history, background, motivation and
rough implementation of the feature were exhaustively introduced[1].

History
=======
- In 2009, Patrick Ohly implemented the basic infrastructure
- In 2014, Willem de Bruijn enhanced the TCP latency observation
- In 2024, Jason Xing proposed its lightweight BPF version
Detailed slides from 28 to 32 [1].

Background
==========
Even though BPF Timetamping 1.0 is comparatively low-overhead,
transparent, it's still complicated due to a few points inherited
from the design:
- Inflexible/fixed reporting phases (qdisc/driver/ack)
  When we confirm the issue arises from the kernel by using attribution
  ability of timestamping feature, we need to further minimize the scope
  until the issue is fixed. That means, we then have to resort to write
  a few complex BPF progs with the similar functionalities (like skb
  level tag) which should not happen.
- Not enough low-overhead
  Serving the sensitive applications, an always-on latency observation
  platform should mitigate the self-impact as much as possible. As we
  can conclude from BPF Timestamping selftests, there are some blocking
  and time-consuming points like where reading/writing BPF maps happen
  in the extremely hot paths.
- Minor flaws
  There are a few minor flaws inherited from the initial design, like
  missing tagging the last packet[2][3][4].
Detailed slides from 33 to 39 [1].

Motivation
==========
During the process of the large scale deployment over the last few years,
we eventually realized timestamping feature doesn't support container
scenario and we need a finer-grained and flexible tracing tool (packet
basis) after a few rounds of attribution of issues.

Design
======
- Start time
  For the specific protocol, we need to accurately set the start time of
  each packet first. For TCP, we chose the entry of tcp_sendmsg_locked
  and the driver time as the start point, so that any BPF program is
  capable of computing the delta between start time and current time.
- Simplicity
  Previous BPF program (like selftests) is too complex to implement. The
  core idea is to make everything as simple as possible. And it should be
  decoupled from BPF area and previous timestamping feature as much as
  possible.
- Flexibility
  BPF program hooking any function with skb parameter can get the latency
  value, which means it's no longer bound to the pre-embeded reporting
  phases (see __skb_tstamp_tx)
- Efficiency
  Avoid the previous BPF operations as much as possible. Make sure the
  feature achieves the lowest performance impact, which means only time
  operations remain.
Detailed slides from 40 to 62 [1].

Implementations
===============
in-kernel
- Find a suitable place to timestamp for each packet
- Pick the right start time for TCP
- Handle the split skb due to various reasons
BPF prog
- Hook any functions that carry skb parameter
- Read out the start time from the skb
- Generate the current time and then compute the latency

Discussion?
===========
- Do we need a kfunc to allow users to reset the start time of each skb?
  What I had in mind is if someone tries to observe the latency between
  two specific functions (rather than tcp_sendmsg_locked).
- Current implementation is real hardware timestamp always wins, which
  means BPF prog possibly gets the hardware time that is not aligned
  with bpf_ktime_get_real_ns.
- After the series, do we need to implement the same logic for
  SYN/FIN/PROBE... As far as I know according to numerous user reports,
  a small handful of issues came from 3-way handshake.
- Reusing the slot of hwtstamp might bring potential problems or make the
  code hard to maintain. Can we add a timestamping specific field in
  skb to deal with the latency observation?
- netdev_data conflict in IGC driver. It seems unavoidable to pollute
  start time when it's enabled. Should V2 feature coexist with hardware
  timestamping?
- Should V2 coexist with net timestamping and BPF timestamping? If not,
  the maintenance should be easier.

Any suggestions are greatly welcome!

After we set how to use it from the perspective of users, I would add
a corresponding selftest for this.

[1]: https://netdevconf.info/0x1A/sessions/bof/network-observability-bof.html
[2]: https://lore.kernel.org/all/20260404150452.83904-1-kerneljasonxing@gmail.com/
[3]: commit 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx queue")
[4]: https://lore.kernel.org/all/20260915214450.2882680-1-dw@davidwei.uk/


Jason Xing (9):
  net: add bpf_setsockopt for SK_BPF_CB_TIMESTAMPING_V2
  bpf: add bpf_ktime_get_real_ns() kfunc
  tcp: record a start time in the tx path for SK_BPF_CB_TIMESTAMPING_V2
  net: reuse skb_shared_hwtstamps for BPF Timestamping v2
  net-timestamp: use pskb_copy to avoid polluting the orig skb's start
    time
  bpf-timestamping: restore skb hwtstamp if it is used by start time
  tcp: propagate the start time onto every skb in the tx path
  net: generate the start time for every skb in the rx path
  tcp: handle the start time of each split skb in the tx path

 include/linux/skbuff.h         | 17 +++++++++
 include/net/sock.h             |  2 +
 include/uapi/linux/bpf.h       |  5 ++-
 kernel/bpf/helpers.c           |  6 +++
 net/core/dev.c                 | 69 +++++++++++++++++++++++++++++++---
 net/core/filter.c              |  7 ++++
 net/core/skbuff.c              | 10 ++++-
 net/core/sock.c                |  5 +++
 net/ipv4/tcp.c                 |  7 ++++
 net/ipv4/tcp_offload.c         |  3 ++
 net/ipv4/tcp_output.c          |  5 +++
 tools/include/uapi/linux/bpf.h |  5 ++-
 12 files changed, 131 insertions(+), 10 deletions(-)

-- 
2.43.7

