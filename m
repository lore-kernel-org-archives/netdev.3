Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416441;
	b=Ss57/9y0dMj8ZpZxi8PzAu/Ofmg+SeVeVkb4kWp8xEq9wpkA8dNwa8lMy9tQ7knkXLCa
	 M+OOk+TRI9TNO1Rbs10pV92+x+y+iNCJrvj43m5I27D75FgL3Sj83fSntr+iBGMZUGAsZ
	 VKsM9/VVRA0sjxg7vOVkV5v2CeM1NzeIkyQYTHSRjKHux3ij4Pz2vxYdNBWIQ4wQA8eZL
	 YkGzn/VLkH012hat5LM0/eiJSjAz3wECbeED1Kz0a30+NNuVLajgVGQSh9PajBPUj7RPe
	 4Ud6/+2FqQTUZgx4w2SSpWbWS9sLEZALNaedU3+57EzI0xRaLpk7gw8bjdUckdnWStQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416441;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=74FoFchhuSQQ2jSNjsBXa6BV1QiK2Fm+lk28fFAbdUE=;
	b=ThWHrlIPpsMI9ZD63miU1IfkBwusWOAjsfYtH0K4H/+CU/T1CxojCxLGIrzjfVcvCcQp
	 R3XGmSNRX9BWM0hCrwEJoZtXMhLrJySLuv34a/nrbnlZ1H8GjzkBVeKAlmrWLeU6yKP1+
	 H6xdgATko+Xi7t2KiDHob6fxHave7iog1dAA0aZ8RZe4M17J6Ap+4c36gROw9+qx8Tk+7
	 Q1+SBnN1UFADBaKUwYV8mGxjVTR3o9Z7rPwemLU+j4QE09FP5Hg4/GSqqb1yzDNSxKohO
	 TPpQ5K0bfjNEgPSKTpRoFNEuyGaNOmNYc477OTEyJvHuSvLQ/VVYH+KkO75zvTN2fiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=KKDUZEPW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD82606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=KKDUZEPW
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF33PH3776003
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:00:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=74FoFchhuSQ
	Q2jSNjsBXa6BV1QiK2Fm+lk28fFAbdUE=; b=KKDUZEPWjFxEuM39SyRtvJ/r0/c
	+hQ8uhEGP6gr2JUPPDpEGcq0NTiQEyQ9i8Y2g3dv39QgOtx59p8EVdbDUQLa6L+t
	94/0SvdQaKFzm4Cv+3qMAatvhm6L/NQDjRHUOOvxpSMqYTskbxEpPNPMbZb8J28Q
	VEnA6gATK7C0rGaA8Xc8mBs9uwKNehQFzrIi16cEvw7v7laleiJrStlzJ6yosvTH
	sB1t+/ZON2DzbCDWmVTFGDgroxRJzYUeSJWeXZaQlf4jqciqfQuDmTSiFxExpl88
	c+tWUz6RkiMrJFompExetsSO2R/KCDNAgyE+nnENK5DPuycgfbYUa5suUXQ==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hvbxcdtx3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:00:40 -0800 (PST)
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4903fc8537aso2297811f8f.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:00:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416439; cv=none;
        d=google.com; s=arc-20260327;
        b=Mw4cGjXemdOduU561cinYecigp54oILp37QVirIVPkIlPX2hLDQgHxFn1ejJzxmE80
         tj8RINmtCm6HPWVHAI1PuuC6BJeWAXzz+EFHr6Gv7plypyVcMyiLjyu0M3TjSHzubQ+I
         umJjqwsjHTgkKiOo2VD6yY2+p0e/Xx6oaOafYrhwgt3CU+vJaMwCBen3hLKVhOhD+Vg7
         ecAtllw3IIwLADiNRaJ81Y+Wbzw8umrzfm1KqZrcK47/MIzHvas7oooO2XvK4plQ/kyC
         11+h9Hs6GCOlzf05muG/iGMwanN736Vp260/7DZQ+caUGg6MwXT9kBaonWST1mlYNlWe
         V8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=74FoFchhuSQQ2jSNjsBXa6BV1QiK2Fm+lk28fFAbdUE=;
        fh=/sDsa3GsCDheeT4Yepk/4KE2unrSIqWil/Sl6eQomAo=;
        b=elyQHwcdnyEfqDZABSsWS6FICRl6ebJ2KSzvpFDhBXuRUFbRFYjrs1xJSBR6Qf3yem
         naJ7LkGDo+EnRAgGlF0tVGbZ4hF41eRYFcq/rI9hXsxxDpDt8IYEGx3I0edJTx/v/FJ7
         Xd0GJK7WDE0ibtwyku4qYBIJsswW37Y9UoTk5B4tYtwa2Wj/PchzAw8AQqhBYQXaD/JC
         NtWgYhDbEcqtF/z2lt9duhCIZaTWreMbzvbe2QOD38RJ+o5a6c2N+GQ1TyT7N9cPhaqE
         ru+b6IqYSMMTd8dpq2zK7LaJg8GAfQvbPqXT2Ul67/H5ZRkZWwKwbZ8RM+pUGgqPT9/c
         09sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416439; x=1795021239;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=74FoFchhuSQQ2jSNjsBXa6BV1QiK2Fm+lk28fFAbdUE=;
        b=tpin3dKBucWqSLJMVvFfGqMC180XlXAsw8pRSO4XGm3BwMw0zaTK+Hi2cO8SscPNx/
         N9KemJPu1GlYsGsnA/3xDiwpr1jk8nuxhmzTtxX6E87erDzHUKzpHquP7oLK+DDF6cbn
         QHvBXqGTiyflq/duPFVbErhfkA/kGXwUBpHX/fm1TXJqVmWQdnCpvoyKvgBlJyVkTCPo
         QLQ98lo01Nq7kbCvBb/TFFzMhJeofFlw38BzcXQpBImw0THkuzjj9xSC4MyWDwkjJKNn
         CcRHQ/OOLvztdLzEtqJMFwiajRW3V+/wGrEMr5ltf0lCTH5B0Lj2n0z5TiHy+2zHhmRo
         1Juw==
X-Forwarded-Encrypted: i=1; AL+hErFJlzAjUM4qAt/OcSPYuXj5MUgS9BOAGxKw/0tBJ1kGckc/SKV4p5BrOaxRrNNwJSm5tt7tMdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xpsf4RVzj7uHaxDrrknHdFrGbYCa6tduzJvaEN8+c/hREOlfF
	21pfrEDv97fQ6k68+uXh8+BG6+kQfjfH/orizC03tuMkIG7oqrqNuJLtdNIFI+dDHc1mC+bzjoF
	u7qOYsHNWMg6Mn4Wbw3KJcD1gdwg9M7ynmfGHOp0mLx26jmcA2hsqDt86Lcst5hd785zPFkbFZz
	2xUT8gs2FuzZBB+nXzzbykxzDOOoF/bHc=
X-Gm-Gg: AYBFou3Jh5NHLRPGfbrQR/Xkq796JsZTRgBkLXLwgR+eGfZfwjQXWoOI7NFbmJPiXfl
	0rK4DO8is/GKdr30dPADpftayU/qerXH3LCc/ksKlf15UXOpROsr3QRe8FaLKdfY1skOcBI+mXj
	7eh9jvCxyWUM9yL560FqUUPUv9NHnyKfENupQ/0ZMYu43TIQdc49P/QNtheGOJWCaUW/d7BI1+o
	H3lDCMV9Wn4NrW3cHaqj0XfO9k+ZS3I
X-Received: by 2002:a05:6000:401e:b0:495:5c83:51bc with SMTP id ffacd0b85a97d-499c3b9ff3emr5473696f8f.5.1794416439115;
        Wed, 11 Nov 2026 09:00:39 -0800 (PST)
X-Received: by 2002:a05:6000:401e:b0:495:5c83:51bc with SMTP id
 ffacd0b85a97d-499c3b9ff3emr5473639f8f.5.1794416438735; Wed, 11 Nov 2026
 09:00:38 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111003111.3826942-1-toddfreed@meta.com> <179435738198.2168702.12439855185550580348@kernel.org>
In-Reply-To: <179435738198.2168702.12439855185550580348@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 11 Nov 2026 09:00:26 -0800
X-Gm-Features: AclHuK8tjqwSs5WvfY5ngy_lWto0eQaig-gnzMnKLMUSIRvHhVTmNTSnDzSw4Ys
Message-ID: <CADh2yMyWd2JMajjp42yx-2JEa6NsMoX1JK+2qVaci9vths6WkA@mail.gmail.com>
Subject: Re: [PATCH nf-next 0/2] netfilter: don't send decrypted skbs in clear text
To: netdev-bot+sinfo@kernel.org
Cc: netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Boris Pismenny <borisp@nvidia.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Zahka <daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        coreteam@netfilter.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX+l963VoF8JCq
 l6SVpA/LOCTS5MDqhRpDVvN34b53RQEjsy7mDAy8/41r0uyoPnw2Qx9OaBCEm/2jrOgX6W2taA6
 ZWT/7Bw0VGhOKiLi8JN7mFm9U1N1kmK4aeqzt1oACd7EKsqO8LkcfCp2Ne1p8GOnbZzFh+6uTcD
 wsDeuQaBRKwBrT5daaUMad9mHGd30bdU0Gd5apxnfPe4LOly8vtFdmOXnt6TzIQCnESL3VNyxa8
 MZaAR8rhsWEEdr6LNRZS5MeCQGZpzyKMXez5T4GRs/Si+nczibJ6thpwDWllKjQTywHLoEwUTa4
 xE0lUyqqAHpHoCkKSXI3jSgsVMBsaTZMBDtr5h00NbalP4F975DqitzUEHtNcuX6OBzf29CORxc
 W3Kokt3OTrqicy4TJmoU88jyD2W5482LJ7reRY0Mw4J7jiGuBlxDFJVC4cp78mu5exL+dC2AY5B
 hGqjyaDABXbOuUt89Aw==
X-Proofpoint-ORIG-GUID: kCiAKM9UeEMLSYUQpiFaq-FWdeb9tR52
X-Proofpoint-GUID: kCiAKM9UeEMLSYUQpiFaq-FWdeb9tR52
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX0FzkVsnxDHKL
 8+daJMx5D4oyn2GKEHyFdWoRdw0n48U6ftU3emPcrHfmy4IsEAcHLnk0FRl7S/tsf6rxczKa3SA
 Enf2b9jXsPRSdtabkF4olmg9/U1YYP4=
X-Authority-Analysis: v=2.4 cv=ZdKIpcVA c=1 sm=1 tr=0 ts=6af49f38 cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=v81qpcjm-LW16Aac8AIA:9 a=QEXdDO2ut3YA:10 a=F7q00xkr9EfWfQvbdVXI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01

>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Hit during development on crypto offloads on the net series that I
linked to.

-Todd
