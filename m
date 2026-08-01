Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014235E1DA
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586225; cv=none; b=QBJGVbAr8lvRYNB9hCeOxtDeO79iNMS7CeWiTxdgWfoqkJAm+xNGEXBOzi0y8a55dxqLWGQ4YA1/Oq1X/9jefNbkQRTxNWn2JhUo4c5qjYkszcUpNcHRRlj+R6yUl/cJGBmxLUiy4R+VIuh+G5git/iOembWYBr59n/lz8qLNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586225; c=relaxed/simple;
	bh=0a/DfPW/J2eWS7Zjbpr4bCkkZmoeuxFertNvWeQC7mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBAvMiLE7wLdMYqRqwCkThvUCsda/k5R7RvNNmPd9cbZjEqg1VBOEcIlImZjAev2p9M9RTyFcQ6trWuBdxURizWKDsLvu9u3G+AKrYMbvT6bewjGiPWhdhNeQwb7yAMTd97Q4esSx5D+cBg4CWrFT00xJUI6F0zW+vaF5mimlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=MbsK0abv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="MbsK0abv"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1870174b3a.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785586223; x=1786191023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJnhj6aPy3l3k5O+WJ6a/1glwK3p1ECA3qtJY2n81/s=;
        b=MbsK0abvf1vh5ohX+oVszaUndUiUx/ZFHzxgt1YeUn/LirnQtxCfbyZirXQQbQFn51
         niGs//ShvSduq9b7GmUjOajdxdHBiKx+2EYDw6h0BhPGbuTaPPeTCWCXzxOmkGV7CZTL
         q+kKVVYjTgExAxS1+IJFRJwdQ1G4H2vUjnLizE3yFEXUjkH3HjqJolTMT83xsKwrxIym
         SnWY15L/DXIMyx4JDyuCdb4d4YpyQw0+B+OXV/40pw8fK5r6VwOWf1PrHAMCsTfaGovC
         GrwiGDSD3WQRWZCHm/pbi+hqZw6ff+HvnMUdVdffTPENdQsiwzEmbKGKiQ2LDSnz7V23
         eZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785586223; x=1786191023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJnhj6aPy3l3k5O+WJ6a/1glwK3p1ECA3qtJY2n81/s=;
        b=STNpvi2yxbLvUm0QqdpEfYjJ7oeWidZcvPHngKcDKAmaJTs8SYxy1M8Sie9mg0zX/v
         5F9anXsa16FSGPwRimgNan9r/yI22bHK1qUI5hrVkT2AYOEcHJ7FGoIvxmfVAhUsaPEz
         fIOddebFEFNDRLWTEpUibWogB3cDuU00803asZ2j78Wy3qLHrmrWzoTsNtk9jMH4apEr
         XfMMcKx+L0eCkbCiJGyMJg9bppBXn/hpUAdDqILXJ3RTMVLhSIA/5lujutfrAdvz2AXf
         R/VvESHuuShhQnzycOJo/sgOPwkzKfjKcZzUgKzV6L1fqBQQki9D+51LQlL5ieZKNTcF
         +FRg==
X-Forwarded-Encrypted: i=1; AHgh+RrcMBRcljMouLDQIZM1tDQ8HWtGXDb9kaddz14SgGmAj17DnScBrBjBM+XPPrPIo3LhtWZh9dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbQUd0sRuq77wnP0XOaJ5qHh7FzWEMQ3SmrfjM7xfL+qS5+y1
	78YRc50ixL3qAiOPP3DtCdbfE4sF8YHeOh6nxvPKIrVWxtGeYj6o7PaCG0zKsVfTTC5L
X-Gm-Gg: AR+sD115RDjaK9wpt/FI1rxkI44TAxXbYDVow+sN0SMJq4GXcW0gP+TLDRAFoWNqDJX
	ledU38gWcKDnSl2ZYjM8FUt2coY3yxlLe99FJx81nLbqJqW31M+nWWyZBbXD7XQ2akGedEYmrxV
	wYlwswxlJWHENc+Z+q8gjqUQWWCa0/D5BQDCL5iAAGIbO9Iy3Lkr/K3r4ozAFOrJPX9NzvGfHUm
	wjcUfb3lNss0NExyXVYBQDQfvvBJRa0ZpiiPYtTpSNDLoT5kyfTHCl7Nt1VWtOqrVeUA7tAJraU
	jG/hwqRJr1C5JMtO+etrym/1g/YEUtb0iHOUITn8xfOKsE5NZf+IOT1gI4r4WemwrChYMX2qXV1
	axZIj/oZRfK9zv5z+MOTuKeqIgHGAcEaoNZUL3P79hmRBTMs/Q/3TyWxQLOaiTfDs3hem+kHJ1Z
	0LVZtHaSo1mtWxRFyU6db5/bTZaxzw+vhajz9By8b/XAnom1wbf3b51e1vT40hmIzKZB4Of5KDH
	g==
X-Received: by 2002:a05:6a00:f07:b0:848:2f7a:2e5b with SMTP id d2e1a72fcca58-84ee4998d54mr2831093b3a.74.1785586223409;
        Sat, 01 Aug 2026 05:10:23 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d45e5sm1580587b3a.42.2026.08.01.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 05:10:21 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	kadlec@netfilter.org,
	den@openvz.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	xmei5@asu.edu,
	kees@kernel.org,
	sbrivio@redhat.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH nf 1/1] netfilter: ipset: serialize kernel-side put-byindex with swap
Date: Sat,  1 Aug 2026 20:10:02 +0800
Message-ID: <df40376603e2a53a311d5ceea63240bedc11bdfc.1785583673.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785583673.git.zhilinz@nebusec.ai>
References: <cover.1785583673.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

list:set garbage collection drops member set references through
ip_set_put_byindex(), which resolves inst->ip_set_list[index] before
__ip_set_put() takes ip_set_ref_lock. ip_set_swap() swaps both the set
pointers and the corresponding refcounts while holding that same lock.

If garbage collection looks up the old set pointer for an index and then
loses the lock race to ip_set_swap(), it decrements the old object after
its refcount has already been swapped away. This can trigger BUG_ON(ref
== 0) when the other set had no references, or otherwise under-reference
a set that is still reachable through the swapped index.

Fix this by holding ip_set_ref_lock across the kernel-side lookup and
refcount decrement. This keeps ip_set_put_byindex() paired with the same
set/ref state that ip_set_swap() publishes, without changing normal
list:set deletion or swap behaviour.

Fixes: 439cd39ea136 ("netfilter: ipset: list:set: Decrease refcount synchronously on deletion and replace")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/netfilter/ipset/ip_set_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 6cfad152d7d1b..2d3c8586e6445 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -855,9 +855,16 @@ __ip_set_put_byindex(struct ip_set_net *inst, ip_set_id_t index)
 	struct ip_set *set;
 
 	rcu_read_lock();
+	/* Serialize the list lookup with ip_set_swap(), which swaps both
+	 * ip_set_list[] entries and set->ref under ip_set_ref_lock.
+	 */
+	write_lock_bh(&ip_set_ref_lock);
 	set = rcu_dereference(inst->ip_set_list)[index];
-	if (set)
-		__ip_set_put(set);
+	if (set) {
+		BUG_ON(set->ref == 0);
+		set->ref--;
+	}
+	write_unlock_bh(&ip_set_ref_lock);
 	rcu_read_unlock();
 }
 
-- 
2.43.0

