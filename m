Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A062F8EBC;
	Sat,  3 Oct 2026 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017745; cv=none; b=TbEX1/PihYEYZiOfVJryqkYvS6mQ0efrm0VQUJ/pW42IgwuXgpanUDQd8kt2BhXdgb5ZgakjZow7Vuo6MXvzHsubAdfRazw4yKSLBnlzA2vAop3nzXrgYXgqqvMkhHX+6536ZBcpHSkWWMy1mOo03f26nM0U5VHCZ14uJbAC/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017745; c=relaxed/simple;
	bh=v1WZS8NjUf+BWYEkee52Jrsz1kHJc2+bQNlXBEsO9Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFgIcIylT6XsHmkTZ2ZCJSAC93DiVj95tImvDnd9PuuWqCS1EFeFNpa3Te6cN/PxyMIgLk4FqS4WCCDxlFH7JpJOJJ3n6L/kzVaP7QkkF8aULIuX0ImsNEIsOWwVO5+bhhh4ZivjgKJB/9L3XywMfZX0osZZUF2AfqfFharl6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=xbPyw2qd; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="xbPyw2qd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=xbPyw2qdkSKtmaU/wYW4MvmhtvPNYlQl5VF10/5Ohx2rjJkbM4vjvS/6NknIWPIJ96RrbiN0x4/Oh
	 8KlGdN9SN6txCzIg4Gpu30TVCs9B0EGweiRT7/tb3V1fSdQuFeRB7sX+T6mHvDL4OhnHNY67ua9EB7
	 u/Wn16KZ9a7OIKeI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86ac0c3080ab-3a23c;
	Sat, 03 Oct 2026 16:55:39 +0800 (CST)
X-RM-TRANSID:2ee86ac0c3080ab-3a23c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16ac0c30766e-3c31c;
	Sat, 03 Oct 2026 16:55:39 +0800 (CST)
X-RM-TRANSID:2ee16ac0c30766e-3c31c
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH net] bareudp: set the inner protocol to the protocol of the packet
Date: Fri,  2 Oct 2026 23:30:39 +0800
Message-ID: <20261002153039.462663-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bareudp_xmit_skb() sets the inner protocol of the skb to the configured
ethertype, and bareudp6_xmit_skb() does not set it at all. The inner
protocol is used by skb_udp_tunnel_segment() to segment the inner packet
when GSO has to be done in software, for instance when the lower device
does not offload the checksum.

With multiproto, an IPv4 device also carries IPv6, so the IPv6 header
is parsed as an IPv4 one. With IPv6 underlay, the inner protocol is
whatever the skb had before. In both cases segmentation fails and the
packets are dropped. With veth tx checksum offload disabled, iperf3 TCP
over bareudp gets about 10 Mbit/s with thousands of retransmits instead
of about 700 Mbit/s for IPv6 over IPv4 and for both families over IPv6,
while IPv4 over IPv4 works.

At this point skb->protocol is the protocol of the inner packet, which
bareudp_xmit() has already checked against the configuration, so use it
on both paths.

Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
Fixes: 4b5f67232d95 ("net: Special handling for IP & MPLS.")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/bareudp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index c3b5ed52d877..b9fe54151e1a 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -356,7 +356,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (err)
 		goto free_dst;
 
-	skb_set_inner_protocol(skb, bareudp->ethertype);
+	skb_set_inner_protocol(skb, skb->protocol);
 	udp_tunnel_xmit_skb(rt, sk, skb, saddr, info->key.u.ipv4.dst,
 			    tos, ttl, df, sport, bareudp->port,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
@@ -424,6 +424,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (err)
 		goto free_dst;
 
+	skb_set_inner_protocol(skb, skb->protocol);
 	daddr = info->key.u.ipv6.dst;
 	udp_tunnel6_xmit_skb(dst, sk, skb, dev,
 			     &saddr, &daddr, prio, ttl,
-- 
2.43.0



