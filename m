Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207856;
	b=l3l6BAp2syHiTcZqxstbas/ZN9JoGYCa+C7CGLIVwwuGbH8P6u4ixwSGZ3x7nuWa+cSq
	 3zxQNuTnMBd5ZEElKFNGIgvWq6bxHvw7mzT+ay1/VJtES6Q/Bef4J70CgLGFawSKHa5kB
	 EUBG0O+HL5Er1OlzsA/AFohTioQCVAJfAs5EYb3EXEpebSHRbSFNt3JjLtYUFYGAc2ZG2
	 emI/99buXQjb2GaDdfI5++iZ1v0/4spyAewgAZkoB4o48xD8nHUOvvXP1VH1L0ORluQ0A
	 eTRpuoBOqR7/6CuXGrc6aBNZNa155eFEiymaS1vIcyt2ZHVV9Z6Sxltu+GTMBYB/UyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207856;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=4xlm+iOZGH5Go2YFUU3+UHHX7jeMx1Dlrs8HI4RLlvk=;
	b=ZLN8jrcuFutTyr6PYj9CUnb1Xa3dBidnje5IlAfr1C7lNIy7cL9DVbSxjlnIhunPQ+5+
	 VNO64Ie3GSu20ybGNx/j8cjjsd6h7KwGaMkpY4JE8eQAdWh9FDyqHNZgCKi+ZLtKs0Z6L
	 tTkpawKH8fA0K0vxr0zyJI7Z3keSj3vxVyt38wnWrtQqK5pIM16FxHsdBK8Zr9e9w6kBQ
	 wPLtmku5NnVjNp5MIzESDypD3OHeh/oEui8MqJGFLRKjCHPKeFORABLEaLHRLIP0AjTtP
	 bUEcdL6bOHO7d9i7IV48GJEQT0WypVfKYyldaN9jSBdyKX92ZFYsv5y7wG6GcbLFPyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=temperror header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=3mYJXMWi;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=BXQvKhE3;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE60606A31A;
	Wed, 28 Oct 2026 17:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE60606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=3mYJXMWi;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=BXQvKhE3
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69SHGYRr026236;
	Wed, 28 Oct 2026 18:16:40 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 38D26120EB0;
	Wed, 28 Oct 2026 18:16:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793207790; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=4xlm+iOZGH5Go2YFUU3+UHHX7jeMx1Dlrs8HI4RLlvk=;
	b=3mYJXMWiFCNBvx8jWSsdbbL6nBbKx3Jd+is8HmDW/nCJ6DM/obgvK8G8uRSk/OgSoJyfPJ
	c+vpu/3cJHAH9nDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793207790; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=4xlm+iOZGH5Go2YFUU3+UHHX7jeMx1Dlrs8HI4RLlvk=;
	b=BXQvKhE3l9yecMrym4IOTZy+oJa0XMOGfJvBgVK9u/lybS2f6TOwGCSBq0c4au253CM5Ea
	BvmZsghVt3kCMuYDLJkJ6nxxGA1YhRLQl85rZ+qZfEHC73Ed1BCOVRSaQyjPG5zMb5mYza
	nqf7iETslJLofiv/3/Ud/w8solFeLwQhfSbxflIXDIRe6sXojseZyZPqD2htULrbAHWpCn
	igg10uPcZ1sSa4b/CKOoY6fx0rBUXfud2XATTgdvp60x5bcXcpDTd/nk5mbXGcphRx44q7
	i8Iu1yNnTJmblASFsXJq+WlSc1nWVkgc6Ts+GJ3qU7mC7aCDH7ZaHQ8UGIHSwQ==
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Lebrun <david.lebrun@uclouvain.be>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Ahern <dsahern@kernel.org>,
        Hazley Samsudin <hazleycryilis@gmail.com>,
        Hangbin Liu <hangbin.liu@linux.dev>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>,
        Hangbin Liu <liuhangbin@kylinos.cn>
Subject: [PATCH net v2] seg6: fix transport header for inner IPv4 with IP options
Date: Wed, 28 Oct 2026 18:15:11 +0100
Message-Id: <20261028171511.35-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
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
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

The End.DT4, End.DT46 (its IPv4 path only) and End.DX4 behaviors set the
transport header of the decapsulated IPv4 packet at a fixed 20 bytes, the
size of an IPv4 header without options. They do not validate the header
length either. With options, the transport header points at the first
option byte. The effects include:
- ping -R sends an echo request with a 60-byte IPv4 header to a local
  address through an End.DT4 or an End.DX4 SID. Since icmp_rcv()
  computes the ICMP checksum from the first option byte, the request
  fails the check and is counted in IcmpInCsumErrors.
- A UDP datagram can reach a port that an iptables rule drops. The rule
  checks the UDP header after the full IPv4 header, while the socket
  lookup reads it at the fixed 20-byte offset.
- With an inbound AH state, ah_input() reads the AH header at the fixed
  20-byte offset, but copies the IPv4 header over it with the length in
  the IHL field. A packet shorter than that length can make ah_input()
  write past the end of the data, into skb_shared_info when the skb has
  no tailroom.

Validate the inner IPv4 header length with the new helper
seg6_validate_iphdr_len() and set the transport header at that length. A
packet that is not IPv4, whose header length field is below 5, or whose
header is truncated, is dropped with a drop reason. The fix is limited to
the header length, which the transport header relies on. Other checks done
on IPv4 input, such as the header checksum, the total length and the IP
options, are not addressed here.

Found by code inspection while reviewing commit 44930446dde4 ("ipv6: seg6:
clear IPv4 control block on IPIP decapsulation"), as a pre-existing issue
that Sashiko also reported on v2 of that patch. Without this patch, a
bpftrace probe on ah_input() shows the reporter's reproducer packet
written into skb_shared_info. With it, that packet is dropped before
ah_input(), ping -R no longer fails the ICMP checksum, the UDP datagram
reaches its real port, and the SRv6 selftests still pass. These effects
reproduce on an unmodified kernel, without error injection.

Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
Reported-by: Hazley Samsudin <hazleycryilis@gmail.com>
Closes: https://lore.kernel.org/netdev/20260809221915.2ffc1ecd0f445fcb70270e31@uniroma2.it/
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
v2:
 - Use SKB_DR() to declare the drop reason variable, and move the
   family mismatch check before the switch in end_dt_vrf_core()
   (Hangbin Liu)
 - Fix stale comment on struct seg6_end_dt_info::family (Sashiko)
 - No functional change from v1. Collect Reviewed-by tags from David
   Ahern and Hangbin Liu, thanks to both for the reviews
v1: https://lore.kernel.org/netdev/20261020023336.34-1-andrea.mayer@uniroma2.it/

 net/ipv6/seg6_local.c | 69 +++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 0c3d1be7f129..0d952514d095 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -149,9 +149,7 @@ struct seg6_end_dt_info {
 	int vrf_ifindex;
 	int vrf_table;
 
-	/* tunneled packet family (IPv4 or IPv6).
-	 * Protocol and header length are inferred from family.
-	 */
+	/* tunneled packet family (IPv4 or IPv6) */
 	u16 family;
 };
 
@@ -1056,6 +1054,40 @@ static int input_action_end_dx6(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+/* Validate the length of the IPv4 header at skb->data (which must point to
+ * the network header) and report that length, options included.
+ * Only the version, the header length and the presence of the whole header
+ * are checked.
+ * The length is written only when SKB_NOT_DROPPED_YET is returned.
+ *
+ * skb pointers may change: after this call, the caller must evaluate again
+ * any pointer into the packet data.
+ */
+static enum skb_drop_reason
+seg6_validate_iphdr_len(struct sk_buff *skb, int *hdrlen)
+{
+	enum skb_drop_reason reason;
+	const struct iphdr *iph;
+	int len;
+
+	reason = pskb_may_pull_reason(skb, sizeof(struct iphdr));
+	if (reason)
+		return reason;
+
+	iph = ip_hdr(skb);
+	if (iph->version != 4 || iph->ihl < 5)
+		return SKB_DROP_REASON_IP_INHDR;
+
+	len = ip_hdrlen(skb);
+
+	reason = pskb_may_pull_reason(skb, len);
+	if (reason)
+		return reason;
+
+	*hdrlen = len;
+	return SKB_NOT_DROPPED_YET;
+}
+
 static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
@@ -1085,14 +1117,18 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 static int input_action_end_dx4(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
+	SKB_DR(reason);
+	int hdrlen;
+
 	if (!decap_and_validate(skb, IPPROTO_IPIP))
 		goto drop;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	reason = seg6_validate_iphdr_len(skb, &hdrlen);
+	if (reason)
 		goto drop;
 
 	skb->protocol = htons(ETH_P_IP);
-	skb_set_transport_header(skb, sizeof(struct iphdr));
+	skb_set_transport_header(skb, hdrlen);
 	nf_reset_ct(skb);
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
@@ -1102,7 +1138,7 @@ static int input_action_end_dx4(struct sk_buff *skb,
 
 	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
 drop:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return -EINVAL;
 }
 
@@ -1237,16 +1273,24 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 	struct seg6_end_dt_info *info = &slwt->dt_info;
 	struct net_device *vrf;
 	__be16 protocol;
+	SKB_DR(reason);
 	int hdrlen;
 
 	vrf = end_dt_get_vrf_rcu(skb, info);
 	if (unlikely(!vrf))
 		goto drop;
 
+	if (unlikely(info->family != AF_UNSPEC && info->family != family)) {
+		pr_warn_once("seg6local: SRv6 End.DT* family mismatch");
+		goto drop;
+	}
+
 	switch (family) {
 	case AF_INET:
 		protocol = htons(ETH_P_IP);
-		hdrlen = sizeof(struct iphdr);
+		reason = seg6_validate_iphdr_len(skb, &hdrlen);
+		if (unlikely(reason))
+			goto drop;
 		break;
 	case AF_INET6:
 		protocol = htons(ETH_P_IPV6);
@@ -1258,11 +1302,6 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 		goto drop;
 	}
 
-	if (unlikely(info->family != AF_UNSPEC && info->family != family)) {
-		pr_warn_once("seg6local: SRv6 End.DT* family mismatch");
-		goto drop;
-	}
-
 	skb->protocol = protocol;
 
 	skb_dst_drop(skb);
@@ -1273,7 +1312,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 	return end_dt_vrf_rcv(skb, family, vrf);
 
 drop:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return ERR_PTR(-EINVAL);
 }
 
@@ -1286,9 +1325,7 @@ static int input_action_end_dt4(struct sk_buff *skb,
 	if (!decap_and_validate(skb, IPPROTO_IPIP))
 		goto drop;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		goto drop;
-
+	/* end_dt_vrf_core() validates the inner IPv4 header length */
 	skb = end_dt_vrf_core(skb, slwt, AF_INET);
 	if (!skb)
 		/* packet has been processed and consumed by the VRF */
-- 
2.43.0

