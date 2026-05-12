Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BBA3D9680
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605104; cv=none; b=a+D0tJ0Cgbq96txXooX8priInahql/iGAo2xnwSUvnlNjMPDuOyg/3cB9Fy/V2I9RRHYjJMeQaZXy/WX528Vmq8CUaprLhNdc17ziyqnhaw+3H5BCQbvwJCR0DE6f/kYeb8uIe7sBHOk4WFD5pgWVYlwvdvOBRKQmNwqAkSCj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605104; c=relaxed/simple;
	bh=NfyjXcXPVZPF7w6Bcme5G+ASurpWWQTb1BYBNJKEMuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLdwRLKQx5IlGHrxPgLaz5ZP/tCzRgptYKI0SSpup0U2hDGw7b3Po9I22IiY8RKXWnhLNeAfi4C0xy3UETf53So/5p7AYHLDvH3OGkZZ9/w6iMQrwyBSWKg81LltwYT6AuT4huCedb0e0p2bzJpr8leVRjQi1jUY28XrEXLGoK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=UHm4qtTU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uU09qoGv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="UHm4qtTU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uU09qoGv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58437140018A;
	Tue, 12 May 2026 12:58:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 12 May 2026 12:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778605102; x=
	1778691502; bh=q45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=U
	Hm4qtTUXQAVGHzD8A2KFncLwKVZKbyrMqYIQpNP0m3fzVxiXRPr6G0Wv5Wfc2ysd
	OFZ9/dz2JX81RrYzcPQhzmatVICTT4hnHrbJ8Z/iamtNKqbAD3T8o+FzhaVVcuQO
	8GYJYBA3ZA1ojAs2U6fp1Xw+mylKb/Mm4DdscQUM9XFQEJgF/quNMo9c5KhLMebI
	2Ei462B4rdZrLKMgdxSlokELBpsbDvGhuu2onrnCas/ljUT+GG8uwpKhQjN/fcsI
	olk10WQo9jD9jRnMCWLz+s2zKoEokFi8wZFC0km8SVbZRnOKM5vqzlAz5FsCS7pV
	f0mDpTEKrMzjvRYFjEPxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778605102; x=1778691502; bh=q
	45lDLMJsqLmY/ucK1IYEGTdKCA/4/17rWNxl6f9Ca0=; b=uU09qoGvnJyY1kHNE
	tFAEKZlVqv+XTrui0EC6A1zUsfOU+6/2HGrZAThQIySAV2nidKa3bKtPab1iOpLo
	llfBZ6hHeweoO8ccD7TKWh8JvzEGWZNEbpPMf1J2KEra+TjAG8v9/a/5I8QiM/hK
	NlYCCB8bI6IB3RHmot71bQPWaBW+7/AkqKj3pNrRgS458w8q12EMysB2VPmcVLyl
	/tuzv/A2KmtSo8aRZ9l4g3DEJRGUw/DLRFyjRxFDne7lMQdXQTjvRiSWw/rWjr/H
	wLYKTOVN2Yq5LcFDe5BbOhCo4SEKfNzfx9ZfAUtUGYbNgM8urpmVv3IA3zipB/Qx
	jYK8A==
X-ME-Sender: <xms:LlwDauBnFoYdFbIMiccUpbEMlN2ROHYsDa_lKCZZ77Pg9-HOeCyYlA>
    <xme:LlwDanC44xqL1Oj-9adGZrCMAbNeNzc60igMKnNVOE24QEaiS0cWIYKbfToHzW7b4
    aITonG2sU21WykxM_8VLdp5WqDfKj1QXIqKMrvNo9yKDP8Ps9NdfpY>
X-ME-Received: <xmr:LlwDaoZD5qffUmn6Wq_k-XfG7pctlhQT33qTk2RcESzHWspvQ4vXyj2UTI88NIupgPTGD25X6Ls-0LKXpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LlwDasxvo6JYUoJQ_flY4zDTyKderIFZ7_xAEK7zR1z2yoRSiX4IOg>
    <xmx:LlwDarcfF94p5U1SHcRksXpwBJVanT5lGVbfYPVh9QwNBcugAo2_lg>
    <xmx:LlwDaiJpQ4Gj22bWJWvwE-b-fqaoT5xpHYQgNg6gCfwwIr7dIea8pA>
    <xmx:LlwDak1VLeATjUURvWoJMmV9p-1t1fKGVX9fP5jPuUIyrKAoxYIH7w>
    <xmx:LlwDat98KR8qc7lIS5OO0OYjCUOs-SWKhSct3ViRUNytkcBkheifiK64>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:58:21 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v4 09/12] udp: Set length in UDP header to 0 for big GSO packets
Date: Tue, 12 May 2026 18:56:45 +0200
Message-ID: <20260512165648.386518-10-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512165648.386518-1-alice.kernel@fastmail.im>
References: <20260512165648.386518-1-alice.kernel@fastmail.im>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_tunnel_core.c | 2 +-
 net/ipv6/ip6_udp_tunnel.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 0fccb38f074d..a128fe85620d 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -178,7 +178,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	uh->dest = dst_port;
 	uh->source = src_port;
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index dcff7fb16ff6..32525a051a6f 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	uh->dest = dst_port;
 	uh->source = src_port;
 
-	udp_set_len_short(uh, skb->len);
+	udp_set_len(uh, skb->len);
 
 	skb_dst_set(skb, dst);
 
-- 
2.54.0

