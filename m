Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605889;
	b=VwMKmUSJBMRGlVsuLytgBXncceplD9mzuLZcYCnPlZC9+6Tlr9onQMY3f6urc7DLsneb
	 XQaUXz1IlCIq7JcA4EI7KeICL+Gu7R9EV90AS3/Hd+vX8bV05ATkVikl4rKA8O4p1rV4d
	 PhApqHs84prqWtbqaGAx4Vx7+Xg4goCHun/9/maeL81RYDA/2vH+/3TxTjy0WcKOIltNS
	 t5s3A3cRK2O5j+6Sb7HUy/yaLsRTIBTj/irC0QuxXaPd4ySyXqHwtfLf/0NKupw3OM4tQ
	 b6HmvUaM61Pjn8CBjZuyRnROT3HVHP7cAgAHojWAqCe6qNdO/NJvokFRu4+GAehlEVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IKh826oksAsnXOv/8mkzFjoflIikbvfEEGMxfs2JQRg=;
	b=Pm3zpFJ+gMChT0LdpUor7wMO2cVJCWRjYR8Dx+0dd0T/hnAk/nVhagjNGlvXdsdyn8Yt
	 ZRR47EWpQCnYTc5BwcKbiKJSLWIaX3Gv1T5HJ+TpQrdha8P+PaKgSBYkdg0rsmBDsXCBk
	 U9ar8gD9MVATx0mVmoZYe+C7cvJcfVBWb6JzL9xv7tAOq8MUrnE0fdQC9GDKYFIEg/bNI
	 gD6zu/MX+sD3h1hWYSUcuv3v0oWE7bAFASDB/BMsrN2HImantzAByG2K703xqGaE34Wlq
	 CkEk5kGufHdiQkOZYix9n/0Lii7zd+sZPgwVvFy8Zlzhza2q9NA3y3gtUxyTXotbmkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWik3WnI;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1C606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 18:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D1C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWik3WnI
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so672095e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605886; x=1793210686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKh826oksAsnXOv/8mkzFjoflIikbvfEEGMxfs2JQRg=;
        b=CWik3WnIyChRkJiFjDby8AUm4P72t6GJlKKoLll9tcfUvy8nMdm6quUdw7bOp/Cdrj
         tnUONVfLRoDkwRY2U+J/41ipIVdLv2vw5v+ZP81cljtyAGPbU98VqDIbMpGcrWZjS+1h
         iUAag3s3ynMam7T5pk9UvjlcULGuIT4hot2neeVAts+OdV4zWf5icj27TPOMTMFi+iZX
         jPAWYgjWLqcSBjQ96JBu+RIbCpJosQCL8pYnhhq/MUw7dsvXQsFmorTyZz3NKMYKnfIF
         D/5TKGNf43tNXTrhdhCsVNVMvmn17vufPhh0YHUGqo7ej5u4G8muH4oukSj5wetRJ/l1
         quaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605886; x=1793210686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKh826oksAsnXOv/8mkzFjoflIikbvfEEGMxfs2JQRg=;
        b=DUUfJ6B1FRxCnukBzoM9EyZAOYDuZ24uLktu9xNYu9F3O0xx0l1/jV7QP6TvC1K0oP
         +wtaWHZLewClta4tW/qUCiJVKnVpFeejVj8/7ST8awJPvpz3SX/0ZI4eC1HXNJyCoFc3
         ra1sgKmjJSh7MOqKZwYRSMdaK0L07Q++Khg8LoSpic+dqlAdCCnMlyFAyRf9SL6d1tlp
         sqz4CBKLKULwfDASXtLDoi8BlQgqRE/sbxO0hvD9/ZQlNpvi1QYWg2s34T467JARGoUE
         k+sG8TbV6Rk8TOwyblaWGYJSpftEGXaEbKYywgPx88mp7XZQ68rJ78Px54BMJKH/oEeV
         347Q==
X-Forwarded-Encrypted: i=1; AKwUvBzwEVnbBguyVmpIde1VLOxCHWz4TteABybH7gdcTZGgYNQGGNZHC0fwD4v6GO+V8SY1oWZ15lI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtRuxCId59sk37lHo7PikYl46VEsr1LUqo+n1oN8Elgl06KH2b
	6HnWJYlMwfzl9HnDdTC85SThtWCDLFUclQGGuUkLdAJZ/eqUeeKBI8YY
X-Gm-Gg: AYBFou2MHBzn6UJSQhpqwRxAwHoD3fSajBsDA4zIgBo0RGPz3dkpKWT0sDospb0pu7l
	TtBiT7E2PGzlneIJA6PuteZscsMxUGuJvf97TzyKN9jJxauugU32MB1VPOOJrkT9UueqK8M3mLx
	YIvYia5kIvTMe5J5GiSteAV01z70NCZZ6/+mrxY2dvwK+6REt5yYgNqvVwAjWh1gMf/enR0jOnq
	adJIB+bP998u0vnFIOWlngjcTZbtigU42TJJO+uZzc8h3jEjK0VnTzAgapvn2NQZ0RnARIBZDvb
	xI6HpNITb1m/Ei7bLrI0OzguQhcTsSG61OmVWQPTgcpvq1XYfbJfO8BE64/sB6aBMuZVGOJuL64
	zPWMcj3RA+/2BYF/ZxG51u6Wk0MzI0kL6U73EKLUko75YlSZxG3CtYzBXE/F4QP1JxykDn04PJG
	mIUrDO22ktYoh90IvlOlIpYr29z2BE9b/gYiaRpclk1LZyhG/3Ydeq6XuChwV8od10z9ESi5F3a
	3x+7CCcLOMnw6o1BygnnkfLTSIHmC48qlUOrzxH5orEKaSYlO5jjSVExadLdK0BUt4B0n/AauFW
	YKu4SbE9yLHPR8YKDUMQTK94D3V7dYNRZUOiLVPaQEcZdM18NBbqZjSLdupftosPG2Pc8NZjKk6
	474bU5U6mgr5uUuxzcDcWzzpdeHcsP/JN
X-Received: by 2002:a05:600c:a48d:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a204bb59aamr2067385e9.16.1792605886218;
        Wed, 21 Oct 2026 11:04:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:e6ea:6401:f04a:ac6f:988e:f33d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd13891sm47007775e9.2.2026.10.21.11.04.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 11:04:45 -0700 (PDT)
From: Nick Simpson <nick.simo@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Sridhar Samudrala <sri@us.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] xsk, ipv6: validate user-supplied checksum offsets
Date: Wed, 21 Oct 2026 19:03:26 +0100
Message-ID: <20261021180329.26358-1-nick.simo@gmail.com>
X-Mailer: git-send-email 2.50.1
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

In copy mode, AF_XDP turns the csum_start/csum_offset of
XDP_TXMD_FLAGS_CHECKSUM into a CHECKSUM_PARTIAL skb after checking only
that the checksum fits in the frame. Sent over a veth into a namespace
that forwards IPv6 with nf_defrag_ipv6, the checksum is then completed
after the forward hook has accepted the packet, at an offset in the IPv6
header chosen by the sender; with csum_start before the network header,
skb_checksum_help() warns. Patch 1 has the details and the trace.

This is the AF_XDP counterpart of the virtio_net_hdr issue fixed for
IPv4 by commit 6785011f8b16 ("ipv4: validate checksum_start before
completing checksum") and addressed by the "more virtio-net csum
hardening" series [1], which does not cover AF_XDP.

Patch 1 is the fix: CHECKSUM_PARTIAL is kept only for the TCP or UDP
checksum of an unfragmented IPv4/IPv6 packet, not IP-in-IP or GRE
encapsulated, on an Ethernet device; other requests are completed in
software at the sender. Frames without a linear part
(IFF_TX_SKB_NO_LINEAR) are left unchanged. One visible change: a request
on a frame that is itself an IP fragment is completed over that fragment
alone, as a device would, so the reassembled datagram no longer has a
valid transport checksum and conntrack marks it invalid; before, if
every fragment carried a request, it stayed CHECKSUM_PARTIAL and was
completed on refragmentation.

Patch 2 documents the new behaviour in xsk-tx-metadata.rst. It is kept
separate so that patch 1 stays within the stable size limit.

Patch 3 is defence in depth: the IPv6 counterpart of
ip_check_csum_start() on the two IPv6 fragmentation paths,
ip6_fragment() and br_ip6_fragment(). For IPv4 the check is also
called from nfnetlink_queue, xt_CHECKSUM and xfrm_output; their IPv6
counterparts are not changed here, and a check at reassembly time would
cover more. Patch 1 does not depend on it, and it is not marked for
stable.

Testing, on netdev/net 82e31923c055, arm64 under QEMU:
- reproducer (fragmented IPv6/UDP over veth into a namespace with an
  nftables forward rule on "ip6 saddr", csum_start/csum_offset 22/22;
  an unfragmented packet with 14/22 and TX checksum offload off on the
  egress veth; csum_start 20): without the series the source address is
  rewritten after the forward hook accepted the packet, and
  skb_checksum_help() warns. With the series, or with patch 1 alone,
  nothing is rewritten after the accept and there is no warning; with
  patch 3 alone the fragmented cases are not sent on (ip6_fragment()
  drops them) and the unfragmented case is not covered
- a legitimate IPv6/UDP request (csum_start at the UDP header, offset 6)
  is still sent CHECKSUM_PARTIAL and delivered to a UDP socket
- which requests stay CHECKSUM_PARTIAL, observed on the veth peer with
  PACKET_AUXDATA: IPv4/UDP, IPv4/TCP, IPv4 with options, IPv6/UDP, IPv6
  with a hop-by-hop header and VLAN-tagged IPv6/UDP stay partial; a
  wrong csum_offset, csum_start in the IP header, IPv4 and IPv6 first
  fragments, IPIP and ICMP are completed in software with the correct
  value. Without the series all of them stay partial.
- tools/testing/selftests/bpf: test_progs -t xdp_metadata passes with
  and without the series
- on a kernel with KASAN, PROVE_LOCKING, PROVE_RCU,
  DEBUG_ATOMIC_SLEEP, DEBUG_PREEMPT, DEBUG_PAGEALLOC and
  DEBUG_OBJECTS_RCU_HEAD, no warnings: with the series, the
  reproducer, the classification test and the selftest; without it,
  the selftest and the legitimate request
- W=1 and sparse (C=1) on the changed files in allmodconfig builds for
  arm64, x86_64, i386 and s390: no warnings, with or without the
  series; checkstack unchanged; arm64 allnoconfig and an INET=n build
  with XDP_SOCKETS=y build; checkpatch --strict is clean; htmldocs for
  networking builds without warnings for xsk-tx-metadata.rst
- arm64 allmodconfig and allyesconfig with W=1 build, with no warning
  in the changed files (CONFIG_WERROR and the DRM *_WERROR options
  were turned off: with gcc 15, existing W=1 warnings in unrelated
  files otherwise stop the build)
Not tested: IFF_TX_SKB_NO_LINEAR (virtio_net) devices, multi-buffer
frames, an attached BPF flow dissector, a sender in an unprivileged
user namespace, x86 at runtime, and patch 3 with tun/tap or packet
socket sources of CHECKSUM_PARTIAL (the same header rewrite through a
tap device was reproduced on mainline earlier, but not re-run with
patch 3).

The issue was found, and the patches and tests prepared, with LLM
assistance (see the Assisted-by tags). I have reviewed the changes and
the test results. A reproducer is available on request.

[1] https://lore.kernel.org/r/cover.1792411304.git.mst@redhat.com

Nick Simpson (3):
  xsk: validate checksum offload requests in copy mode
  xsk: document checksum offload handling in copy mode
  ipv6: validate checksum_start before fragmenting

 Documentation/networking/xsk-tx-metadata.rst |  7 ++-
 include/net/ipv6.h                           | 12 ++++
 net/ipv6/ip6_output.c                        | 10 +++-
 net/ipv6/netfilter.c                         | 10 +++-
 net/xdp/xsk.c                                | 58 ++++++++++++++++++++
 5 files changed, 90 insertions(+), 7 deletions(-)


base-commit: 82e31923c0553fdbfcddcd910ca07952880ca9b9
-- 
2.53.0

