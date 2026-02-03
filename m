Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C23306B0A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109250; cv=none; b=cIlzBXTiUmpAPcZDcDNOKjqxFGVD7b0WaIaJHEue5EQ3nFzZAVkfmPfUj+sn62eMFykveB8nRsV21O2W9R3zd8FOBdW5r23IB8GYfbo+4QUICEvBaxkE4PnsfP7ffXZWE0vxbYWjgJssuG988Nw5mvm2Y02Npw7H6TLAHU+1a8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109250; c=relaxed/simple;
	bh=pCZ2C+kMHbXzK6Y2YjAqrnO0L2JdukaOFK3MX4dKZ9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhwJuWV7KzPMSnyEYlykVUjLLXRtLHz2L+PeaH+bNzlGiXP9NnFfKzPsS3cF8ylWqiNgj7W40SlArWb2coVzpuVnMOF0OMK64u0dNlkdplUtLpyob6MX8HFM6DTJ9LRaZhFszE7CI3oWN88dWwLG8QQxykIJLh3+ofyG2WvLHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=tPcfj+ty; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lm2lDT5y; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="tPcfj+ty";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lm2lDT5y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 39F921D000E3;
	Tue,  3 Feb 2026 04:00:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 04:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109248; x=
	1770195648; bh=2SS4qdV4seVZmo9WT1QHI3LHa2NO7Xe61ujySrFOKLw=; b=t
	Pcfj+tymoCan99HfCVOBi3Dj0CU6a5tirYpVZ2AGVcXvqJERr1af8BFsrMFfexle
	OE2IZyrcCQ0NS0CUEIj4SirEpC3yXs93uG1D32O1T7cHuPgPF1hsraefm5H1ItQA
	6kDAzb1luy9QvG6+h4lf+zGQ6CLF7SA3iIrCqIsc2NKkXaMQilqBDSsXUnegHwH+
	yxTxAg9rRHO0SPPjfl/EhJfqH0/ARtNNoz9Z7n/j5KyyGBTdan0vf7rPbgDEqp8x
	YC3RckPkcBXnwd94BYLdvfhq+mjuVG9E87Rro45pZw9abR6KHhMLi0mCiL0YuBn5
	H3WwXgYqEsk9QhmYRB53w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109248; x=1770195648; bh=2
	SS4qdV4seVZmo9WT1QHI3LHa2NO7Xe61ujySrFOKLw=; b=Lm2lDT5yTbaAFsJQp
	cLQ5RhMFUTcSCGDCRZex8rAAXe3bRAp30bKPwz1nfMQvehEFhbqq5ALZMGUsPpXm
	AXktN/zKHeMPYaOxrraJGFGsOvegwZzJS7Pmhf5I7dWlOl+KuHRcIJJKFfW2Gr/9
	K0HxzwpaoT3CUo/30xj2/JHCaGBZP5dlSeQs01H6cpNXcTyZRriCDUp6MuS0JW0w
	KqAoa/r4fpFlVP9/EIuGu0XpnPYXtTfiCbkTEVhXvO0SdQpT+wbPHP615QzVx2Gf
	Jk1AzvqvsWPcegHsFqb/yu0v5QoUFUBlVvDJH+jM3zqnPqGLUrga9iQBlhO1D9Ri
	+PCtw==
X-ME-Sender: <xms:P7mBafJvjT1pSYBA6Ds6TysNzEESBPg4zs3F46vYQ4VGOhFnVqCEeg>
    <xme:P7mBaZiUTqkQHJzdW7xM8IJ9w_zoRbNv_UNDUxCau4qWo1yGVCbiBJ3iGYIX1tM_y
    0uJDSnEoHo9Qk9U1kTm18BM5p21iwSTraFqUzVltOxv64cUreFiG1k>
X-ME-Received: <xmr:P7mBaT_2BfkxdQrH2MwbTif1xSVQiueRau-AszTWYKGFxFvdO9cV7ojl0Ft0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:P7mBaWMSSGyWPjN91UnSgJuwhoi25HKLjUtuMWFk7oO1-hLyG4bY4g>
    <xmx:P7mBafDQYkHplKVddbcCNYFBTgnB3K8ds4pGFi27puLnFaLAEa6B0A>
    <xmx:P7mBaSPitGnnRb7heRoxA8qfXt30sTgx1NUF2EBzt_RXktW3YoTVaw>
    <xmx:P7mBaeedYdHUy4a3GOQB6YeWWe_oNGg_wGq-G5dpjdHhOTnY7yzaDw>
    <xmx:QLmBaZkIU4ktdq0SS0Zwfkh0b9LEtP3G611dX5K-HDmBMA_gMEzAPOHE>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:00:47 -0500 (EST)
From: Alice Mikityanska <alice.projects@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v4 04/12] net/ipv6: Remove jumbo_remove step from TX path
Date: Tue,  3 Feb 2026 10:59:34 +0200
Message-ID: <20260203085942.2477583-5-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203085942.2477583-1-alice.projects@fastmail.im>
References: <20260203085942.2477583-1-alice.projects@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the GSO TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c         | 6 ++----
 net/ipv6/ip6_offload.c | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 43de5af0d6ec..ac6bcb2a0784 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3813,8 +3813,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
 	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
 	    skb_transport_header_was_set(skb) &&
-	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-	    !ipv6_has_hopopt_jumbo(skb))
+	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3917,8 +3916,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index c44bb5812484..bd7f780e37a5 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -94,7 +94,7 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct ipv6hdr *ipv6h;
 	const struct net_offload *ops;
-	int proto, err;
+	int proto;
 	struct frag_hdr *fptr;
 	unsigned int payload_len;
 	u8 *prevhdr;
@@ -104,9 +104,6 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
-	err = ipv6_hopopt_jumbo_remove(skb);
-	if (err)
-		return ERR_PTR(err);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.52.0

