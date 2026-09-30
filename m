Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB44F5E18
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793564; cv=none; b=gb/s33AxED3wCYp3Q9SAC/9GJ9iJebB4U8ymVZI+BItgKsari3I9PawSGXCyLHZsgO0t0o7f11rPMshZ0pmnGi/MAl11ZuWqwWI1o+4M1EvUDNh+m5C9dSJymqnuP0ViZwqN27Ofm4Cr94/0ze3s2HnfLhGTXo4kFvkwbXY/gT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793564; c=relaxed/simple;
	bh=BOpp6DRP7KQqQA59TF7zhVWFL4ApPAzbS6wEP9TMK1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m29KAYaKg/z3LLLNDPNnOX9cLinyOi64zibIa+V4LTpHctcqbMp5fY7r6/MaWIVL0FTDlK998oi8zQGIZBcFp18wZwQVwNsu1nQsj8goHhl96wlKRQqbvGY6NhSWPwNKRl8yQNpKr+QMSxAPlXnLgmKmUc+81SV4pERgMAHaQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVUsn0Me; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVUsn0Me"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba379d8804so1740173e87.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793561; x=1791398361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ToqTunoRW+HAQtTGFMTKEaJX6dglQl5RR6Nhjpbaiso=;
        b=DVUsn0MeCRVwFs3HsO0EzcQgRInH4ICQO1D1nmrDtmOzTQkh7u49SbwDufkDPf9KHw
         52Mx6mhUADWZI6tFPBKd+WFcyOGqHaxoNpOTPAKVqY0Oppj7Z9IL5caRsgnH5JrBBC82
         ARtibXjXQCnnRt7DowEM5xFZCFIdAkQMNsXbmM/91a+WZF5h3lWOKFkEDzD4i4bpaPXH
         JqsgF72SgHVWBJtiHAYprG2/xtM2QdtvW2CDhX1+ncBU4Rdd/73k6H/PHFRyZOIQwr+z
         xwPL+OIs+A9q7LCvxUHlemmRFbEDT1WtpS7FOqbs2/Urb2C684tc681j6eS0MrRpkma4
         veIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793561; x=1791398361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ToqTunoRW+HAQtTGFMTKEaJX6dglQl5RR6Nhjpbaiso=;
        b=ooU9m3iwK9U9WEZgYFAKStfv2ihXTSP7XI2NAwnvNuB6tQlKgAPTQq6mxDgD0G2L01
         lxXJoADKw4gId6Q/fe9NlYsAbnahhPeZ1KoWD/b7ctlKU0XaCEm49clwKWlx2Q36RR7A
         QfRzciCA10yCWRfoGaqNL6nkY9xGg/7Rcd1eTL1dS09A7GY8vaeCKWNsjcKYpUv0Im3o
         DWt4RyOLo3hxcQ6pXOQLLMilnxpkjQcH9Q2Hcz4retNQ/7phN6/zm7ht1Mhs2TPWL0Rm
         iIVikxuq5MF9fIELy7DBUTO0ytGAqdaRv6rhGWtPJZ3gdcsbfBv3boZ7B/vpurxk1nOf
         GXyg==
X-Gm-Message-State: AFq9FYK9sJJZKwsFvRqiap4IdGjDDLWQgfBv3vduGVO4vHk4PsFylT4P
	UH+ornnhSYzGTmbD36lgj9V/YgHvTsKUBDevrVkKhWLOS8S2seol8hv5ZMWiD1gt
X-Gm-Gg: AYBFou0zoCRM5o7JH/EynOHjKUUMe1Dpy+f/Mq7a+55f96DhlybmDVFahuNzdPOHMLV
	dRB49Isv/0+GbVsBdJM8ooMQ/c4lk1FGrWelYR6v3qK9AP6cQwAfRajisP+D/Blo4ZUl7FowkDC
	My8CwsP1qfVMWEzILhMKBHQjhK44meRa0/4XTlGOPVAfAdAc33rLa5e5B5LfHV1VdUa8VdoWTJ7
	3tqMUhY8fqqK9omwy9xwFpDkkk00kAedl5EXcuMfZsydEJIFhDrNXpUhDCs6fNp96oUDtkU7ZLk
	yNgmtek+aqoAY+g8Wt1EcrV8ZivaihtleE2Jij1wONShntwkJqJQ58xpuiGFQZadcYN68jxuPPZ
	1PFJQ6Puc8KNiRnF6GymR3Cz+BUSM3qSqyjdg2d/GK28vKpUVuKb+rNr3SpOwTd6WJ259tKTc1u
	xABcR/gbYhEsW+UDmjlzf9DbwJ7C/Cd7tIHBCs718dErSS+MvYt2mC0I8obmHzLLc4JnpNCEGLU
	QwFCs2AWQ7C2QV167/rxNigUAqgeCS3Ic6U46IYBpsSGg==
X-Received: by 2002:a05:6512:244f:b0:5ba:4372:9250 with SMTP id 2adb3069b0e04-5ba4372938emr104711e87.4.1790793560430;
        Wed, 30 Sep 2026 11:39:20 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:19 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 00/14] tunnels: add core and gre drop reasons
Date: Wed, 30 Sep 2026 21:38:56 +0300
Message-ID: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
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
stable key either: its offset moves with the compiler, inlining and the
configuration, and the debug info that maps it back to a source line
only serves that one build, as the line moves with any change to the
file. So a filter on it has to follow every rebuild. The reason does not
move with the build: NET_DM_ATTR_REASON reports it, and a BPF program
can match it by name. The device counters group the failures coarsely
too: rx_errors and tx_errors each lump together unrelated conditions.

This series covers the generic paths shared by ipip, sit, gre and their
IPv6 counterparts, plus the GRE and ip6tnl specific code, in both
directions; the code specific to ipip and sit keeps kfree_skb(). So does
the tunnel4 and tunnel6 demux, shared with the xfrm tunnels, which frees
the packets that no ipip, sit or ip6tnl device takes. ip6tnl is in
because its transmit handler goes through ip6_tnl_xmit(), which changes
along with ip6_gre, and its receive side is converted to match. The
series also makes two vxlan reasons generic, so that GRE reports the
same ones.

Patch 1 renames VXLAN_INVALID_HDR and VXLAN_VNI_NOT_FOUND to
TUNNEL_INVALID_HDR and TUNNEL_NOT_FOUND. Their values stay the same;
the names vxlan drops are reported with change.

Patch 2 makes __iptunnel_pull_header() and iptunnel_pull_header() return
a drop reason. Until now they returned -ENOMEM for any failure, so a
packet too short to pull looked like an allocation failure: vxlan
reports it as NOMEM, and ip6_gre would do the same for a packet from any
sender whose inner Ethernet header or WCCPv2 word is cut short, since it
pulls the header before the tunnel lookup. Patch 3 has vxlan report the
reason these functions now return.

Patches 4-5 convert the generic receive paths, ip_tunnel_rcv() and
__ip6_tnl_rcv(); patch 5 also converts ipxip6_rcv(), the ip6tnl handler
in front of the latter. Two reasons are added:

  TUNNEL_OPT_MISMATCH  the options a packet carries do not match the
                       tunnel configuration
  TUNNEL_OLD_SEQ       the sequence number is older than the one the
                       tunnel expects, like TCP_OLD_SEQUENCE for TCP

The second one has a failure mode worth naming: when a peer reboots, its
outgoing sequence number restarts at zero, and the receiver can drop
everything until the peer's numbers get past the last one the receiver
accepted. By the counters alone that looks like a misconfiguration: a
packet without the sequence number option bumps the same rx_fifo_errors.

Patches 6-8 convert the GRE specific receive path. gre_parse_header()
returns -EINVAL for every failure, and the only detail its callers could
get was a csum_err flag that none of them read: both ip_gre and ip6_gre
declared it, passed it in and ignored it. gre_parse_header() now returns
a drop reason instead, and its callers take the header length from
tpi->hdr_len. The receive helpers below gre_rcv() return the drop reason
instead of a PACKET_* code, and the PACKET_* codes go away. The GRE
receive paths report TUNNEL_INVALID_HDR and TUNNEL_NOT_FOUND, the length
checks report what pskb_may_pull_reason() returns, and one reason is
added, GRE_CSUM, like TCP_CSUM and UDP_CSUM.

Patches 9-13 convert the transmit side of ip_tunnel, ip_gre, ip6_tunnel
and ip6_gre. One reason is added, TUNNEL_ENCAP, for a failure to build
the encapsulation header. Patch 11 is a small preparation:
prepare_ip6gre_xmit_other() cannot fail, so it is made void rather than
given a drop reason for a branch that never runs. ip6_tnl_xmit() leaves
freeing the packet to its callers, so patch 12 makes it and the helpers
between it and the ndo_start_xmit handlers return the drop reason
instead of an error, and patch 13 converts the ip6_gre handlers. Patch
14 has vxlan report a route that goes out of the vxlan device itself as
RECURSION_LIMIT, as ip_tunnel and ip6_tunnel now do, instead of
IP_OUTNOROUTES.

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

The reason variable follows one rule in the functions this series
converts that have a drop label: it is initialized to
SKB_DROP_REASON_NOT_SPECIFIED unless the first statement of the function
sets it, and where a helper stores its result in it, the drop label
falls back to SKB_DROP_REASON_NOT_SPECIFIED, as in vxlan_rcv(). Together
they keep a drop without a reason of its own, including one that a later
change adds, from freeing a packet with SKB_NOT_DROPPED_YET. Every drop
path of the series sets a reason, except the looped back multicast check
in ip_gre's gre_rcv().

Changes since v4:
- new patch 1 renames VXLAN_INVALID_HDR and VXLAN_VNI_NOT_FOUND to
  TUNNEL_INVALID_HDR and TUNNEL_NOT_FOUND, and GRE reports those instead
  of the GRE_INVALID_HDR and GRE_TUNNEL_NOT_FOUND added by v4 (Ido)
- the TNL_* reasons are renamed to TUNNEL_*, to match
- the length checks report what pskb_may_pull_reason() returns instead
  of HDR_TRUNC; the WCCP check, which uses skb_header_pointer(), reports
  PKT_TOO_SMALL (Ido)
- gre_rcv() in the demux reports TUNNEL_INVALID_HDR instead of
  UNHANDLED_PROTO for a version it cannot dispatch (Ido)
- __iptunnel_pull_header() and iptunnel_pull_header() return the drop
  reason themselves, instead of the __iptunnel_pull_header_reason() v4
  added; the three callers that tested the result with "< 0" test for a
  non-zero value (Ido)
- new patch 3 has vxlan report the reason __iptunnel_pull_header()
  returns (Ido)
- ip_tunnel_xmit() sets the reason for an NBMA payload it cannot derive
  a destination from in the branch that uses it (Ido); the reason is now
  NO_TX_TARGET, as for the other NBMA packets without a destination
- the gre_parse_header() argument icmp_err is called ignore_csum_err,
  after what it does, and the function has a kernel-doc comment
- the cover letter no longer announces a series for other tunnel
  drivers (Ido)
- ipxip6_rcv() reports drop reasons too (patch 5), so the ip6tnl code
  is converted in both directions
- the ip6_tunnel transmit patch is split in two: ip6_tnl_xmit() and the
  ip6_gre helpers (patch 12), then the ip6_gre handlers (patch 13)
- the reason is initialized to NOT_SPECIFIED only where the first
  statement of a function does not set it, and a drop label reached
  after a helper falls back to NOT_SPECIFIED, as in vxlan_rcv()
- new patch 14 has vxlan report a circular route as RECURSION_LIMIT, as
  ip_tunnel and ip6_tunnel do
- the description of RECURSION_LIMIT gives the tunnel case as an
  example (patch 9)
- a transmit through an NBMA tunnel that finds no endpoint for the
  packet, and through an ip6_gre device without a remote, reports
  NO_TX_TARGET, as on the IPv4 side, instead of DEV_READY; the message
  of patch 12 describes the cases DEV_READY still covers
- ip6gre_tunnel_xmit() drops a packet without IPv6 metadata on a
  collect_md device as TUNNEL_TXINFO right after it looks the metadata
  up, as ip6erspan does, so the DAD probes of an ip6gretap device are no
  longer reported as RECURSION_LIMIT (patch 13)
- the Assisted-by tags take the form that
  Documentation/process/coding-assistants.rst gives

- v4: https://lore.kernel.org/netdev/20260922221507.3268127-1-littlesmilingcloud@gmail.com/
- v3: https://lore.kernel.org/netdev/20260916143717.1875082-1-littlesmilingcloud@gmail.com/
- v2: https://lore.kernel.org/netdev/20260913034937.875068-1-littlesmilingcloud@gmail.com/
- v1: https://lore.kernel.org/netdev/20260831215137.549324-1-littlesmilingcloud@gmail.com/

Anton Danilov (14):
  vxlan: rename the drop reasons for use by other tunnels
  ip_tunnel: make __iptunnel_pull_header() return a drop reason
  vxlan: report the drop reason of __iptunnel_pull_header()
  ip_tunnel: add drop reasons to the generic RX path
  ip6_tunnel: add drop reasons to the receive path
  gre: make gre_parse_header() report a drop reason
  ip_gre: add drop reasons to the RX path
  ip6_gre: add drop reasons to the RX path
  ip_tunnel: add drop reasons to the transmit path
  ip_gre: add drop reasons to the transmit path
  ip6_gre: make prepare_ip6gre_xmit_other() void
  ip6_tunnel: make ip6_tnl_xmit() return a drop reason
  ip6_gre: add drop reasons to the transmit path
  vxlan: report a circular route as SKB_DROP_REASON_RECURSION_LIMIT

 drivers/net/vxlan/vxlan_core.c |  26 ++--
 include/net/dropreason-core.h  |  53 ++++++--
 include/net/gre.h              |   5 +-
 include/net/ip6_tunnel.h       |   5 +-
 include/net/ip_tunnels.h       |  14 +-
 net/ipv4/gre_demux.c           |  65 ++++++---
 net/ipv4/ip_gre.c              | 199 +++++++++++++++++----------
 net/ipv4/ip_tunnel.c           |  64 ++++++---
 net/ipv4/ip_tunnel_core.c      |  22 ++-
 net/ipv6/ip6_gre.c             | 236 ++++++++++++++++++++-------------
 net/ipv6/ip6_tunnel.c          | 153 +++++++++++++--------
 11 files changed, 556 insertions(+), 286 deletions(-)

-- 
2.47.3

