Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551360;
	b=gfQsr9CsmxDClAM5U9xCbMnNYXQJEZcR+tO3jDQfedbhSK6jSSuxWhN/OTqBLXUKHXNZ
	 TYs0RY4rnSvU4yXrPxXqZhY1hJ3y9Ah2/T4krx5hI27PU2zkQElHJcOjmqP4qwoZKb137
	 D7W/A4x9XRiHsRk3RSl/OUfQ6eCnNv0TZZl/sSI2oevnc3TVu4Gl31gYR4JStmeF1bZTZ
	 4aROrEW0ox0ih6LAfE4gtOAKAK9MHRLVLSDmZV8+6OFwcenmciYySHHCYiU4jRK0iRTNV
	 189rOHpjMHlkgRSm2nBN+IsjdUa9z8nth0hpCe33vuqv1rt0+Q56hHR87zjoYwusVTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/WNAnBkrbcrEaDn+R+l43ZtITCPYDHBaXxtP7LcdE9A=;
	b=dfMje8WAD27j48JEi9m3gSs4B6aXxuq+ce1bRJQ1vfpuVPUhnm6ou2qUaLDscpK7/CzJ
	 j1Cmve6vfuzTB+jPOmoHGkzw+0DDCLt1Zw+0kbXbsz7PIHKqwQHmgGNtwS75CwcU8zLpp
	 KoGDwDly/SQvkB2G8JqQ/QkBJjFPQQTZzR1SjCIDM7CmiBz8kxjKT7jzdSeIwh9g1l9pR
	 P5IVMWLC+UMSsqXEPjhG4Qy6M2z7DrV0t3mIUeR2LPUgV32SuwShTP33yN02kfpnCgMX7
	 SbDtsU4haCI35TVlph+8NLKSXU9vEEBclQLolc6XWdZDZ1zjIQWqq6fBQkNba0HU22A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b="rqw60U8/";
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857960A2623
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A857960A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=rqw60U8/
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4550d8ab15so261946766b.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551358; x=1794156158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WNAnBkrbcrEaDn+R+l43ZtITCPYDHBaXxtP7LcdE9A=;
        b=rqw60U8/IjWMUYGZp3rGQovjPuSBBIYlg+7Lc3yabzijOBiIqmAASC3rLs2LmMpKVY
         k60DNa7TR0hpQ+J1DJfyuz2v+QkRX2vRZrC0961PtLqU8ktNbmVi+Nzx5TMT5m8wg+DB
         OWoe9zWHx6XEfzxLz8SlJjWgYcgbkJ2/pTtucC0gXseKwYgEheH1soB7h5Q8xApaqCMY
         l0m4YLA25C/cGGbE+ZvgPUYe66YkHmGgKsq+2gffTQIXuw4ABarfaNRsIb1s2ZeN40Ny
         NOZVHKPQs7+II8fcs4sSzDFCB7nQxCwNsylVN1cFblrtuzuh/RDGfot5vgSSswOLbGV6
         fukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551358; x=1794156158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WNAnBkrbcrEaDn+R+l43ZtITCPYDHBaXxtP7LcdE9A=;
        b=t3LeS55yXH7P+rBnE4tG0CC2OKSoGEtZXwhW+/LbcNU7nvn+6eR1wbEUOJKjQF8pNe
         eF/CxOaiL6bsLZ52rVBuyLwLkFzJkzlOzLZ7wvHQvvRgdacJISig+UghA+H+8iqGDVhy
         pzElsAk7ZdCw5p9LxKFNB0cCr2EC9QUpoN/WK7DIWakN+609KTeuTU1+OSb2MYV8oU4N
         lEUxGmDyUKIWGPNKS03B1qc3hbR+lx4/TyhUXv2xkU85Sd9PeoCRBOzE4IW9EtD9w7Rw
         gUJIgPJOhrEUe/ZLTrTqnE/44jw3hQ7b6nS1h7KaHx6gfCY19r/lkGaO4b48aTr0K7Ti
         NP4g==
X-Gm-Message-State: AFq9FYJ8tNpHu8EpBoW2L9vTLuVAmmG0uoXmsEPQSM/mPtQRiUdcGKSb
	nOMSME6J1YkHmklGYeLozRLFzdsafPYDxObvzK8gELu5yqTesM1rXTm0bdqAykeCrKsBnAzr3b0
	Co4ZgLqBr
X-Gm-Gg: AYBFou0UoVq6OfHFvUSkDSPHmE+SVot4ve/wmnsm3+Pm3NRZRohs8xyhIRfToqcbJ5u
	chvQC649+IE0d8dRB5pfaTQedVMs1PDO0pdbe0+ALZ1lbWbS2K7TbwDF7XoyIXCoMdTpe6TFYXn
	DNWhH9r05fp9TnpsXhUUpNT9Q3UuJwQKohxIhi/qVyMFsoyOz42RGCWPYiAthC0mbNRDDfIInIB
	lJ2jJ2XhCcox1XSntVuOw1ZTD8+/rDiGMtgB+NDLxUi9PUGp3mEMdRwXrL7hu1PRw3maL9IDlKn
	uYmNpYBSzOfkqDLoQhmAfsPqA1biBeHJUGaGI0/3K8pJFrdImPpQeQkQXia2786XLZexEuFyG2C
	3knK8SG5mxIDIME6qga0c52FV5MwRqLLttIDZQT4gZKmefa+euwBsYFGiOWUlupzUOzSp3mEU5F
	SxttiH0MRWUAuJEQfRtp6oK0BY3FTUsO3Elc9pv4GmSqw5QQ7ptbvTESsYdfHHrTPl7+yf85ayv
	Q/YD25MDkuEcLG9mmBE+bumexJUg32t5OxSC8iBPVOnUcudE3bos4Gt/BDoFGijdiVnbrIo3D6u
	K35OTTnDgPZegrAwi5rK5EMYYgUyrCW2MhIsZHCf3EPhGrqvnUmXIAXRp4yIvVozoBz5E2JWwVV
	HrEGL7iJEeBnnZNM7Cnm5g0EWzZ+2LR55J0WqoiLmvrp2X8pr3PtKI+1eeFyGo3apxInVOfH2Eo
	B+aA3+gQ+AeV/riP8Eiq3aajn2VZPPoCPDD6hgOIqcVphSLAAfvLkjVe/V6G7vmBdn22PutBHQn
	NHEYzkuLQVQ1bbUtBpgviXsk5XkMU6meJy5O270tH1Fap32j+e3E146dVjwATmagOzCEvvzW51H
	tgr6br8PHfOfoHEo1PQ=
X-Received: by 2002:a17:907:9283:b0:c41:a5da:1511 with SMTP id a640c23a62f3a-c4ca7a88ad4mr596253366b.25.1793551357608;
        Sun, 01 Nov 2026 08:42:37 -0800 (PST)
Received: from Desktop (p54aff88b.dip0.t-ipconnect.de. [84.175.248.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0f37esm296622966b.33.2026.11.01.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:42:37 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 4/4] ipmr: do not drop GSO packets that fit the MTU after segmentation
Date: Sun,  1 Nov 2026 17:42:32 +0100
Message-ID: <3733295a358d34df6220ea924d2b710ca537cf6d.1792838740.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792838740.git.julius@bairaktaris.de>
References: <cover.1792838740.git.julius@bairaktaris.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_prepare_xmit() drops a packet with DF set when skb->len exceeds the
route MTU, without checking whether it is a GSO packet. A UDP multicast
stream received with fraglist GRO or UDP GRO forwarding enabled is
aggregated into GSO packets, and every aggregate is dropped with
FragFails, while ip_forward() lets the same packets pass by checking
skb_gso_validate_network_len(). Do the same for multicast routing,
leaving room for the outer header on tunnel vifs. ip6mr has no such
check and leaves GSO packets to ip6_output().

On an IPQ8074 router with fraglist GRO on, a 10 Mbit/s stream of
1316-byte DF datagrams routed by igmpproxy loses 14.5 to 15.5% (n=3)
and 0% with this change.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/ipv4/ipmr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 98e38839f8ccb..1fb728fb15741 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1932,6 +1932,7 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 	struct rtable *rt;
 	struct flowi4 fl4;
 	int    encap = 0;
+	unsigned int mtu;
 
 	vif_dev = vif_dev_read(vif);
 	if (!vif_dev)
@@ -1964,7 +1965,10 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 			return -1;
 	}
 
-	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
+	mtu = dst4_mtu(&rt->dst);
+	if (skb->len + encap > mtu && (ntohs(iph->frag_off) & IP_DF) &&
+	    !(skb_is_gso(skb) && mtu > encap &&
+	      skb_gso_validate_network_len(skb, mtu - encap))) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
 		 * to blackhole.
-- 
2.53.0

