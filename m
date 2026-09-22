Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E85548566;
	Tue, 22 Sep 2026 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113347; cv=none; b=RK/YWAV+T+JCMwX7ypMaJrRLsI4Q9FhjCPNNcGkASc+xNHPdJzY7f7j3byGKdKfe2eKFFZeIzKJbY7mU29Jx1N+ONrkQsz8X9zMtQRXkqAqS0Q5ESMdoKRtIZwqRZZIJlD3xJmr3uZ2wP6BZEh3G9IkeWmYp4tRZcADeh+pXjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113347; c=relaxed/simple;
	bh=bdZHWktZQrNVooTNS2xbaoRXXu8ECM/sOZ8cgZBFEzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPWwQi+L/4Fw1CYcPBbYD6yXkepLXVuCSmhg3+R3yCkkMwPBR/W2KhVHWwqSOqXwm1+KDL/7RHVS7SM6PzlF1slncZjrgQAHvqndHKdefn03y1jTuqeB6KKT5J7qNCk7E+M3QibMMlCiSDHNGRH+Tooklbbjf9axPOdF13Dzuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MZbtuOYB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MZbtuOYB"
Received: from localhost.localdomain (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id A72BE20B7167;
	Tue, 22 Sep 2026 14:41:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A72BE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790113283;
	bh=AwmQ1oWcxi3FY9aiQMRQQPaw3GGCnd6GMquPBV0gKXk=;
	h=From:To:Cc:Subject:Date:From;
	b=MZbtuOYB1k7EbraxySVx+DrOQ362+k5TLCvOntm2eInzrga6TG929fPEPcrdtYcWx
	 B3IGGZc7okeoxNligJALt4ZwJn1ySECtff3OGcmeZsQTKQzE8V8/6AcCP97vXFcl3l
	 TAnJgqOP+lz6T+buJqOm/ItTwsBklW0RTT1d8JLc=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Xiang Mei <xmei5@asu.edu>,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: [PATCH net v2] amt: do not store tunnel pointer in skb control block
Date: Tue, 22 Sep 2026 17:41:50 -0400
Message-ID: <20260922214150.13970-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An skb queued in a qdisc can outlive the tunnel it references
through a raw pointer in skb->cb. For example, a netem delay of
180s exceeds the default tunnel lifetime of 135s (igmp_qrv=1);
when the tunnel expires and is freed, the subsequent dequeue
triggers a use-after-free in amt_dev_xmit().

  BUG: KASAN: slab-use-after-free in amt_dev_xmit+0x2763/0x2e20
  Call Trace:
   amt_dev_xmit+0x2763/0x2e20 [drivers/net/amt.c:1262]
   dev_hard_start_xmit+0x22f/0x620
   sch_direct_xmit+0x12e/0xac0
   netem_dequeue+0x333/0xc50
   net_tx_action+0x35c/0xa60

Store the tunnel identity (ip4 + source_port) in skb->cb instead
of a pointer, and re-lookup the tunnel under RCU in amt_dev_xmit().
If the tunnel is gone, the query is simply dropped.

A refcount fix would be hard to keep balanced here, as the skb may
be dropped or cloned by the qdisc layer before reaching
amt_dev_xmit().

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
---
v2:
 - Drop the comment above struct amt_skb_cb (Taehee Yoo)
 - Mention in the commit message why a refcount is not used
   (Taehee Yoo)
 - Rebase on net/main
v1: https://lore.kernel.org/netdev/20260818164825.63967-1-blbllhy@gmail.com/

 drivers/net/amt.c | 34 +++++++++++++++++++++++++---------
 include/net/amt.h |  3 ++-
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index bddc24e1856..b660cebf248 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -791,6 +791,18 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	rcu_read_unlock();
 }
 
+static struct amt_tunnel_list *amt_lookup_tunnel(struct amt_dev *amt,
+						 __be32 ip4, __be16 source_port)
+{
+	struct amt_tunnel_list *tunnel;
+
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
+		if (tunnel->ip4 == ip4 && tunnel->source_port == source_port)
+			return tunnel;
+
+	return NULL;
+}
+
 static void amt_send_igmp_gq(struct amt_dev *amt,
 			     struct amt_tunnel_list *tunnel)
 {
@@ -800,7 +812,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 	if (!skb)
 		return;
 
-	amt_skb_cb(skb)->tunnel = tunnel;
+	amt_skb_cb(skb)->tunnel_ip4 = tunnel->ip4;
+	amt_skb_cb(skb)->tunnel_port = tunnel->source_port;
 	dev_queue_xmit(skb);
 }
 
@@ -885,7 +898,8 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 	if (!skb)
 		return;
 
-	amt_skb_cb(skb)->tunnel = tunnel;
+	amt_skb_cb(skb)->tunnel_ip4 = tunnel->ip4;
+	amt_skb_cb(skb)->tunnel_port = tunnel->source_port;
 	dev_queue_xmit(skb);
 }
 #else
@@ -1262,15 +1276,17 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto unlock;
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (query) {
-			tunnel = amt_skb_cb(skb)->tunnel;
-			if (!tunnel) {
-				WARN_ON(1);
-				goto free;
-			}
-
+			rcu_read_lock();
+			tunnel = amt_lookup_tunnel(amt,
+						   amt_skb_cb(skb)->tunnel_ip4,
+						   amt_skb_cb(skb)->tunnel_port);
 			/* Do not forward unexpected query */
-			if (amt_send_membership_query(amt, skb, tunnel, v6))
+			if (!tunnel ||
+			    amt_send_membership_query(amt, skb, tunnel, v6)) {
+				rcu_read_unlock();
 				goto free;
+			}
+			rcu_read_unlock();
 			goto unlock;
 		}
 
diff --git a/include/net/amt.h b/include/net/amt.h
index a0255491f5b..8727cf007bc 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -232,7 +232,8 @@ struct amt_relay_headers {
 } __packed;
 
 struct amt_skb_cb {
-	struct amt_tunnel_list *tunnel;
+	__be32			tunnel_ip4;
+	__be16			tunnel_port;
 };
 
 struct amt_tunnel_list {
-- 
2.53.0

