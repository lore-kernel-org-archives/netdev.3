Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40B542EF2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080053; cv=none; b=KRRSCRITp6lans9OfHUenX5k2p2xBMZ9YFylts0fcxa/bzhQn5ibzgoF4JQo7OX+f9LleNyaHYUiphqp7Tdc15aqRI6UXG3tbF7Uu/WQ0u+jAulX9WPBOTxnbf5Aoj6WdjmEbWIjoUV0ht/01L439Gju5D4cvfzasWe1ary3x5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080053; c=relaxed/simple;
	bh=YpfW/Ctyq9vb7xt+4IiyK8k59VZYaFPOFc5ZL1QX4dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NI/chYxOV91gMDCUiqdOx018l70OvN1Cp4FxRDdM3rVvDRRKCxGIjgjn/UA3+jOpptTxe7pJqYafWRnYKD1wp+Z2SKgf2zxj7AvlW6Q2XGFFn5sMzb9RFclLIe1ctPH6qvQ/Xud9DSpj1w9jyv7yIw1XhvW5TaGUm5lrsc6rRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0WzsOoy; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0WzsOoy"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-532abbd5a51so70467051cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080048; x=1790684848; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VaUxoHzEsNrkVC7Scas94TQv4mol+kGNEzxDUq0Chv8=;
        b=b0WzsOoyCq6E+vAT7nW36hM2iifBicC/ARpyQVJ47MUCko0Y7eMYPl8rcQSH+tx0CO
         mQU8LbM56GUQ8sOoKxaIlVm/L8bvdN9KAjX1Au22zn+wt+UsoGdC/YoeJBvQtRugAln8
         n3HNjQ/TrHbpe6tzP2P5/NLIqMpf979YLbpzwl8KbP7929RnqVTQ4VU3SOM+AXd8mSpg
         hJtZCAmvg4qn4hWc7LqmeQtvUsVvMme0Abfaj8iAxvKKiZ5H+5SuvhGuCaZVucvLuJYt
         Ny+VDiCg4q/ObzZOUTnDvIyAmpuM1M1cRL9nGRZ3KG47btCDGDjrlPsX1McT9u+R4ikK
         F98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080048; x=1790684848;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VaUxoHzEsNrkVC7Scas94TQv4mol+kGNEzxDUq0Chv8=;
        b=l/NbnFbl0jLMpCHW0s5vf11BP9hvsu5mWPhmgj78Znl+UFAX8ZSgb/LwPnkDNLYEV5
         gRGIE57KQEbeYdRV36HQ2ih+R6jxnxaZ9ijRMUwzR7GlKZsftISkGR47X408pKC//OX1
         nCaI3y9cpQ6LlSubeW048pR5V9ikiZDo86Rm6ny6XmRcDuz2Mikd4mXInp0h1d6twoOH
         LB0vPtB/1Qm5m+a18X9PFG+eR2koxk2yFgdDY4AZAD+srUX+tD1YPuT905hhh4Tr31n3
         9Q/ZckkHM+2a0hk9pThTv52A/fsovc0JjJYdLm92P9jHaCg7Ptm4yJNN7A/bsLukmGKf
         xyDw==
X-Forwarded-Encrypted: i=1; AKwUvBzn3uJhvoNFC+teWIcEix9IN5tXbCqBS01raSH8y2t2gHzGCfQzFdf4sIe6AlKyZYHueeeT2M0=@vger.kernel.org
X-Gm-Message-State: AFuF++mQBrL+vf+eP4NYJkyKXXVP987rB34g6eCfamBKrbb4yOr5nl9L
	96exEQ7JEZyhSJ/jPSFWIg81ol6lQGoBYXVOxeD7H8DkNvJ+xdpPUCAa49adiFbTqdyiFoVtmcb
	29t899sGuvPqWZA==
X-Received: from qtpp11-n1.prod.google.com ([2002:a05:622a:9cb:10b0:532:a28d:9eb6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:113:b0:532:9adc:639e with SMTP id d75a77b69052e-532d8e708f7mr51408341cf.66.1790080048103;
 Tue, 22 Sep 2026 05:27:28 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:15 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-5-edumazet@google.com>
Subject: [PATCH net-next 4/9] rds: use sk_set_nospace()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers instead of open coding the SOCK_NOSPACE
manipulation, so that TCP can later maintain a cheaper private
copy of this bit.

No functional change intended.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/rds/tcp_send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 7c52acc749cf4d4003c749a2646c2b4f87f207fe..824222c475119d91e333123c5afc9291005a8696 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -100,7 +100,7 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 
 	if (hdr_off < sizeof(struct rds_header)) {
 		/* see rds_tcp_write_space() */
-		set_bit(SOCK_NOSPACE, &tc->t_sock->sk->sk_socket->flags);
+		sk_set_nospace(tc->t_sock->sk);
 
 		ret = rds_tcp_sendmsg(tc->t_sock,
 				      (void *)&rm->m_inc.i_hdr + hdr_off,
@@ -221,6 +221,5 @@ void rds_tcp_write_space(struct sock *sk)
 	 */
 	write_space(sk);
 
-	if (sk->sk_socket)
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	sk_set_nospace(sk);
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

