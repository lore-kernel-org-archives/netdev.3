Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E253033F7
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786400269; cv=none; b=u7M22Xr8ryIQiwAG8SAW7ayqYTm016jv5xa8rf5ovFO/K3aLS2Hf3KrKgxoWeQtFrz+5tEMAe5G6LnH2qq6uioXVouAqM2x9L5l70d8jpsUW6S2smncVVxDJI6subjH2nM/k0P1yy81E8b2AU7Avjksc2nVvsKlbJQbfxKpQ5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786400269; c=relaxed/simple;
	bh=ZhNKW6g/+oomwKLg7OPXq3/1lKLTs4nkOCQ711e8Xgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4SVvCJWNbqfw3H0tP+KwnrlEpHcDfeH9rG6cYyg7Vf/xfSIXPqiCrwCJM6lBI3pCZsYqtWONCtufsAOQht+Ke5yragBeswxA2KBfak79YowOze3rQwH53iKT5Kq/MRBHvG+O7Rf/rkXbFNSv8DsKji1fqCRpyocM+GWggPTcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=e73Jtd4N; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="e73Jtd4N"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb85186d43so1293982a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786400268; x=1787005068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xyx4aLVuNIym2aqZSu/GBDUgtkyzDL0TaIKLCAoxUHg=;
        b=e73Jtd4NkAIS1dxafE7BDnugB7nY74QcIV5Eff87Hj46Qgi3MqBv1sl4ncupa9lRkx
         T16xGW+QLKUANWlNn9z7buP6v9S8airljz0MptH/kIlY6a2gULV5/7PkQuEx4ldZk4ZE
         jEQBO02J9sa/gGqERpfydylNQVJNO6Iif05e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786400268; x=1787005068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xyx4aLVuNIym2aqZSu/GBDUgtkyzDL0TaIKLCAoxUHg=;
        b=LQa607srqSO2xUKsyUJ7NSZWcJaVLjUicTi1kw7R0MQN4chEAxnR7BKyFtTwNg7CM1
         a6CIvTqsgoLJlmQRCkfxJScepzm7hHp4DWc94wGvU8OCjGMPbE9oFc2rHfBXJn1LzUNc
         5ALuKxtQzYVugrFTBoVUCaGnfJyio/uWMPErI7jO4WvobH+7Aa5JU2IfSP6C9nS0OMXm
         gBKapLLFBcbvW2tBJbd1RKDot+Z5zsrgDUcMhgrsY8aA4S535yc15ZPJxp+8cjTpjfQE
         HPXUPddvBljnOw+K/MEHNYgUbUJANP7/WHybbmJ33dAYZMjXUDnm4BQDUE6iv6MrvBMw
         s2Ng==
X-Forwarded-Encrypted: i=1; AHgh+Ro9pXHBdbYdTwjZ+PjAKb8gflahQpKnlPX8c/kU2d5ZMFggVkKac6XBzMVh2oOvcb7WfM9iNZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKYRfwfuGfROwO1E1xVzBWdW/60GkpuBvqVS94kseVIaPULPB
	87MYW23cZA+u5G56w8jkm6DdY2Y1KiUI2TmAXw1AWnjRkqytuKCB25UCaXbUtrN6yBLcQaXJhXQ
	shhConH+7yg==
X-Gm-Gg: AR+sD11f4zklhnhzxSUhCYWGrvuCNX2ZF+v02CyT+Qr8a7wk2SMO2QqAKs9Nq0J9ftM
	PuRDoRdwhyJ4zRK6N8+x75Kirs+hBQBjgGKlv+NauH3dLbpRwfIt4Mh1h4hUici9B9f9OaRpPxJ
	mYS59v0fh/SJFzEoRRJuDozyYWkJTfb80X10vygTq4i/GTVxW9mtWDhrT2TbBwBLbO0JOvEhUZN
	bICrUrIiuTRu58UBhTOSgmINwbOY3mIcGbtWYJo9fp8TCSg6UdM2dJjccn/uHsqof9Y+ZgtDd9P
	xLswL/W1uRXeAXGk9+aWXkIwkyeJJGI6baS1XHjw1O+BVh2W+uRp07pGh3HTZzfpzfPjz8f07IE
	Ken5vy5xs5JsyjizTkezjKsNnRPOkKS/t8RTyWKegk17mpDagZMcangSUi2w6LvKBJJUv+6adlY
	YW4qjCeBMO+lrG4cQzm9+bOfchfC4E6IE+Ouqu/uwb4WcIGPn3gn8sOeC/+y5JqJ0KWw+GWiUSz
	w2m/kPUZ6F4gqyD/11L5yDfliPJOVQaiuLh+ACe0+JWtHaS/jV4YtY/S3tbNOYGPPYJtyKRyQI=
X-Received: by 2002:a05:6a21:33a0:b0:3c3:7762:5d5f with SMTP id adf61e73a8af0-3cbce8d45e2mr24390555637.19.1786400267996;
        Mon, 10 Aug 2026 15:17:47 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86f98esm47392553eec.6.2026.08.10.15.17.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 15:17:47 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] netfilter: nft_ct: validate timeout object protocol
Date: Mon, 10 Aug 2026 15:17:44 -0700
Message-ID: <20260810221744.35007-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nft_ct_timeout_obj_eval() only compares the timeout object protocol with
packet metadata. A packet header can be changed after conntrack attaches
an entry, so this metadata does not necessarily describe the entry.

Timeout objects contain protocol-specific arrays. Attaching an object for
a protocol with fewer timeout states to an entry for one with more states
lets the conntrack tracker read beyond the object.

Require the object protocol to match the conntrack tuple protocol before
attaching it. This mirrors validation by named timeout policies and
nftables conntrack helper objects.

Fixes: 0434ccdcf883 ("netfilter: nf_tables: rework ct timeout set support")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/netfilter/nft_ct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 03a88c7..d618bfa 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -885,7 +885,8 @@ static void nft_ct_timeout_obj_eval(struct nft_object *obj,
 	if (priv->l4proto != pkt->tprot)
 		return;
 
-	if (!ct || nf_ct_is_template(ct) || nf_ct_is_confirmed(ct))
+	if (!ct || nf_ct_is_template(ct) || nf_ct_is_confirmed(ct) ||
+	    priv->l4proto != nf_ct_protonum(ct))
 		return;
 
 	timeout = nf_ct_timeout_find(ct);
