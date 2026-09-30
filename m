Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B733B3C10
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766943; cv=none; b=KqL8HMK/ZkaNnOYjnrOp5x9fJ9ctRuVHQLnql49WJSrSdfHdf55LCPVaCOYOS1uDcOx7AUmbltFJiQYa96FQkvuzjgajp4KFXaAEvw0F88lUcrwklIpDaOZIA5qdsN5AiT0lpAJ6APp7xJD7ADvSMtTd59vrpTzHBu8IvY91Vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766943; c=relaxed/simple;
	bh=ut8rvLhP17tb5HQA2ZCszIBk6inyqigAHlmPxxRheVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZMpaYl92VYIoN0XlKcw0bzsxF0Ma2hb7pzUxpy6LXd6an1Px3MwYUohmYW64GRSjOlyt/MqDswgYcMBVvW0ePMzBSaDnK4OJeUHR46Ry9tlI2eZCFl7hxGmHzKxZ33yhWtgx8kHWoaorusQ/SvARPcslI9m9pEVLCU/GXnDp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=l9v3R/rX; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="l9v3R/rX"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so2963096eec.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790766939; x=1791371739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ybQdZDVCL6Eh8as1T1D5UTCJMJ7etZIZLmbrGuDrcO4=;
        b=l9v3R/rXc5L7LlI9XrZWVaR17b745DkJERN79UQ+TCXbjypLdq+tKVxx90871baqyJ
         O2pAbHmmFoV9fk/j4uT+6gtiVS5Sig9s0OynZG8SPkaGMgKCy6wuYOBrOosKcIqwm2Hh
         TXqHofSqu8Aj/5LWmE5pCkBCAnuitnTNFaSy6QOLLgvxPLsAhALOHMmCw46M03YJPKx6
         D7m+3YicgsZljTb59HDuN2DQqN3V4sQKlpc8xBJ3UkH/w4PC2dYE9UEM/ZBIGpcDP/Nb
         JogHEbCOQZE+YdEVspGjsfG1dZag4AuTyS61uW2qBawpLn1+7LAZLaPr5mDk9aIFkQR9
         dTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766939; x=1791371739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ybQdZDVCL6Eh8as1T1D5UTCJMJ7etZIZLmbrGuDrcO4=;
        b=TkeneGI7dKtNjHAhwTS234R9byFgJpuzMXAA+DHQyqNQ+rCmwAA1zbSu5C1FztIZzb
         sonfSl5EUXBmDchdCItdlgQOAn4W0p84dDdnrZIxc1ZAzJp55X+FNA5VOwkSuEm0qBSU
         b9yhPGmmPBSwl/fZNm0Fl3DimoNC3TnkKSWkIjkkblPcjFCl8KjDGFdLwbLOfjzb4N7F
         n5H0B/TbzhvAlv2QUmvpObNxqlCxAvUxmBE/UCMLo5gsORmPDqtdWz7zLy+s/X7s8Lau
         RA6BWjdGK85BH/WjFIz3faOL1lXBpTa/bagwgLdQ129G5UnqcblFAB8JGfYyaXw0nxUf
         Ciqw==
X-Gm-Message-State: AFq9FYI3cMYHdk8ltjJDA47ZMe7vb23+/9qGYIHQD73f57yuK0jxkDt8
	zUzVwu1UeQbiSKFmn4Reu3TEoA2kgfD3myMdsREvg5xNyPb9FfLXr/PFKpUYEXYr1sb+lVyY0Qp
	nLKqU/gIi/eE/2Udvzx4nyj6Kae8upDV++WjIA1Df0qYvAYsu7GTGJfbW2oyG52GviUYyycde
X-Gm-Gg: AYBFou0e7sGXNEesPYaUqIHCBHuSCZKMMJtVTBTPr6XscrE7cGD+4CmK6TvPmis7OSo
	Lezxv99Iz9tQJixLUhpEUNvZHaeqWf0cG/QzQGZTGNp08OFIGtPzxbdxR1qruCNCV43Ff/1C3SV
	VeU43y/d/pQLYPHpmqP/UWxtjEtt91v2TweLduIp6cxMQZCvFOt54xjAh5hngN2yBOKSBJHiIy3
	9nw617dZC8KgRvQPqImadmSRtuKVp18/MuetRFwn+85Nh0PQM3/6suNZKipDFXVhf/Da836/MoQ
	LYSqHrJNCuUTrI0aEzsHJmrpVLI5hWUFYtJqFxM458eLNnSsaLESVDm2YLKsBSbvBxxxlShfP2e
	DLe0e8hdRYpbofdR7LG7ClxryWaGhTudjyKK7Ds37/jdGinMP1btXz1iFWCh/wThVWA33HshkSv
	0dUaPZVZawRk7PEGHrPtXN26I5tf7GfTDGQiMiVxZgQoFa+aTbZken+SIi1Pdbca2UX9sBAO+Ba
	NYR8WXErRI6X6fo94G6UQ==
X-Received: by 2002:a05:7300:f292:b0:33b:c29a:7c3b with SMTP id 5a478bee46e88-34cd5ff6546mr1365281eec.0.1790766938594;
        Wed, 30 Sep 2026 04:15:38 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5a2c6f9sm3520320eec.21.2026.09.30.04.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:15:38 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v4 0/5] net: re-segment oversized TCP GSO skbs
Date: Wed, 30 Sep 2026 19:15:21 +0800
Message-ID: <20260930111526.2183107-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BIG TCP is negotiated per netdevice, so BIG TCP and non-BIG TCP ports can
coexist in one path.  When an skb exceeds the GSO limits of the port it is
sent to, it loses its GSO feature mask and is segmented into individual MSS
sized packets, which that port then sends without TSO.

This series cuts such a TCP GSO skb into GSO skbs which fit the device
limits instead, so the rest of the path keeps using TSO.  On a
veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP enabled on the
veth endpoints and left off in the guest, a single iperf3 TCP flow, six
alternating runs per state (-t 15 -O 5, fixed CPU affinity and port tuple):

  protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
  TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
  TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps

The middle column is the same tree with the re-segmentation disabled.  A
BIG TCP hop which feeds a 64 KiB hop loses 69% of the throughput of a path
which never enables BIG TCP; re-segmentation recovers it.

1/5 moves the GSO size limit lookup into dev.c and makes it follow the
packet's L3 protocol, so where the tag sits does not decide which limit
applies.  2/5 is the preparation which lets the limit tests be skipped for
one caller, and carries no functional change.

The new path is taken only when the skb is an unencapsulated TCP GSO skb
without a frag_list, it exceeds gso_max_size or gso_max_segs, and the
device offloads that GSO type.  Everything else keeps today's segmentation.

The output obeys the GSO feature and limit contract the device already
advertises, so this needs no new UAPI, no device state and no driver
change, and it applies automatically.  max_segs only says how the output is
grouped; an over-limit skb pays one extra ndo_features_check() in exchange
for staying a GSO skb.

Alternatives considered:

  - The caller could set skb_shinfo(skb)->gso_size to ~64K and adjust the
    gso bits in the shared info afterwards, which would need
    skb_unclone(), a repeat of the grouping logic skb_segment() already
    has, and a recomputed IPv4 ID for the DF=0 case.

Patch layout:

  [1/5] the GSO size limit follows the packet's L3 protocol
  [2/5] factor the device limit check out of gso_features_check()
  [3/5] let the GSO engine group several MSS into one output skb
  [4/5] re-segment oversized TCP GSO skbs in the TX path
  [5/5] KUnit coverage for re-segmentation and the TCP path

---

v4:
- patch 1: drop the Fixes tag
- patch 1: move the limit lookup into dev.c, so it can use vlan_get_protocol()
- patch 2: keep the two limit tests as separate returns
- patch 2: move the wrapper to netdevice.h, export the callee
- patch 3: call the feature re-segmentation rather than bound
- patch 3: drop the comment at the frag_list gate
- patch 3: say in the @max_segs kernel-doc which skbs may set it
- patch 4: drop the comment above the frag_list check
- patch 4: drop the mac header test, it is always set on this path
- patch 4: take the TCP header from the checksum start the GSO engine uses
- patch 4: keep the transport header test, its accessor warns when unset
- patch 4: shorten the comment above the features lookup
- patch 5: name the cases and the descriptions after re-segmentation
- patch 5: reserve the builder headroom the VLAN step needs
- patch 5: check the exact gso_segs of every bounded output
- patch 5: free the segments when a bounded case does not match
v3: https://lore.kernel.org/20260928044102.1004310-1-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-1-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-1-wang.zhan@smartx.com/

Wang Zhan (5):
  net: core: use the packet's L3 protocol for the GSO size limit
  net: core: factor out the GSO device limit check
  net: gso: support re-segmentation of TCP GSO skbs
  net: core: re-segment oversized TCP GSO skbs
  net: net_test: add tests for TCP re-segmentation

 drivers/net/tap.c          |   3 +-
 include/linux/netdevice.h  |  18 +-
 include/net/gso.h          |   6 +-
 include/net/udp.h          |   2 +-
 net/core/dev.c             |  92 ++++++++--
 net/core/gso.c             |   6 +-
 net/core/net_test.c        | 351 +++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c          |   8 +-
 net/openvswitch/datapath.c |   2 +-
 9 files changed, 459 insertions(+), 29 deletions(-)


base-commit: 47a1446725732cd3996edf607e8739334bbf4d78
-- 
2.47.3
