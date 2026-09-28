Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89744C4F69
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606591; cv=none; b=Q43ZY4RMcNz1dtbGlMLLrs2wsPSQag7udF91KfH2g3hypWnUYYA/7wi5MAp2Jpv4qAlAGkWTCKDleRoV0Zo20wXp2dHVO0aciJCyD78D1+DLvFEA9nrD3fHesdmWd9iylixduOV0bnscdUxcAvvXX4vdYe/71mBX8zbVyUTgeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606591; c=relaxed/simple;
	bh=OSfRzVDUvBeAN7hm0ECX9M2AaR/sma3/1Fm9X0pEYxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNybHypV/imxJ/pP3GMVJCZ3cgT73CtB3MgLTA6omqAUs6frLMspRvK5TsRMbC+k6R0OCiHiLeKpKsQ8wE18B/7HRQHS0Sbr34cklY67lZFar7dpd6mZg92ZGi62E5q/IvhoKnm3L1C2IodpBHbXxGx5FgE4lzEjCkS3XDq+iJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PksIICp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PksIICp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94001F00898;
	Mon, 28 Sep 2026 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790606583;
	bh=WNDL+BHhx1E7tAaK0LTR3OnIXWP1n0O7e/XtPSm/qhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PksIICp+2yQr+cCNwWJTITYDVijfwvtfsjMZe6FP8PChm6SCEJkn02hqSpU5b4Xmr
	 BRgatUereSYKOBA1GQ78O+zuIbvabMPiqDE0dkSXOT2nKfXEIpt5GRA0BNo2HnnaJE
	 6Zzj9ipGGl/XiGWaWL4fs3obRigg8oR+uBWKeIY2aNtHNPIW6tCEoHRcls9CLKgki4
	 2OGAd6n6RSU1mIvYa1TukicYzDQdMP9fQY4AcripJ/euylzVDgcq66Tnt3ByfoPUfD
	 puiWBn8z71lE8Etl7oCF92A2TiyCqTHtcF3U+37vHMh9xnFM7/iLr95yAeFx0D4ECD
	 8da/+1PElELfw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	edumazet@kernel.org
Subject: [PATCH v2 net 2/2] selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM
Date: Mon, 28 Sep 2026 14:42:53 +0000
Message-ID: <20260928144254.3361044-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260928144254.3361044-1-edumazet@kernel.org>
References: <20260928144254.3361044-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest in tun.c verifying that a VLAN-tagged (802.1Q) TCPv4 GSO
packet without VIRTIO_NET_HDR_F_NEEDS_CSUM (both flags = 0 and
flags = VIRTIO_NET_HDR_F_DATA_VALID) is accepted when written to a TAP
device (/dev/net/tun with IFF_TAP | IFF_NO_PI | IFF_VNET_HDR).

Also verify that mismatched GSO types (e.g. VIRTIO_NET_HDR_GSO_TCPV6 on
a VLAN-tagged IPv4 packet) and truncated headers without NEEDS_CSUM are
rejected with -EINVAL.

Based on a reproducer by Michael S. Tsirkin <mst@redhat.com>.

Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 tools/testing/selftests/net/tun.c | 107 ++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index abe488bac50bb3b05df5c446836c1c3dfa9ea604..c6afafb7b957360e2873640e60a7d580c6564a66 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <linux/if_tun.h>
+#include <netinet/tcp.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
@@ -542,6 +543,112 @@ TEST_F(tun, reattach_close_delete)
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
+	/* Truncated TCP header without NEEDS_CSUM */
+	vh.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
+	vh.hdr_len = ETH_HLEN + 4 + sizeof(struct iphdr);
+	memcpy(pkt, &vh, sizeof(vh));
+	ret = write(self->fd, pkt, sizeof(vh) + vh.hdr_len);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
 FIXTURE(tun_vnet_udptnl)
 {
 	char ifname[IFNAMSIZ];
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

