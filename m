Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4704347C0EE;
	Thu,  1 Oct 2026 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879037; cv=none; b=SOTT8jxFt9A5fdH9DDsJqq4VidlESEGmD2uYi8i88BJ07L6FN+Pvur3pwmcXRS3rfa8Zw3RMdg2Fsvv7OWYm5pqZLjpnQqjjPzgKweRVk2D3cmtHFhl1xfzCsrFHYv4JAWvyujMmgRWyLKtyEgE1qA+whUNzdJmK+lkjXQzna8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879037; c=relaxed/simple;
	bh=xLMyqXxDxmLBOL4zddDny3xGnXiyAjR016oL7nRspyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eY9Fy7oPrEvA1dC7ohPy0EPnuk8yKBXkg7J0T2PtxTXhym/fAlYW06OwE71lmG3+lTO/bf46rHxuuBTxTxx/FSGR4hcKFuA3CQyljhYL7g81fLmsco4ZANb4WfaTF19R+tO04pSiPmy1oJzxnIwqJQzsOZ2g5YvMj1ci0s7R0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=LX4Zd7r/; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=hubVIKqr; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="LX4Zd7r/";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="hubVIKqr"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 691IN6Ru014100;
	Thu, 1 Oct 2026 20:23:11 +0200
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id A58AE122917;
	Thu,  1 Oct 2026 20:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790878981; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=gtHsa7+nbYxwIbXAeMZuuzHwq3HqJLznTQd9fNnv/gU=;
	b=LX4Zd7r/6TiQAw9Dhx8CGM5OWV1H39Hvf0OK0Mi2RVKxe30B0qhDM7pQd8hO45YNKIz8kS
	wpsKO7sIfMF7RoDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790878981; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=gtHsa7+nbYxwIbXAeMZuuzHwq3HqJLznTQd9fNnv/gU=;
	b=hubVIKqrIq0qyeLN2KCPQ/B9y/auHOumAmRK+lTeN6HlPCp+I8GbemkPVFn7wV5UEvS6x+
	cm+H1URMphRl3LDGgq2kY0akH/AqTnVFusF/K04O45VeSGP2hbo9uTY5vd/Sw3v3/6n0Wm
	snvMxe7Nv0L/83bOWv0v8GQtylztijE3G/qNwH1yc8M8/O9BOgm/tECYwEijm72ovcT1xQ
	dg6pVsCNA/BYwJDftHHy1T/uApOKHSCdrOtiMxBrFyGPOihCkkdfORL8n9KhlJYYaFcou6
	DBrfIpV6FgLs55lQ87DlT6GQatmL2y9RmY2k24GTL/rW6IilLym42EaYTeRS8A==
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Hui Peng <benquike@gmail.com>, Andrea Mayer <andrea.mayer@uniroma2.it>,
        Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] ipv6: rpl: unclone the skb before modifying the packet
Date: Thu,  1 Oct 2026 20:21:36 +0200
Message-Id: <20261001182136.33-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

ipv6_rpl_srh_rcv() modifies the packet data, such as Segments Left and
the destination address, without checking whether the skb is cloned.
The skb may be cloned, for example by an AF_PACKET socket receiving on
the ingress device. ipv6_rpl_srh_rcv() then writes into the packet data
shared with the clone. A read from that socket can return the modified
packet instead of the received one.

The only pskb_expand_head() in the function runs after Segments Left and
the destination address are written, and only when Segments Left reaches
0 or there is not enough headroom.

Call pskb_expand_head() on a cloned skb before the packet is modified
(i.e., before Segments Left is decremented), as ipv6_srh_rcv() does.
On failure, drop the packet with SKB_DROP_REASON_NOMEM.

Fixes: a2f4c143d76b ("ipv6: rpl: Fix Route of Death.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925133807.32-1-andrea.mayer%40uniroma2.it
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/exthdrs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 09a4552f7f08..8fcf18e6114d 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -548,6 +548,17 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 		return -1;
 	}
 
+	if (skb_cloned(skb)) {
+		if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC)) {
+			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+					IPSTATS_MIB_OUTDISCARDS);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+			return -1;
+		}
+
+		hdr = (struct ipv6_rpl_sr_hdr *)skb_transport_header(skb);
+	}
+
 	hdr->segments_left--;
 	i = n - hdr->segments_left;
 
-- 
2.43.0

