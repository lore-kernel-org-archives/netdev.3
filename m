Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155843;
	b=qlf4j1S/Txwih2Hr8mBfE4OT51HMfNg09ID3mtygBKanJMB6K0aH02ZAz0xKRhGrU5sk
	 tsL1z7Tsaf0PcuF/eqVMLbbZFYEmnNPF7lKjIeTnFb4ENwo563CwJlrWNXn683/s5eLs1
	 YGMkyiceTIrtnwPpEpHzUVu3ro+0zMLG34WyFTBcQHCLVTfeLz5mQVB6FSZ5mJAD0XH6U
	 Gf7iANjXNnP6pCmkNQ4fKdXQpqDmEiD1qh4q9EqXloJ/55pOdqTxtEVrND0jZteKKwVKn
	 DUl9hB7uWhXXxOpzzy0gqk9oIkxYF7/YI8al73EZ4pZO+0OK++cBfEvD1JTfRM+4Ezw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
	b=u9x9aECeG3fTOL6XBtzXk9AvKTz/E/EjzQQn8SUV24et5WidxgOWQB/yesii/RuGf58R
	 MvnGK/9Xm5okjh35F3WdP3dgX6aIa9BWNuo7MCXnK+aIsIcFMn1JEKDVxDwULF3GRgIWI
	 GClD194KsOnO7OJnWbi5aIY6tB7nsRoSmmM5uRjU6PW0eTXAWBPsKMajre/zb1q12MbCS
	 L+2FBud5dB9hZSU4t24iptAyjDWbbZgzeVEKQt/+h/wXFqk+9CSICdpn7jp+1i06pPy40
	 dhpnGG2/GaidEcZ0Pp8pwcmdcJqn+GF4VLfyQY4LBzaJ3RI4/O6GyXSRam8HvkbxhOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sIxGQVuC;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F64606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F64606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sIxGQVuC
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e651c30dcbso1282245ad.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155842; x=1793760642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=sIxGQVuCcRBJM4Y9dM+uPj1MqVYGHELdrlvbHCe9zroN36ORPXLLIpUOw1Y6USdWW6
         7ef1iCd9EeBB9i4GBNCqUBO7kig/5+eAom4R2U2fo1nCFMDbzDqNlVamlytn9yhKL1GU
         RuSCEC78ZTuhxP0oIx1itKjzAX43wQXc4JJ2uFJUXQBy/kNfGdzUPitJ3+XEamRRz39h
         VElrB6cmCShWH9Ye/+8+MSZ1V5L/dOAjvzwjyMmk0TUqbDEsTAEobny4s4FEoWzyZZc/
         RLFqY/AlU62Pu+5gGGZv0DS5CwCRjKulSHKlzlLuts/4LH0iMOUeyGZ8+8jAxm2hsAbC
         ExLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155842; x=1793760642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=XxU6b2WCTyTdE53Yx0MyZGsz6gaEtHp+a6PKhaNDRtp7SzHbrruJz2hGwDJrJJ8f1L
         NTSWsvblvuCGzpixBZF19pNnKBi8ARBZqw7K7OzH0xmKp/9S5Ijkh+yH+wYsB5/gyttt
         ie27Z7AexsDM/EWbyxF2QfgNwc+PbLSvnKnj8nVDfbWQJiN8qvTa1osuoJIMz7OBtuvf
         UFj4KTWZDLrvaAL51BBGb/G4lZ6d6iuRMu0thd1G4yha0pUUy8CwkaOpVjvpIRG070Af
         wJR2e4Qbdx3o/atjqCsJMnpzAr+tKMYZLPWa+ji8JYmh9qtf2yrEPs/T+B7RTXJfQO5I
         cu+g==
X-Gm-Message-State: AFq9FYL8F48EJGKxMzYxqsKrrHMR0sx2OaA2rC7DDFH3C1exfI8gYUiG
	EfcUmhvrFklDH9nTaz7X20OmBRCZr6dcTAtB+rmPNkcKLXxcfizLkcmo4FaCYogWjqFd37Ih
X-Gm-Gg: AYBFou0i0ueUQ6kOtpdjHT0YVzIG3kJm+KItp6zTBAFw/CidnC02stnqmn+Irg8LnQ1
	VRjrWMYvZxHugUhkomI7SDq+eSFR9owIwYbuq4WoalhP6BvtowD0/a0aEYHaReoJaakHoiF5g9U
	ZtAut62cHsNzbYp2u6FQ0ijJwwgLf80VrqDmCN46RWDplsEdHaSdhlkWgnumWU3O7EajXVPeG84
	mUolPgEYRXfrPHCDcrbGmMr917qtWKM4xJ+r1n9uk90/v2I5ROyU57mNeju0nLV11X1PE7wu70I
	+CJnShxyCb58SoEsxqEB7RZLi7jCPy7TLZzFaaBCxURjbiO5Mst+9h+ud8kq4dCwTXz515vXq+M
	hUcaOa8DB8AArIHtCz6Unz9/5L6P7GAktu6qs27Iz37xt7rCQr07GQuJU/glg43+jGpUV9T4uus
	6BZ2l7kAAZqCt9MoxZk8pPpkM2z1//6QW4W0REd+IAlMpBAd4Vm+gfxxDGY1S48dnxnG70vJ1ds
	C1OeP0LExOFJ1kvBhdLjcI1Ppdj5+mZRsUybHSjsGWCa6POePjYyYkiAa7LLJJMtlSCJPPkWyVj
	pIGCjXJYoeWtHjre/DfdjenFhCE4zNyzO0nBTbdUwGfeKRFaJr4lNSvloqDg56c=
X-Received: by 2002:a17:90b:280b:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3ae580df868mr793396a91.41.1793155842143;
        Tue, 27 Oct 2026 19:50:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:1d00:2b84:48c6:402f:d1c5:644a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm812447a91.1.2026.10.27.19.50.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:50:41 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v3 1/2] xsk: defer software checksum until the skb is complete
Date: Wed, 28 Oct 2026 10:50:25 +0800
Message-Id: <20261028025026.11401-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028025026.11401-1-testwrzwrz@gmail.com>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
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

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..aa6b010192ad 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (unlikely(pool->tx_sw_csum &&
+		     skb->ip_summed == CHECKSUM_PARTIAL))
+		return skb_checksum_help(skb);
+
+	return 0;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xp_mb_desc(&desc)) {
 			xs->skb = skb;
 			continue;
+		} else {
+			err = xsk_skb_sw_csum(skb, xs->pool);
+			if (unlikely(err)) {
+				xsk_drop_skb(skb);
+				goto out;
+			}
 		}
 
 		err = __dev_direct_xmit(skb, xs->queue_id);
-- 
2.39.5 (Apple Git-154)

