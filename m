Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794596939;
	b=tFeUwuT7/iNhxqSvhs6g9TvxAut7ze418kOQgfVxe9GMdFrNEzie79tj7OJ6btlb7xU8
	 iGkyyACWk22VxT6Q/Zb1qanBY5WAG3xLtTsGrwvBNK+VYYF5LEVkj5/301rl8OeyadulO
	 RtMtc1V+4KtlRiQGjYuYl15w+WNtmGRghGc7CLdX/EG7afIf4EfxR29XmDHV5rcBCcdHA
	 GgZpvHGq80+qyCcnYRLtkWHs+Qtpn7s2EKTf74EkrqGDY2uoDD2b/gYBlRL2T3U/igtB7
	 nRlK1majKMAHZl1UH9CoOJ7U2+EHR2ayUjFRlrgq7S9xauTqYvCj1gSl2jwcZVYGt/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=wMGf9TKkw2dAolbYMMRxX3h85UEtf4o2yarI4oY4daU=;
	b=YWWkNMxfERt+4hQ/eZnmMt1+N3TWlMNx89L9JYew5kH9QjLS7DfgGxoSMstvZQ9L6ap6
	 DzQAwwTqmb5+ZNWATmosiErZ6kgQ4a9rMeSGbv33+5/HH9HpH82xbkys1tTVyLAwd9nNq
	 L75mhLY3e6+SxpJ66v3ro7+XzkNaBK+68FcXvlc3msWfT6ckIqPYwMHxMYYsFi7EwjpYY
	 STVJclvCq8jaS4fXOPbxLRHmqr2TIo7/0lNtnth1S3gCwKV0mt3B0bWwfRNClcpFni6U/
	 c7ykIfoXA61tDA20bTgbnHOaJK++Q02wISexM34Wag/wVdmrsDdgPrO23y1WitkoWGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=nOONlcMC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5E606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F5E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=nOONlcMC
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADIwVfx1875878
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:08:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=wMGf9TKkw2d
	AolbYMMRxX3h85UEtf4o2yarI4oY4daU=; b=nOONlcMC8i4eL5z9MdkEXEZlwOx
	Vrvx+jYuO0AU7xRzGRrS3LpEi73YXmUwnlC/dOM+wJ1ODaYOk7bl6zGXh9sfmJfw
	MKNO6Sg6FOBmO6fyVJijB2yweyStubRKYP+YC5sRD+08HFJSgTDbMn2V2e8elqHY
	cir6/wisuzYvGcarXU8Wim98GEnpbLytImhbK0UaDptgWMMAdVa2EzVnCL0Fdt4P
	C8CwU6njpzc16OA1dki1A/QVsYaa2fr1OOoMTrn0yofhzM7HL6RF2Wow7f2tRuaJ
	2PYNcqU0vefF9VfhQZZYt3fhB3NxmITWzERS0MJE8hSc3pgEiPS+lD+uMlQ==
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwm2976wf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:08:58 -0800 (PST)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ba078abd70so9427175e9.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:08:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794596937; cv=none;
        d=google.com; s=arc-20260327;
        b=BEYtSXWgCMrBSx5mP2kIFa0G9Ud5tlPVySZnjg3/OYbGoMzH5DJCbDIId8E/eseHlh
         HAKTOrZVx8t5qFae6jm2ojOfL8WxV/yPyaCOu5hbLhXm6Whe7KQXy8KmOw5Wt3pkBuet
         NEOGHvGhrvcxnPKDQFLpi7WdwXXivPzgphNs25JVfa8ya0rp3NjYsXFWq1LWuHf6ge1f
         YGreO0UCN+dpWTAS9rDP70x+Y/SnJz3iTVeZVJc5ELCRv0eJ70WV0w/NbT68SA/z5oy0
         aqcG85+YmGWfbMGYLNpS4BspQFZwtJSuE08fOtNzuSpk8pb/xNQTzbncpmpUO8eHajyW
         dILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=wMGf9TKkw2dAolbYMMRxX3h85UEtf4o2yarI4oY4daU=;
        fh=yGsYxp/cLFJkoDLjDXbxi9E7eRrRkJJPe+WI4JPJZro=;
        b=FOEmiWvxy7PAeaxL4uWx2gxgzlZfyaiH0VjtCBFcTtULiQNZ+kJXyW7gDbuFaKgGD3
         DCAIYA549To8QRAKTeTkv/ZUv/uDCucqV2VSfOYSzmDSNqsxSI3R3ElwCCSXT0olGoDW
         AmYx2W7c/Db9Afq1qmbc6cSXJ0kcTY2QwBi1Ql7AJflPDK4p7nYB3kOg5+lTWfRDuPWR
         tj95VqDuUuC62mS2QsQxRozsAnF1sJqNfRldyWiYPybIzbnmqsAIawQVhB+2N4Frkvm+
         4f8sQXANbtAuPfFTj+NYqYezyqEGzE74uZYB6jnszq/qdCZP5Hgu9ELhCHjmpJhxE4je
         JniA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596937; x=1795201737;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wMGf9TKkw2dAolbYMMRxX3h85UEtf4o2yarI4oY4daU=;
        b=yloCPWD1HFhLXyqavMj04Rupf8fvCfeLPXW8c5bkOUIGGK+3sKtiixPtToufK91U5b
         IED1fP1N2lGMQ73zX/y4a87jwDHnZByQWYOFySSbdVypbc/soHeFXXorWGQLMNwW4IQt
         QP6qikHQJUnfphn0eoOv6G+r7KN6YJJe4qZj76QLunRQZehl0nH0j1OcQmpBf9yb5vfn
         XYhPQ0QnGQaI681wvfPaY2XPoqutwuMM42s9yHTlwQQWeSGxab7qK5zzCk0hxoprqa0b
         AEmcb3os6GRGBDJDn1hWX4B9+sPWM8FE/D3mjVvHtyxxakUSuOUnFATFDf4QgEuUP2OM
         ds3w==
X-Gm-Message-State: APuU4Z/JzGNaHb/igIdTLeBb+Xv5fKHxL/4pPk2G4RBgms0uCrU2USSi
	ARvfIj+ZMSjAzejvuYNZv5u6sStXc8E81YkZy9jTQuMsZvs3ml8KOZcABXAA9t18dWYopyVyWmt
	xDX9wIMb/syEZApaeXJUThDSKrLE8yutE6ybFDMbB2FHzyZiYb4coqFt2MM5f3Oh8UunXtN0OO+
	KC8oGaws9fTf53CnVpqhzwMkzvWIk4OEk=
X-Gm-Gg: AYBFou0ZJBRrLfw8MuikNUQ73Rm9QNnjpDUDL/z0d4gRnSdA5vgzarsjew7D1XqyWIJ
	m8bCdu7ptViBFtP3RknQVY7+Ph8MjuGg0fMVHTfHo6EppvtQOhk8O29ALGGGNPdhhO6DSeHLoGs
	9l00pnW+mA0Ty3Sqhl9SK7eB2IRa+7oMu7hUeRth/XfP8nr2Nwb+gpPrxlTav/hO4i5QFSX4Flx
	r1WqXnLTnSg+qjJNglDhj1i/1BRJx/OSEG8UrjQVMOWTDbQN5w=
X-Received: by 2002:a05:600c:c172:b0:4bb:5f07:10d3 with SMTP id 5b1f17b1804b1-4bb5f071385mr25701115e9.21.1794596937124;
        Fri, 13 Nov 2026 11:08:57 -0800 (PST)
X-Received: by 2002:a05:600c:c172:b0:4bb:5f07:10d3 with SMTP id
 5b1f17b1804b1-4bb5f071385mr25700845e9.21.1794596936812; Fri, 13 Nov 2026
 11:08:56 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <CAM0EoMnPM54re5-WKyWgwyoz0cn1uGT6=E96OBG2-4m7M+kx7g@mail.gmail.com>
 <CAM0EoMmrRrmPdXPKyiQgEHQSb=mq3uYfNc69hEKw+Rw1EQAzmw@mail.gmail.com>
In-Reply-To: <CAM0EoMmrRrmPdXPKyiQgEHQSb=mq3uYfNc69hEKw+Rw1EQAzmw@mail.gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Fri, 13 Nov 2026 11:08:44 -0800
X-Gm-Features: AclHuK-U0ThzUJNaBNSfjppeRsNnyfVDY_cTKL9afgrilY3k6R5ZNeb33jtLtAI
Message-ID: <CADh2yMyJ7Fgtv2BAyNpKFkBC6YRC=Z7kOHSiBcH6kTqcriWL4A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/15] psp: introduce socket-less associations
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Zahka <daniel.zahka@gmail.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=bNODs/+Z c=1 sm=1 tr=0 ts=6af7604a cx=c_pps
 a=IwH782EDBk/vqbJ9rM8UFw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=V8I_lJ-4SMfPdcaXHV4A:9 a=QEXdDO2ut3YA:10
 a=Ng9YvVcppn9CIdWre3nD:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NiBTYWx0ZWRfX5kmyNxeU81RF
 58CNbHr3F6/5EILwiwPyA4P4kVtuMEfknDFWON8UKTNtTglyrVhRFGw0Br8UbzZCLozntCHT2yM
 MaZcPVeHOx3oaCmGPl3dAxpoBr8ERLc=
X-Proofpoint-ORIG-GUID: lhZUeBqbjoP3J3VfjViRQ1xAQt-uCZ_U
X-Proofpoint-GUID: lhZUeBqbjoP3J3VfjViRQ1xAQt-uCZ_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NiBTYWx0ZWRfX4J8PTNmxoe9I
 I++x+CWuvcWedxEoT2N9hNsFyHf+VvWCy0D3qI+aXu1hJUDnAgY8zevq21ib0i9yyMNHr33CbiZ
 lABoBvzAZkySgr5Asx08+/eCHSto6To9wgIlylBRsLqPMw/knGz8RBUHbDTNteGpmduqMiTKDBq
 643IedrItk1HvxgvRUo1hNE7y3gpmIoarSF5sHPjRcw+7qpbPkeOcIdn0rBYbJSINZ/zfGMcqDK
 CDtjkd1JmY1xV3vpN3/nQ1yaq8fTDHwWcYitN2IR5/KSiNRgqrta0C7h9J8OS/fNEOWw0QTCZlk
 N8WkxfG/YVpxaWq4r0ZOH8fOoiWDXhPUO6Er1nHdwbCe8Xi3dtBnq+RMQ14tkNRwnuP38zcthTN
 llGcHQJO2uHrcMzAlkcbtVH3GbkiSsD+UPzPgF5HSIJqSxCRgB4K2s5mPSn+kUVVL2sZThp3Efl
 JwXTeKY0trSYcWtpYnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01

> My bad - only one of the sashikos (gemini) responded. I suggest you
> wait for the second one. I think it watches this gemini sashiko and
> tries to come up with more clever findings.

Ok, I will wait for that before posting v2. What is the best way to know
if that has happened? This posting is from 3 days ago so I would have
expected all the sashiko reviews to be complete by now. Let me know
if I should adjust my expectation.

I think this is the right place to look

https://sashiko.dev/#/patchset/20261111005533.6436-1-toddfreed%40meta.com

-Todd
