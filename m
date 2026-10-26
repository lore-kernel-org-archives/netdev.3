Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033245;
	b=3ImSyxVVUlPrKfbAXMyKlfd6QsdFuyJRo877SDQe96l0/X2sQGfwXE0SSeSxqU4TKxJw
	 Z+/G1ZQU8lgpXqitccZ+Tw6JYABq+HOt/TiKFfl43vcPkqDdsyhJNCv3Mh2nf3q32650T
	 uBm3nzYsfpgV2QDDp2iC03UTaCjDaizaEEUl2zziE2xeUGuxpnobMubztJgQ58xdZreuF
	 97BPBTl2q0LqVxsi9m20dvcfPfL8SKAktPBCQKrbQyI3minMAZeLaByOexOvlubMQzLoN
	 ZFQO0ookPjILK5HQlg88XfOtZTj6tJo1hIg0vGEDlMObsGO245Jtx99qVR+KTR5ivcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033245;
	h=DMARC-Filter:X-Originating-IP:Received:DKIM-Signature:X-Session-ID:
	 X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QMOoqe+TutbkbsZc737NRYZEP57anVwx9xxuV+n/o3I=;
	b=qpKkr7ZGGoQtrxuml7lhGdmcB++ddlkg0aYIVXNoegjKz5MXcTEjd2FcmJapBCMGDo+i
	 mz9Id5Z1bSFkWcipdjHBauT7k1Tcc7eNPNId4efUtYGOwnRanwwCwcOy/i/n4NNEE58uv
	 24Xc1Cew1edUUjT+PSChgqFHVqT7eM6cOv4qKOwIvx92vA3NzXIciBiQniS4d/S5cxv4k
	 JaTr/IDgf9eEZguaTRKTVV5RpMRr4xJI+Ye+QAG57MalpJMTNgrm3tfmumBsbIVn7GSsO
	 Eb7j6E/07C3dt7GwgTLJmaTOT5F2Kt28nnYHGpODqaT40M6Eg5aTycI00JA5pQPLafQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=naver.com;
	spf=pass smtp.mailfrom=naver.com;
	dkim=pass header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=sM2ca90g;
	arc=none smtp.remote-ip=114.111.35.32
Received: from cvsmtppost17.nm.naver.com (cvsmtppost17.nm.naver.com [114.111.35.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D70606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D70606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=sM2ca90g
Received: from cvsendbo001.nm ([10.112.18.53])
  by cvsmtppost17.nm.naver.com with ESMTP id rNKkf2VkSVOySG-f+Dv9xw
  for <netdev@vger.kernel.org>;
  Mon, 26 Oct 2026 16:47:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1793033237; bh=09sRZR9KY7m2H+U8tfnwmsxMDaYtH4E+cTV0rpldJ+0=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=sM2ca90gmOlPQ7OMSFWOuQ18440qEi9aZ3w8wVtuI9BNpsr+bsL8qKYMmVpEIpWZi
	 9OlGibtOkzvXTN4Eb6NyvioBlNSVQCpRUDC2ddw+Yf2zEWVySYFCXpJk3xv0xpVQa8
	 n7q7sBCV0Ha/nAOcIzmQqDekJCqWus6CS9WB/WMMy1ZPWKj8goSJUYSd/U5eYWFNhe
	 rCU+Tku3b8hWYU72epRO8fQRGMGrih7FfpD7lTd9f+HOlc/vog7214zuABe4PCF3uC
	 jLRBLGow5spRZgDW6eDKsWSmXdkXg1ytU28jLu8C3evei3Jy20r0d0ga2JiBrglNcz
	 rizhyLysPAoUw==
X-Session-ID: SRKOlrDjSuuNfm11+xl0TQ
X-Works-Send-Opt: vf+5b4RCjHmZjAJYKouwjAuwKAvwKqgZFopYjAJYKg==
X-Works-Smtp-Source: dqbmKAKlFqJZ+HmrKq2m+6E=
Received: from localhost.localdomain ([183.100.208.186])
  by cvnsmtp004.nm.naver.com with ESMTP id SRKOlrDjSuuNfm11+xl0TQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Mon, 26 Oct 2026 16:47:16 -0000
From: Haon KIM <akrn112@naver.com>
To: dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Haon KIM <akrn112@naver.com>
Subject: [PATCH net] net: vrf: Set L3MDEV OIF flag for outbound lookups
Date: Tue, 27 Oct 2026 01:47:02 +0900
Message-Id: <20261026164702.1415-1-akrn112@naver.com>
X-Mailer: git-send-email 2.37.0.windows.1
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

The IPv4 and IPv6 outbound processing paths in the VRF driver
set the L3 master device index in the flow structure before
performing route lookups, but do not set
FLOWI_FLAG_L3MDEV_OIF.

Both the IPv4 and IPv6 outbound processing paths contain
the comment "needed to match OIF rule", indicating that
the L3 master device index is needed to match OIF rules.
However, FIB rule matching requires both
FLOWI_FLAG_L3MDEV_OIF and a matching flowi_l3mdev index
to match a rule specifying the VRF master as the output
interface.

The matching logic introduced by commit 2d300ce0b783
("net: fib_rules: Fix iif / oif matching on L3 master device")
requires FLOWI_FLAG_L3MDEV_OIF to be set for OIF rules to
match the VRF master. The existing outbound processing paths
set the L3 master device index directly, so
l3mdev_update_flow() does not set this flag.

Consequently, OIF rules specifying the VRF master may fail
to match these flows.

Set FLOWI_FLAG_L3MDEV_OIF in both outbound processing paths
so that FIB rules can correctly match the VRF master as the
output interface.

The issue was identified by code inspection. Runtime testing
has not been performed.

Fixes: 2d300ce0b783 ("net: fib_rules: Fix iif / oif matching on L3 master device")
Signed-off-by: Haon KIM <akrn112@naver.com>
---
 drivers/net/vrf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 79d433f49f80..f22ac91fefd4 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -432,6 +432,7 @@ static netdev_tx_t vrf_process_v6_outbound(struct sk_buff *skb,
 	fl6.flowlabel = ip6_flowinfo(iph);
 	fl6.flowi6_mark = skb->mark;
 	fl6.flowi6_proto = iph->nexthdr;
+	fl6.flowi6_flags = FLOWI_FLAG_L3MDEV_OIF;
 
 	dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
 	if (IS_ERR(dst) || dst == dst_null)
@@ -506,7 +507,7 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
 	fl4.flowi4_l3mdev = vrf_dev->ifindex;
 	fl4.flowi4_iif = LOOPBACK_IFINDEX;
 	fl4.flowi4_dscp = ip4h_dscp(ip4h);
-	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
+	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC | FLOWI_FLAG_L3MDEV_OIF;
 	fl4.flowi4_proto = ip4h->protocol;
 	fl4.daddr = ip4h->daddr;
 	fl4.saddr = ip4h->saddr;
-- 
2.37.0

