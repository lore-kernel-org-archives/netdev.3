Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF33B0AD0
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388152; cv=none; b=helyyxtMV1ge4VMT+hxZAUvAQZrp/m+T/kyU4j8/6BlxxwO4a9T4BKqXasza8fsqJE7mja8mAL/E2BgFN6fSOrh6A7vrWXVp7KisJWzIh0hmu6HswjUhPlKe7EZNemLmKJSATCfIgNNLPyUxBnfKLGQjidTMIO3CLWB67Na2naY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388152; c=relaxed/simple;
	bh=KrarQrPtDYU5AM1GBZjuZkLk1Hn8XL+7NTcl0FgGXYY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HJibyBcUN0IxEImBL0DUZyQ3/LHx8rpYciOXnubbjH2sXEYk/W2dkWMjNpxGzclTftrcilriSzLI1GMIjbT02n5XQO8zPyknoSrQjzI+Bn/0Qt8qVbXlMZubF1DfkBQUEmwGsHvzYV+9nBFL/IPWNIkvl1m++P6N7D+vFJCCYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE391upo; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE391upo"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3516c82e96cso730564eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791388149; x=1791992949; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y+M+jNVGjExhYHY5TOYpx7uQI975MKbRu1QzVKYNZrI=;
        b=mE391upoxyEC3ZfZQJ32Hm4d4U8Xn5FJTUJiXKcxWOn3+pWLpKxQEyJbfbLYd5dbip
         m2UeifxGTVkA4SJcZ4CIPCVLsCsb+bUm9PJK1bFS/2s2884U8hYFv2na9UaMcUf7aiaC
         LtJrfbN/+6VhUfwOgDfo09X1fQ8jzB/YFsKVaD8cvold/AFQpzT4BisJZaA+wHnDm4au
         J/bVYxJyOHCfQakkXCTYHaeKTc2qOLxJVm9yAxu7NquBKeDA7jMcToXvXfH2M5n6jdWk
         qLAVqJu/YBm7Ko8+Gspv+wOoL4hufaNQ+vwWmIeLYp/zXjro5WVibfc5ei3XiISgc8Tz
         h7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791388149; x=1791992949;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y+M+jNVGjExhYHY5TOYpx7uQI975MKbRu1QzVKYNZrI=;
        b=O37FoICEpsNGeoOnr9fcAuK4fxx8j0ciWujaAIqF41sgMug/OH3dm0qYK/vZ2eWOyF
         OdXrG5VosbGfV/1HIm/SGPAmHu/a7RbgR+Rs+KWLPFzzWSE/waDmA2DhX0nPGpcU/etf
         bprbt2o65eBm1tSeuWuDpBGIhKwONLQSZJKNtot4/YGgssfgzZbRBKftODDgO9BsOQKI
         3YJ1dc40YD5j1BpdKayb40w6+ZT6PduXqKFJg2Y7GUuTEV5JGKoXOSAFgiKXalsEAKmh
         huhzKtyYCb1zbUUuxwcJJ/joH4amaCwdM63NDKr7YAD5NO/2XsmfIQkrQUugwmQk5cd7
         lktQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4HwcMDG9aYHdtuxMhvsViUYc8uuwopVSSl+Bcx8ur+wyrxuRQI+kE92gFr/Xq0aFhbasYga4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkQbIDiLhPAt1O6L0btUpiIVz3QkqqtetGcORP/TPOEaGdv4En
	5OaBb/29BcnGJi/miHOEOCaJJh36xj1wheDA5/DnxpVCFhL0SqzJ1A8S17xBjiWkUEiF+UH0
X-Gm-Gg: AYBFou1yN8/Te6db/kckvojOg39fVoNx0yjqdVzthCkOddVS67QoBBJIvL22QwX8tcS
	jp6y9fm9hBwkETI3lH773cLEhoyfX+N8RTVA9dHc+bX6jpgH+xzbuJVgHPVThEYofi4tH8x9v6N
	GfdWb2o7gtg4lH4C8WaU2uIYwd9hGedAETgqGFPUCBEe90QtGHkHvb7bftuCFPBs3cTydAcQd7w
	U2NFYHe/pBGJQBolA9JYcnbDexPMTmdQQctNNkXwZKTOLtx4Omeypq0+lteDCMoVTdE4tNreFXG
	rtp4sgZyOajUOp+LrvyQio5u9QBxptYtuawllnFwyPFSp4snAYUmC2wgJQOc5GqdXvLikOiPc3e
	E6lOhc6++6egCGDXPhTx5ela1KBpOE8EaaD1KcxfKcHEfxJTn7achv+Ti0JtBpaiLhl4RpHJacG
	7FlE2QoyYvwKuq+nwk+MDiTQVuiVdHnGID4FAPOZqgr9P/bu4QC7MRqXBBuefxEPge+bBZoSrh6
	XWaL/w/xjbOwzrK/VSfvtsqj/QnHcGLE4AUZFwEdPdZsS5Cp+BaHNxtP83A6jBFeRURGuUuuZof
	BPOwIGoSiV2WVgVdzx6V+a+4cRePeQT5Q/dwFQMWbxv350+NRIU=
X-Received: by 2002:a05:693c:60d6:b0:351:1230:508d with SMTP id 5a478bee46e88-3515dd4d2fbmr3262965eec.13.1791388137202;
        Wed, 07 Oct 2026 08:48:57 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([95.173.223.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515abb5389sm9131411eec.2.2026.10.07.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:48:56 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org
Subject: [PATCH nf-next v3] netfilter: ip6t_NPT: ensure skb is writable before
 header modification
Date: Wed, 07 Oct 2026 12:48:51 -0300
Message-ID: <179138813128.81565.3404247396030440460@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ip6t_snpt_tg() and ip6t_dnpt_tg() rewrite the IPv6 source/destination
address in place via ip6t_npt_map_pfx() without first calling
skb_ensure_writable().  When the skb data is shared with a clone, the
write is visible to the other holder of the buffer.

This is easy to hit with DNPT in PREROUTING: a packet socket on the
ingress interface (tcpdump, or any AF_PACKET listener) queues a clone
of the incoming skb, and DNPT then rewrites the shared data, so the
captured copy shows the translated destination instead of the one that
was on the wire.

The ICMPv6 error path has the same problem for the embedded IPv6
header, and a second one: icmpv6_bounced_ipv6hdr() uses
skb_header_pointer(), which returns a pointer to a stack copy when the
header is not in the linear area.  ip6t_npt_map_pfx() then modifies
the copy, so the inner header of such ICMPv6 errors is never
translated.

Call skb_ensure_writable() on the IPv6 header before translating it,
and make icmpv6_bounced_ipv6hdr() ensure the embedded header is
writable and return a pointer into the skb instead of a stack copy.

Fixes: 8a91bb0c304b ("netfilter: ip6tables: add stateless IPv6-to-IPv6 Network Prefix Translation target")
Fixes: d5608a0578a0 ("netfilter: ip6t_NPT: rewrite addresses in ICMPv6 original packet")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Changes in v3:
- v2 was hand-edited and does not apply (corrupt hunk); regenerated
  with git format-patch on top of current mainline.
- Keep icmpv6_bounced_ipv6hdr() and make it return a writable pointer
  into the skb instead of open-coding it twice.
- Commit message: describe the reproducer below instead of the
  earlier test notes.

Reproducer (tested on 602042bf29f6, arm64, QEMU):

  ip netns add C; ip netns add R; ip netns add S
  ip link add cr type veth peer name rc
  ip link add rs type veth peer name sr
  ip link set cr netns C; ip link set rc netns R
  ip link set rs netns R; ip link set sr netns S
  ip -n C -6 addr add fd00:1::2/64 dev cr nodad; ip -n C link set cr up
  ip -n R -6 addr add fd00:1::1/64 dev rc nodad; ip -n R link set rc up
  ip -n R -6 addr add fd00:2::1/64 dev rs nodad; ip -n R link set rs up
  ip -n S -6 addr add fd00:2::2/64 dev sr nodad; ip -n S link set sr up
  ip -n C -6 route add default via fd00:1::1
  ip -n S -6 route add fd00:99::/64 via fd00:2::1
  ip netns exec R sysctl -w net.ipv6.conf.all.forwarding=1
  ip netns exec R ip6tables -t mangle -A PREROUTING -i rs \
          -d fd00:99::/64 -j DNPT --src-pfx fd00:99::/64 --dst-pfx fd00:1::/64

  # AF_PACKET listener on rs that reads its queue 4s later (cap.c below)
  ip netns exec R ./cap rs 4 &
  sleep 1
  # any UDP sender works; send6.c below sends 3 datagrams to port 9999
  ip netns exec S ./send6 fd00:99::2
  wait

  before: captured UDP packet, dst=fd00:1::98:0:0:2  (rewritten in the clone)
  after:  captured UDP packet, dst=fd00:99::2        (as sent on the wire)

cap.c:

  #include <arpa/inet.h>
  #include <linux/if_ether.h>
  #include <linux/if_packet.h>
  #include <net/if.h>
  #include <netinet/ip6.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/socket.h>
  #include <unistd.h>

  int main(int argc, char **argv)
  {
          struct sockaddr_ll ll = { .sll_family = AF_PACKET,
                                    .sll_protocol = htons(ETH_P_IPV6),
                                    .sll_ifindex = if_nametoindex(argv[1]) };
          int s = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_IPV6));
          char buf[2048], dst[64];

          bind(s, (void *)&ll, sizeof(ll));
          sleep(atoi(argv[2]));
          for (;;) {
                  struct ip6_hdr *h = (void *)buf;
                  int n = recv(s, buf, sizeof(buf), MSG_DONTWAIT);

                  if (n < (int)sizeof(*h))
                          break;
                  if (h->ip6_nxt != IPPROTO_UDP)
                          continue;
                  inet_ntop(AF_INET6, &h->ip6_dst, dst, sizeof(dst));
                  printf("captured UDP packet, dst=%s\n", dst);
          }
          return 0;
  }

send6.c:

  #include <arpa/inet.h>
  #include <sys/socket.h>
  #include <unistd.h>

  int main(int argc, char **argv)
  {
          struct sockaddr_in6 a = { .sin6_family = AF_INET6,
                                    .sin6_port = htons(9999) };
          int s = socket(AF_INET6, SOCK_DGRAM, 0);

          inet_pton(AF_INET6, argv[1], &a.sin6_addr);
          for (int i = 0; i < 3; i++) {
                  sendto(s, "npt", 3, 0, (void *)&a, sizeof(a));
                  usleep(200000);
          }
          return 0;
  }

Kernel config: IP6_NF_IPTABLES, IP6_NF_MANGLE, IP6_NF_TARGET_NPT, PACKET.
Builds cleanly with W=1.

 net/ipv6/netfilter/ip6t_NPT.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/netfilter/ip6t_NPT.c b/net/ipv6/netfilter/ip6t_NPT.c
index 787c74aa8..e76d202dd 100644
--- a/net/ipv6/netfilter/ip6t_NPT.c
+++ b/net/ipv6/netfilter/ip6t_NPT.c
@@ -77,29 +77,34 @@ static bool ip6t_npt_map_pfx(const struct ip6t_npt_tginfo *npt,
 	return true;
 }
 
-static struct ipv6hdr *icmpv6_bounced_ipv6hdr(struct sk_buff *skb,
-					      struct ipv6hdr *_bounced_hdr)
+static struct ipv6hdr *icmpv6_bounced_ipv6hdr(struct sk_buff *skb)
 {
+	unsigned int offset;
+
 	if (ipv6_hdr(skb)->nexthdr != IPPROTO_ICMPV6)
 		return NULL;
 
 	if (!icmpv6_is_err(icmp6_hdr(skb)->icmp6_type))
 		return NULL;
 
-	return skb_header_pointer(skb,
-				  skb_transport_offset(skb) + sizeof(struct icmp6hdr),
-				  sizeof(struct ipv6hdr),
-				  _bounced_hdr);
+	offset = skb_transport_offset(skb) + sizeof(struct icmp6hdr);
+	if (skb_ensure_writable(skb, offset + sizeof(struct ipv6hdr)))
+		return NULL;
+
+	return (struct ipv6hdr *)(skb_transport_header(skb) +
+				  sizeof(struct icmp6hdr));
 }
 
 static unsigned int
 ip6t_snpt_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct ip6t_npt_tginfo *npt = par->targinfo;
-	struct ipv6hdr _bounced_hdr;
 	struct ipv6hdr *bounced_hdr;
 	struct in6_addr bounced_pfx;
 
+	if (skb_ensure_writable(skb, sizeof(struct ipv6hdr)))
+		return NF_DROP;
+
 	if (!ip6t_npt_map_pfx(npt, &ipv6_hdr(skb)->saddr)) {
 		icmpv6_send(skb, ICMPV6_PARAMPROB, ICMPV6_HDR_FIELD,
 			    offsetof(struct ipv6hdr, saddr));
@@ -107,7 +112,7 @@ ip6t_snpt_tg(struct sk_buff *skb, const struct xt_action_param *par)
 	}
 
 	/* rewrite dst addr of bounced packet which was sent to dst range */
-	bounced_hdr = icmpv6_bounced_ipv6hdr(skb, &_bounced_hdr);
+	bounced_hdr = icmpv6_bounced_ipv6hdr(skb);
 	if (bounced_hdr) {
 		ipv6_addr_prefix(&bounced_pfx, &bounced_hdr->daddr, npt->src_pfx_len);
 		if (ipv6_addr_cmp(&bounced_pfx, &npt->src_pfx.in6) == 0)
@@ -121,10 +126,12 @@ static unsigned int
 ip6t_dnpt_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct ip6t_npt_tginfo *npt = par->targinfo;
-	struct ipv6hdr _bounced_hdr;
 	struct ipv6hdr *bounced_hdr;
 	struct in6_addr bounced_pfx;
 
+	if (skb_ensure_writable(skb, sizeof(struct ipv6hdr)))
+		return NF_DROP;
+
 	if (!ip6t_npt_map_pfx(npt, &ipv6_hdr(skb)->daddr)) {
 		icmpv6_send(skb, ICMPV6_PARAMPROB, ICMPV6_HDR_FIELD,
 			    offsetof(struct ipv6hdr, daddr));
@@ -132,7 +139,7 @@ ip6t_dnpt_tg(struct sk_buff *skb, const struct xt_action_param *par)
 	}
 
 	/* rewrite src addr of bounced packet which was sent from dst range */
-	bounced_hdr = icmpv6_bounced_ipv6hdr(skb, &_bounced_hdr);
+	bounced_hdr = icmpv6_bounced_ipv6hdr(skb);
 	if (bounced_hdr) {
 		ipv6_addr_prefix(&bounced_pfx, &bounced_hdr->saddr, npt->src_pfx_len);
 		if (ipv6_addr_cmp(&bounced_pfx, &npt->src_pfx.in6) == 0)
-- 
2.43.0

