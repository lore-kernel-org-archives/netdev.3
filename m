Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025651;
	b=govy+UZYeN3CpIhMwThfnXO4tlBv7gTFDjf3dqV6KW2hNfHKGym0E7jFDCfQzgyi4CJo
	 dZP1IgJeFacYQFtX/lEQ3XV1woXk2z1+Yg1oQ9l7bTWfg39fkkE1XY4RFUDLTLSK4lc2F
	 Kz3iKgKUcuclhtjrGCiZLjb5klqBYVn2wNmLDHVMHCxsk4uH7drKbwnfN8b6orhvY5BFr
	 W643K+OCoIQ0f6pO+ZuG8JLtEPS1ZjxO7wH0H0eIxaahc1523SutCTtDlt4CezFigZlMU
	 nBCyhLraWx5doaYbpD+U5CadDRS40KXl0vRCG97s3VhJH8t60WdqCTDgR2iW/6+K9Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=8Kll1iF/QT91YErkwJEoScaiXhixs9z1aNQZhsSbLyI=;
	b=FlxDZI7m/w+W9x7uR0BptdxvzNmL9o7SW3f6mbn/0o3b4ekz6ehwBJx2J5mqiHySMgOf
	 EhL+eTvAN0ZIqYv5TktwN5EiHP9rNPcz3KLod0M8OayTun7U2OALawfxm/ELogBIFclbm
	 Q3NaTQGZcZYGewqBO3UYN+0MsoOhlfvSMDJEuo03gHqv6x3uwczJu17mE4gyebRyIslyz
	 lhgt2qM7y0JYJXQhfCXv49xG3jWPoMVrwCwxFPbjkBbANbwaWmptzuWIj4hMb7c7GJgzi
	 zXG6QlqusRTEI+XF5+wU9k+B/QdVoXNdwjISocSeUu8fEYeHgLbbqEhLFXFkZIuS74Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pmQnzjNm;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2C606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA2C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pmQnzjNm
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd67d4bbdffso2377627a12.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793025650; x=1793630450; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Kll1iF/QT91YErkwJEoScaiXhixs9z1aNQZhsSbLyI=;
        b=pmQnzjNmSkFRFPDCyIkvlEdyjgJNNIq2cNF8/Wxm+gHU+CgXs5sKZtGIFtmlU+ioeA
         LwOPD2YbJ188JbL6zVXDA603WzrzvkQnYcnlmjgdEnmOE3NvwZBtLHzmF3ZjFlsjtxfz
         vNMfFDbM3OAv67a7OEcFvjMqfW8W400BQVNPbFyaTi7TmkUWf5GojlXOdLZ7tqVohXQD
         D/d8qDEkwcgKQsfei26OOOWGbnkijg2t9MLoucP/we45obWsekt3sEaMH6tIET/+ux9S
         QOfsITDYlVIKFyWTsGT9K00vOs5f3BX8i8g74gl2OIAB5UDgHswJOKFUf81sid8WX4cz
         ZwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025650; x=1793630450;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Kll1iF/QT91YErkwJEoScaiXhixs9z1aNQZhsSbLyI=;
        b=RxRirmKUbCvNxBY8h4LW//5Reok0h41SP+umggnnvzG/h7rZg5Q3jq8r1DM5kciE+E
         ZQjv2TlV7IUi1QukFH7gSKBZhUMB3vqaNc0zYYB2uegWfA3/fI0pFcsznicM3ei5Wbc1
         azp0J2Z05kVz9FzE8d4de5oQSp41kjhcgCTMKDVSTiO0NX8GNUJrCXVSs9Veegfj5OcQ
         oKHdwzne0hiHGkPDdkBI8NnazjW1LhXIvXyZtKMWe89J8zt+s5SYxdplQEzEkSvhLTPx
         k/7GwPF9UqgHCEtMPXTswm7KY8OJHBjw3IH8NG8cUL+1ovYcXzUJgKtboK9gV2TstT8r
         M9Eg==
X-Gm-Message-State: AFq9FYIQV5Y6ihlF0Vya9UqZ5xYv5UnVmt4cDn9xocWx6dzWCdVAbUEL
	PmWYxmtz0xkk91a+3bFxPpohKSE2KojmNx5E/HumRtE01w7vy+PFeqmfSsHHuhf092r9hkfhYpK
	ZlRrbFq6okFsbJ4HyK7/JfbaKkVRUSUVBmWNvPKDxjxYpR+xDxp8QldbMc290GXOT4iyhsjZ0AD
	mZiKMp7LivJjAFXHkXEy+wq+99swJ5SnuWbqZI6b5v+WNT1+7KaE/4
X-Received: from pfh4.prod.google.com ([2002:a05:6a00:12c4:b0:89f:6242:b2d2])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:200a:b0:3e1:d13f:5fa9 with SMTP id adf61e73a8af0-3e7cd641742mr4292671637.73.1793025650060;
 Mon, 26 Oct 2026 07:40:50 -0700 (PDT)
Date: Mon, 26 Oct 2026 14:40:32 +0000
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
Message-ID: <20261026144032.1338614-1-starchang@google.com>
Subject: [PATCH net v2] net: Fix Hole-196 vulnerability by dropping unicast
 ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org, 
	Star Chang <starchang@google.com>
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

Signed-off-by: Star Chang <starchang@google.com>
---
v1 -> v2:
  - Clarified discovery method (manual code inspection and protocol analysis)
    and triggering context in commit message per netdev-bot automated feedback.
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
2.56.0.257.gf7497c7d27-goog

