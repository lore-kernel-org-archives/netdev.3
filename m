Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE6479882
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881916; cv=none; b=qbWuin2W/3QvYGpmwM/FnAu+2FiDxMPcGVLCJuQYe70W9UFFWSwYqsFmFhlOy9rwX82gWYMYatIqbr3kdF51xkLlRrhFfpd4rJiMc1Zwi8PpsH6HOrdNtzeghuXi0vDvZGbUwGFz0djrOyBBe8Ct/MJq9xmlFhJpLv6xPcrbVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881916; c=relaxed/simple;
	bh=2kQ5HyGCqIYXmwehYvuH4lBXZGqsljvo2J6EHtZr31I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGrcQm7D0b9kT1BC4y07KJ1p2kPcQTMq/dCzX0M4BCj0pM//HGZN5ZN/v9+JndfusL3kj+ECqfxGFDzWVaj6nHiCeYGpN5YHct1FrQQPSEexR0Wm6KcAMjMs3Ei3UDULZLegQf9gxacS1FzNOSUH2YimlKf8wQgJ01Sa6mKr2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsE+Fbca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsE+Fbca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302A71F000FF;
	Thu,  1 Oct 2026 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790881911;
	bh=5A9+ICU2a47qU3a3ecQUGkAkvb1goP7YtH5Yta52Gt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MsE+FbcaUWhfxee8oskfcvrmCQcajBOl0Tt+t22pvGZIhztejRH50RxlL1RJYghld
	 e3qrCEuQSt7OVSRajAVLl6tuSIZf7Ubu269NvnPgfLj/THSzFYLfBf3TZi+xYCu7fn
	 D0iMtIDE8liQs2Lq+Bfeqm6JWE6B6DlE+vJLBqMq4yPIG26Ru9bEDxHb5db9pRBluB
	 vFJEVsB2viytua2XKkY/twljuNxToD94XUrONvmxTJIlZzQs8OfN6dFzgs7mVbXy8j
	 gqY+h8Y8jVHRlY8L6VzmHszodoKCjeIvEi3Pw6r0RBgo79Y/tgdNHekaknoHT0BlD7
	 i6WIcIOnxyXCw==
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
Subject: [PATCH v3 net 3/3] selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM
Date: Thu,  1 Oct 2026 19:11:40 +0000
Message-ID: <20261001191140.2818991-4-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261001191140.2818991-1-edumazet@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests in tun.c verifying that a VLAN-tagged (802.1Q) TCPv4 GSO
packet without VIRTIO_NET_HDR_F_NEEDS_CSUM (both flags = 0 and
flags = VIRTIO_NET_HDR_F_DATA_VALID) is accepted when written to a TAP
device (/dev/net/tun with IFF_TAP | IFF_NO_PI | IFF_VNET_HDR).

Also verify that the following are rejected with -EINVAL:
- a mismatched GSO type (VIRTIO_NET_HDR_GSO_TCPV6 on a VLAN-tagged IPv4
  packet).
- a frame whose TCP header is truncated after 10 bytes. Pulling only
  sizeof(struct iphdr) + sizeof(struct tcphdr) bytes would accept it,
  so this requires the transport offset found by flow dissection.

Finally, verify that a 65540-byte frame is accepted. Its skb->len is
above U16_MAX while it is flow-dissected, before eth_type_trans() pulls
the Ethernet header.

Based on a reproducer by Michael S. Tsirkin <mst@redhat.com>.

Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tun.c | 136 ++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index abe488bac50bb3b05df5c446836c1c3dfa9ea604..afaa81c9bac5311944c9a70a20de05bffb683f26 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <linux/if_tun.h>
+#include <netinet/tcp.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
@@ -542,6 +543,141 @@ TEST_F(tun, reattach_close_delete)
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+FIXTURE(tun_vnet_gso)
+{
+	char ifname[IFNAMSIZ];
+	int fd;
+};
+
+FIXTURE_SETUP(tun_vnet_gso)
+{
+	int flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
+
+	memset(self->ifname, 0, sizeof(self->ifname));
+	self->fd = tun_open(self->ifname, flags, 0, 0, NULL);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_TEARDOWN(tun_vnet_gso)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+static int build_vlan_tcpv4_gso_packet(uint8_t *buf, int payload_len)
+{
+	uint16_t vlan_tag[2] = { htons(100), htons(ETH_P_IP) };
+	uint8_t *cur = buf + sizeof(struct virtio_net_hdr);
+	struct virtio_net_hdr vh = { 0 };
+	struct tcphdr tcph = { 0 };
+	uint32_t sum;
+
+	cur += build_eth(cur, ETH_P_8021Q, param_hwaddr_outer_src,
+			 param_hwaddr_outer_dst);
+
+	/* 802.1Q tag: VID=100, inner protocol=ETH_P_IP */
+	memcpy(cur, vlan_tag, sizeof(vlan_tag));
+	cur += sizeof(vlan_tag);
+
+	cur += build_ipv4_header(cur, IPPROTO_TCP,
+				 sizeof(tcph) + payload_len,
+				 &param_ipaddr4_outer_src,
+				 &param_ipaddr4_outer_dst);
+
+	tcph.source = htons(12345);
+	tcph.dest = htons(80);
+	tcph.seq = htonl(1);
+	tcph.doff = sizeof(tcph) / 4;
+	tcph.ack = 1;
+	tcph.window = htons(65535);
+	memcpy(cur, &tcph, sizeof(tcph));
+	memset(cur + sizeof(tcph), PKT_DATA, payload_len);
+
+	sum = add_csum((const uint8_t *)&param_ipaddr4_outer_src,
+		       sizeof(param_ipaddr4_outer_src));
+	sum += add_csum((const uint8_t *)&param_ipaddr4_outer_dst,
+			sizeof(param_ipaddr4_outer_dst));
+	sum += htons(IPPROTO_TCP) + htons(sizeof(tcph) + payload_len);
+	sum += add_csum(cur, sizeof(tcph) + payload_len);
+	tcph.check = finish_ip_csum(sum);
+	memcpy(cur, &tcph, sizeof(tcph));
+	cur += sizeof(tcph) + payload_len;
+
+	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
+	vh.gso_size = 1400;
+	vh.hdr_len = (cur - buf) - sizeof(vh) - payload_len;
+	memcpy(buf, &vh, sizeof(vh));
+
+	return cur - buf;
+}
+
+TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum)
+{
+	struct virtio_net_hdr vh;
+	uint8_t pkt[4096] = { 0 };
+	int len, ret;
+
+	len = build_vlan_tcpv4_gso_packet(pkt, 2800);
+	memcpy(&vh, pkt, sizeof(vh));
+
+	/* Valid VLAN-tagged TCPv4 GSO with flags = 0 (no NEEDS_CSUM) */
+	vh.flags = 0;
+	memcpy(pkt, &vh, sizeof(vh));
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, len);
+
+	/* Valid VLAN-tagged TCPv4 GSO with flags = DATA_VALID */
+	vh.flags = VIRTIO_NET_HDR_F_DATA_VALID;
+	memcpy(pkt, &vh, sizeof(vh));
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, len);
+
+	/* Mismatched GSO type (TCPV6 on VLAN-tagged IPv4 packet) */
+	vh.flags = 0;
+	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
+	memcpy(pkt, &vh, sizeof(vh));
+	ret = write(self->fd, pkt, len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* TCP header truncated after 10 bytes, without NEEDS_CSUM.
+	 * Requires the transport header offset found by flow dissection:
+	 * pulling only sizeof(struct iphdr) + sizeof(struct tcphdr) bytes
+	 * from the mac header would accept this frame.
+	 */
+	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
+	vh.hdr_len = ETH_HLEN + 4 + sizeof(struct iphdr) + 10;
+	memcpy(pkt, &vh, sizeof(vh));
+	ret = write(self->fd, pkt, sizeof(vh) + vh.hdr_len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)
+{
+	/* Ethernet frame of 65540 bytes: skb->len is above U16_MAX when the
+	 * frame is flow-dissected, before eth_type_trans() pulls ETH_HLEN.
+	 */
+	const int payload_len = 65540 - ETH_HLEN - 4 -
+				sizeof(struct iphdr) - sizeof(struct tcphdr);
+	struct virtio_net_hdr vh;
+	uint8_t *pkt;
+	int len, ret;
+
+	pkt = calloc(1, sizeof(vh) + 65540);
+	ASSERT_NE(pkt, NULL);
+
+	len = build_vlan_tcpv4_gso_packet(pkt, payload_len);
+	ASSERT_EQ(len, sizeof(vh) + 65540);
+	memcpy(&vh, pkt, sizeof(vh));
+
+	vh.flags = 0;
+	memcpy(pkt, &vh, sizeof(vh));
+	ret = write(self->fd, pkt, len);
+	free(pkt);
+	ASSERT_EQ(ret, len);
+}
+
 FIXTURE(tun_vnet_udptnl)
 {
 	char ifname[IFNAMSIZ];
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

