Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1045349B
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137027; cv=none; b=Es1bv7Z/X0sojDQDh7/z56cmePypFzAwsaiRmYvxP9590/129CrmXK2wF+uKpDF6l4ubOOwG/O5X4P+1dy900A78dK5gYxdE/8iJ31Oy3ZdoSUK82fcf4/+hxbwr1JmlEqLM4cbMbBoxcxacXzBW7WWYtP7YxDDU1xX/y8AT494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137027; c=relaxed/simple;
	bh=W2fEHKmH3KDh4S9/LSXYmTREYf0b4IFdakUFdp68+N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnymtCLMM5Yka83GP1VwSW0gSBGWfKMjTLOyl2JtYU6RI/CVGRr9yjLSmkCSF9JJhul3gkGXKMJSZ0WIfIzWOeeW9jHiBS2b/pfmWNXU45oitCwNre3v5jHbg0cVqtIZ/WkrIcULVtP2DI9JptVxRTSe644JAT0C9fbtEec/xMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=RX6qUaiJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2JbDSHS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="RX6qUaiJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2JbDSHS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 654257A0132;
	Thu, 26 Feb 2026 15:17:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 26 Feb 2026 15:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772137024; x=
	1772223424; bh=l92cUXNGqMcOBeHQGpGuY+Wt5dwCnzQRaBVnWD92Miw=; b=R
	X6qUaiJ4oX7MpYcQl+qJDIz+HhCar+WyCYUzMqg9bp3DBXl9rZj7Sd8JtmRM7EYV
	gqriV1rtNzkmcqY4n6tc//atfMY19HEVs6AUNirLKntVkTwMIwCI8pyLTgmqL+aL
	K0s0W1hzQNX/XJh60voKAYoAcbvZ86TV9Am9yOsTyxg7x0gTwA5ybpQNjnc8Q+tv
	T9meeyRiyRL9DKPT56EWcf/CllRGZMoIo8azHyzWHSSEbl2n8q4CH02nUSHCfBML
	ipAmbxxbjGTiIW4ZASH/z1ooDmRvXVk6m8snrrmGUJuMIl8AobDuiwcqcUoYcztq
	oV9rnzFbtbsbMePc3fybw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772137024; x=1772223424; bh=l
	92cUXNGqMcOBeHQGpGuY+Wt5dwCnzQRaBVnWD92Miw=; b=V2JbDSHSzx0Bt6/ov
	2CAvglHbSOuvRtXfxyIFdHciPeJ0Vkn9ClVJ1/Ul9+9dUpo/CueB4RX1XBEM/Xra
	CQyQcfviEejpKp3pwDikaE2r1keCdHooD4XN38NtRtjQNN9xD1DD/5wdXb5RX/Dx
	9grxQDVT3jct69B2uW6tvOYk+xedPB1beF1XlXo2bWLzim7hTx8PbqKo31IUwHqS
	3hD5Ptt8tOofncnrcm0W71FKXbDF3628zMf48iLyYlHDKvdR5pmHHl1TL9M8Lia7
	fMzHKaIRlcQT9irgplHG9kvh/O+MWCnZ5bMTEM4DDJnWtTy9rBF9lfuG3maX0fWb
	jN9rw==
X-ME-Sender: <xms:QKqgaSCWgiwsxvX4SUiEaXdpvj65Z-F8Oz5fOTrVTz2f5f70kE5W4A>
    <xme:QKqgadIb3sxjfIOqhuJHn-wXkAa0U1TWeL2UmiCtdmPT0Zk96amlLlrEDtkaf8U11
    KfT72z-ceeXT1GQm-nM9IcYzbtXM4-oUCm95N_IOO04fTTu5sgGZkqB>
X-ME-Received: <xmr:QKqgaQtUut-_cDy85z9ownwWuX8nQRxwwJqb4_zcSRK6yznpnuR-3yKHeQO-LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:QKqgaVW1pshXKvpDGD1d6StsBPgpW6Eu1aceCq_2TtjiMvTfYyIVhA>
    <xmx:QKqgabLy9MlTNAosaYFZXEPItSidh0tJEE2eOUGte-2HLp5DYBJ1Ow>
    <xmx:QKqgaa_JwDv1fBHzb7pfi9cbKL-LSP2hhtQJw5mlT9rgN0T3aJTkVA>
    <xmx:QKqgaZNXIzVOEpOTmJ9pFYPQPvqmFCWovrUxJYjGQj_xTwJ-4u7UTw>
    <xmx:QKqgaWAGNWq9aJtCFvStJakUGog28dYcN07yAolQZhrLTHFo-v4eu5OW>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:17:03 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v2 09/12] udp: Set length in UDP header to 0 for big GSO packets
Date: Thu, 26 Feb 2026 22:15:57 +0200
Message-ID: <20260226201600.222044-10-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226201600.222044-1-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

skb->len may be bigger than 65535 in UDP-based tunnels that have BIG TCP
enabled. If GSO aggregates packets that large, set the length in the UDP
header to 0, so that tcpdump can print such packets properly (treating
them as RFC 2675 jumbograms). Later in the pipeline, __udp_gso_segment
will set uh->len to the size of individual packets.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/ipv4/udp_tunnel_core.c | 2 +-
 net/ipv6/ip6_udp_tunnel.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 18f789d9383e..8c586dc08f3b 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -184,7 +184,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	uh->dest = dst_port;
 	uh->source = src_port;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 26b140fea7b7..b7810736d1c6 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	uh->dest = dst_port;
 	uh->source = src_port;
 
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	skb_dst_set(skb, dst);
 
-- 
2.52.0

