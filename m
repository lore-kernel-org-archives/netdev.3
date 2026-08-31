Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137853B8948
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157674; cv=none; b=ZZIOybIWFHVFw3vy2UIKPDatla+eDEtMpPAOl1aLXUgEI2Fng5qCyXQrX6yeJqnocUxQhqr3DduKReq852qBgDsYQhdCdwvy5Wu8K2pCPzVhqXOG72ho5EfMJyzj6P0TwL+RaqAFkZsZhIdVrJcz0FEkbEGTIIQN2LWT0bsHV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157674; c=relaxed/simple;
	bh=ZWW2kLJpeHZ9bI1gCB17n/9KjSyJDrH8X+KrOXuSvaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhW08Kaa17awLNcO1qSczcPy7Yv+Ze5FPII+VupjIm7idKG7gbjTvQ1RYgaVUIjeDZtllpR4f98mkO6ySKTMCseB7Cl9udzCuO7Zi7idOe0erPmxiLk2qKueiIIQgd7RLftc+ouJl/B0e52T8ZG0rZLJD8EfB/65pJ4fHt9TAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rps2zRxd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rps2zRxd"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so312767466b.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 23:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788157671; x=1788762471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLzznjJdTU4e3xyN00y256UQzkoLhYeQ1hJjpcML1Uk=;
        b=Rps2zRxdPUoaWcJelKmccCVVbeEWPGzkR+UyE8ytjqleb9PJ0MdZPbN+XDa8GVnpF/
         gVTJ9ussyuXw30gOzoyUln0ER6+dM0WN7rMK3iUQWVfvT0sl2uZXEr3j2aZnP7M7fqWU
         8qQhLQ2lt/J5vbf2UX6X7nc8oaFihLlpBHXEyw2uHPoikAMcBYtPSL1A7Sr263nSm0E4
         mZtuThXXn1mqvgDjjHqV7HS9/68qvBPxuWQ3JhQZA8wfEWQkH0GkxcyAAcd8lHZF8nyU
         4rFFVRebbFF39htp+ciRGa8MZLc5f9mHWbZFwuR9dQXjXN/zrC3agCV3NiycqJHD6uc6
         ruOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788157671; x=1788762471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLzznjJdTU4e3xyN00y256UQzkoLhYeQ1hJjpcML1Uk=;
        b=HojsjONsasgvuQ5Te139PBwgbABnJpSw7+3d7yS0rTLivQm41Gi/t1j47ZFk2KeDMz
         KNa51OrTx+SGExgoDQ01ootHR2DwchmRnTUTyDES/WLQZVUqZjncpUVJou16pJSmhASO
         r/naqzdef3B9KEXs4j7ae+DPdyr96TVWs39tWzya0EcpNX0n7Ai8evfiCX4cpxU8nCth
         pb1WR5iLikRNJaAoglGRdvmBAFfJE81rJzt0jPqtptHsvw7GEMz2cwrv+UUOWD9iJg9V
         KIrqLNLGCRtqikUBN/5FhAhR2iMl21bVOMKfcH+KOEjW+IIfyz9d2akoP+IYXx+PaYKX
         5uIg==
X-Gm-Message-State: AFuF++kdHkNjwTGP90D2IMIEvVFiRtgNZQYkorm9wc0aUlvzijmplSPg
	/3pGROF3AEXiREm0nwSXsIPPwuqwUK3FWdpZELQsNu3YEgxThU7e/nze6W7XVff0Z20=
X-Gm-Gg: AR+sD11+0YtACb1CGnvjO3+eyjtTgX8XslVfKILccKtE1IKa6rHospO+u6/jaOgX4XD
	K6EukiHtiVV0QBM53sSG9vakM0NiOJQd8Fb0hg/+pBLaSvmlO1xviqvS7IvU1QfJZsCJ0EJV/uj
	XTqXyIRoRbIquNrFiM0pidxgBlSnzB6itt1+cZXLWdgsfgOFcMRTXh7qcz42SjU+CjSTJiwXwA4
	ZKWD+E6r/QGRgp3+G55E+sZphEf33JmnElTexHVLKE/KPJtntNVqhq3U+IGmw3b8KiU7dBxTGhY
	w5o9uc3ePqkUT9zQoBDCy2erEztP5TsCqC9h2XfQRPt82JCie5VvwkgGHM0GzN3s9aD3Zqo4ZnO
	sRq0CcT0gJA74fkdfoDLOBv5q969iqvXW7bDAbQ+I18yzhuOI5OxKCRE2tJkruGNJ8lbHxefkfQ
	W9lLUv/yuf3UNgpw0f3MrU89azxSUd9gEX9wq1Ba8DrNmw1pUEcYMqymtZg7/z3Lf8GS3UYGm1w
	tcNcPePOpqVbJHvBm2qSh/cDS5wP5eYujG4HA==
X-Received: by 2002:a17:907:1b07:b0:c20:21be:ea75 with SMTP id a640c23a62f3a-c2556fe4518mr1509641666b.8.1788157671206;
        Sun, 30 Aug 2026 23:27:51 -0700 (PDT)
Received: from cloudflare.com (79.184.131.109.ipv4.supernova.orange.pl. [79.184.131.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25ab2f9aa6sm24499566b.35.2026.08.30.23.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:27:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 31 Aug 2026 08:27:39 +0200
Subject: [PATCH net-next 2/2] net: Make skb_ext_put_mctp() idempotent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-skb-ext-prep-work-v1-2-ecc2a8542fd9@cloudflare.com>
References: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
In-Reply-To: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
To: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

The MCTP flow extension can be released either when it is deleted from an
skb or when the last skb holding the extension block is freed. Handle the
release in __skb_ext_del(), which is currently missing, and make
skb_ext_put_mctp() safe to call from both paths.

This will let __skb_ext_put() release the MCTP key without checking whether
the extension is present first, which is needed if we want to reuse skb_ext
chunks area after skb scrubbing.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index aa8b42c74f42..ab195b99c853 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7248,8 +7248,11 @@ static void skb_ext_put_sp(struct sec_path *sp)
 #ifdef CONFIG_MCTP_FLOWS
 static void skb_ext_put_mctp(struct mctp_flow *flow)
 {
-	if (flow->key)
-		mctp_key_unref(flow->key);
+	if (!flow->key)
+		return;
+
+	mctp_key_unref(flow->key);
+	flow->key = NULL;
 }
 #endif
 
@@ -7261,13 +7264,20 @@ void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id)
 	if (skb->active_extensions == 0) {
 		skb->extensions = NULL;
 		__skb_ext_put(ext);
-#ifdef CONFIG_XFRM
-	} else if (id == SKB_EXT_SEC_PATH &&
-		   refcount_read(&ext->refcnt) == 1) {
+		return;
+	}
+
+	if (refcount_read(&ext->refcnt) > 1)
+		return;
 
+#ifdef CONFIG_XFRM
+	if (id == SKB_EXT_SEC_PATH)
 		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
 #endif
-	}
+#ifdef CONFIG_MCTP_FLOWS
+	if (id == SKB_EXT_MCTP)
+		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
+#endif
 }
 EXPORT_SYMBOL(__skb_ext_del);
 

-- 
2.43.0

