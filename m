Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027163;
	b=eHRBoXnbD52ccdzDhM8F6rBUsO+NONc7d6qGTLprXZR3ppufGp8raohxSdRTihRKunz6
	 eQPp30+Iql5LkDJajNxE+zNrmGn0OUktbwlBrWwPpt97aqS+Ffnh933k/gWT8TqVL9tFz
	 BOmyedGXXiwM9rOBv9cYAXCxOzfE07PGAxcfIYlrd6rnCcwp3gSwuXmPRmGwbxDOgeT24
	 292016v7Bru7zHWPxCEMZH0QPDDmrLh0KbHhGb5lWSE9Fo5P0MztgG5cTUOnOr4DGWivc
	 tF5Bo6xv6u7YAAmHpFG/0rX2NgqVq2NNPUBESiBNzRSV3u1se02MhuatPbHRSNxE4wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=YAQMHYEx+VaTuqm8g03RQPwUqcCWwVMwQyZo+1H6cdk=;
	b=draHD6NeXUx0PzYKTUkf3Sz/YVrYcc4jMmO8wxVL99ljFuMVdNlWCEOucIU8xPC37CAS
	 TFp1ZM78ov3etLudV466AEDpvc9B76LIzrWw7XRDP6Hd949CgdsOjdbaAqqCBO5xOrh/O
	 qadkVsldRQeuro9Kk10aNYemV1XhJJGCvhQQMTkumT3OsPVL8wT8AuWMQ/d2jjeF4zuc0
	 j4n4w0248UFALE8gaoeNXNRtrec0OqYGk4ThFyIdQgKmx2OpxerJzdeSgHCNNOA3TwhaH
	 0G0631r8CO3F2pBwIk+e7gouP20R5ocjMBl8ksyvcYcfrSaNSQ1oLXiPuKsqkbgr4hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fDYjT3P9;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9351606A323
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9351606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fDYjT3P9
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a086f5d91aso4612027b3a.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793027162; x=1793631962; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAQMHYEx+VaTuqm8g03RQPwUqcCWwVMwQyZo+1H6cdk=;
        b=fDYjT3P9Vpy5o0EFTBaoD/FXKC1G6EJxcvIe3l9A2gVePBU80OcPT9P7kDtsbXMlTl
         zB8zq4UEB40xQNGObJZRdGReKQiB8/pECljQ/xXKLQ30dTTOmtD01fM9zDVE5UhFgZjm
         L9fbZw95TdGyzoqC+yTnOce6vgoX2lu1ISWZRgqmOucYYYld5kRaFqN/zbFPqCRlPv1c
         LB/7nf2khZHBFYdZzXnM1kHTzQEq4hyT60LA0jC9BMtqznFhhMh/NyXX5TbStP41X50c
         u5fDJibmuo3PIKfh7Wkewmc4k/eBCh5KTtMjafErAYjexPVAVHUg5k61XUNup230JIrC
         txkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027162; x=1793631962;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YAQMHYEx+VaTuqm8g03RQPwUqcCWwVMwQyZo+1H6cdk=;
        b=nkUHn45EbdUpgesKyP4AySK/KHTVlo3vXDuHpoLtKNsayxHau4MMc6aCDIQjH9sdYF
         Jfc0YFbdHs/HmREYW3nV5EKwb5DgsqDkhwe1HeGUOe3tZFi35GE6CbCkf8Sv3YSL848i
         +Gwa6+zYVkXuv5EnT45fQ6V6HgeR3AnImrBEQAs1f0BWIjd2sPWR0eC82+mSAztxpq7V
         +PkiRXDyOWiP4dYvk5CgwrxyN/mRGjRgHwQEoMbCEAZcnIUXB4+TxHD8ZhCFcgtCMr6E
         1eC7mpn5padRN+UTPczX81wBSD91e3rNRI83nn9InDSN7+e2H0OlBS4DreyzqpBoscLw
         yVOQ==
X-Gm-Message-State: AFq9FYKkHxeaK9yNh8i2SJWDq1u8Vuu4vEDLChtkUopValk6YUQL8sW0
	yLoUtalrPLHp6nCJfEcd3Ay1/6uGXsQDbRrFnGkAMx38mwYjNG9OR8WSdtFKHKqgOuFaqA4iQcM
	BihvYWh3EejObrnmsv05jIOf6dNH/5dezCyQqUPwpq9J6zGz8VaVrCWfKPxogWmVwKSIQ/QhKHk
	13Df8TSsPHDaJd+fWjZAKYRNiD1zsRxQTDrSUrwGkw0YIZkuQpDcVZ
X-Received: from pfbeb15.prod.google.com ([2002:a05:6a00:4c8f:b0:8a0:3171:5410])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:896:b0:880:973d:597a with SMTP id d2e1a72fcca58-8a368a9fd92mr6124603b3a.53.1793027160600;
 Mon, 26 Oct 2026 08:06:00 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:05:39 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261026150539.1357037-1-starchang@google.com>
Subject: [PATCH net v3] net: Fix Hole-196 vulnerability by dropping unicast
 ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, idosch@nvidia.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, Star Chang <starchang@google.com>
Content-Type: text/plain; charset="UTF-8"

Wi-Fi 802.11 to 802.3 frame translation allows attackers to inject
unicast L3 packets or ARP payloads inside GTK-encrypted L2 broadcast
and multicast (BMC) frames (the "Hole-196" vulnerability).

While the `drop_unicast_in_l2_multicast` sysctl was introduced to drop
unicast IPv4/IPv6 packets received over L2 BMC, it had several gaps:

1. ARP packets were not checked in `net/ipv4/arp.c`, allowing attackers
   to perform ARP poisoning via L2 BMC frames (`group-arp-unicast`).
2. Enforcement lacked DHCP client (UDP port 68) exemption, which could
   discard legitimate DHCP server responses sent via L2 broadcast.
3. Dropped packets were silently discarded without warnings or MIB stats.

The issue was identified via manual code inspection and protocol security
analysis of cross-station frame injection in 802.11 shared-key (GTK)
networks. In laboratory testing, crafted 802.11 broadcast frames containing
unicast ARP payloads (e.g. ARPOP_REQUEST / ARPOP_REPLY with tha set to a
victim's unicast MAC) bypassed the existing sysctl, poisoning the victim's
ARP cache. Furthermore, per RFC 2131 inspection, unconditionally dropping
L2 broadcast frames carrying unicast IP addresses discards standard DHCP
server responses (DHCPOFFER/DHCPACK) destined for UDP port 68 during lease
negotiation.

Enhance `drop_unicast_in_l2_multicast` sysctl enforcement:
- Extend sysctl checks to `net/ipv4/arp.c` (`arp_process()`) to drop
  unsolicited ARP Replies and ARP Requests with a non-zero unicast
  Target Hardware Address (tha) received over L2 BMC.
- Exempt Gratuitous ARP (GARP) and RFC 5227 Address Announcements
  (`sip == tip`) from L2 BMC unicast drop logic so they defer to the
  `DROP_GRATUITOUS_ARP` sysctl, preserving VRRP/HSRP router failover.
- Exempt non-fragmented DHCP client traffic (UDP dest port 68) in
  `net/ipv4/ip_input.c` and safely reload `ip_hdr(skb)` after
  `pskb_may_pull()` to prevent dangling pointer access.
- Log rate-limited warnings (`pr_warn_ratelimited`) and increment MIB
  error counters (`IPSTATS_MIB_INHDRERRORS`) for dropped frames.

Fixes: 12b74dfadb5a ("ipv4: add option to drop unicast encapsulated in L2 multicast")
Fixes: abbc30436d39 ("ipv6: add option to drop unicast encapsulated in L2 multicast")
Signed-off-by: Star Chang <starchang@google.com>
---
v2 -> v3:
  - Add Fixes: tags for commits 12b74dfadb5a and abbc30436d39.
  - Reformat lines in net/ipv4/ip_input.c to adhere strictly to the 80-column
    limit.
  - CC maintainers Ido Schimmel and Simon Horman per netdev bot check.
v1 -> v2:
  - Clarified discovery method (manual code inspection and protocol analysis)
    and triggering context in commit message per netdev-bot automated feedback.
 net/ipv4/arp.c       | 29 +++++++++++++++++++++++++++++
 net/ipv4/ip_input.c  | 32 ++++++++++++++++++++++++++++++--
 net/ipv6/ip6_input.c |  2 ++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index d409f606aec0..ad23db2e2f59 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -791,6 +791,35 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 	    (!IN_DEV_ROUTE_LOCALNET(in_dev) && ipv4_is_loopback(tip)))
 		goto out_free_skb;
 
+/*
+ * Hole-196 defense for ARP:
+ * If drop_unicast_in_l2_multicast sysctl is enabled on this interface,
+ * drop ARP Replies in L2 BMC frames, and ARP Requests in L2 BMC frames
+ * that specify a non-zero unicast Target Hardware Address (tha).
+ *
+ * Legitimate Gratuitous ARP (GARP) and RFC 5227 Address Announcements
+ * require (sip == tip) and tha matching sha (tha == sha). Only valid
+ * GARP frames are exempted so they defer to DROP_GRATUITOUS_ARP below.
+ */
+	if ((skb->pkt_type == PACKET_BROADCAST ||
+	     skb->pkt_type == PACKET_MULTICAST) &&
+	    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {
+		bool is_valid_garp = (sip == tip) && tha &&
+				     !memcmp(tha, sha, dev->addr_len);
+
+		if (arp->ar_op == htons(ARPOP_REPLY) && !is_valid_garp) {
+			net_warn_ratelimited("Drop ARP Reply in L2 BMC on %s\n",
+					     dev->name);
+			goto out_free_skb;
+		}
+		if (dev->addr_len == ETH_ALEN && tha &&
+		    is_valid_ether_addr(tha) && !is_valid_garp) {
+			net_warn_ratelimited("Drop unicast THA ARP Req in L2 BMC on %s\n",
+					     dev->name);
+			goto out_free_skb;
+		}
+	}
+
  /*
   *	For some 802.11 wireless deployments (and possibly other networks),
   *	there will be an ARP proxy and gratuitous ARP frames are attacks
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..75a5c2059632 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -456,10 +456,38 @@ static int ip_rcv_finish_core(struct net *net,
 		 * this is 802.11 protecting against cross-station spoofing (the
 		 * so-called "hole-196" attack) so do it for both.
 		 */
+		/* Hole-196 defense:
+		 * Drop unicast IP packets received over L2 BMC frames.
+		 * Exempt DHCP client responses (UDP port 68).
+		 */
 		if (in_dev &&
 		    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {
-			drop_reason = SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST;
-			goto drop;
+			bool is_dhcp_resp = false;
+
+			iph = ip_hdr(skb);
+			if (iph->protocol == IPPROTO_UDP &&
+			    !ip_is_fragment(iph) &&
+			    pskb_may_pull(skb, iph->ihl * 4 +
+					       sizeof(struct udphdr))) {
+				const struct udphdr *uh;
+
+				iph = ip_hdr(skb);
+				uh = (const struct udphdr *)
+					(skb_network_header(skb) +
+					 iph->ihl * 4);
+				if (uh->dest == htons(68))
+					is_dhcp_resp = true;
+			}
+
+			if (!is_dhcp_resp) {
+				net_warn_ratelimited("Drop unicast IP %pI4 in L2 BMC on %s
+",
+						     &iph->daddr, dev->name);
+				__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
+				drop_reason =
+					SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST;
+				goto drop;
+			}
 		}
 	}
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 8972863c93ee..caf9811f6352 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -278,6 +278,8 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	    (skb->pkt_type == PACKET_BROADCAST ||
 	     skb->pkt_type == PACKET_MULTICAST) &&
 	    READ_ONCE(idev->cnf.drop_unicast_in_l2_multicast)) {
+		net_warn_ratelimited("IPv6: Drop unicast IP %pI6c in L2 BMC on %s\n",
+				     &hdr->daddr, dev->name);
 		SKB_DR_SET(reason, UNICAST_IN_L2_MULTICAST);
 		goto err;
 	}
-- 
2.56.0.257.gf7497c7d27-goog

