Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8037701A;
	Thu,  8 Oct 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477539; cv=none; b=IwjNI2miu5hfc2wJ6415DBB5d5BMxxzd0J4FbH9o18AN2mKy4GObYyAsaLUWmBFJormf4y7X5rDWdwapm98D5ORqTXHlINYuIjW3yBOUcdv2icfmw4HYH5HxT2VNrhs0M6yLriy5ga8smwnlS7qREbMdi8PkL0QzMdu195o2B4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477539; c=relaxed/simple;
	bh=QT++DOMQGaKvuHc4qGfA36cSa+Jt/is7lWxQax5N2NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs2eWpea0g4czUP6XSlKIok77Gl/Zq9hLgW/320Elc4O6pbhOMU/ExE0tOe413yAZpeEWICflFTgJcXmb3/rM62LugMoE4ZEoJONiosJ47jsY8NeNWdbc70nLMluE0NUqHTCkD059kqnuPqb4EyOj8tYenR1OPDQ0ILxFUaDdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=nV1fwKlW; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nV1fwKlW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=fhNMiM/6MSOAliB7C22sWhh7RwXtAm1LS4XzOpdH5xs=; b=nV1fwKlWkzE0
	ktOsa/2gjUgC2KkDUFjSP1NgbQWAKZ1fj4pmgVjy5z00UkOqBxZixn0T0B1oR6Af5roll1yxTWhUW
	bkjJw2xcuRPL7Jsq4f+x1RHk8INUPLrbDO/vwAuDH+rl4cEQ1kzJf0EL5FKqu6kJjS+VttVEGzilT
	vtA6SvirvhHzgNujcM3Cb2+Q18LU8kmn6tMcJeuG4vw+IfuFkCVSG7cma1BdQxnFUXTWVe3SeC16x
	IsBl7Td1LbLXTJO8ZwX5xe7LABvXAAYXtIx83HkKKyXaG5iHRt+KzccmgLzKNnYGBDyLajJ+ar6DY
	wRme/Kf3XFQlSzESEsbTIw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xEr5P-000XlW-1O;
	Thu, 08 Oct 2026 18:38:37 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <alobakin@pm.me>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	netdev@vger.kernel.org
Subject: [PATCH] udp: let rx-udp-gro-forwarding aggregate under encapsulation
Date: Thu,  8 Oct 2026 19:38:16 +0300
Message-ID: <20261008163817.2983484-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rx-udp-gro-forwarding checks of the veth kselftest fail with "got
10 packets, expected 1" on a host where something uses UDP
encapsulation, a vxlan say, and pass on a host where nothing does.

Since commit f2e9de210d50 ("udp: gro behind static key") the receiving
socket is looked up only once a tunnel socket exists, and commit
36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO
packets") takes "no socket found" for "forwarded" and aggregates only
then. So the device setting works on a host without a tunnel and stops
working with one.

Aggregate whenever the device asks, socket found or not. That is what
every host without a tunnel has done all along: a local socket without
UDP_GRO gets the packets resegmented on delivery, and a tunnel socket
keeps its own receive path.

Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 net/ipv4/udp_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a..d4e0e6bb9959 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -804,7 +804,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
 			NAPI_GRO_CB(skb)->is_flist = sk ? !udp_test_bit(GRO_ENABLED, sk) : 1;
 
-		if ((!sk && (skb->dev->features & NETIF_F_GRO_UDP_FWD)) ||
+		if ((skb->dev->features & NETIF_F_GRO_UDP_FWD) ||
 		    (sk && udp_test_bit(GRO_ENABLED, sk)) || NAPI_GRO_CB(skb)->is_flist)
 			return call_gro_receive(udp_gro_receive_segment, head, skb);
 
-- 
2.56.0

