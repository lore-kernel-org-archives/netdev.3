Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218628B7EA
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309238; cv=none; b=JYHt/oIwbM0uSZPBiowA0uFYtVRr17YTKMPIW+lewsQc/dFQvNTJkv7/KmZOQDp3sydABPP+SVIC3ETgVfpRV5qJIrleaWEufNIsCzn8BGPW8qPwt/zehjd8/dXcK1C/g0qs1OM7IuSUGngRWXFYp+XT5hL8vZVMLuriw7hrXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309238; c=relaxed/simple;
	bh=pfgGQPeQ6f1FO/f1aPTHHjYKPZ1JAPknYqLz5w4NlgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xw2rfK5CYKTqCTZ4jmibnpXshW0E1eTqIwnLiOK3aviCjCtBKbFiue17Csj1kFFasJDq97NVazVLMvs3+h59vRYoaWIR5QkgjHwOeXsSziTW8M78E3h1rbidWpCKwqZKLMfgtH45XK+DskrD0JdUtiCtMVgzo+shOSikE29rZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/RCtZHC; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/RCtZHC"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso9374441cf.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309236; x=1788914036; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFS62CPFHohhGRKRf2J7v/SfAoWqeMRRR/mDres1KHA=;
        b=G/RCtZHCqw9aLr7085CTwUZ02ystZlESTlOOrWqjR7LvvcDabd7idIi1LAqSOPbZ+V
         WPBJ0WKOeR+QEysOaHbrQOIZQVr+OIZECeJnbjmcXoORnVVpZ0sR1uDI1tzEpTHSjJkd
         nPEouAjHkUFJRSwkgrEImHM4T+Z4Iz0xxMhk/4KBcpQKI0lisBYVnYVCqADfR2fbhvcL
         izSST8iuBjIwtE2qmR+wKqNl+5SR6iBKv12XvAGMbVEISBqf1fe30x5KeOwEGWB02DJ6
         UP4d0n+m9WfzBf65hhKV3gc3R8ewiJpaZtDjsCVL2ZuNciVhT2gqiIWZHkeO0hieFvDq
         xtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309236; x=1788914036;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YFS62CPFHohhGRKRf2J7v/SfAoWqeMRRR/mDres1KHA=;
        b=I7O8W6wDP+a0DByRnfJXlpCCxbK8ia52qZfCagQp7Q5t1Fdp5LIOqW8DlrAEJiZAWC
         UcQ8IBKk4MK1HAILIb2uT4oFm64V3d505Z/ZegO5u5HU75FVSJw0d1dKayo4Iq+2Da2p
         zwyid0e6/BKTo+OAKaOTNVjQfZdhccentBPAkjKQiu4RsjWq/kjLkuimEZc/WKFFn1eS
         nMdwyNAbIHi0AveWd4mXH0LvytR/eG5t8B86Xojn0FHL5/CP1kd7VqW8oYOMGx12zjDH
         ddKe8tVb4JGi/TvFVy+XVPNml1IKFH1hWNatm7tfDZ+8cTzI4ZMstX2N8dACFlVPmf+L
         cp4A==
X-Forwarded-Encrypted: i=1; AHgh+Rr30KIiQOX4VNICjQTaNuvcrGaCyyBfmjzdyhiDD20XdsUja5r/fN3cGnlxuKxoA55N2QYQokk=@vger.kernel.org
X-Gm-Message-State: AFuF++mpYuG+/4QKUKCL/+Cx8YTLTfyg32xPnT8NYimlRjssjRg0htCd
	b28/pWHRfu6/km4ziyZgJYCU2PzIavuS+sJ1kcdICQXncGxOCe/nZ7DUThpZ53t815R8sT2r88b
	UPHuEAXxgrwumbg==
X-Received: from qtbjv8.prod.google.com ([2002:a05:622a:a088:b0:52e:f047:8481])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2c2:b0:51c:1568:3a53 with SMTP id d75a77b69052e-53036c0ea49mr8038111cf.16.1788309235206;
 Tue, 01 Sep 2026 17:33:55 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:40 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-7-edumazet@google.com>
Subject: [PATCH net-next 06/10] macsec: do not assume mac header is set in macsec_encrypt_finish()
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
 drivers/net/macsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 6f9f3aceffaad311d5d47bb93fa0df59082aa9f9..da7f917e71807410c050bcf4a8ed836272ab87cb 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -503,8 +503,7 @@ static void macsec_encrypt_finish(struct sk_buff *skb, struct net_device *dev)
 	struct macsec_dev *macsec = netdev_priv(dev);
 
 	skb->dev = macsec->real_dev;
-	skb_reset_mac_header(skb);
-	skb->protocol = eth_hdr(skb)->h_proto;
+	skb->protocol = skb_eth_hdr(skb)->h_proto;
 }
 
 static unsigned int macsec_msdu_len(struct sk_buff *skb)
-- 
2.55.0.966.g6673acef38-goog

