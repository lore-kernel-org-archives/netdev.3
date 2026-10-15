Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8037DAAE;
	Thu, 15 Oct 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108511; cv=none; b=BdEkhfNCkZsrJcX4VcKXdUWsAtmYcIN6/dyaNZHszqBkV6KCgUgX3Oix2HXt+tg7+N3iJZ7EMjBi1BZZRT25Aw5rC2j0Ksn08ZRbIXdLpqYrY9JJ/dUAYL3AjQxDoRwKcCNhF6mDhD+LugVfHeOvZmn+N/3VIiizOM7rQ4GyIn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108511; c=relaxed/simple;
	bh=NU+88D01z0xKD9rVu1nOHWbkObq+uVTVJ19u+9nRUk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eU1U2kvlLwI6pQJnHWi6tRSOqCg9MYaH5jGYGlFfdwtSyre83ZGQ/4I8mkmhx6aQrDRhGhbFYxm24WTTNt6+bRVLTQlCfV5khiBvxAXHKU02W0hMfXadFU/8NhtdZeJwW7hbbrc4mFE3W+SIJ0cGLtwY3TCP8gy+psFH31QQrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XgjKzsG6; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XgjKzsG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792108509; x=1823644509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zj9mrzxo72LrC57/aCdjXrA9LiKXNIoxoGruwoqBX+g=;
  b=XgjKzsG6LUhWChEGDDFmw6RvJbqIr9STtELmPXxl4NM8fdNK+OevjuBs
   FlxJOGuwBdCyXOBQZuJc/HVw4TRN6NvRNQBPQxc1jRgeueUJzeH4w+/hm
   Ko4sPSfbxy9iS9wDFWx2pstdfdAhFFl0Me8M20FtKaBJC2qNQuq7Jy8ne
   kvucohrLCz0cekY1etKerN/OIWDgomn1RmQDDr7cNHIUUUFNDdwTJySXd
   syqGcERJhFENr6OwzQZP/pUou7dp3DQBTCRfK9wQkeLPZpzlTXcNpqA2+
   sONuHbJfx9zDW2GPD0xcZ30al8IktrKHm/j6F/kxN+tdJvSSKJiyvc+sp
   g==;
X-CSE-ConnectionGUID: U01tyVWPSh+MkzNoNdi+4A==
X-CSE-MsgGUID: ZNQTjotqSwy5pJoOTMd+qw==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31261335"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 23:55:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:29648]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.190:2525] with esmtp (Farcaster)
 id 43bf413a-6a22-4a82-a52b-f78d3746de0b; Thu, 15 Oct 2026 23:55:08 +0000 (UTC)
X-Farcaster-Flow-ID: 43bf413a-6a22-4a82-a52b-f78d3746de0b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 23:55:08 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 23:55:08 +0000
From: David Keogh <dkeogh@amazon.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	<nh-open-source@amazon.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next 2/6] net: reserve extra TX headroom for local egress
Date: Thu, 15 Oct 2026 23:53:31 +0000
Message-ID: <20261015235335.4162993-3-dkeogh@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261015235335.4162993-1-dkeogh@amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Use LL_ALLOC_SPACE() instead of LL_RESERVED_SPACE() where the stack
allocates packets on behalf of a local sender and sizes them for the
output device:

 - __ip_append_data() and __ip6_append_data(), covering UDP, ICMP,
   ping and raw sockets without IP_HDRINCL;
 - raw_send_hdrinc() and rawv6_send_hdrinc();
 - the three AF_PACKET transmit paths;
 - AF_XDP copy mode, which open-codes the same calculation from
   needed_headroom.

These are the main paths where a packet's headroom is decided by the
device's advertised requirement and nothing else. Adding the
administrator's extra reservation here means such packets reach the TC
egress hook with room for additional headers already in place.

Paths that check an existing packet against LL_RESERVED_SPACE() and
expand it on demand, such as ip_finish_output2() and the tunnel
transmit functions, are deliberately left alone. Using the larger value
there would force a reallocation of every packet that lacks the full
extra reservation, including TCP segments that already have enough
room for the headers an egress program actually pushes.

Signed-off-by: David Keogh <dkeogh@amazon.com>
---
 net/ipv4/ip_output.c   | 2 +-
 net/ipv4/raw.c         | 2 +-
 net/ipv6/ip6_output.c  | 2 +-
 net/ipv6/raw.c         | 2 +-
 net/packet/af_packet.c | 6 +++---
 net/xdp/xsk.c          | 6 ++++--
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 3396f177a..bf718b8f6 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -988,7 +988,7 @@ static int __ip_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
 	paged = !!cork->gso_size;
 
-	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
+	hh_len = LL_ALLOC_SPACE(rt->dst.dev);
 
 	fragheaderlen = sizeof(struct iphdr) + (opt ? opt->optlen : 0);
 	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 9d01006d8..a1e72e634 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -355,7 +355,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	if (flags&MSG_PROBE)
 		goto out;
 
-	hlen = LL_RESERVED_SPACE(rt->dst.dev);
+	hlen = LL_ALLOC_SPACE(rt->dst.dev);
 	tlen = rt->dst.dev->needed_tailroom;
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98..a3626d5f0 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1490,7 +1490,7 @@ static int __ip6_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;
 	orig_mtu = mtu;
 
-	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
+	hh_len = LL_ALLOC_SPACE(rt->dst.dev);
 
 	fragheaderlen = sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len +
 			(opt ? opt->opt_nflen : 0);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b965258cf..7f2da5581 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -601,7 +601,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	struct sk_buff *skb;
 	int err;
 	struct rt6_info *rt = dst_rt6_info(*dstp);
-	int hlen = LL_RESERVED_SPACE(rt->dst.dev);
+	int hlen = LL_ALLOC_SPACE(rt->dst.dev);
 	int tlen = rt->dst.dev->needed_tailroom;
 
 	if (length > rt->dst.dev->mtu) {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c..8790fd038 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2031,7 +2031,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 
 	if (!skb) {
-		size_t reserved = LL_RESERVED_SPACE_EX(dev, hard_header_len);
+		size_t reserved = LL_ALLOC_SPACE_EX(dev, hard_header_len);
 		int tlen = dev->needed_tailroom;
 		unsigned int hhlen = dev->header_ops ? hard_header_len : 0;
 
@@ -2863,7 +2863,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
+		hlen = LL_ALLOC_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
 			data += vnet_hdr_sz;
@@ -3090,7 +3090,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
+	hlen = LL_ALLOC_SPACE_EX(dev, hard_header_len);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
 	linear = max(linear, min_t(int, len, hard_header_len));
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180..58d64025d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1045,7 +1045,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	buffer = xsk_buff_raw_get_data(pool, addr);
 
 	if (!skb) {
-		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
+		hr = max(NET_SKB_PAD,
+			 L1_CACHE_ALIGN(netdev_tx_alloc_headroom(xs->dev)));
 
 		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
 		if (unlikely(!skb))
@@ -1128,7 +1129,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		len = desc->len;
 
 		if (!skb) {
-			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
+			hr = max(NET_SKB_PAD,
+				 L1_CACHE_ALIGN(netdev_tx_alloc_headroom(dev)));
 			tr = dev->needed_tailroom;
 			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
 			if (unlikely(!skb))
-- 
2.50.1

