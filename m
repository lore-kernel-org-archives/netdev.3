Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0339A4D6
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787995486; cv=none; b=mMx22fk0IcGTSgDo3aOHjjPR2vCe0GfZNVvcHdywiXZ9BIB+2yP21q1tiQPWE98HJblbfHADLPSo2pipXs5dLP7CfmtryIcXI7DLBe7H7XinX/mXd1p11Civ2IM7bqpoaRjjMP+MBoGHnh+1N92kq/ildXdD5zRCX5+wrP7xBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787995486; c=relaxed/simple;
	bh=+IEhAvVHb/RTTZlIV+MlIDGrvKR9IAI5fdAmZ0jST3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxQc8ReG6l+9AGNbhNnkkHDofQnr9rTtxse9+44od1rMCIWkDCRKOXQWgol7dRo6KrJOAOls3EGGS/k/TkcZzDHYFmXyuRSYHuva7iJMDDe4OIlkLQmZRqj06vgMeQAgd09saUwWbOwltQIhtvOzkdqpWYDI1Gne2OvkMrkG8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=lpPy82pE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="lpPy82pE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceab75934dso20237805ad.2
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787995483; x=1788600283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2gSZRP78V5ZnfWDTm5K53eUzvLJtp/hIyTh1X4kS3k=;
        b=lpPy82pEY6v276nOLQZbxiEZQKq7CaEZJBtLRbjLYPq4L3Oh511hJiW7cI/nWgxIXL
         euP+AlivWddyZpIbI7oTt6Jfp3ss045KsqMJu4vKrETt/WSyQIxgkvhx/o/3Z0fxiSPd
         wynKswToaAn+n1Zp2bzytTcXKc/R4M6NDs12V1lZHZvlst7Njc8sSEO0v1S7us1cggpa
         7kmNSeIyyN+OFYleTcAEgxhp51RXLD+Xk3gOtlT2FXdApwhGFW52nswnHoKf9MJ6E1V+
         +TdgHjnF58iAF9mlNPFzAQYzC39Ktxo1KL7HdzqyuzSx/S6ReQyvAbPkscOZp+2fgac7
         4b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787995483; x=1788600283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2gSZRP78V5ZnfWDTm5K53eUzvLJtp/hIyTh1X4kS3k=;
        b=XDagsG8/9y5kAjbqpnE03lqD57T5bf3akNkRERbrflFTVNyBtoZR7WM73I3nPjXD74
         0l6b8Ia0AYJlSgKjOxGb34qpFXWQIsBdHXojELk0+q+xyHGw0kN07NYZfjNpWL7jLsyN
         7z0G2SpaNUOu+cQTXlAb30HHa//OVI2ZmZF/2o2xAtdNJuEpKGFv04X7tRSg9J3+3w+d
         RRLohNgbZK7MIddLdnGQui2miiOUJnn/p15NcZLJhJ+9CpPPPgpsToeQ/vRq1qb0BCc7
         uad9eFh81qk+GuQMmhkn+1B5DPOAgW0VJ7j9ftgjC0OltZ+D8RFilDB2/8L/wJwax8dA
         2+Pw==
X-Forwarded-Encrypted: i=1; AHgh+RqoPzt4FaiRlyC5k9eCeIcgJeVTmRmZbRZJ/Ui8l4tEHIq40vnkNNI16VNfF2YJWHVYNYwpdNI=@vger.kernel.org
X-Gm-Message-State: AFuF++mJLosF0kxxQNfb8Aj6gq/+bmQ2tB0A1JLsQ2RkqHeBOLhnqMmm
	/9BpS+nd6PtCf7SjeTvhxbfDvJEwYjtmGESOUjQcSzt1InQha1WDEWGBBLRCGOyhdlwlMBeQaxr
	QBq4OOWbe
X-Gm-Gg: AR+sD13Y8xchEu5c2c1WYuedB89MLme2GgUKC/MBsRxHqzcEpuAZifG/SjGtHkEII7A
	rKNSO5MiufVlcmt+6944Wyx18Jkbxgzeb7bCNggumtFomrsVP8i+F8WkqBDUvyQqXvKsuAVXTQt
	GQ7K3JpQK6Ey6zSNNTSJzmO5wfC7YNXSZnqS0WxdNl09hUsawh2mtPpRSFwKh5u3lKPsaZYDfXw
	suEN2zJhtmH4TTlQsxvFKJiLza/miYwI0enwKa9u/SHv0Cu3xmU6TFMweM8wY+7p7k+YgwKkjqs
	pSyHrA7VgvHdhrgWreaV04pCfHGCd5GKZY5+LT7zvCtFaUlZUj7I06sQ8EmxD85hvi/KGM0qwmH
	zXCoWJKY92jdV1N483CqQ+Rhp6uoMV//4S3celJvkG/gJDEGlDJraogwoFkZaQp2n3M3jTHZtJA
	dpoTUAD4N7mmj8fqbtygk2RdV9Ei42QaF9pkFdAiATsqBHv7z2L/rRE7bd5WeDb5QJBtty
X-Received: by 2002:a17:903:32c7:b0:2d8:d4d0:792c with SMTP id d9443c01a7336-2d8d4d0798emr61259415ad.16.1787995482769;
        Sat, 29 Aug 2026 02:24:42 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa5517fsm15522568eec.31.2026.08.29.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:24:42 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v4 1/1] xfrm: save input state data before secpath resets
Date: Sat, 29 Aug 2026 17:24:24 +0800
Message-ID: <52e0da6a8ae00868e180484645dee769402ee5f0.1787994112.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787994112.git.zhilinz@nebusec.ai>
References: <cover.1787994112.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_input() stores the current xfrm_state in the skb secpath while it
continues receive-side processing. Some input paths can reset that secpath
before xfrm_input() has finished dereferencing the state.

Receive callback users such as VTI and XFRM interfaces can reset the
secpath. The VTI receive path does so before checking whether the packet
crosses network namespaces, while the XFRM interface path does so only for
cross-network-namespace packets. The XFRM_MAX_DEPTH error path can also
reset the secpath before the final drop callback reports the current
state's protocol.

If secpath_reset() drops the last state reference while the state is
concurrently deleted, xfrm_input() can still dereference the freed state
when selecting transport_finish() or reporting the drop callback protocol.

Save the state protocol on the stack while the state is still valid,
and use the already saved address family for transport_finish(). A larval
XFRM_STATE_ACQ state has no type, so retain nexthdr as its protocol. This
preserves the existing drop-path fallback while avoiding the post-reset
state dereferences without adding an extra state reference to every
received packet.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v4:
- Clarify that VTI resets skb extensions before checking xnet, while XFRM
  interfaces reset secpath only for cross-network-namespace packets.
- v3 Link: https://lore.kernel.org/all/db594f875fdac39aff6f4f44dd1e270b0ce5ad4c.1787381531.git.zhilinz@nebusec.ai/

changes in v3:
- Retain nexthdr for larval XFRM_STATE_ACQ entries, whose x->type is NULL.
- Avoid dereferencing x->type before the existing state validity checks.
- v2 Link: https://lore.kernel.org/all/e59b617d27acb3a38a3523649d52b90f022fa28d.1785288865.git.zhilinz@nebusec.ai/

changes in v2:
- Avoid per-packet xfrm_state refcounting by saving state data on the stack.
- Use the saved protocol and family after secpath resets instead of
  dereferencing x.
- v1 Link: https://lore.kernel.org/all/89be67de93958a00193c8c4bd668733c976e2aa9.1785135576.git.zhilinz@nebusec.ai/

 net/xfrm/xfrm_input.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index eecab337bd0a7..77b9f4d4568d6 100644
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
+		xfrm_proto = x->type ? x->type->proto : nexthdr;
 
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
+		xfrm_proto = x->type ? x->type->proto : nexthdr;
 
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
