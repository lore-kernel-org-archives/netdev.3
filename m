Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FD2D5412
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309236; cv=none; b=LYVMPUWEl5y0dJMNmoBJ3rGc4cuEAs3OjtyL8TtiCtHbTLh0Wdtk6/0j58U4+cwtz1yKPX7fVyjVTLLHNoOKFWFatQ2VmflyGHY/THjF2q7YZEFFQca8GkJwxLHQVrNfUQ83oneDhmJ4wRGfUSVX42C+lam28Stm9lKvC5ihWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309236; c=relaxed/simple;
	bh=Y28b9bHSwIIK50NWh9CclWdbO/LaxyN45BWaJbO4tD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AUPlgeoJwm64OMbkltY2RvXx1hS2v8HexNuaq92YVyXm4rDzJlvXpPdEhjTZrbyBrrBxdZCO2Mw46u8ZMGiLoUAzlyezqqi6ji0fih79HsyZ5FSlIJqSGVlXI6wlL3+9XPgrZlGlW0qfRNrneULBIZBpY/twvXedIrlAmveJTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zc9GzMiS; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zc9GzMiS"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9390e7e4c5eso98227785a.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309234; x=1788914034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GuNL7Wby9MNWAnsVQJiqvpKUIMJDRnuc5Vz5nrBgTGM=;
        b=Zc9GzMiSNuDPrbpVRH8vYXgskHw5BiGiQt5x+gbvoDvIAf/AZEaj2uFvzovXVe8CXv
         RznrRdx30JQcxlF0eR1YJu6rd5ODBHxIdFhndNV4QPLG+lLrNeI8KyV6r1YAOMU0WHws
         /PcOXAZuAnl+QldmyGE4vOLOHu+kdFVywpRak42T3oa54sOvXbWeuYb+I2N+PSbU9wLp
         ieHhhCwvGkKlr+b5NwEo/uhA5ILlJxfxQo6vRoV/e7zakTBZPfasKFeTcddY/4nYUe5V
         lKSH3sOTOsD0yQx5WHFp+ijDR2FQZit+fx8ynf/3Vazom2gWVrHh47bzk+okt8sjzjkG
         1t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309234; x=1788914034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GuNL7Wby9MNWAnsVQJiqvpKUIMJDRnuc5Vz5nrBgTGM=;
        b=pP+x2eb78KMHwNyzyB6qlfQDG995anRSynOge/U4YRxjANDt51vNH5KjpfyktquWcv
         Y2pW1dVx0mHKw3GBruGWYY1wjFnbM/SVnDgr/jtQaBPSXzBNcA6iXfQkMPL2a0yUNb5V
         zhDTnxvCLmJqcm5KUB0zlPskVdL20TbBZAa4dqb4dKlqpkot2akLQMm6ZZRRlv169ISZ
         hKmXeW15/qdLkHnNLUMkpMPr3WKnye8+2+lgCyV9TPJeh76A0I1iW0O9SR9/mUDkOuLQ
         Sux8Ti8P2TinzVVn6TkQ2TRHiH+QuJMoHx3QL8EOfoezfKm/FwK5mN6rS3vqKpDDpDbq
         Awbw==
X-Forwarded-Encrypted: i=1; AHgh+Rpjwz9KCkvNnNBxqWKpmDOcQQYYJ5Zh3Z3U8RQLjNwaiGHz4KGLPxO9VHpkpQFu2IUXpvyEOrc=@vger.kernel.org
X-Gm-Message-State: AFuF++mzfGBZG7ZDhT5qdkvORaN3H1ygxBD7LH+Cu0jtr7MUkJkwZ8Cg
	/BFwKdJ+RTSO4CgKlwkaNb3kgH0v75TMJ+4MZ9z14KElc1W6BnMbiAVxY5sx0Z8pHYxr6VzaNY5
	O0DSKUzZ866GoAw==
X-Received: from qkof21.prod.google.com ([2002:a05:620a:4095:b0:939:359f:cb12])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a285:b0:937:11c9:37f1 with SMTP id af79cd13be357-93960e3256dmr141949085a.16.1788309233837;
 Tue, 01 Sep 2026 17:33:53 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:39 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-6-edumazet@google.com>
Subject: [PATCH net-next 05/10] netvsc: do not assume mac header is set in netvsc_start_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue,
and remove now redundant skb_reset_mac_header().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/hyperv/netvsc_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1d43c73fd73f10200ee0c69c9221a2a44971b08a..d78ed0f3a3bd1de37a05187b4d7f499099041668 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -533,8 +533,7 @@ static int netvsc_xmit(struct sk_buff *skb, struct net_device *net, bool xdp_tx)
 	if (skb->protocol == htons(ETH_P_8021Q)) {
 		u16 vlan_tci;
 
-		skb_reset_mac_header(skb);
-		if (eth_type_vlan(eth_hdr(skb)->h_proto)) {
+		if (eth_type_vlan(skb_eth_hdr(skb)->h_proto)) {
 			if (unlikely(__skb_vlan_pop(skb, &vlan_tci) != 0)) {
 				++net_device_ctx->eth_stats.vlan_error;
 				goto drop;
-- 
2.55.0.966.g6673acef38-goog

