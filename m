Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296124;
	b=4babLvRcFvBqNK56LAn4xzD08BwvEZ8MGIfMo4UCKa4Hqn5pa4pJW75YoLYUlc8Aa1IX
	 fNKg506817tYV+n98/NjpbPuNv4UZPHN3Gi4w2kO7KbS62hf51AZQ13kUeIEK30dI78sF
	 QC3cXqBKB6S78HSGniKFUe+bzRo5H67ZlYAvllyesofInkJ9QRz9/WvXu9H3S1Rm1gxDg
	 eCFrPvC+r5em5kbgg/Dm41WO4JQyLH27Cg0a1ryPiOlPQ38QRqFeORr/kXkXI9VoZ6ddC
	 Q2pWIztBm95gGDMdJDFyW09BtDRc/zgbtICID5JKxwJ5j9D/cGgY7XRtSK8u04BQ3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296124;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dab/A/i+GScxx85l1FMnGvkoYL6jXJ4ltrwbw5NIbSw=;
	b=uMf65b5cmsjJ3Pazk62w7WS2LDRUfne2KxVGilCRioGXN6Z+HrHtGg8A/q+OL9nFjq5g
	 w33391JR7UOfqNqNtSnx7S4cPako5dEfl0v7TAGk+/SK779paO7pNU9/WgybBiTZm68zi
	 e4uq/8JRfekITwN6fBijgjD/7dPHQx4Ms54ygpq3U2lZRyaZpj/zNJngWGyYkI/Ox8tF/
	 t4xDJHnKvz9adNgE6rgJ5m5hBbYE/P7Aa3M2Y3ONTHIxS1rFQDptQLrbKIoklOaApvUCO
	 90aMKt8q+UFCb+LGQQ9XJdqG7ejK3EUzPlWjEiP7IJIJOcA6QD7tIyxvWAQybDkvPRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="QXTW+jn/";
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA060A260A;
	Tue, 10 Nov 2026 07:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01BA060A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QXTW+jn/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QXTW+jn/k2p6irJWawWwnTH3kAQLUBTaskDr572XvnTVU1uSb8ZQl6fyxq2ETvXjDgy2VJBUbCmoL
	 XcOW5RphDhcgyWCb0MbTnqG5DU9w64Ryi5Tu7Oud4rj4WDKX+L5OUYzlRxPEWD9Q8wmCfOeJqLAjuL
	 x8A82I7fyBxNoqmc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af2c93922d-6c046;
	Tue, 10 Nov 2026 15:35:21 +0800 (CST)
X-RM-TRANSID:2ee46af2c93922d-6c046
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af2c9242df-ac0c4;
	Tue, 10 Nov 2026 15:35:21 +0800 (CST)
X-RM-TRANSID:2ee46af2c9242df-ac0c4
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	William Tu <witu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] erspan: drop packets with an unknown ERSPAN version
Date: Wed, 11 Nov 2026 00:28:48 +0900
Message-ID: <20261110152848.23136-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

The ERSPAN type II and III receive paths take the length of the ERSPAN
header from the version field of the packet, with erspan_hdr_len(), but
never check that the version is one they know: 1 for type II or 2 for
type III.

For any other version, erspan_hdr_len() returns 0 or the type III
length. With version 0, the ERSPAN header is not pulled, so it is
passed up as the start of the inner Ethernet frame, and in collect_md
mode the metadata is filled from the wrong part of the header. The
ETH_HLEN pull in __iptunnel_pull_header() still covers the bytes that
are copied, so nothing is read past the pulled data.

Reject such packets, as a packet with a truncated ERSPAN header already
is.

On IPv4, a packet with a 4-byte GRE header is taken as type I without
looking at the protocol. gre_parse_header() treats an ETH_P_ERSPAN2
packet as carrying an ERSPAN header whatever the GRE header length,
but erspan_rcv() then skips that header's version and passes it up as
the inner frame. Type I only uses ETH_P_ERSPAN, so check the protocol
too. Such a packet now goes through the type III path and its version
check.

IPv6 has no type I, but ip6erspan_rcv() does not reject a type I
packet, an ETH_P_ERSPAN packet with a 4-byte GRE header. Such a packet
has no ERSPAN header, so the version is read from the inner destination
MAC address, and if that happens to be 1 or 2, the start of the inner
frame is stripped as an ERSPAN header. Reject these packets too.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
The issue was found with the help of an AI coding assistant.

Tested on x86_64 with ip_gre and ip6_gre built from net-next
fa5196392691 with this patch, by sending hand-built GRE/ERSPAN packets
over a veth into erspan and ip6erspan devices, in plain and collect_md
mode: version 0 packets, ERSPAN2 packets with a 4-byte GRE header and
version 0 or 3, and on IPv6 type I packets whose inner destination MAC
starts with 0x1 or 0x2 are now dropped. Version 1 and 2 packets and
IPv4 type I packets are unchanged, and erspan v1/v2 ping over IPv4 and
IPv6 still works.

v4:
- Also reject type I packets in ip6erspan_rcv() (Sashiko).
v3: https://lore.kernel.org/netdev/20261108193504.73393-1-yanhaishuang@cmss.chinamobile.com/
- Also check the protocol when classifying a packet as type I, so that
  an ETH_P_ERSPAN2 packet with a 4-byte GRE header gets the version
  check too (Sashiko).
v2: https://lore.kernel.org/netdev/20261107130030.35220-1-yanhaishuang@cmss.chinamobile.com/
- Drop the Fixes tags and correct the commit message: the ETH_HLEN pull
  of __iptunnel_pull_header() covers the metadata copy, so there is no
  out of bounds read (Ido, Sashiko).
- Drop the patch that skipped the type III sub-header, as no device is
  known to send it (Ido).
v1: https://lore.kernel.org/netdev/20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com/

 net/ipv4/ip_gre.c  | 12 +++++++-----
 net/ipv6/ip6_gre.c |  9 +++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5485586fa0e6..f8a7c4353502 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -255,13 +255,13 @@ static void gre_err(struct sk_buff *skb, u32 info)
 	ipgre_err(skb, info, &tpi);
 }
 
-static bool is_erspan_type1(int gre_hdr_len)
+static bool is_erspan_type1(const struct tnl_ptk_info *tpi, int gre_hdr_len)
 {
 	/* Both ERSPAN type I (version 0) and type II (version 1) use
 	 * protocol 0x88BE, but the type I has only 4-byte GRE header,
 	 * while type II has 8-byte.
 	 */
-	return gre_hdr_len == 4;
+	return tpi->proto == htons(ETH_P_ERSPAN) && gre_hdr_len == 4;
 }
 
 static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
@@ -282,7 +282,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 	itn = net_generic(net, erspan_net_id);
 	iph = ip_hdr(skb);
-	if (is_erspan_type1(gre_hdr_len)) {
+	if (is_erspan_type1(tpi, gre_hdr_len)) {
 		ver = 0;
 		__set_bit(IP_TUNNEL_NO_KEY_BIT, flags);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
@@ -301,10 +301,12 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	}
 
 	if (tunnel) {
-		if (is_erspan_type1(gre_hdr_len))
+		if (is_erspan_type1(tpi, gre_hdr_len))
 			len = gre_hdr_len;
-		else
+		else if (ver == ERSPAN_VERSION || ver == ERSPAN_VERSION2)
 			len = gre_hdr_len + erspan_hdr_len(ver);
+		else
+			return PACKET_REJECT;
 
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b5d6ed8f0c36..26c0e1c4de18 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -494,6 +494,12 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
+	/* There is no type I (ETH_P_ERSPAN with a 4-byte GRE header) on
+	 * IPv6, and such a packet carries no ERSPAN header to look at.
+	 */
+	if (unlikely(tpi->proto == htons(ETH_P_ERSPAN) && gre_hdr_len == 4))
+		return PACKET_REJECT;
+
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
 		return PACKET_REJECT;
 
@@ -507,6 +513,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	if (tunnel) {
 		int len = erspan_hdr_len(ver);
 
+		if (unlikely(ver != ERSPAN_VERSION && ver != ERSPAN_VERSION2))
+			return PACKET_REJECT;
+
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
 

base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.43.0



