Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58859346FA0;
	Sun, 18 Oct 2026 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314208; cv=none; b=bO9r1K+4ycnt7HkuG6Ab5Fi6GWiW/ggE1xqeTQFN5z+FcBYukUxiLnr/SckkNyyXpiXhzUyTfQplaOWNvEyCfRpOmkDAArnu8tyiYDaNiQQtD2MbZtSLmTdaeCH/kJtTLrzN1DNjJGXLlmFEN8Q3SdKKmzYS5zByJ89L3yyeBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314208; c=relaxed/simple;
	bh=f3f5IHx0dcEAgHK3kzpdgbBZIaG5uTvotMrVX6H/r0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8OEM+AxBKRrZI9XRNt+hcDxWZkp6EfutOZCqq27wg8Tm0u0juq+tcB7iza3LWZkRqsZpjN9Ald0zwV0uJ7eyYKfnc0XgkC9y4WrMYSXp/Mtx6De9jdCiJtIPZY2cFN/Vv/ezPfwoTy0LpOx9h6p2cOLiiR6o/f/OTf435qmZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=nDRQufll; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="nDRQufll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=nDRQuflldMafCo46dZXtOoumY6p7RD/9It25a9ihLoLuat8MAEAMCYXIE9uq9wreeRyEpeAPSIQwJ
	 vsPVb7Rt8F50Euiw+EF4slCyST5JWZCEQbJhRqIT+UsLXvxEQq4jz9kncFbG45Eo4T+9Q6kpyWDNPY
	 Beg641DVXYE+go5o=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ad48b508f8-05d3d;
	Sun, 18 Oct 2026 17:03:17 +0800 (CST)
X-RM-TRANSID:2ee56ad48b508f8-05d3d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[112.22.251.201])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6ad48b34aee-7c204;
	Sun, 18 Oct 2026 17:03:17 +0800 (CST)
X-RM-TRANSID:2eea6ad48b34aee-7c204
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net-next 2/2] erspan: skip the platform specific sub-header of ERSPAN type III
Date: Sun, 18 Oct 2026 17:02:36 +0800
Message-ID: <20261018090236.2487997-3-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com>
References: <20261018090236.2487997-1-yanhaishuang@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ERSPAN type III header has an O flag, which tells whether an
optional platform specific sub-header of 8 octets follows it. The
ERSPAN payload starts after that sub-header when the flag is set [1].

Linux never sets the flag on transmit, but it ignores it on receive
too. When a peer sends the sub-header, its 8 bytes are passed up as the
start of the mirrored Ethernet frame, so the frame is corrupted.

Pull the sub-header as well when the O flag is set. The collect_md
metadata still only carries the fixed part of the type III header.

[1] https://datatracker.ietf.org/doc/html/draft-foschiano-erspan-03

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 include/net/erspan.h |  4 ++++
 net/ipv4/ip_gre.c    | 10 ++++++++++
 net/ipv6/ip6_gre.c   | 10 ++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/net/erspan.h b/include/net/erspan.h
index c6209e7b6c96..0ef4338588c4 100644
--- a/include/net/erspan.h
+++ b/include/net/erspan.h
@@ -94,6 +94,10 @@ enum erspan_encap_type {
 
 #define ERSPAN_V1_MDSIZE	4
 #define ERSPAN_V2_MDSIZE	8
+/* Optional platform specific sub-header of ERSPAN type III, which follows
+ * the header when its O flag is set.
+ */
+#define ERSPAN_V2_SUBHDR_LEN	8
 
 struct erspan_base_hdr {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 2f112c1edf7c..b24ff0eca30b 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -311,6 +311,16 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
 
+		if (ver == ERSPAN_VERSION2) {
+			md2 = (struct erspan_md2 *)(skb->data + gre_hdr_len +
+						    sizeof(*ershdr));
+			if (md2->o) {
+				len += ERSPAN_V2_SUBHDR_LEN;
+				if (unlikely(!pskb_may_pull(skb, len)))
+					return PACKET_REJECT;
+			}
+		}
+
 		if (__iptunnel_pull_header(skb,
 					   len,
 					   htons(ETH_P_TEB),
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 3fe395ed92f9..c87a7198e5a8 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -513,6 +513,16 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 		if (unlikely(!pskb_may_pull(skb, len)))
 			return PACKET_REJECT;
 
+		if (ver == ERSPAN_VERSION2) {
+			md2 = (struct erspan_md2 *)(skb->data +
+						    sizeof(*ershdr));
+			if (md2->o) {
+				len += ERSPAN_V2_SUBHDR_LEN;
+				if (unlikely(!pskb_may_pull(skb, len)))
+					return PACKET_REJECT;
+			}
+		}
+
 		if (__iptunnel_pull_header(skb, len,
 					   htons(ETH_P_TEB),
 					   false, false))
-- 
2.43.0



