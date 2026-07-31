Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629035F199
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506895; cv=none; b=DvarPTUjQbrEqNH3Fh0elv5FuTvuwB/NTlIFgpuMqvV4qcfO0KjIl1Rl5YfGwmLwgfprjusEClaj8nMs9BdIVCuAMwRx5Mr4UkZi+dccpELybTr1nvkJx04+LctEpbe0AgfMpZXruB9p7YxaFp9vamzH2Czbq97pp8bvGd6ewBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506895; c=relaxed/simple;
	bh=lWYS/jQQIXC0y44IHuPBs/Bn1BGmlDCz4C7AQHJjUxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxyry4TqjP0M9ovcLX2zIFNBOCKLrhpIFPZ6YKepBKnOA8tWCxQym+eTW663SSNyMXZWBXkA32jbAGk6cIJzR7zDaIVEWXcuSbcSARYs1X6K/uJmhtlLPJp1y4apLKhRQzQrgWo4SICHneN93QRFy1mOwWOF1gq4blnHfoVqJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=cnikELOM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="cnikELOM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c16ac21acso6019051cf.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785506892; x=1786111692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H1m5R8ifW3apJu3sUYJF9SxlauvcUbf0bTaC1a+0HJY=;
        b=cnikELOMVZ6CYvzmcILg9PK74aKJ0kKV6sqj0IdsEMOUZEpdES8YwbzjOlHH6QOyLf
         T+uaLvOSZoGp7FSjuzV3pQLfp2EKKDZCdcW+ohyyZeEvLQAT8W7oehQN/n/glDFePoqC
         Ze4tbdaK8nXM/jDQavdRIpSE/cRzGXKaopwENnYjup4chbRsk8QWcJK0RPAGxnr6F/ta
         4DMnVXz4gbkG1YTHCwTCaF+w+AMKlj562OSr7AX9GG1wCozqUyRWiGeGlN3A/wFQfd4T
         9mLxIq1mlPqwDRvz6910m/O8XkjzRvIgzzjLNkEqazKsVOYFCzxxv0sg6umtb8rqYXK0
         aVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506892; x=1786111692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1m5R8ifW3apJu3sUYJF9SxlauvcUbf0bTaC1a+0HJY=;
        b=HghxiizWn5LOA188sGSEO9lg65YrC5WuntrM6XPs34BsMEChnagrBYbeE6wfZgoXh/
         5ne2o2TTczrTPtjMkk2MzIS9pT5iQ9v0enj4nCX/VKnD425qLZLJrjYS9mlMBMWN8Ein
         b95VyozlDXIqv+3qcUt1Ap+ViHxB2HyOjVBtthoQlnVi7Dh101SID7tQkXXbJqcE9XYz
         R1wuEqcfg3fxXZlU3aJ+UdTDl0AVuBZzB4rWBVqWutDhw6rSZBQ2qapRgHAqmhxCQHjO
         67NUSAYO7Jl55d61H5rmSTksnbBVhTaaoAaeW0PIzxiAjx/ykUvxDpRldikDXoKdwGpt
         ggIA==
X-Forwarded-Encrypted: i=1; AHgh+RpJb6Up+6gzlFkfXsRGpvMFMTDayxR3YukytZOXX1qDrpDnjDe2Wm9ftKXRv+LXt/sAWkh/LuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLeeYiKG3MbhAK4L8IhulLZn7EGnw9pxhdzjUU3v7C6tIf0Z6
	HIBWn35qxfpsfBv5+NgPhld0sfaKYgij8/kPkxHLjdtOVNFgpIFpxmx3Sfm6VkgrqcY=
X-Gm-Gg: AR+sD12/zCPHYF2SUEPaE8xfFtlqUy6xoL3Xu/meMqIqMmj58Nh8J+jM/x1neD3fU7U
	u7+6NowVjxyWfF//X4QLQV/FzSS4aKEBDppvuzq9CChYAqu101r28TmizxFT6/NVKIgnssrwuwO
	3uYOjUDUj1eiJ1H6LMh/Wa2NM6bMgRAdeGRtw1oF63RVH69SHVG0IF1ysKqc5RpoVdkmFno6KRF
	lZqNtwVuzTKdv8E5ieKzR2xVyQAaLUEU/ThhpuzI+FNNQCdf8X9RbTDRh4EFms9K88nRHZAZwyF
	3GXwP3yn75CgY+12bMw+B5WOX7peR85L7fwQGcqqluguOnZeCDDfSy30ELkFxy142otIHgz2wWS
	NFe3jCuAEPCbPqJkQRmk0OLTVW+toDF56+E/z+NJ8i1csrZET2FIoOoGMvD9ijXKlbQYaWGrl5l
	z1JCQ8xNPnh9cxViEO8IYFlQqRzzz0U5SZtJ+NnUviaSheJVB/KsKIVygGs3qdkTyqJ9ocRUh5w
	N1A
X-Received: by 2002:a05:622a:400d:b0:528:3d62:16c8 with SMTP id d75a77b69052e-52b56794317mr4487941cf.31.1785506892382;
        Fri, 31 Jul 2026 07:08:12 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-52b4e81edadsm8626151cf.8.2026.07.31.07.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:08:12 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: pablo@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	phil@nwl.cc,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: nf_conntrack: prevent helper extension relocation
Date: Fri, 31 Jul 2026 14:08:10 +0000
Message-ID: <20260731140811.566714-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct nf_conn_help contains the head of the per-master expectation
list. hlist_add_head_rcu() makes the first expectation node point back to
that head, but nf_ct_ext_add() can later move the extension buffer with
krealloc(). This leaves the node backpointer aimed at freed memory, so
unlinking the expectation writes through a stale pointer.

Reserve the full u8-addressable extension space when adding the helper
extension and reuse the existing buffer once the helper is present. This
keeps the expectation list head stable while allowing later extensions
to be added.

Fixes: 857b46027d6f ("netfilter: nft_ct: add ct expectations support")
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 net/netfilter/nf_conntrack_extend.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_extend.c b/net/netfilter/nf_conntrack_extend.c
index 0da105e1d..1421944a3 100644
--- a/net/netfilter/nf_conntrack_extend.c
+++ b/net/netfilter/nf_conntrack_extend.c
@@ -112,9 +112,21 @@ void *nf_ct_ext_add(struct nf_conn *ct, enum nf_ct_ext_id id, gfp_t gfp)
 	newlen = newoff + nf_ct_ext_type_len[id];
 
 	alloc = max(newlen, NF_CT_EXT_PREALLOC);
-	new = krealloc(ct->ext, alloc, gfp);
-	if (!new)
-		return NULL;
+	/*
+	 * Once an expectation is linked, its list node points back to the
+	 * hlist head in the helper extension. Reserve all available extension
+	 * space for the helper and do not move it afterward.
+	 */
+	if (ct->ext &&
+	    __nf_ct_ext_exist(ct->ext, NF_CT_EXT_HELPER)) {
+		new = ct->ext;
+	} else {
+		if (id == NF_CT_EXT_HELPER)
+			alloc = U8_MAX;
+		new = krealloc(ct->ext, alloc, gfp);
+		if (!new)
+			return NULL;
+	}
 
 	if (!ct->ext)
 		memset(new->offset, 0, sizeof(new->offset));
-- 
2.53.0
