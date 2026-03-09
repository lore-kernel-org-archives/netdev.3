Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261FE3921FC
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052394; cv=none; b=cvjn2lgrAteTcvj2HqMpDrb1Mt27XMyrO/1tyPPKQo3yE5HmpqLJt0lnUO0MKyByW9jmqg+8IoFrAwjKza0mbDICbs7zW1NnXzjdUPld+cSUYeONl4xRFssHXlY+0d8xqbVwGHvztITHOBMhdIsdwIlKBGz0qxGWbkxTeHhcCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052394; c=relaxed/simple;
	bh=gsB9yX8j17ytVJjJhgvw3Ghj0LgBVarto4urqj8KL4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAyV6Qp/8o88h1QHKlWfEwoTVx9RZcVIY8vva3cH6krkZaMOAG9JU/eK6vMizVnRWrYjKQda+hSrr+zYYH1pxg4oglpo6jxgJjkihHiGhkoGtUkQzKZWePbg9Q/0blBcOs6+wyp6PWuw9cnfZEsDrGxnDogmphPgIe9L2ctbjtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Xo0VJ4Nv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4W7CX9z; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Xo0VJ4Nv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4W7CX9z"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D7EA7A014A;
	Mon,  9 Mar 2026 06:33:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 06:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052392; x=
	1773138792; bh=OjlgWjSs/e2vwI2nwFI/mwv/XhX14LFAvnFnYVBijrU=; b=X
	o0VJ4Nv7MWqlSS+znU6ufu9xhDTBz7VfqTKQyiSYyvBiMr9GopRJpZEf/HHQDT6N
	Tzw4QxzXGrP+UKMfZR+qS5KI3DlNnpqGv4dnc1nuRk2MyE70oe/c8ZilnsWO25XF
	qVOCBIO8MTsgNTE21RNHqpmpeHm850HT63Vux5d2ueU7ZGXO8Ti3r6dG8mbyR1bY
	gW8fagAc2LzFPcixKsrcfUku4cbZl4wx3q9toOcM6CAkX0Y7CqNXh3fJ8T7srPWm
	nROZo825eaCsRLAxm4RRhv7NpvlIaJmB3MOq/qwaV1BBM5hgMyAD9Kp9jTIyS66d
	vwu6l9x7xr5SZY8BhigOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052392; x=1773138792; bh=O
	jlgWjSs/e2vwI2nwFI/mwv/XhX14LFAvnFnYVBijrU=; b=A4W7CX9zoeB9UyxTZ
	VK7jmyJe0KYoGmsBYXsrYFUQ0wzNCOTNIbtDBt18PW+SBf/nHRuakKBsxx6lsSAQ
	he29QcYQRJVC+qvR8a+Q2UkQ4QGSHdFxJxibQH3F3xrdv6fIsozEcSlR42D2hr+i
	A9M4o7K1hru8bXytdFtKCmZfd6u84l4kIAozju68oVXNu0MDMjFDLTIK9f9pK5Qo
	MOdJuFb6U/SZclECOueVackHKLmc2UKoBU97lBvdFCIfIo16OpXlRWJ5pFiy3EGG
	cFzPP+dQRveKVYl1aAlg/Qfp6YqzRDnGsAPAKlEyrZvrL2ZEW9pcCtdcNf2El7N0
	ZrsuA==
X-ME-Sender: <xms:6KGuaTlgsM1PUcBflu9MPtAy245LhnvBuxwujd9ugYb9r3X3Th9EKw>
    <xme:6KGuaSR8rntv9D4iGsNnZLEG2dCB44i8fpJx5c_OHw2eMDtBEg8qHoazEeiVUlM0I
    lUrhJX4TLUX3kL0cQjitQf7yT7GFvZt4qI2EV-nJIGPuQLVpb3lyA>
X-ME-Received: <xmr:6KGuadJG7p0CWM9Dx1u1hY0LJtHSYGEJevUqnDq9t1TNQviB26ykm-tOhe-K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdroh
    hrghdrrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:6KGuaQC62dKhlJtmKBe0G7Q08csEyc_E7IJ0EAm6jxdFT0j6JMF1fg>
    <xmx:6KGuaeDE4n6o2MsyaeYwVXEgLVPSJxsquQawyPiYOv8llqUwFUYQkA>
    <xmx:6KGuaaA9kAcXMXoZ1M_PFD2u9UxN-V7fZclGhEjIV7GWsQnbIyE6_A>
    <xmx:6KGuaRq6XZTmlqBfVGPaUW11jIagPqgWj_F9jbbd66yWd-9PixrvEQ>
    <xmx:6KGuacbvLQWAbyZUTjMjHuCOKl2yZQ0tAj31TzLPuE_nqvZl3Zx8zCHG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:33:11 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 08/10] xfrm: policy: silence sparse warning in xfrm_policy_unregister_afinfo
Date: Mon,  9 Mar 2026 11:32:41 +0100
Message-ID: <1e514e2d0e4d060fafd9dcb6767ba651d7bf92a6.1773051558.git.sd@queasysnail.net>
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

xfrm_policy_afinfo is __rcu, use rcu_access_pointer to silence:

net/xfrm/xfrm_policy.c:4152:43: error: incompatible types in comparison expression (different address spaces):
net/xfrm/xfrm_policy.c:4152:43:    struct xfrm_policy_afinfo const [noderef] __rcu *
net/xfrm/xfrm_policy.c:4152:43:    struct xfrm_policy_afinfo const *

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9b8d37502de3..93fb47472390 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4149,7 +4149,7 @@ void xfrm_policy_unregister_afinfo(const struct xfrm_policy_afinfo *afinfo)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(xfrm_policy_afinfo); i++) {
-		if (xfrm_policy_afinfo[i] != afinfo)
+		if (rcu_access_pointer(xfrm_policy_afinfo[i]) != afinfo)
 			continue;
 		RCU_INIT_POINTER(xfrm_policy_afinfo[i], NULL);
 		break;
-- 
2.51.2

