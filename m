Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477652E229F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204304; cv=none; b=UQC9xW6OrebSr0lyKURgcJ5NtkD0fwQZwTX4nZiNYhxH1PDC2bjRnu7rKpP19BdyboFA8/abSdvR/qxU5NLmt2QWkMjTL1Y/qwAgt5lSGKifuQgfxbUockdd5CMCibl0wO4PT/t7l+9uOga+UiOF6xjDx//D483ja7oJRVVUQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204304; c=relaxed/simple;
	bh=BKTHbU3y40nhjeylxspDDvKFCHhAg87yV1+AM5ki5xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GF0UiHl28UJaHMPAutXBplJDBl07Gs/447ZrGZOootWoKD33HZWDxY27th7Nq47WhzyRsbmyZ4j1NUrNEOX9UhaewmvxTS/zNFBsHqOSvpaYIV4R91aaiRBb5BObUzmAvlMKeAZXL20U8s4k8cbqnWaGa8oyJkx5N6iJrvTtqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=WFyxP3ih; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="WFyxP3ih"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so7296795e9.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790204300; x=1790809100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XeMipPAuwVCCTOvnSQqo7JiZRZXG45zOb88nXVU7yl8=;
        b=WFyxP3ihNMaVXERQyswe9uwrjwNAFYX9ko2LE+25CWIYv1G3qc8T0zqVclwWZJ7PTI
         kX3zzEn7qAhw6VgZisld5u1EI86phcTdUi5P5X7T/hnyIZerf+ftKGyVmfqEUedc6jKO
         VaSPA7A/cMZqS2lAHzrPrlBqOAA9Pbg30GnG4/iCMTqRHfOexER6v6XZMk4gGIMT3JQr
         iFeXC0FBJTK87vlwgtKNc9LzQQ8dg3cTlkNoJh7FPvm4aZtxXRKaltojrt69xwGdnNAQ
         bbAAzcvB6O38fMMTPPJCMXZD5EL52kZGZcqP5ah9IRIFyowgZXACPP8ZmiM8Xl/2K2hB
         tZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790204300; x=1790809100;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeMipPAuwVCCTOvnSQqo7JiZRZXG45zOb88nXVU7yl8=;
        b=KzQkxQYnaJBz+Y6QsgraJnZ8PSIaz3YHrWYmRUGKU3c/hwYJeLflN7+TiE9MS5eHVM
         ILDuYWBjnFh9XklhXruwgIP0uNYGVQEVdWJclKCFYdYGB7vlpV8q6ShAZyD3uOu7jGlu
         pAzS4nOwrR4XCz4QxO1kBWBT7mUaCdi05SkNW1rkEGfOvaE8jTA1Ig2yAIclZLvvvhJI
         nl9EZrqm9S/sqsV+2mhiEzNdEJoCbDaFqQY3JpcJvKAaq7SpR9nKAo4nfR9ahYZ6gFYh
         TtuuwM7L468W72qXP0/MIBBqZXqY23HgWv3rBGVEgT4NOjcucJzm78eDytWXT25L6H6w
         VF4w==
X-Forwarded-Encrypted: i=1; AKwUvBzsgUggYoR+RmEdVLA4MB1vtQ6/fCS7d1VJAgwhLlMpq+iRoKOnbBHjCQ0Vnr5WpaoYtWaJ1gE=@vger.kernel.org
X-Gm-Message-State: AFuF++ldLjsJm9fqY1TdExib/CVJxQ5V0O+ZZyC4SDAEumjdbFtuJxfn
	aXUkAtoPUjNPK36ymwucLgUfvDHxrYw8Aab3vzisKwQj/qcymAg8xMVQ+zowYRZV/Yc=
X-Gm-Gg: AYBFou3QzGnFAKkk3mWvr7IShvUryGN2SaIKgdrZpapJuIt0W9eEP8b3Fb9t4xe8IL5
	umDGRHPK9zzRhnD+th+FW9I53QXftV96YRxjBz5JmbRcYGGS9eD444B8mryDfh9sNbMI50o7gW6
	R19FfnaD3ZqNIz1m6BunlIuj4j1l90ljW2P4XFTxTxZIV97SQPy5sVp+2mlrUVRrhP/zbVXqXbc
	+V49XhRNNxxlF8oGg4+ixLx9/NkmR0CTFumUWFeQ4nrJrGr6hRVLCSLM0BDNQsdTPbOP0n7Lrpa
	7FVH6uLfoq4kH7djyCIYjDyFAPIDcGVCahPlyce3+IapTxd4XMQIT0FnXvrSkf85GKDPqK39vgB
	aZPqJYg6VLUFyqH79RElyT0eOE8uAkh03lUCWSdN37+o1QRTB2V01lAbOGqgdkaO6WrZj7Y4ihw
	bIV6xBDQD5gksS7JKwDdxzHso4skwjBsgdkDVKoYpTc1KBJUArqf6Q+Rx9P6Pt/di7kAAZ9umQI
	6Q+LlRYyIp/dC244SeJ8wkCyt5d/kKfFctSvOup0txgfmSQTz/b4mdOOsbRh3jK1rjC11/YP/yq
	uiw2
X-Received: by 2002:a05:600d:8643:10b0:49f:bb8a:b4ce with SMTP id 5b1f17b1804b1-49fe67bc26fmr5904585e9.28.1790204299937;
        Wed, 23 Sep 2026 15:58:19 -0700 (PDT)
Received: from localhost.localdomain ([197.51.234.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4b51bsm72894285e9.4.2026.09.23.15.58.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 15:58:18 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Xiang Mei <xmei5@asu.edu>,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH net v2] amt: do not store tunnel pointer in skb control block
Date: Thu, 24 Sep 2026 01:56:31 +0300
Message-ID: <20260923225630.95537-2-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922214150.13970-1-cenzhang@linux.microsoft.com>
References: <20260922214150.13970-1-cenzhang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Resending with the list and maintainers on Cc; my first copy went to
Cen only. Sorry for the duplicate, Cen.]

Hi Cen,

On Tue, Sep 22, 2026 at 05:41:50PM -0400, Cen Zhang (Microsoft Security FORGE Labs) wrote:
> An skb queued in a qdisc can outlive the tunnel it references
> through a raw pointer in skb->cb. For example, a netem delay of
> 180s exceeds the default tunnel lifetime of 135s (igmp_qrv=1);
> when the tunnel expires and is freed, the subsequent dequeue
> triggers a use-after-free in amt_dev_xmit().

Thanks for finding this and for sticking with it. I agree with the
analysis and the trace. Nothing pins the tunnel while the General
Query waits in the qdisc, and amt_tunnel_expire() frees it with
kfree_rcu() well before a 180s netem delay runs out.

> Store the tunnel identity (ip4 + source_port) in skb->cb instead
> of a pointer, and re-lookup the tunnel under RCU in amt_dev_xmit().
> If the tunnel is gone, the query is simply dropped.
>
> A refcount fix would be hard to keep balanced here, as the skb may
> be dropped or cloned by the qdisc layer before reaching
> amt_dev_xmit().

Agreed on the refcount. Could we avoid both the refcount and the
lookup by not sending the relay's GQ through amt_dev_xmit() at all?

amt_send_igmp_gq() and amt_send_mld_gq() have one caller,
amt_request_handler(). It runs inside the rcu_read_lock_bh() section
of amt_rcv() and already holds the right tunnel, whether it found the
tunnel or just created it. For this skb, dev_queue_xmit() only leads
back into amt_dev_xmit(), which strips the Ethernet header and calls
amt_send_membership_query(amt, skb, tunnel, v6). The two senders can
make that call themselves, in the same way that
amt_send_advertisement() already transmits from this receive path.

With that change:
 - the skb never waits in a qdisc, so there is no lifetime window;
 - the tunnel is only dereferenced inside the RCU section that found
   or created it, and rcu_dereference_bh(amt->sk) in the sender stays
   covered;
 - it is O(1): nothing is stored in skb->cb, and there is no lookup
   and no refcount.

Once the round trip is gone, the query branch in amt_dev_xmit(),
amt_skb_cb() and struct amt_skb_cb have no users left and can be
removed.

> +	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> +		if (tunnel->ip4 == ip4 && tunnel->source_port == source_port)
> +			return tunnel;

This keeps the per-Query walk of tunnel_list that Taehee raised on
v1. Space isn't the issue: your (ip4, port) key fits in the free cb
bytes, and so would a u32 tunnel id. The cost is that any key needs a
lookup at dequeue time, plus a rule for a tunnel that expired or was
recreated in the meantime, while the sender already has the tunnel in
hand.

These are the behaviour changes I'm aware of. The first two only
affect the relay's own GQs; the third affects foreign queries:
 - They no longer go through a qdisc or taps on the amt device. They
   are still visible as UDP on the underlay.
 - They are no longer counted as tx_dropped when sent successfully.
   Today the query branch in amt_dev_xmit() exits through the unlock
   label, which counts every sent query as dropped.
 - A query that reaches amt_dev_xmit() on a relay from somewhere
   else, such as a userspace querier, is now dropped at the IGMP/MLD
   type switch. Before, it trusted whatever skb->cb held, and a NULL
   hit the WARN_ON(1). I found this by reading the code and have not
   exercised it.

What I have and haven't tested:
 - The diff below applies to net at 9c572a83037a. It builds with W=1
   and no warnings (gcc 14, arm64, CONFIG_IPV6=y and =n), and
   checkpatch --strict is clean. I haven't booted it.
 - An earlier form of this direct send (without the dead-code removal
   or the failure accounting) passed amt.sh 5/5 under vng in August,
   on a v7.1 tree carrying our other pending AMT patches. That was not
   a KASAN build, and it predates this diff. Our out-of-tree module's
   source carries the same earlier form.
 - I haven't reproduced the KASAN report. Could you share the netem
   setup you used, so I can run it before and after? The GQ no longer
   enters the qdisc, so I expect it to stop triggering by
   construction, but I'd want to see that before this goes in.

If you and Taehee like this direction, either of these works for me:
 - I post it as v3 with your KASAN trace in the commit message,
   keeping the existing Reported-by tags (you're already one), plus
   Co-developed-by if you'd like; that needs your Signed-off-by.
 - You fold it into your v3 with a Suggested-by.

Taehee, would this be acceptable to you?

Thanks,
Omar

-- >8 --
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index bddc24e1856d..b53f8ec55661 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -80,15 +80,6 @@ static struct in6_addr mld2_all_node = MLD2_ALL_NODE_INIT;
 static struct mld2_grec mldv2_zero_grec;
 #endif
 
-static struct amt_skb_cb *amt_skb_cb(struct sk_buff *skb)
-{
-	BUILD_BUG_ON(sizeof(struct amt_skb_cb) + sizeof(struct tc_skb_cb) >
-		     sizeof_field(struct sk_buff, cb));
-
-	return (struct amt_skb_cb *)((void *)skb->cb +
-		sizeof(struct tc_skb_cb));
-}
-
 static void __amt_source_gc_work(void)
 {
 	struct amt_source_node *snode;
@@ -791,6 +782,11 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	rcu_read_unlock();
 }
 
+static bool amt_send_membership_query(struct amt_dev *amt,
+				      struct sk_buff *skb,
+				      struct amt_tunnel_list *tunnel,
+				      bool v6);
+
 static void amt_send_igmp_gq(struct amt_dev *amt,
 			     struct amt_tunnel_list *tunnel)
 {
@@ -800,8 +796,11 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 	if (!skb)
 		return;
 
-	amt_skb_cb(skb)->tunnel = tunnel;
-	dev_queue_xmit(skb);
+	skb_pull(skb, sizeof(struct ethhdr));
+	if (amt_send_membership_query(amt, skb, tunnel, false)) {
+		amt->dev->stats.tx_dropped++;
+		kfree_skb(skb);
+	}
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -885,8 +884,11 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 	if (!skb)
 		return;
 
-	amt_skb_cb(skb)->tunnel = tunnel;
-	dev_queue_xmit(skb);
+	skb_pull(skb, sizeof(struct ethhdr));
+	if (amt_send_membership_query(amt, skb, tunnel, true)) {
+		amt->dev->stats.tx_dropped++;
+		kfree_skb(skb);
+	}
 }
 #else
 static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
@@ -1186,7 +1188,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif
 	bool report = false;
 	struct igmphdr *ih;
-	bool query = false;
 	struct iphdr *iph;
 	bool data = false;
 	bool v6 = false;
@@ -1204,9 +1205,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			case IGMP_HOST_MEMBERSHIP_REPORT:
 				report = true;
 				break;
-			case IGMP_HOST_MEMBERSHIP_QUERY:
-				query = true;
-				break;
 			default:
 				goto free;
 			}
@@ -1228,9 +1226,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			case ICMPV6_MLD2_REPORT:
 				report = true;
 				break;
-			case ICMPV6_MGM_QUERY:
-				query = true;
-				break;
 			default:
 				goto free;
 			}
@@ -1261,19 +1256,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto free;
 		goto unlock;
 	} else if (amt->mode == AMT_MODE_RELAY) {
-		if (query) {
-			tunnel = amt_skb_cb(skb)->tunnel;
-			if (!tunnel) {
-				WARN_ON(1);
-				goto free;
-			}
-
-			/* Do not forward unexpected query */
-			if (amt_send_membership_query(amt, skb, tunnel, v6))
-				goto free;
-			goto unlock;
-		}
-
 		if (!data)
 			goto free;
 		list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
diff --git a/include/net/amt.h b/include/net/amt.h
index a0255491f5b0..2846dde0cadc 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -231,10 +231,6 @@ struct amt_relay_headers {
 	};
 } __packed;
 
-struct amt_skb_cb {
-	struct amt_tunnel_list *tunnel;
-};
-
 struct amt_tunnel_list {
 	struct list_head	list;
 	/* Protect All resources under an amt_tunne_list */
