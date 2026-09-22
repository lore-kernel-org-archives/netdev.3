Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3652ED57
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115325; cv=none; b=XHJJuAE4oWAVYFbdUw9FmMJqAPRIYqw5ZKs2lSI3TJbHOKzvr3+HzWnoDuOiMersxGEE3XumL37yDLRhQiEN04KFpatusj7CUL7gR0QR0uzyybcHwoMznJvDaq7+NJpPeciZXV+OLR49osVXx5w9Ok9It5fuN/DUY8ykKkqZV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115325; c=relaxed/simple;
	bh=IJxtcG7YfbiDy65B/kZAOBJ0kfmYIHS62vZo/60rgr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmpsY7jO4LkG8vesf7Z//sNHec7J1xV8F9Xz8CqC+hJ759c005obV6fLPUEDgm8oQIg9IRknzfYGBuegYsut1FdPmmhyHYAnde/IulRlBxOcqJ5OUrFBFbUvuXdiBQ1FNdkVyFl/HdUYecgO2mvQZ52pabiUfOzzu07j7tOTMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWFRxnuU; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWFRxnuU"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1b846so377784e87.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115313; x=1790720113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pBgKampETMPka2XZirh+gpBK7oF1vIpX/nPi2mOFejw=;
        b=pWFRxnuUOU7j3xwCy2WnSytmfAGp09tYsov4Kkpa8MTymak7+z/OOotkHAEwJBceKQ
         K9dTkBULPd022jqkQa+rhqt46AD5h4u6TqpSrXU0hB3H73uxmSMwgy4KaOVAeLNNBd2z
         yzw2GcSN4rx0e7DDv9/v6k0af4CSW7xT5M14STIz5CIgR02OaW9UsT1BLgDMrA3M6CLq
         1f+6EW/NfpwDXNgcncNsCIGaqlnoA1EQpEgG6405IQygFRYnvbYed2JIXei8Wn3dnFoY
         kSfCujj4vqpe1/0mdNHrK49Je2Gs/hevUr+i3IJWWcfgvREe7vXGNtPW86+ORRn3D2qf
         O8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115313; x=1790720113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBgKampETMPka2XZirh+gpBK7oF1vIpX/nPi2mOFejw=;
        b=tQf5tC8fpQRZz5x65K6PmwkEmWGeXgFbGz2xYJ/p8TVgY3wA0YzppqwXk2u1uM5lFe
         O2y5sBpIwZxol5vnLMVgcVbC263wqQ6dS+utgEq09KIOTXkNzNSXbFA/OsceDG5gqb9M
         yCSYh9eApRruGdf1W/bJl7j2ACc2dqAr3lQyMPT7J/aSvCFIXhGphI6DjkdSe4kuNq+T
         xs5uiXGpd3blgRCXoTEOuJLRKFo2ITb0ISFU9xgeIl4Fwck33xnDDe0/GY01xGnhifup
         wR0o8ZPbFKsBDb3UTgJwqV/5Sukutl9o2F2T8LkQ2l4/DgwAD6gZgUtCC254xmzGEyCC
         akQQ==
X-Gm-Message-State: AFuF++kI+tKfk9JBpC/LlYC0nEB0NNPMVfwiOs4icjPXCNeBqYJgcTKh
	Cw5aYHZ15AQ3IvN5nFAquHURu/puyFj8e8Lj9JLeyhqcDqHto6mOI6FPD57r6/GB7w0=
X-Gm-Gg: AYBFou31s5zKuxg8MDw/LjTxNqobNG7KedoUoq6hq9wjyVkM5X/464pEYiI3uvifHLO
	2xZuJaKyuqS51yl2ptkN0c8mCkNyIY/i3aqGWiETDf97OH/uaC2cUfBB85m9IjmFfhqBoHV9mWq
	g35frj8J37e7VG+vViWLnsvwkl8IRS8MXQ+SfjUfi7xD3HyZLj9MaM52VxvMucFOpFVzhWOg3aA
	0+RyTL6QE+HvNdJ7kxEgmToKEVMgWaZ2oGch9gs/gyRsr2jtSWI4jS67y0fSzFCkS/Vg3SPPKM/
	4sRQ7PveOD3YZPGwfC5u7Ww8jjvyYPZBqwOg9efUoAFnqWnYd0Zeub+AKz1jqpqcGUGiqx6S4LD
	SVK4pWaxMGMKsMMZ/NGrKSP6fDnBSLGzdinZV1VR3KVyWNwcIrutkrCzWNWAso9S92LqLFJaqC9
	cnnz9kkCM5837z20C4RySaNLPNO3Vyn2Li3EUyxj4saBJzZkda4o0QGm7CuG0ZZXrvsRGqe8tS5
	okKo9ACyW8WH1JR1Ghm/zVdAcWqUQkNBuMxrL60+VlVmcbWaAZvg9DKzRMlXUGX4xoQxtn+1w==
X-Received: by 2002:a05:6512:2246:b0:5b6:1a7c:aa17 with SMTP id 2adb3069b0e04-5b8d89a701emr177445e87.47.1790115313232;
        Tue, 22 Sep 2026 15:15:13 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d857873asm164920e87.17.2026.09.22.15.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:11 -0700 (PDT)
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
Subject: [PATCH net-next v4 00/10] tunnels: add core and gre drop reasons
Date: Wed, 23 Sep 2026 01:14:57 +0300
Message-ID: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only vxlan reports drop reasons among the tunnel drivers today. The ones
converted here free what they drop with kfree_skb(), which drop_monitor
and the skb:kfree_skb tracepoint do report, but as NOT_SPECIFIED, with
the call site as the only hint at which check failed. That hint does not
go far: all the failures of ip_tunnel_rcv() end at one call site, and so
do nearly all of those of each transmit function. The call site is not a
stable interface either: its offset moves with the compiler, inlining
and the configuration, so a filter on it has to follow every rebuild.
The reason stays the same across kernels, whether NET_DM_ATTR_REASON
reports it or a BPF program matches it by name. The device counters
group the failures coarsely too: rx_errors and tx_errors each lump
together unrelated conditions.

This series covers the generic paths shared by ipip, sit, gre and their
IPv6 counterparts, plus the GRE specific code, in both directions.
A later series will do the same for geneve, bareudp, fou and the
remaining IP in IP drivers.

Patches 1-2 convert the generic receive paths, ip_tunnel_rcv() and
__ip6_tnl_rcv(). Two reasons are added:

  TNL_OPT_MISMATCH  the options a packet carries do not match the
                    tunnel configuration
  TNL_OLD_SEQ       the sequence number is older than the one the
                    tunnel expects, like TCP_OLD_SEQUENCE for TCP

The second one has a failure mode worth naming: when a peer reboots, its
outgoing sequence number restarts at zero, and the receiver drops
everything until the peer's numbers get past the last one the receiver
accepted. By the counters alone that looks like a misconfiguration: a
packet without the sequence number option bumps the same rx_fifo_errors.

Patches 3-6 convert the GRE specific receive path. gre_parse_header()
returns -EINVAL for every failure, and the only detail its callers could
get was a csum_err flag that none of them read: both ip_gre and ip6_gre
declared it, passed it in and ignored it. gre_parse_header() now returns
a drop reason instead, and its callers take the header length from
tpi->hdr_len. The receive helpers below gre_rcv() return the drop reason
instead of a PACKET_* code, and the PACKET_* codes go away. Three
reasons are added: GRE_INVALID_HDR and GRE_TUNNEL_NOT_FOUND, mirroring
vxlan's VXLAN_INVALID_HDR and VXLAN_VNI_NOT_FOUND, and GRE_CSUM, like
TCP_CSUM and UDP_CSUM.

Patch 4 adds __iptunnel_pull_header_reason(), because
__iptunnel_pull_header() reports a packet too short to pull as -ENOMEM,
the same as an allocation failure, and ip6_gre calls it for every GRE
packet, before the tunnel lookup.

Patches 7-10 convert the transmit side of ip_tunnel, ip_gre, ip6_tunnel
and ip6_gre. One reason is added, TNL_ENCAP, for a failure to build the
encapsulation header. Patch 9 is a small preparation:
prepare_ip6gre_xmit_other() cannot fail, so it is made void rather than
given a drop reason for a branch that never runs. ip6_tnl_xmit() leaves
freeing the packet to its callers, so it and the helpers between it and
the ndo_start_xmit handlers return the drop reason instead of an error.

The transmit side has its own case worth naming: tnl_update_pmtu()
returns -E2BIG after it has already sent the ICMP error back, which is
path MTU discovery working exactly as intended, yet among the device
counters the drop only bumps tx_errors, like a failed encapsulation and
a few other failures do. If the ICMP error never reaches the sender,
the resulting MTU black hole cannot be told from those by the device
counters; the reason tells them apart.

Drop reasons on transmit are not new: vxlan already reports several from
its xmit path, and ip_tunnel_core.c reports RECURSION_LIMIT. They are
most useful for forwarded packets, which is what a tunnel gateway mostly
transmits: the sender is another host, which gets an ICMP error for only
some of these failures, so the drop has to be explained on the gateway.

Changes since v3:
- the functions that took a drop reason output parameter now return the
  reason, SKB_NOT_DROPPED_YET on success: gre_parse_header(), the GRE
  receive helpers, ip6_tnl_xmit() and the helpers between it and the
  ndo_start_xmit handlers (Jakub)
- the callers of gre_parse_header() take the header length from
  tpi->hdr_len; the ICMP error handlers pass a new icmp_err argument
  instead of a NULL reason pointer
- the IPv6 transmit paths send the ICMP error on PKT_TOO_BIG, and
  ipgre_rcv() retries ETH_P_TEB on GRE_TUNNEL_NOT_FOUND: the same
  conditions as -EMSGSIZE and PACKET_NEXT before
- the motivation no longer says these drops are invisible; the problem
  is the NOT_SPECIFIED reason and the call site all the failures of a
  function share (Eric)
- new patch 4, __iptunnel_pull_header_reason(): a packet too short to
  pull is reported as PKT_TOO_SMALL instead of NOMEM
- PACKET_RCVD, PACKET_REJECT and PACKET_NEXT are removed
- the ip_tunnel transmit patch no longer says the counters cannot tell
  an MTU black hole from a failed route lookup
- the TNL_OPT_MISMATCH kernel-doc also covers an unexpected checksum;
  other commit message fixes

- v3: https://lore.kernel.org/netdev/20260916143717.1875082-1-littlesmilingcloud@gmail.com/
- v2: https://lore.kernel.org/netdev/20260913034937.875068-1-littlesmilingcloud@gmail.com/
- v1: https://lore.kernel.org/netdev/20260831215137.549324-1-littlesmilingcloud@gmail.com/

Anton Danilov (10):
  ip_tunnel: add drop reasons to the generic RX path
  ip6_tunnel: add drop reasons to the generic RX path
  gre: make gre_parse_header() report a drop reason
  ip_tunnel: add __iptunnel_pull_header_reason()
  ip_gre: add drop reasons to the RX path
  ip6_gre: add drop reasons to the RX path
  ip_tunnel: add drop reasons to the transmit path
  ip_gre: add drop reasons to the transmit path
  ip6_gre: make prepare_ip6gre_xmit_other() void
  ip6_tunnel: add drop reasons to the transmit path

 include/net/dropreason-core.h |  39 +++++++
 include/net/gre.h             |   5 +-
 include/net/ip6_tunnel.h      |   5 +-
 include/net/ip_tunnels.h      |  17 ++-
 net/ipv4/gre_demux.c          |  42 ++++---
 net/ipv4/ip_gre.c             | 187 +++++++++++++++++++-----------
 net/ipv4/ip_tunnel.c          |  60 ++++++++--
 net/ipv4/ip_tunnel_core.c     |  24 ++--
 net/ipv6/ip6_gre.c            | 211 ++++++++++++++++++++--------------
 net/ipv6/ip6_tunnel.c         | 123 ++++++++++++--------
 10 files changed, 467 insertions(+), 246 deletions(-)

-- 
2.47.3

