Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C654774
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291111; cv=none; b=cZU+ng+MsWBZwf3Y0xtJpR16nSmfWeY9BnDRttxh92jLj7ZstDrgGZXhQXFVkzBRHC5tYHUGV4MX+Bg0mmJSJBkw0/1o0ljY+UDzhif9TqsiAzk0a9N68z3YFHXJAnB4IcI3UsLLVvIFe2Kmb43Rfq09rrRkI/Qakbnrzd7AK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291111; c=relaxed/simple;
	bh=/KyJ9L1qwzCiwPsOVVf1RbQsUCKEtwgojEyTWOEdsxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ssl4ga79IbzIMBuQox6fxxldgcIyX1lmJJUtbVVvI4ULQISoLmfb2Lhkq9CJj9gq6I6N6Ppv5A+fpGFLy0g1KnblZj9TDTMIF/5c8iJLlBtMvsKZEufr8SXBDES6bY1vlM/lwnlUXQ3yU/x8KVH5PbgXgwA6hPxT1+LSN0CfauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=FZ7E3MIK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="FZ7E3MIK"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e507b079dso337328b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785291109; x=1785895909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KJEA1nWK4Gv1bXGA18hX88zHi8hXkIdIpy0wTjYDmKI=;
        b=FZ7E3MIK4oXWqIN1fw3Al1JUZUpDUVcoD+Hmy7zXZBuDhRwG3yetkfcnwAqlcHlk64
         4XV68+frQBAVMAc7ahZdQIL4COnJjBPaqN2uXx3MI7Mx0g6LVMv9d/DsCwo8eluOW4nX
         W7usYgAUXHACH4mvZwBr6KZQ4AgBbK897936YgMnOpkJnFLYL1cXqw3+zRZvUb5ude9D
         zRm1rGlIEtG62skL9fEWRwPPueIf6bXgQKeF+W4baCht/JJCOx1NtJRutOi6U8HTs8La
         EUdXB35ycGSGDaoYmZWH3fxQlyqKrEEgcc+sYQ9Gk1Ku3kjdEQJ8svD/O5EkWADDv/PU
         rsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785291109; x=1785895909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJEA1nWK4Gv1bXGA18hX88zHi8hXkIdIpy0wTjYDmKI=;
        b=Yl845AcGnTiZI1RhvdeyW7+FQzLlNMPyB5i6GL5t85pDN8K33OsaeFBO0s6zEyqgg9
         WxZBRApN3Bf0NUmKWy+ZCszGiTYP3mpj0yF7PKSsA8qESQOBAOLtCsExXk3PQ9GCuo9J
         tXSk6ChHEHOOnAcMwoIoN4ND6jPJRuQwoDh6K+s3fFTxI3KW1fN/P69ylDKCovzzwl9R
         Qi1Ph/7YU8O2rv4Cc9W96YSKKNZzEiTaMqZAviVoo1+yJKACgthiAog4/mEY6092SIC4
         4/DonX9WTTvjztPpwiromETjNx8Ipt4H3xkpQUCTRndyNoLbuWmlQC2wIDDF9O/+iElC
         YoCQ==
X-Gm-Message-State: AOJu0YzPKe++//RBL/AtSd1F1Sl0AX49JWGOqHP24TanJwpVo7a7QQvA
	ZEduwypF4ZP0+snNmAWQaLcZdf3qFdDcmOBoJuRH9E2qUqxXikkjYHyOlZqC+eg5V7GOPl581Kb
	FiKSU7FP6eBA=
X-Gm-Gg: AR+sD128o0/jWWIuiOBxt9FgTrtBTb/TKXPZGejW+uiFQb1hrXexYs0rxuQGhjjHRY/
	78DqVjK8EkTWwp+aAQQ8eb0/jyTfQhVO1HgipW0MRHlMitJ3RBSPAQPgDfTHohu53/kQnXjrOcd
	44IDx/LmXOWjRgZIvwzM7yvh7m5wuWORvKBpqleRAfGjOHy8G5eqglx+xpRaoH5EU9xbl2kcUiu
	ZdWH2AXH6LtibMgFO2gHei6bAW/dMpe3b+RTC0tJ9ANt+yHpVFVKpdt0Oaxqz5+NMruJyQTBTG8
	bRhH4viFTunylzxSe+eCUVPQYdPH4qsOvEI6h1LB7fqFCWHF4Q5Y9SbsJaQWnawGsqFe6PRjC7F
	xz6fvk444cL/dTTooZb/1eU3VBIyrFZm78TXqtRYQVPP1hnObmPKP3yQ4Jr0a50vCKZrMSoRoGr
	02lgYcqK9VQcOyeyrh0g5vcvTpdULSFNi/oR8+hzyU7flaFPUmHZL0RUxSEiv3DYcbaIQMgVipG
	dCl
X-Received: by 2002:a05:6a00:a227:b0:848:5821:9489 with SMTP id d2e1a72fcca58-84e9344fda7mr5059496b3a.68.1785291109428;
        Tue, 28 Jul 2026 19:11:49 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fbe1b0bsm639081b3a.0.2026.07.28.19.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:11:48 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] xfrm: save input state data before secpath resets
Date: Wed, 29 Jul 2026 10:11:35 +0800
Message-ID: <e59b617d27acb3a38a3523649d52b90f022fa28d.1785288865.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_input() keeps the current state reference through the skb secpath
while it performs final transport processing.  Some input paths can reset
the secpath before xfrm_input() is done using data from that state.

Receive callback users such as VTI and XFRM interfaces can scrub packets
that cross network namespaces by resetting the secpath.  The
XFRM_MAX_DEPTH error path can also reset the secpath before the final drop
callback reports the current state's protocol.  If that drops the last
state reference and the state is concurrently deleted, xfrm_input() can
still dereference the freed state.

Save the state protocol on the stack while the state is still valid and use
the already saved address family for transport_finish().  This avoids the
post-reset state dereferences without adding an extra state reference to
every received packet.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Avoid per-packet xfrm_state refcounting by saving state data on the stack.
- Use the saved protocol and family after secpath resets instead of dereferencing x.
- v1 Link: https://lore.kernel.org/all/89be67de93958a00193c8c4bd668733c976e2aa9.1785135576.git.zhilinz@nebusec.ai/

 net/xfrm/xfrm_input.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index eecab337bd0a7..3177fa33961cb 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -474,6 +474,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_state *x = NULL;
 	xfrm_address_t *daddr;
 	u32 mark = skb->mark;
+	u8 xfrm_proto = nexthdr;
 	unsigned int family = AF_UNSPEC;
 	int decaps = 0;
 	int async = 0;
@@ -485,6 +486,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0 ||
 				      encap_type == UDP_ENCAP_ESPINUDP))) {
 		x = xfrm_input_state(skb);
+		xfrm_proto = x->type->proto;
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
@@ -592,11 +594,13 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		x = xfrm_input_state_lookup(net, mark, daddr, spi, nexthdr, family);
 		if (x == NULL) {
+			xfrm_proto = nexthdr;
 			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
 			xfrm_audit_state_notfound(skb, family, spi, seq);
 			goto drop;
 		}
+		xfrm_proto = x->type->proto;
 
 		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
 			secpath_reset(skb);
@@ -604,6 +608,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			xfrm_audit_state_notfound(skb, family, spi, seq);
 			xfrm_state_put(x);
 			x = NULL;
+			xfrm_proto = nexthdr;
 			goto drop;
 		}
 
@@ -728,7 +733,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	} while (!err);
 
 	rcu_read_lock();
-	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
+	err = xfrm_rcv_cb(skb, family, xfrm_proto, 0);
 	if (err) {
 		rcu_read_unlock();
 		goto drop;
@@ -753,7 +758,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			xfrm_gro = xo->flags & XFRM_GRO;
 
 		err = -EAFNOSUPPORT;
-		afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
+		afinfo = xfrm_state_afinfo_get_rcu(family);
 		if (likely(afinfo))
 			err = afinfo->transport_finish(skb, xfrm_gro || async);
 		if (xfrm_gro) {
@@ -776,7 +781,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop:
 	if (async)
 		dev_put(dev);
-	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
+	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.43.0

