Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069470;
	b=jkIoJTBIwQS6LtD23Ox5j8QxsrAm9P6oo3gWE9HLOJUjsbeCE24JfGPG/ACyW7gUtEaD
	 V0hKufY34+IcCVDPHyh2AzmwX6Y/tkOD84O1J2aSqWQV/vwdy9EsW3aOU92LNdgBJeB4t
	 2Pt9T0x9oVkQ3rtdkdPSJF70F/tC8VtGzstadFrWUtoVrzny5HB4WF6QFoeRzbtsuWdyX
	 JWf5FG1zLn/QB7PbiwE0upwL+6CNxWo4eT6scKt8FeK4X1nr6lNvIDaeFjxYcsoFPwT+Q
	 x36v46ny0UJtBjozh3LSXykBEvxSqhl/sVpL7pyQp4K5wioVGAa+staN3b+DZsCoEIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:
	 In-Reply-To:References:From:Date:Subject;
	bh=LYzIw2h63C7TJ7EZ3aau0el7NfxeZ14SAIQjRaCB+n0=;
	b=Y2uJT/+DHabXoyUxphPClObWjxV1wvebX1CN172Ad13JY8gU77YLdJh/nydjaBmgYUoA
	 cb29VDx34ycJygEPS3jy/ng7IBZnXAw87eg2XGNKamW62c+/l7cxZ1YV5QsaorxiaLmMh
	 P6IXQCi8MbYQJp2PnOxnuqkC4K3VNtVUu0lWSJnY5FgrSf1dAr4ceBnnxYS401J53VYN0
	 0F/ORSV+VksYOTe0g0ewWExCxgNm2yqo/nD4J3rk7X7HZc85Fj0wO+7FQRsk271dVpWh0
	 F0b1m/zZ+WoVX8kGho456Lo/a3c/Ke1ptHE+xRZEI3vhX+9xdidUJNiNXLoWJio9ebA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dHVMlYiV;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759DC606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 759DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dHVMlYiV
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad6499e88fso541741a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 19:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793069470; x=1793674270; darn=vger.kernel.org;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LYzIw2h63C7TJ7EZ3aau0el7NfxeZ14SAIQjRaCB+n0=;
        b=dHVMlYiV0HTDZdxGWizwLohev8WvIys6fcn8S2ZfUGoHWSXoqj2+T422EoMgrvxE9w
         BHk6wUnnyFNHSp8iFbRfcPOv6bRAvfY32ZUFe2Xda56jrOXzKGiHHWG31Pq1NGaKlaxd
         eq+DXle5XLjO2oIa8sDB0Z2GIttTaZdtBn8yNOvKPfHxa5myGihCass2DPWZjCd56wmt
         AsuzsDkU2PlRUccTETcU3MJ4L+wQE5ZWNNcTSyuOf8cCYHMgquf57ss8ZW0OP3MSIP3G
         H8MNAwsdb36OH+0+Pqm3wyrhngmz+AkNMYmor6LfT0l5tzIROV5qWJZCjeY3Xzoj3eDH
         /CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069470; x=1793674270;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LYzIw2h63C7TJ7EZ3aau0el7NfxeZ14SAIQjRaCB+n0=;
        b=cp+izWBI8JCxHFHJUXNCZuUgiufPjtQ9tO5U6B3T/XMs14hEVt5e+wtWXsDUZ0NwtV
         1P6145P9mUvsiFpg8CjNm1UxCAyyxyLGMqA4TH0XNcgzfRZwVA8kZOecyUKRCUTFP4pr
         jCXwBno++LHSKHoE95fBuz6lsvnieQj8XVLL1dQ0d2Sy25GmgPgMjlZqC7yPBjwqiKHN
         CBZlSfIy7d4eGkNDKS1T432o45G96CiWfDxf/ma/PzurmgbPsgO09YQJgutgwD3G67f+
         8OClP7xXkcBip6mNlKqzT2lPk9TsPHxfDCVie6Rvc7TophL3yfHWHdcng1n8LyqCjO/Q
         D/Zg==
X-Gm-Message-State: AFq9FYJY/vgcNZMRRdgZTNAsFwjNaghZ2dBD1hNZ2QV/Wo+DtzyY7Jjd
	3YVIYj1tclUMDtccGJzTZiZUw2JZJPrlg+8DK5bQzcWV4yUn2RwU/iX2
X-Gm-Gg: AYBFou3sKDzVeruiaSaVVNCQBVbg4PI+FebLiNyordRhWlJWt45hc3+5+SLG8ClRhup
	i1u9CpIKkCHlPfWnto1evVz3kzFkk8WW1iluM+HskRy4S60tNg8etNGMqGtLkgMZYHpJ6LHfTRD
	i59VuAGjQmJX/XoxcnLeup7QSqEOfke7wzbfMnjOdKpgij/7miJ4JpCFteSg8iGooM/dB5lF3Dm
	48PmewTQBYpdOTItjyWG5JmU3WJqum2N4XjMQTHQvtdkgYCBeX2Ag64beR1lmpIoopBQE9w7Xr6
	d5GH1ltNHTmTS7P3iB3GFeOv+xeiwQc2ERDwdmjEO1lIFaMg31EFWNOpoAegRpYkaoygOWsALPF
	9gY1YETcueLvIm1ZO+ITrKDFfFfAA8TP4SM+PX4BeHsp78JW7Yr30MJwWJlriJdKIC+17vc+Wur
	Uj8E/M2YL+6LLykfVgAVLU8ogBTVbn/UT8RlItuSx1ejbslBPooI8l7u1b1d7tjf2T1dmuWo04B
	LqzdlVX/IIClCA7clS6dZGz8JXuCnHFpOwFSKK4n2ifPda9vLUHGDABgxWH5bodGKl7VPMursir
	yJQYFdkzk6v6REIkWfDlIY1ziCiJJGwR4cYN1CJjtsANguaK7Xm0f2CUEdbfJsPTtQbRfrI=
X-Received: by 2002:a17:90b:2ecc:b0:3ac:e6a:1af5 with SMTP id 98e67ed59e1d1-3adea1f17fdmr12335096a91.2.1793069469769;
        Mon, 26 Oct 2026 19:51:09 -0700 (PDT)
Received: from msg ([188.253.120.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb82761esm6930676a91.0.2026.10.26.19.51.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 19:51:09 -0700 (PDT)
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Message-ID: <20261027105031.19928-3-q.h.hack.winter@gmail.com>
In-Reply-To: <20261027105031.19928-1-q.h.hack.winter@gmail.com>
References: <20261027105031.19928-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 14 Oct 2026 21:17:12 +0800
Subject: [PATCH net v7 2/3] xfrm: set the address family before the early
 invalid-state drop
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The early drop in xfrm_input() for a state that is no longer valid runs
while family is still AF_UNSPEC, so xfrm_rcv_cb() cannot find the
afinfo and the receive callback is never invoked for such a packet.
Set the family from the state before the check so that the drop path
dispatches the callback like every other drop does.

This is also a prerequisite for releasing the tunnel device reference
on that drop path in the next patch: without a family, the release
cannot tell an ip_tunnel from an ip6_tnl.

Fixes: 4ce3dbe397d7 ("xfrm: Fix xfrm_input() to verify state is valid when (encap_type < 0)")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_input.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index cfd5cea033127..ab391258a5028 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -487,6 +487,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				      encap_type == UDP_ENCAP_ESPINUDP))) {
 		x = xfrm_input_state(skb);
 		xfrm_proto = x->type ? x->type->proto : nexthdr;
+		family = x->props.family;
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
@@ -500,8 +501,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-		family = x->props.family;
-
 		/* An encap_type of -2 indicates reconstructed inner packet */
 		if (encap_type == -2)
 			goto resume_decapped;
-- 
2.54.0 (Apple Git-157)


