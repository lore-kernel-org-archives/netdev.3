Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366730;
	b=aUoOjwQnlp602nzSleB7m3qoxsfDo9Pp/8UAE0Xi/sYQG4oys0J5sPc9rnxIqRkKaL6e
	 bRDQ6SM3kl19z05PbpcBSUpJdIrGGoOYGYYT6i/zE2ANQAZIur9/lOcpbXrWXelowUlB3
	 6U5bu8P46LO89CkV5iy4N01mZdnbldYZUV01fRY2XDjHe07vSzSK6TAjDypPpPP30+Gpm
	 o9fCSsub2DzR8hbWPpsJsaeaCCUPBTbgCZYbmeo1QOot5UBHhgCdHqqqQi4CzqS54Fyyv
	 iCAc5zPsMWv1xcMYtEwVBRezdGRqxcB7sK8yNaR0buAKvQClf4DdASYOc/hHk8KAYow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366730;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9IPIOvv6KeJOQVoUmqhLpqdnguUSFsIDrV7BNBwQySI=;
	b=KYV0X+lxCNuSCDuDOKnkQhi/x+eYZjnXX/A0yUr57Trj1dfVIP7eu7RVKUObmTrfRioO
	 VQjtICW5uVG4vrnt1Hk5d/82Dps7qkGtk4zoK6q31aShjYmVylcTcndgJUsGDC7SIpp5a
	 V+ipSs+ZlF7LmdYd7GjEvejd0DN2TWq3WfmfQpwjZgy5wrb2iFJmxXyMjfaT1WX/eL2X5
	 46Nsmh9ph0NRe/4DSBZo76kieeX9BGAx6ATgA9wzkmVU0fKwfOurErg/VX1CWlLKD+fq2
	 Q8vNBgUGGmdSefPhMYIoEwBXo5t6Xge0ASkYTgXJKl0CAe+EXCEFmX+2ctzmZsqx88w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rrfR6IWW;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78993606A31C;
	Wed, 11 Nov 2026 03:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78993606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rrfR6IWW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rrfR6IWWk8wvRhe43ri2bnMYSzyzD1xwIpRlVabdGCjb6IPPfk87BGNP5FDD+KAjh24xrhoGGqU61
	 eWHtdHNGgvLDeEUBy1wiSyLB3A9mcC4RSq5DNSAgdAsy91FXvT+4RmQtXrfMiI5DUPUF6qXLRZcHQG
	 SmJdqrehmMhemOYc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af3dd05277-9fa8b;
	Wed, 11 Nov 2026 11:12:07 +0800 (CST)
X-RM-TRANSID:2ee36af3dd05277-9fa8b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af3dd05404-cc4b7;
	Wed, 11 Nov 2026 11:12:06 +0800 (CST)
X-RM-TRANSID:2ee26af3dd05404-cc4b7
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net] amt: use ipv6_hdr() in amt_mldv1_leave_handler()
Date: Wed, 11 Nov 2026 11:11:47 +0800
Message-Id: <20261111031147.105834-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
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

In amt_mldv1_leave_handler(), which handles IPv6 MLDv1 Done
(ICMPV6_MGM_REDUCTION) messages, the source address is mistakenly
extracted via ip_hdr(skb)->saddr into host.ip4 instead of copying the
IPv6 source address from ipv6_hdr(skb)->saddr into host.ip6 as
amt_mldv1_report_handler() does.

Because amt_lookup_group() compares the full union amt_addr for v6
groups, looking up the group with a 32-bit IPv4 header slice fails to
match the group entry created by amt_mldv1_report_handler(). As a
result, amt_del_group() is not called when an MLDv1 listener leaves,
and the AMT relay continues forwarding multicast traffic until the
group timer expires.

Use ipv6_hdr(skb) and copy ip6h->saddr into host.ip6 so that MLDv1
Done messages properly match and delete the corresponding IPv6 group.

This issue was found via LLM-assisted code review, confirmed by
reproducing the stale group forwarding in a User-Mode Linux (ARCH=um)
environment, and verified in UML by testing that AMT relay multicast
forwarding stops immediately after receiving an MLDv1 Done message.

Fixes: b75f7095d4d4 ("amt: add mld report message handler")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
 drivers/net/amt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 81d26ef82cf5..31d91ab7c9ac 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2147,13 +2147,12 @@ static void amt_mldv1_leave_handler(struct amt_dev *amt, struct sk_buff *skb,
 				    struct amt_tunnel_list *tunnel)
 {
 	struct mld_msg *mld = (struct mld_msg *)icmp6_hdr(skb);
-	struct iphdr *iph = ip_hdr(skb);
+	struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct amt_group_node *gnode;
 	union amt_addr group, host;
 
 	memcpy(&group.ip6, &mld->mld_mca, sizeof(struct in6_addr));
-	memset(&host, 0, sizeof(union amt_addr));
-	host.ip4 = iph->saddr;
+	memcpy(&host.ip6, &ip6h->saddr, sizeof(struct in6_addr));
 
 	gnode = amt_lookup_group(tunnel, &group, &host, true);
 	if (gnode) {
-- 
2.33.0



