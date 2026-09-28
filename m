Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DD36195A
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570480; cv=none; b=Xl7FRUvOGUHdqBFvC9JkwOIbjJFBAMTc2H7hvQIBLZnwIPVY6t19YpknIflDMWBy2IpykE6LLmUlzgKVgH/9aI4MHXBmuDXOex3HYMRtYaj6uCjmyZATFV+IEIrbpNp/irV+eM+jRSRI04aEpjPME4KPELAl+AsrYOKTFPCUxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570480; c=relaxed/simple;
	bh=yN5iSxfHObU5enkVT7t0eCR5BOQK92T50qQGkC99TWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHLH4rQ490mFYJksoCupPvPn/8WyfzjiJzLRlI/ZAMFNR2JjWcLh9m2/JHrP08/qv06KkpFPzR68AWYXuAoOVZLm5ydzYA7hCGGHOd8yuSvsoNcBni+dS/nrz59zTJqBIx1yEAJSCioyju0cpZucflc5FPerPPk91rUd1VkgGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=R+zriA17; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="R+zriA17"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so1364943eec.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790570476; x=1791175276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y5/RuB7BG8mXQE4VhaB5l8e0f9SkvMyTjmKRRegzpdI=;
        b=R+zriA17KaEOrYCtp13iI5MEcS5PIhrtAnvEg3OAoAR7OyegRLlEpnbxtYnNfjSmo4
         /fhNjP2RykbAoWT3ftLAZ1fMsaOvMNx31KYUlEVR4St5lSSeW5zjD13AUwxmqodSm7DS
         MjS9ocI4UwmgTmcYS3iapC1lzNaFhqTR82EzO6E6Fv1/9WJGuSlUy37cdoyfDFUnbgaN
         bSZsQ7q8ry4VHr57W/HyTxGraePU8neI2kwYVQT6HF9jN2O/Rs/GjaGy4UbzUQ6I8GiG
         QqgPPV8IQTKL08RvOjs6byzPErCQymHkzbQPnQhPIQsMULT9miujeQhUhI9XQhPyWaE2
         Zzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570476; x=1791175276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5/RuB7BG8mXQE4VhaB5l8e0f9SkvMyTjmKRRegzpdI=;
        b=dmbJdqfogdaUQIw7BDZ/C6fLb2DbSRrqoPtkHszshPwpJTkRTk+qgUpsIWBw+zjjYi
         JN3kBtk2eX5j9CSi6yUGCiDoysFDFtOVTkJYVzYxAHQj51/ZBZtvFse9pdKfbmygfkg2
         WG4iDujFYPznmiSZwCLNQc5/xHuJHMFrUNYaN7BvKQvTSF2QjlZXQU12SOJAmUtSOLJK
         CzCeTdTI7RYtdN8XS8vrukC7UbZVYdqp/ATknvKo5hBvDY/iYlRzUzeU/XtRJ1POrDvJ
         9qKf7HBLmVIzcXyX2vLAlaf8mZLc6iDsnlMXrTXmTNkNmXku0ky6RodqGRp+IF7prSeD
         ZVQg==
X-Gm-Message-State: AFq9FYKKMxF8qYceijIuvzYK2LsCpUIAJ6aRwgyg6XvtR65dHG5KCBl+
	of8KevzUjAK7BMtx1lu4FdQyPPSpUamedN0qN6KCBotP1x90DvbXg79vr0Xx2GX6VoQrvC7lP/F
	fc40OMd14DnJGX2WXtES/Fj9+uTW8Bf87Iwcym1fyBx1TULkyHkGpHdejfoLKvTnRncadUswJ2w
	4IMA==
X-Gm-Gg: AYBFou3mwDVuIqIC333118YplyWVVf6q4yudIjxu6vweDO5By+3c2let4cI1F80+QN7
	ta/ILYa0kJavUoI5eaSKVrWozVefmSlngmhrPu04mVk5KPynyMXT/qsvHX5aNMohnOfG5CaY4gO
	vpIMGdy2l8r5IXKppSRlqgdlCvImBBFGC5dg9PqincTsp1LhLNTRk6z6kNTR7W0UznSq03AQr2b
	bF+8uDgKkpBnXZOOg7sSto4pJV+0Qpwnw4rkHPNYvjSH0V/lmN8phWl93AlaR18n94TBeCCmi9B
	e+LgkxmEFUzasNHraakrFDVMfKDEwvELf5i+wbI36dkjKH8c/TejNFbotdxKLXiUWv2iZQ8qPjA
	gZaFN6XY9lBwg/n/XDE8eXqKuX/XP/3LqYrtfbalLl61uf45CP+YCNfG1YVrsoV8uHsd9YkMNdd
	fo8IWaykpHgNgDMRQeIvYNUXLHN+b4PtWL/6SZxNlwiiGFL0mYGf616GqutG4Dfh/xlu/X5Mg8z
	rLMJv1kFhs=
X-Received: by 2002:a05:7300:ea01:b0:33b:a4e3:9958 with SMTP id 5a478bee46e88-3426fcc9606mr8221941eec.2.1790570475869;
        Sun, 27 Sep 2026 21:41:15 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm22772905eec.28.2026.09.27.21.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:41:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/5] net: resegment oversized TCP GSO skbs
Date: Mon, 28 Sep 2026 12:40:57 +0800
Message-ID: <20260928044102.1004310-1-wang.zhan@smartx.com>
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

The middle column is the same tree with the bounded path disabled.  A BIG
TCP hop which feeds a 64 KiB hop loses 69% of the throughput of a path
which never enables BIG TCP; bounded resegmentation recovers it.

1/5 stands on its own as a fix: the size limit is picked from
skb->protocol, which is the VLAN ethertype for a frame which already
carries its tag in the packet, so an IPv6 frame was measured against the
IPv4 limit.  2/5 is the preparation which lets the limit tests be skipped
for one caller, and carries no functional change.

The new path is taken only when the skb is an unencapsulated TCP GSO skb
without a frag_list, it exceeds gso_max_size or gso_max_segs, and the
device offloads that GSO type.  Everything else keeps today's
segmentation.

The output obeys the GSO feature and limit contract the device already
advertises, so this needs no new UAPI, no device state and no driver
change, and it applies automatically.  The bound only says how the output
is grouped; an over-limit skb pays one extra ndo_features_check() in
exchange for staying a GSO skb.

Alternatives considered:

  - The caller could set skb_shinfo(skb)->gso_size to ~64K and adjust the
    gso bits in the shared info afterwards, which would need
    skb_unclone(), a repeat of the grouping logic skb_segment() already
    has, and a recomputed IPv4 ID for the DF=0 case.

Patch layout:

  [1/5] the GSO size limit follows the packet's L3 protocol
  [2/5] factor the device limit check out of gso_features_check()
  [3/5] let the GSO engine bound the MSS segments per output skb
  [4/5] apply that bound to oversized TCP GSO skbs in the TX path
  [5/5] KUnit coverage for the bound, the device limits and the TCP path

---
v3:
- patch 1 is new: the size limit follows the packet's L3 protocol
- patch 2: move the check_gso_limits flag and the wrapper split in from patch 4
- patch 3: drop the tcp_gso_segment() exception, the caller keeps the features
- patch 3: cap the bound with GSO_MAX_SEGS and drop the output reset
- patch 3: document the bound as TCP only and note the frag_list gate
- patch 4: enter from the limit predicate gso_features_check() uses
- patch 4: keep the features, so the bound shapes the output only
- patch 4: drop the SG and checksum tests, fold the MSS minimum
- patch 4: cap each output at GSO_LEGACY_MAX_SIZE, not the BIG TCP size
- patch 5: cover the IPv4 and the IPv6 limit, with and without the tag
- patch 5: skip the TCP cases without CONFIG_INET, reserve headroom
- patch 5: free on the failure paths, check the ungrouped single MSS
v2: https://lore.kernel.org/20260918084651.3022878-1-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-1-wang.zhan@smartx.com/

Wang Zhan (5):
  net: core: use the packet's L3 protocol for the GSO size limit
  net: core: factor out the GSO device limit check
  net: gso: support bounded TCP segmentation
  net: core: resegment oversized TCP GSO skbs
  net: net_test: add tests for bounded GSO segmentation

 drivers/net/tap.c          |   3 +-
 include/linux/netdevice.h  |   4 +-
 include/net/gso.h          |   6 +-
 include/net/udp.h          |   2 +-
 net/core/dev.c             |  91 ++++++++--
 net/core/gso.c             |   6 +-
 net/core/net_test.c        | 347 +++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c          |  14 +-
 net/openvswitch/datapath.c |   2 +-
 9 files changed, 455 insertions(+), 20 deletions(-)


base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
-- 
2.47.3
