Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338B41930F
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929424; cv=none; b=UYg5E/IxNXO3WJp/3CY30MzRzKc0hNMvQj2ZoxCCdyI9uRieywky8DdYVEMAMkzn11AXdOwtIWd2BjrPVVJByhl19nNxHHF/cp6bJbHpQAMoKrz3Ctuniy9fanGmIuS7At1Rzb2OOKjYLuu0qM7I0EvSf45NC5XhRqsj09DmU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929424; c=relaxed/simple;
	bh=fJ3u01aHHcgk6IPnVawD1Y/lFZZj9DoX4Zon6NUmFag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qxxiJN79DiBmmQkvXJEjXbVxvVPoHf58Jm7S5VBCiM7PhyK7QM4pWRKsTW3Q+a5YBqXGAV6xzC597bmSsNLKcOZ6pRK/9QtgBoh6YDGioF8YUuo+rztup3TEOfsILRXtbRfsbPnp5z5IaizoyyllY+k2XM1HcmGmwTz38Xk14GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1MPRG27; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1MPRG27"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso5163179a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790929423; x=1791534223; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pFjbU9pSZseB8ygpaiaapqJgIpAPCinx+umBz2pZzas=;
        b=C1MPRG27RVpzZBSK7Jr/3+k0Rim67FzHemFZAqyIqOyHktJESpV+7N5rOyj0zrqADU
         7SjjfSC553hHXInhxhWkjZ/TfmpsMR3soQ5oM1qr3hgTqcAfwJ2lNFGXzFs146XoOwEE
         rpftkD/mYacNB98FQXuIV/hWzGY4qx/SNTdAtLp+qhkZnzMMh+BaF/qKGj8Do1vsEONj
         TDHUmUoH77RKnG6a0gYjEI+YfNgVC/ktx3Og72Kpue61rgz9QDcx962T8ssYdcUeMQYc
         7+ereJDJ01i2yJb9fG32BW3706w2KB+B1bEmbsUJf1sFfdHsA83hhfFOOOjD5krfkGTD
         T/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929423; x=1791534223;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFjbU9pSZseB8ygpaiaapqJgIpAPCinx+umBz2pZzas=;
        b=f+E+P0O9gUofoe33Olmph/NrNyaiFMXdznOuTeenLXD52V3IfJ/b4RAqbNVfQqx5n5
         FtO8Uwfd/QbTZfa4jc0b0fNIfuB/9L8Tj+9r3p6hM4GWwUxrIZBXSUl1JeTNT5G7QGxo
         hreh1P/UnAFTDmM1pu52jnvPHUZ11hlJ3UZ+tIb52m5MZxSOPBi9l+6OIWDkPTACjuCP
         FB/x7l1DQRrom18RVUyRn+O7sV5U3Zr9U6tRr7kWbssBpbdinv7Sf4IoiVd+mJ2FRlq8
         ZgrKrEfz7IWaAYNguBuUZ00oUW1Md4XmQ5eQjvfbpHPdYD64CpW1renodutJW5prpGMC
         b2nQ==
X-Gm-Message-State: AFuF++lpbbuGjMOZzpcCLIBq4M0IMfHFTLGJj+aucbXapJ0LoEA67XpF
	8b7Is4XWCzitVz38y8BwB4If6ZaZRM90xkCoaqvDbGj9orQEMxBjLqPxyu89WcqBXwOeK4zn11j
	kKBF/Yc+puln2PKu+FsUXvVrQpoSP/POWuAO+xot9Ge6WA45ymBCR+M+aaFAeZeKYSzLVom8kCc
	I6ZGn9se0xg4J+fejKw6Ms78kzpkW9NFMi6bGdeb7pNNva6o+kpmR3
X-Received: from pgbco13.prod.google.com ([2002:a05:6a02:34d:b0:cc9:f746:40bb])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4327:b0:3d7:dfbf:7435 with SMTP id adf61e73a8af0-3e0bcef9a61mr2333431637.25.1790929422228;
 Fri, 02 Oct 2026 01:23:42 -0700 (PDT)
Date: Fri,  2 Oct 2026 08:23:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002082336.608201-1-starchang@google.com>
Subject: [PATCH net] net: Fix Hole-196 vulnerability by dropping unicast
 ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org, 
	wangroger@google.com, Star Chang <starchang@google.com>
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

Signed-off-by: Star Chang <starchang@google.com>
---
 net/ipv4/arp.c       | 29 +++++++++++++++++++++++++++++
 net/ipv4/ip_input.c  | 27 +++++++++++++++++++++++++--
 net/ipv6/ip6_input.c |  2 ++
 3 files changed, 56 insertions(+), 2 deletions(-)

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
index 9860178752b8..f863aa293020 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -456,10 +456,33 @@ static int ip_rcv_finish_core(struct net *net,
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
+			if (iph->protocol == IPPROTO_UDP && !ip_is_fragment(iph) &&
+			    pskb_may_pull(skb, iph->ihl * 4 + sizeof(struct udphdr))) {
+				const struct udphdr *uh;
+
+				iph = ip_hdr(skb);
+				uh = (const struct udphdr *)(skb_network_header(skb) +
+							    iph->ihl * 4);
+				if (uh->dest == htons(68))
+					is_dhcp_resp = true;
+			}
+
+			if (!is_dhcp_resp) {
+				net_warn_ratelimited("Drop unicast IP %pI4 in L2 BMC on %s\n",
+						     &iph->daddr, dev->name);
+				__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
+				drop_reason = SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST;
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
2.56.0.rc1.315.gc6ed9934b7-goog

