Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066183;
	b=C7n86XY4Lnk4fwRntgBvSGbHB7cPgcLe73bDkG9mbNSZuj6ERkFmCL6fX1vDZt4WNT8M
	 7UobdUWDCS9sh6Gyg6r+khT1+mdN7Md6loa5ZyfVpjRzJRrfR4SrECWPYEZHfa++2Au9j
	 6yAA7vfVAHqtm7KMCPZ65U5HBV4J0aFe0YnRIgFaFDkKhSU2Wsyjq+3mWJ2vLwZzZjb/3
	 XLdth05lbkXrAGL1A4WDSwEShE+zXVwVON/slZ/hlfkB+8f++tHrwgkt3x/X6OH//YbHr
	 bCmtEPh+SSVuIdLQOklYKd+BrPJibWJuPzfFBpxAWcLmuCr1BzuJcEyWk4s362ZytAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=MCpoMADTiJxwsfzWeJ5DnI4OECVzlunkx5qHILlDWuM=;
	b=kFKNZbYFP8qeXIZOJHV9ZtoIahoCh7TaMyLfrvoVGw50PrBDZ52u5DQmyABPnVqIjATX
	 PKhj5nKxTrjBhGhWpR7ZAfs6p+UZCXBpFvy6rmUI60UqwnpHRBEOQzrOrts/eLGP2Owp4
	 x96xuCZXs/JJPWFLDozD0IzLQSg4WEoOPNMImwwOzJPrNxSXtetC0LMlc7sbtUIJxU+SU
	 cVLXP4WzHNaQgQWAh0do5IGx0n0h+NWEBh3KaKwF32GiAlkwS/sVcl9TWx6F9sr/rT4nT
	 AS16UoldQ2AMe4E/gJPOE+OlOtnZP8dujX9hhyBqUVaHHleVEizq6+Vio4iAk4ShgXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BguTVFsk;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA6606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CA6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BguTVFsk
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a01e2962a1so3957190b3a.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793066182; x=1793670982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCpoMADTiJxwsfzWeJ5DnI4OECVzlunkx5qHILlDWuM=;
        b=BguTVFskdSIL9vCzO1RUA1N5HmeJ3VX+oeLNpcvFFK/FZOk0GtGq1AlPc9F4nTFp5s
         ibTUgCov43I13ulgv2inBDB9RQq626NvfmHMtWkLcHfbNHtnmDca/UiNZ2Gk8yb8FGG7
         zhgz6l2YZvk1KjiwOnEfOF/XUtEtdl+1DnIqcq2V/PlSI8uMRC5UiTFMiuhhnyV1nVlP
         O9xvNdPHZ0ElVs+XH6u22G87T0r2d7TcycVQQCHW1vMqqpikE94D5GRtiUZVBc3e5fC7
         L/m22D/FNOVnnICZzCYrAvvp+7/49r1tOBu54CnhelAybLtY5LaN1jrzfDfXjWeiqr3T
         0yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793066182; x=1793670982;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCpoMADTiJxwsfzWeJ5DnI4OECVzlunkx5qHILlDWuM=;
        b=Jy+gPe0gBuwKfbNuj9ZQizD8tpbKuPXiKnriEDFFOvKsfg+XZMQbF7St/PqzHFqH1W
         7pcPfWGU5U0v+oX7HQI6aIU6bYyMglw5keFkSaDWGWujPPOdcF40v3vHCRolMDnza9rV
         aIvzt4Uc1vbv1eCouQA1KFu9JV/0IY0JEOCFX4uQrTUQLibma/j4IvI8eDAhlY8lVbM3
         2IJFvXonywHyBMYxRB36Df1p1/5rT3xS638z7W13PFfdPzDyb+xrepP9pPSoV/dOf2t4
         uGnh6QRe6MwtyiAZK1xePV+KRWWHUVg33zvB1Ca7nYZS9/ZpkqsM2LvOFjwvS2JAm9rK
         SEgQ==
X-Gm-Message-State: AFq9FYIK1QiJTap9tR7c+NZn/+LAAaWm3Tj9oPEAHqdZwhFR7DgXg1s4
	cCmQt9FMrCSnVOp/JGJ27HDpbSg0gZ+oI/LslagrtYTn0TQaWAze+wMmrrpBwho13wBJpkN4Iyd
	oREL94LEMZcnxbg6JSv6ipuaIX0ohAMLUVfrD6KFTrch/3aZQGf3q1iNpnCQj2GEQmbtddNUH48
	vMPbZtB89OCN90S+UerCvVPTq0z1nmNCcq9kmwj35n4MvoXKpBJ+LO
X-Received: from pgx30.prod.google.com ([2002:a63:175e:0:b0:cc7:492f:3ac1])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4d91:b0:3e2:3392:5419 with SMTP id adf61e73a8af0-3e7bfd08881mr6040861637.56.1793066181484;
 Mon, 26 Oct 2026 18:56:21 -0700 (PDT)
Date: Tue, 27 Oct 2026 01:56:19 +0000
In-Reply-To: <20261026150539.1357037-1-starchang@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026150539.1357037-1-starchang@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027015619.1745984-1-starchang@google.com>
Subject: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping unicast
 ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ja@ssi.bg, johannes@sipsolutions.net, johannes.berg@intel.com, 
	linux-kernel@vger.kernel.org, starchang@google.com
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
- Log rate-limited warnings (`net_warn_ratelimited`) and increment MIB
  error counters (`IPSTATS_MIB_INHDRERRORS`) for dropped frames.

Fixes: 12b74dfadb5a ("ipv4: add option to drop unicast encapsulated in L2 multicast")
Fixes: abbc30436d39 ("ipv6: add option to drop unicast encapsulated in L2 multicast")
Signed-off-by: Star Chang <starchang@google.com>
---
v3 -> v4:
  - Fix broken newline syntax in net_warn_ratelimited() string literal
    in net/ipv4/ip_input.c that caused build failures across 32-bit,
    allmodconfig, and clang CI builds.
  - CC Julian Anastasov (ja@ssi.bg) per netdev-bot blamed author check.
v2 -> v3:
  - Add Fixes: tags for commits 12b74dfadb5a and abbc30436d39.
  - Reformat lines in net/ipv4/ip_input.c to adhere strictly to the 80-column limit.
  - CC maintainers Ido Schimmel and Simon Horman per netdev bot check.
v1 -> v2:
  - Clarified discovery method and triggering context per netdev-bot feedback.

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
index 9860178752b8..7d6d3e72e557 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -456,10 +456,37 @@ static int ip_rcv_finish_core(struct net *net,
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
+				net_warn_ratelimited("Drop unicast IP %pI4 in L2 BMC on %s\n",
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
2.43.0
