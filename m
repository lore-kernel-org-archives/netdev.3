Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883020;
	b=MwHr1YEdPZ7vaNrTRnKdk1HvdynjzbSmF0++ZwIafeqg3sHCxlqROJnyeP949Y5+Yqxk
	 5x33XWNmv6yPDTLBJ0Ls1sPtNp68OtbLzrtpDP0dI8OdV5T08VGlH50erjDeOGzGnlDNC
	 VC+pq2FRMghjYxI3BxZOwboPcDfxovprwiuC93aitNF1YFRsgnYo4n7bwuaoCoQDfflb9
	 UHeBw8UQVDxrkSEniWZSZqC/NHxEH3MhG5oK4s0tJQvyEpHrQ0YG0cfktkb23kVAY9MZe
	 1iIoduEciHh26Z63csdOptxMSsRUfO274ZsIGW37oUwN93PF3ShDCpDBG3EFvlukivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EMyF93eU2YKIrSl7+R9jg9v5qd941Zg8klEalBJ3ZmA=;
	b=3Hk9sZqIth8PzxW6qgfDBLZWn7STHgKUI51QxNjAX2k0VkPyLRoxRclnqWQYGcosPcHq
	 aYYE+l9+ZUtpNsqP0z3yXIJGYqO3CXGwpjmaPOFWtFRQcaCrg97e5GbG9FG4amHFDrZVQ
	 qs6CzWDsZsrJB5kqHNbPCfAEtU/63L3mDmPOyoCbZpvweAOWtygCwCvooqX0O37aA+0Tt
	 l5L4BQP+Ceb6JoPLzk0s4OKh6FpOVTm/d058hSea8Ts1aRQVOwHvV012hWhMJk062qm0B
	 kYW8MWoqnTx5Aj3ITfJGHXv166Qpedh7lqQw3v2vAcR6E3EixnFtGE1OMib3IR2/CqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=rheF2w3r;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24B606D83B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F24B606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=rheF2w3r
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-353804b591eso3488542eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883020; x=1794487820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMyF93eU2YKIrSl7+R9jg9v5qd941Zg8klEalBJ3ZmA=;
        b=rheF2w3rHVKSU3m9yREGEtg3QCfJwxZZeo5XUy2EyOfA2WeNqo+/XB1nhfsx4swJqy
         C8mxmxv0vtG72CpXhb3DpQChnwG0rBhz7GeDgKSuvFCHAPXpwuxDU25NG185Hcd3tjpI
         1TCiwmiW2kGXAg0L45Kvhayg0oos3G7se6x5QzLf4zPmfcTSBPK7hmPAcZ3j2SfKm8de
         usIcPoVwK7Lq7zp/4qp2+wAsmXKMbL0MdFrUA/LLeCpvYuUqUB1NQjL1bqzBSOr35NT8
         EnfWvRc0A1IKDf5DRQ4TOe0E+OXyFqOqL4MSIyqj8ID/gwV0Itnh7ymp6QGUmkPAaQh+
         iEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883020; x=1794487820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EMyF93eU2YKIrSl7+R9jg9v5qd941Zg8klEalBJ3ZmA=;
        b=sfI0ONScbnuyo5fEVxUZBMYdb7TACPaRxdEwG5Ehj3A5Fe6/0O4sNvA5RMZaCIM3qa
         MZYti+SIl9nUnJKV7YEDDpnDrUY9RuGIiirfLRiy8k+qqYF2/Bt3mDDo5MP5sqbm6dub
         JsWOl6K3j8cD70y8ZCuVRDzryC1Bdqwyaz3OLO4QsmwbkcJyOdKbtb416e711w7HhCK4
         Tw4DGNrHPiiOwM6qMZhhfNjGkrbum33D8blExCHGrO48KAs3tIv0bdqgwmMHxljl3rOn
         Mshl83wHCV4KKbUEOflmwsj5YDmQ9EdDNds2bJqcYdUEA7Hl33sd8y+rnNqQmzhEIKlW
         czwg==
X-Gm-Message-State: APuU4Z+3eBuV0dMvajD/fkcglpIKxmHi5GNlbTfCY7CVkC/HFKdf3OIV
	jZDdvSeuasF4LGK7rB8/9ab13IaAh5Zl6QEqwTwtnFNpGAGOqeQ79D3Vb/Nr03ctVj4=
X-Gm-Gg: AYBFou0cRjk+iB5B0rKRpz2/PQTfXeiEoYz8cyw/9rCedvonOVyhV+n7EbIAXk0MFcO
	Y194czCshfiqbuorXDcKrLXgptsbvgkLtfsxGBjlJY95WDYZMeTFvIFa1PXaC6A4gZtqsa5qI2L
	CVyXxTby9FnVR2x79DRJ4FQ82ngyEFHjgFUeNC2X8ELIA44RqvbYbMmOTmGj5BcHnuSrgBIgqGH
	vz1nFM7TjH8Fex0A82i667dpPhVnafMFSC8P0ta0bL1Pza9t5DopAgRfz+kQYfHSt45iAcx5zU4
	7SDxSWeSByeDOeekbkZjYBNXLzfhJz5LX4CpW0GSb63+dlIDaKjkNBEfIe9eHurFPRNvUmUzvbj
	T/8E5jL0RgtGCLs5BnsZDb1C2A5QxwCzD45hfR/uexjhG2xjkw9kGSxmUmWbnZA9tKHcLUGLO/h
	AIHRzmPrhwmLuMZi+jHeRlHU1QmhfeEe7CKJJeFRj4xfM8OhT+trULQTRp9kZmRataRpAi/2qnV
	BK3pLedgD4S89HkP1jJPJOR+DIRCOo9L9SsNckYYhdVSqnZEFTv+n9GiAVZPJbdPcU6V3uK69zc
	gdBi99rJqvnRn/hpfbTRcJDUo26AnQIsNzTGFdffsPaJNowDpETU7v+b8vJ+wwcyGAzYOyc=
X-Received: by 2002:a05:693c:69cf:b0:369:daea:812a with SMTP id 5a478bee46e88-36a423fae73mr25902658eec.30.1793883019358;
        Thu, 05 Nov 2026 04:50:19 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:18 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v5 4/5] amt: make pre-query report drops visible
Date: Thu,  5 Nov 2026 12:50:09 +0000
Message-ID: <20261105125010.1107546-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105125010.1107546-1-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
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

A gateway cannot forward an IGMP or MLD report until it has received the
relay's Membership Query for that family.  The Query supplies the
response MAC the Update echoes, so dropping an early report is required,
but doing so silently leaves operators with a dark multicast path and no
indication why the join never happened.

Emit a family-specific debug message before taking the drop path.

tx_dropped could not show these drops either: amt_dev_xmit() reaches the
same tx_dropped increment after amt_send_membership_update() has handed
the report to the tunnel, so in gateway mode every forwarded report was
also counted as a drop.  Return NETDEV_TX_OK directly once the report has
been sent, so tx_dropped counts only reports that were discarded.

The device is LLTX, so amt_dev_xmit() can run on several CPUs at once;
use DEV_STATS_INC() for its tx_dropped and tx_errors updates so
concurrent increments are not lost.

Found by code inspection while debugging an IPv6-in-IPv6 forwarding
failure in a selftest for the AMT IPv6 outer transport. This drop can
leave one address family dark, so it was a suspect, but that was not
confirmed: the failure was later traced to the selftest, which sent a
single datagram without waiting for the relay's multicast routes to
converge. The drop has not been observed in production, and there is
no oops or trace. Review of v3 found the tx_dropped miscount and the
non-atomic counter updates.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 68f08f5f6..26a942c2a 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -701,7 +701,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -711,7 +711,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -756,7 +756,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 	amt_update_gw_status(amt, AMT_STATUS_SENT_DISCOVERY, true);
 out:
@@ -792,7 +792,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -802,7 +802,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -849,7 +849,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
@@ -871,7 +871,7 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, false)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -915,7 +915,7 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 
 	if (ipv6_dev_get_saddr(amt->net, amt->dev, &ip6h->daddr, 0,
 			       &ip6h->saddr)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		kfree_skb(skb);
 		return NULL;
 	}
@@ -959,7 +959,7 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, true)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -1319,7 +1319,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 		goto free;
 	}
 
@@ -1332,12 +1332,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Gateway only passes IGMP/MLD packets */
 		if (!report)
 			goto free;
+		/* A validated report can only be forwarded after the relay's
+		 * family-specific Membership Query supplies the state echoed
+		 * by the Membership Update. Log this readiness failure before
+		 * the shared drop path accounts it.
+		 */
 		if ((!v6 && !READ_ONCE(amt->ready4)) ||
-		    (v6 && !READ_ONCE(amt->ready6)))
+		    (v6 && !READ_ONCE(amt->ready6))) {
+			netdev_dbg(dev, "drop %s report: waiting for Membership Query\n",
+				   v6 ? "MLD" : "IGMP");
 			goto free;
+		}
 		if (amt_send_membership_update(amt, skb,  v6))
 			goto free;
-		goto unlock;
+		/* Sent: the tunnel consumed the skb.  Not a drop. */
+		return NETDEV_TX_OK;
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (!data)
 			goto free;
@@ -1366,8 +1375,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 free:
 	dev_kfree_skb(skb);
-unlock:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -2730,7 +2738,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2740,7 +2748,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2786,7 +2794,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
-- 
2.47.3

