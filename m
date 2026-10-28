Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793168574;
	b=jJXMO/NG+c8cr+JNJFYxD1TsPjySOvATkdVjCyFWK4TKObqGT7Rv3Ud+B5sIsewwRc2M
	 AGqmNhfeU+frYwVOrhXkT8psCasaOBJe9VpueqcHerheLBnaN8GF0AEtgfTLj/otwbQwd
	 BFqZXqBOLH8/e6Ksev3VOLg0f9bIkzvOt4E71f9OpeHxjSWdinypHhmkIv6ojCwXewHi4
	 uaWQHJBjsx5q+eG/jos9+vqHS17d+l8KYt+Lw8hBk4WDx5vCscel8+VSj6m6im0RAcXmq
	 r1IRI7zQlJr92ELDKZ+YOwJdPq5JbiRiq9Ofz/m0lunU77lC1PSB9JfKIFcz3ogeHtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793168574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-Mailer;
	bh=SulABahkU3rLao+I7j5g0Ph09Yg6H2vGeWdscwhFpIs=;
	b=X+Fe9Do7ZVxtt/e9eIZDMr8uP2TCyh/LlaLVm0ciMjSs9AbOdpV6gUlbTR7Qi+v/Itx5
	 aBOcsG2DXpLuR9wozDAkPP89bSmf7a5P3YZ6+tuCRb1pG1kv72qca5uq8d3qLdREfgX/l
	 12ENCIBte7nGxtUUmnuHEGQwcdz7HycXBGdYMtLwNvvANO9TXULZIkIbcWdUYDgwyodzh
	 ckUkdoUufBgKctYZjpzgz0GoF5r4bqmydhDDmGWYEkSvMd8HjhjpfxSAm2ZZliUB9LBpS
	 LcCTU+v53qWLt+6i0Sy5jcuinwJRPw6scwfUsmdeowdMrIzbUYimdz9c3i/6hhZ1JXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bk++MV6k;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDD606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 06:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4DDD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bk++MV6k
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2e7c8213b09so1694325ad.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793168573; x=1793773373; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SulABahkU3rLao+I7j5g0Ph09Yg6H2vGeWdscwhFpIs=;
        b=Bk++MV6kwfBaTPsFQ9sPW6xVdQXu8QHBLNBmXn+4O5/4UZqCRMXj2JVrOkA0O73ASK
         UjmfdxIzc591iBllQHPYUS8Ru4hTCYR2k7f5FbUeYKYAjjWddLDzfKFvfFG/tE/iWG7G
         kdIkEkNgFScyzvf90nJziUXX66iSajGdCM9mpd1XJS5P5JjZVERSO9upDyUKUGCpPLP2
         l+BaJE36fU2n6FPqKPUz+fXH1HGgGhfJnC4i6Crg0DJFPEcI9WG6MYtV7KFaBPtMBx4t
         kcnIOMBDqZr88IhosTjC1ODmw/JZP7bnUSLnYqZJEQovxNIYaDtF8V7sVJ5vOpLE1xCB
         MJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793168573; x=1793773373;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SulABahkU3rLao+I7j5g0Ph09Yg6H2vGeWdscwhFpIs=;
        b=LfE3LRITXVVTSWnccYjN/Hmt90nV2cHTEeYAwzdB9GUH2ATEVP16UqBlWrvM47Bt6n
         Z24hb+P7Rce2u5GJ0bQ7T0S7G/vha9W9go6jryogcQZU2ndNw+6ZXoSx6d/DUHFsuUbb
         lSumTu+mEQpjqu8eI/R1MnSZ2Yv99LLF9SXnkK5XTeiBOWr6AJQoFDCwCabmSvPcLbY3
         bn+97Blx6alMiNiCBwpd1bA3DLmwNu+Pb1iNJ6M8egeGl2sTstceaYU8gF0hhvN9Jpae
         LVVB/qxMNK3f4ErgkP9leaavgU+VV+0wOTnFQfzpj9T+YDXshHjnn0OCw0jI6JuHb0pI
         U3hw==
X-Forwarded-Encrypted: i=1; AKwUvBzZs9Apv36y+bAlw/Z4gXIxA3LundPvXFF+kFFWrS0vU22rhzAkjkamzjv/k1oNv92L1Kgas50=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVwfnl7bdoAr6sKJeUBVhJVIHkmkExd2X+2IiCqpF9YeefcgDT
	kluh4k3YUpuPwcBaLDSDksE/8yVCLAJZd8/xGIHI7Nj4wSu1wa61cKm8
X-Gm-Gg: AYBFou2AYI3Ta9qOxxzSuuoGrdzHAvVT/iVSIcym6zNP+4Fuk9fNGjAuD5FKwakBTMd
	gUxjGjEVom2sf/O9Fcgo6iDsGrtpu2dZA0zsO9TnjjP6fYInQkfG+nd5SEcvD3m2XzFoyDLMI4z
	UEldmPWoD4Xv9a0VSZbEbg3V5cRQWKJxuhrklxAO+cvsOx2LC2YSdGTG+neHfzvBYUkwjPV9o2T
	SkuQSrxLMsLCGYs9IU8DbhWvgYqKwP0X06Mp32VhknH2RvY95nCbG2JYIlU55CW7xIt75FCniMd
	lM1m6MZ1SEnIuld1FiyP429Hby3hJn+A8eqsmvUxKlgjVxr2UvPa+yygPxIfdpM1Lr1iOu0QQjj
	dQu0T0v34zCBWSen/ssdnwRVEQGKSUkjdnlpyjmHlL4TbbA56bS03OkN1/e2Mif2RsWmfD7ELP0
	whijPC5+cZTSw+Q1nbZvL/OoryumFy7ku57onSoq/LGB6PxKaY0Z3tzj8JNPlHeQOg5EeyazUJE
	tuhG6gEM4pp8DzXFo9CmQqQczQkR8sOrBgjMu3PYAuii23fGbi1yVOoubRSNfvTrcC1XcScKBXw
	4HDZ+AaAE+rlS+VwvDaL
X-Received: by 2002:a17:90b:55ce:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3ae5832af4dmr1018817a91.67.1793168573088;
        Tue, 27 Oct 2026 23:22:53 -0700 (PDT)
Received: from hhost ([120.231.212.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a27f7c7sm1558410a91.2.2026.10.27.23.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 23:22:52 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:22:42 +0800
From: Xingyuan Mo <hdthky0@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: Xingyuan Mo <hdthky0@gmail.com>
Subject: [PATCH nf] netfilter: nf_tables: fix flow rule leak in nft_delrule()
 error path
Message-ID: <20261028062204.1079089-1-hdthky0@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0

On the nf_tables_delrule_deactivate() failure path, nft_trans_destroy()
frees the transaction but not the attached HW offload flow rule. Destroy
the flow after the transaction to avoid memory leak.

Fixes: 63b48c73ff56 ("netfilter: nf_tables_offload: undo updates if transaction fails")
Assisted-by: opencode:deepseek-v4
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
---
 net/netfilter/nf_tables_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 59ac623e6805..ec56ea8c8436 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -752,7 +752,7 @@ static struct nft_trans *nft_trans_rule_add(struct nft_ctx *ctx, int msg_type,
 
 static int nft_delrule(struct nft_ctx *ctx, struct nft_rule *rule)
 {
-	struct nft_flow_rule *flow;
+	struct nft_flow_rule *flow = NULL;
 	struct nft_trans *trans;
 	int err;
 
@@ -773,6 +773,8 @@ static int nft_delrule(struct nft_ctx *ctx, struct nft_rule *rule)
 	err = nf_tables_delrule_deactivate(ctx, rule);
 	if (err < 0) {
 		nft_trans_destroy(trans);
+		if (flow)
+			nft_flow_rule_destroy(flow);
 		return err;
 	}
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_PREPARE);
-- 
2.43.0

