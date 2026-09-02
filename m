Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E2229B38
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309231; cv=none; b=Q0IRYaNSVZ4Xz3QH4upzWyAt2NWotZ/YjOzx8lsYNcVNhY40FVWAxN+hYvQza6FPltcCWTGZk29u3CGYO65V6s6YEDiU53tiRMv0VrqZAbISfwRV2GbUU290vZdGeGqtjVvTPYaM4I0bvg9LUe6KjR9Y7E3AjCzQe+iLH/Y0CdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309231; c=relaxed/simple;
	bh=WBOwm1FM8iiMl4/EbShKWDrIsJ3+3lnn93+nu8QxH4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HVv3J6712goTjDgzLnbcCD1h9q3vLQbMUeHZ8vN8IejJGFBNmV7WbKBHGwi6RgMEOrazzyqb+QUtA/rD/UuPaHMh6YPpeNil3qh7VX0M8JTp6flDKiaW+3prOfpzYSNGJ3RwhSl798einUItmWcDj0rFbQdXnnOOIMjvefBpeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwqNXNDo; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwqNXNDo"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d137a68so11823431cf.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309228; x=1788914028; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14zjqv44VGG0GQmQRdsZ7UA2UrDxWUXUgWfhQ5+RSqc=;
        b=HwqNXNDojn23CnwDZkfUvbVVibTMvxmkEsr2E7AsFcgy/xS2JA9HfHmR+5+k///T8V
         txPCfxJ3feuG1GAA0vtoB9UISAEJPgDoSgFxnFRWk0oHCF9IuuBtdkRgB4gSJuzNrgbu
         RJ9wvm5TGUVMj/h+cWG9ybAtJio43HrqFWusehXZOHh5y45oKaUpTJE8N2oj8RTpAZ4R
         wQZW4x2HN+hSOJ4uiTkbBuSMIkA8u3GOBjYB2AIj4fJCx5iE6kzUacIKO02uAWqwy5XQ
         dFlbH6NayzZZEEEL5hB699OgDRggo744scxEWja9vopNUN+gfMBKbJ1p1KTc03xTDWjr
         0o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309228; x=1788914028;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14zjqv44VGG0GQmQRdsZ7UA2UrDxWUXUgWfhQ5+RSqc=;
        b=TlkVvDs1G4wzYh+qDWtEGW2Xnc4raLAXKfHfqjh5OA+6KZ/tl1CkgKKmwK/ao5BMBX
         /P2s5PyR4enKUjBM/BK630ZzHX6ngZ4ANoV1Rbd24TkRhVI/QtWd3C8xjY0ETGmS5DFT
         07e+fDG3CoIkN2B7PF9utaDmlh8IuH0PMRg7VoeylxSXwe4CKSkQGJAuLIpAQ7xQOcZu
         AmAQD6hwjdqFhVoXrGZSMAe4eTZJbXTz0nv0rdKpxqyzIyH+qeJiUQczpW5jNuhRhhQ9
         vf/paWl2cWwYwfNeXo3DRFxHM9H9jW8fL3prmi+p6/kz9s1HJVnfkilSp9WStQgR1kZH
         ahYw==
X-Forwarded-Encrypted: i=1; AHgh+Rrt0fbDQNkSKCZ89jzs7P3dEypcR/keeD3xcJ6akdLSuXticVv245bzqnkGCU58bKzHabUHzNI=@vger.kernel.org
X-Gm-Message-State: AFuF++mtj8TP2hbadfHhIC6X0TWU1N8QXQKwaBsNS/hvfNIO20+yboPC
	ej77nHCV+qUPL+E/wWT4jvf50qtUwRVGOR+JqWKqEnYt53nTHk6xjgInCBwpsjOmJMi5s7NN+uZ
	Z5vFqapW+1Hwimw==
X-Received: from qtrr18-n2.prod.google.com ([2002:a05:622a:a992:20b0:51b:fc9e:edef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a4e:0:b0:51b:ec6c:766c with SMTP id d75a77b69052e-53036bf7625mr10900971cf.12.1788309228029;
 Tue, 01 Sep 2026 17:33:48 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:35 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-2-edumazet@google.com>
Subject: [PATCH net-next 01/10] bonding: do not assume mac header is set in
 ALB/TLB tx paths
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue,
and remove now redundant skb_reset_mac_header() calls.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/bonding/bond_alb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 839f7482dc1823b12a13437a4b6639e3b63d46ec..3d2c6a9fe3b7bfdd46299aeff14689d323c525d3 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1339,7 +1339,7 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 				    struct slave *tx_slave)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
-	struct ethhdr *eth_data = eth_hdr(skb);
+	struct ethhdr *eth_data = skb_eth_hdr(skb);
 
 	if (!tx_slave) {
 		/* unbalanced or unassigned, send through primary */
@@ -1374,8 +1374,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
 	struct ethhdr *eth_data;
 	u32 hash_index;
 
-	skb_reset_mac_header(skb);
-	eth_data = eth_hdr(skb);
+	eth_data = skb_eth_hdr(skb);
 
 	/* Do not TX balance any multicast or broadcast */
 	if (!is_multicast_ether_addr(eth_data->h_dest)) {
@@ -1427,8 +1426,7 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 	u32 hash_index = 0;
 	int hash_size = 0;
 
-	skb_reset_mac_header(skb);
-	eth_data = eth_hdr(skb);
+	eth_data = skb_eth_hdr(skb);
 
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_IP: {
-- 
2.55.0.966.g6673acef38-goog

