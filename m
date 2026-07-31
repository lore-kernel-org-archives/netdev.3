Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED963537FF
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506821; cv=none; b=d/7DBClYfXy19WoQHGbe/J+RGEjyGwX6q3qKXGU9KB5yhliWevsvK5htjXa43MGoJ4rSldRzKjsbDWWbx8U8DX1w8WcKSSitX5r+O4voJfXBkhW4T9XZBcZr5i2ZIvGy/gZAgLCR/w/qHO5mmWdj0g7tmYNJlGTi6xWHv888nJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506821; c=relaxed/simple;
	bh=yIeApXitfnS8CcqsGXBvonkx8fP0b42QxgWsMsjIYqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAkSDJbcfHIhCNr7JIl/bICm/sq06iLtdQkmp7762VuX2AbgsWImMz0Ze17vkwxaxqzpb5nBqBf9dvljlmnTCGH9LCmbHyPnbCjjY/Q9CYB9TLnQd6El1rTeyioXkDKy5IDa7I2ivq4Vcu46gViKc8+JJgT483VNYlvw4yDMU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=MgKXhFOh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="MgKXhFOh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c5382806fso9583531cf.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785506819; x=1786111619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=skmn0gc4hRDxdVRgF7HwpzhsoE62D6T+gwWSKWR4PIs=;
        b=MgKXhFOhCczVktx8X3H1nY15Fp7f6EW6vDDXPkwrfpfsRyqemqr5gj2q5VqkhhDpZD
         mZNu12fGQ11qxbyTe6EuulEb9LBKvRJ4NNeTsc3xhlv2GlwOB0CRFz17b3FQbDmkWZSI
         3Tv4SqzfHcKftuuU5du8e2YEDtYk/lXMAxzOOeK8jVNixvS/2Pg54+Z83DwNYiAikYYM
         md2QDsjSccLxBPrnYXAu2emYpt3Bpf49EbIInTq9uUyDfgSHr5o8Ev3tn7jjDpygKpTy
         1dyi4EQAXnOGSB6QyBrhUC7itxy4GP5GqDc8E/cEB3FeD2HwOcUu2uwxBXVrWyFv8xXH
         ALWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506819; x=1786111619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skmn0gc4hRDxdVRgF7HwpzhsoE62D6T+gwWSKWR4PIs=;
        b=LbSttmJ1gXLmyOXcSWsOA2mpNrsFj9w03l5JqtKI3oiC1QSehiHNk3dHz4uvtFUgMV
         UWDYMCqPRTJyX1Ab4iYX3Ob8mWQo7OgibLPqC4a/ZeaW/rQNT7WpxdraB/WilHK/qgIO
         BSCx1mYK89Ii07+vG81RdKpzZ5sMqZ6M3ciAqD34pcLQo2K/g5MZDGI/yZtB4ZAA6jSY
         8lgSvP6f0z29QTQ9KI4vV8kmuxny1GTPamFjNpCQp8Er0IDgtd4Qe4mFazeKcnyZLbaP
         Qj7rpih3RsNZbs3IYyFpY080O0BJX+cD9G5q/nhYwq1Zzifrw4cTPfWTdpBuagjUsO5J
         0/Iw==
X-Forwarded-Encrypted: i=1; AHgh+RpETe/1S3ee81j/WWaaCG8k12a4CEiPuPeSbo9Sh2rJP/D3DAGlWM0W7hulVm5hmRphIyrIYF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnbsYLQ4chXoiH/Hx5UMe94UDY7FD4A81w5jRuNcjHv8fmHaj
	TSCTE367Kw8GlQf5tnmP+VphWf0ywcBTPpt1plTwzbDAVgf8MyXtSGC69/oSyI6Anns=
X-Gm-Gg: AR+sD12NH6h8DKficylOzbP4DRmZkf9IoKEDw31i31oGClnAgffOHyTbCIRBmMCJh77
	b8apufmnF4acYZvTvZammdHsRnODjrW3vs/xU9TOZ6ZEGVuxeC37N9XvBuDkCNdIFQdopAGQQ4M
	nFj3z/rdTOYd4MgEDKu/9RMs7tAttHhLgBeSW4Ujb/SWcu/gpYzWR63V5/OkHqSqtuidqPStAJw
	9ou79GcJKkpv0Gea82WE9WzLkygEtuIC8qODrwmrXwOAYDwXvOedUP2OnAK38TH3J/vvzg9kSs/
	1wmhpCUyzhJ21U9jX0bMZQLi263MiiTS1QtIUw792Jjk7IdKngfQS8T9qsaCZszz1OMlE+pZUY6
	SpthUwUVMvuvc6/u2J28DGB6z10p5rnvS/zZod6tqyim7ROiLV5IyUO0rlzQrDtR6TIfZhrI7Ji
	p0tVXHgnL8rHa/i++wN69T6mEVTSDljZxzxcUjGijPvTNQXHSkyvaHykaGZVmtfj9q6xhKFKblN
	fhq
X-Received: by 2002:a05:622a:5145:b0:516:ed02:c85d with SMTP id d75a77b69052e-52b5666f9c1mr5131111cf.3.1785506819272;
        Fri, 31 Jul 2026 07:06:59 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-52b4eb956c3sm8318251cf.22.2026.07.31.07.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:06:58 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xfrm: fix compat ALLOCSPI request use-after-free
Date: Fri, 31 Jul 2026 14:06:57 +0000
Message-ID: <20260731140658.566571-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_state_netlink() builds the ALLOCSPI response with
dump_one_state(), which already calls alloc_compat() with the response
skb and header.

xfrm_alloc_userspi() then calls alloc_compat() again, but passes the
original request skb and its header. For a compat request, the
translator therefore interprets the 228-byte compat xfrm_userspi_info
as the 232-byte native layout and reads four bytes past the declared
payload. It also publishes the translated child through the request's
frag_list.

A multicast clone of the request shares skb_shared_info and can observe
that child. xfrm_user_rcv_msg() frees it after the request handler
returns, racing a compat receiver which may still be copying from it and
resulting in a use-after-free.

Remove the redundant conversion. The response keeps its correct compat
translation from dump_one_state(), and no child is attached to the
inbound request.

Fixes: 5f3eea6b7e8f ("xfrm/compat: Attach xfrm dumps to 64=>32 bit translator")
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 net/xfrm/xfrm_user.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d6db63304ba6bd5bbd9c09c665170936e1107ced..a7f35a123648d3946aae88674c7bead5666c9eb3 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1877,7 +1877,6 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
 	struct xfrm_userspi_info *p;
-	struct xfrm_translator *xtr;
 	struct sk_buff *resp_skb;
 	xfrm_address_t *daddr;
 	int family;
@@ -1943,17 +1942,6 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
-	xtr = xfrm_get_translator();
-	if (xtr) {
-		err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
-
-		xfrm_put_translator(xtr);
-		if (err) {
-			kfree_skb(resp_skb);
-			goto out;
-		}
-	}
-
 	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 
 out:
-- 
2.53.0
