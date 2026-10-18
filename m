Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53A2E8DE3;
	Sun, 18 Oct 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314206; cv=none; b=QAfUfRVpWbAQ/gzvs+kWR1HdtuoNlHrTPLTInPoMtiBJ55BcJzoHz89h0Sb2bn188Xk3C/aZNSsVb9JSGYOnfsfS76J+hpZMWv7Jto1ncvt4IXoBhsesbbs/schKe4vR2lVak82SsgtOZs6i74TFwIb20DGIIlJsDLdjeZf9T7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314206; c=relaxed/simple;
	bh=DHN6URFKmV+bvGuOokjjvjXxOSZrP0bhrQowrhmuTXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlMTqeMqR/wsfER+yxcY+w8OADsv3kmZSg1rRAJnxrC215a6HiR4Mkd70/AeCN5uzOulV1Wme9Ipl96XMylcE1wSTKDPkVvZ8eBV9tbsIDmeYB52fjBUhyRL1lixfS9eQo9gi6/3k3zX5KvwgPxCPu6jeUJyEPywsWVx0XsPpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=gxfi+iu1; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="gxfi+iu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=gxfi+iu1oES02AoPMFotH0bs/EpyGreTh/okdotFC25bI/cdr3KXevLkdX+jOe6QTkuJytb3DJ9Gx
	 O9V33AS/tHbfD+1JTzxXSpVKcrsKuVmyPsIbGuuEXKHTdtGZlhYQ6kjeuEMRsrTSxXywd5T0SL6QIX
	 JrZ5BtJsRpAEKPWI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ad48b532e7-0897c;
	Sun, 18 Oct 2026 17:03:15 +0800 (CST)
X-RM-TRANSID:2ee76ad48b532e7-0897c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[112.22.251.201])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6ad48b34aee-7c200;
	Sun, 18 Oct 2026 17:03:15 +0800 (CST)
X-RM-TRANSID:2eea6ad48b34aee-7c200
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
Subject: [PATCH net-next 1/2] erspan: drop packets with an unknown ERSPAN version
Date: Sun, 18 Oct 2026 17:02:35 +0800
Message-ID: <20261018090236.2487997-2-yanhaishuang@cmss.chinamobile.com>
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

The ERSPAN type II and III receive paths take the length of the ERSPAN
header from the version field of the packet, with erspan_hdr_len(), but
never check that the version is one they know: 1 for type II or 2 for
type III.

For any other version, erspan_hdr_len() returns 0 or the type III
length. With version 0, the ERSPAN header is not pulled at all, so it
is passed up as the start of the inner Ethernet frame, and in collect_md
mode the metadata is copied from 8 bytes after the base header, which
pskb_may_pull() did not cover.

Reject such packets, as a packet with a truncated ERSPAN header already
is.

Fixes: f551c91de262 ("net: erspan: introduce erspan v2 for ip_gre")
Fixes: 94d7d8f29287 ("ip6_gre: add erspan v2 support")

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 net/ipv4/ip_gre.c  | 4 +++-
 net/ipv6/ip6_gre.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 3ee437fa3eae..2f112c1edf7c 100644
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
index 3d08240ea00c..3fe395ed92f9 100644
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
 
-- 
2.43.0



