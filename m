Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23341302CD5
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060258; cv=none; b=o+tS5jY/LuhsgNhXyT5p+WnovHG2KxXSh2rX1i1Jpkf5OkJ32Ds2hoOnYYoXQAIwK5++hIcxYCmvokCBAI4SOsOYbOr0nXeXY3w8hl2uuk2OUVvNqzfH3fFMSwI7/6pfcxE0lQOQxRu0VhZL0yq9b8/zHVdVFXAGdlWmc010nls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060258; c=relaxed/simple;
	bh=j5C7SxM5T72+3FenrxCIKD4/InDcjM9KjDwKJS/jcLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXmQmGfrTd0R50Hq7pYEFgcPWlQBYYaKxdu7KUUJ6b795Ng+VqPA3/pUKilNYRxJgOX7dVLIWeAcTPh2PribfbsMj2umJf2Va6z41tauAhfDfBRe15T7dCX+v4ahdCtIzqNm3R8333ngsMROK9ujz1Cz0ZokQdZxR9dF86KxA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=q+liLqcc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MswILAnf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="q+liLqcc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MswILAnf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34E3E7A00CB;
	Mon,  2 Feb 2026 14:24:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 14:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060256; x=
	1770146656; bh=OFBcL9Dcd9RmdRdjFm3klJq47sr4memqh7zO+7CMzpY=; b=q
	+liLqccocHvAMP1U25Faw0tqZBjq/nl/sQAe2Z2Rx2VongQ+tWXoMk4X6WpfUARr
	v/L8WhL2FCeKM7Wq65Qs76lhCJU1m0oxBzF8jU5JWhUNqkGjX7x8Ki7kAak92S6s
	xetHEoeKUlI7HzCqSl/cevpLj42/RX+SrmiazAaQvp3KUmozyDTyf3e4f0OMm8rm
	mYYIBrcIZjDckZXsJh+8T+AFGBYCWd3bx6jYvb5k9Oa2AnXzuGDgO3bMSH2vW9ub
	KrNZrC1oONYye+dFCbUQ2HyQAulVxX3S/OSAZ9K/erzBz8Vb0Dn6bL3esS2ZusfX
	YJ4OU9JNT62sOlwni2ILQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060256; x=1770146656; bh=O
	FBcL9Dcd9RmdRdjFm3klJq47sr4memqh7zO+7CMzpY=; b=MswILAnfMwBPyVEf5
	aqGKEAnIudIvS6djJ64CEgR6XufYYAcWkPAuzP2bR26dCWizttEsmtCZrZQ32Cog
	WQ7v3DEuheQQGq+5ElFK/EwGChzSdHMKqxV91uebTj7Q0O9/BzDyLAPN4+21KzRJ
	Tsz+85qmukCgSipB9fLZSHpxE78fTbQmNd6FahJlKMNuIJ0Xr83078AWusEAMyps
	FpR9ijLTr2tByVjGyPB3A8RN0NqzyDyM50HRzwlI64+M4O3ZX+zmLF93t8wIWY+P
	qZPMdxskLKQ8TYRM6Bz5Muv8E4/8/VuK0jIHM5I0afMIh9MwtXml1xtfEaaCJdnA
	cECIw==
X-ME-Sender: <xms:3_mAaXFzdUx1n8ewyfdLDCmCigg-k3YOyAc7MTgZkW_U-w2BLsmcqQ>
    <xme:3_mAaasrUNAb7ORG7XEXN-CjlTUhZYKYS2UpZXMG2J5hXW-ECzDwblafpmt5rA5Bi
    gIOcMkGLUdoSBWwwaXw4aSCPHGfiyKL7aQVlb2PjrMA2b5oXK8BfHA>
X-ME-Received: <xmr:3_mAaVZb8sEVp7WnXrN1jBQBnbMJoU0q4zQZoV0CTTaS1oxgQYkfho-CWmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:4PmAaS7H9X5E5Onzqd2uDB5wn1DwxczDOBNqnOqZ-Pa-keNWHovMsw>
    <xmx:4PmAaV8t6_q4qGe_2lUZrV-alLMDSadj9DrsjxOt-oTy0ehEvTOj8g>
    <xmx:4PmAaWb3I2QGc0ZIxKuGDjz4TiXxgEDtY6dUkogGo3dR359Lhhh9Ew>
    <xmx:4PmAaW7di_MT46mRptUoIOu0QzhTIZYOl1PuUpJZZz8eCz9-cMXotA>
    <xmx:4PmAabwmZeeYfPK5zb7sSdG5c_WF1094fnbNXijAxhw4fnCcVcLt6r8y>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:15 -0500 (EST)
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
Subject: [PATCH net-next v3 08/11] bnxt_en: Remove jumbo_remove step from TX path
Date: Mon,  2 Feb 2026 21:23:35 +0200
Message-ID: <20260202192338.2373930-9-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202192338.2373930-1-alice.projects@fastmail.im>
References: <20260202192338.2373930-1-alice.projects@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the bnxt_en TX path, that used to check and
remove HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 466e0fc6141f..7d63d6b0d2c2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -517,9 +517,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_free;
-
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -13881,7 +13878,6 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 			      u8 **nextp)
 {
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(skb->data + nw_off);
-	struct hop_jumbo_hdr *jhdr;
 	int hdr_count = 0;
 	u8 *nexthdr;
 	int start;
@@ -13910,24 +13906,7 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 		if (hdrlen > 64)
 			return false;
 
-		/* The ext header may be a hop-by-hop header inserted for
-		 * big TCP purposes. This will be removed before sending
-		 * from NIC, so do not count it.
-		 */
-		if (*nexthdr == NEXTHDR_HOP) {
-			if (likely(skb->len <= GRO_LEGACY_MAX_SIZE))
-				goto increment_hdr;
-
-			jhdr = (struct hop_jumbo_hdr *)hp;
-			if (jhdr->tlv_type != IPV6_TLV_JUMBO || jhdr->hdrlen != 0 ||
-			    jhdr->nexthdr != IPPROTO_TCP)
-				goto increment_hdr;
-
-			goto next_hdr;
-		}
-increment_hdr:
 		hdr_count++;
-next_hdr:
 		nexthdr = &hp->nexthdr;
 		start += hdrlen;
 	}
-- 
2.52.0

