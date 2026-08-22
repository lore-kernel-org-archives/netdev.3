Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3C35DA40
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787382186; cv=none; b=ViPfd4GNdxrhTu9y4UP5ReEnJnPiMQYAT0Qqbtxsb2OQV7EiYI55nWDVCINeKmQO5jTmzeKEl0dQZ34xhYoVii9AQT5fkBSlCq3Y4n4EhEH9yK3mRIYpgCtfl/tJpXBZ681whsdyo/klseHdmg+s3B0NY38/bT1ygpWk3GLJoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787382186; c=relaxed/simple;
	bh=QzQ/9lNfU7AS5HCwXezmdhiBPtPEDaxmSMG+EQoWpZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5lJVqq2t4COLzmVXTZF2xbkypZhBaUaAMMSdSN3xWCPByZqaqKoirSiwRfmglndLdG2AqjPB9W3rNB7Ah1Zoiop189x+RL+fI7/CRmVgtNMafQ0ymL7bw9CiejKCcAqmixgGaR1KVCtS9/dYRDLNVZCvbz29bJLe8+F/P2+o48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d01663d816so15449655ad.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787382184; x=1787986984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S09nHWhvnNNCQSjhFfDlMhmny0a/6iV4hbH6+MZXS0E=;
        b=WM2bEHpnh58qcDGd5seFESo+KSsdxNjhpLS1eMuQ9fdn8pvxzur3YZchgbyC1x70WP
         LtXh3F6k4lnik9F7Qoq5iHv5ouLHCXCtXW1nkqf0yyNWupK8IrRmDlWpw1BzlanxWyji
         JBQRttRNO/U95lFhbcnTiQ0Q3fjYmX9CbDfU984gCkHvtIQke+Q0Jx6ylyChLdBXzINS
         82Rk7M1OB+vutSPPBhRW8DPCIDd/Kt/lXhYLA4HpDALzpn5cdcsV7vZ6fHvzLqiiNbuJ
         RGFXsN+UsWci7ar6bHNkkRZSTpgDqhee5rkCFEvkhMgkoo8mdOqPJ1tj56dzcDTJCA65
         AOxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCG0eJrwSUD53HIPQKr4Vwrucnh9ypQeSu6Rdr/mPFuucxhKYfQzeyks7tQ6CumQyu96lnXr0=@vger.kernel.org
X-Gm-Message-State: AFuF++mXXuQ0QucK6xFuu/ujYyUJFMDFclxcjdeMOW6zo9EA0IMg8h4q
	ZY+48s9wLxY62BjzESGAndHvsC9WQDyxaevIhZ5xfTivM49ocMzdkjqu9co0NGXMNGZ1
X-Gm-Gg: AR+sD124tblhvfc+wIAYY+DLe3E1T9behihU7C5BHDQT++vUKBCJudYgIeuaAwfr49O
	JosscZWck703QvrAIFQaWh25Re/qEhK0TVem5odElUvD23Nt7M1kZzi/K/ORA5KQeCY0iTjSWf/
	DkgcPnjNdK0clj+xNpXnZ3kH3CTkgp8qXJ0ANMlWZmmoqBamrN01321avwhY12Ujv2DSXWse5Kr
	MogJ58b4F+ghUURdkN+LwmZuy2vDNw0E3OFxmIgR6YWbRQ1Gqf/GnRgeBJ4InbJKN3+IwMIXASO
	DGXGhojj7upt+QSrMLDs2V1rV9RDJ11Yi5Qm0WRJivzCoIrdSKGDbRKvdG1AHewDzJqmr6zbZIk
	9aibMXHiK8MlGHnKJeJxeWTx749Twr1EzDrCrlzp1gqC8VxE278SmG/sE4D7wYps4rBSZoY7MWe
	j7xk/lQe08RSrO1fgVN6BRRG9Q3j97WMxp0DLcttTumKZ5mw==
X-Received: by 2002:a17:902:f70f:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2d64ada4464mr232728525ad.3.1787382184140;
        Sat, 22 Aug 2026 00:03:04 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:2bd:64ff:feda:6b7b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90999fcsm3315904eec.1.2026.08.22.00.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 00:03:02 -0700 (PDT)
From: Zhiling Zou zhilinz@nebusec.ai
To: steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] xfrm: save input state data before secpath resets
Date: Sat, 22 Aug 2026 15:02:44 +0800
Message-ID: <db594f875fdac39aff6f4f44dd1e270b0ce5ad4c.1787381531.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787381531.git.zhilinz@nebusec.ai>
References: <cover.1787381531.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

xfrm_input() keeps the current state reference through the skb secpath
while it performs final transport processing. Some input paths can reset
the secpath before xfrm_input() is done using data from that state.

Receive callback users such as VTI and XFRM interfaces can scrub packets
that cross network namespaces by resetting the secpath. The
XFRM_MAX_DEPTH error path can also reset the secpath before the final drop
callback reports the current state's protocol. If that drops the last
state reference and the state is concurrently deleted, xfrm_input() can
still dereference the freed state.

Save the state protocol on the stack while the state is still valid, and
use the already saved address family for transport_finish(). A larval
XFRM_STATE_ACQ state has no type, so retain nexthdr as its protocol. This
preserves the existing drop-path fallback while avoiding the post-reset
state dereferences without adding an extra state reference to every
received packet.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
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
