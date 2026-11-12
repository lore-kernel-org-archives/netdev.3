Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478136;
	b=p/0HNmnalvOjfqLcyxHACMgZFPb0hWAJyqL/ThxMrqJJoO0DjNMSYxULHKoPJsitZ16P
	 pztjmgpyNhc3GEJuHJrhAnpQhb1CHt/nit2MJe7KD24Y3LL2e5iEq12Y+Nw13sS0Xdf0F
	 oMBYv4h4D3+2fvyPWi21kxH0XGV4En5X2XqHJ1Se3D2cHG/lE69h8mXPzcheFlbPRJgE1
	 NZZ5vm+a8gOkZ+cQFscZO29GS+jrxTFWrLeoTokd7hI2GXkWliUdvPjUrxvWLWRKBS52O
	 qZS1LK4+dW8dZluSO8HrIC+YfrRFKzPWrsx6iQcQm0qOIea7legm0r0uTvijfVCnxuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=IahaQWnW2L3d2rI5uNi4is2Ap/AkkkuOCkd2M+75oU0=;
	b=Bkq2ahfLO80K0ia6FfrSNv1eQyFIRof6E257BIzYOjE0a05tGRmNi08YB2tOg+aJXifY
	 YOUzVHxiNIDbG1AOlU5qp/iaXKOFo8bcBPn601rQSRV4sdBDInU2utQHhreSN2s529POO
	 DwxJ5JKJ7pGfzrxMEOi9QgoZAqfdaDRcdRlmtwGvVEf+3Q9JswTBdrB7i/IjdQVE+JwjI
	 Xz1pTgcSA7TIHZahjl3Kf9haVJEtrtaMzvxWrI0ygEQjmuHHEsgG8ljhPj3/bqEBudg+i
	 t/aYb2S34Yvr/wQHBl3X6aFRpZM41Veop7kQEX0N+A+/Z92icR4AK0IW8PeCEyg31GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P7BNzbql;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7E606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B7E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P7BNzbql
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so48016985e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478135; x=1795082935; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IahaQWnW2L3d2rI5uNi4is2Ap/AkkkuOCkd2M+75oU0=;
        b=P7BNzbqlel+Im07I4ouOc191Y1OxCsDaPnWxNXwbbWO3MeDCBhfLunRmAP88K560Y7
         D8k3kxGbhBmmDloc5oYxXIGTC7V+BIdkWyBVXBiDhQpF6gLaEGjoer0OhfNVKM6md0Yl
         rtc6B4f+NZC/FoDYXvKu0B6aT1ipwWOWta3cZcupb2KRg6TtCyy2Kp6Lca/j89UXo53C
         gpIdTSZju9hBrIRs8d6T73+35AMRGUxAf4iX9QRma5KlC2TQSLFGYobjHHkQCDZNkn3u
         wXQyIaaRHrmPJZzS25QvnId8BtHhJe34WQMBGQKn+pWmoohLEq1Qc0o6aqwM8x2h/Zj7
         KZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478135; x=1795082935;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IahaQWnW2L3d2rI5uNi4is2Ap/AkkkuOCkd2M+75oU0=;
        b=cBNgvtou2rrlEF1XcLAlfIvA2TbjV2OLlttu8YcmnF2doGaPa3w5vkSRByShGaPdOb
         EhAL+QcoPlZy8WBBGAhnyPM3iqQZZq0HdvWnn4BrVbHzwXcLtOGm5IA+VIFe1Mm1KIuh
         MTbbbtm3ly/Qz7L+xWPqUPDp1dkBk8/J/sh1thYTj6G1b/wWthSEwA3DLyyi/7eFibi0
         Hwuw+VYBd3sn5otFbxyD/2Cya+IuUF4q7Xqze1wNqgdsaeBlTHYTYZSctGl1ZuExI8wI
         NwAzF94c/kc2qraD7tjV7u8TLYR3w6Bf67FA1iezfRSlEap3XLdoYPsIoQsp9eFsb1Cu
         YESg==
X-Forwarded-Encrypted: i=1; AL+hErEt1YIPyVE6UsyFCUyyFCc+sXf9b67kG/sncIuwqSYJFcGMDn+rbl9jsg8R8dWle/OfHVd4vYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LD+j8IYklL06dfPXioW5JTfKx8U143r6GnXchnJNh98KOVt3S
	eRD4x21G4V0PNDEh3elHOO0K+uHZytn9OTGUqOLC5UxuUSkI/GVBOjpx
X-Gm-Gg: AYBFou1tBsbLE3vThKGamrgxRd1axMNPjcB4rl4zxBwFHgrOSERKUfnhsDKueBhLtQ/
	9zBI0p3P6++d2IHTNvJyv1gnycbwp2idr8P1tUCRZrDfcdfZEI4WHDutAu7mGNuU9GJSSTIBmlR
	+oni0UFhO7GVJAv21M4tt4OaKwJNvLTA6mD1cJzDwkQW2zdGCuM3VmS5+hCbiX3ArJk0xWQpjPv
	4MwAMF03tinVSuByc3RTZCBr9J/wGA3Xs2Fc5UUa7nuKfBkWwLrWszmbjRjCOid5WYs2rA2y/gX
	u1m7+4ubDP9aX5jb35gzoVnsU+Rs9iHlhCLFldGgc/HQM8I+SdvZLYNVEuoLhqE+gRwCVAJcrbc
	wT3IrTr7WrT7OfCfyWvT4h5RFOXfPMLLMlH59VdlOO8pOj+lqdS5l0D5k3o4h9mNKwEUMZnW2T4
	uRRrKah7je6LzVLYZpEFZ5K0layTVOZhwW6t9JlrsSg7DMrJaoxCI4DjOAEPsDMCRCY5ClvRQ+p
	vMHVT5k69WthspdkCZS4/sz5GSTJFmTexz0FLZgH4benIGASprrOQgAUGAAgE64dJNWTi7kWkg0
	tWHvCrFpWL0DL2PKPS5y1QLR3fntpVBVkGK8hHLiiZv+2/QopkI=
X-Received: by 2002:a05:600c:8b22:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4ba0938a590mr91246165e9.27.1794478134548;
        Thu, 12 Nov 2026 02:08:54 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0953d26asm70701795e9.4.2026.11.12.02.08.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:08:54 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH ipsec 4/7] xfrm: prevent AES-GCM nonce reuse after early
 GSO
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 12 Nov 2026 11:08:43 +0100
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>,
 netdev@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F06270EF-7648-4E76-811F-C607A8390835@gmail.com>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Wed, 30 Sep 2026 14:45:21 +0000, Jeremy Jean wrote:
> In the software ESP offload path, xfrm_output_gso() leaves its segments
> sharing a secpath extension. Each segment gets its own ESP sequence
> number, but stores it in the same xo->seq field for IV generation.

Tested this patch as posted (patchwork 14858684) on v7.3 against the
same build without it. Both kernels carry patch 1/7 of this series
and no other patch of it, plus my "xfrm: use software GSO for inner
tunnels without crypto offload" v1, which does not change the
tunnel-mode path and moves the transport-mode case onto it. The test
ran in a VM with two network namespaces on a veth, TCP through an
ip6tnl tunnel over an rfc4106(gcm(aes)) SA, esp6_offload loaded, a
tbf qdisc on the egress veth that queues the segments, 3 MB per run
and 3 runs per case. The sender capture was decrypted with the SA
keys.

Without this patch every queued run reused IV values, 92, 51 and 51
per run over a tunnel-mode SA and 50, 51 and 50 over a transport-mode
SA, each shared by up to 7 segments of one GSO packet, with ct1 XOR
ct2 equal to pt1 XOR pt2 for one pair under each value. With this
patch, 0 in all 6 runs. A kernel with 1/7 alone gave 50, 50 and 51
over the tunnel-mode SA. Without the qdisc every run was 0 on every
kernel.

Tested-by: Usman Malik <usmanmalik@engineer.com>

