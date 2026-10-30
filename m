Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329900;
	b=oxIu34qoAcQTfrgj2ej6p2pZukIUGm3hAY5xpKNh0mx3sThceILYluWtP2sspE+7CFjR
	 ZTIPylJvKRel6xdAuUy39jvz4Rt7dw1GB0WrlkWhEfaJPtKBFvHfz8m/S6u8ur+dwkaIV
	 k8fM0BavkddwNAgdQkO5qZaTtAASpmk94YhaNZFsDe3hd077QzKajmUV1pbFH71Gh0Qcu
	 pTk/K4Z/YZZaW2zM5JqCF4nOAmD5g3KPlN6IXOBNavkd1uVkbFR0H/LkqzztAMlb/5fPm
	 9WyHwscTevNJqeEGITkV4WUqf1cURD4NDrCbYuYtG8O/mqZa7kYFWUR4Vwi1BcdInfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=2fDJp0mtNAsbfuIPfVhzQZRqcvQEENgLWc8ECje75lk=;
	b=zKHbBfHkK6XH0XgJBKQlRHcGLfAwFnhP93D/A/LeOnH59DyDBkgmi3QcALGYwkowktO1
	 G8aUKbUilqymReSCnWOy6NKvD5FWHWOCaghjkvmoUzgUjnyUEKgtFyZCq2D9bi8ZkcwbJ
	 exnZ1eb7wCOnY1WzoCVXGjv8Bf6J/ohLFtzDg1wouRPrdLDSlCe7t33OYH2ujtprZT4DJ
	 Qds/P9O3Q5FMkqs0fDc9HlfBFtNqNy1JIEC9NKS9ipTr+Vw6LpH/sM4eAXigAmymtLxC0
	 Sqtc700ah9UiEwjyc8C8/Rj8P1N0yw4KIGwzJwjwVhrvLTJGbvX3VCXXopv075SsK0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jKrdVlwV;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F75606A323
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F75606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jKrdVlwV
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a073778890so171573b3a.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793329899; x=1793934699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2fDJp0mtNAsbfuIPfVhzQZRqcvQEENgLWc8ECje75lk=;
        b=jKrdVlwVUzHlCoqlXv/D4pBj/numfL+p81jNrs982LRoMu1evrn3GJO6A/a1kc6gh1
         cZwFqV0Hh+J3egBb/qxTDFddtgYtnFtESqmVmxjMr/TfH7FWudq9bZFZ/UR4FsIvs/KH
         9DB0c8VAomn3Y8rIoK91W0Kk8UZjlyo5N4H5TlRMRheI3aD/Fc6pHRXXsF74WQkyEWJ9
         kPNaorAFqPtCb5ZbsQAUfafws9TJkCAL6io7zxGEHHOpB4pXMAaDpu0euLGitLegRo2k
         85eg176H6HsDSmgAESAXlZyI8ZoOtvtc7iw+zMTqrzoe9a3mpvwq7mE4D9WsackzHPKN
         of9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793329899; x=1793934699;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fDJp0mtNAsbfuIPfVhzQZRqcvQEENgLWc8ECje75lk=;
        b=yVqvXFdlgZK+pAU+Q14aCRSg2QxdX6PpGo+tbgdUEYdR9UGhrkc364y8ySOrrW2ilo
         qbYneYW2VxECax2l5DDDWDB9TXN2DRNnIOAkUUSIWbogpWH1kUCA4NHHUT8KAL74g2mu
         u5uoH0Ga+VHkurhtd7i06OovfVDOwrZXUkkQ/OM09aq11D+2bpy9o8xgnUSAQftv41DG
         oU6S4EeAZ9zVh2zsE8H65vvGsw4RnZ9OLC+mzCoKaK0vcFVMc6JESMJD/nqXI4Ns4V87
         KrIsBWs0/znlZggkgRcqO8N1SL7fRGcmw5a25rhYvuwKzlO7dOFSP7MUU/r6SCC3Qjmx
         kGVw==
X-Gm-Message-State: AFq9FYJkRb/rhywfw65UGdxCfp2aYqlfbD1S04xXZgiOHWTYjolHOYTv
	Wtd9zbm8XmdBg3wYiQSDBKCy2V+lDKvjNvbLnDUwghRWRJH8AHWllri/joMj5rs+bQC/0F/QNRx
	xv6VYwu0EH/t8WoUBfJsOeRwGUQ4OD9eJeI1wpzaPRRSPoRsIDLiUD54LLLIGHH3JcZD8N+K39o
	xAF3QxJXrqrtIIgAVzYW6rwruLTwoha412b6LFI88Lz9gr0HH3sYmf
X-Received: from pffl11-n1.prod.google.com ([2002:a05:6a00:c34b:10b0:89e:78fd:6ab9])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4f8c:b0:899:465d:c8ff with SMTP id d2e1a72fcca58-8a9bdbd0f81mr976153b3a.13.1793329898568;
 Thu, 29 Oct 2026 20:11:38 -0700 (PDT)
Date: Fri, 30 Oct 2026 03:11:36 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030031136.607720-1-starchang@google.com>
Subject: [PATCH net v5] arp: Fix Hole-196 vulnerability by dropping unicast
 ARP replies in L2 BMC
From: Star Chang <starchang@google.com>
To: netdev@vger.kernel.org
Cc: ja@ssi.bg, dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	johannes@sipsolutions.net, johannes.berg@intel.com, 
	linux-kernel@vger.kernel.org, wangroger@google.com, starchang@google.com
Content-Type: text/plain; charset="UTF-8"

Wi-Fi 802.11 to 802.3 frame translation allows attackers to inject
frames inside GTK-encrypted L2 broadcast/multicast (BMC) frames (the
"Hole-196" vulnerability).

While the `drop_unicast_in_l2_multicast` sysctl drops unicast
IPv4/IPv6 packets received over L2 BMC, it did not check ARP replies in
`net/ipv4/arp.c`. In laboratory testing on shared-key Wi-Fi networks,
an attacker can inject an unsolicited unicast ARP reply (e.g. sip =
gateway IP, sha = attacker MAC, tip = victim IP) over L2 broadcast. If
the victim already has a neighbor entry for the gateway (such as after
normal network traffic), `neigh_update()` is invoked after the
1-second locktime window, overwriting the gateway's cached MAC address
with the attacker's MAC.

Under standard networking behavior, a non-GARP ARP reply is strictly
meant to be delivered as an L2 unicast frame (PACKET_HOST) to the
requester. The only legitimate reason an ARP reply is sent over L2
broadcast is for Gratuitous ARP (sip == tip) or address announcement.

Enhance `drop_unicast_in_l2_multicast` sysctl enforcement:
- Drop ARP replies received over L2 BMC frames unless they are
  Gratuitous ARP (sip == tip), recording
  SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST.
- Preserve legitimate GARP announcements (sip == tip) so they continue
  to defer to the `drop_gratuitous_arp` sysctl, preserving VRRP/HSRP
  router failover.
- Leave ARP requests untouched per RFC 826.
- Update Documentation/networking/ip-sysctl.rst to describe the ARP
  behavior.

Fixes: 12b74dfadb5a ("ipv4: add option to drop unicast encapsulated in L2 multicast")
Signed-off-by: Star Chang <starchang@google.com>
---
v4 -> v5:
  - Drop all IP and IPv6 changes to avoid UAF risks and adhere to RFC 1122.
  - Simplify ARP logic to strictly drop non-GARP ARP replies (ar_op == ARPOP_REPLY && sip != tip) over L2 BMC.
  - Do not inspect or gate on target hardware address (tha), leaving ARP requests untouched per RFC 826.
  - Update Documentation/networking/ip-sysctl.rst to accurately reflect ARP behavior.
  - Record SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST on drop.
  - Retain only Fixes: 12b74dfadb5a.

v3 -> v4:
  - Addressed review feedback on ratelimit logging and drop counters.

v2 -> v3:
  - Added THA validation and gratuitous ARP handling.

v1 -> v2:
  - Initial expansion to ARP.

 Documentation/networking/ip-sysctl.rst |  4 ++--
 net/ipv4/arp.c                         | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 208f46967ee5..0e4f151fac48 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2297,8 +2297,8 @@ promote_secondaries - BOOLEAN
 	Default: 0 (disabled)
 
 drop_unicast_in_l2_multicast - BOOLEAN
-	Drop any unicast IP packets that are received in link-layer
-	multicast (or broadcast) frames.
+	Drop any unicast IP packets and non-GARP ARP replies that are
+	received in link-layer multicast (or broadcast) frames.
 
 	This behavior (for multicast) is actually a SHOULD in RFC
 	1122, but is disabled by default for compatibility reasons.
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index d409f606aec0..d6a01d05aa75 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -791,6 +791,26 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 	    (!IN_DEV_ROUTE_LOCALNET(in_dev) && ipv4_is_loopback(tip)))
 		goto out_free_skb;
 
+/*
+ * Hole-196 defense for ARP:
+ * If drop_unicast_in_l2_multicast is enabled, drop ARP Replies received
+ * in L2 BMC frames unless they are Gratuitous ARP (sip == tip).
+ *
+ * Standard ARP Replies are strictly unicast (PACKET_HOST). An ARP Reply
+ * in an L2 broadcast frame with (sip != tip) is an injected unicast packet.
+ * Legitimate GARP (sip == tip) is preserved and defers to DROP_GRATUITOUS_ARP.
+ * ARP Requests are left untouched per RFC 826.
+ */
+	if ((skb->pkt_type == PACKET_BROADCAST ||
+	     skb->pkt_type == PACKET_MULTICAST) &&
+	    IN_DEV_ORCONF(in_dev, DROP_UNICAST_IN_L2_MULTICAST)) {
+		if (arp->ar_op == htons(ARPOP_REPLY) && sip != tip) {
+			kfree_skb_reason(skb,
+					 SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST);
+			return NET_RX_DROP;
+		}
+	}
+
  /*
   *	For some 802.11 wireless deployments (and possibly other networks),
   *	there will be an ARP proxy and gratuitous ARP frames are attacks
-- 
2.56.0.317.g454f8302e1-goog
