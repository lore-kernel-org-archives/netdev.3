Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342027;
	b=kRjlnZPoAOJZ3YVljctS1D9LoCiTByn/gKeqUWWcn6kWrS/hM4FXShUI6l3m4E38Ix6V
	 w65YX+hlzep4VTeD3etHQiJkpNApHqF/7ULgfG0JDs9Lw9kTvHWSRp1fW8dMAWJiWfhw6
	 Tx/cJZ7CyFFW77c4z+DPK9ejHHgOPnftkyZ3aw4ARrMojDTET+zRszFiSNmsBiKCuZ+Bt
	 D0NKeBCdqQzkxS+jiC72cOTAJ3tOXxqYQN/WVWcP0l56Mnk09FHGBWu2acJD/vPj4ZuhS
	 4dXu43znfzZsfceA2pzIQImSj5Eu4DeIS7aKmf+pgYvkEDjXEZ7uQkpQrSxHmXa0EcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4wO9tG+e/9njCwC0puklxG0DiT7rzT+c7jUfSyIX2RI=;
	b=vvc5EYsN9Bg/s6XJL226c4p9iCpKSTxdZF3EZgdPLNPBaxXLFacUWtULfBZy2Z4kCedE
	 6xblyxmixXM/S0kOVzc1ZfNT0WCx920bhDThvotvRc0PhnbaMEIaoEJkgZ2ZlfTz+yRC5
	 ZvGU0gGvNw4wrBZ4yRa8T8IywkzDUYbruzrY9jn/ZG7ymiacBzm5xnucANWPD6DDdu4XH
	 0qaaw5TfigZlPr+gFLrnqXAE/B9OXGlVH4uMrgjvynLlf17iyjlfO0O6/WZFE24cNxhFU
	 h3Yw6kV0cDNC6JgqatfWXF1APprjLH+mzD3nHTvaiCwFbrmar1ClpWhdEut+gxD8DLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QsfUoEZD;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B2606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B75B2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QsfUoEZD
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3accd1ff4c3so19066621fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342025; x=1794946825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wO9tG+e/9njCwC0puklxG0DiT7rzT+c7jUfSyIX2RI=;
        b=QsfUoEZDi3HsT1hKlgHEhrb2FKfiZwiR4B+ywOvtiE8c980xC2XTWQpakj3OcxrV9t
         J35sQEQXUhwC/oK7xbzVNzzR1SkS5VF/x+nT6YpsEaYcBIH4FgyzSGY28O9J5aFAeJa6
         Exm7yS2dqvYt80EctniXd1hkNzq5yjCEsbhF1NDhACccuwyE8Zg6hFXlbww8mCqfL1db
         DjHbpG40/Q+Y3UPI/vComjd7kFzeoC2NgdWpKi3gcXqQntaQtYUS6hGeUqhbx8IsKMbe
         yjaJ0yjh2XMuRjeMya0OVbnFjinZEG74V07hCe4w5I5yoGzpGBh7PJHlSD9ivRjwZBq7
         eD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342025; x=1794946825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wO9tG+e/9njCwC0puklxG0DiT7rzT+c7jUfSyIX2RI=;
        b=qhotCYAQNCKpCXtfPj3XV91d1ItO9dXdjXVkJCf05jjHE/CKguNSCGflACr4TSqCRC
         yt381+y8d/62raDddKlToOcGkNZtNwh6uGv66luHoGUztwluBDeYNgdVr/dAKR/vHeE3
         WpkuYCVBcDthl5NL5Ff/B6GLRYpxPBR87fGabtF4xqnehTyJytSuEQoXoRoAA9Q8EokC
         NfPsN8Dgo2IM2C3TxUC7lc9X+TkT3Rb7cFIH/ab7n1V912s2xLcz6Gi1rYs3HdsDZq2d
         IorfQQuJ0eXC+EutuJsrnUkUKTYaYqZ/ArLF5eRGxpl6vwB+EYfI+1NhbAxPWiwiPASV
         8Hbw==
X-Gm-Message-State: APuU4Z/dTANz36nKF1pibfXe2W1vXl9543+Wd/u/CoFUfAv/onn6dpa9
	tQ0U7eCsghVXWp3sAkdtUbqFj+omtuQDmxeiN/e6dXoxJsL/KPOLbvtAICs+w9RRWxAiZA==
X-Gm-Gg: AYBFou2oUqXMd4VPlD5hxkErG9TCQ1usxlfTJoOddn8OrTvp+6bDOPqDbNY09HKMEZ2
	4c5Q8z19QUJYBgixEerEWXAxf54wGVwDSeFWUlFuFM0ki9f9HHabuax3QjlHi9QeYu/wUKakms5
	613RDywT1ugDzKBlgSp0LeueLrrNbUCfd/TVCRsukMJx7qrF1h0XxFXoI6o2ZKzHVyv0yKPmwOm
	IFtkNG5bQntL6ywlylrxhuYBC76blEVAEq7+YtCdTdZlTM4sL+s4N/jdtn09qQgnPzkBEe1/Qzt
	+QXvE7VoTZ/Sd+IgpsjdjgMsXYqiR6iTkcwAxGCwGbeMZaPoDdIAFLgti9w6DBMq5cFdDOnlVVF
	FVPC9Nb27ITWpBYXAIY0Vy/9+1EUpn4mEvyqhqK5+3FjPaJt+1pHsd7r4I6Q2IVhXWgwl2QRz64
	ZHZwy2qNmTEpMjcifgJV0bYVIaH+VK4fXu3TMrPc8+k389jkNJEpcfkasz9jFKy09lK5T6rFvix
	CE3B8JkjduVCUvPWM01lhscVpcPzUWFpM+LSlTtA7/m2LaDBQeOoH8mk8vUnKK3bj9bVn9nI9Bq
	iZE8qcCnaRqD1fCRlpIB0rmxoV6Aiz/1lp+kXXgZ05RpmrxQ0mw9qzdUCdwIz0/hEl8nwVzpVDP
	WU4fVjKKB8UgzLiRN
X-Received: by 2002:a05:651c:f02:b0:3a9:74f3:17d5 with SMTP id 38308e7fff4ca-3ae0956b450mr8439811fa.3.1794342024664;
        Tue, 10 Nov 2026 12:20:24 -0800 (PST)
Received: from dau-home-pc.megasoftware.org ([95.139.137.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae090ea59esm5945401fa.0.2026.11.10.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:20:22 -0800 (PST)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 0/8] tunnels: add core and gre drop reasons
Date: Tue, 10 Nov 2026 23:20:13 +0300
Message-ID: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

This series covers the receive paths shared by ipip, sit, gre and their
IPv6 counterparts, plus the GRE and ip6tnl specific receive code, and
the IPv4 transmit side of ip_tunnel and ip_gre; the code specific to
ipip and sit keeps kfree_skb(). So does the tunnel4 and tunnel6 demux,
shared with the xfrm tunnels, which frees the packets that no ipip, sit
or ip6tnl device takes. The IPv6 transmit side, ip6_tnl_xmit() and the
ip6_gre handlers, is left for a later series. GRE reports the reasons
vxlan reports for the same conditions, which commit 7629d6db839f
("vxlan: rename the drop reasons for use by other tunnels") made
generic.

Patches 1-2 convert the generic receive paths, ip_tunnel_rcv() and
__ip6_tnl_rcv(); patch 2 also converts ipxip6_rcv(), the ip6tnl handler
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

Patches 3-5 convert the GRE specific receive path. gre_parse_header()
returns -EINVAL for every failure, and the only detail its callers could
get was a csum_err flag that none of them read: both ip_gre and ip6_gre
declared it, passed it in and ignored it. gre_parse_header() now returns
a drop reason instead, and its callers take the header length from
tpi->hdr_len. The receive helpers below gre_rcv() return the drop reason
instead of a PACKET_* code, and the PACKET_* codes go away. The GRE
receive paths report TUNNEL_INVALID_HDR and TUNNEL_NOT_FOUND, the length
checks report what pskb_may_pull_reason() returns, and one reason is
added, GRE_CSUM, like TCP_CSUM and UDP_CSUM.

Patches 6-8 convert the IPv4 transmit side. Patch 6 makes
ip_tunnel_encap() return a drop reason: NOMEM when a FOU or GUE callback
fails to allocate, and the new TUNNEL_ENCAP for any other failure to
build the encapsulation header. Patches 7-8 convert the transmit paths
of ip_tunnel and ip_gre.

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
sets it, and every jump to the drop label comes with a reason of its
own. Every drop path of the series reports a reason other than
NOT_SPECIFIED, except the looped back multicast check in ip_gre's
gre_rcv() and a packet that ip6_tnl_rcv_ctl() refuses.

This series was developed with an LLM-based coding assistant (Claude
Code). It was used to write and revise the code and the changelogs, to
build and test the series in virtme-ng, and to review it before posting
with a local run of the Sashiko review prompts. I have reviewed every
change and every text and take responsibility for them.

Changes since v5:
- v5 is split (Ido): its vxlan patches 1-3 and 14 were posted on their
  own and are in net-next; this is v5 4-10 plus the new patch 6, and
  v5 11-13, the IPv6 transmit side, follow in a later series
- the drop labels no longer fall back to NOT_SPECIFIED: no jump reaches
  them without a reason (Ido). In patch 3, until the handlers return a
  reason, gre_rcv() of ip_gre and ip6_gre sets NOT_SPECIFIED once the
  header is parsed; patches 4 and 5 remove that again
- new patch 6 makes ip_tunnel_encap() return a drop reason, so that an
  allocation failure of the FOU and GUE callbacks is reported as NOMEM
  rather than TUNNEL_ENCAP (Ido); TUNNEL_ENCAP is added there instead of
  in patch 7. ip6_tnl_encap() follows with the IPv6 transmit side, as
  its only caller is ip6_tnl_xmit()
- a packet that ip6_tnl_rcv_ctl() refuses is reported as NOT_SPECIFIED
  instead of DEV_READY (Ido)
- the looped back multicast check in ip_gre's gre_rcv() sets
  NOT_SPECIFIED explicitly instead of relying on the initializer, so
  that every jump to a drop label comes with a reason of its own
- the description of TUNNEL_OLD_SEQ also names reordering as a cause,
  not only a restart of the remote endpoint
- the description of RECURSION_LIMIT gives the tunnel case as an example
  since the vxlan patches, so patch 7 no longer changes it
- the Assisted-by tags are dropped after commit 1e035297ffda ("docs:
  remove Assisted-by references"); the paragraph above describes the
  tool use instead

- v5: https://lore.kernel.org/netdev/20260930183910.3151873-1-littlesmilingcloud@gmail.com/
- vxlan part of v5: https://lore.kernel.org/netdev/20261005201417.906344-1-littlesmilingcloud@gmail.com/
- v4: https://lore.kernel.org/netdev/20260922221507.3268127-1-littlesmilingcloud@gmail.com/
- v3: https://lore.kernel.org/netdev/20260916143717.1875082-1-littlesmilingcloud@gmail.com/
- v2: https://lore.kernel.org/netdev/20260913034937.875068-1-littlesmilingcloud@gmail.com/
- v1: https://lore.kernel.org/netdev/20260831215137.549324-1-littlesmilingcloud@gmail.com/

Anton Danilov (8):
  ip_tunnel: add drop reasons to the generic RX path
  ip6_tunnel: add drop reasons to the receive path
  gre: make gre_parse_header() report a drop reason
  ip_gre: add drop reasons to the RX path
  ip6_gre: add drop reasons to the RX path
  ip_tunnel: make ip_tunnel_encap() return a drop reason
  ip_tunnel: add drop reasons to the transmit path
  ip_gre: add drop reasons to the transmit path

 include/net/dropreason-core.h |  31 +++++-
 include/net/gre.h             |   5 +-
 include/net/ip_tunnels.h      |  20 ++--
 net/ipv4/gre_demux.c          |  64 +++++++----
 net/ipv4/ip_gre.c             | 197 ++++++++++++++++++++++------------
 net/ipv4/ip_tunnel.c          |  61 ++++++++---
 net/ipv6/ip6_gre.c            |  62 ++++++-----
 net/ipv6/ip6_tunnel.c         |  45 +++++---
 net/ipv6/sit.c                |   2 +-
 9 files changed, 328 insertions(+), 159 deletions(-)

-- 
2.47.3

