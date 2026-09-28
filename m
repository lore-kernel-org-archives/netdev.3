Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40364DAFAD
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606587; cv=none; b=AmQ5f4tT5rqNDj9hZPLS7wo9zCcha3Xdd6VRY+URBR2UkG8j6kdsKG4Puz1FytNNYvZKGwRUAbZXpYiGPm1nmklP86CgDIHUXAs8sjgaoJnN+1tLW47fyj5ms339STxKky5MMmyGLxpGHP9iQ+14tIXvZu+o3/RzArqf8PzF+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606587; c=relaxed/simple;
	bh=3igxtc4zUTESBw0Ar4iJeRH7/CeZG60+YdkXUFMRVR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVs1rwI44Bjp947quM5nPtJK1k/Wl5yaG52+qlcfYtGg7DRdsOcIKDw02uVe9fguBBJnMms2WuOS0ycpwE0g60tnNGDJf1MRB6upF27PIl5u5WbsDBMGYyjvqh6LMQ89PZlJASXMdaaSxYADEBCkARHoLLU8cyyUJJ81FEFOA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7IEfrCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7IEfrCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2AB1F000FF;
	Mon, 28 Sep 2026 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790606580;
	bh=z8zrRA+MfPc3dht4cMUxmTSTeOKudZ0A8yNZJxI4LBY=;
	h=From:To:Cc:Subject:Date;
	b=T7IEfrCPxaTV6zJ4h+1rtsnuaXUG2GEJ6QoWSxBtrDO0r7LcoaqfJ/wjZt7zZbA90
	 4inG63yP6+IIHhdVco2oFkMhlvRfRd8BlTqhyz8bQ5bXPALD3PJ1HiPkQDvW6tLbu0
	 sOUHMqa/tw2ou3yTfIC3lQ0Ld1NOuPRPqY3zG7lf6U8ow3vXGktp11CRAdq83/6KN8
	 R2VhV6++cg1gorRGB3S2eEYFJDlk46DAqRu8eGOXvS6SXnnrXRnpPCsRYkc5l3Vlj9
	 c2e17AvWluctubIBNtyxtY1eG4hsKhXvHt3mneXJStsv+Wy3pK6aiqbMbInGSRZaXf
	 Ab4f8dhwZoEBw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	edumazet@kernel.org
Subject: [PATCH v2 net 0/2] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
Date: Mon, 28 Sep 2026 14:42:51 +0000
Message-ID: <20260928144254.3361044-1-edumazet@kernel.org>
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

- Patch 1 initializes skb->dev and skb->network_header before calling
  virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
  virtnet_receive_done(), and raw_verify_header(), removes the
  '&& skb->network_header' condition and the unvalidated
  'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), and moves
  virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys_basic()
  so it validates the dissected L3 protocol (keys.basic.n_proto) rather
  than the outer L2 protocol.

- Patch 2 adds a kselftest in tools/testing/selftests/net/tun.c verifying
  that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSUM (both
  flags = 0 and flags = VIRTIO_NET_HDR_F_DATA_VALID) are accepted on a
  TAP device, and that mismatched GSO types and truncated headers without
  NEEDS_CSUM are rejected with -EINVAL.

v2:
 - Patch 1: drop the pre-dissection virtio_net_hdr_match_proto() check
   inside 'if (!skb->protocol)' so VLAN-tagged GSO frames without
   NEEDS_CSUM are not rejected before flow dissection (Michael S. Tsirkin).
 - Patch 1: clarify the changelog regarding why skb->network_header was 0
   in those callers and why skb_reset_mac_header() is dropped in
   tun_get_user() for IFF_TUN (Michael S. Tsirkin).
 - Patch 2: add selftest in tools/testing/selftests/net/tun.c based on
   Michael's reproducer.
 - Link to v1: https://lore.kernel.org/netdev/20260927195536.2489079-1-edumazet@google.com/

Eric Dumazet (2):
  net: always dissect GSO packets in __virtio_net_hdr_to_skb()
  selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM

 arch/um/drivers/vector_transports.c |   1 +
 drivers/net/tun.c                   |  23 +++---
 drivers/net/virtio_net.c            |   2 +
 include/linux/virtio_net.h          |  60 +++++++---------
 tools/testing/selftests/net/tun.c   | 107 ++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 44 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

