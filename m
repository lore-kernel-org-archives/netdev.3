Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8C175A89
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173449; cv=none; b=WdUtE9hH7DpwrNvTDy4gUnyJHL9VYCKFBzFqwLFUVhuhdmLaayCzE2CcO9qEarCeShn/VssifMjwBTiu6ZYGwOki2mjCB+qKc/pjrKGMxkyCu+OfjyaKYjKekH0STnJ5BS4WaNZCaHtBoscr3aTcfMw5k2LAGyYokfAzdrN9Blw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173449; c=relaxed/simple;
	bh=anTJiPII5Yg4ct4EO3RCj4WOVlIJMpjA2t1SBPmPrSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9L8K9f/3DxC1u+HuzSO88oNFeoXzsYc5eointNWt6TCDQw16Det2DUTaY52e929XVTVovEvweDP4lrXrUn6GBxntZ58aiz3CdJPFAKTOw4GF+UGFOx5KxPNLivC+P/4GnsMfxUyp6GuuYuWCzSTvz+d6KnNp22LHipu61P/EMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlJM6+xb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlJM6+xb"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e507b079dso1685607b3a.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785173443; x=1785778243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sdp24lKzKsYgtAHOhpuWDLOzrkhwtWwHLnrkOwUKc9k=;
        b=qlJM6+xb4XPfuLBxMfFJMTr0GFmKY7DdouKqo8d7c/r6EpBd9SyABulErhXBugxEbI
         LB5mTBeKcn9ICv1YeP0yPB+utBObt8hf/qFdlTvoCnovkKtIj81w0C70Lc3mDYb6w1Ie
         l1os+KEeK/psWdrtg2d1o+3Q7MSYiBLpENvlsKEZxh062iHW1RDRN/PB4UTNMCxJc1LG
         odj3XRYKKotzwXfjMVnd+kxMOq2bjiafpF3ty2MrBMeK1Q98Fg6DiCI0gsJRxfLlvpMH
         ZJCuJSQg8p8jFmFceDrRG+yFjdtZT6c2d6toESmURkq84SGQZN1vmJ0uY+LcFV20TOL2
         iRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173443; x=1785778243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sdp24lKzKsYgtAHOhpuWDLOzrkhwtWwHLnrkOwUKc9k=;
        b=rSVnLVeL+lVjiSMGW5AIfs8YClmJSUHkpoVmVtNvIix2L7nd6faDqsxexKA5L3hmGM
         OZYQeUkIGCorcqJIgiIiidszSn74vXhphkV7a/smYQc+gxmL61Tpearozbya6c89maLt
         6f/A7eRtZKJTulfa8NIuOFYnEKu1pBYHKivG90Ill552nvj5SU271GAF3fSZDwdrVn8g
         F5RgnI7yCj+5c5g5BnsfouoqQnIRHsaf+z8HlweGjMxMNinHum9NHrak1JBNoirukcG6
         SPMqiQ8krN8KbQ7JRVUDRqFg9Gxj4fRkYu/XJCyoer8eUTV8f/aK3/fedgaKPzBbCjQs
         NLMg==
X-Gm-Message-State: AOJu0Ywgsn5doV0jr/RR/6qQzjtcAdKlbxia+3iwf/gVEbM5DbOwS9gA
	kAyhSw7NAmM33ZJ/isv1eccR2jYQypl+gDwQ0ZlpCJcuF6fKD7/DUhd6Bcf3Ig2MKKU=
X-Gm-Gg: AR+sD102AsnG/nSIXWdmJSvTm3bDA9Rdllh+6/N+Ek50rB8aBnJCpo62wy2xCfvVH1c
	2LZLa3UMkDlHonvVYKQDr4OtyW9GYz2DQnc8qM51t6B9j5xOApnYNacK1/zT7rPZrqkKsyFjDss
	6PLFKWPS4k6GFX51IiU0ckMe6edjqx62LMV7yhGo8ZxaH/CIlLVNdRmKSTf5DoUdHft8wjEBWYw
	6QtJVcWJ68zgQks6hOxmbdSPJ3EVcf2xPz+M4kGmSB+uvf/8vBb54rUtnNuMQoS7vP3RLC9sF6g
	bPIsu/xUOYym7ZQ+Q7qRVwlELJhG8ilQacoI4B7/yBluhfnaz+fU8lBYpFwTvJwltaFmA21irpr
	cp32okiat69tT3vPVDiXG0mJCx2Ot9aolJ19QKMjhUdegs7EIW3mlYpEC1qkGjs/Yc3KXlcB9Dj
	ko9xG4VjCI6HsJDXiaCk9X
X-Received: by 2002:a05:6a00:1c87:b0:848:6a95:a9d3 with SMTP id d2e1a72fcca58-84e59564532mr7230110b3a.40.1785173442810;
        Mon, 27 Jul 2026 10:30:42 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f22fsm3372658b3a.13.2026.07.27.10.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:30:42 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	martin@strongswan.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH ipsec 1/1] xfrm: fix xfrm_state_construct() auth-trunc leak
Date: Tue, 28 Jul 2026 01:30:32 +0800
Message-ID: <49598e6a475f779e96c58a0d587790694862edf5.1784963896.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784963896.git.zihanx@nebusec.ai>
References: <cover.1784963896.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

attach_auth_trunc() can allocate x->aalg while leaving
x->props.aalgo at zero when the selected auth algorithm has no
sadb_alg_id. One real case is cmac(aes).

xfrm_state_construct() then treats !x->props.aalgo as "no auth
algorithm attached yet" and calls attach_auth(). That overwrites
x->aalg and loses the first allocation. Any later failure or teardown
only frees the replacement pointer.

Check whether x->aalg is already attached instead of inferring that
state from x->props.aalgo.

Fixes: 4447bb33f094 ("xfrm: Store aalg in xfrm_state with a user specified truncation length")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d6db63304ba6..6266a92cf302 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -940,7 +940,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	if ((err = attach_auth_trunc(&x->aalg, &x->props.aalgo,
 				     attrs[XFRMA_ALG_AUTH_TRUNC], extack)))
 		goto error;
-	if (!x->props.aalgo) {
+	if (!x->aalg) {
 		if ((err = attach_auth(&x->aalg, &x->props.aalgo,
 				       attrs[XFRMA_ALG_AUTH], extack)))
 			goto error;
-- 
2.43.0
