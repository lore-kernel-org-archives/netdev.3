Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463672;
	b=zhmgSGbLIAEl8SsPf8yJcPJ+AZ3ea76onpyw8fmhLP47XQ0v9/kvJr/hbw9l1kbAQ0mH
	 hd/voROwFBLDuLZ3+VrTshgsILuR5SrozXO/s8Am1F/90aeLQUCfwqswj/HOyMCmCa5zv
	 8PLAmlbK6yPmSpThrnGdi87/vWxopU4Bg1Al5nnPMIplJd2rc2otNK5Qoce6gI0u2ZHsP
	 8JfwOIMJJz9WihqYnM2AGkU0lAG8tcF4md+5b6FAHzUeeLhy0qGvSvndP4d4Wyw3FHMat
	 Z5/MprOjclKV+nu4W/X8qT9xEy72ietbdb+yo5JCnKQrIQCl+nUnAVf1vYPtL7MkSjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463672;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=rAcJpnc3Fz26CFHGng6q7kIunuo/xgjRbsmYFh4OhgA=;
	b=1pzXCWbR3+aDlX/JMMRnpb2GghcBQ3TTcme4JXpWIgU5I0OSlFyezv3VZ6WvoW0DeI+v
	 YPWemsNC5EZqk3nwoH2xNixMdPG0y1PuuQ6kxdiYGGQk2jFu2qnruH5JSFZxjx+FKgmFW
	 YO7CtLs8tWuOJKqT0pMfRFZrSuEimksbBJap+6zFXUsDHx43ajooipgQpCem8h/uMaSrD
	 3ivJ0UhA0r3PtspSfqWuWcagDm4g+SzbaMyuTW8BYyn8EyZobrWseIwQM1RaISYyYAEr1
	 LZiexmb6FQbMS79Js9QmVSbKS/6fiqeU0ptxXl7z9zmT0uFPFA77oE2L57s5m9REOMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=Tu12XhNn;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=wyH0+BBX;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704CC606A319;
	Tue, 20 Oct 2026 02:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 704CC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=Tu12XhNn;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=wyH0+BBX
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69K2Xn69006835;
	Tue, 20 Oct 2026 04:33:55 +0200
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 307AB120535;
	Tue, 20 Oct 2026 04:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1792463626; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=rAcJpnc3Fz26CFHGng6q7kIunuo/xgjRbsmYFh4OhgA=;
	b=Tu12XhNnVe1NjqsYEvaBCUM1uB5FOmpzposrSXE6Qc2G6pE8U8R2DLhzBMTW0b9GQQOQKb
	QbLJTZyEJ9yzptCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1792463626; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=rAcJpnc3Fz26CFHGng6q7kIunuo/xgjRbsmYFh4OhgA=;
	b=wyH0+BBXW/D7ujqEzQox8Rtw9ViWXpsAmJ1fHJIDi4fJU20WXzuXBkP5jRQq3Fnv8eeYCj
	1MEGX6m2EcGilHB+eVhIroaakHPaQ47PJ3WNYYm4+vNNS2QbvDWbMPrAaqCIN/AHElVMlu
	Hfd5fxwLrw+GIGp7cFN0puG2k+a2H/UR2PQn6mtULdQEpZ4kAkYPYSWYT9DqKDlnJyFpLj
	SevmNuMLc3/P8Iw2K+TBwaPY1kFjmODgOWg9+LyPVpkamys7iWI/k1G+tMdp874nl7uuRr
	Gc7XX8R0TQ+UcP6mOXZu/O43wvqRZ2pP70/Nhh42Wf1esozed+egF2clc8tHUw==
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
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net] seg6: fix transport header for inner IPv4 with IP options
Date: Tue, 20 Oct 2026 04:33:36 +0200
Message-Id: <20261020023336.34-1-andrea.mayer@uniroma2.it>
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
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 56 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 53f7b2452575..c249f7751d41 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1056,6 +1056,40 @@ static int input_action_end_dx6(struct sk_buff *skb,
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
@@ -1085,14 +1119,18 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 static int input_action_end_dx4(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
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
@@ -1102,7 +1140,7 @@ static int input_action_end_dx4(struct sk_buff *skb,
 
 	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
 drop:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return -EINVAL;
 }
 
@@ -1234,6 +1272,7 @@ static struct net_device *end_dt_get_vrf_rcu(struct sk_buff *skb,
 static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 				       struct seg6_local_lwt *slwt, u16 family)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct seg6_end_dt_info *info = &slwt->dt_info;
 	struct net_device *vrf;
 	__be16 protocol;
@@ -1246,7 +1285,9 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
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
@@ -1260,6 +1301,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 
 	if (unlikely(info->family != AF_UNSPEC && info->family != family)) {
 		pr_warn_once("seg6local: SRv6 End.DT* family mismatch");
+		reason = SKB_DROP_REASON_NOT_SPECIFIED;
 		goto drop;
 	}
 
@@ -1273,7 +1315,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 	return end_dt_vrf_rcv(skb, family, vrf);
 
 drop:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return ERR_PTR(-EINVAL);
 }
 
@@ -1286,9 +1328,7 @@ static int input_action_end_dt4(struct sk_buff *skb,
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

