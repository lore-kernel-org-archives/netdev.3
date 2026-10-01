Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41743F1048
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881910; cv=none; b=dNZd3IOCOgYlsKOUhlZWweL/gMZq/q8mfAg9vKV5BPeecC1IBWyPfQfpde/e2qPKydwRmfU+s/Tly7FMYjPLKvhXeHXFPT9kg6YuIcGODlMg2xZyfltDnd4X/paUW/VmJuBIW2SRGI5XtCQ2iyoUXGd3g+fsLxYMITk+xPp8P3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881910; c=relaxed/simple;
	bh=VWMUirdcJhMGUi0UL84Ghg4eNM4gOXw6t5MZ5bk53W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GH2luXQyueCbngk/sXy+mDcGcF+n4d7v9UbHNetEw1gDRFKIFhqJAhEJLg4QOaz6+bmY33iABw3UwXnCQhuscsu+LjQAQwBsGw22ShtKbJ4eXAvwUkTfa/ehBNRM8gG5GM1FvdJu3yKvT9LjqFnZksN9+RN824ze5DcYB5eIqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrpEJ+5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrpEJ+5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40DD1F000FF;
	Thu,  1 Oct 2026 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790881906;
	bh=788g6AX+kEzIrLsjZn3D6cvllALeyyXNPdhgfbbKGDw=;
	h=From:To:Cc:Subject:Date;
	b=KrpEJ+5PlpEM7iDb2xwIGI808o77zQrzX8G7SmhskVaD4HuFCSWm5QxejOSeIcX9r
	 JXVPkp69q+Klou+IOGkxbj9NAMKni7BhlAstNM7hJXtBYQD02DF1vvY+obM8SCptr/
	 cBmlUF5D8w1XG/PoJXp6U4umJoMnl16U86Uy4idOt56jjkN0RKd04pKXhZ9Cth3SNY
	 kDq58vzqdpl7LAeRHGcJKl2WLj0hb7M/zAqvMENWsq14RjtvazhJTQGN4da4mwODYS
	 1KhS+vvG9tQyrvIngXgcM117B3V2szxeV2tihZLUR+3Wcs529BOACKzcPJ1ITt5uqu
	 Hy03Neu26Jklw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net 0/3] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
Date: Thu,  1 Oct 2026 19:11:37 +0000
Message-ID: <20261001191140.2818991-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bypass of untrusted GSO flow dissection in
__virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is not set,
and adds a kselftest covering VLAN-tagged GSO packets without NEEDS_CSUM:

- Patch 1 fixes __skb_flow_dissect(), which computes key_control->thoff
  with min_t(u16, ...). This truncates skb->len and returns a bogus small
  transport offset when skb->len modulo 65536 is smaller than the
  transport offset. Offsets that do not fit in the u16 thoff now fail the
  dissection instead of being silently truncated.

- Patch 2 initializes skb->dev and skb->network_header before calling
  virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
  virtnet_receive_done(), and raw_verify_header(), removes the
  '&& skb->network_header' condition and the unvalidated
  'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), and moves
  virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys_basic()
  so it validates the dissected L3 protocol (keys.basic.n_proto) rather
  than the outer L2 protocol.

- Patch 3 adds kselftests in tools/testing/selftests/net/tun.c verifying
  that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSUM (both
  flags = 0 and flags = VIRTIO_NET_HDR_F_DATA_VALID) are accepted on a
  TAP device, that mismatched GSO types and truncated TCP headers without
  NEEDS_CSUM are rejected with -EINVAL, and that a 65540-byte frame is
  accepted.

v3:
 - New patch 1: avoid u16 truncation of skb->len when computing thoff in
   __skb_flow_dissect(). Patch 2 makes tun_get_user() dissect IFF_TAP
   frames before eth_type_trans(), with skb->len up to 65549 for a GSO
   frame carrying a maximal IPv4 packet (Sashiko).
 - Patch 3: truncate the TCP header after 10 bytes so that the test
   requires the transport offset found by flow dissection, and add a
   65540-byte frame test (Sashiko).
 - Link to v2: https://lore.kernel.org/netdev/20260928144254.3361044-1-edumazet@kernel.org/

v2:
 - Patch 2: drop the pre-dissection virtio_net_hdr_match_proto() check
   inside 'if (!skb->protocol)' so VLAN-tagged GSO frames without
   NEEDS_CSUM are not rejected before flow dissection (Michael S. Tsirkin).
 - Patch 2: clarify the changelog regarding why skb->network_header was 0
   in those callers and why skb_reset_mac_header() is dropped in
   tun_get_user() for IFF_TUN (Michael S. Tsirkin).
 - Patch 3: add selftest in tools/testing/selftests/net/tun.c based on
   Michael's reproducer.
 - Link to v1: https://lore.kernel.org/netdev/20260927195536.2489079-1-edumazet@google.com/

Eric Dumazet (3):
  flow_dissector: avoid u16 truncation of skb->len when computing thoff
  net: always dissect GSO packets in __virtio_net_hdr_to_skb()
  selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM

 arch/um/drivers/vector_transports.c |   1 +
 drivers/net/tun.c                   |  23 +++--
 drivers/net/virtio_net.c            |   2 +
 include/linux/virtio_net.h          |  60 +++++-------
 net/core/flow_dissector.c           |   9 +-
 tools/testing/selftests/net/tun.c   | 136 ++++++++++++++++++++++++++++
 6 files changed, 186 insertions(+), 45 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

