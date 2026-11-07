Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027655;
	b=xB+DQiFYAtdeTunBRUTiG1ALY5OxuhLeJF6fYpQQN5WeOU94IvQYCgxmDKr4cR4f1zkQ
	 LLCIyc1t4hvvOZblu4VjMXaM5JaNOf1HDvaC+r6R4pfJI3ivXjQN/dP6HMSLy7XEt/y3x
	 gyMrzqmutUgteoalvZWPd011ygSL7Z1sICkm9E3rqv1xUwPHZuuT3uieH2SmBbpry26on
	 d99/lgyCiDJlQoNyC+tFugTB8Shmk2yIk9P+1/W+xPm6RWTzbrCxaUxr/fEN+lF0CDA2L
	 veWiNGsXGPtt2imHS/qzornmAazt3kG+90x1w6xjVuZcD5fmM4Wx9m8iVYU3qXembHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027655;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U1gd6UA2nDUrScSCQliizSZWUXIvJcQRp5u6YbYjYJc=;
	b=TMxP1Q6Zetnh7afqp/nCv/pvarJZEdkWAAFONddIYyMnndEoQc9QKlKo7viu4dsdq3qC
	 5tqvRUK95xyU6G6p8qgp3O0oO1H2OCmdbo+Hcxy2kCaoMTRjuwt2ghTWBu3P10VxbnXhR
	 ti9abZQ+8t3VlGf+n5kQ8SM1/QhmbIPLxSvs13wwbX2rI52lwjqxGR6l7XjC5Snx9hoIh
	 NWidKbwXvIt7gCXgpE2oVRJQ8gTztWrIHZ703CVkYiFfbKE6YWsuPO0RxqT/ZOifiDiHm
	 yG3SA69FVsptJ0u9bOBc3xbbi8hTZmdwMuSTPgeog84j/f5N7gSd8iggBMkbe7DnQaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=JHCAlLA3;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB7606A331;
	Sat,  7 Nov 2026 05:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25FB7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=JHCAlLA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=JHCAlLA3JeXTRjgEEmoHG2hPMsWW3pRgKSitzvsz/O1QbU+GWQ8t0PE4dkgtsbMValNoMZqK2Uno6
	 HfSZrHOb36QhSV+ZPKYZ3vW/LTEsePQB3XtBVifjrOaJ167l4b+qw4vnvifyJKf3fLKKHJL/B+v1t6
	 LQJR8d8kK3ZAj2Kw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56aeeb07ccd9-b3131;
	Sat, 07 Nov 2026 13:00:46 +0800 (CST)
X-RM-TRANSID:2ee56aeeb07ccd9-b3131
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66aeeb06e3ff-3a7f5;
	Sat, 07 Nov 2026 13:00:46 +0800 (CST)
X-RM-TRANSID:2ee66aeeb06e3ff-3a7f5
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
Subject: [PATCH net-next v2] erspan: drop packets with an unknown ERSPAN version
Date: Sat,  7 Nov 2026 22:00:30 +0900
Message-ID: <20261107130030.35220-1-yanhaishuang@cmss.chinamobile.com>
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

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
Tested with hand-built GRE/ERSPAN packets sent over a veth into erspan
and ip6erspan devices, in plain and collect_md mode: version 0 packets
are now dropped, version 1 and 2 packets are unchanged.

v2:
- Drop the Fixes tags and correct the commit message: the ETH_HLEN pull
  of __iptunnel_pull_header() covers the metadata copy, so there is no
  out of bounds read (Ido, Sashiko).
- Drop the patch that skipped the type III sub-header, as no device is
  known to send it (Ido).
v1: https://lore.kernel.org/netdev/20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com/

 net/ipv4/ip_gre.c  | 4 +++-
 net/ipv6/ip6_gre.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5485586fa0e6..ea41be3c4229 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -303,8 +303,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	if (tunnel) {
 		if (is_erspan_type1(gre_hdr_len))
 			len = gre_hdr_len;
-		else
+		else if (ver == ERSPAN_VERSION || ver == ERSPAN_VERSION2)
 			len = gre_hdr_len + erspan_hdr_len(ver);
+		else
+			return PACKET_REJECT;
 
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b5d6ed8f0c36..46fac89a0743 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -507,6 +507,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	if (tunnel) {
 		int len = erspan_hdr_len(ver);
 
+		if (unlikely(ver != ERSPAN_VERSION && ver != ERSPAN_VERSION2))
+			return PACKET_REJECT;
+
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
 

base-commit: 303d91a1592587fdb481dd36a9ef2c0414dacb0f
-- 
2.43.0



