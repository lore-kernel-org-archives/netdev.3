Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624615;
	b=E2mRen+JBpwYFnbRhElxxIERApQTqOYB1XTvN+l2fqmkC9rRlU76o2CfrIRb5v1xhxA4
	 NY53w/5wLN29y5P1r7Lc53YHyIvEnoFCsoefH7qed2PBMKIi1zzrYQo4qDE5VVPN7EbIL
	 ecI62BXEu/u2Bmo7nYWsO9v9FsCAMJyvBjFNO6bRt+D77w4bntn+E56plya97AAzothxt
	 juKa/nxsJzadIRIvKwXtTaS2j9MJR+8llevNSZ2Ud3xrctY6SLCZNTDSSQCmYbSOoCF24
	 Y9iaSQl95JqNjYHfQHwATwPltDW0c1wM8HKxqpGz/GWd5YWJhMuZIMDJkdubg3dJyYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624615;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=pJrlS6BI0RjyXJfE4zensthLKF+BlE5JhwzaSHI/tVA=;
	b=V9RDE06cbs342QBR1C7wfyJlq0/gftSlpGyit35LWaIcdDZC1YaizdlFap+MHpOWi+8j
	 gkVTqQjQ0q2Xk5VFBkVupXMxhQaFR6IJHlX32EPQOF/eTFNq0QrZqa3/Ik0JaHQJh5cBn
	 zHIEbWsQBbaf/H9+CZVervs/4o1hGTos04IHC3ekaTVESd4ZRjXtr/JR5G/viRK8TIMTO
	 /JgEh6HvjbsraMdr7993Zlfe8RDdYAJwZISmsUsEvicWPLD/FeRd2YvlyRWLdCKQpWPTq
	 t+kjGXldzBkqqQJ0EKT5Yy4vrLtm/nqF5+/vjVI+jBVYZpL3AjIcX4rTe63F0K9NXTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Vp4gwrZl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73061606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 23:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73061606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Vp4gwrZl
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LMgKUA2857624
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:16:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=pJrlS6BI0RjyXJfE4zensthLKF+BlE5JhwzaS
	HI/tVA=; b=Vp4gwrZlgWsBSRNsNo7EaOnVLk+z9CB+3MfP6zxr786/0Ld2DW9nG
	+wejsvBnbBKR4lV0t7FWj00/nFs4rACUwdZViTnySZ2OtIsJFyYLZ5YJ054xMBXX
	RzLSSrAHr1FGpwnjnXzthJXyKMCVKYPCgMIw0AgzOtzV86iFHVEzC4ipoYIV1en4
	suoFe3g35pCFOaOZWH6Lqm6wixaj0420VzuuJdqnLupuoKTG4vjTSHYkV9WfVFFx
	7NT+1THYzfOeXI14PWluiW2lKWGK7Wm4+wIlNYYdv05tnSBjHCkFYF3eppH0m3hc
	rgZtWzFwbwsCMRdg4d/ekOKH+C/mVtjNA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hexcgmyv8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:16:53 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e94b4a6e8dso11907565ad.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792624612; cv=none;
        d=google.com; s=arc-20260327;
        b=nYtadTYN95GmttMgwxVFtTmgKs/6aSH9PMDPFPH178nTP0MWeSmRWeN5kosPqyAVDY
         V9PaktqnBVxtaEcmURrsB1/0qw/WaqwMQGUmgb1Qluqn0JOego7weoiwGvss8jh5VKxD
         kD/toNO0DW2lNveuJrlCFR0urgES0TMaoGh/TqUnp2r+GnMWXXfCrth0uUJTJg5Eplp2
         YfTw5LjV6Z51DMdM/7t3fqrxWOqHdqxq3KaB65HGt3HMYiJUYL7U11t8EFwNa2ixfvmB
         wC8KiZmOv/O5w/9OncODR05mYdW+NhTmA1XDTt/VkHLBx4ydpT1LfR7qwQcIdpVPyR5a
         IBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pJrlS6BI0RjyXJfE4zensthLKF+BlE5JhwzaSHI/tVA=;
        fh=c4QWZHjOuehXOinWZz8qpAMRClqZV7KV2FFHuCeDd24=;
        b=djRPLhvgEgjywCaPMEJZ9TqmPfuRmXlN/K2rxz4ZkP01TLYI6BR+XJxiGj7pWS4Fhl
         ynchnKkxu4ewsrC4DfqcrYWBFmgUmVwbgOhz0hhilURgmvhtB/d/lsjU4+6+uSzmzM2r
         pIS6v98G+uNJqTr6SVRZzKUZSU3GZqJfFxqPaAlP3wNht+9WcjaubjVr53HA92HRSmsz
         a/acXDhkdvURA6UQA/aiHfzQX6/WE0AitvSGOz9gdaMFCaQOvanwAmPdPNAmSM+5rFb/
         rVJear2sHGy6piOjRxp42odh/Z3p6eaq4fGs7l/1fEYr9KMt30aCVT541xBtgusz912g
         VzKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792624612; x=1793229412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJrlS6BI0RjyXJfE4zensthLKF+BlE5JhwzaSHI/tVA=;
        b=kOnq+y1x5GQVNhJ7XgrIRrZYRpXxfl05XtuuySOPrH/sZIh13NHxtE9RHWY0krYUy6
         3qDchea59nDhE+retTnkUYYW95uViHiwcwpdc7gRJlRD5mEPcCxLtlentmNfRkFIat+C
         5vCFR95HPfuZNAfLJSWfjxQVvUX8ZGMXrHlwojh+HfKM4eUB8NaY/0YhOpFSub9FrgZV
         YmVC/loea1omw4dt0Fxkk4sw7LWsd6R6OXKbcUdKwyPYU1tBha03etPm+rf+1lPj5UW2
         qnlVy+fwSWmplcf9I49jAzo6FyzWANXisKjX6KPvXjsYDEqPmOl/jyREI/Ibv28XPN8e
         EXZg==
X-Gm-Message-State: AFq9FYI6jAiMTLlK9UcqIVDn5SYgez+EUczX53B1hdZt0CqX98H4GN3+
	Nor9j65pNAfoF2Cl6r2qbtEAS2ARmGyHdvqCawd8r0aGA6mR0NgO6UGxH26d13VlHZfvo4zAl/v
	VxYPsFtB7qAjT8vcJVJsYWvaTnvCoIXWYSIixxoKwAYLqjfwxqzaD2jlTeXuFLufKP6CRu5osyf
	FYSxDq9gIlmjtDXiQhMKNy/BplaeWthtQ=
X-Gm-Gg: AYBFou3Ny/v3ak1pULhSMKjbGqVdwFGchCWZDGWh94zYSZgbnKZUY53K+A8ohzqKToJ
	7xpGgfrH8uyma/jT9fdMoJsUIoRksGijEyheBwP8o/IuDgsexG7B2kic9mm1+iBsrpeTCCAObhj
	OMv4vgTy45eiqjEMD2ETsoEVLFXfXrvRs3+GzmSbD/yXAVjiRaHYKqi3f153SeSVRqfEj0+E6z5
	FnFqZqjPDQjR1pGQby8b93QL/my3ffsYqMnG8kp9+xsdP8KaPo=
X-Received: by 2002:a17:903:22c5:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2ea43ccafacmr29581065ad.47.1792624612329;
        Wed, 21 Oct 2026 16:16:52 -0700 (PDT)
X-Received: by 2002:a17:903:22c5:b0:2e9:9a19:c5b with SMTP id
 d9443c01a7336-2ea43ccafacmr29580865ad.47.1792624611831; Wed, 21 Oct 2026
 16:16:51 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021210200.788191-1-toddfreed@meta.com> <DMAUWQVPIVKP.1QAK1YSA76EHJ@gmail.com>
In-Reply-To: <DMAUWQVPIVKP.1QAK1YSA76EHJ@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 21 Oct 2026 16:16:40 -0700
X-Gm-Features: AclHuK8lwg5eXLuGUxQHiUC8_vLdaY-ZwbVEaxo_SZTaHFB4eITFRpoBhnT9ZXo
Message-ID: <CADh2yMypAdV07rRufDqj1aOdEzAqEaH2bDkJ2jYV_z1_9iXRkg@mail.gmail.com>
Subject: Re: [PATCH net 0/2] psp: drop packets with extension headers in
 transport mode
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Shuah Khan <shuah@kernel.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Raed Salem <raeds@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXxsYqXpZCgZup
 9GwmXinOixzGmb7YIIZUD4QjsSfeq73lPR3mRnzz8pffUQCNF5GkT44pdKpqCF1JMTOnoelU7h8
 HcW92s/B6GhxC81lPvej6v3bebbaiFDb98tbKMuTXycBc3vpRPgAO0Ogc7IcPr0rmCfvlpxRcty
 Lpgs0OIVg6LaNNrTWQYJplAD2afCE+t4K0PN7GiRG+JLW+fRxplw8dyDLPIhYSbe2K9Wwo1hia7
 9cQouJpCArX1imPyHKlV1Ew5gA7J727rwU+nWyOvVB5tvYeQTw09TaDjAZUASNpyvZMUeDLtYg9
 g6jXelonBcIzWUO9B1tlSUZjIqZC+LJaZME9ieX77zyqSVERGKKf4LXYSTN1xDNTgOFdKYP64Bt
 25JgmufnjjfDw8npqO4UkIazt40gA8tcfrvZltsVPOeZzLoIq5PQB3iBjOk1/3GBmxcbo5p/c3X
 u+lluKSfgHTNcLuYbxQ==
X-Authority-Analysis: v=2.4 cv=RdcFmFtv c=1 sm=1 tr=0 ts=6ad947e5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=pGLkceISAAAA:8 a=8MYx3_RU7Mcw6uyp7OoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX9M8yj/HbMOvM
 356qeTN6UGA7DjcPVsy8oZ/QwtsMKl9FutSBY+EvgsApy7Gy00V8fT08mgGUYtLGeouOmp3HEYw
 xiSRemLdsspExk5N18o2+a8CqfXKSDk=
X-Proofpoint-ORIG-GUID: GQ_h0B8sf5LwzS0XCLH8krBEvJlvDHZT
X-Proofpoint-GUID: GQ_h0B8sf5LwzS0XCLH8krBEvJlvDHZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01

On Wed, Oct 21, 2026 at 3:07=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
> >
> > The first patch drops the packets, the second patch adds selftests for
> > that case.
> >
>
> Why not just fix psp_dev_encapsulate() to put the psp headers in the
> right position? With the self test we are going to make PSP + ipv6 ext
> header =3D=3D drop part of the uapi?

If the original ipv6 packet has extension headers, then the nexthdr on the
fixed ipv6 header identifies the first extension header, and the L4 proto i=
s
in the nexthdr on the last one in the chain.

psp_dev_encapsulate() places the udp+psp headers after all the extension
headers in this case.

The issue is that it rewrites the fixed ipv6 header nexthdr to be UDP,

  ipv6_hdr(skb)->nexthdr =3D IPPROTO_UDP;

It would need to walk the chain, and set the nexthdr on the final extension
header to UDP, instead, if the correct policy were for udp+psp to come
after the extension headers in all cases.

I'm not sure that's the correct policy though ; for some headers (e.g. the
fragment header) it might make sense to leave them on the inner packet.
Note that the psp spec does not describe this. Perhaps the user should
express the desired policy?

Explicitly dropping ipv6 packets with fragments is consistent with the
current behavior (it already doesn't work).

-Todd
