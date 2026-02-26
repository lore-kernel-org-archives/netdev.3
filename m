Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D344E03D
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137009; cv=none; b=OMEEFK+DyqGUDmQAYQ9Kjn+PUcWU4edFJ2J68H8tiyil32gxASOWlSOEg2WfiX143wL8c9mIAU2mceiVFxo7DRtEq8Z5w4nIDEfNohpFJXM1CjmjLQ6+c06z3nQN2pQowLg4WQT22fy5Yt6wFTsAgHHe3o9qdnhostS+Cz+D11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137009; c=relaxed/simple;
	bh=XgkZDS+Ik2fOY0z92R5xnzLzip2q9tSgmFoa/o1Rscg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJstLY8dsIhYqtVxRkSQN8rRi9QAS2FTenyMUHRNu4BtMTOzSPP9KEWG7QDo2osyBM5ObTad0qTmr70dHyBh4b+jMUfNxjG4bLC2jfOY++Um6A9+XEsFBrAAD9l5D7dMcgTRg62uBnKT8MVH/xiK91caY9pH7/9Wtvzfn0+S9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=qTEds0RH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8xNsZjS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="qTEds0RH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8xNsZjS"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13A027A00E9;
	Thu, 26 Feb 2026 15:16:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 26 Feb 2026 15:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772137005; x=
	1772223405; bh=mwDMsd1RTWwJlwDmDwN4i+Lo0zEnQJu5RBcYFTqBS5A=; b=q
	TEds0RHiI/m21/Y7MBhxC7t0HO0r5Dc6XIUX8Ft/wmh1gY/ITeHoW3AqpqdXmLIP
	nx5tPc19pqKmEEA8qCPEgcTeA5qOC5HZlTpMafDHFlY3cVxkW391rIyYosLdnFs0
	utx8VkNU4958gQ77UxCKk9yNRMFJHvbxXS9vpxBYzpnMgoveUQb2XajHRIo5rYO4
	iHzSEAuxZcLZ+3qBAcIMWG67tIv6J1nxmV0lzRq9A4lNV5FsKOMGKvQWs1FZ9Lz0
	lBDlRC6Pr+okiyhMB7DOxV/1jLP08Jg3Zt1UL5gH8pUIxzGV2qd4bG3F95fVk3PD
	ZLNExdfmttMdwQmFWT8jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772137005; x=1772223405; bh=m
	wDMsd1RTWwJlwDmDwN4i+Lo0zEnQJu5RBcYFTqBS5A=; b=e8xNsZjSivyPhrrts
	j5SwzfLbYnubKjsMHqOFKMF/dTTgKfOA9fyWYar6o2n4sbNnYy71dnL+z8UiGesI
	SjL1fNYeYXhbERRgQ6OtccI+Gd0OLUXh9Hjg+tgsH7zNxdQ0nQWY6KF5RA+Peoyx
	VIQoP6DPUeQXt9HwKfukps9YwEkXfK8lDFHFEbIQBim3VgDiVWd++5CTZuODpBzP
	iXEOZWisxSWysWMsqEeYzHhle0jz7rCcaKQPCmirngRR2TMDML4VuTRcLOEaK9XC
	fkae69Asg16f5/b/FeyTmA8tBn23LHGUXUXpQrcYPVartvfGFY2BE7I124/uXDNo
	iwXTw==
X-ME-Sender: <xms:LaqgaUqRHtQenDymz25krWiMo4t2WPjqVGOH-Wimx3cK7zP_9sbT-A>
    <xme:LaqgabHLbhd8ExaVM4T3zj14HAPBL-FNscal3BBngVOCFHFOZptdZDkkmo2Pf7zJB
    EYpYKW5T0y6hj8kgByTC8RRivroGXA1w6OLt9wqzmil84bVTNmO9C8>
X-ME-Received: <xmr:LaqgaY8wPSvQvsb0dPxEnRNRt0lZ3ChWD0sY3xxYetbtqExVh06kWEW9TCbCug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:LaqgaYT2E38giSfiG7ziirozB6byqKoqqU29nPjujsjhZzYwpRsppg>
    <xmx:LaqgadqYVd-aWt7I6ewl7lOEQVWvhGI7KCJiHxKYIcJoZ0soFZNLDA>
    <xmx:LaqgaVNQcaf_0HguL-qxVJMvkNlG-h-F1DfNTO3ww3ViQe3iVT6r0w>
    <xmx:LaqgaTxNPzR2qKvD0684nJwSqdBwzS4swDm1itcUWnUyr82sYCLrLA>
    <xmx:LaqgaQBUiYflEoJYaVBZCbEOwx2p_1xR363f_Q8IwovNB0Kp00G2QLT7>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:16:44 -0500 (EST)
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
Subject: [PATCH net-next v2 03/12] geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
Date: Thu, 26 Feb 2026 22:15:51 +0200
Message-ID: <20260226201600.222044-4-alice.kernel@fastmail.im>
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

GRO_LEGACY_MAX_SIZE = 65536; total_len being 65536 is too big to fit
into a u16. As can be seen in skb_gro_receive, packets bigger or equal
to gro_max_size (or GRO_LEGACY_MAX_SIZE) are dropped with -E2BIG. Apply
the same boundary to geneve_post_decap_hint to avoid writing 65536 to a
16-bit iph->tot_len field with an overflow.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 01cdd06102e0..7a26e2439d48 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -604,7 +604,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
 	iph = (struct iphdr *)ipv6h;
 	total_len = skb->len - gro_hint->nested_nh_offset;
-	if (total_len > GRO_LEGACY_MAX_SIZE)
+	if (total_len >= GRO_LEGACY_MAX_SIZE)
 		return -E2BIG;
 
 	/*
-- 
2.52.0

