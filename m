Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DA37FF53
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271390; cv=none; b=JIeXGoXOk4ASFv+np4c+TzNcjIUQvK6O+MiKmM0EhZfDrbnifTXv+R5TaNq9+sSgWwbGOnza/yNeX7qNhW3MiRLqBU7qB9FUOc/OhBy6vciimMfQ5WtIqOpwv8XmQtYDgpPGP9kqFLP6RyCXaHrT/tL/gQCUscrtoGlE2hYfJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271390; c=relaxed/simple;
	bh=gMpfD+mqQiDzLTP0fxIcjUewF8bwoxfTKr+VsxpO3rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcGGJ8XuCs1zGXIikRKWhXI87LQguFX8gNxZfjMSf7JCnsKBtnibNgtq9Czx1wR54nlEaIfoS9yBoE2WzPBc9SN/mfuSn2GztJaRmeZTOSlFZWvV/zWQjjPjcWO5U9+KnfIyVjN6VzMJaOAewZYYdPCpEDIBvKH1KaMLmePHoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTUEhmFo; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTUEhmFo"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a35a64530bso7641831fa.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271386; x=1789876186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BkACxqCXl6mybpuTCqEI04LMPdFiJukVxDGD6ehdJS0=;
        b=MTUEhmFoWPnUWQeUK9wXRvu/lGrp8bIS7tOvBHlehTp2MXYw1EWlyMbfY2jVJOC6wm
         P2QZZ5GAaCJsJD2p68pGHZxqBMey+yHVJSQ7dMfjYXr5PH+f/Iu6D8h9iZM1AvsPuf5X
         h+AH0kfUmg7mVhDF4UbwNLUXsXuTNaoyfXO2Et7vFgRRWQvJJQ6IK1CHGWr6wGDQZqiZ
         hQ+nnZjQNjWD3N92fBRsInVljnsN5amikebPFmcS37RLWLLrDLLVl3igYmRd58laY6Hb
         3b8GNIqB26/g5kpjjmVHIhFtjFX1IzY1k0WqeNlg87Y0IJg5+cOcvxznZymi4pmMotDc
         eWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271386; x=1789876186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkACxqCXl6mybpuTCqEI04LMPdFiJukVxDGD6ehdJS0=;
        b=tLxOwHpmCN5GrSbtpCCZ8kk1CDJFdwGeblDOQS3bmBMyC+kiiupsC0ytT3orsbaEVO
         7s5ojr/x6RkaFCJaIbWPEOkGUJyR/+2Id0kxzpOTrrPsRVnlPydbghhkutvDc9vGOUcJ
         5u68rkW/fYLv11LcH/kR3FBJMlb2Fz+ndUxEtCLlK3VhzDi7TrKGpmk+t8Q/K+YT8sb9
         C5ftetGdGhUWaeLN/DY7nYL1oFVdmrPyqp50Gu/r7WFW8liJJLyGDLEFjwENmKQ5BXGT
         OAGl7Cr9aIvgHVhWSwwFTuJpmqHmIfOQ2d/3cuGLSUtUW1E3CRY54fxRwYGj2yvQCEeF
         eRWw==
X-Gm-Message-State: AFuF++mKJxo/6vIbMi7KVIMGJZpUy0cH1q3+38YttRmujWaPlSwWD38J
	lnGwaT1iQOddJewD5RgXzf/4VV2wawavQhB2/H40tUyBFW2+j2jOe2gKA1GmiS6UCOw=
X-Gm-Gg: AYBFou2X3+Lzck+lGjLPcJTLwzpwWc7N9Sd69rSorHD27KFGaUq67QiqUkAdazsl6t1
	LAQJa5KXVlDMjxVyb0LLzJuU8iQ983+UqBM3bXJM+WCeVw10OJISU+OXizEed78UwvUvUZfid8Z
	2JDJ49MHqikOIAW2mGDw49z1Z5nVdAwQw06EAbeHTtEWCDErm6KazHcekbhYCx25mk81p8Zx3uN
	Zvkpt3hZxXtr8NPGDk1tO23AII7koZdtZhUfUHHP+CkHBmlD82EMt1osD+Vpd5aTQybpRPsBSmX
	SHe4Fz4ErGM1LV2gtaHQVBBAAFh7XvpQeZVoWX9xOilVsSi3/6ssReBbkZe6fleG4N1IJXwi3Xz
	Fyq/mh2PiA6C7QsSWp//WiyMQX3YG7nWg1vx55/rJtN40qWgDv5FnFhIn6FEWDA9pUSqWu/rLBs
	swWpFaTWexWhAVWLSSqHSzjcC+T2zIMDNLKAMihK4rlNljsuMCDYyW+KUq8MmqNSkSkuyhf8HEB
	5scPhVhdg/6oJEcF+ForUq4i2MDDRU/Iktb6w6P0KvW
X-Received: by 2002:a2e:b894:0:b0:3a3:74b9:8a7f with SMTP id 38308e7fff4ca-3a5b384d6efmr6117411fa.24.1789271385981;
        Sat, 12 Sep 2026 20:49:45 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a332737dsm17277051fa.22.2026.09.12.20.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:49:44 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/8] tunnels: add core and gre drop reasons
Date: Sun, 13 Sep 2026 06:49:29 +0300
Message-ID: <20260913034937.875068-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only vxlan reports drop reasons among the tunnel drivers today.
Everything else, on both the receive and the transmit side, ends in a
plain kfree_skb(), so a packet that a tunnel throws away is invisible
to dropwatch, drop_monitor and perf trace -e skb:kfree_skb. The device
counters group the failures coarsely: rx_errors and tx_errors each
cover half a dozen unrelated conditions.

This series covers the generic paths shared by ipip, sit, vti, gre and
their IPv6 counterparts, plus the GRE specific parsing, on both
directions. A later series will do the same for geneve, bareudp, fou
and the remaining IP in IP drivers.

Patches 1-2 convert the generic receive paths, ip_tunnel_rcv() and
__ip6_tnl_rcv(). Two reasons are added:

  TNL_OPT_MISMATCH  the options a packet carries do not match the
                    tunnel configuration
  TNL_OLD_SEQ       the sequence number is older than the one the
                    tunnel expects, next to the existing
                    TCP_OLD_SEQUENCE

The second one has a failure mode worth naming: when a peer reboots,
its outgoing sequence number restarts at zero and the receiver drops
everything until its own counter catches up. That is indistinguishable
from a misconfiguration by the counters alone.

Patches 3-5 do the GRE specific receive path. gre_parse_header()
returns -EINVAL for six different reasons, and the only detail its
callers could get was a csum_err flag that none of them read: both
ip_gre and ip6_gre declared it, passed it in and ignored it. It is
replaced by a drop reason. Three reasons are added, mirroring vxlan:
GRE_INVALID_HDR, GRE_CSUM and GRE_TUNNEL_NOT_FOUND.

Patches 6-8 do the transmit side, about forty failure paths across
ip_tunnel, ip_gre, ip6_tunnel and ip6_gre. One reason is added,
TNL_ENCAP, for a failure to build the encapsulation header.

The transmit side has its own case worth naming: tnl_update_pmtu()
returns -E2BIG after it has already sent an ICMP fragmentation needed
back, which is path MTU discovery working exactly as intended, yet the
drop lands in tx_errors next to genuine failures. An MTU black hole
cannot be told from a broken route by looking at the counters.

Drop reasons on transmit are not new: vxlan already reports several
from its xmit path, and ip_tunnel_core.c reports RECURSION_LIMIT.

Tested under virtme-ng with a script that builds tunnel pairs over
veth in network namespaces, makes each of them fail in one specific
way and reads the reason back from the skb:kfree_skb tracepoint:
twelve cases, each reporting the expected reason from the expected
function. Breaking the new mechanisms on purpose makes exactly the
corresponding cases fail. No DEBUG_NET splat from the
SKB_NOT_DROPPED_YET check in sk_skb_reason_drop(). v1 carried that
script as three selftest patches; they are dropped here.

Changes since v1:
- dropped the three selftest patches (Jakub)
- renamed IP_TUNNEL_CFG_OPTS_MISMATCH to TNL_OPT_MISMATCH (Jakub);
  renamed the other two reasons the series adds for the generic paths,
  IP_TUNNEL_OLD_SEQ and IP_TUNNEL_ENCAP, to TNL_OLD_SEQ and TNL_ENCAP
  so that the three do not end up under two prefixes
- documented the new @reason parameter of ip6_tnl_xmit() (Jakub)
- fixed the local variable ordering in the blocks this series adds
  declarations to (Jakub)
- rebased on current net-next
- v1: https://lore.kernel.org/netdev/20260831215137.549324-1-littlesmilingcloud@gmail.com/

Anton Danilov (8):
  ip_tunnel: add drop reasons to the generic RX path
  ip6_tunnel: add drop reasons to the generic RX path
  gre: make gre_parse_header() report a drop reason
  ip_gre: add drop reasons to the RX path
  ip6_gre: add drop reasons to the RX path
  ip_tunnel: add drop reasons to the transmit path
  ip_gre: add drop reasons to the transmit path
  ip6_tunnel: add drop reasons to the transmit path

 include/net/dropreason-core.h |  38 ++++++++
 include/net/gre.h             |   2 +-
 include/net/ip6_tunnel.h      |   3 +-
 net/ipv4/gre_demux.c          |  51 ++++++++---
 net/ipv4/ip_gre.c             | 144 +++++++++++++++++++++---------
 net/ipv4/ip_tunnel.c          |  60 ++++++++++---
 net/ipv6/ip6_gre.c            | 163 ++++++++++++++++++++++++----------
 net/ipv6/ip6_tunnel.c         |  96 ++++++++++++++------
 8 files changed, 415 insertions(+), 142 deletions(-)

-- 
2.47.3

