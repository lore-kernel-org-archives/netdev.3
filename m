Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4337D131
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887930; cv=none; b=dNSJ/OQHjVvFDQiMH1YZ+y8qLKoOLkHA6qXgwIzY8vMLX478xS2p3uM4KIEnl4r264m2l7nYZmXePVmGlytunxVF0y37czr83iKBd0FdWJF4kPit7Mt85U6D1X4HxOoGDVuyc5NQJlCIrrsW31pNJYps5q6z7trhgjPhU+wUo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887930; c=relaxed/simple;
	bh=SqejiicPd7AIHhFb5cjk7ILDTFURgwz3KgrK0dGiA0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3zE2l9W1siCUcfVn4Qp2wncA/y5K903F5pF5VmnAt+vAYQ9Zl9JQgP327nfoobE+OAAlF9zff7hAdnDbcM+ck4LIFKQFLOi6chtFQcGPoL0knXYL9GvhHefJBN4IhSYvaFHXB3LFEufFL504+I1oIsSQetzQX4P25SawbsHckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=SLWIKO2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VR5nN1Fc; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="SLWIKO2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VR5nN1Fc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E5DE7A0061;
	Mon, 23 Feb 2026 18:05:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 18:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771887927; x=
	1771974327; bh=Y4LQhFMzlRdN6Kiy7RCWFM3STqimrQtTeO6gLow7n+g=; b=S
	LWIKO2G15cLfPTnTYiXYBCznY6O15mPqklVPd+qIjGkVS7TPm83GemHNrvspflHB
	wTCgC4tdjlhvLMHnupV6XKbtAntoFm8g5WWuuW6S2JvZakwrvQBI2/tEz6avjyHI
	6MkyndX4hmHCoJPAbkxjdER8H52qyuF0+adXasJeoKzCVHIMuhj83t2PWfuAiIUb
	zXxSoD3PjodCbvn3CvP7Xurke1ZyvdkOnz+Vr8i/BZEKYO1t+YMxAoyoWWLmuGnA
	y0cGrBJuRUQO8Rky5Aj8G4vPPsOpR6EkFVv2d9+5Nkn7bZUgN9eV8/0mmY9wtm8g
	ZeQKv7JtP7qfATnEyi1nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771887927; x=1771974327; bh=Y
	4LQhFMzlRdN6Kiy7RCWFM3STqimrQtTeO6gLow7n+g=; b=VR5nN1FcjDcoeKQa/
	OE42XyF9/jm9HQwkuNjcpsQlL9Nny+UJFhszNSb/pEmEQ+u2/omjwtxc9EtB4/vf
	qwlsaJy4YdPDMqH5fkiMf7R50JVQ/BYpVnm2V+rfGe2MUE8pr4JDYhmavvN3aDnZ
	U4J5ON7mvTjmxnjjP0E27/gWYODwEGvw+Kb2GQIpqSyQSFWfZaYozy9zrdtC8hS3
	ph2eI7T3LNCL8hdiWc0F901wEA799/BlAeXyii2NxHC6pb9waEf3l6t8WvByCY+B
	141ZZ9wB8mBzaXoqrKqU2MIoh21y4Zo+lXE09TIsyPjq7pE43BuNSn4apF3ZL76d
	vDtZA==
X-ME-Sender: <xms:N92caYwbcsxUaRePql-SWIw2ACFnDBOCksMrU6ecZilDcefgAVEtdQ>
    <xme:N92caXvQ-6yNAUd1W3K2NPR03BhggGhvMSo6iQkaSFNtztsjaDteMzm9dMXXseqS8
    tADGx0uGoI2yFCJjMYMIJK7KqLprKNbgtadVBLoBY174oUmpZ3xy-M>
X-ME-Received: <xmr:N92cad1Z1Uewv8_vSZgrelNmpT3XutEowpcW7HZAb41AhCxFdt7tdOJgVIhJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekhedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:N92caa-3fN3rhU8rkUdpYUYb4lSSIY0DuO86VyzFSBHFr10C71LaHQ>
    <xmx:N92caWMCiBVGn8PXtzauDmlAEtWsiWJVIepSb8FoMViy0qavxNySpw>
    <xmx:N92caWcg8-_F9T-2ljSB1ZxA1tAIvfcWQ2ZNQLoyqlk8s0e2PwMJag>
    <xmx:N92cadUSq_8Nh_kDHp1t_Yk4jl2FrcPpzVoXjNw7K5Ry6hARPRrvNw>
    <xmx:N92caXHbmoCMzFOAlylAqWCqMHWXawbydn7mGfV0LJi0RoXlXouTQEYw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 18:05:26 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 2/4] xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
Date: Tue, 24 Feb 2026 00:05:12 +0100
Message-ID: <475856d2b60e1e14660756a381a0a0abd7bf372f.1771876412.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1771876412.git.sd@queasysnail.net>
References: <cover.1771876412.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcpu_num = 0 is a valid value. The marker for "unset pcpu_num" which
makes copy_to_user_state_extra not add the XFRMA_SA_PCPU attribute is
UINT_MAX.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 3e6477c6082e..4dd8341225bc 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3676,7 +3676,7 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	}
 	if (x->if_id)
 		l += nla_total_size(sizeof(x->if_id));
-	if (x->pcpu_num)
+	if (x->pcpu_num != UINT_MAX)
 		l += nla_total_size(sizeof(x->pcpu_num));
 
 	/* Must count x->lastused as it may become non-zero behind our back. */
-- 
2.51.2

