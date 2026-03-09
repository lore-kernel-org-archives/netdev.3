Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A33921C3
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052387; cv=none; b=VfyNUI7gOtuBHww7hJUjmU3ProwsmMkNygNXkw4DrsdgMHYBSOuVse9cEv4+kHl49/vA+/YJUBvFDsaAmlLvjj5BgytzuQr91hEFYH46k7C1/ixtolSZ1gCDn4zTmAT5jPR4F+4Pp5wY3JGslmdgM0+PWyXPnnfq8TKztvJG7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052387; c=relaxed/simple;
	bh=HZemARvk0n6miPzLzcOHnKjocT7FsiW1Wo0KnwiJvkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnZAmvymF1EPpApvP5eT0I3GAdIy6fnCqUV93rjcfBTv5O468hvbDFbG4u/hTDCsqKN9OQYmvyj703z6zPfmd8Ry0ntg1PRnI797lG/17bGM3PReOpQKyjw088t87bREWPBSoGXXdeDu6WNN1q5ogcjGWMVkAQIdK/ThYXoh/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=rk39954B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wwp4J2Aq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="rk39954B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wwp4J2Aq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FE987A0164;
	Mon,  9 Mar 2026 06:33:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 06:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052385; x=
	1773138785; bh=7VQZmWrKQIMWeDx6i+lq447FrlF/h+9vTCQmxYcsz1g=; b=r
	k39954Bnq4dd0fwNTJUfyrKHf8nXTLcOW0f5DdV7TnPXcImx0Z2kgfRkHPIH8w4u
	gmnOqwDjo+ixSNvjLDX3tNiyDHaMLsF8bq5wtlC+EbLGMkpp3+DiCVGU/Vo0ch0X
	lHA1BpFAoolWDU0lmPzUA+H5bEYPa9qixTVi/qt03/Ie7zdBNI6OzLOz1J5CnbbM
	NyloHR1vr5HZ8VAxkpbM9QZ6xOXy12CKWXiEkRK53mgRAK+zRwAMln1Lk+oJGKlR
	N4VR0a0714TDFPSqOUAnsBrVNPhua4T0QF7kpE8rL11CUcIOMfQXX6hCCMIBzONd
	IXdFrwyjjs8NT0PHGtnnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052385; x=1773138785; bh=7
	VQZmWrKQIMWeDx6i+lq447FrlF/h+9vTCQmxYcsz1g=; b=wwp4J2AqmUp6yQ8TA
	mGFMKX9aDAq5PoRMkrckC+yzIg8n1xwh1d41GG5c2Hn3TBvLvnALyb7ImXwNTi/b
	UzIgZOeY5V5K79FlZPofZDSf5gaauaykm2z+IYA2ZmBipJXZ4A83QFsOZ1aqVSaF
	e5xEiyBl9rJESouTgPnJVLY0+dEJTO9eZlXREe2Z0WPpmKY8dgeBdX84ATySKXd2
	0lrVeLrmVYRjZNFfmvdHX8MxuL/BRjpBtTF4ctkpV9+/zheOWv4lBnAzmzow4NYP
	cLlR748ITrktywgnILjWgAEz0uov/edR8kJOCl75plYkgsvAtGTQ9Ot5g2AL/p4F
	avrZQ==
X-ME-Sender: <xms:4aGuaWg6RM_itcWzpydAtxwSiJwTGDaxo-QMxypqV3EyEGeBvDzNXA>
    <xme:4aGuaSec_OJyIvuV3Bd96-uKmcFJcnqmfueUG7dV6AvTYu494R7qGnSAJvp4xIHUm
    jTxoqhDjHIyMqHFwg8r8s8wx-tZr_uZOP4MfS2w9ytWMlJKppSGXQ>
X-ME-Received: <xmr:4aGuaRmauOdZgjdWCo55B5chO8dt2H5sRYYFBPQ9g4X6m7LrKqg3Ccmi5b1y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdroh
    hrghdrrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:4aGuaTv5RFzd3d8HAXsXPHmvYzK7qQfHEBAwc5qO7yOHpdKxwKWUNA>
    <xmx:4aGuaf-yv9Cvg8gnQUX67F_mi69ZGYCNRYEC-6-2cp7gRIE4HLrjWw>
    <xmx:4aGuadN6JcfVyPqONGMTBd8is8FdvCk0uoyhStzHy3XMiP14Jr59FA>
    <xmx:4aGuadGa6OARxRDqp8HV6KgGAjiBbd-WpKzba2OkwIt2LRExOJLGfQ>
    <xmx:4aGuaaR0w6EH-RlSOEuFqMy2Ol_0Wlu7ycRAPsNpki_kxeMQrM-U3bpn>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:33:05 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 05/10] xfrm: remove rcu/state_hold from xfrm_state_lookup_spi_proto
Date: Mon,  9 Mar 2026 11:32:38 +0100
Message-ID: <bbe15a10c2bc537f71906bdee0bc8c1c0242ac9c.1773051558.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_state_lookup_spi_proto is called under xfrm_state_lock by
xfrm_alloc_spi, no need to take a reference on the state and pretend
to be under RCU.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c234431e1967..ff421fb73df5 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1703,18 +1703,12 @@ static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 sp
 	struct xfrm_state *x;
 	unsigned int i;
 
-	rcu_read_lock();
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		hlist_for_each_entry_rcu(x, &net->xfrm.state_byspi[i], byspi) {
-			if (x->id.spi == spi && x->id.proto == proto) {
-				if (!xfrm_state_hold_rcu(x))
-					continue;
-				rcu_read_unlock();
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_byspi, net) + i, byspi) {
+			if (x->id.spi == spi && x->id.proto == proto)
 				return x;
-			}
 		}
 	}
-	rcu_read_unlock();
 	return NULL;
 }
 
@@ -2615,7 +2609,6 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 			err = 0;
 			goto unlock;
 		}
-		xfrm_state_put(x0);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
 next:
-- 
2.51.2

